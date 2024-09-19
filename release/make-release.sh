#! /bin/bash

OPEN_DIR=$(cd $(dirname $0) && pwd)

THEME_NAME=Wuthering

SCREEN_VARIANTS=('1080p' '2k' '4k')
THEME_VARIANTS=('changli' 'jinxi' 'jiyan' 'yinlin' 'anke' 'weilinai' 'kakaluo' 'jianxin')

screens=()
themes=()

if [[ "${#screens[@]}" -eq 0 ]] ; then
  screens=("${SCREEN_VARIANTS[@]}")
fi

if [[ "${#themes[@]}" -eq 0 ]] ; then
  themes=("${THEME_VARIANTS[@]}")
fi

Tar_themes() {
  for theme in "${themes[@]}"; do
    rm -rf ${THEME_NAME}-${theme}-grub-theme.tar
    rm -rf ${THEME_NAME}-${theme}-grub-theme.tar.xz
  done

  for theme in "${themes[@]}"; do
    tar -Jcvf ${THEME_NAME}-${theme}-grub-theme.tar.xz ${THEME_NAME}-${theme}-grub-theme
  done
}

Clear_theme() {
  for theme in "${themes[@]}"; do
    rm -rf ${THEME_NAME}-${theme}-grub-theme
  done
}

cd ..
for theme in "${themes[@]}"; do
  for screen in "${screens[@]}"; do
    ./generate.sh -d "$OPEN_DIR/${THEME_NAME}-${theme}-grub-theme/${screen}" -t "${theme}" -s "${screen}"
    cp -rf "$OPEN_DIR"/install "$OPEN_DIR/${THEME_NAME}-${theme}-grub-theme/${screen}"/install.sh
    sed -i "s/grub_theme_name/${THEME_NAME}-${theme}/g" "$OPEN_DIR/${THEME_NAME}-${theme}-grub-theme/${screen}"/install.sh
  done
done

cd $OPEN_DIR && Tar_themes && Clear_theme

