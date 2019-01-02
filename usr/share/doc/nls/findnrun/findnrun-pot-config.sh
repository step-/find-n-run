# This file is sourced not run

# =============================================================================
# finnrun-pot-config.sh - Project configuration for findnrun .pot file creator
  Version=1.1.1
# author: Copyright (C)2015-2019 step
# license: GNU GPL version 2
# depends: GNU gettext package, mdview, xgettext.sh
# source: https://github.com/step-/find-n-run
# forum: http://www.murga-linux.com/puppy/viewtopic.php?t=102811
# =============================================================================

# Optional settings {{{1
MDVIEW=mdview
# since version 2.2.0 using Fatdog64-710 alpha mdview 2016.04.26 - which includes my patches.

# Required script settings {{{1
# Output file name
FPOT=findnrun.new.pot
# Firstly $XSRC source file is scanned for msgids with xgettext $XOPT
XSRC=../../../../bin/findnrun
XOPT="-ci18n -L Shell"
# Then $XTBL source file is scanned for msgids with $XXGT
XTBL=../../../../share/findnrun/i18n_table.sh
XXGT=./xgettext.sh
XXGTOPT="-- -ci18n -L Shell"
# Multiple files in list_md_files() are scanned for msgids with mdview --po {{{2
list_md_files()
{
  local d=../../../../share/doc/findnrun
  set +f
  printf "%s\n" "$d/"*.md "$D/../examples/"*/*.md
}

# A file failing is_to_be_translated() isn't even scanned {{{2
is_to_be_translated() # $1-filepath
{
  case $f in
    */TRANSLATING.md)
      : $f targets translators - they need English doc only
      ;;
    # $f Debian info is again maintained since version 3.0.0
    # */DEBIAN.md)
    #   : $f Debian package is not maintained since version 2.0.0
    #   ;;
    */plugin-debugging.md|*/plugin-dev.md|*/plugin-examples.md)
      : $f targets developers - they prefer English doc anyway
      # but plugin.md and plugin-list.md are to be translated
      ;;
    */no-help.md)
      : $f is obsolete
      ;;
    */examples/*)
      : $f not now - maybe to be translated in a future release
      ;;
    */LICENSE.md)
      : we keep $f in English as GNU GPL does not endorse translations
      ;;
    *) # translate all other files
      : $f target end users - translate it
      return 0
      ;;
  esac
  return 1
}

# Required project header settings {{{1
PACKAGE_VERSION="4.0.0"
PACKAGE_NAME="find-n-run"
PACKAGE_TITLE="Findnrun $PACKAGE_VERSION"
PACKAGE_COPYRIGHT="2015-2019 step; 2015 SFR, L18L, step"
PACKAGE_FIRST_POT_AUTHOR="step, https://github.com/step-/"
PACKAGE_POT_CREATION_TZ="UTC"
PACKAGE_POT_LANGUAGE="en"
PACKAGE_CHARSET="UTF-8"
PACKAGE_POT_BUGS_ADDRESS="https://github.com/step-/find-n-run/issues/"

__notes_on_pot_file() # {{{1
{
  echo '
#. Example of Plural-Forms value valid for English; adapt for your language:
#.   "Plural-Forms: nplurals=2; plural=(n != 1);\n"
#.
#. =======================================================================
#. i18n User documentation in markdown format from .md files follows.
#. i18n IMPORTANT! Reproduce indentation and special punctuation exactly.
#. =======================================================================
#.
'
}


__notes_on_file_LICENSE() #{{{1 # is excluded from the pot file
{
  echo "
#. i18n File LICENSE.md is a special case. Do not to translate it. Instead
#. i18n find a translation from http://www.gnu.org/licenses/translations.html
#. i18n and use that translated text here.
#.
"
}

__notes_on_file_preference() # {{{1
{
  echo "
#. i18n File 'preference.md' includes markdown CODE BLOCKS, for which
#. i18n you need to translate the shell comments that the blocks include.
#. i18n The comments explain which function each setting performs.
#. i18n INSIDE each code block you will translate the COMMENT lines
#. i18n located above each variable assignment.
#. i18n Make sure to reproduce the comment '#' hash character in place.
#. i18n When the source text includes MULTIPLE-LINE shell comments each line
#. i18n is presented for translation as a separate msgid, which can be
#. i18n initially confusing. Look at the source file to understand over
#. i18n which set of msgids the shell comment spreads. Your translation
#. i18n needs to spread over the same set exactly. You may choose to format
#. i18n your comment differently from the source, for example to even out
#. i18n line lengths. Make sure to keep the same set of msgids and the '#'
#. i18n hash character at the beginning of each translated msgstr.
#. i18n Do NOT translate VARIABLE names or variable assignments.
#. i18n And, as usual, translate all text outside the code blocks.
#.
"
}

