TEMPLATE = app
TARGET = dashboard
# Comments on .pro file Qt Creator
# ( https://stackoverflow.com/a/9498021 )
# Automatic increment of build number in Qt Creator
# ( https://goo.gl/EcKoZR ) / ( https://goo.gl/JGSuzC )

# Creating Project Files
# @see https://tinyurl.com/y2p6g7fu

# qmake provides built-in functions to allow the contents
# of variables to be processed ( https://goo.gl/mqR3xe )
# VERSION = 1.0.0
VERSION = $$system(date \'+%Y%m%d%H%M%S\')
DEFINES += VERSION_STRING=\\\"$${VERSION}\\\"
# -I/usr/local/include/dashboard
INCLUDEPATH += . /usr/local/include -I/usr/local/include/libmongoc-1.0 -I/usr/local/include/libbson-1.0

# -lsharedHandlers
LIBS += -L/usr/local/lib64 -L/usr/local/lib -L/usr/lib

QT += quick widgets serialbus charts qml serialport

SOURCES += \
    main.cpp \
    clockthread.cpp \
    racev.cpp \
    info.cpp \
    myobject.cpp \
    cpu_util/CPUSnapshot.cpp \
    cpu_util/CPUData.cpp \
    conn/connthread.cpp \
    can/canthread.cpp \
    can/sja1000_api.cpp \
    can/sja1000_can.c \
    can/tools.cpp \
    can/frameparser.cpp \
    worker.cpp \
    can/viob_can06/Can06Thread.cpp \
    can/viob_can06/fp_can06.cpp \
    log/log.cc \
    parameters/contactmodel.cpp \
    can/handlers/ALM_MSG00.cpp \
    can/handlers/ALM_MSG01.cpp \
    can/handlers/ALM_MSG02.cpp \
    can/handlers/ALM_MSG03.cpp \
    can/handlers/BCU_ER_MSG01.cpp \
    can/handlers/BCU_VCU_MSG0.cpp \
    can/handlers/BCU_VCU_SMD.cpp \
    can/handlers/BMS_CMUERR_MSG01.cpp \
    can/handlers/BMS_VCU_MSG01.cpp \
    can/handlers/BMS_VCU_MSG02.cpp \
    can/handlers/BMS_VCU_MSG03.cpp \
    can/handlers/BMS_VCU_MSG04.cpp \
    can/handlers/DCDC_MSG00.cpp \
    can/handlers/PCU_CMD_MOT_1.cpp \
    can/handlers/PCU_CMD_MOT_2.cpp \
    can/handlers/PCU_CMD_MOT_3.cpp \
    can/handlers/PCU_CMD_SYS_1.cpp \
    can/handlers/PCU_IO_SIG00.cpp \
    can/handlers/PCU_ST_MOT_1.cpp \
    can/handlers/PCU_ST_MOT_2.cpp \
    can/handlers/PCU_ST_MOT_3.cpp \
    can/handlers/PCU_ST_SYS_1.cpp \
    can/handlers/PCU_ST_SYS_2.cpp \
    can/handlers/PCU_ST_SYS_3.cpp \
    can/handlers/PCU_ST_SYS_4.cpp \
    can/handlers/TPMS_MSG01.cpp \
    can/handlers/TPMS_MSG02.cpp \
    can/handlers/VCU_DIAG01.cpp \
    can/handlers/VCU_DIAG02.cpp \
    can/handlers/VCU_HMI_MSG02.cpp \
    can/handlers/VCU_IOSIG_MSG.cpp \
    parameters/alarm.cpp \
    accelerometer/G-sensor_API.c \
    accelerometer/gsensor_wrapper.cpp \
    vtc6210bk/io/iowrapper.cpp \
    vtc6210bk/io/OtherIO/OtherIO.c \
    can/handlers/VCU_PWR_STATUS.cpp \
    can/handlers/VCU_HMI_MSG01.cpp \
    can/handlers/VCU_HMI_MSG03.cpp \
    can/handlers/BMS_OBC_MSG01.cpp \
    gps/gpswrapper.cpp \
    gps/gpsthread.cpp

RESOURCES += \
    dashboard.qrc

OTHER_FILES += \
    qml/DashboardGaugeStyle.qml \
    qml/IconGaugeStyle.qml \
    qml/TachometerStyle.qml \
    qml/TurnIndicator.qml \
    qml/ValueSource.qml

# target.path = $$[QT_INSTALL_EXAMPLES]/quickcontrols/extras/dashboard
# xdg autostart (Desktop Application Autostart Specification
# - Standards) Linux 桌面自動啟動程式的設定 ( https://goo.gl/5BLECk )
target.path = /home/user
INSTALLS += target

DISTFILES += \
    qml/IndicatorRowStyle.qml \
    qml/PowerGaugeStyle.qml \
    qml/BatteryStatus.qml \
    qml/BatteryDeployment.qml \
    qml/jbQuick/Charts/QChart.js \
    qml/jbQuick/Charts/QChart.js \
    qml/jbQuick/Charts/README.md \
    qml/jbQuick/Charts/qmldir \
    qml/jbQuick/Charts/QChart.js \
    qml/jbQuick/Charts/qmldir \
    qml/jbQuick/Charts/QChart.qml \
    qml/jbQuick/Charts/QChart.js \
    qml/HmiDashboard.qml \
    qml/Charging.qml \
    qml/Diagnose.qml \
    qml/ButtonStyle.qml \
    qml/VehicleInfo.qml \
    qml/History.qml \
    qml/SystemLog.qml \
    qml/CellAlarmRecord.qml \
    qml/VehicleInfoRecord.qml \
    qml/ChargeTrippedRecord.qml \
    qml/ecu/analog/PcuAnalog.qml \
    qml/history/AlarmRecord.qml \
    qml/history/AlarmStat.qml \
    qml/history/CellAlarmRecord.qml \
    qml/history/ChargeTrippedRecord.qml \
    qml/history/SystemLog.qml \
    qml/history/VehicleInfoRecord.qml \
    qml/Tpms.qml \
    qml/ecu/digital/BcuDigital.qml \
    qml/ecu/digital/Dcdc.qml \
    qml/ecu/digital/PcuDigital.qml \
    qml/ecu/digital/VcuDigital.qml \
    qml/ecu/analog/BcuAnalog.qml \
    qml/ecu/analog/PcuAnalog.qml \
    qml/ecu/analog/VcuAnalog.qml \
    qml/dashwindow.qml \
    qml/style/RpmGaugeStyle.qml \
    qml/icon_desc/ChargeModel.qml \
    qml/icon_desc/ContactModel.qml \
    qml/high_voltage/Brake.qml \
    qml/high_voltage/Steering.qml \
    qml/high_voltage/Traction.qml \
    qml/ecu/analog/BmsAnalog.qml \
    qml/ecu/digital/BmsDigital.qml \
    qml/Unlock.qml \
    qml/Parameters.qml \
    qml/parameters/General.qml \
    qml/parameters/Tyres.qml \
    qml/parameters/Hmi.qml \
    qml/parameters/Alarm.qml \
    qml/parameters/Charge.qml \
    qml/parameters/ContactModel.qml \
    qml/LogOn.qml \
    qml/style/Styles.qml \
    qml/Boot.qml \
    qml/PedalGaugeStyle.qml \
    qml/IconDescription.qml

HEADERS += \
    clockthread.h \
    racev.h \
    info.h \
    myobject.h \
    cpu_util/CPUData.h \
    cpu_util/CPUSnapshot.h \
    conn/connthread.h \
    can/canthread.h \
    can/sja1000_api.h \
    can/sja1000_can.h \
    can/tools.h \
    can/frameparser.h \
    worker.h \
    can/viob_can06/Can06Thread.h \
    can/viob_can06/fp_can06.h \
    can/handlers.h \
    log/log.h \
    parameters/contactmodel.h \
    can/handlers/ALM_MSG00.h \
    can/handlers/ALM_MSG01.h \
    can/handlers/ALM_MSG02.h \
    can/handlers/ALM_MSG03.h \
    can/handlers/BCU_ER_MSG01.h \
    can/handlers/BCU_VCU_MSG0.h \
    can/handlers/BCU_VCU_SMD.h \
    can/handlers/BMS_CMUERR_MSG01.h \
    can/handlers/BMS_VCU_MSG01.h \
    can/handlers/BMS_VCU_MSG02.h \
    can/handlers/BMS_VCU_MSG03.h \
    can/handlers/BMS_VCU_MSG04.h \
    can/handlers/DCDC_MSG00.h \
    can/handlers/PCU_CMD_MOT_1.h \
    can/handlers/PCU_CMD_MOT_2.h \
    can/handlers/PCU_CMD_MOT_3.h \
    can/handlers/PCU_CMD_SYS_1.h \
    can/handlers/PCU_IO_SIG00.h \
    can/handlers/PCU_ST_MOT_1.h \
    can/handlers/PCU_ST_MOT_2.h \
    can/handlers/PCU_ST_MOT_3.h \
    can/handlers/PCU_ST_SYS_1.h \
    can/handlers/PCU_ST_SYS_2.h \
    can/handlers/PCU_ST_SYS_3.h \
    can/handlers/PCU_ST_SYS_4.h \
    can/handlers/TPMS_MSG01.h \
    can/handlers/TPMS_MSG02.h \
    can/handlers/VCU_DIAG01.h \
    can/handlers/VCU_DIAG02.h \
    can/handlers/VCU_HMI_MSG02.h \
    can/handlers/VCU_IOSIG_MSG.h \
    parameters/alarm.h \
    accelerometer/G-sensor.h \
    accelerometer/gsensor_wrapper.h \
    vtc6210bk/io/iowrapper.h \
    vtc6210bk/io/OtherIO/OtherIO.h \
    gps/gpsthread.h \
    gps/gpswrapper.h \
    can/handlers/VCU_PWR_STATUS.h \
    can/handlers/VCU_HMI_MSG01.h \
    can/handlers/VCU_HMI_MSG03.h \
    can/handlers/BMS_OBC_MSG01.h

# howto statically link ( https://goo.gl/Z9k9em )
# static -rpath

# Having "CONFIG+=debug" will add debug symbols to your program
# @see https://tinyurl.com/yxaceu6t
CONFIG += link_pkgconfig debug address_sanitizer
# Launching in Core Mode @see https://tinyurl.com/y2cs8s6h
# The Core mode is used to inspect core files (crash dumps) that are generated from crashed processes on Linux and Unix systems if the system is set up to allow this

# PKGCONFIG += libmongocxx-static

# unix:!macx: LIBS += -lmongocxx-static -lnmea
# ( https://goo.gl/3MLfk8 )
# unix:QMAKE_RPATHDIR += /usr/lib64

SUBDIRS += \
    qml/jbQuick/Charts/qchart.js.pro

# used QMAKE_LFLAGS += -no-pie in the .pro file
# and it produced me an executable file instead of a library
# @see https://tinyurl.com/y2j9tgy9
# QMAKE_LFLAGS_RELEASE_WITH_DEBUGINFO += -no-pie
QMAKE_LFLAGS += -no-pie
# option QMAKE_LFLAGS @see https://tinyurl.com/yxhrk7rj

# FIXME: How to execute shell command after link ( https://goo.gl/9iaqVq )
# make_ctags.command = $$system("make ctags-clean")
# QMAKE_POST_LINK += make_ctags
