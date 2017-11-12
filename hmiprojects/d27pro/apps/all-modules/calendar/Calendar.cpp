#include "Calendar.h"

#include <QDebug>

#define qsTr QObject::tr

//每年春节对应的公历日期
static const int springFestival[] = {
    130,217,206,                                // 1968,1969,1970
    127,215,203,123,211,131,218,207,128,216,    // 1971--1980
    205,125,213,202,220,209,219,217,206,127,    // 1981---1990
    215,204,123,210,131,219,207,128,216,205,    // 1991--2000
    124,212,201,122,209,129,218,207,126,214,    // 2001--2010
    203,123,210,131,219,208,128,216,205,125,    // 2011--2020
    212,201,122,210,129,217,206,126,213,203,    // 2021--2030
    123,211,131,219,208,128,215,204,124,212,     // 2031--2040
    201,122,210,130,217,206,126,214,202          // 2041--2049
};

//16--18位表示闰几月，0--12位表示农历每月的数据，高位表示1月，低位表示12月（农历闰月就会多一个月）
static const int  nLunarData[] = {
    461653,1386,2413,                                            // 1968,1969,1970
    330077,1197,2637,268877,3365,531109,2900,2922,398042,2395,   // 1971--1980
    1179,267415,2635,661067,1701,1748,398772,2742,2391,330031,   // 1981---1990
    1175,1611,200010,3749,527717,1452,2742,332397,2350,3222,     // 1991--2000
    268949,3402,3493,133973,1386,464219,605,2349,334123,2709,    // 2001--2010
    2890,267946,2773,592565,1210,2651,395863,1323,2707,265877,   // 2011--2020
    1706,2773,133557,1206,398510,2638,3366,335142,3411,1450,     // 2021 -- 2030
    200042,2413,723293,1197,2637,399947,3365,3410,334676,2906,    // 2031 -- 2040
    2778,132267,2358,459927,5270,5450,333477,1746,5556            // 2031 -- 2049

};


static const QString dayName[] =  {
    qsTr("*"),
    qsTr("初一"), qsTr("初二"), qsTr("初三"), qsTr("初四"), qsTr("初五"),
    qsTr("初六"), qsTr("初七"), qsTr("初八"), qsTr("初九"), qsTr("初十"),
    qsTr("十一"), qsTr("十二"), qsTr("十三"), qsTr("十四"), qsTr("十五"),
    qsTr("十六"), qsTr("十七"), qsTr("十八"), qsTr("十九"), qsTr("二十"),
    qsTr("廿一"), qsTr("廿二"), qsTr("廿三"), qsTr("廿四"), qsTr("廿五"),
    qsTr("廿六"), qsTr("廿七"), qsTr("廿八"), qsTr("廿九"), qsTr("三十")
};

/*农历月份名*/
static const QString monName[] = {
    qsTr("*"),
    qsTr("正月"), qsTr("二月"), qsTr("三月"), qsTr("四月"),
    qsTr("五月"), qsTr("六月"), qsTr("七月"), qsTr("八月"),
    qsTr("九月"), qsTr("十月"), qsTr("冬月"), qsTr("腊月")
};

/*公历每月前面的天数*/
int monthAdd[] = {
    0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334
};


Calendar::Calendar(QObject *parent) : QObject(parent)
{

}

/**
 * @brief Calendar::getLunarDate 计算农历
 * @param year  年
 * @param month 月
 * @param day 日
 * @return
 */
