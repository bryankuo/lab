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
    id: logon

    // ( https://goo.gl/LWbdMG )
    objectName: "logOnWindow"
    // make the first one visible
    Styles { id: style }
    visible: false

    // QML - main window position on start (screen center)
    // ( https://goo.gl/wLpvZD )
    width: style.resolutionWidth
    height: style.resolutionHeight
    maximumHeight: height
    maximumWidth: width
    x: (Screen.width - width) / 2
    y: (Screen.height - height) / 2

    minimumHeight: height
    minimumWidth: width
    color: "#161616"
    property alias window: logon
    flags: Qt.FramelessWindowHint
    title: "Log On"

    // Property names must begin with a lower case letter
    // and can only contain letters ( https://goo.gl/HzLQet )
    //
    property string credentials : "";
    property var minLenCredential : 3;
    property string colorENABLE : "#00FFFF";
    property string colorDISABLE : "#808080";
    signal qmlSignal(string msg)
    signal qmlSignalActive(string msg)
    signal qmlSignalAuth(string ticket); // TODO: encode
    signal qmlSignalTimeout(int time);

    // should remove for security purpose
    function authFailed(msg) {
	console.debug("authFailed! ("+msg+")");
    }

    function authPassed() {
	console.debug("authPassed.");
    }

    function postKeyPressed(key) {
	txtEntry.text += "•";
	credentials += key;
	// console.debug("credentials = ["+credentials+"]");
	if ( 0 < credentials.length ) {
	    txtC.color = colorENABLE;
	    btnC.enabled = true;
	}
	if ( minLenCredential < credentials.length ) {
	    txtOK.color = colorENABLE;
	    btnOK.enabled = true;
	}
    }

    function postCleared() {
	// @see https://tinyurl.com/yywejfq6
	txtEntry.text = txtEntry.text.slice(0, -1);
	credentials = credentials.slice(0, -1);
	// console.debug("credentials = ["+credentials+"]");
	if ( credentials.length <= 0 ) {
	    txtC.color = colorDISABLE;
	    btnC.enabled = false;
	}
	if ( credentials.length <= minLenCredential ) {
	    txtOK.color = colorDISABLE;
	    btnOK.enabled = false;
	}
    }

    Rectangle {
        id: recLogOn

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

    Text {
        id: txtEntry
        y: 22
        width: 450
        height: 60
        color: "#ffffff"
        text: qsTr("")
        wrapMode: Text.WordWrap
        font.family: "Tahoma"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 50
        font.pixelSize: 60
        MouseArea {
            width: 70
            height: 40
            anchors.top: parent.top
            hoverEnabled: false
            anchors.left: parent.left
        }
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }

    Button {
        id: btn1
        x: 135
        y: 132
        width: 150
        height: 120
        text: qsTr("")
        anchors.right: btn2.left
        anchors.rightMargin: 50
	onClicked: {
	    postKeyPressed(txt1.text);
	}
        style: ButtonStyle {
            background: Rectangle {
                radius: 4
                implicitWidth: 100
                implicitHeight: 43
                border.color: "#888888"
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
            }
        }
        anchors.leftMargin: 180

        Text {
            id: txt1
            x: 88
            y: 93
            color: "#000000"
            text: qsTr("1")
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
            lineHeight: 0.9
            font.pixelSize: 80
        }
    }

    Button {
        id: btn2
        x: 349
        y: 132
        width: 150
        height: 120
        text: qsTr("")
        anchors.horizontalCenter: parent.horizontalCenter
	onClicked: {
	    postKeyPressed(txt2.text);
	}
        style: ButtonStyle {
            background: Rectangle {
                radius: 4
                implicitWidth: 100
                border.color: "#888888"
                implicitHeight: 43
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
            }
        }
        anchors.leftMargin: 180
        Text {
            id: txt2
            x: 88
            y: 93
            color: "#000000"
            text: qsTr("2")
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 80
            anchors.verticalCenter: parent.verticalCenter
            lineHeight: 0.9
        }
    }

    Button {
        id: btn3
        y: 132
        width: 150
        height: 120
        text: qsTr("")
        anchors.left: btn2.right
	onClicked: {
	    postKeyPressed(txt3.text);
	}
        style: ButtonStyle {
            background: Rectangle {
                radius: 4
                implicitWidth: 100
                border.color: "#888888"
                implicitHeight: 43
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
            }
        }
        anchors.leftMargin: 50
        Text {
            id: txt3
            x: 88
            y: 93
            color: "#000000"
            text: qsTr("3")
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 80
            anchors.verticalCenter: parent.verticalCenter
            lineHeight: 0.9
        }
    }

    Button {
        id: btn4
        x: 135
        width: 150
        height: 120
        text: qsTr("")
        anchors.top: btn1.bottom
        anchors.topMargin: 40
        anchors.right: btn5.left
        anchors.rightMargin: 50
	onClicked: {
	    postKeyPressed(txt4.text);
	}
        style: ButtonStyle {
            background: Rectangle {
                radius: 4
                implicitWidth: 100
                implicitHeight: 43
                border.color: "#888888"
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
            }
        }
        anchors.leftMargin: 180
        Text {
            id: txt4
            x: 88
            y: 93
            color: "#000000"
            text: qsTr("4")
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 80
            anchors.verticalCenter: parent.verticalCenter
            lineHeight: 0.9
        }
    }

    Button {
        id: btn5
        x: 349
        width: 150
        height: 120
        text: qsTr("")
        anchors.top: btn2.bottom
        anchors.topMargin: 40
        anchors.horizontalCenter: parent.horizontalCenter
	onClicked: {
	    postKeyPressed(txt5.text);
	}
        style: ButtonStyle {
            background: Rectangle {
                radius: 4
                implicitWidth: 100
                border.color: "#888888"
                implicitHeight: 43
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
            }
        }
        anchors.leftMargin: 180
        Text {
            id: txt5
            x: 88
            y: 93
            color: "#000000"
            text: qsTr("5")
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 80
            anchors.verticalCenter: parent.verticalCenter
            lineHeight: 0.9
        }
    }

    Button {
        id: btn6
        width: 150
        height: 120
        text: qsTr("")
        anchors.top: btn3.bottom
        anchors.topMargin: 40
        anchors.left: btn5.right
	onClicked: {
	    postKeyPressed(txt6.text);
	}
        style: ButtonStyle {
            background: Rectangle {
                radius: 4
                implicitWidth: 100
                implicitHeight: 43
                border.color: "#888888"
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
            }
        }
        anchors.leftMargin: 50
        Text {
            id: txt6
            x: 88
            y: 93
            color: "#000000"
            text: qsTr("6")
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 80
            anchors.verticalCenter: parent.verticalCenter
            lineHeight: 0.9
        }
    }

    Button {
        id: btn7
        x: 135
        width: 150
        height: 120
        text: qsTr("")
        anchors.top: btn4.bottom
        anchors.topMargin: 40
        anchors.right: btn8.left
        anchors.rightMargin: 50
	onClicked: {
	    postKeyPressed(txt7.text);
	}
        style: ButtonStyle {
            background: Rectangle {
                radius: 4
                implicitWidth: 100
                implicitHeight: 43
                border.color: "#888888"
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
            }
        }
        anchors.leftMargin: 180
        Text {
            id: txt7
            x: 88
            y: 93
            color: "#000000"
            text: qsTr("7")
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 80
            anchors.verticalCenter: parent.verticalCenter
            lineHeight: 0.9
        }
    }

    Button {
        id: btn8
        x: 349
        width: 150
        height: 120
        text: qsTr("")
        anchors.top: btn5.bottom
        anchors.topMargin: 40
        anchors.horizontalCenter: parent.horizontalCenter
	onClicked: {
	    postKeyPressed(txt8.text);
	}
        style: ButtonStyle {
            background: Rectangle {
                radius: 4
                implicitWidth: 100
                border.color: "#888888"
                implicitHeight: 43
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
            }
        }
        anchors.leftMargin: 180
        Text {
            id: txt8
            x: 88
            y: 93
            color: "#000000"
            text: qsTr("8")
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 80
            anchors.verticalCenter: parent.verticalCenter
            lineHeight: 0.9
        }
    }

    Button {
        id: btn9
        width: 150
        height: 120
        text: qsTr("")
        anchors.top: btn6.bottom
        anchors.topMargin: 40
        anchors.left: btn8.right
	onClicked: {
	    postKeyPressed(txt9.text);
	}
        style: ButtonStyle {
            background: Rectangle {
                radius: 4
                implicitWidth: 100
                implicitHeight: 43
                border.color: "#888888"
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
            }
        }
        anchors.leftMargin: 50
        Text {
            id: txt9
            x: 88
            y: 93
            color: "#000000"
            text: qsTr("9")
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 80
            anchors.verticalCenter: parent.verticalCenter
            lineHeight: 0.9
        }
    }

    Button {
        id: btn0
        x: 349
        width: 150
        height: 120
        text: qsTr("")
        anchors.top: btn8.bottom
        anchors.topMargin: 40
        anchors.horizontalCenter: parent.horizontalCenter
	onClicked: {
	    postKeyPressed(txt0.text);
	}
        style: ButtonStyle {
            background: Rectangle {
                radius: 4
                implicitWidth: 100
                border.color: "#888888"
                implicitHeight: 43
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
            }
        }
        anchors.leftMargin: 180
        Text {
            id: txt0
            x: 88
            y: 93
            color: "#000000"
            text: qsTr("0")
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 80
            anchors.verticalCenter: parent.verticalCenter
            lineHeight: 0.9
        }
    }

    Button {
        id: btnC
        x: 135
        width: 150
        height: 120
        text: qsTr("")
	enabled: false
        anchors.top: btn7.bottom
        anchors.topMargin: 40
        anchors.right: btn0.left
        anchors.rightMargin: 50
	onClicked: {
	    postCleared();
	}
        style: ButtonStyle {
            background: Rectangle {
                radius: 4
                implicitWidth: 100
                border.color: "#888888"
                implicitHeight: 43
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
            }
        }
        anchors.leftMargin: 180
        Text {
            id: txtC
            x: 88
            y: 93
            color: "#808080"
            text: qsTr("C")
            fontSizeMode: Text.VerticalFit
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 80
            anchors.verticalCenter: parent.verticalCenter
            lineHeight: 0.9
        }
    }

    Button {
        id: btnOK
        width: 150
        height: 120
        text: qsTr("")
        enabled: false
        anchors.top: btn9.bottom
        anchors.topMargin: 40
        anchors.left: btn0.right
	onClicked: {
	    logon.qmlSignalAuth(credentials); // TODO: encode
	}

        style: ButtonStyle {
            background: Rectangle {
                radius: 4
                implicitWidth: 100
                implicitHeight: 43
                border.color: "#888888"
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
            }
        }
        anchors.leftMargin: 50
        Text {
            id: txtOK
            x: 88
            y: 93
            color: "#808080"
            text: qsTr("OK")
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 65
            anchors.verticalCenter: parent.verticalCenter
            lineHeight: 0.9
        }
    }

    Timer {
	id: screenTimer
	repeat: false
	interval: 60 * 1000
	triggeredOnStart: true
	running: true
	onTriggered: {
	    console.debug("session time out!");
	    logon.qmlSignalTimeout(60);
	}
    }

    onActiveChanged : {
	if ( true === logon.active ) {
	    txtEntry.text = ""; // clean before showing
	    credentials = "";
	    logon.qmlSignalActive("LogOn");
	    screenTimer.start();
	    console.debug("session timer start,");
	}
    }

}
