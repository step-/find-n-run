## Translations Demystified

You can be a translator too! No magic involved. This page includes
a tutorial that attempts to demistify the Linux translation
toolset. You will learn to create a full translation using just your
favorite text editor and some shell commands, that's all. You could
use specialized translation tools instead, but really it isn't
necessary.

I will add contributed translations to the project repository.
Preferably send me your contribution as a GitHub pull request.
Alternatively, attach your contributed files to the forum thread.
I ask for both the source and the compiled files (.po and .mo)
because findnrun is an open source project.  Thank you.

Findnrun is prepared for translation with the GNU Gettext toolset.
Message catalogs are kept separated into multiple text domains, which
are named:

 * "findnrun" for the required base functionality
 * "findnrun-plugin-PLUGIN-ID" for each contributed [plugin](plugin.md),
   where _PLUGIN-ID_ stands for the unique identifier of a plugin.

### Adding a New Translation

Process overview.  For step-by-step instructions refer to section
_Tutorial_.

 * Download and unpack the 'mdview' archive attached to the
   [release page](https://github.com/step-/find-n-run/releases).
   This custom version of mdview includes bug fixes that enable full
   support for translating findnrun
 * Download and install the latest findnrun NLS package
 * Initialize a new translation file `findnrun.po` from the template
   file `findnrun.pot`.  File extension `po` stands for GNU gettext
   Portable Object format, and `pot` for `po` Template
 * Edit and translate the `po` file - you can use your favorite text
   editor, or a specialized `po` editing application, such as poedit
 * Convert the translated `po` file to `mo` format - you can use shell
   command `msgfmt`, or a specialized application
 * Install `mo` and `po` files for testing[1]
 * Run findnrun to test[2] your translation
 * Run the custom mdview[3] to test your translation of markdown files
 * Send me `mo` **and `po`** files for inclusion in the repository.[3]

[1] Place `mo` **and `po`** files in
   `/usr/share/locale/<language>/LC_MESSAGES/`, where `<language>` is the
   _language code_ for your language, i.e., 'de' for German, 'fr' for
   French, 'pt\_BR' for Brasilian Portuguese, and so on.

[2] Before you can test effectively you might need to prepare your
   system. Refer to the _Tutorial_.

[3] I ask for `mo` **and `po`** files because Findnrun is an open
   source project.
   For GitHub pull requests you need to create a relative path that
   corresponds to the full path indicated in note [1] above, and add the
   path you created to your pull request.

### Updating an Existing Translation

Process overview.  For step-by-step instructions refer to section
_Tutorial_.

 * Download and install archives as explained in section _Adding a New
   Translation._
 * Update the existing translation `findnrun.po` from the template file
 * Edit and translate the updated `po` file
 * Convert the translated `po` file to `mo` format
 * Install and test as described in _Adding a New Translation_
 * Send me the updated `po` **and `mo`** files.[3]

### Tutorial

This tutorial uses German (language code = de).  Substitute the language
and full locale codes for your own case.

* Download and unpack the 'mdview' archive attached to the
  [release page](https://github.com/step-/find-n-run/releases).
* Download and install the latest findnrun NLS package.
* Open a terminal window
```
# Create relative folder structure for your locale.
mkdir -p /usr/share/locale/de/LC_MESSAGES
cd /usr/share/locale/de/LC_MESSAGES

# Backup current .po and .mo files, if they exist
cp -i findnrun.po findnrun-old.po
cp -i findnrun.mo findnrun-old.mo

# [A] For new translations: generate a new .po file
# [B] For existing translations: merge updates into the existing .po file

## Either do case [A]
msginit -i /usr/share/doc/nls/findnrun/findnrun.pot -o findnrun.po --locale=de --no-wrap

## or case [B]
msgmerge -U findnrun.po /usr/share/doc/nls/findnrun/findnrun.pot
```

Now edit and translate `findnrun.po` with your favorite text editor or
a specialized application, such as poedit.
You translate each 'msgid' string into its corresponding 'msgstr' string.
For case [B] label 'fuzzy' marks new/updated entries.
Don't forget to fill in/update the initial information block.

Then generate the new .mo file
```
msgfmt -o findnrun.mo findnrun.po
```

Now start findnrun to test your translation of windows and dialogs. First, you need to
set your system language to the translation language. This requires
rebooting.  If for some reason you can't reboot, you can try _faking_
proper language setup when you start findnrun; sometimes it's enough:
```
cd /usr/share/locale/de/LC_MESSAGES

# Faking proper system language setup:
# set LANGUAGE to the FULL language locale
env LANGUAGE=de_DE.UTF-8 /usr/bin/findnrun --geometry=
```

On Fatdog64-702, for example, setting `LANGUAGE` is enough for findnrun
to be able to display a translated GUI.  However, it isn't sufficient
for findnrun to also display translated application comments, which many
`.desktop` files include. Note that your translation doesn't involve
such comments, so you need not worry about them. Just be wary that you
might see untranslated data **inside** the comment field in the main
window.

----

_Optional: To view translated application comments you need to set
the system locale code properly by following the exact procedure of
your Linux variant.  For instance, the steps for Fatdog64-702 Linux
involve installing the system NLS SFS, dropping to the system console,
setting the locale code and variables, and finally restarting X:_
```
# First download fd64-nls_702.sfs with the SFS manager
load_sfs.sh --load /path/to/fd64-nls_701.sfs # load SFS

/usr/sbin/fatdog-choose-locale.sh # choose, i.e., German for Germany

# Close all windows and press Ctrl+Alt+BackSpace

LANG=de_DE.UTF-8; export LANG # German for Germany
LANGUAGE=$LANG; export LANGUAGE

xwin # restart X with German for Germany as a back-end.
```

_Findnrun looks at environment variable `LANG` to determine the
locale code of `.desktop` file comments. Start a terminal and type:_
```
echo $LANG # It should match German for Germany
```

_End of optional paragraph._

----

To complete testing findnrun's GUI make sure to open all sub-dialogs
(click the start icon) and tooltips (hover your mouse pointer over all
fields).

Next step: test help messages. You should have already downloaded the
custom mdview archive from the download page. Go to the folder where you
unpacked mdview. We are going to use the 'fake language code' trick:
```
# Faking proper system language setup:
# set LANGUAGE to the FULL language locale
env LANGUAGE=de_DE.UTF-8 ./mdview '/usr/share/locale/<language>/LC_MESSAGES/index.md'
```
Now you should see findnrun's help index in your language. Follow all
links though all pages to ensure you didn't miss sections that you want
translated. For more information about findnrun's help system you can
read section _Help Documents_ further down.

If you need to change your translation, go back to the step that
involves editing file findnrun.po and keep working through this tutorial
again. When you are satisfied with your work send me the new .mo and
.po files. Preferably generate a GitHub pull request for your files.
Otherwise attach them to the project
[forum thread](https://github.com/step-/find-n-run/blob/master/usr/share/doc/findnrun/index.md#links).

### Desktop File

Open file `/usr/share/applications/findnrun.desktop` and check whether
translations into your language already exist for fields `Comment` and
`Name` If not, send the translated fields to me via one of the
mechanisms noted above.  Translating at least the `Comment` field is
recommended.

**example for Spanish**
```
Name=Findnrun
Name[es]=Buscar y ejecutar
Comment=Find applications and more
Comment[es]=Buscar aplicaciones y más
```

### Plugins

Each [plugin](plugin.md) has its own `mo` file in
`/usr/share/doc/nls/findnrun/`.
The file name must be "findnrun-plugin-PLUGIN-ID.mo", where _PLUGIN-ID_
stands for the unique identifier of the plugin.

As a minimum translators should add a translation for the plugin title
defined with `TITLE_`_PLUGIN-ID_=... in the plugin installation section
of file `~/.findnrunrc`. Translators can retrieve plugin installation
information (PLUGIN-ID, title, etc.) from the plugin developer.

Plugin source code files may include other GetText resources to be
translated in the same `mo` file. A plugin developer may optionally
provide a corresponding `po` file to ease up the translator's task.

### Help Documents

Since version 2.0.0 findnrun's help system is based on markdown code
only, and it is translated as part of the main window translation as
GetText 'msgstr' strings.  The `pot` template includes source
file locations and comments that help you identify when you are dealing
with markdown codes as opposed to GUI text.

Pay attention that markdown output formatting is controlled by the
relative position and indentation of text lines and a few special
characters. Try to identify such elements in the `pot` template and
reproduce them verbatim in your translation of the surrounding
text. Markdown isn't standardized, so different dialect provide
different capabilities. For findnrun you must stick to the markdown
syntax and `%%` directives that
[mdview](http://chiselapp.com/user/jamesbond/repository/mdview3/index)
supports.

### Thank You

I am committed to enabling software localization. I appreciate very much
your help in building up an array of language translations for findnrun.
Thank you.

