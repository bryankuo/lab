#include <iostream>
#include <iomanip>
#include <errno.h>

#include "memory.h"

#include <QFile>
#include <QDateTime>
#include <QByteArray>
#include <QCanBusFrame>

#include "sja1000_api.h"

SJA1000_Api::SJA1000_Api():
#if defined ( EN_SJA1000_FRAME_LOG_ )
    m_filename("/dev/shm/sja1000-cap.txt"),
    // tmpfs log to RAM
    // ( https://www.howtoforge.com/storing-files-directories-in-memory-with-tmpfs )
#endif
    m_fh(0)
{
#if defined ( EN_SJA1000_FRAME_LOG_ )
    // ( http://tinyw.in/KKoP )
    m_file.setFileName(m_filename);
    if ( false == m_file.open(QIODevice::ReadWrite | QIODevice::Append) ) {
        cout << __FILE__ << ":" << __LINE__ << " file open!";
    }
    m_stream.setDevice(&m_file);
#endif

}

SJA1000_Api::SJA1000_Api(QObject* pParent):
#if defined ( EN_SJA1000_FRAME_LOG_ )
    m_filename("/dev/shm/sja1000-cap.txt"),
    // tmpfs log to RAM
    // ( https://www.howtoforge.com/storing-files-directories-in-memory-with-tmpfs )
#endif
    m_fh(0)
{
#if defined ( EN_SJA1000_FRAME_LOG_ )
    // ( http://tinyw.in/KKoP )
    m_file.setFileName(m_filename);
    if ( false == m_file.open(QIODevice::ReadWrite | QIODevice::Append) ) {
        cout << __FILE__ << ":" << __LINE__ << " file open!";
    }
    m_stream.setDevice(&m_file);
#endif

}

SJA1000_Api::~SJA1000_Api()
{
#if defined( EN_SJA1000_FRAME_LOG_ )
    // m_stream << endl;
    m_file.close();
#endif
    cout << __func__ << ":" << __LINE__ << "~" << endl;
}

