import QtQuick 2.3

QtObject {
    id: root

    property Flickable flickable: Flickable {}
    readonly property int pageCount: Math.ceil(flickable.contentHeight / flickable.height)
    readonly property int pageNum: Math.ceil(flickable.contentY / flickable.height) > (pageCount - 1) ? (pageCount - 1) : Math.ceil(flickable.contentY / flickable.height)
    readonly property bool hasPrevPage: pageNum > 0
    readonly property bool hasNextPage: pageNum < pageCount - 1

    function switchToPage(to) {
        if (to >= 0 && to < pageCount && to !== pageNum) {
            var toHeight = to * flickable.height;
            var maxHeight = flickable.contentHeight - flickable.height;
            flickable.contentY = toHeight <= maxHeight ? toHeight : maxHeight;
        }
    }

    function prevPage() {
        if (hasPrevPage) switchToPage(pageNum - 1);
    }

    function nextPage() {
        if (hasNextPage) switchToPage(pageNum +1);
    }
}
