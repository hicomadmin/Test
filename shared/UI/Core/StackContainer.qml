import QtQuick 2.3
import 'qrc:/UI/Private' as Private
import 'qrc:/UI/Core/StackContainer.js' as JS
import 'qrc:/UI/JSLibs/ThreeParts.js' as JSLibs

Private.Container {
    id: root
    transitionDelegate: Private.ContainerTransitionDelegate {}

    property var elSettings: ({}) // id, cache, url, com, parent

    function findById(id) {
        return JSLibs._.findWhere(JS.stack, {id: id});
    }

    function findAllById(id) {
        return findById(id) || JS.cacheStack[id];
    }

    function findByItem(item) {
        return JSLibs._.findWhere(JS.stack, {item: item});
    }

    function findAllByItem(item) {
        return findByItem(item) || JSLibs._.findWhere(JSLibs._.values(JS.cacheStack), {item: item});
    }

    function foreachEl(pred) {
        for (var i = 0; i < JS.stack.length; ++i) {
            if (pred(JS.stack[i])) break
        }
    }

    function clear() {
        console.debug("Clear All Elements.")
        var el = JS.current();
        if (!el) return
        __showEl(false, el);
        for (var i = 0; i < JS.stack.length; ++i) {
            __destroyPopedEl(JS.stack[i]);
        }
        JS.removeStack(0, JS.stack.length);
        __changeCurrentId('')
        __outputStack()
    }

    /* BEGIN by Zhang Yi, 2016.12.01
     * Add this function for removing an element of this id from the stack.
    */
    function remove(id) {
        var el = findById(id);
        if (!el) return
        var removeIndex = JSLibs._.indexOf(JS.stack, el);
        console.debug("Removing:", removeIndex, el.id)
        if (removeIndex < 0) return
        if (currentId === id) {
            __showEl(false, el);
        }
        __destroyPopedEl(el);
        JS.removeStack(removeIndex, 1);
        if (currentId === id) {
            el = JS.current();
            if (el) {
                __changeCurrentId(el.id)
                __showEl(true, el);
            }
            else {
                __changeCurrentId('')
            }
        }
        __outputStack()
    }
    /* END - by Zhang Yi, 2016.12.01 */

    /*
    * 把元素压入栈内，支持多个同时压入
    *     ids: 需要被压入栈中的所有元素id, 可以是单个字符串（'xxx'），或者字符串数组（['xxx']）
    *     optses: 匹配ids个数的操作选项：可以是单个对象，或者对象数组（['xxx']）
    *         其中opts对象的属性包括：
    *               parent: 被创建的元素的父元素
    *               properties: {key: value} 被创建元素的属性参数传递
    *               replace: false 是否替换掉当前栈的元素
    *               keep: 0 如果上层有元素的话, 保留最上层多少个元素
    *               immediate: false 是否直接切换，不需要动画效果，如果时第一页时，页不会有动画元素
    *               settings: {key: value} 用于替换元素配置信息中的值
    *               waitAnimationComplete: true 在动画执行前，是否一直等待上一次动画完成
    */
    function changeTo(ids, optses) {
        if (animating) return console.warn('StackContainer changeTo animating...');

        optses = JSLibs._.isArray(optses) ? optses : [optses || {}];
        if (!ids) {
            ids = [];
            JSLibs._.each(optses, function (opts, i) {
                ids.push(__generateId(function (_id) { return !!elSettings[_id] }));
                console.warn('StackContainer changeTo: empty id, has generated for U, id is', ids[i]);
            });
        }
        ids = JSLibs._.isArray(ids) ? ids : [ids];
        var createElTasks = [];
        optses = JSLibs._.map(optses, function (opts, index) {
            var id = ids[index];
            var settings = elSettings[id];
            opts = opts || {};
            opts = JSLibs._.extendOwn({
                                         replace: false,
                                         keep: 0,
                                         immediate: false,
                                         settings: settings,
                                         waitAnimationComplete: true
                                      }, opts);

            if (!settings && !opts.settings) return console.error('StackContainer changeTo:  U should set settings into opts for no-existed id.');
            if (!settings) elSettings[id] = settings = opts.settings;
            opts.parent = opts.parent || settings.parent || root;

            // 创建所有未创建的
            var object  = findAllById(id);
            if (!object) {
                createElTasks.push(function (cb) {
                    itemBeforeCreated(id);
                    __prepareEl(opts, function (err, item, com) {
                        if (err) {
                            itemCreateError(id, err);
                            console.error('StackContainer changeTo: __prepareEl err', id, err)
                            return cb(err);
                        }

                        item.width = Qt.binding(function() { return item.parent.width });
                        item.height = Qt.binding(function() { return item.parent.height });

                        var el = {id: id, item: item, cache: !!settings.cache};
                        JS.cacheStack[id] = el;
                        itemAfterCreated(id);
                        cb(null, item);
                    });
                });
            } else {
                if(object.item && opts.needUpdate && opts.properties) {
                    for (var key in opts.properties) {
                        object.item[key] = opts.properties[key];
                    }
                }
            }           // 2016/02/02 增加页面back时数据传递

            return opts;
        });

        if (createElTasks.length > 0) {
            var taskCb = function (err, results) {
                if (err) return console.error('StackContainer create elTasks err', err);
                __afterPrepareAllEl(ids, optses);
            }
            for (var i = 0; i < createElTasks.length; ++i) {
                createElTasks[i](taskCb)
            }
//            JSLibs.async.series(createElTasks, function (err, results) {
//                if (err) return console.error('StackContainer create elTasks err', err);
//                __afterPrepareAllEl(ids, optses);
//            });
        } else {
            __afterPrepareAllEl(ids, optses);
        }
    }

    function depth() {
        return JS.stack.length;
    }

    function findByIndex(index) {
        var el;
        if (index < JS.stack.length) {
            el = JS.stack[index];
        }
        return el;
    }

    // 异步创建元素对象实例
    function __prepareEl(opts, cb) {
        var settings = opts.settings;
        var creator = settings.com || settings.url;
        var _opts = {
            parent: opts.parent,
            properties: opts.properties
        };

        if (typeof creator === 'string') {
            JSLibs.createComponentObjectAsync(creator, _opts, cb);
        } else {
            JSLibs.createObjectAsync(creator, _opts, cb);
        }
    }

    // 过渡前准备操作
    function __afterPrepareAllEl(ids, optses) {
        var id = ids[ids.length - 1];
        if (id === currentId && !animating) {
            itemRefreshed(id);
            return console.warn('StackContainer changeTo: id is same with currentId.');
        }

        if (ids.length > 1) for (var i = 0; i < ids.length - 1; i++) itemForwardSkipped(ids[i]); // 当多个元素被压入栈时，子项被跳过

        var opts = optses[optses.length - 1];
        var inEl = findById(id);
        var outEl = findById(currentId);
        if (!inEl) {
            // search from cache firstly
            inEl = JS.cacheStack[id];
        }
        if (!inEl) return console.error('StackContainer __afterPrepareAllEl invalid el', id);
        __doTransition(inEl, outEl, opts, ids);
    }

    // 开始动画检查
    function __doTransition(inEl, outEl, opts, ids) {
        if (!outEl) opts.immediate = true;
        if (animating) {
            if (opts.waitAnimationComplete) {
                if (currentAnimation) currentAnimation.stopped.connect(function () {
                    if (currentAnimation) currentAnimation.destroy();
                    __performCustomTransition(inEl, outEl, opts, ids);
                });
            } else {
                if (currentAnimation) {
                    var animatingInEl = findByItem(currentAnimation.enterItem);
                    var animatingOutEl = findByItem(currentAnimation.exitItem);

                    if (animatingInEl) itemInterrupted(animatingInEl.id, 'animation request', true);
                    if (animatingOutEl) itemInterrupted(animatingOutEl.id, 'animation request', false);
                    currentAnimation.complete();
                    if (currentAnimation) currentAnimation.destroy();
                }
                __performCustomTransition(inEl, outEl, opts, ids);
            }
        } else {
            __performCustomTransition(inEl, outEl, opts, ids);
        }
    }

    // 执行自定义过渡动画
    function __performCustomTransition(inEl, outEl, opts, ids) {

        /* BEGIN by Zhang Yi, 2016.12.01
         * Add this logic for keeping elements which need to be upper than the inEl.
        */
        var keep = opts.keep || 0;
        if (keep === 0) {
        /* END - by Zhang Yi, 2016.12.01 */

            itemReadyShow(inEl.id);
            if (outEl) itemReadyHide(outEl.id);

            var doAfter = function() {
                itemShown(inEl.id);
                if (outEl) {
                    itemHiden(outEl.id);
                }
                __doAfterAnimation(inEl, outEl, opts, ids);
            };

            if (!transitionDelegate) {
                opts.immediate = true;
                console.warn('StackContainer __performCustomTransition transitionDelegate is empty.');
            }

            if (!opts.immediate) {
                var inIndex = JSLibs._.indexOf(JS.stack, inEl);
                var outIndex = JSLibs._.indexOf(JS.stack, outEl);

                opts.isBack = inIndex > -1 && inIndex < outIndex;
                currentAnimation = transitionDelegate.getAnimation(inEl, outEl, opts);
            }

            if (!opts.immediate && currentAnimation) {
                animating = true;
                currentAnimation.start();
                itemShowing(inEl.id);
                if (outEl) itemHiding(outEl.id);
                currentAnimation.stopped.connect(function () {
                    animating = false;
                    doAfter();
                    if (currentAnimation) currentAnimation.destroy();
                });
            } else {
                itemShowing(inEl.id);
                if (outEl) itemHiding(outEl.id);
                doAfter()
            }

        /* BEGIN by Zhang Yi, 2016.12.01
         * Add this logic for keeping elements which need to be upper than the inEl.
        */
        }
        else {
            __showEl(false, inEl)
            __doAfterAnimation(inEl, outEl, opts, ids);
        }
        /* END - by Zhang Yi, 2016.12.01 */
    }

    // 动画执行完成
    function __doAfterAnimation(inEl, outEl, opts, ids) {
        var inIndex = JSLibs._.indexOf(JS.stack, inEl);
        var outIndex = JSLibs._.indexOf(JS.stack, outEl);

        /* BEGIN by Zhang Yi, 2016.12.01
         * Add this logic for keeping elements which need to be upper than the inEl.
        */
        var keep = opts.keep || 0;
        console.debug("Page changes to --",
                      "replace:", opts.replace, "keep:", keep, "in:", inIndex, "out:", outIndex, ids[0])
        var removedEls;
        var replaceLogic = function() {
            removedEls = JS.removeAfterIndex(outIndex, keep);
            removedEls = removedEls || [];
            JSLibs._.each(removedEls, function (el) {
                console.debug("Destroying el:", el.id)
                __destroyPopedEl(el);
            });
        };
        /* END - by Zhang Yi, 2016.12.01 */

        if (inIndex < 0) {
            if (opts.replace) replaceLogic();
            JSLibs._.each(ids, function (id, index) {
                var el;
                if (!findById(id)) {
                    el = JS.cacheStack[id];
                    if (el) {
                        if (keep === 0) JS.push(el);
                        else            JS.insert(el, keep);
                    }
                    delete JS.cacheStack[id];
                }
            });
        } else if (inIndex < outIndex) {
            outIndex = inIndex + 1
            replaceLogic();
        }
        // 当前画面变更
        __changeCurrentId(JS.current().id)
        __outputStack()
    }

    // 检查是否销毁被弹出的元素
    function __destroyPopedEl(el) {
        if (el.cache) {
            JS.cacheStack[el.id] = el;
        } else {
            itemBeforeDestroyed(el.id);
            el.item.Component.destruction.connect(function () {
                itemAfterDestroyed(el.id);
            });
            el.item.destroy();
        }
    }

    function __showEl(op, el) {
        if (!el) return
        if (op) {
            itemReadyShow(el.id);
            itemShowing(el.id);
            itemShown(el.id);
        }
        else {
            itemReadyHide(el.id);
            itemHiding(el.id);
            itemHiden(el.id);
        }
    }

    function __outputStack() {
        console.debug("@@@@ Output JS.stack -- BEGIN")
        for (var i = 0; i < JS.stack.length; ++i) {
            console.debug("@@@@  ", i, ":", JS.stack[i].id)
        }
        console.debug("@@@@ Output JS.stack -- END")
    }

    function __changeCurrentId(id) {
        currentIdChanging(id)
        currentId = id;
    }
}
