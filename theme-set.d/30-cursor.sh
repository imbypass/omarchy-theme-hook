#!/bin/bash

output_file="$HOME/.config/omarchy/current/theme/vscode_colors.json"

if ! command -v cursor >/dev/null 2>&1; then
    skipped "Cursor"
fi

cat > "$output_file" << EOF
{
    "\$schema": "vscode://schemas/color-theme",
    "name": "Omarchy",
    "type": "",
    "colors": {
    // Base colors
    "foreground":"#${normal_white}", //5
    "disabledForeground":"#${bright_black}", //4
    "widget.shadow":"#${normal_black}", //0
    "selection.background":"#${normal_blue}", //D
    "descriptionForeground":"#${bright_black}", //3
    "errorForeground":"#${normal_red}", //8
    "icon.foreground":"#${bright_black}", //4

    // Text colors
    "textBlockQuote.background":"#${normal_black}", //1
    "textBlockQuote.border":"#${normal_blue}", //D
    "textCodeBlock.background":"#${normal_black}", //0
    "textLink.activeForeground":"#${normal_cyan}", //C
    "textLink.foreground":"#${normal_blue}", //D
    "textPreformat.foreground":"#${normal_blue}", //D
    "textSeparator.foreground": "#f0f",

    // Action colors
    "toolbar.hoverBackground":"#${normal_black}", //2
    "toolbar.activeBackground":"#${bright_black}", //3

    // Button control
    "button.background":"#${normal_blue}", //D
    "button.foreground":"#${bright_white}", //7
    "button.hoverBackground":"#${bright_black}", //4
    "button.secondaryForeground":"#${bright_white}", //7
    "button.secondaryBackground":"#${normal_magenta}", //E
    "button.secondaryHoverBackground":"#${bright_black}", //4
    "checkbox.background":"#${normal_black}", //0
    "checkbox.foreground":"#${normal_white}", //5

    // Dropdown control
    "dropdown.background":"#${normal_black}", //0
    "dropdown.listBackground":"#${normal_black}", //0
    "dropdown.foreground":"#${normal_white}", //5

    // Input control
    "input.background":"#${normal_black}", //0
    "input.foreground":"#${normal_white}", //5
    "input.placeholderForeground":"#${bright_black}", //3
    "inputOption.activeBackground":"#${normal_black}", //2
    "inputOption.activeBorder":"#${bright_red}", //9
    "inputOption.activeForeground":"#${normal_white}", //5
    "inputValidation.errorBackground":"#${normal_red}", //8
    "inputValidation.errorForeground":"#${normal_white}", //5
    "inputValidation.errorBorder":"#${normal_red}", //8
    "inputValidation.infoBackground":"#${normal_blue}", //D
    "inputValidation.infoForeground":"#${normal_white}", //5
    "inputValidation.infoBorder":"#${normal_blue}", //D
    "inputValidation.warningBackground":"#${normal_yellow}", //A
    "inputValidation.warningForeground":"#${normal_white}", //5
    "inputValidation.warningBorder":"#${normal_yellow}", //A

    // Scrollbar control
    "scrollbar.shadow":"#${normal_black}", //1
    "scrollbarSlider.activeBackground":"#${bright_black}6f", //4
    "scrollbarSlider.background":"#${normal_black}6f", //2
    "scrollbarSlider.hoverBackground":"#${bright_black}6f", //3

    // Badge
    "badge.background":"#${normal_black}", //0
    "badge.foreground":"#${normal_white}", //5

    // Progress bar
    "progressBar.background":"#${bright_black}", //3

    // Lists and trees
    "list.activeSelectionBackground":"#${normal_black}", //2
    "list.activeSelectionForeground":"#${normal_white}", //5
    "list.dropBackground":"#${bright_white}", //7
    "list.focusBackground":"#${normal_black}", //2
    "list.focusForeground":"#${normal_white}", //5
    "list.highlightForeground":"#${bright_white}", //7
    "list.hoverBackground":"#${bright_black}", //3
    "list.hoverForeground":"#${normal_white}", //5
    "list.inactiveSelectionBackground":"#${normal_black}", //2
    "list.inactiveSelectionForeground":"#${normal_white}", //5
    "list.inactiveFocusBackground":"#${normal_black}", //2
    "list.invalidItemForeground":"#${normal_red}", //8
    "list.errorForeground":"#${normal_red}", //8
    "list.warningForeground":"#${normal_yellow}", //A
    "listFilterWidget.background":"#${normal_black}", //0
    "listFilterWidget.noMatchesOutline":"#${normal_red}", //8
    "list.filterMatchBackground":"#${normal_black}", //2
    "tree.indentGuidesStroke":"#${normal_white}", //5

    // Activity Bar
    "activityBar.background":"#${normal_black}", //0
    // Below is no longer supported as of 1.52
    "activityBar.dropBackground":"#${bright_white}", //7
    // Above is no longer supported as of 1.52
    "activityBar.foreground":"#${normal_white}", //5
    "activityBar.inactiveForeground":"#${bright_black}", //3
    "activityBarBadge.background":"#${normal_blue}", //D
    "activityBarBadge.foreground":"#${bright_white}", //7
    "activityBar.activeBackground":"#${normal_black}", //2

    // Side Bar
    "sideBar.background":"#${normal_black}", //1
    "sideBar.foreground":"#${normal_white}", //5
    "sideBar.dropBackground":"#${normal_black}6f", //2
    "sideBarTitle.foreground":"#${normal_white}", //5
    "sideBarSectionHeader.background":"#${bright_black}", //3
    "sideBarSectionHeader.foreground":"#${normal_white}", //5

    //Minimap
    "minimap.findMatchHighlight":"#${normal_yellow}6f", //A
    "minimap.selectionHighlight":"#${normal_black}6f", //2
    "minimap.errorHighlight":"#${normal_red}", //8
    "minimap.warningHighlight":"#${normal_yellow}", //A
    "minimap.background":"#${normal_black}", //0
    "minimap.selectionOccurrenceHighlight":"#${bright_black}", //3
    "minimapGutter.addedBackground":"#${normal_green}", //B
    "minimapGutter.modifiedBackground":"#${normal_magenta}", //E
    "minimapGutter.deletedBackground":"#${normal_red}", //8

    // Editor Groups & Tabs
    // Below is no longer supported as of 1.24
    "editorGroup.background":"#${normal_black}", //0
    // Above is no longer supported as of 1.24
    "editorGroup.dropBackground":"#${normal_black}6f", //2
    "editorGroupHeader.noTabsBackground":"#${normal_black}", //1
    "editorGroupHeader.tabsBackground":"#${normal_black}", //1
    "editorGroup.emptyBackground":"#${normal_black}", //0
    "editorGroup.dropIntoPromptForeground":"#${bright_white}", //5
    "editorGroup.dropIntoPromptBackground":"#${normal_black}", //0
    "tab.activeBackground":"#${normal_black}", //0
    "tab.unfocusedActiveBackground":"#${normal_black}", //0
    "tab.activeForeground":"#${normal_white}", //5
    "tab.inactiveBackground":"#${normal_black}", //1
    "tab.inactiveForeground":"#${bright_black}", //3
    "tab.unfocusedActiveForeground":"#${bright_black}", //4
    "tab.unfocusedInactiveForeground":"#${bright_black}", //3
    "tab.hoverBackground":"#${normal_black}", //2
    "tab.unfocusedHoverBackground":"#${normal_black}", //2

    "tab.activeModifiedBorder":"#${normal_blue}", //D
    "tab.inactiveModifiedBorder":"#${normal_blue}", //D
    "tab.unfocusedActiveModifiedBorder":"#${normal_blue}", //D
    "tab.unfocusedInactiveModifiedBorder":"#${normal_blue}", //D
    "editorPane.background":"#${normal_black}", //0

    // Editor colors
    "editor.background":"#${normal_black}", //0
    "editor.foreground":"#${normal_white}", //5
    "editorLineNumber.foreground":"#${bright_black}", //3
    "editorLineNumber.activeForeground":"#${bright_black}", //4
    "editorCursor.foreground":"#${normal_white}", //5
    "editor.selectionBackground":"#${normal_black}", //2
    "editor.inactiveSelectionBackground":"#${normal_black}", //2
    "editor.selectionHighlightBackground":"#${normal_black}", //1
    "editor.wordHighlightBackground":"#${normal_black}6f", //2
    "editor.wordHighlightStrongBackground":"#${bright_black}6f", //3
    "editor.findMatchBackground":"#${normal_yellow}6f", //A
    "editor.findMatchHighlightBackground":"#${bright_red}6f", //9
    "editor.findRangeHighlightBackground":"#${normal_black}6f", //1
    "searchEditor.findMatchBackground":"#${normal_yellow}6f", //A
    "editor.hoverHighlightBackground":"#${normal_black}6f", //2
    "editor.lineHighlightBackground":"#${normal_black}", //1
    "editorLink.activeForeground":"#${normal_blue}", //D
    "editor.rangeHighlightBackground":"#${normal_black}6f", //1
    "editorWhitespace.foreground":"#${bright_black}", //3
    "editorIndentGuide.background":"#${bright_black}", //3
    "editorIndentGuide.activeBackground":"#${bright_black}", //4
    "editorInlayHint.background":"#${normal_black}", //1
    "editorInlayHint.foreground":"#${normal_white}", //5
    "editorInlayHint.typeBackground":"#${normal_black}", //1
    "editorInlayHint.typeForeground":"#${normal_white}", //5
    "editorInlayHint.parameterBackground":"#${normal_black}", //1
    "editorInlayHint.parameterForeground":"#${normal_white}", //5
    "editorRuler.foreground":"#${bright_black}", //3

    /// CodeLens
    "editorCodeLens.foreground":"#${normal_black}", //2

    /// Lightbulb
    "editorLightBulb.foreground":"#${normal_yellow}", //A
    "editorLightBulbAutoFix.foreground":"#${normal_blue}", //D

    /// Bracket matches
    "editorBracketMatch.background":"#${normal_black}", //2

    /// Bracket pair colorization
    "editorBracketHighlight.foreground1":"#${normal_red}", //8
    "editorBracketHighlight.foreground2":"#${bright_red}", //9
    "editorBracketHighlight.foreground3":"#${normal_yellow}", //A
    "editorBracketHighlight.foreground4":"#${normal_green}", //B
    "editorBracketHighlight.foreground5":"#${normal_blue}", //D
    "editorBracketHighlight.foreground6":"#${normal_magenta}", //E
    "editorBracketHighlight.unexpectedBracket.foreground":"#${bright_magenta}", //F
    "editorOverviewRuler.findMatchForeground":"#${normal_yellow}6f", //A
    "editorOverviewRuler.rangeHighlightForeground":"#${bright_black}6f", //3
    "editorOverviewRuler.selectionHighlightForeground":"#${normal_black}6f", //2
    "editorOverviewRuler.wordHighlightForeground":"#${bright_white}6f", //7
    "editorOverviewRuler.wordHighlightStrongForeground":"#${normal_blue}6f", //D
    "editorOverviewRuler.modifiedForeground":"#${normal_magenta}", //E
    "editorOverviewRuler.addedForeground":"#${normal_green}", //B
    "editorOverviewRuler.deletedForeground":"#${normal_red}", //8
    "editorOverviewRuler.errorForeground":"#${normal_red}", //8
    "editorOverviewRuler.warningForeground":"#${normal_yellow}", //A
    "editorOverviewRuler.infoForeground":"#${normal_cyan}", //C
    "editorOverviewRuler.bracketMatchForeground":"#${bright_white}", //6

    /// Errors and warnings
    "editorError.foreground":"#${normal_red}", //8
    "editorWarning.foreground":"#${normal_yellow}", //A
    "editorInfo.foreground":"#${normal_cyan}", //C
    "editorHint.foreground":"#${normal_blue}", //D
    "problemsErrorIcon.foreground":"#${normal_red}", //8
    "problemsWarningIcon.foreground":"#${normal_yellow}", //A
    "problemsInfoIcon.foreground":"#${normal_cyan}", //C

    /// Gutter
    "editorGutter.background":"#${normal_black}", //0
    "editorGutter.modifiedBackground":"#${normal_magenta}", //E
    "editorGutter.addedBackground":"#${normal_green}", //B
    "editorGutter.deletedBackground":"#${normal_red}", //8
    "editorGutter.commentRangeForeground":"#${bright_black}", //4
    "editorGutter.foldingControlForeground":"#${normal_white}", //5

    // Diff editor colors
    "diffEditor.insertedTextBackground":"#${normal_green}20",
    "diffEditor.removedTextBackground":"#${normal_red}20",
    "diffEditor.diagonalFill":"#${normal_black}", //2

    // Editor widget colors
    "editorWidget.foreground":"#${normal_white}", //5
    "editorWidget.background":"#${normal_black}", //0
    "editorSuggestWidget.background":"#${normal_black}", //1
    "editorSuggestWidget.foreground":"#${normal_white}", //5
    "editorSuggestWidget.focusHighlightForeground":"#${bright_white}", //7
    "editorSuggestWidget.highlightForeground":"#${normal_blue}", //D
    "editorSuggestWidget.selectedBackground":"#${normal_black}", //2
    "editorSuggestWidget.selectedForeground":"#${bright_white}", //6
    "editorHoverWidget.foreground":"#${normal_white}", //5
    "editorHoverWidget.background":"#${normal_black}", //1
    "debugExceptionWidget.background":"#${normal_black}", //1
    "editorMarkerNavigation.background":"#${normal_black}", //1
    "editorMarkerNavigationError.background":"#${normal_red}", //8
    "editorMarkerNavigationWarning.background":"#${normal_yellow}", //A
    "editorMarkerNavigationInfo.background":"#${normal_blue}", //D
    "editorMarkerNavigationError.headerBackground":"#${normal_red}20", //8
    "editorMarkerNavigationWarning.headerBackground":"#${normal_yellow}20", //A
    "editorMarkerNavigationInfo.headerBackground":"#${normal_cyan}20", //C

    // Peek view colors
    "peekViewEditor.background":"#${normal_black}", //1
    "peekViewEditorGutter.background":"#${normal_black}", //1
    "peekViewEditor.matchHighlightBackground":"#${bright_red}6f", //9
    "peekViewResult.background":"#${normal_black}", //0
    "peekViewResult.fileForeground":"#${normal_white}", //5
    "peekViewResult.lineForeground":"#${bright_black}", //3
    "peekViewResult.matchHighlightBackground":"#${bright_red}6f", //9
    "peekViewResult.selectionBackground":"#${normal_black}", //2
    "peekViewResult.selectionForeground":"#${normal_white}", //5
    "peekViewTitle.background":"#${normal_black}", //2
    "peekViewTitleDescription.foreground":"#${bright_black}", //3
    "peekViewTitleLabel.foreground":"#${normal_white}", //5

    // Merge conflicts colors
    "merge.currentContentBackground":"#${normal_blue}40", //D
    "merge.currentHeaderBackground":"#${normal_blue}40", //D
    "merge.incomingContentBackground":"#${normal_green}60", //B
    "merge.incomingHeaderBackground":"#${normal_green}60", //B
    "editorOverviewRuler.currentContentForeground":"#${normal_blue}", //D
    "editorOverviewRuler.incomingContentForeground":"#${normal_green}", //B
    "editorOverviewRuler.commonContentForeground":"#${bright_magenta}", //F

    // Panel colors
    "panel.background":"#${normal_black}", //0
    // Below is no longer supported as of 1.47
    "panel.dropBackground":"#${normal_black}6f", //1
    // Above is no longer supported as of 1.47
    "panel.dropBorder":"#${normal_black}6f", //1
    "panelTitle.activeForeground":"#${normal_white}", //5
    "panelTitle.inactiveForeground":"#${bright_black}", //3

    // Status Bar colors
    "statusBar.background":"#${normal_blue}", //D
    "statusBar.foreground":"#${bright_white}", //7
    "statusBar.debuggingBackground":"#${bright_red}", //9
    "statusBar.debuggingForeground":"#${bright_white}", //7
    "statusBar.noFolderBackground":"#${normal_magenta}", //E
    "statusBar.noFolderForeground":"#${bright_white}", //7
    "statusBarItem.activeBackground":"#${bright_black}", //3
    "statusBarItem.hoverBackground":"#${normal_black}", //2
    "statusBarItem.prominentForeground":"#${bright_white}", //7
    "statusBarItem.prominentBackground":"#${normal_magenta}", //E
    "statusBarItem.prominentHoverBackground":"#${normal_red}", //8
    "statusBarItem.remoteBackground":"#${normal_green}", //B
    "statusBarItem.remoteForeground":"#${bright_white}", //7
    "statusBarItem.errorBackground":"#${normal_red}", //8
    "statusBarItem.errorForeground":"#${bright_white}", //7
    "statusBarItem.warningBackground":"#${normal_yellow}", //A
    "statusBarItem.warningForeground":"#${bright_white}", //7

    // Title Bar colors
    "titleBar.activeBackground":"#${normal_black}", //0
    "titleBar.activeForeground":"#${normal_white}", //5
    "titleBar.inactiveBackground":"#${normal_black}", //1
    "titleBar.inactiveForeground":"#${bright_black}", //3

    // Menu Bar colors
    "menubar.selectionForeground":"#${normal_white}", //5
    "menubar.selectionBackground":"#${normal_black}", //1
    "menu.foreground":"#${normal_white}", //5
    "menu.background":"#${normal_black}", //1
    "menu.selectionForeground":"#${normal_white}", //5
    "menu.selectionBackground":"#${normal_black}", //2
    "menu.separatorBackground":"#${bright_white}", //7

    // Command Center colors
    "commandCenter.foreground":"#${normal_white}", //5
    "commandCenter.activeForeground":"#${bright_white}", //7
    "commandCenter.background":"#${normal_black}", //0
    "commandCenter.activeBackground":"#${normal_black}", //1

    // Notification colors
    "notificationCenterHeader.foreground":"#${normal_white}", //5
    "notificationCenterHeader.background":"#${normal_black}", //1
    "notifications.foreground":"#${normal_white}", //5
    "notifications.background":"#${normal_black}", //2
    "notificationLink.foreground":"#${normal_blue}", //D
    "notificationsErrorIcon.foreground":"#${normal_red}", //8
    "notificationsWarningIcon.foreground":"#${normal_yellow}", //A
    "notificationsInfoIcon.foreground":"#${normal_blue}", //D

    // Below is no longer supported as of 1.21
    "notification.background":"#${normal_black}", //2
    "notification.foreground":"#${normal_white}", //5
    "notification.buttonBackground":"#${normal_blue}", //D
    "notification.buttonHoverBackground":"#${normal_black}", //2
    "notification.buttonForeground":"#${bright_white}", //7
    "notification.infoBackground":"#${normal_cyan}", //C
    "notification.infoForeground":"#${bright_white}", //7
    "notification.warningBackground":"#${normal_yellow}", //A
    "notification.warningForeground":"#${bright_white}", //7
    "notification.errorBackground":"#${normal_red}", //8
    "notification.errorForeground":"#${bright_white}", //7
    // Above is no longer supported as of 1.21
    //
    // Banner colors
    "banner.background":"#${normal_black}", //2
    "banner.foreground":"#${normal_white}", //5
    "banner.iconForeground":"#${normal_blue}", //D

    // Extensions colors
    "extensionButton.prominentBackground":"#${normal_green}", //B
    "extensionButton.prominentForeground":"#${bright_white}", //7
    "extensionButton.prominentHoverBackground":"#${normal_black}", //2
    "extensionBadge.remoteBackground":"#${bright_red}", //9
    "extensionBadge.remoteForeground":"#${bright_white}", //7
    "extensionIcon.starForeground":"#${normal_yellow}", //A
    "extensionIcon.verifiedForeground":"#${normal_blue}", //D
    "extensionIcon.preReleaseForeground":"#${bright_red}", //9

    // Quick picker colors
    "pickerGroup.foreground":"#${bright_black}", //3
    "quickInput.background":"#${normal_black}", //1
    "quickInput.foreground":"#${normal_white}", //5
    "quickInputList.focusBackground":"#${bright_black}", //3
    "quickInputList.focusForeground":"#${bright_white}", //7
    "quickInputList.focusIconForeground":"#${bright_white}", //7

    // Keybinding label colors
    "keybindingLabel.background":"#${normal_black}", //2
    "keybindingLabel.foreground":"#${normal_white}", //5

    // Keybinding shortcut table colors
    "keybindingTable.headerBackground":"#${normal_black}", //2
    "keybindingTable.rowsBackground":"#${normal_black}", //1

    // Integrated terminal colors
    "terminal.background":"#${normal_black}", //0
    "terminal.foreground":"#${normal_white}", //5
    "terminal.ansiBlack":"#${normal_black}", //0
    "terminal.ansiRed":"#${normal_red}", //8
    "terminal.ansiGreen":"#${normal_green}", //B
    "terminal.ansiYellow":"#${normal_yellow}", //A
    "terminal.ansiBlue":"#${normal_blue}", //D
    "terminal.ansiMagenta":"#${normal_magenta}", //E
    "terminal.ansiCyan":"#${normal_cyan}", //C
    "terminal.ansiWhite":"#${normal_white}", //5
    "terminal.ansiBrightBlack":"#${bright_black}", //3
    "terminal.ansiBrightRed":"#${normal_red}", //8
    "terminal.ansiBrightGreen":"#${normal_green}", //B
    "terminal.ansiBrightYellow":"#${normal_yellow}", //A
    "terminal.ansiBrightBlue":"#${normal_blue}", //D
    "terminal.ansiBrightMagenta":"#${normal_magenta}", //E
    "terminal.ansiBrightCyan":"#${normal_cyan}", //C
    "terminal.ansiBrightWhite":"#${bright_white}", //7
    "terminalCursor.foreground":"#${normal_white}", //5
    "terminalOverviewRuler.cursorForeground": "#ff0000",
    "terminalOverviewRuler.findMatchForeground": "#ff0000",

    // Debug colors
    "debugToolBar.background":"#${normal_black}", //1
    "debugView.stateLabelForeground":"#${bright_white}", //7
    "debugView.stateLabelBackground":"#${normal_blue}", //D
    "debugView.valueChangedHighlight":"#${normal_blue}", //D
    "debugTokenExpression.name":"#${normal_magenta}", //E
    "debugTokenExpression.value":"#${normal_white}", //5
    "debugTokenExpression.string":"#${normal_green}", //B
    "debugTokenExpression.boolean":"#${bright_red}", //9
    "debugTokenExpression.number":"#${bright_red}", //9
    "debugTokenExpression.error":"#${normal_red}", //8

    // Testing colors
    "testing.iconFailed":"#${normal_red}", //8
    "testing.iconErrored":"#${bright_magenta}", //F
    "testing.iconPassed":"#${normal_green}", //B
    "testing.runAction":"#${bright_black}", //4
    "testing.iconQueued":"#${normal_yellow}", //A
    "testing.iconUnset":"#${bright_black}", //4
    "testing.iconSkipped":"#${normal_magenta}", //E

    "testing.peekHeaderBackground":"#${normal_black}", //1
    "testing.message.error.decorationForeground":"#${normal_white}", //5
    "testing.message.error.lineBackground":"#${normal_red}20", //8
    "testing.message.info.decorationForeground":"#${normal_white}", //5
    "testing.message.info.lineBackground":"#${normal_blue}20", //D

    // Welcome page colors
    "welcomePage.background":"#${normal_black}", //0

    // Below is no longer supported as of 1.63
    "welcomePage.buttonBackground":"#${normal_black}", //1
    "welcomePage.buttonHoverBackground":"#${normal_black}", //2

    // Above is no longer supported as of 1.63
    "welcomePage.progress.background":"#${bright_black}", //3
    "welcomePage.progress.foreground":"#${normal_blue}", //D
    "welcomePage.tileBackground":"#${normal_black}", //1
    "welcomePage.tileHoverBackground":"#${normal_black}", //2
    "walkThrough.embeddedEditorBackground":"#${normal_black}", //0
    // Git colors
    "gitDecoration.addedResourceForeground":"#${normal_green}", //B
    "gitDecoration.modifiedResourceForeground":"#${normal_magenta}", //E
    "gitDecoration.deletedResourceForeground":"#${normal_red}", //8
    "gitDecoration.renamedResourceForeground":"#${normal_cyan}", //C
    "gitDecoration.stageModifiedResourceForeground":"#${normal_magenta}", //E
    "gitDecoration.stageDeletedResourceForeground":"#${normal_red}", //8
    "gitDecoration.untrackedResourceForeground":"#${bright_red}", //9
    "gitDecoration.ignoredResourceForeground":"#${bright_black}", //3
    "gitDecoration.conflictingResourceForeground":"#${normal_yellow}", //A
    "gitDecoration.submoduleResourceForeground":"#${bright_magenta}", //F
    // Settings Editor colors
    "settings.headerForeground":"#${normal_white}", //5
    "settings.modifiedItemIndicator":"#${normal_blue}", //D

    // Below was introduced temporarily in 1.26
    "settings.modifiedItemForeground":"#${normal_green}", //B

    // Above was introduced temporarily in 1.26
    "settings.dropdownBackground":"#${normal_black}", //1
    "settings.dropdownForeground":"#${normal_white}", //5

    "settings.checkboxBackground":"#${normal_black}", //1
    "settings.checkboxForeground":"#${normal_white}", //5
    "settings.rowHoverBackground":"#${normal_black}", //2
    "settings.textInputBackground":"#${normal_black}", //1
    "settings.textInputForeground":"#${normal_white}", //5
    "settings.numberInputBackground":"#${normal_black}", //1
    "settings.numberInputForeground":"#${normal_white}", //5
    "settings.focusedRowBackground":"#${normal_black}", //2

    "settings.headerBorder":"#${normal_white}", //5
    "settings.sashBorder":"#${normal_white}", //5
    // Breadcrumbs colors
    "breadcrumb.foreground":"#${normal_white}", //5
    "breadcrumb.background":"#${normal_black}", //1
    "breadcrumb.focusForeground":"#${bright_white}", //6
    "breadcrumb.activeSelectionForeground":"#${bright_white}", //7
    "breadcrumbPicker.background":"#${normal_black}", //1
    // Snippets colors
    "editor.snippetTabstopHighlightBackground":"#${normal_black}", //2
    "editor.snippetFinalTabstopHighlightBackground":"#${bright_black}", //3

    // Symbol Icons colors
    "symbolIcon.arrayForeground":"#${normal_white}", //5
    "symbolIcon.booleanForeground":"#${bright_red}", //9
    "symbolIcon.classForeground":"#${normal_yellow}", //A
    "symbolIcon.colorForeground": "#f0f",
    "symbolIcon.constantForeground":"#${bright_red}", //9
    "symbolIcon.constructorForeground":"#${normal_blue}", //D
    "symbolIcon.enumeratorForeground":"#${bright_red}", //9
    "symbolIcon.enumeratorMemberForeground":"#${normal_blue}", //D
    "symbolIcon.eventForeground":"#${normal_yellow}", //A
    "symbolIcon.fieldForeground":"#${normal_red}", //8
    "symbolIcon.fileForeground":"#${normal_white}", //5
    "symbolIcon.folderForeground":"#${normal_white}", //5
    "symbolIcon.functionForeground":"#${normal_blue}", //D,
    "symbolIcon.interfaceForeground":"#${normal_blue}", //D
    "symbolIcon.keyForeground": "#f0f",
    "symbolIcon.keywordForeground":"#${normal_magenta}", //E
    "symbolIcon.methodForeground":"#${normal_blue}", //D
    "symbolIcon.moduleForeground":"#${normal_white}", //5
    "symbolIcon.namespaceForeground":"#${normal_white}", //5
    "symbolIcon.nullForeground":"#${bright_magenta}", //F
    "symbolIcon.numberForeground":"#${bright_red}", //9
    "symbolIcon.objectForeground": "#f0f",
    "symbolIcon.operatorForeground": "#f0f",
    "symbolIcon.packageForeground": "#f0f",
    "symbolIcon.propertyForeground":"#${normal_white}", //5
    "symbolIcon.referenceForeground": "#f0f",
    "symbolIcon.snippetForeground":"#${normal_white}", //5
    "symbolIcon.stringForeground":"#${normal_green}", //B
    "symbolIcon.structForeground":"#${normal_yellow}", //A
    "symbolIcon.textForeground":"#${normal_white}", //5
    "symbolIcon.typeParameterForeground": "#f0f",
    "symbolIcon.unitForeground": "#f0f",
    "symbolIcon.variableForeground":"#${normal_red}", //8

    // Debug Icons colors
    "debugIcon.breakpointForeground":"#${normal_red}", //8
    "debugIcon.breakpointDisabledForeground":"#${bright_black}", //4
    "debugIcon.breakpointUnverifiedForeground":"#${normal_black}", //2
    "debugIcon.breakpointCurrentStackframeForeground":"#${normal_yellow}", //A
    "debugIcon.breakpointStackframeForeground":"#${bright_magenta}", //F
    "debugIcon.startForeground":"#${normal_green}", //B
    "debugIcon.pauseForeground":"#${normal_blue}", //D
    "debugIcon.stopForeground":"#${normal_red}", //8
    "debugIcon.disconnectForeground":"#${normal_red}", //8
    "debugIcon.restartForeground":"#${normal_green}", //B
    "debugIcon.stepOverForeground":"#${normal_blue}", //D
    "debugIcon.stepIntoForeground":"#${normal_cyan}", //C
    "debugIcon.stepOutForeground":"#${normal_magenta}", //E
    "debugIcon.continueForeground":"#${normal_green}", //B
    "debugIcon.stepBackForeground":"#${bright_magenta}", //F
    "debugConsole.infoForeground":"#${normal_white}", //5
    "debugConsole.warningForeground":"#${normal_yellow}", //A
    "debugConsole.errorForeground":"#${normal_red}", //8
    "debugConsole.sourceForeground":"#${normal_white}", //5
    "debugConsoleInputIcon.foreground":"#${normal_white}", //5
    // Notebook colors
    "notebook.editorBackground":"#${normal_black}", //0
    "notebook.cellBorderColor":"#${bright_black}", //3
    "notebook.cellHoverBackground":"#${normal_black}", //1

    "notebook.cellToolbarSeparator":"#${normal_black}", //2
    "notebook.cellEditorBackground":"#${normal_black}", //0
    "notebook.focusedCellBackground":"#${normal_black}", //2
    "notebook.focusedCellBorder":"#${normal_blue}", //D
    "notebook.focusedEditorBorder":"#${normal_blue}", //D
    "notebook.inactiveFocusedCellBorder":"#${bright_black}", //3

    "notebook.selectedCellBackground":"#${normal_black}", //2

    "notebookStatusErrorIcon.foreground":"#${normal_red}", //8
    "notebookStatusRunningIcon.foreground":"#${normal_cyan}", //C
    "notebookStatusSuccessIcon.foreground":"#${normal_green}", //B
    // Chart colors
    "charts.foreground":"#${normal_white}", //5
    "charts.lines":"#${normal_white}", //5
    "charts.red":"#${normal_red}", //8
    "charts.blue":"#${normal_blue}", //D
    "charts.yellow":"#${normal_yellow}", //A
    "charts.orange":"#${bright_red}", //9
    "charts.green":"#${normal_green}", //B
    "charts.purple":"#${normal_magenta}", //E
    // Ports Colors
    "ports.iconRunningProcessForeground":"#${bright_red}" //9
    },
    "tokenColors": [
    {
        "name": "Comment",
        "scope": ["comment", "punctuation.definition.comment"],
        "settings": {
        "fontStyle": "italic",
        "foreground":"#${bright_black}" //3
        }
    },
    {
        "name": "Variables, Parameters",
        "scope": [
        "variable",
        "string constant.other.placeholder",
        "entity.name.variable.parameter",
        "entity.name.variable.local",
        "variable.parameter"
        ],
        "settings": {
        "foreground":"#${normal_red}" //8
        }
    },
    {
        "name": "Properties",
        "scope": ["variable.other.object.property"],
        "settings": {
        "foreground":"#${normal_blue}" //D
        }
    },
    {
        "name": "Colors",
        "scope": ["constant.other.color"],
        "settings": {
        "foreground":"#${normal_green}" //B
        }
    },
    {
        "name": "Invalid",
        "scope": ["invalid", "invalid.illegal"],
        "settings": {
        "foreground":"#${normal_red}" //8
        }
    },
    {
        "name": "Invalid - Deprecated",
        "scope": ["invalid.deprecated"],
        "settings": {
        "foreground":"#${bright_magenta}" //F
        }
    },
    {
        "name": "Keyword, Storage",
        "scope": ["keyword", "storage.modifier"],
        "settings": {
        "foreground":"#${normal_magenta}" //E
        }
    },
    {
        "name": "Keyword Control",
        "scope": [
        "keyword.control",
        "keyword.control.flow",
        "keyword.control.from",
        "keyword.control.import",
        "keyword.control.as"
        ],
        "settings": {
        "foreground":"#${normal_magenta}" //E
        }
    },
    {
        "name": "Keyword",
        "scope": [
        "keyword.other.using",
        "keyword.other.namespace",
        "keyword.other.class",
        "keyword.other.new",
        "keyword.other.event",
        "keyword.other.this",
        "keyword.other.await",
        "keyword.other.var",
        "keyword.other.package",
        "keyword.other.import",
        "variable.language.this",
        "storage.type.ts"
        ],
        "settings": {
        "foreground":"#${normal_magenta}" //E
        }
    },
    {
        "name": "Types, Primitives",
        "scope": ["keyword.type", "storage.type.primitive"],
        "settings": {
        "foreground":"#${normal_cyan}" //C
        }
    },
    {
        "name": "Function",
        "scope": ["storage.type.function"],
        "settings": {
        "foreground":"#${normal_blue}" //D
        }
    },
    {
        "name": "Operator, Misc",
        "scope": [
        "constant.other.color",
        "punctuation",
        "punctuation.section.class.end",
        "meta.tag",
        "punctuation.definition.tag",
        "punctuation.separator.inheritance.php",
        "punctuation.definition.tag.html",
        "punctuation.definition.tag.begin.html",
        "punctuation.definition.tag.end.html",
        "keyword.other.template",
        "keyword.other.substitution"
        ],
        "settings": {
        "foreground":"#${normal_white}" //5
        }
    },
    {
        "name": "Embedded",
        "scope": ["punctuation.section.embedded", "variable.interpolation"],
        "settings": {
        "foreground":"#${bright_magenta}" //F
        }
    },
    {
        "name": "Tag",
        "scope": [
        "entity.name.tag",
        "meta.tag.sgml",
        "markup.deleted.git_gutter"
        ],
        "settings": {
        "foreground":"#${normal_red}" //8
        }
    },
    {
        "name": "Function, Special Method",
        "scope": [
        "entity.name.function",
        "meta.function-call",
        "variable.function",
        "support.function",
        "keyword.other.special-method"
        ],
        "settings": {
        "foreground":"#${normal_blue}" //D
        }
    },
    {
        "name": "Block Level Variables",
        "scope": ["meta.block variable.other"],
        "settings": {
        "foreground":"#${normal_red}" //8
        }
    },
    {
        "name": "Other Variable, String Link",
        "scope": ["support.other.variable", "string.other.link"],
        "settings": {
        "foreground":"#${normal_red}" //8
        }
    },
    {
        "name": "Number, Constant, Function Argument, Tag Attribute, Embedded",
        "scope": [
        "constant.numeric",
        "constant.language",
        "support.constant",
        "constant.character",
        "constant.escape",
        "keyword.other.unit",
        "keyword.other"
        ],
        "settings": {
        "foreground":"#${bright_red}" //9
        }
    },
    {
        "name": "String, Symbols, Inherited Class, Markup Heading",
        "scope": [
        "string",
        "constant.other.symbol",
        "constant.other.key",
        "entity.other.inherited-class",
        "markup.heading",
        "markup.inserted.git_gutter",
        "meta.group.braces.curly constant.other.object.key.js string.unquoted.label.js"
        ],
        "settings": {
        "fontStyle": "",
        "foreground":"#${normal_green}" //B
        }
    },
    {
        "name": "Class, Support",
        "scope": [
        "entity.name",
        "support.type",
        "support.class",
        "support.other.namespace.use.php",
        "meta.use.php",
        "support.other.namespace.php",
        "markup.changed.git_gutter",
        "support.type.sys-types"
        ],
        "settings": {
        "foreground":"#${normal_yellow}" //A
        }
    },
    {
        "name": "Storage Type, Import Class",
        "scope": [
        "storage.type",
        "storage.modifier.package",
        "storage.modifier.import"
        ],
        "settings": {
        "foreground":"#${normal_yellow}" //A
        }
    },
    {
        "name": "Fields",
        "scope": ["entity.name.variable.field"],
        "settings": {
        "foreground":"#${normal_blue}" //D
        }
    },
    {
        "name": "Entity Types",
        "scope": ["support.type"],
        "settings": {
        "foreground":"#${normal_cyan}" //C
        }
    },
    {
        "name": "CSS Class and Support",
        "scope": [
        "source.css support.type.property-name",
        "source.sass support.type.property-name",
        "source.scss support.type.property-name",
        "source.less support.type.property-name",
        "source.stylus support.type.property-name",
        "source.postcss support.type.property-name"
        ],
        "settings": {
        "foreground":"#${normal_cyan}" //C
        }
    },
    {
        "name": "Sub-methods",
        "scope": [
        "entity.name.module.js",
        "variable.import.parameter.js",
        "variable.other.class.js"
        ],
        "settings": {
        "foreground":"#${normal_red}" //8
        }
    },
    {
        "name": "Language methods",
        "scope": ["variable.language"],
        "settings": {
        "fontStyle": "italic",
        "foreground":"#${normal_red}" //8
        }
    },
    {
        "name": "entity.name.method.js",
        "scope": ["entity.name.method.js"],
        "settings": {
        "fontStyle": "italic",
        "foreground":"#${normal_blue}" //D
        }
    },
    {
        "name": "meta.method.js",
        "scope": [
        "meta.class-method.js entity.name.function.js",
        "variable.function.constructor"
        ],
        "settings": {
        "foreground":"#${normal_blue}" //D
        }
    },
    {
        "name": "Attributes",
        "scope": ["entity.other.attribute-name"],
        "settings": {
        "foreground":"#${normal_blue}" //D
        }
    },
    {
        "name": "HTML Attributes",
        "scope": [
        "text.html.basic entity.other.attribute-name.html",
        "text.html.basic entity.other.attribute-name"
        ],
        "settings": {
        "fontStyle": "italic",
        "foreground":"#${normal_yellow}" //A
        }
    },
    {
        "name": "CSS Classes",
        "scope": ["entity.other.attribute-name.class"],
        "settings": {
        "foreground":"#${normal_yellow}" //A
        }
    },
    {
        "name": "CSS ID's",
        "scope": ["source.sass keyword.control"],
        "settings": {
        "foreground":"#${normal_blue}" //D
        }
    },
    {
        "name": "Inserted",
        "scope": ["markup.inserted"],
        "settings": {
        "foreground":"#${normal_green}" //B
        }
    },
    {
        "name": "Deleted",
        "scope": ["markup.deleted"],
        "settings": {
        "foreground":"#${normal_red}" //8
        }
    },
    {
        "name": "Changed",
        "scope": ["markup.changed"],
        "settings": {
        "foreground":"#${normal_magenta}" //E
        }
    },
    {
        "name": "Regular Expressions",
        "scope": ["string.regexp"],
        "settings": {
        "foreground":"#${normal_cyan}" //C
        }
    },
    {
        "name": "Escape Characters",
        "scope": ["constant.character.escape"],
        "settings": {
        "foreground":"#${normal_cyan}" //C
        }
    },
    {
        "name": "URL",
        "scope": ["*url*", "*link*", "*uri*"],
        "settings": {
        "fontStyle": "underline"
        }
    },
    {
        "name": "Decorators",
        "scope": [
        "tag.decorator.js entity.name.tag.js",
        "tag.decorator.js punctuation.definition.tag.js"
        ],
        "settings": {
        "fontStyle": "italic",
        "foreground":"#${normal_blue}" // D
        }
    },
    {
        "name": "ES7 Bind Operator",
        "scope": [
        "source.js constant.other.object.key.js string.unquoted.label.js"
        ],
        "settings": {
        "fontStyle": "italic",
        "foreground":"#${normal_magenta}" //E
        }
    },
    {
        "name": "JSON Key - Level 0",
        "scope": [
        "source.json meta.structure.dictionary.json support.type.property-name.json"
        ],
        "settings": {
        "foreground":"#${normal_blue}" //D
        }
    },
    {
        "name": "JSON Key - Level 1",
        "scope": [
        "source.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json support.type.property-name.json"
        ],
        "settings": {
        "foreground":"#${normal_blue}" //D
        }
    },
    {
        "name": "JSON Key - Level 2",
        "scope": [
        "source.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json support.type.property-name.json"
        ],
        "settings": {
        "foreground":"#${normal_blue}" //D
        }
    },
    {
        "name": "JSON Key - Level 3",
        "scope": [
        "source.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json support.type.property-name.json"
        ],
        "settings": {
        "foreground":"#${normal_blue}" //D
        }
    },
    {
        "name": "JSON Key - Level 4",
        "scope": [
        "source.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json support.type.property-name.json"
        ],
        "settings": {
        "foreground":"#${normal_blue}" //D
        }
    },
    {
        "name": "JSON Key - Level 5",
        "scope": [
        "source.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json support.type.property-name.json"
        ],
        "settings": {
        "foreground":"#${normal_blue}" //D
        }
    },
    {
        "name": "JSON Key - Level 6",
        "scope": [
        "source.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json support.type.property-name.json"
        ],
        "settings": {
        "foreground":"#${normal_blue}" //D
        }
    },
    {
        "name": "JSON Key - Level 7",
        "scope": [
        "source.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json support.type.property-name.json"
        ],
        "settings": {
        "foreground":"#${normal_blue}" //D
        }
    },
    {
        "name": "JSON Key - Level 8",
        "scope": [
        "source.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json support.type.property-name.json"
        ],
        "settings": {
        "foreground":"#${normal_blue}" //D
        }
    },
    {
        "name": "Markdown - Plain",
        "scope": [
        "text.html.markdown",
        "punctuation.definition.list_item.markdown"
        ],
        "settings": {
        "foreground":"#${normal_white}" //5
        }
    },
    {
        "name": "Markdown - Markup Raw Inline",
        "scope": ["text.html.markdown markup.inline.raw.markdown"],
        "settings": {
        "foreground":"#${normal_magenta}" //E
        }
    },
    {
        "name": "Markdown - Markup Raw Inline Punctuation",
        "scope": [
        "text.html.markdown markup.inline.raw.markdown punctuation.definition.raw.markdown"
        ],
        "settings": {
        "foreground":"#${normal_cyan}" //C
        }
    },
    {
        "name": "Markdown - Line Break",
        "scope": ["text.html.markdown meta.dummy.line-break"],
        "settings": {
        "foreground":"#${bright_black}" //3
        }
    },
    {
        "name": "Markdown - Heading",
        "scope": [
        "markdown.heading",
        "markup.heading | markup.heading entity.name",
        "markup.heading.markdown punctuation.definition.heading.markdown"
        ],
        "settings": {
        "foreground":"#${normal_blue}" //D
        }
    },
    {
        "name": "Markup - Italic",
        "scope": ["markup.italic"],
        "settings": {
        "fontStyle": "italic",
        "foreground":"#${normal_red}" //8
        }
    },
    {
        "name": "Markup - Bold",
        "scope": ["markup.bold", "markup.bold string"],
        "settings": {
        "fontStyle": "bold",
        "foreground":"#${normal_red}" //8
        }
    },
    {
        "name": "Markup - Bold-Italic",
        "scope": [
        "markup.bold markup.italic",
        "markup.italic markup.bold",
        "markup.quote markup.bold",
        "markup.bold markup.italic string",
        "markup.italic markup.bold string",
        "markup.quote markup.bold string"
        ],
        "settings": {
        "fontStyle": "bold",
        "foreground":"#${normal_red}" //8
        }
    },
    {
        "name": "Markup - Underline",
        "scope": ["markup.underline"],
        "settings": {
        "fontStyle": "underline",
        "foreground":"#${bright_red}" //9
        }
    },
    {
        "name": "Markdown - Blockquote",
        "scope": ["markup.quote punctuation.definition.blockquote.markdown"],
        "settings": {
        "foreground":"#${normal_cyan}" //C
        }
    },
    {
        "name": "Markup - Quote",
        "scope": ["markup.quote"],
        "settings": {
        "fontStyle": "italic"
        }
    },
    {
        "name": "Markdown - Link",
        "scope": ["string.other.link.title.markdown"],
        "settings": {
        "foreground":"#${normal_blue}" //D
        }
    },
    {
        "name": "Markdown - Link Description",
        "scope": ["string.other.link.description.title.markdown"],
        "settings": {
        "foreground":"#${normal_magenta}" //E
        }
    },
    {
        "name": "Markdown - Link Anchor",
        "scope": ["constant.other.reference.link.markdown"],
        "settings": {
        "foreground":"#${normal_yellow}" //A
        }
    },
    {
        "name": "Markup - Raw Block",
        "scope": ["markup.raw.block"],
        "settings": {
        "foreground":"#${normal_magenta}" //E
        }
    },
    {
        "name": "Markdown - Raw Block Fenced",
        "scope": ["markup.raw.block.fenced.markdown"],
        "settings": {
        "foreground": "#00000050"
        }
    },
    {
        "name": "Markdown - Fenced Bode Block",
        "scope": ["punctuation.definition.fenced.markdown"],
        "settings": {
        "foreground": "#00000050"
        }
    },
    {
        "name": "Markdown - Fenced Code Block Variable",
        "scope": [
        "markup.raw.block.fenced.markdown",
        "variable.language.fenced.markdown"
        ],
        "settings": {
        "foreground":"#${normal_magenta}" //E
        }
    },
    {
        "name": "Markdown - Fenced Language",
        "scope": ["variable.language.fenced.markdown"],
        "settings": {
        "foreground":"#${normal_red}" //8
        }
    },
    {
        "name": "Markdown - Separator",
        "scope": ["meta.separator"],
        "settings": {
        "fontStyle": "bold",
        "foreground":"#${normal_cyan}" //C
        }
    },
    {
        "name": "Markup - Table",
        "scope": ["markup.table"],
        "settings": {
        "foreground":"#${normal_magenta}" //E
        }
    },
    {
        "scope": "token.info-token",
        "settings": {
        "foreground":"#${normal_blue}" //D
        }
    },
    {
        "scope": "token.warn-token",
        "settings": {
        "foreground":"#${normal_yellow}" //A
        }
    },
    {
        "scope": "token.error-token",
        "settings": {
        "foreground":"#${normal_red}" //8
        }
    },
    {
        "scope": "token.debug-token",
        "settings": {
        "foreground":"#${normal_magenta}" //E
        }
    }
    ]
}
EOF

