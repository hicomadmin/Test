#ifndef HS_HMIDATA_PLUGIN_CONFIG
#define HS_HMIDATA_PLUGIN_CONFIG

enum ID_GROUP_ENUM{
    ID_GROUP_PWR                    = 0x0000,
    ID_GROUP_RADIO                  = 0x0100,
    ID_GROUP_CD                     = 0x0200,
    ID_GROUP_KEY                    = 0x0300,
    ID_GROUP_SETTING                = 0x0400,
    ID_GROUP_AUX                    = 0x0500,
    ID_GROUP_AUDIO                  = 0x0600,
    ID_GROUP_REVERSE                = 0x0700,

    ID_GROUP_CANGE                  = 0x2000,
    ID_GROUP_CANDIAG                = 0x2100,
    ID_GROUP_CANNET                 = 0x2200,
    ID_GROUP_MB_MAX                 = 0x2F00,

    ID_GROUP_BLUETOOTH              = 0x3100,
    ID_GROUP_USB_MUSIC              = 0x3200,
    ID_GROUP_USB_VEDIO              = 0x3300,
    ID_GROUP_USB_IMAGE              = 0x3400,
    ID_GROUP_VOICE_ASS              = 0x3500,
    ID_GROUP_MCAN_SYNC              = 0x3600,
    ID_GROUP_SOURCE_MG              = 0x3700,
    ID_GROUP_IPOD                   = 0x3800,
    ID_GROUP_WIFI                   = 0x3900,
    ID_GROUP_PHONELINK              = 0x3A00,
    ID_GROUP_CARPLAY                = 0x3B00,
    ID_GROUP_CARLIFE                = 0x3C00,
    ID_GROUP_ECOLINK                = 0x3D00,
    ID_GROUP_MIRRLINK               = 0x3E00,
    ID_GROUP_MIRACAST               = 0x3F00,
    ID_GROUP_USB_FOLDER             = 0x4000,
    ID_GROUP_USB_TEXT               = 0x4100,
    ID_GROUP_DEVICE                 = 0x4200,
    ID_GROUP_INPUT                  = 0x4300,
    ID_GROUP_MAX
};

#if 1
// Used for service module
enum ID_SERVICE_GROUP_ENUM{
    ID_SRV_GROUP_MB_PWR             = 0x0000,
    ID_SRV_GROUP_MB_RADIO           = 0x0100,
    ID_SRV_GROUP_MB_CD              = 0x0200,
    ID_SRV_GROUP_MB_KEY             = 0x0300,
    ID_SRV_GROUP_MB_SETTING         = 0x0400,
    ID_SRV_GROUP_MB_AUX             = 0x0500,
    ID_SRV_GROUP_MB_AUDIO           = 0x0600,
    ID_SRV_GROUP_MB_REV             = 0x0700,

    ID_SRV_GROUP_MB_CANGE           = 0x2000,
    ID_SRV_GROUP_MB_CANDIAG         = 0x2100,
    ID_SRV_GROUP_MB_CANNET          = 0x2200,
    ID_SRV_GROUP_MB_MAX             = 0x2F00,

    ID_SRV_GROUP_BLUETOOTH          = 0x3100,
    ID_SRV_GROUP_USB_MUSIC          = 0x3200,
    ID_SRV_GROUP_USB_VEDIO          = 0x3300,
    ID_SRV_GROUP_USB_IMAGE          = 0x3400,
    ID_SRV_GROUP_VOICE_ASS          = 0x3500,
    ID_SRV_GROUP_MCAN_SYNC          = 0x3600,
    ID_SRV_GROUP_SOURCE_MG          = 0x3700,
    ID_SRV_GROUP_IPOD               = 0x3800,
    ID_SRV_GROUP_WIFI               = 0x3900,
    ID_SRV_GROUP_PHONELINK          = 0x3A00,
    ID_SRV_GROUP_CARPLAY            = 0x3B00,
    ID_SRV_GROUP_CARLIFE            = 0x3C00,
    ID_SRV_GROUP_ECOLINK            = 0x3D00,
    ID_SRV_GROUP_MIRRLINK           = 0x3E00,
    ID_SRV_GROUP_MIRACAST           = 0x3F00,
    ID_SRV_GROUP_USB_FOLDER         = 0x4000,
    ID_SRV_GROUP_USB_TEXT           = 0x4100,
    ID_SRV_GROUP_DEVICE              = 0x4200,
    ID_SRV_GROUP_INPUT              = 0x4300,
    ID_SRV_GROUP_SOURCE_MAX
};

// Used for plugin module
enum ID_PLUGIN_GROUP_ENUM{
    ID_PLUGIN_GROUP_MB_PWR             = 0x0000,
    ID_PLUGIN_GROUP_MB_RADIO           = 0x0100,
    ID_PLUGIN_GROUP_MB_CD              = 0x0200,
    ID_PLUGIN_GROUP_MB_KEY             = 0x0300,
    ID_PLUGIN_GROUP_MB_SETTING         = 0x0400,
    ID_PLUGIN_GROUP_MB_AUX             = 0x0500,
    ID_PLUGIN_GROUP_MB_AUDIO           = 0x0600,
    ID_PLUGIN_GROUP_MB_REV             = 0x0700,

