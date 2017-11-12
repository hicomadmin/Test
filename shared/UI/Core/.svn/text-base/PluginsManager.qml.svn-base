import QtQuick 2.3
import 'qrc:/UI/Core/PluginsManager.js' as JS
import 'qrc:/UI/JSLibs/ThreeParts.js' as JSLibs

QtObject {
    id: root

    /* BEGIN by Zhang Yi, 2016.12.09
     * Reconstitute plug-in management.
    */
    property var pluginsCreators: ({})

    function prepareItemPlugins(id, items, itemStack) {
        var itemSettings = items[id];
        var requirePluginsInfo = itemSettings.requires;

        if (requirePluginsInfo) {
            if (typeof requirePluginsInfo === 'string') {
                // 如果设置为某一个字符串
                requirePluginsInfo = [{ name: requirePluginsInfo }];
            } else if (!requirePluginsInfo.hasOwnProperty('length')) {
                // 是单个对象
                requirePluginsInfo = [requirePluginsInfo];
            }

            if (requirePluginsInfo.length <= 0) return console.warn('Plugin settings is empty.');

            // 开始请求插件
            var refItemReadyFns = [];
            var infoTemp;
            for (var i = 0; i < requirePluginsInfo.length; ++i) {
                infoTemp = requirePluginsInfo[i];
                if (typeof infoTemp === 'string') {
                    infoTemp = { name: infoTemp };
                }
                // 当配置信息里面没有设置创建器时，则在全局window中获取
                infoTemp.creator = infoTemp.creator || pluginsCreators[infoTemp.name];
                refItemReadyFns.push(requirePlugin(infoTemp.name, infoTemp));
            }

            // 判断是否存在，再执行信号
            var runReadyFns = function (refItem) {
                for (var i = 0; i < refItemReadyFns.length; i++) {
                    refItemReadyFns[i](refItem);
                }
            };
            var itemInfo = itemStack.findAllById(id);

            if (itemInfo && itemInfo.item) {
                runReadyFns(itemInfo.item);
            } else {
                itemStack.itemAfterCreated.connect(function slot(_id) {
                    if (_id === id) { // 如果是当前item
                        itemStack.itemAfterCreated.disconnect(slot);
                        var itemInfo = itemStack.findAllById(_id);
                        runReadyFns(itemInfo.item);
                    }
                });
            }
        }
    }

    function getPlugin(name) {
        var plugin = JS.findOne(name)
        if (plugin) {
            plugin = plugin.item
        }
        else {
            plugin = __createPlugin(name, pluginsCreators[name])
        }
        return plugin
    }
    /* END - by Zhang Yi, 2016.12.09 */

    /*
    * name插件名称
    * opts包括：
    *     recreate 是否重新创建，true无论何时都重新创建，false只有在第一次才创建
    *     creator 需要创建时的Component或者source
    *     destroyWhen 销毁的时间点，如果未设置则不会销毁（包括：readyHide, hiding, hiden, firstHiden），
    *                   名称可能会根据不同的实例类型而不同，如则是pageHiden
    *
    *  返回值是一个函数，需要当依赖对象实例已准备好再调用
    */
    function requirePlugin(name, opts) {
        if (!name) return console.error('PluginManager requirePlugin err: name is invalid.');
        opts = opts || {};

        var plugin;
        // 如果不需要重新创建则在现有的存储里面查询
        if (!opts.recreate) plugin = JS.findOne(name);

        if (!plugin) {
            plugin = {item: __createPlugin(name, opts.creator)};
        }

        var destroyWhen = opts.destroyWhen;
        var pluginItem = plugin.item;
        return function (refItem) {
            // 把依赖的实例的值为name的属性赋值
            if (refItem.hasOwnProperty(name)) refItem[name] = pluginItem;

            // 当依赖的实例销毁时，判断是不是需要销毁插件实例
            if (destroyWhen) {
                var destroySignal = refItem[destroyWhen];
                destroySignal.connect(function slot() {
                    destroySignal.disconnect(slot);
                    JS.remove(name, pluginItem);
                });
            }
        }
    }

    // 创建相关插件
    function __createPlugin(name, creator) {
        var pluginItem = __createPluginObject(creator);
        JS.append(name, {item: pluginItem});
        return pluginItem;
    }

    function __createPluginObject(creator) {
        var obj;

        if (typeof creator === 'string') {
            obj = JSLibs.createComponentObject(creator, {});
        } else {
            obj = JSLibs.createObject(creator, {});
        }
        return obj;
    }
}
