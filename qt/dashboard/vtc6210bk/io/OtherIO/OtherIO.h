#ifdef __cplusplus
extern "C"
{
#endif

void EXTERNAL_12_Power(int);
int Voltage_Get();
void Voltage_Select_Setting(int);
void Module_Wireless_WAN_Switch(int);
void Module_Wireless_LAN_Switch(int);
void Module_Wireless_LAN_DIS2_L_Switch(int);
void Module_Wireless_LAN_DIS3_L_Switch(int);
void Module_USB2Con_Power_Switch(int);
void Module_USB3Con_Power_Switch(int);
void Module_GPS_Power_Switch(int);
void SIM_CARD_Switch(int);
void Wake_On_Wireless_WAN_Switch(int);
void Wake_On_RTC_Switch(int);
void MCU_GPIO_SetGPO_Status_1(int);
void MCU_GPIO_SetGPO_Status_2(int);
int MCU_GPIO_ReadGPO_Status_1();
int MCU_GPIO_ReadGPO_Status_2();
int MCU_GPIO_ReadGPI_Status_1();
int MCU_GPIO_ReadGPI_Status_2();
int MCU_GPIO_ReadPANIC_Status();
void MCU_GPIO_PANIC_Status_Clear();
void MCU_GPIO_SetLED_Status(int);
void SerialPort_Select(int);
#ifdef __cplusplus
}
#endif
