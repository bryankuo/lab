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
import "style"

Window {
    id: diagnose

    // ( https://goo.gl/LWbdMG )
    objectName: "diagnoseWindow"

    Styles { id: style }

    // QML - main window position on start (screen center)
    // ( https://goo.gl/wLpvZD )
    width: style.resolutionWidth
    height: style.resolutionHeight
    maximumHeight: height
    maximumWidth: width
    x: 0
    y: 0

    minimumHeight: height
    minimumWidth: width
    color: "#161616"
    property alias window: diagnose
    flags: Qt.FramelessWindowHint
    title: "diagnose"

    // Property names must begin with a lower case letter
    // and can only contain letters ( https://goo.gl/HzLQet )
    //
    //property string batteryPackName
    signal qmlSignalActive(string msg)
    signal qmlSignalCalibrate(string msg)
    signal qmlSignalZero(string msg)

    function tickGSensor(x, y, z, pitch, roll, yaw, cali, zero_p) {
    txtXValue.text = x;
    txtYValue.text = y;
    txtZValue.text = z;
    txtPitchVal.text = pitch;
    //txtRollVal.text = roll;
    //txtYawVal.text = yaw;
    }

    function tickGPS(lat, dir_lat, lon, dir_lon) {
    txtLatitudeReading.text = lat+" "+dir_lat;
    txtLongitudeReading.text = lon+" "+dir_lon;
    }

    function updateMsg_BMS_VCU_Msg03(max_pt_temp, max_pt_idx,
    charger_cc2,charger_conn1,charger_conn2,bms_pr_state,
    mctr_state, mi_ctr_state, frelay_state, s_bms_lcounter) {
    //console.log(max_pt_temp+','+max_pt_idx+','+charger_cc2+','+charger_conn1+','+charger_conn2+','+bms_pr_state+','+mctr_state+','+mi_ctr_state+','+frelay_state+','+l_counter);

    txtLcBV03.text = s_bms_lcounter;
    }

    function updateMsg_PCUIO_SIG00(s_pcu_lcounter) {
    txtLcPCU.text = s_pcu_lcounter;
    }

    function updateMsg_BCU_VCU_MSG0(abs_alarm, fl_lining, fr_lining,
    rl_lining, rr_lining, ecas33f, ecas_kneeling, ecas34w,
    s_bcu2vcu_lcounter) {
    txtLcBV20.text = s_bcu2vcu_lcounter;
    }

    function updateMsg_BCU_ER_MSG01(s_bcu_alarm_lcounter,
    bms_ierr, vsam_err, tsam_err, ccom_err, cer_err, chot, ch_scerr, ch_wcerr) {
    txtLcBal93.text = s_bcu_alarm_lcounter;
    }

    function loadImei(s_imei) {
    txtIMEI.text = s_imei;
    }

    function updateMsg_PCUIO_SIG00_Byte2To7(dlta, inlet_t, outlet_t,
    pedal_depth, pcu_lc) {
    //console.debug("updateMsg_PCUIO_SIG00_Byte2To7");
    //txtAirPressureVal.text  = dlta;
    }

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
    }

    Image {
        id: imageDiagnoseBack
        x: 0
        width: 80
        height: 80
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
        source: "../images/0-color/HMI-ICON-55.png"
        fillMode: Image.PreserveAspectFit
        MouseArea {
            id: mouseAreaStatusBack
            width: 80
            height: 80
            z: 2
            anchors.fill: parent
            onClicked: {
                diagnose.hide();
            }
        }
    }

    Rectangle {
        id: rowGpsLatitude
        x: 300
        y: 200
        width: 230
        height: 43
        color: "#161616"
        anchors.leftMargin: 30

        Text {
            id: txtGpsLatCaption
            y: 0
            width: 100
            height: 30
            color: "#ffffff"
            text: qsTr("Latitude")
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.verticalCenterOffset: 0
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 20
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            MouseArea {
                height: 30
                anchors.fill: parent
                enabled: false
                hoverEnabled: false
            }
        }

        Rectangle {
            id: recGpsLatitude
            y: 379
            width: 100
            height: 43
            color: "#000000"
            radius: 10
            anchors.leftMargin: 120
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left

            Text {
                id: txtLatitudeReading
                y: 0
                width: 100
                height: 43
                color: "#ffffff"
                text: qsTr("0.0")
                anchors.horizontalCenter: parent.horizontalCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 15
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        //anchors.top: rowTop.bottom
        anchors.topMargin: 200
        anchors.left: parent.left
    }

    Rectangle {
        id: rowGpsLongitude
        x: 202
        y: 260
        width: 230
        height: 43
        color: "#161616"
        anchors.leftMargin: 30
        Text {
            id: txtGpsLongCaption
            y: 0
            width: 100
            height: 30
            color: "#ffffff"
            text: qsTr("Longitude")
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 20
            horizontalAlignment: Text.AlignLeft
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            MouseArea {
                anchors.fill: parent
                enabled: false
                hoverEnabled: false
            }
            anchors.left: parent.left
            anchors.verticalCenterOffset: 0
        }

        Rectangle {
            id: recGpsLatitude1
            y: 379
            width: 100
            height: 43
            color: "#000000"
            radius: 10
            anchors.leftMargin: 120
            anchors.verticalCenter: parent.verticalCenter
            Text {
                id: txtLongitudeReading
                y: 0
                width: 100
                height: 43
                color: "#ffffff"
                text: qsTr("0.0")
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 17
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
            anchors.left: parent.left
        }
        //anchors.top: rowTop.bottom
        anchors.topMargin: 200
        anchors.left: parent.left
    }

    Rectangle {
        id: rowGps
        y: 140
        width: 230
        height: 43
        color: "#161616"
        anchors.left: parent.left
        anchors.leftMargin: 30
        Text {
            id: txtGpsCaption
            y: 0
            width: 100
            height: 43
            color: "#ffffff"
            text: qsTr("GPS")
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
    }

    Rectangle {
        id: rowHeading
        x: 200
        width: 300
        height: 43
    color: "#161616"
        anchors.leftMargin: 50
        Text {
            id: txtPageCaption
            y: 0
            width: 100
            height: 43
            color: "#ffffff"
            text: qsTr("Hardware Diagnostics")
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
        anchors.top: parent.top
        anchors.topMargin: 50
        anchors.left: parent.left
    }

    Rectangle {
        id: rectangleEng2
        x: -4
        y: -4
        color: "#d3d3d3"
        anchors.leftMargin: 359
        anchors.rightMargin: 921
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: 4
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 796
    }

    Rectangle {
        id: rowGSensorX
        y: 200
        width: 300
        height: 43
    color: "#161616"
    anchors.left: rowGps.right
    anchors.leftMargin: 30
    Text {
        id: txtGSensorXCaption
            y: 0
            width: 100
            height: 43
            color: "#ffffff"
            text: qsTr("X")
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

        Rectangle {
            id: recGpsLatitude2
            y: 379
            width: 100
            height: 43
            color: "#000000"
            radius: 10
            anchors.leftMargin: 180
            anchors.verticalCenter: parent.verticalCenter
            Text {
                id: txtXValue
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("0.0")
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 25
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
            anchors.left: parent.left
        }
        //anchors.top: rowTop.bottom
        anchors.topMargin: 200
    }

    Rectangle {
        id: rowGSensorY
        y: 260
        width: 300
        height: 43
    color: "#161616"
    anchors.left: rowGps.right
    anchors.leftMargin: 30
    Text {
        id: txtGSensorYCaption
            y: 0
            width: 100
            height: 43
            color: "#ffffff"
            text: qsTr("Y")
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

        Rectangle {
            id: recGpsLatitude3
            y: 379
            width: 100
            height: 43
            color: "#000000"
            radius: 10
            anchors.leftMargin: 180
            anchors.verticalCenter: parent.verticalCenter
            Text {
                id: txtYValue
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("0.0")
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 25
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
            anchors.left: parent.left
        }
        //anchors.top: rowTop.bottom
        anchors.topMargin: 200
    }

    Rectangle {
        id: rowGSensor
        y: 140
        width: 300
        height: 43
    color: "#161616"
    anchors.left: rowGps.right
    anchors.leftMargin: 30
    Text {
        id: txtGSensorCaption
            y: 0
            width: 100
            height: 43
            color: "#ffffff"
            text: qsTr("G-Sensor")
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
    }

    Rectangle {
        id: rowGSensorZ
        y: 320
        width: 300
        height: 43
    color: "#161616"
    anchors.left: rowGps.right
    anchors.leftMargin: 30
    Text {
        id: txtGSensorZCaption
            y: 0
            width: 100
            height: 43
            color: "#ffffff"
            text: qsTr("Z")
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

        Rectangle {
            id: recGpsLatitude4
            y: 379
            width: 100
            height: 43
            color: "#000000"
            radius: 10
            anchors.leftMargin: 180
            anchors.verticalCenter: parent.verticalCenter
            Text {
                id: txtZValue
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("0.0")
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 25
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
            anchors.left: parent.left
        }
        //anchors.top: rowTop.bottom
        anchors.topMargin: 200
    }

    Rectangle {
        id: rowGSensorSlope
        y: 380
        width: 300
        height: 43
    color: "#161616"
    anchors.left: rowGps.right
    anchors.leftMargin: 30
    Text {
        id: txtSlopeCaption
            y: 0
            width: 100
            height: 43
            color: "#ffffff"
            text: qsTr("Slope")
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

        Rectangle {
            id: recGpsLatitude5
            y: 379
            width: 100
            height: 43
            color: "#000000"
            radius: 10
            anchors.leftMargin: 180
            anchors.verticalCenter: parent.verticalCenter
            Text {
                id: txtPitchVal
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("0.0")
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 25
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
            anchors.left: parent.left
        }
        //anchors.top: rowTop.bottom
        anchors.topMargin: 200
    }

    Rectangle {
        id: rowCaliZero
        y: 440
        width: 300
        height: 43
    color: "#161616"
    anchors.left: rowGps.right
    anchors.leftMargin: 30
    Text {
        id: txtCaliZCaption
            y: 0
            width: 100
            height: 43
            color: "#ffffff"
            text: qsTr("Calibrate to 0")
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

        Button {
            id: btnCali2Zero
            x: 0
            y: 0
            //width: 100
            //height: 43
            text: qsTr("RESET")
            anchors.leftMargin: 180
            anchors.left: txtCaliZCaption.left
            onClicked: {
                diagnose.qmlSignalCalibrate("Calibrate");
            }
        style: ButtonStyle {
        background: Rectangle {
            implicitWidth: 100
            implicitHeight: 43
            border.width: control.activeFocus ? 2 : 1
            border.color: "#888"
            radius: 4
            gradient: Gradient {
            GradientStop { position: 0 ; color: control.pressed ? "#ccc" : "#eee" }
            GradientStop { position: 1 ; color: control.pressed ? "#aaa" : "#ccc" }
            }
        }
        }        }
        //anchors.top: rowTop.bottom
        anchors.topMargin: 200
    }

    Rectangle {
        id: rowZeroP
        y: 500
        width: 300
        height: 43
    color: "#161616"
    anchors.left: rowGps.right
    anchors.leftMargin: 30
    Text {
        id: txtZeroPosCaption
            y: 0
            width: 100
            height: 43
            color: "#ffffff"
            text: qsTr("Zero Position")
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

        Button {
            id: btnZeroPos
            y: 0
            //width: 100
            //height: 43
            text: qsTr("RESET")
            anchors.leftMargin: 180
            anchors.left: parent.left
            onClicked: {
                diagnose.qmlSignalZero("Zero");
            }
            style: ButtonStyle {
                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 43
                    border.width: control.activeFocus ? 2 : 1
                    border.color: "#888"
                    radius: 4
                    gradient: Gradient {
                        GradientStop { position: 0 ; color: control.pressed ? "#ccc" : "#eee" }
                        GradientStop { position: 1 ; color: control.pressed ? "#aaa" : "#ccc" }
                    }
                }
            }
        }
        //anchors.top: rowTop.bottom
        anchors.topMargin: 200
    }

    Rectangle {
        id: rowCAN
        x: 30
        y: 569
        width: 300
        height: 43
    color: "#161616"
    Text {
        id: txtVCU
            y: 0
            width: 100
            height: 43
            color: "#ffffff"
            text: qsTr("CAN")
            anchors.left: parent.left
            anchors.verticalCenterOffset: 0
            MouseArea {
                width: 70
                height: 40
                hoverEnabled: false
                anchors.left: parent.left
                anchors.top: parent.top
            }
            anchors.leftMargin: 0
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 25
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
        }
        anchors.topMargin: 200
        //anchors.top: rowTop.bottom
    }

    Rectangle {
        id: rowLCounter
        x: 30
        y: 689
        width: 500
        height: 43
    color: "#161616"

        Text {
            id: txtVcuLiveCap1
            y: 0
            width: 145
            height: 43
            color: "#ffffff"
            text: qsTr("Live Counter")
            anchors.left: parent.left
            anchors.verticalCenterOffset: 0
            MouseArea {
                width: 70
                height: 40
                hoverEnabled: false
                anchors.left: parent.left
                anchors.top: parent.top
            }
            anchors.leftMargin: 0
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 25
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
        }

        Rectangle {
            id: recLiveCounter
            y: 379
            width: 70
            height: 43
            color: "#000000"
            radius: 10
            anchors.left: txtVcuLiveCap1.right
            Text {
                id: txtLcBV03
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("FF")
                anchors.horizontalCenter: parent.horizontalCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 25
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
            }
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
        }

        Rectangle {
            id: recLiveCounterV
            y: 379
            width: 70
            height: 43
            color: "#000000"
            radius: 10
            Text {
                id: txtLcPCU
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("FF")
                elide: Text.ElideLeft
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 25
                anchors.verticalCenter: parent.verticalCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 10
            anchors.left: recLiveCounter.right
        }

        Rectangle {
            id: recLiveCounterV1
            y: 379
            width: 70
            height: 43
            color: "#000000"
            radius: 10
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: recLiveCounterV.right
            Text {
                id: txtLcBV20
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("FF")
                horizontalAlignment: Text.AlignHCenter
                elide: Text.ElideLeft
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 25
                verticalAlignment: Text.AlignVCenter
            }
        }

        Rectangle {
            id: recLiveCounterV2
            y: 379
            width: 70
            height: 43
            color: "#000000"
            radius: 10
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: recLiveCounterV1.right
            Text {
                id: txtLcBal93
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("FF")
                horizontalAlignment: Text.AlignHCenter
                elide: Text.ElideLeft
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 25
                verticalAlignment: Text.AlignVCenter
            }
        }
        anchors.topMargin: 200
        //anchors.top: rowTop.bottom
    }

    Text {
        id: txtCelluar
        x: 620
        y: 147
        width: 200
        height: 43
        color: "#ffffff"
        text: qsTr("Celluar Network")
        MouseArea {
            width: 70
            height: 40
            hoverEnabled: false
            anchors.left: parent.left
            anchors.top: parent.top
        }
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 25
        horizontalAlignment: Text.AlignLeft
    }

    Rectangle {
        id: rowImei
        x: 620
        y: 207
        width: 380
        height: 43
    color: "#161616"
        Text {
            id: txtImeiCap
            y: 0
            width: 70
            height: 43
            color: "#ffffff"
            text: qsTr("IMEI")
            anchors.left: parent.left
            anchors.verticalCenterOffset: 0
            MouseArea {
                width: 70
                height: 40
                hoverEnabled: false
                anchors.left: parent.left
                anchors.top: parent.top
            }
            anchors.leftMargin: 0
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 25
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
        }

        Rectangle {
            id: recImei
            y: 379
            width: 280
            height: 43
            color: "#000000"
            radius: 0
            anchors.left: txtImeiCap.right
            Text {
                id: txtIMEI
                y: 0
                width: 280
                height: 43
                color: "#ffffff"
// qmicli --device=/dev/cdc-wdm0 --device-open-proxy --dms-get-ids | grep -e "IMEI" | grep -oP "(?<=').*?(?=')" > /home/racev/IMEI.cfg
// grep a string between two single quotes
// ( https://stackoverflow.com/a/35202408 )
// Automatically execute script at Linux startup with Debian 9 (Stretch)
// ( https://is.gd/RZu8Ej )
                text: qsTr("0000000000000000")
                anchors.horizontalCenter: parent.horizontalCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 25
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
            }
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
        }
        anchors.topMargin: 200
    }

    Rectangle {
        id: rowConn
        x: 620
        y: 267
        width: 380
        height: 43
    color: "#161616"
        Text {
            id: txtConnCap
            y: 0
            width: 70
            height: 43
            color: "#ffffff"
            text: qsTr("Status")
            anchors.left: parent.left
            anchors.verticalCenterOffset: 0
            MouseArea {
                id: maConn
                width: 70
                height: 40
                hoverEnabled: false
                anchors.left: parent.left
                anchors.top: parent.top
            }
            anchors.leftMargin: 0
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 25
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
        }

        Rectangle {
            id: recImei1
            y: 379
            width: 170
            height: 43
            color: "#000000"
            radius: 0
            anchors.left: txtConnCap.right
            Text {
                id: txtConn
                y: 0
                width: 170
                height: 43
                color: "#ffffff"
                text: qsTr("Disconnected")
                anchors.left: parent.left
                anchors.leftMargin: 0
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 25
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
            }
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
        }
        anchors.topMargin: 200
    }

    Rectangle {
        id: rowLCounterCap
        x: 30
        y: 629
        width: 500
        height: 43
        color: "#161616"
        Text {
            id: txtVcuLiveCap2
            y: 0
            width: 145
            height: 43
            color: "#ffffff"
            text: qsTr("PGN")
            horizontalAlignment: Text.AlignLeft
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            MouseArea {
                width: 70
                height: 40
                anchors.top: parent.top
                anchors.left: parent.left
                hoverEnabled: false
            }
            anchors.verticalCenterOffset: 0
            font.pixelSize: 25
            verticalAlignment: Text.AlignVCenter
        }

        Rectangle {
            id: recLiveCounter1
            y: 379
            width: 70
            height: 43
            color: "#000000"
            radius: 10
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: txtVcuLiveCap2.right
            Text {
                id: txtLiveCounter4
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("BV03")
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 25
                verticalAlignment: Text.AlignVCenter
            }
        }

        Rectangle {
            id: recLiveCounterV3
            y: 379
            width: 70
            height: 43
            color: "#000000"
            radius: 10
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: recLiveCounter1.right
            Text {
                id: txtLiveCounter5
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("PC40")
                horizontalAlignment: Text.AlignHCenter
                elide: Text.ElideLeft
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 25
                verticalAlignment: Text.AlignVCenter
            }
        }

        Rectangle {
            id: recLiveCounter2
            y: 379
            width: 70
            height: 43
            color: "#000000"
            radius: 10
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: recLiveCounterV3.right
            Text {
                id: txtLiveCounter6
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("BV20")
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 25
                verticalAlignment: Text.AlignVCenter
            }
        }

        Rectangle {
            id: recLiveCounter3
            y: 379
            width: 70
            height: 43
            color: "#000000"
            radius: 10
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: recLiveCounter2.right
            Text {
                id: txtLiveCounter7
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("AL93")
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 25
                verticalAlignment: Text.AlignVCenter
            }
        }
        anchors.topMargin: 200
    }

    onActiveChanged : {
    if ( true === diagnose.active ) {
        diagnose.qmlSignalActive("Diagnosis");
    }
    }
}

































































/*##^## Designer {
    D{i:8;anchors_height:40;anchors_width:70}D{i:13;anchors_height:40;anchors_width:70}
D{i:16;anchors_x:200}D{i:25;anchors_x:330}D{i:30;anchors_x:330}D{i:35;anchors_x:330}
D{i:38;anchors_x:330}D{i:43;anchors_x:330}D{i:48;anchors_x:330}D{i:57;anchors_x:330}
D{i:66;anchors_x:650}
}
 ##^##*/
