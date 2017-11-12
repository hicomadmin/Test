import QtQuick 2.3
import QtQuick.Controls 1.2
import 'qrc:/UI/Private' as Private
import 'qrc:/UI/JSLibs/ThreeParts.js' as JSLibs

Item {
    id: root

    property string currentId

    property bool animating: false
    property var currentAnimation
    property QtObject transitionDelegate
    property string signalPrefix: 'item'

    signal currentIdChanging(string id)

    signal itemRefreshed(string id) // 被刷新
    signal itemBeforeCreated(string id) // 创建之前
    signal itemAfterCreated(string id) // 创建之后
    signal itemCreateError(string id, var err) // 创建时出错

    signal itemReadyShow(string id) // 准备进入
    signal itemShowing(string id) // 进入中
    signal itemShown(string id) // 进入后
    signal itemFirstShown(string id) // 第一次进入后

    signal itemInterrupted(string id, string reason, bool isIn) // 动画中被中断
    signal itemForwardSkipped(string id) // 动画中向前被跳过
    signal itemBackwardSkipped(string id) // 动画中向后被跳过

    signal itemReadyHide(string id) // 准备出去
    signal itemHiding(string id) // 出去中
    signal itemHiden(string id) // 出去后
    signal itemFirstHiden(string id) // 第一次出去后

    signal itemBeforeDestroyed(string id) // 销毁之前
    signal itemAfterDestroyed(string id) // 销毁之后

    onItemRefreshed: if (visible) __dispatchSignal('refreshed', id)
    onItemAfterCreated: __dispatchSignal('afterCreated', id)

    onItemReadyShow: __dispatchSignal(visible ? 'readyShow' : 'readyHide', id)
    onItemShowing: __dispatchSignal(visible ? 'showing' : 'hiding', id)
    onItemShown: __dispatchSignal(visible ? 'shown' : 'hiden', id)
    onItemFirstShown: __dispatchSignal(visible ? 'firstShown' : 'firstHiden', id)

    onItemInterrupted: __dispatchSignal('interrupted', id, [reason, isIn])
    onItemForwardSkipped: __dispatchSignal('forwardSkipped', id)
    onItemBackwardSkipped: __dispatchSignal('backwardSkipped', id)

    onItemReadyHide: __dispatchSignal('readyHide', id)
    onItemHiding: __dispatchSignal('hiding', id)
    onItemHiden: __dispatchSignal('hiden', id)
    onItemFirstHiden: __dispatchSignal('firstHiden', id)

    onItemBeforeDestroyed: __dispatchSignal('beforeDestroyed', id)
    onItemAfterDestroyed: __dispatchSignal('afterDestroyed', id)

    function findById(id) {}
    function findAllById(id) {}
    function findByItem(item) {}
    function findAllByItem(item) {}
    function changeTo(id, opts) {}
    function back(opts) {}

    function __generateId(verifyFn) {
        var id = 'id' + JSLibs._.random(0, 999999);
        if (verifyFn && verifyFn(id)) id = __generateId(verifyFn);
        return id;
    }

    function __dispatchSignal(name, id, args) {
        if (!enabled) return
        var signal, result = findAllById(id);
        if (result && result.item) {

            var checkHasDone = function (ask, asked, value) {
                if (name === ask) {
                    var has = !!(result['has' + asked])
                    if (has === value) return true
                    result['has' + asked] = value
                }
                return false
            }

            if (checkHasDone('readyShow' , 'ReadyShow' , true )) return
            if (checkHasDone('showing'   , 'Showing'   , true )) return
            if (checkHasDone('shown'     , 'Shown'     , true )) return
            if (checkHasDone('firstShown', 'FirstShown', true )) return

            if (checkHasDone('readyHide' , 'ReadyShow' , false)) return
            if (checkHasDone('hiding'    , 'Showing'   , false)) return
            if (checkHasDone('hiden'     , 'Shown'     , false)) return
            if (checkHasDone('firstHiden', 'FirstHiden', true )) return

            signal = result.item[signalPrefix + JSLibs.ucfirst(name)];
            if (signal) signal(args);

            if (name === 'shown') {
                if (!result.hasFirstShown) {
                    itemFirstShown(id);
                    result.hasFirstShown = true;
                }
            }
            else if (name === 'hiden') {
                if (!result.hasFirstHiden) {
                    itemFirstHiden(id);
                    result.hasFirstHiden = true;
                }
            }
        }
    }
}
