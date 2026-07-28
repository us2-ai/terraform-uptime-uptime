#!/usr/bin/env python3
"""Fail if an attribute allowlist disagrees with what the module actually reads.

Collection variables are typed `any` and read with `try(each.value.<attr>, ...)`, so an
attribute the module never reads is silently discarded. Each collection guards against that
with an allowlist in an `allowlists.tf` file. The two must agree:

  * an attribute read by the module but missing from the allowlist is unsettable —
    callers who set it get a validation error
  * an attribute in the allowlist that the module never reads is accepted and then
    ignored, which is the exact bug the allowlists exist to prevent

Run from the repository root: python3 scripts/check_allowlists.py
"""

from __future__ import annotations

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent


def read(path: str) -> str:
    return (ROOT / path).read_text()


def allowlist(path: str, name: str) -> set[str]:
    """Extract one entry from the `local.allowed_attributes` map in an allowlists.tf file."""
    src = read(path)
    match = re.search(rf"^\s*{re.escape(name)}\s*=\s*\[(.*?)\]", src, re.S | re.M)
    if not match:
        sys.exit(f"no allowlist entry '{name}' in {path}")
    return set(re.findall(r'"([^"]+)"', match.group(1)))


def block(src: str, start: int) -> str:
    """Return the text of a brace-delimited block starting at or after `start`."""
    depth, i, begun = 0, start, False
    while i < len(src):
        if src[i] == "{":
            depth, begun = depth + 1, True
        elif src[i] == "}":
            depth -= 1
            if begun and depth == 0:
                return src[start : i + 1]
        i += 1
    return src[start:]


def module_collections() -> dict[str, set[str]]:
    """Root main.tf: attributes read from each `for_each` collection."""
    src = read("main.tf")
    found: dict[str, set[str]] = {}
    for m in re.finditer(r'\nmodule "(\w+)" \{', src):
        body = block(src, m.end() - 1)
        fe = re.search(r"for_each\s*=\s*\{ for k, v in (?:var|local)\.(\w+)", body)
        if fe:
            found[fe.group(1)] = set(re.findall(r"each\.value\.(\w+)", body))
    return found


def statuspage_collections() -> dict[str, set[str]]:
    """statuspage main.tf: attributes read from each sub-resource collection."""
    src = read("modules/statuspage/main.tf")
    found: dict[str, set[str]] = {}
    for m in re.finditer(r'\nresource "\w+" "this" \{', src):
        body = block(src, m.end() - 1)
        fe = re.search(r"for_each\s*=\s*var\.create \? var\.(\w+)", body)
        if fe:
            found[fe.group(1)] = set(re.findall(r"each\.value\.(\w+)", body))
    return found


def destructured(path: str, names: list[str]) -> dict[str, set[str]]:
    """Attributes read off a single object variable, e.g. `var.config.<attr>`."""
    src = read(path)
    return {n: set(re.findall(rf"var\.{n}\.(\w+)", src)) for n in names}


def compare(label: str, path: str, consumed: dict[str, set[str]]) -> list[str]:
    problems = []
    for name, reads in sorted(consumed.items()):
        listed = allowlist(path, name)
        for attr in sorted(reads - listed):
            problems.append(f"{label} {name}: '{attr}' is read by the module but missing from {path}")
        for attr in sorted(listed - reads):
            problems.append(f"{label} {name}: '{attr}' is allowlisted in {path} but never read")
    return problems


def main() -> int:
    problems: list[str] = []
    problems += compare("root", "allowlists.tf", module_collections())
    problems += compare("statuspage", "modules/statuspage/allowlists.tf", statuspage_collections())
    problems += compare(
        "check",
        "modules/check/allowlists.tf",
        destructured("modules/check/main.tf", ["config", "pagespeed_config", "cloudstatus_config"]),
    )
    problems += compare(
        "integration",
        "modules/integration/allowlists.tf",
        destructured("modules/integration/main.tf", ["settings"]),
    )

    # The wrapper mirrors the root module's arguments; `items` and `defaults` share one set.
    wrapper = set(re.findall(r"each\.value\.(\w+)", read("wrappers/main.tf")))
    problems += compare(
        "wrapper", "wrappers/allowlists.tf", {"items": wrapper, "defaults": wrapper}
    )

    # Anything read via bracket or lookup() syntax would slip past the checks above.
    for path in ["main.tf", "wrappers/main.tf", "modules/statuspage/main.tf"]:
        if re.search(r"each\.value\[|lookup\(each\.value", read(path)):
            problems.append(f"{path}: bracket/lookup attribute access is not covered by this check")

    if problems:
        print("Allowlist drift detected:\n")
        for p in problems:
            print(f"  - {p}")
        print(f"\n{len(problems)} problem(s). See CONTRIBUTING.md > Attribute allowlists.")
        return 1

    print("Allowlists agree with the attributes the module reads.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
