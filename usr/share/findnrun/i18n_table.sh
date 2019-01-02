# Efficient way to structure a translation table.
i18n_table() # {{{1
{
# Notes for translators:
# 1. Apparently the standard xgettext utility doesn't know how to extract
#    strings from calls to 'gettext -es'. Therefore the .pot template is
#    generated with the help of usr/share/doc/findnrun/xgettext.sh.
# 2. From this point on:
#    A. Never use \n **inside** a msgstr. For yad and gtkdialog you can replace
#    \n with \r.
#    B. However, always **end** your msgstr with \n.
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
    read i18n_search_engine
    read i18n_builtin
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
    read i18n_Fuzzy
    read i18n_Keep_this_window_open
    read i18n_Keep_window
    read i18n_Display_all_available_icons
    read i18n_Show_all_icons
    read i18n_Icons
    read i18n_Return_the_keyboard_focus
    read i18n_Focus_search
    read i18n_About_and_help
    read i18n_Exit
    read i18n_Less
    read i18n_Show_hidden_system_applications
    read i18n_Show_hidden
    read i18n_Search_in_application_names_etc
    read i18n_Search_complete
    read i18n_mnu_Search_Regex
    read i18n_mnu_tt_Search_Regex
    read i18n_mnu_tt_Fuzzy_ignores_this
    read i18n_Edit_configuration_file
    read i18n_When_you_are_finished
    read i18n_application_finder_options
    read i18n_desktop_Name
    read i18n_desktop_Comment
    read i18n_Key_Enter_to_close_terminal
    read i18n_Run_command_in_terminal
    read i18n_info # printf "\u2139"
    read i18n_MenuKey
    read i18n_hotkeys
    read i18n_previous_results_page
    read i18n_next_results_page
    read i18n_run_top_selected_result
    read i18n_run_top_selected_result_in_terminal
    read i18n_save_search_results
    read i18n_quit
    read i18n_show_help
    read i18n_cycle_through_input_fields
    read i18n_cycle_through_search_sources
    read i18n_clear_search_input
    read i18n_Search_results_saved_as
    read i18n_mnu_Options # printf "\u2630"
    read i18n_asterisk # printf "\u2723"
    read i18n_asterisk_restart_required
    read i18n_Hover_for_help
    read i18n_mnu_tt_Options
    read i18n_mnu_Search_Default
    read i18n_mnu_tt_Search_Default
    read i18n_mnu_Search_Fuzzy
    read i18n_mnu_tt_Search_Fuzzy
    read i18n_mnu_Search_Details
    read i18n_mnu_tt_Search_Details
    read i18n_mnu_Search_Filename
    read i18n_mnu_tt_Search_Filename
    read i18n_mnu_Search_Comment
    read i18n_mnu_tt_Search_Comment
    read i18n_mnu_Search_Categories
    read i18n_mnu_tt_Search_Categories
    read i18n_mnu_Search_Ninja
    read i18n_mnu_tt_Search_Ninja
    read i18n_mnu_Search_Case
    read i18n_mnu_tt_Search_Case
    read i18n_CaseSensitive # printf "\u2260"
    read i18n_mnu_Search_Anchor_Left
    read i18n_mnu_tt_Search_Anchor_Left
    read i18n_mnu_Search_Hidden
    read i18n_mnu_tt_Search_Hidden
    read i18n_Check_fzf_text
    read i18n_Show_this_at_next_start
    read i18n_root_access_rights_needed
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
  "search engine: %s\n" \
  "built-in\n" \
  "%s application found\n" \
  "%s applications found\n" \
  "%s source loaded\n" \
  "%s sources loaded\n" \
  "_OK\n" \
  "Source %s defines an invalid SAVEFLT redirection: '%s'.\n" \
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
  "Fu_zzy\n" \
  "Keep this window open after activating an item. Keep the window open to use the history feature, or to avoid startup delays.\n" \
  "_Keep\n" \
  "Display all available icons instead of displaying just the icons that do not need to be cached. Caching all icons may take some time. Disabling this option clears the existing cache.\n" \
  "Show all _Icons\n" \
  "_Icons\n" \
  "Return the keyboard focus to the search input field after activating an item instead of keeping the keyboard focus on the activated list item.\n" \
  "_Focus search\n" \
  "About and help\n" \
  "Exit\n" \
  "Less\n" \
  "Show also hidden system applications.\n" \
  "Show _hidden\n" \
  "Search in application names, file names, comments and categories all at once.\n" \
  "Search _complete\n" \
  "_Regex\n" \
  "Interpret the search pattern as a POSIX Basic regular expression.\n" \
  "Fuzzy search ignores this.\n" \
  "Edit the configuration file directly. Restart required for changes to take effect.\n" \
  "When you are finished making your changes come back to this window and restart.\n" \
  "application finder options\n" \
  "Findnrun.\n" \
  "Find applications and much more.\n" \
  "Press ENTER to close the terminal [%s]\n" \
  "Run entry in a terminal\n" \
  "ℹ\n" \
  "[F10]\n" \
  "hotkeys\n" \
  "previous results page\n" \
  "next results page\n" \
  "run top/selected result\n" \
  "run top/selected result in a terminal\n" \
  "save search results\n" \
  "quit\n" \
  "show help\n" \
  "cycle through input fields\n" \
  "cycle through search sources\n" \
  "clear search input field\n" \
  "Search results saved as '%s'.\n" \
  "☰\n" \
  "✣\n" \
  "✣ = restart required\n" \
  "Hover over for help\n" \
  "Change options.\n" \
  "_Default search\n" \
  "Find words as they are written exactly.\n" \
  "_Fuzzy search\n" \
  "Find words that match the search terms approximately rather than exactly.\n" \
  "Search _Details\n" \
  "Without requesting further details, search considers application names only.\n" \
  "_Filename\n" \
  "Consider also the .desktop file name when searching for a match.\n" \
  "_Comment\n" \
  "Consider also the application comment when searching for a match. The system menu displays the comment as a tooltip.\n" \
  "C_ategory\n" \
  "Consider also the application categories when searching for a match. The system menu groups application entries by categories.\n" \
  "Search _Ninja\n" \
  "Advanced settings and tweaks.\n" \
  "Match _Case\n" \
  "Enable this for case-sensitive matching.\n" \
  "'_A ≠ 'a'\n" \
  "Anchor _Left\n" \
  "Enable this to make searching match a term only if the term begins in column one. Not applied to Fuzzy search.\n" \
  "Show _Hidden\n" \
  "Enable this to also search for hidden applications that don't appear in the system menu.\n" \
  "The optional Fzf search engine wasn't found.\r\rDo you want to download and install fzf (recommended)?\r\rClick [Help] for details.\n"\
  "_Show this window at next start\n" \
  "This operation needs root's access rights\n" \
  )
EOF
}

