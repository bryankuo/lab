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
    id: brake

    // ( https://goo.gl/LWbdMG )
    objectName: "brakeWindow"

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
    property alias window: brake
    flags: Qt.FramelessWindowHint
    title: "Brake System"

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

    function updateMsg_PCUIO_SIG00_Byte0(pedal, brake, pbrake, clutch,
    rgbrake, emgstop, wpump, coolingf) {
    //console.debug("updateMsg_PCUIO_SIG00_Byte0");
    siEmgStop.active = (emgstop == 1)?true:false;
    siFootBrake.active = (brake == 1)?true:false;
    siParkingBrake.active = (pbrake == 1)?true:false;
    }

    function updateMsg_PCUIO_SIG00_Byte1(
    hy_run, hy_reset, hy_alarm, advr_reset, adrv_alarm) {
    //console.debug("updateMsg_PCUIO_SIG00_Byte1");
    siDriverRESETCommand.active = (advr_reset == 1)?true:false;
    siAirCompressorDriverAlarm.active = (adrv_alarm == 1)?true:false;
    }

    function updateMsg_PCUIO_SIG00_Byte2To7(dlta, inlet_t, outlet_t,
    pedal_depth, pcu_lc) {
    //console.debug("updateMsg_PCUIO_SIG00_Byte2To7");
    txtAirPressureVal.text  = dlta;
    }

    function updateMsg_VCU_IOSIG_MSG(
    mctactor, p3keyon, p4Start, hv_ctr, pc_ctr) {
    console.debug("updateMsg_VCU_IOSIG_MSG "+mctactor+", "
    +p3keyon+", "+p4Start+", "+hv_ctr+", "+pc_ctr);
    }

    function updateMsg_VCU_DIAG01(main_dvr_rt, main_mt_rt, penumatic_dvr_rt, penumatic_mt_rt) {
    txtDriverRunTimeVal.text = penumatic_dvr_rt;
    txtMotorRunTimeVal.text = penumatic_mt_rt;
    //console.debug("updateMsg_VCU_DIAG01 ");
    }

    function updateMsg_VCU_DIAG02(hyd_rt, hym_rt, ap_buildup_time) {
    //console.debug("updateMsg_VCU_DIAG02 "+ap_buildup_time);
    txtAirPressureBuildUpTimeVal.text = ap_buildup_time;
    // TODO: change PA symbol as well
    }

    function updateMsg_BCU_VCU_MSG0(abs_alarm, fl_lining, fr_lining,
    rl_lining, rr_lining, ecas33f, ecas_kneeling, ecas34w,
    s_bcu2vcu_lcounter) {
    siABSAlarm.active = ( abs_alarm == 1 )?true:false;
    siFLBrakeLining.active = ( fl_lining == 1 )?true:false;
    siFRBrakeLining.active = ( fr_lining == 1 )?true:false;
    siRLBrakeLining.active = ( rl_lining == 1 )?true:false;
    siRRBrakeLining.active = ( rr_lining == 1 )?true:false;
    siECASFailure.active = ( ecas33f == 1 )?true:false;
    siECASSideKneeling.active = ( ecas_kneeling == 1 )?true:false;
    siECASWarning.active = ( ecas34w == 1 )?true:false;
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
        id: imageBrakeBack
        x: 0
        width: 100
        height: 100
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
                brake.hide();
            }
        }
    }

    Rectangle {
        id: rowBrake
        x: 200
        y: 50
        width: 300
        height: 43
        color: "#161616"
        anchors.leftMargin: 50
        Text {
            id: txtBrakeWinCaption
            y: 0
            width: 100
            height: 43
            color: "#ffffff"
            text: qsTr("Brake System")
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
        id: rowDriverRunTime
        x: 202
        width: 400
        height: 40
        color: "#161616"
        Text {
            id: txtDriverRunTimeCap
            y: 0
            width: 162
            height: 25
            color: "#ffffff"
            text: qsTr("Driver Run Time :")
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: 20
        }

        Rectangle {
            id: recDriverRunTimeVal
            y: 379
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            Text {
                id: txtDriverRunTimeVal
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 20
            }
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: txtDriverRunTimeCap.right
            anchors.leftMargin: 20
        }

        Button {
            id: btnDriverRunTimeReset
            x: 1
            y: 1
            height: 40
            text: qsTr("RESET")
            anchors.verticalCenter: parent.verticalCenter
            onClicked: {
        brake.qmlSignalReset("BRKdrvRT");
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
                    border.width: control.activeFocus ? 2 : 1
                    border.color: "#888888"
                    implicitWidth: 100
                    implicitHeight: 43
                }
            }
            anchors.left: recDriverRunTimeVal.right
            anchors.leftMargin: 10
        }
        anchors.top: rowBrake.bottom
        anchors.topMargin: 50
        anchors.left: parent.left
        anchors.leftMargin: 50
    }

    Rectangle {
        id: rowMotorRunTime
        x: 208
        width: 400
        height: 40
        color: "#161616"
        Text {
            id: txtMotorRunTimeCap
            y: 0
            width: 162
            height: 25
            color: "#ffffff"
            text: qsTr("Motor Run Time :")
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: 20
        }

        Rectangle {
            id: recMotorRunTimeVal
            y: 379
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            Text {
                id: txtMotorRunTimeVal
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 20
            }
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: txtMotorRunTimeCap.right
            anchors.leftMargin: 20
        }

        Button {
            id: btnMotorRunTimeReset
            y: 1
            height: 40
            text: qsTr("RESET")
            anchors.verticalCenter: parent.verticalCenter
            onClicked: {
        brake.qmlSignalReset("BRKMVRT");
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
                    border.width: control.activeFocus ? 2 : 1
                    border.color: "#888888"
                    implicitWidth: 100
                    implicitHeight: 43
                }
            }
            anchors.left: recMotorRunTimeVal.right
            anchors.leftMargin: 10
        }
        anchors.top: rowDriverRunTime.bottom
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 50
    }

    Rectangle {
        id: rowAirPressureBuildUpTime
        x: 199
        width: 450
        height: 40
        color: "#161616"
        Text {
            id: txtAirPressureBuildUpTimeCap
            y: 0
            width: 270
            height: 25
            color: "#ffffff"
            text: qsTr("Air Pressure Build Up Time :")
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: 20
        }

        Rectangle {
            id: recAirPressureBuildUpTimeVal
            y: 379
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            Text {
                id: txtAirPressureBuildUpTimeVal
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 20
            }
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: txtAirPressureBuildUpTimeCap.right
            anchors.leftMargin: 15
        }

        Text {
            id: txtAirPressureSuffix1
            y: -3
            width: 50
            height: 25
            color: "#ffffff"
            text: qsTr("sec")
            anchors.left: recAirPressureBuildUpTimeVal.right
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 20
            z: 1
            elide: Text.ElideMiddle
            horizontalAlignment: Text.AlignHCenter
            visible: true
            verticalAlignment: Text.AlignTop
        }
        anchors.top: rowMotorRunTime.bottom
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 50
    }

    Rectangle {
        id: rowMainVoltage
        y: 133
        width: 300
        height: 40
        color: "#161616"
        z: 3
        anchors.left: parent.left
        anchors.leftMargin: 680
        Text {
            id: txtMainVoltage
            y: 0
            width: 162
            height: 25
            color: "#ffffff"
            text: qsTr("Main Voltage :")
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: 20
        }

        Rectangle {
            id: recMainVoltageVal
            y: 379
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            Text {
                id: txtMainVoltageVal
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 20
            }
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: txtMainVoltage.right
            anchors.leftMargin: 10
        }

        Text {
            id: txtMainVoltageSuffix
            y: -3
            width: 20
            height: 25
            color: "#ffffff"
            text: qsTr("V")
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: recMainVoltageVal.right
            anchors.leftMargin: 5
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 20
        }
        anchors.top: rowBrake.bottom
        anchors.topMargin: 50
    }

    Rectangle {
        id: recAirCompressorDriverAlarm
        x: 202
        y: 430
        width: 240
        height: 25
        color: "#161616"
        Text {
            id: txtAirCompressorDriverAlarm
            y: 0
            width: 200
            height: 20
            color: "#ffffff"
            text: "Air Compressor Driver Alarm"
            anchors.verticalCenter: parent.verticalCenter
            lineHeight: 0.9
            anchors.left: siAirCompressorDriverAlarm.right
            anchors.leftMargin: 20
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siAirCompressorDriverAlarm
            y: 87
            width: 20
            height: 20
            color: "#ff0000"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 0
            active: false
        }
        anchors.top: rowInput.bottom
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 50
    }

    Rectangle {
        id: recEmgStop
        x: 192
        y: -8
        width: 240
        height: 25
        color: "#161616"
        Text {
            id: txtEmgStop
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "EMG. Stop"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siEmgStop.right
            anchors.leftMargin: 20
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siEmgStop
            y: 87
            width: 20
            height: 20
            color: "#ff0000"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 0
            active: false
        }
        anchors.top: recAirCompressorDriverAlarm.bottom
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 50
    }

    Rectangle {
        id: recFootBrake
        x: 204
        y: 7
        width: 240
        height: 25
        color: "#161616"
        Text {
            id: txtFootBrake
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Foot Brake"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siFootBrake.right
            anchors.leftMargin: 20
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siFootBrake
            y: 87
            width: 20
            height: 20
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 0
            active: false
        }
        anchors.top: recEmgStop.bottom
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 50
    }

    Rectangle {
        id: recParkingBrake
        x: 213
        y: 0
        width: 240
        height: 25
        color: "#161616"
        Text {
            id: txtParkingBrake
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Parking Brake"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siParkingBrake.right
            anchors.leftMargin: 20
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siParkingBrake
            y: 87
            width: 20
            height: 20
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 0
            active: false
        }
        anchors.top: recFootBrake.bottom
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 50
    }

    Rectangle {
        id: recDriverRESETCommand
        y: -2
        width: 240
        height: 25
        color: "#161616"
        anchors.left: rowInput.right
        anchors.leftMargin: 100
        Text {
            id: txtDriverRESETCommand
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Driver RESET Command"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siDriverRESETCommand.right
            anchors.leftMargin: 20
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siDriverRESETCommand
            y: 87
            width: 20
            height: 20
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 0
            active: false
        }
        anchors.top: rowOutput.bottom
        anchors.topMargin: 10
    }

    Rectangle {
        id: recABSAlarm
        width: 240
        height: 25
        color: "#161616"
        anchors.top: rowMvInput.bottom
        anchors.topMargin: 5
        anchors.left: rowCueVertical.right
        anchors.leftMargin: 60
        Text {
            id: txtABSAlarm
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "ABS Alarm"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siABSAlarm.right
            anchors.leftMargin: 20
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siABSAlarm
            y: 87
            width: 20
            height: 20
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 0
            active: false
        }
    }

    Rectangle {
        id: rowInput
        y: 500
        width: 300
        height: 40
        color: "#161616"
        Text {
            id: txtInput
            y: 0
            width: 100
            height: 25
            color: "#ffffff"
            text: qsTr("Input :")
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: 20
        }
        anchors.topMargin: 200
        anchors.left: parent.left
        anchors.leftMargin: 50
    }

    Rectangle {
        id: rowOutput
        y: 500
        width: 300
        height: 40
        color: "#161616"
        anchors.left: rowInput.right
        anchors.leftMargin: 100
        Text {
            id: txtOutput
            y: 0
            width: 100
            height: 25
            color: "#ffffff"
            text: qsTr("Output :")
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: 20
        }
        anchors.topMargin: 200
    }

    Rectangle {
        id: rowAirPressure
        width: 290
        height: 30
        color: "#161616"
        anchors.top: recECASWarning.bottom
        anchors.left: rowCueVertical.right
        anchors.leftMargin: 30
        z: 4
        Text {
            id: txtAirPressureCap
            y: 0
            width: 120
            height: 25
            color: "#ffffff"
            text: qsTr("Air Pressure :")
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: 20
        }

        Rectangle {
            id: recAirPressureVal
            y: 379
            width: 90
            height: 25
            color: "#000000"
            radius: 5
            Text {
                id: txtAirPressureVal
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 20
            }
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: txtAirPressureCap.right
            anchors.leftMargin: 5
        }

        Text {
            id: txtAirPressureSuffix
            y: -3
            width: 70
            height: 25
            color: "#ffffff"
            text: qsTr("㎏/㎠")
            z: 1
            elide: Text.ElideMiddle
            visible: true
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: recAirPressureVal.right
            anchors.leftMargin: 0
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 20
        }
        anchors.topMargin: 50
    }

    Rectangle {
        id: rowMvInput
        width: 150
        height: 40
        color: "#161616"
        anchors.left: rowCueVertical.right
        anchors.leftMargin: 60
        anchors.top: rowBrake.bottom
        anchors.topMargin: 50
        Text {
            id: txtMvInput
            y: 0
            width: 100
            height: 25
            color: "#ffffff"
            text: qsTr("Input :")
            font.pixelSize: 20
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 0
            anchors.verticalCenterOffset: 0
            horizontalAlignment: Text.AlignLeft
        }
    }

    Rectangle {
        id: recFLBrakeLining
        width: 240
        height: 25
        color: "#161616"
        anchors.left: rowCueVertical.right
        anchors.leftMargin: 60
        anchors.topMargin: 5
        anchors.top: recABSAlarm.bottom
        Text {
            id: txtFLBrakeLining
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "FL Brake Lining"
            font.pixelSize: 15
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siFLBrakeLining.right
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 20
            horizontalAlignment: Text.AlignLeft
        }

        StatusIndicator {
            id: siFLBrakeLining
            y: 87
            width: 20
            height: 20
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            active: false
            anchors.left: parent.left
            anchors.leftMargin: 0
        }
    }

    Rectangle {
        id: recRLBrakeLining
        y: 11
        width: 240
        height: 25
        color: "#161616"
        anchors.left: rowCueVertical.right
        anchors.leftMargin: 60
        anchors.topMargin: 5
        anchors.top: recFRBrakeLining.bottom
        Text {
            id: txtRLBrakeLining
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "RL Brake Lining"
            font.pixelSize: 15
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siRLBrakeLining.right
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 20
            horizontalAlignment: Text.AlignLeft
        }

        StatusIndicator {
            id: siRLBrakeLining
            y: 87
            width: 20
            height: 20
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            active: false
            anchors.left: parent.left
            anchors.leftMargin: 0
        }
    }

    Rectangle {
        id: recFRBrakeLining
        y: 271
        width: 240
        height: 25
        color: "#161616"
        anchors.left: rowCueVertical.right
        anchors.leftMargin: 60
        anchors.topMargin: 5
        anchors.top: recFLBrakeLining.bottom
        Text {
            id: txtFRBrakeLining
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "FR Brake Lining"
            font.pixelSize: 15
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siFRBrakeLining.right
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 20
            horizontalAlignment: Text.AlignLeft
        }

        StatusIndicator {
            id: siFRBrakeLining
            y: 87
            width: 20
            height: 20
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            active: false
            anchors.left: parent.left
            anchors.leftMargin: 0
        }
    }

    Rectangle {
        id: recRRBrakeLining
        width: 240
        height: 25
        color: "#161616"
        anchors.left: rowCueVertical.right
        anchors.leftMargin: 60
        anchors.topMargin: 5
        anchors.top: recRLBrakeLining.bottom
        Text {
            id: txtRRBrakeLining
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "RR Brake Lining"
            font.pixelSize: 15
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siRRBrakeLining.right
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 20
            horizontalAlignment: Text.AlignLeft
        }

        StatusIndicator {
            id: siRRBrakeLining
            y: 87
            width: 20
            height: 20
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            active: false
            anchors.left: parent.left
            anchors.leftMargin: 0
        }
    }

    Rectangle {
        id: recECASFailure
        y: -4
        width: 240
        height: 25
        color: "#161616"
        anchors.left: rowCueVertical.right
        anchors.leftMargin: 60
        anchors.topMargin: 5
        anchors.top: recRRBrakeLining.bottom
        Text {
            id: txtECASFailure
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "ECAS Failure"
            font.pixelSize: 15
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siECASFailure.right
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 20
            horizontalAlignment: Text.AlignLeft
        }

        StatusIndicator {
            id: siECASFailure
            y: 87
            width: 20
            height: 20
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            active: false
            anchors.left: parent.left
            anchors.leftMargin: 0
        }
    }

    Rectangle {
        id: recECASSideKneeling
        y: -12
        width: 240
        height: 25
        color: "#161616"
        anchors.left: rowCueVertical.right
        anchors.leftMargin: 60
        anchors.topMargin: 5
        anchors.top: recECASFailure.bottom
        Text {
            id: txtECASSideKneeling
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "ECAS Side Kneeling"
            font.pixelSize: 15
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siECASSideKneeling.right
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 20
            horizontalAlignment: Text.AlignLeft
        }

        StatusIndicator {
            id: siECASSideKneeling
            y: 87
            width: 20
            height: 20
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            active: false
            anchors.left: parent.left
            anchors.leftMargin: 0
        }
    }

    Rectangle {
        id: recECASWarning
        y: -10
        width: 240
        height: 25
        color: "#161616"
        anchors.left: rowCueVertical.right
        anchors.leftMargin: 60
        anchors.topMargin: 5
        anchors.top: recECASSideKneeling.bottom
        Text {
            id: txtECASWarning
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "ECAS Warning"
            font.pixelSize: 15
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siECASWarning.right
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 20
            horizontalAlignment: Text.AlignLeft
        }

        StatusIndicator {
            id: siECASWarning
            y: 87
            width: 20
            height: 20
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            active: false
            anchors.left: parent.left
            anchors.leftMargin: 0
        }
    }

    Rectangle {
        id: rowCueHorizontal
        x: 0
        y: 300
        width: 940
        height: 100
        color: "#161616"

        Image {
            id: imgPcuIn
            y: 10
            width: 100
            height: 100
            anchors.leftMargin: 100
            z: 2
            fillMode: Image.PreserveAspectFit
            source: "../../images/0-color/input_2pcu.png"
            anchors.verticalCenter: parent.verticalCenter
            sourceSize.width: 116
            anchors.left: parent.left
            sourceSize.height: 80
        }

        Image {
            id: imgPCU
            y: 50
            width: 100
            height: 100
            anchors.leftMargin: 100
            anchors.verticalCenterOffset: 0
            fillMode: Image.PreserveAspectFit
            source: "../../images/0-color/pcu.png"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: imgPcuIn.right
        }

        Image {
            id: imgPcuOut
            x: -9
            y: 41
            width: 200
            height: 100
            anchors.leftMargin: 100
            fillMode: Image.PreserveAspectFit
            source: "../../images/0-color/pcu_output.png"
            anchors.verticalCenter: parent.verticalCenter
            sourceSize.width: 235
            anchors.left: imgPCU.right
            sourceSize.height: 86
        }
    }

    Rectangle {
        id: rowCueVertical
        x: 841
        y: 0
        width: 100
        height: 800
        color: "#161616"
        z: 2
        anchors.left: parent.left
        anchors.leftMargin: 840
        border.color: "#161616"

        Image {
            id: imgHVPC
            x: 590
            y: 190
            width: 100
            height: 100
            z: 1
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
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 300
            fillMode: Image.PreserveAspectFit
            source: "../../images/0-color/pa_grey.png"
        }

        Image {
            id: imgMT
            x: 869
            width: 100
            height: 100
            anchors.top: imgPA.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 130
            fillMode: Image.PreserveAspectFit
            source: "../../images/0-color/mt_grey_vstroke.png"
        }

        Image {
            id: imgWiring
            x: 859
            y: 0
            width: 70
            height: 200
            visible: false
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 10
            source: "../../images/0-color/vstroke.png"
            anchors.top: imgPA.bottom
            fillMode: Image.Stretch
        }
    }

    Image {
        id: imgCompressor
        width: 195
        height: 150
        sourceSize.height: 197
        sourceSize.width: 390
        anchors.left: rowCueVertical.right
        anchors.leftMargin: 5
        fillMode: Image.PreserveAspectFit
        anchors.topMargin: 20
        anchors.top: rowAirPressure.bottom
        source: "../../images/0-color/compressor.png"
    }

    onActiveChanged : {
    if ( true === brake.active ) {
        brake.qmlSignalActive("Brake");
    }
    }

}































































































































/*##^## Designer {
    D{i:9;anchors_y:247}D{i:19;anchors_y:248}D{i:23;anchors_x:1}D{i:29;anchors_y:2}D{i:32;anchors_y:143}
D{i:33;anchors_x:203}D{i:51;anchors_x:213}D{i:53;anchors_x:900;anchors_y:2}D{i:59;anchors_x:0}
D{i:60;anchors_x:800;anchors_y:500}D{i:65;anchors_x:900}D{i:67;anchors_x:900}D{i:70;anchors_x:900}
D{i:73;anchors_x:900}D{i:76;anchors_x:900}D{i:79;anchors_x:900}D{i:82;anchors_x:900}
D{i:87;anchors_width:70}D{i:85;anchors_x:901}D{i:96;anchors_x:869}D{i:92;anchors_x:0}
}
 ##^##*/
