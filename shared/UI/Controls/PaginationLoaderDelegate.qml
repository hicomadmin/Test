import QtQuick 2.3
import 'qrc:/UI/JSLibs/ThreeParts.js' as JSLibs

QtObject {
    id: root

    property int page: 0 // 当前已加载的页数
    property bool asynchronous: true // 请求是否异步
    property bool processing: false // 是否请求正在处理中
    property int processingType: -1 // 请求处理类型，-1：未知类型（默认），0：首页加载中、1：刷新中、2：加载更多中
    property bool noMore: false // 是否还有更多数据
    property int resetProcessingDelay: 300 // 处理中状态延迟重置时间
    property bool useRefresher: false // 是否开启刷新功能
    property bool useLoaderMore: true // 是否开启刷新功能

    signal refreshed // 开始刷新数据
    signal refreshPulling(real rate) // 刷新拉拽中
    signal loadMore // 开始加载更多

    signal loadError(var err); // 加载出错
    signal dataLoaded(var data, bool refresh); // // 当数据被加载

    function loadFirstPage() { // 加载首页数据
        if (processing) return;
        processing = true;
        processingType = 0;

        __refreshData();
    }
    function loadPage(page) {  } // 加载页面数据的接口，需要外部实现
    function loadPageAsync(page, cb) { if (cb) cb(null); } // 异步加载页面数据接口，需要外部实现

    function __refresh() { return loadPage(1); } // 刷新数据
    function __refreshAsync(cb) { loadPageAsync(1, cb) } // 异步刷新数据
    function __resetPage() { //重置页面信息
        page = 1;
        noMore = false;
    }
    function __refreshData() {
        if (asynchronous) {
            __refreshAsync(function (err, data) {
                JSLibs.setTimeout(function () { processing = false; }, resetProcessingDelay);

                if (err || !data) return loadError(err);
                __resetPage();
                dataLoaded(data, true);
            });
        } else {
            var res = __refresh();

            JSLibs.setTimeout(function () { processing = false; }, resetProcessingDelay);
            if (!res) loadError('unknow error');
            else {
                __resetPage();
                dataLoaded(res, true);
            }
        }
    }

    onDataLoaded: {
        processing = false;
    }

    onRefreshed: {
        if (processing) return;
        processing = true;
        processingType = 1;

        __refreshData();
    }
    onLoadMore: {
        if (noMore || processing) return;
        processing = true;
        processingType = 2;

        if (asynchronous) {
            loadPageAsync(page + 1, function (err, data) {
                JSLibs.setTimeout(function () { processing = false; }, resetProcessingDelay);
                if (err || !data) return loadError(err);

                if (data.length > 0) {
                    page++;
                    dataLoaded(data, false);
                } else noMore = true;
            });
        } else {
            var res = loadPage(page + 1);

            JSLibs.setTimeout(function () { processing = false; }, resetProcessingDelay);
            if (!res) loadError('unknow error');
            else
                if (res.length > 0) {
                    page++;
                    dataLoaded(res, false);
                } else noMore = true;
        }
    }
}
