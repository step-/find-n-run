#!/bin/sh

# =============================================================================
# create-pot-file.sh - Create findnrun GNU GetText template file
  Version=1.1.0
# author: Copyright (C)2016-2018 step
# license: GNU GPL version 2
# depends: GNU gettext package, mdview
# source: https://github.com/step-/find-n-run
# forum: http://www.murga-linux.com/puppy/viewtopic.php?t=102811
# =============================================================================

# Stubs for configuration file.
is_to_be_translated() { :; }
list_md_files() { :; }
FPOT= XSRC= XOPT= XTBL= XXGT= XXGTOPT=

CONFIG=$1
[ -z "$CONFIG" ] && CONFIG="${0%.sh}-config.sh"
if ! [ -r "$CONFIG" ]; then
  echo >&2 "${0##*/}: error: can't read configuration file '$CONFIG'.
usage: ${0##*/} [config-file (default ${0%.sh}-config.sh)]"
  exit 1
fi
. "$CONFIG"
if ! [ -e "$XSRC" -a -n "$FPOT" ]; then
  echo >&2 "${0##*/}: error: at least one of XSRC, FPOT is wrong."
  exit 1
fi

mdview=${MDVIEW:-mdview}
mdview=$(command -v "$mdview")
if [ -z "$mdview" ]; then
  echo >&2 "${0##*/}: error: can't find command 'mdview'. Found MDVIEW='$MDVIEW'."
  exit 1
fi

create_pot_file() # $1-pot-file $2...-xgettext-options {{{1
{
  local f x fpot xopt
  fpot=$1; shift
  rm  -f "$fpot."*tmp

  # Create pot file header
  init_po_file "$fpot.tmp" || {
    ERRORS="${ERRORS}
    init_po_file '$fpot' $*"; return 1; }
  # Append all notes
  insert_notes >> "$fpot.tmp"
  # Append main source file scan
  scan_source_file "$XSRC" "$@" --omit-header >> "$fpot.tmp" || {
    ERRORS="${ERRORS}
    scan_source_file '$XSRC'"; return 1; }
  # Append i18n_table source file scan
  scan_i18n_table_file "$XTBL" --omit-header >> "$fpot.tmp" || {
    ERRORS="${ERRORS}
    scan_i18n_table_file '$XTBL'"; return 1; }
  # Append notes again
  type __notes_on_pot_file >/dev/null 2>&1 &&
    __notes_on_pot_file >> "$fpot.tmp"
  # Append .md file scans
  while read -r f; do
    is_to_be_translated "$f" || continue
    scan_md_file "$f" "$fpot.2.tmp"
    # Cumulate unique messages, all comments and all file positions.
    msgcat --no-wrap -o "$fpot.tmp" "$fpot.tmp" "$fpot.2.tmp" 2>> "$fpot.warn.tmp" || ERRORS="${ERRORS}
    msgcat '$f'"
  done << EOF
  $(list_md_files)
EOF
  # Output warnings except those related to "...\r..."
  sort -u "$fpot.warn.tmp" | grep -vF '\r' >&2
  # Delete annoyances
  sed '
/#-#-#-#-#/d
/^#: /{s~ \.\./\.\./\.\./\.\./~ /usr/~g}
s~^#:.*'"$PACKAGE_NAME"'~#: ~
' "$fpot.tmp" || ERRORS="${ERRORS}
  sed"

  rm  -f "$fpot."*tmp
  return ${ERRORS:+1}
}

scan_source_file() # $1-filepath $2...-xgettext-options {{{1
{
  local f
  f=$1; shift &&
  echo >&2 "$f" &&
  env TZ="$PACKAGE_POT_CREATION_TZ" \
    xgettext "$@" --no-wrap -o -  \
      --package-name="$PACKAGE_NAME" \
      --package-version="$PACKAGE_VERSION" \
      --msgid-bugs-address="$PACKAGE_POT_BUGS_ADDRESS" \
    "$f"
}

scan_i18n_table_file() # $1-filepath $2...-xgettext-options {{{1
{
  local f sep
  f=$1; shift &&
  echo >&2 "$f" &&
  case $XXGTOPT in
    *' '--' '*|--' '*|*' '-- ) : ;; *) sep="--" ;; esac &&
    "$XXGT" $XXGTOPT $sep "$@" --no-wrap "$f"
}

init_po_file() # $1-po(t)-OUTPUT-file $2...-xgettext-options {{{1
{
  local f
  f=$1; shift
  env TZ="$PACKAGE_POT_CREATION_TZ" \
    xgettext "$@" --force-po -C -o "$f" \
      --package-name="$PACKAGE_NAME" \
      --package-version="$PACKAGE_VERSION" \
      --msgid-bugs-address="$PACKAGE_POT_BUGS_ADDRESS" \
    /dev/null &&
  sed -i '
1,20{s~SOME DESCRIPTIVE TITLE~'"$PACKAGE_TITLE"'~}
1,20{s~YEAR THE PACKAGE.*$~'"$PACKAGE_COPYRIGHT"'~}
1,20{s~FIRST AUTHOR.*$~'"$PACKAGE_FIRST_POT_AUTHOR"'~}
1,20{s~Language: ~&'"$PACKAGE_POT_LANGUAGE"'~}
1,20{s~=CHARSET~='"$PACKAGE_CHARSET"'~}
$ a \
"Plural-Forms: nplurals=INTEGER; plural=EXPRESSION;\\n"\

' "$f"
}

insert_notes() # {{{1
{
  local f
  # Opening notes on pot file
  type __notes_on_pot_file >/dev/null 2>&1 &&
    __notes_on_pot_file
  # Call all function names that start with '__notes_on_file' in
  # config file except those that are marked 'excluded'.
  for f in $(awk -F '[ \t()]' \
    '/^__notes_on_file/ && ! /excluded/ {print $1}' "$CONFIG"); do
    eval $f
  done
}

insert_notes_on_file() # $1-filepath {{{1
{
  local f x
  f=$1
  echo "
#.
#. ---------------------------------------------------------
#. i18n $f
#. ---------------------------------------------------------
#.
"
  x=__notes_on_file_${f##*/}; x=${x%.*}
  type "$x" >/dev/null 2>&1 && eval "$x"
}

scan_md_file() # $1-in-filepath $2-out-filepath {{{1
{
  local in out
  in=$1 out=$2
  echo >&2 "$in"

  init_po_file "$out" || {
    ERRORS="${ERRORS}
    init_po_file '$in'"; return 1; }

  insert_notes_on_file "$in" >> "$out"

  $mdview --po "$in" >> "$out" # || {
    #ERRORS="${ERRORS}
    #$mdview '$in'"; return 1; }
  # FIXME[mdview] mdview's stdout_output() doesn't exit(code) at all

  # Always run msguniq on output by mdview --po
  msguniq --no-wrap -i "$out" -o "$out" || {
    ERRORS="${ERRORS}
   msguniq '$in'"; return 1; }
}

# {{{1}}}
ERRORS=
create_pot_file "$FPOT" $XOPT > "$FPOT"
if [ -n "${ERRORS}" ]; then
  echo >&2 "${0##*/}: ERRORS:${ERRORS}"
  exit 1
fi

