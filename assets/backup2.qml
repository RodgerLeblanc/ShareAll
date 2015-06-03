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
    
    
    
    
    Page {
        property bool saved: true
        
        actions:  [
            ActionItem {
                title: "share"
                ActionBar.placement: ActionBarPlacement.Signature
                imageSource: "asset:///ic_share.png"
                backgroundColor: Color.Gray
                onTriggered: {
                    textArea.text = textArea.text + " #ShareMe"
                
                }
            }
        ]
        
        attachedObjects: [
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
            }
        ]
        
        titleBar: TitleBar {
            title: "Share Me"
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