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
import QtQuick.Extras 1.4
// mark to prevent importing SwitchDelegate such that delaybutton 'round'
// import QtQuick.Controls 2.5

// Access C++ function from QML
// https://goo.gl/nxZegu
//import com.myself 1.0

Window {
    id: root
    objectName: mainWindow

    visible: true
    // ( https://goo.gl/nnR4j9 )
    x: (Screen.width - width) / 2
    y: (Screen.height - height) / 2
    //x: 0
    //y: 0
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
    property alias imageBattery: imageBattery
    //property alias gauge1: gauge
    //property alias txtKph1: txtKph
    property alias txtMilage1: txtMilage
    //property alias switchDelegate1: switchDelegate
    //property bool isAnimating : switchDelegate1.checked
    // Launch a child QML window from a parent QML window
    // ( https://goo.gl/J67Pcc )
    property variant win;  // you can hold this as a reference..

    title: qsTr("RACEV HMI")

    ValueSource {
        id: valueSource
        // objectName: "valueSource1" // ( https://goo.gl/Caomvq )
    }

    Rectangle {
        id: rectangle
        //color: "lightGrey"
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 800
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 1280
    }

    Item {
        id: container
        height: Math.min(root.width, root.height)
        visible: true
        z: 2
        anchors.verticalCenterOffset: -2
        anchors.horizontalCenterOffset: 0
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
            Rectangle {
                id: recMessage
                x: 0
                y: 0
                width: 1280
                height: 50
                color: "#1f1f1f"
                anchors.bottom: parent.bottom

                MouseArea {
            onClicked: {
                var component = Qt.createComponent("BatteryStatus.qml");
                win = component.createObject(deployment_window);
                //TODO: check singleton
                win.show();
            }
                }

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

                Text {
                    id: txtVersionLabel
                    x: 192
                    y: 382
                    width: 75
                    height: 44
                    color: "#ffffff"
                    text: qsTr("VER:")
                    textFormat: Text.PlainText
                    fontSizeMode: Text.FixedSize
                    anchors.leftMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 35
                    anchors.left: fmem2.right
                }

                Text {
                    id: txtVersion
                    objectName: "txtVersion"
                    x: 192
                    y: 382
                    width: 350
                    height: 44
                    color: "#ffffff"
                    text: qsTr("YYYYMMDDHHNNSS")
                    textFormat: Text.PlainText
                    fontSizeMode: Text.FixedSize
                    anchors.leftMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 35
                    anchors.left: txtVersionLabel.right
                }
    /*
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
    */
            }

        }

        Row {
            id: row
            x: 40
            width: 100
            height: 100
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.top: rowTop.bottom
            anchors.topMargin: 0

            Image {
                id: imageCharging
                width: 100
                height: 100
                anchors.topMargin: 0
                fillMode: Image.PreserveAspectFit
                anchors.top: parent.top
                source: "../images/park-and-charge.png"
                anchors.right: parent.right
                anchors.rightMargin: 0
        MouseArea {
            //id: mouseArea
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
            id: rowTop
            width: 1180
            height: 100
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0

            Image {
                id: imageEcas
                width: 100
                height: 100
                fillMode: Image.PreserveAspectFit
                anchors.leftMargin: 0
                anchors.top: parent.top
                source: "../images/1-white/白HMI-ICON-13.png"
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
                source: "../images/1-white/白HMI-ICON-11.png"
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
                source: "../images/1-white/HMI-ICON-06.png"
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
                source: "../images/1-white/白HMI-ICON-05.png"
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
                source: "../images/1-white/白HMI-ICON-03.png"
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
                source: "../images/1-white/白HMI-ICON-04.png"
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
                source: "../images/1-white/白HMI-ICON-15.png"
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
                source: "../images/1-white/白HMI-ICON-10.png"
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
                source: "../images/1-white/白HMI-ICON-08.png"
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
                source: "../images/1-white/白HMI-ICON-14.png"
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
                source: "../images/1-white/白HMI-ICON-09.png"
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
                source: "../images/1-white/白HMI-ICON-07.png"
                anchors.left: parent.left
                anchors.topMargin: 0
            }
        }


        Row {
            id: row2
            x: 42
            width: 100
            height: 100
            anchors.rightMargin: 0
            anchors.top: row.bottom
            anchors.topMargin: 0
            anchors.right: parent.right

            Image {
                id: imageDiagnostics
                width: 100
                height: 100
                anchors.topMargin: 0
                fillMode: Image.PreserveAspectFit
                anchors.top: parent.top
                source: "../images/diagnose.png"
                anchors.right: parent.right
                anchors.rightMargin: 0
            }
        }

        Row {
            id: rowAir
            width: 300
            height: 43
            anchors.left: parent.left
            anchors.leftMargin: 0
            Image {
                id: imageAir
                width: 100
                height: 100
                anchors.verticalCenter: parent.verticalCenter
                fillMode: Image.PreserveAspectFit
                anchors.leftMargin: 0
                source: "../images/0-color/HMI-ICON-34.png"
                anchors.left: parent.left
            }

            Text {
                id: txtAirCaption
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

            Text {
                id: txtAirReading
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("00.00")
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 25
                verticalAlignment: Text.AlignVCenter
            }
            anchors.top: rowTop.bottom
            anchors.topMargin: 200
        }

        Row {
            id: rowMotorTemp
            x: -8
            width: 300
            height: 43
            Image {
                id: imageMotorTemp
                width: 100
                height: 100
                anchors.verticalCenter: parent.verticalCenter
                fillMode: Image.PreserveAspectFit
                anchors.leftMargin: 0
                source: "../images/1-white/白HMI-ICON-32.png"
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

            Text {
                id: txtMotorIoTempReading
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("000")
                wrapMode: Text.WordWrap
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.left: parent.left
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 25
                anchors.leftMargin: 0
            }
            anchors.leftMargin: 0
            anchors.top: rowAir.bottom
            anchors.left: parent.left
            anchors.topMargin: 10
        }

        Row {
            id: rowIoTankTemp
            x: -6
            width: 300
            height: 43
            anchors.top: rowMotorTemp.bottom
            anchors.topMargin: 10
            Image {
                id: imageIoTankTemp
                width: 100
                height: 100
                anchors.verticalCenter: parent.verticalCenter
                fillMode: Image.PreserveAspectFit
                anchors.leftMargin: 0
                source: "../images/1-white/白HMI-ICON-30.png"
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

            Rectangle {
                id: rectangle2
                y: 379
                width: 100
                height: 43
                color: "#000000"
                radius: 10
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 100
                Text {
                    id: txtKph6
                    y: 0
                    width: 70
                    height: 43
                    color: "#ffffff"
                    text: qsTr("000")
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    MouseArea {
                        width: 70
                        height: 40
                        anchors.left: parent.left
                        hoverEnabled: false
                        anchors.top: parent.top
                    }
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 25
                    verticalAlignment: Text.AlignVCenter
                }
            }
            anchors.leftMargin: 0
            anchors.left: parent.left
        }

        Row {
            id: rowHcWarning
            x: -1
            width: 300
            height: 100

            Image {
                id: image18
                width: 100
                height: 100
                fillMode: Image.PreserveAspectFit
                anchors.leftMargin: 100
                anchors.top: parent.top
                source: "../images/1-white/白HMI-ICON-25.png"
                anchors.left: parent.left
                anchors.topMargin: 0
            }

            Image {
                id: imageMotor
                width: 100
                height: 100
                fillMode: Image.PreserveAspectFit
                anchors.leftMargin: 200
                anchors.top: parent.top
                source: "../images/0-color/HMI-ICON-20.png"
                anchors.left: parent.left
                anchors.topMargin: 0
            }

            Image {
                id: imageHcWarning
                y: 7
                width: 100
                height: 100
                anchors.left: parent.left
                anchors.leftMargin: 0
                fillMode: Image.PreserveAspectFit
                source: "../images/1-white/白HMI-ICON-16.png"
                anchors.top: parent.top
                anchors.topMargin: 0
            }
            anchors.leftMargin: 0
            anchors.top: rowLcWarning.bottom
            anchors.left: parent.left
            anchors.topMargin: 0
        }

        Row {
            id: rowLcWarning
            x: -10
            width: 300
            height: 43
            anchors.top: rowIoTankTemp.bottom
            anchors.topMargin: 10
            Image {
                id: imageLcWarning
                width: 100
                height: 100
                anchors.verticalCenter: parent.verticalCenter
                fillMode: Image.PreserveAspectFit
                anchors.leftMargin: 0
                source: "../images/1-white/白HMI-ICON-17.png"
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

            Rectangle {
                id: rectangle3
                y: 439
                width: 100
                height: 43
                color: "#000000"
                radius: 10
                anchors.left: parent.left
                anchors.leftMargin: 100
                anchors.verticalCenter: parent.verticalCenter
                Text {
                    id: txtKph8
                    y: 0
                    width: 70
                    height: 43
                    color: "#ffffff"
                    text: qsTr("00")
                    anchors.verticalCenterOffset: 0
                    verticalAlignment: Text.AlignVCenter
                    MouseArea {
                        width: 70
                        height: 40
                        anchors.left: parent.left
                        hoverEnabled: false
                        anchors.top: parent.top
                    }
                    anchors.verticalCenter: parent.verticalCenter
                    horizontalAlignment: Text.AlignHCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 25
                }
            }
            anchors.leftMargin: 0
            anchors.left: parent.left
        }

        Row {
            id: rowDateTime
            x: 2
            width: 350
            height: 43
            anchors.top: imageEvacuation.bottom
            anchors.leftMargin: 35
            anchors.left: parent.left
            anchors.topMargin: 0

            Text {
                id: txtClock
                x: 0
                y: 0
                width: 350
                color: "#ffffff"
                text: qsTr("2019/01/31 00:00:00")
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 35
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottomMargin: 30
        function set() {
        // How to format a Date in MM/dd/yyyy HH:mm:ss
        // format in JavaScript? ( https://goo.gl/nq1b73 )
Number.prototype.padLeft = function(base,chr){
    var  len = (String(base || 10).length - String(this).length)+1;
    return len > 0? new Array(len).join(chr || '0')+this : this;
}
            var d = new Date,
            dformat = [
                d.getFullYear(),
                (d.getMonth()+1).padLeft(),
                d.getDate().padLeft(),
            ].join('/') +' ' + [
            d.getHours().padLeft(),
            d.getMinutes().padLeft(),
            d.getSeconds().padLeft()].join(':');
            //=> dformat => '2012/05/17 10:52:21'
            txtClock.text = dformat;
        }
        // QML Example Use timer to update Date
        // ( https://goo.gl/REe3HA )
                Timer {
                    id: clockTimer
                    repeat: true
                    interval: 1 * 1000
                    triggeredOnStart: true
                    running: true
            onTriggered: txtClock.set()
                }

                MouseArea {
                    hoverEnabled: false
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }

        Rectangle {
            id: milage
            x: 6500
            width: 180
            height: 30
            color: "#000000"
            radius: 10
            anchors.top: speedometer.bottom
            anchors.topMargin: 30
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.leftMargin: 3
            border.width: 1
            //anchors.left: statusIndicator00.right
            border.color: "#000000"
            Text {
                id: txtMilage
                x: 0
                width: 180
                height: 30
                color: "#ffffff"
                text: "0123456789"
                anchors.top: parent.top
                anchors.topMargin: 0
                font.pointSize: 20
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
        }

        Row {
            id: row10
            x: 49
            width: 100
            height: 100
            anchors.top: row2.bottom
            anchors.rightMargin: 0
            anchors.right: parent.right
            anchors.topMargin: 0

            Image {
                id: imageEngineering
                x: 0
                width: 100
                height: 100
                anchors.topMargin: 0
                fillMode: Image.PreserveAspectFit
                anchors.top: parent.top
                source: "../images/engineering.png"
                anchors.right: parent.right
                anchors.rightMargin: 0
            }
        }

        Image {
            id: image12
            width: 100
            height: 100
            anchors.right: parent.right
            anchors.rightMargin: 280
            anchors.top: rowTop.bottom
            anchors.topMargin: 0
            fillMode: Image.PreserveAspectFit
            source: "../images/1-white/白HMI-ICON-19.png"
        }

        Image {
            id: image11
            y: 100
            width: 100
            height: 100
            anchors.right: parent.right
            anchors.rightMargin: 180
            fillMode: Image.PreserveAspectFit
            source: "../images/1-white/白HMI-ICON-29.png"
            anchors.top: rowTop.bottom
            anchors.topMargin: 0
        }

        CircularGauge {
            id: powerGauge
            x: 0
            width: 200
            height: 200
            anchors.top: parent.top
            anchors.topMargin: 200
            stepSize: 150
            value: 0
            minimumValue: -750
            maximumValue: 750
            anchors.right: parent.right
            anchors.rightMargin: 130
            style: IconGaugeStyle {
                id: tempGaugeStyle
                maxWarningColor: Qt.rgba(0.5, 0, 0, 1)
                //icon: "qrc:/images/power.png"
                tickmarkLabel: Text {
                    color: "#ffffff"
                    text: styleData.value/150
                    font.pixelSize: tempGaugeStyle.toPixels(0.16)
                }
            }
        }

        CircularGauge {
            id: socGauge
            x: 950
            y: 406
            width: 200
            height: 200
            anchors.right: parent.right
            anchors.rightMargin: 130

            Rectangle {
                id: recSocLight
                x: 0
                y: 0
                width: 40
                height: 40
                color: "#000000"
                radius: 0
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 15
                StatusIndicator {
                    id: statusIndicator
            x: 0
            width: 40
            height: 40
            active: true
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 5
            anchors.rightMargin: 0
            anchors.right: recSoc.left
            anchors.top: socGauge.bottom
        }
                anchors.horizontalCenter: parent.horizontalCenter
                border.width: 1
                anchors.leftMargin: 3
                border.color: "#ffffff"
                //anchors.left: statusIndicator00.right
            }
        }

        CircularGauge {
            id: speedometer
            x: 0
            y: 100
            width: 500
            height: 500
            value: 0
            anchors.horizontalCenter: parent.horizontalCenter
            maximumValue: 200
            style: DashboardGaugeStyle {
            }
            smooth: true
            TurnIndicator {
                id: leftIndicator
                x: 100
                width: 70
                height: 70
                anchors.left: parent.left
                flashing: false
                on: false
                anchors.leftMargin: 0
                direction: Qt.LeftArrow
                anchors.top: parent.top
                anchors.topMargin: 0
            }
            Rectangle {
                id: rectGear1
                x: -9
                y: -8
                width: 40
                height: 40
                color: "#000000"
                anchors.horizontalCenter: parent.horizontalCenter
                //anchors.left: statusIndicator00.right
                border.width: 1
                Text {
                    id: txtGear1
                    width: 40
                    height: 40
                    color: "#ffffff"
                    text: "N"
                    lineHeight: 0.8
                    anchors.centerIn: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 25
                }
                anchors.bottomMargin: 15
                anchors.leftMargin: 3
                border.color: "#ffffff"
                anchors.bottom: parent.bottom
            }
            TurnIndicator {
                id: rightIndicator
                x: 80
                width: height
                height: 70
                flashing: /*isAnimating ? true:*/ false
                //on: isAnimating ? true:false
                on: false
                anchors.right: parent.right
                anchors.rightMargin: 0
                direction: Qt.RightArrow
                anchors.top: parent.top
                anchors.topMargin: 0
            }
        }

        Image {
            id: imageEvacuation
            width: 100
            height: 100
            anchors.left: parent.left
            anchors.leftMargin: 200
            visible: true
            anchors.topMargin: 100
            fillMode: Image.PreserveAspectFit
            anchors.top: parent.top
            source: "../images/1-white/白HMI-ICON-24.png"
        }

        Image {
            id: imageTyre
            width: 100
            height: 100
            anchors.left: parent.left
            anchors.leftMargin: 100
            anchors.top: rowTop.bottom
            anchors.topMargin: 0
            fillMode: Image.PreserveAspectFit
            // how to add alpha channel
            // ( https://goo.gl/Umjp9m )
            source: "../images/tyre_pressure1.png"
        }

        Rectangle {
            id: recSoc
            x: 6509
            y: -6
            width: 80
            height: 30
            color: "#000000"
            radius: 10
            anchors.topMargin: 5
            Text {
                id: txtMilageLeft
                x: 0
                width: 80
                height: 30
                color: "#ffffff"
                text: "0123"
                anchors.topMargin: 0
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 20
                anchors.top: parent.top
                verticalAlignment: Text.AlignVCenter
            }
            anchors.horizontalCenter: socGauge.horizontalCenter
            anchors.leftMargin: 3
            border.width: 1
            border.color: "#000000"
            anchors.top: socGauge.bottom
            //anchors.left: statusIndicator00.right
        }

        Text {
            id: txtMilageLeftCap
            y: -2
            width: 60
            height: 30
            color: "#ffffff"
            text: "Km"
            anchors.left: recSoc.right
            anchors.leftMargin: 0
            anchors.topMargin: 5
            horizontalAlignment: Text.AlignLeft
            font.pointSize: 20
            anchors.top: socGauge.bottom
            verticalAlignment: Text.AlignVCenter
        }
    }
/*
    MyObject {
       id: myobject
    }
*/
    // c++ -> QML
    // https://goo.gl/sHMaKL
    function updateSystemInfo(timestamp, n_dbop, cpu, freemem, ts) {
        //console.log("updateSystemInfo+ ", freemem)
        //text1.text = timestamp; // https://goo.gl/UQ4jEV
        // better not do calculation in QML, just display
        dbop.text = n_dbop;
        cpu1.text = cpu;
        fmem1.text = freemem;
        //gauge1.value = cpu; // test
    txtMilage.text = ts;
        return ""
    }

    function updateCANBus(speed, rpm, gear, milage) {
        if ( true /*!switchDelegate1.checked*/ ) {
            //console.log("updateCANBus: A "+switchDelegate1.checked)
            return ""
        }
        //console.log("updateCANBus (", gear, speed, rpm, milage, ")")
        //gauge1.value = cpu;
        //txtKph.text = speed;
        valueSource.kph = speed;
        txtGear1.text = gear
        //speedometer.value = speed;
        //tachometer.value = rpm;
        txtMilage.text = milage;
        return ""
    }

    function updateModel(speed, rpm, gear, milage) {
        if ( true /*!switchDelegate1.checked*/ ) {
            //console.log("updateCANBus: A "+switchDelegate1.checked)
            return ""
        }
        //console.log("updateCANBus (", gear, speed, rpm, milage, ")")
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
    }

    // Dashboards are typically in a landscape orientation, so we need to ensure
    // our height is never greater than our width.

    ToggleButton {
        id: toggleButton
        x: 746
        y: 620
        width: 50
        height: 50
        text: qsTr("T")
        transformOrigin: Item.Center
        z: 1
    }

    Image {
        id: imageBattery
        x: -9
        y: -8
        width: 100
        height: 100
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.rightMargin: 0
        source: "../images/battery-charging-icon.png"
        fillMode: Image.PreserveAspectFit
        anchors.right: parent.right
        // How can I create a new window from within QML?
        // ( https://goo.gl/ivPZh7 )
    MouseArea {
            id: mouseArea
        z: 2
        anchors.fill: parent
        onClicked: {
         //TODO:check singleton
        var component = Qt.createComponent("BatteryDeployment.qml");
        win = component.createObject(root);
        win.show();
        }
    }
    }
}