//***********************************************************************
void SJA1000_Api::start(int fh)
{
    int res;
    //qDebug() << "fh value in main is " << fh;
    res = CAN_Run(fh);
    if (res==0)
        qDebug() << "CAN Run is fail.";
}
//***********************************************************************
void SJA1000_Api::stop()
{
    int res;
    res = CAN_Stop();
    if (res==0)
        qDebug() << "CAN Stop is fail.";
}
//***********************************************************************
void SJA1000_Api::set_bitrate(int fh, int BaudRate)
{
    //qDebug() << "fh is " << fh;
    qDebug() << "BaudRate is " << BaudRate;
    CAN_Reset(fh);
    CAN_Initial(fh,BaudRate);
}
//***********************************************************************
int SJA1000_Api::open_driver()
{
    int fh=0;
    errno = 0;
    fh = open("/dev/NEXCOM_CAN1", O_RDWR);
    //qDebug() << "fh=" << fh;

    if(fh >=0 ) {
        qDebug() << "CAN driver operation is normal.";
        //stream << "CAN driver operation is normal." << endl;
        return fh;
    }
    else {
        qDebug() << "CAN driver cannot open.";
        //stream << "CAN ! " << strerror (errno) << endl;
        return -1;
    }
    //return fh;
}
//***********************************************************************
void SJA1000_Api::clean_buffer(int fh)
{
    Clear_Buffer(fh);
}
//***********************************************************************
int SJA1000_Api::can_initial(int fh, int BaudRate)
{
    int res;
    res = CAN_Initial(fh, BaudRate);
    if (res==1) {
        //qDebug() << "Initial Success.";
        return 0;
    }
    else {
        qDebug() << "Initial Fail.";
        return -1;
    }
    //return res;
}
//***********************************************************************
void SJA1000_Api::can_filtermode(int fh, int mode)
{
    /*
    if( mode == 0 )
    { // Dual mode

        printf("\n");
        printf("===Dual filter configuration===\n");

        can_rx_dual_filter_t dual_filter;

        printf("Filter 1 ACR ID (11bit) : 0x");
        scanf("%x", &dual_filter.acr_filter1_id );
        printf("Filter 1 ACR RTR (0 or 1) : ");
        scanf("%d", &dual_filter.acr_filter1_rtr );

        printf("Filter 1 AMR ID (11bit) : 0x");
        scanf("%x", &dual_filter.amr_filter1_id );
        printf("Filter 1 AMR RTR (0 or 1) : ");
        scanf("%d", &dual_filter.amr_filter1_rtr );

        printf("Filter 2 ACR ID (11bit) : 0x");
        scanf("%x", &dual_filter.acr_filter2_id );
        printf("Filter 2 ACR RTR (0 or 1) : ");
        scanf("%d", &dual_filter.acr_filter2_rtr );

        printf("Filter 2 AMR ID (11bit) : 0x");
        scanf("%x", &dual_filter.amr_filter2_id );
        printf("Filter 2 AMR RTR (0 or 1) : ");
        scanf("%d", &dual_filter.amr_filter2_rtr );

        printf("Filter data 1 ACR (8bit) : 0x");
        scanf("%x", &dual_filter.acr_data1 );
        printf("Filter data 1 AMR (8bit) : 0x");
        scanf("%x", &dual_filter.amr_data1 );

        CAN_Dual_Filter(fh,&dual_filter);
    }
    else if( mode == 1 )
    { // Single mode
        int nID_Mode = 0;
        printf("ID? (0:Standard 1:Extended) : ");
        scanf("%d", &nID_Mode );

        if( nID_Mode == 0 )
        { // Standard

            printf("\n");
            printf("===Single Standard filter configuration===\n");

            can_rx_single_standard_filter_t single_standard_filter;

            printf("ACR ID (11bit) : 0x");
            scanf("%x", &single_standard_filter.acr_id );
            printf("ACR RTR (0 or 1) : ");
            scanf("%d", &single_standard_filter.acr_rtr );

            printf("AMR ID (11bit) : 0x");
            scanf("%x", &single_standard_filter.amr_id );
            printf("AMR RTR (0 or 1) : ");
            scanf("%d", &single_standard_filter.amr_rtr );

            printf("Data 1 ACR (8bit) : 0x");
            scanf("%x", &single_standard_filter.acr_data1);
            printf("Data 1 AMR (8bit) : 0x");
            scanf("%x", &single_standard_filter.amr_data1);

            printf("Data 2 ACR (8bit) : 0x");
            scanf("%x", &single_standard_filter.acr_data2);
            printf("Data 2 AMR (8bit) : 0x");
            scanf("%x", &single_standard_filter.amr_data2);

            CAN_Single_Standard_Filter(fh,&single_standard_filter);
        }
        else
        { // Extended

            printf("\n");
            printf("===Single Extended filter configuration===\n");

            can_rx_single_extended_filter_t single_extended_filter;

            printf("ACR ID (29bit) : 0x");
            scanf("%x", &single_extended_filter.acr_id );
            printf("The filter.acr_id is %x\n",single_extended_filter.acr_id);
            printf("ACR RTR (0 or 1) : ");
            scanf("%d", &single_extended_filter.acr_rtr );

            printf("AMR ID (29bit) : 0x");
            scanf("%x", &single_extended_filter.amr_id );
            printf("AMR RTR (0 or 1) : ");
            scanf("%d", &single_extended_filter.amr_rtr );

            CAN_Single_Extended_Filter(fh,&single_extended_filter);
        }
    }
    else {
    */
    if (mode==2) {

        can_rx_dual_filter_t dual_filter;

        dual_filter.amr_filter1_id =0xffff;
        dual_filter.amr_filter1_rtr=0xffff;

        dual_filter.amr_filter2_id=0xffff;
        dual_filter.amr_filter2_rtr=0xffff;

        dual_filter.amr_data1=0xffff;

        CAN_Dual_Filter(fh,&dual_filter);

    }
}

