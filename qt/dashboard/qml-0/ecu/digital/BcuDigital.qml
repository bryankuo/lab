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
    id: bcuDigital

    // ( https://goo.gl/LWbdMG )
    objectName: "bcuDigitalWindow"

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
    property alias window: bcuDigital
    flags: Qt.FramelessWindowHint
    title: "BCU IO (Digital)"

    // Property names must begin with a lower case letter
    // and can only contain letters ( https://goo.gl/HzLQet )
    //
    //property string batteryPackName
    signal qmlSignal(string msg)
    signal qmlSignalActive(string msg)

    function updateMsg_BCU_VCU_SMD(td1,td2,td3,td4,td5,td6) {
	txtTemperatureDetect1.text = td1;
	txtTemperatureDetect2.text = td2;
	txtTemperatureDetect3.text = td3;
	txtTemperatureDetect4.text = td4;
	txtTemperatureDetect5.text = td5;
	txtTemperatureDetect6.text = td6;
    }

    function updateMsg_BCU_VCU_MSG0(abs_alarm, fl_lining, fr_lining,
	rl_lining, rr_lining, ecas33f, ecas_kneeling, ecas34w,
	s_bcu2vcu_lcounter) {
	txtCode.text = s_bcu2vcu_lcounter;
    }

    Rectangle {
        id: recBcuDigital
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
        source: "../../../images/0-color/HMI-ICON-55.png"
        fillMode: Image.PreserveAspectFit
        MouseArea {
        id: maBack
        z: 2
        anchors.fill: parent
        onClicked: {
        bcuDigital.hide();
        }
    }
    }

    Rectangle {
        id: rowbcuDigital
        x: 200
        y: 30
        width: 300
        height: 43
	color: "#161616"
        anchors.leftMargin: 50
        Text {
            id: txtbcuDigital
            y: 0
            width: 100
            height: 43
            color: "#ffffff"
            text: qsTr("BCU IO (Digital)")
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

    Rectangle {
        id: rowReserved3
        x: -1
        width: 450
        height: 43
	color: "#161616"
        anchors.leftMargin: 50
        anchors.left: parent.left
        Rectangle {
            id: recReserved3
            y: 439
            width: 100
            height: 43
            color: "#000000"
            radius: 10
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 15
            anchors.left: txtReservedCaption3.right
            Text {
                id: txtReserved3
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("0")
                anchors.verticalCenter: parent.verticalCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 25
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenterOffset: 0
                horizontalAlignment: Text.AlignHCenter
            }
        }

        Text {
            id: txtReservedCaption3
            y: 0
            width: 300
            height: 43
            color: "#ffffff"
            text: qsTr("Reserved :")
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            verticalAlignment: Text.AlignVCenter
            anchors.left: parent.left
            font.pixelSize: 25
            horizontalAlignment: Text.AlignLeft
        }
        anchors.topMargin: 10
        anchors.top: rowbcuDigital.bottom
    }

    Rectangle {
        id: rowTemperatureDetect5
        x: 7
        width: 450
        height: 43
	color: "#161616"
        anchors.leftMargin: 50
        anchors.left: parent.left
        Rectangle {
            id: recTemperatureDetect5
            y: 439
            width: 100
            height: 43
            color: "#000000"
            radius: 10
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 15
            anchors.left: txtTemperatureDetect5Caption.right
            Text {
                id: txtTemperatureDetect5
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("0")
                anchors.verticalCenter: parent.verticalCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 25
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenterOffset: 0
                horizontalAlignment: Text.AlignHCenter
            }
        }

        Text {
            id: txtTemperatureDetect5Caption
            y: 0
            width: 300
            height: 43
            color: "#ffffff"
            text: qsTr("Temperature Detect 5 :")
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            verticalAlignment: Text.AlignVCenter
            anchors.left: parent.left
            font.pixelSize: 25
            horizontalAlignment: Text.AlignLeft
        }
        anchors.topMargin: 10
        anchors.top: rowTemperatureDetect4.bottom
    }

    Rectangle {
        id: rowTemperatureDetect6
        width: 450
        height: 43
	color: "#161616"
        anchors.left: parent.left
        anchors.leftMargin: 50
        Rectangle {
            id: recTemperatureDetect6
            y: 439
            width: 100
            height: 43
            color: "#000000"
            radius: 10
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 15
            anchors.left: txtTemperatureDetect6Caption.right
            Text {
                id: txtTemperatureDetect6
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("0")
                anchors.verticalCenter: parent.verticalCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 25
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenterOffset: 0
                horizontalAlignment: Text.AlignHCenter
            }
        }

        Text {
            id: txtTemperatureDetect6Caption
            y: 0
            width: 300
            height: 43
            color: "#ffffff"
            text: qsTr("Temperature Detect 6 :")
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            verticalAlignment: Text.AlignVCenter
            anchors.left: parent.left
            font.pixelSize: 25
            horizontalAlignment: Text.AlignLeft
        }
        anchors.topMargin: 10
        anchors.top: rowTemperatureDetect5.bottom
    }

    Rectangle {
        id: rowTemperatureDetect2
        x: 13
        y: 6
        width: 450
        height: 43
	color: "#161616"
        anchors.leftMargin: 50
        anchors.left: parent.left
        Rectangle {
            id: recTemperatureDetect2
            y: 439
            width: 100
            height: 43
            color: "#000000"
            radius: 10
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 15
            anchors.left: txtTemperatureDetect2Caption.right
            Text {
                id: txtTemperatureDetect2
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("0")
                anchors.verticalCenter: parent.verticalCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 25
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenterOffset: 0
                horizontalAlignment: Text.AlignHCenter
            }
        }

        Text {
            id: txtTemperatureDetect2Caption
            y: 0
            width: 300
            height: 43
            color: "#ffffff"
            text: qsTr("Temperature Detect 2 :")
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            verticalAlignment: Text.AlignVCenter
            anchors.left: parent.left
            font.pixelSize: 25
            horizontalAlignment: Text.AlignLeft
        }
        anchors.topMargin: 10
        anchors.top: rowTemperatureDetect1.bottom
    }

    Rectangle {
        id: rowTemperatureDetect1
        x: 6
        y: 249
        width: 450
        height: 43
	color: "#161616"
        anchors.leftMargin: 50
        anchors.left: parent.left
        Rectangle {
            id: recTemperatureDetect1
            y: 439
            width: 100
            height: 43
            color: "#000000"
            radius: 10
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 15
            anchors.left: txtTemperatureDetect1Caption.right
            Text {
                id: txtTemperatureDetect1
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("0")
                anchors.verticalCenter: parent.verticalCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 25
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenterOffset: 0
                horizontalAlignment: Text.AlignHCenter
            }
        }

        Text {
            id: txtTemperatureDetect1Caption
            y: 0
            width: 300
            height: 43
            color: "#ffffff"
            text: qsTr("Temperature Detect 1 :")
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            verticalAlignment: Text.AlignVCenter
            anchors.left: parent.left
            font.pixelSize: 25
            horizontalAlignment: Text.AlignLeft
        }
        anchors.topMargin: 10
        anchors.top: rowReserved3.bottom
    }

    Rectangle {
        id: rowTemperatureDetect4
        x: 14
        y: 7
        width: 450
        height: 43
	color: "#161616"
        anchors.leftMargin: 50
        anchors.left: parent.left
        Rectangle {
            id: recTemperatureDetect4
            y: 439
            width: 100
            height: 43
            color: "#000000"
            radius: 10
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 15
            anchors.left: txtTemperatureDetect4Caption.right
            Text {
                id: txtTemperatureDetect4
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("0")
                anchors.verticalCenter: parent.verticalCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 25
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenterOffset: 0
                horizontalAlignment: Text.AlignHCenter
            }
        }

        Text {
            id: txtTemperatureDetect4Caption
            y: 0
            width: 300
            height: 43
            color: "#ffffff"
            text: qsTr("Temperature Detect 4 :")
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            verticalAlignment: Text.AlignVCenter
            anchors.left: parent.left
            font.pixelSize: 25
            horizontalAlignment: Text.AlignLeft
        }
        anchors.topMargin: 10
        anchors.top: rowTemperatureDetect3.bottom
    }

    Rectangle {
        id: rowTemperatureDetect3
        x: 7
        y: 432
        width: 450
        height: 43
	color: "#161616"
        anchors.leftMargin: 50
        anchors.left: parent.left
        Rectangle {
            id: recTemperatureDetect3
            y: 439
            width: 100
            height: 43
            color: "#000000"
            radius: 10
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 15
            anchors.left: txtTemperatureDetect3Caption.right
            Text {
                id: txtTemperatureDetect3
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("0")
                anchors.verticalCenter: parent.verticalCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 25
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenterOffset: 0
                horizontalAlignment: Text.AlignHCenter
            }
        }

        Text {
            id: txtTemperatureDetect3Caption
            y: 0
            width: 300
            height: 43
            color: "#ffffff"
            text: qsTr("Temperature Detect 3 :")
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            verticalAlignment: Text.AlignVCenter
            anchors.left: parent.left
            font.pixelSize: 25
            horizontalAlignment: Text.AlignLeft
        }
        anchors.topMargin: 10
        anchors.top: rowTemperatureDetect2.bottom
    }

    Rectangle {
        id: rowCode
        x: -9
        y: -8
        width: 450
        height: 43
	color: "#161616"
        anchors.leftMargin: 50

        Text {
            id: txtCode
            y: 0
            width: 300
            height: 43
            color: "#ffffff"
            text: qsTr("0")
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 25
        }
        anchors.topMargin: 10
        anchors.top: rowTemperatureDetect6.bottom
        anchors.left: parent.left
    }

    onActiveChanged : {
        if ( true === bcuDigital.active ) {
        bcuDigital.qmlSignalActive("BCUDigital");
    }
    }

}



















/*##^## Designer {
    D{i:26;anchors_y:"-4"}D{i:30;anchors_y:"-8"}D{i:34;anchors_x:8;anchors_y:1}
}
 ##^##*/
