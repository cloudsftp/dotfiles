#!/bin/bash

ROOT_DIR="/home/fabi/Anime"

if [ $# -eq 1 ]; then
    ROOT_DIR="$1"
fi

get_file_idx() {
  MATCH_FILE="$1"
  i="0"
  for FILE in *; do
    if [[ "$MATCH_FILE" = "$FILE" ]]; then
      echo "$i"
      break
    fi
    i=$(( i + 1 ))
  done
}

LAST_EPISODE_FILE=".last_episode"
set_last_episode() {
  echo "$1" > "$LAST_EPISODE_FILE"
}
get_last_episode() {
  [[ -f "$LAST_EPISODE_FILE" ]] || return
  cat "$LAST_EPISODE_FILE"
}
get_last_episode_idx() {
  get_file_idx "$(get_last_episode)"
}

get_next_episode() {
  EPISODES=()
  for EPISODE in *; do
    EPISODES+=( "$EPISODE" )
  done

  LAST_EPISODE="$(get_last_episode)"
  [[ -z "$LAST_EPISODE" ]] && return

  LAST_EPISODE_IDX=0
  for i in "${!EPISODES[@]}"; do
    if [[ "${EPISODES[$i]}" = "$LAST_EPISODE" ]]; then
      LAST_EPISODE_IDX="$i"
    fi
  done
  NEXT_EPISODE_IDX=$(( LAST_EPISODE_IDX + 1 ))
  [[ "$NEXT_EPISODE_IDX" -lt "${#EPISODES[@]}" ]] && echo "${EPISODES["$NEXT_EPISODE_IDX"]}"
}
get_next_episode_idx() {
  NEXT_EPISODE="$(get_next_episode)"
  [[ -n "$NEXT_EPISODE" ]] && echo "$(get_file_idx "$NEXT_EPISODE")"
}

LAST_DIR_FILE=".last_dir"
set_last_dir() {
  echo "$1" > "$LAST_DIR_FILE"
}
get_last_dir_idx() {
  [[ -f "$LAST_DIR_FILE" ]] || return
  echo "$(get_file_idx "$(cat "$LAST_DIR_FILE")")"
}

AUDIO_TRACK_FILE=".audio_track"
get_track() {
  FILE="$1"

  if [[ -f "$FILE" ]]; then
    echo "$(cat "$FILE")"
  else
    echo "auto"
  fi
}
set_audio_track() {
  echo "$1" > "$AUDIO_TRACK_FILE"
}
get_audio_track() {
  get_track "$AUDIO_TRACK_FILE"
}
SUBS_TRACK_FILE=".subs_track"
set_subs_track() {
  echo "$1" > "$SUBS_TRACK_FILE"
}
get_subs_track() {
  get_track "$SUBS_TRACK_FILE"
}
get_mpv_options() {
  echo "--aid=$(get_audio_track) --sid=$(get_subs_track)"
}

shopt -s extglob
VIDEO_FILE_PATTERN="+(*.mkv|*.mp4|*.avi)"

ROFI_COMMAND="rofi -matching-negate-char \
              -kb-move-char-forward Control+f \
              -kb-accept-entry Right,Return \
              -dmenu \
              -no-custom \
              -i \
              -p $(printf "\u30c4")"

# Control+j,Control+m,Return,KP_Enter

get_media_tracks() {
  EPISODE="$1"
  MEDIA_NAME="$2"

  mediainfo "$EPISODE" \
    | awk -v pattern="^${MEDIA_NAME}" '
    BEGIN {
      parsing = 0;
      first_option = 1;
      id = 1;
    }
    $0 ~ pattern {
      first_option = 0;
      parsing = 1;

      printf "%s,", id;
      id++;
    }
    /^Title/ || /^Language/ {
      if (parsing && $3 != "") {
        for (i = 3; i <= NF; i++) {
          printf "%s ", $i;
        }
        printf ",";
      }
    }
    /Forced/ {
      if (parsing) {
        printf "\n";
      }
      parsing = 0;
    }
    '
}

select_media_track() {
  EPISODE="$1"
  MEDIA_NAME="$2"
  SELECTED="$3"

  OPTIONS="$(get_media_tracks "$EPISODE" "$MEDIA_NAME")"

  [[ -z "$OPTIONS" ]] && return
  OPTIONS="auto,Default\n${OPTIONS}\nno,None"

  echo -e "$OPTIONS" | \
    column -s ',' -t | \
    ${ROFI_COMMAND} -select "$SELECTED" | \
    sed 's/\s.*//'
}

select_audio_subtitles() {
  EPISODE="$1"

  AID="$(select_media_track "$EPISODE" "Audio" "$(get_audio_track)")"
  [[ -n "$AID" ]] && set_audio_track "$AID"
  SID="$(select_media_track "$EPISODE" "Text" "$(get_subs_track)")"
  [[ -n "$SID" ]] && set_subs_track "$SID"
}

watch_episode() {
  EPISODE="$1"

  while true; do
    set_last_episode "$EPISODE"

    mpv $(get_mpv_options) "$EPISODE"
    sleep 0.5 # let resolution reset

    NEXT_EPISODE="$(get_next_episode)"
    SELECT_AUDIO_SUBS_OPTION="Choose Audio and Subtitles"

    OPTIONS="${EPISODE}"
    if [[ -n "$NEXT_EPISODE" ]]; then
      OPTIONS="${OPTIONS}\n${NEXT_EPISODE}"
      SELECTED_ROW="1" # select next episode
    else
      SELECTED_ROW="2" # select back
    fi
    OPTIONS="${OPTIONS}\n${SELECT_AUDIO_SUBS_OPTION}\nback"

    CHOICE="$( \
      echo -e "$OPTIONS" \
      | ${ROFI_COMMAND} \
        -selected-row "$SELECTED_ROW" \
      )"

    [[ -z "$CHOICE" ]] && exit 0

    case "$CHOICE" in
      $VIDEO_FILE_PATTERN)
        EPISODE="$CHOICE"
        ;;
      $SELECT_AUDIO_SUBS_OPTION)
        select_audio_subtitles "$EPISODE"
        ;;
      back)
        break
        ;;
    esac
  done
}

