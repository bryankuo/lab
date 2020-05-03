
/****************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/
import QtQml 2.2
import QtQuick 2.2
import QtQuick.Window 2.2
import QtQuick.Extras 1.4
// ref: ( https://is.gd/Gc28s9 )
import QtQuick.Controls 1.4 as QQC1
import QtQuick.Controls 2.4
import QtQuick.Controls.Styles 1.4

// mark to prevent importing SwitchDelegate such that delaybutton 'round'
// import QtQuick.Controls 2.5

// Access C++ function from QML
// https://goo.gl/nxZegu
//import com.myself 1.0
// signal from c++ to QML slot
import QtCharts 2.3
import "style"

// import "popup"
ApplicationWindow {
    id: hmiroot
    objectName: "hmiroot"
    visible: true // this is mandatory
    visibility: Window.FullScreen
    Styles {
        id: style
    }
    Models {
        id: model
    }
    width: style.resolutionWidth // application wide properties
    height: style.resolutionHeight
    x: 0
    y: 0
    // ( https://goo.igl/nnR4j9 )
    // @see https://tinyurl.com/yyrzzade
    // width: Screen.desktopAvailableWidth
    // height: Screen.desktopAvailableHeight
    // frameless windows with qt5 (qml)
    // ( https://goo.gl/nnR4j9 )
    flags: Qt.FramelessWindowHint
    // How to make QtQuick2.0 application window not resizable?
    // ( https://goo.gl/1YCbCc )
    maximumHeight: height
    maximumWidth: width
    minimumHeight: height
    minimumWidth: width

    color: style.colorBackground
    property alias imageVehicleInfo: imageVehicleInfo
    // be sure to export property alias
    property alias imageBattery: imageBattery
    property alias imageCharging: imageCharging
    property alias imageTPMS: imageTPMS
    property alias imageDiagnostics: imageDiagnostics
    property alias imageUnlock: imageUnlock
    property alias imageIconDesc: imageIconDesc
    property alias imageHistory: imageHistory
    property alias imageParameters: imageParameters

    property alias txtMilage1: txtMilage
    //property alias switchDelegate1: switchDelegate
    //property bool isAnimating : switchDelegate1.checked
    // Launch a child QML window from a parent QML window
    // ( https://goo.gl/J67Pcc )
    property variant win
    // you can hold this as a reference..
    // Defining Property Attributes ( https://goo.gl/p2Rg16 )
    property string current_trip: "000000.0" // string
    property string current_total: "000000.0"
    property real max_sample_display: 20
    property real update_freq: 1 // number of second
    property real energy_consumed: 0 // place holder for Chart
    //title: qsTr("RACEV HMI")
    property var mtr_op
    property var mtr_overrun
    property var mtr_alarm
    property int num_sec_alarm
    property int bsoc_width: 16

    // TODO: global constant
    property double volt_NORMAL: 23.0
    property double volt_WARN: 22.0
    property double v24: 0.0
    // 0: status, 1: warning, 2: cruise, 3: efficiency
    property int current_view_index: 0

    property int view_left: 500
    property int view_top: 200
    property int view_w: 530
    property int view_h: 420

    property int reading_left: 250

    property int button_wh: 75

    //onActiveFocusItemChanged: print("activeFocusItem", activeFocusItem)
    // Connecting to QML Signals ( https://goo.gl/gFZphL )
    signal qmlSignal(string msg)
    // c++ -> QML ( https://goo.gl/sHMaKL )

    // https://tinyurl.com/vfr5y6p
    signal qmlSignalPressAndHold

    // @see https://tinyurl.com/qs42sty
    function formatDate(date) {
        var d = new Date(date), month = ''
                                + (d.getMonth(
                                       ) + 1), day = '' + d.getDate(
                                                   ), year = d.getFullYear(
                                                          ), hour = '' + d.getHours(
                                                                 ), min = '' + d.getMinutes(
                                                                        ), sec = '' + d.getSeconds()

        if (month.length < 2)
            month = '0' + month
        if (day.length < 2)
            day = '0' + day
        if (hour.length < 2)
            hour = '0' + hour
        if (min.length < 2)
            min = '0' + min
        if (sec.length < 2)
            sec = '0' + sec

        return [year, month, day].join('-') + ' ' + [hour, min, sec].join(':')
    }

    // not called
    function updateSystemInfo(n_dbop, cpu, freemem) {
        //console.log("updateSystemInfo+ ", freemem)
        //text1.text = timestamp; // https://goo.gl/UQ4jEV
        // better not do calculation in QML, just display
        dbop.text = n_dbop
        cpu1.text = cpu
        fmem1.text = freemem
        return ""
    }

    // note: Qt Creator moves function code location,
    // such that QMetaObject::invokeMethod complains 'No such method'
    function updateModel(speed, rpm, gear, milage) {
        valueSource.kph = speed
        return ""
    }

    function loadMenuText(locale) {
        console.log("locale: [" + locale + "]")
        // energy.title = loadString(1, locale);
        // TODO: Internationalization and Localization with Qt Quick
        // @see https://tinyurl.com/y2c7mguc
        // example:
        // @see https://tinyurl.com/y64rtkwf
    }

    // not called
    function setAnimaiton(is_on) {
        isAnimating = is_on
        //console.debug("setAnimation +++ " + isAnimating);
    }

    // byte0
    function update_VCU_HMI_Msg_1(lturn, rturn, hd_light, side_light, hazard_light, access_light, door_open, rear_defogger_light) {
        leftIndicator.on = (lturn !== 0) ? true : false

        //leftIndicator.flashing = ( lturn !== 1 ) ? true:false;
        // TODO: relay "sound" and screen "flash" synchronization issue.
        rightIndicator.on = (rturn !== 0) ? true : false

        //rightIndicator.flashing = ( rturn !== 0 ) ? true:false;
        imageHeadLights.source = (hd_light !== 0) ? "../images/0-color/HMI-ICON-03.png" : "" // ../images/1-white/white-HMI-ICON-03.png

        // TODO: regulation is blue
        imageSideLights.source = (side_light !== 0) ? "../images/0-color/HMI-ICON-04.png" : "" // ../images/1-white/HMI-ICON-04.png

        imageHazardLight.source = (hazard_light !== 0) ? "../images/0-color/HMI-ICON-07.png" : "" // ../images/1-white/white-HMI-ICON-07.png

        imageAccessLight.source = (access_light !== 0) ? "../images/0-color/HMI-ICON-19.png" : "" // ../images/1-white/white-HMI-ICON-19.png

        imageDoorOpen.source = (door_open !== 0) ? "../images/1-white/20190308HMI-ICON-99.png" : ""
        imageRearDefogger.source = (rear_defogger_light
                                    !== 0) ? "../images/0-color/20190308HMI-ICON-82.png" : ""
    }

    function setMotorState(m_op, m_overrun, m_alarm) {
        // console.debug(m_op+", "+m_overrun+", "+m_alarm);
        // in the order of highest priority:
        if (m_alarm === 2) {
            imageMotor.source = "../images/2-iso2575/56-m09Red-1.PNG"
        } else if (m_overrun === 1) {
            imageMotor.source = "../images/2-iso2575/56-m09Red-2.PNG"
        } else if (m_alarm === 1) {
            imageMotor.source = "../images/2-iso2575/56-m09Yellow.PNG"
        } else {
            if (m_op === 1) {
                imageMotor.source = "../images/2-iso2575/56-m09Green.PNG"
            } else {
                imageMotor.source = ""
            }
        }
    }

    function setNextView() {
        current_view_index++
        if (3 < current_view_index)
            current_view_index = 0
        switch (current_view_index) {
        case 0:
            statusView.visible = true
            warninigView.visible = false
            cruiseView.visible = false
            efficiencyView.visible = false
            break
        case 1:
            statusView.visible = false
            warninigView.visible = true
            cruiseView.visible = false
            efficiencyView.visible = false
            break
        case 2:
            statusView.visible = false
            warninigView.visible = false
            cruiseView.visible = true
            efficiencyView.visible = false
            break
        case 3:
            statusView.visible = false
            warninigView.visible = false
            cruiseView.visible = false
            efficiencyView.visible = true
            break
        }
    }

    ValueSource {
        id: valueSource
        //objectName: "valueSource1" // ( https://goo.gl/Caomvq )
    }

    Item {
        id: container
        height: Math.min(hmiroot.width, hmiroot.height)
        visible: true
        z: 2
        anchors.verticalCenterOffset: 0
        anchors.horizontalCenterOffset: 0
        anchors.centerIn: parent
        width: hmiroot.width

        Rectangle {
            id: recMessage
            x: style.msgBarX1
            y: 900
            width: style.msgBarWidth
            height: style.msgBarHeight
            color: "#1f1f1f"

            Text {
                id: txtAlarmContent
                x: 0
                y: 0
                width: style.msgBarWidth
                color: "#ffa500"
                text: qsTr("")
                font.family: "Verdana"
                lineHeight: 0.9
                verticalAlignment: Text.AlignTop
                font.pixelSize: 32
            }

            // TODO:
            // Responding To User Input in QML
            // ref: ( https://tinyurl.com/yx6zwbfr )
            // Qt 5.12
            // ref: ( https://is.gd/lSuzeu )
            // TapHandler {
            //    onTapped: {
            //	root.qmlSingalTagAlarmRectangle("NEXT", 1);
            //	console.log("tapped...");
            //    }
            // }
            MouseArea {
                onClicked: {
                    root.qmlSignalClickAlarmRectangle("NEXT", 1)
                }
            }
        }

        Rectangle {
            id: recODOmeter
            x: 380
            width: 300
            height: 75
            color: "#000000"
            radius: 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            anchors.leftMargin: 3
            border.width: 1
            border.color: "#000000"
            Text {
                id: txtMilage
                x: 0
                width: 300
                height: 75
                color: "#ffffff"
                text: "000000.0"
                anchors.horizontalCenterOffset: 0
                lineHeight: 1
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: 40
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
        }

        // TODO: to be obseleted, but ChartView in use
        // somehow test pilot j prefers meter to educate users
        CircularGauge {
            id: powerCircularGauge
            x: 0
            y: -200
            width: 180
            height: 180
            clip: false
            z: -3
            visible: true
            stepSize: 1
            value: 0
            minimumValue: 0
            maximumValue: 250
            smooth: true
            Behavior on value {
                NumberAnimation {
                    duration: 250
                }
            }
            style: PedalGaugeStyle {
                id: lala //pedalGaugeStyle
                // maxWarningColor: Qt.rgba(1, 0, 0, 1)
                // minWarningColor: Qt.rgba(1, 1, 0.1, 0.7)
                // maxGreenColor: Qt.rgba(0, 1, 0, 0.3)
                //icon: "qrc:/images/power.png"
                tickmarkLabel: Text {
                    color: "#ffffff"
                    text: styleData.value / 1
                    font.pixelSize: lala.toPixels(0.08)
                    //pedalGaugeStyle.
                }
            }
        }

        Rectangle {
            id: recEnergyConsumption
            y: 530
            z: 1
            width: 360
            height: 150
            color: style.colorBackground
            radius: 2
            border.color: style.colorBackground
            anchors.left: parent.left
            anchors.leftMargin: -400

            // border.width: 1
            Timer {
                id: clockTimer
                repeat: true
                interval: 1 * 1000
                triggeredOnStart: true
                running: true
                onTriggered: {
                    txtClock.text = formatDate(Date())
                    // TODO: model.formatDate(Date()) re-use
                    // if ( 0 < txtAlarmContent.text.length ) {
                    num_sec_alarm++
                    // }
                    if (1 < num_sec_alarm /*&& 0 < txtAlarmContent.text.length*/
                            ) {
                        // txtAlarmContent.text = "";
                        // console.debug("clear alarm");
                        num_sec_alarm = 0
                        // txtAlarmContent.text
                        //  = AlarmParameters.getNextAlarmIdContent();
                    }
                }
            }

            // QT Charts QML scrolling X axis in ms
            // ( https://is.gd/zChCxb )
            Timer {
                property int amountOfData: 0
                //So we know when we need to start scrolling
                id: refreshTimer
                interval: update_freq * 1000 // ms
                running: true
                repeat: true
                onTriggered: {
                    areaSeries1.lowerSeries.append(amountOfData, 0)
                    areaSeries1.upperSeries.append(amountOfData,
                                                   energy_consumed)
                    if (amountOfData > areaSeries1.axisX.max) {
                        areaSeries1.axisX.min++
                        areaSeries1.axisX.max++
                        //areaSeries1.remove(areaSeries1.axisX.min-1);
                    } else {
                        amountOfData++
                        // This else is just to stop
                        // incrementing the variable unnecessarily
                    }
                    //remove all data points that are not visible anymore
                    if (max_sample_display < amountOfData) {
                        areaSeries1.lowerSeries.remove(1)
                        areaSeries1.upperSeries.remove(1)
                    }
                }
            }

            Text {
                id: txtZero
                x: 39
                y: 608
                width: 20
                height: 20
                color: "#ffffff"
                text: qsTr("0")
                anchors.verticalCenter: parent.verticalCenter
                z: 2
                horizontalAlignment: Text.AlignHCenter
                lineHeight: 0.8
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 15
            }

            Text {
                id: txtMinus
                x: 39
                y: 637
                width: 20
                height: 20
                color: "#ffffff"
                text: qsTr("-")
                anchors.verticalCenter: parent.verticalCenter
                z: 2
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 30
            }

            Text {
                id: txtPlus
                x: 39
                y: 552
                width: 20
                height: 20
                color: "#ffffff"
                text: qsTr("+")
                anchors.verticalCenter: parent.verticalCenter
                z: 2
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 19
            }
        }

        CircularGauge {
            id: rpmGauge
            x: 0
            y: 200
            width: 420
            height: 420
            anchors.right: parent.right
            anchors.rightMargin: 10
            z: -5
            visible: true
            minimumValue: 0
            value: 0.000
            stepSize: 0.001
            maximumValue: 4
            smooth: true
            Behavior on value {
                NumberAnimation {
                    duration: 100
                }
            }
            style: RpmGaugeStyle {}
        }

        CircularGauge {
            id: speedometer
            y: 200
            width: 420
            height: 420
            anchors.left: parent.left
            anchors.leftMargin: 10
            z: -5
            value: 0.00
            maximumValue: 140.00
            // style: DashboardGaugeStyle { }
            // TODO: check if housekeeping required, obselete
            style: SpeedGaugeStyle {}
            smooth: true
            stepSize: 0.01
            Behavior on value {
                NumberAnimation {
                    // TODO: reserving resource
                    // from 400 to 200
                    duration: 400
                }
            }
        }

        // usage as RPM gauge
        // scale: What are the RPM figures given for electric vehicles?
        // ref: ( https://is.gd/vwxoRZ )
        Image {
            id: imageCharging
            y: -8
            width: 75
            height: 75
            anchors.left: imageBattery.right
            anchors.leftMargin: 0
            source: "../images/0-color/HMI-ICON-53.png"
            anchors.top: imageBattery.top
            fillMode: Image.PreserveAspectFit
            MouseArea {
                id: mouseAreaChargingStation
                width: 75
                height: 75
                anchors.fill: parent
                z: 2
                onClicked: {
                    hmiroot.qmlSignal("ChargingStation")
                }
            }
            anchors.topMargin: 0
        }

        Image {
            id: imageBattery
            x: 190
            y: -100
            width: 75
            height: 75
            sourceSize.height: 267
            sourceSize.width: 267
            source: "../images/0-color/HMI-ICON-51.png"
            fillMode: Image.PreserveAspectFit
            MouseArea {
                id: mouseAreaDeployment
                y: -100
                width: 75
                height: 75
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.top: parent.top
                z: 2
                onClicked: {
                    hmiroot.qmlSignal("Battery")
                }
            }
        }
        Image {
            id: imageDiagnostics
            width: 75
            height: 75
            anchors.left: imageTPMS.right
            anchors.leftMargin: 0
            anchors.topMargin: 0
            fillMode: Image.PreserveAspectFit
            anchors.top: imageBattery.top
            source: "../images/0-color/20190703HMI-ICON-90.png"
            MouseArea {
                id: mouseAreaDiagnose
                z: 2
                anchors.fill: parent
                onClicked: {
                    hmiroot.qmlSignal("Diagnosis")
                }
            }
        }

        // Dashboards are typically in a landscape orientation, so we need to ensure
        // our height is never greater than our width.
        ToggleButton {
            id: tbTrip
            y: 626
            width: 75
            height: 75
            text: qsTr("T")
            anchors.left: recODOmeter.right
            anchors.leftMargin: 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            transformOrigin: Item.Center
            z: 1
            onClicked: {
                //console.debug("total "+current_total+
                //	" trip "+current_trip+" status "+tbTrip.checked);
                if (tbTrip.checked) {
                    txtMilage.text = current_trip
                } else {
                    txtMilage.text = current_total
                }
            }

            Timer {
                id: longPressTimer

                //your press-and-hold interval here
                interval: style.buttonHoldTimeMs
                repeat: false
                running: false

                onTriggered: {
                    hmiroot.qmlSignalPressAndHold()
                    console.debug("triggered")
                }
            }

            onPressedChanged: {
                if (tbTrip.checked) {
                    // only in trip state
                    if (pressed) {
                        // TODO: find out in doc
                        longPressTimer.running = true
                    } else {
                        longPressTimer.running = false
                    }
                    console.debug("pressed=" + pressed)
                }
            }
        }

        Image {
            id: imageVehicleInfo
            y: 1
            width: 75
            height: 75
            anchors.left: imageIconDesc.right
            anchors.leftMargin: 0
            fillMode: Image.PreserveAspectFit
            source: "../images/0-color/HMI-ICON-57.png"
            MouseArea {
                id: maVehicleInfo
                width: 75
                height: 75
                anchors.fill: parent
                z: 2
                onClicked: {
                    hmiroot.qmlSignal("vehicleInfoWindow")
                }
            }
            anchors.topMargin: 0
            anchors.top: imageBattery.top
        }

        Image {
            id: imageHistory
            y: 8
            width: 75
            height: 75
            anchors.left: imageVehicleInfo.right
            anchors.leftMargin: 0
            fillMode: Image.PreserveAspectFit
            anchors.top: imageBattery.top
            MouseArea {
                id: maHistory
                anchors.fill: parent
                visible: true
                z: 2
                onClicked: {
                    hmiroot.qmlSignal("historyWindow")
                }
            }
            source: "../images/0-color/20190703HMI-ICON-83.png"
            anchors.topMargin: 0
        }

        Image {
            id: imageTPMS
            y: 0
            width: 75
            height: 75
            anchors.left: imageCharging.right
            anchors.leftMargin: 0
            anchors.topMargin: 0
            MouseArea {
                id: maTPMS
                width: 75
                height: 75
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.right: parent.right
                visible: true
                z: 2
                anchors.top: parent.top
                onClicked: {
                    hmiroot.qmlSignal("TPMS")
                }
            }
            fillMode: Image.PreserveAspectFit
            source: "../images/0-color/20190703HMI-ICON-86.png"
            anchors.top: imageBattery.top
        }

        Image {
            id: imageUnlock
            y: 15
            width: 75
            height: 75
            anchors.left: imageDiagnostics.right
            anchors.leftMargin: 0
            anchors.topMargin: 0
            MouseArea {
                id: maUnlock
                anchors.fill: parent
                visible: true
                z: 2
                onClicked: {
                    hmiroot.qmlSignal("UNLOCK")
                }
            }
            fillMode: Image.PreserveAspectFit
            source: "../images/0-color/20190703HMI-ICON-92.png"
            anchors.top: imageDiagnostics.top
        }

        Image {
            id: imageIconDesc
            y: 1
            width: 75
            height: 75
            anchors.left: imageUnlock.right
            anchors.leftMargin: 0
            anchors.topMargin: 0
            MouseArea {
                id: maIconDesc
                width: 75
                height: 75
                anchors.right: parent.right
                anchors.top: parent.top
                z: 2
                onClicked: {
                    hmiroot.qmlSignal("IconDesc")
                }
            }

            fillMode: Image.PreserveAspectFit
            source: "../images/0-color/20190703HMI-ICON-94.png"
            anchors.top: imageBattery.top
        }

        Image {
            id: imageParameters
            y: 5
            width: 75
            height: 75
            anchors.left: imageHistory.right
            anchors.leftMargin: 0
            anchors.topMargin: 0
            MouseArea {
                id: maParameter
                width: 75
                height: 75
                anchors.right: parent.right
                visible: true
                z: 2
                anchors.top: parent.top
                onClicked: {
                    hmiroot.qmlSignal("Parameters")
                }
            }
            fillMode: Image.PreserveAspectFit
            source: "../images/0-color/20190308HMI-ICON-96.png"
            anchors.top: imageBattery.top
        }

        Text {
            id: lblDbop
            x: -8
            y: -8
            width: 70
            height: 25
            color: "#ffffff"
            text: qsTr("#DBW:")
            anchors.verticalCenterOffset: 607
            visible: false
            font.pixelSize: 20
            anchors.left: parent.left
            textFormat: Text.PlainText
            fontSizeMode: Text.FixedSize
            anchors.leftMargin: -24
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: dbop
            x: -8
            y: -8
            width: 80
            height: 25
            color: "#ffffff"
            text: qsTr("00000")
            visible: false
            font.pixelSize: 20
            anchors.topMargin: 978
            anchors.left: lblDbop.right
            textFormat: Text.PlainText
            fontSizeMode: Text.Fit
            anchors.leftMargin: -48
            anchors.top: parent.top
        }

        Text {
            id: lbl_cpu1
            x: 200
            width: 70
            height: 25
            color: "#ffffff"
            text: qsTr("CPU%:")
            visible: false
            font.pixelSize: 20
            anchors.topMargin: 978
            anchors.left: dbop.right
            textFormat: Text.PlainText
            fontSizeMode: Text.FixedSize
            anchors.leftMargin: -48
            anchors.top: parent.top
        }

        Text {
            id: cpu1
            x: 390
            width: 40
            height: 25
            color: "#ffffff"
            text: qsTr("00")
            visible: false
            font.pixelSize: 20
            anchors.topMargin: 978
            anchors.left: lbl_cpu1.right
            textFormat: Text.PlainText
            fontSizeMode: Text.Fit
            anchors.leftMargin: -48
            anchors.top: parent.top
        }

        Text {
            id: lbl_fmem
            x: 192
            y: -8
            width: 60
            height: 25
            color: "#ffffff"
            text: qsTr("FREE:")
            visible: false
            font.pixelSize: 20
            anchors.topMargin: 978
            anchors.left: cpu1.right
            textFormat: Text.PlainText
            fontSizeMode: Text.FixedSize
            anchors.leftMargin: -48
            anchors.top: parent.top
        }

        Text {
            id: fmem1
            x: 192
            y: -8
            width: 50
            height: 25
            color: "#ffffff"
            text: qsTr("0000")
            visible: false
            font.pixelSize: 20
            anchors.topMargin: 978
            anchors.left: lbl_fmem.right
            textFormat: Text.PlainText
            fontSizeMode: Text.FixedSize
            anchors.leftMargin: -48
            anchors.top: parent.top
        }

        Text {
            id: fmem2
            x: 192
            y: -8
            width: 25
            height: 25
            color: "#ffffff"
            text: qsTr("M")
            visible: false
            font.pixelSize: 20
            anchors.topMargin: 978
            anchors.left: fmem1.right
            textFormat: Text.PlainText
            fontSizeMode: Text.FixedSize
            anchors.leftMargin: -48
            anchors.top: parent.top
        }

        Text {
            id: txtFPayLoadCaption
            x: 183
            y: -9
            width: 35
            height: 25
            color: "#ffffff"
            text: qsTr("#B:")
            visible: false
            font.pixelSize: 20
            anchors.topMargin: 978
            anchors.left: fmem2.right
            textFormat: Text.PlainText
            fontSizeMode: Text.FixedSize
            anchors.leftMargin: -48
            anchors.top: parent.top
        }

        Text {
            id: txtFramePayLoad
            y: -9
            width: 40
            height: 25
            color: "#ffffff"
            text: qsTr("000")
            visible: false
            font.pixelSize: 20
            anchors.topMargin: 978
            anchors.left: txtFPayLoadCaption.right
            textFormat: Text.RichText
            fontSizeMode: Text.FixedSize
            objectName: "txtFramePayLoad"
            anchors.leftMargin: -48
            font.family: "Cantarell"
            anchors.top: parent.top
        }

        Text {
            id: txtSizeQCap
            x: 175
            y: -17
            width: 40
            height: 25
            color: "#ffffff"
            text: qsTr("#Q:")
            visible: false
            font.pixelSize: 20
            anchors.topMargin: 978
            anchors.left: txtFramePayLoad.right
            textFormat: Text.PlainText
            fontSizeMode: Text.FixedSize
            anchors.leftMargin: -48
            anchors.top: parent.top
        }

        Text {
            id: txtSizeQ
            x: -56
            y: -17
            width: 40
            height: 25
            color: "#ffffff"
            text: qsTr("000")
            visible: false
            font.pixelSize: 20
            anchors.topMargin: 978
            anchors.left: txtSizeQCap.right
            textFormat: Text.RichText
            fontSizeMode: Text.FixedSize
            objectName: "txtSizeQ"
            anchors.leftMargin: 0
            font.family: "Cantarell"
            anchors.top: parent.top
        }

        Text {
            id: txtGx
            x: -200
            y: 44
            width: 30
            height: 25
            color: "#ffffff"
            text: qsTr("X :")
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 19
            horizontalAlignment: Text.AlignLeft
            visible: false
        }

        Text {
            id: txtXValue
            x: -170
            y: 44
            width: 150
            height: 25
            color: "#ffffff"
            text: qsTr("0000000000000000")
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 14
            horizontalAlignment: Text.AlignLeft
            visible: false
        }

        Text {
            id: txtGy
            x: -230
            y: 393
            visible: (root.role === 0) ? true : false
            width: 30
            height: 25
            color: "#ffffff"
            text: qsTr("Y :")
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 19
            horizontalAlignment: Text.AlignLeft
        }

        Text {
            id: txtYValue
            y: 393
            width: 150
            height: 26
            visible: (root.role === 0) ? true : false
            color: "#ffffff"
            text: qsTr("H 00 T 00 d 0 s 0 tx 000 rx 000")
            anchors.left: txtGy.right
            anchors.leftMargin: -230
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 14
            horizontalAlignment: Text.AlignLeft
        }

        Text {
            id: txtGz
            x: -150
            width: 30
            height: 25
            color: "#ffffff"
            text: qsTr("Z :")
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 19
            horizontalAlignment: Text.AlignLeft
            visible: false
        }

        Text {
            id: txtZValue
            x: -145
            width: 150
            height: 25
            color: "#ffffff"
            text: qsTr("")
            lineHeight: 0.9
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 14
            horizontalAlignment: Text.AlignLeft
            visible: false
        }

        Image {
            id: imageEcas
            x: 100
            width: 75
            height: 75
            z: 4
            source: "../images/1-white/white-HMI-ICON-13.png"
            sourceSize.height: 267
            sourceSize.width: 267
            fillMode: Image.Stretch
        }

        Image {
            id: imageEcasKneeling
            x: 75
            width: 75
            height: 75
            anchors.top: imageEcas.top
            anchors.topMargin: 0
            anchors.left: imageEcas.right
            source: "../images/1-white/white-HMI-ICON-11.png"
            sourceSize.height: 267
            sourceSize.width: 267
            fillMode: Image.PreserveAspectFit
            anchors.leftMargin: 5
        }

        Image {
            id: imageTyre
            y: 0
            width: 75
            height: 75
            anchors.left: imagePSteering.right
            anchors.leftMargin: 0
            anchors.top: imagePSteering.top
            anchors.topMargin: 0
            visible: true
            z: 1
            source: "../images/2-iso2575/NO008_49-k12Red.PNG"
            sourceSize.height: 300
            sourceSize.width: 300
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: imageMotor
            y: 0
            width: 75
            height: 75
            anchors.top: imageRegenBrake.top
            anchors.topMargin: -10
            sourceSize.width: 300
            anchors.leftMargin: 5
            anchors.left: imageReady.right
            sourceSize.height: 300
            source: "../images/2-iso2575/56-m09Green.PNG"
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: imageRearDefogger
            width: 75
            height: 75
            anchors.left: imageParking.right
            anchors.leftMargin: 5
            anchors.top: imageLining.top
            anchors.topMargin: 0
            source: "../images/0-color/HMI-ICON-06.png"
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: imageRearFogLight
            width: 75
            height: 75
            sourceSize.height: 300
            sourceSize.width: 300
            anchors.top: imageLining.top
            anchors.topMargin: 0
            anchors.leftMargin: 5
            anchors.left: imageFrontFogLIght.right
            source: "../images/2-iso2575/NO010_12-a06Yellow.PNG"
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: imageHeadLights
            y: 75
            width: 75
            height: 75
            sourceSize.height: 300
            sourceSize.width: 300
            anchors.topMargin: 0
            anchors.leftMargin: 5
            anchors.top: imageLining.top
            anchors.left: imageRearFogLight.right
            source: "../images/2-iso2575/NO012_12-a02Green.PNG"
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: imageSideLights
            y: 4
            width: 75
            height: 75
            anchors.topMargin: 0
            anchors.leftMargin: 5
            anchors.top: imageLining.top
            anchors.left: imageHeadLights.right
            source: "../images/0-color/HMI-ICON-04.png"
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: imagePSteering
            y: 0
            width: 75
            height: 75
            anchors.left: imageHazardLight.right
            anchors.leftMargin: -20
            source: "../images/2-iso2575/NO009_45-j04Yellow.PNG"
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: imageLining
            x: 100
            y: 75
            width: 75
            height: 75
            source: "../images/2-iso2575/NO007_18-b10Yellow.PNG"
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: imageRegenBrake
            y: 0
            width: 75
            height: 75
            anchors.left: imageDoorOpen.right
            anchors.leftMargin: 5
            source: "../images/0-color/HMI-ICON-08.png"
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: imageAbs
            y: 9
            width: 75
            height: 75
            anchors.topMargin: 0
            anchors.leftMargin: 5
            anchors.left: imageLining.right
            anchors.top: imageLining.top
            source: "../images/2-iso2575/NO017_17-b05Yellow.PNG"
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: imageParking
            y: 9
            width: 76
            height: 75
            sourceSize.height: 300
            sourceSize.width: 300
            anchors.topMargin: 0
            anchors.leftMargin: 5
            anchors.top: imageLining.top
            anchors.left: imageAbs.right
            source: "../images/2-iso2575/NO015_17-b02Red.PNG"
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: imageMainPower
            width: 75
            height: 75
            anchors.top: imageRegenBrake.top
            anchors.topMargin: 0
            anchors.leftMargin: -20
            anchors.left: imageBatteryStatus.right
            source: "../images/0-color/HMI-ICON-16.png"
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: imageBatteryStatus
            width: 75
            height: 75
            anchors.top: imageRegenBrake.top
            anchors.topMargin: 0
            anchors.leftMargin: 5
            anchors.left: imageMotor.right
            source: "../images/2-iso2575/55-m07Yellow.PNG"
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: imageHazardLight
            width: 75
            height: 75
            anchors.left: imageMainPower.left
            anchors.leftMargin: 48
            anchors.top: imageRegenBrake.top
            anchors.topMargin: 0
            source: "../images/0-color/HMI-ICON-07.png"
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: imageAccessLight
            width: 75
            height: 75
            anchors.left: imageTyre.right
            anchors.leftMargin: -20
            source: "../images/1-white/white-HMI-ICON-19.png"
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: imageAlarmGetOff
            x: 571
            width: 75
            height: 75
            anchors.top: imagePSteering.top
            anchors.topMargin: 0
            anchors.leftMargin: -30
            anchors.left: imageAccessLight.right
            source: "../images/0-color/HMI-ICON-29.png"
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: imageEvacuation
            width: 75
            height: 75
            anchors.left: imageEcasKneeling.right
            anchors.leftMargin: 5
            anchors.top: imageEcas.top
            sourceSize.width: 267
            visible: true
            anchors.topMargin: 0
            sourceSize.height: 267
            source: "../images/0-color/HMI-ICON-24.png"
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: imageDoorOpen
            y: 480
            width: 75
            height: 75
            anchors.top: imageEcas.top
            anchors.topMargin: 0
            sourceSize.width: 267
            visible: true
            anchors.leftMargin: 5
            anchors.left: imageEvacuation.right
            sourceSize.height: 267
            source: "../images/1-white/white-HMI-ICON-24.png"
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: imageCANBus
            x: 500
            width: 75
            height: 75
            anchors.top: imagePSteering.top
            anchors.topMargin: 0
            visible: false
            anchors.leftMargin: 60
            anchors.left: imageAlarmGetOff.left
            source: "../images/0-color/HMI-ICON-40.png"
            fillMode: Image.PreserveAspectFit
        }
        Rectangle {
            id: rectGear
            x: 250
            y: -8
            width: 75
            height: 75
            color: "#000000"
            radius: 1
            anchors.right: recODOmeter.left
            anchors.rightMargin: 10
            anchors.bottom: parent.bottom
            border.width: 1
            border.color: "#ffffff"
            anchors.bottomMargin: 20
            anchors.leftMargin: 3
            Text {
                id: txtGear
                width: 75
                height: 75
                color: "#ffffff"
                text: "N"
                fontSizeMode: Text.HorizontalFit
                horizontalAlignment: Text.AlignHCenter
                lineHeight: 0.7
                anchors.centerIn: parent
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 50
            }
        }

        Rectangle {
            id: recVersion
            x: -450
            width: 210
            height: 24
            color: "#000000"
            radius: 0
            anchors.top: recMilageLeft.bottom
            anchors.topMargin: 15
            visible: (root.role === 0) ? true : false
            Text {
                id: txtVersionLabel
                width: 40
                height: 25
                color: "#ffffff"
                text: qsTr("VER:")
                anchors.left: parent.left
                anchors.leftMargin: 3
                fontSizeMode: Text.FixedSize
                font.family: "Verdana"
                textFormat: Text.PlainText
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 16
            }

            Text {
                id: txtVersion
                y: -9
                width: 160
                height: 25
                color: "#ffffff"
                text: qsTr("YYYYMMDDHHNNSS")
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: txtVersionLabel.right
                objectName: "txtVersion"
                fontSizeMode: Text.FixedSize
                font.family: "Cantarell"
                textFormat: Text.RichText
                verticalAlignment: Text.AlignVCenter
                anchors.leftMargin: 5
                font.pixelSize: 16
            }
        }

        TurnIndicator {
            id: leftIndicator
            x: 0
            y: 0
            width: 75
            height: 75
            flashing: false
            on: false
            direction: Qt.LeftArrow
        }

        TurnIndicator {
            id: rightIndicator
            x: 0
            y: 0
            width: 75
            height: 75
            anchors.right: parent.right
            anchors.rightMargin: 0
            flashing: false
            on: false
            direction: Qt.RightArrow
        }

        ToggleButton {
            id: tbUnit
            y: 627
            width: 75
            height: 75
            text: qsTr("U")
            anchors.left: tbTrip.right
            anchors.leftMargin: 10
            transformOrigin: Item.Center
            z: 1
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            Timer {
                id: longPressTimer1
                interval: style.buttonHoldTimeMs
                repeat: false
                running: false
            }
        }

        QQC1.Button {
            id: btNextView
            x: 0
            y: 636
            width: button_wh
            height: button_wh
            text: qsTr("")
            opacity: 0.7
            enabled: true
            anchors.right: rectGear.left
            z: 3
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20

            style: ButtonStyle {
                label: Image {
                    source: "../images/0-color/next_view.png"
                    fillMode: Image.PreserveAspectFit
                }
            }
            anchors.rightMargin: 10
            onClicked: {
                setNextView()
            }
        }

        Image {
            id: imageReady
            x: -9
            y: 5
            width: 75
            height: 75
            fillMode: Image.PreserveAspectFit
            anchors.leftMargin: 5
            anchors.left: imageRegenBrake.right
            source: "../images/2-iso2575/NO006_56-m10Grey.PNG"
        }

        Image {
            id: imageFrontFogLIght
            x: -9
            y: -8
            width: 75
            height: 75
            anchors.leftMargin: 5
            anchors.topMargin: 0
            anchors.left: imageRearDefogger.right
            fillMode: Image.PreserveAspectFit
            anchors.top: imageLining.top
            source: "../images/2-iso2575/NO014_12-a05Green.PNG"
        }

        // Component QML Type @see https://tinyurl.com/y2ccmb3n
        // @see https://tinyurl.com/y4kugxfx
        Component.onCompleted: {

            // console.debug(this+" onCompleted 2396");
            // console.debug(
            // FIXME: find out why undefined
            // " daw: " + hmiroot.desktopAvailableWidth + ", " +
            // " dah: " + hmiroot.desktopAvailableHeight+ ", " +
            // " w: " + hmiroot.width + ", " +
            // " h: " + hmiroot.height);
        }
    }

    Text {
        id: txtPitch
        y: -15
        width: 60
        height: 25
        color: "#ffffff"
        text: qsTr("pitch:")
        horizontalAlignment: Text.AlignLeft
        visible: false
        anchors.verticalCenterOffset: -55
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 19
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: -135
    }

    Text {
        id: txtRollVal
        x: -15
        y: -6
        width: 60
        height: 25
        color: "#ffffff"
        text: qsTr("")
        horizontalAlignment: Text.AlignLeft
        visible: false
        anchors.verticalCenterOffset: -55
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 15
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: txtRoll.right
        anchors.leftMargin: -135
    }

    Text {
        id: txtRoll
        x: -24
        y: -24
        width: 45
        height: 25
        color: "#ffffff"
        text: qsTr("roll :")
        horizontalAlignment: Text.AlignLeft
        visible: false
        anchors.verticalCenterOffset: -55
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 19
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: txtPitchVal.right
        anchors.leftMargin: -125
    }

    Text {
        id: txtPitchVal
        x: -24
        y: -15
        width: 60
        height: 25
        color: "#ffffff"
        text: qsTr("")
        horizontalAlignment: Text.AlignLeft
        visible: false
        anchors.verticalCenterOffset: -55
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 15
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: txtPitch.right
        anchors.leftMargin: -125
    }

    Text {
        id: txtYawVal
        x: -158
        y: -14
        width: 60
        height: 25
        color: "#ffffff"
        text: qsTr("")
        horizontalAlignment: Text.AlignLeft
        visible: false
        anchors.verticalCenterOffset: -55
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 15
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: txtYaw.right
        anchors.leftMargin: 0
    }

    Text {
        id: txtYaw
        x: -167
        y: -32
        width: 50
        height: 25
        color: "#ffffff"
        text: qsTr("yaw :")
        horizontalAlignment: Text.AlignLeft
        visible: false
        anchors.verticalCenterOffset: -55
        font.pixelSize: 19
        verticalAlignment: Text.AlignVCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: txtRollVal.right
        anchors.leftMargin: 10
    }

    // change view test
    // ref: ( https://is.gd/RWeGRc )
    Item {
        id: statusView
        x: view_left
        y: view_top
        width: view_w
        height: view_h
        anchors.horizontalCenter: parent.horizontalCenter
        z: 3
        visible: false

        Rectangle {
            id: recStatusView
            anchors.fill: parent
            color: style.colorBackground
            border.color: "black"
            border.width: 5
            Text {
                color: "#ffffff"
                text: "status"
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: 15
                renderType: Text.NativeRendering
                elide: Text.ElideLeft
            }

            Rectangle {
                id: rowDateTime
                x: 10
                y: 30
                width: 210
                height: 24
                color: style.colorBackground

                Text {
                    id: txtClock
                    x: 0
                    y: 0
                    width: 210
                    height: 24
                    color: "#ffffff"
                    text: qsTr("2019/11/14 15:30:00")
                    verticalAlignment: Text.AlignVCenter
                    anchors.verticalCenter: parent.verticalCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 22
                    anchors.bottomMargin: 30

                    // QML Example Use timer to update Date
                    // ( https://goo.gl/REe3HA )
                }
            }

            Rectangle {
                id: rowAir
                x: 10
                width: 210
                height: 24
                color: style.colorBackground

                Image {
                    id: imageAir
                    width: 60
                    height: 60
                    anchors.verticalCenter: parent.verticalCenter
                    fillMode: Image.PreserveAspectFit
                    anchors.leftMargin: 0
                    source: "../images/0-color/HMI-ICON-34.png"
                    anchors.left: parent.left
                }

                Text {
                    id: txtAirCaption
                    y: 0
                    height: 24
                    color: "#ffffff"
                    text: qsTr("㎏/㎠")
                    anchors.left: recAirReading.right
                    anchors.leftMargin: 0
                    horizontalAlignment: Text.AlignHCenter
                    MouseArea {
                        width: 70
                        height: 24
                        enabled: false
                        anchors.fill: parent
                        hoverEnabled: false
                    }
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 20
                    verticalAlignment: Text.AlignVCenter
                }

                Rectangle {
                    id: recAirReading
                    y: 379
                    width: 100
                    height: 24
                    color: "#000000"
                    radius: style.rectRadius
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 60

                    Text {
                        id: txtAirReading
                        y: 0
                        width: 70
                        height: 24
                        color: "#ffffff"
                        text: qsTr("0.0")
                        font.pixelSize: 20
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
                anchors.top: rowDateTime.bottom
                anchors.topMargin: 10
            }

            Rectangle {
                id: rowMotorTemp
                x: 10
                width: 210
                height: 24
                color: style.colorBackground
                Image {
                    id: imageMotorTemp
                    width: 60
                    height: 60
                    anchors.verticalCenter: parent.verticalCenter
                    fillMode: Image.PreserveAspectFit
                    anchors.leftMargin: 5
                    source: "../images/1-white/HMI-ICON-32.png"
                    anchors.left: parent.left
                }

                Text {
                    id: txtKph5
                    y: 0
                    height: 24
                    color: "#ffffff"
                    text: qsTr("℃")
                    font.family: "Tahoma"
                    anchors.left: recMotorTemp.right
                    anchors.leftMargin: 0
                    horizontalAlignment: Text.AlignHCenter
                    MouseArea {
                        width: 70
                        height: 24
                        enabled: false
                        anchors.fill: parent
                        hoverEnabled: false
                    }
                    anchors.verticalCenter: parent.verticalCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 20
                }
                Rectangle {
                    id: recMotorTemp
                    y: 379
                    width: 100
                    height: 24
                    color: "#000000"
                    radius: style.rectRadius
                    z: 1
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 60

                    Text {
                        id: txtMotorIoTempReading
                        y: 0
                        width: 70
                        height: 24
                        color: "#ffffff"
                        text: qsTr("0")
                        verticalAlignment: Text.AlignVCenter
                        textFormat: Text.RichText
                        anchors.horizontalCenter: parent.horizontalCenter
                        horizontalAlignment: Text.AlignHCenter
                        anchors.verticalCenter: parent.verticalCenter
                        z: 5
                        lineHeight: 1.1
                        font.pixelSize: 20
                        styleColor: "#000000"
                        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    }
                }
                anchors.top: rowAir.bottom
                anchors.topMargin: 10
            }

            Rectangle {
                id: rowIoTankTemp
                x: 10
                width: 210
                height: 24
                color: style.colorBackground
                Image {
                    id: imageIoTankTemp
                    width: 60
                    height: 60
                    anchors.verticalCenter: parent.verticalCenter
                    fillMode: Image.PreserveAspectFit
                    anchors.leftMargin: 0
                    source: "../images/1-white/white-HMI-ICON-30.png"
                    anchors.left: parent.left
                }

                Text {
                    id: txtOTankTempCaption
                    y: 0
                    width: 22
                    height: 24
                    color: "#ffffff"
                    text: qsTr("℃")
                    renderType: Text.NativeRendering
                    font.family: "Tahoma"
                    anchors.left: recOTankTemp.right
                    anchors.leftMargin: 0
                    horizontalAlignment: Text.AlignLeft
                    MouseArea {
                        width: 22
                        anchors.fill: parent
                        enabled: false
                        hoverEnabled: false
                    }
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 20
                    verticalAlignment: Text.AlignVCenter
                }

                Rectangle {
                    id: recOTankTemp
                    y: 379
                    width: 100
                    height: 24
                    color: "#000000"
                    radius: style.rectRadius
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 60
                    Text {
                        id: txtOTankTemp
                        y: 0
                        width: 70
                        height: 24
                        color: "#ffffff"
                        text: qsTr("0")
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: false
                        }
                        horizontalAlignment: Text.AlignHCenter
                        font.pixelSize: 20
                        verticalAlignment: Text.AlignVCenter
                    }
                }
                anchors.top: rowMotorTemp.bottom
                anchors.topMargin: 10
            }

            Rectangle {
                id: rect24V
                x: 10
                width: 210
                height: 24
                color: style.colorBackground

                anchors.top: rowIoTankTemp.bottom
                anchors.topMargin: 10
                Image {
                    id: imageV24
                    width: 60
                    height: 60
                    anchors.verticalCenter: parent.verticalCenter
                    fillMode: Image.PreserveAspectFit
                    anchors.leftMargin: 0
                    source: "../images/1-white/white-HMI-ICON-17.png"
                    anchors.left: parent.left
                }

                Text {
                    id: txtKph9
                    y: 0
                    width: 42
                    height: 24
                    color: "#ffffff"
                    text: qsTr("volt")
                    anchors.left: rec24V.right
                    anchors.leftMargin: 0
                    font.family: "Tahoma"
                    horizontalAlignment: Text.AlignLeft
                    MouseArea {
                        width: 42
                        height: 40
                        anchors.fill: parent
                        hoverEnabled: false
                    }
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 20
                    verticalAlignment: Text.AlignVCenter
                }

                Rectangle {
                    id: rec24V
                    y: 439
                    width: 100
                    height: 24
                    color: "#000000"
                    radius: style.rectRadius
                    anchors.left: parent.left
                    anchors.leftMargin: 60
                    anchors.verticalCenter: parent.verticalCenter
                    Text {
                        id: txtV24
                        y: 0
                        width: 70
                        height: 24
                        color: "#ffffff"
                        text: qsTr("0.0")
                        anchors.verticalCenterOffset: 0
                        verticalAlignment: Text.AlignVCenter
                        MouseArea {
                            width: 70
                            height: 40
                            anchors.left: parent.left
                            hoverEnabled: false
                            anchors.top: parent.top
                        }
                        anchors.verticalCenter: parent.verticalCenter
                        horizontalAlignment: Text.AlignHCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.pixelSize: 20
                    }
                }
            }

            Rectangle {
                id: rectSoc
                x: 10
                width: 210
                height: 24
                color: style.colorBackground
                anchors.topMargin: 10
                Image {
                    id: imageSOC
                    width: 55
                    height: 55
                    source: "../images/1-white/white-HMI-ICON-25.png"
                    fillMode: Image.PreserveAspectFit
                    anchors.verticalCenter: parent.verticalCenter
                    sourceSize.width: 267
                    anchors.leftMargin: 4
                    anchors.left: parent.left
                    anchors.verticalCenterOffset: 0
                    sourceSize.height: 267
                }

                Text {
                    id: txtSocSuffix
                    y: 0
                    height: 24
                    color: "#ffffff"
                    text: qsTr("%")
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: 0
                    MouseArea {
                        width: 70
                        height: 24
                        enabled: false
                        hoverEnabled: false
                        anchors.fill: parent
                    }
                    anchors.left: recStation1.right
                    font.pixelSize: 24
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                }

                Rectangle {
                    id: recStation1
                    y: 439
                    width: 100
                    height: 24
                    color: "#000000"
                    radius: style.rectRadius
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: 60
                    Text {
                        id: txtSocValue
                        y: 0
                        width: 70
                        height: 24
                        color: "#ffffff"
                        text: qsTr("0")
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        MouseArea {
                            width: 70
                            height: 24
                            enabled: false
                            hoverEnabled: false
                            anchors.fill: parent
                        }
                        font.pixelSize: 20
                        anchors.verticalCenterOffset: 0
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }
                    anchors.left: parent.left
                }

                Rectangle {
                    id: recBSOC
                    x: 22
                    y: 7
                    width: bsoc_width
                    height: 9
                    z: 2
                    gradient: Gradient {
                        GradientStop {
                            position: 0
                            color: "#2b40f0"
                        }

                        GradientStop {
                            position: 0.33
                            color: "#5fb4f0"
                        }

                        GradientStop {
                            position: 1
                            color: "#2b40f0"
                        }
                    }
                }
                anchors.top: rect24V.bottom
            }
            // cannot specify left, right... inside Row, Row will not work.
            Rectangle {
                id: recMilageLeft
                x: 10
                width: 210
                height: 24
                color: style.colorBackground

                Image {
                    id: imageStation
                    width: 55
                    height: 55
                    anchors.verticalCenterOffset: 0
                    sourceSize.height: 267
                    sourceSize.width: 267
                    source: "../images/1-white/20190308HMI-ICON-85.png"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    fillMode: Image.PreserveAspectFit
                    anchors.leftMargin: 4
                }

                Text {
                    id: txtMLeftSuffix
                    y: 0
                    height: 24
                    color: "#ffffff"
                    // ref. regulation 75 appendix 15
                    text: qsTr("km")
                    anchors.left: recStation.right
                    anchors.leftMargin: 0
                    anchors.verticalCenter: parent.verticalCenter
                    MouseArea {
                        width: 70
                        height: 24
                        anchors.fill: parent
                        hoverEnabled: false
                    }
                    font.pixelSize: 24
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                }

                Rectangle {
                    id: recStation
                    y: 439
                    width: 100
                    height: 24
                    color: "#000000"
                    radius: style.rectRadius
                    anchors.verticalCenter: parent.verticalCenter
                    Text {
                        id: txtMilageLeft
                        y: 0
                        width: 70
                        height: 24
                        color: "#ffffff"
                        text: qsTr("000.0")
                        anchors.verticalCenter: parent.verticalCenter
                        MouseArea {
                            width: 70
                            height: 24
                            anchors.right: parent.right
                            hoverEnabled: false
                        }
                        font.pixelSize: 20
                        anchors.horizontalCenter: parent.horizontalCenter
                        horizontalAlignment: Text.AlignHCenter
                        anchors.verticalCenterOffset: 0
                        verticalAlignment: Text.AlignVCenter
                    }
                    anchors.left: parent.left
                    anchors.leftMargin: 60
                }
                anchors.top: rectSoc.bottom
                anchors.topMargin: 12
            }
        }
    }

    Item {
        id: cruiseView
        x: view_left
        y: view_top
        width: view_w
        height: view_h
        z: 4
        anchors.horizontalCenter: parent.horizontalCenter
        visible: false
        Rectangle {
            id: recCruiseView
            anchors.fill: parent
            color: style.colorBackground
            border.color: "black"
            border.width: 5
            Text {
                text: "cruise"
                color: "#ffffff"
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: 15
                renderType: Text.NativeRendering
                elide: Text.ElideLeft
            }
        }
    }

    Item {
        id: warninigView
        x: view_left
        y: view_top
        width: view_w
        height: view_h
        anchors.horizontalCenter: parent.horizontalCenter
        visible: true
        Rectangle {
            id: recWarningView
            anchors.fill: parent
            color: style.colorBackground
            border.color: "black"
            border.width: 5

            Text {
                id: txtWarningCap
                text: "alarm"
                color: "#ffffff"
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: 15
                renderType: Text.NativeRendering
                elide: Text.ElideLeft
            }

            Text {
                id: txtAlarmIDCap
                x: 10
                y: -8
                color: "#ffffff"
                text: "ID :"
                anchors.left: parent.left
                anchors.leftMargin: 10
                renderType: Text.NativeRendering
                anchors.top: txtWarningCap.bottom
                elide: Text.ElideLeft
                font.pointSize: 15
                anchors.topMargin: 0
            }

            Text {
                id: txtAlarmTextCap
                x: 10
                y: 0
                color: "#ffffff"
                text: "Text :"
                renderType: Text.NativeRendering
                anchors.top: txtAlarmIDCap.bottom
                elide: Text.ElideLeft
                font.pointSize: 15
                anchors.left: parent.left
                anchors.topMargin: 0
                anchors.leftMargin: 10
            }

            Text {
                id: txtAlarmSeperator
                color: "#ffffff"
                text: "----------------------------------------------------------------------------------------"
                anchors.top: txtAlarmTextCap.bottom
                anchors.topMargin: 0
                anchors.right: parent.right
                anchors.left: parent.left
                renderType: Text.NativeRendering
                elide: Text.ElideLeft
                font.pointSize: 15
            }
        }
    }

    Item {
        id: efficiencyView
        x: view_left
        y: view_top
        width: view_w
        height: view_h
        anchors.horizontalCenter: parent.horizontalCenter
        visible: false
        Rectangle {
            id: recEfficiencyView
            anchors.fill: parent
            color: style.colorBackground
            border.color: "black"
            border.width: 5

            Text {
                text: "efficiency"
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#ffffff"
                anchors.top: parent.top
                anchors.topMargin: 0
                font.pointSize: 15
                renderType: Text.NativeRendering
                elide: Text.ElideLeft
            }
            ChartView {
                id: energy
                x: 0
                title: "energy consumption ( kw )"
                titleColor: "white"
                titleFont.pointSize: 15
                backgroundColor: style.colorBackground
                y: 150

                width: 420
                height: 260
                // anchors.fill: parent
                anchors.right: parent.right
                anchors.rightMargin: 10
                anchors.horizontalCenter: parent.horizontalCenter
                visible: true
                z: 1
                antialiasing: true

                // QTBUG-68470, ref: ( https://is.gd/XrN4sl )
                // it is only annoied when in Qt Creater designer mode
                // legend.visible: false

                // Define x-axis to be used with the series instead of default one
                ValueAxis {
                    id: valueAxis
                    min: 0
                    max: 49
                    tickCount: max_sample_display
                    labelFormat: "%.0f"
                    labelsFont.pointSize: 10
                    gridVisible: true
                    labelsVisible: false
                    gridLineColor: "#d7d6d5"
                }

                ValueAxis {
                    id: valueAxisKw
                    min: -80 //-500
                    max: 150 //1000
                    tickCount: 15
                    labelFormat: "%.0f"
                    labelsFont.pointSize: 5
                    labelsVisible: false
                    gridVisible: true
                    gridLineColor: "#80c342"
                }

                // Qt Creator QML editor design mode complains,
                // workaround ref: ( https://is.gd/mfgYYU )
                anchors {
                    margins: -15
                }
                margins {
                    right: 0
                    bottom: 0
                    left: 0
                    top: 0
                }

                AreaSeries {
                    id: areaSeries1
                    axisX: valueAxis
                    axisY: valueAxisKw
                    color: "#7CFC00"
                    lowerSeries: LineSeries {
                        color: "Chartreuse"
                        id: lowerLineSeries
                        style: Qt.DotLine
                    }
                    upperSeries: LineSeries {
                        //color: "DarkOrange"
                        id: upperLineSeries
                        style: Qt.DotLine
                        //XYPoint { x: 00; y: 750 }
                        //XYPoint { x: 01; y: 500 }
                    }
                }
                // ( https://is.gd/BsvBXx )
                onSeriesRemoved: {

                }
            }

            // official ref: ( https://is.gd/QJu3og )
            // customization ref: ( https://is.gd/NUZZko )
            ProgressBar {
                id: powerProgressBar
                x: 0
                y: 30
                width: 450
                height: 30
                indeterminate: true
                focusPolicy: Qt.WheelFocus
                spacing: 3
                anchors.horizontalCenter: parent.horizontalCenter
                visible: true
                to: 250
                contentItem: Item {
                    implicitWidth: 200
                    Rectangle {
                        width: powerProgressBar.visualPosition * parent.width
                        height: parent.height
                        radius: 2
                        color: (150 <= powerProgressBar.value) ? "red" : (90 <= powerProgressBar.value && powerProgressBar.value < 150) ? "yellow" : "#17a81a"
                    }
                    implicitHeight: 4
                }
                value: 0
                smooth: true
                Behavior on value {
                    NumberAnimation {
                        duration: 250
                    }
                }
                background: Rectangle {
                    border.color: "lightgray"
                    color: style.colorBackground
                    radius: 3
                    implicitWidth: 200
                    implicitHeight: 6
                }
                padding: 2
                from: 0.2
            }

            Gauge {
                id: powerGauge1
                x: -9
                y: 60
                width: 500
                height: 30
                anchors.horizontalCenter: parent.horizontalCenter
                maximumValue: 250
                rotation: 0
                value: 100
                smooth: true
                minimumValue: 0
            }
        }
    }

    QQC1.Button {
        id: btnMenu
        text: "Open"
        checkable: true
        opacity: 0.5
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        x: Math.round(parent.width - width)
        y: Math.round(parent.height - height)

        width: button_wh
        height: button_wh
        onClicked: {
            if (btnMenu.checked)
                listPopup.close()
            else
                listPopup.open()
        }
        style: ButtonStyle {
            label: Image {
                source: "../images/menu.png"
                fillMode: Image.PreserveAspectFit
            }
        }
    }

    Popup {
        id: listPopup
        // property alias model : view.model
        property variant currentValue
        property variant currentItem: model[view.currentIndex]

        property int itemWidth: button_wh
        property int itemHeight: button_wh

        x: btnMenu.x
        y: btnMenu.y - button_wh * listmodel1.count
        width: button_wh
        height: button_wh * listmodel1.count
        opacity: 0.5
        padding: 0

        // signal selected
        ListView {
            id: view
            anchors.fill: parent
            anchors.margins: 0
            width: parent.width
            snapMode: ListView.SnapOneItem
            currentIndex: 0
            // fancy spreading
            populate: Transition {
                NumberAnimation {
                    properties: "x,y"
                    duration: 50
                }
            }
            verticalLayoutDirection: ListView.BottomToTop
            // highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
            // https://stackoverflow.com/a/34159246
            highlightFollowsCurrentItem: true
            highlight: Rectangle {
                color: "lightgray"
                radius: 3
            }
            highlightMoveDuration: 50
            highlightMoveVelocity: 1000
            focus: true
            model: ListModel {
                id: listmodel1
                ListElement {
                    // signal to CPP
                    sig: "Battery"
                    iconSrc: "../images/0-color/HMI-ICON-51.png"
                }
                ListElement {
                    sig: "ChargingStation"
                    iconSrc: "../images/0-color/HMI-ICON-53.png"
                }
                ListElement {
                    sig: "TPMS"
                    iconSrc: "../images/0-color/20190703HMI-ICON-86.png"
                }
                ListElement {
                    sig: "Diagnosis"
                    iconSrc: "../images/0-color/20190703HMI-ICON-90.png"
                }
                ListElement {
                    sig: "UNLOCK"
                    iconSrc: "../images/0-color/20190703HMI-ICON-92.png"
                }
                ListElement {
                    sig: "IconDesc"
                    iconSrc: "../images/0-color/20190703HMI-ICON-94.png"
                }
                ListElement {
                    sig: "vehicleInfoWindow"
                    iconSrc: "../images/0-color/HMI-ICON-57.png"
                }
                ListElement {
                    sig: "historyWindow"
                    iconSrc: "../images/0-color/20190703HMI-ICON-83.png"
                }
                ListElement {
                    sig: "Parameters"
                    iconSrc: "../images/0-color/20190308HMI-ICON-96.png"
                }
            }
            Component {
                id: delegateListElement
                Rectangle {
                    width: view.width
                    height: button_wh
                    //color: view.isCurrentItem ? "white" : "transparent"
                    // ref: ( https://is.gd/vBdBy3 )
                    property alias entered: maItem.isEntered
                    color: entered ? "white" : "transparent"
                    Item {
                        property int indexOfThisDelegate: index
                        width: button_wh
                        height: button_wh
                        Image {
                            anchors.fill: parent
                            source: iconSrc
                            fillMode: Image.PreserveAspectFit
                            anchors.centerIn: parent
                        }
                        MouseArea {
                            id: maItem
                            property bool isEntered: false
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: {
                                view.positionViewAtIndex(index,
                                                         ListView.Contain)
                                view.currentIndex = index /*OfThisDelegate*/
                                view.forceActiveFocus()
                                isEntered = false
                            }
                            onEntered: {
                                isEntered = true
                                //console.log(index + ": onEntered = "+isEntered);
                                view.positionViewAtIndex(index,
                                                         ListView.Contain)
                                view.forceActiveFocus()
                            }
                            onExited: {
                                isEntered = false
                                view.currentIndex = -1
                            }
                        }
                    }
                }
            }
            delegate: delegateListElement
            onCurrentItemChanged: {
                hmiroot.qmlSignal(listmodel1.get(currentIndex).sig)
            }
        }
    }

    onActiveChanged: {
        if (true === hmiroot.active) {
            root.qmlSignalActive(hmiroot.objectName)
            // clockTimer.start();
        } else {
            // clockTimer.stop();
            listPopup.close()
            view.currentIndex = -1
        }
    }

    // Full-screen desktop application with QML
    // @see https://tinyurl.com/udrf9tr
    // How to make full screen in qt quick?
    // @see https://tinyurl.com/vdh5m4q
    // start apps fullscreen? >xfce
    // @see https://tinyurl.com/sqox5ap
    Component.onCompleted: {

        // console.debug(this.objectName+" onCompleted");
        // root.qmlSignalCompleted(this.objectName); // to notify window loaded
        // hmiroot.showFullScreen(); // handle by cpp
    }

    Connections {
        target: handlerVcuHmiMSG01
        onSignalVcuHmiMSG01: {
            //console.log("Received in QML from C++: " + lturn +
            //", " + rturn + ", " + rear_defogger_light);
            leftIndicator.on = (lturn !== 0) ? true : false

            //leftIndicator.flashing = ( lturn !== 1 ) ? true:false;
            // TODO: relay "sound" and screen "flash" synchronization issue.
            rightIndicator.on = (rturn !== 0) ? true : false

            //rightIndicator.flashing = ( rturn !== 0 ) ? true:false;
            imageHeadLights.source = (hd_light !== 0) ? "../images/0-color/HMI-ICON-03.png" : "" // ../images/1-white/white-HMI-ICON-03.png

            // TODO: regulation is blue
            imageSideLights.source = (side_light !== 0) ? "../images/0-color/HMI-ICON-04.png" : "" // ../images/1-white/HMI-ICON-04.png

            imageHazardLight.source = (hazard_light !== 0) ? "../images/0-color/HMI-ICON-07.png" : "" // ../images/1-white/white-HMI-ICON-07.png

            imageAccessLight.source = (access_light !== 0) ? "../images/0-color/HMI-ICON-19.png" : "" // ../images/1-white/white-HMI-ICON-19.png

            imageDoorOpen.source
                    = (door_open !== 0) ? "../images/1-white/20190308HMI-ICON-99.png" : ""
            imageRearDefogger.source = (rear_defogger_light
                                        !== 0) ? "../images/0-color/20190308HMI-ICON-82.png" : ""
        }

        onSignalVcuHmiMSG01B1: {
            imageEcasKneeling.source
                    = (ecas_kneeling !== 0) ? "../images/1-white/white-HMI-ICON-11.png" : ""
            imageRearFogLight.source
                    = (rear_fog_light !== 0) ? "../images/0-color/20190308HMI-ICON-82.png" : ""

            imageAlarmGetOff.source = (alarm_getoff !== 0) ? "../images/0-color/HMI-ICON-29.png" : "" // ../images/1-white/white-HMI-ICON-29.png

            imageRegenBrake.source = (regen_brake !== 0) ? "../images/0-color/HMI-ICON-08.png" : "" // ../images/1-white/white-HMI-ICON-08.png

            imageParking.source = (parking !== 0) ? "../images/0-color/HMI-ICON-09.png" : "" // ../images/1-white/white-HMI-ICON-09.png

            // console.debug("mo "+motor_overrun+", op "+motor_op);
            mtr_op = motor_op
            mtr_overrun = motor_overrun
            setMotorState(mtr_op, mtr_overrun, mtr_alarm)
            // TODO: there is a warning icon, yellow, 63.
            // "../images/0-color/HMI-ICON-63.png"
        }

        onSignalVcuHmiMSG01B2: {

            //console.debug(abs+","+ecas_warn+","+lining+","+emergency_exit);
            imageAbs.source = (abs === 2) ? "../images/0-color/HMI-ICON-14.png" : (abs === 1) ? "../images/0-color/20190308HMI-ICON-79.png" : "" // ../images/1-white/white-HMI-ICON-14.png

            imageEcas.source = (ecas_warn === 2) ? "../images/0-color/HMI-ICON-13.png" : (ecas_warn === 1) ? "../images/0-color/HMI-ICON-12.png" : ""

            imageLining.source = (lining === 1) ? "../images/0-color/20190308HMI-ICON-80.png" : "" // ../images/1-white/white-HMI-ICON-10.png
            imageEvacuation.source = (emergency_exit
                                      === 1) ? "../images/0-color/HMI-ICON-24.png" : ""
        }

        onSignalVcuHmiMSG01B3: {
            // TODO: cf. design doc, text color is annotated.
            mtr_alarm = motor_alarm
            setMotorState(mtr_op, mtr_overrun, mtr_alarm)
            imageAir.source = (air_alarm === 2) ? "../images/0-color/HMI-ICON-35.png" : (air_alarm === 1) ? "../images/0-color/HMI-ICON-36.png" : "../images/0-color/HMI-ICON-34.png"

            imagePSteering.source = (psteering_alarm === 2) ? "../images/0-color/HMI-ICON-15.png" : (psteering_alarm === 1) ? "../images/0-color/HMI-ICON-62.png" : "" // ../images/1-white/white-HMI-ICON-15.png

            imageMainPower.source = (mpower_alarm === 2) ? "../images/0-color/HMI-ICON-61.png" : (mpower_alarm === 1) ? "../images/0-color/HMI-ICON-16.png" : "" // ../images/1-white/white-HMI-ICON-16.png
        }

        onSignalVcuHmiMSG01B4: {
            imageV24.source = (v24_alarm === 2) ? "../images/0-color/HMI-ICON-18.png" : (v24_alarm === 1) ? "../images/0-color/HMI-ICON-64.png" : "../images/1-white/white-HMI-ICON-17.png"
        }

        onSignalVcuHmiMSG01B5: {
            switch (gear) {
            case 0:
                txtGear.text = "N"
                break
            case 1:
                txtGear.text = "1"
                break
            case 2:
                txtGear.text = "2"
                break
            case 3:
                txtGear.text = "3"
                break
            case 4:
                txtGear.text = "4"
                break
            case 5:
                txtGear.text = "5"
                break
            case 6:
                txtGear.text = "6"
                break
            case 7:
                txtGear.text = "R"
                break
            default:
                txtGear.text = ""
            }
        }

        onSignalVcuHmiMSG01B6: {
            // speedometer.value = speed;
            speedometer.value = parseFloat(reading) / 100
            // console.debug("onSignalVcuHmiMSG01B6: "+speed+", "+reading);


            /*
        if ( 120 <= speedometer.value )
        speedText.color = "red";
        else
        speedText.color = "#e5e5e5";
        */
        }
    }

    Connections {
        target: handlerVcuHmiMSG02
        onSignalVcuHmiMSG02Byte0_5: {
            // TODO: global constant criteria
            if (6.5 <= s_air)
                txtAirReading.color = style.colorNormal
            else if (6.0 <= s_air && s_air < 6.5)
                txtAirReading.color = style.colorWarning
            else
                // s_air < 6.0
                txtAirReading.color = style.colorAlert
            txtAirReading.text = s_air

            //    = parseFloat(Math.round(s_air*10)/10).toFixed(1);
            if (motor_temp <= 69)
                txtMotorIoTempReading.color = style.colorNormal
            else if (69 < motor_temp && motor_temp < 85)
                txtMotorIoTempReading.color = style.colorWarning
            else
                // 85 <= motor_temp
                txtMotorIoTempReading.color = style.colorAlert
            txtMotorIoTempReading.text = motor_temp

            if (otank_temp2 < 55)
                txtOTankTemp.color = style.colorNormal
            else if (55 <= otank_temp2 && otank_temp2 < 60)
                txtOTankTemp.color = style.colorWarning
            else
                // 60 <= otank_temp2
                txtOTankTemp.color = style.colorAlert
            txtOTankTemp.text = otank_temp2

            // 20200213 meeting conclusion
            // TODO: speed up by eliminate extra instruction
            v24 = parseFloat(s_v24)
            // console.debug(s_v24 + "," + v24);
            if (v24 <= volt_WARN) {
                txtV24.color = style.colorAlert
            } else if (volt_WARN < v24 && v24 <= volt_NORMAL) {
                txtV24.color = style.colorWarning
            } else {
                txtV24.color = style.colorNormal
            }
            txtV24.text = s_v24
        }

        onSignalVcuHmiMSG02Byte6: {

            // console.debug(air_unlock + ", " +
            //  passenger_unlock );


            /*emergency_unlock,
            wproff_unlock,
            ecas_unlock,
            isolation_abnormal_unlock,
            v24_carlock_unlock);*/
            // TODO:
        }
    }

    Connections {
        target: handlerVcuHmiMSG03
        onSignalVcuHmiMSG03: {
            current_total = s_total
            current_trip = s_trip
            if (tbTrip.checked) {
                txtMilage.text = s_trip
            } else {
                txtMilage.text = s_total
            }
            //console.debug("total "+current_total+
            //    " trip "+current_trip+" status "+tbTrip.checked);
        }
    }

    Connections {
        target: handlerVcuHmiMSG04
        onSignalVcuHmiMSG04: {
            txtMilageLeft.text = s_left
            powerCircularGauge.value = s_delta // for powerGauge
            powerProgressBar.value = s_delta
            energy_consumed = s_delta // for chart
            // TODO: perkm
        }
    }

    Connections {
        target: handlerVcuPwrStatus
        onSignalVcuPwrStatus: {
            txtXValue.text = sHex
        }
    }

    Connections {
        target: handlerBmsVcuMSG01
        onSignalBmsVcuMSG01: {

            // var num = soc/100 + Math.random().toFixed(3);
            // var n = num.toFixed(3); // FIXME:
            // rpmGauge.value = num.toFixed(3); // FIXME:
            //statusIndicator.color =
            //   ( soc <= 19 ) ?
            // "red" : ( 20 <= soc && soc <= 29 ) ?
            //"yellow" : "cyan";
            // statusIndicator.active = true;
            if (bms_state === 0) {
                imageBatteryStatus.source = "../images/2-iso2575/55-m07Green.PNG"
            } else if (bms_state === 1) {
                imageBatteryStatus.source = "../images/2-iso2575/55-m07Green.PNG"
            } else if (bms_state === 2) {
                imageBatteryStatus.source = "../images/2-iso2575/55-m07Yellow.PNG"
            } else if (bms_state === 3) {
                imageBatteryStatus.source = "../images/2-iso2575/56-m08Red.PNG"
            } else {

            }

            txtSocValue.text = soc
            recBSOC.width = bsoc_width * (soc / 100)
            // TODO:
            imageTyre.source = ""
        }
    }

    Connections {
        target: handlerPcuStMot01
        onSignalPcuStMot01: {
            //console.debug("updateMsg_PCU_ST_MOT_1 "+s_rpm+", "
            //+s_torq+", "+s_dclv+", "+s_mechpwr);
            rpmGauge.value = parseFloat(s_rpm) / 1000
            //console.debug(parseFloat(s_rpm)+", "+parseFloat(s_rpm)/1000);
        }
    }

    Connections {
        target: handlerPcuCmdMt01
        onSignalPcuCmdMt01: {
            //console.debug("updateMsg_PCU_CMD_MOT_1 "+ctrl_mode+", "+mtrun_cmd);
            txtControlModeVal.text = ctrl_mode
            txtMotorRunCmdVal.text = mtrun_cmd
        }
    }

    Connections {
        target: worker
        onSignalLoadMenuText: {
            console.debug("onSignalLoadMenuText [" + locale + "]")
        }

        onSignalDisplayGSensor: {


            /*txtXValue.text = s_x;
        txtYValue.text = s_y;
        txtZValue.text = s_z;
        txtPitchVal.text = s_pitch;
        txtRollVal.text = s_roll;
        txtYawVal.text = s_yaw;*/
        }
    }

    Connections {
        target: canrxthread
        onSignalDisplayInfo: {
            txtYValue.text = dinfo
        }
    }

    Connections {
        target: handlerAlmMSG00
        onSignalAlmMSG00: {
            // console.debug(alarmText);
            // txtAlarmContent.text = alarmText;
            num_sec_alarm = 0
            // TODO: call reset_hold_timer();
            // test longest size to rectangle
            AlarmParameters.getContentById(633)
        }
    }

    Connections {
        target: handlerAlmMSG01
        onSignalAlmMSG01: {

            // TODO: to be implemented
            //txtAlarmContent.text = alarmText;
        }
    }

    Connections {
        target: handlerAlmMSG02
        onSignalAlmMSG02: {

            // txtAlarmContent.text = alarmText;
        }
    }

    Connections {
        target: handlerAlmMSG03
        onSignalAlmMSG03: {

            // txtAlarmContent.text = alarmText;
        }
    }

    Connections {
        target: handlerDcdcMSG00
        onSignalAlmMSG04: {

            // txtAlarmContent.text = alarmText;
        }
    }

    Connections {
        target: handlerBcuErMSG01
        onSignalAlmMSG05: {

            // txtAlarmContent.text = alarmText;
        }
    }

    Connections {
        target: handlerBmsCmuErrMSG01
        onSignalAlmMSG06: {

            // txtAlarmContent.text = alarmText;
        }
    }

    Connections {
        target: handlerPcuStSys03
        onSignalAlmMSG07: {

            // txtAlarmContent.text = alarmText;
        }
    }

    Connections {
        target: handlerPcuStSys04
        onSignalAlmMSG08: {

            // txtAlarmContent.text = alarmText;
        }
    }
}

/*##^##
Designer {
    D{i:157;anchors_x:0}D{i:158;anchors_x:0}D{i:159;anchors_x:19;anchors_y:-6}
}
##^##*/