void SJA1000_Api::set_filter(int fh, int filter_mode, int id_mode) {
#if 1
    cout<< __func__ << __LINE__ << ": "
	<<"("<< fh << "," << filter_mode << "," << id_mode << ")" << endl;
#endif
    if( filter_mode == 0 ) { // Dual mode
/*
        printf("\n");
        printf("===Dual filter configuration===\n");

        can_rx_dual_filter_t dual_filter;

        printf("Filter 1 ACR ID (11bit) : 0x");
        scanf("%x", &dual_filter.acr_filter1_id );
        printf("Filter 1 ACR RTR (0 or 1) : ");
        scanf("%d", &dual_filter.acr_filter1_rtr );

        printf("Filter 1 AMR ID (11bit) : 0x");
        scanf("%x", &dual_filter.amr_filter1_id );
        printf("Filter 1 AMR RTR (0 or 1) : ");
        scanf("%d", &dual_filter.amr_filter1_rtr );

        printf("Filter 2 ACR ID (11bit) : 0x");
        scanf("%x", &dual_filter.acr_filter2_id );
        printf("Filter 2 ACR RTR (0 or 1) : ");
        scanf("%d", &dual_filter.acr_filter2_rtr );

        printf("Filter 2 AMR ID (11bit) : 0x");
        scanf("%x", &dual_filter.amr_filter2_id );
        printf("Filter 2 AMR RTR (0 or 1) : ");
        scanf("%d", &dual_filter.amr_filter2_rtr );

        printf("Filter data 1 ACR (8bit) : 0x");
        scanf("%x", &dual_filter.acr_data1 );
        printf("Filter data 1 AMR (8bit) : 0x");
        scanf("%x", &dual_filter.amr_data1 );

        CAN_Dual_Filter(fh,&dual_filter);*/
    }
    else if( filter_mode == 1 ) { // Single mode
        int nID_Mode = id_mode;
	// SAEJ1939 use extended ID mode
        //printf("ID? (0:Standard 1:Extended) : ");
        //scanf("%d", &nID_Mode );
	nID_Mode = 1;
        if( nID_Mode == 0 )
        { // Standard
/*
            printf("\n");
            printf("===Single Standard filter configuration===\n");

            can_rx_single_standard_filter_t single_standard_filter;

            printf("ACR ID (11bit) : 0x");
            scanf("%x", &single_standard_filter.acr_id );
            printf("ACR RTR (0 or 1) : ");
            scanf("%d", &single_standard_filter.acr_rtr );

            printf("AMR ID (11bit) : 0x");
            scanf("%x", &single_standard_filter.amr_id );
            printf("AMR RTR (0 or 1) : ");
            scanf("%d", &single_standard_filter.amr_rtr );

            printf("Data 1 ACR (8bit) : 0x");
            scanf("%x", &single_standard_filter.acr_data1);
            printf("Data 1 AMR (8bit) : 0x");
            scanf("%x", &single_standard_filter.amr_data1);

            printf("Data 2 ACR (8bit) : 0x");
            scanf("%x", &single_standard_filter.acr_data2);
            printf("Data 2 AMR (8bit) : 0x");
            scanf("%x", &single_standard_filter.amr_data2);

            CAN_Single_Standard_Filter(fh,&single_standard_filter);*/
        }
        else { // Extended
            //printf("\n");
            //printf("===Single Extended filter configuration===\n");

            can_rx_single_extended_filter_t single_extended_filter;

            //printf("ACR ID (29bit) : 0x");
            //scanf("%x", &single_extended_filter.acr_id );
	    //single_extended_filter.acr_id = 0x08E80020;
	    //single_extended_filter.acr_id = 0x0CFF0022; // OK
	    //single_extended_filter.acr_id = 0x0CFF0022; // msg1
	    //single_extended_filter.acr_id = 0x18FF0122; // msg1 & msg2
	    //single_extended_filter.acr_id = 0x08FF0022; // msg 1,2,3,4
	    //single_extended_filter.acr_id = 0x08FF0020; // msg 1,2,3,4,b 1,2
	    single_extended_filter.acr_id = ACR_ID;
            //printf("The filter.acr_id is %x\n",);
	    qDebug() << "=> acr_id"
		<< QString("%1").arg(single_extended_filter.acr_id, 0, 16);
            //printf("ACR RTR (0 or 1) : ");
            //scanf("%d", &single_extended_filter.acr_rtr );
	    // RTR(Remote Transmission Request) ( https://goo.gl/atmB4e )
	    single_extended_filter.acr_rtr = 0; // AN97076, page 22
            //printf("AMR ID (29bit) : 0x");
            //scanf("%x", &single_extended_filter.amr_id );
	    //single_extended_filter.amr_id = 0x1417FFD6;
	    //single_extended_filter.amr_id = 0x00000000; // OK
	    //single_extended_filter.amr_id = 0x14000100; // msg1 & msg2
	    //single_extended_filter.amr_id = 0x14000300; // msg 1,2,3,4
	    //single_extended_filter.amr_id = 0x140093D6; // msg 1234b
	    //single_extended_filter.amr_id = 0x140097D6; // msg 1234b
	    single_extended_filter.amr_id = AMR_ID;
            //printf("AMR RTR (0 or 1) : ");
            //scanf("%d", &single_extended_filter.amr_rtr );
	    single_extended_filter.amr_rtr = 0; // AN97076, page 22
	    qDebug() << "=> amr_id"
		<< QString("%1").arg(single_extended_filter.amr_id, 0, 16);
            CAN_Single_Extended_Filter(fh,&single_extended_filter);
        }
    }
    else if ( filter_mode == 2 ) {

        can_rx_dual_filter_t dual_filter;

        dual_filter.amr_filter1_id =0xffff;
        dual_filter.amr_filter1_rtr=0xffff;

        dual_filter.amr_filter2_id=0xffff;
        dual_filter.amr_filter2_rtr=0xffff;

        dual_filter.amr_data1=0xffff;

        CAN_Dual_Filter(fh,&dual_filter);
    }
}

