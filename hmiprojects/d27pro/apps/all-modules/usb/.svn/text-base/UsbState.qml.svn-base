import QtQuick 2.3
import QtQuick.Controls 1.2
import 'qrc:/Instances/Core' as ICore
import 'qrc:/Instances/Controls' as IControls
import  'qrc:/UI/Controls' as UControls
import  Multimedia 1.0

ICore.Page {
    id: usbstatePage

    property UsbCtl usbctl
    property int filenum
    property int  state

    onUsbctlChanged: {
        filenum =Qt.binding(function(){ return usbctl.filecount })
        state = Qt.binding(function() { return usbctl.state })
    }

//    onItemShowing: {
//        if(state === 2){
//            application.createDialogAsync('qrc:/usb/DialogTip.qml',{text:qsTr("正在读取文件")},function(dialog){
//                usbctl.stateChanged.connect(function(){
//                    if(state === 3){
//                        if(filenum == 0){
//                            dialog.close()
//                            application.multiApplications.changeApplication('home')
//                        }else {
//                            application.changePage('main',{replace: true})
//                        }
//                  }
//                })
//            })
//        }
//    }
    onStateChanged: {
        if(state === 2) {
            application.createProgressDialogAsync('qrc:/usb/DialogTip.qml',{text:qsTr("正在读取U盘")})
        } else if(state === 3) {
            if(filenum == 0){
                dialog.close()
                application.multiApplications.changeApplication('home')
            }else {
                application.changePage('main',{replace: true})
            }
      }
    }

   Timer{
       id:autocloser
       interval: 4000
       onTriggered: {
           autocloser.stop()
       }
   }

}
