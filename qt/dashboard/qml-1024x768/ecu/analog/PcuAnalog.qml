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
    id: pcuAnalog

    // ( https://goo.gl/LWbdMG )
    objectName: "pcuAnalog"

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
    property alias window: pcuAnalog
    flags: Qt.FramelessWindowHint
    title: "PCU IO (Analog)"

    // Property names must begin with a lower case letter
    // and can only contain letters ( https://goo.gl/HzLQet )
    //
    //property string batteryPackName
    signal qmlSignal(string msg)
    signal qmlSignalActive(string msg)

    function updateMsg_PCUIO_SIG00_Byte0(pedal, brake, pbrake, clutch,
    rgbrake, emgstop, wpump, coolingf) {
    //console.debug("updateMsg_PCUIO_SIG00_Byte0");
    siAcceleratorPedal.active = (pedal === 1)?true:false;
    siFootBrake.active = (brake === 1)?true:false;
    siParkingBrake.active = (pbrake === 1)?true:false;
    siClutchPedal.active = (clutch === 1)?true:false;
    siRegenerativeBrake.active = (rgbrake === 1)?true:false;
    siEmergencyStop.active = (emgstop === 1)?true:false;
    siWaterPump.active = (wpump === 1)?true:false;
    siCoolingFan.active = (coolingf === 1)?true:false;
    }

    function updateMsg_PCUIO_SIG00_Byte1(
    hy_run, hy_reset, hy_alarm, advr_reset, adrv_alarm) {
    //console.debug("updateMsg_PCUIO_SIG00_Byte1");
    siHydraulicDriverRUN.active = (hy_run === 1)?true:false;
    siHydraulicDriverRESET.active = (hy_reset === 1)?true:false;
    siOilPressureIndication.active = (hy_alarm === 1)?true:false;
    siPneumaticDriverRESET.active = (advr_reset === 1)?true:false;
    siAirPressureAbnormal.active = (adrv_alarm === 1)?true:false;
    }

    function updateMsg_PCUIO_SIG00_Byte2To7(dlta, inlet_t, outlet_t,
    pedal_depth, pcu_lc) {
    //console.debug("updateMsg_PCUIO_SIG00_Byte2To7");
    txtPCULiveCounter.text = pcu_lc;
    }

    Rectangle {
        id: recPcuAnalog
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
        pcuAnalog.hide();
        }
    }
    }

    Rectangle {
        id: rowpcuAnalog
        x: 200
        y: 30
        width: 300
        height: 43
    color: "#161616"
        anchors.leftMargin: 50
        Text {
            id: txtpcuAnalog
            y: 0
            width: 100
            height: 43
            color: "#ffffff"
            text: qsTr("PCU IO (Analog)")
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
        id: rowAcceleratorPedal
        x: 200
        width: 300
        height: 43
    color: "#161616"
        anchors.leftMargin: 50
        anchors.topMargin: 10
        anchors.left: parent.left

        Text {
            id: txtAcceleratorPedal
            y: 0
            width: 200
            height: 43
            color: "#ffffff"
            text: qsTr("Accelerator Pedal")
            anchors.left: siAcceleratorPedal.right
            anchors.leftMargin: 15
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 25
        }

        StatusIndicator {
            id: siAcceleratorPedal
            y: 87
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            anchors.left: parent.left
        }
        anchors.top: rowpcuAnalog.bottom
    }

    Rectangle {
        id: rowFootBrake
        x: 190
        y: 147
        width: 300
        height: 43
    color: "#161616"
        anchors.leftMargin: 50
        anchors.topMargin: 10
        anchors.left: parent.left
        Text {
            id: txtFootBrake
            y: 0
            width: 200
            height: 43
            color: "#ffffff"
            text: qsTr("Foot Brake")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 15
            anchors.left: siFootBrake.right
            font.pixelSize: 25
        }

        StatusIndicator {
            id: siFootBrake
            y: 87
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            anchors.left: parent.left
        }
        anchors.top: rowAcceleratorPedal.bottom
    }

    Rectangle {
        id: rowParkingBrake
        x: 192
        width: 300
        height: 43
    color: "#161616"
        anchors.leftMargin: 50
        anchors.topMargin: 10
        anchors.left: parent.left

        StatusIndicator {
            id: siParkingBrake
            y: 87
            color: "#ffffff"
            active: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            anchors.left: parent.left
        }

        Text {
            id: txtParkingBrake
            y: 0
            width: 200
            height: 43
            color: "#ffffff"
            text: qsTr("Parking Brake")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 15
            anchors.left: siParkingBrake.right
            font.pixelSize: 25
        }
        anchors.top: rowFootBrake.bottom
    }

    Rectangle {
        id: rowClutchPedal
        x: 199
        y: 156
        width: 300
        height: 43
    color: "#161616"
        anchors.leftMargin: 50
        anchors.topMargin: 10
        anchors.left: parent.left
        Text {
            id: txtClutchPedal
            y: 0
            width: 200
            height: 43
            color: "#ffffff"
            text: qsTr("Clutch Pedal")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 15
            anchors.left: siClutchPedal.right
            font.pixelSize: 25
        }

        StatusIndicator {
            id: siClutchPedal
            y: 87
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            anchors.left: parent.left
        }
        anchors.top: rowParkingBrake.bottom
    }

    Rectangle {
        id: rowRegenerativeBrake
        x: 201
        width: 300
        height: 43
    color: "#161616"
        anchors.leftMargin: 50
        anchors.topMargin: 10
        anchors.left: parent.left
        StatusIndicator {
            id: siRegenerativeBrake
            y: 87
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            anchors.left: parent.left
        }

        Text {
            id: txtRegenerativeBrake
            y: 0
            width: 200
            height: 43
            color: "#ffffff"
            text: qsTr("Regenerative Brake")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 15
            anchors.left: siRegenerativeBrake.right
            font.pixelSize: 25
        }
        anchors.top: rowClutchPedal.bottom
    }

    Rectangle {
        id: rowEmergencyStop
        x: 194
        width: 300
        height: 43
    color: "#161616"
        anchors.leftMargin: 50
        anchors.topMargin: 10
        anchors.left: parent.left
        StatusIndicator {
            id: siEmergencyStop
            y: 87
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            anchors.left: parent.left
        }

        Text {
            id: txtEmergencyStop
            y: 0
            width: 200
            height: 43
            color: "#ffffff"
            text: qsTr("Emergency Stop")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 15
            anchors.left: siEmergencyStop.right
            font.pixelSize: 25
        }
        anchors.top: rowRegenerativeBrake.bottom
    }

    Rectangle {
        id: rowWaterPump
        x: 191
        y: -4
        width: 300
        height: 43
    color: "#161616"
        anchors.leftMargin: 50
        anchors.topMargin: 10
        anchors.left: parent.left
        StatusIndicator {
            id: siWaterPump
            y: 87
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            anchors.left: parent.left
        }

        Text {
            id: txtWaterPump
            y: 0
            width: 200
            height: 43
            color: "#ffffff"
            text: qsTr("Water Pump")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 15
            anchors.left: siWaterPump.right
            font.pixelSize: 25
        }
        anchors.top: rowEmergencyStop.bottom
    }

    Rectangle {
        id: rowCoolingFan
        x: 198
        y: -8
        width: 300
        height: 43
    color: "#161616"
        anchors.leftMargin: 50
        anchors.topMargin: 10
        anchors.left: parent.left
        StatusIndicator {
            id: siCoolingFan
            y: 87
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            anchors.left: parent.left
        }

        Text {
            id: txtCoolingFan
            y: 0
            width: 200
            height: 43
            color: "#ffffff"
            text: qsTr("Cooling Fan")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 15
            anchors.left: siCoolingFan.right
            font.pixelSize: 25
        }
        anchors.top: rowWaterPump.bottom
    }

    Rectangle {
        id: rowHydraulicDriverRUN
        x: 199
        y: -6
        width: 300
        height: 43
    color: "#161616"
        anchors.leftMargin: 50
        anchors.topMargin: 10
        anchors.left: parent.left
        StatusIndicator {
            id: siHydraulicDriverRUN
            y: 87
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            anchors.left: parent.left
        }

        Text {
            id: txtHydraulicDriverRUN
            y: 0
            width: 200
            height: 43
            color: "#ffffff"
            text: qsTr("Hydraulic Driver RUN")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 15
            anchors.left: siHydraulicDriverRUN.right
            font.pixelSize: 25
        }
        anchors.top: rowCoolingFan.bottom
    }

    Rectangle {
        id: rowHydraulicDriverRESET
        x: 204
        y: -6
        width: 300
        height: 43
    color: "#161616"
        anchors.leftMargin: 50
        anchors.topMargin: 10
        anchors.left: parent.left
        StatusIndicator {
            id: siHydraulicDriverRESET
            y: 87
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            anchors.left: parent.left
        }

        Text {
            id: txtHydraulicDriverRESET
            y: 0
            width: 200
            height: 43
            color: "#ffffff"
            text: qsTr("Hydraulic Driver RESET")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 15
            anchors.left: siHydraulicDriverRESET.right
            font.pixelSize: 25
        }
        anchors.top: rowHydraulicDriverRUN.bottom
    }

    Rectangle {
        id: rowPneumaticDriverRESET
        x: 198
        y: 0
        width: 300
        height: 43
    color: "#161616"
        anchors.leftMargin: 50
        anchors.topMargin: 10
        anchors.left: parent.left
        StatusIndicator {
            id: siPneumaticDriverRESET
            y: 87
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            anchors.left: parent.left
        }

        Text {
            id: txtPneumaticDriverRESET
            y: 0
            width: 200
            height: 43
            color: "#ffffff"
            text: "Pneumatic Driver RESET"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 15
            anchors.left: siPneumaticDriverRESET.right
            font.pixelSize: 25
        }
        anchors.top: rowOilPressureIndication.bottom
    }

    Rectangle {
        id: rowAirPressureAbnormal
        x: 207
        y: 4
        width: 300
        height: 43
    color: "#161616"
        anchors.leftMargin: 50
        anchors.topMargin: 10
        anchors.left: rowAcceleratorPedal.right
        StatusIndicator {
            id: siAirPressureAbnormal
            y: 87
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            anchors.left: parent.left
        }

        Text {
            id: txtAirPressureAbnormal
            y: 0
            width: 200
            height: 43
            color: "#ffffff"
            text: qsTr("Air Pressure Abnormal")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 15
            anchors.left: siAirPressureAbnormal.right
            font.pixelSize: 25
        }
        anchors.top: rowpcuAnalog.bottom
    }

    Rectangle {
        id: rowReserved0
        x: 207
        width: 300
        height: 43
        anchors.leftMargin: 50
        anchors.topMargin: 10
        color: "#161616"
        anchors.left: rowAcceleratorPedal.right
        StatusIndicator {
            id: siReserved0
            y: 87
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            anchors.left: parent.left
        }

        Text {
            id: txtReserved0
            y: 0
            width: 200
            height: 43
            color: "#ffffff"
            text: qsTr("Reserved")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 15
            anchors.left: siReserved0.right
            font.pixelSize: 25
        }
        anchors.top: rowAirPressureAbnormal.bottom
    }

    Rectangle {
        id: rowsiReserved1
        x: 188
        y: 154
        width: 300
        height: 43
    color: "#161616"
        anchors.leftMargin: 50
        anchors.topMargin: 10
        anchors.left: rowAcceleratorPedal.right
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

        StatusIndicator {
            id: siReserved1
            y: 87
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            anchors.left: parent.left
        }
        anchors.top: rowReserved0.bottom
    }

    Rectangle {
        id: rowPcuLiveCounter
        x: 191
        width: 300
        height: 43
        color: "#161616"
        anchors.leftMargin: 50
        anchors.topMargin: 10
        anchors.left: rowAcceleratorPedal.right
        Text {
            id: txtPCULiveCounter
            y: 0
            width: 200
            height: 43
            color: "#ffffff"
            text: qsTr("0")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 15
            anchors.left: siP4KeyOnContractor.right
            font.pixelSize: 25
        }

        StatusIndicator {
            id: siP4KeyOnContractor
            y: 87
            visible: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            anchors.left: parent.left
        }
        anchors.top: rowsiReserved1.bottom
    }

    Rectangle {
        id: rowOilPressureIndication
        x: 194
        y: -14
        width: 300
        height: 43
        color: "#161616"
        StatusIndicator {
            id: siOilPressureIndication
            y: 87
            color: "#ffffff"
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
        }

        Text {
            id: txtOilPressureIndication
            y: 0
            width: 200
            height: 43
            color: "#ffffff"
            text: qsTr("Oil Pressure Indication")
            font.pixelSize: 25
            anchors.leftMargin: 15
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.left: siOilPressureIndication.right
        }
        anchors.leftMargin: 50
        anchors.top: rowHydraulicDriverRESET.bottom
        anchors.left: parent.left
        anchors.topMargin: 10
    }

    onActiveChanged : {
    if ( true === pcuAnalog.active ) {
        pcuAnalog.qmlSignalActive("PCUAnalog");
    }
    }

}
