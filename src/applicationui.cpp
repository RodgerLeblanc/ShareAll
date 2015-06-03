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

#include "applicationui.hpp"

#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>
#include <bb/cascades/LocaleHandler>

#include <bb/system/InvokeManager>
#include <bb/system/InvokeTargetReply>

using namespace bb::cascades;
using namespace bb::system;

ApplicationUI::ApplicationUI() :
        QObject(),
        m_invokeManager(new InvokeManager(this))
{
    // prepare the localization
    m_pTranslator = new QTranslator(this);
    m_pLocaleHandler = new LocaleHandler(this);

    bool res = QObject::connect(m_pLocaleHandler, SIGNAL(systemLanguageChanged()), this, SLOT(onSystemLanguageChanged()));
    // This is only available in Debug builds
    Q_ASSERT(res);
    // Since the variable is not used in the app, this is added to avoid a
    // compiler warning
    Q_UNUSED(res);

    // initial load
    onSystemLanguageChanged();

    // Create scene document from main.qml asset, the parent is set
    // to ensure the document gets destroyed properly at shut down.
    QmlDocument *qml = QmlDocument::create("asset:///main.qml").parent(this);
    qml->setContextProperty("_app", this);

    // Create root object for the UI
    AbstractPane *root = qml->createRootObject<AbstractPane>();

    // Set created root object as the application scene
    Application::instance()->setScene(root);
}

void ApplicationUI::onSystemLanguageChanged()
{
    QCoreApplication::instance()->removeTranslator(m_pTranslator);
    // Initiate, load and install the application translation files.
    QString locale_string = QLocale().name();
    QString file_name = QString("ShareAll_%1").arg(locale_string);
    if (m_pTranslator->load(file_name, "app/native/qm")) {
        QCoreApplication::instance()->installTranslator(m_pTranslator);
    }
}

void ApplicationUI::invokeSelected(const QStringList& selected, const QString& message) {
    qDebug() << "ApplicationUI::invokeSelected()" << selected << message;

    // Saving to global variables
    invokeLeft = selected;
    messageToSend = message;

    if (!invokeLeft.isEmpty()) {
        invoke(invokeLeft.first(), messageToSend);
        invokeLeft.removeFirst();
    }
}

void ApplicationUI::invoke(const QString& platform, const QString& data) {
    // Some invoke only works in C++, that's why all my invoke are done in C++
    qDebug() << "ApplicationUI::invoke()" << platform << data;

    // Load from previous saved information
    const QString jsonPathFile = QDir::currentPath() + "/app/native/assets/InvokeTargets.json";
    QVariantMap invokeTargets = jda.load(jsonPathFile).toMap()[platform].toMap();
    qDebug() << "invokeTargets:" << invokeTargets;

    // Create a new invocation request
    InvokeRequest request;
    if (!invokeTargets["target"].isNull())
        request.setTarget(invokeTargets["target"].toString());

    if (!invokeTargets["action"].isNull())
        request.setAction(invokeTargets["action"].toString());

    if (!invokeTargets["mimeType"].isNull())
        request.setMimeType(invokeTargets["mimeType"].toString());

    if (!invokeTargets["uri"].isNull())
        request.setUri(invokeTargets["uri"].toString() + data);

    request.setData(data.toUtf8());

    // Start the invocation
    m_invokeManager->invoke(request);
    connect(m_invokeManager, SIGNAL(childCardDone(const bb::system::CardDoneMessage&)), this, SLOT(invokeNext()));
}

void ApplicationUI::invokeNext() {
    qDebug() << "ApplicationUI::onInvokeFinished()";

    if (!invokeLeft.isEmpty()) {
        invoke(invokeLeft.first(), messageToSend);
        invokeLeft.removeFirst();
    }
}
