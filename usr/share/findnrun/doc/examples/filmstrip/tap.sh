#!/bin/sh
# POSIX. No bashisms.

[ "${FNRDEBUG:-0}" -gt 1 ] && set -x

# Source plugin 'filmstrip' tap has its own configuration file.
# See the default configuration file 'taprc' in this folder.
# That file also explains how to enable the plugin.
# Plugin synopsis can be found in file README.md in this folder.

# No change below. {{{1
CONFIG=$1; . "${CONFIG}"
term=$2 # search term
MAXREC=${LIST_LINES:-100} # output records
xmax=$((${VIEWER_FRAMES} -1)) # image strip max row index (0-based)
ymax=0 # ditto column index TODO implement ymax>0
MAXSLOT=$(( (${ymax}+1) * (${xmax}+1) ))
TMPD="${FNRTMP:-/tmp}/.${ID:-filmstrip}" && mkdir -p "${TMPD}" && chmod 700 "${TMPD}"
RESF="${TMPD}/.result" # search results for each ${term}
ALLF="${TMPD}/.all" # cache all image paths between invocations
VIEWER="${0%/*}/viewer.sh" # viewer component
INPUTSTEM="${TMPD}/.input" # viewer component's input file stem
BLANKIMG="${0%/*}/spacer.png"

# i18n Localization {{{1
TEXTDOMAIN="findnrun-plugin-filmstrip"

infobox () # $1-single-line-message, non-blocking {{{1
{
  local pid x
  # i18 $TITLE translation fyi. {{{
  # i18n $TITLE is the value of $TITLE_filmstrip in ~/.findnrunrc and
  # i18n here it's already translated, provided that a translation for
  # i18n $TITLE_filmstrip exists in TEXTDOMAIN=findnrun-plugin-filmstrip.
  #}}}
  x=$(printf '\xc2\xa0') # U+00A0 no-break space
  x="$x$x$x$x"; x="$x$x"; x="$x$x"
  pid=$(Xdialog --title "${TITLE}" --no-buttons \
    --infobox "$x$1$x" 0x0 999999 1>&2 &
  echo -n $!)
  # Return sane pid to kill infobox dialog.
  case ${pid} in 0|1) ;; *) echo -n ${pid};; esac
}

: List image filenames that match the search $term. #{{{1
# $ALLF is a working file which doubles as *the* cache file when
# $CACHE_LIST is 'true'.
if ! [ -s "${ALLF}" ]; then
  # Find image files {{{
  [ true = "${FIND_IN_SUBFOLDERS}" ] || FIND_EXPR_OPTS="-maxdepth 1 ${FIND_EXPR_OPTS}"
  ifs=${IFS}; IFS=: # $FIND_PATH is formatted like $PATH
  set -- ${FIND_PATH}; IFS=${ifs}
  find ${FIND_OPTS} "$@" ${FIND_EXPR_OPTS} -type f -iregex ".*${FIND_TYPE}" >"${ALLF}"
  [ true = "${FIND_SORTED}" ] && sort -o "${ALLF}" "${ALLF}"
  #}}}
  # Warn against finding no files. {{{
  if ! [ -s "${ALLF}" ]; then
    infobox_pid=$(infobox "$(gettext "Warning: no files found.")")
    sleep 2
    kill ${infobox_pid} >/dev/null 2>&1
  fi
  # }}}
  # Optionally read custom caption data {{{
  if [ -n "${CUSTOM_CAPTION}" ] && [ -s "${ALLF}" ]; then
    infobox_pid=$(infobox "$(gettext "Reading captions...")")

    ${CUSTOM_CAPTION} "${ALLF}" > "${ALLF}.tmp"
    # Guard against gross failure of $CUSTOM_CAPTION function.
    [ -s "${ALLF}.tmp" ] && mv "${ALLF}.tmp" "${ALLF}"

    kill ${infobox_pid} >/dev/null 2>&1
  fi
  #}}}
fi

