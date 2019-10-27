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
// import QtQuick.Layouts 1.1
import "style"

Window {
    id: vehicle

    // ( https://goo.gl/LWbdMG )
    objectName: "vehicleInfoWindow"
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
    property alias window: vehicle
    flags: Qt.FramelessWindowHint
    title: "Vehicle"

    // Property names must begin with a lower case letter
    // and can only contain letters ( https://goo.gl/HzLQet )
    //
    //property string batteryPackName
    signal qmlSignal(string msg)
    signal qmlSignalActive(string msg)

    Rectangle {
        id: rectangleVehicle

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
        id: imageViBack
        x: 0
        width: 80
        height: 80
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
        width: 80
        height: 80

        }
        source: "../images/0-color/HMI-ICON-55.png"
        fillMode: Image.PreserveAspectFit
    MouseArea {
        id: maViBack
        z: 2
        anchors.fill: parent
        onClicked: {
        vehicle.hide();
        }
        width: 80
        height: 80

    }
    }

    Rectangle {
        id: rowVehicleInfo
        x: 200
        y: 30
        width: 300
        height: 43
    color: "#161616"
        anchors.leftMargin: 50
        Text {
            id: txtVehicleInfo
            y: 0
            width: 100
            height: 43
            color: "#ffffff"
            text: qsTr("Vehicle Information")
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

    Button {
    id: btnTraction
    width: 150
    height: 86
    text: qsTr("Traction")
    anchors.left: parent.left
    anchors.leftMargin: 60
    anchors.top: parent.top
    anchors.topMargin: 176
    style: ButtonStyle {
    }
    onClicked: {
    vehicle.qmlSignal("Traction");
    }
    }
    Button {
    id: btnBrake
    width: 150
    height: 86
    text: "Brake"
    anchors.left: btnTraction.right
    anchors.leftMargin: 30
    anchors.top: txtHiVoltage.bottom
    anchors.topMargin: 10
    style: ButtonStyle {
    }
    onClicked: {
    vehicle.qmlSignal("Brake");
    }
    }
    Button {
    id: btnSteering
    width: 150
    height: 86
    text: qsTr("Steering")
    anchors.left: btnBrake.right
    anchors.leftMargin: 30
    anchors.top: txtHiVoltage.bottom
    anchors.topMargin: 10
    style: ButtonStyle {
    }
    onClicked: {
    vehicle.qmlSignal("Steering");
    }
    }

    // Analog
    Button {
    id: btnAnalogPCUIO
    width: 150
    height: 86
    text: "PCU IO"
    anchors.left: parent.left
    anchors.leftMargin: 60
    anchors.top: txtECUDevices.bottom
    anchors.topMargin: 10
    style: ButtonStyle {
    }
    onClicked: {
        vehicle.qmlSignal("PcuIoAnalog");
    }
    }
    Button {
    id: btnAnalogBCUIO
    width: 150
    height: 86
    text: "BCU IO"
    anchors.left: btnAnalogPCUIO.right
    anchors.leftMargin: 30
    anchors.top: txtECUDevices.bottom
    anchors.topMargin: 10
    //qsTr("Icon Desc.")
    style: ButtonStyle {
    }
    onClicked: {
        vehicle.qmlSignal("BcuIoAnalog");
    }
    }
    Button {
    id: btnAnalogVCUIO
    width: 150
    height: 86
    text: "VCUIO"
    anchors.left: btnAnalogBCUIO.right
    anchors.leftMargin: 30
    anchors.top: txtECUDevices.bottom
    anchors.topMargin: 10
    style: ButtonStyle {
    }
    onClicked: {
        vehicle.qmlSignal("VcuIoAnalog");
    }
    }

    // digital
    Button {
    id: btnPCUIO
    width: 150
    height: 86
    text: "PCU IO"
    anchors.left: parent.left
    anchors.leftMargin: 60
    anchors.top: txtECUDevicesDigital.bottom
    anchors.topMargin: 10
    style: ButtonStyle {
    }
    onClicked: {
        vehicle.qmlSignal("PcuIoDigital");
    }
    }
    Button {
    id: btnBCUIO
    width: 150
    height: 86
    text: "BCU IO"
    anchors.left: btnPCUIO.right
    anchors.leftMargin: 30
    anchors.top: txtECUDevicesDigital.bottom
    anchors.topMargin: 10
    //qsTr("Icon Desc.")
    style: ButtonStyle {
    }
    onClicked: {
        vehicle.qmlSignal("BcuIoDigital");
    }
    }

    Button {
    id: btnVCUIO
    width: 150
    height: 86
    text: "VCUIO"
    anchors.left: btnBCUIO.right
    anchors.leftMargin: 30
    anchors.top: txtECUDevicesDigital.bottom
    anchors.topMargin: 10
    style: ButtonStyle {
    }
    onClicked: {
        vehicle.qmlSignal("VcuIoDigital");
    }
    }

    Button {
    id: btnDCDC
    width: 150
    height: 86
    text: "DCDC"
    anchors.left: btnDigitalBMS.right
    anchors.leftMargin: 30
    anchors.top: txtECUDevicesDigital.bottom
    anchors.topMargin: 10
    style: ButtonStyle {
    }
    onClicked: {
        vehicle.qmlSignal("dc2Digital");
    }
    }

    Text {
        id: txtHiVoltage
        width: 300
        height: 43
        color: "#ffffff"
        text: qsTr("High Voltage System")
        anchors.top: rowVehicleInfo.bottom
        anchors.topMargin: 50
        font.pixelSize: 25
        MouseArea {
            width: 70
            height: 40
            anchors.top: parent.top
            hoverEnabled: false
            anchors.left: parent.left
        }
        anchors.left: parent.left
        verticalAlignment: Text.AlignVCenter
        anchors.leftMargin: 50
        horizontalAlignment: Text.AlignLeft
    }

    Text {
        id: txtECUDevices
        x: 9
        y: -6
        width: 300
        height: 43
        color: "#ffffff"
        text: qsTr("ECU Devices ( Analog )")
        anchors.topMargin: 150
        font.pixelSize: 25
        anchors.top: txtHiVoltage.bottom
        MouseArea {
            width: 70
            height: 40
            anchors.top: parent.top
            hoverEnabled: false
            anchors.left: parent.left
        }
        anchors.left: parent.left
        anchors.leftMargin: 50
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
    }

    Text {
        id: txtECUDevicesDigital
        x: 0
        y: -2
        width: 300
        height: 43
        color: "#ffffff"
        text: qsTr("ECU Devices ( Digital )")
        anchors.topMargin: 150
        font.pixelSize: 25
        anchors.top: txtECUDevices.bottom
        MouseArea {
            width: 70
            height: 40
            anchors.top: parent.top
            hoverEnabled: false
            anchors.left: parent.left
        }
        anchors.left: parent.left
        anchors.leftMargin: 50
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
    }

    Button {
        id: btnAnalogBMS
        x: -9
        y: -8
        width: 150
        height: 86
        text: "BMS"
        anchors.leftMargin: 30
        anchors.left: btnAnalogVCUIO.right
        style: ButtonStyle {
        }
    onClicked: {
        vehicle.qmlSignal("BmsAnalog");
    }
        anchors.top: txtECUDevices.bottom
        anchors.topMargin: 10
    }

    Button {
        id: btnDigitalBMS
        x: -6
        y: 0
        width: 150
        height: 86
        text: "BMS"
        anchors.leftMargin: 30
        anchors.left: btnVCUIO.right
        style: ButtonStyle {
        }
    onClicked: {
        vehicle.qmlSignal("BmsDigital");
    }
        anchors.top: txtECUDevicesDigital.bottom
        anchors.topMargin: 10
    }

    onActiveChanged : {
    if ( true === vehicle.active ) {
        vehicle.qmlSignalActive("Vehicle");
    }
    }

}































/*##^## Designer {
    D{i:9;anchors_x:100;anchors_y:280}D{i:11;anchors_x:400;anchors_y:280}D{i:13;anchors_x:700;anchors_y:280}
D{i:15;anchors_x:100;anchors_y:450}D{i:17;anchors_x:400;anchors_y:450}D{i:19;anchors_x:700;anchors_y:450}
D{i:21;anchors_x:100;anchors_y:630}D{i:23;anchors_x:400;anchors_y:630}D{i:25;anchors_x:700;anchors_y:630}
D{i:27;anchors_x:1000;anchors_y:630}D{i:35;anchors_x:700;anchors_y:450}D{i:37;anchors_x:700;anchors_y:450}
}
 ##^##*/
