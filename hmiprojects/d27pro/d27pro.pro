#/*********************************************************************************
#  *Copyright(C),2010-2016,Shenzhen Hangsheng electronics Co.,Ltd.
#  *FileName: src.pro
#  *Author: Blavik Zou
#  *Version:  V1.0
#  *Date: 2016/06/20
#  *Description: 此工程是针对项目的工程文件，其中包含apps工程和Instances工程
#                1. apps工程下是该项目的所有页面逻辑具体的实现
#                2. Instances工程是该项目的工程共通组件工程，可单独编译运行调试效果
#  *Notice： 注意在添加工程的时候记住要加上'\',具体操作请查看工程实例
#  *Others:
#  *History:
#     1.Date:
#       Author:
#       Modification:
#**********************************************************************************/

TEMPLATE = subdirs

SUBDIRS += \
    common/Instances \
    apps \



