import QtQuick 2.3
import 'qrc:/UI/Private' as Private
import 'qrc:/UI/JSLibs/ThreeParts.js' as JSLibs

Private.Control {
    id: root

    property string name
    property string title
    property VirtualApplication application

    signal pageRefreshed
    signal pageAfterCreated
    signal pageReadyShow
    signal pageShowing
    signal pageShown
    signal pageFirstShown
    signal pageReadyHide
    signal pageHiding
    signal pageHiden
    signal pageFirstHiden
    signal pageBeforeDestroyed
    signal pageAfterDestroyed

    onPageReadyShow: visible = true;
    onPageHiden: visible = false;

    function requirePlugins(properties, cb) {
        if (typeof properties === 'string') {
            properties = [properties];
        }
        if (!properties || properties.length <= 0) return cb('Param is invalid.');

        var tasks = [];
        JSLibs._.each(properties, function (pro) {
            tasks.push(function (callback) {
                if (root[pro]) callback(null, root[pro]);
                else {
                    var signal = root[pro + 'Changed'];
                    signal.connect(function slot(p) {
                        signal.disconnect(slot);

                        callback(null, root[pro]);
                    });
                }
            });
        });

        JSLibs.async.parallel(tasks, cb);
    }
}
