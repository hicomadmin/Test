import QtQuick 2.3
import QtMultimedia 5.0
import 'qrc:/Instances/Core' as ICore

ICore.Window {
    id: window
    multiApplications {
        applications: ({
                           home: { url: Qt.resolvedUrl('home/Application.qml'), title: '主菜单' },
                           buttons: { url: Qt.resolvedUrl('buttons/Application.qml'), title: '按钮实例' },
                           labels: { url: Qt.resolvedUrl('labels/Application.qml'), title: '标签实例' },
                           dialogs: { url: Qt.resolvedUrl('dialogs/Application.qml'), title: '弹出框实例' },
                           listView: { url: Qt.resolvedUrl('listView/Application.qml'), title: '列表实例'},
                           dataOperations: { url: Qt.resolvedUrl('dataOperations/Application.qml'), title: '数据操作类实例'},
                           requirePlugins: { url: Qt.resolvedUrl('requirePlugins/Application.qml'), title: '插件加载器'},
                           RoundLabButtons: { url: Qt.resolvedUrl('RoundLabButtons/Application.qml'), title: 'lab按钮'},
                           calendar:{ url: Qt.resolvedUrl('calendar/Application.qml'), title: 'calendar'},
                           miniCalendar:{ url: Qt.resolvedUrl('miniCalendar/Application.qml'), title: 'miniCalendar'},
                            keyPad:{url: Qt.resolvedUrl('keyPad/Application.qml'), title: 'keyPad'}
                       })
        initialApplication: 'home'
    }
    pluginsCreators: ({
                          radio: radioCom,
                          video: videoCom
                      })

    Component {
        id: radioCom
        Radio {
            frequency: 1550002
        }
    }
    Component {
        id: videoCom
        Video {
            muted: true
        }
    }
}
