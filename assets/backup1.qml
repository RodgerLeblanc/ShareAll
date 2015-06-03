/*
 * Copyright (c) 2011-2014 BlackBerry Limited.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import bb.platform 1.3
import bb.cascades 1.4
import bb.system 1.2
import bb.multimedia 1.0
import bb.device 1.0
import QtQuick 1.0
import bb.cascades.pickers 1.0


NavigationPane {
    id: navigationPane
    property bool copiedToClipboard: false
    
    onCopiedToClipboardChanged: {
        console.log("onCopiedToClipboardChanged: " + copiedToClipboard)
        if (copiedToClipboard) {
            toast.show()
        }
    }
    onPopTransitionEnded: {
        Application.menuEnabled = true
        if (page.objectName == "SettingsPage") {
            page.save()
            updateGuiFromSettings()
        }
        page.destroy()
    }
    function updateGuiFromSettings() {
    
    }
    
    Menu.definition: MenuDefinition {
        helpAction: HelpActionItem {
            title: qsTr("Contact Us")
            imageSource: "asset:///images/contact.png"
            onTriggered: {
                invoke1.query.setMimeType("text/plain")
                var subject = "Support for " + Application.applicationName + " " + Application.applicationVersion
                var body = ""
                var uri = "mailto:hugsofts@gmail.com?subject=" + subject + "&body=" + body
                invoke1.query.setUri(uri)
                invoke1.query.setInvokeTargetId("sys.pim.uib.email.hybridcomposer")
                invoke1.query.updateQuery() 
            }
        }
        
        settingsAction: SettingsActionItem 
        {
            title: qsTr("Settings")
            imageSource: "asset:///images/settings.png"
            onTriggered: {
                
                navigationPane.push(settingsPageDefinition.createObject())
            }
        }
        actions: [
            
            /*     ActionItem {
             title: qsTr("Review") + Retranslate.onLanguageChanged
             imageSource: "asset:///images/ic_review.png"
             onTriggered: {
             invoke3.query.uri = "appworld://content/59956020"
             invoke3.query.updateQuery()
             }
             
             },*/
            ActionItem {
                title: qsTr("About") + Retranslate.onLanguageChanged
                imageSource: "asset:///images/ic_help.png"
                onTriggered: {
                    navigationPane.push(pabout.createObject())
                }
            },
            
            
            ActionItem {
                title: "BBM Channel"
                imageSource: "asset:///images/bbm.png"
                attachedObjects: [
                    Invocation {
                        id: invokeBBMChannel
                        query {
                            invokeTargetId: "sys.bbm.channels.card.previewer"
                            invokeActionId: "bb.action.OPENBBMCHANNEL"
                            uri: "bbmc:C00370A37"
                        }
                    }
                ]
                onTriggered: {
                    invokeBBMChannel.trigger("bb.action.OPENBBMCHANNEL")
                }
            },
            /*     ActionItem {
             id: update
             imageSource: "asset:///images/update.png"
             title: qsTr("Update") + Retranslate.onLanguageChanged
             ActionBar.placement: ActionBarPlacement.OnBar
             enabled: bbmHandler.allowed
             onTriggered: {
             bbmHandler.setPersonalMessage("I am using NoteEdit app")
             }
             },*/
            ActionItem {
                id: invite
                imageSource: "asset:///images/invite.png"
                title: qsTr("Invite") + Retranslate.onLanguageChanged
                ActionBar.placement: ActionBarPlacement.OnBar
                enabled: bbmHandler.allowed
                onTriggered: {
                    bbmHandler.sendInvite();
                }
            }
        ] 
    
    }
    
    Page {
        property bool saved: true
        
        actions: [
            
            /*    ActionItem {
             title: qsTr("Save")
             imageSource: "asset:///ic_save.png"
             ActionBar.placement: ActionBarPlacement.InOverflow
             
             onTriggered: {
             saved = _fileSaver.save(textArea.text)
             systemToast.show()
             }
             },
             ActionItem {
             title: qsTr("Save as")
             imageSource: "asset:///ic_save.png"
             ActionBar.placement: ActionBarPlacement.Signature
             
             onTriggered: {
             prompt.show()  
             }
             },*/
            /*      ActionItem {
             title: qsTr("am")
             imageSource: "asset:///ic_save.png"
             ActionBar.placement: ActionBarPlacement.OnBar
             onTriggered: {
             psaveas.query.invokeActionId = "bb.action.open";
             psaveas.query.mimeType = "text/plain"
             psaveas.query.invokeTargetId ="bb.action.view"
             psaveas.query.data =  saved = _fileSaver.save(textArea.text)
             systemToast.show();
             
             }
             },*/
            ActionItem {
                
                id: copyImageButton
                imageSource: "asset:///images/ic_copy.png" 
                enabled: !copiedToClipboard
                title: "Copy to clipboard"
                ActionBar.placement: ActionBarPlacement.InOverflow
                onTriggered: {
                    
                    copiedToClipboard = app.copyToClipboard(textArea.text)
                    toast.show()
                
                }
            
            },
            
            ActionItem {
                title: "Share"
                ActionBar.placement: ActionBarPlacement.InOverflow
                imageSource: "asset:///ic_share.png"
                onTriggered: {
                    shareInvoke.query.invokeActionId = "bb.action.SHARE";
                    shareInvoke.query.mimeType = "text/plain"
                    shareInvoke.query.data = textArea.text 
                    shareInvoke.query.updateQuery()
                }
            },
            ActionItem {
                title: "Share to facebook"
                ActionBar.placement: ActionBarPlacement.InOverflow
                imageSource: "asset:///images/faceBook.png"
                onTriggered: {
                    facebook.query.invokeActionId = "bb.action.SHARE";
                    facebook.query.invokeTargetId = "Facebook"
                    facebook.query.mimeType = "text/plain"
                    facebook.query.data = textArea.text 
                    facebook.query.updateQuery()
                }
            },
            ActionItem {
                title: "Share to twitter"
                ActionBar.placement: ActionBarPlacement.InOverflow
                imageSource: "asset:///images/twitter.png"
                onTriggered: {
                    twitter.query.invokeActionId = "bb.action.SHARE";
                    twitter.query.invokeTargetId = "Twitter"
                    twitter.query.mimeType = "text/plain"
                    twitter.query.data = textArea.text 
                    twitter.query.updateQuery()
                }
            },
            
            ActionItem {
                title: "Share to LinkedIn "
                ActionBar.placement: ActionBarPlacement.InOverflow
                imageSource: "asset:///images/linkedIn.png"
                onTriggered: {
                    linkin.query.invokeActionId = "bb.action.SHARE";
                    linkin.query.invokeTargetId = "LinkedIn"
                    linkin.query.mimeType = "text/plain"
                    linkin.query.data = textArea.text 
                    linkin.query.updateQuery()
                }
            },
            
            ActionItem {
                id: settingsAction
                ActionBar.placement: ActionBarPlacement.InOverflow
                title: qsTr("Theme change")
                imageSource: "asset:///images/settings.png"
                onTriggered: {
                    Application.menuEnabled = false
                    var page = settingsPageDefinition.createObject();
                    push(page);
                }
            },
            ActionItem {
                title: "Search"
                ActionBar.placement: ActionBarPlacement.InOverflow
                imageSource: "asset:///images/ic_search.png"
                onTriggered: {
                    search.query.invokeActionId = "bb.action.OPEN";
                    search.query.invokeTargetId = "sys.search"
                    search.query.mimeType = "text/plain"
                    search.query.data = textArea.text 
                    search.query.updateQuery()
                }
            },
            /*   ActionItem {
             title: qsTr("Review") + Retranslate.onLanguageChanged
             imageSource: "asset:///images/ic_review.png"
             onTriggered: {
             invoke2.query.uri = "appworld://content/59956020"
             invoke2.query.updateQuery()
             invoke2.trigger("bb.action.OPEN")
             }
             },*/
ActionItem {
                
                
                title: "BBM Channel"
                imageSource: "asset:///images/bbm.png"
                attachedObjects: [
                    Invocation {
                        id: invokeBBMChannel1
                        query {
                            invokeTargetId: "sys.bbm.channels.card.previewer"
                            invokeActionId: "bb.action.OPENBBMCHANNEL"
                            uri: "bbmc:C00370A37"
                        }
                    }
                ]
                onTriggered: {
                    invokeBBMChannel1.trigger("bb.action.OPENBBMCHANNEL")
                }
},
ActionItem {
    id: update1
    imageSource: "asset:///images/update.png"
    title: qsTr("Update") + Retranslate.onLanguageChanged
    ActionBar.placement: ActionBarPlacement.InOverflow
    enabled: bbmHandler.allowed
    onTriggered: {
        bbmHandler.setPersonalMessage("I am using Share Me app.")
    }
},
ActionItem {
    id: invite1
    imageSource: "asset:///images/invite.png"
    title: qsTr("Invite") + Retranslate.onLanguageChanged
    ActionBar.placement: ActionBarPlacement.InOverflow
    enabled: bbmHandler.allowed
    onTriggered: {
        bbmHandler.sendInvite();
    }
},
ActionItem {
    title: qsTr("Contact Us")
    imageSource: "asset:///images/contact.png"
    onTriggered: {
        invoke1.query.setMimeType("text/plain")
        var subject = "Support for " + Application.applicationName + " " + Application.applicationVersion
        var body = ""
        var uri = "mailto:hugsofts@gmail.com?subject=" + subject + "&body=" + body
        invoke1.query.setUri(uri)
        invoke1.query.setInvokeTargetId("sys.pim.uib.email.hybridcomposer")
        invoke1.query.updateQuery()
    }
},


ActionItem {
    title: qsTr("About") 
    imageSource: "asset:///images/ic_help.png"
    ActionBar.placement: ActionBarPlacement.InOverflow
    onTriggered: {
        navigationPane.push(pabout.createObject())
    }
}

]

attachedObjects: [
    SystemToast {
        id: systemToast
        body: saved ? "The text was saved successfully! in Save to /books/" : "The text wasn't saved..."
    },
    SystemToast {
        id: toast
        body: "Copied to Clipboard"
    },
    
    Invocation {
        id: invoke1
        onArmed: {
            trigger("bb.action.SENDEMAIL")
        }
    },
    Invocation {
        id: invoke3
        onArmed: {
            trigger("bb.action.OPEN") 
        
        }
    },
    Invocation {
        id: search
        onArmed: {
            trigger(query.invokeActionId) 
        
        }
    },
    ComponentDefinition {
        id: appCover
        source: "AppCover.qml"
    },
    Invocation {
        id: shareInvoke
        onArmed: {
            trigger(query.invokeActionId)
        }
    },
    Invocation {
        id: facebook
        onArmed: {
            trigger(query.invokeActionId)
        }
    },
    Invocation {
        id: twitter
        onArmed: {
            trigger(query.invokeActionId)
        }
    },
    Invocation {
        id: linkin
        onArmed: {
            trigger(query.invokeActionId)
        }
    },
    Invocation {
        id: bbm1
        onArmed: {
            trigger(query.invokeActionId)
        }
    },
    Invocation {
        id: bbmg
        onArmed: {
            trigger(query.invokeActionId)
        }
    },
    Invocation {
        id: bbmc
        onArmed: {
            trigger(query.invokeActionId)
        }
    },
    Invocation {
        id: silent
        onArmed: {
            trigger(query.invokeActionId)
        }
    },
    Invocation {
        id: bulet
        onArmed: {
            trigger(query.invokeActionId)
        }
    },
    Invocation {
        id: bumblr
        onArmed: {
            trigger(query.invokeActionId)
        }
    },
    Invocation {
        id: whatsapp
        onArmed: {
            trigger(query.invokeActionId)
        }
    },
    Invocation {
        id: blaq
        onArmed: {
            trigger(query.invokeActionId)
        }
    },
    Invocation {
        id: head
        onArmed: {
            trigger(query.invokeActionId)
        }
    },
    Invocation {
        id: bookmark
        onArmed: {
            trigger(query.invokeActionId)
        }
    },
    Invocation {
        id: psaveas
        onArmed: {
            trigger("bb.action.OPEN")
        }
    },
    ComponentDefinition {
        id: pabout
        source: "about.qml"
    },
    ComponentDefinition {
        id: settingsPageDefinition
        source: "SettingsPage.qml"
    },
    SystemPrompt {
        
        
        id: prompt
        title: "Enter a new file name" 
        inputField.emptyText: qsTr("Enter a new file name")
        onFinished: {
            switch(value)
            {
                case (SystemUiResult.ConfirmButtonSelection):{
                        saved = _fileSaver.save(textArea.text, inputFieldTextEntry())
                        systemToast.show()
                }
            }
        }
    }
]

titleBar: TitleBar {
    title: "Share Me"
}


function updateGuiFromSettings() {

}
Container {
    topPadding: 20
    Container {
        layout: StackLayout {
            orientation: LayoutOrientation.LeftToRight
        
        }
        Button {
            layoutProperties: StackLayoutProperties {
            
            }
            id: hash
            text: "#"
            onClicked: {
                textArea.text = textArea.text + "#";
            }
            margin.leftOffset: 20.0
            margin.rightOffset: 400.0
            color: Color.DarkGray
        
        }
        Button {
            id: atth
            text: "@"
            onClicked: {
                textArea.text = textArea.text + "@";                
            }
            margin.leftOffset: 400.0
            margin.rightOffset: 20.0
            color: Color.DarkGray
        
        
        }
    }
    TextArea {
        
        id: textArea
        hintText: "Write something"
        textStyle.fontSize: FontSize.Medium
        maximumLength: 100000
        autoSize.maxLineCount: 10000
        textStyle.textAlign: TextAlign.Justify
        textFormat: TextFormat.Plain
        scrollMode: TextAreaScrollMode.Elastic
    }
    ScrollView {
        scrollViewProperties.scrollMode: ScrollMode.Horizontal
        
        scrollViewProperties.maxContentScale: 1.7
        Container {
            
            
            
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            
            }
            
            margin.leftOffset: 10.0
            ImageButton {
                
                
                id: fb
                layoutProperties: StackLayoutProperties {
                
                }
                defaultImageSource: "asset:///icon/128-facebook.png"
                horizontalAlignment: HorizontalAlignment.Left
                onClicked: {
                    facebook.query.invokeActionId = "bb.action.SHARE";
                    facebook.query.invokeTargetId = "Facebook"
                    facebook.query.mimeType = "text/plain"
                    facebook.query.data = textArea.text 
                    facebook.query.updateQuery()
                }
                margin.rightOffset: -15.0
                margin.leftOffset: 1.0
            
            }
            
            ImageButton {
                layoutProperties: StackLayoutProperties {
                
                }
                id: ln
                defaultImageSource: "asset:///icon/128-linkedin.png"
                horizontalAlignment: HorizontalAlignment.Right
                onClicked: {
                    linkin.query.invokeActionId = "bb.action.SHARE";
                    linkin.query.invokeTargetId = "LinkedIn"
                    linkin.query.mimeType = "text/plain"
                    linkin.query.data = textArea.text 
                    linkin.query.updateQuery()
                }
            }
            ImageButton {
                layoutProperties: StackLayoutProperties {
                
                }
                id: blaq1
                defaultImageSource: "asset:///icon/blaq.png"
                horizontalAlignment: HorizontalAlignment.Right
                onClicked: {
                    blaq.query.invokeActionId = "bb.action.SHARE";
                    blaq.query.invokeTargetId = "com.kisailabs.blaq.BB10.composer"
                    blaq.query.mimeType = "text/plain"
                    blaq.query.data = textArea.text 
                    blaq.query.updateQuery()
                }
            }
            ImageButton {
                layoutProperties: StackLayoutProperties {
                
                }
                
                id: tw
                defaultImageSource: "asset:///icon/128-twitter.png"
                horizontalAlignment: HorizontalAlignment.Center
                onClicked: {
                    twitter.query.invokeActionId = "bb.action.SHARE";
                    twitter.query.invokeTargetId = "Twitter"
                    twitter.query.mimeType = "text/plain"
                    twitter.query.data = textArea.text 
                    twitter.query.updateQuery()
                }
            
            }
            ImageButton {
                layoutProperties: StackLayoutProperties {
                
                }
                id: twittly
                defaultImageSource: "asset:///icon/twittly.png"
                horizontalAlignment: HorizontalAlignment.Right
                onClicked: {
                    bookmark.query.invokeActionId = "bb.action.SHARE";
                    bookmark.query.invokeTargetId = "com.nemory.twittly.blackberry.card.sharetext"
                    bookmark.query.mimeType = "text/plain"
                    bookmark.query.data = textArea.text 
                    bookmark.query.updateQuery()
                }
            }
            ImageButton {
                layoutProperties: StackLayoutProperties {
                
                }
                id: neatly
                defaultImageSource: "asset:///icon/neatly.png"
                horizontalAlignment: HorizontalAlignment.Right
                onClicked: {
                    bookmark.query.invokeActionId = "bb.action.SHARE";
                    bookmark.query.invokeTargetId = "com.f16apps.Neatly.share"
                    bookmark.query.mimeType = "text/plain"
                    bookmark.query.data = textArea.text 
                    bookmark.query.updateQuery()
                }
            }
            ImageButton {
                layoutProperties: StackLayoutProperties {
                
                }
                id:whtap
                defaultImageSource: "asset:///icon/whatsapp.png"
                horizontalAlignment: HorizontalAlignment.Right
                onClicked: {
                    whatsapp.query.invokeActionId = "bb.action.SHARE";
                    whatsapp.query.invokeTargetId = "com.whatsapp.WhatsApp.invoke.share"
                    whatsapp.query.mimeType = "text/plain"
                    whatsapp.query.data = textArea.text 
                    whatsapp.query.updateQuery()
                }
            }
            ImageButton {
                layoutProperties: StackLayoutProperties {
                
                }
                id: reddit
                defaultImageSource: "asset:///icon/reddit.png"
                horizontalAlignment: HorizontalAlignment.Right
                onClicked: {
                    bookmark.query.invokeActionId = "bb.action.SHARE";
                    bookmark.query.invokeTargetId = "com.reddit.share"
                    bookmark.query.mimeType = "text/plain"
                    bookmark.query.data = textArea.text 
                    bookmark.query.updateQuery()
                }
            }
            ImageButton {
                layoutProperties: StackLayoutProperties {
                
                }
                id: bbmm
                defaultImageSource: "asset:///icon/icon_w.png"
                horizontalAlignment: HorizontalAlignment.Right
                onClicked: {
                    bbm1.query.invokeActionId = "bb.action.SHARE";
                    bbm1.query.invokeTargetId = "sys.bbm.sharehandler"
                    bbm1.query.mimeType = "text/plain"
                    bbm1.query.data = textArea.text 
                    bbm1.query.updateQuery()
                }
            }
            ImageButton {
                layoutProperties: StackLayoutProperties {
                
                }
                id: bbmgrp
                defaultImageSource: "asset:///icon/groups.png"
                horizontalAlignment: HorizontalAlignment.Right
                onClicked: {
                    bbmg.query.invokeActionId = "bb.action.SHARE";
                    bbmg.query.invokeTargetId = "sys.bbgroups.sharehandler"
                    bbmg.query.mimeType = "text/plain"
                    bbmg.query.data = textArea.text 
                    bbmg.query.updateQuery()
                }
            }
            ImageButton {
                layoutProperties: StackLayoutProperties {
                
                }
                id: bbmch
                defaultImageSource: "asset:///icon/ic_bbmchannels.png"
                horizontalAlignment: HorizontalAlignment.Right
                onClicked: {
                    bbmc.query.invokeActionId = "bb.action.SHARE";
                    bbmc.query.invokeTargetId = "sys.bbm.channels.sharehandler"
                    bbmc.query.mimeType = "text/plain"
                    bbmc.query.data = textArea.text 
                    bbmc.query.updateQuery()
                }
            }
            ImageButton {
                layoutProperties: StackLayoutProperties {
                
                }
                id: silentkey
                defaultImageSource: "asset:///icon/silent.png"
                horizontalAlignment: HorizontalAlignment.Right
                onClicked: {
                    silent.query.invokeActionId = "bb.action.SHARE";
                    silent.query.invokeTargetId = "com.RogerLeblanc.SilentKeys.sharecomposer"
                    silent.query.mimeType = "text/plain"
                    silent.query.data = textArea.text 
                    silent.query.updateQuery()
                }
            }
            ImageButton {
                layoutProperties: StackLayoutProperties {
                
                }
                id: bumbl
                defaultImageSource: "asset:///icon/bumblr.png"
                horizontalAlignment: HorizontalAlignment.Right
                onClicked: {
                    bumblr.query.invokeActionId = "bb.action.SHARE";
                    bumblr.query.invokeTargetId = "com.shwstppr.bumblr.invocation.sharetext"
                    bumblr.query.mimeType = "text/plain"
                    bumblr.query.data = textArea.text 
                    bumblr.query.updateQuery()
                }
            }
            ImageButton {
                layoutProperties: StackLayoutProperties {
                
                }
                id:headsup
                defaultImageSource: "asset:///icon/head.png"
                horizontalAlignment: HorizontalAlignment.Right
                onClicked: {
                    head.query.invokeActionId = "bb.action.SHARE";
                    head.query.invokeTargetId = "tcs.headsup.textinvoke"
                    head.query.mimeType = "text/plain"
                    head.query.data = textArea.text 
                    head.query.updateQuery()
                }
            }
            
            ImageButton {
                layoutProperties: StackLayoutProperties {
                
                }
                id:blacbult
                defaultImageSource: "asset:///icon/blackbullet.png"
                horizontalAlignment: HorizontalAlignment.Right
                onClicked: {
                    bulet.query.invokeActionId = "bb.action.SHARE";
                    bulet.query.invokeTargetId = "helex.BlackBullet"
                    bulet.query.mimeType = "text/plain"
                    bulet.query.data = textArea.text 
                    bulet.query.updateQuery()
                }
            }
            ImageButton {
                layoutProperties: StackLayoutProperties {
                
                }
                id:turbo
                defaultImageSource: "asset:///icon/turbo.png"
                horizontalAlignment: HorizontalAlignment.Right
                onClicked: {
                    bulet.query.invokeActionId = "bb.action.SHARE";
                    bulet.query.invokeTargetId = "helex.TurboReader"
                    bulet.query.mimeType = "text/plain"
                    bulet.query.data = textArea.text 
                    bulet.query.updateQuery()
                }
            }
            
            ImageButton {
                layoutProperties: StackLayoutProperties {
                
                }
                id: bookmrk
                defaultImageSource: "asset:///icon/bookmark.png"
                horizontalAlignment: HorizontalAlignment.Right
                onClicked: {
                    bookmark.query.invokeActionId = "bb.action.SHARE";
                    bookmark.query.invokeTargetId = "com.sasha.BookmarkPro"
                    bookmark.query.mimeType = "text/plain"
                    bookmark.query.data = textArea.text 
                    bookmark.query.updateQuery()
                }
            }
            
            ImageButton {
                
                id: copyImageButton1
                defaultImageSource: "asset:///icon/clip1.png" 
                enabled: !copiedToClipboard
                ActionBar.placement: ActionBarPlacement.InOverflow
                onClicked: {
                    
                    copiedToClipboard = app.copyToClipboard(textArea.text)
                
                }
            
            }
        
        
        
        }
    
    
    
    }
}
    }

}