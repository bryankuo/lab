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
import "style"

Window {
    id: deployment_window

    // ( https://goo.gl/LWbdMG )
    objectName: "deploymentWindow"

    // QML - main window position on start (screen center)
    // ( https://goo.gl/wLpvZD )
    Styles { id: style }
    width: style.resolutionWidth // application wide properties
    height: style.resolutionHeight
    maximumHeight: height
    maximumWidth: width
    x: 0 //(Screen.width - width) / 2
    y: 0 //(Screen.height - height) / 2
    minimumHeight: height
    minimumWidth: width
    color: "#161616"
    property alias rectangle: rectangle
    property alias mouseAreaDeploymentAll: mouseAreaDeploymentAll
    property alias deployment_window: deployment_window
    property alias recMessage: recMessage
    // Launch a child QML window from a parent QML window
    // ( https://goo.gl/J67Pcc )
    property variant win;  // you can hold this as a reference..
    flags: Qt.FramelessWindowHint
    // QML Signal and Handler Event System ( https://goo.gl/ULdJGh )
    //
    signal launchChartSignal(string packName)
    signal qmlSignalDeployment(string packName, int packIndex/*0based*/)
    signal qmlSignalActive(string msg)
    property int bsoc_width : 30;

    function updateView(total_voltage, total_current,
    soc, state, bms_code) {
    // TODO: total voltage is obselete
        if ( total_voltage <= 440.1 )
        txtTotalVoltage.color = style.colorAlert;
    else if ( 440.2 <= total_voltage && total_voltage < 583.0 )
        txtTotalVoltage.color = style.colorWarning;
    else
        txtTotalVoltage.color = style.colorNormal;
    txtTotalVoltage.text = total_voltage;
        txtTotalCurrent.text = total_current;
        txtSocValue.text = soc;
        txtCurrentState.text = state;
        txtBmsCode.text = bms_code; // TODO: from BMS_VCU_Msg04
        return ""
    }

    // split to workaround 13 arguments issue.
    // TODO: verify if obselete
/*    function updateViewEx(max_voltage, max_packnum,
    min_voltage, min_packnum, diff_voltage, diff_packnum) {
        txtMaxVoltage.text = max_voltage;
        txtMaxPackNum.text = max_packnum;
        txtMinVoltage.text = min_voltage;
        txtMinPackNum.text = min_packnum;
        txtDiffVoltage.text = diff_voltage;
        txtDiffPackNum.text = diff_packnum;
        return ""
    } */

    function updateBMS_VCU_MSG01(s_voltage,s_current,soc,b_status,
    f_level,mcntctr_nc,mcntctr_st,pcell_alrm,s_cremains) {
    /*console.debug("v "+s_voltage+" a "+s_current+" soc "+soc
        +" b "+b_status+" fl "+f_level+" mctn "+mcntctr_nc
        +" mcts "+mcntctr_st+" pcal "+pcell_alrm
        +" crmn "+s_cremains);*/
        if ( s_voltage <= 440.1 )
        txtTotalVoltage.color = style.colorAlert;
    else if ( 440.2 <= s_voltage && s_voltage < 583.0 )
        txtTotalVoltage.color = style.colorWarning;
    else
        txtTotalVoltage.color = style.colorNormal;
    txtTotalVoltage.text = s_voltage;
    txtTotalCurrent.text = Math.abs(s_current);
    txtSocValue.text = soc;
    recBSOC.width = bsoc_width * ( soc/100 );
    if ( 0 === b_status ) {
        txtCurrentState.text = "IDLE";
    }
    else if ( 1 === b_status ) {
        txtCurrentState.text = "DISC";
    }
    else if ( 2 === b_status ) {
        txtCurrentState.text = "CHRG"
    }
    else if ( 3 === b_status ) {
        txtCurrentState.text = "STOP";
    }
    else {};
    txtBmsCode.text = f_level;
    }

    function updateBMS_VCU_MSG02(
	s_cmaxv,cell_maxi,s_cminv,cell_mini,s_cdiffv) {
    //console.debug(s_cmaxv+","+cell_maxi+","+s_cminv+","+cell_mini+","+
    //s_cdiffv);
    txtMaxVoltage.text = s_cmaxv;
    txtMaxPackNum.text = cell_maxi;
    txtMinVoltage.text = s_cminv;
    txtMinPackNum.text = cell_mini;
    txtDiffVoltage.text = s_cdiffv;
    }

    Rectangle {
        id: rectangle

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
            id: mouseAreaDeploymentAll
            width: 1280
            height: 800
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            onClicked: {
                /*var component = Qt.createComponent("BatteryStatus.qml");
                win = component.createObject(deployment_window);
                win.show();*/
        deployment_window.qmlSignalDeployment("Chart");
            }
        }
    }

