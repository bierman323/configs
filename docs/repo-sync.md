---
tags: [tools, git, cli]
aliases: [repo-sync, repo sync check]
---

# repo-sync

> **Script**: `~/bin/repo-sync` (on `$PATH`)
> Config dir: `~/.config/repo-sync/` (created automatically, per machine)

Scans a directory tree for git repos, reports which are dirty (uncommitted
changes) and which are clean-but-behind their remote, then offers to pull
the behind ones. Uncommitted repos are just listed — never touched.

---

## Basic usage

```sh
cd ~/code
repo-sync              # check status
```

- First run in a given directory: no cache exists yet, so it scans
  automatically.
- Every run after that: prompts `Rescan ... and update the map? [y/N]`
  before deciding whether to re-walk the filesystem or just reuse the
  cached list of repos from last time.
- Dirty repos (uncommitted/staged/untracked changes) are reported and
  skipped — no prompt, nothing is touched.
- Clean repos behind their remote get a per-repo `Pull? [y/N]` prompt.
  Pulls always use `--ff-only`, so it will never create a merge commit.

Pass a directory to scan something other than the current one:

```sh
repo-sync ~/code/awn
repo-sync /opt
```

---

## Flags

| Flag | Effect |
|------|--------|
| `--scan` | Force a rescan of `ROOT_DIR` and update its map, skipping the prompt |
| `--list-maps` | List every root that has a cached map, with repo counts |
| `--ignore [PATH]` | Add `PATH` to the ignore list (default: current directory) and exit |
| `-h` | Help |

---

## The map (per-root cache)

Each root directory you scan gets its own cache file under
`~/.config/repo-sync/maps/`, named from the root's absolute path (e.g.
`~/code` → `Users_you_code`). This means scanning `~/code` and scanning
`~` are tracked independently — running from one never silently reuses
the other's map.

```sh
repo-sync --list-maps
```

```
Cached roots
  /Users/brad.bierman/.config (1 repos)
  /Users/brad.bierman/code (56 repos) (current)
```

The map only stores a plain list of repo paths — it does not cache dirty
or behind status. Every run re-checks live status for each repo in the
map; the map just saves re-walking the filesystem.

---

## Ignoring directories or repos

`~/.config/repo-sync/ignore` — one path per line, `#` comments allowed,
`~` expands to `$HOME`. Matching directories are pruned entirely during a
scan (repo-sync never descends into them). It works for a single repo
too, not just parent directories — ignoring a repo's own path skips just
that repo without affecting its siblings.

Created automatically on first run, prepopulated with `~/Downloads`.

Add entries with the flag instead of hand-editing:

```sh
repo-sync --ignore                  # ignore the dir you're standing in
repo-sync --ignore ~/code/foo       # ignore a specific repo or directory
```

This also strips the path from any existing maps immediately, so it
takes effect right away — no need to `--scan` again.

---

## Notes

- Symlinks are **not** followed while scanning — only real directories on
  the local filesystem.
- Portable to bash 3.2+ (stock macOS `/bin/bash`), no GNU-only coreutils
  flags — safe to use on servers as well as this machine.
- Repo names in output are shown relative to `ROOT_DIR`, not `$HOME`.
