# rajasdevel/tap

Homebrew formulae for [NetShift](https://github.com/rajasdevel/netshift), a
small watcher that runs your own scripts when your public IP or connectivity
changes.

## Install

```sh
brew install rajasdevel/tap/netshift
```

This installs the prebuilt NetShift release for macOS or Linux, on ARM64 or
Intel, checked against the release's `SHA256SUMS`. The example profiles and
recipes are in `$(brew --prefix)/share/netshift`:

```sh
netshift --config "$(brew --prefix)/share/netshift/config/example.json" validate
```

## Upgrade

```sh
brew upgrade netshift
```

An installed NetShift service runs its own copy of the binary, so after an
upgrade, repeat `netshift --config PROFILE service install --start` for each
profile.

## Maintenance

Each stable NetShift release updates `Formula/netshift.rb` with
`scripts/bump-formula.py` from the netshift repository, as described in its
[release checklist](https://github.com/rajasdevel/netshift/blob/main/docs/releasing.md#maintainer-checklist).
Please report problems in the
[netshift issues](https://github.com/rajasdevel/netshift/issues).
