import QtQuick 2.3

QtObject {
    id: root

    property bool autoLoadFirstPage: true // 自动获取首页数据
    property real refreshEmitSize: 50 // 刷新触发的距离，即当下拉至一定距离后触发刷新事件
    property Flickable flickable: Flickable {}
    readonly property bool atYEnd: flickable.atYEnd // 是否在底部
    readonly property real yPosition: flickable.visibleArea.yPosition

    property PaginationLoaderDelegate delegate: PaginationLoaderDelegate {}

    //fix bug-1775, do not load more data when have no more data. by gaojun -2017-1-19
    onAtYEndChanged: {
        if (delegate.useLoaderMore && !delegate.noMore && atYEnd && (flickable.contentHeight > flickable.height)) {
            delegate.loadMore();
        }
    }

    onYPositionChanged: {
        if (delegate.useRefresher) {
            var refreshPosition = refreshEmitSize / flickable.contentHeight;
            if (yPosition < 0) {
                var isTriggeredRefreshed = yPosition + refreshPosition <= 0;

                if (flickable.dragging) {
                    if (!isTriggeredRefreshed) delegate.refreshPulling(Math.abs(yPosition) / refreshPosition);
                } else {
                    if (isTriggeredRefreshed) delegate.refreshed();
                }
            }
        }
    }

    onDelegateChanged: {
        if (flickable.hasOwnProperty('model')) {
            // 包含model属性
            delegate.dataLoaded.connect(function (data, refresh) {
                if (refresh) flickable.model.clear();
                if (data && data.length > 0) flickable.model.append(data);
            });
        }

        autoLoadFirstPage && delegate.loadFirstPage();
    }
}
