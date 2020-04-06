#!/bin/bash

[ "${FNRDEBUG:-0}" -gt 1 ] && set -x

# Synopsis {{{1
# The 'multi' source outputs at most $MAXREC (500) records to the tree
# list widget.  Each row displays its own icon, which is chosen in
# alphabetical order from the icon cache.  The row label is the icon
# name.  Activating a row brings up a demo Xdialog message showing the
# numbered icon name.  Handled error cases:
#  1. Invalid/not found ICONCACHE directory.
#  2. Empty icon cache.
# Source title and error messages can be localized by installing a
# suitable .mo file, findnrun-plugin-multi.mo

# User may change. {{{1
MAXREC=500 # output records

# Source declaration, manually copy to ~/.findnrunrc {{{1
# And add source 'multi' to variable SOURCES in ~/.findnrunrc.
# Uncomment each line when copying.
#SOURCE_multi='multi:multi::multi:'
#TAP_multi='/usr/share/findnrun/doc/examples/multi-field-tap.sh "${term}" | findnrun-formatter --'
#DRAIN_multi='show() { Xdialog --msgbox "$*" 0x0 ;} ; show'
#TITLE_multi='multi-field example'

# No change below. {{{1
term=$1 # search term

# Trap {{{1
TMPF="/tmp/.${0##*/}.tmp.$$"
trap 'rm -f "${TMPF:-/tmp/dummy}"*' HUP INT QUIT TERM ABRT 0

# i18n Localization {{{1
TEXTDOMAIN="findnrun-plugin-multi"

# Load findnrun settings. {{{1
ICONCACHE=
. ${HOME}/.findnrunrc

# Handle errors upfront. {{{1
# But only when the input search field is "", which happens in two
# cases: 1) the first time the source plugin is started, typically by
# pressing F3; and 2) when the user clears the search input field.
if [ -z "${term}" ]; then
  if ! [ -d "${ICONCACHE}" ]; then
    # Print error directly onto the list widget. {{{
    printf "$(gettext \
      "%sError: invalid setting: ICONCACHE.\n%sPlease try restarting Findnrun.")" \
      '||' '||' # 2 records
    #}}}
    exit
  fi
  # Our tap search targets the filename template findnrun-*.png only
  set +f # enable * expansion
  line=
  printf "%s\n" "${ICONCACHE}/findnrun"-*.png >"${TMPF}" && # list icon filenames
    read line < "${TMPF}" # read first filename
  # Filename ends with '*.png' if there were no matches.
  if case "${line}" in *-\*.png) true ;; *) false ;; esac; then
    # Error: no matching filename. {{{
    # i18n Please translate just the first gettext in
    # i18n TEXTDOMAIN=findnrun-plugin-multi. The second gettext is
    # i18n re-cycled from TEXTDOMAIN=findnrun by design to keep translated
    # i18n text in sync.
    # i18n Fyi, $TITLE is the value of $TITLE_multi in ~/.findnrunrc and
    # i18n here it's already translated, provided that a translation for
    # i18n $TITLE_multi exists in TEXTDOMAIN=findnrun-plugin-multi.
    printf "$(gettext \
      "%sPlugin '%s' found no icons to display.\n%sPlease untick [%s] and tick it again.\n%sThen clear the search input field to refresh search results.")" \
      '||' "${TITLE}" '||' "$(gettext -d findnrun "_Show all icons")" '||' # 3 records
    #}}}
    exit
  fi
fi

# Implement the search. {{{1
# Output tabular data {{{2
# Fill six columns:
# <icon-filename> '|' <tap-reserved> '|' <label> '|' <tap-data> '|' <comment> '|' <categories>

d=/dev/fd

# This is one way to fill six columns worth of data. Each here-doc below
# contains a column's worth of data. Sub-shells run in some here-docs to
# create dynamic data. Do not indent outside of an opening '$(' and its
# closing ')' or you will get spurious spaces in column data.
paste -d '|' $d/4 4<<EOF4 $d/5 5<<EOF5 $d/6 6<<EOF6 $d/7 7<<EOF7 $d/8 8<<EOF8 $d/9 9<<EOF9
$(
  # Save icon names to ${TMPF}.4
  set +f # enable * expansion
  # List icon filenames that match the search term.
  printf "%s\n" "${ICONCACHE}/findnrun-"*"$1"*.png >"${TMPF}.4" &&
  # Format filenames.
  awk '
  {
    # Exit on reaching the maximum output record count.
    if( ++n > '"${MAXREC}"') exit

    # Take basename and print to this column (EOF4).
    gsub(/^.*\/|\.png$/, ""); print

    # Strip name template prefix and print to file for column EOF6.
    print substr($0, 1+length("findnrun-")) > "'"${TMPF}.6"'"
  } ' "${TMPF}.4"
  # Below leave 2nd column (EOF) empty - it is tap-reserved.
)
EOF4
EOF5
$(
  # Print labels courtesy of column EOF4.
  cat "${TMPF}.6"
)
EOF6
$(
  # Source drain will process these data.
  # Output a numbered list of icon names for Xdialog to show on row activation.
  cat -n "${TMPF}.6"
)
EOF7
comments row 1
comments row 2
etc.
EOF8
categories row 1
categories row 2
etc.
EOF9