    ID_PLUGIN_GROUP_MB_CANGE           = 0x2000,
    ID_PLUGIN_GROUP_MB_CANDIAG         = 0x2100,
    ID_PLUGIN_GROUP_MB_CANNET          = 0x2200,
    ID_PLUGIN_GROUP_MB_MAX             = 0x2F00,

    ID_PLUGIN_GROUP_BLUETOOTH       = 0x3100,
    ID_PLUGIN_GROUP_USB_MUSIC       = 0x3200,
    ID_PLUGIN_GROUP_USB_VEDIO       = 0x3300,
    ID_PLUGIN_GROUP_USB_IMAGE       = 0x3400,
    ID_PLUGIN_GROUP_VOICE_ASS       = 0x3500,
    ID_PLUGIN_GROUP_MCAN_SYNC       = 0x3600,
    ID_PLUGIN_GROUP_SOURCE_MG       = 0x3700,
    ID_PLUGIN_GROUP_IPOD            = 0x3800,
    ID_PLUGIN_GROUP_WIFI            = 0x3900,
    ID_PLUGIN_GROUP_PHONELINK       = 0x3A00,
    ID_PLUGIN_GROUP_CARPLAY         = 0x3B00,
    ID_PLUGIN_GROUP_CARLIFE         = 0x3C00,
    ID_PLUGIN_GROUP_ECOLINK         = 0x3D00,
    ID_PLUGIN_GROUP_MIRRLINK        = 0x3E00,
    ID_PLUGIN_GROUP_MIRACAST        = 0x3F00,
    ID_PLUGIN_GROUP_USB_FOLDER      = 0x4000,
    ID_PLUGIN_GROUP_USB_TEXT        = 0x4100,
    ID_PLUGIN_GROUP_DEVICE           = 0x4200,
    ID_PLUGIN_GROUP_INPUT           = 0x4300,
    ID_PLUGIN_GROUP_SOURCE_MAX
};
#endif

#define HS_PLUGIN_ID       "PI"
#define HS_SERVICE_ID      "SI"
#define HS_REQUEST_NAME    "RN"
#define HS_REQUEST_PARAM   "RP"
#define HS_ATTR_NAME       "AN"
#define HS_ATTR_PARAM      "AP"
#define HS_FRAME_ID        "FI"

#define HS_CTL_SERVER      "HS_CTL_SERVER"
#define HS_DATA_SERVER     "HS_DATA_SERVER"

#define ID_GROUP_NUM_MAX            ID_GROUP_MAX  /**/
#define ID_CMD_TRAN_NUM             6   /* Main-Board used to sava variables */
#define CORE_TRAN_TIMOUT_TIM        10  /* Main-Board used to calc timeout, mean 10*(10) ms */
#define CORE_TRAN_TIMOUT_NUM        3   /* Main-Board used to calc timeout times, 3 times */

enum ID_PWR_ENUM{
    ID_PWR_SYS_START                = 0x0001,
    ID_PWR_SYS_STOP                 = 0x0002,
    ID_PWR_STATUS_REPORT            = 0x0081,
    ID_PWR_SYS_ALIVE                = 0x0082,
    ID_PWR_DEV_ECP_REPORT           = 0x0083,
};
#define ID_PWR_RX_NUM               3

enum ID_RADIO_ENUM{
    ID_RADIO_ALL_INFO_GET           = 0x0101,
    ID_RADIO_SET_FREQ               = 0x0102,
    ID_RADIO_SEEK_SET               = 0x0103,
    ID_RADIO_STEP_SET               = 0x0104,
    ID_RADIO_SCAN_SET               = 0x0105,
    ID_RADIO_PRESET_SAVE            = 0x0106,
    ID_RADIO_PRESET_LIST_GET        = 0x0107,
    ID_RADIO_FREQ_GET               = 0x0108,
    ID_RADIO_ENGINE_PARAM_GET       = 0x0109,
    ID_RADIO_ENGINE_PARAM_SET       = 0x010A,
    ID_RADIO_PRESET_SET             = 0x010B,
    ID_RADIO_LOVE_SAVE              = 0x010C,
    ID_RADIO_LOVE_LIST_GET          = 0x010D,
    ID_RADIO_SWITCH                 = 0X010E,
    ID_RADIO_CURR_FREQ_REPORT       = 0x0181,
    ID_RADIO_PRESET_LIST_REPORT     = 0x0182,
};
#define ID_RADIO_RX_NUM             15

enum ID_CD_ENUM{
    ID_CD_RESERVED                  = 0x0201,
    ID_CD_RESERVED1                 = 0x0202,

};

enum ID_KEY_ENUM{
    ID_KEY_STATUS_REPORT            = 0x0381,
};

