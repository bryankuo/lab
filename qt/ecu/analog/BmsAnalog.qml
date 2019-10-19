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
import "../../style"

Window {
    id: bmsAnalog

    // ( https://goo.gl/LWbdMG )
    objectName: "bmsAnalogWindow"

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
    property alias window: bmsAnalog
    flags: Qt.FramelessWindowHint
    title: "BMS (Analogue)"

    // Property names must begin with a lower case letter
    // and can only contain letters ( https://goo.gl/HzLQet )
    //
    property string color_normal: "#34B972"
    property variant cmu_u_errflags: [0,0,0,0,0,0,0,0,0,0,0,0]
    property variant cmu_d_errflags: [0,0,0,0,0,0,0,0,0,0,0,0]
    // TODO: 1.cmuErrorFlags[][]; or 2.test from cmuState

    // layer: 0: up, 1: down
    // index: from 0 to 11
    // state: 0: open, 1: close, 2: can't open, 3: can't close
    property variant cmuState: [ [1,1,1,1,1,1,1,1,1,1,1,1], [1,1,1,1,1,1,1,1,1,1,1,1] ]
    // TODO: apply from 0 to 10

    signal qmlSignal(string msg)
    signal qmlSignalActive(string msg)

    // TODO:
    function updateCmuState(index, layer, state, imgObject) {
	cmuState[layer][index] = state;
	// console.debug(index+", "layer++", "+state+", "+imgObject);
	switch ( layer ) {
	case 0: /* up */
	    switch ( state ) {
		case 0: imgObject.source =
		    "../../../images/0-color/bms/cmu_norm_open_u.png";
		break;
		case 1: imgObject.source =
		    "../../../images/0-color/bms/cmu_normal_u.png";
		break;
		case 2: imgObject.source =
		    "../../../images/0-color/bms/cmu_open_ng_u.png";
		break;
		case 3: imgObject.source =
		    "../../../images/0-color/bms/cmu_close_ng_u.png";
		break;
	    }
	break;
	case 1: /* down */
	    switch ( state ) {
		case 0: imgObject.source =
		    "../../../images/0-color/bms/cmu_norm_open_d.png";
		break;
		case 1: imgObject.source =
		    "../../../images/0-color/bms/cmu_normal_d.png";
		break;
		case 2: imgObject.source =
		    "../../../images/0-color/bms/cmu_open_ng_d.png";
		break;
		case 3: imgObject.source =
		    "../../../images/0-color/bms/cmu_close_ng_d.png";
		break;
	    }
	break;
	default:
	break;
	}
    }

    function updateBMS_VCU_MSG01(s_voltage,s_current,soc,b_status,
    f_level,mcntctr_nc,mcntctr_st,pcell_alrm,s_cremains) {
    siErrorLevel.color =
        ( f_level === 1 ) ? "orange" :
        ( f_level === 2 ) ? "red" : "#000000";
    siErrorLevel.active = ( f_level == 1 || f_level == 2 )? true : false;
    siMContactorCannotClose.active = ( mcntctr_nc == 1 )? true: false;
    siMainContactorSticking.active = ( mcntctr_st == 1 )? true: false;
    siPowerBatteryAlarm.active = ( pcell_alrm == 1 )? true: false;
    }

    function updateMsg_BCU_ER_MSG01(s_bcu_alarm_lcounter,
    bms_ierr, vsam_err, tsam_err, ccom_err, cer_err,
    chot, ch_scerr, ch_wcerr) {
    siBMSInternalError.active = ( bms_ierr == 1 )?true:false;
    siVoltSamplingError.active = ( vsam_err == 1 )?true:false;
    siTempSamplingError.active = ( tsam_err == 1 )?true:false;
    siCMUCommError.active = ( ccom_err == 1 )?true:false;
    siChargeEcuCommError.active = ( cer_err == 1 )?true:false;
    siOverTime.active = ( chot == 1 )?true:false;
    siSevereCommError.active = ( ch_scerr == 1 )?true:false;
    siWarningCommError.active = ( ch_wcerr == 1 )?true:false;
    }

    function updateMsg_BCU_ER_MSG01_Byte0(ch_shv, ds_shv,
    ch_whv, ds_whv, ds_slv, ds_wlv, ds_hdv, ds_lsoc) {
    siSevereHighCellVoltage.active = ( ch_shv == 1 )?true: false;
    siWarningHighCellVoltage.active = ( ch_whv == 1 )?true: false;
    siLowSoc.active = ( ds_lsoc == 1 )?true: false;
    siHighDiffVoltage.active = ( ds_hdv == 1 )?true: false;
    siSevereHighCellVoltageDs.active = ( ds_shv == 1 )?true: false;
    siWarningHighCellVoltageDs.active = ( ds_whv == 1 )?true: false;
    siSevereLowCellVoltageDs.active = ( ds_slv == 1 )?true: false;
    siWarningLowCellVoltageDs.active = ( ds_wlv == 1 )?true: false;
    }

    function updateMsg_BCU_ER_MSG01_Byte1(sht_ch, sht_ds, wht_ch, wht_ds,
    slt_ch, slt_ds, wlt_ch, wlt_ds) {
    siSevereHighTemp.active = ( sht_ch == 1 )?true: false;
    siSevereHighTempDs.active = ( sht_ds == 1 )?true: false;
    siWarningHighTemp.active = ( wht_ch == 1 )?true: false;
    siWarningHighTempDs.active = ( wht_ds == 1 )?true: false;
    siSevereLowTemp.active = ( slt_ch == 1 )?true: false;
    siSevereLowTempDs.active = ( slt_ds == 1 )?true: false;
    siWarningLowTemp.active = ( wlt_ch == 1 )?true: false;
    siWarningLowTempDs.active = ( wlt_ds == 1 )?true: false;
    }

    function updateMsg_BCU_ER_MSG01_Byte2(oc_ch, oc_ds) {
    siOverCurrent.active = ( oc_ch == 1 )?true: false;
    siOverCurrentDs.active = ( oc_ds == 1 )?true: false;
    }

    function updateMsg_BCU_ER_MSG01_Byte4(issl_ch, issl_ds,
    iswl_ch, iswl_ds, hvil_ch, hvil_ds) {
    siSevereLowInsulation.active = ( issl_ch == 1 )?true: false;
    siSevereLowInsulationDS.active = ( issl_ds == 1 )?true: false;
    siWarningLowInsulation.active = ( iswl_ch == 1 )?true: false;
    siWarningLowInsulationDS.active = ( iswl_ds == 1 )?true: false;
    siAbnormalHvil.active = ( hvil_ch == 1 )?true: false;
    siAbnormalHvilDs.active = ( hvil_ds == 1 )?true: false;
    }

    function updateMsg_BCU_ER_MSG01_Byte5(c1,c2,c3,c4,c5,c6,c7,c8) {
	if ( 1 === c1 ) {
	    txtCMU1.color = "#ff0000";
	    cmu_u_errflags[0] = 1;
	    cmu_d_errflags[0] = 1;
	}
	else {
	    txtCMU1.color = color_normal;
	    cmu_u_errflags[0] = 0;
	    cmu_d_errflags[0] = 0;
	}

	if ( 1 === c2 ) {
	    txtCMU2.color = "#ff0000";
	    cmu_u_errflags[1] = 1;
	    cmu_d_errflags[1] = 1;
	}
	else {
	    txtCMU2.color = color_normal;
	    cmu_u_errflags[1] = 0;
	    cmu_d_errflags[1] = 0;
	}

	if ( 1 === c3 ) {
	    txtCMU3.color = "#ff0000";
	    cmu_u_errflags[2] = 1;
	    cmu_d_errflags[2] = 1;
	}
	else {
	    txtCMU3.color = color_normal;
	    cmu_u_errflags[2] = 0;
	    cmu_d_errflags[2] = 0;
	}

	if ( 1 === c4 ) {
	    txtCMU4.color = "#ff0000";
	    cmu_u_errflags[3] = 1;
	    cmu_d_errflags[3] = 1;
	}
	else {
	    txtCMU4.color = color_normal;
	    cmu_u_errflags[3] = 0;
	    cmu_d_errflags[3] = 0;
	}

	if ( 1 === c5 ) {
	    txtCMU5.color = "#ff0000";
	    cmu_u_errflags[4] = 1;
	    cmu_d_errflags[4] = 1;
	}
	else {
	    txtCMU5.color = color_normal;
	    cmu_u_errflags[4] = 0;
	    cmu_d_errflags[4] = 0;
	}

	if ( 1 === c6 ) {
	    txtCMU6.color = "#ff0000";
	    cmu_u_errflags[5] = 1;
	    cmu_d_errflags[5] = 1;
	}
	else {
	    txtCMU6.color = color_normal;
	    cmu_u_errflags[5] = 0;
	    cmu_d_errflags[5] = 0;
	}

	if ( 1 === c7 ) {
	    txtCMU7.color = "#ff0000";
	    cmu_u_errflags[6] = 1;
	    cmu_d_errflags[6] = 1;
	}
	else {
	    txtCMU7.color = color_normal;
	    cmu_u_errflags[6] = 0;
	    cmu_d_errflags[6] = 0;
	}

	if ( 1 === c8 ) {
	    txtCMU8.color = "#ff0000";
	    cmu_u_errflags[7] = 1;
	    cmu_d_errflags[7] = 1;
	}
	else {
	    txtCMU8.color = color_normal;
	    cmu_u_errflags[7] = 0;
	    cmu_d_errflags[7] = 0;
	}

    }

    function updateMsg_BCU_ER_MSG01_Byte6(c9,c10,c11,c12,c13,c14,chg,bms) {

	if ( 1 === c9 ) {
	    txtCMU9.color = "#ff0000";
	    cmu_u_errflags[8] = 1;
	    cmu_d_errflags[8] = 1;
	}
	else {
	    txtCMU9.color = color_normal;
	    cmu_u_errflags[8] = 0;
	    cmu_d_errflags[8] = 0;
	}

	if ( 1 === c10 ) {
	    txtCMU10.color = "#ff0000";
	    cmu_u_errflags[9] = 1;
	    cmu_d_errflags[9] = 1;
	}
	else {
	    txtCMU10.color = color_normal;
	    cmu_u_errflags[9] = 0;
	    cmu_d_errflags[9] = 0;
	}

	if ( 1 === c11 ) {
	    txtCMU11.color = "#ff0000";
	    cmu_u_errflags[10] = 1;
	    cmu_d_errflags[10] = 1;
	}
	else {
	    txtCMU11.color = color_normal;
	    cmu_u_errflags[10] = 0;
	    cmu_d_errflags[10] = 0;
	}

	if ( 1 === c12 ) {
	    txtCMU12.color = "#ff0000";
	    cmu_u_errflags[11] = 1;
	    cmu_d_errflags[11] = 1;
	}
	else {
	    txtCMU12.color = color_normal;
	    cmu_u_errflags[11] = 0;
	    cmu_d_errflags[11] = 0;
	    updateCmuState(11, 0, 1, imgCmu12u);
	}

	imgCharger.source =
	( 1 === chg )?"../../../images/0-color/bms/charger_alert.png"
	    :"../../../images/0-color/bms/charger_normal.png";
	imgBMS.source =
	( 1 === bms )?"../../../images/0-color/bms/bms-alert.png"
	    :"../../../images/0-color/bms/bms-normal.png";

	/*console.debug(cmu_u_errflags[0]+","+cmu_u_errflags[1]+","+cmu_u_errflags[2]+","+
	    cmu_u_errflags[3]+","+cmu_u_errflags[4]+","+cmu_u_errflags[5]+","+
	    cmu_u_errflags[6]+","+cmu_u_errflags[7]+","+cmu_u_errflags[8]+","+
	    cmu_u_errflags[9]+","+cmu_u_errflags[10]+","+cmu_u_errflags[11]);
	console.debug(cmu_d_errflags[0]+","+cmu_d_errflags[1]+","+cmu_d_errflags[2]+","+
	    cmu_d_errflags[3]+","+cmu_d_errflags[4]+","+cmu_d_errflags[5]+","+
	    cmu_d_errflags[6]+","+cmu_d_errflags[7]+","+cmu_d_errflags[8]+","+
	    cmu_d_errflags[9]+","+cmu_d_errflags[10]+","+cmu_d_errflags[11]);*/
    }

    function updateBMS_CMUERR_MSG01_Byte0(b0,b1,b2,b3,b4,b5,b6,b7) {
	if ( 1 === b0 ) {
	    imgCmu1u.source = "../../../images/0-color/bms/cmu_close_ng_u.png";
	    cmu_u_errflags[0] = 1;
	    txtCMU1.color = "#ff0000";
	}
	if ( 1 === b1 ) {
	    imgCmu2u.source = "../../../images/0-color/bms/cmu_close_ng_u.png";
	    cmu_u_errflags[1] = 1;
	    txtCMU2.color = "#ff0000";
	}
	if ( 1 === b2 ) {
	    imgCmu3u.source = "../../../images/0-color/bms/cmu_close_ng_u.png";
	    cmu_u_errflags[2] = 1;
	    txtCMU3.color = "#ff0000";
	}
	if ( 1 === b3 ) {
	    imgCmu4u.source = "../../../images/0-color/bms/cmu_close_ng_u.png";
	    cmu_u_errflags[3] = 1;
	    txtCMU4.color = "#ff0000";
	}

	if ( 1 === b4 ) {
	    imgCmu5u.source = "../../../images/0-color/bms/cmu_close_ng_u.png";
	    cmu_u_errflags[4] = 1;
	    txtCMU5.color = "#ff0000";
	}

	if ( 1 === b5 ) {
	    imgCmu6u.source = "../../../images/0-color/bms/cmu_close_ng_u.png";
	    cmu_u_errflags[5] = 1;
	    txtCMU6.color = "#ff0000";
	}

	if ( 1 === b6 ) {
	    imgCmu7u.source = "../../../images/0-color/bms/cmu_close_ng_u.png";
	    cmu_u_errflags[6] = 1;
	    txtCMU7.color = "#ff0000";
	}

	if ( 1 === b7 ) {
	    imgCmu8u.source = "../../../images/0-color/bms/cmu_close_ng_u.png";
	    cmu_u_errflags[7] = 1;
	    txtCMU8.color = "#ff0000";
	}
    }

    function updateBMS_CMUERR_MSG01_Byte1(b0,b1,b2,b3,b4,b5,b6,b7) {
	if ( 1 === b0 ) {
	    imgCmu9u.source = "../../../images/0-color/bms/cmu_close_ng_u.png";
	    cmu_u_errflags[8] = 1;
	    txtCMU9.color = "#ff0000";
	}
	if ( 1 === b1 ) {
	    imgCmu10u.source = "../../../images/0-color/bms/cmu_close_ng_u.png";
	    cmu_u_errflags[9] = 1;
	    txtCMU10.color = "#ff0000";
	}
	if ( 1 === b2 ) {
	    imgCmu11u.source = "../../../images/0-color/bms/cmu_close_ng_u.png";
	    cmu_u_errflags[10] = 1;
	    txtCMU11.color = "#ff0000";
	}
	if ( 1 === b3 ) {
	    imgCmu12u.source = "../../../images/0-color/bms/cmu_close_ng_u.png";
	    cmu_u_errflags[11] = 1;
	    txtCMU12.color = "#ff0000";
	    updateCmuState(11, 0, 3, imgCmu12u);
	}
    }

    function updateBMS_CMUERR_MSG01_Byte2(b0, b1, b2, b3, b4, b5, b6, b7) {
	if ( 1 === b0 ) {
	    imgCmu1u.source = "../../../images/0-color/bms/cmu_open_ng_u.png";
	    cmu_u_errflags[0] = 1;
	    txtCMU1.color = "#ff0000";
	}
	if ( 1 === b1 ) {
	    imgCmu2u.source = "../../../images/0-color/bms/cmu_open_ng_u.png";
	    cmu_u_errflags[1] = 1;
	    txtCMU2.color = "#ff0000";
	}

	if ( 1 === b2 ) {
	    imgCmu3u.source = "../../../images/0-color/bms/cmu_open_ng_u.png";
	    cmu_u_errflags[2] = 1;
	    txtCMU3.color = "#ff0000";
	}

	if ( 1 === b3 ) {
	    imgCmu4u.source = "../../../images/0-color/bms/cmu_open_ng_u.png";
	    cmu_u_errflags[3] = 1;
	    txtCMU4.color = "#ff0000";
	}

	if ( 1 === b4 ) {
	    imgCmu5u.source = "../../../images/0-color/bms/cmu_open_ng_u.png";
	    cmu_u_errflags[4] = 1;
	    txtCMU5.color = "#ff0000";
	}

	if ( 1 === b5 ) {
	    imgCmu6u.source = "../../../images/0-color/bms/cmu_open_ng_u.png";
	    cmu_u_errflags[5] = 1;
	    txtCMU6.color = "#ff0000";
	}

	if ( 1 === b6 ) {
	    imgCmu7u.source = "../../../images/0-color/bms/cmu_open_ng_u.png";
	    cmu_u_errflags[6] = 1;
	    txtCMU7.color = "#ff0000";
	}

	if ( 1 === b7 ) {
	    imgCmu8u.source = "../../../images/0-color/bms/cmu_open_ng_u.png";
	    cmu_u_errflags[7] = 1;
	    txtCMU8.color = "#ff0000";
	}
    }

    function updateBMS_CMUERR_MSG01_Byte3(b0, b1, b2, b3, b4, b5, b6, b7) {
	if ( 1 === b0 ) {
	    imgCmu9u.source = "../../../images/0-color/bms/cmu_open_ng_u.png";
	    cmu_u_errflags[8] = 1;
	    txtCMU9.color = "#ff0000";
	}
	if ( 1 === b1 ) {
	    imgCmu10u.source = "../../../images/0-color/bms/cmu_open_ng_u.png";
	    cmu_u_errflags[9] = 1;
	    txtCMU10.color = "#ff0000";
	}
	if ( 1 === b2 ) {
	    imgCmu11u.source = "../../../images/0-color/bms/cmu_open_ng_u.png";
	    cmu_u_errflags[10] = 1;
	    txtCMU11.color = "#ff0000";
	}
	if ( 1 === b3 ) {
	    imgCmu12u.source = "../../../images/0-color/bms/cmu_open_ng_u.png";
	    cmu_u_errflags[11] = 1;
	    txtCMU12.color = "#ff0000";
	    updateCmuState(11, 0, 2, imgCmu12u);
	}
    }

    function updateBMS_CMUERR_MSG01_Byte4(b0, b1, b2, b3, b4, b5, b6, b7) {
	if ( 1 === b0 ) {
	    imgCmu1d.source = "../../../images/0-color/bms/cmu_close_ng_d.png";
	    cmu_d_errflags[0] = 1;
	    txtCMU1.color = "#ff0000";
	}
	if ( 1 === b1 ) {
	    imgCmu2d.source = "../../../images/0-color/bms/cmu_close_ng_d.png";
	    cmu_d_errflags[1] = 1;
	    txtCMU2.color = "#ff0000";
	}
	if ( 1 === b2 ) {
	    imgCmu3d.source = "../../../images/0-color/bms/cmu_close_ng_d.png";
	    cmu_d_errflags[2] = 1;
	    txtCMU3.color = "#ff0000";
	}
	if ( 1 === b3 ) {
	    imgCmu4d.source = "../../../images/0-color/bms/cmu_close_ng_d.png";
	    cmu_d_errflags[3] = 1;
	    txtCMU4.color = "#ff0000";
	}
	if ( 1 === b4 ) {
	    imgCmu5d.source = "../../../images/0-color/bms/cmu_close_ng_d.png";
	    cmu_d_errflags[4] = 1;
	    txtCMU5.color = "#ff0000";
	}
	if ( 1 === b5 ) {
	    imgCmu6d.source = "../../../images/0-color/bms/cmu_close_ng_d.png";
	    cmu_d_errflags[5] = 1;
	    txtCMU6.color = "#ff0000";
	}
	if ( 1 === b6 ) {
	    imgCmu7d.source = "../../../images/0-color/bms/cmu_close_ng_d.png";
	    cmu_d_errflags[6] = 1;
	    txtCMU7.color = "#ff0000";
	}
	if ( 1 === b7 ) {
	    imgCmu8d.source = "../../../images/0-color/bms/cmu_close_ng_d.png";
	    cmu_d_errflags[7] = 1;
	    txtCMU8.color = "#ff0000";
	}
    }

    function updateBMS_CMUERR_MSG01_Byte5(b0, b1, b2, b3, b4, b5, b6, b7) {
	if ( 1 === b0 ) {
	    imgCmu9d.source = "../../../images/0-color/bms/cmu_close_ng_d.png";
	    cmu_d_errflags[8] = 1;
	    txtCMU9.color = "#ff0000";
	}
	if ( 1 === b1 ) {
	    imgCmu10d.source = "../../../images/0-color/bms/cmu_close_ng_d.png";
	    cmu_d_errflags[9] = 1;
	    txtCMU10.color = "#ff0000";
	}
	if ( 1 === b2 ) {
	    imgCmu11d.source = "../../../images/0-color/bms/cmu_close_ng_d.png";
	    cmu_d_errflags[10] = 1;
	    txtCMU11.color = "#ff0000";
	}
	if ( 1 === b3 ) {
	    imgCmu12d.source = "../../../images/0-color/bms/cmu_close_ng_d.png";
	    cmu_d_errflags[11] = 1;
	    txtCMU12.color = "#ff0000";
	}
    }

    function updateBMS_CMUERR_MSG01_Byte6(b0, b1, b2, b3, b4, b5, b6, b7) {
	if ( 1 === b0 ) {
	    imgCmu1d.source = "../../../images/0-color/bms/cmu_open_ng_d.png";
	    cmu_d_errflags[0] = 1;
	    txtCMU1.color = "#ff0000";
	}
	if ( 1 === b1 ) {
	    imgCmu2d.source = "../../../images/0-color/bms/cmu_open_ng_d.png";
	    cmu_d_errflags[1] = 1;
	    txtCMU2.color = "#ff0000";
	}
	if ( 1 === b2 ) {
	    imgCmu3d.source = "../../../images/0-color/bms/cmu_open_ng_d.png";
	    cmu_d_errflags[2] = 1;
	    txtCMU3.color = "#ff0000";
	}
	if ( 1 === b3 ) {
	    imgCmu4d.source = "../../../images/0-color/bms/cmu_open_ng_d.png";
	    cmu_d_errflags[3] = 1;
	    txtCMU4.color = "#ff0000";
	}
	if ( 1 === b4 ) {
	    imgCmu5d.source = "../../../images/0-color/bms/cmu_open_ng_d.png";
	    cmu_d_errflags[4] = 1;
	    txtCMU5.color = "#ff0000";
	}
	if ( 1 === b5 ) {
	    imgCmu6d.source = "../../../images/0-color/bms/cmu_open_ng_d.png";
	    cmu_d_errflags[5] = 1;
	    txtCMU6.color = "#ff0000";
	}
	if ( 1 === b6 ) {
	    imgCmu7d.source = "../../../images/0-color/bms/cmu_open_ng_d.png";
	    cmu_d_errflags[6] = 1;
	    txtCMU7.color = "#ff0000";
	}
	if ( 1 === b7 ) {
	    imgCmu8d.source = "../../../images/0-color/bms/cmu_open_ng_d.png";
	    cmu_d_errflags[7] = 1;
	    txtCMU8.color = "#ff0000";
	}
    }

    function updateBMS_CMUERR_MSG01_Byte7(b0, b1, b2, b3, b4, b5, b6, b7) {
	if ( 1 === b0 ) {
	    imgCmu9d.source = "../../../images/0-color/bms/cmu_open_ng_d.png";
	    cmu_d_errflags[8] = 1;
	    txtCMU9.color = "#ff0000";
	}
	if ( 1 === b1 ) {
	    imgCmu10d.source = "../../../images/0-color/bms/cmu_open_ng_d.png";
	    cmu_d_errflags[9] = 1;
	    txtCMU10.color = "#ff0000";
	}
	if ( 1 === b2 ) {
	    imgCmu11d.source = "../../../images/0-color/bms/cmu_open_ng_d.png";
	    cmu_d_errflags[10] = 1;
	    txtCMU11.color = "#ff0000";
	}
	if ( 1 === b3 ) {
	    imgCmu12d.source = "../../../images/0-color/bms/cmu_open_ng_d.png";
	    cmu_d_errflags[11] = 1;
	    txtCMU12.color = "#ff0000";
	}
    }

    function updateBMS_VCU_MSG02(s_cmaxv,cell_maxi,s_cminv,cell_mini,
    s_cdiffv) {
    // console.debug("updateBMS_VCU_MSG02");
    // TODO:
    }

    function updateMsg_BMS_VCU_Msg03(max_pt_temp, max_pt_idx,
    charger_cc2,charger_conn1,charger_conn2,bms_pr_state,
    mctr_state, mi_ctr_state, frelay_state, l_counter) {
    }

    function updateBMS_VCU_MSG03_Byte3(b0, b1, b2, b3, b4, b5, b6, b7) {
	if ( cmu_u_errflags[0] === 0 ) {
	    if ( 1 === b0 )
		imgCmu1u.source = "../../../images/0-color/bms/cmu_normal_u.png";
	    else
		imgCmu1u.source = "../../../images/0-color/bms/cmu_norm_open_u.png";
	}

	if ( cmu_u_errflags[1] === 0 ) {
	    if ( 1 === b1 )
		imgCmu2u.source = "../../../images/0-color/bms/cmu_normal_u.png";
	    else
		imgCmu2u.source = "../../../images/0-color/bms/cmu_norm_open_u.png";
	}

	if ( cmu_u_errflags[2] === 0 ) {
	    if ( 1 === b2 )
		imgCmu3u.source = "../../../images/0-color/bms/cmu_normal_u.png";
	    else
		imgCmu3u.source = "../../../images/0-color/bms/cmu_norm_open_u.png";
	}

	if ( cmu_u_errflags[3] === 0 ) {
	    if ( 1 === b3 )
		imgCmu4u.source = "../../../images/0-color/bms/cmu_normal_u.png";
	    else
		imgCmu4u.source = "../../../images/0-color/bms/cmu_norm_open_u.png";
	}

	if ( cmu_u_errflags[4] === 0 ) {
	    if ( 1 === b4 )
		imgCmu5u.source = "../../../images/0-color/bms/cmu_normal_u.png";
	    else
		imgCmu5u.source = "../../../images/0-color/bms/cmu_norm_open_u.png";
	}

	if ( cmu_u_errflags[5] === 0 ) {
	    if ( 1 === b5 )
		imgCmu6u.source = "../../../images/0-color/bms/cmu_normal_u.png";
	    else
		imgCmu6u.source = "../../../images/0-color/bms/cmu_norm_open_u.png";
	}

	if ( cmu_u_errflags[6] === 0 ) {
	    if ( 1 === b6 )
		imgCmu7u.source = "../../../images/0-color/bms/cmu_normal_u.png";
	    else
		imgCmu7u.source = "../../../images/0-color/bms/cmu_norm_open_u.png";
	}

	if ( cmu_u_errflags[7] === 0 ) {
	    if ( 1 === b7 )
		imgCmu8u.source = "../../../images/0-color/bms/cmu_normal_u.png";
	    else
		imgCmu8u.source = "../../../images/0-color/bms/cmu_norm_open_u.png";
	}
    }

    function updateBMS_VCU_MSG03_Byte4(b0, b1, b2, b3, b4, b5, b6, b7) {
	if ( cmu_u_errflags[8] === 0 ) {
	    if ( 1 === b0 )
		imgCmu9u.source = "../../../images/0-color/bms/cmu_normal_u.png";
	    else
		imgCmu9u.source = "../../../images/0-color/bms/cmu_norm_open_u.png";
	}

	if ( cmu_u_errflags[9] === 0 ) {
	    if ( 1 === b1 )
		imgCmu10u.source = "../../../images/0-color/bms/cmu_normal_u.png";
	    else
		imgCmu10u.source = "../../../images/0-color/bms/cmu_norm_open_u.png";
	}

	if ( cmu_u_errflags[10] === 0 ) {
	    if ( 1 === b2 )
		imgCmu11u.source = "../../../images/0-color/bms/cmu_normal_u.png";
	    else
		imgCmu11u.source = "../../../images/0-color/bms/cmu_norm_open_u.png";
	}

	if ( cmu_u_errflags[11] === 0 ) {
	    if ( 1 === b3 ) {
		imgCmu12u.source = "../../../images/0-color/bms/cmu_normal_u.png";
		updateCmuState(11, 0, 1, imgCmu12u);
	    }
	    else {
		imgCmu12u.source = "../../../images/0-color/bms/cmu_norm_open_u.png";
		updateCmuState(11, 0, 0, imgCmu12u);
	    }
	}
    }

    function updateBMS_VCU_MSG03_Byte5(b0, b1, b2, b3, b4, b5, b6, b7) {
	if ( cmu_d_errflags[0] === 0 ) {
	    if ( 1 === b0 )
		imgCmu1d.source = "../../../images/0-color/bms/cmu_normal_d.png";
	    else
		imgCmu1d.source = "../../../images/0-color/bms/cmu_norm_open_d.png";
	}

	if ( cmu_d_errflags[1] === 0 ) {
	    if ( 1 === b1 )
		imgCmu2d.source = "../../../images/0-color/bms/cmu_normal_d.png";
	    else
		imgCmu2d.source = "../../../images/0-color/bms/cmu_norm_open_d.png";
	}

	if ( cmu_d_errflags[2] === 0 ) {
	    if ( 1 === b2 )
		imgCmu3d.source = "../../../images/0-color/bms/cmu_normal_d.png";
	    else
		imgCmu3d.source = "../../../images/0-color/bms/cmu_norm_open_d.png";
	}

	if ( cmu_d_errflags[3] === 0 ) {
	    if ( 1 === b3 )
		imgCmu4d.source = "../../../images/0-color/bms/cmu_normal_d.png";
	    else
		imgCmu4d.source = "../../../images/0-color/bms/cmu_norm_open_d.png";
	}

	if ( cmu_d_errflags[4] === 0 ) {
	    if ( 1 === b4 )
		imgCmu5d.source = "../../../images/0-color/bms/cmu_normal_d.png";
	    else
		imgCmu5d.source = "../../../images/0-color/bms/cmu_norm_open_d.png";
	}

	if ( cmu_d_errflags[5] === 0 ) {
	    if ( 1 === b5 )
		imgCmu6d.source = "../../../images/0-color/bms/cmu_normal_d.png";
	    else
		imgCmu6d.source = "../../../images/0-color/bms/cmu_norm_open_d.png";
	}

	if ( cmu_d_errflags[6] === 0 ) {
	    if ( 1 === b6 )
		imgCmu7d.source = "../../../images/0-color/bms/cmu_normal_d.png";
	    else
		imgCmu7d.source = "../../../images/0-color/bms/cmu_norm_open_d.png";
	}

	if ( cmu_d_errflags[7] === 0 ) {
	    if ( 1 === b7 )
		imgCmu8d.source = "../../../images/0-color/bms/cmu_normal_d.png";
	    else
		imgCmu8d.source = "../../../images/0-color/bms/cmu_norm_open_d.png";
	}
    }

    function updateBMS_VCU_MSG03_Byte6(b0, b1, b2, b3, b4, b5, b6, b7) {
	//console.debug(b0+","+b1+","+b2+","+b3+","+b4+","+b5+","+b6+","+b7);
	//console.debug(cmu_d_errflags[8]+","+cmu_d_errflags[9]+","+cmu_d_errflags[10]+","+cmu_d_errflags[11]);
	if ( cmu_d_errflags[8] === 0 ) {
	    if ( 1 === b0 )
		imgCmu9d.source = "../../../images/0-color/bms/cmu_normal_d.png";
	    else
		imgCmu9d.source = "../../../images/0-color/bms/cmu_norm_open_d.png";
	}

	if ( cmu_d_errflags[9] === 0 ) {
	    if ( 1 === b1 )
		imgCmu10d.source = "../../../images/0-color/bms/cmu_normal_d.png";
	    else
		imgCmu10d.source = "../../../images/0-color/bms/cmu_norm_open_d.png";
	}

	if ( cmu_d_errflags[10] === 0 ) {
	    if ( 1 === b2 )
		imgCmu11d.source = "../../../images/0-color/bms/cmu_normal_d.png";
	    else
		imgCmu11d.source = "../../../images/0-color/bms/cmu_norm_open_d.png";
	}

	if ( cmu_d_errflags[11] === 0 ) {
	    if ( 1 === b3 )
		imgCmu12d.source = "../../../images/0-color/bms/cmu_normal_d.png";
	    else
		imgCmu12d.source = "../../../images/0-color/bms/cmu_norm_open_d.png";
	}
    }

    function updateBMS_VCU_MSG04(chg_state, battery_type,
    s_ri_voltage, bms_code) {
    // console.debug("updateBMS_VCU_MSG04");
    // TODO:
    }

    Rectangle {
        id: recBmsAnalog
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
        source: "../../../images/0-color/HMI-ICON-55.png"
        fillMode: Image.PreserveAspectFit
        MouseArea {
            id: maBack
            z: 2
            anchors.fill: parent
            onClicked: {
                bmsAnalog.hide();
            }
        }
    }

    Rectangle {
        id: rowBMS
        x: 200
        y: 30
        width: 300
        height: 43
        color: "#161616"
        anchors.leftMargin: 50
        Text {
            id: txtBmsAnalog
            y: 0
            width: 100
            height: 43
            color: "#ffffff"
            text: qsTr("BMS (Analogue)")
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 25
            horizontalAlignment: Text.AlignLeft
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.verticalCenterOffset: 0
        }
        anchors.topMargin: 200
        anchors.left: parent.left
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

    Rectangle {
        id: recErrorLevel
        x: 202
        width: 240
        height: 25
        color: "#161616"
        anchors.leftMargin: 50
        anchors.top: rowColumn0.bottom
        Text {
            id: txtErrorLevel
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Error Level"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 20
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.left: siErrorLevel.right
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siErrorLevel
            y: 87
            width: 20
            height: 20
            color: "#000000"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            active: false
        }
        anchors.topMargin: 11
        anchors.left: parent.left
    }

    Rectangle {
        id: recMainContactorCantClose
        x: 192
        y: -8
        width: 240
        height: 25
        color: "#161616"
        anchors.leftMargin: 50
        anchors.top: recErrorLevel.bottom
        Text {
            id: txtMainContactorCantClose
            y: 0
            width: 190
            height: 20
            color: "#ffffff"
            text: "Main Contactor Can't Close"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 20
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.left: siMContactorCannotClose.right
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siMContactorCannotClose
            y: 87
            width: 20
            height: 20
            color: "#ff0000"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            active: false
        }
        anchors.topMargin: 5
        anchors.left: parent.left
    }

    Rectangle {
        id: recMainContactorSticking
        x: 211
        width: 240
        height: 25
        color: "#161616"
        anchors.leftMargin: 50
        anchors.top: recMainContactorCantClose.bottom
        Text {
            id: txtMainContactorSticking
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Main Contactor Sticking"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 20
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.left: siMainContactorSticking.right
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siMainContactorSticking
            y: 87
            width: 20
            height: 20
            color: "#ff0000"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            active: false
        }
        anchors.topMargin: 5
        anchors.left: parent.left
    }

    Rectangle {
        id: recPowerBatteryAlarm
        x: 211
        y: -2
        width: 240
        height: 25
        color: "#161616"
        anchors.leftMargin: 50
        anchors.top: recMainContactorSticking.bottom
        Text {
            id: txtPowerBatteryAlarm
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Power Battery Alarm"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 20
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.left: siPowerBatteryAlarm.right
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siPowerBatteryAlarm
            y: 87
            width: 20
            height: 20
            color: "#ff0000"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            active: false
        }
        anchors.topMargin: 5
        anchors.left: parent.left
    }

    Rectangle {
        id: recVoltSamplingError
        x: 198
        y: -4
        width: 230
        height: 25
        color: "#161616"
        anchors.leftMargin: 30
        anchors.top: recBMSInternalError.bottom
        Text {
            id: txtVoltSamplingError
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Volt. Sampling Error"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 20
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.left: siVoltSamplingError.right
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siVoltSamplingError
            y: 87
            width: 20
            height: 20
            color: "#ff0000"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            active: false
        }
        anchors.topMargin: 5
        anchors.left: recErrorLevel.right
    }

    Rectangle {
        id: recTempSamplingError
        x: 188
        y: -12
        width: 230
        height: 25
        color: "#161616"
        anchors.leftMargin: 30
        anchors.top: recVoltSamplingError.bottom
        Text {
            id: txtTempSamplingError
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Temp. Sampling Error"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 20
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.left: siTempSamplingError.right
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siTempSamplingError
            y: 87
            width: 20
            height: 20
            color: "#ff0000"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            active: false
        }
        anchors.topMargin: 5
        anchors.left: recErrorLevel.right
    }

    Rectangle {
        id: recCMUCommError
        x: 207
        y: -4
        width: 230
        height: 25
        color: "#161616"
        anchors.leftMargin: 30
        anchors.top: recTempSamplingError.bottom
        Text {
            id: txtCMUCommError
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "CMU Comm. Error"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 20
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.left: siCMUCommError.right
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siCMUCommError
            y: 87
            width: 20
            height: 20
            color: "#ff0000"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            active: false
        }
        anchors.topMargin: 5
        anchors.left: recErrorLevel.right
    }

    Rectangle {
        id: recBMSInternalError
        x: 207
        y: 123
        width: 230
        height: 25
        color: "#161616"
        anchors.leftMargin: 30
        anchors.top: rowColumn0.bottom
        Text {
            id: txtBMSInternalError
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "BMS Internal Error"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 20
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.left: siBMSInternalError.right
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siBMSInternalError
            y: 87
            width: 20
            height: 20
            color: "#ff0000"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            active: false
        }
        anchors.topMargin: 10
        anchors.left: recErrorLevel.right
    }

    Rectangle {
        id: recChargeEcuCommError
        x: 211
        y: -12
        width: 230
        height: 25
        color: "#161616"
        anchors.leftMargin: 30
        anchors.top: recCMUCommError.bottom
        Text {
            id: txtChargeEcuCommError
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Charge ECU Comm. Error"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 20
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.left: siChargeEcuCommError.right
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siChargeEcuCommError
            y: 87
            width: 20
            height: 20
            color: "#ff0000"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            active: false
        }
        anchors.topMargin: 5
        anchors.left: recErrorLevel.right
    }

    Rectangle {
        id: rowCharge
        width: 200
        height: 40
        color: "#161616"
        anchors.top: rowBMS.bottom
        anchors.leftMargin: 30
        Text {
            id: txtCharge
            y: 0
            width: 100
            height: 25
            color: "#ffffff"
            text: qsTr("Charge :")
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenterOffset: 0
            anchors.left: parent.left
            font.pixelSize: 20
        }
        anchors.topMargin: 50
        anchors.left: recBMSInternalError.right
    }

    Rectangle {
        id: rowDriveStop
        width: 200
        height: 40
        color: "#161616"
        anchors.top: rowBMS.bottom
        anchors.leftMargin: 30
        Text {
            id: txtDriveStop
            y: 0
            width: 100
            height: 25
            color: "#ffffff"
            text: qsTr("Drive / Stop :")
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenterOffset: 0
            anchors.left: parent.left
            font.pixelSize: 20
        }
        anchors.topMargin: 50
        anchors.left: recHighVoltageAtCharge.right
    }

    Rectangle {
        id: rowColumn0
        width: 200
        height: 40
        color: "#161616"
        anchors.top: rowBMS.bottom
        anchors.leftMargin: 50
        Text {
            id: txtColumn0
            y: 0
            width: 100
            height: 25
            color: "#ffffff"
            text: qsTr("")
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenterOffset: 0
            anchors.left: parent.left
            font.pixelSize: 20
        }
        anchors.topMargin: 50
        anchors.left: parent.left
    }

    Rectangle {
        id: recOverCurrentAtCharge
        x: 197
        width: 300
        height: 25
        color: "#161616"
        anchors.top: recLowInsulationAtCharge.bottom
        anchors.topMargin: 5
        anchors.leftMargin: 30
        Text {
            id: txtOverCurrent
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Over Current"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 10
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.left: siOverCurrent.right
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siOverCurrent
            y: 87
            width: 20
            height: 20
            color: "#ff0000"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            active: false
        }
        anchors.left: recBMSInternalError.right
    }

    Rectangle {
        id: recHighCellVoltageAtCharge
        x: 216
        y: 5
        width: 300
        height: 25
        color: "#161616"
        anchors.leftMargin: 30
        anchors.top: recHighVoltageAtCharge.bottom
        Text {
            id: txtSevereHighCellVoltage
            y: 0
            width: 50
            height: 20
            color: "#ffffff"
            text: "Severe"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 10
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.left: siSevereHighCellVoltage.right
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siSevereHighCellVoltage
            y: 87
            width: 20
            height: 20
            color: "#ff0000"
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 130
            active: false
        }

        Text {
            id: txtWarningHighCellVoltage
            y: 1
            width: 60
            height: 20
            color: "#ffffff"
            text: "Warning"
            font.pixelSize: 15
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.left: siWarningHighCellVoltage.right
        }

        StatusIndicator {
            id: siWarningHighCellVoltage
            y: 88
            width: 20
            height: 20
            color: "#ff0000"
            anchors.left: parent.left
            anchors.leftMargin: 220
            anchors.verticalCenter: parent.verticalCenter
            active: false
        }

        Text {
            id: txtHighVoltageCharge
            x: 0
            y: 0
            width: 120
            height: 20
            color: "#ffffff"
            text: "High Cell Voltage"
            font.pixelSize: 15
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenterOffset: 0
            verticalAlignment: Text.AlignVCenter
            anchors.left: parent.left
        }
        anchors.topMargin: 5
        anchors.left: recBMSInternalError.right
    }

    Rectangle {
        id: recHighVoltageAtCharge
        x: 216
        y: 132
        width: 300
        height: 25
        color: "#161616"
        anchors.leftMargin: 30
        anchors.top: rowCharge.bottom
        Text {
            id: txtSevereHighVoltage
            y: 0
            width: 50
            height: 20
            color: "#ffffff"
            text: "Severe"
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 10
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.left: siSevereHighVoltage.right
            font.pixelSize: 15
        }

        StatusIndicator {
            id: siSevereHighVoltage
            y: 87
            width: 20
            height: 20
            color: "#ff0000"
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 130
            active: false
        }

        Text {
            id: txtHighVoltageSectionDs4
            x: 0
            y: 0
            width: 90
            height: 20
            color: "#ffffff"
            text: "High Voltage"
            font.pixelSize: 15
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenterOffset: 0
            verticalAlignment: Text.AlignVCenter
            anchors.left: parent.left
        }

        Text {
            id: txtWarningHighVoltage
            y: 1
            width: 60
            height: 20
            color: "#ffffff"
            text: "Warning"
            font.pixelSize: 15
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.left: siWarningHighVoltage.right
        }

        StatusIndicator {
            id: siWarningHighVoltage
            y: 88
            width: 20
            height: 20
            color: "#ff0000"
            anchors.left: parent.left
            anchors.leftMargin: 220
            anchors.verticalCenter: parent.verticalCenter
            active: false
        }
        anchors.topMargin: 10
        anchors.left: recBMSInternalError.right
    }

    Rectangle {
        id: recOverTimeAtCharge
        x: 188
        width: 300
        height: 25
        color: "#161616"
        anchors.top: recOverCurrentAtCharge.bottom
        anchors.topMargin: 5
        Text {
            id: txtOverTime
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Over Time"
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 15
            anchors.leftMargin: 10
            anchors.left: siOverTime.right
            verticalAlignment: Text.AlignVCenter
        }

        StatusIndicator {
            id: siOverTime
            y: 87
            width: 20
            height: 20
            color: "#ff0000"
            active: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
        }
        anchors.leftMargin: 30
        anchors.left: recBMSInternalError.right
    }

    Rectangle {
        id: recCommErrorAtCharge
        x: 207
        y: -4
        width: 300
        height: 25
        color: "#161616"
        anchors.top: recHighCellVoltageAtCharge.bottom
        anchors.topMargin: 5
        Text {
            id: txtSevereCommError
            y: 0
            width: 50
            height: 20
            color: "#ffffff"
            text: "Severe"
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 15
            anchors.leftMargin: 10
            anchors.left: siSevereCommError.right
            verticalAlignment: Text.AlignVCenter
        }

        StatusIndicator {
            id: siSevereCommError
            y: 87
            width: 20
            height: 20
            color: "#ff0000"
            anchors.left: parent.left
            active: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 130
        }

        Text {
            id: txtWarningCommError
            y: 6
            width: 60
            height: 20
            color: "#ffffff"
            text: "Warning"
            font.pixelSize: 15
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.left: siWarningCommError.right
        }

        StatusIndicator {
            id: siWarningCommError
            y: 93
            width: 20
            height: 20
            color: "#ff0000"
            anchors.left: parent.left
            anchors.leftMargin: 220
            anchors.verticalCenter: parent.verticalCenter
            active: false
        }

        Text {
            id: txtCommErr
            x: 0
            y: 0
            width: 120
            height: 20
            color: "#ffffff"
            text: "Comm. Error"
            font.pixelSize: 15
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 0
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.left: parent.left
        }
        anchors.leftMargin: 30
        anchors.left: recBMSInternalError.right
    }

    Rectangle {
        id: recHighTempAtCharge
        x: 182
        width: 300
        height: 25
        color: "#161616"
        anchors.top: recCommErrorAtCharge.bottom
        anchors.topMargin: 5
        Text {
            id: txtSevereHighTemp
            y: 0
            width: 50
            height: 20
            color: "#ffffff"
            text: "Severe"
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 15
            anchors.leftMargin: 10
            anchors.left: siSevereHighTemp.right
            verticalAlignment: Text.AlignVCenter
        }

        StatusIndicator {
            id: siSevereHighTemp
            y: 87
            width: 20
            height: 20
            color: "#ff0000"
            anchors.left: parent.left
            active: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 130
        }

        Text {
            id: txtWarningHighTemp
            y: 1
            width: 60
            height: 20
            color: "#ffffff"
            text: "Warning"
            font.pixelSize: 15
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.left: siWarningHighTemp.right
        }

        StatusIndicator {
            id: siWarningHighTemp
            y: 88
            width: 20
            height: 20
            color: "#ff0000"
            anchors.left: parent.left
            anchors.leftMargin: 220
            anchors.verticalCenter: parent.verticalCenter
            active: false
        }

        Text {
            id: txtHighTempDs1
            x: 0
            y: 0
            width: 120
            height: 20
            color: "#ffffff"
            text: "High Temp."
            font.pixelSize: 15
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 0
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.left: parent.left
        }
        anchors.leftMargin: 30
        anchors.left: recBMSInternalError.right
    }

    Rectangle {
        id: recLowTempAtCharge
        x: 182
        width: 300
        height: 25
        color: "#161616"
        anchors.top: recHighTempAtCharge.bottom
        anchors.topMargin: 5
        Text {
            id: txtSevereLowTemp
            y: 0
            width: 50
            height: 20
            color: "#ffffff"
            text: "Severe"
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 15
            anchors.leftMargin: 10
            anchors.left: siSevereLowTemp.right
            verticalAlignment: Text.AlignVCenter
        }

        StatusIndicator {
            id: siSevereLowTemp
            y: 87
            width: 20
            height: 20
            color: "#ff0000"
            anchors.left: parent.left
            active: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 130
        }

        Text {
            id: txtWarningLowTemp
            y: 0
            width: 60
            height: 20
            color: "#ffffff"
            text: "Warning"
            font.pixelSize: 15
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.left: siWarningLowTemp.right
        }

        StatusIndicator {
            id: siWarningLowTemp
            y: 87
            width: 20
            height: 20
            color: "#ff0000"
            anchors.left: parent.left
            anchors.leftMargin: 220
            anchors.verticalCenter: parent.verticalCenter
            active: false
        }

        Text {
            id: txtLowTempDs1
            x: 0
            y: 0
            width: 120
            height: 20
            color: "#ffffff"
            text: "Low Temp."
            font.pixelSize: 15
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenterOffset: 0
            verticalAlignment: Text.AlignVCenter
            anchors.left: parent.left
        }
        anchors.leftMargin: 30
        anchors.left: recBMSInternalError.right
    }

    Rectangle {
        id: recLowVoltageAtDrive
        x: 205
        y: 3
        width: 300
        height: 25
        color: "#161616"
        anchors.top: recHighVoltageAtCharge.bottom
        anchors.topMargin: 5
        anchors.leftMargin: 30
        anchors.left: recHighVoltageAtCharge.right

        Text {
            id: txtHighVoltageSectionDs1
            x: 0
            y: 0
            width: 90
            height: 20
            color: "#ffffff"
            text: "Low Voltage"
            font.pixelSize: 15
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenterOffset: 0
            verticalAlignment: Text.AlignVCenter
            anchors.left: parent.left
        }

        Text {
            id: txtSevereLowVoltageDs
            y: 0
            width: 50
            height: 20
            color: "#ffffff"
            text: "Severe"
            font.pixelSize: 15
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.left: siSevereLowVoltageDs.right
        }

        StatusIndicator {
            id: siSevereLowVoltageDs
            y: 87
            width: 20
            height: 20
            color: "#ff0000"
            anchors.left: parent.left
            anchors.leftMargin: 130
            anchors.verticalCenter: parent.verticalCenter
            active: false
        }

        Text {
            id: txtWarningLowVoltageDs
            y: 2
            width: 60
            height: 20
            color: "#ffffff"
            text: "Warning"
            font.pixelSize: 15
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.left: siWarningLowVoltageDs.right
        }

        StatusIndicator {
            id: siWarningLowVoltageDs
            y: 89
            width: 20
            height: 20
            color: "#ff0000"
            anchors.left: parent.left
            anchors.leftMargin: 220
            anchors.verticalCenter: parent.verticalCenter
            active: false
        }
    }

    Rectangle {
        id: recOverCurrentAtDrive
        x: 195
        width: 300
        height: 25
        color: "#161616"
        anchors.top: recLowInsulationDS.bottom
        anchors.topMargin: 5
        Text {
            id: txtOverCurrentDs
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Over Current"
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 15
            anchors.leftMargin: 10
            anchors.left: siOverCurrentDs.right
            verticalAlignment: Text.AlignVCenter
        }

        StatusIndicator {
            id: siOverCurrentDs
            y: 87
            width: 20
            height: 20
            color: "#ffa500"
            active: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
        }
        anchors.leftMargin: 30
        anchors.left: recHighVoltageAtCharge.right
    }

    Rectangle {
        id: recHighCellVoltageAtDrive
        x: 214
        y: 3
        width: 300
        height: 25
        color: "#161616"
        anchors.top: recLowVoltageAtDrive.bottom
        anchors.topMargin: 5
        Text {
            id: txtSevereHighCellVoltageDs
            y: 0
            width: 50
            height: 20
            color: "#ffffff"
            text: "Severe"
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 15
            anchors.leftMargin: 10
            anchors.left: siSevereHighCellVoltageDs.right
            verticalAlignment: Text.AlignVCenter
        }

        StatusIndicator {
            id: siSevereHighCellVoltageDs
            y: 87
            width: 20
            height: 20
            color: "#ffa500"
            anchors.left: parent.left
            active: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 130
        }

        Text {
            id: txtHighVoltageSectionDs2
            x: 0
            y: 0
            width: 120
            height: 20
            color: "#ffffff"
            text: "High Cell Voltage"
            font.pixelSize: 15
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 0
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.left: parent.left
        }

        Text {
            id: txtWarningHighCellVoltageDs
            y: 7
            width: 60
            height: 20
            color: "#ffffff"
            text: "Warning"
            font.pixelSize: 15
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.left: siWarningHighCellVoltageDs.right
        }

        StatusIndicator {
            id: siWarningHighCellVoltageDs
            y: 94
            width: 20
            height: 20
            color: "#ffa500"
            anchors.left: parent.left
            anchors.leftMargin: 220
            anchors.verticalCenter: parent.verticalCenter
            active: false
        }
        anchors.leftMargin: 30
        anchors.left: recHighVoltageAtCharge.right
    }

    Rectangle {
        id: recLowCellVoltageDs
        x: 196
        y: -6
        width: 300
        height: 25
        color: "#161616"
        anchors.top: recHighCellVoltageAtDrive.bottom
        anchors.topMargin: 5
        anchors.leftMargin: 30
        anchors.left: recHighVoltageAtCharge.right

        Text {
            id: txtHighVoltageSectionDs3
            x: 0
            y: 0
            width: 120
            height: 20
            color: "#ffffff"
            text: "Low Cell Voltage"
            font.pixelSize: 15
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenterOffset: 0
            verticalAlignment: Text.AlignVCenter
            anchors.left: parent.left
        }

        Text {
            id: txtSevereLowCellVoltageDs
            y: 0
            width: 50
            height: 20
            color: "#ffffff"
            text: "Severe"
            font.pixelSize: 15
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.left: siSevereLowCellVoltageDs.right
        }

        StatusIndicator {
            id: siSevereLowCellVoltageDs
            y: 87
            width: 20
            height: 20
            color: "#ff0000"
            anchors.left: parent.left
            anchors.leftMargin: 130
            anchors.verticalCenter: parent.verticalCenter
            active: false
        }

        Text {
            id: txtWarningLowCellVoltageDs
            y: -6
            width: 60
            height: 20
            color: "#ffffff"
            text: "Warning"
            font.pixelSize: 15
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.left: siWarningLowCellVoltageDs.right
        }

        StatusIndicator {
            id: siWarningLowCellVoltageDs
            y: 81
            width: 20
            height: 20
            color: "#ffa500"
            anchors.left: parent.left
            anchors.leftMargin: 220
            anchors.verticalCenter: parent.verticalCenter
            active: false
        }
    }

    Rectangle {
        id: recHighDiffVoltage
        x: 186
        y: -14
        width: 300
        height: 25
        color: "#161616"
        anchors.top: recLowSoc.bottom
        anchors.topMargin: 5
        Text {
            id: txtHighDiffVoltage
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "High Diff. Voltage"
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 15
            anchors.leftMargin: 10
            anchors.left: siHighDiffVoltage.right
            verticalAlignment: Text.AlignVCenter
        }

        StatusIndicator {
            id: siHighDiffVoltage
            y: 87
            width: 20
            height: 20
            color: "#ffa500"
            active: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
        }
        anchors.leftMargin: 30
        anchors.left: recHighVoltageAtCharge.right
    }

    Rectangle {
        id: recHighVoltageDs
        x: 628
        y: 324
        width: 300
        height: 25
        color: "#161616"
        anchors.top: rowCharge.bottom
        anchors.topMargin: 10
        Text {
            id: txtSevereHighVoltageDs
            y: 0
            width: 50
            height: 20
            color: "#ffffff"
            text: "Severe"
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 15
            anchors.leftMargin: 10
            anchors.left: siSevereHighVoltageDs.right
            verticalAlignment: Text.AlignVCenter
        }

        StatusIndicator {
            id: siSevereHighVoltageDs
            y: 87
            width: 20
            height: 20
            color: "#ff0000"
            anchors.left: parent.left
            active: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 130
        }

        Text {
            id: txtWarningHighVoltageDs
            y: -9
            width: 60
            height: 20
            color: "#ffffff"
            text: "Warning"
            font.pixelSize: 15
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.left: siWarningHighVoltageDs.right
        }

        StatusIndicator {
            id: siWarningHighVoltageDs
            y: 78
            width: 20
            height: 20
            color: "#ff0000"
            anchors.left: parent.left
            anchors.leftMargin: 220
            anchors.verticalCenter: parent.verticalCenter
            active: false
        }

        Text {
            id: txtHighVoltageSectionDs
            x: 0
            y: 0
            width: 90
            height: 20
            color: "#ffffff"
            text: "High Voltage"
            font.pixelSize: 15
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenterOffset: 0
            verticalAlignment: Text.AlignVCenter
            anchors.left: parent.left
        }
        anchors.leftMargin: 30
        anchors.left: recHighVoltageAtCharge.right
    }

    Rectangle {
        id: recHighTempDs
        x: 180
        width: 300
        height: 25
        color: "#161616"
        anchors.top: recLowCellVoltageDs.bottom
        anchors.topMargin: 5
        Text {
            id: txtSevereHighTempDs
            y: 0
            width: 50
            height: 20
            color: "#ffffff"
            text: "Severe"
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 15
            anchors.leftMargin: 10
            anchors.left: siSevereHighTempDs.right
            verticalAlignment: Text.AlignVCenter
        }

        StatusIndicator {
            id: siSevereHighTempDs
            y: 87
            width: 20
            height: 20
            color: "#ff0000"
            anchors.left: parent.left
            active: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 130
        }

        Text {
            id: txtHighTempDs
            x: 0
            y: 0
            width: 120
            height: 20
            color: "#ffffff"
            text: "High Temp."
            font.pixelSize: 15
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenterOffset: 0
            verticalAlignment: Text.AlignVCenter
            anchors.left: parent.left
        }

        Text {
            id: txtWarningHighTempDs
            y: 0
            width: 60
            height: 20
            color: "#ffffff"
            text: "Warning"
            font.pixelSize: 15
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.left: siWarningHighTempDs.right
        }

        StatusIndicator {
            id: siWarningHighTempDs
            y: 87
            width: 20
            height: 20
            color: "#ffa500"
            anchors.left: parent.left
            anchors.leftMargin: 220
            anchors.verticalCenter: parent.verticalCenter
            active: false
        }
        anchors.leftMargin: 30
        anchors.left: recHighVoltageAtCharge.right
    }

    Rectangle {
        id: recWarningHighTempDs
        x: 199
        y: -12
        width: 300
        height: 25
        color: "#161616"
        anchors.top: recHighTempDs.bottom
        anchors.topMargin: 5
        anchors.leftMargin: 30
        anchors.left: recHighVoltageAtCharge.right

        Text {
            id: txtLowTempDs
            x: 0
            y: 0
            width: 120
            height: 20
            color: "#ffffff"
            text: "Low Temp."
            font.pixelSize: 15
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 0
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.left: parent.left
        }

        Text {
            id: txtSevereLowTempDs
            y: 0
            width: 50
            height: 20
            color: "#ffffff"
            text: "Severe"
            font.pixelSize: 15
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.left: siSevereLowTempDs.right
        }

        StatusIndicator {
            id: siSevereLowTempDs
            y: 87
            width: 20
            height: 20
            color: "#ff0000"
            anchors.left: parent.left
            anchors.leftMargin: 130
            anchors.verticalCenter: parent.verticalCenter
            active: false
        }

        Text {
            id: txtWarningLowTempDs
            y: -4
            width: 60
            height: 20
            color: "#ffffff"
            text: "Warning"
            font.pixelSize: 15
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.left: siWarningLowTempDs.right
        }

        StatusIndicator {
            id: siWarningLowTempDs
            y: 83
            width: 20
            height: 20
            color: "#ff0000"
            anchors.left: parent.left
            anchors.leftMargin: 220
            anchors.verticalCenter: parent.verticalCenter
            active: false
        }
    }

    Rectangle {
        id: recLowInsulationDS
        x: 180
        y: -20
        width: 300
        height: 25
        color: "#161616"
        z: 2
        anchors.top: recWarningHighTempDs.bottom
        anchors.topMargin: 5
        anchors.leftMargin: 30
        anchors.left: recHighVoltageAtCharge.right

        Text {
            id: txtLowInsulationDS
            x: 0
            y: 0
            width: 120
            height: 20
            color: "#ffffff"
            text: "Low Insulation"
            font.pixelSize: 15
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenterOffset: 0
            verticalAlignment: Text.AlignVCenter
            anchors.left: parent.left
        }

        Text {
            id: txtSevereLowInsulationDS
            y: 0
            width: 50
            height: 20
            color: "#ffffff"
            text: "Severe"
            font.pixelSize: 15
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.left: siSevereLowInsulationDS.right
        }

        StatusIndicator {
            id: siSevereLowInsulationDS
            y: 87
            width: 20
            height: 20
            color: "#ff0000"
            anchors.left: parent.left
            anchors.leftMargin: 130
            anchors.verticalCenter: parent.verticalCenter
            active: false
        }

        Text {
            id: txtWarningLowInsulationDS
            y: -8
            width: 60
            height: 20
            color: "#ffffff"
            text: "Warning"
            font.pixelSize: 15
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.left: siWarningLowInsulationDS.right
        }

        StatusIndicator {
            id: siWarningLowInsulationDS
            y: 79
            width: 20
            height: 20
            color: "#ff0000"
            anchors.left: parent.left
            anchors.leftMargin: 220
            anchors.verticalCenter: parent.verticalCenter
            active: false
        }
    }

    Rectangle {
        id: recLowSoc
        x: 920
        y: 348
        width: 300
        height: 25
        color: "#161616"
        anchors.top: recOverCurrentAtDrive.bottom
        anchors.topMargin: 5
        Text {
            id: txtLowSoc
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "Low SOC"
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 15
            anchors.leftMargin: 10
            anchors.left: siLowSoc.right
            verticalAlignment: Text.AlignVCenter
        }

        StatusIndicator {
            id: siLowSoc
            y: 87
            width: 20
            height: 20
            color: "#ffa500"
            active: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
        }
        anchors.leftMargin: 30
        anchors.left: recHighVoltageAtCharge.right
    }

    Rectangle {
        id: recLowInsulationAtCharge
        x: 189
        width: 300
        height: 25
        color: "#161616"
        anchors.top: recLowTempAtCharge.bottom
        Text {
            id: txtSevereLowInsulation
            y: 0
            width: 50
            height: 20
            color: "#ffffff"
            text: "Severe"
            font.pixelSize: 15
            anchors.left: siSevereLowInsulation.right
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
        }

        StatusIndicator {
            id: siSevereLowInsulation
            y: 87
            width: 20
            height: 20
            color: "#ff0000"
            anchors.left: parent.left
            anchors.leftMargin: 130
            anchors.verticalCenter: parent.verticalCenter
            active: false
        }

        Text {
            id: txtWarningLowInsulation
            y: 7
            width: 60
            height: 20
            color: "#ffffff"
            text: "Warning"
            font.pixelSize: 15
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.left: siWarningLowInsulation.right
        }

        StatusIndicator {
            id: siWarningLowInsulation
            y: 94
            width: 20
            height: 20
            color: "#ff0000"
            anchors.left: parent.left
            anchors.leftMargin: 220
            anchors.verticalCenter: parent.verticalCenter
            active: false
        }

        Text {
            id: txtLowInsulationAtCharge
            x: 0
            y: 0
            width: 120
            height: 20
            color: "#ffffff"
            text: "Low Insulation"
            font.pixelSize: 15
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 0
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.left: parent.left
        }
        anchors.left: recBMSInternalError.right
        anchors.leftMargin: 30
        anchors.topMargin: 5
    }

    Rectangle {
        id: recAbnormalHvilAtDrive
        x: 368
        width: 300
        height: 25
        color: "#161616"
        anchors.left: recHighVoltageAtCharge.right
        anchors.leftMargin: 30
        anchors.topMargin: 5
        anchors.top: recHighDiffVoltage.bottom
        Text {
            id: txtAbnormalHvilDs
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "HVIL Warning"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siAbnormalHvilDs.right
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 10
            font.pixelSize: 15
            horizontalAlignment: Text.AlignLeft
        }

        StatusIndicator {
            id: siAbnormalHvilDs
            y: 87
            width: 20
            height: 20
            color: "#ff0000"
            anchors.verticalCenter: parent.verticalCenter
            active: false
            anchors.leftMargin: 0
        }
    }

    Rectangle {
        id: recAbnormalHvilAtCharge
        x: 630
        width: 300
        height: 25
        color: "#161616"
        anchors.left: recBMSInternalError.right
        anchors.leftMargin: 30
        anchors.topMargin: 5
        anchors.top: recOverTimeAtCharge.bottom
        Text {
            id: txtAbnormalHvil
            y: 0
            width: 180
            height: 20
            color: "#ffffff"
            text: "HVIL Warning"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: siAbnormalHvil.right
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 10
            font.pixelSize: 15
            horizontalAlignment: Text.AlignLeft
        }

        StatusIndicator {
            id: siAbnormalHvil
            y: 87
            width: 20
            height: 20
            color: "#ff0000"
            anchors.verticalCenter: parent.verticalCenter
            active: false
            anchors.leftMargin: 0
        }
    }

    Image {
        id: imgBMS
        x: 424
        y: 358
        width: 200
        height: 200
        sourceSize.height: 267
        sourceSize.width: 267
        source: "../../../images/0-color/bms/bms-normal.png"
        fillMode: Image.Stretch
    }

    Image {
        id: imgCharger
        x: 50
        y: 510
        width: 150
        height: 200
        source: "../../../images/0-color/bms/charger_normal.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imgCmu1u
        y: 510
        width: 90
        height: 60
        anchors.left: imgCharger.right
        anchors.leftMargin: 10
        source: "../../../images/0-color/bms/cmu_normal_u.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imgCmu1d
        width: 90
        height: 60
        anchors.top: imgCmu1u.bottom
        anchors.topMargin: -23
        anchors.left: imgCharger.right
        anchors.leftMargin: 10
        source: "../../../images/0-color/bms/cmu_normal_d.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imgCmu2u
        y: 510
        width: 90
        height: 60
        anchors.left: imgWiring12.right
        anchors.leftMargin: -5
        source: "../../../images/0-color/bms/cmu_normal_u.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imgCmu2d
        width: 90
        height: 60
        anchors.top: imgCmu2u.bottom
        anchors.topMargin: -23
        anchors.left: imgWiring12.right
        anchors.leftMargin: -5
        source: "../../../images/0-color/bms/cmu_normal_d.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imgWiring12
        width: 27
        height: 20
        anchors.top: imgCmu1u.top
        anchors.topMargin: 36
        anchors.left: imgCmu1u.right
        anchors.leftMargin: -5
        source: "../../../images/0-color/bms/cmu_wiring.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imgCmu3u
        y: 510
        width: 90
        height: 60
        anchors.left: imgWiring23.right
        anchors.leftMargin: -5
        source: "../../../images/0-color/bms/cmu_normal_u.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imgCmu3d
        width: 90
        height: 60
        anchors.left: imgWiring23.right
        anchors.leftMargin: -5
        anchors.top: imgCmu3u.bottom
        anchors.topMargin: -23
        source: "../../../images/0-color/bms/cmu_normal_d.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imgWiring23
        width: 27
        height: 20
        anchors.top: imgCmu2u.top
        anchors.topMargin: 36
        anchors.left: imgCmu2u.right
        anchors.leftMargin: -5
        source: "../../../images/0-color/bms/cmu_wiring.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imgCmu4u
        y: 510
        width: 90
        height: 60
        anchors.left: imgWiring34.right
        anchors.leftMargin: -5
        source: "../../../images/0-color/bms/cmu_normal_u.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imgCmu4d
        width: 90
        height: 60
        anchors.left: imgWiring34.right
        anchors.leftMargin: -5
        anchors.top: imgCmu4u.bottom
        anchors.topMargin: -23
        source: "../../../images/0-color/bms/cmu_normal_d.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imgWiring34
        width: 27
        height: 20
        anchors.left: imgCmu3u.right
        anchors.leftMargin: -5
        anchors.top: imgCmu3u.top
        anchors.topMargin: 36
        source: "../../../images/0-color/bms/cmu_wiring.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imgCmu5u
        y: 510
        width: 90
        height: 60
        anchors.left: imgWiring45.right
        anchors.leftMargin: -5
        source: "../../../images/0-color/bms/cmu_normal_u.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imgCmu5d
        width: 90
        height: 60
        anchors.left: imgWiring45.right
        anchors.leftMargin: -5
        anchors.top: imgCmu5u.bottom
        anchors.topMargin: -23
        source: "../../../images/0-color/bms/cmu_normal_d.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imgWiring45
        width: 27
        height: 20
        anchors.left: imgCmu4u.right
        anchors.leftMargin: -5
        anchors.top: imgCmu4u.top
        anchors.topMargin: 36
        source: "../../../images/0-color/bms/cmu_wiring.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imgCmu6u
        y: 510
        width: 90
        height: 60
        anchors.left: imgWiring56.right
        anchors.leftMargin: -5
        source: "../../../images/0-color/bms/cmu_normal_u.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imgCmu6d
        width: 90
        height: 60
        anchors.left: imgWiring56.right
        anchors.leftMargin: -5
        anchors.top: imgCmu6u.bottom
        anchors.topMargin: -23
        source: "../../../images/0-color/bms/cmu_normal_d.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imgWiring56
        width: 27
        height: 20
        anchors.top: imgCmu5u.top
        anchors.topMargin: 36
        anchors.left: imgCmu5u.right
        anchors.leftMargin: -5
        source: "../../../images/0-color/bms/cmu_wiring.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imgCmu7u
        width: 90
        height: 60
        anchors.top: imgCmu1d.bottom
        anchors.topMargin: 0
        anchors.left: imgCharger.right
        anchors.leftMargin: 10
        source: "../../../images/0-color/bms/cmu_normal_u.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imgCmu7d
        width: 90
        height: 60
        anchors.top: imgCmu7u.bottom
        anchors.topMargin: -23
        anchors.left: imgCharger.right
        anchors.leftMargin: 10
        source: "../../../images/0-color/bms/cmu_normal_d.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imgCmu8u
        width: 90
        height: 60
        anchors.top: imgCmu2d.bottom
        anchors.topMargin: 0
        anchors.left: imgWiring78.right
        anchors.leftMargin: -5
        source: "../../../images/0-color/bms/cmu_normal_u.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imgCmu8d
        width: 90
        height: 60
        anchors.top: imgCmu8u.bottom
        anchors.topMargin: -23
        anchors.left: imgWiring78.right
        anchors.leftMargin: -5
        source: "../../../images/0-color/bms/cmu_normal_d.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imgWiring78
        width: 27
        height: 20
        anchors.top: imgCmu7u.top
        anchors.topMargin: 36
        anchors.left: imgCmu1u.right
        anchors.leftMargin: -5
        source: "../../../images/0-color/bms/cmu_wiring.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imgCmu9u
        y: 607
        width: 90
        height: 60
        anchors.left: imgWiring89.right
        anchors.leftMargin: -5
        source: "../../../images/0-color/bms/cmu_normal_u.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imgCmu9d
        width: 90
        height: 60
        anchors.left: imgWiring89.right
        anchors.leftMargin: -5
        anchors.top: imgCmu9u.bottom
        anchors.topMargin: -23
        source: "../../../images/0-color/bms/cmu_normal_d.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imgWiring89
        width: 27
        height: 20
        anchors.left: imgCmu8u.right
        anchors.leftMargin: -5
        anchors.top: imgCmu8u.top
        anchors.topMargin: 36
        source: "../../../images/0-color/bms/cmu_wiring.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imgCmu10u
        y: 607
        width: 90
        height: 60
        anchors.left: imgWiring910.right
        anchors.leftMargin: -5
        source: "../../../images/0-color/bms/cmu_normal_u.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imgCmu10d
        width: 90
        height: 60
        anchors.left: imgWiring910.right
        anchors.leftMargin: -5
        anchors.top: imgCmu10u.bottom
        anchors.topMargin: -23
        source: "../../../images/0-color/bms/cmu_normal_d.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imgWiring910
        width: 27
        height: 20
        anchors.left: imgCmu9u.right
        anchors.leftMargin: -5
        anchors.top: imgCmu9u.top
        anchors.topMargin: 36
        source: "../../../images/0-color/bms/cmu_wiring.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imgCmu11u
        y: 607
        width: 90
        height: 60
        anchors.left: imgWiring1011.right
        anchors.leftMargin: -5
        source: "../../../images/0-color/bms/cmu_normal_u.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imgCmu11d
        width: 90
        height: 60
        anchors.left: imgWiring1011.right
        anchors.leftMargin: -5
        anchors.top: imgCmu11u.bottom
        anchors.topMargin: -23
        source: "../../../images/0-color/bms/cmu_normal_d.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imgWiring1011
        width: 27
        height: 20
        anchors.top: imgCmu10u.top
        anchors.topMargin: 36
        anchors.left: imgCmu10u.right
        anchors.leftMargin: -5
        source: "../../../images/0-color/bms/cmu_wiring.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imgCmu12u
        y: 607
        width: 90
        height: 60
        anchors.left: imgWiring1112.right
        anchors.leftMargin: -5
        source: "../../../images/0-color/bms/cmu_normal_u.png"
	/* ( cmuState[0][11] == 0 )
	    ?"../../../images/0-color/bms/cmu_norm_open_u.png"
	    :(( cmuState[0][11] == 1 )?"../../../images/0-color/bms/cmu_normal_u.png"
	    :(( cmuState[0][11] == 2 )?"../../../images/0-color/bms/cmu_open_ng_u.png"
	    :"../../../images/0-color/bms/cmu_close_ng_u.png")) */

        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imgCmu12d
        width: 90
        height: 60
        anchors.left: imgWiring1112.right
        anchors.leftMargin: -5
        anchors.top: imgCmu12u.bottom
        anchors.topMargin: -23
        source: "../../../images/0-color/bms/cmu_normal_d.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: imgWiring1112
        width: 27
        height: 20
        anchors.top: imgCmu11u.top
        anchors.topMargin: 36
        anchors.left: imgCmu11u.right
        anchors.leftMargin: -5
        source: "../../../images/0-color/bms/cmu_wiring.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: image
        x: 488
        y: 466
        width: 70
        height: 100
        source: "../../../images/0-color/vstroke.png"
        fillMode: Image.PreserveAspectFit
    }

    Text {
        id: txtCMU1
        x: 230
        y: 505
        width: 50
        height: 20
        color: "#34b972"
        text: "CMU1"
        elide: Text.ElideLeft
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 15
    }

    Text {
        id: txtCMU2
        x: 337
        y: 505
        width: 50
        height: 20
        color: "#34b972"
        text: "CMU2"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 15
    }

    Text {
        id: txtCMU3
        x: 444
        y: 505
        width: 50
        height: 20
        color: "#34b972"
        text: "CMU3"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 15
    }

    Text {
        id: txtCMU4
        x: 551
        y: 505
        width: 50
        height: 20
        color: "#34b972"
        text: "CMU4"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 15
    }

    Text {
        id: txtCMU5
        x: 658
        y: 505
        width: 50
        height: 20
        color: "#34b972"
        text: "CMU5"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 15
    }

    Text {
        id: txtCMU6
        x: 765
        y: 505
        width: 50
        height: 20
        color: "#34b972"
        text: "CMU6"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 15
    }

    Text {
        id: txtCMU7
        x: 230
        y: 600
        width: 50
        height: 20
        color: "#34b972"
        text: "CMU7"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 15
    }

    Text {
        id: txtCMU8
        x: 337
        y: 600
        width: 50
        height: 20
        color: "#34b972"
        text: "CMU8"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 15
    }

    Text {
        id: txtCMU9
        x: 444
        y: 600
        width: 50
        height: 20
        color: "#34b972"
        text: "CMU9"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 15
    }

    Text {
        id: txtCMU10
        x: 551
        y: 600
        width: 50
        height: 20
        color: "#34b972"
        text: "CMU10"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 15
    }

    Text {
        id: txtCMU11
        x: 658
        y: 600
        width: 50
        height: 20
        color: "#34b972"
        text: "CMU11"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 15
    }

    Text {
        id: txtCMU12
        x: 765
        y: 600
        width: 50
        height: 20
        color: "#34b972"
        text: "CMU12"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 15
    }

    onActiveChanged : {
        if ( true === bmsAnalog.active ) {
        bmsAnalog.qmlSignalActive("BmsAnalog");
    }
    }
}























































































































































































/*##^## Designer {
    D{i:45;anchors_y:"-3"}D{i:57;anchors_y:"-12"}D{i:66;anchors_y:"-18"}D{i:72;anchors_y:"-18"}
D{i:79;anchors_y:"-5"}D{i:97;anchors_y:"-20"}D{i:124;anchors_y:"-11"}D{i:136;anchors_y:482}
D{i:143;anchors_x:135}D{i:144;anchors_x:135;anchors_y:547}D{i:145;anchors_x:188}D{i:146;anchors_x:188;anchors_y:561}
D{i:147;anchors_x:167;anchors_y:526}D{i:148;anchors_x:290}D{i:149;anchors_x:290;anchors_y:515}
D{i:150;anchors_x:263;anchors_y:503}D{i:151;anchors_x:377}D{i:152;anchors_x:377;anchors_y:515}
D{i:153;anchors_x:350;anchors_y:503}D{i:154;anchors_x:463}D{i:155;anchors_x:463;anchors_y:515}
D{i:156;anchors_x:436;anchors_y:503}D{i:157;anchors_x:550}D{i:158;anchors_x:550;anchors_y:515}
D{i:159;anchors_x:523;anchors_y:503}D{i:160;anchors_x:87;anchors_y:574}D{i:161;anchors_x:87;anchors_y:628}
D{i:162;anchors_x:188;anchors_y:574}D{i:163;anchors_x:188;anchors_y:628}D{i:164;anchors_x:162;anchors_y:616}
D{i:165;anchors_x:290}D{i:166;anchors_x:290;anchors_y:628}D{i:167;anchors_x:263;anchors_y:616}
D{i:168;anchors_x:377}D{i:169;anchors_x:377;anchors_y:628}D{i:170;anchors_x:350;anchors_y:616}
D{i:171;anchors_x:463}D{i:172;anchors_x:463;anchors_y:628}D{i:173;anchors_x:436;anchors_y:616}
D{i:174;anchors_x:550}D{i:175;anchors_x:550;anchors_y:628}D{i:176;anchors_x:523;anchors_y:616}
}
 ##^##*/
