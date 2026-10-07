#!/usr/bin/env python3
"""Write root Package.swift for a GitHub binary release."""
from __future__ import annotations

import argparse
from pathlib import Path


TEMPLATE = """\
// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "LibXray",
    products: [
        .library(name: "LibXray", targets: ["LibXray"])
    ],
    targets: [
        .binaryTarget(
            name: "LibXray",
            url: "{url}",
            checksum: "{checksum}"
        )
    ]
)
"""


def main() -> None:
    p = argparse.ArgumentParser()
    p.add_argument("--repo", required=True, help="owner/name")
    p.add_argument("--tag", required=True)
    p.add_argument("--checksum", required=True)
    p.add_argument("--out", default="Package.swift")
    args = p.parse_args()
    url = f"https://github.com/{args.repo}/releases/download/{args.tag}/LibXray.xcframework.zip"
    Path(args.out).write_text(
        TEMPLATE.format(url=url, checksum=args.checksum.strip()),
        encoding="utf-8",
        newline="\n",
    )
    print(args.out)


if __name__ == "__main__":
    main()
