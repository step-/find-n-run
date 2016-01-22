## Starting findnrun

### Desktop Menu

Findnrun's application icon is found in the 'File System' category of
your desktop menu.

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
  you pass could conflict with the way `findnrun` sets up gtkdialog
  for use. Be also aware that in some cases you might also need to
  specify option `--stdout`:

    findnrun --geometry= -- --center
    findnrun -- --display=DISPLAY
    findnrun --stdout -- --version

## Alternative Configuration File

Specify an alternative configuration file as an environment variable:
```
    env CONFIG=/path/to/findnrunrc-alternative findnrun
```

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
  locale.  Find-n-run honors the system locale code that environment
  variable `LANG` displays.

    echo $LANG

**Non-standard variables**

`GEOMETRY`

  Window geometry can be set as an environment variable, as a
  configuration preference, and as a command-line option - in increasing
  order of precedence.

    env GEOMETRY=500x200+100+100 findnrun

