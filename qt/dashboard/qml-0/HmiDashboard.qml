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
import QtQuick.Window 2.1
import QtQuick.Extras 1.4
import QtQuick.Controls 1.4
// mark to prevent importing SwitchDelegate such that delaybutton 'round'
// import QtQuick.Controls 2.5

// Access C++ function from QML
// https://goo.gl/nxZegu
//import com.myself 1.0
import QtCharts 2.3
import "style"

ApplicationWindow {
    id: hmiroot
    objectName: "hmiroot"
    // make the first one visible, assume 'Boot' splash
    visible: true
    Styles { id: style }
    // ( https://goo.igl/nnR4j9 )
    // x: (Screen.width - width) / 2
    // y: (Screen.height - height) / 2
    x: 0
    y: 0
    // width: 1280
    // height: 800
    // @see https://tinyurl.com/yyrzzade
    // width: Screen.desktopAvailableWidth
    width: style.resolutionWidth // application wide properties
    height: style.resolutionHeight
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
    // be sure to export property alias
    property alias imageBattery: imageBattery
    property alias imageCharging: imageCharging
    property alias imageTPMS: imageTPMS
    property alias imageDiagnostics: imageDiagnostics
    property alias imageUnlock: imageUnlock
    property alias imageIconDesc: imageIconDesc
    property alias imageEngineering: imageEngineering
    property alias imageHistory: imageHistory
    property alias imageParameters: imageParameters

    property alias txtMilage1: txtMilage
    //property alias switchDelegate1: switchDelegate
    //property bool isAnimating : switchDelegate1.checked
    // Launch a child QML window from a parent QML window
    // ( https://goo.gl/J67Pcc )
    property variant win;  // you can hold this as a reference..
    // Defining Property Attributes ( https://goo.gl/p2Rg16 )
    property string current_trip : "0000000" // string
    property string current_total : "0000000"
    property real max_sample_display : 30
    property real update_freq : 1 /* number of second */

    //title: qsTr("RACEV HMI")

    //onActiveFocusItemChanged: print("activeFocusItem", activeFocusItem)
    // Connecting to QML Signals ( https://goo.gl/gFZphL )
    signal qmlSignal(string msg)
    signal qmlSignalActive(string msg)
    signal qmlSignalOnCompleted(string msg) // FIXME: too early to fire
    // c++ -> QML ( https://goo.gl/sHMaKL )
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

    function updateMsg_VCU_PWR_STATUS(sHex) {
    txtXValue.text = sHex;
    }

    function updateView() {
    }

    function loadMenuText(locale) {
    console.log("locale: [" + locale + "]")
    // energy.title = loadString(1, locale);
    // TODO: Internationalization and Localization with Qt Quick
    // @see https://tinyurl.com/y2c7mguc
    // example:
    // @see https://tinyurl.com/y64rtkwf
    }

    function setAnimaiton(is_on) {
        isAnimating = is_on;
        //console.debug("setAnimation +++ " + isAnimating);
    }

    function updateQBInfo(payload, qsize, bsize) {
    txtFramePayLoad.text = bsize; // FIXME:
    txtSizeQ.text = qsize;
    }

    function tickGSensor(x, y, z, pitch, roll, yaw, cali, zero_p) {
    txtXValue.text = x;
    txtYValue.text = y;
    txtZValue.text = z;
    txtPitchVal.text = pitch;
    txtRollVal.text = roll;
    txtYawVal.text = yaw;
    }

    // byte0
    function update_VCU_HMI_Msg_1(lturn, rturn, hd_light, side_light,
    hazard_light, access_light, door_open, rear_defogger_light) {
    //console.debug(lturn+","+rturn+","+hd_light);
    leftIndicator.on = ( lturn !== 0 ) ? true:false;
    leftIndicator.flashing = ( lturn !== 1 ) ? true:false;

    rightIndicator.on = ( rturn !== 0 ) ? true:false;
    rightIndicator.flashing = ( rturn != 0 ) ? true:false;

    imageHeadLights.source = ( hd_light != 0 )
        ? "../images/0-color/HMI-ICON-03.png"
        : ""; // ../images/1-white/white-HMI-ICON-03.png
    // TODO: regulation is blue

    imageSideLights.source = ( side_light != 0 )
        ? "../images/0-color/HMI-ICON-04.png"
        : ""; // ../images/1-white/HMI-ICON-04.png

    imageHazardLight.source = ( hazard_light != 0 )
        ? "../images/0-color/HMI-ICON-07.png"
        : ""; // ../images/1-white/white-HMI-ICON-07.png

    imageAccessLight.source = ( access_light != 0 )
        ? "../images/0-color/HMI-ICON-19.png"
        : ""; // ../images/1-white/white-HMI-ICON-19.png

    imageDoorOpen.source = ( door_open != 0 )
        ? "../images/1-white/20190308HMI-ICON-99.png"
        : "";
    imageRearDefogger.source = ( rear_defogger_light != 0 )
        ? "../images/0-color/20190308HMI-ICON-82.png"
        : "";
    }

    function update_VCU_HMI_Msg_1_Byte_1(ecas_kneeling, rear_fog_light, alarm_getoff,
    motor_overrun, regen_brake, parking, motor_op) {
    //console.debug(ecas_kneeling+","+rear_fog_light+","+alarm_getoff+","+motor_overrun+","+regen_brake+","+parking+","+motor_op);
    imageEcasKneeling.source = ( ecas_kneeling != 0 )
        ? "../images/1-white/white-HMI-ICON-11.png"
        : "";
    imageRearFogLight.source = ( rear_fog_light != 0 )
    ? "../images/0-color/20190308HMI-ICON-82.png"
    : "";

    imageAlarmGetOff.source = ( alarm_getoff != 0 )
        ? "../images/0-color/HMI-ICON-29.png"
        : ""; // ../images/1-white/white-HMI-ICON-29.png

    imageRegenBrake.source = ( regen_brake != 0 )
        ? "../images/0-color/HMI-ICON-08.png"
        : ""; // ../images/1-white/white-HMI-ICON-08.png

    imageParking.source = ( parking != 0 )
        ? "../images/0-color/HMI-ICON-09.png"
        : ""; // ../images/1-white/white-HMI-ICON-09.png

    imageMotor.source = ( motor_overrun != 0 )
        ? "../images/0-color/HMI-ICON-21.png"
        : ( motor_op != 0 )
        ? "../images/0-color/HMI-ICON-20.png"
        : "";
        // TODO: there is a warning icon, yellow, 63.
    }

    function update_VCU_HMI_Msg_1_Byte_2(
    abs,ecas_warn,lining,emergency_exit) {
    //console.debug(abs+","+ecas_warn+","+lining+","+emergency_exit);

    imageAbs.source = ( abs == 2 )
        ? "../images/0-color/HMI-ICON-14.png"
        : ( abs == 1 )
        ? "../images/0-color/20190308HMI-ICON-79.png"
        : ""; // ../images/1-white/white-HMI-ICON-14.png

    imageEcas.source = ( ecas_warn == 2 )
        ? "../images/0-color/HMI-ICON-13.png"
        : ( ecas_warn == 1 )
        ? "../images/0-color/HMI-ICON-12.png"
        : "";

    imageLining.source = ( lining == 1 )
        ? "../images/0-color/20190308HMI-ICON-80.png"
        : ""; // ../images/1-white/white-HMI-ICON-10.png
    imageEvacuation.source = ( emergency_exit == 1 )
        ? "../images/0-color/HMI-ICON-24.png"
        : "";
    }

    function update_VCU_HMI_Msg_1_Byte_3(motor_alarm,air_alarm,psteering_alarm,mpower_alarm) {
    // TODO: cf. design doc, text color is annotated.
    imageMotor.source = ( motor_alarm == 2 )
        ? "../images/0-color/HMI-ICON-21.png"
        : ( motor_alarm == 1 )
        ? "../images/0-color/HMI-ICON-63.png"
        : "../images/1-white/white-HMI-ICON-20.png";
    imageAir.source = ( air_alarm == 2 )
        ? "../images/0-color/HMI-ICON-35.png"
        : ( air_alarm == 1 )
        ? "../images/0-color/HMI-ICON-36.png"
        : "../images/0-color/HMI-ICON-34.png";

    imagePSteering.source = ( psteering_alarm == 2 )
        ? "../images/0-color/HMI-ICON-15.png"
        : ( psteering_alarm == 1 )
        ? "../images/0-color/HMI-ICON-62.png"
        : ""; // ../images/1-white/white-HMI-ICON-15.png

    imageMainPower.source = ( mpower_alarm == 2 )
        ? "../images/0-color/HMI-ICON-61.png"
        : ( mpower_alarm == 1 )
        ? "../images/0-color/HMI-ICON-16.png"
        : ""; // ../images/1-white/white-HMI-ICON-16.png
    }

    function update_VCU_HMI_Msg_1_Byte_4(v24_alarm,lv_alarm,
    charge_abort,brake,wiper,lb_light) {
    imageV24.source = ( v24_alarm == 2 )
        ? "../images/0-color/HMI-ICON-18.png"
        : ( v24_alarm == 1 )
        ? "../images/0-color/HMI-ICON-64.png"
        : "../images/1-white/white-HMI-ICON-17.png";
    }

    function update_VCU_HMI_Msg_1_Byte_5(gear) {
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

    function update_VCU_HMI_Msg_1_Byte_6(speed) {
    speedometer.value = speed;
    // TODO: animation
    // text color not customized so far
    /*
    if ( 120 <= speedometer.value )
        speedText.color = "red";
    else
        speedText.color = "#e5e5e5";
    */
    }

    function update_VCU_HMI_Msg_2_Byte_0_5(air_pressure,motor_temp,
    otank_temp2,v24) {
    // console.debug("ap "+air_pressure+", mt="+motor_temp+","+otank_temp2+","+v24);

    if ( 6.5 <= air_pressure )
        txtAirReading.color = style.colorNormal;
    else if ( 6.0 <= air_pressure && air_pressure < 6.5 )
        txtAirReading.color = style.colorWarning;
    else // air_pressure < 6.0
        txtAirReading.color = style.colorAlert;
    txtAirReading.text = air_pressure;
    //    = parseFloat(Math.round(air_pressure*10)/10).toFixed(1);

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

    if ( 21.6 <= v24 )
        txtV24.color = style.colorNormal;
    else
        txtV24.color = style.colorAlert;
    txtV24.text = v24; // parseFloat(Math.round(v24*10)/10).toFixed(1);
    }

    function update_VCU_HMI_Msg_2_Byte_6(air_unlock,
    passenger_unlock,emergency_unlock,wproff_unlock,
    ecas_unlock, isolation_abnormal_unlock,
    v24_carlock_unlock) {
    //console.debug(air_unlock+","+passenger_unlock+","+emergency_unlock+","+wproff_unlock+","+ecas_unlock+","+isolation_abnormal_unlock+","+v24_carlock_unlock);
    // TODO:
    }

    function update_VCU_HMI_Msg_3(total, trip) {
    if ( tbTrip.checked ) {
        txtMilage.text = trip;
    }
    else {
        txtMilage.text = total;
    }
    current_total = total;
    current_trip = trip;
    //console.debug("total "+current_total+
    //    " trip "+current_trip+" status "+tbTrip.checked);
    }

    function update_VCU_HMI_Msg_4(delta, perkm, left) {
    txtMilageLeft.text = left;
    powerGauge.value = delta;
    // TODO: perkm
    //console.debug("delta "+delta+
    //    " perkm "+perkm+" left "+left);
    }

    function updateBMS_VCU_MSG01(s_voltage,s_current,soc,b_status,
    f_level,mcntctr_nc,mcntctr_st,pcell_alrm,s_cremains) {
    // var num = soc/100 + Math.random().toFixed(3);
    // var n = num.toFixed(3); // FIXME:
    // console.debug("[" + n.toString() + "]");
    // rpmGauge.value = num.toFixed(3); // FIXME:
    //statusIndicator.color =
     //   ( soc <= 19 ) ?
       // "red" : ( 20 <= soc && soc <= 29 ) ?
        //"yellow" : "cyan";
    // statusIndicator.active = true;
    /*console.debug("v "+s_voltage+" a "+s_current+" soc "+soc
        +" b "+b_status+" fl "+f_level+" mctn "+mcntctr_nc
        +" mcts "+mcntctr_st+" pcal "+pcell_alrm
        +" crmn "+s_cremains);*/

    if ( b_status === 0 ) {
        imageBatteryStatus.source = "../images/0-color/HMI-ICON-25.png";
    } else if ( b_status === 1 ) {
        imageBatteryStatus.source = "../images/0-color/HMI-ICON-26.png";
    } else if ( b_status === 2 ) {
        imageBatteryStatus.source = "../images/0-color/HMI-ICON-27.png";
    } else if ( b_status === 3 ) {
        imageBatteryStatus.source = "../images/0-color/HMI-ICON-28.png";
    } else { }

    // TODO:
    imageTyre.source = "";
    }

    function updateBMS_VCU_MSG02(s_cmaxv,cell_maxi,s_cminv,cell_mini,
    s_cdiffv) {
    //console.debug(hmiroot.objectName+" ubcm2");
    }

    function updateMsg_PCU_ST_MOT_1(s_rpm, s_torq, s_dclv, s_mechpwr) {
    //console.debug("updateMsg_PCU_ST_MOT_1 "+s_rpm+", "
    //+s_torq+", "+s_dclv+", "+s_mechpwr);
    rpmGauge.value = parseFloat(s_rpm)/1000;
    //console.debug(parseFloat(s_rpm)+", "+parseFloat(s_rpm)/1000);
    }

    function tickTimeStamp() {
    // How to format a Date in MM/dd/yyyy HH:mm:ss
    // format in JavaScript? ( https://goo.gl/nq1b73 )
    Number.prototype.padLeft = function(base,chr) {
        var  len = (String(base || 10).length - String(this).length)+1;
        return len > 0? new Array(len).join(chr || '0')+this : this;
    }
    var d = new Date,
    dformat = [
        d.getFullYear(),
        (d.getMonth()+1).padLeft(),
        d.getDate().padLeft(),
    ].join('/') +' ' + [
    d.getHours().padLeft(),
    d.getMinutes().padLeft(),
    d.getSeconds().padLeft()].join(':');
    //=> dformat => '2012/05/17 10:52:21'
    //console.debug(dformat);
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
    x: 0
    y: 0
    width: 1024
    height: 40
    color: "#1f1f1f"
    anchors.bottomMargin: 0
    anchors.bottom: parent.bottom

    MouseArea {
    onClicked: {
    var component = Qt.createComponent("BatteryStatus.qml");
    win = component.createObject(deployment_window);
    //TODO: check singleton
    win.show();
    }
    }
/*
    SwitchDelegate {
    id: switchDelegate
    x: 1204
    height: 50
    text: checked ? qsTr("Animation ON"):qsTr("Animation OFF")
    enabled: true
    hoverEnabled: false
    highlighted: false
    spacing: 10
    anchors.rightMargin: 0
    anchors.right: parent.right
    anchors.top: row2.bottom
    checked: false
    anchors.topMargin: 0
    onCheckableChanged: {
        //console.debug(switchDelegate1.checked);
        setAnimaiton(checked);
    }
    }
*/
    }

        Rectangle {
        id: rowTop
        width: 1024
        height: 75
        color: "#161616"

        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0

        Image {
            id: imageEcas
            width: 75
            height: 75
            sourceSize.height: 267
            sourceSize.width: 267
            fillMode: Image.Stretch
            anchors.leftMargin: -10
            anchors.top: parent.top
            source: "../images/1-white/white-HMI-ICON-13.png"
            anchors.left: parent.left
            anchors.topMargin: 0
        }

        Image {
            id: imageEcasKneeling
            width: 75
            height: 75
            sourceSize.height: 267
            sourceSize.width: 267
            fillMode: Image.PreserveAspectFit
            anchors.leftMargin: -30
            anchors.top: parent.top
            source: "../images/1-white/white-HMI-ICON-11.png"
            anchors.left: imageEcas.right
            anchors.topMargin: 0
        }

        Image {
            id: imageRearDefogger
            width: 75
            height: 75
            fillMode: Image.PreserveAspectFit
            anchors.leftMargin: -30
            anchors.top: parent.top
            source: "../images/0-color/HMI-ICON-06.png"
            anchors.left: imageMotor.right
            anchors.topMargin: 0
        }

        Image {
            id: imageRearFogLight
            width: 75
            height: 75
            fillMode: Image.PreserveAspectFit
            anchors.leftMargin: -40
            anchors.top: parent.top
            source: "../images/0-color/20190308HMI-ICON-82.png"
            anchors.left: imageRearDefogger.right
            anchors.topMargin: 0
        }

        Image {
            id: imageHeadLights
            width: 75
            height: 75
            fillMode: Image.PreserveAspectFit
            anchors.leftMargin: -40
            anchors.top: parent.top
            source: "../images/0-color/HMI-ICON-03.png"
            anchors.left: imageRearFogLight.right
            anchors.topMargin: 0
        }

        Image {
            id: imageSideLights
            width: 75
            height: 75
            fillMode: Image.PreserveAspectFit
            anchors.leftMargin: -30
            anchors.top: parent.top
            source: "../images/0-color/HMI-ICON-04.png"
            anchors.left: imageHeadLights.right
            anchors.topMargin: 0
        }

        Image {
            id: imagePSteering
            width: 75
            height: 75
            fillMode: Image.PreserveAspectFit
            anchors.leftMargin: -30
            anchors.top: parent.top
            source: "../images/0-color/HMI-ICON-62.png"
            anchors.left: imageSideLights.right
            anchors.topMargin: 0
        }

        Image {
            id: imageLining
            width: 75
            height: 75
            fillMode: Image.PreserveAspectFit
            anchors.leftMargin: -30
            anchors.top: parent.top
            source: "../images/0-color/20190308HMI-ICON-80.png"
            anchors.left: imagePSteering.right
            anchors.topMargin: 0
        }

        Image {
            id: imageRegenBrake
            width: 75
            height: 75
            fillMode: Image.PreserveAspectFit
            anchors.leftMargin: -30
            anchors.top: parent.top
            source: "../images/0-color/HMI-ICON-08.png"
            anchors.left: imageLining.right
            anchors.topMargin: 0
        }

        Image {
            id: imageAbs
            width: 75
            height: 75
            fillMode: Image.PreserveAspectFit
            anchors.leftMargin: -30
            anchors.top: parent.top
            source: "../images/0-color/20190308HMI-ICON-79.png"
            anchors.left: imageRegenBrake.right
            anchors.topMargin: 0
        }

        Image {
            id: imageParking
            width: 75
            height: 75
            fillMode: Image.PreserveAspectFit
            anchors.leftMargin: -30
            anchors.top: parent.top
            source: "../images/0-color/HMI-ICON-09.png"
            anchors.left: imageAbs.right
            anchors.topMargin: 0
        }

        Image {
            id: imageHazardLight
            width: 75
            height: 75
            anchors.verticalCenter: parent.verticalCenter
            fillMode: Image.PreserveAspectFit
            anchors.leftMargin: -35
            source: "../images/0-color/HMI-ICON-07.png"
            anchors.left: imageBatteryStatus.right
        }

        Image {
            id: imageAccessLight
            width: 75
            height: 75
            anchors.left: imageDoorOpen.right
            anchors.leftMargin: -20
            anchors.verticalCenter: parent.verticalCenter
            fillMode: Image.PreserveAspectFit
            source: "../images/1-white/white-HMI-ICON-19.png"
        }

        Image {
            id: imageAlarmGetOff
            y: 100
            width: 75
            height: 75
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: imageAccessLight.right
            anchors.leftMargin: -30
            fillMode: Image.PreserveAspectFit
            source: "../images/0-color/HMI-ICON-29.png"
        }

        Image {
            id: imageTyre
            width: 75
            height: 75
            sourceSize.height: 267
            sourceSize.width: 267
            visible: true
            z: 1
            anchors.verticalCenter: parent.verticalCenter
            fillMode: Image.PreserveAspectFit
            source: "../images/0-color/HMI-ICON-48.png"
            anchors.leftMargin: -30
            anchors.left: imageEcasKneeling.right
        }

        Image {
            id: imageMotor
            width: 75
            height: 75
            anchors.verticalCenter: parent.verticalCenter
            sourceSize.height: 267
            sourceSize.width: 267
            fillMode: Image.PreserveAspectFit
            anchors.leftMargin: -30
            source: "../images/0-color/HMI-ICON-63.png"
            anchors.left: imageTyre.right
        }

        Image {
            id: imageMainPower
            y: 7
            width: 75
            height: 75
            anchors.verticalCenter: parent.verticalCenter
            fillMode: Image.PreserveAspectFit
            anchors.leftMargin: -30
            source: "../images/0-color/HMI-ICON-16.png"
            anchors.left: imageParking.right
        }

        Image {
            id: imageBatteryStatus
            width: 75
            height: 75
            anchors.verticalCenter: parent.verticalCenter
            fillMode: Image.PreserveAspectFit
            source: "../images/1-white/white-HMI-ICON-25.png"
            anchors.leftMargin: -30
            anchors.left: imageMainPower.right
        }

        Image {
            id: imageEvacuation
            width: 75
            height: 75
            fillMode: Image.PreserveAspectFit
            sourceSize.height: 267
            sourceSize.width: 267
            source: "../images/0-color/HMI-ICON-24.png"
            anchors.leftMargin: -20
            visible: true
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: imageHazardLight.right
            anchors.topMargin: 0
        }

        Image {
            id: imageCANBus
            y: 600
            width: 75
            height: 75
            visible: false
            fillMode: Image.PreserveAspectFit
            source: "../images/0-color/HMI-ICON-40.png"
            anchors.leftMargin: -10
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: imageAlarmGetOff.right
        }

        Image {
            id: imageDoorOpen
            x: -9
            y: -8
            width: 75
            height: 75
            sourceSize.height: 267
            visible: true
            sourceSize.width: 267
            fillMode: Image.PreserveAspectFit
            anchors.left: imageHazardLight.right
            source: "../images/1-white/white-HMI-ICON-24.png"
            anchors.topMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 50
        }
        }

        Rectangle {
        id: rowAir
        width: 300
        height: 43
    color: "#161616"

        anchors.left: parent.left
        anchors.leftMargin: 10
        Image {
            id: imageAir
            width: 90
            height: 90
            anchors.verticalCenter: parent.verticalCenter
            fillMode: Image.PreserveAspectFit
            anchors.leftMargin: 0
            source: "../images/0-color/HMI-ICON-34.png"
            anchors.left: parent.left
        }

        Text {
            id: txtAirCaption
            y: 0
            height: 43
            color: "#ffffff"
            text: qsTr("㎏/㎠")
            anchors.left: recAirReading.right
            anchors.leftMargin: 0
            horizontalAlignment: Text.AlignHCenter
            MouseArea {
            width: 70
            height: 40
            enabled: false
            anchors.top: parent.top
            anchors.left: parent.left
            hoverEnabled: false
            }
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 25
            verticalAlignment: Text.AlignVCenter
        }


        Rectangle {
            id: recAirReading
            y: 379
            width: 100
            height: 43
            color: "#000000"
            radius: 10
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 90

            Text {
                id: txtAirReading
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("0.0")
                font.pixelSize: 25
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        anchors.top: rowTop.bottom
        anchors.topMargin: 30
        }

        Rectangle {
        id: rowMotorTemp
        x: -8
        width: 300
        height: 43
    color: "#161616"
        Image {
            id: imageMotorTemp
            width: 90
            height: 90
            anchors.verticalCenter: parent.verticalCenter
            fillMode: Image.PreserveAspectFit
            anchors.leftMargin: 0
            source: "../images/1-white/HMI-ICON-32.png"
            anchors.left: parent.left
        }

        Text {
            id: txtKph5
            y: 0
            height: 43
            color: "#ffffff"
            text: qsTr("℃")
            font.family: "Tahoma"
            anchors.left: recMotorTemp.right
            anchors.leftMargin: 0
            horizontalAlignment: Text.AlignHCenter
            MouseArea {
            width: 70
            height: 40
            enabled: false
            anchors.top: parent.top
            anchors.left: parent.left
            hoverEnabled: false
            }
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 24
        }
        Rectangle {
            id: recMotorTemp
            y: 379
            width: 100
            height: 43
            color: "#000000"
            radius: 10
            z: 1
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 90

            Text {
        id: txtMotorIoTempReading
        y: 0
        width: 70
        height: 43
        color: "#ffffff"
        text: qsTr("0")
        verticalAlignment: Text.AlignVCenter
        textFormat: Text.RichText
        anchors.horizontalCenter: parent.horizontalCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.verticalCenter: parent.verticalCenter
        z: 5
        lineHeight: 1.1
        font.pixelSize: 25
        styleColor: "#000000"
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        }
        }
        anchors.leftMargin: 10
        anchors.top: rowAir.bottom
        anchors.left: parent.left
        anchors.topMargin: 5
        }

        Rectangle {
        id: rowIoTankTemp
        x: -6
        width: 300
        height: 43
    color: "#161616"
        anchors.top: rowMotorTemp.bottom
        anchors.topMargin: 5
        Image {
            id: imageIoTankTemp
            width: 90
            height: 90
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
            height: 43
            color: "#ffffff"
            text: qsTr("℃")
            renderType: Text.NativeRendering
            font.family: "Tahoma"
            anchors.left: recOTankTemp.right
            anchors.leftMargin: 0
            horizontalAlignment: Text.AlignLeft
            MouseArea {
                width: 70
                height: 40
                enabled: false
            anchors.top: parent.top
            anchors.left: parent.left
            hoverEnabled: false
            }
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 24
            verticalAlignment: Text.AlignVCenter
        }

        Rectangle {
            id: recOTankTemp
            y: 379
            width: 100
            height: 43
            color: "#000000"
            radius: 10
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 90
            Text {
                id: txtOTankTemp
            y: 0
            width: 70
            height: 43
            color: "#ffffff"
            text: qsTr("0")
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            MouseArea {
                width: 70
                height: 40
                anchors.left: parent.left
                hoverEnabled: false
                anchors.top: parent.top
            }
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 25
            verticalAlignment: Text.AlignVCenter
            }
        }
        anchors.leftMargin: 10
        anchors.left: parent.left
        }

        Rectangle {
        id: rowLcWarning
        x: -10
        width: 300
        height: 43
    color: "#161616"

        anchors.top: rowIoTankTemp.bottom
        anchors.topMargin: 5
        Image {
            id: imageV24
            width: 90
            height: 90
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
            height: 43
            color: "#ffffff"
            text: qsTr("volt")
            anchors.left: rec24V.right
            anchors.leftMargin: 0
            font.family: "Tahoma"
            horizontalAlignment: Text.AlignLeft
            MouseArea {
                width: 70
            height: 40
            anchors.top: parent.top
            anchors.left: parent.left
            hoverEnabled: false
            }
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 24
            verticalAlignment: Text.AlignVCenter
        }

        Rectangle {
            id: rec24V
            y: 439
            width: 100
            height: 43
            color: "#000000"
            radius: 10
            anchors.left: parent.left
            anchors.leftMargin: 90
            anchors.verticalCenter: parent.verticalCenter
            Text {
            id: txtV24
            y: 0
            width: 70
            height: 43
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
            font.pixelSize: 25
            }
        }
        anchors.leftMargin: 10
        anchors.left: parent.left
        }

        Rectangle {
        id: rowDateTime
        x: 0
        width: 250
        height: 24
        color: "#161616"
        anchors.horizontalCenter: parent.horizontalCenter

        anchors.top: rowTop.bottom
        anchors.topMargin: 3

        Text {
            id: txtClock
            x: 0
            y: 0
            width: 250
            height: 24
            color: "#ffffff"
            text: qsTr("2019/10/04 15:30:00")
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 24
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 30
        function set() {
        // How to format a Date in MM/dd/yyyy HH:mm:ss
        // format in JavaScript? ( https://goo.gl/nq1b73 )
    Number.prototype.padLeft = function(base,chr){
    var  len = (String(base || 10).length - String(this).length)+1;
    return len > 0? new Array(len).join(chr || '0')+this : this;
    }
        var d = new Date,
        dformat = [
            d.getFullYear(),
            (d.getMonth()+1).padLeft(),
            d.getDate().padLeft(),
        ].join('/') +' ' + [
        d.getHours().padLeft(),
        d.getMinutes().padLeft(),
        d.getSeconds().padLeft()].join(':');
        //=> dformat => '2012/05/17 10:52:21'
        txtClock.text = dformat;
        }
        // QML Example Use timer to update Date
        // ( https://goo.gl/REe3HA )
            Timer {
            id: clockTimer
            repeat: true
            interval: 1 * 1000
            triggeredOnStart: true
            running: true
        onTriggered: txtClock.set()
            }

            MouseArea {
            hoverEnabled: false
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            }
        }
        }

        Rectangle {
        id: milage
        x: 650
        width: 180
        height: 30
        color: "#000000"
        radius: 10
        anchors.top: speedometer.bottom
        anchors.topMargin: 10
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
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 20
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
        }

    // TODO: to be obseleted, but ChartView in use
        CircularGauge {
        id: powerGauge
        x: 0
        y: 128
        width: 200
        height: 200
        anchors.horizontalCenterOffset: 324
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 440
        anchors.horizontalCenter: parent.horizontalCenter
        visible: true
        stepSize: 1
        value: 0
        minimumValue: -500
        maximumValue: 1000
        smooth: true
        Behavior on value {
        NumberAnimation {
        duration: 500
        }
        }
        style: IconGaugeStyle {
            id: tempGaugeStyle
            maxWarningColor: Qt.rgba(0.5, 0, 0, 1)
            //icon: "qrc:/images/power.png"
            tickmarkLabel: Text {
            color: "#ffffff"
            text: styleData.value/1
            font.pixelSize: tempGaugeStyle.toPixels(0.08)
            }
        }
        }

    Rectangle {
    id: recEnergyConsumption
    y: 800
    z: 1
    width: 310
    height: 210
    color: "#000000"
    radius: 0
    anchors.left: parent.left
    anchors.leftMargin: 0
    anchors.top: rowTop.bottom
    anchors.topMargin: 270
    //border.width: 1
    //border.color: "white"

    ChartView {
        id: energy
        title: "Energy Consumption ( kw )"
        titleColor: "white"
        titleFont.pointSize: 10
        backgroundColor: "#1f1f1f"
        x: 0
        y: 800
        //y: -8
        width: 310
        height: 210
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
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
        min: -80/*-500*/
        max: 150/*1000*/
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
    /*
        LineSeries {
        //name: "Russian"
        id: lineSeries1
        //color: "Light green"
        color: "white"
        axisX: valueAxis
        axisY: valueAxisKw
        pointLabelsVisible: false
        }
    */
        AreaSeries {
        id: areaSeries1
        // name: "Russian"
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
            /*XYPoint { x: 00; y: 750 }
            XYPoint { x: 01; y: 500 }*/
        }
        }
        onSeriesRemoved: { /* ( https://is.gd/BsvBXx ) */
        console.debug("onSeriesRemoved");
        }
    }

    // QT Charts QML scrolling X axis in ms
    // ( https://is.gd/zChCxb )
    Timer {
        property int amountOfData: 0
        //So we know when we need to start scrolling
        id: refreshTimer
        interval: 1000/* ms */ * update_freq
        running: true
        repeat: true
        onTriggered: {
        /* lineSeries1.append(amountOfData, powerGauge.value);
            //lineSeries1.append(10, Dashboard.gpsAltitude);
        if(amountOfData > lineSeries1.axisX.max) {
            lineSeries1.axisX.min++;
            lineSeries1.axisX.max++;
            lineSeries1.remove(lineSeries1.axisX.min-1);
        }
        else{
            amountOfData++;
            // This else is just to stop
            // incrementing the variable unnecessarily
        }*/
        areaSeries1.lowerSeries.append(amountOfData, 0);
        areaSeries1.upperSeries.append(amountOfData, powerGauge.value);
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
        x: 1091
        width: 265
        height: 265
        visible: false
        minimumValue: 0
        value: 0.000
        stepSize: 0.001
        maximumValue: 15
        anchors.top: recEnergyConsumption.bottom
        anchors.topMargin: -155
        anchors.right: parent.right
        anchors.rightMargin: -332
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
        }
        anchors.horizontalCenter: parent.horizontalCenter
        border.width: 0
        anchors.leftMargin: 3
        border.color: "#ffffff"
        }
        }

        CircularGauge {
        id: speedometer
        x: 0
        width: 400
        height: 400
        anchors.top: rowTop.bottom
        anchors.topMargin: 53
        value: 0
        anchors.horizontalCenter: parent.horizontalCenter
        maximumValue: 200
        style: DashboardGaugeStyle {
    /*
        Text {
        id: speedText
        font.pixelSize: toPixels(0.3)
        text: kphInt
        color: speedometer.value >= 110 ? "red" : "white"
        horizontalAlignment: Text.AlignRight
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.verticalCenter
        anchors.topMargin: toPixels(0.1)
        readonly property int kphInt: control.value
        }
    */
        }
        smooth: true
        Behavior on value {
        NumberAnimation {
        duration: 500
        }
        }
        TurnIndicator {
            id: leftIndicator
            x: 100
            width: 70
            height: 70
            anchors.left: parent.left
            flashing: false
            on: false
            anchors.leftMargin: 0
            direction: Qt.LeftArrow
            anchors.top: parent.top
            anchors.topMargin: 0
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
            x: 80
            width: height
            height: 70
            flashing: /*isAnimating ? true:*/ false
            //on: isAnimating ? true:false
            on: false
            anchors.right: parent.right
            anchors.rightMargin: 0
            direction: Qt.RightArrow
            anchors.top: parent.top
            anchors.topMargin: 0
        }
        }

    // usage as RPM gauge
    // scale: What are the RPM figures given for electric vehicles? ( https://is.gd/vwxoRZ )

        Image {
        id: imageCharging
        x: -9
        y: -8
        width: 75
        height: 75
        source: "../images/0-color/HMI-ICON-53.png"
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.top: imageBattery.bottom
        fillMode: Image.PreserveAspectFit
        MouseArea {
        id: mouseAreaChargingStation
        width: 75
        height: 75
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        z: 2
        onClicked: {
        hmiroot.qmlSignal("ChargingStation");
        }
        }
        anchors.topMargin: -30
        }

        Image {
        id: imageBattery
        x: -6
        width: 75
        height: 75
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.top: rowTop.bottom
        anchors.topMargin: 190
        sourceSize.height: 267
        sourceSize.width: 267
        source: "../images/0-color/HMI-ICON-51.png"
        fillMode: Image.PreserveAspectFit
        MouseArea {
            id: mouseAreaDeployment
            width: 75
            height: 75
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.right: parent.right
            z: 2
            onClicked: {
            hmiroot.qmlSignal("Battery");
            }
        }
        }
        Image {
            id: imageDiagnostics
            width: 75
            height: 75
            anchors.topMargin: -30
            fillMode: Image.PreserveAspectFit
            anchors.top: imageTPMS.bottom
            source: "../images/0-color/20190703HMI-ICON-90.png"
            anchors.right: parent.right
            anchors.rightMargin: 0
        MouseArea {
        id: mouseAreaDiagnose
        z: 2
        anchors.fill: parent
        onClicked: {
        hmiroot.qmlSignal("Diagnosis");
        }
        }
        }
        /*
    MyObject {
       id: myobject
    }
    */

        // Dashboards are typically in a landscape orientation, so we need to ensure
        // our height is never greater than our width.

        ToggleButton {
            id: tbTrip
            x: 746
            width: 75
            height: 75
            text: qsTr("T")
            anchors.top: speedometer.bottom
            anchors.topMargin: 0
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
        }

        Image {
            id: imageEngineering
            x: 6
            y: 1
            width: 75
            height: 75
            anchors.rightMargin: 0
            fillMode: Image.PreserveAspectFit
            anchors.right: parent.right
            source: "../images/0-color/HMI-ICON-57.png"
            MouseArea {
                id: mouseAreaEngineering
                width: 75
                height: 75
                anchors.right: parent.right
                anchors.top: parent.top
                z: 2
                onClicked: {
                    hmiroot.qmlSignal("Vehicle");
                }
            }
            anchors.topMargin: -30
            anchors.top: imageIconDesc.bottom
        }

        Image {
            id: imageHistory
            x: 8
            y: 8
            width: 75
            height: 75
            fillMode: Image.PreserveAspectFit
            anchors.top: imageEngineering.bottom
            anchors.right: parent.right
            MouseArea {
                id: maHistory
                width: 75
                height: 75
                visible: true
                anchors.top: parent.top
                anchors.right: parent.right
                z: 2
                onClicked: {
                    hmiroot.qmlSignal("History");
                }
            }
            anchors.rightMargin: 0
            source: "../images/0-color/20190703HMI-ICON-83.png"
            anchors.topMargin: -30
        }

    Rectangle {
        id: recAdas
        x: 1091
        y: 143
        width: 320
        height: 230
        color: "#1f1f1f"
        radius: 1
        visible: false
        anchors.right: parent.right
        anchors.rightMargin: -387
        anchors.top: rowTop.bottom
        anchors.topMargin: 53
        BorderImage {
            id: imgADAS
            width: 320
            height: 230
            anchors.verticalCenterOffset: 0
            anchors.horizontalCenterOffset: 0
            visible: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        source: ""
        }
    }

    // cannot specify left, right... inside Row, Row will not work.
  Rectangle /*Row*/ {
     id: recMilageLeft
     x: -19
     width: 300
     height: 43
     color: "#161616"

     Image {
         id: imageStation
         width: 70
         height: 70
         anchors.verticalCenterOffset: -1
         sourceSize.height: 267
         sourceSize.width: 267
         source: "../images/1-white/20190308HMI-ICON-85.png"
         anchors.verticalCenter: parent.verticalCenter
         anchors.left: parent.left
         fillMode: Image.PreserveAspectFit
         anchors.leftMargin: 12
     }

     Text {
         id: txtMLeftSuffix
         y: 0
         height: 43
         color: "#ffffff"
     // ref. regulation 75 appendix 15
         text: qsTr("km")
         anchors.left: recStation.right
         anchors.leftMargin: 0
         anchors.verticalCenter: parent.verticalCenter
         MouseArea {
             width: 70
             height: 40
             anchors.left: parent.left
             anchors.top: parent.top
             hoverEnabled: false
         }
         font.pixelSize: 25
         horizontalAlignment: Text.AlignLeft
         verticalAlignment: Text.AlignVCenter
     }

     Rectangle {
         id: recStation
         y: 439
         width: 100
         height: 43
         color: "#000000"
         radius: 10
         anchors.verticalCenter: parent.verticalCenter
         Text {
             id: txtMilageLeft
             y: 0
             width: 70
             height: 43
             color: "#ffffff"
             text: qsTr("000.0")
             anchors.verticalCenter: parent.verticalCenter
             MouseArea {
                 width: 70
                 height: 40
                 anchors.left: parent.left
                 anchors.top: parent.top
                 hoverEnabled: false
             }
             font.pixelSize: 25
             anchors.horizontalCenter: parent.horizontalCenter
             horizontalAlignment: Text.AlignHCenter
             anchors.verticalCenterOffset: 0
             verticalAlignment: Text.AlignVCenter
         }
         anchors.left: parent.left
         anchors.leftMargin: 90
     }
     anchors.left: parent.left
     anchors.top: rowLcWarning.bottom
     anchors.topMargin: 5
     anchors.leftMargin: 10
  }

 Image {
     id: imageTPMS
     x: -1
     y: 0
     width: 75
     height: 75
     anchors.rightMargin: 0
     anchors.right: parent.right
     anchors.topMargin: -30
     MouseArea {
         id: maTPMS
         width: 75
         height: 75
         anchors.right: parent.right
         visible: true
         z: 2
         anchors.top: parent.top
        onClicked: {
    console.log("tpms")
        hmiroot.qmlSignal("TPMS");
        }
     }
     fillMode: Image.PreserveAspectFit
     source: "../images/0-color/20190703HMI-ICON-86.png"
     anchors.top: imageCharging.bottom
 }

 Image {
     id: imageUnlock
     x: 10
     y: 15
     width: 75
     height: 75
     anchors.rightMargin: 0
     anchors.right: parent.right
     anchors.topMargin: -30
     MouseArea {
         id: maUnlock
         width: 75
         height: 75
         anchors.right: parent.right
         visible: true
         z: 2
         anchors.top: parent.top
        onClicked: {
        hmiroot.qmlSignal("UNLOCK");
        }
     }
     fillMode: Image.PreserveAspectFit
     source: "../images/0-color/20190703HMI-ICON-92.png"
     anchors.top: imageDiagnostics.bottom
 }

 Image {
     id: imageIconDesc
     x: 17
     y: 1
     width: 75
     height: 75
     anchors.rightMargin: 0
     anchors.right: parent.right
     anchors.topMargin: -30
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
     anchors.top: imageUnlock.bottom
 }

 Image {
     id: imageParameters
     x: 8
     y: 5
     width: 75
     height: 75
     anchors.rightMargin: 0
     anchors.right: parent.right
     anchors.topMargin: -30
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
     anchors.top: imageHistory.bottom
 }

 Rectangle {
     id: rowChargingMaxOutput
     y: 700
     width: 1024
     height: 30
     color: "#161616"
     anchors.left: parent.left
     anchors.leftMargin: 0
     // anchors.top: rowCharge.bottom
     Text {
         id: txtGx
         y: 0
         width: 30
         height: 25
         color: "#ffffff"
         text: qsTr("X :")
         visible: true
         anchors.left: parent.left
         anchors.verticalCenterOffset: 0
         font.pixelSize: 19
         verticalAlignment: Text.AlignVCenter
         anchors.verticalCenter: parent.verticalCenter
         anchors.leftMargin: 0
         horizontalAlignment: Text.AlignLeft
     }

     Text {
         id: txtXValue
         y: 9
         width: 140
         height: 25
         color: "#ffffff"
         text: qsTr("0000000000000000")
         visible: true
         anchors.left: txtGx.right
         anchors.verticalCenterOffset: 0
         font.pixelSize: 12
         verticalAlignment: Text.AlignVCenter
         anchors.verticalCenter: parent.verticalCenter
         anchors.leftMargin: 0
         horizontalAlignment: Text.AlignLeft
     }

     Text {
         id: txtGy
         x: -9
         y: -9
         width: 30
         height: 25
         color: "#ffffff"
         text: qsTr("Y :")
         visible: false
         verticalAlignment: Text.AlignVCenter
         anchors.verticalCenter: parent.verticalCenter
         horizontalAlignment: Text.AlignLeft
         anchors.leftMargin: 10
         font.pixelSize: 19
         anchors.left: txtXValue.right
         anchors.verticalCenterOffset: 0
     }

     Text {
         id: txtYValue
         x: -9
         y: 0
         width: 60
         height: 25
         color: "#ffffff"
         text: qsTr("")
         visible: false
         verticalAlignment: Text.AlignVCenter
         anchors.verticalCenter: parent.verticalCenter
         horizontalAlignment: Text.AlignLeft
         anchors.leftMargin: 0
         font.pixelSize: 15
         anchors.left: txtGy.right
         anchors.verticalCenterOffset: 0
     }

     Text {
         id: txtGz
         x: -17
         y: -17
         width: 30
         height: 25
         color: "#ffffff"
         text: qsTr("Z :")
         visible: false
         verticalAlignment: Text.AlignVCenter
         anchors.verticalCenter: parent.verticalCenter
         horizontalAlignment: Text.AlignLeft
         anchors.leftMargin: 10
         font.pixelSize: 19
         anchors.left: txtYValue.right
         anchors.verticalCenterOffset: 0
     }

     Text {
         id: txtZValue
         x: -17
         y: -8
         width: 60
         height: 25
         color: "#ffffff"
         text: qsTr("")
         visible: false
         verticalAlignment: Text.AlignVCenter
         anchors.verticalCenter: parent.verticalCenter
         horizontalAlignment: Text.AlignLeft
         anchors.leftMargin: 0
         font.pixelSize: 15
         anchors.left: txtGz.right
         anchors.verticalCenterOffset: 0
     }

     Text {
         id: txtPitch
         x: -15
         y: -15
         width: 60
         height: 25
         color: "#ffffff"
         text: qsTr("pitch:")
         visible: false
         verticalAlignment: Text.AlignVCenter
         anchors.verticalCenter: parent.verticalCenter
         horizontalAlignment: Text.AlignLeft
         anchors.leftMargin: 10
         font.pixelSize: 19
         anchors.left: txtZValue.right
         anchors.verticalCenterOffset: 0
     }

     Text {
         id: txtRollVal
         x: -15
         y: -6
         width: 60
         height: 25
         color: "#ffffff"
         text: qsTr("")
         visible: false
         verticalAlignment: Text.AlignVCenter
         anchors.verticalCenter: parent.verticalCenter
         horizontalAlignment: Text.AlignLeft
         anchors.leftMargin: 0
         font.pixelSize: 15
         anchors.left: txtRoll.right
         anchors.verticalCenterOffset: 0
     }

     Text {
         id: txtRoll
         x: -24
         y: -24
         width: 45
         height: 25
         color: "#ffffff"
         text: qsTr("roll :")
         visible: false
         horizontalAlignment: Text.AlignLeft
         anchors.leftMargin: 10
         anchors.left: txtPitchVal.right
         verticalAlignment: Text.AlignVCenter
         font.pixelSize: 19
         anchors.verticalCenter: parent.verticalCenter
         anchors.verticalCenterOffset: 0
     }

     Text {
         id: txtPitchVal
         x: -24
         y: -15
         width: 60
         height: 25
         color: "#ffffff"
         text: qsTr("")
         visible: false
         horizontalAlignment: Text.AlignLeft
         anchors.leftMargin: 10
         anchors.left: txtPitch.right
         verticalAlignment: Text.AlignVCenter
         font.pixelSize: 15
         anchors.verticalCenter: parent.verticalCenter
         anchors.verticalCenterOffset: 0
     }

     Text {
         id: txtYawVal
         x: -23
         y: -14
         width: 60
         height: 25
         color: "#ffffff"
         text: qsTr("")
         visible: false
         horizontalAlignment: Text.AlignLeft
         anchors.leftMargin: 0
         anchors.left: txtYaw.right
         verticalAlignment: Text.AlignVCenter
         font.pixelSize: 15
         anchors.verticalCenter: parent.verticalCenter
         anchors.verticalCenterOffset: 0
     }

     Text {
         id: txtYaw
         x: -32
         y: -32
         width: 50
         height: 25
         color: "#ffffff"
         text: qsTr("yaw :")
         visible: false
         anchors.leftMargin: 10
         horizontalAlignment: Text.AlignLeft
         anchors.left: txtRollVal.right
         font.pixelSize: 19
         verticalAlignment: Text.AlignVCenter
         anchors.verticalCenter: parent.verticalCenter
         anchors.verticalCenterOffset: 0
     }

     Text {
         id: txtVersionLabel
         x: 192
         width: 50
         height: 25
         color: "#ffffff"
         text: qsTr("VER:")
         verticalAlignment: Text.AlignVCenter
         font.family: "Verdana"
         anchors.verticalCenter: parent.verticalCenter
         font.pixelSize: 16
         anchors.left: txtRoll.right
         textFormat: Text.PlainText
         fontSizeMode: Text.FixedSize
         anchors.leftMargin: 230
     }

     Text {
         id: txtVersion
         y: -9
         width: 200
         height: 25
         color: "#ffffff"
         text: qsTr("YYYYMMDDHHNNSS")
         verticalAlignment: Text.AlignVCenter
         anchors.verticalCenter: parent.verticalCenter
         font.pixelSize: 16
         anchors.left: txtVersionLabel.right
         textFormat: Text.RichText
         fontSizeMode: Text.FixedSize
         objectName: "txtVersion"
         font.family: "Cantarell"
         anchors.leftMargin: 0
     }
     anchors.topMargin: 50
 }

 Text {
     id: txtZero
     x: -42
     y: 287
     width: 32
     height: 20
     color: "#ffffff"
     text: qsTr("0")
     lineHeight: 0.8
     z: 2
     font.pixelSize: 15
     horizontalAlignment: Text.AlignLeft
     verticalAlignment: Text.AlignVCenter
 }

 Text {
     id: txtMinus
     x: -42
     y: 350
     width: 32
     height: 21
     color: "#ffffff"
     text: qsTr("-")
     horizontalAlignment: Text.AlignLeft
     verticalAlignment: Text.AlignVCenter
     font.pixelSize: 30
     z: 2
 }

 Text {
     id: txtPlus
     x: -43
     y: 163
     width: 32
     height: 20
     color: "#ffffff"
     text: qsTr("+")
     horizontalAlignment: Text.AlignLeft
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

    Component.onCompleted: {
    console.debug(
        // FIXME: find out why undefined
        " daw: " + hmiroot.desktopAvailableWidth + ", " +
        " dah: " + hmiroot.desktopAvailableHeight+ ", " +
        " w: " + hmiroot.width + ", " +
        " h: " + hmiroot.height);
    // TODO: ticking here
    // hmiroot.qmlSignalOnCompleted(""); // FIXME: too early to fire
    // tickTimeStamp(); // FIXME: works but format fixing needed
    }
    }

    onActiveChanged : {
    //console.log("Activated "+this.id); // FIXME:
    if ( true === hmiroot.active ) {
        hmiroot.qmlSignalActive("Main");
    }
    }
}





































































































/*##^## Designer {
    D{i:0;height:768;width:1024}D{i:45;anchors_width:70;anchors_x:0}D{i:51;anchors_width:70;anchors_x:0}
D{i:57;anchors_width:70;anchors_x:0}D{i:64;anchors_width:70;anchors_x:0}D{i:98;anchors_width:75;anchors_x:-6;anchors_y:0}
D{i:111;anchors_width:70;anchors_x:0}D{i:156;anchors_x:183}
}
 ##^##*/
