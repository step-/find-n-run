# Efficient way to structure a translation table.
i18n_table() # {{{1
{
# Notes for translators:
# 1. Apparently the standard xgettext utility doesn't know how to extract
#    strings from calls to 'gettext -es'. Therefore the .pot template is
#    generated with the help of usr/share/doc/findnrun/xgettext.sh.
# 2. From this point on:
#    A. Never use \n inside your msgstr. For yad and gtkdialog dialog \r can
#       replace \n.
#    B. Always end your msgstr with \n.
#    C. Replace trailing spaces (hex 20) with non-breaking spaces (hex A0).
#
  {
    read i18n_Findnrun
    read i18n_application_finder
    read i18n_shell_completion
    read i18n_fatal_source_error
    read i18n_recoverable_source_error
    read i18n_source_warning
    read i18n_Invalid_source_plugins
    read i18n_SHOWNODISPLAY_false_excludes
    read i18n_filename_Icon_not_found
    read i18n_analyzing_applications
    read i18n_Help
    read i18n_gui_about
    read i18n_application_found
    read i18n_applications_found
    read i18n_source_loaded
    read i18n_sources_loaded
    read i18n_OK
    read i18n_invalid_SAVEFLT_redirection
    read i18n_ctrl_digit
    read i18n_boxed_string
    read i18n_Click_the_status_bar
    read i18n_Restart_Findnrun
    read i18n_Press_ENTER_to_select
    read i18n_Type_some_letters
    read i18n_Clear_entry
    read i18n_Press_ENTER_or_double_click
    read i18n_Press_the_Down_Arrow_key
    read i18n_Press_Down_Arrow
    read i18n_Remove_entry_from_history
    read i18n_Comment_about_current_item
    read i18n_More
    read i18n_Keep_this_window_open
    read i18n_Keep_window
    read i18n_Display_all_available_icons
    read i18n_Show_all_icons
    read i18n_Return_the_keyboard_focus
    read i18n_Focus_search
    read i18n_About_and_help
    read i18n_Exit
    read i18n_Click_to_hide
    read i18n_Show_hidden_system_applications
    read i18n_Show_hidden
    read i18n_Search_in_application_names_etc
    read i18n_Search_complete
    read i18n_Interpret_search_as_BRE
    read i18n_Regex
    read i18n_Edit_configuration_file
    read i18n_When_you_are_finished
    read i18n_application_finder_options
    read i18n_desktop_Name
    read i18n_desktop_Comment
  } << EOF
  $(gettext -es -- \
  "Findnrun\n" \
  "application finder\n" \
  "shell completion\n" \
  "fatal source error: %d%s\n" \
  "recoverable source error: %d%s\n" \
  "source warning: %d%s\n" \
  "Invalid source plugins found and disabled:\r%s\n" \
  "SHOWNODISPLAY false excludes file '%s'\n" \
  "filename '%s': Icon '%s' not found.\n" \
  "analyzing %d applications...\n" \
  "_Help\n" \
  "%s %s\rauthors: %s\rOpen source - GNU GPL license applies\r\r%s\r%s\r\rconfiguration: %s\r\n" \
  "%s application found\n" \
  "%s applications found\n" \
  "%s source loaded\n" \
  "%s sources loaded\n" \
  "_OK\n" \
  "%s: invalid SAVEFLT redirection '%s'\n" \
  "[ctrl+%d]\n" \
  "[%s]\n" \
  "Click the status bar or press a hotkey to activate the next source.\r%s\r%s\n" \
  "Restart Findnrun?\n" \
  "Press ENTER to select\n" \
  "Type some letters to refine the list\n" \
  "Clear entry\n" \
  "Press ENTER or double-click to run the selected item\n" \
  "Press the Down Arrow key to grab the selected item and move through the history list. You can edit the grabbed entry. History persists while the program is running. History is cleared on exit.\n" \
  "Press Down Arrow to grab selected item\n" \
  "Remove entry from history\n" \
  "Comment about current item\n" \
  "More...\n" \
  "Keep this window open after activating an item. Keep the window open to use the history feature, or to avoid startup delays.\n" \
  "_Keep window\n" \
  "Display all available icons instead of displaying just the icons that do not need to be cached. Caching all icons may take some time. Disabling this option clears the existing cache.\n" \
  "_Show all icons\n" \
  "Return the keyboard focus to the search input field after activating an item instead of keeping the keyboard focus on the activated list item.\n" \
  "_Focus search\n" \
  "About and help\n" \
  "Exit\n" \
  "Click to hide.\n" \
  "Show also hidden system applications.\n" \
  "Show _hidden\n" \
  "Search in application names, file names, command lines, comments and categories all at once.\n" \
  "Search _complete\n" \
  "Interpret the search pattern as a POSIX Basic regular expression.\n" \
  "_Regex\n" \
  "Edit configuration file directly. Restart required for changes to take effect.*\n" \
  "When you are finished making your changes come back to this window and restart findnrun.\n" \
  "application finder options       * = restart required\n" \
  "Findnrun.\n" \
  "Find applications and much more.\n" \
  )
EOF
}

