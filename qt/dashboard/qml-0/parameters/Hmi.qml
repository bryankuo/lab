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

Window {
    id: hmiSetting

    // ( https://goo.gl/LWbdMG )
    objectName: "hmiSettingWindow"

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
    property alias window: hmiSetting
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
        width: 100
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
                hmiSetting.hide();
            }
        }
    }

    Rectangle {
        id: rowhmiSetting
        x: 200
        y: 50
        width: 300
        height: 43
        color: "#161616"
        anchors.leftMargin: 50
        Text {
            id: txthmiSettingWinCaption
            y: 0
            width: 250
            height: 43
            color: "#ffffff"
            text: qsTr("HMI Parameters")
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

    Rectangle {
        id: rowVehicleBus
        x: 202
        width: 900
        height: 30
        color: "#161616"
        anchors.leftMargin: 50
        Text {
            id: txtChassisNoCap
            y: 0
            width: 130
            height: 25
            color: "#ffffff"
            text: qsTr("Vehicle Bus :")
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 20
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.left: parent.left
            anchors.verticalCenterOffset: 0
        }

        RadioButton {
            id: radioButton
            x: 218
            y: 4
            text: "CAN Bus"
            style: RadioButtonStyle {
                label: Text {
                    color: "#ffffff"
                    text: qsTr("CAN Bus")
                }
            }
            anchors.verticalCenter: parent.verticalCenter
        }

        RadioButton {
            id: radioModBus
            x: 363
            y: 4
            text: "MOD Bus"
            style: RadioButtonStyle {
                label: Text {
                    color: "#ffffff"
                    text: qsTr("ModBus")
                }
            }
            anchors.verticalCenter: parent.verticalCenter
        }
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.top: rowInterface.bottom
    }

    Rectangle {
        id: rowButtons
        x: 198
        y: 259
        width: 250
        height: 40
        color: "#161616"
        anchors.topMargin: 50
        anchors.top: rowhmiSetting.bottom

        Button {
            id: btnSave
            y: 1
            height: 40
            text: qsTr("SAVE")
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
        anchors.left: parent.left
        anchors.leftMargin: 1000
    }

    Rectangle {
        id: rowBusSpeed
        x: 195
        y: 0
        width: 1200
        height: 30
        color: "#161616"
        anchors.topMargin: 10
        anchors.top: rowVehicleBus.bottom
        Text {
            id: txtBusSpeedCap
            y: 0
            width: 130
            height: 25
            color: "#ffffff"
            text: qsTr("Bus Speed :")
            font.pixelSize: 20
            anchors.left: parent.left
            anchors.verticalCenterOffset: 0
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
        }

        ComboBox {
            id: cboSpeed
            x: 218
            y: 23
            anchors.verticalCenter: parent.verticalCenter
        }

    // customizing radioButton ( https://tinyurl.com/y28nkyye )
        anchors.left: parent.left
        anchors.leftMargin: 50
    }

    Rectangle {
        id: rowAlarmMessages
        x: 199
        y: -8
        width: 1200
        height: 30
        color: "#161616"
        anchors.topMargin: 30
        anchors.top: rowBusSpeed.bottom
        Text {
            id: txtAlarmMessages
            y: 0
            width: 130
            height: 25
            color: "#ffffff"
            text: qsTr("Alarm Messages :")
            font.pixelSize: 20
            anchors.left: parent.left
            anchors.verticalCenterOffset: 0
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
        }
        anchors.left: parent.left
        anchors.leftMargin: 50
    }

    Rectangle {
        id: rowVoiceSpeed
        x: 206
        width: 1200
        height: 30
        color: "#161616"
        anchors.topMargin: 10
        anchors.top: rowAlarmMessages.bottom
        Text {
            id: txtLeakageCurrent
            y: 0
            width: 130
            height: 25
            color: "#ffffff"
            text: qsTr("Voice Speed :")
            font.pixelSize: 20
            anchors.left: parent.left
            anchors.verticalCenterOffset: 0
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
        }

        RadioButton {
            id: radioNormal
            x: 220
            y: 4
            text: "CAN Bus"
            anchors.verticalCenterOffset: 2
            style: RadioButtonStyle {
                label: Text {
                    color: "#ffffff"
                    text: qsTr("Normal")
                }
            }
            anchors.verticalCenter: parent.verticalCenter
        }

        RadioButton {
            id: radioSlow
            x: 365
            y: 4
            text: "MOD Bus"
            anchors.verticalCenterOffset: 2
            style: RadioButtonStyle {
                label: Text {
                    color: "#ffffff"
                    text: qsTr("Slow")
                }
            }
            anchors.verticalCenter: parent.verticalCenter
        }
        anchors.left: parent.left
        anchors.leftMargin: 50
    }

    Rectangle {
        id: rowDisplayPeriod
        x: 208
        y: 285
        width: 1200
        height: 30
        color: "#161616"
        anchors.leftMargin: 50
        anchors.top: rowVoiceSpeed.bottom
        anchors.left: parent.left
        anchors.topMargin: 10
        Text {
            id: txtAlarmMessages1
            y: 0
            width: 130
            height: 25
            color: "#ffffff"
            text: qsTr("Display Period :")
            horizontalAlignment: Text.AlignLeft
            anchors.leftMargin: 0
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenterOffset: 0
            anchors.left: parent.left
            font.pixelSize: 20
            anchors.verticalCenter: parent.verticalCenter
        }

        ComboBox {
            id: cboPeriod
            x: 218
            y: 23
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    Rectangle {
        id: rowInterface
        x: 206
        y: 109
        width: 1200
        height: 30
        color: "#161616"
        anchors.leftMargin: 50
        anchors.left: parent.left
        anchors.topMargin: 5
        Text {
            id: txtLeakageCurrent1
            y: 0
            width: 130
            height: 25
            color: "#ffffff"
            text: qsTr("Interface :")
            horizontalAlignment: Text.AlignLeft
            anchors.leftMargin: 0
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenterOffset: 0
            anchors.left: parent.left
            font.pixelSize: 20
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    Rectangle {
        id: rowVehicleInfoRecord
        x: 209
        y: 439
        width: 1200
        height: 30
        color: "#161616"
        anchors.leftMargin: 50
        anchors.top: rowDisplayPeriod.bottom
        anchors.left: parent.left
        anchors.topMargin: 30
        Text {
            id: txtAlarmMessages2
            y: 0
            width: 130
            height: 25
            color: "#ffffff"
            text: qsTr("Vehicle Info. Record :")
            horizontalAlignment: Text.AlignLeft
            anchors.leftMargin: 0
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenterOffset: 0
            anchors.left: parent.left
            font.pixelSize: 20
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    Rectangle {
        id: rowLogOnOff
        x: 213
        y: 467
        width: 1200
        height: 30
        color: "#161616"
        anchors.leftMargin: 50
        anchors.top: rowVehicleInfoRecord.bottom
        anchors.left: parent.left
        anchors.topMargin: 10
        Text {
            id: txtAlarmMessages3
            y: 0
            width: 130
            height: 25
            color: "#ffffff"
            text: qsTr("Log On/Off :")
            horizontalAlignment: Text.AlignLeft
            anchors.leftMargin: 0
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenterOffset: 0
            anchors.left: parent.left
            font.pixelSize: 20
            anchors.verticalCenter: parent.verticalCenter
        }

        RadioButton {
            id: radioOn
            x: 220
            y: 4
            text: "CAN Bus"
            style: RadioButtonStyle {
                label: Text {
                    color: "#ffffff"
                    text: qsTr("On")
                }
            }
            anchors.verticalCenterOffset: 2
            anchors.verticalCenter: parent.verticalCenter
        }

        RadioButton {
            id: radioOff
            x: 365
            y: 4
            text: "MOD Bus"
            style: RadioButtonStyle {
                label: Text {
                    color: "#ffffff"
                    text: qsTr("Off")
                }
            }
            anchors.verticalCenterOffset: 2
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    Rectangle {
        id: rowDataLogPeriod
        x: 221
        y: 498
        width: 1200
        height: 30
        color: "#161616"
        anchors.leftMargin: 50
        anchors.top: rowLogOnOff.bottom
        anchors.left: parent.left
        anchors.topMargin: 10
        Text {
            id: txtAlarmMessages4
            y: 0
            width: 130
            height: 25
            color: "#ffffff"
            text: qsTr("Data Log Period :")
            horizontalAlignment: Text.AlignLeft
            anchors.leftMargin: 0
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenterOffset: 0
            anchors.left: parent.left
            font.pixelSize: 20
            anchors.verticalCenter: parent.verticalCenter
        }

        ComboBox {
            id: cboLogPeriod
            x: 218
            y: 23
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    Rectangle {
        id: rowLanguage
        x: 214
        y: 505
        width: 1200
        height: 30
        color: "#161616"
        anchors.leftMargin: 50
        anchors.top: rowDataLogPeriod.bottom
        anchors.left: parent.left
        anchors.topMargin: 10
        Text {
            id: txtAlarmMessages5
            y: 0
            width: 130
            height: 25
            color: "#ffffff"
            text: qsTr("Language :")
            horizontalAlignment: Text.AlignLeft
            anchors.leftMargin: 0
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenterOffset: 0
            anchors.left: parent.left
            font.pixelSize: 20
            anchors.verticalCenter: parent.verticalCenter
        }

        RadioButton {
            id: radioEnglish
            x: 220
            y: 4
            text: "CAN Bus"
            style: RadioButtonStyle {
                label: Text {
                    color: "#ffffff"
                    text: qsTr("English")
                }
            }
            anchors.verticalCenterOffset: 2
            anchors.verticalCenter: parent.verticalCenter
        }

        RadioButton {
            id: radioTradChinese
            x: 365
            y: 4
            text: "MOD Bus"
            style: RadioButtonStyle {
                label: Text {
                    color: "#ffffff"
                    text: qsTr("Traditional Chinese")
                }
            }
            anchors.verticalCenterOffset: 2
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    Rectangle {
        id: rowNetwork
        x: 222
        y: 509
        width: 1200
        height: 30
        color: "#161616"
        anchors.leftMargin: 50
        anchors.top: rowLanguage.bottom
        anchors.left: parent.left
        anchors.topMargin: 10
        Text {
            id: txtAlarmMessages6
            y: 0
            width: 130
            height: 25
            color: "#ffffff"
            text: qsTr("Network :")
            horizontalAlignment: Text.AlignLeft
            anchors.leftMargin: 0
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenterOffset: 0
            anchors.left: parent.left
            font.pixelSize: 20
            anchors.verticalCenter: parent.verticalCenter
        }

        Button {
            id: btnLoadConfig
            y: 8
            height: 40
            text: qsTr("LOAD CONFIG")
            anchors.verticalCenterOffset: 0
            anchors.leftMargin: 165
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
                    implicitWidth: 100
                    border.width: control.activeFocus ? 2 : 1
                    border.color: "#888888"
                    implicitHeight: 43
                }
            }
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: txtIMEICap
            x: 7
            y: 8
            width: 60
            height: 25
            color: "#ffffff"
            text: qsTr("IMEI :")
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            anchors.leftMargin: 350
            verticalAlignment: Text.AlignVCenter
            anchors.left: parent.left
            font.pixelSize: 20
        }

        Text {
            id: txtIMEIVal
            x: 0
            y: 0
            width: 200
            height: 25
            color: "#ffffff"
            text: qsTr("0123456789abcde")
            horizontalAlignment: Text.AlignHCenter
            anchors.leftMargin: 10
            verticalAlignment: Text.AlignVCenter
            anchors.left: txtIMEICap.right
            font.pixelSize: 20
            anchors.rightMargin: 0
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    Rectangle {
        id: rowAbout
        x: 219
        y: 514
        width: 1200
        height: 30
        color: "#161616"
        anchors.leftMargin: 50
        anchors.top: rowVersion.bottom
        anchors.left: parent.left
        anchors.topMargin: 10

        Button {
            id: btnAbout
            y: 8
            height: 40
            text: qsTr("ABOUT")
            anchors.leftMargin: 0
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
                    implicitWidth: 100
                    border.width: control.activeFocus ? 2 : 1
                    border.color: "#888888"
                    implicitHeight: 43
                }
            }
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    Rectangle {
        id: rowVersion
        x: 222
        y: 537
        width: 1200
        height: 30
        color: "#161616"
        anchors.leftMargin: 50
        anchors.top: rowNetwork.bottom
        anchors.left: parent.left
        anchors.topMargin: 10
        Text {
            id: txtAlarmMessages8
            y: 0
            width: 130
            height: 25
            color: "#ffffff"
            text: "Version :"
            horizontalAlignment: Text.AlignLeft
            anchors.leftMargin: 0
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenterOffset: 0
            anchors.left: parent.left
            font.pixelSize: 20
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    onActiveChanged : {
        if ( true === hmiSetting.active ) {
        hmiSetting.qmlSignalActive("HmiParameters");
    }
    }

}



























































































































































































/*##^## Designer {
    D{i:8;anchors_y:161}D{i:27;anchors_y:329}
}
 ##^##*/
