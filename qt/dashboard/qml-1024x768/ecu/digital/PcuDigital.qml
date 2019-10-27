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
import "../../style"

Window {
    id: pcuDigital

    // ( https://goo.gl/LWbdMG )
    objectName: "pcuDigitalWindow"

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
    property alias window: pcuDigital
    flags: Qt.FramelessWindowHint
    title: "PCU IO (Digital)"

    // Property names must begin with a lower case letter
    // and can only contain letters ( https://goo.gl/HzLQet )
    //
    //property string batteryPackName
    signal qmlSignal(string msg)
    signal qmlSignalActive(string msg)

    function updateMsg_PCUIO_SIG00_Byte2To7(dlta, inlet_t, outlet_t,
    pedal_depth, pcu_lc) {
    //console.debug("updateMsg_PCUIO_SIG00_Byte2To7");
    txtPressureGaugeDelta.text = dlta;
    txtOutletTemperature.text = outlet_t;
    txtInletTemperature.text = inlet_t;
    txtAcceleratorPedalDepth.text = pedal_depth;
    txtPCULiveCounter.text = pcu_lc;
    }

    Rectangle {
        id: recpcuDigital
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
                pcuDigital.hide();
            }
        }
    }

    Rectangle {
        id: rowpcuDigital
        x: 200
        y: 30
        width: 300
        height: 43
    color: "#161616"
        anchors.leftMargin: 50
        Text {
            id: txtpcuDigital
            y: 0
            width: 100
            height: 43
            color: "#ffffff"
            text: qsTr("PCU IO (Digital)")
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
        id: rowPressureGaugeDelta
        x: -4
        width: 450
        height: 43
    color: "#161616"
        anchors.leftMargin: 50
        anchors.left: parent.left
        Rectangle {
            id: recPressureGaugeDelta
            y: 439
            width: 100
            height: 43
            color: "#000000"
            radius: 10
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 20
            anchors.left: txtPressureGaugeDeltaCaption.right
            Text {
                id: txtPressureGaugeDelta
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
            id: txtPressureGaugeDeltaCaption
            y: 0
            width: 300
            height: 43
            color: "#ffffff"
            text: qsTr("Pressure Gauge Delta :")
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            verticalAlignment: Text.AlignVCenter
            anchors.left: parent.left
            font.pixelSize: 25
            horizontalAlignment: Text.AlignLeft
        }
        anchors.topMargin: 10
        anchors.top: rowpcuDigital.bottom
    }

    Rectangle {
        id: rowOutletTemperature
        x: -9
        width: 450
        height: 43
    color: "#161616"
        anchors.leftMargin: 50
        anchors.left: parent.left
        Rectangle {
            id: recOutletTemperature
            y: 439
            width: 100
            height: 43
            color: "#000000"
            radius: 10
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 20
            anchors.left: txtOutletTemperatureCaption.right
            Text {
                id: txtOutletTemperature
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
            id: txtOutletTemperatureCaption
            y: 0
            width: 300
            height: 43
            color: "#ffffff"
            text: qsTr("Outlet Temperature :")
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            verticalAlignment: Text.AlignVCenter
            anchors.left: parent.left
            font.pixelSize: 25
            horizontalAlignment: Text.AlignLeft
        }
        anchors.topMargin: 10
        anchors.top: rowPressureGaugeDelta.bottom
    }

    Rectangle {
        id: rowInletTemperature
        x: -6
        width: 450
        height: 43
    color: "#161616"
        anchors.leftMargin: 50
        anchors.left: parent.left
        Rectangle {
            id: recInletTemperature
            y: 439
            width: 100
            height: 43
            color: "#000000"
            radius: 10
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 20
            anchors.left: txtInletTemperatureCaption.right
            Text {
                id: txtInletTemperature
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
            id: txtInletTemperatureCaption
            y: 0
            width: 300
            height: 43
            color: "#ffffff"
            text: qsTr("Inlet Temperature :")
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            verticalAlignment: Text.AlignVCenter
            anchors.left: parent.left
            font.pixelSize: 25
            horizontalAlignment: Text.AlignLeft
        }
        anchors.topMargin: 10
        anchors.top: rowOutletTemperature.bottom
    }

    Rectangle {
        id: rowAcceleratorPedalDepth
        x: 3
        width: 450
        height: 43
    color: "#161616"
        anchors.leftMargin: 50
        anchors.left: parent.left
        Rectangle {
            id: recAcceleratorPedalDepth
            y: 439
            width: 100
            height: 43
            color: "#000000"
            radius: 10
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 20
            anchors.left: txtAcceleratorPedalDepthCaption.right
            Text {
                id: txtAcceleratorPedalDepth
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
            id: txtAcceleratorPedalDepthCaption
            y: 0
            width: 300
            height: 43
            color: "#ffffff"
            text: qsTr("Accelerator Pedal Depth :")
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            verticalAlignment: Text.AlignVCenter
            anchors.left: parent.left
            font.pixelSize: 25
            horizontalAlignment: Text.AlignLeft
        }
        anchors.topMargin: 10
        anchors.top: rowInletTemperature.bottom
    }

    Rectangle {
        id: rowReserved3
        x: -1
        y: -4
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
            anchors.leftMargin: 20
            anchors.left: txtReservedCaption3.right
            Text {
                id: txtReserved3
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
        anchors.top: rowAcceleratorPedalDepth.bottom
    }

    Rectangle {
        id: rowP4KeyOnContractor
        x: 50
        y: 354
        width: 450
        height: 43
        color: "#161616"
        Text {
            id: txtPCULiveCounter
            y: 0
            width: 200
            height: 43
            color: "#ffffff"
            text: qsTr("0")
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.leftMargin: 15
            font.pixelSize: 25
        }
        anchors.leftMargin: 50
        anchors.topMargin: 10
    }

    onActiveChanged : {
    if ( true === pcuDigital.active ) {
        pcuDigital.qmlSignalActive("PCUDigital");
    }
    }

}















/*##^## Designer {
    D{i:13;anchors_x:"-10"}D{i:10;anchors_y:"-4"}D{i:20;anchors_x:0}D{i:21;anchors_x:"-10";anchors_y:"-8"}
D{i:24;anchors_x:0}D{i:25;anchors_x:"-10";anchors_y:7}D{i:28;anchors_x:0}D{i:29;anchors_x:"-10";anchors_y:"-6"}
}
 ##^##*/
