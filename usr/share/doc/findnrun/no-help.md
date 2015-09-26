## Can't open the Help file?

* If the **Help file** isn't installed, consider downloading and
  installing the findnrun-doc sub-package for your platform.

* If the **Help file** is installed but it does not open - or it opens
  in a text editor - try setting `BROWSER` to your preferred web
  browser.  `BROWSER` can be set either as an environment variable or as
  a configuration preference.

    env BROWSER=firefox findnrun

* If a translation file for your local language is installed but you
  see English messages, you need to properly configure your system
  locale.  Find-n-run honors the system locale code that environment
  variable `LANG` displays.

    echo $LANG

[Proceed to the Help file](index.md)

