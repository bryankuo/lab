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

Window {
    id: parameters

    // ( https://goo.gl/LWbdMG )
    objectName: "parametersWindow"

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
    property alias window: parameters
    flags: Qt.FramelessWindowHint
    title: ""

    // Property names must begin with a lower case letter
    // and can only contain letters ( https://goo.gl/HzLQet )
    //
    //property string batteryPackName
    signal qmlSignal(string msg)
    signal qmlSignalActive(string msg)

    Rectangle {
        id: recParameters
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
        source: "../images/0-color/HMI-ICON-55.png"
        fillMode: Image.PreserveAspectFit
    MouseArea {
        id: maViBack
        z: 2
        anchors.fill: parent
        onClicked: {
        parameters.hide();
        }
    }
    }

    Rectangle {
        id: rowHistory
        x: 200
        y: 30
        width: 300
        height: 43
    color: "#161616"
        anchors.leftMargin: 50
        Text {
            id: txtHistoryData
            y: 0
            width: 100
            height: 43
            color: "#ffffff"
            text: qsTr("Parameters")
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

    Button {
    id: btnGeneral
    x: 100
    y: 280
    width: 200
    height: 86
    text: qsTr("General")
    style: ButtonStyle {
    }
    onClicked: {
        parameters.qmlSignal("GeneralParameters");
    }
    }

    Button {
    id: btnCharge
    x: 400
    y: 280
    width: 200
    height: 86
    text: "Charge"
    style: ButtonStyle {
    }
    onClicked: {
        parameters.qmlSignal("ChargeParameters");
    }
    }

    Button {
    id: btnAlarm
    x: 700
    y: 280
    width: 200
    height: 86
    text: qsTr("Alarm")
    style: ButtonStyle {
    }
    onClicked: {
        parameters.qmlSignal("AlarmParameters");
    }
    }


    Button {
    id: btnCellAlmRecord
    x: 100
    y: 450
    width: 200
    height: 86
    text: "HMI"
    style: ButtonStyle {
    }
    onClicked: {
        parameters.qmlSignal("HmiParameters");
    }
    }
    Button {
    id: btnVehicleInfoRecord
    x: 400
    y: 450
    width: 200
    height: 86
    text: "TPMS"
    //qsTr("Icon Desc.")
    style: ButtonStyle {
    }
    onClicked: {
        parameters.qmlSignal("TpmsSetting");
    }
    }

    Button {
    id: btnChargeTrippedRecord
    x: 700
    y: 450
    width: 200
    height: 86
    text: "Charge Tripped Rec.:w"
    visible: false
    style: ButtonStyle {
    }
    onClicked: {
        //parameters.qmlSignal("ChargeTrippedRecord");
    }
    }

    Text {
        id: txtAlmCaption
        width: 100
        height: 43
        color: "#ffffff"
        text: qsTr("")
        anchors.top: parent.top
        anchors.topMargin: 200
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
        id: txtAlmCaption2
        x: 9
        y: -6
        width: 100
        height: 43
        color: "#ffffff"
        text: qsTr("")
        anchors.topMargin: 380
        font.pixelSize: 25
        anchors.top: parent.top
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

    onActiveChanged : {
    if ( true === parameters.active ) {
        parameters.qmlSignalActive("Parameters");
    }
    }

}
