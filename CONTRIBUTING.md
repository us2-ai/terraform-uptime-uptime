# Contributing

Contributions are welcome and appreciated.

## Getting Started

1. Fork this repository
2. Create a feature branch (`git checkout -b feature/my-feature`)
3. Make your changes
4. Ensure all checks pass (see below)
5. Commit your changes (`git commit -m 'Add my feature'`)
6. Push to the branch (`git push origin feature/my-feature`)
7. Open a Pull Request

## Development Requirements

- [Terraform](https://www.terraform.io/downloads) >= 1.10.3 or [OpenTofu](https://opentofu.org) >= 1.10.3
- [pre-commit](https://pre-commit.com/#install) (optional but recommended)
- [terraform-docs](https://terraform-docs.io/) (optional, for README generation)
- [TFLint](https://github.com/terraform-linters/tflint) (optional, for linting)

## Running Checks

### Pre-commit hooks

Install the hooks once:

```bash
pre-commit install
```

Run all hooks manually:

```bash
pre-commit run -a
```

### Manual validation

```bash
# Format all files
terraform fmt -recursive

# Validate root module
terraform init -backend=false
terraform validate

# Validate examples
for dir in examples/*/; do
  (cd "$dir" && terraform init -backend=false && terraform validate)
done

# Validate wrappers
(cd wrappers && terraform init -backend=false && terraform validate)
```

### Tests

Tests use `terraform test` with `mock_provider`, so they need no credentials and make no API
calls. Each module with tests is its own test root:

```bash
for dir in . modules/check modules/statuspage modules/integration wrappers; do
  (cd "$dir" && terraform init -backend=false && terraform test)
done
```

Root tests cover composition: attribute validation, the `create_*` flags, private-location lookup
gating. Submodule tests cover resource wiring, since a child module's resources and variables are
only addressable when that module is the one under test — `expect_failures` cannot reach a child
module's variable from the root.

Two limitations worth knowing:

- Provider mocking cannot set the length of a nested-attribute list, so
  `data.uptime_private_locations` always returns an empty list under test.
- Root-level global defaults (`try(each.value.interval, var.interval)`) are not observable through
  outputs, so they are exercised indirectly rather than asserted.

### Regenerate documentation

The README tables between the `BEGIN_TF_DOCS` / `END_TF_DOCS` markers are generated. Every
module directory has them: the root, each submodule, and the wrapper:

```bash
for dir in . modules/*/ wrappers; do
  terraform-docs -c "$PWD/.terraform-docs.yml" "$dir"
done
```

CI regenerates these and fails on any difference, so commit the result.

Two things to know:

- Run this **without** a `.terraform.lock.hcl` present in the directory. With a lock file,
  terraform-docs renders the resolved provider version (`3.0.0`) instead of the constraint
  (`>= 3.0`), which does not match what CI produces. `terraform init` creates one, so regenerate
  from a clean checkout or move the lock file aside.
- CI pins terraform-docs to the version named in `.github/workflows/validate.yml`; a different
  version may format tables differently.

## Guidelines

- Follow existing code patterns and naming conventions
- Add new variables with meaningful `description` fields
- Update `CHANGELOG.md` under the `[Unreleased]` section
- Add or update examples when adding new features
- Ensure `terraform fmt`, `terraform validate`, and `terraform test` pass before submitting
- Add a test for any bug you fix; every module with logic has a `tests/` directory
- Keep the attribute allowlists up to date (see below)

## Attribute allowlists

Collection variables are typed `any` and read with `try(each.value.<attr>, ...)`, which means an
attribute the code does not read is silently discarded. To prevent that, every collection validates
its attribute names against an allowlist. **Adding an attribute without adding it to the allowlist
makes it unusable** — callers who set it get a validation error.

Each allowlist is a single entry in a `local.allowed_attributes` map, referenced from the variable's
`validation` block. Referencing a local from a validation block needs Terraform/OpenTofu >= 1.9.
The declared floor is higher, 1.10.3, because OpenTofu 1.9.0 through 1.10.2 crash in `tofu test`
on this module's suites (fixed upstream in 1.10.3, opentofu/opentofu#2994), and a floor CI cannot
test is not a floor.

Allowlists live in:

| File | Collections |
|---|---|
| `allowlists.tf` | the 17 root collections |
| `wrappers/allowlists.tf` | `items`, `defaults` (mirror the root module's arguments) |
| `modules/statuspage/allowlists.tf` | `components`, `incidents`, `metrics`, `subscribers`, `subscription_domain_allows`, `subscription_domain_blocks`, `users` |
| `modules/check/allowlists.tf` | `config`, `pagespeed_config`, `cloudstatus_config` |
| `modules/integration/allowlists.tf` | `settings` (union across all integration types) |

Blocks passed straight through to the provider (`sla`, credential `secret`, dashboard
`alerts`/`metrics`/`services`/`selected`, group `config`) have no allowlist —
the provider type-checks those itself.

To confirm an allowlist matches what the code actually reads, compare it against the `each.value.*`
references in the corresponding `main.tf`.

## Adding a New Check Type

1. Add the resource block to `modules/check/main.tf`
2. Add the type to the validation regex in `modules/check/variables.tf`
3. Add any new variables needed to `modules/check/variables.tf`
4. Add the type to the `coalesce()` chains in `modules/check/outputs.tf`
5. Wire any new root-level variables through `main.tf` and `variables.tf`
6. Add any new per-check attributes to `local.allowed_attributes.checks` in `allowlists.tf`
7. Update the wrapper in `wrappers/main.tf` and `wrappers/allowlists.tf` if new root variables were added
8. Update the README check type table

## Adding a New Integration Type

1. Add the resource block to `modules/integration/main.tf`
2. Add the type to the validation regex in `modules/integration/variables.tf`
3. Add the type to the `coalesce()` chains in `modules/integration/outputs.tf`
4. Add any new settings attributes to `local.allowed_attributes.settings` in `modules/integration/allowlists.tf`
5. Update the README integrations list

## Adding a New Resource Module

1. Create a new directory under `modules/` (e.g., `modules/my_resource/`)
2. Add `main.tf`, `variables.tf`, `outputs.tf`, and `versions.tf` following existing patterns:
   - Use `count = var.create ? 1 : 0` for conditional creation
   - Use `try(resource[0].attr, null)` in outputs
   - Declare the provider floor in `versions.tf`; every submodule carries it so that calling one
     directly cannot resolve a provider too old for its resources
3. Add a `README.md` with a one-line description, a usage block, and the `BEGIN_TF_DOCS` /
   `END_TF_DOCS` markers, then generate its tables (see above). CI fails on a submodule without one.
4. Wire the module into the root `main.tf` with `for_each` and `try()` inheritance
5. Add the input variable (type `any`, default `{}`) to root `variables.tf`, with a `validation`
   block referencing a new `local.allowed_attributes` entry in `allowlists.tf`
6. Add the output to root `outputs.tf`
7. Add the variable to `wrappers/main.tf` with 3-level `try()` fallback, and add its attributes to
   `wrappers/allowlists.tf`
8. Update the README submodules table, inputs, and outputs
9. Add usage to `examples/complete/`
10. Update `CHANGELOG.md` under the `[Unreleased]` section
