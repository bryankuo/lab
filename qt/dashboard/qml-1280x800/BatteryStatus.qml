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

// using jwintz/qchart.js QML bindings for Chart.js ( https://goo.gl/vTehWv )
// commits ( fbcfc22ac0cd7040b9866b3afb69417cc97a475e )
import jbQuick.Charts 1.0
// QML2_IMPORT_PATH / Qt Creator Project RUN
// ( https://goo.gl/3Zh2ys )
// copy to : /home/racev/Qt/5.12.0/gcc_64/qml/jbQuick/Charts

//FIXME: under same git directory control
//import "."
//import "QChart.js"        as Charts
//import "QChartGallery.js" as ChartsData
//import "/home/racev/src/dashboard/qml/jbQuick/QChart.js"        as Charts
//import "/home/racev/src/dashboard/qml/jbQuick/QChartGallery.js" as ChartsData
import "style"

Window {
    id: chart

    // ( https://goo.gl/LWbdMG )
    objectName: "chartWindow"

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
    property alias window: chart
    flags: Qt.FramelessWindowHint
    //title: "電池組" ok
    title: "Battery Pack"

    // Property names must begin with a lower case letter
    // and can only contain letters ( https://goo.gl/HzLQet )
    //
    property string batteryPackName
//    property int chart_width: 300;
//    property int chart_height: 300;
    property var labels01: [
"01","02","03","04","05","06","07",
"08","09","10","11","12","13","14"
];
    property var datasets01: [{
    data: [
    4.99, 4,    3.8, 3.6,  1.9,  2.5, 4.99,
    4.99, 4.05, 0.9, 4.95, 4.05, 3.05, 2.9
    ],
    // ( https://goo.gl/mEy93P )
    fillColor : "#66FFB2",
    //strokeColor : "rgba(72,174,209,0.4)"
    }];

    property var datasets02: [{
    data: [
    1.92, 4,    3.2, 3.6,  1.9,  2.5, 4.99,
    2.92, 4.25, 0.2, 4.25, 4.25, 3.05, 2.9
    ],
    // ( https://goo.gl/mEy93P )
    fillColor : "#66FFB2",
    //strokeColor : "rgba(72,174,209,0.4)"
    }];

    property alias chart_bar: chart_bar;
    signal qmlSignalActive(string msg)
    property int bsoc_width : 30;

    function setPack(packName, index) {
        batteryPackName = packName;
        chart.title = chart.title + "-" + batteryPackName;
    txtPackId.text = packName;
    }

    function updateView() {
    }

    function updateBMS_VCU_MSG01(s_voltage,s_current,soc,b_status,
    f_level,mcntctr_nc,mcntctr_st,pcell_alrm,s_cremains) {
    /*console.debug("v "+s_voltage+" a "+s_current+" soc "+soc
        +" b "+b_status+" fl "+f_level+" mctn "+mcntctr_nc
        +" mcts "+mcntctr_st+" pcal "+pcell_alrm
        +" crmn "+s_cremains);*/
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

    function updateBMS_VCU_MSG02(s_cmaxv,cell_maxi,s_cminv,cell_mini,
    s_cdiffv) {
    //console.debug(s_cmaxv+","+cell_maxi+","+s_cminv+","+cell_mini+","+
    //s_cdiffv);
    txtMaxVoltage.text = s_cmaxv;
    txtMaxPackNum.text = cell_maxi;
    txtMinVoltage.text = s_cminv;
    txtMinPackNum.text = cell_mini;
    txtDiffVoltage.text = s_cdiffv;
    }

    function updateBMS_Volt_Msg01_cell1_7(c1,c2,c3,c4,c5,c6,c7) {
    //console.debug("update c17");
    datasets02[0].data[0] = c1;
    datasets02[0].data[1] = c2;
    datasets02[0].data[2] = c3;
    datasets02[0].data[3] = c4;
    datasets02[0].data[4] = c5;
    datasets02[0].data[5] = c6;
    datasets02[0].data[6] = c7;
    }

    function updateBMS_Volt_Msg01_cell8_14(c8,c9,c10,c11,c12,c13,c14) {
    //console.debug("update c814");
    datasets02[0].data[7] = c8;
    datasets02[0].data[8] = c9;
    datasets02[0].data[9] = c10;
    datasets02[0].data[10] = c11;
    datasets02[0].data[11] = c12;
    datasets02[0].data[12] = c13;
    datasets02[0].data[13] = c14;
    }

    function updateBMS_Temp_Msg01(t1,t2,t3,t4) {
    txtT1DegreeC.text = t1;
    txtT2DegreeC.text = t2;
    txtT3DegreeC.text = t3;
    txtT4DegreeC.text = t4;
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

        Chart {
        id: chart_bar;
        x: 0
        y: 260
        width: 910
        height: 450
        anchors.horizontalCenterOffset: 641
        anchors.horizontalCenter: parent.horizontalCenter
        contextType: qsTr("2d")
        chartAnimated: true;
        chartAnimationEasing: Easing.OutQuad;
        chartAnimationDuration: 1000;
        chartType: Charts.ChartType.BAR;
        Component.onCompleted: {
        //console.debug("completed");

        // ( https://stackoverflow.com/a/54678128 )
        chartData = {
            labels: labels01,
            datasets: datasets01
        };
        chartOptions = {
            scaleFontSize: 24,
            scaleGridLineColor: "rgba(192,192,192,.5)",
            //barShowStroke: false
            //barValueSpacing: 5
            //scaleLineColor: "rgba(255,0,0,1)",
            //barStrokeWidth: 1
            scales: {
            yAxes: [{
            ticks: {
                beginAtZero: true,
                steps: 10,
                stepValue: 6,
                max: 60 //max value for the chart is 60
            }
            }]
            },
            // chartjs : how to set custom scale in bar chart
            // ( https://goo.gl/tCKnUP )
            scaleLineColor: "rgba(192,192,192,.5)",
            scaleOverride:true,
            scaleSteps: 6,
            scaleStartValue:0,
            scaleStepWidth:1
        };


        }
        }
    }

    Image {
        id: imageChartBack
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
        //window.hide(); works
        chart.hide();
        //chart.close(); // do works ( https://goo.gl/LQQRv1 )
        //chart.destroy();
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
                id: imageChartVolt
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
                anchors.left: imageChartVolt.right
                Text {
                    id: txtTotalVoltage
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
                id: imageChartAmp
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
                anchors.left: imageChartAmp.right
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
            width: 230
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
        x: 32; y: 14
        width: bsoc_width; height: 16
        // Gradient QML type ( http://tinyw.in/hU1L )
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
            width: 230
            height: 43
            color: "#161616"
            anchors.topMargin: 10
            anchors.leftMargin: 0
            anchors.left: rowITotalCurrent.right
            Image {
                id: imageIoTankTemp3
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
                anchors.left: imageIoTankTemp3.right
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
            anchors.leftMargin: -50
            anchors.left: rowSoc.right
            Image {
                id: imageChartVMax
                width: 100
                height: 100
                anchors.leftMargin: 0
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
                anchors.left: imageChartVMax.right
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
            id: rowBms
            y: 140
            width: 300
            height: 43
        color: "#161616"
            anchors.topMargin: 10
            anchors.leftMargin: -10
            anchors.left: rowDiff.right
            Image {
                id: imageChartBMSCode
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
                anchors.left: imageChartBMSCode.right
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
            anchors.leftMargin: -50
            anchors.left: rowCurrentState.right
            Image {
                id: imageChartVDiff
                width: 100
                height: 100
                anchors.leftMargin: 0
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
                anchors.left: imageChartVDiff.right
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
                color: "#1c1c1c"
                radius: 10
                visible: false
                anchors.leftMargin: 0
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: txtMaxVCap1.right
                Text {
                    id: txtMaxPackNum1
                    y: 0
                    width: 50
                    height: 43
                    color: "#ffffff"
                    text: qsTr("")
                    styleColor: "#1c1c1c"
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
            id: rowMin
            x: 0
            y: 80
            width: 300
            height: 43
        color: "#161616"
            anchors.topMargin: 10
            anchors.leftMargin: -10
            anchors.left: rowMax.right
            Image {
                id: imageChartVMin
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
                anchors.left: imageChartVMin.right
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
    }

    Rectangle {
    id: recMessage
    x: 0
    y: 0
    width: 1024
    height: 40
    color: "#1f1f1f"
    anchors.bottomMargin: -4
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottom: parent.bottom
    MouseArea {
        onClicked: {
        //console.debug("+++");
        var component = Qt.createComponent("BatteryStatus.qml");
        win = component.createObject(deployment_window);
        //TODO: check singleton
        win.show();
        console.debug("---");
        }
    }
    }

    Rectangle {
        id: rowBatteryPack
        x: 82
        y: 200
        width: 1024
        height: 43
        color: "#161616"
        anchors.horizontalCenter: parent.horizontalCenter

        Rectangle {
            id: recPackId
            y: 379
            width: 50
            height: 43
            color: "#000000"
            radius: 10
            visible: false
            anchors.leftMargin: 30
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: txtT1Cap
            y: 0
            width: 50
            height: 43
            color: "#ffffff"
            text: qsTr("T1 :")
            anchors.left: parent.left
            anchors.leftMargin: 300
            MouseArea {
                width: 50
                height: 40
                hoverEnabled: false
                anchors.left: parent.left
                anchors.top: parent.top
            }
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: 25
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        Rectangle {
            id: recT1
            y: 379
            width: 50
            height: 43
            color: "#000000"
            radius: 10
            anchors.leftMargin: 0
            Text {
                id: txtT1DegreeC
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("0")
                MouseArea {
                    width: 70
                    height: 40
                    hoverEnabled: false
                    anchors.left: parent.left
                    anchors.top: parent.top
                }
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 25
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
            }
            anchors.left: txtT1Cap.right
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: txtT1Unit
            y: 0
            width: 50
            height: 43
            color: "#ffffff"
            text: qsTr("℃")
            anchors.leftMargin: 0
            MouseArea {
                width: 50
                height: 40
                hoverEnabled: false
                anchors.left: parent.left
                anchors.top: parent.top
            }
            horizontalAlignment: Text.AlignHCenter
            anchors.left: recT1.right
            font.pixelSize: 25
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: txtT2Cap
            y: 0
            width: 50
            height: 43
            color: "#ffffff"
            text: qsTr("T2 :")
            anchors.leftMargin: 30
            MouseArea {
                width: 50
                height: 40
                hoverEnabled: false
                anchors.left: parent.left
                anchors.top: parent.top
            }
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: 25
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
        anchors.left: txtT1Unit.right
        }

        Rectangle {
            id: recT2
            y: 379
            width: 50
            height: 43
            color: "#000000"
            radius: 10
            anchors.leftMargin: 0
            Text {
                id: txtT2DegreeC
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("0")
                MouseArea {
                    width: 70
                    height: 40
                    hoverEnabled: false
                    anchors.left: parent.left
                    anchors.top: parent.top
                }
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 25
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
            }
            anchors.left: txtT2Cap.right
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: txtT2Unit
            y: 0
            width: 50
            height: 43
            color: "#ffffff"
            text: qsTr("℃")
            anchors.leftMargin: 0
            MouseArea {
                width: 50
                height: 40
                anchors.verticalCenter: parent.verticalCenter
                hoverEnabled: false
                anchors.left: parent.left
            }
            horizontalAlignment: Text.AlignHCenter
            anchors.left: recT2.right
            font.pixelSize: 25
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: txtT3Cap
            y: 0
            width: 50
            height: 43
            color: "#ffffff"
            text: qsTr("T3 :")
            anchors.left: txtT2Unit.right
            anchors.leftMargin: 30
            MouseArea {
                width: 50
                height: 40
                hoverEnabled: false
                anchors.left: parent.left
                anchors.top: parent.top
            }
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: 25
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        Rectangle {
            id: recT3
            y: 379
            width: 50
            height: 43
            color: "#000000"
            radius: 10
            anchors.leftMargin: 0
            Text {
                id: txtT3DegreeC
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("0")
                MouseArea {
                    width: 70
                    height: 40
                    hoverEnabled: false
                    anchors.left: parent.left
                    anchors.top: parent.top
                }
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 25
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
            }
            anchors.left: txtT3Cap.right
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: txtT3Unit
            y: 0
            width: 50
            height: 43
            color: "#ffffff"
            text: qsTr("℃")
            anchors.leftMargin: 0
            MouseArea {
                width: 50
                height: 40
                hoverEnabled: false
                anchors.left: parent.left
                anchors.top: parent.top
            }
            horizontalAlignment: Text.AlignHCenter
            anchors.left: recT3.right
            font.pixelSize: 25
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: txtT4Cap
            y: 0
            width: 50
            height: 43
            color: "#ffffff"
            text: qsTr("T4 :")
            anchors.leftMargin: 30
            MouseArea {
                width: 50
                height: 40
                hoverEnabled: false
                anchors.left: parent.left
                anchors.top: parent.top
            }
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: 25
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
        anchors.left: txtT3Unit.right
        }

        Rectangle {
            id: recT4
            y: 379
            width: 50
            height: 43
            color: "#000000"
            radius: 10
            anchors.leftMargin: 0
            Text {
                id: txtT4DegreeC
                y: 0
                width: 70
                height: 43
                color: "#ffffff"
                text: qsTr("0")
                MouseArea {
                    width: 70
                    height: 40
                    hoverEnabled: false
                    anchors.left: parent.left
                    anchors.top: parent.top
                }
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 25
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
            }
            anchors.left: txtT4Cap.right
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: txtT4Unit
            y: 0
            width: 50
            height: 43
            color: "#ffffff"
            text: qsTr("℃")
            anchors.leftMargin: 0
            MouseArea {
                width: 50
                height: 40
                anchors.verticalCenter: parent.verticalCenter
                hoverEnabled: false
                anchors.left: parent.left
            }
            horizontalAlignment: Text.AlignHCenter
            anchors.left: recT4.right
            font.pixelSize: 25
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        Image {
            id: imageChartPack
            width: 100
            height: 100
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            source: "../images/1-white/HMI-ICON-73.png"
            fillMode: Image.PreserveAspectFit
            anchors.leftMargin: 100

            Text {
                id: txtPackId
                x: 0
                width: 60
                height: 43
                color: "#ffffff"
                text: qsTr("")
                anchors.top: parent.top
                anchors.topMargin: 33
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignHCenter
                MouseArea {
                    width: 50
                    height: 40
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    hoverEnabled: false
                }
                font.pixelSize: 25
            }
        }

    }

    Text {
        id: txtYLegend
        width: 50
        height: 43
        color: "#ffffff"
        text: qsTr("Volt")
        anchors.left: parent.left
        anchors.leftMargin: 3
        anchors.top: parent.top
        anchors.topMargin: 259
        horizontalAlignment: Text.AlignLeft
        font.pixelSize: 25
        verticalAlignment: Text.AlignVCenter
    }

    Text {
        id: txtXLegend
        x: 2
        y: 7
        width: 50
        height: 43
        color: "#ffffff"
        text: qsTr("Cell")
        anchors.leftMargin: 971
        horizontalAlignment: Text.AlignLeft
        anchors.left: parent.left
        font.pixelSize: 25
        anchors.top: parent.top
        verticalAlignment: Text.AlignVCenter
        anchors.topMargin: 637
    }
    onActiveChanged : {
    if ( true === chart.active ) {
        //console.debug("active");
        chart.qmlSignalActive("Chart");
        // ( https://stackoverflow.com/a/54678128 )
        chart_bar.chartData = {
        labels: labels01,
        datasets: datasets02
        };
        chart_bar.chart = false; // ( https://goo.gl/bRtsp7 )
        // try to call chart.update() b4 chart.repaint()
        chart_bar.update();
        chart_bar.repaint(); // trying
        // Starting QML Debugging ( https://goo.gl/wuF2j8 )
    }
    }
}





































/*##^## Designer {
    D{i:0;height:768;width:1024}
}
 ##^##*/
