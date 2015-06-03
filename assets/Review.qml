import bb.cascades 1.3
ActionItem {
    title: qsTr("Review") + Retranslate.onLanguageChanged
    ActionBar.placement: ActionBarPlacement.InOverflow
    
    onTriggered: {
        invoke.query.uri = "appworld://content/59956020"
        invoke.query.updateQuery()
        invoke.trigger("bb.action.OPEN")
    }
}