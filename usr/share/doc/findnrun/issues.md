## Reporting Bugs

Please file bugs against this script in the issues section of the
[github repository](https://github.com/step-/find-n-run/issues) _and not
in the Puppy Linux forum thread_. You do need a github free accont to
file new issues.

## Known Issues and Limitations

 * Freedesktop.org's
   [icon theme](http://standards.freedesktop.org/icon-theme-spec)
   support isn't implemented. This means that if multiple
   icon themes are installed _findnrun_ will apply the first icon found
   in alphabetical order.
   You can work around this limitation by setting hidden user preference
   `ICON_DIRS`.
 * Prioritized language preferences via environment variable `LANGUAGE`
   are not supported. Findnrun honors the system locale code that
   environment variable `LANG` displays - when a matching translation
   file is installed.
 * Findnrun does not include the additional ROX-Filer application that
   the earlier Find'N'Run project has.

