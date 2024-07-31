#!/bin/bash

INKSCAPE="/usr/bin/inkscape"
OPTIPNG="/usr/bin/optipng"

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

THEME_VARIANTS=('changli' 'jinxi' 'jiyan' 'yinlin' 'anke' 'weilinai' 'kakaluo' 'jianxin')

render_background() {
  local theme="${1}"

  local FILENAME="$REPO_DIR/background-${theme}.png"

  if [[ -f "$FILENAME" ]]; then
    echo "$FILENAME exists"
  else
    echo -e "\nRendering $FILENAME"
    $INKSCAPE "--export-id=${theme}" \
              "--export-dpi=96" \
              "--export-id-only" \
              "--export-filename=$FILENAME" background.svg >/dev/null
    convert "$FILENAME" "$REPO_DIR/background-${theme}.jpg"
  fi

  rm -rf "$FILENAME"
}

for theme in "${THEME_VARIANTS[@]}"; do
  render_background "${theme}"
done

exit 0
