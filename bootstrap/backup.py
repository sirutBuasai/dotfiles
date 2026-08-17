#!/usr/bin/env python3
"""Snapshot of dotbot's managed dotfiles prior to init

Reads the link map from a dotbot config, and back up real file/dir targets
to ~/.dotfiles-backup/<timestamp>/ mirroring its $HOME-relative path.
Symlinks are left for dotbot's relink; paths that don't exist are skipped.

  usage: bootstrap/backup.py [config]     (config default: install.conf.yaml)
"""
import argparse
import os
import shutil
import sys
import time

DIR = os.path.dirname(os.path.abspath(__file__))
REPO = os.path.dirname(DIR)
HOME = os.path.expanduser("~")

# dotbot's vendored pyyaml
sys.path.insert(0, os.path.join(REPO, ".dotbot", "lib", "pyyaml", "lib"))
import yaml  # noqa: E402


def parse_args():
    p = argparse.ArgumentParser(
        prog="backup.py",
        description="Back up real files that dotbot is about to symlink.",
    )
    p.add_argument(
        "config",
        nargs="?",
        default="install.conf.yaml",
        help="dotbot config to read the link map from (default: %(default)s)",
    )
    return p, p.parse_args()


def link_targets(config_path):
    """Yield every target path under the config's `link:` directive."""
    with open(config_path) as f:
        docs = yaml.safe_load(f) or []
    for doc in docs:
        if isinstance(doc, dict) and "link" in doc:
            yield from doc["link"]


def backup_rel(path):
    """Path under the stamp dir: mirror $HOME layout; nest others by abs path."""
    rel = os.path.relpath(path, HOME)
    if rel.startswith(".."):          # target lives outside $HOME
        rel = os.path.relpath(path, "/")
    return rel


def main():
    parser, args = parse_args()

    config_path = os.path.join(REPO, args.config)
    if not os.path.isfile(config_path):
        parser.error(f"config not found: {config_path}")

    try:
        targets = list(link_targets(config_path))
    except (OSError, yaml.YAMLError) as e:
        print(f"! backup: could not read {args.config}: {e} (skipping)", file=sys.stderr)
        return 0

    stamp = os.path.join(HOME, ".dotfiles-backup", time.strftime("%Y%m%d-%H%M%S"))
    backed_up = 0

    for target in targets:
        if not target:
            continue

        pth = os.path.expanduser(os.path.expandvars(str(target)))

        # skip symlinks (dotbot relink handles them) and paths that don't exist
        if os.path.islink(pth) or not os.path.exists(pth):
            continue

        dest = os.path.join(stamp, backup_rel(pth))
        os.makedirs(os.path.dirname(dest), exist_ok=True)
        shutil.move(pth, dest)

        print(f"backed up {pth} → {dest}")
        backed_up += 1

    print(
        f"▶ backups saved under {stamp}" if backed_up
        else "▶ no existing real files to back up"
    )
    return 0


if __name__ == "__main__":
    sys.exit(main())
