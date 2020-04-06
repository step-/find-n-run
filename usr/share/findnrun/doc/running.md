_Next: [Configuring Preferences](preference.md)_

## Starting Findnrun

### Desktop Menu

Findnrun's application icon is found in the 'File System' category of
your desktop menu.

### Global Hotkey

You may find convenient to start findnrun with a global hotkey. For
instance, on Fatdog64-701 Linux pressing Alt-F3 anywhere on the desktop
starts findnrun.

### First Run

The first time findnrun starts it creates its configuration file
`.findnrunrc` in your home directory, then displays the list of
desktop applications, and the status bar shows that "application
finder" is the current view. Press [F3] to change the view to "shell
completion", the list of shell commands. Press [Ctrl+1] to switch back
to "application finder". Click the exit icon to close findnrun.

### Command-Line Options

`--geometry=WxH+X+Y`

  Set window Width`x`Heigth and top-left corner position.
  You may omit `WxH` or `+X+Y`.

`--perm=PERMISSIONS`

  Set PERMISSIONS of the _temporary directory_ with the `chown` command.
  By default the directory is accessible only to the file owner (700).
  If you need to set less-restrictive permissions:

    findnrun --perm=755 # Now everyone can read temporary files.

`--stdout`

  Display gtkdialog's standard output, which would otherwise not be shown.
  This option is mostly of interest to developers and advanced users.

`--`

  If you need to pass advanced options to gtkdialog, like perhaps
  which X display to use, you need to pass them on the command-line
  after a `--` stop marker. Anything following `--` will be passed
  to gtkdialog without further inspection. Be vary that some options
  you pass could conflict with the way findnrun sets up gtkdialog
  for use. Be also aware that in some cases you might also need to
  specify option `--stdout`:

    findnrun --geometry= -- --center
    findnrun -- --display=DISPLAY
    findnrun --stdout -- --version

## Alternate Configuration File

Specify an alternate configuration file as an environment variable:

    env CONFIG=/path/to/alternate-findnrunrc findnrun

## Environment Variables

**Standard variables**

Many Linux versions pre-define some of these variables in system
initialization files.

`BROWSER`

  _The HTML version of the Help file has been discontinued after version
  1.10.6_

  If the HTML Help file is installed but it does not open - or it opens
  in a text editor - try setting `BROWSER` to your preferred web
  browser.  `BROWSER` can be set either as an environment variable or as
  a configuration preference.

    env BROWSER=firefox findnrun

`LANG`

  If a translation file for your local language is installed but you
  see English messages, you need to properly configure your system
  locale.  Findnrun honors the language code that the environment
  variable `LANG` displays.

    echo $LANG

  See also `LANGUAGE` in the [translation tutorial](TRANSLATING.md).

**Specific findnrun variables**

`CONFIG`

  Alternate path to the configuration file.
  Default value: `$HOME/.findnrunrc`.

    env CONFIG=/path/to/alternate-findnrunrc findnrun

`GEOMETRY`

  Window geometry can be set as an environment variable, as a
  configuration preference, and as a command-line option - in increasing
  order of precedence.

    env GEOMETRY=500x200+100+100 findnrun

`RDR`

  Advanced setting for the save filter function. See RDR in [user preferences](preference.md).

`FNRDEBUG`

  Debugging aid for plugin developers and bug reports.

`FNRMDVIEW`

  Alternate path to the mdview markdown viewer. Findnrun
  opens its help files with `FNRMDVIEW`. Default value: "mdview".

    env FNRMDVIEW=/usr/bin/geany findnrun

  See more examples in the [translation tutorial](TRANSLATING.md).

`FNRSEARCHENGINE`

  See section _[Fzf Search Engine](fzf.md)_ for details.
  To use the older, built-in search engine set this variable to value "v1":

    env FNRSEARCHENGINE=v1 findnrun
  
  Or set it in your [configuration file](preference.md), which takes precedence
  over the environment value.

_Next: [Configuring Preferences](preference.md)_

