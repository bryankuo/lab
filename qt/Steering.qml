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
    id: steering

    // ( https://goo.gl/LWbdMG )
    objectName: "steeringWindow"

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
    property alias window: steering
    flags: Qt.FramelessWindowHint
    title: "Steering System"

    // Property names must begin with a lower case letter
    // and can only contain letters ( https://goo.gl/HzLQet )
    //
    signal qmlSignalActive(string msg)
    signal qmlSignalReset(string msg)

    function updateBMS_VCU_MSG01(s_voltage,s_current,soc,b_status,
    f_level,mcntctr_nc,mcntctr_st,pcell_alrm,s_cremains) {
    console.debug("v "+s_voltage+" a "+s_current+" soc "+soc
        +" b "+b_status+" fl "+f_level+" mctn "+mcntctr_nc
        +" mcts "+mcntctr_st+" pcal "+pcell_alrm
        +" crmn "+s_cremains);
    txtMainVoltageVal.text = s_voltage;
    }

    function updateMsg_PCUIO_SIG00_Byte0(pedal, brake, pbrake, clutch,
    rgbrake, emgstop, wpump, coolingf) {
    //console.debug("updateMsg_PCUIO_SIG00_Byte0");
    siEmgStop.active = (emgstop == 1)?true:false;
    siAccelPedal.active = (pedal == 1)?true:false;
    }

    function updateMsg_PCUIO_SIG00_Byte1(
    hy_run, hy_reset, hy_alarm,advr_reset, adrv_alarm) {
    //console.debug("updateMsg_PCUIO_SIG00_Byte1");
    siDrvRunCmd.active = (hy_run == 1)?true:false;
    siDrvRstCmd.active = (hy_reset == 1)?true:false;
    siHydraulicDriverAlarmIndicator.active = (hy_alarm == 1)?true:false;
    }

    function updateMsg_VCU_DIAG02(hyd_rt, hym_rt, ap_buildup_time) {
    //console.debug("updateMsg_VCU_DIAG02 "+ap_buildup_time);
    txtHydraulicDriverRunTimeVal.text = hyd_rt;
    txtHydraulicMotorRunTimeVal.text = hym_rt;
    // TODO: change PA symbol as well
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
        id: imageSteeringBack
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
                steering.hide();
            }
        }
    }

    Rectangle {
        id: rowSteering
        x: 200
        y: 50
        width: 300
        height: 43
        color: "#161616"
        anchors.leftMargin: 50
        Text {
            id: txtSteeringWinCaption
            y: 0
            width: 100
            height: 43
            color: "#ffffff"
            text: qsTr("Steering System")
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
        id: rowHydraulicDriverRunTime
        x: 202
        width: 550
        height: 40
        color: "#161616"
        anchors.leftMargin: 50
        Text {
            id: txtHydraulicDriverRunTimeCap
            y: 0
            width: 280
            height: 25
            color: "#ffffff"
            text: qsTr("Hydraulic Driver Run Time :")
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 20
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.left: parent.left
            anchors.verticalCenterOffset: 0
        }

        Rectangle {
            id: recHydraulicDriverRunTimeVal
            y: 379
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            Text {
                id: txtHydraulicDriverRunTimeVal
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 20
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
            anchors.left: txtHydraulicDriverRunTimeCap.right
        }

        Button {
            id: btnHydraulicDriverRunTimeReset
            x: 1
            y: 1
            height: 40
            text: qsTr("RESET")
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            onClicked: {
        steering.qmlSignalReset("HdDrvRT");
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
            anchors.left: recHydraulicDriverRunTimeVal.right
        }
        anchors.topMargin: 50
        anchors.left: parent.left
        anchors.top: rowSteering.bottom
    }

    Rectangle {
        id: rowHydraulicMotorRunTime
        x: 208
        y: 162
        width: 550
        height: 40
        color: "#161616"
        anchors.leftMargin: 50
        Text {
            id: txtMotorRunTimeCap
            y: 0
            width: 280
            height: 25
            color: "#ffffff"
            text: qsTr("Hydraulic Motor Run Time :")
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 20
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.left: parent.left
            anchors.verticalCenterOffset: 0
        }

        Rectangle {
            id: recHydraulicMotorRunTimeVal
            y: 379
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            Text {
                id: txtHydraulicMotorRunTimeVal
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 20
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
            anchors.left: txtMotorRunTimeCap.right
        }

        Button {
            id: btnHydraulicMotorRunTimeReset
            x: 1
            y: 1
            height: 40
            text: qsTr("RESET")
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            onClicked: {
        steering.qmlSignalReset("HdMtrRT");
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
            anchors.left: recHydraulicMotorRunTimeVal.right
        }
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.top: rowHydraulicDriverRunTime.bottom
    }

    Rectangle {
        id: rowMainVoltage
        x: 680
        y: 133
        width: 300
        height: 40
        color: "#161616"
        z: 3
        anchors.leftMargin: 680
        Text {
            id: txtMainVoltage
            y: 0
            width: 162
            height: 25
            color: "#ffffff"
            text: qsTr("Main Voltage :")
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 20
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.left: parent.left
            anchors.verticalCenterOffset: 0
        }

        Rectangle {
            id: recMainVoltageVal
            y: 379
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            Text {
                id: txtMainVoltageVal
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 20
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
            anchors.left: txtMainVoltage.right
        }

        Text {
            id: txtMainVoltageSuffix
            y: -3
            width: 20
            height: 25
            color: "#ffffff"
            text: qsTr("V")
            anchors.leftMargin: 5
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 20
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.left: recMainVoltageVal.right
        }
        anchors.topMargin: 50
        anchors.left: parent.left
        anchors.top: rowSteering.bottom
    }

    Rectangle {
        id: recAccelPedal
        x: 202
        y: 430
        width: 240
        height: 25
        color: "#161616"
        anchors.leftMargin: 50
        anchors.left: parent.left
        anchors.topMargin: 10
        anchors.top: rowInput.bottom
        Text {
            id: txtAccelPedal
            y: 0
            width: 90
            height: 20
            color: "#ffffff"
            text: "Accel. Pedal"
            lineHeight: 0.9
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 20
            anchors.left: siAccelPedal.right
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 15
            horizontalAlignment: Text.AlignLeft
        }

        StatusIndicator {
            id: siAccelPedal
            y: 87
            width: 20
            height: 20
            color: "#ffffff"
            anchors.leftMargin: 0
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            active: false
        }
    }

    Rectangle {
        id: recEmgStop
        x: 192
        y: -8
        width: 240
        height: 25
        color: "#161616"
        anchors.leftMargin: 50
        anchors.left: parent.left
        anchors.topMargin: 10
        anchors.top: recAccelPedal.bottom
        Text {
            id: txtEmgStop
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "EMG. Stop"
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 20
            anchors.left: siEmgStop.right
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 15
            horizontalAlignment: Text.AlignLeft
        }

        StatusIndicator {
            id: siEmgStop
            y: 87
            width: 20
            height: 20
            color: "#ff0000"
            anchors.leftMargin: 0
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            active: false
        }
    }

    Rectangle {
        id: recHydraulicDriverAlarmIndicator
        x: 204
        y: 7
        width: 240
        height: 25
        color: "#161616"
        anchors.leftMargin: 50
        anchors.left: parent.left
        anchors.topMargin: 10
        anchors.top: recEmgStop.bottom
        Text {
            id: txtHydraulicDriverAlarmIndicator
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Hydraulic Driver Alarm Indicator"
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 20
            anchors.left: siHydraulicDriverAlarmIndicator.right
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 15
            horizontalAlignment: Text.AlignLeft
        }

        StatusIndicator {
            id: siHydraulicDriverAlarmIndicator
            y: 87
            width: 20
            height: 20
            color: "#ffffff"
            anchors.leftMargin: 0
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            active: false
        }
    }

    Rectangle {
        id: recDrvRunCmd
        x: 213
        y: -2
        width: 240
        height: 25
        color: "#161616"
        anchors.leftMargin: 100
        anchors.left: rowInput.right
        anchors.topMargin: 10
        anchors.top: rowOutput.bottom
        Text {
            id: txtDrvRunCmd
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Driver RUN Command"
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 20
            anchors.left: siDrvRunCmd.right
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 15
            horizontalAlignment: Text.AlignLeft
        }

        StatusIndicator {
            id: siDrvRunCmd
            y: 87
            width: 20
            height: 20
            color: "#ffffff"
            anchors.leftMargin: 0
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            active: false
        }
    }

    Rectangle {
        id: recDrvRstCmd
        x: 208
        y: 2
        width: 240
        height: 25
        color: "#161616"
        anchors.leftMargin: 100
        anchors.left: rowInput.right
        anchors.topMargin: 10
        anchors.top: recDrvRunCmd.bottom
        Text {
            id: txtDrvRstCmd
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Driver RESET Command"
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 20
            anchors.left: siDrvRstCmd.right
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 15
            horizontalAlignment: Text.AlignLeft
        }

        StatusIndicator {
            id: siDrvRstCmd
            y: 87
            width: 20
            height: 20
            color: "#ffffff"
            anchors.leftMargin: 0
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            active: false
        }
    }

    Rectangle {
        id: rowInput
        y: 500
        width: 300
        height: 40
        color: "#161616"
        anchors.leftMargin: 50
        anchors.left: parent.left
        anchors.topMargin: 200
        Text {
            id: txtInput
            y: 0
            width: 100
            height: 25
            color: "#ffffff"
            text: qsTr("Input :")
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 0
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 0
            font.pixelSize: 20
            horizontalAlignment: Text.AlignLeft
        }
    }

    Rectangle {
        id: rowOutput
        x: 0
        y: 500
        width: 300
        height: 40
        color: "#161616"
        anchors.leftMargin: 100
        anchors.left: rowInput.right
        anchors.topMargin: 200
        Text {
            id: txtOutput
            y: 0
            width: 100
            height: 25
            color: "#ffffff"
            text: qsTr("Output :")
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 0
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 0
            font.pixelSize: 20
            horizontalAlignment: Text.AlignLeft
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
            anchors.left: parent.left
            sourceSize.height: 80
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 100
            source: "../../images/0-color/input_2pcu.png"
            z: 2
            fillMode: Image.PreserveAspectFit
            sourceSize.width: 116
        }

        Image {
            id: imgPCU
            y: 50
            width: 100
            height: 100
            anchors.left: imgPcuIn.right
            anchors.verticalCenterOffset: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 100
            source: "../../images/0-color/pcu.png"
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: imgPcuOut
            x: -9
            y: 41
            width: 200
            height: 100
            anchors.left: imgPCU.right
            sourceSize.height: 86
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 100
            source: "../../images/0-color/pcu_output.png"
            fillMode: Image.PreserveAspectFit
            sourceSize.width: 235
        }
    }

    Rectangle {
        id: rowCueVertical
        x: 841
        y: 0
        width: 100
        height: 800
        color: "#161616"
        anchors.left: parent.left
        Image {
            id: imgHVPC
            x: 590
            y: 190
            width: 100
            height: 100
            anchors.horizontalCenter: parent.horizontalCenter
            source: "../../images/0-color/hvpc_fb_off.png"
            z: 1
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: imgPA
            x: 139
            y: 0
            width: 100
            height: 100
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 300
            source: "../../images/0-color/pa_grey.png"
            anchors.top: parent.top
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: imgMT
            x: 869
            width: 100
            height: 100
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 130
            source: "../../images/0-color/mt_grey_vstroke.png"
            anchors.top: imgPA.bottom
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: imgWiring
            x: 859
            y: 0
            width: 70
            height: 200
            anchors.horizontalCenter: parent.horizontalCenter
            visible: false
            anchors.topMargin: 10
            source: "../../images/0-color/vstroke.png"
            anchors.top: imgPA.bottom
            fillMode: Image.Stretch
        }
        anchors.leftMargin: 840
        z: 2
        border.color: "#161616"
    }

    Image {
        id: imgGear
        x: 1000
        y: 520
        width: 195
        height: 150
        anchors.left: rowCueVertical.right
        sourceSize.height: 197
        anchors.leftMargin: 120
        anchors.topMargin: 20
        source: "../../images/0-color/steering.png"
        fillMode: Image.PreserveAspectFit
        sourceSize.width: 390
    }

    Image {
        id: imgWire
        x: 139
        y: 0
        width: 100
        height: 70
        anchors.horizontalCenterOffset: 360
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 560
        source: "../../images/0-color/hstroke.png"
        anchors.top: parent.top
        fillMode: Image.PreserveAspectFit
    }

    onActiveChanged : {
        if ( true === steering.active ) {
        steering.qmlSignalActive("Steering");
    }
    }

}







































/*##^## Designer {
    D{i:8;anchors_y:161}D{i:60;anchors_x:869}D{i:56;anchors_x:0}
}
 ##^##*/
