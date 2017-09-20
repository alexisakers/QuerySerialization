#!/bin/bash
set -e

MODULE_VERSION=$1
OUTPUT=$2
SWIFT_VERSION="4.0"
AUTHOR="Alexis Aubry"
AUTHOR_URL="https://twitter.com/_alexaubry"
MODULE_NAME="QuerySerialization"
COPYRIGHT="Copyright © 2017 $AUTHOR. Available under the MIT License."
GITHUB_URL="https://github.com/alexaubry/QuerySerialization"
GH_PAGES_URL="https://alexaubry.github.io/QuerySerialization"

jazzy \
    --swift-version $SWIFT_VERSION \
    -a "$AUTHOR" \
    -u "$AUTHOR_URL" \
    -m "$MODULE_NAME" \
    --module-version "$MODULE_VERSION" \
    --copyright "$COPYRIGHT" \
    -g "$GITHUB_URL" \
    --github-file-prefix "$GITHUB_URL/tree/master" \
    -r "$GH_PAGES_URL" \
    -o "$OUTPUT"\
    --min-acl public \
    --use-safe-filenames
