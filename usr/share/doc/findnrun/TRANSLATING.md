## Translations

I will gladly add contributed translations to this git repository if
translators send them to me. Generate a Github pull request or attach your
contributed files (see below) to the forum thread.

### Instructions

 * Start from the pre-generated GNU gettext Portable Object format
   template file `usr/share/doc/nls/findnrun/findnrun.pot`
 * Generate a new `.po` file for your local language from the `.pot` file
 * Edit and translate the `.po` file
 * Convert the translated `.po` file to `.mo` format
 * Install the `.mo` file
 * Test your translation including the About dialog; to open the About
   dialog click the star icon in the find-n-run main window
 * Send the `.po` and `.mo` files to me for inclusion in this repository.

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

**Νote 1:** Test all main window _and about dialog_ elements. Before testing you should set the system locale to the translation language. If for some reason you can't set the system locale, you might try faking language setup by running these shell commands (replace all occurrences of `de` with the language code that you are testing):

    # Start at the top directory of this git repository.
    cd find-n-run
    # Temporarily link message catalog file
    test -d /usr/share/locale/de || ln -s `pwd`/usr/share/locale/de /usr/share/locale/de
    test -e /usr/share/locale/de/LC_MESSAGES/findnrun.mo || ln -s `pwd`/usr/share/locale/de/LC_MESSAGES/findnun.mo /usr/share/locale/de/LC_MESSAGES/findnrun.mo
    # Set LANGUAGE (or LANG) to the FULL language locale
    env LANGUAGE=de_DE.UTF-8 usr/bin/findnrun --geometry=
    # Clean up temporary links
    test -L /usr/share/local/de && rm /usr/share/local/de
    test -L /usr/share/local/de/LC_MESSAGES/findnrun.mo && rm /usr/share/local/de/LC_MESSAGES/findnrun.mo

**Note 2:** If at all possible, please generate a Github pull request for your contribution. Otherwise attach the two files to the project forum thread - see [README](README.md) for URL info.

### Desktop file

Finally open file `usr/share/applications/findnrun.desktop` and check whether
a translated _Comment field_ already exists for your language. If not,
please make one and send it to me via the mechanisms noted above.

**example for Spanish**

    Comment=Find and run apps very quickly
    Comment[es]=Buscar y ejecutar aplicaciones rápidamente

