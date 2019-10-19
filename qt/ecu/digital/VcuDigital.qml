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
import "../../style"

Window {
    id: vcuDigital

    // ( https://goo.gl/LWbdMG )
    objectName: "vcuDigitalWindow"

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
    property alias window: vcuDigital
    flags: Qt.FramelessWindowHint
    title: "VCU IO (Digital)"

    // Property names must begin with a lower case letter
    // and can only contain letters ( https://goo.gl/HzLQet )
    //
    //property string batteryPackName
    signal qmlSignal(string msg)
    signal qmlSignalActive(string msg)

    function updateMsg_VCU_IOSIG_MSG_Byte3(l_detect) {
    txtLeakageDectionValue.text = l_detect;
    }

    function updateMsg_BMS_VCU_Msg03(max_pt_temp, max_pt_idx,
    charger_cc2,charger_conn1,charger_conn2,bms_pr_state,
    mctr_state, mi_ctr_state, frelay_state, s_bms_lcounter) {
    txtBVLCounter.text = s_bms_lcounter;
    }

    Rectangle {
        id: rectanglevcuDigital
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
        source: "../../../images/0-color/HMI-ICON-55.png"
        fillMode: Image.PreserveAspectFit
        MouseArea {
        id: maBack
        z: 2
        anchors.fill: parent
        onClicked: {
        vcuDigital.hide();
        }
        }
    }

    Rectangle {
        id: rowvcuDigital
        x: 200
        y: 30
        width: 300
        height: 43
    color: "#161616"
        anchors.leftMargin: 50
        Text {
            id: txtvcuDigital
            y: 0
            width: 100
            height: 43
            color: "#ffffff"
            text: qsTr("VCU IO (Digital)")
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
        id: rowLeakageDetect
        width: 350
        height: 43
    color: "#161616"
        anchors.left: parent.left
        anchors.leftMargin: 50

        Rectangle {
            id: recLeakageDetectValue
            y: 439
            width: 100
            height: 43
            color: "#000000"
            radius: 10
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 15
            anchors.left: txtLeakageDetectCaption.right
            Text {
                id: txtLeakageDectionValue
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("511")
                anchors.verticalCenter: parent.verticalCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 25
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenterOffset: 0
                horizontalAlignment: Text.AlignHCenter
            }
        }

        Text {
            id: txtLeakageDetectCaption
            y: 0
            width: 200
            height: 43
            color: "#ffffff"
            text: qsTr("Leakage Detect :")
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            verticalAlignment: Text.AlignVCenter
            anchors.left: parent.left
            font.pixelSize: 25
            horizontalAlignment: Text.AlignLeft
        }
        anchors.topMargin: 10
        anchors.top: rowvcuDigital.bottom
    }

    Rectangle {
        id: rowReserved0
        x: -9
        width: 350
        height: 43
    color: "#161616"
        anchors.leftMargin: 50
        anchors.left: parent.left
        Rectangle {
            id: recReserved0
            y: 439
            width: 100
            height: 43
            color: "#000000"
            radius: 10
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 15
            anchors.left: txtReservedCaption0.right
            Text {
                id: txtReserved0
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("")
                anchors.verticalCenter: parent.verticalCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 25
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenterOffset: 0
                horizontalAlignment: Text.AlignHCenter
            }
        }

        Text {
            id: txtReservedCaption0
            y: 0
            width: 200
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
        anchors.top: rowLeakageDetect.bottom
    }

    Rectangle {
        id: rowReserved1
        x: -6
        width: 350
        height: 43
    color: "#161616"
        anchors.leftMargin: 50
        anchors.left: parent.left
        Rectangle {
            id: recReserved1
            y: 439
            width: 100
            height: 43
            color: "#000000"
            radius: 10
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 15
            anchors.left: txtReservedCaption1.right
            Text {
                id: txtReserved1
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("")
                anchors.verticalCenter: parent.verticalCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 25
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenterOffset: 0
                horizontalAlignment: Text.AlignHCenter
            }
        }

        Text {
            id: txtReservedCaption1
            y: 0
            width: 200
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
        anchors.top: rowReserved0.bottom
    }

    Rectangle {
        id: rowReserved2
        x: 3
        width: 350
        height: 43
    color: "#161616"
        anchors.leftMargin: 50
        anchors.left: parent.left
        Rectangle {
            id: recReserved2
            y: 439
            width: 100
            height: 43
            color: "#000000"
            radius: 10
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 15
            anchors.left: txtReservedCaption2.right
            Text {
                id: txtReserved2
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("")
                anchors.verticalCenter: parent.verticalCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 25
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenterOffset: 0
                horizontalAlignment: Text.AlignHCenter
            }
        }

        Text {
            id: txtReservedCaption2
            y: 0
            width: 200
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
        anchors.top: rowReserved1.bottom
    }

    Rectangle {
        id: rowReserved3
        x: 3
        width: 350
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
            width: 200
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
        anchors.top: rowReserved2.bottom
    }

    Rectangle {
        id: rowReserved4
        x: -6
        y: 357
        width: 350
        height: 43
        color: "#161616"
        anchors.topMargin: 10
        anchors.top: rowReserved2.bottom
        anchors.left: parent.left
        Rectangle {
            id: recReserved4
            y: 439
            width: 100
            height: 43
            color: "#000000"
            radius: 10
            anchors.left: txtReservedCaption4.right
            anchors.leftMargin: 15
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: txtReservedCaption4
            y: 0
            width: 200
            height: 43
            color: "#ffffff"
            text: qsTr("Reserved :")
            anchors.left: parent.left
            font.pixelSize: 25
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 0
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
        }
        anchors.leftMargin: 50
    }

    Rectangle {
        id: rowBVLCounter
        x: -3
        width: 350
        height: 43
        color: "#161616"
        anchors.top: rowReserved3.bottom
        anchors.left: parent.left
        anchors.leftMargin: 50
        Rectangle {
            id: recReserved5
            y: 439
            width: 100
            height: 43
            color: "#000000"
            radius: 10
            visible: false
            anchors.left: txtBVLCounter.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 15
        }

        Text {
            id: txtBVLCounter
            y: 0
            width: 200
            height: 43
            color: "#ffffff"
            text: qsTr("0")
            horizontalAlignment: Text.AlignLeft
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 0
            font.pixelSize: 25
        }
        anchors.topMargin: 10
    }

    onActiveChanged : {
        if ( true === vcuDigital.active ) {
        vcuDigital.qmlSignalActive("VCUDigital");
    }
    }

}





/*##^## Designer {
    D{i:33;anchors_y:364}
}
 ##^##*/
