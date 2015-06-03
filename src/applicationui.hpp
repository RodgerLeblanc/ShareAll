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

#ifndef ApplicationUI_HPP_
#define ApplicationUI_HPP_

#include <QObject>
#include <QUrl>
#include <QSettings>

#include <src/FileSaver/FileSaver.h>
#include "src/Settings/Settings.h"
#include <src/bbm/BBMHandler.hpp>
#include <bb/system/InvokeManager>
#include <bb/system/InvokeRequest>
#include <QStringList>
#include <QObject>
#include <bb/cascades/TextArea>
namespace bb
{
    namespace cascades
    {
        class Application;
        class LocaleHandler;
    }
    namespace system {
            class InvokeManager;
        }

}

class QTranslator;

/*!
 * @brief Application UI object
 *
 * Use this object to create and init app UI, to create context objects, to register the new meta types etc.
 */
class ApplicationUI : public QObject
{
    Q_OBJECT
public:
    ApplicationUI(bb::cascades::Application *app);
            virtual ~ApplicationUI() { }
            // Converts the passed QString to an UTF-8 encoded QByteArray
            Q_INVOKABLE QByteArray encodeQString(const QString& toEncode) const;






  private Q_SLOTS:
    void handleInvoke(const bb::system::InvokeRequest&);




private slots:
    void onSystemLanguageChanged();


private:

    void initFullUI();

    QTranslator* m_pTranslator;
    bb::cascades::LocaleHandler* m_pLocaleHandler;
    bb::system::InvokeManager* m_invokeManager;


    Settings *settings;
    FileSaver* fileSaver;

};

#endif /* ApplicationUI_HPP_ */
