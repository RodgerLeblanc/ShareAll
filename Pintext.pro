APP_NAME = Mycon
LIBS += -lbbplatform

CONFIG += qt warn_on cascades10
LIBS += -lbbdevice -lbbdata -lbbsystem -lbbplatformbbm
QT += network

LIBS += -lbb -lbbsystem  -lbbcascadespickers
MOBILITY += sensors
QT += declarative
QT += core network



include(config.pri)
