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
import "style"

Window {
    id: tpms

    // ( https://goo.gl/LWbdMG )
    objectName: "tpmsWindow"

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
    property alias window: tpms
    flags: Qt.FramelessWindowHint
    title: "TPMS"

    // Property names must begin with a lower case letter
    // and can only contain letters ( https://goo.gl/HzLQet )
    //
    //property string batteryPackName
    signal qmlSignal(string msg)
    signal qmlSignalActive(string msg)

    function updateMsg_TPMS_MSG01(
    ax,tyr,prssr,temp,conn,lk_a,ht_a,pr_drop_rate,pr_alarm) {
    switch ( ax ) {
        case 0:
        switch ( tyr ) {
            case 0:
            txtA0T0_PressureVal.text = prssr;
            txtA0T0_FrateVal.text = lk_a;
            txtA0T0_TempVal.text = temp;
            break;
            case 1:
            txtA0T1_PressureVal.text = prssr;
            txtA0T1_FrateVal.text = lk_a;
            txtA0T1_TempVal.text = temp;
            break;
            default:
            break;
        }
        break;

        case 1:
        switch ( tyr ) {
            case 0:
            txtA1T0_PressureVal.text = prssr;
            txtA1T0_FrateVal.text = lk_a;
            txtA1T0_TempVal.text = temp;
            break;
            case 1:
            txtA1T1_PressureVal.text = prssr;
            txtA1T1_FrateVal.text = lk_a;
            txtA1T1_TempVal.text = temp;
            break;
            case 2:
            txtA1T2_PressureVal.text = prssr;
            txtA1T2_FrateVal.text = lk_a;
            txtA1T2_TempVal.text = temp;
            break;
            case 3:
            txtA1T3_PressureVal.text = prssr;
            txtA1T3_FrateVal.text = lk_a;
            txtA1T3_TempVal.text = temp;
            break;
            default:
            break;
        }
        break;

        default:
        break;
    }
    }

    function updateMsg_TPMS_MSG02() {
    }

    Rectangle {
        id: rectangletpms
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
        }
        source: "../images/0-color/HMI-ICON-55.png"
        fillMode: Image.PreserveAspectFit
        MouseArea {
        id: maBack
        z: 2
        anchors.fill: parent
        onClicked: {
        tpms.hide();
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
            id: txttpms
            y: 0
            width: 100
            height: 43
            color: "#ffffff"
            text: qsTr("TPMS")
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
    height: 50
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
        anchors.bottomMargin: -3
        anchors.bottom: parent.bottom
    }
    }

    Image {
        id: imgBody
        x: 590
        y: 179
        width: style.resolutionWidth
        height: style.resolutionHeight
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        sourceSize.height: 208
        sourceSize.width: 318
        source: "../images/0-color/20190828TPMS-06.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imgA0T0
        x: 200
        y: 77
        width: 100
        height: 100
        source: "../images/0-color/201905ICON-22.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imgA0T1
        x: 724
        y: 77
        width: 100
        height: 100
        source: "../images/0-color/201905ICON-22.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imgA1T1
        x: 473
        y: 450
        width: 100
        height: 100
        source: "../images/0-color/201905ICON-22.png"
        fillMode: Image.PreserveAspectFit

        Image {
            id: imgA1T0
            x: -416
            y: 4
            width: 100
            height: 100
            source: "../images/0-color/201905ICON-22.png"
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: imgA1T2
            x: 224
            y: 4
            width: 100
            height: 100
            source: "../images/0-color/201905ICON-22.png"
            fillMode: Image.PreserveAspectFit
        }
    }

    Image {
        id: imgA1T3
        x: 895
        y: 458
        width: 100
        height: 100
        source: "../images/0-color/201905ICON-22.png"
        fillMode: Image.PreserveAspectFit
    }

    Rectangle {
        id: recA0T0
        x: 150
        y: 175
        width: 200
        height: 155
        color: "#161616"
        radius: 1
        border.color: "#ffffff"

        Rectangle {
            id: rowA0T0_Pressure
            width: 180
            height: 40
            color: "#161616"
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.left: parent.left
            z: 4
            Rectangle {
                id: recA0T0_Pressure
                y: 379
                width: 100
                height: 25
                color: "#000000"
                radius: 10
                anchors.verticalCenter: parent.verticalCenter
                Text {
                    id: txtA0T0_PressureVal
                    y: 0
                    width: 70
                    height: 25
                    color: "#ffffff"
                    text: qsTr("")
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 20
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                anchors.leftMargin: 0
            }

            Text {
                id: txtA0T0_PressureSuffix
                y: 383
                width: 60
                height: 40
                color: "#ffffff"
                text: qsTr("Bar")
                anchors.left: recA0T0_Pressure.right
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 20
                font.family: "Courier"
                font.bold: true
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                anchors.leftMargin: 10
            }
            anchors.leftMargin: 10
        }

        Rectangle {
            id: rowA0T0_Frate
            x: 10
            width: 180
            height: 40
            color: "#161616"
            anchors.topMargin: 10
            anchors.top: rowA0T0_Pressure.bottom
            z: 4
            Rectangle {
                id: recA0T0_Frate
                y: 379
                width: 100
                height: 25
                color: "#000000"
                radius: 10
                anchors.verticalCenter: parent.verticalCenter
                Text {
                    id: txtA0T0_FrateVal
                    y: 0
                    width: 70
                    height: 25
                    color: "#ffffff"
                    text: qsTr("")
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 20
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                anchors.leftMargin: 0
            }

            Text {
                id: txtA0T0_FrateSuffix
                y: 383
                width: 60
                height: 40
                color: "#ffffff"
                text: qsTr("Bar/s")
                anchors.left: recA0T0_Frate.right
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 20
                font.family: "Courier"
                font.bold: true
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.leftMargin: 10
            }
            anchors.leftMargin: 600
        }

        Rectangle {
            id: rowA0T0_Temp
            width: 180
            height: 40
            color: "#161616"
            anchors.left: parent.left
            anchors.topMargin: 10
            anchors.top: rowA0T0_Frate.bottom
            z: 4
            Rectangle {
                id: recA0T0_Temp
                y: 379
                width: 100
                height: 25
                color: "#000000"
                radius: 10
                anchors.verticalCenter: parent.verticalCenter
                Text {
                    id: txtA0T0_TempVal
                    y: 0
                    width: 70
                    height: 25
                    color: "#ffffff"
                    text: qsTr("")
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 20
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                anchors.leftMargin: 0
            }

            Text {
                id: txtA0T0Suffix
                y: 383
                width: 30
                height: 40
                color: "#ffffff"
                text: qsTr("℃")
                anchors.left: recA0T0_Temp.right
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 20
                font.family: "Courier"
                font.bold: true
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.leftMargin: 10
            }
            anchors.leftMargin: 10
        }
    }

    Rectangle {
        id: rowA0T1_Temp
        y: -4
        width: 180
        height: 40
        color: "#161616"
        anchors.left: recA0T1.left
        anchors.top: rowA0T1_Frate.bottom
        Rectangle {
            id: recA0T1_Temp
            y: 379
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            Text {
                id: txtA0T1_TempVal
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                font.pixelSize: 20
                anchors.horizontalCenter: parent.horizontalCenter
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
            }
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: txtA0T1Suffix
            y: 383
            width: 30
            height: 40
            color: "#ffffff"
            text: qsTr("℃")
            font.pixelSize: 20
            font.bold: true
            verticalAlignment: Text.AlignVCenter
            font.family: "Courier"
            anchors.left: recA0T1_Temp.right
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignHCenter
        }
        anchors.leftMargin: 10
        anchors.topMargin: 10
        z: 4
    }

    Rectangle {
        id: rowA0T1_Frate
        y: -4
        width: 180
        height: 40
        color: "#161616"
        anchors.left: recA0T1.left
        anchors.top: rowA0T1_Pressure.bottom
        Rectangle {
            id: recA0T1_Frate
            y: 379
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            Text {
                id: txtA0T1_FrateVal
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                font.pixelSize: 20
                anchors.horizontalCenter: parent.horizontalCenter
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
            }
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: txtA0T1_FrateSuffix
            y: 383
            width: 60
            height: 40
            color: "#ffffff"
            text: qsTr("Bar/s")
            font.pixelSize: 20
            font.bold: true
            verticalAlignment: Text.AlignVCenter
            font.family: "Courier"
            anchors.left: recA0T1_Frate.right
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignHCenter
        }
        anchors.leftMargin: 10
        anchors.topMargin: 10
        z: 4
    }

    Rectangle {
        id: rowA0T1_Pressure
        y: 188
        width: 180
        height: 40
        color: "#161616"
        anchors.left: recA0T1.left
        Rectangle {
            id: recA0T1_Pressure
            y: 379
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            Text {
                id: txtA0T1_PressureVal
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                font.pixelSize: 20
                anchors.horizontalCenter: parent.horizontalCenter
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
            }
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: txtA0T1_PressureSuffix
            y: 383
            width: 60
            height: 40
            color: "#ffffff"
            text: qsTr("Bar")
            font.pixelSize: 20
            font.bold: true
            verticalAlignment: Text.AlignVCenter
            font.family: "Courier"
            anchors.left: recA0T1_Pressure.right
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
        }
        anchors.leftMargin: 10
        z: 4
    }

    Rectangle {
        id: recA0T1
        x: 802
        y: 175
        width: 200
        height: 155
        color: "#161616"
        radius: 5
        anchors.right: parent.right
        anchors.rightMargin: 150
        border.color: "#ffffff"
    }

    Rectangle {
        id: rowA1T1_Temp
        x: 233
        y: 4
        width: 180
        height: 40
        color: "#161616"
        anchors.top: rowA1T1_Frate.bottom
        Rectangle {
            id: recA1T1_Temp
            y: 379
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            Text {
                id: txtA1T1_TempVal
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                font.pixelSize: 20
                anchors.horizontalCenter: parent.horizontalCenter
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
            }
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: txtA1T1Suffix
            y: 383
            width: 30
            height: 40
            color: "#ffffff"
            text: qsTr("℃")
            font.pixelSize: 20
            font.bold: true
            verticalAlignment: Text.AlignVCenter
            font.family: "Courier"
            anchors.left: recA1T1_Temp.right
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignHCenter
        }
        anchors.leftMargin: 600
        anchors.topMargin: 1
        z: 4
    }

    Rectangle {
        id: rowA1T1_Frate
        x: 234
        y: 4
        width: 180
        height: 40
        color: "#161616"
        anchors.top: rowA1T1_Pressure.bottom
        Rectangle {
            id: recA1T1_Frate
            y: 379
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            Text {
                id: txtA1T1_FrateVal
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                font.pixelSize: 20
                anchors.horizontalCenter: parent.horizontalCenter
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
            }
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: txtA1T1_FrateSuffix
            y: 383
            width: 60
            height: 40
            color: "#ffffff"
            text: qsTr("Bar/s")
            font.pixelSize: 20
            font.bold: true
            verticalAlignment: Text.AlignVCenter
            font.family: "Courier"
            anchors.left: recA1T1_Frate.right
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignHCenter
        }
        anchors.leftMargin: 600
        anchors.topMargin: 1
        z: 4
    }

    Rectangle {
        id: rowA1T1_Pressure
        x: 234
        y: 562
        width: 180
        height: 40
        color: "#161616"
        Rectangle {
            id: recA1T1_Pressure
            y: 379
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            Text {
                id: txtA1T1_PressureVal
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                font.pixelSize: 20
                anchors.horizontalCenter: parent.horizontalCenter
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
            }
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: txtA1T1_PressureSuffix
            y: 383
            width: 60
            height: 40
            color: "#ffffff"
            text: qsTr("Bar")
            font.pixelSize: 20
            font.bold: true
            verticalAlignment: Text.AlignVCenter
            font.family: "Courier"
            anchors.left: recA1T1_Pressure.right
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
        }
        anchors.leftMargin: 600
        z: 4
    }

    Rectangle {
        id: recA1T1
        x: 225
        y: 553
        width: 200
        height: 152
        color: "#161616"
        radius: 5
        border.color: "#ffffff"
    }

    Rectangle {
        id: rowA1T0_Temp
        x: 21
        y: -8
        width: 180
        height: 40
        color: "#161616"
        anchors.top: rowA1T0_Frate.bottom
        Rectangle {
            id: recA1T0_Temp
            y: 379
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            Text {
                id: txtA1T0_TempVal
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                font.pixelSize: 20
                anchors.horizontalCenter: parent.horizontalCenter
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
            }
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: txtA1T0Suffix
            y: 383
            width: 30
            height: 40
            color: "#ffffff"
            text: qsTr("℃")
            font.pixelSize: 20
            font.bold: true
            verticalAlignment: Text.AlignVCenter
            font.family: "Courier"
            anchors.left: recA1T0_Temp.right
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignHCenter
        }
        anchors.leftMargin: 600
        anchors.topMargin: 10
        z: 4
    }

    Rectangle {
        id: rowA1T0_Frate
        x: 21
        y: -8
        width: 180
        height: 40
        color: "#161616"
        anchors.top: rowA1T0_Pressure.bottom
        Rectangle {
            id: recA1T0_Frate
            y: 379
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            Text {
                id: txtA1T0_FrateVal
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                font.pixelSize: 20
                anchors.horizontalCenter: parent.horizontalCenter
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
            }
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: txtA1T0_FrateSuffix
            y: 383
            width: 60
            height: 40
            color: "#ffffff"
            text: qsTr("Bar/s")
            font.pixelSize: 20
            font.bold: true
            verticalAlignment: Text.AlignVCenter
            font.family: "Courier"
            anchors.left: recA1T0_Frate.right
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignHCenter
        }
        anchors.leftMargin: 600
        anchors.topMargin: 10
        z: 4
    }

    Rectangle {
        id: rowA1T0_Pressure
        x: 21
        y: 562
        width: 180
        height: 40
        color: "#161616"
        Rectangle {
            id: recA1T0_Pressure
            y: 379
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            Text {
                id: txtA1T0_PressureVal
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                font.pixelSize: 20
                anchors.horizontalCenter: parent.horizontalCenter
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
            }
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: txtA1T0_PressureSuffix
            y: 383
            width: 60
            height: 40
            color: "#ffffff"
            text: qsTr("Bar")
            font.pixelSize: 20
            font.bold: true
            verticalAlignment: Text.AlignVCenter
            font.family: "Courier"
            anchors.left: recA1T0_Pressure.right
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
        }
        anchors.leftMargin: 600
        z: 4
    }

    Rectangle {
        id: recA1T0
        x: 11
        y: 553
        width: 200
        height: 152
        color: "#161616"
        radius: 5
        border.color: "#ffffff"
    }

    Rectangle {
        id: rowA1T2_Temp
        x: 651
        y: 2
        width: 180
        height: 40
        color: "#161616"
        anchors.top: rowA1T2_Frate.bottom
        Rectangle {
            id: recA1T2_Temp
            y: 379
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            Text {
                id: txtA1T2_TempVal
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                font.pixelSize: 20
                anchors.horizontalCenter: parent.horizontalCenter
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
            }
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: txtA1T2Suffix
            y: 383
            width: 30
            height: 40
            color: "#ffffff"
            text: qsTr("℃")
            font.pixelSize: 20
            font.bold: true
            verticalAlignment: Text.AlignVCenter
            font.family: "Courier"
            anchors.left: recA1T2_Temp.right
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignHCenter
        }
        anchors.leftMargin: 600
        anchors.topMargin: 1
        z: 4
    }

    Rectangle {
        id: rowA1T2_Frate
        x: 651
        y: 2
        width: 180
        height: 40
        color: "#161616"
        anchors.top: rowA1T2_Pressure.bottom
        Rectangle {
            id: recA1T2_Frate
            y: 379
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            Text {
                id: txtA1T2_FrateVal
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                font.pixelSize: 20
                anchors.horizontalCenter: parent.horizontalCenter
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
            }
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: txtA1T2_FrateSuffix
            y: 383
            width: 60
            height: 40
            color: "#ffffff"
            text: qsTr("Bar/s")
            font.pixelSize: 20
            font.bold: true
            verticalAlignment: Text.AlignVCenter
            font.family: "Courier"
            anchors.left: recA1T2_Frate.right
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignHCenter
        }
        anchors.leftMargin: 600
        anchors.topMargin: 1
        z: 4
    }

    Rectangle {
        id: rowA1T2_Pressure
        y: 562
        width: 180
        height: 40
        color: "#161616"
        anchors.left: parent.left
        Rectangle {
            id: recA1T2_Pressure
            y: 379
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            Text {
                id: txtA1T2_PressureVal
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                font.pixelSize: 20
                anchors.horizontalCenter: parent.horizontalCenter
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
            }
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: txtA1T2_PressureSuffix
            y: 383
            width: 60
            height: 40
            color: "#ffffff"
            text: qsTr("Bar")
            font.pixelSize: 20
            font.bold: true
            verticalAlignment: Text.AlignVCenter
            font.family: "Courier"
            anchors.left: recA1T2_Pressure.right
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
        }
        anchors.leftMargin: 651
        z: 4
    }

    Rectangle {
        id: recA1T2
        x: 641
        y: 554
        width: 200
        height: 152
        color: "#161616"
        radius: 5
        border.color: "#ffffff"
    }

    Rectangle {
        id: rowA1T3_Temp
        x: 860
        y: -3
        width: 180
        height: 40
        color: "#161616"
        anchors.top: rowA1T3_Frate.bottom
        Rectangle {
            id: recA1T3_Temp
            y: 379
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            Text {
                id: txtA1T3_TempVal
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                font.pixelSize: 20
                anchors.horizontalCenter: parent.horizontalCenter
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
            }
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: txtA1T3Suffix
            y: 383
            width: 30
            height: 40
            color: "#ffffff"
            text: qsTr("℃")
            font.pixelSize: 20
            font.bold: true
            verticalAlignment: Text.AlignVCenter
            font.family: "Courier"
            anchors.left: recA1T3_Temp.right
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignHCenter
        }
        anchors.leftMargin: 600
        anchors.topMargin: 10
        z: 4
    }

    Rectangle {
        id: rowA1T3_Frate
        x: 860
        y: -3
        width: 180
        height: 40
        color: "#161616"
        anchors.top: rowA1T3_Pressure.bottom
        Rectangle {
            id: recA1T3_Frate
            y: 379
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            Text {
                id: txtA1T3_FrateVal
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                font.pixelSize: 20
                anchors.horizontalCenter: parent.horizontalCenter
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
            }
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: txtA1T3_FrateSuffix
            y: 383
            width: 60
            height: 40
            color: "#ffffff"
            text: qsTr("Bar/s")
            font.pixelSize: 20
            font.bold: true
            verticalAlignment: Text.AlignVCenter
            font.family: "Courier"
            anchors.left: recA1T3_Frate.right
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignHCenter
        }
        anchors.leftMargin: 600
        anchors.topMargin: 10
        z: 4
    }

    Rectangle {
        id: rowA1T3_Pressure
        x: 860
        y: 562
        width: 180
        height: 40
        color: "#161616"
        Rectangle {
            id: recA1T3_Pressure
            y: 379
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            Text {
                id: txtA1T3_PressureVal
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                font.pixelSize: 20
                anchors.horizontalCenter: parent.horizontalCenter
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
            }
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: txtA1T3_PressureSuffix
            y: 383
            width: 60
            height: 40
            color: "#ffffff"
            text: qsTr("Bar")
            font.pixelSize: 20
            font.bold: true
            verticalAlignment: Text.AlignVCenter
            font.family: "Courier"
            anchors.left: recA1T3_Pressure.right
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
        }
        anchors.leftMargin: 600
        z: 4
    }

    Rectangle {
        id: recA1T3
        x: 850
        y: 554
        width: 200
        height: 152
        color: "#161616"
        radius: 5
        border.color: "#ffffff"
    }

    onActiveChanged : {
    if ( true === tpms.active ) {
        tpms.qmlSignalActive("Tpms");
    }
    }

}











































































































/*##^## Designer {
    D{i:30;anchors_x:822;anchors_y:260}D{i:18;anchors_width:200;anchors_x:150}D{i:34;anchors_x:822;anchors_y:216}
D{i:38;anchors_x:822}D{i:43;anchors_y:260}D{i:47;anchors_y:216}D{i:56;anchors_y:260}
D{i:60;anchors_y:216}D{i:69;anchors_y:260}D{i:73;anchors_y:216}D{i:77;anchors_x:812}
D{i:82;anchors_y:260}D{i:86;anchors_y:216}
}
 ##^##*/