enum ID_SETTING_ENUM{
    ID_SETTING_ALL_INFO_GET         = 0x0401,
    ID_SETTING_CLOCK_SET            = 0x0402,
    ID_SETTING_CLOCK_GET            = 0x0403,
    ID_SETTING_BL_PARAM_SET         = 0x0404,
    ID_SETTING_BL_PARAM_GET         = 0x0405,
    ID_SETTING_BLMODE_SET           = 0x0406,
    ID_SETTING_BLMODE_GET           = 0x0407,
    ID_SETTING_INFO_SET             = 0x0408,
    ID_SETTING_INFO_GET             = 0x0409,
    ID_SETTING_SYS_RESET            = 0x040A,
    ID_SETTING_UPDATE_MB            = 0x040B,
    ID_SETTING_VERSION_GET          = 0x040C,
    ID_SETTING_BLMODE_REPORT        = 0x0481,
    ID_SETTING_ILLMODE_REPORT       = 0x0482,
    ID_SETTING_BL_PARAM_REPORT      = 0x0483,
    ID_SETTING_CLOCK_REPORT         = 0x0484,
};

enum ID_AUX_ENUM{
    ID_AUX_ALL_INFO_GET             = 0x0501,
    ID_AUX_STATUS_GET               = 0x0502,
    ID_AUX_GAIN_SET                 = 0x0503,
    ID_AUX_GAIN_GET                 = 0x0504,
    ID_AUX_STATUS_REPORT            = 0x0581,
};

enum ID_AUDIO_ENUM{
    ID_AUDIO_ALL_INFO_GET           = 0x0601,
    ID_AUDIO_SOURCE_SET             = 0x0602,
    ID_AUDIO_SOURCE_GET             = 0x0603,
    ID_AUDIO_SWITCH_SET             = 0x0604,
    ID_AUDIO_SWITCH_GET             = 0x0605,
    ID_AUDIO_VOLUMN_SET             = 0x0606,
    ID_AUDIO_VOLUMN_GET             = 0x0607,
    ID_AUDIO_PARAM_SET              = 0x0608,
    ID_AUDIO_PARAM_GET              = 0x0609,
    ID_AUDIO_BEEP_SET               = 0x060A,
    ID_AUDIO_VOLUMN_REPORT          = 0x0681,
};

enum ID_REV_ENUM{
    ID_REV_STATUS_GET               = 0x0701,
    ID_REV_RADAR_GET                = 0x0702,
    ID_REV_AVM_SET                  = 0x0703,
    ID_REV_AVM_GET                  = 0x0704,
    ID_REV_STATUS_REPORT            = 0x0781,
    ID_REV_AVM_STATUS_REPORT        = 0x0782,
    ID_REV_RADAR_INFO_REPORT        = 0x0783,
};

enum ID_CAN_GE_ENUM{
    ID_CAN_GE_HAVC_SET				= 0x2001,
    ID_CAN_GE_HVAC_GET              = 0x2002,
    ID_CAN_GE_TPMS_GET              = 0x2003,
    ID_CAN_GE_DOOR_SET              = 0x2004,
    ID_CAN_GE_DOOR_GET              = 0x2005,
    ID_CAN_GE_METER_SET             = 0x2006,
    ID_CAN_GE_METER_GET             = 0x2007,
    ID_CAN_GE_CARSTA_GET            = 0x2008,
    ID_CAN_GE_CARCTRL_SET			= 0x2009,
    ID_CAN_GE_CARCTRL_GET			= 0x200A,

    ID_CAN_GE_HVAC_REPORT           = 0x2081,
    ID_CAN_GE_TPMS_REPORT           = 0x2082,
    ID_CAN_GE_DOOR_REPORT           = 0x2083,
    ID_CAN_GE_METER_REPORT          = 0x2084,
    ID_CAN_GE_CARSTA_REPORT         = 0x2085,
};

enum ID_CAN_DIAG_ENUM{
    ID_CAN_DIAG_INFO_SET            = 0x2101,
    ID_CAN_DIAG_INFO_GET            = 0x2102,
    ID_CAN_DIAG_INFO_REPORT         = 0x2181,
};

enum ID_CAN_NET_ENUM{
    ID_CAN_NET_INFO_GET             = 0x0B01,
    ID_CAN_NET_INFO_REPORT          = 0x0B81,
};

#define ID_CMD_NORM_MASK            0x7FFF
#define ID_CMD_RESP_MASK            0x8000
#define ID_CMDL_NORM_MASK           0x7F
#define ID_CMDH_NORM_MASK           0x7F

enum ACK_STA_ENUM{
    ACK_RECV_SUCCESS                = 0x00,
    ACK_RECV_CHKSUM_ERR             = 0x01,
    ACK_RECV_ID_INVALID             = 0x02,
    ACK_RECV_DATA_INVALID           = 0x03,
    ACK_RECV_COMM_BUSY              = 0x04,
};

#endif // HS_HMIDATA_PLUGIN_CONFIG

