import bb.cascades 1.3

Page {
    id: settingsPage
    objectName: "SettingsPage"
    titleBar: TitleBar {
        visibility: ChromeVisibility.Visible
        scrollBehavior: TitleBarScrollBehavior.Sticky
        title: qsTr("Theme Selection")
    }
    
    
    
    Container {
        leftPadding: 20.0
        rightPadding: 20.0
        topPadding: 20.0
        bottomPadding: 20.0
        horizontalAlignment: HorizontalAlignment.Center
        DropDown {
            title: qsTr("Theme")
            Option {
                id: dark
                text: qsTr("Dark")
            }
            Option {
                id: bright
                text: qsTr("Bright")
            }
            onSelectedOptionChanged: {
                _settings.setValue("theme", selectedOption.text.toLowerCase())
                if (selectedOption.text == "Dark")
                    Application.themeSupport.setVisualStyle(VisualStyle.Dark)
                else
                    Application.themeSupport.setVisualStyle(VisualStyle.Bright)
            }
            onCreationCompleted: Application.themeSupport.theme.colorTheme.style == VisualStyle.Dark ? setSelectedOption(dark) : setSelectedOption(bright)
        }
        Label {
            text: qsTr("Changes to the visual theme will take place without application is relaunched.")
            multiline: true
        }
       
    }
    
 
}
