#!/bin/bash
# VS Code Live Theme Hook - instant updates, no restart
#
# Safe settings.json editing via jq deep merge:
#   jq '. * {"workbench.colorCustomizations": ...}' settings.json
# Only touches colorCustomizations keys - all other settings preserved
# Backups malformed JSON before fixing

settings_file="$HOME/.config/Code/User/settings.json"

# Skip if VS Code not installed
if ! command -v code >/dev/null 2>&1; then
    skipped "VS Code"
    exit 0
fi

# Require jq for safe JSON manipulation
if ! command -v jq >/dev/null 2>&1; then
    warning "VS Code: jq required for live theming"
    exit 0
fi

# Ensure settings directory and file exist
mkdir -p "$(dirname "$settings_file")"
[[ ! -f "$settings_file" ]] && echo '{}' > "$settings_file"

# Validate existing JSON (backup and recreate if malformed)
if ! jq empty "$settings_file" 2>/dev/null; then
    cp "$settings_file" "$settings_file.backup"
    echo '{}' > "$settings_file"
    warning "VS Code: Fixed malformed settings.json (backup created)"
fi

# Generate UI colors JSON using bypass's color mapping conventions
# Colors without # prefix come from theme-set exports
ui_colors=$(cat <<EOF
{
    "foreground": "#${normal_white}",
    "disabledForeground": "#${bright_black}",
    "widget.shadow": "#${normal_black}",
    "selection.background": "#${normal_blue}",
    "descriptionForeground": "#${bright_black}",
    "errorForeground": "#${normal_red}",
    "icon.foreground": "#${bright_black}",

    "textBlockQuote.background": "#${normal_black}",
    "textBlockQuote.border": "#${normal_blue}",
    "textCodeBlock.background": "#${normal_black}",
    "textLink.activeForeground": "#${normal_cyan}",
    "textLink.foreground": "#${normal_blue}",
    "textPreformat.foreground": "#${normal_blue}",

    "toolbar.hoverBackground": "#${normal_black}",
    "toolbar.activeBackground": "#${bright_black}",

    "button.background": "#${normal_blue}",
    "button.foreground": "#${bright_white}",
    "button.hoverBackground": "#${bright_black}",
    "button.secondaryForeground": "#${bright_white}",
    "button.secondaryBackground": "#${normal_magenta}",
    "button.secondaryHoverBackground": "#${bright_black}",
    "checkbox.background": "#${normal_black}",
    "checkbox.foreground": "#${normal_white}",

    "dropdown.background": "#${normal_black}",
    "dropdown.listBackground": "#${normal_black}",
    "dropdown.foreground": "#${normal_white}",

    "input.background": "#${normal_black}",
    "input.foreground": "#${normal_white}",
    "input.placeholderForeground": "#${bright_black}",
    "inputOption.activeBackground": "#${normal_black}",
    "inputOption.activeBorder": "#${bright_red}",
    "inputOption.activeForeground": "#${normal_white}",
    "inputValidation.errorBackground": "#${normal_red}",
    "inputValidation.errorForeground": "#${normal_white}",
    "inputValidation.errorBorder": "#${normal_red}",
    "inputValidation.infoBackground": "#${normal_blue}",
    "inputValidation.infoForeground": "#${normal_white}",
    "inputValidation.infoBorder": "#${normal_blue}",
    "inputValidation.warningBackground": "#${normal_yellow}",
    "inputValidation.warningForeground": "#${normal_white}",
    "inputValidation.warningBorder": "#${normal_yellow}",

    "scrollbar.shadow": "#${normal_black}",
    "scrollbarSlider.activeBackground": "#${bright_black}6f",
    "scrollbarSlider.background": "#${normal_black}6f",
    "scrollbarSlider.hoverBackground": "#${bright_black}6f",

    "badge.background": "#${normal_black}",
    "badge.foreground": "#${normal_white}",

    "progressBar.background": "#${bright_black}",

    "list.activeSelectionBackground": "#${normal_black}",
    "list.activeSelectionForeground": "#${normal_white}",
    "list.dropBackground": "#${bright_white}",
    "list.focusBackground": "#${normal_black}",
    "list.focusForeground": "#${normal_white}",
    "list.highlightForeground": "#${bright_white}",
    "list.hoverBackground": "#${bright_black}",
    "list.hoverForeground": "#${normal_white}",
    "list.inactiveSelectionBackground": "#${normal_black}",
    "list.inactiveSelectionForeground": "#${normal_white}",
    "list.inactiveFocusBackground": "#${normal_black}",
    "list.invalidItemForeground": "#${normal_red}",
    "list.errorForeground": "#${normal_red}",
    "list.warningForeground": "#${normal_yellow}",
    "listFilterWidget.background": "#${normal_black}",
    "listFilterWidget.noMatchesOutline": "#${normal_red}",
    "list.filterMatchBackground": "#${normal_black}",
    "tree.indentGuidesStroke": "#${normal_white}",

    "activityBar.background": "#${normal_black}",
    "activityBar.foreground": "#${normal_white}",
    "activityBar.inactiveForeground": "#${bright_black}",
    "activityBarBadge.background": "#${normal_blue}",
    "activityBarBadge.foreground": "#${bright_white}",
    "activityBar.activeBackground": "#${normal_black}",

    "sideBar.background": "#${normal_black}",
    "sideBar.foreground": "#${normal_white}",
    "sideBar.dropBackground": "#${normal_black}6f",
    "sideBarTitle.foreground": "#${normal_white}",
    "sideBarSectionHeader.background": "#${bright_black}",
    "sideBarSectionHeader.foreground": "#${normal_white}",

    "minimap.findMatchHighlight": "#${normal_yellow}6f",
    "minimap.selectionHighlight": "#${normal_black}6f",
    "minimap.errorHighlight": "#${normal_red}",
    "minimap.warningHighlight": "#${normal_yellow}",
    "minimap.background": "#${normal_black}",
    "minimap.selectionOccurrenceHighlight": "#${bright_black}",
    "minimapGutter.addedBackground": "#${normal_green}",
    "minimapGutter.modifiedBackground": "#${normal_magenta}",
    "minimapGutter.deletedBackground": "#${normal_red}",

    "editorGroup.dropBackground": "#${normal_black}6f",
    "editorGroupHeader.noTabsBackground": "#${normal_black}",
    "editorGroupHeader.tabsBackground": "#${normal_black}",
    "editorGroup.emptyBackground": "#${normal_black}",
    "editorGroup.dropIntoPromptForeground": "#${bright_white}",
    "editorGroup.dropIntoPromptBackground": "#${normal_black}",
    "tab.activeBackground": "#${normal_black}",
    "tab.unfocusedActiveBackground": "#${normal_black}",
    "tab.activeForeground": "#${normal_white}",
    "tab.inactiveBackground": "#${normal_black}",
    "tab.inactiveForeground": "#${bright_black}",
    "tab.unfocusedActiveForeground": "#${bright_black}",
    "tab.unfocusedInactiveForeground": "#${bright_black}",
    "tab.hoverBackground": "#${normal_black}",
    "tab.unfocusedHoverBackground": "#${normal_black}",
    "tab.activeModifiedBorder": "#${normal_blue}",
    "tab.inactiveModifiedBorder": "#${normal_blue}",
    "tab.unfocusedActiveModifiedBorder": "#${normal_blue}",
    "tab.unfocusedInactiveModifiedBorder": "#${normal_blue}",
    "editorPane.background": "#${normal_black}",

    "editor.background": "#${normal_black}",
    "editor.foreground": "#${normal_white}",
    "editorLineNumber.foreground": "#${bright_black}",
    "editorLineNumber.activeForeground": "#${bright_black}",
    "editorCursor.foreground": "#${normal_white}",
    "editor.selectionBackground": "#${normal_black}",
    "editor.inactiveSelectionBackground": "#${normal_black}",
    "editor.selectionHighlightBackground": "#${normal_black}",
    "editor.wordHighlightBackground": "#${normal_black}6f",
    "editor.wordHighlightStrongBackground": "#${bright_black}6f",
    "editor.findMatchBackground": "#${normal_yellow}6f",
    "editor.findMatchHighlightBackground": "#${bright_red}6f",
    "editor.findRangeHighlightBackground": "#${normal_black}6f",
    "searchEditor.findMatchBackground": "#${normal_yellow}6f",
    "editor.hoverHighlightBackground": "#${normal_black}6f",
    "editor.lineHighlightBackground": "#${normal_black}",
    "editorLink.activeForeground": "#${normal_blue}",
    "editor.rangeHighlightBackground": "#${normal_black}6f",
    "editorWhitespace.foreground": "#${bright_black}",
    "editorIndentGuide.background1": "#${bright_black}",
    "editorIndentGuide.activeBackground1": "#${bright_black}",
    "editorInlayHint.background": "#${normal_black}",
    "editorInlayHint.foreground": "#${normal_white}",
    "editorInlayHint.typeBackground": "#${normal_black}",
    "editorInlayHint.typeForeground": "#${normal_white}",
    "editorInlayHint.parameterBackground": "#${normal_black}",
    "editorInlayHint.parameterForeground": "#${normal_white}",
    "editorRuler.foreground": "#${bright_black}",

    "editorCodeLens.foreground": "#${normal_black}",
    "editorLightBulb.foreground": "#${normal_yellow}",
    "editorLightBulbAutoFix.foreground": "#${normal_blue}",
    "editorBracketMatch.background": "#${normal_black}",

    "editorBracketHighlight.foreground1": "#${normal_red}",
    "editorBracketHighlight.foreground2": "#${bright_red}",
    "editorBracketHighlight.foreground3": "#${normal_yellow}",
    "editorBracketHighlight.foreground4": "#${normal_green}",
    "editorBracketHighlight.foreground5": "#${normal_blue}",
    "editorBracketHighlight.foreground6": "#${normal_magenta}",
    "editorBracketHighlight.unexpectedBracket.foreground": "#${bright_magenta}",
    "editorOverviewRuler.findMatchForeground": "#${normal_yellow}6f",
    "editorOverviewRuler.rangeHighlightForeground": "#${bright_black}6f",
    "editorOverviewRuler.selectionHighlightForeground": "#${normal_black}6f",
    "editorOverviewRuler.wordHighlightForeground": "#${bright_white}6f",
    "editorOverviewRuler.wordHighlightStrongForeground": "#${normal_blue}6f",
    "editorOverviewRuler.modifiedForeground": "#${normal_magenta}",
    "editorOverviewRuler.addedForeground": "#${normal_green}",
    "editorOverviewRuler.deletedForeground": "#${normal_red}",
    "editorOverviewRuler.errorForeground": "#${normal_red}",
    "editorOverviewRuler.warningForeground": "#${normal_yellow}",
    "editorOverviewRuler.infoForeground": "#${normal_cyan}",
    "editorOverviewRuler.bracketMatchForeground": "#${bright_white}",

    "editorError.foreground": "#${normal_red}",
    "editorWarning.foreground": "#${normal_yellow}",
    "editorInfo.foreground": "#${normal_cyan}",
    "editorHint.foreground": "#${normal_blue}",
    "problemsErrorIcon.foreground": "#${normal_red}",
    "problemsWarningIcon.foreground": "#${normal_yellow}",
    "problemsInfoIcon.foreground": "#${normal_cyan}",

    "editorGutter.background": "#${normal_black}",
    "editorGutter.modifiedBackground": "#${normal_magenta}",
    "editorGutter.addedBackground": "#${normal_green}",
    "editorGutter.deletedBackground": "#${normal_red}",
    "editorGutter.commentRangeForeground": "#${bright_black}",
    "editorGutter.foldingControlForeground": "#${normal_white}",

    "diffEditor.insertedTextBackground": "#${normal_green}20",
    "diffEditor.removedTextBackground": "#${normal_red}20",
    "diffEditor.diagonalFill": "#${normal_black}",

    "editorWidget.foreground": "#${normal_white}",
    "editorWidget.background": "#${normal_black}",
    "editorSuggestWidget.background": "#${normal_black}",
    "editorSuggestWidget.foreground": "#${normal_white}",
    "editorSuggestWidget.focusHighlightForeground": "#${bright_white}",
    "editorSuggestWidget.highlightForeground": "#${normal_blue}",
    "editorSuggestWidget.selectedBackground": "#${normal_black}",
    "editorSuggestWidget.selectedForeground": "#${bright_white}",
    "editorHoverWidget.foreground": "#${normal_white}",
    "editorHoverWidget.background": "#${normal_black}",
    "debugExceptionWidget.background": "#${normal_black}",
    "editorMarkerNavigation.background": "#${normal_black}",
    "editorMarkerNavigationError.background": "#${normal_red}",
    "editorMarkerNavigationWarning.background": "#${normal_yellow}",
    "editorMarkerNavigationInfo.background": "#${normal_blue}",
    "editorMarkerNavigationError.headerBackground": "#${normal_red}20",
    "editorMarkerNavigationWarning.headerBackground": "#${normal_yellow}20",
    "editorMarkerNavigationInfo.headerBackground": "#${normal_cyan}20",

    "peekViewEditor.background": "#${normal_black}",
    "peekViewEditorGutter.background": "#${normal_black}",
    "peekViewEditor.matchHighlightBackground": "#${bright_red}6f",
    "peekViewResult.background": "#${normal_black}",
    "peekViewResult.fileForeground": "#${normal_white}",
    "peekViewResult.lineForeground": "#${bright_black}",
    "peekViewResult.matchHighlightBackground": "#${bright_red}6f",
    "peekViewResult.selectionBackground": "#${normal_black}",
    "peekViewResult.selectionForeground": "#${normal_white}",
    "peekViewTitle.background": "#${normal_black}",
    "peekViewTitleDescription.foreground": "#${bright_black}",
    "peekViewTitleLabel.foreground": "#${normal_white}",

    "merge.currentContentBackground": "#${normal_blue}40",
    "merge.currentHeaderBackground": "#${normal_blue}40",
    "merge.incomingContentBackground": "#${normal_green}60",
    "merge.incomingHeaderBackground": "#${normal_green}60",
    "editorOverviewRuler.currentContentForeground": "#${normal_blue}",
    "editorOverviewRuler.incomingContentForeground": "#${normal_green}",
    "editorOverviewRuler.commonContentForeground": "#${bright_magenta}",

    "panel.background": "#${normal_black}",
    "panel.dropBorder": "#${normal_black}6f",
    "panelTitle.activeForeground": "#${normal_white}",
    "panelTitle.inactiveForeground": "#${bright_black}",

    "statusBar.background": "#${normal_blue}",
    "statusBar.foreground": "#${bright_white}",
    "statusBar.debuggingBackground": "#${bright_red}",
    "statusBar.debuggingForeground": "#${bright_white}",
    "statusBar.noFolderBackground": "#${normal_magenta}",
    "statusBar.noFolderForeground": "#${bright_white}",
    "statusBarItem.activeBackground": "#${bright_black}",
    "statusBarItem.hoverBackground": "#${normal_black}",
    "statusBarItem.prominentForeground": "#${bright_white}",
    "statusBarItem.prominentBackground": "#${normal_magenta}",
    "statusBarItem.prominentHoverBackground": "#${normal_red}",
    "statusBarItem.remoteBackground": "#${normal_green}",
    "statusBarItem.remoteForeground": "#${bright_white}",
    "statusBarItem.errorBackground": "#${normal_red}",
    "statusBarItem.errorForeground": "#${bright_white}",
    "statusBarItem.warningBackground": "#${normal_yellow}",
    "statusBarItem.warningForeground": "#${bright_white}",

    "titleBar.activeBackground": "#${normal_black}",
    "titleBar.activeForeground": "#${normal_white}",
    "titleBar.inactiveBackground": "#${normal_black}",
    "titleBar.inactiveForeground": "#${bright_black}",

    "menubar.selectionForeground": "#${normal_white}",
    "menubar.selectionBackground": "#${normal_black}",
    "menu.foreground": "#${normal_white}",
    "menu.background": "#${normal_black}",
    "menu.selectionForeground": "#${normal_white}",
    "menu.selectionBackground": "#${normal_black}",
    "menu.separatorBackground": "#${bright_white}",

    "commandCenter.foreground": "#${normal_white}",
    "commandCenter.activeForeground": "#${bright_white}",
    "commandCenter.background": "#${normal_black}",
    "commandCenter.activeBackground": "#${normal_black}",

    "notificationCenterHeader.foreground": "#${normal_white}",
    "notificationCenterHeader.background": "#${normal_black}",
    "notifications.foreground": "#${normal_white}",
    "notifications.background": "#${normal_black}",
    "notificationLink.foreground": "#${normal_blue}",
    "notificationsErrorIcon.foreground": "#${normal_red}",
    "notificationsWarningIcon.foreground": "#${normal_yellow}",
    "notificationsInfoIcon.foreground": "#${normal_blue}",

    "banner.background": "#${normal_black}",
    "banner.foreground": "#${normal_white}",
    "banner.iconForeground": "#${normal_blue}",

    "extensionButton.prominentBackground": "#${normal_green}",
    "extensionButton.prominentForeground": "#${bright_white}",
    "extensionButton.prominentHoverBackground": "#${normal_black}",
    "extensionBadge.remoteBackground": "#${bright_red}",
    "extensionBadge.remoteForeground": "#${bright_white}",
    "extensionIcon.starForeground": "#${normal_yellow}",
    "extensionIcon.verifiedForeground": "#${normal_blue}",
    "extensionIcon.preReleaseForeground": "#${bright_red}",

    "pickerGroup.foreground": "#${bright_black}",
    "quickInput.background": "#${normal_black}",
    "quickInput.foreground": "#${normal_white}",
    "quickInputList.focusBackground": "#${bright_black}",
    "quickInputList.focusForeground": "#${bright_white}",
    "quickInputList.focusIconForeground": "#${bright_white}",

    "keybindingLabel.background": "#${normal_black}",
    "keybindingLabel.foreground": "#${normal_white}",
    "keybindingTable.headerBackground": "#${normal_black}",
    "keybindingTable.rowsBackground": "#${normal_black}",

    "terminal.background": "#${normal_black}",
    "terminal.foreground": "#${normal_white}",
    "terminal.ansiBlack": "#${normal_black}",
    "terminal.ansiRed": "#${normal_red}",
    "terminal.ansiGreen": "#${normal_green}",
    "terminal.ansiYellow": "#${normal_yellow}",
    "terminal.ansiBlue": "#${normal_blue}",
    "terminal.ansiMagenta": "#${normal_magenta}",
    "terminal.ansiCyan": "#${normal_cyan}",
    "terminal.ansiWhite": "#${normal_white}",
    "terminal.ansiBrightBlack": "#${bright_black}",
    "terminal.ansiBrightRed": "#${bright_red}",
    "terminal.ansiBrightGreen": "#${bright_green}",
    "terminal.ansiBrightYellow": "#${bright_yellow}",
    "terminal.ansiBrightBlue": "#${bright_blue}",
    "terminal.ansiBrightMagenta": "#${bright_magenta}",
    "terminal.ansiBrightCyan": "#${bright_cyan}",
    "terminal.ansiBrightWhite": "#${bright_white}",
    "terminalCursor.foreground": "#${normal_white}",

    "debugToolBar.background": "#${normal_black}",
    "debugView.stateLabelForeground": "#${bright_white}",
    "debugView.stateLabelBackground": "#${normal_blue}",
    "debugView.valueChangedHighlight": "#${normal_blue}",
    "debugTokenExpression.name": "#${normal_magenta}",
    "debugTokenExpression.value": "#${normal_white}",
    "debugTokenExpression.string": "#${normal_green}",
    "debugTokenExpression.boolean": "#${bright_red}",
    "debugTokenExpression.number": "#${bright_red}",
    "debugTokenExpression.error": "#${normal_red}",

    "testing.iconFailed": "#${normal_red}",
    "testing.iconErrored": "#${bright_magenta}",
    "testing.iconPassed": "#${normal_green}",
    "testing.runAction": "#${bright_black}",
    "testing.iconQueued": "#${normal_yellow}",
    "testing.iconUnset": "#${bright_black}",
    "testing.iconSkipped": "#${normal_magenta}",
    "testing.peekHeaderBackground": "#${normal_black}",
    "testing.message.error.decorationForeground": "#${normal_white}",
    "testing.message.error.lineBackground": "#${normal_red}20",
    "testing.message.info.decorationForeground": "#${normal_white}",
    "testing.message.info.lineBackground": "#${normal_blue}20",

    "welcomePage.background": "#${normal_black}",
    "welcomePage.progress.background": "#${bright_black}",
    "welcomePage.progress.foreground": "#${normal_blue}",
    "welcomePage.tileBackground": "#${normal_black}",
    "welcomePage.tileHoverBackground": "#${normal_black}",
    "walkThrough.embeddedEditorBackground": "#${normal_black}",

    "gitDecoration.addedResourceForeground": "#${normal_green}",
    "gitDecoration.modifiedResourceForeground": "#${normal_magenta}",
    "gitDecoration.deletedResourceForeground": "#${normal_red}",
    "gitDecoration.renamedResourceForeground": "#${normal_cyan}",
    "gitDecoration.stageModifiedResourceForeground": "#${normal_magenta}",
    "gitDecoration.stageDeletedResourceForeground": "#${normal_red}",
    "gitDecoration.untrackedResourceForeground": "#${bright_red}",
    "gitDecoration.ignoredResourceForeground": "#${bright_black}",
    "gitDecoration.conflictingResourceForeground": "#${normal_yellow}",
    "gitDecoration.submoduleResourceForeground": "#${bright_magenta}",

    "settings.headerForeground": "#${normal_white}",
    "settings.modifiedItemIndicator": "#${normal_blue}",
    "settings.dropdownBackground": "#${normal_black}",
    "settings.dropdownForeground": "#${normal_white}",
    "settings.checkboxBackground": "#${normal_black}",
    "settings.checkboxForeground": "#${normal_white}",
    "settings.rowHoverBackground": "#${normal_black}",
    "settings.textInputBackground": "#${normal_black}",
    "settings.textInputForeground": "#${normal_white}",
    "settings.numberInputBackground": "#${normal_black}",
    "settings.numberInputForeground": "#${normal_white}",
    "settings.focusedRowBackground": "#${normal_black}",
    "settings.headerBorder": "#${normal_white}",
    "settings.sashBorder": "#${normal_white}",

    "breadcrumb.foreground": "#${normal_white}",
    "breadcrumb.background": "#${normal_black}",
    "breadcrumb.focusForeground": "#${bright_white}",
    "breadcrumb.activeSelectionForeground": "#${bright_white}",
    "breadcrumbPicker.background": "#${normal_black}",

    "editor.snippetTabstopHighlightBackground": "#${normal_black}",
    "editor.snippetFinalTabstopHighlightBackground": "#${bright_black}",

    "symbolIcon.arrayForeground": "#${normal_white}",
    "symbolIcon.booleanForeground": "#${bright_red}",
    "symbolIcon.classForeground": "#${normal_yellow}",
    "symbolIcon.constantForeground": "#${bright_red}",
    "symbolIcon.constructorForeground": "#${normal_blue}",
    "symbolIcon.enumeratorForeground": "#${bright_red}",
    "symbolIcon.enumeratorMemberForeground": "#${normal_blue}",
    "symbolIcon.eventForeground": "#${normal_yellow}",
    "symbolIcon.fieldForeground": "#${normal_red}",
    "symbolIcon.fileForeground": "#${normal_white}",
    "symbolIcon.folderForeground": "#${normal_white}",
    "symbolIcon.functionForeground": "#${normal_blue}",
    "symbolIcon.interfaceForeground": "#${normal_blue}",
    "symbolIcon.keywordForeground": "#${normal_magenta}",
    "symbolIcon.methodForeground": "#${normal_blue}",
    "symbolIcon.moduleForeground": "#${normal_white}",
    "symbolIcon.namespaceForeground": "#${normal_white}",
    "symbolIcon.nullForeground": "#${bright_magenta}",
    "symbolIcon.numberForeground": "#${bright_red}",
    "symbolIcon.propertyForeground": "#${normal_white}",
    "symbolIcon.snippetForeground": "#${normal_white}",
    "symbolIcon.stringForeground": "#${normal_green}",
    "symbolIcon.structForeground": "#${normal_yellow}",
    "symbolIcon.textForeground": "#${normal_white}",
    "symbolIcon.variableForeground": "#${normal_red}",

    "debugIcon.breakpointForeground": "#${normal_red}",
    "debugIcon.breakpointDisabledForeground": "#${bright_black}",
    "debugIcon.breakpointUnverifiedForeground": "#${normal_black}",
    "debugIcon.breakpointCurrentStackframeForeground": "#${normal_yellow}",
    "debugIcon.breakpointStackframeForeground": "#${bright_magenta}",
    "debugIcon.startForeground": "#${normal_green}",
    "debugIcon.pauseForeground": "#${normal_blue}",
    "debugIcon.stopForeground": "#${normal_red}",
    "debugIcon.disconnectForeground": "#${normal_red}",
    "debugIcon.restartForeground": "#${normal_green}",
    "debugIcon.stepOverForeground": "#${normal_blue}",
    "debugIcon.stepIntoForeground": "#${normal_cyan}",
    "debugIcon.stepOutForeground": "#${normal_magenta}",
    "debugIcon.continueForeground": "#${normal_green}",
    "debugIcon.stepBackForeground": "#${bright_magenta}",
    "debugConsole.infoForeground": "#${normal_white}",
    "debugConsole.warningForeground": "#${normal_yellow}",
    "debugConsole.errorForeground": "#${normal_red}",
    "debugConsole.sourceForeground": "#${normal_white}",
    "debugConsoleInputIcon.foreground": "#${normal_white}",

    "notebook.editorBackground": "#${normal_black}",
    "notebook.cellBorderColor": "#${bright_black}",
    "notebook.cellHoverBackground": "#${normal_black}",
    "notebook.cellToolbarSeparator": "#${normal_black}",
    "notebook.cellEditorBackground": "#${normal_black}",
    "notebook.focusedCellBackground": "#${normal_black}",
    "notebook.focusedCellBorder": "#${normal_blue}",
    "notebook.focusedEditorBorder": "#${normal_blue}",
    "notebook.inactiveFocusedCellBorder": "#${bright_black}",
    "notebook.selectedCellBackground": "#${normal_black}",
    "notebookStatusErrorIcon.foreground": "#${normal_red}",
    "notebookStatusRunningIcon.foreground": "#${normal_cyan}",
    "notebookStatusSuccessIcon.foreground": "#${normal_green}",

    "charts.foreground": "#${normal_white}",
    "charts.lines": "#${normal_white}",
    "charts.red": "#${normal_red}",
    "charts.blue": "#${normal_blue}",
    "charts.yellow": "#${normal_yellow}",
    "charts.orange": "#${bright_red}",
    "charts.green": "#${normal_green}",
    "charts.purple": "#${normal_magenta}",
    "ports.iconRunningProcessForeground": "#${bright_red}"
}
EOF
)

