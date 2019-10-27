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
import QtQuick.Controls 2.4
import "icon_desc"
import "style"

Window {
    id: iconDescription

    // ( https://goo.gl/LWbdMG )
    objectName: "iconDescriptionWindow"

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
    property alias window: iconDescription
    flags: Qt.FramelessWindowHint
    title: "Icon Legend"

    // Property names must begin with a lower case letter
    // and can only contain letters ( https://goo.gl/HzLQet )
    //
    property int swipeviewHeight: 665
    signal qmlSignal(string msg)
    signal qmlSignalActive(string msg)

    Rectangle {
        id: rectangleiconDescription
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
        source: "../images/0-color/HMI-ICON-55.png"
        fillMode: Image.PreserveAspectFit
        MouseArea {
            id: maBack
            z: 2
            anchors.fill: parent
            onClicked: {
                iconDescription.hide();
            }
        }
    }

    Rectangle {
        id: recSwipe
        x: 0
        y: 80
        width: style.resolutionWidth
        height: swipeviewHeight
        color: "#161616"
        SwipeView {
            id: view
            currentIndex: 0
            anchors.fill: parent
            Item {
                id: firstPage
        // QML Grid: Cannot specify anchors for items inside Grid. Grid will not function.
                Rectangle {
                    id: grid0
                    width: style.resolutionWidth
                    height: 665
            color: "#161616"
                    //columns: 10
                    //columnSpacing: 10
                    //spacing: 2
                    // ( page, row, column )
                    Rectangle { id: rec00_00_00; width: 150; height: 120
                        color: "#161616"
                        radius: 5
                        border.width: 0
                        anchors.left: parent.left
                        anchors.leftMargin: 5
                        border.color: "#ffffff"
                        Image {
                            id: image00_00_00
                            x: 0
                            y: 0
                            width: 120
                            height: 90
                            anchors.horizontalCenter: parent.horizontalCenter
                            sourceSize.height: 267
                            sourceSize.width: 267
                            anchors.topMargin: 0
                            z: 0
                            anchors.top: parent.top
                            source: "../images/0-color/HMI-ICON-01.png"
                            fillMode: Image.PreserveAspectCrop
                        }
                        Text {
                            id: txt00_00_00
                            width: 150
                            color: "#ffffff"
                            text: qsTr("Left Turn Signal")
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: image00_00_00.bottom
                            anchors.topMargin: 3
                            verticalAlignment: Text.AlignVCenter
                            font.pixelSize: 18
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }
                    Rectangle {
                        id: rec00_00_01
                        width: 150
                        height: 120
                        color: "#161616"
                        radius: 5
                        border.width: 0
                        border.color: "#ffffff"
                        anchors.left: rec00_00_00.right
                        anchors.leftMargin: 10
                        Image {
                            id: image00_00_01
                            x: 0
                            y: 0
                            width: 120
                            height: 90
                            anchors.horizontalCenter: parent.horizontalCenter
                            z: 0
                            source: "../images/0-color/HMI-ICON-02.png"
                            anchors.top: parent.top
                            fillMode: Image.PreserveAspectCrop
                            anchors.topMargin: 0
                        }

                        Text {
                            id: txt00_00_01
                            width: 150
                            color: "#ffffff"
                            text: qsTr("Right Turn Signal")
                            wrapMode: Text.NoWrap
                            anchors.horizontalCenter: parent.horizontalCenter
                            verticalAlignment: Text.AlignVCenter
                            anchors.top: image00_00_01.bottom
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 15
                            anchors.topMargin: 6
                        }
                    }
                    Rectangle { id: rec00_00_02; y: 0; width: 150; height: 120
                        color: "#161616"
                        radius: 5
                        border.width: 0
                        anchors.left: rec00_00_01.right
                        anchors.leftMargin: 10
                        border.color: "#ffffff"
                        Image {
                            id: image00_00_02
                            x: 0
                            y: 0
                            width: 120
                            height: 90
                            anchors.horizontalCenter: parent.horizontalCenter
                            sourceSize.height: 267
                            sourceSize.width: 267
                            anchors.topMargin: 0
                            z: 0
                            anchors.top: parent.top
                            source: "../images/0-color/HMI-ICON-03.png"
                            fillMode: Image.PreserveAspectCrop
                        }
                        Text {
                            id: txt00_00_02
                            width: 150
                            color: "#ffffff"
                            text: qsTr("High Beam Light")
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: image00_00_02.bottom
                            anchors.topMargin: 6
                            verticalAlignment: Text.AlignVCenter
                            font.pixelSize: 15
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }

                    Rectangle { id: rec00_00_03; width: 150; height: 120
                        color: "#161616"
                        radius: 5
                        border.width: 0
                        anchors.left: rec00_00_02.right
                        anchors.leftMargin: 10
                        border.color: "#ffffff"
                        Image {
                            id: image00_00_03
                            x: 0
                            y: 0
                            width: 120
                            height: 90
                            anchors.horizontalCenter: parent.horizontalCenter
                            sourceSize.height: 267
                            sourceSize.width: 267
                            anchors.topMargin: 0
                            z: 0
                            anchors.top: parent.top
                            source: "../images/0-color/20190308HMI-ICON-82.png"
                            fillMode: Image.PreserveAspectCrop
                        }
                        Text {
                            id: txt00_00_03
                            width: 150
                            color: "#ffffff"
                            text: qsTr("Rear Flog Lamps")
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: image00_00_03.bottom
                            anchors.topMargin: 3
                            verticalAlignment: Text.AlignVCenter
                            font.pixelSize: 16
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }
                    Rectangle { id: rec00_00_04; width: 150; height: 120
                        color: "#161616"
                        radius: 5
                        border.width: 0
                        anchors.left: rec00_00_03.right
                        anchors.leftMargin: 10
                        border.color: "#ffffff"
                        Image {
                            id: image00_00_04
                            x: 0
                            y: 0
                            width: 120
                            height: 90
                            anchors.horizontalCenter: parent.horizontalCenter
                            sourceSize.height: 267
                            sourceSize.width: 267
                            anchors.topMargin: 0
                            z: 0
                            anchors.top: parent.top
                            source: "../images/0-color/HMI-ICON-04.png"
                            fillMode: Image.PreserveAspectCrop
                        }
                        Text {
                            id: txt00_00_04
                            width: 180
                            color: "#ffffff"
                            text: qsTr("Parking Lights")
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: image00_00_04.bottom
                            anchors.topMargin: 0
                            verticalAlignment: Text.AlignVCenter
                            font.pixelSize: 20
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }

                    Rectangle {
                        id: rec00_00_05
                        width: 150
                        height: 120
                        color: "#161616"
                        radius: 5
                        border.width: 0
                        anchors.leftMargin: 10
                        Image {
                            id: image00_00_05
                            x: 0
                            y: 0
                            width: 120
                            height: 90
                            anchors.horizontalCenter: parent.horizontalCenter
                            z: 0
                            source: "../images/0-color/HMI-ICON-06.png"
                            anchors.top: parent.top
                            fillMode: Image.PreserveAspectCrop
                            sourceSize.width: 267
                            sourceSize.height: 267
                            anchors.topMargin: 0
                        }

                        Text {
                            id: txt00_00_05
                            width: 180
                            color: "#ffffff"
                            text: qsTr("Defogger")
                            anchors.horizontalCenter: parent.horizontalCenter
                            verticalAlignment: Text.AlignVCenter
                            anchors.top: image00_00_05.bottom
                            font.pixelSize: 20
                            horizontalAlignment: Text.AlignHCenter
                            anchors.topMargin: 0
                        }
                        border.color: "#ffffff"
                        anchors.left: rec00_00_04.right
                    }
                    Rectangle { id: rec00_01_00; width: 150; height: 120
                        color: "#161616"
                        radius: 5
                        border.width: 0
                        anchors.top: rec00_00_00.bottom
                        anchors.topMargin: 10
                        anchors.left: parent.left
                        anchors.leftMargin: 5
                        border.color: "#ffffff"
                        Image {
                            id: image00_01_00
                            x: 0
                            y: 0
                            width: 120
                            height: 90
                            anchors.horizontalCenter: parent.horizontalCenter
                            sourceSize.height: 267
                            sourceSize.width: 267
                            anchors.topMargin: 0
                            z: 0
                            anchors.top: parent.top
                            source: "../images/0-color/HMI-ICON-14.png"
                            fillMode: Image.PreserveAspectCrop
                        }
                        Text {
                            id: txt00_01_00
                            width: 180
                            color: "#ffffff"
                            text: qsTr("ABS Abnormal")
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: image00_01_00.bottom
                            anchors.topMargin: 0
                            verticalAlignment: Text.AlignVCenter
                            font.pixelSize: 20
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }
                    Rectangle {
                        id: rec00_01_01
                        width: 150
                        height: 120
                        color: "#161616"
                        radius: 5
                        border.width: 0
                        anchors.top: rec00_00_00.bottom
                        anchors.topMargin: 10
                        border.color: "#ffffff"
                        anchors.left: rec00_01_00.right
                        anchors.leftMargin: 10
                        Image {
                            id: image00_01_01
                            x: 0
                            y: 0
                            width: 120
                            height: 90
                            anchors.horizontalCenter: parent.horizontalCenter
                            z: 0
                            source: "../images/0-color/HMI-ICON-08.png"
                            anchors.top: parent.top
                            fillMode: Image.PreserveAspectCrop
                            anchors.topMargin: 0
                        }

                        Text {
                            id: txt00_01_01
                            width: 150
                            color: "#ffffff"
                            text: qsTr("Regen. Brake")
                            anchors.horizontalCenter: parent.horizontalCenter
                            verticalAlignment: Text.AlignVCenter
                            anchors.top: image00_01_01.bottom
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 20
                            anchors.topMargin: 0
                        }
                    }
                    Rectangle { id: rec00_01_02; width: 150; height: 120
                        color: "#161616"
                        radius: 5
                        border.width: 0
                        anchors.top: rec00_00_02.bottom
                        anchors.topMargin: 10
                        anchors.left: rec00_01_01.right
                        anchors.leftMargin: 10
                        border.color: "#ffffff"
                        Image {
                            id: image00_01_02
                            x: 0
                            y: 0
                            width: 120
                            height: 90
                            anchors.horizontalCenter: parent.horizontalCenter
                            sourceSize.height: 267
                            sourceSize.width: 267
                            anchors.topMargin: 0
                            z: 0
                            anchors.top: parent.top
                            source: "../images/0-color/HMI-ICON-10.png"
                            fillMode: Image.PreserveAspectCrop
                        }
                        Text {
                            id: txt00_01_02
                            width: 150
                            color: "#ffffff"
                            text: qsTr("Brake Lining")
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: image00_01_02.bottom
                            anchors.topMargin: 0
                            verticalAlignment: Text.AlignVCenter
                            font.pixelSize: 20
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }

                    Rectangle { id: rec00_01_03; width: 150; height: 120
                        color: "#161616"
                        radius: 5
                        border.width: 0
                        anchors.top: rec00_00_03.bottom
                        anchors.topMargin: 10
                        anchors.left: rec00_01_02.right
                        anchors.leftMargin: 10
                        border.color: "#ffffff"
                        Image {
                            id: image00_01_03
                            x: 0
                            y: 0
                            width: 120
                            height: 90
                            anchors.horizontalCenter: parent.horizontalCenter
                            sourceSize.height: 267
                            sourceSize.width: 267
                            anchors.topMargin: 0
                            z: 0
                            anchors.top: parent.top
                            source: "../images/0-color/HMI-ICON-62.png"
                            fillMode: Image.PreserveAspectCrop
                        }
                        Text {
                            id: txt00_01_03
                            width: 150
                            color: "#ffffff"
                            text: qsTr("Power Steering")
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: image00_01_03.bottom
                            anchors.topMargin: 3
                            verticalAlignment: Text.AlignVCenter
                            font.pixelSize: 18
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }
                    Rectangle { id: rec00_01_04; width: 150; height: 120
                        color: "#161616"
                        radius: 5
                        border.width: 0
                        anchors.top: rec00_00_04.bottom
                        anchors.topMargin: 10
                        anchors.left: rec00_01_03.right
                        anchors.leftMargin: 10
                        border.color: "#ffffff"
                        Image {
                            id: image00_01_04
                            x: 0
                            y: 0
                            width: 120
                            height: 90
                            anchors.horizontalCenter: parent.horizontalCenter
                            sourceSize.height: 267
                            sourceSize.width: 267
                            anchors.topMargin: 0
                            z: 0
                            anchors.top: parent.top
                            source: "../images/0-color/HMI-ICON-11.png"
                            fillMode: Image.PreserveAspectCrop
                        }
                        Text {
                            id: txt00_01_04
                            width: 150
                            color: "#ffffff"
                            text: qsTr("ECAS Side Kneeling")
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: image00_01_04.bottom
                            anchors.topMargin: 5
                            verticalAlignment: Text.AlignVCenter
                            font.pixelSize: 15
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }

                    Rectangle {
                        id: rec00_01_05
                        width: 150
                        height: 120
                        color: "#161616"
                        radius: 5
                        border.width: 0
                        anchors.top: rec00_00_05.bottom
                        anchors.topMargin: 10
                        anchors.leftMargin: 10
                        Image {
                            id: image00_01_05
                            x: 0
                            y: 0
                            width: 120
                            height: 90
                            anchors.horizontalCenter: parent.horizontalCenter
                            z: 0
                            source: "../images/0-color/HMI-ICON-12.png"
                            anchors.top: parent.top
                            fillMode: Image.PreserveAspectCrop
                            sourceSize.width: 267
                            sourceSize.height: 267
                            anchors.topMargin: 0
                        }

                        Text {
                            id: txt00_01_05
                            width: 180
                            color: "#ffffff"
                            text: qsTr("ECAS Warning")
                            anchors.horizontalCenter: parent.horizontalCenter
                            verticalAlignment: Text.AlignVCenter
                            anchors.top: image00_01_05.bottom
                            font.pixelSize: 20
                            horizontalAlignment: Text.AlignHCenter
                            anchors.topMargin: 0
                        }
                        border.color: "#ffffff"
                        anchors.left: rec00_01_04.right
                    }

                    Rectangle {
                        id: rec00_00_06
                        width: 150
                        height: 120
                        color: "#161616"
                        radius: 5
                        border.width: 0
                        anchors.leftMargin: 10
                        Image {
                            id: image00_00_06
                            x: 0
                            y: 0
                            width: 120
                            height: 90
                            source: "../images/0-color/HMI-ICON-09.png"
                            z: 0
                            anchors.top: parent.top
                            fillMode: Image.PreserveAspectCrop
                            anchors.horizontalCenter: parent.horizontalCenter
                            sourceSize.width: 267
                            sourceSize.height: 267
                            anchors.topMargin: 0
                        }

                        Text {
                            id: txt00_00_06
                            width: 180
                            color: "#ffffff"
                            text: qsTr("Parking Brake")
                            verticalAlignment: Text.AlignVCenter
                            anchors.top: image00_00_06.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 20
                            anchors.topMargin: 0
                        }
                        border.color: "#ffffff"
                        anchors.left: rec00_00_05.right
                    }

                    Rectangle {
                        id: rec00_00_07
                        width: 150
                        height: 120
                        color: "#161616"
                        radius: 5
                        border.width: 0
                        anchors.leftMargin: 10
                        Image {
                            id: image00_00_07
                            x: 0
                            y: 0
                            width: 120
                            height: 90
                            z: 0
                            source: "../images/0-color/HMI-ICON-19.png"
                            anchors.top: parent.top
                            fillMode: Image.PreserveAspectCrop
                            anchors.horizontalCenter: parent.horizontalCenter
                            sourceSize.width: 267
                            sourceSize.height: 267
                            anchors.topMargin: 0
                        }

                        Text {
                            id: txt00_00_07
                            width: 180
                            color: "#ffffff"
                            text: qsTr("Assist Button")
                            verticalAlignment: Text.AlignVCenter
                            anchors.top: image00_00_07.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: 20
                            horizontalAlignment: Text.AlignHCenter
                            anchors.topMargin: 0
                        }
                        border.color: "#ffffff"
                        anchors.left: rec00_00_06.right
                    }

                    Rectangle {
                        id: rec00_01_06
                        width: 150
                        height: 120
                        color: "#161616"
                        radius: 5
                        border.width: 0
                        anchors.top: rec00_00_00.bottom
                        anchors.topMargin: 10
                        anchors.leftMargin: 10
                        Image {
                            id: image00_01_06
                            x: 0
                            y: 0
                            width: 120
                            height: 90
                            z: 0
                            source: "../images/0-color/HMI-ICON-24.png"
                            anchors.top: parent.top
                            fillMode: Image.PreserveAspectCrop
                            anchors.horizontalCenter: parent.horizontalCenter
                            sourceSize.width: 267
                            sourceSize.height: 267
                            anchors.topMargin: 0
                        }

                        Text {
                            id: txt00_01_06
                            width: 180
                            color: "#ffffff"
                            text: qsTr("EMG. Door Opened")
                            verticalAlignment: Text.AlignVCenter
                            anchors.top: image00_01_06.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: 15
                            horizontalAlignment: Text.AlignHCenter
                            anchors.topMargin: 5
                        }
                        border.color: "#ffffff"
                        anchors.left: rec00_01_05.right
                    }

                    Rectangle {
                        id: rec00_01_07
                        width: 150
                        height: 120
                        color: "#161616"
                        radius: 5
                        border.width: 0
                        anchors.top: rec00_00_00.bottom
                        anchors.topMargin: 10
                        anchors.leftMargin: 10
                        Image {
                            id: image00_01_07
                            x: 0
                            y: 0
                            width: 120
                            height: 90
                            source: "../images/0-color/HMI-ICON-29.png"
                            z: 0
                            anchors.top: parent.top
                            fillMode: Image.PreserveAspectCrop
                            anchors.horizontalCenter: parent.horizontalCenter
                            sourceSize.width: 267
                            sourceSize.height: 267
                            anchors.topMargin: 0
                        }

                        Text {
                            id: txt00_01_07
                            width: 180
                            color: "#ffffff"
                            text: qsTr("Get Off Button")
                            verticalAlignment: Text.AlignVCenter
                            anchors.top: image00_01_07.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 20
                            anchors.topMargin: 0
                        }
                        border.color: "#ffffff"
                        anchors.left: rec00_01_06.right
                    }

                    Rectangle {
                        id: rec00_02_00
                        width: 150
                        height: 120
                        color: "#161616"
                        radius: 5
                        anchors.leftMargin: 5
                        Image {
                            id: image00_02_00
                            x: 0
                            y: 0
                            width: 120
                            height: 90
                            z: 0
                            source: "../images/0-color/HMI-ICON-16.png"
                            anchors.top: parent.top
                            fillMode: Image.PreserveAspectCrop
                            anchors.horizontalCenter: parent.horizontalCenter
                            sourceSize.width: 267
                            sourceSize.height: 267
                            anchors.topMargin: 0
                        }

                        Text {
                            id: txt00_02_00
                            width: 150
                            color: "#ffffff"
                            text: qsTr("High Volt. Warning")
                            verticalAlignment: Text.AlignVCenter
                            anchors.top: image00_02_00.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: 17
                            horizontalAlignment: Text.AlignHCenter
                            anchors.topMargin: 5
                        }
                        border.width: 0
                        anchors.top: rec00_01_00.bottom
                        border.color: "#ffffff"
                        anchors.left: parent.left
                        anchors.topMargin: 10
                    }

                    Rectangle {
                        id: rec00_02_01
                        width: 150
                        height: 120
                        color: "#161616"
                        radius: 5
                        border.width: 0
                        anchors.leftMargin: 10
                        Image {
                            id: image00_02_01
                            x: 0
                            y: 0
                            width: 120
                            height: 90
                            z: 0
                            source: "../images/0-color/HMI-ICON-64.png"
                            anchors.top: parent.top
                            fillMode: Image.PreserveAspectCrop
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.topMargin: 0
                        }

                        Text {
                            id: txt00_02_01
                            width: 150
                            color: "#ffffff"
                            text: qsTr("24V Warning")
                            verticalAlignment: Text.AlignVCenter
                            anchors.top: image00_02_01.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 20
                            anchors.topMargin: 0
                        }
                        anchors.top: rec00_01_01.bottom
                        border.color: "#ffffff"
                        anchors.left: rec00_02_00.right
                        anchors.topMargin: 10
                    }

                    Rectangle {
                        id: rec00_02_02
                        width: 150
                        height: 120
                        color: "#161616"
                        radius: 5
                        border.width: 0
                        anchors.leftMargin: 10
                        Image {
                            id: image00_02_02
                            x: 0
                            y: 0
                            width: 120
                            height: 90
                            z: 0
                            source: "../images/0-color/20190308HMI-ICON-98.png"
                            anchors.top: parent.top
                            fillMode: Image.PreserveAspectCrop
                            anchors.horizontalCenter: parent.horizontalCenter
                            sourceSize.width: 267
                            sourceSize.height: 267
                            anchors.topMargin: 0
                        }

                        Text {
                            id: txt00_02_02
                            width: 150
                            color: "#ffffff"
                            text: qsTr("Door Opened")
                            verticalAlignment: Text.AlignVCenter
                            anchors.top: image00_02_02.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: 20
                            horizontalAlignment: Text.AlignHCenter
                            anchors.topMargin: 0
                        }
                        anchors.top: rec00_01_02.bottom
                        border.color: "#ffffff"
                        anchors.left: rec00_01_01.right
                        anchors.topMargin: 10
                    }

                    Rectangle {
                        id: rec00_02_03
                        width: 150
                        height: 120
                        color: "#161616"
                        radius: 5
                        border.width: 0
                        anchors.leftMargin: 10
                        Image {
                            id: image00_02_03
                            x: 0
                            y: 0
                            width: 120
                            height: 90
                            z: 0
                            source: "../images/0-color/HMI-ICON-07.png"
                            anchors.top: parent.top
                            fillMode: Image.PreserveAspectCrop
                            anchors.horizontalCenter: parent.horizontalCenter
                            sourceSize.width: 267
                            sourceSize.height: 267
                            anchors.topMargin: 0
                        }

                        Text {
                            id: txt00_02_03
                            width: 150
                            color: "#ffffff"
                            text: qsTr("Hazard Warning")
                            verticalAlignment: Text.AlignVCenter
                            anchors.top: image00_02_03.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: 18
                            horizontalAlignment: Text.AlignHCenter
                            anchors.topMargin: 3
                        }
                        anchors.top: rec00_01_03.bottom
                        border.color: "#ffffff"
                        anchors.left: rec00_02_02.right
                        anchors.topMargin: 10
                    }

                    Rectangle {
                        id: rec00_02_04
                        width: 150
                        height: 120
                        color: "#161616"
                        radius: 5
                        border.width: 0
                        anchors.leftMargin: 10
                        Image {
                            id: image00_02_04
                            x: 0
                            y: 0
                            width: 120
                            height: 90
                            z: 0
                            source: "../images/0-color/HMI-ICON-36.png"
                            anchors.top: parent.top
                            fillMode: Image.PreserveAspectCrop
                            anchors.horizontalCenter: parent.horizontalCenter
                            sourceSize.width: 267
                            sourceSize.height: 267
                            anchors.topMargin: 0
                        }

                        Text {
                            id: txt00_02_04
                            width: 150
                            color: "#ffffff"
                            text: qsTr("Air Pressure")
                            verticalAlignment: Text.AlignVCenter
                            anchors.top: image00_02_04.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: 18
                            horizontalAlignment: Text.AlignHCenter
                            anchors.topMargin: 5
                        }
                        anchors.top: rec00_01_04.bottom
                        border.color: "#ffffff"
                        anchors.left: rec00_02_03.right
                        anchors.topMargin: 10
                    }

                    Rectangle {
                        id: rec00_02_05
                        width: 150
                        height: 120
                        color: "#161616"
                        radius: 5
                        border.width: 0
                        anchors.leftMargin: 10
                        Image {
                            id: image00_02_05
                            x: 0
                            y: 0
                            width: 120
                            height: 90
                            z: 0
                            source: "../images/0-color/HMI-ICON-31.png"
                            anchors.top: parent.top
                            fillMode: Image.PreserveAspectCrop
                            anchors.horizontalCenter: parent.horizontalCenter
                            sourceSize.width: 267
                            sourceSize.height: 267
                            anchors.topMargin: 0
                        }

                        Text {
                            id: txt00_02_05
                            width: 150
                            color: "#ffffff"
                            text: qsTr("Water Temp. Warning")
                            verticalAlignment: Text.AlignVCenter
                            anchors.top: image00_02_05.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: 14
                            horizontalAlignment: Text.AlignHCenter
                            anchors.topMargin: 6
                        }
                        anchors.top: rec00_01_05.bottom
                        border.color: "#ffffff"
                        anchors.left: rec00_02_04.right
                        anchors.topMargin: 10
                    }

                    Rectangle {
                        id: rec00_02_06
                        width: 150
                        height: 120
                        color: "#161616"
                        radius: 5
                        border.width: 0
                        anchors.leftMargin: 10
                        Image {
                            id: image00_02_06
                            x: 0
                            y: 0
                            width: 120
                            height: 90
                            source: "../images/0-color/HMI-ICON-37.png"
                            z: 0
                            anchors.top: parent.top
                            fillMode: Image.PreserveAspectCrop
                            anchors.horizontalCenter: parent.horizontalCenter
                            sourceSize.width: 267
                            sourceSize.height: 267
                            anchors.topMargin: 0
                        }

                        Text {
                            id: txt00_02_06
                            width: 150
                            color: "#ffffff"
                            text: qsTr("Motor Temp. Warning")
                            verticalAlignment: Text.AlignVCenter
                            anchors.top: image00_02_06.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 14
                            anchors.topMargin: 7
                        }
                        anchors.top: rec00_01_06.bottom
                        border.color: "#ffffff"
                        anchors.left: rec00_02_05.right
                        anchors.topMargin: 10
                    }

                    Rectangle {
                        id: rec00_02_07
                        width: 150
                        height: 120
                        color: "#161616"
                        radius: 5
                        border.width: 0
                        anchors.leftMargin: 10
                        Image {
                            id: image00_02_07
                            x: 0
                            y: 0
                            width: 120
                            height: 90
                            z: 0
                            source: "../images/0-color/HMI-ICON-63.png"
                            anchors.top: parent.top
                            fillMode: Image.PreserveAspectCrop
                            anchors.horizontalCenter: parent.horizontalCenter
                            sourceSize.width: 267
                            sourceSize.height: 267
                            anchors.topMargin: 0
                        }

                        Text {
                            id: txt00_02_07
                            width: 150
                            color: "#ffffff"
                            text: qsTr("Motor Warning")
                            verticalAlignment: Text.AlignVCenter
                            anchors.top: image00_02_07.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: 18
                            horizontalAlignment: Text.AlignHCenter
                            anchors.topMargin: 5
                        }
                        anchors.top: rec00_01_07.bottom
                        border.color: "#ffffff"
                        anchors.left: rec00_02_06.right
                        anchors.topMargin: 10
                    }

                    Rectangle {
                        id: rec00_03_00
                        width: 150
                        height: 120
                        color: "#161616"
                        radius: 5
                        anchors.leftMargin: 5
                        Image {
                            id: image00_03_00
                            x: 0
                            y: 0
                            width: 120
                            height: 90
                            source: "../images/0-color/201905ICON-23.png"
                            z: 0
                            anchors.top: parent.top
                            fillMode: Image.PreserveAspectCrop
                            anchors.horizontalCenter: parent.horizontalCenter
                            sourceSize.width: 267
                            sourceSize.height: 267
                            anchors.topMargin: 0
                        }

                        Text {
                            id: txt00_03_00
                            width: 150
                            color: "#ffffff"
                            text: qsTr("Leakage Warning")
                            verticalAlignment: Text.AlignVCenter
                            anchors.top: image00_03_00.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 17
                            anchors.topMargin: 5
                        }
                        border.width: 0
                        anchors.top: rec00_02_00.bottom
                        border.color: "#ffffff"
                        anchors.left: parent.left
                        anchors.topMargin: 10
                    }

                    Rectangle {
                        id: rec00_03_01
                        width: 150
                        height: 120
                        color: "#161616"
                        radius: 5
                        anchors.leftMargin: 10
                        Image {
                            id: image00_03_01
                            x: 0
                            y: 0
                            width: 120
                            height: 90
                            source: "../images/0-color/HMI-ICON-25.png"
                            z: 0
                            anchors.top: parent.top
                            fillMode: Image.PreserveAspectCrop
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.topMargin: 0
                        }

                        Text {
                            id: txt00_03_01
                            width: 150
                            color: "#ffffff"
                            text: qsTr("Battery Idle")
                            verticalAlignment: Text.AlignVCenter
                            anchors.top: image00_03_01.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: 20
                            horizontalAlignment: Text.AlignHCenter
                            anchors.topMargin: 0
                        }
                        border.width: 0
                        anchors.top: rec00_02_01.bottom
                        border.color: "#ffffff"
                        anchors.left: rec00_03_00.right
                        anchors.topMargin: 10
                    }

                    Rectangle {
                        id: rec00_03_02
                        width: 150
                        height: 120
                        color: "#161616"
                        radius: 5
                        anchors.leftMargin: 10
                        Image {
                            id: image00_03_02
                            x: 0
                            y: 0
                            width: 120
                            height: 90
                            source: "../images/0-color/HMI-ICON-78.png"
                            z: 0
                            anchors.top: parent.top
                            fillMode: Image.PreserveAspectCrop
                            anchors.horizontalCenter: parent.horizontalCenter
                            sourceSize.width: 267
                            sourceSize.height: 267
                            anchors.topMargin: 0
                        }

                        Text {
                            id: txt00_03_02
                            width: 150
                            color: "#ffffff"
                            text: qsTr("SOC")
                            verticalAlignment: Text.AlignVCenter
                            anchors.top: image00_03_02.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 20
                            anchors.topMargin: 0
                        }
                        border.width: 0
                        anchors.top: rec00_02_02.bottom
                        border.color: "#ffffff"
                        anchors.left: rec00_03_01.right
                        anchors.topMargin: 10
                    }

                    Rectangle {
                        id: rec00_03_03
                        width: 150
                        height: 120
                        color: "#161616"
                        radius: 5
                        anchors.leftMargin: 10
                        Image {
                            id: image00_03_03
                            x: 0
                            y: 0
                            width: 120
                            height: 90
                            source: "../images/0-color/HMI-ICON-27.png"
                            z: 0
                            anchors.top: parent.top
                            fillMode: Image.PreserveAspectCrop
                            anchors.horizontalCenter: parent.horizontalCenter
                            sourceSize.width: 267
                            sourceSize.height: 267
                            anchors.topMargin: 0
                        }

                        Text {
                            id: txt00_03_03
                            width: 150
                            color: "#ffffff"
                            text: qsTr("Battery Charging")
                            verticalAlignment: Text.AlignVCenter
                            anchors.top: image00_03_03.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 16
                            anchors.topMargin: 3
                        }
                        border.width: 0
                        anchors.top: rec00_02_02.bottom
                        border.color: "#ffffff"
                        anchors.left: rec00_03_02.right
                        anchors.topMargin: 10
                    }

                    Rectangle {
                        id: rec00_03_04
                        width: 150
                        height: 120
                        color: "#161616"
                        radius: 5
                        anchors.leftMargin: 10
                        Image {
                            id: image00_03_04
                            x: 0
                            y: 0
                            width: 120
                            height: 90
                            source: "../images/0-color/HMI-ICON-26.png"
                            z: 0
                            anchors.top: parent.top
                            fillMode: Image.PreserveAspectCrop
                            anchors.horizontalCenter: parent.horizontalCenter
                            sourceSize.width: 267
                            sourceSize.height: 267
                            anchors.topMargin: 0
                        }

                        Text {
                            id: txt00_03_04
                            width: 150
                            color: "#ffffff"
                            text: qsTr("Battery Discharging")
                            verticalAlignment: Text.AlignVCenter
                            anchors.top: image00_03_04.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 16
                            anchors.topMargin: 5
                        }
                        border.width: 0
                        anchors.top: rec00_02_04.bottom
                        border.color: "#ffffff"
                        anchors.left: rec00_03_03.right
                        anchors.topMargin: 10
                    }

                    Rectangle {
                        id: rec00_03_05
                        width: 150
                        height: 120
                        color: "#161616"
                        radius: 5
                        anchors.leftMargin: 10
                        Image {
                            id: image00_03_05
                            x: 0
                            y: 0
                            width: 120
                            height: 90
                            source: "../images/0-color/HMI-ICON-28.png"
                            z: 0
                            anchors.top: parent.top
                            fillMode: Image.PreserveAspectCrop
                            anchors.horizontalCenter: parent.horizontalCenter
                            sourceSize.width: 267
                            sourceSize.height: 267
                            anchors.topMargin: 0
                        }

                        Text {
                            id: txt00_03_05
                            width: 150
                            color: "#ffffff"
                            text: qsTr("Battery Error")
                            verticalAlignment: Text.AlignVCenter
                            anchors.top: image00_03_05.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 16
                            anchors.topMargin: 6
                        }
                        border.width: 0
                        anchors.top: rec00_02_05.bottom
                        border.color: "#ffffff"
                        anchors.left: rec00_02_04.right
                        anchors.topMargin: 10
                    }

                    Rectangle {
                        id: rec00_03_06
                        width: 150
                        height: 120
                        color: "#161616"
                        radius: 5
                        anchors.leftMargin: 10
                        Image {
                            id: image00_03_06
                            x: 0
                            y: 0
                            width: 120
                            height: 90
                            z: 0
                            source: "../images/1-white/HMI-ICON-69.png"
                            anchors.top: parent.top
                            fillMode: Image.PreserveAspectCrop
                            anchors.horizontalCenter: parent.horizontalCenter
                            sourceSize.width: 267
                            sourceSize.height: 267
                            anchors.topMargin: 0
                        }

                        Text {
                            id: txt00_03_06
                            width: 150
                            color: "#ffffff"
                            text: qsTr("Cell Volt. Diff.")
                            verticalAlignment: Text.AlignVCenter
                            anchors.top: image00_03_06.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: 16
                            horizontalAlignment: Text.AlignHCenter
                            anchors.topMargin: 7
                        }
                        border.width: 0
                        anchors.top: rec00_02_06.bottom
                        border.color: "#ffffff"
                        anchors.left: rec00_03_05.right
                        anchors.topMargin: 10
                    }

                    Rectangle {
                        id: rec00_03_07
                        width: 150
                        height: 120
                        color: "#161616"
                        radius: 5
                        anchors.leftMargin: 10
                        Image {
                            id: image00_03_07
                            x: 0
                            y: 0
                            width: 120
                            height: 90
                            source: "../images/1-white/HMI-ICON-67.png"
                            z: 0
                            anchors.top: parent.top
                            fillMode: Image.PreserveAspectCrop
                            anchors.horizontalCenter: parent.horizontalCenter
                            sourceSize.width: 267
                            sourceSize.height: 267
                            anchors.topMargin: 0
                        }

                        Text {
                            id: txt00_03_07
                            width: 150
                            color: "#ffffff"
                            text: qsTr("Minimum Cell. Volt.")
                            verticalAlignment: Text.AlignVCenter
                            anchors.top: image00_03_07.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 16
                            anchors.topMargin: 6
                        }
                        border.width: 0
                        anchors.top: rec00_02_07.bottom
                        border.color: "#ffffff"
                        anchors.left: rec00_03_06.right
                        anchors.topMargin: 10
                    }

                    Rectangle {
                        id: rec00_04_00
                        width: 150
                        height: 120
                        color: "#161616"
                        radius: 5
                        anchors.leftMargin: 5
                        Image {
                            id: image00_04_00
                            x: 0
                            y: 0
                            width: 120
                            height: 90
                            z: 0
                            source: "../images/1-white/HMI-ICON-65.png"
                            anchors.top: parent.top
                            fillMode: Image.PreserveAspectCrop
                            anchors.horizontalCenter: parent.horizontalCenter
                            sourceSize.width: 267
                            sourceSize.height: 267
                            anchors.topMargin: 0
                        }

                        Text {
                            id: txt00_04_00
                            width: 150
                            color: "#ffffff"
                            text: qsTr("Maximum Cell. Volt.")
                            verticalAlignment: Text.AlignVCenter
                            anchors.top: image00_04_00.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: 16
                            horizontalAlignment: Text.AlignHCenter
                            anchors.topMargin: 6
                        }
                        border.width: 0
                        anchors.top: rec00_03_00.bottom
                        border.color: "#ffffff"
                        anchors.left: parent.left
                        anchors.topMargin: 10
                    }

                    Rectangle {
                        id: rec00_04_01
                        width: 150
                        height: 120
                        color: "#161616"
                        radius: 5
                        anchors.leftMargin: 10
                        Image {
                            id: image00_04_01
                            x: 0
                            y: 0
                            width: 120
                            height: 90
                            source: "../images/1-white/HMI-ICON-71.png"
                            z: 0
                            anchors.top: parent.top
                            fillMode: Image.PreserveAspectCrop
                            anchors.horizontalCenter: parent.horizontalCenter
                            sourceSize.width: 267
                            sourceSize.height: 267
                            anchors.topMargin: 0
                        }

                        Text {
                            id: txt00_04_01
                            width: 150
                            color: "#ffffff"
                            text: qsTr("Battery Management Sys.")
                            verticalAlignment: Text.AlignVCenter
                            anchors.top: image00_04_01.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 13
                            anchors.topMargin: 9
                        }
                        border.width: 0
                        anchors.top: rec00_03_01.bottom
                        border.color: "#ffffff"
                        anchors.left: rec00_04_00.right
                        anchors.topMargin: 10
                    }

                    Rectangle {
                        id: rec00_04_02
                        width: 150
                        height: 120
                        color: "#161616"
                        radius: 5
                        anchors.leftMargin: 10
                        Image {
                            id: image00_04_02
                            x: 0
                            y: 0
                            width: 120
                            height: 90
                            z: 0
                            source: "../images/0-color/HMI-ICON-72.png"
                            anchors.top: parent.top
                            fillMode: Image.PreserveAspectCrop
                            anchors.horizontalCenter: parent.horizontalCenter
                            sourceSize.width: 267
                            sourceSize.height: 267
                            anchors.topMargin: 0
                        }

                        Text {
                            id: txt00_04_02
                            width: 150
                            color: "#ffffff"
                            text: qsTr("BMS Error Code")
                            verticalAlignment: Text.AlignVCenter
                            anchors.top: image00_04_02.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: 13
                            horizontalAlignment: Text.AlignHCenter
                            anchors.topMargin: 9
                        }
                        border.width: 0
                        anchors.top: rec00_03_00.bottom
                        border.color: "#ffffff"
                        anchors.left: rec00_04_01.right
                        anchors.topMargin: 10
                    }

                    Rectangle {
                        id: rec00_04_03
                        width: 150
                        height: 120
                        color: "#161616"
                        radius: 5
                        anchors.leftMargin: 10
                        Image {
                            id: image00_04_03
                            x: 0
                            y: 0
                            width: 120
                            height: 90
                            source: "../images/0-color/HMI-ICON-72.png"
                            z: 0
                            anchors.top: parent.top
                            fillMode: Image.PreserveAspectCrop
                            anchors.horizontalCenter: parent.horizontalCenter
                            sourceSize.width: 267
                            sourceSize.height: 267
                            anchors.topMargin: 0
                        }

                        Text {
                            id: txt00_04_03
                            width: 150
                            color: "#ffffff"
                            text: qsTr("Air Pressure Lock Release")
                            verticalAlignment: Text.AlignVCenter
                            anchors.top: image00_04_03.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 12
                            anchors.topMargin: 11
                        }
                        border.width: 0
                        anchors.top: rec00_03_00.bottom
                        border.color: "#ffffff"
                        anchors.left: rec00_04_02.right
                        anchors.topMargin: 10
                    }

                    Rectangle {
                        id: rec00_04_04
                        width: 150
                        height: 120
                        color: "#161616"
                        radius: 5
                        anchors.leftMargin: 10
                        Image {
                            id: image00_04_04
                            x: 0
                            y: 0
                            width: 120
                            height: 90
                            z: 0
                            source: "../images/0-color/HMI-ICON-72.png"
                            anchors.top: parent.top
                            fillMode: Image.PreserveAspectCrop
                            anchors.horizontalCenter: parent.horizontalCenter
                            sourceSize.width: 267
                            sourceSize.height: 267
                            anchors.topMargin: 0
                        }

                        Text {
                            id: txt00_04_04
                            width: 150
                            color: "#ffffff"
                            text: qsTr("Door Lock Release")
                            verticalAlignment: Text.AlignVCenter
                            anchors.top: image00_04_04.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: 14
                            horizontalAlignment: Text.AlignHCenter
                            anchors.topMargin: 11
                        }
                        border.width: 0
                        anchors.top: rec00_03_00.bottom
                        border.color: "#ffffff"
                        anchors.left: rec00_04_03.right
                        anchors.topMargin: 10
                    }

                    Rectangle {
                        id: rec00_04_5
                        width: 150
                        height: 120
                        color: "#161616"
                        radius: 5
                        anchors.leftMargin: 0
                        Image {
                            id: image00_04_5
                            x: 0
                            y: 0
                            width: 120
                            height: 90
                            source: "../images/0-color/HMI-ICON-72.png"
                            z: 0
                            anchors.top: parent.top
                            fillMode: Image.PreserveAspectCrop
                            anchors.horizontalCenter: parent.horizontalCenter
                            sourceSize.width: 267
                            sourceSize.height: 267
                            anchors.topMargin: 0
                        }

                        Text {
                            id: txt00_04_5
                            width: 150
                            color: "#ffffff"
                            text: qsTr("Door Lock Release")
                            verticalAlignment: Text.AlignVCenter
                            anchors.top: image00_04_5.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 12
                            anchors.topMargin: 11
                        }
                        border.width: 0
                        anchors.top: rec00_03_00.bottom
                        border.color: "#ffffff"
                        anchors.left: parent.left
                        anchors.topMargin: 10
                    }

                    Rectangle {
                        id: rec00_04_05
                        width: 150
                        height: 120
                        color: "#161616"
                        radius: 5
                        anchors.leftMargin: 10
                        Image {
                            id: image00_04_4
                            x: 0
                            y: 0
                            width: 120
                            height: 90
                            source: "../images/0-color/HMI-ICON-72.png"
                            z: 0
                            anchors.top: parent.top
                            fillMode: Image.PreserveAspectCrop
                            anchors.horizontalCenter: parent.horizontalCenter
                            sourceSize.width: 267
                            sourceSize.height: 267
                            anchors.topMargin: 0
                        }

                        Text {
                            id: txt00_04_4
                            width: 150
                            color: "#ffffff"
                            text: qsTr("EMG. Door Lock Release")
                            verticalAlignment: Text.AlignVCenter
                            anchors.top: image00_04_4.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 13
                            anchors.topMargin: 11
                        }
                        border.width: 0
                        anchors.top: rec00_03_00.bottom
                        border.color: "#ffffff"
                        anchors.left: rec00_04_04.right
                        anchors.topMargin: 10
                    }

                    Rectangle {
                        id: rec00_04_06
                        width: 150
                        height: 120
                        color: "#161616"
                        radius: 5
                        anchors.leftMargin: 10
                        Image {
                            id: image00_04_06
                            x: 0
                            y: 0
                            width: 120
                            height: 90
                            z: 0
                            source: "../images/0-color/HMI-ICON-72.png"
                            anchors.top: parent.top
                            fillMode: Image.PreserveAspectCrop
                            anchors.horizontalCenter: parent.horizontalCenter
                            sourceSize.width: 267
                            sourceSize.height: 267
                            anchors.topMargin: 0
                        }

                        Text {
                            id: txt00_04_06
                            width: 150
                            color: "#ffffff"
                            text: qsTr("Collision Lock Release")
                            verticalAlignment: Text.AlignVCenter
                            anchors.top: image00_04_06.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: 13
                            horizontalAlignment: Text.AlignHCenter
                            anchors.topMargin: 11
                        }
                        border.width: 0
                        anchors.top: rec00_03_00.bottom
                        border.color: "#ffffff"
                        anchors.left: rec00_04_05.right
                        anchors.topMargin: 10
                    }

                    Rectangle {
                        id: rec00_04_07
                        width: 150
                        height: 120
                        color: "#161616"
                        radius: 5
                        anchors.leftMargin: 10
                        Image {
                            id: image00_04_07
                            x: 0
                            y: 0
                            width: 120
                            height: 90
                            source: "../images/0-color/HMI-ICON-72.png"
                            z: 0
                            anchors.top: parent.top
                            fillMode: Image.PreserveAspectCrop
                            anchors.horizontalCenter: parent.horizontalCenter
                            sourceSize.width: 267
                            sourceSize.height: 267
                            anchors.topMargin: 0
                        }

                        Text {
                            id: txt00_04_07
                            width: 150
                            color: "#ffffff"
                            text: qsTr("ECAS Lock Release")
                            verticalAlignment: Text.AlignVCenter
                            anchors.top: image00_04_07.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 13
                            anchors.topMargin: 11
                        }
                        border.width: 0
                        anchors.top: rec00_03_00.bottom
                        border.color: "#ffffff"
                        anchors.left: rec00_04_06.right
                        anchors.topMargin: 10
                    }



                }
        }
        Item {
        id: secondPage
                Rectangle {
                    id: grid1
                    width: style.resolutionWidth
                    height: 665
            color: "#161616"
                    //columns: 10
                    //columnSpacing: 10
                    //spacing: 2
                    // ( page, row, column )
                    Rectangle { id: rec01_00_00; width: 150; height: 120
                        color: "#161616"
                        radius: 5
                        border.width: 0
                        anchors.left: parent.left
                        anchors.leftMargin: 5
                        border.color: "#ffffff"
                        Image {
                            id: image01_00_00
                            x: 0
                            y: 0
                            width: 120
                            height: 90
                            anchors.horizontalCenter: parent.horizontalCenter
                            sourceSize.height: 267
                            sourceSize.width: 267
                            anchors.topMargin: 0
                            z: 0
                            anchors.top: parent.top
                            source: "../images/0-color/HMI-ICON-01.png"
                            fillMode: Image.PreserveAspectCrop
                        }
                        Text {
                            id: txt01_00_00
                            width: 150
                            color: "#ffffff"
                            text: qsTr("Low Volt. Lock Release")
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: image01_00_00.bottom
                            anchors.topMargin: 5
                            verticalAlignment: Text.AlignVCenter
                            font.pixelSize: 15
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }

                    Rectangle {
                        id: rec01_00_01
                        x: 5
                        y: 0
                        width: 150
                        height: 120
                        color: "#161616"
                        radius: 5
                        anchors.top: parent.top
                        anchors.topMargin: 0
                        anchors.leftMargin: 10
                        Image {
                            id: image01_00_01
                            x: 0
                            y: 0
                            width: 120
                            height: 90
                            source: "../images/0-color/HMI-ICON-01.png"
                            z: 0
                            anchors.top: parent.top
                            fillMode: Image.PreserveAspectCrop
                            anchors.horizontalCenter: parent.horizontalCenter
                            sourceSize.width: 267
                            sourceSize.height: 267
                            anchors.topMargin: 0
                        }

                        Text {
                            id: txt01_00_01
                            width: 150
                            color: "#ffffff"
                            text: qsTr("Alarm Reset")
                            verticalAlignment: Text.AlignVCenter
                            anchors.top: image01_00_01.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 15
                            anchors.topMargin: 6
                        }
                        border.width: 0
                        border.color: "#ffffff"
                        anchors.left: rec01_00_00.right
                    }

                    Rectangle {
                        id: rec01_00_02
                        x: 5
                        y: 0
                        width: 150
                        height: 120
                        color: "#161616"
                        radius: 5
                        anchors.leftMargin: 10
                        Image {
                            id: image01_00_02
                            x: 0
                            y: 0
                            width: 120
                            height: 90
                            z: 0
                            source: "../images/0-color/HMI-ICON-01.png"
                            anchors.top: parent.top
                            fillMode: Image.PreserveAspectCrop
                            anchors.horizontalCenter: parent.horizontalCenter
                            sourceSize.width: 267
                            sourceSize.height: 267
                            anchors.topMargin: 0
                        }

                        Text {
                            id: txt01_00_02
                            width: 150
                            color: "#ffffff"
                            text: qsTr("Power Control Unit")
                            verticalAlignment: Text.AlignVCenter
                            anchors.top: image01_00_02.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: 15
                            horizontalAlignment: Text.AlignHCenter
                            anchors.topMargin: 6
                        }
                        border.width: 0
                        anchors.top: parent.top
                        border.color: "#ffffff"
                        anchors.left: rec01_00_01.right
                        anchors.topMargin: 0
                    }

                    Rectangle {
                        id: rec01_00_03
                        y: 0
                        width: 150
                        height: 120
                        color: "#161616"
                        radius: 5
                        anchors.leftMargin: 10
                        Image {
                            id: image01_00_03
                            x: 0
                            y: 0
                            width: 120
                            height: 90
                            z: 0
                            source: "../images/0-color/HMI-ICON-01.png"
                            anchors.top: parent.top
                            fillMode: Image.PreserveAspectCrop
                            anchors.horizontalCenter: parent.horizontalCenter
                            sourceSize.width: 267
                            sourceSize.height: 267
                            anchors.topMargin: 0
                        }

                        Text {
                            id: txt01_00_03
                            width: 150
                            color: "#ffffff"
                            text: qsTr("Motor Driver")
                            verticalAlignment: Text.AlignVCenter
                            anchors.top: image01_00_03.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: 15
                            horizontalAlignment: Text.AlignHCenter
                            anchors.topMargin: 5
                        }
                        border.width: 0
                        anchors.top: parent.top
                        border.color: "#ffffff"
                        anchors.left: rec01_00_02.right
                        anchors.topMargin: 0
                    }

                    Rectangle {
                        id: rec01_00_04
                        y: 0
                        width: 150
                        height: 120
                        color: "#161616"
                        radius: 5
                        anchors.leftMargin: 10
                        Image {
                            id: image01_00_04
                            x: 0
                            y: 0
                            width: 120
                            height: 90
                            source: "../images/0-color/HMI-ICON-01.png"
                            z: 0
                            anchors.top: parent.top
                            fillMode: Image.PreserveAspectCrop
                            anchors.horizontalCenter: parent.horizontalCenter
                            sourceSize.width: 267
                            sourceSize.height: 267
                            anchors.topMargin: 0
                        }

                        Text {
                            id: txt01_00_04
                            width: 150
                            color: "#ffffff"
                            text: qsTr("Water Pump")
                            verticalAlignment: Text.AlignVCenter
                            anchors.top: image01_00_04.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 15
                            anchors.topMargin: 5
                        }
                        border.width: 0
                        anchors.top: parent.top
                        border.color: "#ffffff"
                        anchors.left: rec01_00_03.right
                        anchors.topMargin: 0
                    }

                    Rectangle {
                        id: rec01_00_05
                        y: 0
                        width: 150
                        height: 120
                        color: "#161616"
                        radius: 5
                        anchors.leftMargin: 10
                        Image {
                            id: image01_00_05
                            x: 0
                            y: 0
                            width: 120
                            height: 90
                            z: 0
                            source: "../images/0-color/HMI-ICON-01.png"
                            anchors.top: parent.top
                            fillMode: Image.PreserveAspectCrop
                            anchors.horizontalCenter: parent.horizontalCenter
                            sourceSize.width: 267
                            sourceSize.height: 267
                            anchors.topMargin: 0
                        }

                        Text {
                            id: txt01_00_4
                            width: 150
                            color: "#ffffff"
                            text: qsTr("Water Cooling Fan")
                            verticalAlignment: Text.AlignVCenter
                            anchors.top: image01_00_05.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: 15
                            horizontalAlignment: Text.AlignHCenter
                            anchors.topMargin: 5
                        }
                        border.width: 0
                        anchors.top: parent.top
                        border.color: "#ffffff"
                        anchors.left: rec01_00_04.right
                        anchors.topMargin: 0
                    }

                    Rectangle {
                        id: rec01_00_06
                        y: 0
                        width: 150
                        height: 120
                        color: "#161616"
                        radius: 5
                        anchors.leftMargin: 10
                        Image {
                            id: image01_00_06
                            x: 0
                            y: 0
                            width: 120
                            height: 90
                            source: "../images/0-color/HMI-ICON-01.png"
                            z: 0
                            anchors.top: parent.top
                            fillMode: Image.PreserveAspectCrop
                            anchors.horizontalCenter: parent.horizontalCenter
                            sourceSize.width: 267
                            sourceSize.height: 267
                            anchors.topMargin: 0
                        }

                        Text {
                            id: txt01_00_06
                            width: 150
                            color: "#ffffff"
                            text: qsTr("Air Compressor")
                            verticalAlignment: Text.AlignVCenter
                            anchors.top: image01_00_06.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 15
                            anchors.topMargin: 5
                        }
                        border.width: 0
                        anchors.top: parent.top
                        border.color: "#ffffff"
                        anchors.left: rec01_00_05.right
                        anchors.topMargin: 0
                    }

                    Rectangle {
                        id: rec01_00_07
                        y: 0
                        width: 150
                        height: 120
                        color: "#161616"
                        radius: 5
                        anchors.leftMargin: 10
                        Image {
                            id: image01_00_07
                            x: 0
                            y: 0
                            width: 120
                            height: 90
                            z: 0
                            source: "../images/0-color/HMI-ICON-01.png"
                            anchors.top: parent.top
                            fillMode: Image.PreserveAspectCrop
                            anchors.horizontalCenter: parent.horizontalCenter
                            sourceSize.width: 267
                            sourceSize.height: 267
                            anchors.topMargin: 0
                        }

                        Text {
                            id: txt01_00_07
                            width: 150
                            color: "#ffffff"
                            text: qsTr("Hydraulic Pump")
                            verticalAlignment: Text.AlignVCenter
                            anchors.top: image01_00_07.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: 15
                            horizontalAlignment: Text.AlignHCenter
                            anchors.topMargin: 5
                        }
                        border.width: 0
                        anchors.top: parent.top
                        border.color: "#ffffff"
                        anchors.left: rec01_00_06.right
                        anchors.topMargin: 0
                    }

                    Rectangle {
                        id: rec01_01_00
                        width: 150
                        height: 120
                        color: "#161616"
                        radius: 5
                        anchors.top: rec01_00_00.bottom
                        anchors.topMargin: 10
                        anchors.leftMargin: 5
                        Image {
                            id: image01_01_00
                            x: 0
                            y: 0
                            width: 120
                            height: 90
                            z: 0
                            source: "../images/0-color/HMI-ICON-01.png"
                            anchors.top: parent.top
                            fillMode: Image.PreserveAspectCrop
                            anchors.horizontalCenter: parent.horizontalCenter
                            sourceSize.width: 267
                            sourceSize.height: 267
                            anchors.topMargin: 0
                        }

                        Text {
                            id: txt01_01_00
                            width: 150
                            color: "#ffffff"
                            text: qsTr("DCDC Converter")
                            verticalAlignment: Text.AlignVCenter
                            anchors.top: image01_01_00.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: 15
                            horizontalAlignment: Text.AlignHCenter
                            anchors.topMargin: 5
                        }
                        border.width: 0
                        border.color: "#ffffff"
                        anchors.left: parent.left
                    }

                    Rectangle {
                        id: rec01_01_01
                        width: 150
                        height: 120
                        color: "#161616"
                        radius: 5
                        anchors.leftMargin: 10
                        Image {
                            id: image01_01_0
                            x: 0
                            y: 0
                            width: 120
                            height: 90
                            source: "../images/0-color/HMI-ICON-01.png"
                            z: 0
                            anchors.top: parent.top
                            fillMode: Image.PreserveAspectCrop
                            anchors.horizontalCenter: parent.horizontalCenter
                            sourceSize.width: 267
                            sourceSize.height: 267
                            anchors.topMargin: 0
                        }

                        Text {
                            id: txt01_01_0
                            width: 150
                            color: "#ffffff"
                            text: qsTr("24V Battery")
                            verticalAlignment: Text.AlignVCenter
                            anchors.top: image01_01_0.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 15
                            anchors.topMargin: 5
                        }
                        border.width: 0
                        anchors.top: rec01_00_00.bottom
                        border.color: "#ffffff"
                        anchors.left: rec01_01_00.right
                        anchors.topMargin: 10
                    }

                    Rectangle {
                        id: rec01_01_02
                        width: 150
                        height: 120
                        color: "#161616"
                        radius: 5
                        anchors.leftMargin: 10
                        Image {
                            id: image01_01_1
                            x: 0
                            y: 0
                            width: 120
                            height: 90
                            z: 0
                            source: "../images/0-color/HMI-ICON-01.png"
                            anchors.top: parent.top
                            fillMode: Image.PreserveAspectCrop
                            anchors.horizontalCenter: parent.horizontalCenter
                            sourceSize.width: 267
                            sourceSize.height: 267
                            anchors.topMargin: 0
                        }

                        Text {
                            id: txt01_01_1
                            width: 150
                            color: "#ffffff"
                            text: qsTr("Cell Management Sys.")
                            verticalAlignment: Text.AlignVCenter
                            anchors.top: image01_01_1.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: 15
                            horizontalAlignment: Text.AlignHCenter
                            anchors.topMargin: 5
                        }
                        border.width: 0
                        anchors.top: rec01_00_00.bottom
                        border.color: "#ffffff"
                        anchors.left: rec01_01_01.right
                        anchors.topMargin: 10
                    }
                }
        }
    // TODO:
        /*Item {
        id: thirdPage
        }*/
    }
    PageIndicator {
        id: indicator

        count: view.count
        currentIndex: view.currentIndex

        anchors.bottom: view.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }
    }

    Rectangle {
        id: rowiconDescription
        x: 200
        y: 30
        width: 300
        height: 43
    color: "#161616"
        anchors.leftMargin: 50
        Text {
            id: txticonDescription
            y: 0
            width: 100
            height: 43
            color: "#ffffff"
            text: qsTr("ICON Legend")
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

    Row {
        id: rowInstantMessage
        objectName: "instantMessage"
        x: 152
        width: style.resolutionWidth
        height: style.msgBarHeight
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        Rectangle {
            id: recMessage
            x: 0
            y: 0
            width: style.resolutionWidth
            height: 50
            color: "#1f1f1f"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
        }
    }

    onActiveChanged : {
    if ( true === iconDescription.active ) {
        iconDescription.qmlSignalActive("IconDescription");
    }
    }

}

/*##^## Designer {
    D{i:0;height:768;width:1024}
}
 ##^##*/
