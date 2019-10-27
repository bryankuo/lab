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
import QtQuick.Controls 2.4
import "../../style"

Window {
    id: bmsDigital

    // ( https://goo.gl/LWbdMG )
    objectName: "bmsDigitalWindow"

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
    property alias window: bmsDigital
    flags: Qt.FramelessWindowHint
    title: "BMS (Digital)"

    // Property names must begin with a lower case letter
    // and can only contain letters ( https://goo.gl/HzLQet )
    //
    //property string batteryPackName
    signal qmlSignal(string msg)
    signal qmlSignalActive(string msg)

    function updateBMS_VCU_MSG01(s_voltage,s_current,soc,b_status,
	f_level,mcntctr_nc,mcntctr_st,pcell_alrm,s_cremains) {
	txtVoltageValue.text = s_voltage;
	txtCurrentValue.text = s_current;
	txtSOCValue.text = soc;
    }

    function updateBMS_VCU_MSG02(s_cmaxv,cell_maxi,s_cminv,cell_mini,
	s_cdiffv) {
	txtMaxCellVoltageVal.text = s_cmaxv;
	txtMaxLocationVal.text = cell_maxi;
	txtMinCellVoltageVal.text = s_cminv;
	txtMinLocationVal.text = cell_mini;
    }

    function updateBMS_VCU_MSG04(chg_state, battery_type,
	s_ri_voltage, bms_code) {
	//console.debug("updateBMS_VCU_MSG04(BD) "
	//    +chg_state+", "+battery_type+", "+s_ri_voltag+", "+bms_code);
	txtBMSErrValue.text = bms_code;
    }

    function updateMsg_BCU_ER_MSG01(s_bcu_alarm_lcounter,
    bms_ierr, vsam_err, tsam_err, ccom_err, cer_err, chot, ch_scerr, ch_wcerr) {
	txtBMSLiveValue.text = s_bcu_alarm_lcounter;
    }

    Rectangle {
        id: recBmsDigital
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
                bmsDigital.hide();
            }
        }
    }

    Rectangle {
        id: rowBMS
        x: 200
        y: 30
        width: 300
        height: 43
        color: "#161616"
        anchors.leftMargin: 50
        Text {
            id: txtBmsDigital
            y: 0
            width: 100
            height: 43
            color: "#ffffff"
            text: qsTr("BMS (Digital)")
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 25
            horizontalAlignment: Text.AlignLeft
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
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
        id: rowVoltage
        x: 0
        width: 450
        height: 43
        color: "#161616"
        Rectangle {
            id: recVoltage
            y: 439
            width: 100
            height: 43
            color: "#000000"
            radius: 10
            anchors.verticalCenter: parent.verticalCenter
            Text {
                id: txtVoltageValue
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("")
                font.pixelSize: 25
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 0
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
            anchors.leftMargin: 20
            anchors.left: txtVoltage.right
        }

        Text {
            id: txtVoltage
            y: 0
            width: 300
            height: 43
            color: "#ffffff"
            text: qsTr("Voltage :")
            font.pixelSize: 25
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 0
            anchors.left: parent.left
        }
        anchors.top: rowBMSErr.bottom
        anchors.topMargin: 10
        anchors.leftMargin: 50
        anchors.left: parent.left
    }

    Rectangle {
        id: rowCurrent
        x: 0
        y: 0
        width: 450
        height: 43
        color: "#161616"
        Rectangle {
            id: recCurrent
            y: 439
            width: 100
            height: 43
            color: "#000000"
            radius: 10
            anchors.verticalCenter: parent.verticalCenter
            Text {
                id: txtCurrentValue
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("")
                font.pixelSize: 25
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 0
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
            anchors.leftMargin: 20
            anchors.left: txtCurrent.right
        }

        Text {
            id: txtCurrent
            y: 0
            width: 300
            height: 43
            color: "#ffffff"
            text: qsTr("Current :")
            font.pixelSize: 25
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 0
            anchors.left: parent.left
        }
        anchors.top: rowVoltage.bottom
        anchors.topMargin: 10
        anchors.leftMargin: 50
        anchors.left: parent.left
    }

    Rectangle {
        id: rowMaxCellVoltage
        x: 2
        y: 2
        width: 450
        height: 43
        color: "#161616"
        Rectangle {
            id: recMaxCellVoltage
            y: 439
            width: 100
            height: 43
            color: "#000000"
            radius: 10
            anchors.verticalCenter: parent.verticalCenter
            Text {
                id: txtMaxCellVoltageVal
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("")
                font.pixelSize: 25
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 0
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
            anchors.leftMargin: 20
            anchors.left: txtMaxCellVoltage.right
        }

        Text {
            id: txtMaxCellVoltage
            y: 0
            width: 300
            height: 43
            color: "#ffffff"
            text: qsTr("Max Cell Voltage :")
            font.pixelSize: 25
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 0
            anchors.left: parent.left
        }
        anchors.top: rowSOC.bottom
        anchors.topMargin: 10
        anchors.leftMargin: 50
        anchors.left: parent.left
    }

    Rectangle {
        id: rowSOC
        x: 2
        y: 192
        width: 450
        height: 43
        color: "#161616"
        Rectangle {
            id: recSOC
            y: 439
            width: 100
            height: 43
            color: "#000000"
            radius: 10
            anchors.verticalCenter: parent.verticalCenter
            Text {
                id: txtSOCValue
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("")
                font.pixelSize: 25
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 0
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
            anchors.leftMargin: 20
            anchors.left: txtSOC.right
        }

        Text {
            id: txtSOC
            y: 0
            width: 300
            height: 43
            color: "#ffffff"
            text: qsTr("SOC :")
            font.pixelSize: 25
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 0
            anchors.left: parent.left
        }
        anchors.top: rowCurrent.bottom
        anchors.topMargin: 10
        anchors.leftMargin: 50
        anchors.left: parent.left
    }

    Rectangle {
        id: rowMaxLocation
        x: 9
        width: 450
        height: 43
        color: "#161616"
        Rectangle {
            id: recMaxLocation
            y: 439
            width: 100
            height: 43
            color: "#000000"
            radius: 10
            anchors.verticalCenter: parent.verticalCenter
            Text {
                id: txtMaxLocationVal
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("")
                font.pixelSize: 25
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 0
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
            anchors.leftMargin: 20
            anchors.left: txtMaxLocation.right
        }

        Text {
            id: txtMaxLocation
            y: 0
            width: 300
            height: 43
            color: "#ffffff"
            text: qsTr("Location :")
            font.pixelSize: 25
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 0
            anchors.left: parent.left
        }
        anchors.top: rowMaxCellVoltage.bottom
        anchors.topMargin: 10
        anchors.leftMargin: 50
        anchors.left: parent.left
    }

    Rectangle {
        id: rowMinCellVoltage
        x: -4
        y: -4
        width: 450
        height: 43
        color: "#161616"
        Rectangle {
            id: recMinCellVoltage
            y: 439
            width: 100
            height: 43
            color: "#000000"
            radius: 10
            anchors.verticalCenter: parent.verticalCenter
            Text {
                id: txtMinCellVoltageVal
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("")
                font.pixelSize: 25
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 0
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
            anchors.leftMargin: 20
            anchors.left: txtMinCellVoltage.right
        }

        Text {
            id: txtMinCellVoltage
            y: 0
            width: 300
            height: 43
            color: "#ffffff"
            text: qsTr("Min Cell Voltage :")
            font.pixelSize: 25
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 0
            anchors.left: parent.left
        }
        anchors.top: rowMaxLocation.bottom
        anchors.topMargin: 10
        anchors.leftMargin: 50
        anchors.left: parent.left
    }

    Rectangle {
        id: rowMinLocation
        x: 3
        y: 407
        width: 450
        height: 43
        color: "#161616"
        Rectangle {
            id: recMinLocation
            y: 439
            width: 100
            height: 43
            color: "#000000"
            radius: 10
            anchors.verticalCenter: parent.verticalCenter
            Text {
                id: txtMinLocationVal
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("")
                font.pixelSize: 25
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 0
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
            anchors.leftMargin: 20
            anchors.left: txtMinLocation.right
        }

        Text {
            id: txtMinLocation
            y: 0
            width: 300
            height: 43
            color: "#ffffff"
            text: qsTr("Location :")
            font.pixelSize: 25
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 0
            anchors.left: parent.left
        }
        anchors.top: rowMinCellVoltage.bottom
        anchors.topMargin: 10
        anchors.leftMargin: 50
        anchors.left: parent.left
    }

    Rectangle {
        id: rowBMSLive
        x: 0
        y: 83
        width: 450
        height: 43
        color: "#161616"
        Rectangle {
            id: recBMSLive
            y: 439
            width: 100
            height: 43
            color: "#000000"
            radius: 10
            anchors.verticalCenter: parent.verticalCenter
            Text {
                id: txtBMSLiveValue
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("")
                font.pixelSize: 25
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 0
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
            anchors.leftMargin: 20
            anchors.left: txtBMSLive.right
        }

        Text {
            id: txtBMSLive
            y: 0
            width: 300
            height: 43
            color: "#ffffff"
            text: qsTr("BMS Live :")
            font.pixelSize: 25
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 0
            anchors.left: parent.left
        }
        anchors.top: rowBMS.bottom
        anchors.topMargin: 10
        anchors.leftMargin: 50
        anchors.left: parent.left
    }

    Rectangle {
        id: rowBMSErr
        x: -4
        y: 87
        width: 450
        height: 43
        color: "#161616"
        Rectangle {
            id: recBMSErr
            y: 439
            width: 100
            height: 43
            color: "#000000"
            radius: 10
            anchors.verticalCenter: parent.verticalCenter
            Text {
                id: txtBMSErrValue
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("")
                font.pixelSize: 25
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 0
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
            anchors.leftMargin: 20
            anchors.left: txtBMSErr.right
        }

        Text {
            id: txtBMSErr
            y: 0
            width: 300
            height: 43
            color: "#ffffff"
            text: qsTr("BMS Error :")
            font.pixelSize: 25
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 0
            anchors.left: parent.left
        }
        anchors.top: rowBMSLive.bottom
        anchors.topMargin: 10
        anchors.leftMargin: 50
        anchors.left: parent.left
    }

    onActiveChanged : {
    if ( true === bmsDigital.active ) {
        bmsDigital.qmlSignalActive("BmsDigital");
    }
    }

}























/*##^## Designer {
    D{i:25;anchors_y:11}D{i:33;anchors_y:11}
}
 ##^##*/
