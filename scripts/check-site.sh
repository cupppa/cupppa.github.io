#!/bin/sh
set -eu

check_file() {
  file="$1"
  if [ ! -s "$file" ]; then
    echo "Missing or empty generated file: $file" >&2
    exit 1
  fi
}

check_file public_html/index.html

for source in $(find org -type f -name '*.org' -print); do
  relative=${source#org/}
  output="public_html/${relative%.org}.html"
  check_file "$output"
  if ! grep -q '</html>' "$output"; then
    echo "Generated file is not complete HTML: $output" >&2
    exit 1
  fi
done

# Require the site's stylesheet and verify every published source asset.
check_file public_html/assets/css/site.css
find org/assets -type f -exec sh -c '
  for source do
    output="public_html/${source#org/}"
    if [ ! -f "$output" ] || ! cmp -s "$source" "$output"; then
      echo "Missing or stale generated asset: $output" >&2
      exit 1
    fi
  done
' sh {} +

node scripts/check-css.cjs

echo "Site checks passed."
