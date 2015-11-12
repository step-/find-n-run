## Translations

I will gladly add contributed translations to this git repository if
translators send them to me. Generate a Github pull request or attach your
contributed files (see below) to the forum thread.

Findnrun source code is prepared for translation with GNU Gettext.  Message catalogs are kept separated into multiple text domains (files):

 * "findnrun" for the required base functionality
 * "findnrun-plugin-PLUGIN-ID" for each contributed [plugin](plugin.md), where PLUGIN-ID stands for the actual plugin unique identifier.

### Instructions for base functionality

 * Start from the pre-generated GNU gettext Portable Object format
   template file `usr/share/doc/nls/findnrun/findnrun.pot`
 * Generate a new `.po` file for your local language from the `.pot` file
 * Edit and translate the `.po` file
 * Convert the translated `.po` file to `.mo` format
 * Install the `.mo` file
 * Test your translation including the About dialog; to open the About
   dialog click the star icon in the find-n-run main window
 * Send me the `.po` and `.mo` files for inclusion in this repository.

**Note:** Place `.po` and `.mo` files in
`usr/share/locale/<language>/LC_MESSAGES/findnrun.po`, where `<language>` is
the _language code_ for your language, i.e., 'de' for German, 'fr' for French,
'ru' for Russian, 'pt\_BR' for Brasilian Portuguese, and so on. The _language code_ is part of the system _locale_, which includes additional regional settings.

### Full example for German

    # Start at the top directory of this git repository.
    cd find-n-run

    # Create relative folder structure for your locale.
    mkdir -p usr/share/locale/de/LC_MESSAGES

    # Generate a new .po file from the .pot template file.
    cd usr/share/locale/de/LC_MESSAGES
    msginit -i ../../../doc/nls/findnrun/findnrun.pot -o findnrun.po --locale=de --no-wrap

    # Now edit and translate findnrun.po...

    # Then generate the .mo file.
    msgfmt -o findnrun.mo findnrun.po
    # Temporarily install the .mo file in the message catalog.
    mkdir -p /usr/share/locale/de/LC_MESSAGES
    ln -s `pwd`/findnrun.mo /usr/share/locale/de/LC_MESSAGES/findnrun.mo

    # Now test the .mo file... (Note 1)
    # Then send .mo and .po files for inclusion in this repository (Note 2)

**Νote 1:** Test all main window _and about dialog_ elements. Before testing you should set the system locale code to the translation language. If for some reason you can't set the system locale, you might try _faking_ proper language setup by running these shell commands (replace all occurrences of `de` with the language code that you are testing):

    # Start at the top directory of this git repository.
    cd find-n-run
    # Temporarily link message catalog file
    test -d /usr/share/locale/de || ln -s `pwd`/usr/share/locale/de /usr/share/locale/de
    test -e /usr/share/locale/de/LC_MESSAGES/findnrun.mo || ln -s `pwd`/usr/share/locale/de/LC_MESSAGES/findnrun.mo /usr/share/locale/de/LC_MESSAGES/findnrun.mo
    # Set LANGUAGE to the FULL language locale
    env LANGUAGE=de_DE.UTF-8 usr/bin/findnrun --geometry=
    # Clean up temporary links
    test -L /usr/share/locale/de && rm /usr/share/locale/de
    test -L /usr/share/locale/de/LC_MESSAGES/findnrun.mo && rm /usr/share/locale/de/LC_MESSAGES/findnrun.mo

These settings should be enough for `findnrun` to show translated
messages.  However, they are not sufficient for `findnrun` to also
display translated application comments. (Translated comments are
included in many `.desktop` files). To also be able to view translated
comments you do need to set the system locale code _properly_ by
following the exact procedure of your Linux variant. For instance, the
steps for Fatdog64 Linux involve installing the NLS SFS, dropping to
the console, setting the locale code and variables, and restarting X:

    # First download fd64-nls_701.sfs with the SFS manager
    load_sfs.sh --load /path/to/fd64-nls_701.sfs # load SFS
    /usr/sbin/fatdog-choose-locale.sh # choose, i.e., German for Germany
    # Close all windows and press Ctrl+Alt+BackSpace
    LANG=de_DE.UTF-8; export LANG # German for Germany
    LANGUAGE=$LANG; export LANGUAGE
    xwin # restart X with German for Germany as a back-end.

