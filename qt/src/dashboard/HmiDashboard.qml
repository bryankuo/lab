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

import QtQuick 2.2 // FIXME: TapHandler is not a type
// import QtQuick 2.11 // FIXME: "QtQuick" version 2.14 is not installed,
// TODO: find out how to import 2.12 and beyond version

import QtQuick.Window 2.2
import QtQuick.Extras 1.4
import QtQuick.Controls 1.4
// mark to prevent importing SwitchDelegate such that delaybutton 'round'
// import QtQuick.Controls 2.5

// Access C++ function from QML
// https://goo.gl/nxZegu
//import com.myself 1.0
// signal from c++ to QML slot

import QtCharts 2.3
import "style"

ApplicationWindow {
    id: hmiroot
    objectName: "hmiroot"
    visible: true   // this is mandatory
    visibility: Window.FullScreen
    Styles { id: style }
    Models { id: model }
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

    color: "#161616"
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
    property variant win;  // you can hold this as a reference..
    // Defining Property Attributes ( https://goo.gl/p2Rg16 )
    property string current_trip : "000000.0" // string
    property string current_total : "000000.0"
    property real max_sample_display : 30
    property real update_freq : 1 // number of second
    property real energy_consumed : 0 // place holder for Chart
    //title: qsTr("RACEV HMI")
    property var mtr_op;
    property var mtr_overrun;
    property var mtr_alarm;
    property int num_sec_alarm;
    property int bsoc_width : 16;

    // TODO: global constant
    property double volt_NORMAL: 23.0
    property double volt_WARN: 22.0
    property double v24: 0.0

    //onActiveFocusItemChanged: print("activeFocusItem", activeFocusItem)
    // Connecting to QML Signals ( https://goo.gl/gFZphL )
    signal qmlSignal(string msg)
    // c++ -> QML ( https://goo.gl/sHMaKL )

    // https://tinyurl.com/vfr5y6p
    signal qmlSignalPressAndHold();

    // @see https://tinyurl.com/qs42sty
    function formatDate(date) {
    var d = new Date(date),
        month = '' + (d.getMonth() + 1),
        day = '' + d.getDate(),
        year = d.getFullYear(),
        hour = '' + d.getHours(),
        min = '' + d.getMinutes(),
        sec = '' + d.getSeconds();

    if (month.length < 2)
        month = '0' + month;
    if (day.length < 2)
        day = '0' + day;
    if (hour.length < 2)
        hour = '0' + hour;
    if (min.length < 2)
        min = '0' + min;
    if (sec.length < 2)
        sec = '0' + sec;

    return [year, month, day].join('-')+' '
    + [hour,min,sec].join(':');
    }

    // not called
    function updateSystemInfo(n_dbop, cpu, freemem) {
        //console.log("updateSystemInfo+ ", freemem)
        //text1.text = timestamp; // https://goo.gl/UQ4jEV
        // better not do calculation in QML, just display
        dbop.text = n_dbop;
        cpu1.text = cpu;
        fmem1.text = freemem;
        return ""
    }

    // note: Qt Creator moves function code location,
    // such that QMetaObject::invokeMethod complains 'No such method'
    function updateModel(speed, rpm, gear, milage) {
        valueSource.kph = speed;
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
        isAnimating = is_on;
        //console.debug("setAnimation +++ " + isAnimating);
    }

    // byte0
    function update_VCU_HMI_Msg_1(lturn, rturn, hd_light, side_light,
    hazard_light, access_light, door_open, rear_defogger_light) {
    leftIndicator.on = ( lturn !== 0 ) ? true:false;
    //leftIndicator.flashing = ( lturn !== 1 ) ? true:false;
    // TODO: relay "sound" and screen "flash" synchronization issue.

    rightIndicator.on = ( rturn !== 0 ) ? true:false;
    //rightIndicator.flashing = ( rturn !== 0 ) ? true:false;

    imageHeadLights.source = ( hd_light !== 0 )
        ? "../images/0-color/HMI-ICON-03.png"
        : ""; // ../images/1-white/white-HMI-ICON-03.png
    // TODO: regulation is blue

    imageSideLights.source = ( side_light !== 0 )
        ? "../images/0-color/HMI-ICON-04.png"
        : ""; // ../images/1-white/HMI-ICON-04.png

    imageHazardLight.source = ( hazard_light !== 0 )
        ? "../images/0-color/HMI-ICON-07.png"
        : ""; // ../images/1-white/white-HMI-ICON-07.png

    imageAccessLight.source = ( access_light !== 0 )
        ? "../images/0-color/HMI-ICON-19.png"
        : ""; // ../images/1-white/white-HMI-ICON-19.png

    imageDoorOpen.source = ( door_open !== 0 )
        ? "../images/1-white/20190308HMI-ICON-99.png"
        : "";
    imageRearDefogger.source = ( rear_defogger_light !== 0 )
        ? "../images/0-color/20190308HMI-ICON-82.png"
        : "";
    }

    function setMotorState(m_op, m_overrun, m_alarm) {
    // console.debug(m_op+", "+m_overrun+", "+m_alarm);
    // in the order of highest priority:
    if ( m_alarm === 2 ) {
        imageMotor.source = "../images/0-color/HMI-ICON-21.png";
    }
    else if ( m_overrun === 1 ) {
        imageMotor.source = "../images/0-color/HMI-ICON-21.png";
    }
    else if ( m_alarm === 1 ) {
        imageMotor.source = "../images/0-color/HMI-ICON-63.png";
    }
    else {
        if ( m_op === 1 ) {
        imageMotor.source = "../images/0-color/HMI-ICON-20.png";
        }
        else {
        imageMotor.source = "";
        }
    }
    }

    ValueSource {
        id: valueSource
        //objectName: "valueSource1" // ( https://goo.gl/Caomvq )
    }

    Rectangle {
        id: rectangle
        //color: "lightGrey"
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 800
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 1280

        Text {
            id: txtVersionLabel
            x: 790
            width: 50
            height: 25
            color: "#ffffff"
            text: qsTr("VER:")
            anchors.verticalCenterOffset: 112
            font.family: "Verdana"
            fontSizeMode: Text.FixedSize
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 16
            anchors.verticalCenter: parent.verticalCenter
            textFormat: Text.PlainText
        }

        Text {
            id: txtVersion
            y: -9
            width: 200
            height: 25
            color: "#ffffff"
            text: qsTr("YYYYMMDDHHNNSS")
            anchors.verticalCenterOffset: 112
            font.family: "Cantarell"
            fontSizeMode: Text.FixedSize
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 16
            anchors.verticalCenter: parent.verticalCenter
            textFormat: Text.RichText
            anchors.left: txtVersionLabel.right
            objectName: "txtVersion"
            anchors.leftMargin: 0
        }
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
    y: style.msgBarY
    width: style.msgBarWidth
    height: style.msgBarHeight
    color: "#1f1f1f"
    anchors.bottomMargin: 0
    anchors.bottom: parent.bottom

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
        anchors.fill: parent
        onClicked: {
        root.qmlSignalClickAlarmRectangle("NEXT", 1);
        console.log("clicked...");
        }
    }
    }

        Rectangle {
        id: rowAir
        width: 250
        height: 24
        color: "#161616"
        anchors.horizontalCenter: parent.horizontalCenter

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
        x: -8
        width: 250
        height: 24
        color: "#161616"
        anchors.horizontalCenter: parent.horizontalCenter
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
        x: -6
        width: 250
        height: 24
        color: "#161616"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: rowMotorTemp.bottom
        anchors.topMargin: 10
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
            width: 70
            height: 24
            color: "#ffffff"
            text: qsTr("℃")
            renderType: Text.NativeRendering
            font.family: "Tahoma"
            anchors.left: recOTankTemp.right
            anchors.leftMargin: 0
            horizontalAlignment: Text.AlignLeft
            MouseArea {
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
        }

        Rectangle {
        id: rect24V
        x: -10
        width: 250
        height: 24
        color: "#161616"
        anchors.horizontalCenter: parent.horizontalCenter

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
            width: 70
            height: 24
            color: "#ffffff"
            text: qsTr("volt")
            anchors.left: rec24V.right
            anchors.leftMargin: 0
            font.family: "Tahoma"
            horizontalAlignment: Text.AlignLeft
            MouseArea {
                width: 70
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
        id: rowDateTime
        width: 250
        height: 24
        color: "#161616"
        anchors.top: parent.top
        anchors.topMargin: 80
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
        id: txtClock
        x: 0
        y: 0
        width: 250
        height: 24
        color: "#ffffff"
        text: qsTr("2019/11/14 15:30:00")
        verticalAlignment: Text.AlignVCenter
        anchors.verticalCenter: parent.verticalCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 22
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 30

        // QML Example Use timer to update Date
        // ( https://goo.gl/REe3HA )

        Timer {
            id: clockTimer
            repeat: true
            interval: 1 * 1000
            triggeredOnStart: true
            running: true
            onTriggered: {
        txtClock.text = formatDate(Date());
        // TODO: model.formatDate(Date()) re-use
        if ( 0 < txtAlarmContent.text.length ) {
            num_sec_alarm++;
        }
        if ( 5 < num_sec_alarm
            && 0 < txtAlarmContent.text.length ) {
            txtAlarmContent.text = "";
            // console.debug("clear alarm");
            num_sec_alarm = 0;
        }
            }
        }
        }
        }

        Rectangle {
        id: recMilage
        x: 460
        width: 180
        height: 30
        color: "#000000"
        radius: style.rectRadius
        anchors.bottom: recMessage.top
        anchors.bottomMargin: 50
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.leftMargin: 3
        border.width: 1
        border.color: "#000000"
        Text {
            id: txtMilage
            x: 0
            width: 180
            height: 30
            color: "#ffffff"
            text: "000000.0"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 0
            font.pointSize: 20
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
        }

    // TODO: to be obseleted, but ChartView in use
    CircularGauge {
        id: powerGauge
        x: 0
        y: 120
        width: 360
        height: 360
        clip: false
        anchors.left: parent.left
        anchors.leftMargin: 0
        z: -3
        visible: true
        stepSize: 1
        value: 0
        minimumValue: 0
        maximumValue: 250
        smooth: true
        Behavior on value {
        NumberAnimation {
        duration: 400
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
                text: styleData.value/1
                font.pixelSize: lala.toPixels(0.08)
                //pedalGaugeStyle.
            }
        }

        TurnIndicator {
            id: leftIndicator
            x: 100
            width: 50
            height: 50
            anchors.right: parent.right
            anchors.rightMargin: 0
            direction: Qt.LeftArrow
            flashing: false
            anchors.topMargin: 0
            anchors.top: parent.top
            on: false
        }
    }

    Rectangle {
    id: recEnergyConsumption
    y: 530
    z: 1
    width: 360
    height: 150
    color: "#161616"
    radius: 2
    border.color: "#161616"
    anchors.left: parent.left
    anchors.leftMargin: 30
    //border.width: 1
    //border.color: "white"

    ChartView {
        id: energy
        title: "Energy Consumption ( kw )"
        titleColor: "white"
        titleFont.pointSize: 10
    backgroundColor: "#161616"
        x: 0
        y: 0

        width: 360
        height: 150
        z: 1
        antialiasing: true

        // FIXME: Must mark such that Qt Creator QML editor design mode works
        legend.visible: false

        // Define x-axis to be used with the series instead of default one
        ValueAxis {
        id: valueAxis
        min: 0
        max: 49
        tickCount: max_sample_display
        labelFormat: "%.0f"
        labelsFont.pointSize: 10
        gridVisible: true
        labelsVisible : false
        gridLineColor: "#d7d6d5"
        }

        ValueAxis {
        id: valueAxisKw
        min: -80 //-500
        max: 150 //1000
        tickCount: 15
        labelFormat: "%.0f"
        labelsFont.pointSize: 5
        labelsVisible : false
        gridVisible: true
        gridLineColor: "#80c342"
        }

        // FIXME: Must mark such that Qt Creator QML editor design mode works
        margins.left: 0
        margins.top: 0
        margins.right: 0
        margins.bottom: 0

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
        onSeriesRemoved: {}
    }

    // QT Charts QML scrolling X axis in ms
    // ( https://is.gd/zChCxb )
    Timer {
        property int amountOfData: 0
        //So we know when we need to start scrolling
        id: refreshTimer
        interval: update_freq * 1000  // ms
        running: true
        repeat: true
        onTriggered: {
        areaSeries1.lowerSeries.append(amountOfData, 0);
        areaSeries1.upperSeries.append(amountOfData, energy_consumed);
        if(amountOfData > areaSeries1.axisX.max) {
            areaSeries1.axisX.min++;
            areaSeries1.axisX.max++;
            //areaSeries1.remove(areaSeries1.axisX.min-1);
        }
        else{
            amountOfData++;
            // This else is just to stop
            // incrementing the variable unnecessarily
        }
        //remove all data points that are not visible anymore
        if ( max_sample_display < amountOfData ) {
            areaSeries1.lowerSeries.remove(1);
            areaSeries1.upperSeries.remove(1);
        }
        }
    }
    }

        CircularGauge {
        id: rpmGauge
        x: 739
        y: 500
        width: 210
        height: 210
        z: -2
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
    style: RpmGaugeStyle {
    }
        Rectangle {
        id: recSocLight
        x: 0
        y: 0
        width: 40
        height: 40
        color: "#161616"
        radius: 0
        visible: false
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 15
        StatusIndicator {
        id: statusIndicator
        x: 0
        width: 40
        height: 40
        active: false
        color: "#000000"
        z: -1
        visible: false
        }
        anchors.horizontalCenter: parent.horizontalCenter
        border.width: 0
        anchors.leftMargin: 3
        border.color: "#ffffff"
        }
        }

        CircularGauge {
        id: speedometer
        y: 120
        width: 360
        height: 360
        anchors.right: parent.right
        anchors.rightMargin: 0
        z: 3
        value: 0
        maximumValue: 140
        style: DashboardGaugeStyle { }
        smooth: true
        Behavior on value {
        NumberAnimation {
        duration: 400
        }
        }
        Rectangle {
            id: rectGear
            x: -9
            y: -8
            width: 40
            height: 40
            color: "#000000"
            anchors.horizontalCenter: parent.horizontalCenter
            //anchors.left: statusIndicator00.right
            border.width: 1
            Text {
            id: txtGear
            width: 40
            height: 40
            color: "#ffffff"
            text: "N"
            lineHeight: 0.8
            anchors.centerIn: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 25
            }
            anchors.bottomMargin: 15
            anchors.leftMargin: 3
            border.color: "#ffffff"
            anchors.bottom: parent.bottom
        }

        TurnIndicator {
            id: rightIndicator
            width: 50
            height: 50
            anchors.left: parent.left
            anchors.leftMargin: 0
            direction: Qt.RightArrow
            flashing: false
            anchors.topMargin: 0
            anchors.top: parent.top
            on: false
        }
        }

    // usage as RPM gauge
    // scale: What are the RPM figures given for electric vehicles? ( https://is.gd/vwxoRZ )

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
        hmiroot.qmlSignal("ChargingStation");
        }
        }
        anchors.topMargin: 0
        }

        Image {
        id: imageBattery
        x: 190
        width: 75
        height: 75
        sourceSize.height: 267
        sourceSize.width: 267
        source: "../images/0-color/HMI-ICON-51.png"
        fillMode: Image.PreserveAspectFit
        MouseArea {
            id: mouseAreaDeployment
            width: 75
            height: 75
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.top: parent.top
            z: 2
            onClicked: {
        // console.debug("menu battery click");
        hmiroot.qmlSignal("Battery");
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
        hmiroot.qmlSignal("Diagnosis");
        }
        }
        }

        // Dashboards are typically in a landscape orientation, so we need to ensure
        // our height is never greater than our width.

        ToggleButton {
            id: tbTrip
            x: 640
            y: 626
            width: 75
            height: 75
            text: qsTr("T")
            transformOrigin: Item.Center
            z: 1
            onClicked: {
                //console.debug("total "+current_total+
                //	" trip "+current_trip+" status "+tbTrip.checked);
                if ( tbTrip.checked ) {
                    txtMilage.text = current_trip;
                }
                else {
                    txtMilage.text = current_total;
                }
            }

        Timer {
        id: longPressTimer

        //your press-and-hold interval here
        interval: style.buttonHoldTimeMs
        repeat: false
        running: false

        onTriggered: {
            hmiroot.qmlSignalPressAndHold();
            console.debug("triggered");
        }
        }

        onPressedChanged: {
        if ( tbTrip.checked ) { // only in trip state
            if ( pressed ) { // TODO: find out in doc
            longPressTimer.running = true;
            } else {
            longPressTimer.running = false;
            }
            console.debug("pressed=" + pressed);
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
                    hmiroot.qmlSignal("vehicleInfoWindow");
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
                    hmiroot.qmlSignal("historyWindow");
                }
            }
            source: "../images/0-color/20190703HMI-ICON-83.png"
            anchors.topMargin: 0
        }

    Rectangle {
        id: recAdas
        x: -400
        y: 515
        width: 320
        height: 180
        color: "#1f1f1f"
        radius: 1
        z: -1
        visible: false
        BorderImage {
            id: imgADAS
            x: -400
            width: 320
            height: 230
            visible: false
        source: ""
        }
    }

    // cannot specify left, right... inside Row, Row will not work.
  Rectangle {
     id: recMilageLeft
     x: -19
     width: 250
     height: 24
     color: "#161616"
     anchors.horizontalCenter: parent.horizontalCenter

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
     anchors.topMargin: 15
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
        console.debug("menu tpms click");
        hmiroot.qmlSignal("TPMS");
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
        hmiroot.qmlSignal("UNLOCK");
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
             hmiroot.qmlSignal("IconDesc");
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
             hmiroot.qmlSignal("Parameters");
         }
     }
     fillMode: Image.PreserveAspectFit
     source: "../images/0-color/20190308HMI-ICON-96.png"
     anchors.top: imageBattery.top
 }

 Text {
     id: txtZero
     x: 39
     y: 608
     width: 20
     height: 20
     color: "#ffffff"
     text: qsTr("0")
     lineHeight: 0.8
     z: 2
     font.pixelSize: 15
     horizontalAlignment: Text.AlignHCenter
     verticalAlignment: Text.AlignVCenter
 }

 Text {
     id: txtMinus
     x: 39
     y: 637
     width: 20
     height: 20
     color: "#ffffff"
     text: qsTr("-")
     horizontalAlignment: Text.AlignHCenter
     verticalAlignment: Text.AlignVCenter
     font.pixelSize: 30
     z: 2
 }

 Text {
     id: txtPlus
     x: 39
     y: 552
     width: 20
     height: 20
     color: "#ffffff"
     text: qsTr("+")
     horizontalAlignment: Text.AlignHCenter
     verticalAlignment: Text.AlignVCenter
     font.pixelSize: 19
     z: 2
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
     x: 0
     y: 60
     width: 30
     height: 25
     color: "#ffffff"
     text: qsTr("X :")
     verticalAlignment: Text.AlignVCenter
     font.pixelSize: 19
     horizontalAlignment: Text.AlignLeft
     visible: true
 }

 Text {
     id: txtXValue
     x: 30
     y: 60
     width: 150
     height: 25
     color: "#ffffff"
     text: qsTr("0000000000000000")
     verticalAlignment: Text.AlignVCenter
     font.pixelSize: 14
     horizontalAlignment: Text.AlignLeft
     visible: true
 }

 Text {
     id: txtGy
     x: 0
     y: 85
     width: 30
     height: 25
     color: "#ffffff"
     text: qsTr("Y :")
     verticalAlignment: Text.AlignVCenter
     font.pixelSize: 19
     horizontalAlignment: Text.AlignLeft
     visible: true
 }

 Text {
     id: txtYValue
     y: 85
     width: 150
     height: 26
     color: "#ffffff"
     text: qsTr("H 00 T 00 d 0 s 0 tx 000 rx 000")
     anchors.left: txtGy.right
     anchors.leftMargin: 0
     verticalAlignment: Text.AlignVCenter
     font.pixelSize: 14
     horizontalAlignment: Text.AlignLeft
     visible: true
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
     width: 150
     height: 25
     color: "#ffffff"
     text: qsTr("")
     lineHeight: 0.9
     verticalAlignment: Text.AlignVCenter
     anchors.left: txtGz.right
     font.pixelSize: 14
     anchors.leftMargin: 5
     horizontalAlignment: Text.AlignLeft
     visible: false
 }

 Image {
     id: imageEcas
     x: 400
     width: 75
     height: 75
     anchors.top: imageLining.top
     anchors.topMargin: 60
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
     anchors.leftMargin: -30
 }

 Image {
     id: imageTyre
     width: 75
     height: 75
     anchors.left: imagePSteering.left
     anchors.leftMargin: 50
     anchors.top: imagePSteering.top
     anchors.topMargin: 0
     visible: true
     z: 1
     source: "../images/0-color/HMI-ICON-48.png"
     sourceSize.height: 267
     sourceSize.width: 267
     fillMode: Image.PreserveAspectFit
 }

 Image {
     id: imageMotor
     width: 75
     height: 75
     anchors.top: imageRegenBrake.top
     anchors.topMargin: 0
     sourceSize.width: 267
     anchors.leftMargin: 45
     anchors.left: imageRegenBrake.left
     sourceSize.height: 267
     source: "../images/0-color/HMI-ICON-63.png"
     fillMode: Image.PreserveAspectFit
 }

 Image {
     id: imageRearDefogger
     width: 75
     height: 75
     anchors.left: imageParking.left
     anchors.leftMargin: 100
     anchors.top: imageLining.top
     anchors.topMargin: 0
     source: "../images/0-color/HMI-ICON-06.png"
     fillMode: Image.PreserveAspectFit
 }

 Image {
     id: imageRearFogLight
     width: 75
     height: 75
     anchors.top: imageLining.top
     anchors.topMargin: 0
     anchors.leftMargin: -37
     anchors.left: imageRearDefogger.right
     source: "../images/0-color/20190308HMI-ICON-82.png"
     fillMode: Image.PreserveAspectFit
 }

 Image {
     id: imageHeadLights
     y: -2
     width: 75
     height: 75
     anchors.topMargin: 0
     anchors.leftMargin: -35
     anchors.top: imageLining.top
     anchors.left: imageRearFogLight.right
     source: "../images/0-color/HMI-ICON-03.png"
     fillMode: Image.PreserveAspectFit
 }

 Image {
     id: imageSideLights
     y: 4
     width: 75
     height: 75
     anchors.topMargin: 0
     anchors.leftMargin: -26
     anchors.top: imageLining.top
     anchors.left: imageHeadLights.right
     source: "../images/0-color/HMI-ICON-04.png"
     fillMode: Image.PreserveAspectFit
 }

 Image {
     id: imagePSteering
     x: 356
     width: 75
     height: 75
     anchors.top: parent.top
     anchors.topMargin: 400
     source: "../images/0-color/HMI-ICON-62.png"
     fillMode: Image.PreserveAspectFit
 }

 Image {
     id: imageLining
     x: 340
     y: 470
     width: 75
     height: 75
     source: "../images/0-color/20190308HMI-ICON-80.png"
     fillMode: Image.PreserveAspectFit
 }

 Image {
     id: imageRegenBrake
     x: 410
     y: 350
     width: 75
     height: 75
     source: "../images/0-color/HMI-ICON-08.png"
     fillMode: Image.PreserveAspectFit
 }

 Image {
     id: imageAbs
     y: 9
     width: 75
     height: 75
     anchors.topMargin: 0
     anchors.leftMargin: -35
     anchors.left: imageLining.right
     anchors.top: imageLining.top
     source: "../images/0-color/20190308HMI-ICON-79.png"
     fillMode: Image.PreserveAspectFit
 }

 Image {
     id: imageParking
     y: 9
     width: 75
     height: 75
     anchors.topMargin: 0
     anchors.leftMargin: -35
     anchors.top: imageLining.top
     anchors.left: imageAbs.right
     source: "../images/0-color/HMI-ICON-09.png"
     fillMode: Image.PreserveAspectFit
 }

 Image {
     id: imageMainPower
     width: 75
     height: 75
     anchors.top: imageRegenBrake.top
     anchors.topMargin: 0
     anchors.leftMargin: 45
     anchors.left: imageBatteryStatus.left
     source: "../images/0-color/HMI-ICON-16.png"
     fillMode: Image.PreserveAspectFit
 }

 Image {
     id: imageBatteryStatus
     width: 75
     height: 75
     anchors.top: imageRegenBrake.top
     anchors.topMargin: 0
     anchors.leftMargin: 45
     anchors.left: imageMotor.left
     source: "../images/1-white/white-HMI-ICON-25.png"
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
     x: 517
     width: 75
     height: 75
     anchors.top: imagePSteering.top
     anchors.topMargin: 0
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
     anchors.left: imageEcasKneeling.left
     anchors.leftMargin: 50
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
     anchors.leftMargin: 65
     anchors.left: imageEvacuation.left
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
     id: rectSoc
     x: -28
     width: 250
     height: 24
     color: "#161616"
     anchors.horizontalCenter: parent.horizontalCenter
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

    onActiveChanged : {
    if ( true === hmiroot.active ) {
        root.qmlSignalActive(hmiroot.objectName);
        // clockTimer.start();
    }
    else {
        // clockTimer.stop();
    }
    }

    // Full-screen desktop application with QML
    // @see https://tinyurl.com/udrf9tr
    // How to make full screen in qt quick?
    // @see https://tinyurl.com/vdh5m4q
    // start apps fullscreen? >xfce
    // @see https://tinyurl.com/sqox5ap
    //

    Component.onCompleted: {
    //console.debug(this.objectName+" onCompleted");
    root.qmlSignalCompleted(this.objectName);
    // hmiroot.showFullScreen();
    // FIXME: setActiveWindow(), with or without this?
    }

    Connections {
    target: handlerVcuHmiMSG01
    onSignalVcuHmiMSG01: {
        //console.log("Received in QML from C++: " + lturn +
        //", " + rturn + ", " + rear_defogger_light);
        leftIndicator.on = ( lturn !== 0 ) ? true:false;
        //leftIndicator.flashing = ( lturn !== 1 ) ? true:false;
        // TODO: relay "sound" and screen "flash" synchronization issue.

        rightIndicator.on = ( rturn !== 0 ) ? true:false;
        //rightIndicator.flashing = ( rturn !== 0 ) ? true:false;

        imageHeadLights.source = ( hd_light !== 0 )
        ? "../images/0-color/HMI-ICON-03.png"
        : ""; // ../images/1-white/white-HMI-ICON-03.png
        // TODO: regulation is blue

        imageSideLights.source = ( side_light !== 0 )
        ? "../images/0-color/HMI-ICON-04.png"
        : ""; // ../images/1-white/HMI-ICON-04.png

        imageHazardLight.source = ( hazard_light !== 0 )
        ? "../images/0-color/HMI-ICON-07.png"
        : ""; // ../images/1-white/white-HMI-ICON-07.png

        imageAccessLight.source = ( access_light !== 0 )
        ? "../images/0-color/HMI-ICON-19.png"
        : ""; // ../images/1-white/white-HMI-ICON-19.png

        imageDoorOpen.source = ( door_open !== 0 )
        ? "../images/1-white/20190308HMI-ICON-99.png"
        : "";
        imageRearDefogger.source = ( rear_defogger_light !== 0 )
        ? "../images/0-color/20190308HMI-ICON-82.png"
        : "";
    }

    onSignalVcuHmiMSG01B1: {
        imageEcasKneeling.source = ( ecas_kneeling !== 0 )
        ? "../images/1-white/white-HMI-ICON-11.png"
        : "";
        imageRearFogLight.source = ( rear_fog_light !== 0 )
        ? "../images/0-color/20190308HMI-ICON-82.png"
        : "";

        imageAlarmGetOff.source = ( alarm_getoff !== 0 )
        ? "../images/0-color/HMI-ICON-29.png"
        : ""; // ../images/1-white/white-HMI-ICON-29.png

        imageRegenBrake.source = ( regen_brake !== 0 )
        ? "../images/0-color/HMI-ICON-08.png"
        : ""; // ../images/1-white/white-HMI-ICON-08.png

        imageParking.source = ( parking !== 0 )
        ? "../images/0-color/HMI-ICON-09.png"
        : ""; // ../images/1-white/white-HMI-ICON-09.png

        // console.debug("mo "+motor_overrun+", op "+motor_op);
        mtr_op = motor_op;
        mtr_overrun = motor_overrun;
        setMotorState(mtr_op, mtr_overrun, mtr_alarm);
        // TODO: there is a warning icon, yellow, 63.
        // "../images/0-color/HMI-ICON-63.png"
    }

    onSignalVcuHmiMSG01B2: {
        //console.debug(abs+","+ecas_warn+","+lining+","+emergency_exit);

        imageAbs.source = ( abs === 2 )
        ? "../images/0-color/HMI-ICON-14.png"
        : ( abs === 1 )
        ? "../images/0-color/20190308HMI-ICON-79.png"
        : ""; // ../images/1-white/white-HMI-ICON-14.png

        imageEcas.source = ( ecas_warn === 2 )
        ? "../images/0-color/HMI-ICON-13.png"
        : ( ecas_warn === 1 )
        ? "../images/0-color/HMI-ICON-12.png"
        : "";

        imageLining.source = ( lining === 1 )
        ? "../images/0-color/20190308HMI-ICON-80.png"
        : ""; // ../images/1-white/white-HMI-ICON-10.png
        imageEvacuation.source = ( emergency_exit === 1 )
        ? "../images/0-color/HMI-ICON-24.png"
        : "";
    }

    onSignalVcuHmiMSG01B3: {
        // TODO: cf. design doc, text color is annotated.
        mtr_alarm = motor_alarm;
        setMotorState(mtr_op, mtr_overrun, mtr_alarm);
        imageAir.source = ( air_alarm === 2 )
        ? "../images/0-color/HMI-ICON-35.png"
        : ( air_alarm === 1 )
        ? "../images/0-color/HMI-ICON-36.png"
        : "../images/0-color/HMI-ICON-34.png";

        imagePSteering.source = ( psteering_alarm === 2 )
        ? "../images/0-color/HMI-ICON-15.png"
        : ( psteering_alarm === 1 )
        ? "../images/0-color/HMI-ICON-62.png"
        : ""; // ../images/1-white/white-HMI-ICON-15.png

        imageMainPower.source = ( mpower_alarm === 2 )
        ? "../images/0-color/HMI-ICON-61.png"
        : ( mpower_alarm === 1 )
        ? "../images/0-color/HMI-ICON-16.png"
        : ""; // ../images/1-white/white-HMI-ICON-16.png
    }

    onSignalVcuHmiMSG01B4: {
        imageV24.source = ( v24_alarm === 2 )
        ? "../images/0-color/HMI-ICON-18.png"
        : ( v24_alarm === 1 )
        ? "../images/0-color/HMI-ICON-64.png"
        : "../images/1-white/white-HMI-ICON-17.png";
    }

    onSignalVcuHmiMSG01B5: {
        switch ( gear ) {
        case 0 : txtGear.text = "N"; break;
        case 1 : txtGear.text = "1"; break;
        case 2 : txtGear.text = "2"; break;
        case 3 : txtGear.text = "3"; break;
        case 4 : txtGear.text = "4"; break;
        case 5 : txtGear.text = "5"; break;
        case 6 : txtGear.text = "6"; break;
        case 7 : txtGear.text = "R"; break;
        default: txtGear.text = "";
        }
    }

    onSignalVcuHmiMSG01B6: {
        speedometer.value = speed;
        // console.debug("onSignalVcuHmiMSG01B6: "+speed);
        // text color not customized so far
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
        if ( 6.5 <= s_air )
        txtAirReading.color = style.colorNormal;
        else if ( 6.0 <= s_air && s_air < 6.5 )
        txtAirReading.color = style.colorWarning;
        else // s_air < 6.0
        txtAirReading.color = style.colorAlert;
        txtAirReading.text = s_air;
        //    = parseFloat(Math.round(s_air*10)/10).toFixed(1);

        if ( motor_temp <= 69 )
        txtMotorIoTempReading.color = style.colorNormal;
        else if ( 69 < motor_temp && motor_temp < 85 )
        txtMotorIoTempReading.color = style.colorWarning;
        else // 85 <= motor_temp
        txtMotorIoTempReading.color = style.colorAlert;
        txtMotorIoTempReading.text = motor_temp;

        if ( otank_temp2 < 55 )
        txtOTankTemp.color = style.colorNormal;
        else if ( 55 <= otank_temp2 && otank_temp2 < 60 )
        txtOTankTemp.color = style.colorWarning;
        else // 60 <= otank_temp2
        txtOTankTemp.color = style.colorAlert;
        txtOTankTemp.text = otank_temp2;

        // 20200213 meeting conclusion
        // TODO: speed up by eliminate extra instruction
        v24 = parseFloat(s_v24);
        // console.debug(s_v24 + "," + v24);
        if ( v24 <= volt_WARN ) {
        txtV24.color = style.colorAlert;
        }
        else if ( volt_WARN < v24 && v24 <= volt_NORMAL ) {
        txtV24.color = style.colorWarning;
        }
        else {
        txtV24.color = style.colorNormal;
        }
        txtV24.text = s_v24;
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
        current_total = s_total;
        current_trip = s_trip;
        if ( tbTrip.checked ) {
        txtMilage.text = s_trip;
        }
        else {
        txtMilage.text = s_total;
        }
        //console.debug("total "+current_total+
        //    " trip "+current_trip+" status "+tbTrip.checked);
    }
    }

    Connections {
    target: handlerVcuHmiMSG04
    onSignalVcuHmiMSG04: {
        txtMilageLeft.text = s_left;
        powerGauge.value = s_delta; // for powerGauge
        energy_consumed = s_delta; // for chart
        // TODO: perkm
    }
    }

    Connections {
    target: handlerVcuPwrStatus
    onSignalVcuPwrStatus: {
        txtXValue.text = sHex;
    }
    }

    Connections {
    target: handlerBmsVcuMSG01
    onSignalBmsVcuMSG01: {
        // var num = soc/100 + Math.random().toFixed(3);
        // var n = num.toFixed(3); // FIXME:
        // console.debug("[" + n.toString() + "]");
        // rpmGauge.value = num.toFixed(3); // FIXME:
        //statusIndicator.color =
         //   ( soc <= 19 ) ?
           // "red" : ( 20 <= soc && soc <= 29 ) ?
        //"yellow" : "cyan";
        // statusIndicator.active = true;

        if ( bms_state === 0 ) {
        imageBatteryStatus.source = "../images/0-color/HMI-ICON-25.png";
        } else if ( bms_state === 1 ) {
        imageBatteryStatus.source = "../images/0-color/HMI-ICON-26.png";
        } else if ( bms_state === 2 ) {
        imageBatteryStatus.source = "../images/0-color/HMI-ICON-27.png";
        } else if ( bms_state === 3 ) {
        imageBatteryStatus.source = "../images/0-color/HMI-ICON-28.png";
        } else { }

        txtSocValue.text = soc;
        recBSOC.width = bsoc_width * ( soc/100 );
        // TODO:
        imageTyre.source = "";
    }
    }

    Connections {
    target: handlerPcuStMot01
    onSignalPcuStMot01: {
        //console.debug("updateMsg_PCU_ST_MOT_1 "+s_rpm+", "
        //+s_torq+", "+s_dclv+", "+s_mechpwr);
        rpmGauge.value = parseFloat(s_rpm)/1000;
        //console.debug(parseFloat(s_rpm)+", "+parseFloat(s_rpm)/1000);
    }
    }

    Connections {
    target: handlerPcuCmdMt01
    onSignalPcuCmdMt01: {
        //console.debug("updateMsg_PCU_CMD_MOT_1 "+ctrl_mode+", "+mtrun_cmd);
        txtControlModeVal.text = ctrl_mode;
        txtMotorRunCmdVal.text = mtrun_cmd;
    }
    }

    Connections {
    target: worker
    onSignalLoadMenuText: {
        console.debug("onSignalLoadMenuText ["+locale+"]");
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
        txtYValue.text = dinfo;
    }
    }

    Connections {
    target: handlerAlmMSG00
    onSignalAlmMSG00: {
        // console.debug(alarmText);
        txtAlarmContent.text = alarmText;
        num_sec_alarm = 0;
	// TODO: call reset_hold_timer();
    }
    }

    Connections {
    target: handlerAlmMSG01
    onSignalAlmMSG01: {
        // TODO: to be implemented
    txtAlarmContent.text = alarmText;
    }
    }

    Connections {
    target: handlerAlmMSG02
    onSignalAlmMSG02: {
        txtAlarmContent.text = alarmText;
    }
    }

    Connections {
    target: handlerAlmMSG03
    onSignalAlmMSG03: {
        txtAlarmContent.text = alarmText;
    }
    }

    Connections {
    target: handlerDcdcMSG00
    onSignalAlmMSG04: {
        txtAlarmContent.text = alarmText;
    }
    }

    Connections {
    target: handlerBcuErMSG01
    onSignalAlmMSG05: {
        txtAlarmContent.text = alarmText;
    }
    }

    Connections {
        target: handlerBmsCmuErrMSG01
        onSignalAlmMSG06: {
            txtAlarmContent.text = alarmText;
        }
    }

    Connections {
        target: handlerPcuStSys03
        onSignalAlmMSG07: {
            txtAlarmContent.text = alarmText;
        }
    }

    Connections {
        target: handlerPcuStSys04
        onSignalAlmMSG08: {
            txtAlarmContent.text = alarmText;
        }
    }

}
