## Debugging Plugins

Your plugin can print debugging messages to the standard error
stream. Do not write to the standard output stream, which is reserved
for tap-records.

Findnrun validates source plugin declarations in various ways. On fatal
errors findnrun prints the offending subject's id, when it is known,
to the standard error strem, and exits with an error exit status. On
recoverable errors, findnrun prints the offending source's id and a
warning code to the standard error stream, disables the source, and
continues. On warnings findnrun prints a warning code to the standard
error stream and continues.
```
    FATAL ERROR EXIT CODES 1-99
    currently none
    -
    RECOVERABLE ERROR CODES 101-199
    101 source-id isn't a valid shell variable name (SOURCES=)
    102 null tap-command
    103 invalid tap-command sh syntax
    104 invalid drain-command sh syntax
    -
    WARNING CODES 201-299
    currently none
```

Use `FNRDEBUG=<level> findnrun` to run findnrun in debugging
mode. Levels 1-9 enable increasingly verbose debugging messages to the
standard error stream. Level 10 dumps the gtkdialog definition to the
standard output stream and exits.  `FNRDEBUG` is exported to plugins.

