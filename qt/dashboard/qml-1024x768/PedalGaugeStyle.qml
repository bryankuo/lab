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
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4

DashboardGaugeStyle {
    id: tempGaugeStyle
    minimumValueAngle: -120
    maximumValueAngle: 120
    // maximumGreenValueAngle: maximumValueAngle

    tickmarkStepSize: 50
    labelStepSize: 50
    labelInset: toPixels(0.22)
    minorTickmarkCount: 4

    needleLength: toPixels(0.85)
    needleBaseWidth: toPixels(0.08)
    needleTipWidth: toPixels(0.03)

    //halfGauge: true

    //property string icon: "AAA"
    property color minWarningColor: "transparent"
    property color maxWarningColor: "transparent"
    property color maxGreenColor: "transparent"
    readonly property real minWarningStartAngle: minimumValueAngle - minimumValueAngle
    readonly property real maxWarningStartAngle: maximumValueAngle - maximumValueAngle
    // readonly property real maxGreenStartAngle: maximumGreenValueAngle - maximumGreenValueAngle

    tickmark: Rectangle {
        implicitWidth: toPixels(0.03)
        antialiasing: true
        implicitHeight: toPixels(0.08)
        color: "#c8c8c8"
    }
/*
    tickmarkLabel:  Text {
	font.pixelSize: Math.max(3, outerRadius * 0.06)
	//text: styleData.value
	text: qsTr("1")
	//color: styleData.value <= gauge.value ? "white" : "#777776"
	//antialiasing: true
    }
*/
    minorTickmark: Rectangle {
        implicitWidth: toPixels(0.02)
        antialiasing: true
        implicitHeight: toPixels(0.04)
        color: "#c8c8c8"
    }

    background: Item {
        Canvas {
            anchors.fill: parent
            onPaint: {
                var ctx = getContext("2d");
                ctx.reset();

                paintBackground(ctx);
                if (minWarningColor != "transparent") {
                    ctx.beginPath();
                    ctx.lineWidth = tempGaugeStyle.toPixels(0.03);
                    ctx.strokeStyle = minWarningColor;
                    ctx.arc(outerRadius, outerRadius,
                        // Start the line in from the decorations, and account for the width of the line itself.
                        outerRadius - tickmarkInset - ctx.lineWidth / 2,
                        degToRad(minWarningStartAngle),
                        degToRad(minWarningStartAngle + angleRange / (minorTickmarkCount + 1)), false);
                    ctx.stroke();
                }
                if (maxWarningColor != "transparent") {
                    ctx.beginPath();
                    ctx.lineWidth = tempGaugeStyle.toPixels(0.03); // 0.08, 1.00: pie
                    ctx.strokeStyle = maxWarningColor;
                    ctx.arc(outerRadius, outerRadius,
                        // Start the line in from the decorations, and account for the width of the line itself.
                        outerRadius - tickmarkInset - ctx.lineWidth / 2,
                        degToRad(maxWarningStartAngle - angleRange / (minorTickmarkCount + 1)),
                        degToRad(maxWarningStartAngle+30), false);
                    ctx.stroke();
                }
// maxGreenColor != "transparent" angleRange
                if ( true ) {
                    ctx.beginPath();
                    ctx.lineWidth = tempGaugeStyle.toPixels(0.03); // 0.08, 1.00: pie
                    ctx.strokeStyle = Qt.rgba(0, 1, 0, 0.5); // "green"; //maxGreenColor;
		    // @see https://tinyurl.com/y6kpo2yn
                    ctx.arc(outerRadius, outerRadius,
                        // Start the line in from the decorations, and account for the width of the line itself.
                        outerRadius - tickmarkInset - ctx.lineWidth / 2,
                        // degToRad( 0 - angleRange / (minorTickmarkCount + 1)),
                        // degToRad( 0 + 30),
                        degToRad( 150 ),
                        degToRad( 237 ),
			false );
                    ctx.stroke();
                }
		// warning
                /*if ( true ) {
                    ctx.beginPath();
                    ctx.lineWidth = tempGaugeStyle.toPixels(0.02); // 0.08, 1.00: pie
                    ctx.strokeStyle = Qt.rgba(1, 1, 0, 1); // "yellow";
		    // @see https://tinyurl.com/y6kpo2yn
                    ctx.arc(outerRadius, outerRadius,
                        // Start the line in from the decorations, and account for the width of the line itself.
                        outerRadius - tickmarkInset - ctx.lineWidth / 2,
                        // degToRad( 0 - angleRange / (minorTickmarkCount + 1)),
                        // degToRad( 0 + 30),
                        degToRad( 205 ),
                        degToRad( 310 ),
			false );
                    ctx.stroke();
                }*/
            }

        Text {
        id: powerText
        font.pixelSize: toPixels(0.3)
        text: powerInt
        color: "white"
        horizontalAlignment: Text.AlignRight
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.verticalCenter
        anchors.topMargin: toPixels(0.1)

        readonly property int powerInt: control.value
        }

	Text {
	    text: qsTr("kw")
	    color: "white"
	    font.pixelSize: toPixels(0.20)
	    anchors.top: powerText.bottom
	    anchors.horizontalCenter: parent.horizontalCenter
        }

	}
/*
        Image {
            source: icon
            anchors.bottom: parent.verticalCenter
            anchors.bottomMargin: toPixels(0.3)
            anchors.horizontalCenter: parent.horizontalCenter
            //width: toPixels(0.3)
            width: toPixels(0.6)
            //height: width
            height: width*2
            fillMode: Image.PreserveAspectFit
        }
*/
    }
}



















































/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
