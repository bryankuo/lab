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
import "../../style"

Window {
    id: vcuAnalog

    // ( https://goo.gl/LWbdMG )
    objectName: "vcuAnalogWindow"

    // QML - main window position on start (screen center)
    // ( https://goo.gl/wLpvZD )
    Styles { id: style }
    width: style.resolutionWidth // application wide properties
    height: style.resolutionHeight
    x: 0
    y: 0
    maximumHeight: height
    maximumWidth: width
    minimumHeight: height
    minimumWidth: width
    color: "#161616"
    property alias window: vcuAnalog
    flags: Qt.FramelessWindowHint
    title: "VCU IO (Analog)"

    // Property names must begin with a lower case letter
    // and can only contain letters ( https://goo.gl/HzLQet )
    //
    //property string batteryPackName
    signal qmlSignal(string msg)
    signal qmlSignalActive(string msg)

    function updateMsg_VCU_IOSIG_MSG_Byte0(
    g_sensor,gs1,gs2,gs3,gs4,speed_s,bms_kick_vcu,start_b) {
    siGearSensorR.active = ( g_sensor == 1 ) ? true:false;
    siGearSensorS1.active = ( gs1 == 1 ) ? true:false;
    siGearSensorS2.active = ( gs2 == 1 ) ? true:false;
    siGearSensorS3.active = ( gs3 == 1 ) ? true:false;
    siGearSensorS4.active = ( gs4 == 1 ) ? true:false;
    siSpeedSensor.active = ( speed_s == 1 ) ? true:false;
    siBMSnotifiesVCU.active = ( bms_kick_vcu == 1 ) ? true:false;
    siStartupButton.active = ( start_b == 1 ) ? true:false;
    }

    function updateMsg_VCU_IOSIG_MSG_Byte1(hpc_fb, ac_fb,cpc_fb,
    cmc_fb, nw_bms, p3ko, p4start, hv_contract) {
    siHighPressureContractorFb.active = ( hpc_fb == 1 ) ? true:false;
    siAirConditionerContractorFb.active = ( ac_fb == 1 ) ? true:false;
    siChargePlusContactorFb.active = ( cpc_fb == 1 ) ? true:false;
    siChargeMinusContactorFb.active = ( cmc_fb == 1 ) ? true:false;
    siNFCWakeupBmsSignal.active = ( nw_bms == 1 ) ? true:false;
    siP3KeyOnContractor.active = ( p3ko == 1 ) ? true:false;
    sip4StartContractor.active = ( p4start == 1 ) ? true:false;
    siHighVoltageContractor.active = ( hv_contract == 1 ) ? true:false;
    }

    function updateMsg_VCU_IOSIG_MSG_Byte2(pf_contractor,ac_cntr,cp_cntr,
    cm_cntr, dcdc_cntr, lkd_cntr) {
    siPrefilledContractor.active = ( pf_contractor == 1 ) ? true:false;
    siAirConditionerContractor.active = ( ac_cntr == 1 ) ? true:false;
    siChargePlusContractor.active = ( cp_cntr == 1 ) ? true:false;
    siChargeMinusContractor.active = ( cm_cntr == 1 ) ? true:false;
    siDcdcContractor.active = ( dcdc_cntr == 1 ) ? true:false;
    siLeakageDetectModule.active = ( lkd_cntr == 1 ) ? true:false;
    }

    function updateMsg_BMS_VCU_Msg03(max_pt_temp, max_pt_idx,
    charger_cc2,charger_conn1,charger_conn2,bms_pr_state,
    mctr_state, mi_ctr_state, frelay_state, s_bms_lcounter) {
    txtBVLCounter.text = s_bms_lcounter;
    }

    Rectangle {
        id: recVcuAnalog
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
        width: style.backWidth
        height: style.backHeight
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
                vcuAnalog.hide();
            }
        }
    }

    Rectangle {
        id: rowvcuAnalog
        x: 200
        y: 30
        width: 300
        height: 43
    color: "#161616"
        anchors.leftMargin: 50
        Text {
            id: txtvcuAnalog
            y: 0
            width: 100
            height: 43
            color: "#ffffff"
            text: qsTr("VCU IO (Analog)")
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
        id: rowGearSensorR
        x: 200
        width: 300
        height: 43
    color: "#161616"
        anchors.leftMargin: 50
        anchors.topMargin: 10
        anchors.left: parent.left

        Text {
            id: txtGearSensorR
            y: 0
            width: 200
            height: 43
            color: "#ffffff"
            text: qsTr("Gear Sensor : R")
            anchors.left: siGearSensorR.right
            anchors.leftMargin: 15
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 25
        }

        StatusIndicator {
            id: siGearSensorR
            y: 87
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            anchors.left: parent.left
        }
        anchors.top: rowvcuAnalog.bottom
    }

    Rectangle {
        id: rowGearSensorS1
        x: 190
        y: 147
        width: 300
        height: 43
    color: "#161616"
        anchors.leftMargin: 50
        anchors.topMargin: 10
        anchors.left: parent.left
        Text {
            id: txtGearSensorS1
            y: 0
            width: 200
            height: 43
            color: "#ffffff"
            text: qsTr("Gear Sensor : S1")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 15
            anchors.left: siGearSensorS1.right
            font.pixelSize: 25
        }

        StatusIndicator {
            id: siGearSensorS1
            y: 87
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            anchors.left: parent.left
        }
        anchors.top: rowGearSensorR.bottom
    }

    Rectangle {
        id: rowGearSensorS2
        x: 192
        width: 300
        height: 43
    color: "#161616"
        anchors.leftMargin: 50
        anchors.topMargin: 10
        anchors.left: parent.left

        StatusIndicator {
            id: siGearSensorS2
            y: 87
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            anchors.left: parent.left
        }

        Text {
            id: txtGearSensorS2
            y: 0
            width: 200
            height: 43
            color: "#ffffff"
            text: qsTr("Gear Sensor : S2")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 15
            anchors.left: siGearSensorS2.right
            font.pixelSize: 25
        }
        anchors.top: rowGearSensorS1.bottom
    }

    Rectangle {
        id: rowGearSensorS3
        x: 199
        y: 156
        width: 300
        height: 43
    color: "#161616"
        anchors.leftMargin: 50
        anchors.topMargin: 10
        anchors.left: parent.left
        Text {
            id: txtGearSensorS3
            y: 0
            width: 200
            height: 43
            color: "#ffffff"
            text: qsTr("Gear Sensor : S3")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 15
            anchors.left: siGearSensorS3.right
            font.pixelSize: 25
        }

        StatusIndicator {
            id: siGearSensorS3
            y: 87
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            anchors.left: parent.left
        }
        anchors.top: rowGearSensorS2.bottom
    }

    Rectangle {
        id: rowGearSensorS4
        x: 201
        width: 300
        height: 43
    color: "#161616"
        anchors.leftMargin: 50
        anchors.topMargin: 10
        anchors.left: parent.left
        StatusIndicator {
            id: siGearSensorS4
            y: 87
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            anchors.left: parent.left
        }

        Text {
            id: txtGearSensorS4
            y: 0
            width: 200
            height: 43
            color: "#ffffff"
            text: qsTr("Gear Sensor : S4")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 15
            anchors.left: siGearSensorS4.right
            font.pixelSize: 25
        }
        anchors.top: rowGearSensorS3.bottom
    }

    Rectangle {
        id: rowSpeedSensor
        x: 194
        width: 300
        height: 43
    color: "#161616"
        anchors.leftMargin: 50
        anchors.topMargin: 10
        anchors.left: parent.left
        StatusIndicator {
            id: siSpeedSensor
            y: 87
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            anchors.left: parent.left
        }

        Text {
            id: txtSpeedSensor
            y: 0
            width: 200
            height: 43
            color: "#ffffff"
            text: qsTr("Speed Sensor")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 15
            anchors.left: siSpeedSensor.right
            font.pixelSize: 25
        }
        anchors.top: rowGearSensorS4.bottom
    }

    Rectangle {
        id: rowBMSnotifiesVCU
        x: 191
        y: -4
        width: 300
        height: 43
    color: "#161616"
        anchors.leftMargin: 50
        anchors.topMargin: 10
        anchors.left: parent.left
        StatusIndicator {
            id: siBMSnotifiesVCU
            y: 87
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            anchors.left: parent.left
        }

        Text {
            id: txtBMSnotifiesVCU
            y: 0
            width: 200
            height: 43
            color: "#ffffff"
            text: qsTr("BMS notifies VCU")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 15
            anchors.left: siBMSnotifiesVCU.right
            font.pixelSize: 25
        }
        anchors.top: rowSpeedSensor.bottom
    }

    Rectangle {
        id: rowStartupButton
        x: 198
        y: -8
        width: 300
        height: 43
    color: "#161616"
        anchors.leftMargin: 50
        anchors.topMargin: 10
        anchors.left: parent.left
        StatusIndicator {
            id: siStartupButton
            y: 87
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            anchors.left: parent.left
        }

        Text {
            id: txtStartupButton
            y: 0
            width: 200
            height: 43
            color: "#ffffff"
            text: qsTr("Startup Button")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 15
            anchors.left: siStartupButton.right
            font.pixelSize: 25
        }
        anchors.top: rowBMSnotifiesVCU.bottom
    }

    Rectangle {
        id: rowHighPressureContractorFb
        x: 199
        y: -6
        width: 300
        height: 43
    color: "#161616"
        anchors.leftMargin: 50
        anchors.topMargin: 10
        anchors.left: parent.left
        StatusIndicator {
            id: siHighPressureContractorFb
            y: 87
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            anchors.left: parent.left
        }

        Text {
            id: txtHighPressureContractorFb
            y: 0
            width: 200
            height: 43
            color: "#ffffff"
            text: qsTr("High Pressure(+) Contractor Feedback")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 15
            anchors.left: siHighPressureContractorFb.right
            font.pixelSize: 25
        }
        anchors.top: rowStartupButton.bottom
    }

    Rectangle {
        id: rowAirConditionerContractorFb
        x: 204
        y: -6
        width: 300
        height: 43
    color: "#161616"
        anchors.leftMargin: 50
        anchors.topMargin: 10
        anchors.left: parent.left
        StatusIndicator {
            id: siAirConditionerContractorFb
            y: 87
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            anchors.left: parent.left
        }

        Text {
            id: txtAirConditionerContractorFb
            y: 0
            width: 200
            height: 43
            color: "#ffffff"
            text: qsTr("Air Cond.(+) Contractor Feedback")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 15
            anchors.left: siAirConditionerContractorFb.right
            font.pixelSize: 25
        }
        anchors.top: rowHighPressureContractorFb.bottom
    }

    Rectangle {
        id: rowChargePlusContactorFb
        x: 198
        y: 0
        width: 300
        height: 43
    color: "#161616"
        anchors.leftMargin: 50
        anchors.topMargin: 10
        anchors.left: parent.left
        StatusIndicator {
            id: siChargePlusContactorFb
            y: 87
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            anchors.left: parent.left
        }

        Text {
            id: txtChargePlusContactorFb
            y: 0
            width: 200
            height: 43
            color: "#ffffff"
            text: qsTr("Charge(+) Contactor Fb")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 15
            anchors.left: siChargePlusContactorFb.right
            font.pixelSize: 25
        }
        anchors.top: rowAirConditionerContractorFb.bottom
    }

    Rectangle {
        id: rowChargeMinusContactorFb
        x: 207
        y: 4
        width: 300
        height: 43
    color: "#161616"
        anchors.leftMargin: 50
        anchors.topMargin: 10
        anchors.left: parent.left
        StatusIndicator {
            id: siChargeMinusContactorFb
            y: 87
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            anchors.left: parent.left
        }

        Text {
            id: txtChargeMinusContactorFb
            y: 0
            width: 200
            height: 43
            color: "#ffffff"
            text: qsTr("Charge(-) Contactor Fb")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 15
            anchors.left: siChargeMinusContactorFb.right
            font.pixelSize: 25
        }
        anchors.top: rowChargePlusContactorFb.bottom
    }

    Rectangle {
        id: rowNFCWakeupBmsSignal
        x: 207
        y: -12
        width: 300
        height: 43
    color: "#161616"
        anchors.leftMargin: 100
        anchors.topMargin: 10
        anchors.left: rowGearSensorR.right
        StatusIndicator {
            id: siNFCWakeupBmsSignal
            y: 87
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            anchors.left: parent.left
        }

        Text {
            id: txtNFCWakeupBmsSignal
            y: 0
            width: 200
            height: 43
            color: "#ffffff"
            text: qsTr("NFC Wakeup Bms Signal")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 15
            anchors.left: siNFCWakeupBmsSignal.right
            font.pixelSize: 25
        }
        anchors.top: rowvcuAnalog.bottom
    }

    Rectangle {
        id: rowP3KeyOnContractor
        x: 188
        y: 154
        width: 300
        height: 43
    color: "#161616"
        anchors.leftMargin: 100
        anchors.topMargin: 10
        anchors.left: rowGearSensorR.right
        Text {
            id: txtP3KeyOnContractor
            y: 0
            width: 200
            height: 43
            color: "#ffffff"
            text: qsTr("P3 (Key On) Contractor")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 15
            anchors.left: siP3KeyOnContractor.right
            font.pixelSize: 25
        }

        StatusIndicator {
            id: siP3KeyOnContractor
            y: 87
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            anchors.left: parent.left
        }
        anchors.top: rowNFCWakeupBmsSignal.bottom
    }

    Rectangle {
        id: rowp4StartContractor
        x: 191
        width: 300
        height: 43
    color: "#161616"
        anchors.leftMargin: 100
        anchors.topMargin: 10
        anchors.left: rowGearSensorR.right
        Text {
            id: txtp4StartContractor
            y: 0
            width: 200
            height: 43
            color: "#ffffff"
            text: qsTr("P4 (Start) Contractor")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 15
            anchors.left: sip4StartContractor.right
            font.pixelSize: 25
        }

        StatusIndicator {
            id: sip4StartContractor
            y: 87
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            anchors.left: parent.left
        }
        anchors.top: rowP3KeyOnContractor.bottom
    }

    Rectangle {
        id: rowHighVoltageContractor
        width: 350
        height: 43
        color: "#161616"
        anchors.left: rowGearSensorR.right
        anchors.leftMargin: 100
        anchors.topMargin: 10
        Text {
            id: txtHighVoltageContractor
            y: 0
            width: 200
            height: 43
            color: "#ffffff"
            text: qsTr("High Voltage Contractor")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 15
            anchors.left: siHighVoltageContractor.right
            font.pixelSize: 25
        }

        StatusIndicator {
            id: siHighVoltageContractor
            y: 87
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            anchors.left: parent.left
        }
        anchors.top: rowp4StartContractor.bottom
    }

    Rectangle {
        id: rowPrefilledContractor
        x: 7
        y: 8
        width: 300
        height: 43
    color: "#161616"
        anchors.leftMargin: 100
        anchors.topMargin: 10
        anchors.left: rowGearSensorR.right
        Text {
            id: txtPrefilledContractor
            y: 0
            width: 200
            height: 43
            color: "#ffffff"
            text: qsTr("Prefilled Contractor")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 15
            anchors.left: siPrefilledContractor.right
            font.pixelSize: 25
        }

        StatusIndicator {
            id: siPrefilledContractor
            y: 87
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            anchors.left: parent.left
        }
        anchors.top: rowHighVoltageContractor.bottom
    }

    Rectangle {
        id: rowAirConditionerContractor
        x: 2
        y: 16
        width: 300
        height: 43
    color: "#161616"
        anchors.leftMargin: 100
        anchors.topMargin: 10
        anchors.left: rowGearSensorR.right
        Text {
            id: txtAirConditionerContractor
            y: 0
            width: 200
            height: 43
            color: "#ffffff"
            text: qsTr("Air Cond.Contractor")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 15
            anchors.left: siAirConditionerContractor.right
            font.pixelSize: 25
        }

        StatusIndicator {
            id: siAirConditionerContractor
            y: 87
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            anchors.left: parent.left
        }
        anchors.top: rowPrefilledContractor.bottom
    }

    Rectangle {
        id: rowChargePlusContractor
        x: 0
        y: 12
        width: 300
        height: 43
    color: "#161616"
        anchors.leftMargin: 100
        anchors.topMargin: 10
        anchors.left: rowGearSensorR.right
        Text {
            id: txtChargePlusContractor
            y: 0
            width: 200
            height: 43
            color: "#ffffff"
            text: qsTr("Charge(+) Contractor")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 15
            anchors.left: siChargePlusContractor.right
            font.pixelSize: 25
        }

        StatusIndicator {
            id: siChargePlusContractor
            y: 87
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            anchors.left: parent.left
        }
        anchors.top: rowAirConditionerContractor.bottom
    }

    Rectangle {
        id: rowChargeMinusContractor
        y: 9
        width: 300
        height: 43
    color: "#161616"
        anchors.leftMargin: 100
        anchors.topMargin: 10
        anchors.left: rowGearSensorR.right
        Text {
            id: txtChargeMinusContractor
            y: 0
            width: 200
            height: 43
            color: "#ffffff"
            text: qsTr("Charge(-) Contractor")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 15
            anchors.left: siChargeMinusContractor.right
            font.pixelSize: 25
        }

        StatusIndicator {
            id: siChargeMinusContractor
            y: 87
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            anchors.left: parent.left
        }
        anchors.top: rowChargePlusContractor.bottom
    }

    Rectangle {
        id: rowDcdcContractor
        x: 5
        width: 300
        height: 43
    color: "#161616"
        anchors.leftMargin: 100
        anchors.topMargin: 10
        anchors.left: rowGearSensorR.right
        Text {
            id: txtDcdcContractor
            y: 0
            width: 200
            height: 43
            color: "#ffffff"
            text: qsTr("DC/DC Contractor")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 15
            anchors.left: siDcdcContractor.right
            font.pixelSize: 25
        }

        StatusIndicator {
            id: siDcdcContractor
            y: 87
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            anchors.left: parent.left
        }
        anchors.top: rowAirConditionerContractorFb.bottom
    }

    Rectangle {
        id: rowLeakageDetectModule
        x: 5
        y: 1
        width: 300
        height: 43
    color: "#161616"
        anchors.leftMargin: 100
        anchors.topMargin: 10
        anchors.left: rowGearSensorR.right
        Text {
            id: txtLeakageDetectModule
            y: 0
            width: 200
            height: 43
            color: "#ffffff"
            text: qsTr("Leakage Detect Module")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 15
            anchors.left: siLeakageDetectModule.right
            font.pixelSize: 25
        }

        StatusIndicator {
            id: siLeakageDetectModule
            y: 87
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            anchors.left: parent.left
        }
        anchors.top: rowDcdcContractor.bottom
    }

    Rectangle {
        id: rowReserved1
        x: 198
        width: 300
        height: 43
    color: "#161616"
        anchors.leftMargin: 100
        anchors.topMargin: 10
        anchors.left: rowNFCWakeupBmsSignal.right
        StatusIndicator {
            id: siReserved1
            y: 87
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            anchors.left: parent.left
        }

        Text {
            id: txtReserved1
            y: 0
            width: 200
            height: 43
            color: "#ffffff"
            text: qsTr("Reserved")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 15
            anchors.left: siReserved1.right
            font.pixelSize: 25
        }
        anchors.top: rowvcuAnalog.bottom
    }

    Rectangle {
        id: rowReserved2
        width: 300
        height: 43
    color: "#161616"
        anchors.leftMargin: 100
        anchors.topMargin: 10
        anchors.left: rowNFCWakeupBmsSignal.right
        StatusIndicator {
            id: siReserved2
            y: 87
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            anchors.left: parent.left
        }

        Text {
            id: txtReserved2
            y: 0
            width: 200
            height: 43
            color: "#ffffff"
            text: qsTr("Reserved")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 15
            anchors.left: siReserved2.right
            font.pixelSize: 25
        }
        anchors.top: rowReserved1.bottom
    }

    Rectangle {
        id: rowReserved3
        width: 300
        height: 43
    color: "#161616"

        anchors.leftMargin: 100
        anchors.topMargin: 10
        anchors.left: rowNFCWakeupBmsSignal.right
        StatusIndicator {
            id: siReserved3
            y: 87
            visible: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            anchors.left: parent.left
        }

        Text {
            id: txtBVLCounter
            y: 0
            width: 200
            height: 43
            color: "#ffffff"
            text: qsTr("0")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 15
            anchors.left: siReserved3.right
            font.pixelSize: 25
        }
        anchors.top: rowReserved2.bottom
    }

    onActiveChanged : {
        if ( true === vcuAnalog.active ) {
            vcuAnalog.qmlSignalActive("VCUAnalog");
    }
    }

}
