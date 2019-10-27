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

import QtQuick 2.2
import QtQuick.Window 2.1 // needed for the Window component
import QtQuick.Shapes 1.12
import "style"

Window {
    id: charging

    // ( https://goo.gl/LWbdMG )
    objectName: "chargingWindow"

    // QML - main window position on start (screen center)
    // ( https://goo.gl/wLpvZD )
    Styles { id: style }
    width: style.resolutionWidth // application wide properties
    height: style.resolutionHeight
    maximumHeight: height
    maximumWidth: width
    x: 0 // (Screen.width - width) / 2
    y: 0 // (Screen.height - height) / 2

    minimumHeight: height
    minimumWidth: width
    color: "#161616"
    property alias window: charging
    flags: Qt.FramelessWindowHint
    title: "Charging"

    // Property names must begin with a lower case letter
    // and can only contain letters ( https://goo.gl/HzLQet )
    //
    property int iPowerCordTurn: 0
    property var maxV: 0
    property var maxA: 0
    property var maxT: 0
    property var maxTidx: 0
    property var estRemains: 0
    property var chargingState: 0
    property var prevChargingState: 0

    signal qmlSignalActive(string msg)

    function updateMsg_BMS_VCU_Msg03(max_pt_temp, max_pt_idx,
    charger_cc2,charger_conn1,charger_conn2,bms_pr_state,
    mctr_state, mi_ctr_state, frelay_state, l_counter) {
    txtCode0.text = charger_cc2;
    txtCode1.text = charger_conn1;
    txtCode2.text = charger_conn2;
    txtCode4.text = l_counter;
    if ( 0 === charger_cc2 ) {
        cc2Timer.stop();
        conn1Timer.stop();
        powerCordTimer.stop();
        animation.stop();
        spinnerRotation.stop();
        if ( true == animation.running ) animation.stop();
        if ( true == spinnerRotation.running ) spinnerRotation.stop();
        // take charger state into consideration
        if ( 0 == chargingState ) {
        //console.log('charger_cc2 '+charger_cc2);
        imageStation.visible = true;
        imageQuestionMark.visible = false;
        imageStationConnectingInProgress.visible = false;
        imageStationDoneAndDetached.visible = false;
        imageBus.visible = true;
        //imageBusChargeInProgress.visible = false;
        imageHandShaking.visible = false;
        imageHandShaked.visible = false;
        imagePlugging.visible = false;
        imagePlugged.visible = false;
        imageChargingInProgress.visible = false;
        imageFullyCharged.visible = false;
        }
        else {
        // abort!!
        imageQuestionMark.visible = true;
        imageStationDoneAndDetached.visible = true;
        imageStation.visible = false;
        imageStationConnectingInProgress.visible = false;
        recProgressing.visible = false;
        imageSpinner.visible = false;
        imagePowerCord00Percent.visible = false;
        imagePowerCord10Percent.visible = false;
        imagePowerCord20Percent.visible = false;
        imagePowerCord30Percent.visible = false;
        imagePowerCord40Percent.visible = false;
        imagePowerCord50Percent.visible = false;
        imagePowerCord60Percent.visible = false;
        imagePowerCord70Percent.visible = false;
        imagePowerCord80Percent.visible = false;
        imagePowerCord90Percent.visible = false;
        }
    }
    else if ( 1 == charger_cc2 ) {
        imageQuestionMark.visible = false;
        imageStationConnectingInProgress.visible = true;
        imageStation.visible = false;
        //imageBusChargeInProgress.visible = true;
        //imageBus.visible = false;
        imagePowerCord00Percent.visible = true;
        imagePlugging.visible = true;
        //imageBusChargeInProgress.visible = true;
        cc2Timer.start();
    }
    else { }

    if ( 1 == charger_conn1 ) {
        imageQuestionMark.visible = false;
        cc2Timer.stop();
        imageHandShaking.visible = true;
        imagePlugging.visible = false;
        conn1Timer.start();
    }
    else {
        conn1Timer.stop();
    }

    if ( 1 == charger_conn2 ) {
        imageQuestionMark.visible = false;
        conn1Timer.stop();
        imageHandShaked.visible = false;
        imageHandShaking.visible = true;
    }
    else if ( 2 == charger_conn2 ) {
        imageQuestionMark.visible = false;
        conn1Timer.stop();
        imageHandShaked.visible = true;
        imageHandShaking.visible = false;
        maxT = max_pt_temp;
        maxTidx = max_pt_idx;
    }
    else {
    }
    }

    function updateBMS_VCU_MSG04(chg_state, battery_type,
    s_ri_voltage, bms_code) {
    //console.log(chg_state+','+battery_type+','+s_ri_voltage+','+bms_code);
    txtCode3.text = chg_state;
    chargingState = chg_state;
    txtCode4.text = bms_code;
    //console.log("state: " + prevChargingState + "->" + chg_state);
    if ( 0 == chg_state ) {
        recProgressing.visible = false;
        imageSpinner.visible = false;
        animation.stop();
        powerCordTimer.stop();
        spinnerRotation.stop();
	// txtTotalVoltage.text = "";
	// txtTotalCurrent.text = "";
        // take PGN FF96 (cc2, conn1, conn2) into consideration
        if ( prevChargingState == 1
        && txtCode0.text == 0
        && txtCode1.text == 0
        && txtCode2.text == 0) {
        // cut from FF96 side -> cut from FF97 side
        // back to initial state
        imageQuestionMark.visible = false;
        imageStation.visible = true;
        imageStationConnectingInProgress.visible = false;
        imageStationDoneAndDetached.visible = false;
        }
    }
    else if ( 1 == chg_state ) {
        // charging start
        imageChargingInProgress.visible = true;
        imageHandShaked.visible = false;
        recProgressing.visible = true;
        imageSpinner.visible = true;
        animation.start();
        powerCordTimer.start();
        spinnerRotation.start();
        txtMaxVoltReading.text = maxV;
        txtMaxCurrentReading.text = maxA;
        txtEstTimeRemains.text = estRemains;
        txtMaxTempReading.text = "T"+maxTidx+":"+maxT;
        imageStationDoneAndDetached.visible = false;
    }
    else if ( 2 == chg_state ) {
        animation.stop();
        powerCordTimer.stop();
        spinnerRotation.stop();
        imageSpinner.visible = false;
        imageQuestionMark.visible = false;
        imageFullyCharged.visible = true;
        imageChargingInProgress.visible = false;
        recProgressing.visible = false;
        imagePowerCord90Percent.visible = false;
        imageStationDoneAndDetached.visible = false;
	// txtTotalVoltage.text = "";
	// txtTotalCurrent.text = "";
    }
    else {
    }
    prevChargingState = chg_state;
    }

    function updateBMS_OCU_Msg01(s_mx_allowed_chg_voltage,
    s_mx_allowed_chg_current, chg_time_left_mins, num_chg_times,
    charger_ctrl_cmds) {
    //console.log(s_mx_allowed_chg_voltage+','+s_mx_allowed_chg_current+','+chg_time_left_mins+','+num_chg_times+','+charger_ctrl_cmds);
    maxV = s_mx_allowed_chg_voltage;
    maxA = s_mx_allowed_chg_current;
    estRemains = chg_time_left_mins;
    if ( "1" === txtCode3.text ) {
        txtMaxVoltReading.text = maxV;
        txtMaxCurrentReading.text = maxA;
        txtMaxTempReading.text = "T"+maxTidx+":"+maxT;
        txtEstTimeRemains.text = estRemains;
    }
    }

    function updateBMS_VCU_MSG01(s_voltage,s_current,soc,b_status,
	f_level,mcntctr_nc,mcntctr_st,pcell_alrm,s_cremains) {
	// console.log(this);
	txtSOCReading.text = soc;
	if ( 1 === chargingState ) {
	    txtTotalVoltage.text = s_voltage + "V";
	    txtTotalCurrent.text = Math.abs(s_current) + "A";
	}
	else {
	    txtTotalVoltage.text = "";
	    txtTotalCurrent.text = "";
	}
    }

    Rectangle {
        id: rectangleCharging

        color: "lightGrey"
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 800
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 1280
        MouseArea {
            id: mouseAreaRectangleAll
            z: 2
            anchors.fill: parent
            onClicked: {
                charging.hide();
            }
        }
    }

    Rectangle {
    id: rowDateTime
    x: 2
    width: 350
    height: 43
    color: "#161616"
    // TODO:
    anchors.top: parent
    anchors.leftMargin: 35
    anchors.left: parent.left
    anchors.topMargin: 0

    Text {
        id: txtClock
        x: 0
        width: 350
        color: "#ffffff"
        text: qsTr("2019/05/21 11:08:00")
        anchors.top: parent.top
        anchors.topMargin: 50
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 35
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 30
        function set() {
        Number.prototype.padLeft = function(base,chr){
        var  len
        = (String(base || 10).length - String(this).length)+1;
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

    Image {
        id: imageChartBack
        x: 0
        width: 100
        height: 100
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.topMargin: 0
        z: 1
        anchors.top: parent.top
        MouseArea {
            id: mouseArea
            z: 2
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.right: parent.right
        }
        source: "../images/0-color/HMI-ICON-55.png"
        fillMode: Image.PreserveAspectFit
        MouseArea {
            id: mouseAreaStatusBack
            z: 2
            anchors.fill: parent
            onClicked: {
                charging.hide();
            }
        }
    }

    Item {
        id: element
        x: 355
        width: 400; height: 40
        anchors.verticalCenter: parent.verticalCenter
        // schemecolor ( http://tinyw.in/61V2 )
        Rectangle {
            x: 0; y: 0;
            id: recProgressing
            width: 320; height: 40
            radius: 1
            visible: false
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#2b40f0" }
                GradientStop { position: 0.33; color: "#5fb4f0" }
                GradientStop { position: 1.0; color: "#2b40f0" }
            }
            // this is a standalone animation, it's not running by default
            PropertyAnimation { id: animation;
                target: recProgressing;
                property: "width";
                from: 0;
                to: 400;
                loops: Animation.Infinite;
                running: false;
                duration: 3000 }

            MouseArea { width: 400; }
        }
    }

    Image {
        id: imageSpinner
        x: 162
        y: 105
        width: 80
        height: 80
        z: 4
        sourceSize.height: 150
        sourceSize.width: 150
        clip: false
        visible: false
        antialiasing: true
        opacity: 1
        source: "../images/power.png"
        fillMode: Image.PreserveAspectFit
    RotationAnimator on rotation {
    id: spinnerRotation
        target: imageSpinner;
        from: 0;
        to: -360;
        duration: 1000
        running: false
        loops: Animation.Infinite;
    }
    }

    Image {
        id: imagePlugging
        x: 450
        y: 130
        width: 150
        height: 150
        z: 2
        sourceSize.height: 150
        sourceSize.width: 150
        clip: false
        visible: false
        antialiasing: true
        opacity: 1
        source: "../images/0-color/201905ICON-15.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imagePlugged
        x: 450
        y: 130
        width: 150
        height: 150
        z: 2
        sourceSize.height: 150
        sourceSize.width: 150
        clip: false
        visible: false
        antialiasing: true
        opacity: 1
        source: "../images/0-color/201905ICON-16.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imageHandShaking
        x: 450
        y: 130
        width: 150
        height: 150
        z: 2
        sourceSize.height: 150
        sourceSize.width: 150
        clip: false
        visible: false
        antialiasing: true
        opacity: 1
        source: "../images/0-color/201905ICON-17.png"
        fillMode: Image.PreserveAspectFit
        function set() {
        imageQuestionMark.visible = true;
        imageHandShaking.visible = false;
        conn1Timer.stop();
        console.log('conn1Timer timeout');
        }
    }
    Timer {
    id: conn1Timer
    repeat: false
    interval: 15 * 1000
    triggeredOnStart: false
    running: false
    onTriggered: imageHandShaking.set()
    }

    Image {
        id: imageHandShaked
        x: 450
        y: 130
        width: 150
        height: 150
        z: 2
        sourceSize.height: 150
        sourceSize.width: 150
        clip: false
        visible: false
        antialiasing: true
        opacity: 1
        source: "../images/0-color/201905ICON-18.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imageChargingInProgress
        x: 450
        y: 130
        width: 150
        height: 150
        z: 2
        sourceSize.height: 150
        sourceSize.width: 150
        clip: false
        visible: false
        antialiasing: true
        opacity: 1
        source: "../images/0-color/201905ICON-19.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imageFullyCharged
        x: 450
        y: 130
        width: 150
        height: 150
        z: 2
        sourceSize.height: 150
        sourceSize.width: 150
        clip: false
        visible: false
        antialiasing: true
        opacity: 1
        source: "../images/0-color/201905ICON-20.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imageQuestionMark
        x: 450
        y: 130
        width: 150
        height: 150
        z: 2
        sourceSize.height: 150
        sourceSize.width: 150
        clip: false
        visible: false
        antialiasing: true
        opacity: 1
        source: "../images/0-color/201905ICON-22.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imageLeakageWarning
        x: 477
        y: 25
        width: 100
        height: 100
        z: 2
        sourceSize.height: 150
        sourceSize.width: 150
        clip: false
        visible: false
        antialiasing: true
        opacity: 1
        source: "../images/0-color/201905ICON-23.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imageLeakageAlert
        x: 477
        y: 25
        width: 100
        height: 100
        z: 2
        sourceSize.height: 150
        sourceSize.width: 150
        clip: false
        visible: false
        antialiasing: true
        opacity: 1
        source: "../images/0-color/201905ICON-24.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imageStation
        y: 206
        width: 230
        height: 400
        visible: true
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 170
        anchors.left: parent.left
        anchors.leftMargin: 100
        anchors.verticalCenter: parent.verticalCenter
        sourceSize.height: 194
        sourceSize.width: 114
        source: "../images/0-color/201905ICON-01.png"
        fillMode: Image.PreserveAspectCrop
        function set() {
        imageQuestionMark.visible = true;
        imagePlugging.visible = false;
        cc2Timer.stop();
        console.log('cc2Timer timeout');
        }
    }
    Timer {
    id: cc2Timer
    repeat: false
    interval: 15 * 1000
    triggeredOnStart: false
    running: false
    onTriggered: imageStation.set()
    }

    Image {
        id: imageStationConnectingInProgress
        x: 80
        y: 200
        width: 240
        height: 450
        visible: false
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 165
        anchors.left: parent.left
        anchors.leftMargin: 80
        anchors.verticalCenter: parent.verticalCenter
        sourceSize.height: 194
        sourceSize.width: 114
        source: "../images/0-color/201905ICON-03.png"
        fillMode: Image.PreserveAspectCrop
    }

    Image {
        id: imageStationDoneAndDetached
        x: 75
        y: 200
        width: 255
        height: 475
        visible: false
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 165
        anchors.left: parent.left
        anchors.leftMargin: 78
        anchors.verticalCenter: parent.verticalCenter
        sourceSize.height: 214
        sourceSize.width: 109
        source: "../images/0-color/201905ICON-21.png"
        fillMode: Image.PreserveAspectCrop
    }

    Image {
        id: imagePowerCord00Percent
        x: 0
        y: 290
        width: 800
        height: 355
        anchors.left: parent.left
        anchors.leftMargin: 114
        z: 3
        visible: false
        sourceSize.height: 155
        sourceSize.width: 200
        source: "../images/0-color/201905ICON-14.png"
        fillMode: Image.PreserveAspectFit

        Timer {
        id: powerCordTimer
        repeat: true
        interval: 1 * 100
        triggeredOnStart: false
        running: false
        onTriggered: imagePowerCord00Percent.set()
        }

        function set() {
        ++iPowerCordTurn;

        imagePowerCord00Percent.visible = false;
        imagePowerCord10Percent.visible = false;
        imagePowerCord20Percent.visible = false;
        imagePowerCord30Percent.visible = false;
        imagePowerCord40Percent.visible = false;
        imagePowerCord50Percent.visible = false;
        imagePowerCord60Percent.visible = false;
        imagePowerCord70Percent.visible = false;
        imagePowerCord80Percent.visible = false;
        imagePowerCord90Percent.visible = false;
        imagePowerCord100Percent.visible = false;

        switch ( iPowerCordTurn ) {
        case 0: imagePowerCord00Percent.visible = true; break;
        case 1: imagePowerCord10Percent.visible = true; break;
        case 2: imagePowerCord20Percent.visible = true; break;
        case 3: imagePowerCord30Percent.visible = true; break;
        case 4: imagePowerCord40Percent.visible = true; break;
        case 5: imagePowerCord50Percent.visible = true; break;
        case 6: imagePowerCord60Percent.visible = true; break;
        case 7: imagePowerCord70Percent.visible = true; break;
        case 8: imagePowerCord80Percent.visible = true; break;
        case 9: imagePowerCord90Percent.visible = true; break;
        case 10: imagePowerCord100Percent.visible = true; break;
        }
        if ( 10 < iPowerCordTurn ) {
        iPowerCordTurn = 0;
        imagePowerCord00Percent.visible = true;
    }
    }
    }

    Image {
        id: imagePowerCord10Percent
        x: 0
        y: 290
        width: 800
        height: 355
        anchors.left: parent.left
        anchors.leftMargin: 114
        z: 3
        visible: false
        sourceSize.height: 155
        sourceSize.width: 200
        source: "../images/0-color/201905ICON-13.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imagePowerCord20Percent
        x: 0
        y: 290
        width: 800
        height: 355
        anchors.left: parent.left
        anchors.leftMargin: 114
        z: 3
        visible: false
        sourceSize.height: 155
        sourceSize.width: 200
        source: "../images/0-color/201905ICON-12.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imagePowerCord30Percent
        x: 0
        y: 290
        width: 800
        height: 355
        anchors.left: parent.left
        anchors.leftMargin: 114
        z: 3
        visible: false
        sourceSize.height: 155
        sourceSize.width: 200
        source: "../images/0-color/201905ICON-11.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imagePowerCord40Percent
        x: 0
        y: 290
        width: 800
        height: 355
        anchors.left: parent.left
        anchors.leftMargin: 114
        z: 3
        visible: false
        sourceSize.height: 155
        sourceSize.width: 200
        source: "../images/0-color/201905ICON-10.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imagePowerCord50Percent
        x: 0
        y: 290
        width: 800
        height: 355
        anchors.left: parent.left
        anchors.leftMargin: 114
        z: 3
        visible: false
        sourceSize.height: 155
        sourceSize.width: 200
        source: "../images/0-color/201905ICON-09.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imagePowerCord60Percent
        x: 0
        y: 290
        width: 800
        height: 355
        anchors.left: parent.left
        anchors.leftMargin: 114
        z: 3
        visible: false
        sourceSize.height: 155
        sourceSize.width: 200
        source: "../images/0-color/201905ICON-08.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imagePowerCord70Percent
        x: 0
        y: 290
        width: 800
        height: 355
        anchors.left: parent.left
        anchors.leftMargin: 114
        z: 3
        visible: false
        sourceSize.height: 155
        sourceSize.width: 200
        source: "../images/0-color/201905ICON-07.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imagePowerCord80Percent
        x: 0
        y: 290
        width: 800
        height: 355
        anchors.left: parent.left
        anchors.leftMargin: 114
        z: 3
        visible: false
        sourceSize.height: 155
        sourceSize.width: 200
        source: "../images/0-color/201905ICON-07.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imagePowerCord90Percent
        x: 0
        y: 290
        width: 800
        height: 355
        anchors.left: parent.left
        anchors.leftMargin: 114
        z: 3
        visible: false
        sourceSize.height: 155
        sourceSize.width: 200
        source: "../images/0-color/201905ICON-06.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imagePowerCord100Percent
        x: 0
        y: 290
        width: 800
        height: 355
        anchors.left: parent.left
        anchors.leftMargin: 114
        z: 3
        visible: false
        sourceSize.height: 155
        sourceSize.width: 200
        source: "../images/0-color/201905ICON-05.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imageBus
        x: 340
        y: 253
        width: 400
        height: 400
        anchors.verticalCenter: parent.verticalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 180
        anchors.right: parent.right
        anchors.rightMargin: 170
        sourceSize.height: 194
        sourceSize.width: 114
        source: "../images/0-color/201905ICON-02.png"
        fillMode: Image.PreserveAspectCrop
    }

    Image {
        id: imageBusChargeInProgress
        x: 340
        width: 400
        height: 400
        visible: false
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 150
        anchors.top: parent.top
        anchors.topMargin: 180
        sourceSize.height: 214
        sourceSize.width: 469
        source: "../images/0-color/BusChargingInProgress.png"
        fillMode: Image.PreserveAspectFit
    }

    onActiveChanged : {
        if ( true === charging.active ) {
        charging.qmlSignalActive("ChargingStation");
    }
    }

    Item {
        id: elementFloor
        x: 0; y: 600
        width: 1280; height: 30
    Shape {
        id: ctr
        anchors.fill: parent
        //containsMode: Shape.FillContains
        ShapePath {
        strokeColor: "#ffffff"
        strokeWidth: 5
        //fillColor: "blue"
        startX: 0; startY: 0
        PathLine { x: ctr.width; y: 0 }
        //PathLine { x: ctr.width - 30; y: ctr.height - 30 }
        //PathLine { x: 30; y: ctr.height - 30 }
        //PathLine { x: 30; y: 30 }
        }
    }
    }
        Rectangle {
            id: rowStatusCode
            x: 355
            width: 400
            height: 43
        color: "#161616"
        anchors.top: elementFloor.bottom
        anchors.topMargin: 0

        Rectangle {
        id: recCode0
        y: 379
        width: 70
        height: 43
        color: "#000000"
        radius: 2
        border.color: "#ffffff"
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 0
        }
        Text {
        id: txtCode0
        y: 0
        width: 70
        height: 43
        color: "#ffffff"
        text: qsTr("0")
        wrapMode: Text.WordWrap
        renderType: Text.QtRendering
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 25
        verticalAlignment: Text.AlignVCenter
        }

        Rectangle {
        id: recCode1
        y: 379
        width: 70
        height: 43
        color: "#000000"
        radius: 2
        border.color: "#ffffff"
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: recCode0.right
        anchors.leftMargin: 10
        }
        Text {
        id: txtCode1
        y: 0
        width: 70
        height: 43
        color: "#ffffff"
        text: qsTr("0")
        wrapMode: Text.WordWrap
        renderType: Text.QtRendering
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 25
        verticalAlignment: Text.AlignVCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: txtCode0.right
        anchors.leftMargin: 10
        }

        Rectangle {
        id: recCode2
        y: 379
        width: 70
        height: 43
        color: "#000000"
        radius: 2
        border.color: "#ffffff"
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: recCode1.right
        anchors.leftMargin: 10
        }
        Text {
        id: txtCode2
        y: 0
        width: 70
        height: 43
        color: "#ffffff"
        text: qsTr("0")
        wrapMode: Text.WordWrap
        renderType: Text.QtRendering
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 25
        verticalAlignment: Text.AlignVCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: txtCode1.right
        anchors.leftMargin: 10
        }


        Rectangle {
            id: recCode3
            y: 379
            width: 70
            height: 43
            color: "#000000"
            radius: 2
            border.color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: recCode2.right
            anchors.leftMargin: 10
        }
        Text {
            id: txtCode3
            y: 0
            width: 70
            height: 43
            color: "#ffffff"
            text: qsTr("0")
            wrapMode: Text.WordWrap
            renderType: Text.QtRendering
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 25
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: txtCode2.right
            anchors.leftMargin: 10
        }

        Rectangle {
            id: recCode4
            y: 379
            width: 70
            height: 43
            color: "#000000"
            radius: 2
            border.color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: recCode3.right
            anchors.leftMargin: 10
            Text {
                id: txtCode4
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("FF")
                wrapMode: Text.WordWrap
                renderType: Text.QtRendering
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 25
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 0
            }
        }
        }

    Rectangle {
        id: rowMaxCurrent
        x: 654
        y: 86
        width: 210
        height: 43
    color: "#161616"
        Text {
            id: txtMaxCurrentCap
            y: 0
            width: 100
            height: 43
            color: "#ffffff"
            text: qsTr("Max.A")
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            anchors.leftMargin: 0
            verticalAlignment: Text.AlignVCenter
            MouseArea {
                width: 70
                height: 40
                anchors.top: parent.top
                anchors.left: parent.left
                hoverEnabled: false
            }
            font.pixelSize: 25
            anchors.verticalCenterOffset: 0
        }

        Rectangle {
            id: recMaxCurrent
            y: 380
            width: 100
            height: 43
            color: "#000000"
            radius: 10
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 100
            Text {
                id: txtMaxCurrentReading
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("0")
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 25
            }
        }
    }

    Rectangle {
        id: rowMaxTemperature
        x: 654
        y: 140
        width: 300
        height: 43
    color: "#161616"
        Text {
            id: txtMaxTCap
            y: 0
            width: 100
            height: 43
            color: "#ffffff"
            text: qsTr("Max.T")
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            anchors.leftMargin: 0
            verticalAlignment: Text.AlignVCenter
            MouseArea {
                width: 70
                height: 40
                anchors.top: parent.top
                anchors.left: parent.left
                hoverEnabled: false
            }
            font.pixelSize: 25
            anchors.verticalCenterOffset: 0
        }

        Rectangle {
            id: recTemperatureReading
            y: 379
            width: 130
            height: 43
            color: "#000000"
            radius: 5
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 100
            Text {
                id: txtMaxTempReading
                y: 0
                width: 120
                height: 43
                color: "#ffffff"
                text: qsTr("0")
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 25
            }
        }

        Text {
            id: txtMaxTCap2
            y: 0
            width: 50
            height: 43
            color: "#ffffff"
            text: qsTr("℃")
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            MouseArea {
                width: 70
                height: 40
                anchors.top: parent.top
                anchors.left: parent.left
                hoverEnabled: false
            }
            font.pixelSize: 25
            anchors.verticalCenterOffset: 0
        }
    }

    Rectangle {
        id: rowMaxVoltage
        x: 654
        y: 33
        width: 210
        height: 43
    color: "#161616"
        Text {
            id: txtMaxVoltCap
            y: 0
            width: 100
            height: 43
            color: "#ffffff"
            text: qsTr("Max.V")
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            anchors.leftMargin: 0
            verticalAlignment: Text.AlignVCenter
            MouseArea {
                width: 70
                height: 40
                anchors.top: parent.top
                anchors.left: parent.left
                hoverEnabled: false
            }
            font.pixelSize: 25
            anchors.verticalCenterOffset: 0
        }

        Rectangle {
            id: recMaxVolt
            y: 380
            width: 100
            height: 43
            color: "#000000"
            radius: 10
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 100
            Text {
                id: txtMaxVoltReading
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("0")
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 25
            }
        }
    }

    Rectangle {
        id: rowTimeRemains
        x: 880
        y: 86
        width: 350
        height: 43
    color: "#161616"
        Text {
            id: txtMaxCurrentCap1
            y: 0
            width: 210
            height: 43
            color: "#ffffff"
            text: qsTr("Est.Time Remains")
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            anchors.leftMargin: 0
            verticalAlignment: Text.AlignVCenter
            MouseArea {
                width: 70
                height: 40
                anchors.top: parent.top
                anchors.left: parent.left
                hoverEnabled: false
            }
            font.pixelSize: 25
            anchors.verticalCenterOffset: 0
        }

        Rectangle {
            id: recEstTimeRemains
            y: 380
            width: 80
            height: 43
            color: "#000000"
            radius: 10
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 210
            Text {
                id: txtEstTimeRemains
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("0")
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 25
            }
        }

        Text {
            id: txtEstRemainsPosix
            y: 0
            width: 50
            height: 43
            color: "#ffffff"
            text: qsTr("Mins")
            anchors.left: recEstTimeRemains.right
            anchors.leftMargin: 10
            MouseArea {
                width: 70
                height: 40
                hoverEnabled: false
                anchors.top: parent.top
                anchors.left: parent.left
            }
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 0
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: 25
            verticalAlignment: Text.AlignVCenter
        }
    }

    Rectangle {
        id: rowMaxTemperature1
        x: 950
        y: 140
        width: 210
        height: 43
    color: "#161616"
        Text {
            id: txtMaxTCap1
            y: 0
            width: 100
            height: 43
            color: "#ffffff"
            text: qsTr("kwh")
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            anchors.leftMargin: 0
            verticalAlignment: Text.AlignVCenter
            MouseArea {
                width: 70
                height: 40
                anchors.leftMargin: 0
                anchors.topMargin: 2
                anchors.top: parent.top
                anchors.left: parent.left
                hoverEnabled: false
            }
            font.pixelSize: 25
            anchors.verticalCenterOffset: 0
        }

        Rectangle {
            id: recGpsLatitude1
            y: 379
            width: 100
            height: 43
            color: "#000000"
            radius: 10
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 100
            Text {
                id: txtChargingKwh
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("0")
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 25
            }
        }
    }

    Rectangle {
        id: rowMaxVoltage1
        x: 880
        y: 33
        width: 210
        height: 43
    color: "#161616"
        Text {
            id: txtMaxVoltCap1
            y: 0
            width: 100
            height: 43
            color: "#ffffff"
            text: qsTr("SOC%")
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            anchors.leftMargin: 0
            verticalAlignment: Text.AlignVCenter
            MouseArea {
                width: 70
                height: 40
                anchors.top: parent.top
                anchors.left: parent.left
                hoverEnabled: false
            }
            font.pixelSize: 25
            anchors.verticalCenterOffset: 0
        }

        Rectangle {
            id: recSOCReading
            y: 380
            width: 100
            height: 43
            color: "#000000"
            radius: 10
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 100
            Text {
                id: txtSOCReading
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("0")
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 25
            }
        }
    }

    Text {
        id: txtTotalVoltage
        y: 0
        width: 70
        height: 30
        color: "#ffffff"
        text: qsTr("")
        anchors.verticalCenterOffset: -54
        anchors.horizontalCenterOffset: -440
        verticalAlignment: Text.AlignVCenter
        anchors.horizontalCenter: parent.horizontalCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 20
        anchors.verticalCenter: parent.verticalCenter
    }

    Text {
        id: txtTotalCurrent
        x: -9
        y: -8
        width: 70
        height: 30
        color: "#ffffff"
        text: qsTr("")
        verticalAlignment: Text.AlignVCenter
        anchors.horizontalCenter: parent.horizontalCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.verticalCenterOffset: -13
        font.pixelSize: 20
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: -440
    }
}



































































































/*##^## Designer {
    D{i:4;anchors_y:0}D{i:16;anchors_y:253}D{i:26;anchors_x:2}D{i:29;anchors_x:50}D{i:62;anchors_width:300;anchors_y:200}
D{i:72;anchors_width:300;anchors_y:200}D{i:77;anchors_width:300;anchors_y:200}D{i:87;anchors_width:300;anchors_y:200}
D{i:92;anchors_width:100}D{i:94;anchors_width:210}
}
 ##^##*/
