# Astraverse Homebrew Tap

Homebrew formulae and casks for [Astraverse](https://github.com/astraverse-io)
projects.

> **Status: not yet installable.** The KubeAstra desktop app ships its first
> signed build with desktop Phase 2. This tap is scaffolded ahead of that
> release; `brew install` will fail until the first `desktop-v*` release
> exists.

## Install

```bash
brew tap astraverse-io/tap
brew trust astraverse-io/tap     # Homebrew 6+ requires this for third-party taps
brew install --cask kubeastra
```

The `brew trust` step is Homebrew's safeguard for taps outside the official
catalog — without it you get
`Error: Refusing to load cask … from untrusted tap`. Trusting a tap means you
are allowing code from this repository to run during installs, so it is worth
[reading the cask](Casks/kubeastra.rb) first; it is 50 lines and does nothing
but download the signed DMG from the KubeAstra releases page. Reverse it any
time with `brew untrust astraverse-io/tap`.

This requirement disappears if KubeAstra is later accepted into the official
homebrew-cask catalog.

After tapping once, KubeAstra behaves like any other cask:

```bash
brew upgrade --cask kubeastra     # update
brew uninstall --cask kubeastra   # remove
brew uninstall --zap --cask kubeastra   # remove, including local data
```

`--zap` also deletes your local investigation history, saved clusters and
vector memory under `~/Library/Application Support/KubeAstra`.

## What is KubeAstra?

An AI-powered Kubernetes investigation assistant. It runs on your machine,
uses the kubeconfig and kubectl you already have, and never requires
installing an agent into your cluster.

Source: [astraverse-io/KubeAstra](https://github.com/astraverse-io/KubeAstra)

## Why a tap instead of homebrew-cask?

Homebrew's central cask catalog requires a project to demonstrate adoption
before accepting a submission. Running our own tap means one extra `brew tap`
line for users and is otherwise identical. Once KubeAstra meets the
notability bar we intend to submit upstream, at which point the `tap` step
becomes unnecessary — existing installs migrate without disruption.

## Maintenance

`Casks/kubeastra.rb` is updated automatically by
[`update-cask.yml`](.github/workflows/update-cask.yml), which the KubeAstra
release workflow triggers on each `desktop-v*` tag. It downloads the released
DMGs, computes their checksums, and commits the new version.

To update manually:

```bash
gh workflow run update-cask.yml -f version=1.2.3 --repo astraverse-io/homebrew-tap
```

## License

Apache-2.0. The KubeAstra trademark policy applies to use of the KubeAstra
name and logo — see
[TRADEMARK.md](https://github.com/astraverse-io/KubeAstra/blob/main/TRADEMARK.md).
