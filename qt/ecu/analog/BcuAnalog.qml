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

Window {
    id: bcuAnalog

    // ( https://goo.gl/LWbdMG )
    objectName: "bcuAnalogWindow"

    // QML - main window position on start (screen center)
    // ( https://goo.gl/wLpvZD )
    width: 1280
    height: 800
    maximumHeight: height
    maximumWidth: width
    x: (Screen.width - width) / 2
    y: (Screen.height - height) / 2

    minimumHeight: height
    minimumWidth: width
    color: "#161616"
    property alias window: bcuAnalog
    flags: Qt.FramelessWindowHint
    title: "BCU IO (Analog)"

    // Property names must begin with a lower case letter
    // and can only contain letters ( https://goo.gl/HzLQet )
    //
    //property string batteryPackName
    signal qmlSignal(string msg)
    signal qmlSignalActive(string msg)

    function updateMsg_BCU_VCU_SMD_Byte0(ds1,ds2,ds3,ds4,ds5,ds6) {
    siDetectSmoke1.active = ( ds1 == 1 )?true:false;
    siDetectSmoke2.active = ( ds2 == 1 )?true:false;
    siDetectSmoke3.active = ( ds3 == 1 )?true:false;
    siDetectSmoke4.active = ( ds4 == 1 )?true:false;
    siDetectSmoke5.active = ( ds5 == 1 )?true:false;
    siDetectSmoke6.active = ( ds6 == 1 )?true:false;
    }

    function updateMsg_BCU_VCU_MSG0(abs_alarm, fl_lining, fr_lining,
    rl_lining, rr_lining, ecas33f, ecas_kneeling, ecas34w,
    s_bcu2vcu_lcounter) {
    txtCode.text = s_bcu2vcu_lcounter;
    }

    function updateMsg_BCU_VCU_MSG0_Byte0(f_openfdoor, f_openbdoor,
	emgdoor_s, fdo_sensor, bdo_sensor, edl_fb, do_signal,
	collision_s1 ) {
	siForceOpenFrontDoor.active = ( f_openfdoor == 1 )?true:false;
	siForceOpenBackDoor.active = ( f_openbdoor == 1 )?true:false;
	siEmergencyDoorSwitch.active = ( emgdoor_s == 1 )?true:false;
	siFrontDoorOpenSensor.active = ( fdo_sensor == 1 )?true:false;
	siBackDoorOpenSensor.active = ( bdo_sensor == 1 )?true:false;
	siEMGDoorLockFeedback.active = ( edl_fb == 1 )?true:false;
	siTheDoorOpenSignal.active = ( do_signal == 1 )?true:false;
	siCollisionSensor1.active = ( collision_s1 == 1 )?true:false;
    }

    function updateMsg_BCU_VCU_MSG0_Byte1( collision_s2, collision_s3,
	collision_s4, collision_s5, collision_s6, assist_gob, assist_gfb,
	gfb ) {
	siCollisionSensor2.active = ( collision_s2 == 1 )?true:false;
	siCollisionSensor3.active = ( collision_s3 == 1 )?true:false;
	siCollisionSensor4.active = ( collision_s4 == 1 )?true:false;
	siCollisionSensor5.active = ( collision_s5 == 1 )?true:false;
	siCollisionSensor6.active = ( collision_s6 == 1 )?true:false;
	siAssistGetOnButton.active = ( assist_gob == 1 )?true:false;
	siAssistGetOffButton.active = ( assist_gfb == 1 )?true:false;
	siGetOffButton.active = ( gfb == 1 )?true:false;
    }

    function updateMsg_BCU_VCU_MSG0_Byte2( dfs_fb, ac_switch, ramp_rl,
	hzwl_switch, wpi_switch, ltsig_switch, rtsig_switch, pkl_switch ) {
	siDefoggerSwitchFeedback.active = ( dfs_fb == 1 )?true:false;
	siAirConditionSwitch.active = ( ac_switch == 1 )?true:false;
	siRampRelease.active = ( ramp_rl == 1 )?true:false;
	siHazardWarningLightSwitch.active = ( hzwl_switch == 1 )?true:false;
	siWiperIntermittentSwitch.active = ( wpi_switch == 1 )?true:false;
	siLeftTurnSignalSwitch.active = ( ltsig_switch == 1 )?true:false;
	siRightTurnSignalSwitch.active = ( rtsig_switch == 1 )?true:false;
	siParkingLightsSwitch.active = ( pkl_switch == 1 )?true:false;
    }

    function updateMsg_BCU_VCU_MSG0_Byte3(
	lb_switch, hb_switch, fogl_switch, hotl_switch,
	abs_alarm, fl_lining, fr_lining, rl_lining) {
	siLowBeamSwitch.active = ( lb_switch == 1 )?true:false;
	siHighBeamSwitch.active = ( hb_switch == 1 )?true:false;
	siFogLightSwitchFeedback.active = ( fogl_switch == 1 )?true:false;
	siDefoggingHotline.active = ( hotl_switch == 1 )?true:false;
	siABSAbnormalSignal.active = ( abs_alarm == 1 )?true:false;
	siLeftFrontBrakeLiningSensor.active = ( fl_lining == 1 )?true:false;
	siRightFrontBrakeLiningSensor.active = ( fr_lining == 1 )?true:false;
	siLeftRearBrakeLiningSensor.active = ( rl_lining == 1 )?true:false;
    }

    function updateMsg_BCU_VCU_MSG0_Byte4(
	rr_lining, ecas33f, ecas_kneeling, ecas34w,
	pking_l, lb_lights, hb_lights, tleft_lights ) {
	siRightRearBrakLiningSensor.active = ( rr_lining == 1 )?true:false;
	siECAS33Failure.active = ( ecas33f == 1 )?true:false;
	siECASSideKneeling.active = ( ecas_kneeling == 1 )?true:false;
	siECAS34Warning.active = ( ecas34w == 1 )?true:false;
	siParkingLights.active = ( pking_l == 1 )?true:false;
	siLowBeamLights.active = ( lb_lights == 1 )?true:false;
	siHighBeamLights.active = ( hb_lights == 1 )?true:false;
	siTurnLeftLights.active = ( tleft_lights == 1 )?true:false;
    }

    function updateMsg_BCU_VCU_MSG0_Byte5(
	tright_lights, bkup_l, brake_l, ts_buzzer, fog_l,
	interior_l, wpi, do_signal_fr ) {
	siTurnRightLights.active = ( tright_lights == 1 )?true:false;
	siBackupLights.active = ( bkup_l == 1 )?true:false;
	siBrakeLights.active = ( brake_l == 1 )?true:false;
	siTurnSignalBuzzer.active = ( ts_buzzer == 1 )?true:false;
	siFogLights.active = ( fog_l == 1 )?true:false;
	siInteriorLights.active = ( interior_l == 1 )?true:false;
	siWiperIntermittent.active = ( wpi == 1 )?true:false;
	siDoorOpenSignalFrontAndRear.active = ( do_signal_fr == 1 )?true:false;
    }

    function updateMsg_BCU_VCU_MSG0_Byte6(
	get_off_bb, emgd_lt, brk2_ecas, dw_buzz_s ) {
	siGetOffBellBox.active = ( get_off_bb == 1 )?true:false;
	siEMGDoorLockTrigger.active = ( emgd_lt == 1 )?true:false;
	siBrakeSignal2ECAS.active = ( brk2_ecas == 1 )?true:false;
	siDoorWarningBuzzerSignal.active = ( dw_buzz_s == 1 )?true:false;
    }

    Rectangle {
        id: recBcuAnalog
        color: "lightGrey"
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 800
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 1280
    }

    Image {
        id: imageBack
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
        source: "../../../images/0-color/HMI-ICON-55.png"
        fillMode: Image.PreserveAspectFit
        MouseArea {
        id: maBack
        z: 2
        anchors.fill: parent
        onClicked: {
        bcuAnalog.hide();
        }
    }
    }

    Rectangle {
        id: rowbcuAnalog
        x: 200
        y: 30
        width: 300
        height: 43
    color: "#161616"
        anchors.leftMargin: 50
        Text {
            id: txtbcuAnalog
            y: 0
            width: 100
            height: 43
            color: "#ffffff"
            text: qsTr("BCU IO (Analog)")
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
        anchors.topMargin: 200
        anchors.left: parent.left
    }

    Row {
        id: rowInstantMessage
        objectName: "instantMessage"
        x: 152
        width: 1280
        height: 50
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        Rectangle {
            id: recMessage
            x: 0
            y: 0
            width: 1280
            height: 50
            color: "#1f1f1f"
            anchors.bottom: parent.bottom
        }
    }

    Rectangle {
        id: rowForceOpenFrontDoor
        x: 202
        y: 7
        width: 240
        height: 25
    color: "#161616"
        anchors.leftMargin: 50
        Text {
            id: txtForceOpenFrontDoor
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Force Open Front Door"
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siForceOpenFrontDoor.right
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siForceOpenFrontDoor
            y: 87
            width: 20
            height: 20
            active: false
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
        color: "#ffffff"
        }
        anchors.topMargin: 50
        anchors.top: rowbcuAnalog.bottom
        anchors.left: parent.left
    }

    Rectangle {
        id: rowForceOpenBackDoor
        x: 211
        width: 240
        height: 25
    color: "#161616"
        anchors.top: rowForceOpenFrontDoor.bottom
        anchors.topMargin: 5
        anchors.leftMargin: 50
        Text {
            id: txtForceOpenBackDoor
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Force Open Back Door"
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siForceOpenBackDoor.right
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: 15
            verticalAlignment: Text.AlignVCenter
        }

        StatusIndicator {
            id: siForceOpenBackDoor
            y: 87
            width: 20
            height: 20
            active: false
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
        color: "#ffffff"
        }
        anchors.left: parent.left
    }

    Rectangle {
        id: rowEMGDoorSwitch
        x: 202
        width: 240
        height: 25
    color: "#161616"
        anchors.leftMargin: 50
        Text {
            id: txtEmergencyDoorSwitch
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Emergency Door Switch"
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siEmergencyDoorSwitch.right
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: 15
            verticalAlignment: Text.AlignVCenter
        }

        StatusIndicator {
            id: siEmergencyDoorSwitch
            y: 87
            width: 20
            height: 20
            active: false
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
        color: "#ffffff"
        }
        anchors.topMargin: 5
        anchors.top: rowForceOpenBackDoor.bottom
        anchors.left: parent.left
    }

    Rectangle {
        id: rowBackDoorOpenSensor
        x: 198
        y: 3
        width: 240
        height: 25
    color: "#161616"
        anchors.leftMargin: 50
        Text {
            id: txtBackDoorOpenSensor
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Back Door Open Sensor"
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siBackDoorOpenSensor.right
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: 15
            verticalAlignment: Text.AlignVCenter
        }

        StatusIndicator {
            id: siBackDoorOpenSensor
            y: 87
            width: 20
            height: 20
            color: "#ffffff"
            active: false
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
        }
        anchors.topMargin: 5
        anchors.top: rowFrontDoorOpenSensor.bottom
        anchors.left: parent.left
    }

    Rectangle {
        id: rowEMGDoorLockFeedback
        x: 207
        y: -4
        width: 240
        height: 25
    color: "#161616"
        anchors.leftMargin: 50
        Text {
            id: txtEMGDoorLockFeedback
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "EMG. Door Lock Feedback"
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siEMGDoorLockFeedback.right
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siEMGDoorLockFeedback
            y: 87
            width: 20
            height: 20
            active: false
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
        color: "#ffffff"
        }
        anchors.topMargin: 5
        anchors.top: rowBackDoorOpenSensor.bottom
        anchors.left: parent.left
    }

    Rectangle {
        id: rowTheDoorOpenSignal
        x: 206
        y: 11
        width: 240
        height: 25
    color: "#161616"
        anchors.leftMargin: 50
        Text {
            id: txtTheDoorOpenSignal
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "The Door Open Signal"
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siTheDoorOpenSignal.right
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: 15
            verticalAlignment: Text.AlignVCenter
        }

        StatusIndicator {
            id: siTheDoorOpenSignal
            y: 87
            width: 20
            height: 20
            active: false
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
        color: "#ffffff"
        }
        anchors.topMargin: 5
        anchors.top: rowEMGDoorLockFeedback.bottom
        anchors.left: parent.left
    }

    Rectangle {
        id: rowCollisionSensor1
        x: 215
        y: 4
        width: 240
        height: 25
    color: "#161616"
        anchors.leftMargin: 50
        Text {
            id: txtCollisionSensor1
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "1 Collision Sensor"
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siCollisionSensor1.right
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siCollisionSensor1
            y: 87
            width: 20
            height: 20
            color: "#ffffff"
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            active: false
        }
        anchors.topMargin: 5
        anchors.top: rowTheDoorOpenSignal.bottom
        anchors.left: parent.left
    }

    Rectangle {
        id: rowCollisionSensor2
        x: 206
        y: 4
        width: 240
        height: 25
    color: "#161616"
        anchors.leftMargin: 50
        Text {
            id: txtCollisionSensor2
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "2 Collision Sensor"
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siCollisionSensor2.right
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siCollisionSensor2
            y: 87
            width: 20
            height: 20
            color: "#ffffff"
            active: false
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
        }
        anchors.topMargin: 5
        anchors.top: rowCollisionSensor1.bottom
        anchors.left: parent.left
    }

    Rectangle {
        id: rowCollisionSensor3
        x: 202
        y: 7
        width: 240
        height: 25
    color: "#161616"
        anchors.leftMargin: 50
        Text {
            id: txtCollisionSensor3
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "3 Collision Sensor"
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siCollisionSensor3.right
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siCollisionSensor3
            y: 87
            width: 20
            height: 20
            color: "#ffffff"
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            active: false
        }
        anchors.topMargin: 5
        anchors.top: rowCollisionSensor2.bottom
        anchors.left: parent.left
    }

    Rectangle {
        id: rowCollisionSensor4
        x: 211
        y: 0
        width: 240
        height: 25
    color: "#161616"
        anchors.leftMargin: 50
        Text {
            id: txtCollisionSensor4
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "4 Collision Sensor"
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siCollisionSensor4.right
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: 15
            verticalAlignment: Text.AlignVCenter
        }

        StatusIndicator {
            id: siCollisionSensor4
            y: 87
            width: 20
            height: 20
            active: false
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
        color: "#ffffff"
        }
        anchors.topMargin: 5
        anchors.top: rowCollisionSensor3.bottom
        anchors.left: parent.left
    }

    Rectangle {
        id: rowFrontDoorOpenSensor
        x: 202
        y: 379
        width: 240
        height: 25
    color: "#161616"
        anchors.leftMargin: 50
        Text {
            id: txtFrontDoorOpenSensor
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Front Door Open Sensor"
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siFrontDoorOpenSensor.right
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: 15
            verticalAlignment: Text.AlignVCenter
        }

        StatusIndicator {
            id: siFrontDoorOpenSensor
            y: 87
            width: 20
            height: 20
            active: false
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
        color: "#ffffff"
        }
        anchors.topMargin: 5
        anchors.top: rowEMGDoorSwitch.bottom
        anchors.left: parent.left
    }

    Rectangle {
        id: rowCollisionSensor5
        x: 194
        y: -1
        width: 240
        height: 25
    color: "#161616"
        anchors.leftMargin: 50
        Text {
            id: txtCollisionSensor5
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "5 Collision Sensor"
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siCollisionSensor5.right
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: 15
            verticalAlignment: Text.AlignVCenter
        }

        StatusIndicator {
            id: siCollisionSensor5
            y: 87
            width: 20
            height: 20
            active: false
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
        color: "#ffffff"
        }
        anchors.topMargin: 5
        anchors.top: rowCollisionSensor4.bottom
        anchors.left: parent.left
    }

    Rectangle {
        id: rowCollisionSensor6
        x: 203
        y: -8
        width: 240
        height: 25
    color: "#161616"
        anchors.leftMargin: 50
        Text {
            id: txtCollisionSensor6
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "6 Collision Sensor"
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siCollisionSensor6.right
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siCollisionSensor6
            y: 87
            width: 20
            height: 20
            color: "#ffffff"
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            active: false
        }
        anchors.topMargin: 5
        anchors.top: rowCollisionSensor5.bottom
        anchors.left: parent.left
    }

    Rectangle {
        id: rowAssistGetOnButton
        x: 194
        y: -8
        width: 240
        height: 25
    color: "#161616"
        anchors.leftMargin: 50
        Text {
            id: txtAssistGetOnButton
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Assist Get On Button"
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siAssistGetOnButton.right
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siAssistGetOnButton
            y: 87
            width: 20
            height: 20
            active: false
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
        color: "#ffffff"
        }
        anchors.topMargin: 5
        anchors.top: rowCollisionSensor6.bottom
        anchors.left: parent.left
    }

    Rectangle {
        id: rowGetOffButton
        x: 190
        y: -5
        width: 240
        height: 25
    color: "#161616"
        anchors.leftMargin: 50
        Text {
            id: txtGetOffButton
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Get Off Button"
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siGetOffButton.right
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siGetOffButton
            y: 87
            width: 20
            height: 20
            color: "#ffffff"
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            active: false
        }
        anchors.topMargin: 5
        anchors.top: rowAssistGetOffButton.bottom
        anchors.left: parent.left
    }

    Rectangle {
        id: rowDefoggerSwitchFeedback
        width: 240
        height: 25
    color: "#161616"
        anchors.left: rowForceOpenFrontDoor.right
        anchors.leftMargin: 50
        anchors.top: rowbcuAnalog.bottom
        anchors.topMargin: 50
        Text {
            id: txtDefoggerSwitchFeedback
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Defogger Switch Feedback"
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siDefoggerSwitchFeedback.right
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: 15
            verticalAlignment: Text.AlignVCenter
        }

        StatusIndicator {
            id: siDefoggerSwitchFeedback
            y: 87
            width: 20
            height: 20
            active: false
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
        color: "#ffffff"
        }
    }

    Rectangle {
        id: rowAssistGetOffButton
        x: 190
        y: 179
        width: 240
        height: 25
    color: "#161616"
        anchors.leftMargin: 50
        Text {
            id: txtAssistGetOffButton
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Assist Get Off Button"
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siAssistGetOffButton.right
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: 15
            verticalAlignment: Text.AlignVCenter
        }

        StatusIndicator {
            id: siAssistGetOffButton
            y: 87
            width: 20
            height: 20
            active: false
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
        color: "#ffffff"
        }
        anchors.topMargin: 5
        anchors.top: rowAssistGetOnButton.bottom
        anchors.left: parent.left
    }

    Rectangle {
        id: rowAirConditionSwitch
        x: 198
        y: 3
        width: 240
        height: 25
    color: "#161616"
        anchors.leftMargin: 50
        Text {
            id: txtAirConditionSwitch
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Air Condition Switch"
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siAirConditionSwitch.right
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siAirConditionSwitch
            y: 87
            width: 20
            height: 20
            active: false
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
        color: "#ffffff"
        }
        anchors.topMargin: 5
        anchors.top: rowDefoggerSwitchFeedback.bottom
        anchors.left: rowForceOpenBackDoor.right
    }

    Rectangle {
        id: rowRampRelease
        x: 207
        y: -4
        width: 240
        height: 25
    color: "#161616"
        anchors.leftMargin: 50
        Text {
            id: txtRampRelease
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Ramp Release"
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siRampRelease.right
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: 15
            verticalAlignment: Text.AlignVCenter
        }

        StatusIndicator {
            id: siRampRelease
            y: 87
            width: 20
            height: 20
            color: "#ffffff"
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            active: false
        }
        anchors.topMargin: 5
        anchors.top: rowAirConditionSwitch.bottom
        anchors.left: rowEMGDoorSwitch.right
    }

    Rectangle {
        id: rowHazardWarningLightSwitch
        x: 198
        y: -4
        width: 240
        height: 25
    color: "#161616"
        anchors.leftMargin: 50
        Text {
            id: txtHazardWarningLightSwitch
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Hazard Warning Light Switch"
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siHazardWarningLightSwitch.right
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: 15
            verticalAlignment: Text.AlignVCenter
        }

        StatusIndicator {
            id: siHazardWarningLightSwitch
            y: 87
            width: 20
            height: 20
            active: false
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
        color: "#ffffff"
        }
        anchors.topMargin: 5
        anchors.top: rowRampRelease.bottom
        anchors.left: rowFrontDoorOpenSensor.right
    }

    Rectangle {
        id: rowWiperIntermittentSwitch
        x: 194
        y: -1
        width: 240
        height: 25
    color: "#161616"
        anchors.leftMargin: 50
        Text {
            id: txtWiperIntermittentSwitch
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Wiper Intermittent Switch"
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siWiperIntermittentSwitch.right
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: 15
            verticalAlignment: Text.AlignVCenter
        }

        StatusIndicator {
            id: siWiperIntermittentSwitch
            y: 87
            width: 20
            height: 20
            color: "#ffffff"
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            active: false
        }
        anchors.topMargin: 5
        anchors.top: rowHazardWarningLightSwitch.bottom
        anchors.left: rowBackDoorOpenSensor.right
    }

    Rectangle {
        id: rowLeftTurnSignalSwitch
        x: 203
        y: -8
        width: 240
        height: 25
    color: "#161616"
        anchors.leftMargin: 50
        Text {
            id: txtLeftTurnSignalSwitch
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Left Turn Signal Switch"
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siLeftTurnSignalSwitch.right
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siLeftTurnSignalSwitch
            y: 87
            width: 20
            height: 20
            color: "#ffffff"
            active: false
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
        }
        anchors.topMargin: 5
        anchors.top: rowWiperIntermittentSwitch.bottom
        anchors.left: rowEMGDoorLockFeedback.right
    }

    Rectangle {
        id: rowRightTurnSignalSwitch
        x: 194
        y: 260
        width: 240
        height: 25
    color: "#161616"
        anchors.leftMargin: 50
        Text {
            id: txtRightTurnSignalSwitch
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Right Turn Signal Switch"
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siRightTurnSignalSwitch.right
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siRightTurnSignalSwitch
            y: 87
            width: 20
            height: 20
            active: false
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
        color: "#ffffff"
        }
        anchors.topMargin: 5
        anchors.top: rowLeftTurnSignalSwitch.bottom
        anchors.left: rowTheDoorOpenSignal.right
    }

    Rectangle {
        id: rowLowBeamSwitch
        x: 207
        y: -4
        width: 240
        height: 25
    color: "#161616"
        Text {
            id: txtLowBeamSwitch
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Low Beam Switch"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siLowBeamSwitch.right
            anchors.leftMargin: 20
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siLowBeamSwitch
            y: 87
            width: 20
            height: 20
            color: "#ffffff"
            active: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 0
        }
        anchors.top: rowParkingLightsSwitch.bottom
        anchors.left: rowCollisionSensor2.right
        anchors.topMargin: 5
        anchors.leftMargin: 50
    }

    Rectangle {
        id: rowHighBeamSwitch
        x: 198
        y: -4
        width: 240
        height: 25
    color: "#161616"
        Text {
            id: txtHighBeamSwitch
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "High Beam Switch"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siHighBeamSwitch.right
            anchors.leftMargin: 20
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siHighBeamSwitch
            y: 87
            width: 20
            height: 20
            active: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 0
        color: "#ffffff"
        }
        anchors.top: rowLowBeamSwitch.bottom
        anchors.left: rowCollisionSensor3.right
        anchors.topMargin: 5
        anchors.leftMargin: 50
    }

    Rectangle {
        id: rowFogLightSwitchFeedback
        x: 194
        y: -1
        width: 240
        height: 25
    color: "#161616"
        Text {
            id: txtFogLightSwitchFeedback
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Fog Light Switch Feedback"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siFogLightSwitchFeedback.right
            anchors.leftMargin: 20
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siFogLightSwitchFeedback
            y: 87
            width: 20
            height: 20
            color: "#ffffff"
            active: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 0
        }
        anchors.top: rowHighBeamSwitch.bottom
        anchors.left: rowCollisionSensor4.right
        anchors.topMargin: 5
        anchors.leftMargin: 50
    }

    Rectangle {
        id: rowDefoggingHotline
        x: 203
        y: -8
        width: 240
        height: 25
    color: "#161616"
        Text {
            id: txtDefoggingHotline
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: qsTr("Defogging Hotline")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siDefoggingHotline.right
            anchors.leftMargin: 20
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siDefoggingHotline
            y: 87
            width: 20
            height: 20
            active: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 0
        color: "#ffffff"
        }
        anchors.top: rowFogLightSwitchFeedback.bottom
        anchors.left: rowCollisionSensor5.right
        anchors.topMargin: 5
        anchors.leftMargin: 50
    }

    Rectangle {
        id: rowABSAbnormalSignal
        x: 186
        y: -9
        width: 240
        height: 25
    color: "#161616"
        Text {
            id: txtABSAbnormalSignal
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "ABS Abnormal Signal"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siABSAbnormalSignal.right
            anchors.leftMargin: 20
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siABSAbnormalSignal
            y: 87
            width: 20
            height: 20
            active: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 0
        color: "#ffffff"
        }
        anchors.top: rowDefoggingHotline.bottom
        anchors.left: rowCollisionSensor6.right
        anchors.topMargin: 5
        anchors.leftMargin: 50
    }

    Rectangle {
        id: rowLeftFrontBrakeLiningSensor
        x: 195
        y: -16
        width: 240
        height: 25
    color: "#161616"
        Text {
            id: txtLeftFrontBrakeLiningSensor
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Left Front Brake Lining Sensor"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siLeftFrontBrakeLiningSensor.right
            anchors.leftMargin: 20
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siLeftFrontBrakeLiningSensor
            y: 87
            width: 20
            height: 20
            color: "#ffffff"
            active: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 0
        }
        anchors.top: rowABSAbnormalSignal.bottom
        anchors.left: rowAssistGetOnButton.right
        anchors.topMargin: 5
        anchors.leftMargin: 50
    }

    Rectangle {
        id: rowRightFrontBrakeLiningSensor
        x: 186
        y: -16
        width: 240
        height: 25
    color: "#161616"
        Text {
            id: txtRightFrontBrakeLiningSensor
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Right Front Brake Lining Sensor"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siRightFrontBrakeLiningSensor.right
            anchors.leftMargin: 20
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siRightFrontBrakeLiningSensor
            y: 87
            width: 20
            height: 20
            active: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 0
        color: "#ffffff"
        }
        anchors.top: rowLeftFrontBrakeLiningSensor.bottom
        anchors.left: rowAssistGetOffButton.right
        anchors.topMargin: 5
        anchors.leftMargin: 50
    }

    Rectangle {
        id: rowLeftRearBrakeLiningSensor
        x: 182
        y: -13
        width: 240
        height: 25
    color: "#161616"
        Text {
            id: txtLeftRearBrakeLiningSensor
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Left Rear Brake Lining Sensor"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siLeftRearBrakeLiningSensor.right
            anchors.leftMargin: 20
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siLeftRearBrakeLiningSensor
            y: 87
            width: 20
            height: 20
            color: "#ffffff"
            active: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 0
        }
        anchors.top: rowRightFrontBrakeLiningSensor.bottom
        anchors.left: rowGetOffButton.right
        anchors.topMargin: 5
        anchors.leftMargin: 50
    }

    Rectangle {
        id: rowParkingLightsSwitch
        x: 182
        y: 303
        width: 240
        height: 25
    color: "#161616"
        Text {
            id: txtParkingLightsSwitch
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Parking Lights Switch"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siParkingLightsSwitch.right
            anchors.leftMargin: 20
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siParkingLightsSwitch
            y: 87
            width: 20
            height: 20
            active: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 0
        color: "#ffffff"
        }
        anchors.top: rowRightTurnSignalSwitch.bottom
        anchors.left: rowCollisionSensor1.right
        anchors.topMargin: 5
        anchors.leftMargin: 50
    }

    Rectangle {
        id: rowRightRearBrakLiningSensor
        x: 204
        y: 9
        width: 240
        height: 25
    color: "#161616"
        Text {
            id: txtRightRearBrakLiningSensor
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Right Rear Brake Lining Sensor"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siRightRearBrakLiningSensor.right
            anchors.leftMargin: 20
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siRightRearBrakLiningSensor
            y: 87
            width: 20
            height: 20
            active: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 0
        color: "#ffffff"
        }
        anchors.top: rowbcuAnalog.bottom
        anchors.left: rowDefoggerSwitchFeedback.right
        anchors.topMargin: 50
        anchors.leftMargin: 50
    }

    Rectangle {
        id: rowECAS33Failure
        x: 213
        y: 2
        width: 240
        height: 25
    color: "#161616"
        Text {
            id: txtECAS33Failure
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "ECAS 33 Failure"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siECAS33Failure.right
            anchors.leftMargin: 20
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siECAS33Failure
            y: 87
            width: 20
            height: 20
            color: "#ffffff"
            active: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 0
        }
        anchors.top: rowRightRearBrakLiningSensor.bottom
        anchors.left: rowAirConditionSwitch.right
        anchors.topMargin: 5
        anchors.leftMargin: 50
    }

    Rectangle {
        id: rowECASSlideKneeling
        x: 204
        y: 2
        width: 240
        height: 25
    color: "#161616"
        Text {
            id: txtECASSlideKneeling
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "ECAS Slide Kneeling"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siECASSideKneeling.right
            anchors.leftMargin: 20
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siECASSideKneeling
            y: 87
            width: 20
            height: 20
            active: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 0
        color: "#ffffff"
        }
        anchors.top: rowECAS33Failure.bottom
        anchors.left: rowRampRelease.right
        anchors.topMargin: 5
        anchors.leftMargin: 50
    }

    Rectangle {
        id: rowParkingLights
        x: 200
        y: 5
        width: 240
        height: 25
    color: "#161616"
        Text {
            id: txtParkingLights
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Parking Lights"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siParkingLights.right
            anchors.leftMargin: 20
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siParkingLights
            y: 87
            width: 20
            height: 20
            color: "#ffffff"
            active: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 0
        }
        anchors.top: rowECAS34Warning.bottom
        anchors.left: rowWiperIntermittentSwitch.right
        anchors.topMargin: 5
        anchors.leftMargin: 50
    }

    Rectangle {
        id: rowLowBeamLights
        x: 209
        y: -2
        width: 240
        height: 25
    color: "#161616"
        Text {
            id: txtLowBeamLights
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Low Beam Lights"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siLowBeamLights.right
            anchors.leftMargin: 20
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siLowBeamLights
            y: 87
            width: 20
            height: 20
            active: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 0
        color: "#ffffff"
        }
        anchors.top: rowParkingLights.bottom
        anchors.left: rowLeftTurnSignalSwitch.right
        anchors.topMargin: 5
        anchors.leftMargin: 50
    }

    Rectangle {
        id: rowHighBeamLights
        x: 208
        y: 13
        width: 240
        height: 25
    color: "#161616"
        Text {
            id: txtHighBeamLights
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "High Beam Lights"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siHighBeamLights.right
            anchors.leftMargin: 20
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siHighBeamLights
            y: 87
            width: 20
            height: 20
            active: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 0
        color: "#ffffff"
        }
        anchors.top: rowLowBeamLights.bottom
        anchors.left: rowRightTurnSignalSwitch.right
        anchors.topMargin: 5
        anchors.leftMargin: 50
    }

    Rectangle {
        id: rowTurnLeftLights
        x: 217
        y: 6
        width: 240
        height: 25
    color: "#161616"
        Text {
            id: txtTurnLeftLights
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Turn Left Lights"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siTurnLeftLights.right
            anchors.leftMargin: 20
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siTurnLeftLights
            y: 87
            width: 20
            height: 20
            color: "#ffffff"
            active: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 0
        }
        anchors.top: rowHighBeamLights.bottom
        anchors.left: rowParkingLightsSwitch.right
        anchors.topMargin: 5
        anchors.leftMargin: 50
    }

    Rectangle {
        id: rowTurnRightLights
        x: 208
        y: 6
        width: 240
        height: 25
    color: "#161616"
        Text {
            id: txtTurnRightLights
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Turn Right Lights"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siTurnRightLights.right
            anchors.leftMargin: 20
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siTurnRightLights
            y: 87
            width: 20
            height: 20
            active: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 0
        color: "#ffffff"
        }
        anchors.top: rowTurnLeftLights.bottom
        anchors.left: rowLowBeamSwitch.right
        anchors.topMargin: 5
        anchors.leftMargin: 50
    }

    Rectangle {
        id: rowBackupLights
        x: 204
        y: 9
        width: 240
        height: 25
    color: "#161616"
        Text {
            id: txtBackupLights
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Backup Lights"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siBackupLights.right
            anchors.leftMargin: 20
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siBackupLights
            y: 87
            width: 20
            height: 20
            color: "#ffffff"
            active: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 0
        }
        anchors.top: rowTurnRightLights.bottom
        anchors.left: rowHighBeamSwitch.right
        anchors.topMargin: 5
        anchors.leftMargin: 50
    }

    Rectangle {
        id: rowBrakeLights
        x: 213
        y: 2
        width: 240
        height: 25
    color: "#161616"
        Text {
            id: txtBrakeLights
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Brake Lights"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siBrakeLights.right
            anchors.leftMargin: 20
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siBrakeLights
            y: 87
            width: 20
            height: 20
            active: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 0
        color: "#ffffff"
        }
        anchors.top: rowBackupLights.bottom
        anchors.left: rowFogLightSwitchFeedback.right
        anchors.topMargin: 5
        anchors.leftMargin: 50
    }

    Rectangle {
        id: rowECAS34Warning
        x: 204
        y: 381
        width: 240
        height: 25
    color: "#161616"
        Text {
            id: txtECAS34Warning
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "ECAS 34 Warning"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siECAS34Warning.right
            anchors.leftMargin: 20
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siECAS34Warning
            y: 87
            width: 20
            height: 20
            active: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 0
        color: "#ffffff"
        }
        anchors.top: rowECASSlideKneeling.bottom
        anchors.left: rowHazardWarningLightSwitch.right
        anchors.topMargin: 5
        anchors.leftMargin: 50
    }

    Rectangle {
        id: rowTurnSignalBuzzer
        x: 196
        y: 1
        width: 240
        height: 25
    color: "#161616"
        Text {
            id: txtTurnSignalBuzzer
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Turn Signal Buzzer"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siTurnSignalBuzzer.right
            anchors.leftMargin: 20
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siTurnSignalBuzzer
            y: 87
            width: 20
            height: 20
            active: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 0
        color: "#ffffff"
        }
        anchors.top: rowBrakeLights.bottom
        anchors.left: rowDefoggingHotline.right
        anchors.topMargin: 5
        anchors.leftMargin: 50
    }

    Rectangle {
        id: rowFogLights
        x: 205
        y: -6
        width: 240
        height: 25
    color: "#161616"
        Text {
            id: txtFogLights
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Fog Lights"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siFogLights.right
            anchors.leftMargin: 20
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siFogLights
            y: 87
            width: 20
            height: 20
            color: "#ffffff"
            active: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 0
        }
        anchors.top: rowTurnSignalBuzzer.bottom
        anchors.left: rowABSAbnormalSignal.right
        anchors.topMargin: 5
        anchors.leftMargin: 50
    }

    Rectangle {
        id: rowInteriorLights
        x: 196
        y: -6
        width: 240
        height: 25
    color: "#161616"
        Text {
            id: txtInteriorLights
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Interior Lights"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siInteriorLights.right
            anchors.leftMargin: 20
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siInteriorLights
            y: 87
            width: 20
            height: 20
            active: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 0
        color: "#ffffff"
        }
        anchors.top: rowFogLights.bottom
        anchors.left: rowLeftFrontBrakeLiningSensor.right
        anchors.topMargin: 5
        anchors.leftMargin: 50
    }

    Rectangle {
        id: rowDoorOpenSignalFrontAndRear
        x: 192
        y: -3
        width: 240
        height: 25
    color: "#161616"
        Text {
            id: txtDoorOpenSignalFrontAndRear
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Door Open Signal ( Front/Rear )"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siDoorOpenSignalFrontAndRear.right
            anchors.leftMargin: 20
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siDoorOpenSignalFrontAndRear
            y: 87
            width: 20
            height: 20
            color: "#ffffff"
            active: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 0
        }
        anchors.top: rowWiperIntermittent.bottom
        anchors.left: rowLeftRearBrakeLiningSensor.right
        anchors.topMargin: 5
        anchors.leftMargin: 50
    }

    Rectangle {
        id: rowGetOffBellBox
        x: 201
        width: 240
        height: 25
    color: "#161616"
        anchors.top: rowbcuAnalog.bottom
        anchors.topMargin: 50
        Text {
            id: txtGetOffBellBox
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Get Off Bell Box"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siGetOffBellBox.right
            anchors.leftMargin: 20
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siGetOffBellBox
            y: 87
            width: 20
            height: 20
            active: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 0
        color: "#ffffff"
        }
        anchors.left: rowRightRearBrakLiningSensor.right
        anchors.leftMargin: 50
    }

    Rectangle {
        id: rowWiperIntermittent
        x: 192
        y: 181
        width: 240
        height: 25
    color: "#161616"
        Text {
            id: txtWiperIntermittent
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Wiper Intermittent"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siWiperIntermittent.right
            anchors.leftMargin: 20
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siWiperIntermittent
            y: 87
            width: 20
            height: 20
            active: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 0
        color: "#ffffff"
        }
        anchors.top: rowInteriorLights.bottom
        anchors.left: rowRightFrontBrakeLiningSensor.right
        anchors.topMargin: 5
        anchors.leftMargin: 50
    }

    Rectangle {
        id: rowEMGDoorLockTrigger
        x: 200
        y: 5
        width: 240
        height: 25
    color: "#161616"
        Text {
            id: txtEMGDoorLockTrigger
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "EMG. Door Lock Trigger"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siEMGDoorLockTrigger.right
            anchors.leftMargin: 20
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siEMGDoorLockTrigger
            y: 87
            width: 20
            height: 20
            active: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 0
        color: "#ffffff"
        }
        anchors.top: rowGetOffBellBox.bottom
        anchors.left: rowECAS33Failure.right
        anchors.topMargin: 5
        anchors.leftMargin: 50
    }

    Rectangle {
        id: rowBrakeSignal2ECAS
        x: 209
        y: -2
        width: 240
        height: 25
    color: "#161616"
        Text {
            id: txtBrakeSignal2ECAS
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Brake Signal ( to ECAS )"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siBrakeSignal2ECAS.right
            anchors.leftMargin: 20
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siBrakeSignal2ECAS
            y: 87
            width: 20
            height: 20
            color: "#ffffff"
            active: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 0
        }
        anchors.top: rowEMGDoorLockTrigger.bottom
        anchors.left: rowECASSlideKneeling.right
        anchors.topMargin: 5
        anchors.leftMargin: 50
    }

    Rectangle {
        id: rowDoorWarningBuzzerSignal
        x: 200
        y: -2
        width: 240
        height: 25
    color: "#161616"
        Text {
            id: txtDoorWarningBuzzerSignal
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Door Warning Buzzer Signal"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siDoorWarningBuzzerSignal.right
            anchors.leftMargin: 20
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siDoorWarningBuzzerSignal
            y: 87
            width: 20
            height: 20
            active: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 0
        color: "#ffffff"
        }
        anchors.top: rowBrakeSignal2ECAS.bottom
        anchors.left: rowECAS34Warning.right
        anchors.topMargin: 5
        anchors.leftMargin: 50
    }

    Rectangle {
        id: rowReserved0
        x: 196
        y: 1
        width: 240
        height: 25
    color: "#161616"
        Text {
            id: txtReserved0
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Reserved"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siReserved0.right
            anchors.leftMargin: 20
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siReserved0
            y: 87
            width: 20
            height: 20
            color: "#ffffff"
            active: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 0
        }
        anchors.top: rowDoorWarningBuzzerSignal.bottom
        anchors.left: rowParkingLights.right
        anchors.topMargin: 5
        anchors.leftMargin: 50
    }

    Rectangle {
        id: rowReserved1
        x: 205
        y: -6
        width: 240
        height: 25
    color: "#161616"
        Text {
            id: txtCollisionSensor16
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Reserved"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siReserved1.right
            anchors.leftMargin: 20
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siReserved1
            y: 87
            width: 20
            height: 20
            active: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 0
        color: "#ffffff"
        }
        anchors.top: rowReserved0.bottom
        anchors.left: rowLowBeamLights.right
        anchors.topMargin: 5
        anchors.leftMargin: 50
    }

    Rectangle {
        id: rowReserved2
        x: 196
        y: 262
        width: 240
        height: 25
    color: "#161616"
        Text {
            id: txtReserved2
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Reserved"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siReserved2.right
            anchors.leftMargin: 20
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siReserved2
            y: 87
            width: 20
            height: 20
            active: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 0
        color: "#ffffff"
        }
        anchors.top: rowReserved1.bottom
        anchors.left: rowHighBeamLights.right
        anchors.topMargin: 5
        anchors.leftMargin: 50
    }

    Rectangle {
        id: rowDetectSmoke1
        x: 209
        y: -2
        width: 240
        height: 25
    color: "#161616"
        Text {
            id: txtDetectSmoke1
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Detect Smoke 1"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.left: siDetectSmoke1.right
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 15
            anchors.leftMargin: 20
        }

        StatusIndicator {
            id: siDetectSmoke1
            y: 87
            width: 20
            height: 20
            color: "#ffffff"
            active: false
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
        }
        anchors.top: rowReserved3.bottom
        anchors.left: rowTurnRightLights.right
        anchors.topMargin: 5
        anchors.leftMargin: 50
    }

    Rectangle {
        id: rowDetectSmoke2
        x: 200
        y: -2
        width: 240
        height: 25
    color: "#161616"
        Text {
            id: txtDetectSmoke2
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Detect Smoke 2"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.left: siDetectSmoke2.right
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 15
            anchors.leftMargin: 20
        }

        StatusIndicator {
            id: siDetectSmoke2
            y: 87
            width: 20
            height: 20
            active: false
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
        color: "#ffffff"
        }
        anchors.top: rowDetectSmoke1.bottom
        anchors.left: rowBackupLights.right
        anchors.topMargin: 5
        anchors.leftMargin: 50
    }

    Rectangle {
        id: rowDetectSmoke3
        x: 196
        y: 1
        width: 240
        height: 25
    color: "#161616"
        Text {
            id: txtDetectSmoke3
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Detect Smoke 3"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.left: siDetectSmoke3.right
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 15
            anchors.leftMargin: 20
        }

        StatusIndicator {
            id: siDetectSmoke3
            y: 87
            width: 20
            height: 20
            color: "#ffffff"
            active: false
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
        }
        anchors.top: rowDetectSmoke2.bottom
        anchors.left: rowBrakeLights.right
        anchors.topMargin: 5
        anchors.leftMargin: 50
    }

    Rectangle {
        id: rowDetectSmoke4
        x: 205
        y: -6
        width: 240
        height: 25
    color: "#161616"
        Text {
            id: txtDetectSmoke4
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: qsTr("Detect Smoke 4")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.left: siDetectSmoke4.right
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 15
            anchors.leftMargin: 20
        }

        StatusIndicator {
            id: siDetectSmoke4
            y: 87
            width: 20
            height: 20
            active: false
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
        color: "#ffffff"
        }
        anchors.top: rowDetectSmoke3.bottom
        anchors.left: rowTurnSignalBuzzer.right
        anchors.topMargin: 5
        anchors.leftMargin: 50
    }

    Rectangle {
        id: rowDetectSmoke5
        x: 188
        y: -7
        width: 240
        height: 25
    color: "#161616"
        Text {
            id: txtDetectSmoke5
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Detect Smoke 5"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.left: siDetectSmoke5.right
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 15
            anchors.leftMargin: 20
        }

        StatusIndicator {
            id: siDetectSmoke5
            y: 87
            width: 20
            height: 20
            active: false
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
        color: "#ffffff"
        }
        anchors.top: rowDetectSmoke4.bottom
        anchors.left: rowFogLights.right
        anchors.topMargin: 5
        anchors.leftMargin: 50
    }

    Rectangle {
        id: rowDetectSmoke6
        x: 197
        y: -14
        width: 240
        height: 25
    color: "#161616"
        Text {
            id: txtDetectSmoke6
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Detect Smoke 6"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.left: siDetectSmoke6.right
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 15
            anchors.leftMargin: 20
        }

        StatusIndicator {
            id: siDetectSmoke6
            y: 87
            width: 20
            height: 20
            color: "#ffffff"
            active: false
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
        }
        anchors.top: rowDetectSmoke5.bottom
        anchors.left: rowInteriorLights.right
        anchors.topMargin: 5
        anchors.leftMargin: 50
    }

    Rectangle {
        id: rowReserved4
        x: 188
        y: -14
        width: 240
        height: 25
    color: "#161616"
        Text {
            id: txtReserved4
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Reserved"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.left: siReserved4.right
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 15
            anchors.leftMargin: 20
        }

        StatusIndicator {
            id: siReserved4
            y: 87
            width: 20
            height: 20
            active: false
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
        color: "#ffffff"
        }
        anchors.top: rowDetectSmoke6.bottom
        anchors.left: rowWiperIntermittent.right
        anchors.topMargin: 5
        anchors.leftMargin: 50
    }

    Rectangle {
        id: rowReserved5
        x: 184
        y: -11
        width: 240
        height: 25
    color: "#161616"
        Text {
            id: txtReserved5
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Reserved"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.left: siReserved5.right
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 15
            anchors.leftMargin: 20
        }

        StatusIndicator {
            id: siReserved5
            y: 87
            width: 20
            height: 20
            color: "#ffffff"
            active: false
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
        }
        anchors.top: rowReserved4.bottom
        anchors.left: rowDoorOpenSignalFrontAndRear.right
        anchors.topMargin: 5
        anchors.leftMargin: 50
    }

    Rectangle {
        id: rowReserved3
        x: 184
        y: 305
        width: 240
        height: 25
    color: "#161616"
        Text {
            id: txtReserved3
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Reserved"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.left: siReserved3.right
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 15
            anchors.leftMargin: 20
        }

        StatusIndicator {
            id: siReserved3
            y: 87
            width: 20
            height: 20
            active: false
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
        color: "#ffffff"
        }
        anchors.top: rowReserved2.bottom
        anchors.left: rowTurnLeftLights.right
        anchors.topMargin: 5
        anchors.leftMargin: 50
    }

    Row {
        id: rowCode
        x: 191
        y: 573
        width: 240
        height: 25
        Text {
            id: txtCode
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "0"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 20
            font.pixelSize: 15
        }
        anchors.top: rowReserved5.bottom
        anchors.left: rowDoorOpenSignalFrontAndRear.right
        anchors.topMargin: 5
        anchors.leftMargin: 50
    }

    onActiveChanged : {
    if ( true === bcuAnalog.active ) {
        bcuAnalog.qmlSignalActive("BCUAnalog");
    }
    }

}
