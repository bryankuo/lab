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
import Backend 1.0
import "../style"

Window {
    id: alarm

    // ( https://goo.gl/LWbdMG )
    objectName: "alarmWindow"

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
    property alias window: alarm
    flags: Qt.FramelessWindowHint
    title: ""

    // Property names must begin with a lower case letter
    // and can only contain letters ( https://goo.gl/HzLQet )
    //
    signal qmlSignalActive(string msg)
    signal checkedChanged(int row, int col, bool cheked)

    function addElement(idx, dp, rec, bps, voice0, content0) {
    // add ListElement ( https://tinyurl.com/y5yddnqk )
    contactModel.append(
        { alarm_no:idx,display:dp,record:rec,
          beeps:bps,voice:voice0,content:content0,changed:0});
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
        MouseArea {
            id: mouseAreaRectangleAll
            z: 2
            anchors.fill: parent
            onClicked: {
                engineering.hide();
            }
        }
    }

    Image {
        id: imgBack
        width: style.backWidth
	height: style.backHeight
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.topMargin: 0
        z: 1
        anchors.top: parent.top
        source: "../../images/0-color/HMI-ICON-55.png"
        fillMode: Image.PreserveAspectFit
        MouseArea {
            id: mouseAreaStatusBack
            z: 2
            anchors.fill: parent
            onClicked: {
                alarm.hide();
            }
        }
    }

    Rectangle {
        id: rowAlarm
        x: 200
        y: 30
        width: 300
        height: 43
        color: "#161616"
        anchors.leftMargin: 50
        Text {
            id: txtalarmWinCaption
            y: 0
            width: 250
            height: 43
            color: "#ffffff"
            text: qsTr("Alarm Parameters")
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
    id: btnRefreshAlarmRecord
    x: 940
    y: 30
    //width: 100
    //height: 43
    text: qsTr("REFRESH")
    anchors.right: btnSave.left
    anchors.rightMargin: 10
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
        id: btnSave
        x: 1056
        y: 30
        text: qsTr("SAVE")
        anchors.right: imgBack.left
        anchors.rightMargin: 10
        enabled: false
        anchors.leftMargin: 180
        style: ButtonStyle {
            background: Rectangle {
                radius: 4
                border.width: control.activeFocus ? 2 : 1
                gradient: Gradient {
                    GradientStop {
                        position: 0
                        color: control.pressed ? "#ccc" : "#eee"
                    }

                    GradientStop {
                        position: 1
                        color: control.pressed ? "#aaa" : "#ccc"
                    }
                }
                implicitWidth: 100
                implicitHeight: 43
                border.color: "#888888"
            }
        }
    }

    TableView {
    id: tableViewAlarmRecord
    objectName: "alarmParameterTablewView"
    x: 0
    width: 1024
    height: 641
    anchors.top: imgBack.bottom
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
    model: contactModel
    signal checked(int row, int col, bool isChecked, string description)
    onChecked: {
        console.log("(" + row + ", " + col +") = " + isChecked + ", [" + description + "]");
        alarm.checkedChanged(row, col, isChecked);
    }

    TableViewColumn {
        id: changeColumn
        title: "changed"
        role: "changed"
        movable: false
        resizable: false
        width: 120
        horizontalAlignment: Text.AlignHCenter
        delegate: Item {
        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: styleData.value
            font.pixelSize: 18
            anchors{left: parent.left; leftMargin: 10}
        }
        }
    }

    TableViewColumn {
        id: noColumn
        title: "Alarm No."
        role: "alarm_no"
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
            anchors{left: parent.left; leftMargin: 10}
        }
        }
    }

    // You can use itemDelegate in TableView
    // for specific cells or all cells. ( https://is.gd/UCSqg0 )
    itemDelegate: Item {
        anchors.fill: parent
        anchors.centerIn: parent
        Text {
          anchors.verticalCenter: parent.verticalCenter
          // color: "green"
          elide: styleData.elideMode
          text: styleData.value
          font.pixelSize: 18
        }
    }

    TableViewColumn {
        id: displayColumn
        title: "Display"
        role: "display"
        horizontalAlignment: Text.AlignHCenter
        movable: false
        resizable: false
        width: 120

            // checkbox in column ( https://tinyurl.com/y5wf5tzt )
        delegate: Item {
        anchors.fill: parent
        CheckBox {
            anchors.centerIn: parent
            checked: styleData.value
            enabled: true
	    visible: false
            onClicked: {
            // it works
            //console.debug("row: " + styleData.row);
            // QML Fetch value from current row in a tableview

            // ref: ( https://tinyurl.com/y4g7wb4r )
            // console.debug(contactModel.get(styleData.row).alarm_no + ": "
            //     + contactModel.get(styleData.row).content );

            // it works, connect table view to worker
            // however, direct signal to worker
            // ( https://tinyurl.com/y5gdy7cf )
            //tableViewAlarmRecord.checked(
            //    styleData.row, styleData.column, checked,
            //    contactModel.get(styleData.row).alarm_no + ": "
            //    + contactModel.get(styleData.row).content );

	    // contactModel.get(styleData.row).changed = 1;
	    // TODO: use array

            alarm.checkedChanged(styleData.row, styleData.column, checked);
            }
        }
        }
    }

    TableViewColumn {
        id: recordColumn
        title: "Record"
        role: "record"
        horizontalAlignment: Text.AlignHCenter
        movable: false
        resizable: false
        width: 120
        delegate: Item {
        anchors.fill: parent
        CheckBox {
            anchors.centerIn: parent
            checked: styleData.value
            enabled: true
            onClicked: {
            alarm.checkedChanged(styleData.row, styleData.column, checked);
            }
        }
        }
    }

    TableViewColumn {
        id: beepsColumn
        title: "Beeps"
        role: "beeps"
        horizontalAlignment: Text.AlignHCenter
        movable: false
        resizable: false
        width: 120
        delegate: Item {
        anchors.fill: parent
        CheckBox {
            anchors.centerIn: parent
            checked: styleData.value
            enabled: true
            onClicked: {
            alarm.checkedChanged(styleData.row, styleData.column, checked);
            }
        }
        }
    }

    TableViewColumn {
        id: voiceColumn
        title: "Voice"
        role: "voice"
        horizontalAlignment: Text.AlignHCenter
        movable: false
        resizable: false
        width: 120
        delegate: Item {
        anchors.fill: parent
        CheckBox {
            anchors.centerIn: parent
            checked: styleData.value
            enabled: true
            onClicked: {
            alarm.checkedChanged(styleData.row, styleData.column, checked);
            }
        }
        }
    }

    TableViewColumn {
        id: contentColumn
        title: "Alarm Content"
        role: "content"
        horizontalAlignment: Text.AlignHCenter
        movable: false
        resizable: false
        width: 400
    }

    ListModel {
        id: contactModel
        onDataChanged: console.log("Data Changed")
        Component.onCompleted: {
        // console.log("listmodel completed+");
            // it is working
            // contactModel.append({alarm_no:"1",display:0,record:1,beeps:1,voice:1,content:"ala"});
            // value is not an object
            //console.log("listmodel completed-");
        }
        /*ListElement {
        alarm_no: "1"
        display: 1
        record: 0
        beeps: 1
        voice: 0
        content: "PCU Fault No.64 B相欠相"
        }
        ListElement {
        alarm_no: "2"
        display: 0
        record: 1
        beeps: 0
        voice: 1
        content: "PCU Fault No.64 B相欠相"
        }*/
    }
    }

    Row {
        id: rowInstantMessage
        objectName: "instantMessage"
        x: 152
        width: style.resolutionWidth
        height: 50
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        Rectangle {
            id: recMessage
            x: 0
            y: 0
            width: style.resolutionWidth
            height: 50
            color: "#1f1f1f"
            anchors.bottom: parent.bottom
        }
    }

    onActiveChanged : {
        if ( true === alarm.active ) {
        alarm.qmlSignalActive("AlarmParameters");
    }
    }
}

/*##^##
Designer {
    D{i:0;height:768;width:1024}
}
##^##*/
