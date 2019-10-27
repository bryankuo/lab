/****************************************************************************
**
** Copyright (C) 2017 The Qt Company Ltd.
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
import QtQuick.Window 2.1
import QtQuick.Extras 1.4
import "ecu/analog" // Local Directory Imports ( https://is.gd/X0bs1k )
import "ecu/digital"
import "history"
import "high_voltage"
import "parameters"
import "style"

QtObject {
    // Q: hardcoded?
    id: root

    // double quotes
    objectName: "mainWindow"

    // always start with an uppercase letter
    // if you want to be able to use them this way
    // ( https://goo.gl/7dBfTc )
    // also be sure to add rc file

    property var bootWin: Boot {
    }

    // the only visible window point to
    property var loginWin: LogOn {
    }

    property var mainWin: HmiDashboard {}
    property var batWin: BatteryDeployment {
    }
                           /* qml file name */
    property var chartWin: BatteryStatus {
    }
    property var chargingWin: Charging {
    }
    property var tpmsWin: Tpms {
    }
    property var unlockWin: Unlock {
    }
    property var diagnoseWin: Diagnose {
    }

    // TODO: to be obseleted
    property var engWin: Engineering {
    }

    property var vehicleInfoWin: VehicleInfo {
    }

    property var tractionWin: Traction {
    }
    property var brakeWin: Brake {
    }
    property var steeringWin: Steering {
    }

    property var pcuAnalogWin: PcuAnalog {
    }
    property var bcuAnalogWin: BcuAnalog {
    }
    property var vcuAnalogWin: VcuAnalog {
    }
    property var bmsAnalogWin: BmsAnalog {
    }

    property var pcuDigitalWin: PcuDigital {
    }
    property var bcuDigitalWin: BcuDigital {
    }
    property var vcuDigitalWin: VcuDigital {
    }
    property var bmsDigitalWin: BmsDigital {
    }

    property var dcdcWin: Dcdc {
    }

    property var iconDescWin: IconDescription {
    }

    property var historyWin: History {
    }
	property var alarmRecWin: AlarmRecord {
	}
	property var alarmStatWin: AlarmStat{
	}
	property var sysLogWin: SystemLog {
	}
	property var cellAlarmRecWin: CellAlarmRecord {
	}
	property var vehicleInfoRecWin: VehicleInfoRecord {
	}
	property var chargeTrippedWin: ChargeTrippedRecord {
	}

    property var parametersWin: Parameters {
    }
	property var generalParaWin: General {
	}
	property var chargeParaWin: Charge {
	}
	property var alarmParaWin: Alarm {
	}
	property var hmiParaWin: Hmi {
	}
	property var tpmsParaWin: Tyres {
	}
}
