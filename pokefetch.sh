#!/usr/bin/env bash

POKEMON_LIST=(
  "charizard --mega-x"
  "mimikyu -s"
  "mewtwo --mega-y"
  umbreon
  gengar
  cubone
  groudon
  emboar
  snorlax
)

FETCHER="fastfetch --logo none"

FETCHER_HEIGHT=$($FETCHER | wc -l)

EXTRA_PADDING_H=2
EXTRA_PADDING_W=0
WIDTH=38

sprite=$(pokeget ${POKEMON_LIST[RANDOM % ${#POKEMON_LIST[@]}]} --hide-name)

height=$(echo "$sprite" | wc -l)

pad_top=$((($FETCHER_HEIGHT - $height) / 2))
pad_top=$((pad_top + EXTRA_PADDING_H))

(( pad_top < 0 )) && pad_top=0

sprite_width=$(
  printf '%s\n' "$sprite" |
  sed 's/\x1b\[[0-9;]*m//g' |
  awk '{ if (length > max) max = length } END { print max }'
)

pad_Left=$((($WIDTH - sprite_width) / 2))
pad_Right=$((($WIDTH - sprite_width + 1) / 2))

pad_Left=$((pad_Left + EXTRA_PADDING_W))
pad_Right=$((pad_Right + EXTRA_PADDING_W))

(( pad_Left < 0 )) && pad_Left=0
(( pad_Right < 0 )) && pad_Right=0

echo "$sprite" | $FETCHER \
  --file-raw - \
  --logo-padding-top $pad_top \
  --logo-padding-left $pad_Left \
  --logo-padding-right $pad_Right

