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

#include "applicationui.hpp"
#include "src/bbm/BBMHandler.hpp"
#include "Clipboard.hpp"
#include "PasteClient.hpp"

#include <bb/cascades/Application>
#include <bb/system/SystemPrompt>
#include <bb/system/SystemToast>
#include <bb/cascades/QmlDocument>
#include <QLocale>
#include <QTranslator>
#include <QtDeclarative>
#include <QObject>
#include <Qt/qdeclarativedebug.h>
#include "src/Settings/Settings.h"
#include <bb/system/SystemUiButton>
#include <bb/cascades/ActionItem>
#include <bb/cascades/HelpActionItem>
#include <bb/cascades/AbstractPane>
#include <bb/system/Clipboard>
#include <bb/cascades/MultiSelectHandler>
#include <QUrl>
#include <bb/system/Invokemanager>
#include <bb/cascades/TextArea>

#include <bb/cascades/pickers/FilePicker>
#include <bb/cascades/pickers/FilePickerMode>
#include <bb/cascades/pickers/FileType>
using namespace bb::cascades;
using namespace bb::system;



Q_DECL_EXPORT int main(int argc, char **argv)
{
    Settings* settings = new Settings();
          qputenv("CASCADES_THEME", settings->value("theme", "dark").toString().toUtf8());
          settings->deleteLater();

          qmlRegisterType<bb::cascades::pickers::FilePicker>("bb.cascades.pickers", 1, 0, "FilePicker");
             qmlRegisterUncreatableType<bb::cascades::pickers::FilePickerMode>("bb.cascades.pickers", 1, 0, "FilePickerMode", "");
            qmlRegisterUncreatableType<bb::cascades::pickers::FileType>("bb.cascades.pickers", 1, 0, "FileType", "");



    Application app(argc, argv);



               PasteClient paster;
                 QmlDocument::defaultDeclarativeEngine()->rootContext()->setContextProperty("Paster", &paster);
    // Create the Application UI object, this is where the main.qml file
    // is loaded and the application scene is set.
    new ApplicationUI(&app);



    // Enter the application main event loop.
    return Application::exec();
}