cd "$ROOT_DIR"

while true; do
  OPTIONS=""
  add_option() {
    OPTIONS="${OPTIONS}$1\n"
  }

  for FILE in *; do
    add_option "$FILE"
  done
  [[ "$(pwd)" = "$ROOT_DIR" ]] || add_option "back"
  add_option "exit"

  OPTIONS="${OPTIONS::-2}"

  LAST_EPISODE_IDX="$(get_last_episode_idx)"
  NEXT_EPISODE_IDX="$(get_next_episode_idx)"
  LAST_DIR_IDX="$(get_last_dir_idx)"
  if [[ -n "$LAST_DIR_IDX" ]]; then
    SELECTED_ROW="$LAST_DIR_IDX"
  elif [[ -n "$LAST_EPISODE_IDX" ]]; then
    if [[ -n "$NEXT_EPISODE_IDX" ]]; then
      SELECTED_ROW="$NEXT_EPISODE_IDX"
    else
      SELECTED_ROW="$(( LAST_EPISODE_IDX + 1))" # select back
    fi
  else
    SELECTED_ROW="0"
  fi

  CHOICE="$( \
    echo -e "$OPTIONS" \
    | ${ROFI_COMMAND} \
      -selected-row "$SELECTED_ROW" \
    )"

  [[ -z "$CHOICE" ]] && exit 0

  case "$CHOICE" in
    back)
      cd ..
      ;;
    exit)
      exit 0
      ;;
    $VIDEO_FILE_PATTERN)
      watch_episode "$CHOICE"
      ;;
    *)
      if [[ -d "$CHOICE" ]]; then
        set_last_dir "$CHOICE"
        cd "$CHOICE"
      fi
      ;;
    esac
done

