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
    id: dcDc

    // ( https://goo.gl/LWbdMG )
    objectName: "dcDcWindow"

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
    property alias window: dcDc
    flags: Qt.FramelessWindowHint
    title: "DCDC"

    // Property names must begin with a lower case letter
    // and can only contain letters ( https://goo.gl/HzLQet )
    //
    //property string batteryPackName
    signal qmlSignal(string msg)
    signal qmlSignalActive(string msg)

    function updateMsg_DCDC_MSG00_Byte0To1(
	output_under, output_over, input_under, input_over,
	fault_f, w_mode, d_rating, input_oc, ot, output_oc ) {
	siInputUnderVoltage.active = ( 1 == input_under )?true:false;
	siInputOverVoltage.active = ( 1 == input_over )?true:false;
	siInputOverCurrent.active = ( 1 == input_oc )?true:false;
	siHardwareFaultFlag.active = ( 1 == fault_f )?true:false;
	// TODO: find out what input makes DCDC switch get opened/closed?
	switch ( w_mode ) {
	    case 1:
		imgInvtr.source
		    = "../../../images/0-color/dc2/dc2_operate.png";
	    break;
	    case 2:
		imgInvtr.source
		    = "../../../images/0-color/dc2/dc2_alert.png";
	    break;
	    default:
		imgInvtr.source
		    = "../../../images/0-color/dc2/dc2_idle.png";
	    break;
	}
	siOverTemperature.active = ( 1 == ot )?true:false;
	siOutputUnderVoltage.active = ( 1 == output_under )?true:false;
	siOutputOverVoltage.active = ( 1 == output_over )?true:false;
	siOutputOverCurrent.active = ( 1 == output_oc )?true:false;
	siPowerLimited.active = ( 1 == d_rating )?true:false;
    }

    function updateMsg_DCDC_MSG00_Byte1To7(real_oc, reality_t,
	real_ov, real_iv, dcdc_v ) {
	txtRealVoltageIn.text = real_iv;
	txtRealT.text = reality_t;
	txtRealOutCurrent.text = real_oc;
	txtRealOutVoltage.text = real_ov;
	txtDcdcVer.text = dcdc_v;
    }

    function updateBMS_VCU_MSG01(s_voltage,s_current,soc,b_status,
    f_level,mcntctr_nc,mcntctr_st,pcell_alrm,s_cremains) {
    txtMainVoltage.text = s_voltage;
    }

    function update_VCU_HMI_Msg_2_Byte_0_5(air_pressure,motor_temp,
    otank_temp2,v24) {
    txtV24.text = v24; /*parseFloat(Math.round(v24*10)/10).toFixed(1);*/
    }

    function update_VCU_HMI_Msg_2_Byte_6(air_unlock,
    passenger_unlock,emergency_unlock,wproff_unlock,
    ecas_unlock, isolation_abnormal_unlock,
    v24_carlock_unlock) {
    }

    Rectangle {
        id: rectangledcDc
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
                dcDc.hide();
            }
        }
    }

    Rectangle {
        id: rowdcDc
        x: 200
        y: 30
        width: 300
        height: 43
    color: "#161616"
        anchors.leftMargin: 50
        Text {
            id: txtdcDc
            y: 0
            width: 100
            height: 43
            color: "#ffffff"
            text: qsTr("DCDC")
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
        id: rowInputUnderVoltage
        width: 240
        height: 25
    color: "#161616"
        anchors.left: parent.left
        anchors.leftMargin: 150
        Text {
            id: txtInputUnderVoltage
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Input Under Voltage"
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siInputUnderVoltage.right
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siInputUnderVoltage
            y: 87
            width: 20
            height: 20
            active: false
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            color: "#ff0000"
        }
        anchors.topMargin: 50
        anchors.top: rowdcDc.bottom
    }

    Rectangle {
        id: rowInputOverVoltage
        x: -9
        y: -8
        width: 240
        height: 25
    color: "#161616"
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.top: rowInputUnderVoltage.bottom
        anchors.leftMargin: 150
        Text {
            id: txtInputOverVoltage
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Input Over Voltage"
            font.pixelSize: 15
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.left: siInputOverVoltage.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 20
        }

        StatusIndicator {
            id: siInputOverVoltage
            y: 87
            width: 20
            height: 20
            color: "#ff0000"
            active: false
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
        }
    }

    Rectangle {
        id: rowInputOverCurrent
        x: -6
        y: 0
        width: 240
        height: 25
    color: "#161616"
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.top: rowInputOverVoltage.bottom
        anchors.leftMargin: 150
        Text {
            id: txtInputOverCurrent
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Input Over Current"
            font.pixelSize: 15
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.left: siInputOverCurrent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 20
        }

        StatusIndicator {
            id: siInputOverCurrent
            y: 87
            width: 20
            height: 20
            color: "#ff0000"
            active: false
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
        }
    }

    Rectangle {
        id: rowOverTemperature
        x: 9
        y: 9
        width: 240
        height: 25
    color: "#161616"
        anchors.topMargin: 10
        anchors.left: rowInputOverVoltage.right
        anchors.top: rowHardwareFaultFlag.bottom
        anchors.leftMargin: 150
        Text {
            id: txtOverTemperature
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Over Temperature"
            font.pixelSize: 15
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.left: siOverTemperature.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 20
        }

        StatusIndicator {
            id: siOverTemperature
            y: 87
            width: 20
            height: 20
            color: "#ff0000"
            active: false
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
        }
    }

    Rectangle {
        id: rowHardwareFaultFlag
        x: 0
        y: 77
        width: 240
        height: 25
    color: "#161616"
        anchors.topMargin: 50
        anchors.left: rowInputUnderVoltage.right
        anchors.top: rowdcDc.bottom
        anchors.leftMargin: 150
        Text {
            id: txtHardwareFaultFlag
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Hardware Fault Flag"
            font.pixelSize: 15
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.left: siHardwareFaultFlag.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 20
        }

        StatusIndicator {
            id: siHardwareFaultFlag
            y: 87
            width: 20
            height: 20
            color: "#ff0000"
            active: false
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
        }
    }

    Rectangle {
        id: rowOutputUnderVoltage
        x: -6
        y: -6
        width: 240
        height: 25
    color: "#161616"
        anchors.topMargin: 50
        anchors.left: rowHardwareFaultFlag.right
        anchors.top: rowdcDc.bottom
        anchors.leftMargin: 150
        Text {
            id: txtOutputUnderVoltage
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Output Under Voltage"
            font.pixelSize: 15
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.left: siOutputUnderVoltage.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 20
        }

        StatusIndicator {
            id: siOutputUnderVoltage
            y: 87
            width: 20
            height: 20
            color: "#ff0000"
            active: false
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
        }
    }

    Rectangle {
        id: rowOutputOverVoltage
        x: -15
        y: -14
        width: 240
        height: 25
    color: "#161616"
        anchors.topMargin: 10
        anchors.left: rowOverTemperature.right
        anchors.top: rowOutputUnderVoltage.bottom
        anchors.leftMargin: 150
        Text {
            id: txtOutputOverVoltage
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Output Over Voltage"
            font.pixelSize: 15
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.left: siOutputOverVoltage.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 20
        }

        StatusIndicator {
            id: siOutputOverVoltage
            y: 87
            width: 20
            height: 20
            color: "#ff0000"
            active: false
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
        }
    }

    Rectangle {
        id: rowOutputOverCurrent
        x: -12
        y: 123
        width: 240
        height: 25
    color: "#161616"
        anchors.topMargin: 10
        anchors.left: rowOverTemperature.right
        anchors.top: rowOutputOverVoltage.bottom
        anchors.leftMargin: 150
        Text {
            id: txtOutputOverCurrent
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Output Over Current"
            font.pixelSize: 15
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.left: siOutputOverCurrent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 20
        }

        StatusIndicator {
            id: siOutputOverCurrent
            y: 87
            width: 20
            height: 20
            color: "#ff0000"
            active: false
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
        }
    }

    Rectangle {
        id: rowPowerLimited
        x: 9
        y: 6
        width: 240
        height: 25
    color: "#161616"
        anchors.topMargin: 10
        anchors.left: rowOverTemperature.right
        anchors.top: rowOutputOverCurrent.bottom
        anchors.leftMargin: 150
        Text {
            id: txtPowerLimited
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Power Limited"
            font.pixelSize: 15
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.left: siPowerLimited.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 20
        }

        StatusIndicator {
            id: siPowerLimited
            y: 87
            width: 20
            height: 20
            color: "#ff0000"
            active: false
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
        }
    }

    Rectangle {
        id: recReserved3
        y: 439
        width: 100
        height: 43
        color: "#000000"
        radius: 10
        border.color: "#ffffff"
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 150
        Text {
            id: txtMainVoltage
            y: 0
            width: 70
            height: 43
            color: "#ffffff"
            text: qsTr("")
            font.pixelSize: 25
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.verticalCenterOffset: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    Rectangle {
        id: recReserved4
        x: -4
        y: 443
        width: 100
        height: 43
        color: "#000000"
        radius: 10
        border.color: "#ffffff"
        anchors.left: recReserved3.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 100
        Text {
            id: txtRealVoltageIn
            y: 0
            width: 70
            height: 43
            color: "#ffffff"
            text: qsTr("")
            font.pixelSize: 25
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.verticalCenterOffset: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    Rectangle {
        id: recReserved5
        x: 590
        y: 434
        width: 100
        height: 43
        color: "#000000"
        radius: 10
        anchors.verticalCenterOffset: -79
        anchors.left: recReserved3.right
        anchors.verticalCenter: parent.verticalCenter
        border.color: "#ffffff"
        Text {
            id: txtRealT
            y: 0
            width: 70
            height: 43
            color: "#ffffff"
            text: qsTr("")
            anchors.verticalCenterOffset: 0
            font.pixelSize: 25
            anchors.horizontalCenter: parent.horizontalCenter
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignHCenter
        }
        anchors.leftMargin: 340
    }

    Rectangle {
        id: recReserved6
        y: 425
        width: 100
        height: 43
        color: "#000000"
        radius: 10
        Text {
            id: txtRealOutVoltage
            y: 0
            width: 70
            height: 43
            color: "#ffffff"
            text: qsTr("")
            font.pixelSize: 25
            horizontalAlignment: Text.AlignHCenter
            anchors.verticalCenterOffset: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            verticalAlignment: Text.AlignVCenter
        }
        border.color: "#ffffff"
        anchors.left: recReserved5.right
        anchors.verticalCenterOffset: -1
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 150
    }

    Rectangle {
        id: recReserved7
        width: 100
        height: 43
        color: "#000000"
        radius: 10
        anchors.top: recReserved6.bottom
        anchors.topMargin: 50
        Text {
            id: txtRealOutCurrent
            y: 0
            width: 70
            height: 43
            color: "#ffffff"
            text: qsTr("")
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 25
            anchors.verticalCenterOffset: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            verticalAlignment: Text.AlignVCenter
        }
        border.color: "#ffffff"
        anchors.left: recReserved5.right
        anchors.leftMargin: 150
    }

    Rectangle {
        id: recReserved8
        width: 100
        height: 43
        color: "#000000"
        radius: 10
        anchors.top: recReserved6.top
        anchors.topMargin: -80
        Text {
            id: txtV24
            y: 0
            width: 70
            height: 43
            color: "#ffffff"
            text: qsTr("")
            font.pixelSize: 25
            horizontalAlignment: Text.AlignHCenter
            anchors.verticalCenterOffset: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            verticalAlignment: Text.AlignVCenter
        }
        border.color: "#ffffff"
        anchors.left: recReserved6.right
        anchors.leftMargin: 120
    }

    Rectangle {
        id: rowDCDCVerCaption
        x: -4
        y: 675
        width: 150
        height: 43
        color: "#161616"
        anchors.right: recDCDCVer.left
        anchors.rightMargin: 0

        Text {
            id: txtDcDcVersionCaption
            x: 0
            y: 0
            width: 130
            height: 43
            color: "#ffffff"
            text: qsTr("DCDC Ver :")
            font.pixelSize: 25
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
        }
    }

    Rectangle {
        id: recDCDCVer
        x: 840
        y: 675
        width: 100
        height: 43
        color: "#000000"
        radius: 10
        Text {
            id: txtDcdcVer
            y: 0
            width: 70
            height: 43
            color: "#ffffff"
            text: qsTr("")
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 25
            anchors.verticalCenterOffset: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            verticalAlignment: Text.AlignVCenter
        }
        border.color: "#ffffff"
        anchors.left: recReserved5.right
        anchors.leftMargin: 150
    }

    Text {
        id: txtDcDcVersionCaption1
        y: 378
        width: 50
        height: 43
        color: "#ffffff"
        text: qsTr("V")
        anchors.verticalCenterOffset: 0
        anchors.left: recReserved3.right
        anchors.leftMargin: 5
        anchors.verticalCenter: recReserved3.verticalCenter
        font.pixelSize: 25
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
    }

    Text {
        id: txtDcDcVersionCaption2
        x: 454
        y: 378
        width: 50
        height: 43
        color: "#ffffff"
        text: qsTr("V")
        horizontalAlignment: Text.AlignLeft
        font.pixelSize: 25
        anchors.verticalCenter: recReserved3.verticalCenter
        verticalAlignment: Text.AlignVCenter
    }

    Text {
        id: txtDcDcVersionCaption3
        y: 379
        width: 50
        height: 43
        color: "#ffffff"
        text: qsTr("℃")
        anchors.verticalCenterOffset: -80
        anchors.left: recReserved5.right
        anchors.leftMargin: 5
        font.pixelSize: 25
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
        anchors.verticalCenter: recReserved3.verticalCenter
    }

    Window {
        id: dcDc1
        x: 2
        y: 7
        width: 1280
        height: 800
        color: "#161616"
        maximumWidth: width
        minimumHeight: height
        objectName: "dcDcWindow"
        title: "DCDC"
        Rectangle {
            id: rectangledcDc1
            color: "#d3d3d3"
            anchors.bottomMargin: 800
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.rightMargin: 1280
            anchors.topMargin: 0
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
        }

        Image {
            id: imageBack1
            x: 0
            width: 100
            height: 100
            z: 1
            MouseArea {
                id: mouseArea1
                z: 2
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.right: parent.right
            }

            MouseArea {
                id: maBack1
                z: 2
                anchors.fill: parent
            }
            source: "../../../images/0-color/HMI-ICON-55.png"
            fillMode: Image.PreserveAspectFit
            anchors.top: parent.top
            anchors.rightMargin: 0
            anchors.topMargin: 0
            anchors.right: parent.right
        }

        Rectangle {
            id: rowdcDc1
            x: 200
            y: 30
            width: 300
            height: 43
        color: "#161616"
            Text {
                id: txtdcDc1
                y: 0
                width: 100
                height: 43
                color: "#ffffff"
                text: qsTr("DCDC")
                anchors.verticalCenterOffset: 0
                anchors.leftMargin: 0
                font.pixelSize: 25
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
            }
            anchors.leftMargin: 50
            anchors.topMargin: 200
            anchors.left: parent.left
        }

        Row {
            id: rowInstantMessage1
            x: 152
            width: 1280
            height: 50
            objectName: "instantMessage"
            anchors.bottomMargin: 5
            Rectangle {
                id: recMessage1
                x: 0
                y: 0
                width: 1280
                height: 50
                color: "#1f1f1f"
                anchors.bottom: parent.bottom
            }
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
        }

        Rectangle {
            id: rowInputUnderVoltage1
            width: 240
            height: 25
        color: "#161616"
            Text {
                id: txtInputUnderVoltage1
                y: 0
                width: 180
                height: 20
                color: "#ffffff"
                text: "Input Under Voltage"
                anchors.leftMargin: 20
                font.pixelSize: 15
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                anchors.left: siInputUnderVoltage1.right
                anchors.verticalCenter: parent.verticalCenter
            }

            StatusIndicator {
                id: siInputUnderVoltage1
                y: 87
                width: 20
                height: 20
                color: "#ffffff"
                anchors.leftMargin: 0
                active: false
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
            }
            anchors.leftMargin: 150
            anchors.topMargin: 50
            anchors.left: parent.left
        }

        Rectangle {
            id: rowInputOverVoltage1
            x: -9
            y: -8
            width: 240
            height: 25
        color: "#161616"
            Text {
                id: txtInputOverVoltage1
                y: 0
                width: 180
                height: 20
                color: "#ffffff"
                text: "Input Over Voltage"
                anchors.leftMargin: 20
                font.pixelSize: 15
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                anchors.left: siInputOverVoltage1.right
                anchors.verticalCenter: parent.verticalCenter
            }

            StatusIndicator {
                id: siInputOverVoltage1
                y: 87
                width: 20
                height: 20
                color: "#ffffff"
                anchors.leftMargin: 0
                active: false
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
            }
            anchors.leftMargin: 150
            anchors.top: rowInputUnderVoltage1.bottom
            anchors.topMargin: 10
            anchors.left: parent.left
        }

        Rectangle {
            id: rowInputOverCurrent1
            x: -6
            y: 0
            width: 240
            height: 25
        color: "#161616"
            Text {
                id: txtInputOverCurrent1
                y: 0
                width: 180
                height: 20
                color: "#ffffff"
                text: "Input Over Current"
                anchors.leftMargin: 20
                font.pixelSize: 15
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                anchors.left: siInputOverCurrent1.right
                anchors.verticalCenter: parent.verticalCenter
            }

            StatusIndicator {
                id: siInputOverCurrent1
                y: 87
                width: 20
                height: 20
                color: "#ffffff"
                anchors.leftMargin: 0
                active: false
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
            }
            anchors.leftMargin: 150
            anchors.top: rowInputOverVoltage1.bottom
            anchors.topMargin: 10
            anchors.left: parent.left
        }

        Rectangle {
            id: rowOverTemperature1
            x: 9
            y: 9
            width: 240
            height: 25
        color: "#161616"
            Text {
                id: txtOverTemperature1
                y: 0
                width: 180
                height: 20
                color: "#ffffff"
                text: "Over Temperature"
                anchors.leftMargin: 20
                font.pixelSize: 15
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                anchors.left: siOverTemperature1.right
                anchors.verticalCenter: parent.verticalCenter
            }

            StatusIndicator {
                id: siOverTemperature1
                y: 87
                width: 20
                height: 20
                color: "#ffffff"
                anchors.leftMargin: 0
                active: false
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
            }
            anchors.leftMargin: 150
            anchors.top: rowHardwareFaultFlag1.bottom
            anchors.topMargin: 10
            anchors.left: rowInputOverVoltage1.right
        }

        Rectangle {
            id: rowHardwareFaultFlag1
            x: 0
            y: 77
            width: 240
            height: 25
        color: "#161616"
            Text {
                id: txtHardwareFaultFlag1
                y: 0
                width: 180
                height: 20
                color: "#ffffff"
                text: "Hardware Fault Flag"
                anchors.leftMargin: 20
                font.pixelSize: 15
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                anchors.left: siHardwareFaultFlag1.right
                anchors.verticalCenter: parent.verticalCenter
            }

            StatusIndicator {
                id: siHardwareFaultFlag1
                y: 87
                width: 20
                height: 20
                color: "#ffffff"
                anchors.leftMargin: 0
                active: false
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
            }
            anchors.leftMargin: 150
            anchors.topMargin: 50
            anchors.left: rowInputUnderVoltage1.right
        }

        Rectangle {
            id: rowOutputUnderVoltage1
            x: -6
            y: -6
            width: 240
            height: 25
        color: "#161616"
            Text {
                id: txtOutputUnderVoltage1
                y: 0
                width: 180
                height: 20
                color: "#ffffff"
                text: "Output Under Voltage"
                anchors.leftMargin: 20
                font.pixelSize: 15
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                anchors.left: siOutputUnderVoltage1.right
                anchors.verticalCenter: parent.verticalCenter
            }

            StatusIndicator {
                id: siOutputUnderVoltage1
                y: 87
                width: 20
                height: 20
                color: "#ffffff"
                anchors.leftMargin: 0
                active: false
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
            }
            anchors.leftMargin: 150
            anchors.topMargin: 50
            anchors.left: rowHardwareFaultFlag1.right
        }

        Rectangle {
            id: rowOutputOverVoltage1
            x: -15
            y: -14
            width: 240
            height: 25
        color: "#161616"
            Text {
                id: txtOutputOverVoltage1
                y: 0
                width: 180
                height: 20
                color: "#ffffff"
                text: "Output Over Voltage"
                anchors.leftMargin: 20
                font.pixelSize: 15
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                anchors.left: siOutputOverVoltage1.right
                anchors.verticalCenter: parent.verticalCenter
            }

            StatusIndicator {
                id: siOutputOverVoltage1
                y: 87
                width: 20
                height: 20
                color: "#ffffff"
                anchors.leftMargin: 0
                active: false
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
            }
            anchors.leftMargin: 150
            anchors.top: rowOutputUnderVoltage1.bottom
            anchors.topMargin: 10
            anchors.left: rowOverTemperature1.right
        }

        Rectangle {
            id: rowOutputOverCurrent1
            x: -12
            y: 123
            width: 240
            height: 25
        color: "#161616"
            Text {
                id: txtOutputOverCurrent1
                y: 0
                width: 180
                height: 20
                color: "#ffffff"
                text: "Output Over Current"
                anchors.leftMargin: 20
                font.pixelSize: 15
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                anchors.left: siOutputOverCurrent1.right
                anchors.verticalCenter: parent.verticalCenter
            }

            StatusIndicator {
                id: siOutputOverCurrent1
                y: 87
                width: 20
                height: 20
                color: "#ffffff"
                anchors.leftMargin: 0
                active: false
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
            }
            anchors.leftMargin: 150
            anchors.top: rowOutputOverVoltage1.bottom
            anchors.topMargin: 10
            anchors.left: rowOverTemperature1.right
        }

        Rectangle {
            id: rowPowerLimited1
            x: 9
            y: 6
            width: 240
            height: 25
        color: "#161616"
            Text {
                id: txtPowerLimited1
                y: 0
                width: 180
                height: 20
                color: "#ffffff"
                text: "PowerLimited"
                anchors.leftMargin: 20
                font.pixelSize: 15
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                anchors.left: siPowerLimited1.right
                anchors.verticalCenter: parent.verticalCenter
            }

            StatusIndicator {
                id: siPowerLimited1
                y: 87
                width: 20
                height: 20
                color: "#ffffff"
                anchors.leftMargin: 0
                active: false
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
            }
            anchors.leftMargin: 150
            anchors.top: rowOutputOverCurrent1.bottom
            anchors.topMargin: 10
            anchors.left: rowOverTemperature1.right
        }

        Rectangle {
            id: recReserved9
            y: 439
            width: 100
            height: 43
            color: "#000000"
            radius: 10
            Text {
                id: txtReserved9
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("")
                anchors.verticalCenterOffset: 0
                font.pixelSize: 25
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
            }
            anchors.leftMargin: 150
            anchors.left: parent.left
            border.color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
        }

        Rectangle {
            id: recReserved10
            x: -4
            y: 443
            width: 100
            height: 43
            color: "#000000"
            radius: 10
            Text {
                id: txtReserved10
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("")
                anchors.verticalCenterOffset: 0
                font.pixelSize: 25
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
            }
            anchors.leftMargin: 100
            anchors.left: recReserved9.right
            border.color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
        }

        Rectangle {
            id: recReserved11
            x: 590
            y: 434
            width: 100
            height: 43
            color: "#000000"
            radius: 10
            anchors.verticalCenterOffset: 1
            Text {
                id: txtReserved11
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("")
                anchors.verticalCenterOffset: 0
                font.pixelSize: 25
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
            }
            anchors.leftMargin: 340
            anchors.left: recReserved9.right
            border.color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
        }

        Rectangle {
            id: recReserved12
            y: 425
            width: 100
            height: 43
            color: "#000000"
            radius: 10
            anchors.verticalCenterOffset: 1
            Text {
                id: txtReserved12
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("")
                anchors.verticalCenterOffset: 0
                font.pixelSize: 25
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
            }
            anchors.leftMargin: 150
            anchors.left: recReserved11.right
            border.color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
        }

        Rectangle {
            id: recReserved13
            width: 100
            height: 43
            color: "#000000"
            radius: 10
            Text {
                id: txtReserved13
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("")
                anchors.verticalCenterOffset: 0
                font.pixelSize: 25
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
            }
            anchors.leftMargin: 150
            anchors.top: recReserved12.bottom
            anchors.topMargin: 50
            anchors.left: recReserved11.right
            border.color: "#ffffff"
        }

        Rectangle {
            id: recReserved14
            width: 100
            height: 43
            color: "#000000"
            radius: 10
            Text {
                id: txtReserved14
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("")
                anchors.verticalCenterOffset: 0
                font.pixelSize: 25
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
            }
            anchors.leftMargin: 120
            anchors.top: recReserved12.top
            anchors.topMargin: -80
            anchors.left: recReserved12.right
            border.color: "#ffffff"
        }

        Row {
            id: rowDCDCVerCaption1
            x: -4
            width: 150
            height: 43
            anchors.top: recDCDCVer1.top
            anchors.rightMargin: 70
            anchors.topMargin: 0
            anchors.right: recDCDCVer1.right
        }

        Rectangle {
            id: recDCDCVer1
            y: 675
            width: 100
            height: 43
            color: "#000000"
            radius: 10
            Text {
                id: txtDcdcVer1
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("")
                anchors.verticalCenterOffset: 0
                font.pixelSize: 25
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
            }
            anchors.leftMargin: 670
            anchors.left: rowInputOverVoltage1.right
            border.color: "#ffffff"
        }

        Text {
            id: txtDcDcVersionCaption5
            y: 378
            width: 50
            height: 43
            color: "#ffffff"
            text: qsTr("V")
            anchors.verticalCenterOffset: 0
            anchors.leftMargin: 5
            font.pixelSize: 25
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.left: recReserved9.right
            anchors.verticalCenter: recReserved9.verticalCenter
        }

        Text {
            id: txtDcDcVersionCaption6
            x: 454
            y: 378
            width: 50
            height: 43
            color: "#ffffff"
            text: qsTr("V")
            font.pixelSize: 25
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: recReserved9.verticalCenter
        }

        Text {
            id: txtDcDcVersionCaption7
            y: 379
            width: 50
            height: 43
            color: "#ffffff"
            text: qsTr("℃")
            anchors.leftMargin: 5
            font.pixelSize: 25
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.left: recReserved11.right
            anchors.verticalCenter: recReserved9.verticalCenter
        }
        flags: Qt.FramelessWindowHint
        minimumWidth: width
        maximumHeight: height
    }

    Text {
        id: txtDcDcVersionCaption8
        y: 379
        width: 50
        height: 43
        color: "#ffffff"
        text: qsTr("V")
        anchors.verticalCenterOffset: -2
        anchors.left: recReserved6.right
        anchors.leftMargin: 5
        horizontalAlignment: Text.AlignLeft
        anchors.verticalCenter: recReserved6.verticalCenter
        font.pixelSize: 25
        verticalAlignment: Text.AlignVCenter
    }

    Text {
        id: txtDcDcVersionCaption9
        y: 472
        width: 50
        height: 43
        color: "#ffffff"
        text: qsTr("A")
        anchors.left: recReserved7.right
        anchors.leftMargin: 5
        horizontalAlignment: Text.AlignLeft
        anchors.verticalCenter: recReserved7.verticalCenter
        font.pixelSize: 25
        verticalAlignment: Text.AlignVCenter
    }

    Text {
        id: txtDcDcVersionCaption10
        y: 299
        width: 50
        height: 43
        color: "#ffffff"
        text: qsTr("V")
        horizontalAlignment: Text.AlignLeft
        anchors.verticalCenter: recReserved8.verticalCenter
        anchors.left: recReserved8.right
        anchors.leftMargin: 5
        font.pixelSize: 25
        verticalAlignment: Text.AlignVCenter
    }

    Image {
        id: imgSwitch
        x: 137
        y: 451
        width: 350
        height: 90
        sourceSize.height: 102
        sourceSize.width: 429
        source: "../../../images/0-color/dc2/dcdc_open.png"
        fillMode: Image.PreserveAspectCrop
    }

    Image {
        id: imgInvtr
        x: 540
        y: 362
        width: 200
        height: 180
        sourceSize.height: 267
        sourceSize.width: 267
        source: "../../../images/0-color/dc2/dc2_idle.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imgWiring
        x: 841
        y: 402
        width: 100
        height: 100
        source: "../../../images/0-color/dc2/bms_wiring.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imgBattery
        x: 1020
        y: 393
        width: 180
        height: 120
        sourceSize.height: 165
        sourceSize.width: 210
        source: "../../../images/0-color/dc2/dc2_battery.png"
        fillMode: Image.PreserveAspectFit
    }

    onActiveChanged : {
        if ( true === dcDc.active ) {
        dcDc.qmlSignalActive("DCDC");
    }
    }

}









































/*##^## Designer {
    D{i:49;anchors_width:130;anchors_x:"-10"}
}
 ##^##*/