# Generate syntax token customizations
syntax_colors=$(cat <<EOF
{
    "comments": "#${bright_black}",
    "strings": "#${normal_green}",
    "keywords": "#${normal_magenta}",
    "numbers": "#${bright_red}",
    "types": "#${normal_yellow}",
    "functions": "#${normal_blue}",
    "variables": "#${normal_red}",
    "textMateRules": [
        {
            "name": "Comment",
            "scope": ["comment", "punctuation.definition.comment"],
            "settings": { "fontStyle": "italic", "foreground": "#${bright_black}" }
        },
        {
            "name": "Variables",
            "scope": ["variable", "variable.parameter", "entity.name.variable"],
            "settings": { "foreground": "#${normal_red}" }
        },
        {
            "name": "Properties",
            "scope": ["variable.other.object.property"],
            "settings": { "foreground": "#${normal_blue}" }
        },
        {
            "name": "Keywords",
            "scope": ["keyword", "storage.modifier", "keyword.control"],
            "settings": { "foreground": "#${normal_magenta}" }
        },
        {
            "name": "Types",
            "scope": ["keyword.type", "storage.type.primitive", "support.type"],
            "settings": { "foreground": "#${normal_cyan}" }
        },
        {
            "name": "Functions",
            "scope": ["entity.name.function", "support.function", "variable.function"],
            "settings": { "foreground": "#${normal_blue}" }
        },
        {
            "name": "Strings",
            "scope": ["string", "constant.other.symbol"],
            "settings": { "foreground": "#${normal_green}" }
        },
        {
            "name": "Numbers",
            "scope": ["constant.numeric", "constant.language", "keyword.other.unit"],
            "settings": { "foreground": "#${bright_red}" }
        },
        {
            "name": "Classes",
            "scope": ["entity.name", "support.class", "entity.name.type"],
            "settings": { "foreground": "#${normal_yellow}" }
        },
        {
            "name": "Tags",
            "scope": ["entity.name.tag"],
            "settings": { "foreground": "#${normal_red}" }
        },
        {
            "name": "Attributes",
            "scope": ["entity.other.attribute-name"],
            "settings": { "foreground": "#${normal_blue}" }
        },
        {
            "name": "Invalid",
            "scope": ["invalid", "invalid.illegal"],
            "settings": { "foreground": "#${normal_red}" }
        },
        {
            "name": "Deprecated",
            "scope": ["invalid.deprecated"],
            "settings": { "foreground": "#${bright_magenta}" }
        },
        {
            "name": "Regex",
            "scope": ["string.regexp", "constant.character.escape"],
            "settings": { "foreground": "#${normal_cyan}" }
        },
        {
            "name": "Embedded",
            "scope": ["punctuation.section.embedded"],
            "settings": { "foreground": "#${bright_magenta}" }
        }
    ]
}
EOF
)

# Merge into settings.json (preserves all other settings)
if jq --argjson ui "$ui_colors" \
   --argjson syntax "$syntax_colors" \
   '. * {
     "workbench.colorCustomizations": $ui,
     "editor.tokenColorCustomizations": $syntax
   }' "$settings_file" > "$settings_file.tmp" 2>/dev/null; then
    mv "$settings_file.tmp" "$settings_file"
    success "VS Code"
else
    rm -f "$settings_file.tmp"
    error "VS Code: Failed to update settings.json"
fi
