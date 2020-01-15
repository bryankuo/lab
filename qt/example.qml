

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
import QtQuick.Window 2.1
// needed for the Window component
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
    Styles {
        id: style
    }
    Models {
        id: model
    }
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
    property int boxw: 192
    property int boxh: 97
    property int rowh: 25
    property int rowtmgn: 5
    property int rowlmgn: 5
    flags: Qt.FramelessWindowHint
    title: "TPMS"

    // Property names must begin with a lower case letter
    // and can only contain letters ( https://goo.gl/HzLQet )
    //property string batteryPackName
    signal qmlSignal(string msg)

    function updateMsg_TPMS_MSG01(ax, tyr, prssr, temp, conn, lk_a, ht_a, pr_drop_rate, pr_alarm) {
        switch (ax) {
        case 0:
            switch (tyr) {
            case 0:
                txtA0T0_PressureVal.text = prssr
                txtA0T0_FrateVal.text = lk_a
                txtA0T0_TempVal.text = temp
                break
            case 1:
                txtA0T1_PressureVal.text = prssr
                txtA0T1_FrateVal.text = lk_a
                txtA0T1_TempVal.text = temp
                break
            default:
                break
            }
            break
        case 1:
            switch (tyr) {
            case 0:
                txtA1T0_PressureVal.text = prssr
                txtA1T0_FrateVal.text = lk_a
                txtA1T0_TempVal.text = temp
                break
            case 1:
                txtA1T1_PressureVal.text = prssr
                txtA1T1_FrateVal.text = lk_a
                txtA1T1_TempVal.text = temp
                break
            case 2:
                txtA1T2_PressureVal.text = prssr
                txtA1T2_FrateVal.text = lk_a
                txtA1T2_TempVal.text = temp
                break
            case 3:
                txtA1T3_PressureVal.text = prssr
                txtA1T3_FrateVal.text = lk_a
                txtA1T3_TempVal.text = temp
                break
            default:
                break
            }
            break
        default:
            break
        }
    }

    function updateMsg_TPMS_MSG02() {}

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
                root.qmlSignalWindowClose(tpms.objectName)
                tpms.close()
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

    Rectangle {
        id: recA0T0
        x: 150
        y: 175
        width: 200
        height: boxh
        color: "#161616"
        radius: 5
        anchors.horizontalCenterOffset: -270
        anchors.horizontalCenter: parent.horizontalCenter
        border.color: "#ffffff"

        Rectangle {
            id: rowA0T0_Pressure
            width: 180
            height: rowh
            color: "#161616"
            anchors.top: parent.top
            anchors.topMargin: rowtmgn
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
                height: rowh
                color: "#ffffff"
                text: qsTr("Bar")
                anchors.left: recA0T0_Pressure.right
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 20
                font.family: "Courier"
                font.bold: true
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                anchors.leftMargin: rowlmgn
            }
            anchors.leftMargin: rowlmgn
        }

        Rectangle {
            id: rowA0T0_Frate
            width: 180
            height: rowh
            color: "#161616"
            anchors.left: parent.left
            anchors.topMargin: rowtmgn
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
                height: rowh
                color: "#ffffff"
                text: qsTr("Bar/s")
                anchors.left: recA0T0_Frate.right
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 20
                font.family: "Courier"
                font.bold: true
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.leftMargin: rowlmgn
            }
            anchors.leftMargin: rowlmgn
        }

        Rectangle {
            id: rowA0T0_Temp
            width: 180
            height: rowh
            color: "#161616"
            anchors.left: parent.left
            anchors.topMargin: rowtmgn
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
                height: rowh
                color: "#ffffff"
                text: qsTr("℃")
                anchors.left: recA0T0_Temp.right
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 20
                font.family: "Courier"
                font.bold: true
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.leftMargin: rowlmgn
            }
            anchors.leftMargin: rowlmgn
        }

        Image {
            id: imgA0T0
            x: 200
            width: 100
            height: 100
            anchors.top: parent.top
            anchors.topMargin: -100
            anchors.horizontalCenter: parent.horizontalCenter
            source: "../images/0-color/201905ICON-22.png"
            fillMode: Image.PreserveAspectFit
        }
    }

    Rectangle {
        id: recA0T1
        x: 802
        y: 175
        width: boxw
        height: boxh
        color: "#161616"
        radius: 5
        anchors.horizontalCenterOffset: 270
        anchors.horizontalCenter: parent.horizontalCenter
        border.color: "#ffffff"

        Image {
            id: imgA0T1
            x: 0
            width: 100
            height: 100
            anchors.top: parent.top
            anchors.topMargin: -100
            anchors.horizontalCenter: parent.horizontalCenter
            source: "../images/0-color/201905ICON-22.png"
            fillMode: Image.PreserveAspectFit
        }

        Rectangle {
            id: rowA0T1_Temp
            y: -4
            width: 180
            height: rowh
            color: "#161616"
            z: 4
            anchors.left: recA0T1.left
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
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 0
            }

            Text {
                id: txtA0T1Suffix
                y: 383
                width: 30
                height: rowh
                color: "#ffffff"
                text: qsTr("℃")
                anchors.left: recA0T1_Temp.right
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 20
                anchors.leftMargin: rowlmgn
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: "Courier"
                font.bold: true
            }
            anchors.topMargin: rowtmgn
            anchors.leftMargin: rowlmgn
            anchors.top: rowA0T1_Frate.bottom
        }

        Rectangle {
            id: rowA0T1_Frate
            x: 9
            width: 180
            height: rowh
            color: "#161616"
            anchors.topMargin: 5
            z: 4
            anchors.left: recA0T1.left
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
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 0
            }

            Text {
                id: txtA0T1_FrateSuffix
                y: 383
                width: 60
                height: rowh
                color: "#ffffff"
                text: qsTr("Bar/s")
                anchors.left: recA0T1_Frate.right
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 20
                anchors.leftMargin: rowlmgn
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: "Courier"
                font.bold: true
            }
            anchors.leftMargin: rowlmgn
            anchors.top: rowA0T1_Pressure.bottom
        }

        Rectangle {
            id: rowA0T1_Pressure
            width: 180
            height: rowh
            color: "#161616"
            z: 4
            anchors.left: parent.left
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
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 0
            }

            Text {
                id: txtA0T1_PressureSuffix
                y: 383
                width: 60
                height: rowh
                color: "#ffffff"
                text: qsTr("Bar")
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: recA0T1_Pressure.right
                anchors.leftMargin: rowlmgn
                font.pixelSize: 20
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                font.family: "Courier"
                font.bold: true
            }
            anchors.topMargin: rowtmgn
            anchors.leftMargin: rowlmgn
            anchors.top: parent.top
        }
    }

    Rectangle {
        id: recA1T1
        x: 225
        y: 600
        width: boxw
        height: boxh
        color: "#161616"
        radius: 5
        anchors.horizontalCenterOffset: -185
        anchors.horizontalCenter: parent.horizontalCenter
        border.color: "#ffffff"

        Image {
            id: imgA1T1
            x: 473
            width: 100
            height: 100
            anchors.top: parent.top
            anchors.topMargin: -100
            anchors.horizontalCenter: parent.horizontalCenter
            source: "../images/0-color/201905ICON-22.png"
            fillMode: Image.PreserveAspectFit
        }

        Rectangle {
            id: rowA1T1_Temp
            y: 4
            width: 180
            height: rowh
            color: "#161616"
            anchors.left: parent.left
            z: 4
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
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 0
            }

            Text {
                id: txtA1T1Suffix
                y: 383
                width: 30
                height: rowh
                color: "#ffffff"
                text: qsTr("℃")
                anchors.left: recA1T1_Temp.right
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 20
                anchors.leftMargin: rowlmgn
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: "Courier"
                font.bold: true
            }
            anchors.topMargin: rowtmgn
            anchors.leftMargin: rowlmgn
            anchors.top: rowA1T1_Frate.bottom
        }

        Rectangle {
            id: rowA1T1_Frate
            width: 180
            height: rowh
            color: "#161616"
            anchors.left: parent.left
            z: 4
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
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 0
            }

            Text {
                id: txtA1T1_FrateSuffix
                y: 383
                width: 60
                height: rowh
                color: "#ffffff"
                text: qsTr("Bar/s")
                anchors.left: recA1T1_Frate.right
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 20
                anchors.leftMargin: rowlmgn
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: "Courier"
                font.bold: true
            }
            anchors.topMargin: rowtmgn
            anchors.leftMargin: rowlmgn
            anchors.top: rowA1T1_Pressure.bottom
        }

        Rectangle {
            id: rowA1T1_Pressure
            width: 180
            height: rowh
            color: "#161616"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: rowtmgn
            z: 4
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
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 0
            }

            Text {
                id: txtA1T1_PressureSuffix
                y: 383
                width: 60
                height: rowh
                color: "#ffffff"
                text: qsTr("Bar")
                anchors.left: recA1T1_Pressure.right
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 20
                anchors.leftMargin: rowlmgn
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                font.family: "Courier"
                font.bold: true
            }
            anchors.leftMargin: rowlmgn
        }
    }

    Rectangle {
        id: recA1T0
        x: 11
        y: 500
        width: boxw
        height: boxh
        color: "#161616"
        radius: 5
        anchors.horizontalCenterOffset: -405
        anchors.horizontalCenter: parent.horizontalCenter
        border.color: "#ffffff"

        Image {
            id: imgA1T0
            x: 0
            width: 100
            height: 100
            anchors.top: parent.top
            anchors.topMargin: -100
            anchors.horizontalCenter: parent.horizontalCenter
            source: "../images/0-color/201905ICON-22.png"
            fillMode: Image.PreserveAspectFit
        }

        Rectangle {
            id: rowA1T0_Temp
            y: -8
            width: 180
            height: rowh
            color: "#161616"
            anchors.left: parent.left
            z: 4
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
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 0
            }

            Text {
                id: txtA1T0Suffix
                y: 383
                width: 30
                height: rowh
                color: "#ffffff"
                text: qsTr("℃")
                anchors.left: recA1T0_Temp.right
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 20
                anchors.leftMargin: rowlmgn
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: "Courier"
                font.bold: true
            }
            anchors.topMargin: rowtmgn
            anchors.leftMargin: rowlmgn
            anchors.top: rowA1T0_Frate.bottom
        }

        Rectangle {
            id: rowA1T0_Frate
            width: 180
            height: rowh
            color: "#161616"
            anchors.left: parent.left
            z: 4
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
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 0
            }

            Text {
                id: txtA1T0_FrateSuffix
                y: 383
                width: 60
                height: rowh
                color: "#ffffff"
                text: qsTr("Bar/s")
                anchors.left: recA1T0_Frate.right
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 20
                anchors.leftMargin: rowlmgn
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: "Courier"
                font.bold: true
            }
            anchors.topMargin: rowtmgn
            anchors.leftMargin: rowlmgn
            anchors.top: rowA1T0_Pressure.bottom
        }

        Rectangle {
            id: rowA1T0_Pressure
            width: 180
            height: rowh
            color: "#161616"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: rowtmgn
            z: 4
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
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 0
            }

            Text {
                id: txtA1T0_PressureSuffix
                y: 383
                width: 60
                height: rowh
                color: "#ffffff"
                text: qsTr("Bar")
                anchors.left: recA1T0_Pressure.right
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 20
                anchors.leftMargin: rowlmgn
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                font.family: "Courier"
                font.bold: true
            }
            anchors.leftMargin: rowlmgn
        }
    }

    Rectangle {
        id: recA1T2
        x: 640
        y: 600
        width: boxw
        height: boxh
        color: "#161616"
        radius: 5
        anchors.horizontalCenterOffset: 185
        anchors.horizontalCenter: parent.horizontalCenter
        border.color: "#ffffff"

        Image {
            id: imgA1T2
            x: 224
            width: 100
            height: 100
            anchors.top: parent.top
            anchors.topMargin: -100
            anchors.horizontalCenter: parent.horizontalCenter
            source: "../images/0-color/201905ICON-22.png"
            fillMode: Image.PreserveAspectFit
        }

        Rectangle {
            id: rowA1T2_Temp
            y: 2
            width: 180
            height: rowh
            color: "#161616"
            anchors.left: parent.left
            z: 4
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
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 0
            }

            Text {
                id: txtA1T2Suffix
                y: 383
                width: 30
                height: rowh
                color: "#ffffff"
                text: qsTr("℃")
                anchors.left: recA1T2_Temp.right
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 20
                anchors.leftMargin: rowlmgn
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: "Courier"
                font.bold: true
            }
            anchors.topMargin: rowtmgn
            anchors.leftMargin: rowlmgn
            anchors.top: rowA1T2_Frate.bottom
        }

        Rectangle {
            id: rowA1T2_Frate
            width: 180
            height: rowh
            color: "#161616"
            anchors.left: parent.left
            z: 4
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
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 0
            }

            Text {
                id: txtA1T2_FrateSuffix
                y: 383
                width: 60
                height: rowh
                color: "#ffffff"
                text: qsTr("Bar/s")
                anchors.left: recA1T2_Frate.right
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 20
                anchors.leftMargin: rowlmgn
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: "Courier"
                font.bold: true
            }
            anchors.topMargin: rowtmgn
            anchors.leftMargin: rowlmgn
            anchors.top: rowA1T2_Pressure.bottom
        }

        Rectangle {
            id: rowA1T2_Pressure
            width: 180
            height: rowh
            color: "#161616"
            anchors.top: parent.top
            anchors.topMargin: rowtmgn
            z: 4
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
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 0
            }

            Text {
                id: txtA1T2_PressureSuffix
                y: 383
                width: 60
                height: rowh
                color: "#ffffff"
                text: qsTr("Bar")
                anchors.right: parent.right
                anchors.rightMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 20
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                font.family: "Courier"
                font.bold: true
            }
            anchors.leftMargin: rowlmgn
        }
    }

    Rectangle {
        id: recA1T3
        x: 850
        y: 500
        width: boxw
        height: boxh
        color: "#161616"
        radius: 5
        anchors.horizontalCenterOffset: 405
        anchors.horizontalCenter: parent.horizontalCenter
        border.color: "#ffffff"

        Image {
            id: imgA1T3
            x: 0
            width: 100
            height: 100
            anchors.top: parent.top
            anchors.topMargin: -100
            anchors.horizontalCenter: parent.horizontalCenter
            source: "../images/0-color/201905ICON-22.png"
            fillMode: Image.PreserveAspectFit
        }

        Rectangle {
            id: rowA1T3_Temp
            y: -3
            width: 180
            height: rowh
            color: "#161616"
            anchors.left: parent.left
            z: 4
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
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 0
            }

            Text {
                id: txtA1T3Suffix
                y: 383
                width: 30
                height: rowh
                color: "#ffffff"
                text: qsTr("℃")
                anchors.left: recA1T3_Temp.right
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 20
                anchors.leftMargin: rowlmgn
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: "Courier"
                font.bold: true
            }
            anchors.topMargin: rowtmgn
            anchors.leftMargin: rowlmgn
            anchors.top: rowA1T3_Frate.bottom
        }

        Rectangle {
            id: rowA1T3_Frate
            width: 180
            height: rowh
            color: "#161616"
            anchors.left: parent.left
            z: 4
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
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 0
            }

            Text {
                id: txtA1T3_FrateSuffix
                y: 383
                width: 60
                height: rowh
                color: "#ffffff"
                text: qsTr("Bar/s")
                anchors.left: recA1T3_Frate.right
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 20
                anchors.leftMargin: rowlmgn
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: "Courier"
                font.bold: true
            }
            anchors.topMargin: rowtmgn
            anchors.leftMargin: rowlmgn
            anchors.top: rowA1T3_Pressure.bottom
        }

        Rectangle {
            id: rowA1T3_Pressure
            width: 180
            height: rowh
            color: "#161616"
            anchors.top: parent.top
            anchors.topMargin: rowtmgn
            anchors.left: parent.left
            z: 4
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
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 0
            }

            Text {
                id: txtA1T3_PressureSuffix
                y: 383
                width: 60
                height: rowh
                color: "#ffffff"
                text: qsTr("Bar")
                anchors.right: parent.right
                anchors.rightMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 20
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                font.family: "Courier"
                font.bold: true
            }
            anchors.leftMargin: rowlmgn
        }
    }

    onActiveChanged: {
        if (true === tpms.active) {
            root.qmlSignalActive(tpms.objectName)
        }
    }
}
