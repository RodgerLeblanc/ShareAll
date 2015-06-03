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
#include "src/Settings/Settings.h"
#include "bbm/BBMHandler.hpp"
#include "activeFrameQML.h"
#include <QObject>

#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>
#include <bb/cascades/LocaleHandler>
#include <bb/system/SystemPrompt>
#include <bb/system/SystemToast>
#include <bb/system/SystemUiButton>
#include <bb/cascades/AbstractCover>
#include <QUrl>
#include <bb/system/InvokeManager>
#include <QList>
#include <QTimer>
#include <bb/cascades/InvokeQuery>
#include <bb/cascades/Invocation>
#include <bb/cascades/Page>
#include <bb/cascades/MultiSelectHandler>
#include <bb/cascades/TextArea>

using namespace bb::cascades;
using namespace bb::system;


ApplicationUI::ApplicationUI(bb::cascades::Application *app) :
    QObject(),
    m_pTranslator(new QTranslator(this)),
    m_pLocaleHandler(new LocaleHandler(this)),
    m_invokeManager(new InvokeManager(this)),
    settings(new Settings(this))
{


    qDebug() << "Registering QTimer for easy QML access";
    qmlRegisterType<QTimer>("Roger.CustomTimer", 1, 0, "Timer");

    qmlRegisterType<SceneCover>("bb.cascades", 1, 2, "SceneCover");
    qmlRegisterUncreatableType<AbstractCover>("bb.cascades", 1, 2, "AbstractCover", "");

    bool res = QObject::connect(m_pLocaleHandler, SIGNAL(systemLanguageChanged()), this, SLOT(onSystemLanguageChanged()));
    // This is only available in Debug builds
    Q_ASSERT(res);
    // Since the variable is not used in the app, this is added to avoid a
    // compiler warning
    Q_UNUSED(res);

    // initial load
    onSystemLanguageChanged();

    // Listen to incoming invocation requests
    connect(m_invokeManager, SIGNAL(invoked(const bb::system::InvokeRequest&)),
                      this, SLOT(handleInvoke(const bb::system::InvokeRequest&)));

    connect(m_invokeManager,
                 SIGNAL(cardResizeRequested(const bb::system::CardResizeMessage&)),
                 this, SLOT(resized(const bb::system::CardResizeMessage&)));

    connect(m_invokeManager,
                 SIGNAL(cardPooled(const bb::system::CardDoneMessage&)), this,
                 SLOT(pooled(const bb::system::CardDoneMessage&)));

    // Initialize properties with default values
    switch (m_invokeManager->startupMode()) {
    case ApplicationStartupMode::LaunchApplication:
        initFullUI();


        TextArea* myTextArea = Application::instance()->scene()->findChild<TextArea*>("myTextAreaObjectName");
                                 myTextArea->setText(QString::fromUtf8(request.data()));
        break;

    case ApplicationStartupMode::InvokeApplication:
        // Wait for invoked signal to determine and initialize the appropriate UI
        break;
    case ApplicationStartupMode::InvokeCard:
        // Wait for invoked signal to determine and initialize the appropriate UI
        break;
    case ApplicationStartupMode::InvokeViewer:
        // Wait for invoked signal to determine and initialize the appropriate UI
        break;
    default: break;
    }
    qDebug() << "End of constructor";


}

void ApplicationUI::initFullUI() {


    // Create scene document from main.qml asset, the parent is set
    // to ensure the document gets destroyed properly at shut down.
    QmlDocument *qml = QmlDocument::create("asset:///main.qml").parent(this);
    qml->setContextProperty("_app", this);

    qml->setContextProperty("_fileSaver", fileSaver);
      qml->setContextProperty("_settings", settings);

              //Expose the ApplicationUI in main.qml
              qml->setContextProperty("app", this);

              QString m_homeDir = QDir::homePath() + "/../app/native";
                 QmlDocument::defaultDeclarativeEngine()->rootContext()->setContextProperty("homeDir",m_homeDir);

                 TextArea* myTextArea = Application::instance()->scene()->findChild<TextArea*>("myTextAreaObjectName");
                                          myTextArea->setText(QString::fromUtf8(request.data()));
              // Create Active Frame (shown when app is miminized)
                     ActiveFrameQML *activeFrame = new ActiveFrameQML();
                     Application::instance()->setCover(activeFrame);

    // Create root object for the UI
    AbstractPane *root = qml->createRootObject<AbstractPane>();

    // Set created root object as the application scene
    Application::instance()->setScene(root);

    qDebug() << "End of initFullUI()";
}

void ApplicationUI::handleInvoke(const bb::system::InvokeRequest& request) {
    // Copy data from incoming invocation request to properties
    qDebug() << QString::fromLatin1("%1 (%2)").arg(request.source().installId()).arg(request.source().groupId());
    qDebug() << request.target();
    qDebug() << request.action();
    qDebug() << request.mimeType();
    qDebug() << request.uri().toString();
    qDebug() << QString::fromUtf8(request.data());

    initFullUI();
    TextArea* myTextArea = Application::instance()->scene()->findChild<TextArea*>("myTextAreaObjectName");

    if (myTextArea)
        myTextArea->setText(QString::fromUtf8(request.data()));
}




void ApplicationUI::onSystemLanguageChanged()
{
    QCoreApplication::instance()->removeTranslator(m_pTranslator);
    // Initiate, load and install the application translation files.
    QString locale_string = QLocale().name();
    QString file_name = QString("ShareMe_%1").arg(locale_string);
    if (m_pTranslator->load(file_name, "app/native/qm")) {
        QCoreApplication::instance()->installTranslator(m_pTranslator);
    }
}





QByteArray ApplicationUI::encodeQString(const QString& toEncode) const {
    return toEncode.toUtf8();
}


