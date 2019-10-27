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
    id: alarmStat

    // ( https://goo.gl/LWbdMG )
    objectName: "alarmStatisticsWin"

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
    property alias window: alarmStat
    flags: Qt.FramelessWindowHint
    title: "Alarm Statistics"

    // Property names must begin with a lower case letter
    // and can only contain letters ( https://goo.gl/HzLQet )
    //
    //property string batteryPackName
    signal qmlSignal(string msg)
    signal qmlSignalActive(string msg)

    Rectangle {
        id: rectanglealarmStat
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
        id: imageBackAlarmStat
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
        source: "../../images/0-color/HMI-ICON-55.png"
        fillMode: Image.PreserveAspectFit
    MouseArea {
        id: maViBack
        z: 2
        anchors.fill: parent
        onClicked: {
        alarmStat.hide();
        }
    }
    }

    Rectangle {
        id: rowalarmStat
        x: 200
        y: 30
        width: 300
        height: 43
	color: "#161616"
        anchors.leftMargin: 50
        Text {
            id: txtalarmStat
            y: 0
            width: 100
            height: 43
            color: "#ffffff"
            text: qsTr("Alarm Statistics")
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
	id: tableViewAlarmStat
	x: 0
	width: 1280
	height: 641
	anchors.top: imageBackAlarmStat.bottom
	anchors.topMargin: 0
	anchors.horizontalCenter: parent.horizontalCenter

	frameVisible: true
	sortIndicatorVisible: false

	Layout.minimumWidth: 400
	Layout.minimumHeight: 240
	Layout.preferredWidth: 600
	Layout.preferredHeight: 400
	// horizontalScrollBarPolicy : Qt.ScrollBarAlwaysOn
	verticalScrollBarPolicy : Qt.ScrollBarAlwaysOn
	model: sourceModel

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
	id: alarmColumn
	title: "Alarm No."
	role: "alm_no"
	horizontalAlignment: Text.AlignHCenter
	movable: false
	resizable: false
	width: 120
	}

	TableViewColumn {
	id: contentColumn
	title: "Content"
	role: "content"
	horizontalAlignment: Text.AlignHCenter
	movable: false
	resizable: false
	width: 400
	}

	TableViewColumn {
	id: countColumn
	title: "Count"
	role: "count"
	horizontalAlignment: Text.AlignHCenter
	movable: false
	resizable: false
	width: 120
	}

	ListModel {
	    id: sourceModel
	    ListElement {
		alm_no: "663"
		content: "PCU Fault No.64 B相欠相"
		count: "1"
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

    onActiveChanged : {
    if ( true === alarmStat.active ) {
        alarmStat.qmlSignalActive("AlarmStatistics");
    }
    }

    Component.onCompleted: {
	console.log("alarm stat completed");
    }

}
