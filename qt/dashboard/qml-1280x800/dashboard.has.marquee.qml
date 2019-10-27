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
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtQuick.Controls 2.5

// Access C++ function from QML
// https://goo.gl/nxZegu
import com.myself 1.0

Window {
    id: root
    visible: true
    // ( https://goo.gl/nnR4j9 )
    // x: (Screen.width - width) / 2
    // y: (Screen.height - height) / 2
    x: 0
    y: 0
    width: 1280
    height: 800
    // frameless windows with qt5 (qml)
    // ( https://goo.gl/nnR4j9 )
    flags: Qt.FramelessWindowHint

// How to make QtQuick2.0 application window not resizable?
// ( https://goo.gl/1YCbCc )
    maximumHeight: height
    maximumWidth: width

    minimumHeight: height
    minimumWidth: width

    color: "#161616"
    property alias mouseArea: mouseArea
    property alias imageMenu: imageMenu
    property alias gauge1: gauge
    property alias speedometer: speedometer
    property alias txtKph1: txtKph
    property alias txtMilage1: txtMilage
    property alias switchDelegate1: switchDelegate
    property bool isAnimating : switchDelegate1.checked
    // Launch a child QML window from a parent QML window
    // ( https://goo.gl/J67Pcc )
    property variant win;  // you can hold this as a reference..

    title: qsTr("RACEV HMI")

    ValueSource {
        id: valueSource
        // objectName: "valueSource1" // ( https://goo.gl/Caomvq )
    }

    Item {
        id: container
        height: Math.min(root.width, root.height)
        anchors.centerIn: parent
        width: root.width

        Row {
            id: engineeringRow_0
            x: 152
            width: 1280
            height: 50
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5

            Text {
                id: lblDbop
                y: 191
                width: 130
                height: 44
                color: "#ffffff"
                text: qsTr("#DB/W:")
                textFormat: Text.PlainText
                fontSizeMode: Text.FixedSize
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 35
            }

            Text {
                id: dbop
                y: 291
                width: 110
                height: 44
                color: "#ffffff"
                text: qsTr("00000")
                anchors.left: lblDbop.right
                anchors.leftMargin: 10
                textFormat: Text.PlainText
                fontSizeMode: Text.Fit
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 35
            }

            Text {
                id: lbl_cpu1
                x: 200
                y: 191
                width: 120
                height: 44
                color: "#ffffff"
                text: qsTr("CPU%:")
                textFormat: Text.PlainText
                fontSizeMode: Text.FixedSize
                anchors.left: dbop.right
                anchors.leftMargin: 20
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 35
            }

            Text {
                id: cpu1
                x: 390
                y: 291
                width: 70
                height: 44
                color: "#ffffff"
                text: qsTr("00")
                anchors.left: lbl_cpu1.right
                anchors.leftMargin: 10
                textFormat: Text.PlainText
                fontSizeMode: Text.Fit
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 35
            }

            Text {
                id: lbl_fmem
                x: 200
                y: 390
                width: 100
                height: 44
                color: "#ffffff"
                text: qsTr("FREE:")
                textFormat: Text.PlainText
                fontSizeMode: Text.FixedSize
                anchors.left: cpu1.right
                anchors.leftMargin: 20
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 35
            }

            Text {
                id: fmem1
                x: 200
                y: 390
                width: 90
                height: 44
                color: "#ffffff"
                text: qsTr("0000")
                textFormat: Text.PlainText
                fontSizeMode: Text.FixedSize
                anchors.left: lbl_fmem.right
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 35
            }

            Text {
                id: fmem2
                x: 200
                y: 390
                width: 40
                height: 44
                color: "#ffffff"
                text: qsTr("M")
                textFormat: Text.PlainText
                fontSizeMode: Text.FixedSize
                anchors.left: fmem1.right
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 35
            }

            SwitchDelegate {
                id: switchDelegate
                x: 1204
                height: 50
                text: checked ? qsTr("Animation ON"):qsTr("Animation OFF")
                enabled: true
                hoverEnabled: false
                highlighted: false
                spacing: 10
                anchors.rightMargin: 0
                anchors.right: parent.right
                anchors.top: row2.bottom
                checked: false
                anchors.topMargin: 0
                onCheckableChanged: {
                    console.debug(switchDelegate1.checked);
                    setAnimaiton(checked);
                }
            }
        }

        Row {
            id: gaugeRow
            width: 720
            height: 400
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 1
            anchors.horizontalCenterOffset: 0
            spacing: container.width * 0.02
            /*
            Item {
                id: element
                width: height
                height: container.height * 0.25 - gaugeRow.spacing
                anchors.verticalCenter: parent.verticalCenter
            }
*/
            CircularGauge {
                id: speedometer
                value: valueSource.kph
                //value: 0
                anchors.verticalCenter: parent.verticalCenter
                maximumValue: 200
                // We set the width to the height, because the height will always be
                // the more limited factor. Also, all circular controls letterbox
                // their contents to ensure that they remain circular. However, we
                // don't want to extra space on the left and right of our gauges,
                // because they're laid out horizontally, and that would create
                // large horizontal gaps between gauges on wide screens.
                width: height
                height: container.height * 0.5

                // SmoothedAnimation QML Type ( https://goo.gl/PAsQfa )
                smooth: true
                Behavior on value {
                    SmoothedAnimation {
                        //velocity: 200
                        velocity: 30
                        //velocity: -1
                        //reversingMode: Sync
                        //reversingMode: Immediate
                        duration: 3000
                    }
                }
                /*
                Behavior on value {
                    NumberAnimation {
                        duration: 250
                    }
                }
*/
                anchors.horizontalCenter: parent.horizontalCenter
                style: DashboardGaugeStyle {}

                TurnIndicator {
                    id: leftIndicator
                    x: 100
                    width: height
                    height: container.height * 0.1 - gaugeRow.spacing
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    anchors.leftMargin: 0
                    flashing: isAnimating ? true:false
                    anchors.left: parent.left
                    direction: Qt.LeftArrow
                    on: isAnimating ? true:false
                }

                Rectangle {
                    id: rectGear1
                    x: -9
                    y: -8
                    width: 40
                    height: 40
                    color: "#000000"
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 15
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text {
                        id: txtGear1
                        width: 40
                        height: 40
                        color: "#ffffff"
                        text: "N"
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        anchors.centerIn: parent
                        font.pixelSize: 25
                    }
                    anchors.leftMargin: 3
                    anchors.left: statusIndicator00.right
                    border.color: "#ffffff"
                    border.width: 1
                }

                TurnIndicator {
                    id: rightIndicator
                    x: 80
                    width: height
                    height: container.height * 0.1 - gaugeRow.spacing
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    flashing: isAnimating ? true:false
                    anchors.rightMargin: 0
                    direction: Qt.RightArrow
                    on: isAnimating ? true:false
                    anchors.right: parent.right
                }
            }

            Text {
                id: txtKph
                x: 0
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("999")
                anchors.right: parent.right
                anchors.rightMargin: -65
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                MouseArea {
                    width: 70
                    height: 40
                    anchors.top: parent.top
                    hoverEnabled: false
                    anchors.left: parent.left
                }
                font.pixelSize: 25
            }

            Text {
                id: txtKph2
                x: 0
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("KM")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.rightMargin: -110
                MouseArea {
                    width: 70
                    height: 40
                    anchors.top: parent.top
                    hoverEnabled: false
                    anchors.left: parent.left

                    Text {
                        id: txtPower
                        x: 0
                        y: 0
                        width: 80
                        height: 43
                        color: "#ffffff"
                        text: qsTr("x250kw")
                        font.pixelSize: 25
                        anchors.rightMargin: 130
                        MouseArea {
                            width: 80
                            height: 40
                            anchors.leftMargin: 0
                            hoverEnabled: false
                            anchors.left: parent.left
                            anchors.top: parent.top
                        }
                        anchors.right: parent.right
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
                font.pixelSize: 25
                anchors.right: parent.right
            }

            CircularGauge {
                id: fuelGauge
                width: 100
                height: 100
                value: 0
                anchors.right: parent.right
                anchors.rightMargin: 10
                anchors.top: parent.top
                anchors.topMargin: 60
                maximumValue: 3
                minimumValue: -3
                style: IconGaugeStyle {
                    id: tempGaugeStyle
                    icon: "qrc:/images/power.png"
                    maxWarningColor: Qt.rgba(0.5, 0, 0, 1)
                    //maxWarningColor: "green"
                    tickmarkLabel: Text {
                        color: "#ffffff"
                        //text: styleData.value === 0 ? "C" : (styleData.value === 1 ? "H" : "")
                        text: styleData.value
                        font.pixelSize: tempGaugeStyle.toPixels(0.225)
                        //visible: styleData.value === 0 || styleData.value === 1
                    }
                }
            }

            Gauge {
                id: gauge
                height: 350
                anchors.right: parent.right
                anchors.rightMargin: -75
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                value: 0
                Timer {
                    interval: 1000
                    repeat: true
                    running: isAnimating ? true:false
                }
                minimumValue: 0
                style: GaugeStyle {
                    valueBar: Rectangle {
                        color: "#7cfc00"
                        implicitWidth: 16
                    }
                }
                maximumValue: 100
            }

            Image {
                id: image
                x: 200
                width: 50
                height: 50
                anchors.top: parent.top
                anchors.topMargin: -70
                fillMode: Image.PreserveAspectFit
                anchors.rightMargin: 35
                source: "../images/motor.png"
                anchors.right: parent.right
            }

            Image {
                id: imageCapacity
                x: 679
                height: 50
                anchors.top: parent.top
                anchors.topMargin: -70
                anchors.right: parent.right
                anchors.rightMargin: -70
                fillMode: Image.PreserveAspectFit
                source: "../images/battery4.png"
            }
        }

        Row {
            id: indicatorRow_1
            x: 152
            width: 1280
            height: 50
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: gaugeRow.bottom
            anchors.topMargin: 10

            spacing: container.width * 0.02

            Rectangle {
                id: milage
                x: 6500
                width: 180
                height: 30
                color: "#000000"
                anchors.right: parent.right
                anchors.rightMargin: 390
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: statusIndicator00.right
                anchors.leftMargin: 3
                Text {
                    id: txtMilage
                    x: 0
                    width: 180
                    height: 30
                    color: "#ffffff"
                    text: "0123456789"
                    anchors.verticalCenterOffset: 0
                    anchors.verticalCenter: parent.verticalCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: 20
                    horizontalAlignment: Text.AlignHCenter
                }
                border.width: 1
                border.color: "#ffffff"
            }

            Text {
                id: txtClock
                x: 0
                y: 0
                color: "#ffffff"
                text: qsTr("00:00")
                font.pixelSize: 35
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottomMargin: 30
                anchors.bottom: gaugeRow.top
                Timer {
                    id: clockTimer
                    repeat: true
                    interval: 3 * 1000
                    triggeredOnStart: true
                    running: true
                }

                MouseArea {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.left: parent.left
                    hoverEnabled: false
                }
            }
        }

        Row {
            id: row1
            x: 8
            width: 1280
            height: 100
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 0

            Image {
                id: imageEcas
                width: 100
                height: 100
                fillMode: Image.PreserveAspectFit
                anchors.leftMargin: 0
                anchors.top: parent.top
                source: "../images/HMI-ICON-13.png"
                anchors.left: parent.left
                anchors.topMargin: 0
            }

            Image {
                id: imageGetOffAlarm1
                width: 100
                height: 100
                fillMode: Image.PreserveAspectFit
                anchors.leftMargin: 100
                anchors.top: parent.top
                source: "../images/HMI-ICON-11.png"
                anchors.left: parent.left
                anchors.topMargin: 0
            }

            Image {
                id: image1
                width: 100
                height: 100
                fillMode: Image.PreserveAspectFit
                anchors.leftMargin: 200
                anchors.top: parent.top
                source: "../images/HMI-ICON-06.png"
                anchors.left: parent.left
                anchors.topMargin: 0
            }

            Image {
                id: image2
                width: 100
                height: 100
                fillMode: Image.PreserveAspectFit
                anchors.leftMargin: 300
                anchors.top: parent.top
                source: "../images/HMI-ICON-05.png"
                anchors.left: parent.left
                anchors.topMargin: 0
            }

            Image {
                id: image3
                width: 100
                height: 100
                fillMode: Image.PreserveAspectFit
                anchors.leftMargin: 400
                anchors.top: parent.top
                source: "../images/HMI-ICON-03.png"
                anchors.left: parent.left
                anchors.topMargin: 0
            }

            Image {
                id: image4
                width: 100
                height: 100
                fillMode: Image.PreserveAspectFit
                anchors.leftMargin: 500
                anchors.top: parent.top
                source: "../images/HMI-ICON-04.png"
                anchors.left: parent.left
                anchors.topMargin: 0
            }

            Image {
                id: image5
                width: 100
                height: 100
                fillMode: Image.PreserveAspectFit
                anchors.leftMargin: 595
                anchors.top: parent.top
                source: "../images/HMI-ICON-15.png"
                anchors.left: parent.left
                anchors.topMargin: 0
            }

            Image {
                id: image6
                width: 100
                height: 100
                fillMode: Image.PreserveAspectFit
                anchors.leftMargin: 700
                anchors.top: parent.top
                source: "../images/HMI-ICON-10.png"
                anchors.left: parent.left
                anchors.topMargin: 0
            }

            Image {
                id: image7
                width: 100
                height: 100
                fillMode: Image.PreserveAspectFit
                anchors.leftMargin: 800
                anchors.top: parent.top
                source: "../images/HMI-ICON-08.png"
                anchors.left: parent.left
                anchors.topMargin: 0
            }

            Image {
                id: image8
                width: 100
                height: 100
                fillMode: Image.PreserveAspectFit
                anchors.leftMargin: 900
                anchors.top: parent.top
                source: "../images/HMI-ICON-14.png"
                anchors.left: parent.left
                anchors.topMargin: 0
            }

            Image {
                id: image9
                width: 100
                height: 100
                fillMode: Image.PreserveAspectFit
                anchors.leftMargin: 1000
                anchors.top: parent.top
                source: "../images/HMI-ICON-09.png"
                anchors.left: parent.left
                anchors.topMargin: 0
            }

            Image {
                id: image10
                width: 100
                height: 100
                fillMode: Image.PreserveAspectFit
                anchors.leftMargin: 1100
                anchors.top: parent.top
                source: "../images/HMI-ICON-07.png"
                anchors.left: parent.left
                anchors.topMargin: 0
            }

            Image {
                id: imageMenu
                width: 100
                height: 100
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.top: parent.top
                anchors.topMargin: 0
                source: "../images/na.png"
                fillMode: Image.PreserveAspectFit

                // How can I create a new window from within QML?
                // ( https://goo.gl/ivPZh7 )
                MouseArea {
                    id: mouseArea
                    z: 2
                    anchors.fill: parent
                    onClicked: {
                        var component = Qt.createComponent("BatteryDeployment.qml");
                        win = component.createObject(root);
                        win.show();
                    }
                }
            }
        }

        Row {
            id: row
            x: 40
            width: 200
            height: 100
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.top: row1.bottom
            anchors.topMargin: 0

            Image {
                id: imageEngineering
                width: 100
                height: 100
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.rightMargin: 0
                source: "../images/na.png"
                anchors.right: parent.right
                fillMode: Image.PreserveAspectFit
            }
        }

        Row {
            id: row2
            x: 42
            width: 200
            height: 100
            anchors.rightMargin: 0
            anchors.top: row.bottom
            anchors.topMargin: 0
            anchors.right: parent.right

            Image {
                id: imageCharging
                width: 100
                height: 100
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.rightMargin: 0
                source: "../images/na.png"
                anchors.right: parent.right
                fillMode: Image.PreserveAspectFit
            }
        }

        Row {
            id: row3
            width: 300
            height: 100
            anchors.left: parent.left
            anchors.leftMargin: 0
            Image {
                id: image13
                width: 100
                height: 100
                fillMode: Image.PreserveAspectFit
                anchors.leftMargin: 0
                anchors.top: parent.top
                source: "../images/HMI-ICON-34.png"
                anchors.left: parent.left
                anchors.topMargin: 0
            }

            Text {
                id: txtKph1
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("00.00")
                anchors.left: parent.left
                anchors.leftMargin: 110
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
                MouseArea {
                    width: 70
                    height: 40
                    anchors.top: parent.top
                    anchors.left: parent.left
                    hoverEnabled: false
                }
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 25
            }

            Text {
                id: txtKph3
                x: 0
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("㎏/㎠ ")
                anchors.right: parent.right
                anchors.rightMargin: 20
                horizontalAlignment: Text.AlignHCenter
                MouseArea {
                    width: 70
                    height: 40
                    anchors.top: parent.top
                    anchors.left: parent.left
                    hoverEnabled: false
                }
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 25
                verticalAlignment: Text.AlignVCenter
            }
            anchors.top: row1.bottom
            anchors.topMargin: 0
        }

        Row {
            id: row4
            x: -8
            width: 300
            height: 100
            Image {
                id: image14
                width: 100
                height: 100
                fillMode: Image.PreserveAspectFit
                anchors.leftMargin: 0
                anchors.top: parent.top
                source: "../images/HMI-ICON-32.png"
                anchors.left: parent.left
                anchors.topMargin: 0
            }

            Text {
                id: txtKph4
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("000")
                horizontalAlignment: Text.AlignHCenter
                MouseArea {
                    width: 70
                    height: 40
                    anchors.top: parent.top
                    anchors.left: parent.left
                    hoverEnabled: false
                }
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 120
                font.pixelSize: 25
                verticalAlignment: Text.AlignVCenter
                anchors.left: parent.left
            }

            Text {
                id: txtKph5
                x: 0
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("℃")
                horizontalAlignment: Text.AlignHCenter
                MouseArea {
                    width: 70
                    height: 40
                    anchors.top: parent.top
                    anchors.left: parent.left
                    hoverEnabled: false
                }
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: 20
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 25
                anchors.right: parent.right
            }
            anchors.leftMargin: 0
            anchors.top: row3.bottom
            anchors.left: parent.left
            anchors.topMargin: 0
        }

        Row {
            id: row5
            x: -6
            width: 300
            height: 100
            Image {
                id: image15
                width: 100
                height: 100
                fillMode: Image.PreserveAspectFit
                anchors.leftMargin: 0
                anchors.top: parent.top
                source: "../images/HMI-ICON-30.png"
                anchors.left: parent.left
                anchors.topMargin: 0
            }

            Text {
                id: txtKph6
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("000")
                horizontalAlignment: Text.AlignHCenter
                MouseArea {
                    width: 70
                    height: 40
                    anchors.top: parent.top
                    anchors.left: parent.left
                    hoverEnabled: false
                }
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 120
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 25
                anchors.left: parent.left
            }

            Text {
                id: txtKph7
                x: 0
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("℃")
                horizontalAlignment: Text.AlignHCenter
                MouseArea {
                    width: 70
                    height: 40
                    anchors.top: parent.top
                    anchors.left: parent.left
                    hoverEnabled: false
                }
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: 20
                font.pixelSize: 25
                verticalAlignment: Text.AlignVCenter
                anchors.right: parent.right
            }
            anchors.leftMargin: 0
            anchors.top: row4.bottom
            anchors.left: parent.left
            anchors.topMargin: 0
        }

        Row {
            id: row6
            x: 7
            width: 300
            height: 100
            anchors.leftMargin: 0
            anchors.top: row7.bottom
            anchors.left: parent.left
            anchors.topMargin: 0

            Image {
                id: image11
                width: 100
                height: 100
                fillMode: Image.PreserveAspectFit
                anchors.leftMargin: 0
                anchors.top: parent.top
                source: "../images/HMI-ICON-29.png"
                anchors.left: parent.left
                anchors.topMargin: 0
            }

            Image {
                id: image12
                width: 100
                height: 100
                fillMode: Image.PreserveAspectFit
                anchors.leftMargin: 100
                anchors.top: parent.top
                source: "../images/HMI-ICON-19.png"
                anchors.left: parent.left
                anchors.topMargin: 0
            }
        }

        Row {
            id: row7
            x: -1
            width: 500
            height: 100
            Image {
                id: image16
                width: 100
                height: 100
                fillMode: Image.PreserveAspectFit
                anchors.leftMargin: 0
                anchors.top: parent.top
                source: "../images/HMI-ICON-16.png"
                anchors.left: parent.left
                anchors.topMargin: 0
            }

            Image {
                id: image18
                width: 100
                height: 100
                fillMode: Image.PreserveAspectFit
                anchors.leftMargin: 100
                anchors.top: parent.top
                source: "../images/HMI-ICON-25.png"
                anchors.left: parent.left
                anchors.topMargin: 0
            }

            Image {
                id: image19
                width: 100
                height: 100
                fillMode: Image.PreserveAspectFit
                anchors.leftMargin: 200
                anchors.top: parent.top
                source: "../images/HMI-ICON-32.png"
                anchors.left: parent.left
                anchors.topMargin: 0
            }

            Image {
                id: image20
                width: 100
                height: 100
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.leftMargin: 300
                anchors.left: parent.left
                source: "../images/na.png"
                fillMode: Image.PreserveAspectFit
            }
            anchors.leftMargin: 0
            anchors.top: row8.bottom
            anchors.left: parent.left
            anchors.topMargin: 0
        }

        Row {
            id: row8
            x: -10
            width: 300
            height: 100
            Image {
                id: image17
                width: 100
                height: 100
                fillMode: Image.PreserveAspectFit
                anchors.leftMargin: 0
                anchors.top: parent.top
                source: "../images/HMI-ICON-17.png"
                anchors.left: parent.left
                anchors.topMargin: 0
            }

            Text {
                id: txtKph8
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("00")
                anchors.verticalCenterOffset: 0
                horizontalAlignment: Text.AlignHCenter
                MouseArea {
                    width: 70
                    height: 40
                    anchors.top: parent.top
                    anchors.left: parent.left
                    hoverEnabled: false
                }
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 120
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 25
                anchors.left: parent.left
            }

            Text {
                id: txtKph9
                x: 0
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("Volt")
                horizontalAlignment: Text.AlignHCenter
                MouseArea {
                    width: 70
                    height: 40
                    anchors.top: parent.top
                    anchors.left: parent.left
                    hoverEnabled: false
                }
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: 20
                font.pixelSize: 25
                verticalAlignment: Text.AlignVCenter
                anchors.right: parent.right
            }
            anchors.leftMargin: 0
            anchors.top: row5.bottom
            anchors.left: parent.left
            anchors.topMargin: 0
        }

        Rectangle {
            id: marquee1
            x: 0
            width: 1280
            height: 40
            color: "#333333"
            anchors.top: indicatorRow_1.bottom
            anchors.topMargin: 0
            Text {
                id: moving_text
                x: parent.width
                color: "#fa9500"
                text: "<<< Low Tire Presure >>>"
                visible: false
                fontSizeMode: Text.FixedSize
                font.pixelSize: 25
                anchors.verticalCenter: parent.verticalCenter
                NumberAnimation on x{
                    from: root.width
                    to: -1*moving_text.width
                    loops: Animation.Infinite
                    duration: 20*1000
                    running: isAnimating ? true:false
                }
                width: 0
                height: 0
            }
        }

        Rectangle {
            id: milageA2B
            x: 850
            y: 500
            width: 125
            height: 30
            color: "#000000"
            border.width: 1
            border.color: "#ffffff"
            Text {
                id: txtTrip
                width: 125
                height: 30
                color: "#ffffff"
                text: "000200"
                font.pointSize: 20
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }

    MyObject {
       id: myobject
    }

    // c++ -> QML
    // https://goo.gl/sHMaKL
    function updateSystemInfo(timestamp, n_dbop, cpu, freemem, ts) {
        //console.log("updateSystemInfo+ ", freemem)
        //text1.text = timestamp; // https://goo.gl/UQ4jEV
        // better not do calculation in QML, just display
        dbop.text = n_dbop;
        cpu1.text = cpu;
        fmem1.text = freemem;
        gauge1.value = cpu; // test
    txtMilage.text = ts;
        return ""
    }

    function updateCANBus(speed, rpm, gear, milage) {
        if ( !switchDelegate1.checked ) {
            console.log("updateCANBus: A "+switchDelegate1.checked)
            return ""
        }
        console.log("updateCANBus (", gear, speed, rpm, milage, ")")
        //gauge1.value = cpu;
        //txtKph.text = speed;
        valueSource.kph = speed;
        txtGear1.text = gear
        //speedometer.value = speed;
        //tachometer.value = rpm;
        txtMilage.text = milage;
        return ""
    }

    function setAnimaiton(is_on) {
        isAnimating = is_on;
        console.debug("setAnimation +++ " + isAnimating);
    }

    // Dashboards are typically in a landscape orientation, so we need to ensure
    // our height is never greater than our width.

    ToggleButton {
        id: toggleButton
        x: 850
        y: 404
        width: 100
        height: 100
        text: qsTr("TRIP")
        z: 1
    }
}




























































/*##^## Designer {
    D{i:39;anchors_x:0}D{i:106;anchors_width:125}
}
 ##^##*/
