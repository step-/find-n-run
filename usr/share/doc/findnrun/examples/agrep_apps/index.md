## Approximate Desktop Application Search

with findnrun and agrep.

Add features to the standard application search window:

 * Approximate (fuzzy) search (including regex, if enabled)
 * Sort output by error tolerance

### Requirements and Installation

 * Copy file [source-me.sh](source-me.sh) to your home folder
   - [alternative location](examples/agrep_apps/source-me.sh).
 * Requirement: Install command `agrep`, which is found in package
   'tre 0.8.0' - 
   [Download links](https://github.com/step-/find-n-run/releases/2.2.0)
   for 32- and 64-bit pet and txz packages.
 * Edit file `~/.findnrunrc` and **APPEND** two lines; one line sources
   this file and another line adds the new plugin source to SOURCES:
```
    . "$HOME/source-me.sh"
    SOURCES='agrep_apps FNRstart FNRsc' # <<< REVIEW AND CHANGE IF NECESSARY
    # Note that SOURCES must include 'FNRstart'
```

 * Start findnrun. Now the 'approximate application finder' handles your
   searches.  You may press Ctrl+2 to use the standard 'application finder'.

### Settings

By default approximate searching matches application names only and
ignores letter-casing.  Findnrun user preferences `SEARCHFILENAMES`,
`SEARCHCOMMENTS`, `SEARCHCATEGORIES`, `SEARCHCOMPLETE`, and
`CASEDEPENDENT` apply.

### Matching

When this plugin is active the findnrun search input field uses
agrep-style syntax to match each record fuzzily. Syntax rules are
outlined below. See also: agrep(1), `man agrep`.

### Error Tolerance

By default fuzzy search tolerates one error - one missing or one extra
or one substituted character.  If the search expression starts with
'-[0-9] ' (mind the space) or ends with ' -[0-9]' (space) then tolerance
is set to the given number between 0 and 9.

 * Note: `-#` is a findnrun extension to agrep syntax.

### Regular Expression Matching

By default the fuzzy search term is matched literally. If file
`~/.findnrun` sets `REGEXSEARCH=true` then the fuzzy search term is
interpreted as a TRE regular expression. Then you can apply standard
regex operators to combine multiple search terms, negate matches, etc.

If the search expression starts with '-x ' or ends with ' -x' then regex
search is enabled on-the-fly. Likewise '-X ' and ' -X' disable regex search.

Example: search for 'audio' OR 'office' assuming `REGEXSEARCH=false`:
```
    audio | office -x
```

### Saving Results

You can save search results by pressing hotkey F4. This is the same save
function that the built-in application search uses. See 'RDR' in the
_Configuring Preferences_ section of the main help file.

### Translations

Source title and messages can be localized by installing a suitable
.mo file, findnrun-plugin-agrep\_apps.mo.

### Version

See file [source-me.sh](source-me.sh) for version information.