//***********************************************************************
//QString SJA1000_Api::receive_message()
void SJA1000_Api::receive_message()
{
    int res;
    //QString ret_code = "";
    //can_msg_t Message;

    while(1) {
        //qDebug() << "Enter to while loop of Receive message.";
        res = CAN_Receive_nonblock(&Message);
        //qDebug() << "CAN_Receive_nonblock res=" << res;

        if (res == -1) {
#if defined ( EN_API_VERBOSE1_ )
            qDebug() << "The receive buffer is empty.";
#endif
            //return ret_code;
        }
        else {
#if defined ( EN_API_VERBOSE1_ )
            qDebug() << "Receive => IDe" << QString("%1").arg(Message.ide, 0, 16);
            qDebug() << "Receive => ID" << QString("%1").arg(Message.id, 0, 16);
            qDebug() << "Receive => Len" << QString("%1").arg(Message.dlc, 0, 16);
            qDebug() << "Receive => Data1" << QString("%1").arg(Message.data[0], 0, 16);
            qDebug() << "Receive => Data2" << QString("%1").arg(Message.data[1], 0, 16);
            qDebug() << "Receive => Data3" << QString("%1").arg(Message.data[2], 0, 16);
            qDebug() << "Receive => Data4" << QString("%1").arg(Message.data[3], 0, 16);
            qDebug() << "Receive => Data5" << QString("%1").arg(Message.data[4], 0, 16);
            qDebug() << "Receive => Data6" << QString("%1").arg(Message.data[5], 0, 16);
            qDebug() << "Receive => Data7" << QString("%1").arg(Message.data[6], 0, 16);
            qDebug() << "Receive => Data8" << QString("%1").arg(Message.data[7], 0, 16);
            qDebug() << "Receive => RTR" << QString("%1").arg(Message.rtr, 0, 16);
            qDebug() << "There are " << res << " CAN message in the buffer";
#endif
        }

        break;
    }

}

