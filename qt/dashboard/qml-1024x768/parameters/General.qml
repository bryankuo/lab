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
    id: general

    // ( https://goo.gl/LWbdMG )
    objectName: "generalWindow"

    // QML - main window position on start (screen center)
    // ( https://goo.gl/wLpvZD )
    Styles { id: style }
    width: style.resolutionWidth // application wide properties
    height: style.resolutionHeight
    maximumHeight: height
    maximumWidth: width
    x: 0
    y: 0
    minimumHeight: height
    minimumWidth: width
    color: "#161616"
    property alias window: general
    flags: Qt.FramelessWindowHint
    title: ""

    // Property names must begin with a lower case letter
    // and can only contain letters ( https://goo.gl/HzLQet )
    //
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
        id: imgBack
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
                general.hide();
            }
        }
    }

    Rectangle {
        id: rowGeneral
        x: 200
        y: 30
        width: 300
        height: 43
        color: "#161616"
        anchors.leftMargin: 50
        Text {
            id: txtgeneralWinCaption
            y: 0
            width: 250
            height: 43
            color: "#ffffff"
            text: qsTr("General Parameters")
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
        id: rowChassisNo
        x: 202
        width: style.resolutionWidth - anchors.leftMargin
        height: 30
        color: "#161616"
        anchors.leftMargin: 30
        Text {
            id: txtChassisNoCap
            y: 0
            width: 130
            height: 25
            color: "#ffffff"
            text: qsTr("Chassis No :")
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 20
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.left: parent.left
            anchors.verticalCenterOffset: 0
        }

        Rectangle {
            id: recChassisNoVal
            y: 379
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            anchors.leftMargin: 130
            anchors.verticalCenter: parent.verticalCenter
            Text {
                id: txtChassisNoVal
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
            anchors.left: parent.left
        }

        Text {
            id: txtSpeedLimitCap
            x: 9
            y: 9
            width: 130
            height: 25
            color: "#ffffff"
            text: qsTr("Speed Limit :")
            font.pixelSize: 20
            anchors.left: parent.left
            anchors.verticalCenterOffset: 0
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 240
        }

        Rectangle {
            id: recSpeedLimitVal
            y: 388
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            Text {
                id: txtSpeedLimitVal
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 400
        }
        anchors.topMargin: 50
        anchors.left: parent.left
        anchors.top: rowGeneral.bottom
    }

    Rectangle {
        id: rowSPAN
        x: 195
        y: 0
        width: style.resolutionWidth - anchors.leftMargin
        height: 30
        color: "#161616"
        anchors.topMargin: 20
        anchors.top: rowChassisNo.bottom
        Text {
            id: txtSPANCap
            y: 0
            width: 130
            height: 25
            color: "#ffffff"
            text: qsTr("SPAN")
            font.pixelSize: 20
            anchors.left: parent.left
            anchors.verticalCenterOffset: 0
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
        }

        Text {
            id: txtSpanSpeedCap
            x: 9
            y: 9
            width: 120
            height: 25
            color: "#ffffff"
            text: qsTr("Speed :")
            font.pixelSize: 20
            anchors.left: parent.left
            anchors.verticalCenterOffset: 0
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 240
        }

        Rectangle {
            id: recSpanSpeedVal
            y: 388
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            Text {
                id: txtSpanSpeedVal
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 400
        }

        Text {
            id: txtSpanPressureCap
            x: 7
            y: 7
            width: 120
            height: 25
            color: "#ffffff"
            text: qsTr("Pressure :")
            font.pixelSize: 20
            anchors.left: parent.left
            anchors.verticalCenterOffset: 0
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 506
        }

        Rectangle {
            id: recSpanPressureVal
            x: -2
            y: 386
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            anchors.verticalCenterOffset: 0
            Text {
                id: txtSpanPressureVal
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 626
        }

        Text {
            id: txtWaterTempCap
            x: 3
            y: 3
            width: 120
            height: 25
            color: "#ffffff"
            text: qsTr("Water Temp. :")
            font.pixelSize: 20
            anchors.left: parent.left
            anchors.verticalCenterOffset: 0
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 735
        }

        Rectangle {
            id: recWaterTempVal
            x: -6
            y: 382
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            Text {
                id: txtWaterTempVal
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
            anchors.left: parent.left
            anchors.verticalCenterOffset: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 875
        }
        anchors.left: parent.left
        anchors.leftMargin: 30
    }

    Rectangle {
        id: rowZERO
        x: 199
        y: -8
        width: style.resolutionWidth - anchors.leftMargin
        height: 30
        color: "#161616"
        anchors.topMargin: 10
        anchors.top: rowSPAN.bottom
        Text {
            id: txtSPANCap1
            y: 0
            width: 130
            height: 25
            color: "#ffffff"
            text: qsTr("ZERO")
            font.pixelSize: 20
            anchors.left: parent.left
            anchors.verticalCenterOffset: 0
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
        }

        Rectangle {
            id: recZeroSpeedVal
            x: 370
            y: 379
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            Text {
                id: txtZeroSpeedVal
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 400
        }

        Text {
            id: txtZeroSpeedCap
            x: 9
            y: 9
            width: 120
            height: 25
            color: "#ffffff"
            text: qsTr("Speed :")
            font.pixelSize: 20
            anchors.left: parent.left
            anchors.verticalCenterOffset: 0
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 240
        }

        Text {
            id: txtSpanPressureCap1
            x: 7
            y: 7
            width: 120
            height: 25
            color: "#ffffff"
            text: qsTr("Pressure :")
            font.pixelSize: 20
            anchors.left: parent.left
            anchors.verticalCenterOffset: 0
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 506
        }

        Rectangle {
            id: recZeroPressureVal
            x: -2
            y: 386
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            Text {
                id: txtZeroPressureVal
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
            anchors.left: parent.left
            anchors.verticalCenterOffset: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 626
        }

        Text {
            id: txtZeroWaterTempCap
            x: 3
            y: 3
            width: 120
            height: 25
            color: "#ffffff"
            text: qsTr("Water Temp. :")
            font.pixelSize: 20
            anchors.left: parent.left
            anchors.verticalCenterOffset: 0
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 735
        }

        Rectangle {
            id: recZeroWaterTempVal
            x: -6
            y: 382
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            Text {
                id: txtZeroWaterTempVal
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
            anchors.left: parent.left
            anchors.verticalCenterOffset: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 875
        }
        anchors.left: parent.left
        anchors.leftMargin: 30
    }

    Rectangle {
        id: rowRBK
        x: 200
        y: -6
        width: style.resolutionWidth - anchors.leftMargin
        height: 30
        color: "#161616"
        anchors.topMargin: 10
        anchors.top: rowZERO.bottom
        Text {
            id: txtRBRK
            y: 0
            width: 130
            height: 25
            color: "#ffffff"
            text: qsTr("Reg. Brake")
            font.pixelSize: 20
            anchors.left: parent.left
            anchors.verticalCenterOffset: 0
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
        }

        Rectangle {
            id: recWorkingSpeed
            x: 370
            y: 379
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            Text {
                id: txtWorkingSpeed
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 400
        }

        Text {
            id: txtZeroSpeedCap1
            x: 9
            y: 9
            width: 120
            height: 25
            color: "#ffffff"
            text: qsTr("Working Speed :")
            font.pixelSize: 19
            anchors.left: parent.left
            anchors.verticalCenterOffset: 0
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 240
        }

        Text {
            id: txtSpanPressureCap2
            x: 7
            y: 7
            width: 120
            height: 25
            color: "#ffffff"
            text: qsTr("Ability :")
            font.pixelSize: 20
            anchors.left: parent.left
            anchors.verticalCenterOffset: 0
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 506
        }

        Rectangle {
            id: recZeroPressureVal1
            x: -2
            y: 386
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            Text {
                id: txtZeroPressureVal1
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
            anchors.left: parent.left
            anchors.verticalCenterOffset: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 626
        }

        Rectangle {
            id: recRegBrkStatus
            y: 379
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            Text {
                id: txtRegBrkStatus
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 130
        }
        anchors.left: parent.left
        anchors.leftMargin: 30
    }

    Rectangle {
        id: rowLeakage
        x: 206
        y: -4
        width: style.resolutionWidth - anchors.leftMargin
        height: 30
        color: "#161616"
        anchors.topMargin: 10
        anchors.top: rowRBK.bottom
        Text {
            id: txtLeakageCurrent
            y: 0
            width: 130
            height: 25
            color: "#ffffff"
            text: qsTr("Leakage Current Thr.")
            font.pixelSize: 20
            anchors.left: parent.left
            anchors.verticalCenterOffset: 0
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
        }

        Rectangle {
            id: recZeroSpeedVal2
            x: 370
            y: 379
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            Text {
                id: txtZeroSpeedVal2
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 400
        }

        Text {
            id: txtZeroSpeedCap2
            x: 9
            y: 9
            width: 120
            height: 25
            color: "#ffffff"
            text: qsTr("Warning :")
            font.pixelSize: 20
            anchors.left: parent.left
            anchors.verticalCenterOffset: 0
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 240
        }

        Text {
            id: txtSpanPressureCap3
            x: 7
            y: 7
            width: 120
            height: 25
            color: "#ffffff"
            text: qsTr("Severe :")
            font.pixelSize: 20
            anchors.left: parent.left
            anchors.verticalCenterOffset: 0
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 506
        }

        Rectangle {
            id: recZeroPressureVal2
            x: -2
            y: 386
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            Text {
                id: txtZeroPressureVal2
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
            anchors.left: parent.left
            anchors.verticalCenterOffset: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 626
        }
        anchors.left: parent.left
        anchors.leftMargin: 30
    }

    Rectangle {
        id: rowPressure0
        x: 206
        y: 3
        width: style.resolutionWidth - anchors.leftMargin
        height: 30
        color: "#161616"
        anchors.topMargin: 10
        anchors.top: rowLeakage.bottom
        Text {
            id: txtLeakageCurrent1
            y: 0
            width: 130
            height: 25
            color: "#ffffff"
            text: qsTr("Pressure")
            font.pixelSize: 20
            anchors.left: parent.left
            anchors.verticalCenterOffset: 0
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
        }

        Rectangle {
            id: recZeroSpeedVal3
            x: 370
            y: 379
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            Text {
                id: txtZeroSpeedVal3
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 400
        }

        Text {
            id: txtZeroSpeedCap3
            x: 9
            y: 9
            width: 120
            height: 25
            color: "#ffffff"
            text: qsTr("Working :")
            font.pixelSize: 20
            anchors.left: parent.left
            anchors.verticalCenterOffset: 0
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 240
        }

        Text {
            id: txtSpanPressureCap4
            x: 7
            y: 7
            width: 120
            height: 25
            color: "#ffffff"
            text: qsTr("Reload :")
            font.pixelSize: 20
            anchors.left: parent.left
            anchors.verticalCenterOffset: 0
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 506
        }

        Rectangle {
            id: recZeroPressureVal3
            x: -2
            y: 386
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            Text {
                id: txtZeroPressureVal3
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
            anchors.left: parent.left
            anchors.verticalCenterOffset: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 626
        }

        Text {
            id: txtZeroWaterTempCap1
            x: 3
            y: 3
            width: 120
            height: 25
            color: "#ffffff"
            text: qsTr("Upper Limit :")
            font.pixelSize: 20
            anchors.left: parent.left
            anchors.verticalCenterOffset: 0
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 735
        }

        Rectangle {
            id: recZeroWaterTempVal1
            x: -6
            y: 382
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            Text {
                id: txtZeroWaterTempVal1
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
            anchors.left: parent.left
            anchors.verticalCenterOffset: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 875
        }
        anchors.left: parent.left
        anchors.leftMargin: 30
    }

    Rectangle {
        id: rowPressure1
        x: 196
        width: style.resolutionWidth - anchors.leftMargin
        height: 30
        color: "#161616"
        anchors.top: rowPressure0.bottom
        Text {
            id: txtLeakageCurrent2
            y: 0
            width: 130
            height: 25
            color: "#ffffff"
            text: qsTr("")
            anchors.verticalCenterOffset: 0
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.left: parent.left
            font.pixelSize: 20
        }

        Rectangle {
            id: recZeroSpeedVal4
            x: 370
            y: 379
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            Text {
                id: txtZeroSpeedVal4
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 20
            }
            anchors.leftMargin: 400
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
        }

        Text {
            id: txtZeroSpeedCap4
            x: 9
            y: 9
            width: 120
            height: 25
            color: "#ffffff"
            text: qsTr("Warning Low :")
            anchors.verticalCenterOffset: 0
            anchors.leftMargin: 240
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.left: parent.left
            font.pixelSize: 20
        }

        Text {
            id: txtSpanPressureCap5
            x: 7
            y: 7
            width: 120
            height: 25
            color: "#ffffff"
            text: qsTr("Severe Low :")
            anchors.verticalCenterOffset: 0
            anchors.leftMargin: 506
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.left: parent.left
            font.pixelSize: 19
        }

        Rectangle {
            id: recZeroPressureVal4
            x: -2
            y: 386
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            anchors.verticalCenterOffset: 0
            Text {
                id: txtZeroPressureVal4
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 20
            }
            anchors.leftMargin: 626
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
        }
        anchors.leftMargin: 30
        anchors.topMargin: 10
        anchors.left: parent.left
    }

    Rectangle {
        id: rowMotorTemp
        x: 196
        y: -2
        width: style.resolutionWidth - anchors.leftMargin
        height: 30
        color: "#161616"
        anchors.top: rowPressure1.bottom
        Text {
            id: txtLeakageCurrent3
            y: 0
            width: 130
            height: 25
            color: "#ffffff"
            text: qsTr("Motor Temp. Thr.")
            anchors.verticalCenterOffset: 0
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.left: parent.left
            font.pixelSize: 20
        }

        Rectangle {
            id: recZeroSpeedVal5
            x: 370
            y: 379
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            Text {
                id: txtZeroSpeedVal5
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 20
            }
            anchors.leftMargin: 400
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
        }

        Text {
            id: txtZeroSpeedCap5
            x: 9
            y: 9
            width: 120
            height: 25
            color: "#ffffff"
            text: qsTr("Warning :")
            anchors.verticalCenterOffset: 0
            anchors.leftMargin: 240
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.left: parent.left
            font.pixelSize: 20
        }

        Text {
            id: txtSpanPressureCap6
            x: 7
            y: 7
            width: 120
            height: 25
            color: "#ffffff"
            text: qsTr("Severe :")
            anchors.verticalCenterOffset: 0
            anchors.leftMargin: 506
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.left: parent.left
            font.pixelSize: 20
        }

        Rectangle {
            id: recZeroPressureVal5
            x: -2
            y: 386
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            anchors.verticalCenterOffset: 0
            Text {
                id: txtZeroPressureVal5
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 20
            }
            anchors.leftMargin: 626
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
        }

        Text {
            id: txtZeroWaterTempCap2
            x: 3
            y: 3
            width: 120
            height: 25
            color: "#ffffff"
            text: qsTr("Normal :")
            anchors.verticalCenterOffset: 0
            anchors.leftMargin: 735
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.left: parent.left
            font.pixelSize: 20
        }

        Rectangle {
            id: recZeroWaterTempVal2
            x: -6
            y: 382
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            anchors.verticalCenterOffset: 0
            Text {
                id: txtZeroWaterTempVal2
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 20
            }
            anchors.leftMargin: 875
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
        }
        anchors.leftMargin: 30
        anchors.topMargin: 10
        anchors.left: parent.left
    }

    Rectangle {
        id: rowWaterTemp
        x: 200
        y: -10
        width: style.resolutionWidth - anchors.leftMargin
        height: 30
        color: "#161616"
        anchors.top: rowMotorTemp.bottom
        Text {
            id: txtLeakageCurrent4
            y: 0
            width: 130
            height: 25
            color: "#ffffff"
            text: qsTr("Water Temp. Thr.")
            anchors.verticalCenterOffset: 0
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.left: parent.left
            font.pixelSize: 20
        }

        Rectangle {
            id: recZeroSpeedVal6
            x: 370
            y: 379
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            Text {
                id: txtZeroSpeedVal6
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 20
            }
            anchors.leftMargin: 400
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
        }

        Text {
            id: txtZeroSpeedCap6
            x: 9
            y: 9
            width: 120
            height: 25
            color: "#ffffff"
            text: qsTr("Warning :")
            anchors.verticalCenterOffset: 0
            anchors.leftMargin: 240
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.left: parent.left
            font.pixelSize: 20
        }

        Text {
            id: txtSpanPressureCap7
            x: 7
            y: 7
            width: 120
            height: 25
            color: "#ffffff"
            text: qsTr("Severe :")
            anchors.verticalCenterOffset: 0
            anchors.leftMargin: 506
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.left: parent.left
            font.pixelSize: 20
        }

        Rectangle {
            id: recZeroPressureVal6
            x: -2
            y: 386
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            anchors.verticalCenterOffset: 0
            Text {
                id: txtZeroPressureVal6
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 20
            }
            anchors.leftMargin: 626
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
        }
        anchors.leftMargin: 30
        anchors.topMargin: 10
        anchors.left: parent.left
    }

    Rectangle {
        id: rowSmokeDTempThr
        x: 201
        y: -8
        width: style.resolutionWidth - anchors.leftMargin
        height: 30
        color: "#161616"
        anchors.top: rowWaterTemp.bottom
        Text {
            id: txtLeakageCurrent5
            y: 0
            width: 130
            height: 25
            color: "#ffffff"
            text: qsTr("Smoke Detector Temp. Thr.")
            fontSizeMode: Text.FixedSize
            anchors.verticalCenterOffset: 0
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.left: parent.left
            font.pixelSize: 17
        }

        Rectangle {
            id: recZeroSpeedVal7
            x: 370
            y: 379
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            Text {
                id: txtZeroSpeedVal7
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 20
            }
            anchors.leftMargin: 400
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
        }

        Text {
            id: txtZeroSpeedCap7
            x: 9
            y: 9
            width: 120
            height: 25
            color: "#ffffff"
            text: qsTr("Warning :")
            anchors.verticalCenterOffset: 0
            anchors.leftMargin: 240
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.left: parent.left
            font.pixelSize: 20
        }

        Text {
            id: txtSpanPressureCap8
            x: 7
            y: 7
            width: 120
            height: 25
            color: "#ffffff"
            text: qsTr("Severe :")
            anchors.verticalCenterOffset: 0
            anchors.leftMargin: 506
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.left: parent.left
            font.pixelSize: 20
        }

        Rectangle {
            id: recZeroPressureVal7
            x: -2
            y: 386
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            anchors.verticalCenterOffset: 0
            Text {
                id: txtZeroPressureVal7
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 20
            }
            anchors.leftMargin: 626
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
        }
        anchors.leftMargin: 30
        anchors.topMargin: 10
        anchors.left: parent.left
    }

    Rectangle {
        id: rowMainVoltageThr0
        x: 207
        y: -6
        width: style.resolutionWidth - anchors.leftMargin
        height: 30
        color: "#161616"
        anchors.top: rowSmokeDTempThr.bottom
        Text {
            id: txtLeakageCurrent6
            y: 0
            width: 130
            height: 25
            color: "#ffffff"
            text: qsTr("Main Volt. Thr.")
            anchors.verticalCenterOffset: 0
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.left: parent.left
            font.pixelSize: 20
        }

        Rectangle {
            id: recZeroSpeedVal8
            x: 370
            y: 379
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            Text {
                id: txtMainVoltThresholdValWarningLow
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 20
            }
            anchors.leftMargin: 400
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
        }

        Text {
            id: txtZeroSpeedCap11
            x: 18
            y: 18
            width: 120
            height: 25
            color: "#ffffff"
            text: qsTr("Warning Low :")
            anchors.verticalCenterOffset: 0
            anchors.leftMargin: 240
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.left: parent.left
            font.pixelSize: 20
        }

        Text {
            id: txtSpanPressureCap12
            x: 16
            y: 16
            width: 120
            height: 25
            color: "#ffffff"
            text: qsTr("Severe Low :")
            anchors.verticalCenterOffset: 0
            anchors.leftMargin: 506
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.left: parent.left
            font.pixelSize: 19
        }

        Rectangle {
            id: recZeroPressureVal11
            x: 7
            y: 395
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            anchors.verticalCenterOffset: 0
            Text {
                id: txtMainVoltThresholdValSevereLow
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 20
            }
            anchors.leftMargin: 626
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
        }
        anchors.leftMargin: 30
        anchors.topMargin: 10
        anchors.left: parent.left
    }

    Rectangle {
        id: rowCellVoltageThr0
        x: 207
        y: 1
        width: style.resolutionWidth - anchors.leftMargin
        height: 30
        color: "#161616"
        anchors.top: rowMainVoltageThr1.bottom
        Text {
            id: txtLeakageCurrent7
            y: 0
            width: 130
            height: 25
            color: "#ffffff"
            text: qsTr("Cell Volt. Thr.")
            anchors.verticalCenterOffset: 0
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.left: parent.left
            font.pixelSize: 20
        }

        Rectangle {
            id: recZeroSpeedVal9
            x: 370
            y: 379
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            Text {
                id: txtZeroSpeedVal9
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 20
            }
            anchors.leftMargin: 400
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
        }

        Text {
            id: txtZeroSpeedCap9
            x: 9
            y: 9
            width: 120
            height: 25
            color: "#ffffff"
            text: qsTr("Warning Low :")
            anchors.verticalCenterOffset: 0
            anchors.leftMargin: 240
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.left: parent.left
            font.pixelSize: 20
        }

        Text {
            id: txtSpanPressureCap10
            x: 7
            y: 7
            width: 120
            height: 25
            color: "#ffffff"
            text: qsTr("Severe Low :")
            anchors.verticalCenterOffset: 0
            anchors.leftMargin: 506
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.left: parent.left
            font.pixelSize: 19
        }

        Rectangle {
            id: recZeroPressureVal9
            x: -2
            y: 386
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            anchors.verticalCenterOffset: 0
            Text {
                id: txtZeroPressureVal9
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 20
            }
            anchors.leftMargin: 626
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
        }
        anchors.leftMargin: 30
        anchors.topMargin: 10
        anchors.left: parent.left
    }

    Rectangle {
        id: rowCellDiffVoltageThr
        x: 216
        y: 5
        width: style.resolutionWidth - anchors.leftMargin
        height: 30
        color: "#161616"
        anchors.top: rowCellVoltageThr1.bottom
        Text {
            id: txtLeakageCurrent8
            y: 0
            width: 130
            height: 25
            color: "#ffffff"
            text: qsTr("Cell Diff Volt. Thr.")
            anchors.verticalCenterOffset: 0
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.left: parent.left
            font.pixelSize: 20
        }

        Rectangle {
            id: recZeroSpeedVal10
            x: 370
            y: 379
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            Text {
                id: txtZeroSpeedVal10
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 20
            }
            anchors.leftMargin: 400
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
        }

        Text {
            id: txtZeroSpeedCap10
            x: 9
            y: 9
            width: 120
            height: 25
            color: "#ffffff"
            text: qsTr("Warning High :")
            anchors.verticalCenterOffset: 0
            anchors.leftMargin: 240
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.left: parent.left
            font.pixelSize: 20
        }

        Text {
            id: txtSpanPressureCap11
            x: 7
            y: 7
            width: 120
            height: 25
            color: "#ffffff"
            text: qsTr("Severe High :")
            anchors.verticalCenterOffset: 0
            anchors.leftMargin: 506
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.left: parent.left
            font.pixelSize: 19
        }

        Rectangle {
            id: recZeroPressureVal10
            x: -2
            y: 386
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            anchors.verticalCenterOffset: 0
            Text {
                id: txtZeroPressureVal10
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 20
            }
            anchors.leftMargin: 626
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
        }
        anchors.leftMargin: 30
        anchors.topMargin: 10
        anchors.left: parent.left
    }

    Button {
        id: btnGet
        y: 30
        height: 40
        text: qsTr("GET")
        anchors.right: imgBack.left
        anchors.rightMargin: 10
        style: ButtonStyle {
            background: Rectangle {
                radius: 4
                border.width: control.activeFocus ? 2 : 1
                implicitWidth: 100
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
                border.color: "#888888"
            }
        }
    }

    Button {
        id: btnSend
        y: 30
        height: 40
        text: qsTr("SEND")
        anchors.right: btnGet.left
        anchors.rightMargin: 10
        style: ButtonStyle {
            background: Rectangle {
                radius: 4
                border.width: control.activeFocus ? 2 : 1
                implicitWidth: 100
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
                border.color: "#888888"
            }
        }
    }

    Rectangle {
        id: rowMainVoltageThr1
        x: 209
        width: style.resolutionWidth - anchors.leftMargin
        height: 30
        color: "#161616"
        anchors.topMargin: 10
        anchors.leftMargin: 30

        Rectangle {
            id: recZeroSpeedVal14
            x: 370
            y: 379
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            anchors.leftMargin: 400
            Text {
                id: txtMainVoltThresholdValWarningHigh
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: txtZeroSpeedCap15
            x: 18
            y: 18
            width: 120
            height: 25
            color: "#ffffff"
            text: qsTr("Warning High :")
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 20
            anchors.leftMargin: 240
            horizontalAlignment: Text.AlignLeft
            anchors.left: parent.left
            anchors.verticalCenterOffset: 0
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: txtSpanPressureCap16
            x: 16
            y: 16
            width: 120
            height: 25
            color: "#ffffff"
            text: qsTr("Severe High :")
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 19
            anchors.leftMargin: 506
            horizontalAlignment: Text.AlignLeft
            anchors.left: parent.left
            anchors.verticalCenterOffset: 0
            anchors.verticalCenter: parent.verticalCenter
        }

        Rectangle {
            id: recZeroPressureVal15
            x: 7
            y: 395
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            anchors.leftMargin: 626
            Text {
                id: txtMainVoltThresholdValSevereHigh
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
            anchors.left: parent.left
            anchors.verticalCenterOffset: 0
            anchors.verticalCenter: parent.verticalCenter
        }
        anchors.left: parent.left
        anchors.top: rowMainVoltageThr0.bottom
    }

    Rectangle {
        id: rowCellVoltageThr1
        x: 216
        width: style.resolutionWidth - anchors.leftMargin
        height: 30
        color: "#161616"
        anchors.topMargin: 10
        anchors.leftMargin: 30

        Rectangle {
            id: recZeroSpeedVal11
            x: 370
            y: 379
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            anchors.leftMargin: 400
            Text {
                id: txtZeroSpeedVal11
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: txtZeroSpeedCap13
            x: 9
            y: 9
            width: 120
            height: 25
            color: "#ffffff"
            text: qsTr("Warning High :")
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 20
            anchors.leftMargin: 240
            horizontalAlignment: Text.AlignLeft
            anchors.left: parent.left
            anchors.verticalCenterOffset: 0
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: txtSpanPressureCap14
            x: 7
            y: 7
            width: 120
            height: 25
            color: "#ffffff"
            text: qsTr("Severe High :")
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 19
            anchors.leftMargin: 506
            horizontalAlignment: Text.AlignLeft
            anchors.left: parent.left
            anchors.verticalCenterOffset: 0
            anchors.verticalCenter: parent.verticalCenter
        }

        Rectangle {
            id: recZeroPressureVal13
            x: -2
            y: 386
            width: 100
            height: 25
            color: "#000000"
            radius: 10
            anchors.leftMargin: 626
            Text {
                id: txtZeroPressureVal11
                y: 0
                width: 70
                height: 25
                color: "#ffffff"
                text: qsTr("")
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
            anchors.left: parent.left
            anchors.verticalCenterOffset: 0
            anchors.verticalCenter: parent.verticalCenter
        }
        anchors.left: parent.left
        anchors.top: rowCellVoltageThr0.bottom
    }

    onActiveChanged : {
        if ( true === general.active ) {
        general.qmlSignalActive("GeneralParameters");
    }
    }

}







































































































































/*##^##
Designer {
    D{i:0;height:768;width:1024}D{i:8;anchors_y:161}D{i:6;anchors_y:161}D{i:55;anchors_x:1}
D{i:54;anchors_x:3}D{i:48;anchors_x:1}D{i:57;anchors_y:"-5"}D{i:61;anchors_x:3}D{i:62;anchors_x:3}
D{i:68;anchors_y:"-5"}D{i:72;anchors_x:3}D{i:73;anchors_x:3}D{i:67;anchors_y:"-5"}
D{i:76;anchors_y:"-5"}D{i:80;anchors_x:3}D{i:81;anchors_x:3}D{i:75;anchors_y:"-5"}
D{i:90;anchors_y:"-5"}D{i:91;anchors_x:3}D{i:86;anchors_y:"-5"}D{i:95;anchors_x:3}
D{i:97;anchors_y:"-5"}D{i:98;anchors_y:"-5"}D{i:105;anchors_x:3;anchors_y:"-5"}D{i:107;anchors_y:"-5"}
D{i:102;anchors_x:3}D{i:113;anchors_x:3}D{i:112;anchors_x:3}D{i:115;anchors_y:"-5"}
D{i:117;anchors_x:3}D{i:120;anchors_x:3}D{i:124;anchors_x:3}D{i:140;anchors_x:3;anchors_y:"-5"}
D{i:142;anchors_y:"-5"}D{i:138;anchors_x:3;anchors_y:1}D{i:147;anchors_x:3}D{i:146;anchors_x:3}
D{i:149;anchors_y:"-5"}D{i:151;anchors_x:3}D{i:145;anchors_y:"-5"}
}
##^##*/