/*
    Window {
        id: window2
        title: "window 2"
        width: 400
        height: 400
        // you can use this instead of Connections
        //Component.onCompleted: {
    // Q: how to use this?
        //    window1.launchChartSignal.connect(show);
        //}
    }
*/
    Image {
        id: imageBack
        x: 0
        width: 80
        height: 80
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.topMargin: 0
        z: 1
        anchors.top: parent.top
        source: "../images/0-color/HMI-ICON-55.png"
        fillMode: Image.PreserveAspectFit
        MouseArea {
            width: 80
            height: 80
            z: 2
            hoverEnabled: false
            anchors.fill: parent
            onClicked: {
                // or ...deployment_window.hide();
                deployment_window.close();
            }
        }
    }

    Rectangle {
        id: row
        y: 0
        width: 1024
        height: 200
        anchors.horizontalCenter: parent.horizontalCenter
    color: "#161616"
        Rectangle {
            id: rowTotalVoltage
            x: 0
            y: 80
            width: 210
            height: 43
            color: "#161616"
            anchors.topMargin: 10
            anchors.leftMargin: 0
            anchors.left: parent.left
            Image {
                id: imageIECVolt
                width: 100
                height: 100
                anchors.leftMargin: -20
                anchors.verticalCenter: parent.verticalCenter
                source: "../images/1-white/HMI-ICON-74.png"
                anchors.left: parent.left
                fillMode: Image.PreserveAspectFit
            }

            Text {
                id: txtTotalVCap
                y: 0
                width: 30
                height: 43
                color: "#ffffff"
                text: qsTr("V")
                anchors.left: rectTotalVoltage.right
                anchors.leftMargin: 10
                font.pixelSize: 25
                anchors.verticalCenter: parent.verticalCenter
                verticalAlignment: Text.AlignVCenter
                MouseArea {
                    width: 30
                    height: 40
                    anchors.left: parent.left
                    anchors.top: parent.top
                    hoverEnabled: false
                }
                horizontalAlignment: Text.AlignLeft
            }

            Rectangle {
                id: rectTotalVoltage
                y: 379
                width: 100
                height: 43
                color: "#000000"
                radius: 10
                anchors.leftMargin: -10
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: imageIECVolt.right
                Text {
                    id: txtTotalVoltage
                    objectName: "txtTotalVoltage"
                    y: 0
                    width: 70
                    height: 43
                    color: style.colorNormal
                    text: qsTr("000.0")
                    font.pixelSize: 25
                    anchors.verticalCenter: parent.verticalCenter
                    verticalAlignment: Text.AlignVCenter
                    MouseArea {
                        width: 70
                        height: 40
                        anchors.left: parent.left
                        anchors.top: parent.top
                        hoverEnabled: false
                    }
                    anchors.horizontalCenter: parent.horizontalCenter
                    horizontalAlignment: Text.AlignHCenter
                }
            }
        }

        Rectangle {
            id: rowITotalCurrent
            x: 300
            y: 140
            width: 210
            height: 43
            color: "#161616"
            anchors.topMargin: 10
            anchors.leftMargin: 0
            anchors.left: parent.left
            Image {
                id: imageIECAmp
                width: 100
                height: 100
                anchors.leftMargin: -20
                anchors.verticalCenter: parent.verticalCenter
                source: "../images/1-white/HMI-ICON-77.png"
                anchors.left: parent.left
                fillMode: Image.PreserveAspectFit
            }

            Text {
                id: txtTotalCurrentCap
                y: 0
                width: 30
                height: 43
                color: "#ffffff"
                text: qsTr("A")
                anchors.left: rectangle3.right
                anchors.leftMargin: 10
                font.pixelSize: 25
                anchors.verticalCenter: parent.verticalCenter
                verticalAlignment: Text.AlignVCenter
                MouseArea {
                    width: 30
                    height: 40
                    anchors.left: parent.left
                    anchors.top: parent.top
                    hoverEnabled: false
                }
                horizontalAlignment: Text.AlignLeft
            }

            Rectangle {
                id: rectangle3
                y: 379
                width: 100
                height: 43
                color: "#000000"
                radius: 10
                anchors.leftMargin: -10
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: imageIECAmp.right
                Text {
                    id: txtTotalCurrent
                    y: 0
                    width: 70
                    height: 43
                    color: "#ffffff"
                    text: qsTr("000.0")
                    font.pixelSize: 25
                    anchors.verticalCenter: parent.verticalCenter
                    verticalAlignment: Text.AlignVCenter
                    MouseArea {
                        width: 70
                        height: 40
                        anchors.left: parent.left
                        anchors.top: parent.top
                        hoverEnabled: false
                    }
                    anchors.horizontalCenter: parent.horizontalCenter
                    horizontalAlignment: Text.AlignHCenter
                }
            }
        }

        Rectangle {
            id: rowSoc
            x: 0
            y: 80
            width: 220
            height: 43
            color: "#161616"
            anchors.topMargin: 10
            anchors.leftMargin: 0
            anchors.left: rowTotalVoltage.right

            Image {
                id: imageIoTankTemp2
                width: 100
                height: 100
                anchors.leftMargin: -10
                anchors.verticalCenter: parent.verticalCenter
                source: "../images/1-white/white-HMI-ICON-25.png"
                anchors.left: parent.left
                fillMode: Image.PreserveAspectFit
            }

        Rectangle {
        id: recBSOC
        x: 22; y: 14
        width: bsoc_width; height: 16
        gradient: Gradient {
            // schemecolor: ( http://tinyw.in/61V2 )
            GradientStop { position: 0.0; color: "#2b40f0" }
            GradientStop { position: 0.33; color: "#5fb4f0" }
            GradientStop { position: 1.0; color: "#2b40f0" }
        }
        }

            Text {
                id: txtTotalVCap1
                y: 0
                width: 30
                height: 43
                color: "#ffffff"
                text: qsTr("%")
                z: 1
                font.pixelSize: 25
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: rectSoc.right
                verticalAlignment: Text.AlignVCenter
                MouseArea {
                    width: 30
                    height: 40
                    anchors.left: parent.left
                    anchors.top: parent.top
                    hoverEnabled: false
                }
                horizontalAlignment: Text.AlignLeft
            }

            Rectangle {
                id: rectSoc
                y: 379
                width: 100
                height: 43
                color: "#000000"
                radius: 10
                anchors.leftMargin: -10
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: imageIoTankTemp2.right
                Text {
                    id: txtSocValue
                    y: 0
                    width: 70
                    height: 43
                    color: "#ffffff"
                    text: qsTr("0")
                    font.pixelSize: 25
                    anchors.verticalCenter: parent.verticalCenter
                    verticalAlignment: Text.AlignVCenter
                    MouseArea {
                        width: 70
                        height: 40
                        anchors.left: parent.left
                        anchors.top: parent.top
                        hoverEnabled: false
                    }
                    anchors.horizontalCenter: parent.horizontalCenter
                    horizontalAlignment: Text.AlignHCenter
                }
            }
        }

        Rectangle {
            id: rowCurrentState
            x: 300
            y: 140
            width: 220
            height: 43
            color: "#161616"
            anchors.topMargin: 10
            anchors.leftMargin: 0
            anchors.left: rowITotalCurrent.right
            Image {
                id: imgBatteryState
                width: 100
                height: 100
                anchors.leftMargin: -10
                anchors.verticalCenter: parent.verticalCenter
                source: "../images/1-white/white-HMI-ICON-25.png"
                anchors.left: parent.left
                fillMode: Image.PreserveAspectFit
            }

            Text {
                id: txtCurrentStateCap
                y: 0
                width: 30
                height: 43
                color: "#ffffff"
                text: qsTr("")
                font.pixelSize: 25
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: rectangle4.right
                verticalAlignment: Text.AlignVCenter
                MouseArea {
                    width: 30
                    height: 40
                    anchors.left: parent.left
                    anchors.top: parent.top
                    hoverEnabled: false
                }
                horizontalAlignment: Text.AlignLeft
            }

            Rectangle {
                id: rectangle4
                y: 379
                width: 100
                height: 43
                color: "#000000"
                radius: 10
                anchors.leftMargin: -10
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: imgBatteryState.right
                Text {
                    id: txtCurrentState
                    y: 0
                    width: 70
                    height: 43
                    color: "#ffffff"
                    text: qsTr("IDLE")
                    font.pixelSize: 25
                    anchors.verticalCenter: parent.verticalCenter
                    verticalAlignment: Text.AlignVCenter
                    MouseArea {
                        width: 70
                        height: 40
                        anchors.left: parent.left
                        anchors.top: parent.top
                        hoverEnabled: false
                    }
                    anchors.horizontalCenter: parent.horizontalCenter
                    horizontalAlignment: Text.AlignHCenter
                }
            }
        }

        Rectangle {
            id: rowMax
            x: 0
            y: 80
            width: 270
            height: 43
            color: "#161616"
            anchors.topMargin: 10
            anchors.leftMargin: 0
            anchors.left: rowSoc.right
            Image {
                id: imageVMax
                width: 100
                height: 100
                anchors.leftMargin: -10
                anchors.verticalCenter: parent.verticalCenter
                source: "../images/1-white/HMI-ICON-65.png"
                anchors.left: parent.left
                fillMode: Image.PreserveAspectFit
            }

            Text {
                id: txtMaxVCap
                y: 0
                width: 30
                height: 43
                color: "#ffffff"
                text: qsTr("V/")
                font.pixelSize: 25
                anchors.leftMargin: 0
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: rectTotalVoltage1.right
                verticalAlignment: Text.AlignVCenter
                MouseArea {
                    width: 30
                    height: 40
                    anchors.left: parent.left
                    anchors.top: parent.top
                    hoverEnabled: false
                }
                horizontalAlignment: Text.AlignLeft
            }

            Rectangle {
                id: rectTotalVoltage1
                y: 379
                width: 100
                height: 43
                color: "#000000"
                radius: 10
                anchors.leftMargin: -10
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: imageVMax.right
                Text {
                    id: txtMaxVoltage
                    y: 0
                    width: 70
                    height: 43
                    color: "#ffffff"
                    text: qsTr("0.000")
                    font.pixelSize: 25
                    anchors.verticalCenter: parent.verticalCenter
                    verticalAlignment: Text.AlignVCenter
                    MouseArea {
                        width: 70
                        height: 40
                        anchors.left: parent.left
                        anchors.top: parent.top
                        hoverEnabled: false
                    }
                    anchors.horizontalCenter: parent.horizontalCenter
                    horizontalAlignment: Text.AlignHCenter
                }
            }

            Rectangle {
                id: rectMaxPack
                y: 379
                width: 50
                height: 43
                color: "#000000"
                radius: 10
                anchors.leftMargin: 0
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: txtMaxVCap.right
                Text {
                    id: txtMaxPackNum
                    y: 0
                    width: 50
                    height: 43
                    color: "#ffffff"
                    text: qsTr("000")
                    font.pixelSize: 25
                    anchors.verticalCenter: parent.verticalCenter
                    verticalAlignment: Text.AlignVCenter
                    MouseArea {
                        width: 50
                        height: 40
                        anchors.left: parent.left
                        anchors.top: parent.top
                        hoverEnabled: false
                    }
                    anchors.horizontalCenter: parent.horizontalCenter
                    horizontalAlignment: Text.AlignHCenter
                }
            }
        }

        Rectangle {
            id: rowBms
            y: 140
            width: 230
            height: 43
            color: "#161616"
            anchors.topMargin: 10
            anchors.leftMargin: -10
            anchors.left: rowDiff.right
            Image {
                id: imageBMSCode
        width: 100
                height: 100
                anchors.leftMargin: 0
                anchors.verticalCenter: parent.verticalCenter
                source: "../images/1-white/HMI-ICON-71.png"
                anchors.left: parent.left
                fillMode: Image.PreserveAspectFit
            }

            Text {
                id: txtCurrentStateCap1
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("")
                anchors.leftMargin: 10
                font.pixelSize: 25
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: rectangle6.right
                verticalAlignment: Text.AlignVCenter
                MouseArea {
                    width: 70
                    height: 40
                    anchors.left: parent.left
                    anchors.top: parent.top
                    hoverEnabled: false
                }
                horizontalAlignment: Text.AlignLeft
            }

            Rectangle {
                id: rectangle6
                y: 379
                width: 100
                height: 43
                color: "#000000"
                radius: 10
                anchors.leftMargin: -10
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: imageBMSCode.right
                Text {
                    id: txtBmsCode
                    y: 0
                    width: 70
                    height: 43
                    color: "#ffffff"
                    text: qsTr("0")
                    font.pixelSize: 25
                    anchors.verticalCenter: parent.verticalCenter
                    verticalAlignment: Text.AlignVCenter
                    MouseArea {
                        width: 70
                        height: 40
                        anchors.left: parent.left
                        anchors.top: parent.top
                        hoverEnabled: false
                    }
                    anchors.horizontalCenter: parent.horizontalCenter
                    horizontalAlignment: Text.AlignHCenter
                }
            }
        }

        Rectangle {
            id: rowDiff
            x: 0
            y: 140
            width: 270
            height: 43
            color: "#161616"
            anchors.topMargin: 10
            anchors.leftMargin: 0
            anchors.left: rowCurrentState.right
            Image {
                id: imageIoVDiff
                width: 100
                height: 100
                anchors.leftMargin: -10
                anchors.verticalCenter: parent.verticalCenter
                source: "../images/1-white/HMI-ICON-69.png"
                anchors.left: parent.left
                fillMode: Image.PreserveAspectFit
            }

            Text {
                id: txtMaxVCap1
                y: 0
                width: 30
                height: 43
                color: "#ffffff"
                text: qsTr("V")
                anchors.leftMargin: 0
                font.pixelSize: 25
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: rectTotalVoltage2.right
                verticalAlignment: Text.AlignVCenter
                MouseArea {
                    width: 30
                    height: 40
                    anchors.left: parent.left
                    anchors.top: parent.top
                    hoverEnabled: false
                }
                horizontalAlignment: Text.AlignLeft
            }

            Rectangle {
                id: rectTotalVoltage2
                y: 379
                width: 100
                height: 43
                color: "#000000"
                radius: 10
                anchors.leftMargin: -10
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: imageIoVDiff.right
                Text {
                    id: txtDiffVoltage
                    y: 0
                    width: 70
                    height: 43
                    color: "#ffffff"
                    text: qsTr("0.000")
                    font.pixelSize: 25
                    anchors.verticalCenter: parent.verticalCenter
                    verticalAlignment: Text.AlignVCenter
                    MouseArea {
                        width: 70
                        height: 40
                        anchors.left: parent.left
                        anchors.top: parent.top
                        hoverEnabled: false
                    }
                    anchors.horizontalCenter: parent.horizontalCenter
                    horizontalAlignment: Text.AlignHCenter
                }
            }

            Rectangle {
                id: rectMaxPack1
                y: 379
                width: 50
                height: 43
                color: "#000000"
                radius: 10
                visible: false
                anchors.leftMargin: 0
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: txtMaxVCap1.right
                Text {
                    id: txtDiffPackNum
                    y: 0
                    width: 50
                    height: 43
                    color: "#ffffff"
                    text: qsTr("")
                    visible: false
                    styleColor: "#000000"
                    font.pixelSize: 25
                    anchors.verticalCenter: parent.verticalCenter
                    verticalAlignment: Text.AlignVCenter
                    MouseArea {
                        width: 70
                        height: 40
                        visible: false
                        anchors.left: parent.left
                        anchors.top: parent.top
                        hoverEnabled: false
                    }
                    anchors.horizontalCenter: parent.horizontalCenter
                    horizontalAlignment: Text.AlignHCenter
                }
            }
        }

        Rectangle {
            id: rowMin
            x: 0
            y: 80
            width: 230
            height: 43
            color: "#161616"
            anchors.topMargin: 10
            anchors.leftMargin: -10
            anchors.left: rowMax.right
            Image {
                id: imageVMin
                width: 100
                height: 100
                anchors.leftMargin: 0
                anchors.verticalCenter: parent.verticalCenter
                source: "../images/1-white/HMI-ICON-67.png"
                anchors.left: parent.left
                fillMode: Image.PreserveAspectFit
            }

            Text {
                id: txtMaxVCap2
                y: 0
                width: 30
                height: 43
                color: "#ffffff"
                text: qsTr("V/")
                anchors.leftMargin: 0
                font.pixelSize: 25
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: rectTotalVoltage3.right
                verticalAlignment: Text.AlignVCenter
                MouseArea {
                    width: 30
                    height: 40
                    anchors.left: parent.left
                    anchors.top: parent.top
                    hoverEnabled: false
                }
                horizontalAlignment: Text.AlignLeft
            }

            Rectangle {
                id: rectTotalVoltage3
                y: 379
                width: 100
                height: 43
                color: "#000000"
                radius: 10
                anchors.leftMargin: -10
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: imageVMin.right
                Text {
                    id: txtMinVoltage
                    y: 0
                    width: 70
                    height: 43
                    color: "#ffffff"
                    text: qsTr("0.000")
                    font.pixelSize: 25
                    anchors.verticalCenter: parent.verticalCenter
                    verticalAlignment: Text.AlignVCenter
                    MouseArea {
                        width: 70
                        height: 40
                        anchors.left: parent.left
                        anchors.top: parent.top
                        hoverEnabled: false
                    }
                    anchors.horizontalCenter: parent.horizontalCenter
                    horizontalAlignment: Text.AlignHCenter
                }
            }

            Rectangle {
                id: rectMaxPack2
                y: 379
                width: 50
                height: 43
                color: "#000000"
                radius: 10
                anchors.leftMargin: 0
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: txtMaxVCap2.right
                Text {
                    id: txtMinPackNum
                    y: 0
                    width: 50
                    height: 43
                    color: "#ffffff"
                    text: qsTr("000")
                    font.pixelSize: 25
                    anchors.verticalCenter: parent.verticalCenter
                    verticalAlignment: Text.AlignVCenter
                    MouseArea {
                        width: 50
                        height: 40
                        visible: false
                        anchors.left: parent.left
                        anchors.top: parent.top
                        hoverEnabled: false
                    }
                    anchors.horizontalCenter: parent.horizontalCenter
                    horizontalAlignment: Text.AlignHCenter
                }
            }
        }
    }

    Rectangle {
        id: recMessage
        x: 0
        y: 0
        width: 1024
        height: 40
        color: "#1f1f1f"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: -4
        anchors.bottom: parent.bottom
        MouseArea {
            onClicked: {
                var component = Qt.createComponent("BatteryStatus.qml");
                win = component.createObject(deployment_window);
                //TODO: check singleton
                win.show();
            }
        }
    }

    Rectangle {
        id: rowBat0
        x: 0
        y: 250
        width: 1024
        height: 170
        color: "#ffffff"
        anchors.horizontalCenter: parent.horizontalCenter

        Rectangle {
            id: rectRow0
            width: 1024
            height: 180
            color: "#ffffff"
            anchors.horizontalCenter: parent.horizontalCenter
            border.width: 0
        }


    }

    Rectangle {
        id: rowBat1
        x: 0
        y: 490
        width: 1024
        height: 180
        color: "#ffffff"
        anchors.horizontalCenter: parent.horizontalCenter

        Rectangle {
            id: rectRow1
            x: 0
            y: 0
            width: 1024
            height: 180
            color: "#ffffff"
            anchors.horizontalCenter: parent.horizontalCenter
            z: -1
            border.width: 0
        }
    }

    Connections {
        target: deployment_window
        // Handler name 'onXXX'
        // with the first letter of the signal in uppercase!
        // ( https://goo.gl/ULdJGh )
        onLaunchChartSignal: {
            //window2.show();
            // pass data from one window to another
            // ( https://goo.gl/BJcinV )
            // doing at QML
            /*
            var component = Qt.createComponent("BatteryStatus.qml");
            win = component.createObject(deployment_window);
            //TODO: check singleton
            win.setPack(packName);
            win.show();*/
        }
    }

    Rectangle {
        id: recBackMain
        x: 0
        y: 0
        width: 80
        height: 80
        color: "#161616"
        border.width: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        border.color: "#ffffff"
    }

    // note: for each pack rect, it is not allowed inside rectange
    Rectangle {
        id: rectA
        x: 0
        y: 260
        width: 160
        height: 160
        color: "#008000"
        radius: 20
        anchors.left: parent.left
        anchors.leftMargin: 15
        Text {
            id: capA
            color: "#ffffff"
            text: {
                "A"
            }
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 50
        }

        MouseArea {
            x: 0
            y: 0
            width: 160
            height: 160
            onClicked: {
                deployment_window.qmlSignalDeployment(capA.text, 0);
            }
        }
        border.width: 0
        border.color: "#ffffff"
    }

    Rectangle {
        id: rectB
        y: 260
        width: 160
        height: 160
        color: "#008000"
        radius: 20
        anchors.left: rectA.right
        Text {
            id: capB
            color: "#ffffff"
            text: {
                "B"
            }
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 50
        }

        MouseArea {
            width: 160
            height: 160
            anchors.left: parent.left
            anchors.leftMargin: 0
            onClicked: {
                deployment_window.qmlSignalDeployment(capB.text, 1);
            }
        }
        border.width: 0
        border.color: "#ffffff"
        anchors.leftMargin: 7
    }

    Rectangle {
        id: rectC
        y: 260
        width: 160
        height: 160
        color: "#008000"
        radius: 20
        anchors.left: rectB.right
        Text {
            id: capC
            color: "#ffffff"
            text: {
                "C"
            }
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 50
        }

        MouseArea {
            width: 160
            height: 160
            onClicked: {
                deployment_window.qmlSignalDeployment(capC.text, 2);
            }
        }
        border.width: 0
        border.color: "#ffffff"
        anchors.leftMargin: 7
    }

    Rectangle {
        id: rectD
        y: 260
        width: 160
        height: 160
        color: "#008000"
        radius: 20
        anchors.left: rectC.right
        Text {
            id: capD
            color: "#ffffff"
            text: {
                "D"
            }
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 50
        }

        MouseArea {
            width: 160
            height: 160
            onClicked: {
                deployment_window.qmlSignalDeployment(capD.text, 3);
            }
        }
        border.width: 0
        border.color: "#ffffff"
        anchors.leftMargin: 7
    }

    Rectangle {
        id: rectE
        y: 260
        width: 160
        height: 160
        color: "#008000"
        radius: 20
        anchors.left: rectD.right
        Text {
            id: capE
            color: "#ffffff"
            text: {
                "E"
            }
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 50
        }

        MouseArea {
            width: 160
            height: 160
            onClicked: {
                deployment_window.qmlSignalDeployment(capE.text, 4);
            }
        }
        border.width: 0
        border.color: "#ffffff"
        anchors.leftMargin: 7
    }

    Rectangle {
        id: rectF
        y: 260
        width: 160
        height: 160
        color: "#008000"
        radius: 20
        anchors.left: rectE.right
        Text {
            id: capF
            color: "#ffffff"
            text: {
                "F"
            }
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 50
        }

        MouseArea {
            width: 160
            height: 160
            onClicked: {
                deployment_window.qmlSignalDeployment(capF.text, 5);
            }
        }
        border.width: 0
        border.color: "#ffffff"
        anchors.leftMargin: 10
    }

    Rectangle {
        id: rectG
        x: 0
        y: 500
        width: 160
        height: 160
        color: "#008000"
        radius: 20
        anchors.left: parent.left
        Text {
            id: capG
            color: "#ffffff"
            text: {
                "G"
            }
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 50
        }

        MouseArea {
            width: 160
            height: 160
            onClicked: {
                deployment_window.qmlSignalDeployment(capG.text, 6);
            }
        }
        border.width: 0
        border.color: "#ffffff"
        anchors.leftMargin: 15
    }

    Rectangle {
        id: rectH
        y: 500
        width: 160
        height: 160
        color: "#008000"
        radius: 20
        anchors.left: rectG.right
        Text {
            id: capH
            color: "#ffffff"
            text: {
                "H"
            }
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 50
        }

        MouseArea {
            width: 160
            height: 160
            onClicked: {
                deployment_window.qmlSignalDeployment(capH.text, 7);
            }
        }
        border.width: 0
        border.color: "#ffffff"
        anchors.leftMargin: 7
    }

    Rectangle {
        id: rectI
        y: 500
        width: 160
        height: 160
        color: "#008000"
        radius: 20
        anchors.left: rectH.right
        Text {
            id: capI
            color: "#ffffff"
            text: {
                "I"
            }
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 50
        }

        MouseArea {
            width: 160
            height: 160
            onClicked: {
                deployment_window.qmlSignalDeployment(capI.text, 8);
            }
        }
        border.width: 0
        border.color: "#ffffff"
        anchors.leftMargin: 7
    }

    Rectangle {
        id: rectJ
        y: 500
        width: 160
        height: 160
        color: "#008000"
        radius: 20
        anchors.left: rectI.right
        Text {
            id: capJ
            color: "#ffffff"
            text: {
                "J"
            }
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 50
        }

        MouseArea {
            width: 160
            height: 160
            onClicked: {
                deployment_window.qmlSignalDeployment(capJ.text, 9);
            }
        }
        border.width: 0
        border.color: "#ffffff"
        anchors.leftMargin: 7
    }

    Rectangle {
        id: rectK
        y: 500
        width: 160
        height: 160
        color: "#008000"
        radius: 20
        anchors.left: rectJ.right
        Text {
            id: capK
            color: "#ffffff"
            text: {
                "K"
            }
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 50
        }

        MouseArea {
            width: 160
            height: 160
            onClicked: {
                deployment_window.qmlSignalDeployment(capK.text, 10);
            }
        }
        border.width: 0
        border.color: "#ffffff"
        anchors.leftMargin: 7
    }

    Rectangle {
        id: rectL
        y: 500
        width: 160
        height: 160
        color: "#008000"
        radius: 20
        anchors.left: rectK.right
        Text {
            id: capL
            color: "#ffffff"
            text: {
                                "L"
                            }
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 50
        }

        MouseArea {
            width: 160
            height: 160
            onClicked: {
                deployment_window.qmlSignalDeployment(capL.text, 11);
            }
        }
        border.width: 0
        border.color: "#ffffff"
        anchors.leftMargin: 7
    }
    onActiveChanged : {
    if ( true === deployment_window.active ) {
        deployment_window.qmlSignalActive("Deployment");
    }
    }
}



















/*##^## Designer {
    D{i:0;height:768;width:1024}D{i:118;anchors_x:-9}D{i:142;anchors_x:0}D{i:151;anchors_x:9}
}
 ##^##*/