//#define EN_API_VERBOSE_
//***********************************************************************
int SJA1000_Api::receive_frame_nonblock(QCanBusFrame &frame)
{
    int res;
    can_msg_t Message;

    //qDebug() << "Enter to while loop of Receive message.";
    res = CAN_Receive_nonblock(&Message);
    //qDebug() << "CAN_Receive_nonblock res=" << res;
    if (res == -1) {
#if defined ( EN_API_VERBOSE_ )
        qDebug() << "The receive buffer is empty.";
#endif
    }
    else {
#if defined ( EN_API_VERBOSE_ )
        qDebug() << "Receive => IDe" << QString("%1").arg(Message.ide, 0, 16);
        qDebug() << "Receive => ID" << QString("%1").arg(Message.id, 0, 16);
        qDebug() << "Receive => Len" << QString("%1").arg(Message.dlc, 0, 16);
        qDebug() << "Receive => Data1" << QString("%1").arg(Message.data[0], 0, 16);
        qDebug() << "Receive => Data2" << QString("%1").arg(Message.data[1], 0, 16);
        qDebug() << "Receive => Data3" << QString("%1").arg(Message.data[2], 0, 16);
        qDebug() << "Receive => Data4" << QString("%1").arg(Message.data[3], 0, 16);
        qDebug() << "Receive => Data5" << QString("%1").arg(Message.data[4], 0, 16);
        qDebug() << "Receive => Data6" << QString("%1").arg(Message.data[5], 0, 16);
        qDebug() << "Receive => Data7" << QString("%1").arg(Message.data[6], 0, 16);
        qDebug() << "Receive => Data8" << QString("%1").arg(Message.data[7], 0, 16);
        qDebug() << "Receive => RTR" << QString("%1").arg(Message.rtr, 0, 16);
#endif
	// working idea from: ( https://goo.gl/KdVbdm )
	frame = QCanBusFrame(static_cast<quint32>(Message.id),
		    QByteArray(reinterpret_cast<const char*>(Message.data),
		    sizeof(Message.data)));
        //frame.setPayload(msg_data); // sometimes not working!
#if defined ( EN_SJA1000_FRAME_LOG_ )
	m_stream << QDateTime::currentMSecsSinceEpoch() << " frame id "
	    << QString("0x%1")
	    .arg(frame.frameId(), 8, 16, QLatin1Char( '0' )) << " "
	    << "type " << frame.frameType() << " "
	    << "data " << frame.payload().toHex(' ') << '\n';
	m_stream.flush(); // unmark to assert single write sequence
#endif
	//<< "can_msg_t size " << sizeof(can_msg_t);
    }
    return res;
}
//***********************************************************************
int SJA1000_Api::can_run()
{
    int fh=0, res=0;
    Tools tools;

    m_fh = fh = open_driver();
    //qDebug() << "open_driver fh=" << fh;
    //stream << "drv fh " << fh << endl;

    clean_buffer(fh);
    //qDebug() << "clean_buffer";

    res = can_initial(fh, 62500);
    //qDebug() << "can_initial res=" << res;
    if (res < 0)
        return res;
    set_filter(fh, 1, 1); // run() is not called in this function
    //set_filter(fh, 2, 0);
    //qDebug() << "can_filtermode";
    tools.delay_sec(1);

    set_bitrate(fh, 250000);
    //qDebug() << "set_bitrate";
    tools.delay_sec(1);

    start(fh);
    //qDebug() << "can start";
    tools.delay_sec(1);
    return res;
}
//***********************************************************************
int SJA1000_Api::can_run(int* pfh)
{
    int fh=0, res=0;
    Tools tools;

    fh = open_driver();
    //stream << "drv fh " << fh << endl;
    *pfh = fh;
    qDebug() << "SJA1000_Api::can_run " << fh;

    clean_buffer(fh);
    //qDebug() << "clean_buffer";

    res = can_initial(fh, 62500);
    //qDebug() << "can_initial res=" << res;
    if (res < 0)
        return res;

#if 0
    can_filtermode(fh, 2);
#else
    //set_filter(fh, 1, 1);
    set_filter(fh, 2, 0);
#endif
    //qDebug() << "can_filtermode";
    tools.delay_sec(1);

    set_bitrate(fh, 250000);
    //qDebug() << "set_bitrate";
    tools.delay_sec(1);

    start(fh);
    //qDebug() << "can start";
    tools.delay_sec(1);
    return res;
}
//***********************************************************************
QString SJA1000_Api::get_can_value(QString str)
{
    QString ret_code;

    if (str == "ide")
        ret_code = QString("%1").arg(Message.ide, 0, 16);
    else if (str == "id")
        ret_code =  QString("%1").arg(Message.id, 0, 16);
    else if (str == "len")
        ret_code = QString("%1").arg(Message.dlc, 0, 16);
    else if (str == "data1")
        ret_code = QString("%1").arg(Message.data[0], 0, 16);
    else if (str == "data2")
        ret_code = QString("%1").arg(Message.data[1], 0, 16);
    else if (str == "data3")
        ret_code = QString("%1").arg(Message.data[2], 0, 16);
    else if (str == "data4")
        ret_code = QString("%1").arg(Message.data[3], 0, 16);
    else if (str == "data5")
        ret_code = QString("%1").arg(Message.data[4], 0, 16);
    else if (str == "data6")
        ret_code = QString("%1").arg(Message.data[5], 0, 16);
    else if (str == "data7")
        ret_code = QString("%1").arg(Message.data[6], 0, 16);
    else if (str == "data8")
        ret_code = QString("%1").arg(Message.data[7], 0, 16);
    else if (str == "rtr")
        ret_code = QString("%1").arg(Message.rtr, 0, 16);

    return ret_code;
}
/*
QString SJA1000_Api::can_data2_value()
{
//    can_msg_t Message1;

    QString ret_code = QString("%1").arg(Message.data[1], 0, 16);

    return ret_code;
}
*/

