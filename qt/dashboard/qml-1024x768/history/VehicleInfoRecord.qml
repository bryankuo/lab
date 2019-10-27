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
import "../style"

Window {
    id: vehicleInfoRecord

    // ( https://goo.gl/LWbdMG )
    objectName: "vehicleInfoRecordWin"

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
    property alias window: vehicleInfoRecord
    flags: Qt.FramelessWindowHint
    title: "Vehicle Information Record"

    // Property names must begin with a lower case letter
    // and can only contain letters ( https://goo.gl/HzLQet )
    //
    //property string batteryPackName
    signal qmlSignal(string msg)
    signal qmlSignalActive(string msg)

    Rectangle {
        id: rectanglevehicleInfoRecord
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
        source: "../../images/0-color/HMI-ICON-55.png"
        fillMode: Image.PreserveAspectFit
    MouseArea {
        id: maViBack
        z: 2
        anchors.fill: parent
        onClicked: {
        vehicleInfoRecord.hide();
        }
    }
    }

    Rectangle {
        id: rowvehicleInfoRecord
        x: 200
        y: 30
        width: 300
        height: 43
	color: "#161616"
        anchors.leftMargin: 50
        Text {
            id: txtvehicleInfoRecord
            y: 0
            width: 100
            height: 43
            color: "#ffffff"
            text: qsTr("Vehicle Info. Record")
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

    Button {
    id: btnClearAlarmRecord
    x: 1050
    y: 30
    //width: 100
    //height: 43
    visible: false
    text: qsTr("CLEAR")
    anchors.leftMargin: 180
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

    Button {
    id: btnRefreshAlarmRecord
    x: 940
    y: 30
    //width: 100
    //height: 43
    text: qsTr("REFRESH")
    anchors.leftMargin: 180
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

    TableView {
    id: tableView
    x: 0
    width: 1280
    height: 641
    anchors.top: imageBack.bottom
    anchors.topMargin: 0
    anchors.horizontalCenter: parent.horizontalCenter

    frameVisible: true
    sortIndicatorVisible: false

    Layout.minimumWidth: 400
    Layout.minimumHeight: 240
    Layout.preferredWidth: 600
    Layout.preferredHeight: 400
    horizontalScrollBarPolicy : Qt.ScrollBarAlwaysOn
    verticalScrollBarPolicy : Qt.ScrollBarAlwaysOn
    model: sourceModel

        function resizeAllColumns() {
            //	for (var i=0; i<columnCount; ++i)
            //	    getColumn(i).resizeToContents()
        cellLowestVLocationColumn.resizeToContents();
        cellHighestVLocationColumn.resizeToContents();
        }

    TableViewColumn {
    id: localtimeColumn
    title: "LocalTime"
    role: "localtime"
    movable: false
    resizable: false
    width: 120 /*tableView.viewport.width - authorColumn.width*/
    // elideMode: Text.ElideMiddle
    horizontalAlignment: Text.AlignHCenter
    delegate: Item {
            Text {
              anchors.verticalCenter: parent.verticalCenter
              //color: "red"
              //elide: styleData.elideMode
              text: styleData.value
              font.pixelSize: 18
            }
         }

    }

    // You can use itemDelegate in TableView
    // for specific cells or all cells. ( https://is.gd/UCSqg0 )
    itemDelegate: Item {
            Text {
              anchors.verticalCenter: parent.verticalCenter
              // color: "green"
              elide: styleData.elideMode
              text: styleData.value
              font.pixelSize: 18
            }
         }

    TableViewColumn {
    id: utcTimeColumn
    title: "UTC Time"
    role: "utctime"
    horizontalAlignment: Text.AlignHCenter
    movable: false
    resizable: false
    width: 100
    }

    TableViewColumn {
    id: longitudeColumn
    title: "Longitude"
    role: "longitude"
    horizontalAlignment: Text.AlignHCenter
    movable: false
    resizable: true
    width: 200
    }

    TableViewColumn {
    id: latitudeColumn
    title: "Latitude"
    role: "latitude"
    horizontalAlignment: Text.AlignHCenter
    movable: false
    resizable: false
    width: 200
    }

    TableViewColumn {
    id: gpsMileageColumn
    title: "GPS Mileage"
    role: "gpsMileage"
    horizontalAlignment: Text.AlignHCenter
    movable: false
    resizable: true
    width: 200
    }

    TableViewColumn {
    id: lumpedVColumn
    title: "Lumped Voltage"
    role: "lumpedV"
    horizontalAlignment: Text.AlignHCenter
    movable: false
    resizable: false
    width: 150
    }

    TableViewColumn {
    id: currentColumn
    title: "Current"
    role: "current"
    horizontalAlignment: Text.AlignHCenter
    movable: false
    resizable: false
    width: 100
    }

    TableViewColumn {
    id: rpmColumn
    title: "RPM"
    role: "rpm"
    horizontalAlignment: Text.AlignHCenter
    movable: false
    resizable: false
    width: 100
    }

    TableViewColumn {
    id: speedColumn
    title: "Speed"
    role: "speed"
    horizontalAlignment: Text.AlignHCenter
    movable: false
    resizable: false
    width: 100
    }

    TableViewColumn {
    id: odoColumn
    title: "ODO"
    role: "odo"
    horizontalAlignment: Text.AlignHCenter
    movable: false
    resizable: false
    width: 100
    }

    TableViewColumn {
    id: socColumn
    title: "SOC"
    role: "soc"
    horizontalAlignment: Text.AlignHCenter
    movable: false
    resizable: false
    width: 100
    }

    TableViewColumn {
    id: raColumn
    title: "Range Est."
    role: "ra"
    horizontalAlignment: Text.AlignHCenter
    movable: false
    resizable: false
    width: 100
    }

    TableViewColumn {
    id: apColumn
    title: "Air Pressure"
    role: "ap"
    horizontalAlignment: Text.AlignHCenter
    movable: false
    resizable: false
    width: 100
    }

    TableViewColumn {
    id: bmsErrorCodeColumn
    title: "BMS Error Code"
    role: "bms_errorCode"
    horizontalAlignment: Text.AlignHCenter
    movable: false
    resizable: false
    width: 100
    }

    TableViewColumn {
    id: dtcColumn
    title: "DTC"
    role: "dtc"
    horizontalAlignment: Text.AlignHCenter
    movable: false
    resizable: false
    width: 100
    }

    TableViewColumn {
    id: inclinationColumn
    title: "Inclination"
    role: "inclination"
    horizontalAlignment: Text.AlignHCenter
    movable: false
    resizable: false
    width: 100
    }

    TableViewColumn {
    id: v24VoltageColumn
    title: "24V Voltage"
    role: "Voltage24v"
    horizontalAlignment: Text.AlignHCenter
    movable: false
    resizable: false
    width: 100
    }

    TableViewColumn {
    id: cellLowestVLocationColumn
    title: "Cell Lowest Voltage Loc."
    role: "cellLowestVLocation"
    horizontalAlignment: Text.AlignHCenter
    movable: false
    resizable: true
    width: 200
    }

    TableViewColumn {
    id: cellLowestVColumn
    title: "Cell Lowest Voltage"
    role: "cellLowestV"
    horizontalAlignment: Text.AlignHCenter
    movable: false
    resizable: false
    width: 200
    }

    TableViewColumn {
    id: cellHighestVLocationColumn
    title: "Cell Highest Voltage Loc."
    role: "cellHighestVLocation"
    horizontalAlignment: Text.AlignHCenter
    movable: false
    resizable: true
    width: 200
    }

    TableViewColumn {
    id: cellHighestVColumn
    title: "Cell Highest Voltage"
    role: "cellHighestV"
    horizontalAlignment: Text.AlignHCenter
    movable: false
    resizable: false
    width: 200
    }

    TableViewColumn {
    id: htLocationColumn
    title: "Highest Temperature Loc."
    role: "htLoc"
    horizontalAlignment: Text.AlignHCenter
    movable: false
    resizable: true
    width: 200
    }

    TableViewColumn {
    id: htColumn
    title: "Highest Temperature"
    role: "ht"
    horizontalAlignment: Text.AlignHCenter
    movable: false
    resizable: false
    width: 200
    }

 	 TableViewColumn {
 	 id: v1Column
 	 title: "V1"
 	 role: "v1"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v2Column
 	 title: "V2"
 	 role: "v2"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v3Column
 	 title: "V3"
 	 role: "v3"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v4Column
 	 title: "V4"
 	 role: "v4"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v5Column
 	 title: "V5"
 	 role: "v5"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v6Column
 	 title: "V6"
 	 role: "v6"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v7Column
 	 title: "V7"
 	 role: "v7"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v8Column
 	 title: "V8"
 	 role: "v8"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v9Column
 	 title: "V9"
 	 role: "v9"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v10Column
 	 title: "V10"
 	 role: "v10"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v11Column
 	 title: "V11"
 	 role: "v11"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v12Column
 	 title: "V12"
 	 role: "v12"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v13Column
 	 title: "V13"
 	 role: "v13"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v14Column
 	 title: "V14"
 	 role: "v14"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v15Column
 	 title: "V15"
 	 role: "v15"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v16Column
 	 title: "V16"
 	 role: "v16"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v17Column
 	 title: "V17"
 	 role: "v17"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v18Column
 	 title: "V18"
 	 role: "v18"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v19Column
 	 title: "V19"
 	 role: "v19"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v20Column
 	 title: "V20"
 	 role: "v20"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v21Column
 	 title: "V21"
 	 role: "v21"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v22Column
 	 title: "V22"
 	 role: "v22"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v23Column
 	 title: "V23"
 	 role: "v23"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v24Column
 	 title: "V24"
 	 role: "v24"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v25Column
 	 title: "V25"
 	 role: "v25"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v26Column
 	 title: "V26"
 	 role: "v26"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v27Column
 	 title: "V27"
 	 role: "v27"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v28Column
 	 title: "V28"
 	 role: "v28"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v29Column
 	 title: "V29"
 	 role: "v29"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v30Column
 	 title: "V30"
 	 role: "v30"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v31Column
 	 title: "V31"
 	 role: "v31"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v32Column
 	 title: "V32"
 	 role: "v32"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v33Column
 	 title: "V33"
 	 role: "v33"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v34Column
 	 title: "V34"
 	 role: "v34"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v35Column
 	 title: "V35"
 	 role: "v35"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v36Column
 	 title: "V36"
 	 role: "v36"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v37Column
 	 title: "V37"
 	 role: "v37"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v38Column
 	 title: "V38"
 	 role: "v38"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v39Column
 	 title: "V39"
 	 role: "v39"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v40Column
 	 title: "V40"
 	 role: "v40"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v41Column
 	 title: "V41"
 	 role: "v41"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v42Column
 	 title: "V42"
 	 role: "v42"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v43Column
 	 title: "V43"
 	 role: "v43"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v44Column
 	 title: "V44"
 	 role: "v44"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v45Column
 	 title: "V45"
 	 role: "v45"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v46Column
 	 title: "V46"
 	 role: "v46"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v47Column
 	 title: "V47"
 	 role: "v47"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v48Column
 	 title: "V48"
 	 role: "v48"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v49Column
 	 title: "V49"
 	 role: "v49"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v50Column
 	 title: "V50"
 	 role: "v50"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v51Column
 	 title: "V51"
 	 role: "v51"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v52Column
 	 title: "V52"
 	 role: "v52"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v53Column
 	 title: "V53"
 	 role: "v53"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v54Column
 	 title: "V54"
 	 role: "v54"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v55Column
 	 title: "V55"
 	 role: "v55"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v56Column
 	 title: "V56"
 	 role: "v56"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v57Column
 	 title: "V57"
 	 role: "v57"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v58Column
 	 title: "V58"
 	 role: "v58"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v59Column
 	 title: "V59"
 	 role: "v59"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v60Column
 	 title: "V60"
 	 role: "v60"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v61Column
 	 title: "V61"
 	 role: "v61"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v62Column
 	 title: "V62"
 	 role: "v62"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v63Column
 	 title: "V63"
 	 role: "v63"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v64Column
 	 title: "V64"
 	 role: "v64"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v65Column
 	 title: "V65"
 	 role: "v65"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v66Column
 	 title: "V66"
 	 role: "v66"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v67Column
 	 title: "V67"
 	 role: "v67"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v68Column
 	 title: "V68"
 	 role: "v68"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v69Column
 	 title: "V69"
 	 role: "v69"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v70Column
 	 title: "V70"
 	 role: "v70"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v71Column
 	 title: "V71"
 	 role: "v71"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v72Column
 	 title: "V72"
 	 role: "v72"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v73Column
 	 title: "V73"
 	 role: "v73"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v74Column
 	 title: "V74"
 	 role: "v74"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v75Column
 	 title: "V75"
 	 role: "v75"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v76Column
 	 title: "V76"
 	 role: "v76"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v77Column
 	 title: "V77"
 	 role: "v77"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v78Column
 	 title: "V78"
 	 role: "v78"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v79Column
 	 title: "V79"
 	 role: "v79"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v80Column
 	 title: "V80"
 	 role: "v80"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v81Column
 	 title: "V81"
 	 role: "v81"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v82Column
 	 title: "V82"
 	 role: "v82"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v83Column
 	 title: "V83"
 	 role: "v83"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v84Column
 	 title: "V84"
 	 role: "v84"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v85Column
 	 title: "V85"
 	 role: "v85"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v86Column
 	 title: "V86"
 	 role: "v86"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v87Column
 	 title: "V87"
 	 role: "v87"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v88Column
 	 title: "V88"
 	 role: "v88"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v89Column
 	 title: "V89"
 	 role: "v89"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v90Column
 	 title: "V90"
 	 role: "v90"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v91Column
 	 title: "V91"
 	 role: "v91"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v92Column
 	 title: "V92"
 	 role: "v92"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v93Column
 	 title: "V93"
 	 role: "v93"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v94Column
 	 title: "V94"
 	 role: "v94"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v95Column
 	 title: "V95"
 	 role: "v95"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v96Column
 	 title: "V96"
 	 role: "v96"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v97Column
 	 title: "V97"
 	 role: "v97"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v98Column
 	 title: "V98"
 	 role: "v98"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v99Column
 	 title: "V99"
 	 role: "v99"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v100Column
 	 title: "V100"
 	 role: "v100"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v101Column
 	 title: "V101"
 	 role: "v101"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v102Column
 	 title: "V102"
 	 role: "v102"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v103Column
 	 title: "V103"
 	 role: "v103"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v104Column
 	 title: "V104"
 	 role: "v104"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v105Column
 	 title: "V105"
 	 role: "v105"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v106Column
 	 title: "V106"
 	 role: "v106"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v107Column
 	 title: "V107"
 	 role: "v107"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v108Column
 	 title: "V108"
 	 role: "v108"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v109Column
 	 title: "V109"
 	 role: "v109"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v110Column
 	 title: "V110"
 	 role: "v110"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v111Column
 	 title: "V111"
 	 role: "v111"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v112Column
 	 title: "V112"
 	 role: "v112"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v113Column
 	 title: "V113"
 	 role: "v113"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v114Column
 	 title: "V114"
 	 role: "v114"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v115Column
 	 title: "V115"
 	 role: "v115"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v116Column
 	 title: "V116"
 	 role: "v116"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v117Column
 	 title: "V117"
 	 role: "v117"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v118Column
 	 title: "V118"
 	 role: "v118"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v119Column
 	 title: "V119"
 	 role: "v119"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v120Column
 	 title: "V120"
 	 role: "v120"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v121Column
 	 title: "V121"
 	 role: "v121"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v122Column
 	 title: "V122"
 	 role: "v122"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v123Column
 	 title: "V123"
 	 role: "v123"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v124Column
 	 title: "V124"
 	 role: "v124"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v125Column
 	 title: "V125"
 	 role: "v125"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v126Column
 	 title: "V126"
 	 role: "v126"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v127Column
 	 title: "V127"
 	 role: "v127"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v128Column
 	 title: "V128"
 	 role: "v128"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v129Column
 	 title: "V129"
 	 role: "v129"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v130Column
 	 title: "V130"
 	 role: "v130"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v131Column
 	 title: "V131"
 	 role: "v131"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v132Column
 	 title: "V132"
 	 role: "v132"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v133Column
 	 title: "V133"
 	 role: "v133"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v134Column
 	 title: "V134"
 	 role: "v134"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v135Column
 	 title: "V135"
 	 role: "v135"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v136Column
 	 title: "V136"
 	 role: "v136"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v137Column
 	 title: "V137"
 	 role: "v137"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v138Column
 	 title: "V138"
 	 role: "v138"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v139Column
 	 title: "V139"
 	 role: "v139"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v140Column
 	 title: "V140"
 	 role: "v140"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v141Column
 	 title: "V141"
 	 role: "v141"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v142Column
 	 title: "V142"
 	 role: "v142"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v143Column
 	 title: "V143"
 	 role: "v143"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v144Column
 	 title: "V144"
 	 role: "v144"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v145Column
 	 title: "V145"
 	 role: "v145"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v146Column
 	 title: "V146"
 	 role: "v146"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v147Column
 	 title: "V147"
 	 role: "v147"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v148Column
 	 title: "V148"
 	 role: "v148"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v149Column
 	 title: "V149"
 	 role: "v149"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v150Column
 	 title: "V150"
 	 role: "v150"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v151Column
 	 title: "V151"
 	 role: "v151"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v152Column
 	 title: "V152"
 	 role: "v152"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v153Column
 	 title: "V153"
 	 role: "v153"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v154Column
 	 title: "V154"
 	 role: "v154"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v155Column
 	 title: "V155"
 	 role: "v155"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v156Column
 	 title: "V156"
 	 role: "v156"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v157Column
 	 title: "V157"
 	 role: "v157"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v158Column
 	 title: "V158"
 	 role: "v158"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v159Column
 	 title: "V159"
 	 role: "v159"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v160Column
 	 title: "V160"
 	 role: "v160"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v161Column
 	 title: "V161"
 	 role: "v161"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v162Column
 	 title: "V162"
 	 role: "v162"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v163Column
 	 title: "V163"
 	 role: "v163"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v164Column
 	 title: "V164"
 	 role: "v164"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v165Column
 	 title: "V165"
 	 role: "v165"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v166Column
 	 title: "V166"
 	 role: "v166"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v167Column
 	 title: "V167"
 	 role: "v167"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: v168Column
 	 title: "V168"
 	 role: "v168"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }

 	 TableViewColumn {
 	 id: inletWTemp
 	 title: "Inlet Water Tank Temp."
 	 role: "inletWaterTankTemp"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }

 	 TableViewColumn {
 	 id: onletWTemp
 	 title: "Outlet Water Tank Temp."
 	 role: "outletWaterTankTemp"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }

 	 TableViewColumn {
 	 id: mTemp
 	 title: "Motor Temp."
 	 role: "motorTemp"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: t1Column
 	 title: "T1"
 	 role: "t1"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 100
 	 }

 	 TableViewColumn {
 	 id: t2Column
 	 title: "T2"
 	 role: "t2"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 100
 	 }

 	 TableViewColumn {
 	 id: t3Column
 	 title: "T3"
 	 role: "t3"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 100
 	 }

 	 TableViewColumn {
 	 id: t4Column
 	 title: "T4"
 	 role: "t4"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 100
 	 }

 	 TableViewColumn {
 	 id: t5Column
 	 title: "T5"
 	 role: "t5"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 100
 	 }

 	 TableViewColumn {
 	 id: t6Column
 	 title: "T6"
 	 role: "t6"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 100
 	 }

 	 TableViewColumn {
 	 id: t7Column
 	 title: "T7"
 	 role: "t7"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 100
 	 }

 	 TableViewColumn {
 	 id: t8Column
 	 title: "T8"
 	 role: "t8"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 100
 	 }

 	 TableViewColumn {
 	 id: t9Column
 	 title: "T9"
 	 role: "t9"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 100
 	 }

 	 TableViewColumn {
 	 id: t10Column
 	 title: "T10"
 	 role: "t10"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 100
 	 }

 	 TableViewColumn {
 	 id: t11Column
 	 title: "T11"
 	 role: "t11"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 100
 	 }

 	 TableViewColumn {
 	 id: t12Column
 	 title: "T12"
 	 role: "t12"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 100
 	 }

 	 TableViewColumn {
 	 id: t13Column
 	 title: "T13"
 	 role: "t13"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 100
 	 }

 	 TableViewColumn {
 	 id: t14Column
 	 title: "T14"
 	 role: "t14"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 100
 	 }

 	 TableViewColumn {
 	 id: t15Column
 	 title: "T15"
 	 role: "t15"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 100
 	 }

 	 TableViewColumn {
 	 id: t16Column
 	 title: "T16"
 	 role: "t16"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 100
 	 }

 	 TableViewColumn {
 	 id: t17Column
 	 title: "T17"
 	 role: "t17"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 100
 	 }

 	 TableViewColumn {
 	 id: t18Column
 	 title: "T18"
 	 role: "t18"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 100
 	 }

 	 TableViewColumn {
 	 id: t19Column
 	 title: "T19"
 	 role: "t19"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 100
 	 }

 	 TableViewColumn {
 	 id: t20Column
 	 title: "T20"
 	 role: "t20"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 100
 	 }

 	 TableViewColumn {
 	 id: t21Column
 	 title: "T21"
 	 role: "t21"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 100
 	 }

 	 TableViewColumn {
 	 id: t22Column
 	 title: "T22"
 	 role: "t22"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 100
 	 }

 	 TableViewColumn {
 	 id: t23Column
 	 title: "T23"
 	 role: "t23"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 100
 	 }

 	 TableViewColumn {
 	 id: t24Column
 	 title: "T24"
 	 role: "t24"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 100
 	 }

 	 TableViewColumn {
 	 id: t25Column
 	 title: "T25"
 	 role: "t25"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 100
 	 }

 	 TableViewColumn {
 	 id: t26Column
 	 title: "T26"
 	 role: "t26"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 100
 	 }

 	 TableViewColumn {
 	 id: t27Column
 	 title: "T27"
 	 role: "t27"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 100
 	 }

 	 TableViewColumn {
 	 id: t28Column
 	 title: "T28"
 	 role: "t28"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 100
 	 }

 	 TableViewColumn {
 	 id: t29Column
 	 title: "T29"
 	 role: "t29"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 100
 	 }

 	 TableViewColumn {
 	 id: t30Column
 	 title: "T30"
 	 role: "t30"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 100
 	 }

 	 TableViewColumn {
 	 id: t31Column
 	 title: "T31"
 	 role: "t31"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 100
 	 }

 	 TableViewColumn {
 	 id: t32Column
 	 title: "T32"
 	 role: "t32"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 100
 	 }

 	 TableViewColumn {
 	 id: t33Column
 	 title: "T33"
 	 role: "t33"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 100
 	 }

 	 TableViewColumn {
 	 id: t34Column
 	 title: "T34"
 	 role: "t34"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 100
 	 }

 	 TableViewColumn {
 	 id: t35Column
 	 title: "T35"
 	 role: "t35"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 100
 	 }

 	 TableViewColumn {
 	 id: t36Column
 	 title: "T36"
 	 role: "t36"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 100
 	 }

 	 TableViewColumn {
 	 id: t37Column
 	 title: "T37"
 	 role: "t37"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 100
 	 }

 	 TableViewColumn {
 	 id: t38Column
 	 title: "T38"
 	 role: "t38"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 100
 	 }

 	 TableViewColumn {
 	 id: t39Column
 	 title: "T39"
 	 role: "t39"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 100
 	 }

 	 TableViewColumn {
 	 id: t40Column
 	 title: "T40"
 	 role: "t40"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 100
 	 }

 	 TableViewColumn {
 	 id: t41Column
 	 title: "T41"
 	 role: "t41"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 100
 	 }

 	 TableViewColumn {
 	 id: t42Column
 	 title: "T42"
 	 role: "t42"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 100
 	 }

 	 TableViewColumn {
 	 id: t43Column
 	 title: "T43"
 	 role: "t43"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 100
 	 }

 	 TableViewColumn {
 	 id: t44Column
 	 title: "T44"
 	 role: "t44"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 100
 	 }

 	 TableViewColumn {
 	 id: t45Column
 	 title: "T45"
 	 role: "t45"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 100
 	 }

 	 TableViewColumn {
 	 id: t46Column
 	 title: "T46"
 	 role: "t46"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 100
 	 }

 	 TableViewColumn {
 	 id: t47Column
 	 title: "T47"
 	 role: "t47"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 100
 	 }

 	 TableViewColumn {
 	 id: t48Column
 	 title: "T48"
 	 role: "t48"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 150
 	 }

 	 TableViewColumn {
 	 id: rTorqueColumn
 	 title: "Rotation Torque"
 	 role: "rtorque"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 150
 	 }

 	 TableViewColumn {
 	 id: gearStateColumn
 	 title: "Gear State"
 	 role: "gearState"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 100
 	 }

 	 TableViewColumn {
 	 id: bcuIoStatus1Column
 	 title: "BCU IO Status 1"
 	 role: "bcuIOStatus1"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 150
 	 }

 	 TableViewColumn {
 	 id: bcuIoStatus2Column
 	 title: "BCU IO Status 2"
 	 role: "bcuIOStatus2"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 150
 	 }

 	 TableViewColumn {
 	 id: bcuIoStatus3Column
 	 title: "BCU IO Status 3"
 	 role: "bcuIOStatus3"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 150
 	 }

 	 TableViewColumn {
 	 id: bcuIoStatus4Column
 	 title: "BCU IO Status 4"
 	 role: "bcuIOStatus4"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 150
 	 }

 	 TableViewColumn {
 	 id: bcuIoStatus5Column
 	 title: "BCU IO Status 5"
 	 role: "bcuIOStatus5"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 150
 	 }

 	 TableViewColumn {
 	 id: bcuIoStatus6Column
 	 title: "BCU IO Status 6"
 	 role: "bcuIOStatus6"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 150
 	 }

 	 TableViewColumn {
 	 id: bcuIoStatus7Column
 	 title: "BCU IO Status 7"
 	 role: "bcuIOStatus7"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 150
 	 }

 	 TableViewColumn {
 	 id: bcuIoStatus8Column
 	 title: "BCU IO Status 8"
 	 role: "bcuIOStatus8"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 150
 	 }


 	 TableViewColumn {
 	 id: bcuSmokeDetectStatus1Column
 	 title: "BCU Smoke Detect Status 1"
 	 role: "bcuSmokeDetectStatus1"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 250
 	 }

 	 TableViewColumn {
 	 id: bcuSmokeDetectStatus2Column
 	 title: "BCU Smoke Detect Status 2"
 	 role: "bcuSmokeDetectStatus2"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 250
 	 }

 	 TableViewColumn {
 	 id: bcuSmokeDetectStatus3Column
 	 title: "BCU Smoke Detect Status 3"
 	 role: "bcuSmokeDetectStatus3"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 250
 	 }

 	 TableViewColumn {
 	 id: bcuSmokeDetectStatus4Column
 	 title: "BCU Smoke Detect Status 4"
 	 role: "bcuSmokeDetectStatus4"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 250
 	 }

 	 TableViewColumn {
 	 id: bcuSmokeDetectStatus5Column
 	 title: "BCU Smoke Detect Status 5"
 	 role: "bcuSmokeDetectStatus5"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 250
 	 }

 	 TableViewColumn {
 	 id: bcuSmokeDetectStatus6Column
 	 title: "BCU Smoke Detect Status 6"
 	 role: "bcuSmokeDetectStatus6"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 250
 	 }

 	 TableViewColumn {
 	 id: bcuSmokeDetectStatus7Column
 	 title: "BCU Smoke Detect Status 7"
 	 role: "bcuSmokeDetectStatus7"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 250
 	 }

 	 TableViewColumn {
 	 id: bcuSmokeDetectStatus8Column
 	 title: "BCU Smoke Detect Status 8"
 	 role: "bcuSmokeDetectStatus8"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 250
 	 }

 	 TableViewColumn {
 	 id: vcuIoStatus1Column
 	 title: "VCU IO Status 1"
 	 role: "vcuIOStatus1"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 150
 	 }

 	 TableViewColumn {
 	 id: vcuIoStatus2Column
 	 title: "VCU IO Status 2"
 	 role: "vcuIOStatus2"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 150
 	 }

 	 TableViewColumn {
 	 id: vcuIoStatus3Column
 	 title: "VCU IO Status 3"
 	 role: "vcuIOStatus3"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 150
 	 }

 	 TableViewColumn {
 	 id: vcuIoStatus4Column
 	 title: "VCU IO Status 4"
 	 role: "vcuIOStatus4"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 150
 	 }

 	 TableViewColumn {
 	 id: vcuIoStatus5Column
 	 title: "VCU IO Status 5"
 	 role: "vcuIOStatus5"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 150
 	 }

 	 TableViewColumn {
 	 id: vcuIoStatus6Column
 	 title: "VCU IO Status 6"
 	 role: "vcuIOStatus6"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 150
 	 }

 	 TableViewColumn {
 	 id: vcuIoStatus7Column
 	 title: "VCU IO Status 7"
 	 role: "vcuIOStatus7"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 150
 	 }

 	 TableViewColumn {
 	 id: vcuIoStatus8Column
 	 title: "VCU IO Status 8"
 	 role: "vcuIOStatus8"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 150
 	 }


 	 TableViewColumn {
 	 id: pcuIoStatus1Column
 	 title: "PCU IO Status 1"
 	 role: "pcuIOStatus1"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }

 	 TableViewColumn {
 	 id: pcuIoStatus2Column
 	 title: "PCU IO Status 2"
 	 role: "pcuIOStatus2"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }

 	 TableViewColumn {
 	 id: pcuIoStatus3Column
 	 title: "PCU IO Status 3"
 	 role: "pcuIOStatus3"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }

 	 TableViewColumn {
 	 id: pcuIoStatus4Column
 	 title: "PCU IO Status 4"
 	 role: "pcuIOStatus4"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }

 	 TableViewColumn {
 	 id: pcuIoStatus5Column
 	 title: "PCU IO Status 5"
 	 role: "pcuIOStatus5"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }

 	 TableViewColumn {
 	 id: pcuIoStatus6Column
 	 title: "PCU IO Status 6"
 	 role: "pcuIOStatus6"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }

 	 TableViewColumn {
 	 id: pcuIoStatus7Column
 	 title: "PCU IO Status 7"
 	 role: "pcuIOStatus7"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }

 	 TableViewColumn {
 	 id: pcuIoStatus8Column
 	 title: "PCU IO Status 8"
 	 role: "pcuIOStatus8"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }

 	 TableViewColumn {
 	 id: brakeSignalStatusColumn
 	 title: "Brake Signal Status"
 	 role: "brakeSignalStatus"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }

 	 TableViewColumn {
 	 id: doorPedalStatusColumn
 	 title: "Door Pedal Status"
 	 role: "doorPedalStatus"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }

 	 TableViewColumn {
 	 id: doorPedalDepthStatusColumn
 	 title: "Door Pedal Depth Status"
 	 role: "doorPedalDepthStatus"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }

 	 TableViewColumn {
 	 id: mainDriverTotalRtColumn
 	 title: "Main Driver Total Run Time"
 	 role: "mainDriverTotalRuntime"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }

 	 TableViewColumn {
 	 id: mainMotorTotalRtColumn
 	 title: "Main Motor Total Run Time"
 	 role: "mainMotorTotalRuntime"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }

 	 TableViewColumn {
 	 id: airDriverTotalRtColumn
 	 title: "Air Driver Total Run Time"
 	 role: "airDriverTotalRuntime"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }

 	 TableViewColumn {
 	 id: airMotorTotalRtColumn
 	 title: "Air Motor Total Run Time"
 	 role: "airMotorTotalRuntime"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }

 	 TableViewColumn {
 	 id: hydraulicDriverTotalRtColumn
 	 title: "Hydraulic Driver Total Run Time"
 	 role: "hydraulicDriverTotalRuntime"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }

 	 TableViewColumn {
 	 id: hydraulicMotorTotalRtColumn
 	 title: "Hydraulic Motor Total Run Time"
 	 role: "hydraulicMotorTotalRuntime"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: outdoorTemperatureColumn
 	 title: "Outdoor Temperature"
 	 role: "outdoorTemperature"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }

 	 TableViewColumn {
 	 id: airConditionColumn
 	 title: "Air Condition"
 	 role: "airCondition"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }

 	 TableViewColumn {
 	 id: alarmCodeColumn
 	 title: "Alarm Code"
 	 role: "alarmCode"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }


 	 TableViewColumn {
 	 id: remainingCapacityColumn
 	 title: "Remaining Capacity"
 	 role: "remainingCapacity"
 	 horizontalAlignment: Text.AlignHCenter
 	 movable: false
 	 resizable: false
 	 width: 200
 	 }

    ListModel {
        id: sourceModel
        ListElement {
	    localtime: "2019/06/10"
	    utctime: "19:10:15"
	    longitude: "153.0"
	    latitude: "25.1234"
	    gpsMileage: "999"
	    lumpedV: "700"
	    current: "70"
	    rpm: "2500"
	    speed: "70"
	    odo: "ON"
	    soc: "87%"
	    ra: "351KM"
	    ap: "10"
	    bms_errorCode: "0"
	    dtc: "0"
	    inclination: "10"
	    Voltage24v: "23.5"
	    cellLowestVLocation: "location"
	    cellLowestV: "3.9"
	    cellHighestVLocation: "location H"
	    cellHighestV: "4.2"
	    htLoc: "cell3"
	    ht: "56"
            v1: ""
            v2: ""
            v3: ""
            v4: ""
            v5: ""
            v6: ""
            v7: ""
            v8: ""
            v9: ""
            v10: ""
            v11: ""
            v12: ""
            v13: ""
            v14: ""
            v15: ""
            v16: ""
            v17: ""
            v18: ""
            v19: ""
            v20: ""
            v21: ""
            v22: ""
            v23: ""
            v24: ""
            v25: ""
            v26: ""
            v27: ""
            v28: ""
            v29: ""
            v30: ""
            v31: ""
            v32: ""
            v33: ""
            v34: ""
            v35: ""
            v36: ""
            v37: ""
            v38: ""
            v39: ""
            v40: ""
            v41: ""
            v42: ""
            v43: ""
            v44: ""
            v45: ""
            v46: ""
            v47: ""
            v48: ""
            v49: ""
            v50: ""
            v51: ""
            v52: ""
            v53: ""
            v54: ""
            v55: ""
            v56: ""
            v57: ""
            v58: ""
            v59: ""
            v60: ""
            v61: ""
            v62: ""
            v63: ""
            v64: ""
            v65: ""
            v66: ""
            v67: ""
            v68: ""
            v69: ""
            v70: ""
            v71: ""
            v72: ""
            v73: ""
            v74: ""
            v75: ""
            v76: ""
            v77: ""
            v78: ""
            v79: ""
            v80: ""
            v81: ""
            v82: ""
            v83: ""
            v84: ""
            v85: ""
            v86: ""
            v87: ""
            v88: ""
            v89: ""
            v90: ""
            v91: ""
            v92: ""
            v93: ""
            v94: ""
            v95: ""
            v96: ""
            v97: ""
            v98: ""
            v99: ""
            v100: ""
            v101: ""
            v102: ""
            v103: ""
            v104: ""
            v105: ""
            v106: ""
            v107: ""
            v108: ""
            v109: ""
            v110: ""
            v111: ""
            v112: ""
            v113: ""
            v114: ""
            v115: ""
            v116: ""
            v117: ""
            v118: ""
            v119: ""
            v120: ""
            v121: ""
            v122: ""
            v123: ""
            v124: ""
            v125: ""
            v126: ""
            v127: ""
            v128: ""
            v129: ""
            v130: ""
            v131: ""
            v132: ""
            v133: ""
            v134: ""
            v135: ""
            v136: ""
            v137: ""
            v138: ""
            v139: ""
            v140: ""
            v141: ""
            v142: ""
            v143: ""
            v144: ""
            v145: ""
            v146: ""
            v147: ""
            v148: ""
            v149: ""
            v150: ""
            v151: ""
            v152: ""
            v153: ""
            v154: ""
            v155: ""
            v156: ""
            v157: ""
            v158: ""
            v159: ""
            v160: ""
            v161: ""
            v162: ""
            v163: ""
            v164: ""
            v165: ""
            v166: ""
            v167: ""
            v168: ""
	    inletWaterTankTemp: "26"
	    outletWaterTankTemp: "56"
	    motorTemp: "86"
            t1: ""
            t2: ""
            t3: ""
            t4: ""
            t5: ""
            t6: ""
            t7: ""
            t8: ""
            t9: ""
            t10: ""
            t11: ""
            t12: ""
            t13: ""
            t14: ""
            t15: ""
            t16: ""
            t17: ""
            t18: ""
            t19: ""
            t20: ""
            t21: ""
            t22: ""
            t23: ""
            t24: ""
            t25: ""
            t26: ""
            t27: ""
            t28: ""
            t29: ""
            t30: ""
            t31: ""
            t32: ""
            t33: ""
            t34: ""
            t35: ""
            t36: ""
            t37: ""
            t38: ""
            t39: ""
            t40: ""
            t41: ""
            t42: ""
            t43: ""
            t44: ""
            t45: ""
            t46: ""
            t47: ""
            t48: ""
	    rtorque: ""
	    gearState: ""
            bcuIOStatus1: ""
            bcuIOStatus2: ""
            bcuIOStatus3: ""
            bcuIOStatus4: ""
            bcuIOStatus5: ""
            bcuIOStatus6: ""
            bcuIOStatus7: ""
            bcuIOStatus8: ""
            bcuSmokeDetectStatus1: ""
            bcuSmokeDetectStatus2: ""
            bcuSmokeDetectStatus3: ""
            bcuSmokeDetectStatus4: ""
            bcuSmokeDetectStatus5: ""
            bcuSmokeDetectStatus6: ""
            bcuSmokeDetectStatus7: ""
            bcuSmokeDetectStatus8: ""
            vcuIOStatus1: ""
            vcuIOStatus2: ""
            vcuIOStatus3: ""
            vcuIOStatus4: ""
            vcuIOStatus5: ""
            vcuIOStatus6: ""
            vcuIOStatus7: ""
            vcuIOStatus8: ""
            pcuIOStatus1: ""
            pcuIOStatus2: ""
            pcuIOStatus3: ""
            pcuIOStatus4: ""
            pcuIOStatus5: ""
            pcuIOStatus6: ""
            pcuIOStatus7: ""
            pcuIOStatus8: ""
	    brakeSignalStatus: ""
	    doorPedalStatus: ""
	    doorPedalDepthStatus: ""
	    mainDriverTotalRuntime: ""
	    mainMotorTotalRuntime: ""
	    airDriverTotalRuntime: ""
	    airMotorTotalRuntime: ""
	    hydraulicDriverTotalRuntime: ""
	    hydraulicMotorTotalRuntime: ""
	    outdoorTemperature: ""
	    airCondition: ""
	    alarmCode: ""
	    remainingCapacity: ""
        }
        Component.onCompleted: {
        tableView.resizeAllColumns();
        console.debug("test1");
        }
    }
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

    ComboBox {
        id: cboRecord
        x: 400
        y: 30
        width: 400
        height: 43
	model: [ "Day1.csv", "Day2.csv", "Day3.csv" ]
	style: ComboBoxStyle {
	    background: Rectangle{
		height: control.height
		width: control.width
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

    onActiveChanged : {
    if ( true === vehicleInfoRecord.active ) {
        vehicleInfoRecord.qmlSignalActive("vehicleInfoRecord");
    }
    }
    Component.onCompleted: {
    tableView.resizeAllColumns();
    console.debug("test2");
    }

}
