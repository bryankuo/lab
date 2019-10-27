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
import "style"

Window {
    id: unlock

    // ( https://goo.gl/LWbdMG )
    objectName: "unlockWindow"
    Styles { id: style }

    // QML - main window position on start (screen center)
    // ( https://goo.gl/wLpvZD )
    width: style.resolutionWidth // application wide properties
    height: style.resolutionHeight
    x: 0
    y: 0
    maximumHeight: height
    maximumWidth: width
    minimumHeight: height
    minimumWidth: width
    color: "#161616"
    property alias window: unlock
    property int unlockAir: 0
    property int unlockDoorOpen: 0
    property int unlockEvacuation: 0
    property int unlockCollision: 0
    property int unlockECAS: 0
    property int unlockLeakage: 0
    property int unlockCharging: 0
    property int unlockAlert: 0
    flags: Qt.FramelessWindowHint
    title: "Lock Release"

    // Property names must begin with a lower case letter
    // and can only contain letters ( https://goo.gl/HzLQet )

    signal qmlSignal(string msg)
    signal qmlSignalActive(string msg)
    signal qmlSignalUnlock(string item, string unlock)

    function update_VCU_HMI_Msg_2_Byte_0_5(air_pressure,motor_temp,
    otank_temp2,v24) {
    //console.debug("update_VCU_HMI_Msg_2_Byte_0_5");
    //console.debug(air_pressure+","+motor_temp+","+otank_temp2+","+v24);
    //txtAirReading.text
     //   = parseFloat(Math.round(air_pressure*10)/10).toFixed(1);
    //txtMotorIoTempReading.text = motor_temp;
    //txtOTankTemp.text = otank_temp2;
    //txtV24.text = parseFloat(Math.round(v24*10)/10).toFixed(1);
    // TODO: text color not customized so far
    }

    function update_VCU_HMI_Msg_2_Byte_6(air_unlock,
    passenger_unlock,emergency_unlock,wproff_unlock,
    ecas_unlock, isolation_abnormal_unlock,
    v24_carlock_unlock) {
    //console.debug(air_unlock+","+passenger_unlock+","+emergency_unlock+","+wproff_unlock+","+ecas_unlock+","+isolation_abnormal_unlock+","+v24_carlock_unlock);
    // TODO:
    }

    function setUnlock(item, unlock) {
    //console.debug("setUnlock "+item+", "+unlock);
    }

    Rectangle {
        id: rectangleunlock
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
        id: maBack
        z: 2
        anchors.fill: parent
        onClicked: {
        unlock.hide();
        width: 80
        height: 80
        }
    }
    }

    Rectangle {
        id: rowTitle
        x: 200
        y: 30
        width: 300
        height: 43
    color: "#161616"
        anchors.leftMargin: 50
        Text {
            id: txtunlock
            y: 0
            width: 100
            height: 43
            color: "#ffffff"
            text: qsTr("Lock Release")
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

    Row {
    id: rowInstantMessage
    objectName: "instantMessage"
    x: 152
    width: 1024
    height: 50
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottom: parent.bottom
    anchors.bottomMargin: 5
    Rectangle {
        id: recMessage
        x: 0
        y: 0
        width: 1024
        height: 50
        color: "#1f1f1f"
        anchors.bottom: parent.bottom
    }
    }

    Image {
        id: imgAir
        x: 40
        y: 250
        width: 200
        height: 150
        sourceSize.height: 267
        sourceSize.width: 267
        MouseArea {
            id: maAir
            x: 50
            width: 200
            anchors.fill: parent
            z: 2
        onClicked: {
        if ( unlockAir ) {
            unlockAir = 0;
            imgAir.source = "../images/1-white/20190715-01.png";
        }
        else {
            unlockAir = 1;
            imgAir.source = "../images/1-white/20190715-03.png";
        }
        unlock.qmlSignalUnlock("0", unlockAir.toFixed(0));
        }
        }
        source: "../images/1-white/20190715-01.png"
        z: 2
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imgDoorOpen
        y: 250
        width: 200
        height: 150
        anchors.left: imgAir.right
        anchors.leftMargin: 50
        scale: 1
        transformOrigin: Item.Center
        z: 1
        MouseArea {
            id: maDoorOpen
            x: 50
            width: 200
            anchors.fill: parent
            z: 2
        onClicked: {
        if ( unlockDoorOpen ) {
            unlockDoorOpen = 0;
            imgDoorOpen.source = "../images/1-white/20190715-05.png";
        }
        else {
            unlockDoorOpen = 1;
            imgDoorOpen.source = "../images/1-white/20190715-06.png";
        }
        unlock.qmlSignalUnlock("1", unlockDoorOpen.toFixed(0));
        }
        }
        source: "../images/1-white/20190715-05.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imgEvacuation
        y: 250
        width: 200
        height: 150
        anchors.left: imgDoorOpen.right
        anchors.leftMargin: 50
        transformOrigin: Item.Center
        z: 1
        MouseArea {
            id: maEvacuation
            x: 50
            width: 200
            anchors.fill: parent
            z: 2
        onClicked: {
        if ( unlockEvacuation ) {
            unlockEvacuation = 0;
            imgEvacuation.source = "../images/1-white/20190715-07.png";
        }
        else {
            unlockEvacuation = 1;
            imgEvacuation.source = "../images/1-white/20190715-08.png";
        }
        unlock.qmlSignalUnlock("2", unlockEvacuation.toFixed(0));
        }
        }
        scale: 1
        source: "../images/1-white/20190715-07.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imgCollision
        y: 250
        width: 200
        height: 150
        anchors.left: imgEvacuation.right
        anchors.leftMargin: 50
        z: 1
        transformOrigin: Item.Center
        MouseArea {
            id: maCollision
            x: 50
            width: 200
            anchors.fill: parent
            z: 2
        onClicked: {
        if ( unlockCollision ) {
            unlockCollision = 0;
            imgCollision.source = "../images/1-white/20190715-15.png";
        }
        else {
            unlockCollision = 1;
            imgCollision.source = "../images/1-white/20190715-16.png";
        }
        unlock.qmlSignalUnlock("3", unlockCollision.toFixed(0));
        }
        }
        scale: 1
        fillMode: Image.PreserveAspectFit
        source: "../images/1-white/20190715-15.png"
    }

    Image {
        id: imgAlert
        y: 450
        width: 200
        height: 150
        anchors.left: imgCharging.right
        anchors.leftMargin: 50
        z: 1
        transformOrigin: Item.Center
        MouseArea {
            id: maAlert
            x: 50
            width: 200
            anchors.fill: parent
            z: 1
        onClicked: {
        //if ( unlockAlert ) {
        //    unlockAlert = 0;
        //    imgAlert.source = "../images/1-white/20190715-11.png";
        //}
        //else {
        //    unlockAlert = 1;
        //    imgAlert.source = "../images/1-white/20190715-12.png";
        //}
        //unlock.qmlSignalUnlock("7", unlockAlert.toFixed(0));
        }
        }
        scale: 1
        fillMode: Image.PreserveAspectFit
        source: "../images/1-white/20190715-11.png"
    }

    Image {
        id: imgCharging
        y: 450
        width: 200
        height: 150
        anchors.left: imgLeakage.right
        anchors.leftMargin: 50
        z: 1
        transformOrigin: Item.Center
        MouseArea {
            id: maCharging
            anchors.fill: parent
            z: 2
        onClicked: {
        if ( unlockCharging ) {
            unlockCharging = 0;
            imgCharging.source = "../images/1-white/20190715-09.png";
        }
        else {
            unlockCharging = 1;
            imgCharging.source = "../images/1-white/20190715-10.png";
        }
        unlock.qmlSignalUnlock("6", unlockCharging.toFixed(0));
        }
        }
        scale: 1
        fillMode: Image.PreserveAspectFit
        source: "../images/1-white/20190715-09.png"
    }

    Image {
        id: imgLeakage
        y: 450
        width: 200
        height: 150
        anchors.left: imgECAS.right
        anchors.leftMargin: 50
        transformOrigin: Item.Center
        z: 1
        MouseArea {
            id: maLeakage
            anchors.fill: parent
            z: 2
        onClicked: {
        if ( unlockLeakage ) {
            unlockLeakage = 0;
            imgLeakage.source = "../images/1-white/20190715-13.png";
        }
        else {
            unlockLeakage = 1;
            imgLeakage.source = "../images/1-white/20190715-14.png";
        }
        unlock.qmlSignalUnlock("5", unlockLeakage.toFixed(0));
        }
        }
        scale: 1
        source: "../images/1-white/20190715-13.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imgECAS
        x: 40
        y: 450
        width: 200
        height: 150
        z: 1
        MouseArea {
            id: maECAS
            anchors.fill: parent
            z: 2
        onClicked: {
        if ( unlockECAS ) {
            unlockECAS = 0;
            imgECAS.source = "../images/1-white/20190715-02.png";
        }
        else {
            unlockECAS = 1;
            imgECAS.source = "../images/1-white/20190715-04.png";
        }
        unlock.qmlSignalUnlock("4", unlockECAS.toFixed(0));
        }
        }
        sourceSize.width: 267
        source: "../images/1-white/20190715-02.png"
        fillMode: Image.PreserveAspectFit
        sourceSize.height: 267
    }

    onActiveChanged : {
        if ( true === unlock.active ) {
        unlock.qmlSignalActive("Unlock");
    }
    }

}































































/*##^## Designer {
    D{i:12;anchors_x:325}D{i:14;anchors_x:610}D{i:16;anchors_x:890}D{i:18;anchors_x:890}
D{i:20;anchors_x:610}D{i:22;anchors_x:325;anchors_y:280}D{i:24;anchors_x:100;anchors_y:280}
}
 ##^##*/
