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
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.1
import QtQuick.Extras 1.4
import "../style"

Window {
    id: traction

    // ( https://goo.gl/LWbdMG )
    objectName: "tractionWindow"
    Styles { id: style }

    // QML - main window position on start (screen center)
    // ( https://goo.gl/wLpvZD )
    width: style.resolutionWidth // application wide properties
    height: style.resolutionHeight
    x: 0
    y: 0
    maximumHeight: height
    maximumWidth: width
    minimumHeight: height
    minimumWidth: width
    color: "#161616"
    property alias window: traction
    flags: Qt.FramelessWindowHint
    title: "Traction"

    // Property names must begin with a lower case letter
    // and can only contain letters ( https://goo.gl/HzLQet )
    //
    signal qmlSignalActive(string msg)
    signal qmlSignalReset(string msg)

    function updateBMS_VCU_MSG01(s_voltage,s_current,soc,b_status,
    f_level,mcntctr_nc,mcntctr_st,pcell_alrm,s_cremains) {
    //console.debug("v "+s_voltage+" a "+s_current+" soc "+soc
    //    +" b "+b_status+" fl "+f_level+" mctn "+mcntctr_nc
    //    +" mcts "+mcntctr_st+" pcal "+pcell_alrm
    //    +" crmn "+s_cremains);
    txtMainVoltageVal.text = s_voltage;
    }

    function updateMsg_VCU_IOSIG_MSG(
    mctactor, p3keyon, p4Start, hv_ctr, pc_ctr) {
    // console.debug("updateMsg_VCU_IOSIG_MSG "+mctactor+", "
    // +p3keyon+", "+p4Start+", "+hv_ctr+", "+pc_ctr);
    if ( 1 === mctactor ) {
        imgHVPC.source = "../../images/0-color/hvpc_fb_on.png";
    }
    else {
        imgHVPC.source = "../../images/0-color/hvpc_fb_off.png";
    }
    }

    function updateMsg_PCUIO_SIG00_Byte0(pedal, brake, pbrake, clutch,
    rgbrake, emgstop, wpump, coolingf) {
    //console.debug("updateMsg_PCUIO_SIG00_Byte0");
    siAccelPedal.active = (pedal === 1)?true:false;
    siEmgStop.active = (emgstop === 1)?true:false;
    siFootBrake.active = (brake === 1)?true:false;
    siParkingBrake.active = (pbrake === 1)?true:false;
    siClutchPedal.active = (clutch === 1)?true:false;
    siRegenBrake.active = (rgbrake === 1)?true:false;
    if ( 1 === wpump ) {
        imgPump.source = "../../images/0-color/pump_on.png";
    }
    else {
        imgPump.source = "../../images/0-color/pump_off.png";
    }
    if ( 1 === coolingf ) {
        imgFan.source = "../../images/0-color/fan_on.png";
    }
    else {
        imgFan.source = "../../images/0-color/fan_off.png";
    }
    }

    function updateMsg_PCUIO_SIG00_Byte2To7(dlta, inlet_t, outlet_t,
    pedal_depth, pcu_lc) {
    //console.debug("updateMsg_PCUIO_SIG00_Byte2To7");
    // TODO: dlta
    txtInletTempVal.text  = inlet_t;
    txtOutletTempVal.text = outlet_t;
    txtAccelPedalVal.text = pedal_depth;
    }

    function updateMsg_PCU_ST_SYS_1(run, fault, warning) {
    if ( 1 === fault ) {
        imgPA.source = "../../images/0-color/pa_red.png";
    }
    else {
        if ( 1 === warning ) {
        imgPA.source = "../../images/0-color/pa_yellow.png";
        }
        else {
        if ( 1 === run )
            imgPA.source = "../../images/0-color/pa_green.png";
        else
            imgPA.source = "../../images/0-color/pa_grey.png";
        }
    }
    }

    function updateMsg_PCU_ST_SYS_2(temp) {
    txtMotorTempVal.text = temp;
    }

    function updateMsg_PCU_ST_SYS_3(i_code0, i_code1) {
    txtErrorCode0.text = i_code0;
    txtErrorCode1.text = i_code1;
    }

    function updateMsg_PCU_ST_SYS_4(i_code2) {
    txtErrorCode2.text = i_code2;
    //console.debug("updateMsg_PCU_ST_SYS_4");
    }

    function updateMsg_PCU_ST_MOT_1(s_rpm, s_torq, s_dclv, s_mechpwr) {
    // console.debug("updateMsg_PCU_ST_MOT_1 "+s_rpm+", "
         //+s_torq+", "+s_dclv+", "+s_mechpwr);
     txtRPMVal.text = s_rpm;
     txtTorqueVal.text = s_torq;
     txtRunningVoltageVal.text = s_dclv;

    }

    function updateMsg_PCU_ST_MOT_2( s_dclink_current, i_mtrun_status,
    i_fault_status, i_mtready, i_mtref ) {
    txtCurrentVal.text = s_dclink_current;
    if ( 1 === i_fault_status ) {
        imgMT.source = "../../images/0-color/mt_red_vstroke.png";
    }
    else {
        if ( 1 === i_mtrun_status ) {
        imgMT.source = "../../images/0-color/mt_green_vstroke.png";
        }
        else {
        imgMT.source = "../../images/0-color/mt_grey_vstroke.png";
        }
    }
    }

    function updateMsg_PCU_ST_MOT_3(temp1, temp2) {
    //console.debug("updateMsg_PCU_ST_MOT_3 "+temp1+", "+temp2);
    }

    function updateMsg_PCU_CMD_SYS_1(cmd_enable) {
    //console.debug("updateMsg_PCU_CMD_SYS_1 "+cmd_enable);
    }

    function updateMsg_PCU_CMD_MOT_1(ctrl_mode, mtrun_cmd) {
    //console.debug("updateMsg_PCU_CMD_MOT_1 "+ctrl_mode+", "+mtrun_cmd);
    txtControlModeVal.text = ctrl_mode;
    txtMotorRunCmdVal.text = mtrun_cmd;
    }

    function updateMsg_PCU_CMD_MOT_2(s_rpm_ref, s_torq_ref, s_dclv_ref, s_mtpwr_ref) {
    //console.debug("updateMsg_PCU_CMD_MOT_2");
    txtRPMrefVal.text = s_rpm_ref;
    txtTorqueRefVal.text = s_torq_ref;
    txtDcLinkVoltRefVal.text = s_dclv_ref;
    txtMotorPwrRefVal.text = s_mtpwr_ref;
    }

    function updateMsg_PCU_CMD_MOT_3(s_freq_ref, s_reactive_pwr_ref) {
    txtFreqRefVal.text = s_freq_ref;
    txtReactivePwrRefVal.text = s_reactive_pwr_ref;
    //console.debug("updateMsg_PCU_CMD_MOT_3");
    }

    function updateMsg_VCU_DIAG01(main_dvr_rt, main_mt_rt, penumatic_dvr_rt, penumatic_mt_rt) {
    txtDriverRunTimeVal.text = main_dvr_rt;
    txtMotorRunTimeVal.text = main_mt_rt;
    //console.debug("updateMsg_VCU_DIAG01 ");
    }

    function updateMsg_VCU_DIAG02(hyd_rt, hym_rt, ap_buildup_time) {
    //console.debug("updateMsg_VCU_DIAG02 "+ap_buildup_time);
    // TODO: check if to change PA symbol as well
    }

    function updateMsg_VCU_DMRT_CLR(s_bcu_alarm_lcounter) {
    //txtLcBal93.text = s_bcu_alarm_lcounter;
    //console.debug("updateMsg_VCU_DMRT_CLR");
    }

    Rectangle {
        id: rectangleEng

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
        engineering.hide();
        }
    }
    }

    Image {
        id: imageTractionBack
        x: 0
        width: style.backWidth
        height: style.backHeight
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.topMargin: 0
        z: 1
        anchors.top: parent.top
        source: "../../images/0-color/HMI-ICON-55.png"
        fillMode: Image.PreserveAspectFit
    MouseArea {
        id: mouseAreaStatusBack
        z: 2
        anchors.fill: parent
        onClicked: {
        traction.hide();
        }
    }
    }

    Rectangle {
        id: rowTraction
        x: 200
        y: 30
        width: 300
        height: 43
        color: "#161616"
        anchors.leftMargin: 50
        Text {
            id: txtTractionWinCaption
            y: 0
            width: 100
            height: 43
            color: "#ffffff"
            text: qsTr("Traction System")
            renderType: Text.NativeRendering
            lineHeight: 0.8
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 25
            horizontalAlignment: Text.AlignLeft
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            MouseArea {
                width: 70
                height: 40
                hoverEnabled: false
                anchors.top: parent.top
                anchors.left: parent.left
            }
            anchors.left: parent.left
            anchors.verticalCenterOffset: 0
        }
        //anchors.top: rowTop.bottom
        anchors.topMargin: 200
        anchors.left: parent.left
    }

    Rectangle {
        id: recAccelPedal
        x: 202
        y: 430
        width: 300
        height: 30
        color: "#161616"
        anchors.leftMargin: 50
        Text {
            id: txtAccelPedal
            y: 0
            width: 120
            height: 20
            color: "#ffffff"
            text: "Accel. Pedal"
            lineHeight: 0.9
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 20
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 20
            horizontalAlignment: Text.AlignLeft
            anchors.left: siAccelPedal.right
        }

        StatusIndicator {
            id: siAccelPedal
            y: 87
            width: 20
            height: 20
            color: "#ffffff"
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            active: false
            anchors.leftMargin: 0
        }

        Rectangle {
            id: recAccelPedalVal
            y: 379
            width: 80
            height: 25
            color: "#000000"
            radius: 10
            anchors.left: txtAccelPedal.right
            Text {
                id: txtAccelPedalVal
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
            }
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
        }
        anchors.topMargin: 10
        anchors.top: rowInput.bottom
        anchors.left: parent.left
    }

    Rectangle {
        id: recEmgStop
        x: 192
        y: -8
        width: 300
        height: 30
        color: "#161616"
        anchors.left: parent.left
        anchors.topMargin: 5
        Text {
            id: txtEmgStop
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "EMG. Stop"
            anchors.left: siEmgStop.right
            font.pixelSize: 20
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
        }

        StatusIndicator {
            id: siEmgStop
            y: 87
            width: 20
            height: 20
            color: "#ff0000"
            anchors.left: parent.left
            active: false
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
        }
        anchors.top: recAccelPedal.bottom
        anchors.leftMargin: 50
    }

    Rectangle {
        id: recFootBrake
        x: 204
        y: 7
        width: 300
        height: 30
        color: "#161616"
        anchors.left: parent.left
        anchors.topMargin: 5
        Text {
            id: txtFootBrake
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Foot Brake"
            anchors.left: siFootBrake.right
            font.pixelSize: 20
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
        }

        StatusIndicator {
            id: siFootBrake
            y: 87
            width: 20
            height: 20
            color: "#ffffff"
            anchors.left: parent.left
            active: false
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
        }
        anchors.top: recEmgStop.bottom
        anchors.leftMargin: 50
    }

    Rectangle {
        id: recParkingBrake
        x: 213
        y: 0
        width: 300
        height: 30
        color: "#161616"
        anchors.left: parent.left
        anchors.topMargin: 5
        Text {
            id: txtParkingBrake
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Parking Brake"
            anchors.left: siParkingBrake.right
            font.pixelSize: 20
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
        }

        StatusIndicator {
            id: siParkingBrake
            y: 87
            width: 20
            height: 20
            color: "#ffffff"
            anchors.left: parent.left
            active: false
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
        }
        anchors.top: recFootBrake.bottom
        anchors.leftMargin: 50
    }

    Rectangle {
        id: recClutchPedal
        x: 213
        y: -2
        width: 300
        height: 30
        color: "#161616"
        anchors.left: parent.left
        anchors.topMargin: 5
        Text {
            id: txtClutchPedal
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Clutch Pedal"
            anchors.left: siClutchPedal.right
            font.pixelSize: 20
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
        }

        StatusIndicator {
            id: siClutchPedal
            y: 87
            width: 20
            height: 20
            color: "#ffffff"
            anchors.left: parent.left
            active: false
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
        }
        anchors.top: recParkingBrake.bottom
        anchors.leftMargin: 50
    }

    Rectangle {
        id: recRegenBrake
        x: 208
        y: 2
        width: 300
        height: 30
        color: "#161616"
        anchors.left: parent.left
        anchors.topMargin: 5
        Text {
            id: txtRegenBrake
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Regenerative Brake"
            anchors.left: siRegenBrake.right
            font.pixelSize: 20
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
        }

        StatusIndicator {
            id: siRegenBrake
            y: 87
            width: 20
            height: 20
            color: "#ffffff"
            anchors.left: parent.left
            active: false
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
        }
        anchors.top: recClutchPedal.bottom
        anchors.leftMargin: 50
    }

    Rectangle {
        id: rowDriverRunTime
        x: 202
        width: 450
        height: 40
        color: "#161616"
        anchors.top: rowTraction.bottom
        anchors.left: parent.left
        anchors.topMargin: 10
        Text {
            id: txtDriverRunTimeCap
            y: 0
            width: 180
            height: 25
            color: "#ffffff"
            text: qsTr("Driver Run Time :")
            anchors.left: parent.left
            font.pixelSize: 20
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 0
        }

        Rectangle {
            id: recDriverRunTimeVal
            y: 379
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            anchors.left: txtDriverRunTimeCap.right
            Text {
                id: txtDriverRunTimeVal
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
            }
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
        }

        Button {
            id: btnDriverRunTimeReset
            x: 1
            y: 1
            height: 40
            text: qsTr("RESET")
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: recDriverRunTimeVal.right
            anchors.leftMargin: 10
            onClicked: {
                //console.debug("drv rt");
        traction.qmlSignalReset("DRVRT");
            }
            style: ButtonStyle {
                background: Rectangle {
                    radius: 4
                    gradient: Gradient {
                        GradientStop {
                            position: 0
                            color: control.pressed ? "#ccc" : "#eee"
                        }

                        GradientStop {
                            position: 1
                            color: control.pressed ? "#aaa" : "#ccc"
                        }
                    }
                    implicitHeight: 43
                    border.width: control.activeFocus ? 2 : 1
                    border.color: "#888888"
                    implicitWidth: 100
                }
            }
        }
        anchors.leftMargin: 50
    }

    Rectangle {
        id: rowInput
        y: 420
        width: 300
        height: 40
        color: "#161616"
        anchors.left: parent.left
        anchors.leftMargin: 50
        anchors.topMargin: 200
        Text {
            id: txtInput
            y: 0
            width: 100
            height: 25
            color: "#ffffff"
            text: qsTr("Input :")
            anchors.left: parent.left
            font.pixelSize: 20
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 0
        }
    }

    Rectangle {
        id: rowMotorRunTime
        x: 208
        y: 1
        width: 450
        height: 40
        color: "#161616"
        anchors.left: parent.left
        anchors.topMargin: 10
        Text {
            id: txtMotorRunTimeCap
            y: 0
            width: 180
            height: 25
            color: "#ffffff"
            text: qsTr("Motor Run Time :")
            anchors.left: parent.left
            font.pixelSize: 20
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 0
        }

        Rectangle {
            id: recMotorRunTimeVal
            y: 379
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            anchors.left: txtMotorRunTimeCap.right
            Text {
                id: txtMotorRunTimeVal
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
            }
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
        }

        Button {
            id: btnMotorRunTimeReset
            x: 1
            y: 1
            height: 40
            text: qsTr("RESET")
            anchors.left: recMotorRunTimeVal.right
            anchors.leftMargin: 10
            onClicked: {
                //console.debug("rst mtrt");
        traction.qmlSignalReset("MTRTime");
            }
            style: ButtonStyle {
                background: Rectangle {
                    radius: 4
                    gradient: Gradient {
                        GradientStop {
                            position: 0
                            color: control.pressed ? "#ccc" : "#eee"
                        }

                        GradientStop {
                            position: 1
                            color: control.pressed ? "#aaa" : "#ccc"
                        }
                    }
                    implicitHeight: 43
                    border.width: control.activeFocus ? 2 : 1
                    border.color: "#888888"
                    implicitWidth: 100
                }
            }
            anchors.verticalCenter: parent.verticalCenter
        }
        anchors.top: rowDriverRunTime.bottom
        anchors.leftMargin: 50
    }

    Rectangle {
        id: rowMotorTemp
        x: 208
        y: 8
        width: 450
        height: 40
        color: "#161616"
        anchors.left: parent.left
        anchors.topMargin: 10
        Text {
            id: txtMotorTempCap
            y: 0
            width: 180
            height: 25
            color: "#ffffff"
            text: qsTr("Motor Temp. :")
            anchors.left: parent.left
            font.pixelSize: 20
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 0
        }

        Rectangle {
            id: recMotorTempVal
            y: 379
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            anchors.left: txtMotorTempCap.right
            Text {
                id: txtMotorTempVal
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
            }
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: txtMotorTempSuffix
            y: 383
            width: 30
            height: 40
            color: "#ffffff"
            text: qsTr("℃")
            font.bold: true
            anchors.left: recMotorTempVal.right
            font.pixelSize: 20
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Courier"
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
        }
        anchors.top: rowMotorRunTime.bottom
        anchors.leftMargin: 50
    }

    Rectangle {
        id: rowErrorCode
        x: 217
        y: 3
        width: 630
        height: 40
        color: "#161616"
        anchors.left: parent.left
        anchors.topMargin: 10
        Text {
            id: txtErrorCodeCap
            y: 0
            width: 180
            height: 25
            color: "#ffffff"
            text: qsTr("Error Code :")
            renderType: Text.NativeRendering
            anchors.left: parent.left
            font.pixelSize: 20
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 0
        }

        Rectangle {
            id: recErrorCode0
            y: 379
            width: 140
            height: 25
            color: "#000000"
            radius: 10
            anchors.left: txtErrorCodeCap.right
            Text {
                id: txtErrorCode0
                y: 0
                width: 130
                height: 25
                color: "#ffffff"
                text: qsTr("")
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
            }
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
        }

        Rectangle {
            id: recErrorCode1
            x: -1
            y: 386
            width: 140
            height: 25
            color: "#000000"
            radius: 10
            anchors.left: recErrorCode0.right
            Text {
                id: txtErrorCode1
                y: 0
                width: 130
                height: 25
                color: "#ffffff"
                text: qsTr("")
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
            }
            anchors.leftMargin: 5
            anchors.verticalCenter: parent.verticalCenter
        }

        Rectangle {
            id: recErrorCode2
            y: 394
            width: 140
            height: 25
            color: "#000000"
            radius: 10
            anchors.left: recErrorCode1.right
            Text {
                id: txtErrorCode2
                y: 0
                width: 130
                height: 25
                color: "#ffffff"
                text: qsTr("")
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
            }
            anchors.leftMargin: 5
            anchors.verticalCenter: parent.verticalCenter
        }
        anchors.top: rowMotorTemp.bottom
        anchors.leftMargin: 50
    }

    Rectangle {
        id: rowMainVoltage
        x: 203
        width: 300
        height: 40
        color: "#161616"
        z: 2
        anchors.left: parent.left
        anchors.topMargin: 10
        Text {
            id: txtMainVoltage
            y: 0
            width: 162
            height: 25
            color: "#ffffff"
            text: qsTr("Main Voltage :")
            anchors.left: parent.left
            font.pixelSize: 20
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 0
        }

        Rectangle {
            id: recMainVoltageVal
            y: 379
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            anchors.left: txtMainVoltage.right
            Text {
                id: txtMainVoltageVal
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
            }
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: txtMainVoltageSuffix
            y: -3
            width: 20
            height: 25
            color: "#ffffff"
            text: qsTr("V")
            anchors.left: recMainVoltageVal.right
            anchors.leftMargin: 5
            font.pixelSize: 20
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
        }
        anchors.top: rowDriverRunTime.bottom
        anchors.leftMargin: 680
    }

    Rectangle {
        id: rowOutput
        x: 0
        y: 420
        width: 300
        height: 40
        color: "#161616"
        anchors.left: rowInput.right
        anchors.topMargin: 200
        Text {
            id: txtOutput
            y: 0
            width: 100
            height: 25
            color: "#ffffff"
            text: qsTr("Output :")
            anchors.left: parent.left
            font.pixelSize: 20
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 0
        }
        anchors.leftMargin: 20
    }

    Rectangle {
        id: rowControlMode
        x: 213
        width: 450
        height: 30
        color: "#161616"
        anchors.left: rowInput.right
        anchors.topMargin: 10
        Text {
            id: txtControlModeCap
            y: 0
            width: 210
            height: 25
            color: "#ffffff"
            text: qsTr("Control Mode :")
            anchors.left: parent.left
            font.pixelSize: 20
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 0
        }

        Rectangle {
            id: recControlModeVal
            y: 379
            width: 220
            height: 25
            color: "#000000"
            radius: 10
            anchors.left: txtControlModeCap.right
            Text {
                id: txtControlModeVal
                y: 0
                width: 210
                height: 25
                color: "#ffffff"
                text: qsTr("")
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
            }
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
        }
        anchors.top: rowOutput.bottom
        anchors.leftMargin: 20
    }

    Rectangle {
        id: rowMotorRunCmd
        x: 213
        width: 450
        height: 30
        color: "#161616"
        anchors.left: rowInput.right
        anchors.topMargin: 5
        Text {
            id: txtMotorRunCmdCap
            y: 0
            width: 210
            height: 25
            color: "#ffffff"
            text: qsTr("Motor Run Cmd. :")
            anchors.left: parent.left
            font.pixelSize: 20
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 0
        }

        Rectangle {
            id: recMotorRunCmdVal
            y: 379
            width: 150
            height: 25
            color: "#000000"
            radius: 10
            anchors.left: txtMotorRunCmdCap.right
            Text {
                id: txtMotorRunCmdVal
                y: 0
                width: 140
                height: 25
                color: "#ffffff"
                text: qsTr("")
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
            }
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
        }
        anchors.top: rowControlMode.bottom
        anchors.leftMargin: 20
    }

    Rectangle {
        id: rowRPMref
        x: 204
        width: 450
        height: 30
        color: "#161616"
        anchors.left: rowInput.right
        anchors.topMargin: 5
        Text {
            id: txtRPMrefCap
            y: 0
            width: 210
            height: 25
            color: "#ffffff"
            text: qsTr("RPM ref. :")
            anchors.left: parent.left
            font.pixelSize: 20
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 0
        }

        Rectangle {
            id: recRPMrefVal
            y: 379
            width: 150
            height: 25
            color: "#000000"
            radius: 10
            anchors.left: txtRPMrefCap.right
            Text {
                id: txtRPMrefVal
                y: 0
                width: 140
                height: 25
                color: "#ffffff"
                text: qsTr("")
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
            }
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: txtRPMSuffix1
            y: -3
            width: 40
            height: 25
            color: "#ffffff"
            text: qsTr("rpm")
            anchors.left: recRPMrefVal.right
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.leftMargin: 10
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 20
        }
        anchors.top: rowMotorRunCmd.bottom
        anchors.leftMargin: 20
    }

    Rectangle {
        id: rowDCLinkVoltRef
        x: 204
        y: -9
        width: 450
        height: 30
        color: "#161616"
        anchors.top: rowTorqueRef.bottom
        anchors.left: rowInput.right
        anchors.topMargin: 5
        anchors.leftMargin: 20
        Text {
            id: txtDcLinkVoltRef
            y: 0
            width: 210
            height: 25
            color: "#ffffff"
            text: qsTr("DC Link Volt. ref. :")
            anchors.verticalCenterOffset: 0
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            anchors.leftMargin: 0
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 20
        }

        Rectangle {
            id: recDcLinkVoltRefVal
            y: 379
            width: 150
            height: 25
            color: "#000000"
            radius: 10
            anchors.left: txtDcLinkVoltRef.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 10
            Text {
                id: txtDcLinkVoltRefVal
                y: 0
                width: 140
                height: 25
                color: "#ffffff"
                text: qsTr("")
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 20
            }
        }

        Text {
            id: txtRunningVoltageSuffix2
            y: -3
            width: 20
            height: 25
            color: "#ffffff"
            text: qsTr("V")
            anchors.left: recDcLinkVoltRefVal.right
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.leftMargin: 10
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 20
        }
    }

    Rectangle {
        id: rowMotorPwrRef
        x: 204
        y: -9
        width: 450
        height: 30
        color: "#161616"
        anchors.top: rowDCLinkVoltRef.bottom
        anchors.left: rowInput.right
        anchors.topMargin: 5
        anchors.leftMargin: 20
        Text {
            id: txtMotorPwrRef
            y: 0
            width: 210
            height: 25
            color: "#ffffff"
            text: qsTr("Motor Power ref. :")
            anchors.verticalCenterOffset: 0
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            anchors.leftMargin: 0
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 20
        }

        Rectangle {
            id: recMotorPwrRefVal
            y: 379
            width: 150
            height: 25
            color: "#000000"
            radius: 10
            anchors.left: txtMotorPwrRef.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 10
            Text {
                id: txtMotorPwrRefVal
                y: 0
                width: 140
                height: 25
                color: "#ffffff"
                text: qsTr("")
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 20
            }
        }

        Text {
            id: txtRunningVoltageSuffix3
            y: -3
            width: 30
            height: 25
            color: "#ffffff"
            text: qsTr("KW")
            anchors.left: recMotorPwrRefVal.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 10
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 20
        }
    }

    Rectangle {
        id: rowTorqueRef
        x: 450
        y: 583
        width: 450
        height: 30
        color: "#161616"
        anchors.top: rowRPMref.bottom
        anchors.left: rowInput.right
        anchors.topMargin: 5
        anchors.leftMargin: 20
        Text {
            id: txtTorqueRefCap
            y: 0
            width: 210
            height: 25
            color: "#ffffff"
            text: qsTr("Torque ref. :")
            anchors.verticalCenterOffset: 0
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 20
        }

        Rectangle {
            id: recTorqueRefVal
            y: 379
            width: 150
            height: 25
            color: "#000000"
            radius: 10
            anchors.left: txtTorqueRefCap.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 10
            Text {
                id: txtTorqueRefVal
                y: 0
                width: 140
                height: 25
                color: "#ffffff"
                text: qsTr("")
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 20
            }
        }

        Text {
            id: txtTorqueSuffix1
            y: -3
            width: 35
            height: 25
            color: "#ffffff"
            text: qsTr("Nm")
            anchors.left: recTorqueRefVal.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 10
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 20
        }
    }

    Rectangle {
        id: rowFreqRef
        x: 211
        y: 0
        width: 450
        height: 30
        color: "#161616"
        anchors.top: rowMotorPwrRef.bottom
        anchors.left: rowInput.right
        anchors.topMargin: 5
        anchors.leftMargin: 20
        Text {
            id: txtFreqRefCap
            y: 0
            width: 210
            height: 25
            color: "#ffffff"
            text: qsTr("Frequency ref. :")
            anchors.verticalCenterOffset: 0
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 20
        }

        Rectangle {
            id: recFreqRefVal
            y: 379
            width: 150
            height: 25
            color: "#000000"
            radius: 10
            anchors.left: txtFreqRefCap.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 10
            Text {
                id: txtFreqRefVal
                y: 0
                width: 140
                height: 25
                color: "#ffffff"
                text: qsTr("")
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 20
            }
        }

        Text {
            id: txtRunningVoltageSuffix8
            y: -3
            width: 30
            height: 25
            color: "#ffffff"
            text: qsTr("Hz")
            anchors.left: recFreqRefVal.right
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.leftMargin: 10
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 20
        }
    }

    Rectangle {
        id: rowReactivePwrRef
        x: 204
        width: 450
        height: 30
        color: "#161616"
        anchors.top: rowFreqRef.bottom
        anchors.left: rowInput.right
        anchors.topMargin: 5
        anchors.leftMargin: 20
        Text {
            id: txtReactivePwrRefCap
            y: 0
            width: 210
            height: 25
            color: "#ffffff"
            text: qsTr("Reactive Power ref. :")
            anchors.verticalCenterOffset: 0
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            anchors.leftMargin: 0
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 20
        }

        Rectangle {
            id: recReactivePwrRefVal
            y: 379
            width: 150
            height: 25
            color: "#000000"
            radius: 10
            anchors.left: txtReactivePwrRefCap.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 10
            Text {
                id: txtReactivePwrRefVal
                y: 0
                width: 140
                height: 25
                color: "#ffffff"
                text: qsTr("")
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 20
            }
        }

        Text {
            id: txtRunningVoltageSuffix9
            y: -3
            width: 50
            height: 25
            color: "#ffffff"
            text: qsTr("kVAr")
            anchors.left: recReactivePwrRefVal.right
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.leftMargin: 10
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 20
        }
    }

    Rectangle {
        id: rowInletTemp
        x: 205
        y: 260
        width: 270
        height: 40
        color: "#161616"
        z: 4
        anchors.left: rowInput.right
        anchors.leftMargin: 600
        Text {
            id: txtInletTempCap
            y: 0
            width: 130
            height: 25
            color: "#ffffff"
            text: qsTr("Inlet Temp. :")
            anchors.verticalCenterOffset: 0
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            anchors.leftMargin: 0
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 20
        }

        Rectangle {
            id: recInletTempVal
            y: 379
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            anchors.left: txtInletTempCap.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            Text {
                id: txtInletTempVal
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 20
            }
        }

        Text {
            id: txtInletTempSuffix
            y: 383
            width: 30
            height: 40
            color: "#ffffff"
            text: qsTr("℃")
            anchors.left: recInletTempVal.right
            anchors.verticalCenter: parent.verticalCenter
            font.family: "Courier"
            horizontalAlignment: Text.AlignHCenter
            anchors.leftMargin: 10
            verticalAlignment: Text.AlignVCenter
            font.bold: true
            font.pixelSize: 20
        }
    }

    Rectangle {
        id: rowOutletTemp
        y: 400
        width: 270
        height: 40
        color: "#161616"
        z: 3
        anchors.left: rowInput.right
        anchors.leftMargin: 600
        Text {
            id: txtOutletTempCap
            y: 0
            width: 130
            height: 25
            color: "#ffffff"
            text: qsTr("Outlet Temp. :")
            anchors.verticalCenterOffset: 0
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 20
        }

        Rectangle {
            id: recOutletTempVal
            y: 379
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            anchors.left: txtOutletTempCap.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            Text {
                id: txtOutletTempVal
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 20
            }
        }

        Text {
            id: txtMotorTempSuffix2
            y: 383
            width: 30
            height: 40
            color: "#ffffff"
            text: qsTr("℃")
            anchors.left: recOutletTempVal.right
            anchors.verticalCenter: parent.verticalCenter
            font.family: "Courier"
            anchors.leftMargin: 10
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.bold: true
            font.pixelSize: 20
        }
    }

    Rectangle {
        id: rowRunningState
        x: 1
        y: 550
        width: 300
        height: 40
        color: "#161616"
        anchors.left: rowInput.right
        anchors.topMargin: 200
        anchors.leftMargin: 600
        Text {
            id: txtRunningState
            y: 0
            width: 100
            height: 25
            color: "#ffffff"
            text: qsTr("Running State :")
            anchors.verticalCenterOffset: 0
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            anchors.leftMargin: 0
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 20
        }
    }

    Rectangle {
        id: rowRunningVoltage
        x: 214
        y: 1
        width: 300
        height: 30
        color: "#161616"
        anchors.top: rowRunningState.bottom
        anchors.left: rowInput.right
        anchors.topMargin: 10
        anchors.leftMargin: 600
        Text {
            id: txtRunningVoltageCap
            y: 0
            width: 120
            height: 25
            color: "#ffffff"
            text: qsTr("Voltage :")
            anchors.verticalCenterOffset: 0
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            anchors.leftMargin: 0
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 20
        }

        Rectangle {
            id: recRunningVoltageVal
            y: 379
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            anchors.left: txtRunningVoltageCap.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            Text {
                id: txtRunningVoltageVal
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 20
            }
        }

        Text {
            id: txtRunningVoltageSuffix
            y: -3
            width: 20
            height: 25
            color: "#ffffff"
            text: qsTr("V")
            anchors.left: recRunningVoltageVal.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 5
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 20
        }
    }

    Rectangle {
        id: rowCurrent
        x: 214
        y: 1
        width: 300
        height: 30
        color: "#161616"
        anchors.top: rowRunningVoltage.bottom
        anchors.left: rowInput.right
        anchors.topMargin: 10
        anchors.leftMargin: 600
        Text {
            id: txtMotorRunCmdCap4
            y: 0
            width: 120
            height: 25
            color: "#ffffff"
            text: qsTr("Current :")
            anchors.verticalCenterOffset: 0
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            anchors.leftMargin: 0
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 20
        }

        Rectangle {
            id: recCurrentVal
            y: 379
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            anchors.left: txtMotorRunCmdCap4.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            Text {
                id: txtCurrentVal
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 20
            }
        }

        Text {
            id: txtRunningVoltageSuffix1
            y: -3
            width: 20
            height: 25
            color: "#ffffff"
            text: qsTr("A")
            anchors.left: recCurrentVal.right
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.leftMargin: 5
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 20
        }
    }

    Rectangle {
        id: rowRPM
        x: 205
        y: 1
        width: 300
        height: 30
        color: "#161616"
        anchors.top: rowCurrent.bottom
        anchors.left: rowInput.right
        anchors.topMargin: 5
        anchors.leftMargin: 600
        Text {
            id: txtRPMCap
            y: 0
            width: 120
            height: 25
            color: "#ffffff"
            text: qsTr("RPM :")
            anchors.verticalCenterOffset: 0
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            anchors.leftMargin: 0
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 20
        }

        Rectangle {
            id: recRPMVal
            y: 379
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            anchors.left: txtRPMCap.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            Text {
                id: txtRPMVal
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 20
            }
        }

        Text {
            id: txtRPMSuffix
            y: -3
            width: 40
            height: 25
            color: "#ffffff"
            text: qsTr("rpm")
            anchors.left: recRPMVal.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 5
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 20
        }
    }

    Rectangle {
        id: rowTorque
        x: 906
        y: 584
        width: 300
        height: 30
        color: "#161616"
        anchors.top: rowRPM.bottom
        anchors.left: rowInput.right
        anchors.topMargin: 5
        anchors.leftMargin: 600
        Text {
            id: txtTorqueCap
            y: 0
            width: 120
            height: 25
            color: "#ffffff"
            text: qsTr("Torque :")
            anchors.verticalCenterOffset: 0
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            anchors.leftMargin: 0
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 20
        }

        Rectangle {
            id: recTorqueVal
            y: 379
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            anchors.left: txtTorqueCap.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            Text {
                id: txtTorqueVal
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 20
            }
        }

        Text {
            id: txtTorqueSuffix
            y: -3
            width: 35
            height: 25
            color: "#ffffff"
            text: qsTr("Nm")
            anchors.left: recTorqueVal.right
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.leftMargin: 5
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 20
        }
    }

    Rectangle {
        id: rowCueHorizontal
        x: 0
        y: 300
        width: style.resolutionWidth
        height: 100
        color: "#161616"
        anchors.topMargin: 200


        Image {
            id: imgPCU
            y: 50
            width: 100
            height: 100
            anchors.left: imgPcuIn.right
            anchors.leftMargin: 100
            anchors.verticalCenterOffset: 0
            anchors.verticalCenter: parent.verticalCenter
            fillMode: Image.PreserveAspectFit
            source: "../../images/0-color/pcu.png"
        }
        Image {
            id: imgPcuIn
            y: 10
            width: 100
            height: 100
            anchors.left: parent.left
            anchors.leftMargin: 100
            z: 2
            anchors.verticalCenter: parent.verticalCenter
            source: "../../images/0-color/input_2pcu.png"
            fillMode: Image.PreserveAspectFit
            sourceSize.width: 116
            sourceSize.height: 80
        }

        Image {
            id: imgPcuOut
            y: 50
            width: 200
            height: 100
            sourceSize.height: 86
            sourceSize.width: 235
            anchors.left: imgPCU.right
            anchors.leftMargin: 100
            anchors.verticalCenter: parent.verticalCenter
            fillMode: Image.PreserveAspectFit
            source: "../../images/0-color/pcu_output.png"
        }

        Image {
            id: imgPump
            y: 300
            width: 100
            height: 100
            anchors.left: imgPcuOut.right
            anchors.leftMargin: 280
            anchors.verticalCenter: parent.verticalCenter
            fillMode: Image.PreserveAspectFit
            source: "../../images/0-color/pump_off.png"
        }

        Image {
            id: imgFan
            y: 300
            width: 100
            height: 100
            anchors.left: imgPump.right
            anchors.leftMargin: 80
            anchors.verticalCenter: parent.verticalCenter
            fillMode: Image.PreserveAspectFit
            source: "../../images/0-color/fan_off.png"
        }
    }

    Rectangle {
        id: rowCueVertical
        x: 0
        y: 0
        width: 100
        height: 800
        color: "#161616"
        anchors.leftMargin: 840
        anchors.topMargin: 200
        anchors.left: parent.left

        Image {
            id: imgHVPC
            x: 590
            y: 190
            width: 100
            height: 100
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit
            source: "../../images/0-color/hvpc_fb_off.png"
        }

        Image {
            id: imgPA
            x: 139
            y: 0
            width: 100
            height: 100
            anchors.top: parent.top
            anchors.topMargin: 300
            anchors.horizontalCenter: parent.horizontalCenter
            source: "../../images/0-color/pa_grey.png"
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: imgMT
            x: 869
            width: 100
            height: 100
            anchors.top: imgPA.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit
            source: "../../images/0-color/mt_grey_vstroke.png"
        }
    }

    onActiveChanged : {
        if ( true === traction.active ) {
        traction.qmlSignalActive("Traction");
    }
    }

}



















/*##^## Designer {
    D{i:116;anchors_x:209}
}
 ##^##*/