# Work-around for AWKPATH variable in gawk < 4.1.2 {{{1
# Issue: gawk versions < 4.1.2 search the current directory for include
# files either before or after searching the paths in AWKPATH. This may
# lead to accidental false hits :- finding an include file from outside of
# AWKPATH. We avoid accidental false hits by changing directory to ${TMPD}
# before running any of the gawk commands below. Note that free cd-ing is
# safe because tap.sh doesn't only uses fullpaths.
cd "${TMPD}" || exit 911

#{{{1}}} Tip: Study 'On event PageUp/Down' after studying
# 'On needing to generate new records' further down.
RESF_ready=false
: On event PageUp/Down... #{{{1
# ... and availability of previously-generated records in $RESF.
# Paginate those records, and send image to the viewer component.
[ -s "${RESF}" ] && case "${FNREVENT}" in
  PageDown|PageUp)
    # Rotate up/down the previous list of results. {{{2
    [ PageDown = ${FNREVENT} ] && sign=+ || sign=-
    AWKPATH="${0%/*}" gawk -F '|' \
      -v MAXSLOT=${MAXSLOT} -v STEM="${INPUTSTEM}" \
      -v RATE=${TYPING_RATE:-0.5} \
      -v ROTATE=${sign}${MAXSLOT} \
      -f rotate.awk "${RESF}" > "${RESF}.tmp" &&
    #{ diff -y "${RESF}.tmp" "${RESF}"; true ;} >&2 &&
    mv "${RESF}.tmp" "${RESF}" &&
    RESF_ready=true
    ;;
esac

: On needing to generate new records... # {{{1
# ... due to event 'Search' or no previously-generated records for events 'PageUp/Down'.
# Save new records to $RESF, and send image references to the viewer component.
if [ false = ${RESF_ready} ]; then
  # Set basedir but only if it's a single path. {{{2
  # Multi-path value with embedded colons will very likely fail the test.
  [ -e "${FIND_PATH}" ] && basedir=${FIND_PATH} || basedir=
  basedir=${basedir%/}

  # generate-records.awk filters and formats $ALLF to create $RESF. {{{2
  AWKPATH="${0%/*}" gawk -F '[/|]' \
    -v OUTF="${RESF}" -v TERM="${term}" -v BASEDIR="${basedir}" \
    -v MAXREC=${MAXREC} -v MAXSLOT=${MAXSLOT} -v STEM="${INPUTSTEM}" \
    -v RATE=${TYPING_RATE:-0.5} \
    -f generate-records.awk "${ALLF}" &&
  RESF_ready=true
fi

: Manage the cache. #{{{1
# Note that $RESF, if existing, is left untouched because we want to
# keep its data around for the *next* invocation regardless of cache
# file status.
[ true = "${CACHE_LIST}" ] || rm -f "${ALLF}"

: Output records to findnrun search list. #{{{1
if [ true = ${RESF_ready} ]; then
  # Work-around a gtkdialog-514 bug:
  # When the <comment> field length is greater than 363 the list widget
  # displays some empty items.  So we shorten the comment, much shorter
  # than 363 characters, which makes sense because findnrun's comment
  # widget can't be scrolled anyway, and we have already searched
  # through the full caption text.
  awk -F '|' -v OFS='|' '{$5=substr($5,1,80)"...";print}' "${RESF}"
fi

: Start viewer component once only. #{{{1
# $VIEWER itself creates/deletes .pidof_viewer when it starts/terminates.
if ! [ -e "${INPUTSTEM%/*}/.pidof_viewer" ]; then
  # Helpers for viewer buttons.
  echo "rm -f '"${ALLF}"'" > "${INPUTSTEM%/*}/.btn-restart-search.sh"

  cp "${BLANKIMG}" "${TMPD}/.blankimg"
  (
    [ "${FNRDEBUG}" ] && >&2 echo starting "'${VIEWER}' '${INPUTSTEM}'"

    FNRDEBUG=${FNRDEBUG} FNRRPC=${FNRRPC} "${VIEWER}" \
      "${CONFIG}" "${INPUTSTEM}" 1>&2 &

    [ "${FNRDEBUG}" ] && >&2 echo bg pid $!
  ) >/dev/null
fi

