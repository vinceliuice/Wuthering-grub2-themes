#!/bin/bash

INKSCAPE="/usr/bin/inkscape"
OPTIPNG="/usr/bin/optipng"

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

SCREEN_VARIANTS=('1080p' '2k' '4k')
THEME_VARIANTS=('changli' 'jinxi' 'jiyan' 'yinlin' 'anke' 'weilinai' 'kakaluo' 'jianxin')

render_background() {
  local theme="${1}"
  local screen="${2}"

  if [[ "${screen}" == "1080p" ]]; then
    EXPORT_DPI="96"
  elif [[ "${screen}" == "2k" ]]; then
    EXPORT_DPI="144"
  elif [[ "${screen}" == "4k" ]]; then
    EXPORT_DPI="192"
  else
    echo "Please use either '1080p', '2k' or '4k'"
    exit 1
  fi

  local FILENAME="$REPO_DIR/background-${theme}-${screen}.png"

  if [[ -f "$FILENAME" ]]; then
    echo "$FILENAME exists"
  else
    echo -e "\nRendering $FILENAME"
    $INKSCAPE "--export-id=${theme}" \
              "--export-dpi=$EXPORT_DPI" \
              "--export-id-only" \
              "--export-filename=$FILENAME" background.svg >/dev/null
    convert "$FILENAME" "$REPO_DIR/background-${theme}-${screen}.jpg"
  fi

  rm -rf "$FILENAME"
}

for theme in "${THEME_VARIANTS[@]}"; do
  for screen in "${SCREEN_VARIANTS[@]}"; do
    render_background "$theme" "$screen"
  done
done

exit 0
