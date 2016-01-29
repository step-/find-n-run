#!/bin/sh

if ! command -v mdview >/dev/null; then
  echo >&2 "${0%%*/}: error: This script needs command 'mdview'."
  exit 1
fi

VERSION=2.0.0
DMD=../../findnrun
DBIN=../../../../bin
FPOT=findnrun.new.pot
ERRORS=

create_pot_file() # {{{1
{
local f
set +f
rm -f "${FPOT}.tmp"

xgettext -o "${FPOT}.tmp" -ci18n -L Shell --no-wrap \
  --package-name=find-n-run --package-version=${VERSION} \
  --msgid-bugs-address=https://github.com/step-/find-n-run/issues/ \
  "${DBIN}/findnrun" || {
  ERRORS="${ERRORS}
  xgettext"; return 1; }

sed -i '
1,20{s/SOME DESCRIPTIVE TITLE/Findnrun '"${VERSION}"'/}
1,20{s/YEAR THE PACKAGE.*$/2015-2016 step; 2015 FSH, L18L, step/}
1,20{s/FIRST AUTHOR.*$/step, 2015 https:\/\/github.com\/step-\//}
1,20{s/CHARSET/UTF-8/}
/POT-Creation-Date:/{s/[0-9][0-9][0-9][0-9]\\n/0000\\n/}
1,20{s/Language: /&English/}
$ a \
\
# =======================================================================\
# i18n User documentation in markdown format from .md files follows.\
# i18n IMPORTANT! Reproduce indentation and special punctuation exactly.\
# =======================================================================\

' "${FPOT}.tmp" || {
  ERRORS="${ERRORS}
  sed"; return 1; }

for f in "${DMD}/"*.md "${DMD}/../examples/"*/*.md; do
  case $f in
    */TRANSLATING.md)
      : >&2 $f targets translators - they need English doc only
      ;;
    */plugin-debugging.md|*/plugin-dev.md|*/plugin-examples.md|*/plugin-list.md)
      : >&2 $f targets developers - they prefer English doc anyway
      ;;
    */no-help.md)
      : >&2 $f is obsolete
      ;;
    */examples/*)
      : >&2 $f not now - maybe to be translated in a future release
      ;;
    */LICENSE.md) : >&2 we keep $f in English as GNU GPL does not endorse translations
      ;;
    *)
      : >&2 $f target end users - translate it
      echo >&2 "$f"
      echo "

# ---------------------------------------------------------
# i18n $f
# ---------------------------------------------------------

"
      if [ LICENSE.md = "$f" ]; then # NOT REACHED
        echo "
# i18n LICENSE.md is a special case. Do not try to translate it. Instead
# i18n find a translation from http://www.gnu.org/licenses/translations.html
# i18n and use that translated text here.
"
    fi &&
    mdview --po "$f" || ERRORS="${ERRORS}
  mdview '$f'"
    # Sometimes mdview returns error status but prints no error message.
    ;;
  esac
done >> "${FPOT}.tmp"

msguniq --no-wrap --no-location "${FPOT}.tmp" || ERRORS="${ERRORS}
  msguniq"

rm  -f "${FPOT}.tmp"

return ${ERRORS:+1}

}

# {{{1}}}
create_pot_file > "${FPOT}"
[ -n "${ERRORS}" ] && echo >&2 "${0##*/}: ERRORS:${ERRORS}"

exit ${ERRORS:+1}