extension_name="tintedtheming.base16-tinted-themes"

install_cursor_extension() {
    is_extension_installed=$(cursor --list-extensions | grep "${extension_name}")
    if [[ -z "$is_extension_installed" ]]; then
        cursor --install-extension $extension_name
        sleep 3
    fi
}

cursor_paths=(
    "$HOME/.cursor/extensions/"
)
find_cursor_extension_dir() {
    for path in "${cursor_paths[@]}"; do
        if [[ -d "$path" ]]; then
            install_path=$(find "$path" -maxdepth 1 -type d -name "${extension_name}-*" | head -n1)
        fi
    done
}

modify_extension_manifest() {
    omarchy_entry=$(cat $install_path/package.json | jq 'first(.contributes.themes[] | select(.label == "Omarchy"))')
    if [[ -z "$omarchy_entry" ]]; then
        omarchy_entry='{"label": "Omarchy", "uiTheme": "vs-dark", "path": "./themes/base16/omarchy.json"}'
        new_manifest=$(cat "${install_path}/package.json" | jq --argjson theme "$omarchy_entry" '.contributes.themes += [$theme]')
        echo "$new_manifest" > "${install_path}/package.json"
    fi
}

install_cursor_extension
find_cursor_extension_dir
modify_extension_manifest

install_location="$install_path/themes/base16/omarchy.json"
cp "$output_file" "$install_location"

require_restart "cursor"
success "Cursor theme updated!"
exit 0
