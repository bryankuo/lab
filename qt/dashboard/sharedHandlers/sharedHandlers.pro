#-------------------------------------------------
#
# Project created by QtCreator 2019-08-27T15:12:58
#
#-------------------------------------------------

QT       += qml serialbus

QT       -= gui

TARGET = sharedHandlers
TEMPLATE = lib

DEFINES += SHAREDHANDLERS_LIBRARY

# The following define makes your compiler emit warnings if you use
# any feature of Qt which has been marked as deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        sharedhandlers.cpp \
    ../can/handlers/ALM_MSG00.cpp \
    ../can/handlers/ALM_MSG01.cpp \
    ../can/handlers/ALM_MSG02.cpp \
    ../can/handlers/ALM_MSG03.cpp \
    ../can/handlers/BCU_ER_MSG01.cpp \
    ../can/handlers/BCU_VCU_MSG0.cpp \
    ../can/handlers/BCU_VCU_SMD.cpp \
    ../can/handlers/BMS_CMUERR_MSG01.cpp \
    ../can/handlers/BMS_VCU_MSG01.cpp \
    ../can/handlers/BMS_VCU_MSG02.cpp \
    ../can/handlers/BMS_VCU_MSG03.cpp \
    ../can/handlers/BMS_VCU_MSG04.cpp \
    ../can/handlers/DCDC_MSG00.cpp \
    ../can/handlers/PCU_CMD_MOT_1.cpp \
    ../can/handlers/PCU_CMD_MOT_2.cpp \
    ../can/handlers/PCU_CMD_MOT_3.cpp \
    ../can/handlers/PCU_CMD_SYS_1.cpp \
    ../can/handlers/PCU_IO_SIG00.cpp \
    ../can/handlers/PCU_ST_MOT_1.cpp \
    ../can/handlers/PCU_ST_MOT_2.cpp \
    ../can/handlers/PCU_ST_MOT_3.cpp \
    ../can/handlers/PCU_ST_SYS_1.cpp \
    ../can/handlers/PCU_ST_SYS_2.cpp \
    ../can/handlers/PCU_ST_SYS_3.cpp \
    ../can/handlers/PCU_ST_SYS_4.cpp \
    ../can/handlers/TPMS_MSG01.cpp \
    ../can/handlers/TPMS_MSG02.cpp \
    ../can/handlers/VCU_DIAG01.cpp \
    ../can/handlers/VCU_DIAG02.cpp \
    ../can/handlers/VCU_HMI_MSG02.cpp \
    ../can/handlers/VCU_IOSIG_MSG.cpp

HEADERS += \
        sharedhandlers.h \
        sharedhandlers_global.h \
    ../can/handlers/ALM_MSG00.h \
    ../can/handlers/ALM_MSG01.h \
    ../can/handlers/ALM_MSG02.h \
    ../can/handlers/ALM_MSG03.h \
    ../can/handlers/BCU_ER_MSG01.h \
    ../can/handlers/BCU_VCU_MSG0.h \
    ../can/handlers/BCU_VCU_SMD.h \
    ../can/handlers/BMS_CMUERR_MSG01.h \
    ../can/handlers/BMS_VCU_MSG01.h \
    ../can/handlers/BMS_VCU_MSG02.h \
    ../can/handlers/BMS_VCU_MSG03.h \
    ../can/handlers/BMS_VCU_MSG04.h \
    ../can/handlers/DCDC_MSG00.h \
    ../can/handlers/PCU_CMD_MOT_1.h \
    ../can/handlers/PCU_CMD_MOT_2.h \
    ../can/handlers/PCU_CMD_MOT_3.h \
    ../can/handlers/PCU_CMD_SYS_1.h \
    ../can/handlers/PCU_IO_SIG00.h \
    ../can/handlers/PCU_ST_MOT_1.h \
    ../can/handlers/PCU_ST_MOT_2.h \
    ../can/handlers/PCU_ST_MOT_3.h \
    ../can/handlers/PCU_ST_SYS_1.h \
    ../can/handlers/PCU_ST_SYS_2.h \
    ../can/handlers/PCU_ST_SYS_3.h \
    ../can/handlers/PCU_ST_SYS_4.h \
    ../can/handlers/TPMS_MSG01.h \
    ../can/handlers/TPMS_MSG02.h \
    ../can/handlers/VCU_DIAG01.h \
    ../can/handlers/VCU_DIAG02.h \
    ../can/handlers/VCU_HMI_MSG02.h \
    ../can/handlers/VCU_IOSIG_MSG.h

unix {
    target.path = /usr/lib
    INSTALLS += target
}
