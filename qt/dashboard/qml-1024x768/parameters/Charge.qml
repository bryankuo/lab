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
    id: charge

    // ( https://goo.gl/LWbdMG )
    objectName: "chargeWindow"

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
    property alias window: charge
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
                charge.hide();
            }
        }
    }

    Rectangle {
        id: rowCharge
        x: 200
        y: 30
        width: 300
        height: 43
        color: "#161616"
        anchors.leftMargin: 50
        Text {
            id: txtchargeWinCaption
            y: 0
            width: 250
            height: 43
            color: "#ffffff"
            text: qsTr("Charge Parameters")
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
        id: rowChargingMaxOutput
        x: 202
        width: style.resolutionWidth - anchors.leftMargin
        height: 30
        color: "#161616"
        anchors.leftMargin: 30
        Text {
            id: txtChargingMaxOutputCap
            y: 0
            width: 220
            height: 25
            color: "#ffffff"
            text: qsTr("Charging Max Output :")
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 19
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.left: parent.left
            anchors.verticalCenterOffset: 0
        }

        Rectangle {
            id: recChargingMaxOutputVal
            y: 379
            width: 70
            height: 25
            color: "#000000"
            radius: 5
            anchors.leftMargin: 5
            anchors.verticalCenter: parent.verticalCenter
            Text {
                id: txtChargingMaxOutputVal
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
            anchors.left: txtChargingMaxOutputCap.right
        }

        Text {
            id: txtChargingMaxOutputSuffix
            x: 9
            y: 9
            width: 30
            height: 25
            color: "#ffffff"
            text: qsTr("%")
            font.pixelSize: 20
            anchors.left: recChargingMaxOutputVal.right
            anchors.verticalCenterOffset: 0
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 5
        }
        anchors.topMargin: 50
        anchors.left: parent.left
        anchors.top: rowCharge.bottom
    }

    Rectangle {
        id: rowButtons
        x: 198
        y: 30
        width: 250
        height: 40
        color: "#161616"
        anchors.right: imgBack.left
        anchors.rightMargin: 10

        Button {
            id: btnSend
            y: 1
            height: 40
            text: qsTr("SEND")
            anchors.left: parent.left
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
                    border.color: "#888888"
                    implicitWidth: 100
                    border.width: control.activeFocus ? 2 : 1
                }
            }
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 120
        }

        Button {
            id: btnGet
            y: 8
            height: 40
            text: qsTr("GET")
            anchors.left: parent.left
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
                    border.color: "#888888"
                    implicitWidth: 100
                    border.width: control.activeFocus ? 2 : 1
                }
            }
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
        }
    }

    Rectangle {
        id: rowFastChargeFunction
        x: 195
        y: 0
        width: style.resolutionWidth - anchors.leftMargin
        height: 30
        color: "#161616"
        anchors.topMargin: 30
        anchors.top: rowTimerChargeFunction.bottom
        Text {
            id: txtTimerChargeFunctionCap
            y: 0
            width: 220
            height: 25
            color: "#ffffff"
            text: qsTr("Fast Charge :")
            font.pixelSize: 20
            anchors.left: parent.left
            anchors.verticalCenterOffset: 0
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
        }

        Text {
            id: txtFastChargeStartTimeCap
            y: 9
            width: 180
            height: 25
            color: "#ffffff"
            text: qsTr("Start Time :")
            anchors.left: parent.left
            anchors.leftMargin: 350
            font.pixelSize: 20
            anchors.verticalCenterOffset: 0
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        Rectangle {
            id: recFastChargeStartTimeVal
            y: 388
            width: 100
            height: 25
            color: "#000000"
            radius: 5
            Text {
                id: txtFastChargeStartTimeHourVal
                y: 0
                width: 40
                height: 25
                color: "#ffffff"
                text: qsTr("00")
                anchors.right: txtFastChargeStartTimeComma.left
                anchors.rightMargin: 0
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            Text {
                id: txtFastChargeStartTimeComma
                x: -9
                y: -8
                width: 15
                height: 25
                color: "#ffffff"
                text: qsTr(":")
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            Text {
                id: txtFastChargeStartTimeMinuteVal
                y: 7
                width: 40
                height: 25
                color: "#ffffff"
                text: qsTr("00")
                anchors.left: txtFastChargeStartTimeComma.right
                anchors.leftMargin: 0
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            anchors.left: txtFastChargeStartTimeCap.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 5
        }

        Text {
            id: txtFastChargeStopTimeCap
            x: 3
            y: 3
            width: 160
            height: 25
            color: "#ffffff"
            text: qsTr("Stop Time :")
            font.pixelSize: 20
            anchors.left: parent.left
            anchors.verticalCenterOffset: 0
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 670
        }

        Button {
            id: btnFastCharge
            y: 8
            height: 40
            text: qsTr("OFF")
            anchors.verticalCenter: parent.verticalCenter
            style: ButtonStyle {
                background: Rectangle {
                    radius: 4
                    implicitWidth: 100
                    border.color: "#888888"
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
                    implicitHeight: 43
                }
            }
            anchors.left: txtTimerChargeFunctionCap.right
            anchors.leftMargin: 5
        }

        Rectangle {
            id: recFastChargeStopTimeVal
            y: 381
            width: 100
            height: 25
            color: "#000000"
            radius: 5
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: txtFastChargeStopTimeCap.right
            Text {
                id: txtFastChargeStopTimeHourVal
                y: 0
                width: 40
                height: 25
                color: "#ffffff"
                text: qsTr("00")
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: txtFastChargeStopTimeComma.left
                font.pixelSize: 20
                anchors.rightMargin: 0
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            Text {
                id: txtFastChargeStopTimeComma
                x: -9
                y: -8
                width: 15
                height: 25
                color: "#ffffff"
                text: qsTr(":")
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            Text {
                id: txtFastChargeStopTimeMinuteVal
                y: 7
                width: 40
                height: 25
                color: "#ffffff"
                text: qsTr("00")
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: txtFastChargeStopTimeComma.right
                font.pixelSize: 20
                anchors.leftMargin: 0
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            anchors.leftMargin: 5
        }
        anchors.left: parent.left
        anchors.leftMargin: 30
    }

    Rectangle {
        id: rowTimerChargeFunction
        x: 199
        y: -8
        width: style.resolutionWidth - anchors.leftMargin
        height: 30
        color: "#161616"
        radius: 5
        anchors.topMargin: 30
        anchors.top: rowChargingMaxOutput.bottom
        Text {
            id: txtTimerChargeCap
            y: 0
            width: 220
            height: 25
            color: "#ffffff"
            text: qsTr("Timer Charge :")
            font.pixelSize: 20
            anchors.left: parent.left
            anchors.verticalCenterOffset: 0
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
        }

        Text {
            id: txtStartTimeCap
            x: 9
            y: 9
            width: 180
            height: 25
            color: "#ffffff"
            text: qsTr("Start Time :")
            font.pixelSize: 20
            anchors.left: parent.left
            anchors.verticalCenterOffset: 0
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 350
        }

        Text {
            id: txtStopTimeCap
            y: 7
            width: 160
            height: 25
            color: "#ffffff"
            text: qsTr("Stop Time :")
            anchors.left: parent.left
            anchors.leftMargin: 670
            font.pixelSize: 20
            anchors.verticalCenterOffset: 0
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        Rectangle {
            id: recTimerChargeStartVal
            y: 388
            width: 100
            height: 25
            color: "#000000"
            radius: 5
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: txtStartTimeCap.right
            Text {
                id: txtTimerChargeStartHourVal
                y: 0
                width: 40
                height: 25
                color: "#ffffff"
                text: qsTr("00")
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: txtTimerChargeStartComma.left
                font.pixelSize: 20
                anchors.rightMargin: 0
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            Text {
                id: txtTimerChargeStartComma
                x: -9
                y: -8
                width: 15
                height: 25
                color: "#ffffff"
                text: qsTr(":")
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            Text {
                id: txtTimerChargeStartMinuteVal
                y: 7
                width: 40
                height: 25
                color: "#ffffff"
                text: qsTr("00")
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: txtTimerChargeStartComma.right
                font.pixelSize: 20
                anchors.leftMargin: 0
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            anchors.leftMargin: 5
        }

        Rectangle {
            id: recTimerChargeStopHourVal
            y: 385
            width: 100
            height: 25
            color: "#000000"
            radius: 5
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: txtStopTimeCap.right
            Text {
                id: txtTimerChargeStopHourVal
                y: 0
                width: 40
                height: 25
                color: "#ffffff"
                text: qsTr("00")
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: txtTimerChargeStopComma.left
                font.pixelSize: 20
                anchors.rightMargin: 0
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            Text {
                id: txtTimerChargeStopComma
                x: -9
                y: -8
                width: 15
                height: 25
                color: "#ffffff"
                text: qsTr(":")
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            Text {
                id: txtTimerChargeStopMinuteVal
                y: 7
                width: 40
                height: 25
                color: "#ffffff"
                text: qsTr("00")
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: txtTimerChargeStopComma.right
                font.pixelSize: 20
                anchors.leftMargin: 0
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            anchors.leftMargin: 5
        }

        Button {
            id: btnTimerCharge
            y: 8
            height: 40
            text: qsTr("OFF")
            anchors.verticalCenter: parent.verticalCenter
            style: ButtonStyle {
                background: Rectangle {
                    radius: 4
                    implicitWidth: 100
                    border.color: "#888888"
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
                    implicitHeight: 43
                }
            }
            anchors.left: txtTimerChargeCap.right
            anchors.leftMargin: 5
        }
        anchors.left: parent.left
        anchors.leftMargin: 30
    }

    Rectangle {
        id: rowPulseChargeFunction
        x: 190
        y: 4
        width: style.resolutionWidth - anchors.leftMargin
        height: 30
        color: "#161616"
        anchors.topMargin: 30
        anchors.top: rowFastChargeFunction.bottom
        anchors.left: parent.left
        Text {
            id: txtTimerChargeFunctionCap1
            y: 0
            width: 220
            height: 25
            color: "#ffffff"
            text: qsTr("Pulse Charge :")
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            font.pixelSize: 20
            anchors.leftMargin: 0
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenterOffset: 0
            verticalAlignment: Text.AlignVCenter
        }

        Text {
            id: txtPulseOnTimeCap
            x: 9
            y: 9
            width: 180
            height: 25
            color: "#ffffff"
            text: qsTr("ON Time :")
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            font.pixelSize: 20
            anchors.leftMargin: 350
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenterOffset: 0
            verticalAlignment: Text.AlignVCenter
        }

        Rectangle {
            id: recPulseOnTimeSecond
            y: 388
            width: 60
            height: 25
            color: "#000000"
            radius: 5
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: txtPulseOnTimeCap.right
            Text {
                id: txtPulseOnTimeSecondVal
                y: 0
                width: 60
                height: 25
                color: "#ffffff"
                text: qsTr("00")
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 20
                anchors.rightMargin: 0
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            anchors.leftMargin: 5
        }

        Text {
            id: txtPulseOffTimeCap
            x: 3
            y: 3
            width: 160
            height: 25
            color: "#ffffff"
            text: qsTr("OFF Time :")
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            font.pixelSize: 20
            anchors.leftMargin: 670
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenterOffset: 0
            verticalAlignment: Text.AlignVCenter
        }

        Button {
            id: btnPulseCharge
            y: 8
            height: 40
            text: qsTr("OFF")
            anchors.verticalCenter: parent.verticalCenter
            style: ButtonStyle {
                background: Rectangle {
                    radius: 4
                    implicitWidth: 100
                    border.color: "#888888"
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
                    implicitHeight: 43
                }
            }
            anchors.left: txtTimerChargeFunctionCap1.right
            anchors.leftMargin: 5
        }

        Rectangle {
            id: recPulseOffTimeSecond
            y: 381
            width: 60
            height: 25
            color: "#000000"
            radius: 5
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: txtPulseOffTimeCap.right
            Text {
                id: txtPulseOffTimeSecondVal
                y: 0
                width: 60
                height: 25
                color: "#ffffff"
                text: qsTr("00")
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 20
                anchors.rightMargin: 0
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            anchors.leftMargin: 5
        }

        Text {
            id: txtPulseOnSuffix
            y: 7
            width: 40
            height: 25
            color: "#ffffff"
            text: qsTr("Sec")
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: recPulseOnTimeSecond.right
            anchors.leftMargin: 5
            font.pixelSize: 20
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        Text {
            id: txtPulseOffTimeSecondSuffix
            y: 3
            width: 40
            height: 25
            color: "#ffffff"
            text: qsTr("Sec")
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: recPulseOffTimeSecond.right
            font.pixelSize: 20
            anchors.leftMargin: 5
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
        anchors.leftMargin: 30
    }

    Rectangle {
        id: rowLimitTimeChargeFunction
        x: 190
        y: 11
        width: style.resolutionWidth - anchors.leftMargin
        height: 30
        color: "#161616"
        anchors.topMargin: 30
        anchors.top: rowPulseChargeFunction1.bottom
        anchors.left: parent.left
        Text {
            id: txtLimitedTimeChargeCap
            y: 0
            width: 220
            height: 25
            color: "#ffffff"
            text: qsTr("Limited Time Charge :")
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            font.pixelSize: 20
            anchors.leftMargin: 0
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenterOffset: 0
            verticalAlignment: Text.AlignVCenter
        }

        Text {
            id: txtLimitedChargeTimeCap
            x: 9
            y: 9
            width: 180
            height: 25
            color: "#ffffff"
            text: qsTr("Charge Time :")
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            font.pixelSize: 20
            anchors.leftMargin: 350
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenterOffset: 0
            verticalAlignment: Text.AlignVCenter
        }

        Rectangle {
            id: recLimitedChargeTimeHour
            y: 388
            width: 60
            height: 25
            color: "#000000"
            radius: 5
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: txtLimitedChargeTimeCap.right
            Text {
                id: txtLimitedChargeTimeHourVal
                y: 0
                width: 60
                height: 25
                color: "#ffffff"
                text: qsTr("00")
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 20
                anchors.rightMargin: 0
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            anchors.leftMargin: 5
        }

        Button {
            id: btnTimerChargeFunction2
            y: 8
            height: 40
            text: qsTr("OFF")
            anchors.verticalCenter: parent.verticalCenter
            style: ButtonStyle {
                background: Rectangle {
                    radius: 4
                    implicitWidth: 100
                    border.color: "#888888"
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
                    implicitHeight: 43
                }
            }
            anchors.left: txtLimitedTimeChargeCap.right
            anchors.leftMargin: 5
        }

        Text {
            id: txtLimitedChargeTimeHourSuffix
            y: 7
            width: 50
            height: 25
            color: "#ffffff"
            text: qsTr("Hour")
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: recLimitedChargeTimeHour.right
            anchors.leftMargin: 5
            font.pixelSize: 20
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
        anchors.leftMargin: 30
    }

    Rectangle {
        id: rowDcdcOutputFunction
        x: 199
        y: 15
        width: style.resolutionWidth - anchors.leftMargin
        height: 30
        color: "#161616"
        anchors.topMargin: 30
        anchors.top: rowLimitTimeChargeFunction.bottom
        anchors.left: parent.left
        Text {
            id: txtDcdcOutputCap
            y: 0
            width: 220
            height: 25
            color: "#ffffff"
            text: qsTr("DCDC Output :")
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 0
            font.pixelSize: 20
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenterOffset: 0
            verticalAlignment: Text.AlignVCenter
        }

        Text {
            id: txtDcdcOutputVoltageCap
            x: 9
            y: 9
            width: 180
            height: 25
            color: "#ffffff"
            text: qsTr("Output Voltage :")
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 350
            font.pixelSize: 20
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenterOffset: 0
            verticalAlignment: Text.AlignVCenter
        }

        Rectangle {
            id: recDcdcOutputVoltageVal
            y: 388
            width: 60
            height: 25
            color: "#000000"
            radius: 5
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: txtDcdcOutputVoltageCap.right
            Text {
                id: txtDcdcOutputVoltageVal
                y: 0
                width: 60
                height: 25
                color: "#ffffff"
                text: qsTr("00")
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 20
                anchors.rightMargin: 0
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            anchors.leftMargin: 5
        }

        Button {
            id: btnTimerChargeFunction3
            y: 8
            height: 40
            text: qsTr("OFF")
            anchors.verticalCenter: parent.verticalCenter
            style: ButtonStyle {
                background: Rectangle {
                    radius: 4
                    implicitWidth: 100
                    border.color: "#888888"
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
                    implicitHeight: 43
                }
            }
            anchors.left: txtDcdcOutputCap.right
            anchors.leftMargin: 5
        }

        Text {
            id: txtDcdcOutputVoltageSuffix
            y: 7
            width: 20
            height: 25
            color: "#ffffff"
            text: qsTr("V")
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: recDcdcOutputVoltageVal.right
            font.pixelSize: 20
            anchors.leftMargin: 5
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
        anchors.leftMargin: 30
    }

    Rectangle {
        id: rowDateOfManufacture
        x: 208
        y: 10
        width: style.resolutionWidth - anchors.leftMargin
        height: 30
        color: "#161616"
        anchors.topMargin: 30
        anchors.top: rowDcdcOutputFunction1.bottom
        anchors.left: parent.left
        Text {
            id: txtDateOfManufacture
            y: 0
            width: 220
            height: 25
            color: "#ffffff"
            text: qsTr("Date of Manufacture :")
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            font.pixelSize: 20
            anchors.leftMargin: 0
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenterOffset: 0
            verticalAlignment: Text.AlignVCenter
        }

        Rectangle {
            id: recDateOfManufacture
            y: 388
            width: 120
            height: 25
            color: "#000000"
            radius: 5
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: txtDateOfManufacture.right
            Text {
                id: txtDateOfManufactureVal
                y: 0
                width: 120
                height: 25
                color: "#ffffff"
                text: qsTr("00000000")
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 20
                anchors.rightMargin: 0
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            anchors.leftMargin: 5
        }

        Text {
            id: txtPlateNumCap
            x: 7
            y: 8
            width: 180
            height: 25
            color: "#ffffff"
            text: qsTr("License Plate No. :")
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            font.pixelSize: 20
            anchors.leftMargin: 350
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenterOffset: 0
            verticalAlignment: Text.AlignVCenter
        }

        Rectangle {
            id: recPlateNoVal
            x: -4
            y: 396
            width: 100
            height: 25
            color: "#000000"
            radius: 5
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: txtPlateNumCap.right
            Text {
                id: txtPlateNoVal
                y: 0
                width: 100
                height: 25
                color: "#ffffff"
                text: qsTr("000000")
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 0
                font.pixelSize: 20
                anchors.rightMargin: 0
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            anchors.leftMargin: 5
        }
        anchors.leftMargin: 30
    }

    Rectangle {
        id: rowPulseChargeFunction1
        x: 180
        width: style.resolutionWidth - anchors.leftMargin
        height: 30
        color: "#161616"
        anchors.topMargin: 10
        anchors.top: rowPulseChargeFunction.bottom

        Text {
            id: txtPulseChargingVoltageCap1
            x: 7
            y: 7
            width: 90
            height: 25
            color: "#ffffff"
            text: qsTr("Voltage :")
            anchors.verticalCenterOffset: 0
            font.pixelSize: 19
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 350
            horizontalAlignment: Text.AlignLeft
        }

        Rectangle {
            id: recPulseChargingVoltage1
            x: -2
            y: 386
            width: 60
            height: 25
            color: "#000000"
            radius: 5
            anchors.verticalCenterOffset: 0
            Text {
                id: txtPulseChargingVoltageVal1
                color: "#ffffff"
                text: qsTr("")
                anchors.fill: parent
                font.pixelSize: 20
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 535
        }

        Text {
            id: txtPulseChargingVoltageSuffix1
            y: 4
            width: 40
            height: 25
            color: "#ffffff"
            text: qsTr("V")
            font.pixelSize: 20
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: recPulseChargingVoltage1.right
            anchors.leftMargin: 5
            horizontalAlignment: Text.AlignHCenter
        }
        anchors.left: parent.left
        anchors.leftMargin: 30
    }

    Rectangle {
        id: rowDcdcOutputFunction1
        x: 201
        width: style.resolutionWidth - anchors.leftMargin
        height: 30
        color: "#161616"
        anchors.topMargin: 10
        anchors.top: rowDcdcOutputFunction.bottom

        Text {
            id: txtDcdcOutputCurrentLowCap1
            x: 8
            y: 8
            width: 160
            height: 25
            color: "#ffffff"
            text: qsTr("Current ( Low ) :")
            anchors.verticalCenterOffset: 0
            font.pixelSize: 19
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 350
            horizontalAlignment: Text.AlignLeft
        }

        Rectangle {
            id: recOutputCurrentLowVal1
            x: -1
            y: 387
            width: 60
            height: 25
            color: "#000000"
            radius: 5
            Text {
                id: txtOutputCurrentLowVal1
                y: 0
                width: 60
                height: 25
                color: "#ffffff"
                text: qsTr("00")
                font.pixelSize: 20
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: 0
                horizontalAlignment: Text.AlignHCenter
            }
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: txtDcdcOutputCurrentLowCap1.right
            anchors.leftMargin: 5
        }

        Text {
            id: txtDcdcOutputCurrentHighCap1
            y: 17
            width: 150
            height: 25
            color: "#ffffff"
            text: qsTr("Current ( High ) :")
            anchors.verticalCenterOffset: 0
            font.pixelSize: 19
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 670
            horizontalAlignment: Text.AlignLeft
        }

        Rectangle {
            id: recOutputCurrentHighVal1
            x: 8
            y: 380
            width: 60
            height: 25
            color: "#000000"
            radius: 5
            Text {
                id: txtOutputCurrentLowVal3
                y: 0
                width: 60
                height: 25
                color: "#ffffff"
                text: qsTr("00")
                font.pixelSize: 20
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: 0
                horizontalAlignment: Text.AlignHCenter
            }
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: txtDcdcOutputCurrentHighCap1.right
            anchors.leftMargin: 5
        }

        Text {
            id: txtOutputCurrentLowSuffix1
            y: -1
            width: 20
            height: 25
            color: "#ffffff"
            text: qsTr("A")
            font.pixelSize: 20
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: recOutputCurrentLowVal1.right
            anchors.leftMargin: 5
            horizontalAlignment: Text.AlignHCenter
        }

        Text {
            id: txtOutputCurrentHighSuffix1
            y: 14
            width: 20
            height: 25
            color: "#ffffff"
            text: qsTr("A")
            font.pixelSize: 20
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: recOutputCurrentHighVal1.right
            anchors.leftMargin: 5
            horizontalAlignment: Text.AlignHCenter
        }
        anchors.left: parent.left
        anchors.leftMargin: 30
    }

    onActiveChanged : {
        if ( true === charge.active ) {
        charge.qmlSignalActive("ChargeParameters");
    }
    }

}

















































































































































































































































































/*##^##
Designer {
    D{i:0;height:768;width:1024}D{i:6;anchors_y:161}D{i:14;anchors_width:250}D{i:113;anchors_height:25;anchors_width:60;anchors_y:0}
D{i:110;anchors_y:-4}D{i:115;anchors_y:22}
}
##^##*/
