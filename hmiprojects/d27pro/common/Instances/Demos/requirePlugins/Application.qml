import QtQuick 2.3
import 'qrc:/Instances/Core' as ICore

ICore.VirtualApplication {
    pages: ({
        main: { url: Qt.resolvedUrl('MainPage.qml'), title: '主菜单', requires: 'radio'},
        multi: { url: Qt.resolvedUrl('MultiPage.qml'), title: '加载多个插件', requires: ['radio', 'video']},
        creator1: { url: Qt.resolvedUrl('MultiPage.qml'), title: '自定义创建器1', requires: [
                        {name: 'test', creator: testCom}
                    ]},
        creator2: { url: Qt.resolvedUrl('MultiPage.qml'), title: '自定义创建器2', requires: [
                        {name: 'test', creator: testCom}
                    ]},
        recreate: { url: Qt.resolvedUrl('MultiPage.qml'), title: '重新创建', requires: [
                        {name: 'test', creator: testCom, recreate: true},
                    ]},
        destroyWhen: { url: Qt.resolvedUrl('MultiPage.qml'), title: '当隐藏时销毁', requires: [
                        {name: 'test', creator: testCom, destroyWhen: 'pageHiden'},
                    ]}
    })
    initialPage: 'main'

    Component {
        id: testCom
        Item {
            x: 100
        }
    }
}
