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
    id: engineering

    // ( https://goo.gl/LWbdMG )
    objectName: "engineeringWindow"

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
    property alias window: engineering
    flags: Qt.FramelessWindowHint
    title: "Engineering"

    // Property names must begin with a lower case letter
    // and can only contain letters ( https://goo.gl/HzLQet )
    //
    //property string batteryPackName
    signal qmlSignal(string msg)
    signal qmlSignalActive(string msg)

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
        id: imageEngineeringBack
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
        engineering.hide();
        }
    }
    }

    Rectangle {
        id: rowTitle
        x: 200
        y: 30
        width: 300
        height: 43
	color: "#161616"
        anchors.leftMargin: 50
        Text {
            id: txtGpsCaption
            y: 0
            width: 100
            height: 43
            color: "#ffffff"
            text: qsTr("Engineering Menu")
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

    GridLayout {
    id: gridLayout
    x: 227
    y: 144
    width: 640
    height: 400
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter
    rows: 2
    columns: 3
    flow: GridLayout.LeftToRight

    Label {
        id: lbl00
        text: ""
        Button {
        id: btnHistoryData
        y: 0
        width: 200
        height: 86
        text: lbl00.text //qsTr("Icon Desc.")
        anchors.left: parent.left
        anchors.leftMargin: 15
        style: ButtonStyle {
        }
        }
    }
    Label {
        id: lbl01
        text: "Vehicle Info."
        Button {
        id: btnVehicleInfo
        y: 0
        width: 200
        height: 86
        text: lbl01.text
        anchors.left: parent.left
        anchors.leftMargin: 15
        style: ButtonStyle {
        }
        onClicked: {
        engineering.qmlSignal("Vehicle");
        }
    }
    }
    Label {
        id: lbl02
        text: "Icon Desc."
        Button {
        id: btnIconDesc02
        y: 0
        width: 200
        height: 86
        text: lbl02.text //qsTr("Icon Desc.")
        anchors.left: parent.left
        anchors.leftMargin: 15
        style: ButtonStyle {
        }
        onClicked: {
        engineering.qmlSignal("IconDesc");
        }
        }
    }
    Label {
        id: lbl10
        text: ""
        Button {
        id: btnIconDesc10
        y: 0
        width: 200
        height: 86
        text: lbl10.text
        anchors.left: parent.left
        anchors.leftMargin: 15
        style: ButtonStyle {
        }
        }
    }
    Label {
        id: lbl11
        text: ""
        Button {
        id: btnIconDesc11
        y: 0
        width: 200
        height: 86
        text: lbl11.text //qsTr("Icon Desc.")
        anchors.left: parent.left
        anchors.leftMargin: 15
        style: ButtonStyle {
        }
        }
    }
    Label {
        id: lbl12
        text: ""
        Button {
        id: btnIconDesc12
        y: 0
        width: 200
        height: 86
        text: lbl12.text
        anchors.left: parent.left
        anchors.leftMargin: 15
        style: ButtonStyle {
        }
        }
    }
    }

    onActiveChanged : {
    if ( true === engineering.active ) {
        engineering.qmlSignalActive("Engineering");
    }
    }

}