// return 0 succes, otherwise failed.
int SJA1000_Api::get_error_status(int fh, can_error_t& status) {
    int rc = 0;
    can_error_t st;
    if( fh <= 0 ) {
	cout << __FILE__ << ":" << __LINE__
	    << " invalid fh! make sure device is ready." << endl;
        rc = -1;
    }
    else {
	memset(&st, 0, sizeof(can_error_t));
	rc = CAN_Error_Stats_Get(fh, &st);
#if 0
	cout << __FILE__ << ":" << ":" << __LINE__ << " "
	    << st.Direction << " "
	    << "s:" << setfill('0') << setw(1) << st.error_stat << " "
	    << "R:" << setfill('0') << setw(3) << st.rx_err_cnt << " "
	    << "T:" << setfill('0') << setw(3) << st.tx_err_cnt
	    << endl;
#endif
	status = st;
    }

    return rc;
}

// return 0 succes, otherwise failed.
int SJA1000_Api::transmit(/*int fh,*/QCanBusFrame frame) {
    int nID = 0x0; int rc = 0;
    int nResult = 0;
    can_msg_t Message;
    QByteArray payload;
    can_error_t can_error;

    payload = frame.payload();
    if ( payload.isEmpty() /*|| payload.size() != 8*/ ) {
	cout << __func__ << ":" << __LINE__ << " "
	    << payload.isEmpty() << " " << payload.size() << "!" << endl;
	rc = -1;
	goto ERROR_HANDLER;
    }
#define SEND_NONCE_
#if defined ( SEND_NONCE_ )
    if ( payload.size() != 8 &&
	( frame.frameId() != 0x1CEA2211
	  && frame.frameId() != 0x18EA3311
	  && frame.frameId() != 0x0CEA2211 ) ) {
	cout << __func__ << ":" << __LINE__ << " "
	    << payload.isEmpty() << " " << payload.size() << "!" << endl;
	rc = -1;
	goto ERROR_HANDLER;
    }
#endif
    try {
	Message.ide     = (frame.hasExtendedFrameFormat()==true)?1:0;
	Message.id      = frame.frameId();
	Message.dlc     = static_cast<unsigned short>(payload.size());
	Message.data[0] = (payload[0]&0xFF);
	Message.data[1] = (payload[1]&0xFF);
	Message.data[2] = (payload[2]&0xFF);
	Message.data[3] = (payload[3]&0xFF);
	Message.data[4] = (payload[4]&0xFF);
	Message.data[5] = (payload[5]&0xFF);
	Message.data[6] = (payload[6]&0xFF);
	Message.data[7] = (payload[7]&0xFF);
	Message.rtr     = (frame.frameType() == QCanBusFrame::RemoteRequestFrame)?1:0;
	nResult = CAN_Transmission(&Message);
	if( nResult >= 0  ) {
	    //printf("Send => IDe(%d), ID(%d), Len(%d), Data1~8(0x%x)(0x%x)(0x%x)(0x%x)(0x%x)(0x%x)(0x%x)(0x%x), RTR(%d)\n", Message.ide, Message.id, Message.dlc, Message.data[0], Message.data[1], Message.data[2], Message.data[3], Message.data[4], Message.data[5], Message.data[6], Message.data[7], Message.rtr);
	    // nID++;
	}
	else {
	    //printf("Send CAN Message failed!!!\n");
	    if (nResult < 0){}
	    //printf("The error code - is %d\n",nResult);
	    //else
	    if ( m_fh ) {
		CAN_Error_Stats_Get(m_fh, &can_error);
		fprintf(stdout, "%s:%d Tx error is %d %d %02X %02X\n",
		    __func__, __LINE__, can_error.Direction, can_error.error_stat,
		    can_error.rx_err_cnt, can_error.tx_err_cnt);
	    }
	}
	//printf("There are %d data in the buffer.\n",point_write);
    } catch (const std::exception& ex) {
	cout << "exception" << ex.what() << endl;
    }
ERROR_HANDLER:
    return rc;
}