`findnrun` looks at environment variable `LANG` to determine the
locale code of `.desktop` file comments. Start a terminal and type:

    echo $LANG # It should match German for Germany

**Note 2:** If at all possible, please generate a Github pull request for your contribution. Otherwise attach the two files to the project forum thread - see [README](README.md) for URL info.

### Desktop file

Open file `usr/share/applications/findnrun.desktop` and check whether
translations into your language already exist for fields `Comment` and
`Name` If not, send the translated fields to me via one of the
mechanisms noted above.  Translating at least the `Comment` field is
recommended.

**example for Spanish**

    Name=Find'N'Run
    Name[es]=Buscar y ejecutar
    Comment=Find and run apps very quickly
    Comment[es]=Buscar y ejecutar aplicaciones muy rápidamente

### Plugins

Each [plugin](plugin.md) has its own `.mo` file, which can be translated
following steps analogous to the ones given in section _Instructions for
base functionality_.

### Help files

The documents that you are reading online are also included in `findnrun`
as run-time help files. The help sub-system can display HTML documents
and markdown documents (using
[mdview](http://chiselapp.com/user/jamesbond/repository/mdview3/index)).
HTML is preferred because the browser is ubiquitous while mdview isn't.

To translate the help files you can either start from the markdown
source, or directly from the HTML source. Markdown should be preferred
in most cases because it is easier than HTML, and because you will start
from the most up-to-date English source files. I imagine HTML would be
preferred if your language had very special layout needs that HTML only
can provide.  Another reason to prefer HTML vs. markdown is that with
HTML your testing cycle will be shorter, because you will not have to
depend on me to convert markdown to HTML (see instructions [A]).  So,
as a translator of the Help documentation you need to first decide your
English source file format: markdown vs. HTML, then proceed as follows.

**[A] Instructions for markdown**

The set of English markdown source files is located on github
[here](https://github.com/step-/find-n-run/tree/master/usr/share/doc/findnrun).

 * Translate all `.md` files found in the on-line folder.
 * Pack all translated files into a `.tar.gz` archive named after your
   locale code, i.e. `markdown[de_DE.UTF-8].tar.gz` for German in Germany.
 * Send me the archive via one of the mechanisms noted above.
 * I will generate an HTML archive and push it to Github with the expectation
   that you will **test the HTML archive** and correct translation and layout
   issues by submitting new `.md` files until all issues are closed.

**Note on markdown syntax**

Avoid being too creative with your markdown syntax. Keep it
simple.  While the publishing process supports [Markdown
Extra](http://en.wikipedia.org/wiki/Markdown_Extra) I recommend that you
stick to the much more limited, but effective, markdown syntax that
[mdview](http://chiselapp.com/user/jamesbond/repository/mdview3/index)
supports. All `.md` files in this project follow this guideline.

**[B] Instructions for HTML**

If you prefer HTML to markdown, then the set of English markdown source
files is archived on github as a `tar.gz` file
[here](https://github.com/step-/find-n-run/tree/master/usr/share/doc/findnrun).

 * Download the latest version of `help[en].tar.gz`, which has full
   locale code en_US.UTF-8.
 * Unpack it in a local folder; translate all `.html` files.
 * Pack all translated files into a `.tar.gz` archive named after your
   locale code, i.e. `html[de_DE.UTF-8].tar.gz` for German in Germany.
 * You should **test your archive** before sending it to me. Follow these
   steps (example for German):
```
    cd "/path/to/dir/containing/" # html[de_DE.UFT-8].tar.gz
    mkdir -p /usr/share/doc/findnrun # it should already exist
    ln -fs "`pwd`/html[de_DE.UFT-8].tar.gz" "/usr/share/doc/findnrun/help[de].tar.gz"
    env LANG=de_DE.UTF-8 findnrun # assumes proper system locale settings
```
 * Send me the archive via one of the mechanisms noted above.
 * I will publish the HTML archive on Github as an official update.

### Thank you

I am committed to enabling software localization. I believe it is
important in widening the adoption of Linux, and it is respectful of
other cultures. Your help in providing an array of language translations
is very much appreciated.  Thank you.

