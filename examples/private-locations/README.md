# Private Locations Example

This example demonstrates the `uptime_private_locations` data source support added in v2.0.0
of this module, backed by the `uptime-com/uptime` provider `>= 2.29`.

Setting `use_private_locations = true` on a check resolves the account's private monitoring
locations and uses them for that check's `locations`. Any explicitly listed `locations` are
merged in and de-duplicated, so private and public locations can be combined.

The lookup is only performed when something consumes it — a check opting in, or
`lookup_private_locations = true` for the `private_locations` and `private_check_locations`
outputs on their own. Accounts with no private location monitors resolve to an empty list.

Note that checks match private locations on the `location` field rather than the user-facing
`name`; `private_check_locations` returns the values in the form a check expects.

It requires the `uptime-com/uptime` provider `>= 2.34`.