QString Calendar::getLunarDate (int year, int month, int day){
    int nTheDate,nIsEnd,nMonTemp,k,n,nBit;
    // 先获取公历节日
    QString strDate = holiday(month, day);

    /*现在计算农历：获得当年春节的公历日期（比如：2015年春节日期为（2月19日）），
            以此为分界点，2.19前面的农历是2014年农历（用2014年农历数据来计算），
            2.19以及之后的日期，农历为2015年农历（用2015年农历数据来计算）。*/
    nMonTemp = year - 1968;
    int springFestivalMonth = springFestival[nMonTemp] / 100;
    int springFestivalDaty = springFestival[nMonTemp] % 100;

    if(month < springFestivalMonth )
    {
        nMonTemp--;
        nTheDate = 365 * 1 + day + monthAdd[month - 1] - 31 * ((springFestival[nMonTemp] / 100) - 1) - springFestival[nMonTemp] % 100 + 1;

        if((!(year % 4)) && (month > 2))
            nTheDate = nTheDate + 1;

        if((!((year - 1) % 4)))
            nTheDate = nTheDate + 1;
    }
    else if (month == springFestivalMonth)
    {
        if (day < springFestivalDaty) {
            nMonTemp--;
            nTheDate = 365 * 1 + day + monthAdd[month - 1] - 31 * ((springFestival[nMonTemp] / 100) - 1) - springFestival[nMonTemp] % 100 + 1;

            if((!(year % 4)) && (month > 2))
                nTheDate = nTheDate + 1;

            if((!((year-1) % 4)))
                nTheDate = nTheDate + 1;
        }
        else {
            nTheDate = day + monthAdd[month - 1] - 31 * ((springFestival[nMonTemp] / 100) - 1) - springFestival[nMonTemp] % 100 + 1;

            if((!(year % 4)) && (month > 2))
                nTheDate = nTheDate + 1;
        }
    }else{
        nTheDate = day + monthAdd[month - 1] - 31 * ((springFestival[nMonTemp] / 100) - 1) - springFestival[nMonTemp] % 100 + 1;
        if((!(year % 4)) && (month > 2))
            nTheDate = nTheDate + 1;
    }
    /*--计算农历月、日---*/
    nIsEnd = 0;

    while(nIsEnd != 1)  {
        if(nLunarData[nMonTemp] < 4095)
            k = 11;
        else
            k = 12;
        n = k;
        while(n >= 0)   {
            // 获取wNongliData(m)的第n个二进制位的值
            nBit = nLunarData[nMonTemp];

            nBit = nBit >> n;
            nBit = nBit % 2;
            if (nTheDate <= (29 + nBit))    {
                nIsEnd = 1;
                break;
            }

            nTheDate = nTheDate - 29 - nBit;
            n = n - 1;
        }

        if(nIsEnd)
            break;

        nMonTemp = nMonTemp + 1;
    }

    // 农历的年月日
    year = 1969 + nMonTemp -1;
    month = k - n + 1;
    day = nTheDate;

    if (k == 12)  {
        if (month == (nLunarData[nMonTemp] / 65536) + 1)
            month = 1 - month;
        else if (month > (nLunarData[nMonTemp] / 65536) + 1)
            month = month - 1;
    }

    // 显示装换的农历
    // only day == 1 ,return month name
    if (1 == day) {
        if(month < 1){
            strDate = "闰" + monName[month * -1];
            return strDate;
        }

        // 公历节日
        if ("" != strDate) return strDate;

        // 计算农历节日
        strDate = lunarFestival(month, day);

        // 如果有节日，直接显示
        if ("" == strDate) {
             strDate = monName[month];
        }

    } else {
        // 公历节日
        if ("" != strDate) return strDate;

        // 计算农历节日
        strDate = lunarFestival(month, day);
        // 如果有节日，直接显示
        if ("" == strDate) {
            strDate = dayName[day];
        }
    }

    return strDate;
}

/**
 * @brief Calendar::holiday 公历假日
 * @param month
 * @param day
 * @return
 */
QString Calendar::holiday(int month, int day)
{
    int temp = (month << 8) | day;
    QString strHoliday = "";
    switch (temp) {
    case 0x0101: strHoliday = tr("元旦");  break;
    case 0x020E: strHoliday = tr("情人节"); break;
    case 0x0308: strHoliday = tr("妇女节"); break;
    case 0x0401: strHoliday = tr("愚人节"); break;
    case 0x0501: strHoliday = tr("劳动节"); break;
    case 0x0504: strHoliday = tr("青年节"); break;
    case 0x0601: strHoliday = tr("儿童节"); break;
    case 0x0701: strHoliday = tr("建党节"); break;
    case 0x0801: strHoliday = tr("建军节"); break;
    case 0x090A: strHoliday = tr("教师节"); break;
    case 0x0A01: strHoliday = tr("国庆节"); break;
    case 0x0C18: strHoliday = tr("圣诞节"); break;
    default: break;
    }

    return strHoliday;
}

/**
 * @brief Calendar::lunarFestival 农历春节节日
 * @param month
 * @param day
 * @return 节日
 */
QString Calendar::lunarFestival(int month, int day) {
    int temp = (month << 8) | day;
    QString strFestival = "";
    switch (temp) {
    case 0x0101: strFestival = tr("春节");  break;
    case 0x010F: strFestival = tr("元宵节"); break;
    case 0x0202: strFestival = tr("龙抬头"); break;
    case 0x0505: strFestival = tr("端午节"); break;
    case 0x0707: strFestival = tr("七夕节"); break;
    case 0x080F: strFestival = tr("中秋节"); break;
    case 0x0909: strFestival = tr("重阳节"); break;
    case 0x0C08: strFestival = tr("腊八节"); break;
    default: break;
    }

    return strFestival;
}
