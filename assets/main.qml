/*
 * Copyright (c) 2011-2015 BlackBerry Limited.
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

import bb.cascades 1.0

Page {
    ScrollView {
        Container {
            leftPadding: 30
            rightPadding: leftPadding
            topPadding: leftPadding
            Container {
                id: checkboxContainer
                CheckBox { text: "BBM" }
                CheckBox { text: "BBM Groups" }
                CheckBox { text: "Blaq" }
                CheckBox { text: "Email" }
                CheckBox { text: "Facebook" }
                CheckBox { text: "LinkedIn" }
                CheckBox { text: "Remember" }
                CheckBox { text: "SMS" }
                CheckBox { text: "Twitter" }
            }
            TextArea {
                id: textArea
                text: "Enter a message to send here"
            }
            Button { 
                text: "Share All"
                onClicked: {
                    var selected = new Array()
                    for (var i = 0; i < checkboxContainer.count(); i++) {
                        if (checkboxContainer.at(i).checked)
                            selected[selected.length] = checkboxContainer.at(i).text
                    }
                    _app.invokeSelected(selected, textArea.text)
                }
            }
        }
    }
}
