import QtQuick 2.3

QtObject {
    id: root

    property bool autoLoadFirstPage: true // 自动获取首页数据
    property real refreshEmitSize: 50 // 刷新触发的距离，即当下拉至一定距离后触发刷新事件
    property Flickable flickable: Flickable {}
    readonly property bool atXEnd: flickable.atXEnd // 是否在底部
    readonly property real xPosition: flickable.visibleArea.xPosition

    property PaginationLoaderDelegate delegate: PaginationLoaderDelegate {}

    onAtXEndChanged: if (delegate.useLoaderMore && atXEnd && flickable.contentWidth > flickable.width) delegate.loadMore();
    onXPositionChanged: {
        if (delegate.useRefresher) {
            var refreshPosition = refreshEmitSize / flickable.contentWidth;
            if (xPosition < 0) {
                var isTriggeredRefreshed = xPosition + refreshPosition <= 0;

                if (flickable.dragging) {
                    if (!isTriggeredRefreshed) delegate.refreshPulling(Math.abs(xPosition) / refreshPosition);
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
                if (data && data.length > 0) {
                    console.log('pppppppppppppp',data)
                    flickable.model.append(data);
                }
            });
        }

        autoLoadFirstPage && delegate.loadFirstPage();
    }
}
