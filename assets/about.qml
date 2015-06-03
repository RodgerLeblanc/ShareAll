import bb.cascades 1.4

Sheet {
    id: root

Page {
    titleBar: TitleBar {
        title: qsTr("About...") + Retranslate.onLocaleOrLanguageChanged
    }    ScrollView {
        horizontalAlignment: HorizontalAlignment.Center
        Container {
            layout: DockLayout {                
            }
            topPadding: 10
            bottomPadding: 20
            horizontalAlignment: HorizontalAlignment.Center
            Container {
                Container {
                    horizontalAlignment: HorizontalAlignment.Center
                    ImageView {
                        id:logo
                        imageSource: "asset:///images/amiy.png"
                    }                 
                }
                Divider {                    
                }
                Container {
                    leftPadding: 20
                    rightPadding: 20
                    Label {
                        multiline: true
                        text: qsTr("<span style='color:#166e93'> \t\t\tPinText</span>") + Retranslate.onLocaleOrLanguageChanged
                        textFormat: TextFormat.Html
                        
                        textStyle{
                            fontSize: FontSize.XLarge
                            fontStyle: FontStyle.Italic
                        }
                    } 
                    Label {
                        multiline: true
                        text: qsTr("   Version v1.0.1") + Retranslate.onLocaleOrLanguageChanged
                        textStyle{
                            fontSize: FontSize.Medium
                            fontStyle: FontStyle.Italic
                        }
                    }                    
                }
                Divider {                    
                }
                Container {
                    leftPadding: 20
                    rightPadding: 20
                /*    Label {
                        multiline: true
                        textStyle{
                            fontSize: FontSize.Medium
                            fontStyle: FontStyle.Italic
                            textAlign: TextAlign.Justify
                        }
                        text: qsTr("   Notepad v1.0 is 1.3.1")
                    } */                   
                }
                
                
            /*    Divider {                    
                }*/
                Container {
                    leftPadding: 20
                    rightPadding: 20
                    horizontalAlignment: HorizontalAlignment.Center
                    Label {
                        multiline: true
                        textStyle{
                            fontSize: FontSize.Medium
                            fontStyle: FontStyle.Italic
                            textAlign: TextAlign.Center
                        }
                        text: qsTr("    This app is Created by Hugsoft.\n    This App is in development mode.\n    Now i have added only few features.\n    So please bear with me.\n    If you need any help than mail me.\n ")
                        horizontalAlignment: HorizontalAlignment.Center
                    }                    
                }
                
                
                
                Divider {                    
                }
                Container {
                    leftPadding: 20
                    rightPadding: 20
                    Container {
                        topPadding: 20
                        layout: StackLayout {
                            orientation: LayoutOrientation.LeftToRight
                        }
                        Label {
                            textStyle{
                                fontSize: FontSize.Medium
                                fontStyle: FontStyle.Italic
                                color: Color.create("#ff166e93")
                                textAlign: TextAlign.Right
                            }
                            text: qsTr("Developer: ") + Retranslate.onLocaleOrLanguageChanged
                        }
                        Label {                        
                            text: qsTr("<span style='color:#166e93'>HugSoft</span>") + Retranslate.onLocaleOrLanguageChanged
                            textFormat: TextFormat.Html
                            textStyle{
                                fontSize: FontSize.Medium
                                fontStyle: FontStyle.Italic
                            }
                        }
                    }
                    Container {
                        topPadding: 20
                        bottomPadding: 20
                        layout: StackLayout {
                            orientation: LayoutOrientation.LeftToRight
                        }
                        Label {
                            textStyle{
                                fontSize: FontSize.Medium
                                fontStyle: FontStyle.Italic
                                color: Color.create("#ff166e93")
                                textAlign: TextAlign.Right
                            }
                            text: qsTr("Support: ") + Retranslate.onLocaleOrLanguageChanged
                        }
                        Label {                        
                            text: qsTr("<span style='color:#166e93'>@ansdStudios\nRoger Leblanc</span>") + Retranslate.onLocaleOrLanguageChanged
                            textFormat: TextFormat.Html
                            multiline: true
                            textStyle{
                                fontSize: FontSize.Medium
                                fontStyle: FontStyle.Italic
                            }
                        }
                    } 
               /*     Divider {                        
                    }
                    Container { 
                        horizontalAlignment: HorizontalAlignment.Center                   
                        Container {
                            horizontalAlignment: HorizontalAlignment.Center
                            ImageView {
                                id:logo2
                                imageSource: "asset:///images/amit.png"
                            }                 
                        }                        
                    }
                    Divider {                        
                    }*/
                }
            }
        }        
    }
    actions: [
        ActionItem {
            title: "Back"
            imageSource: "asset:///images/ic_previous.png"
            ActionBar.placement: ActionBarPlacement.OnBar
            onTriggered: {
                root.close();
            }
        }
    
    ]
}
}