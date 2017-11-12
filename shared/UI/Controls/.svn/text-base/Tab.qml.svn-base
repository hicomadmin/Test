import QtQuick 2.3
import 'qrc:/UI/Private' as Private
import 'qrc:/UI/JSLibs/ThreeParts.js' as JSLibs

Item {
    id: tab

    property var application
    property var tabview

    signal tabRefreshed
    signal tabAfterCreated
    signal tabReadyShow
    signal tabShowing
    signal tabShown
    signal tabFirstShown
    signal tabReadyHide
    signal tabHiding
    signal tabHiden
    signal tabFirstHiden
    signal tabBeforeDestroyed
    signal tabAfterDestroyed

    onTabReadyShow: visible = true;
    onTabHiden: visible = false;

    function requirePlugins(properties, cb) {
        if (typeof properties === 'string') {
            properties = [properties];
        }
        if (!properties || properties.length <= 0) return cb('Param is invalid.');

        var tasks = [];
        JSLibs._.each(properties, function (pro) {
            tasks.push(function (callback) {
                if (tab[pro]) callback(null, tab[pro]);
                else {
                    var signal = tab[pro + 'Changed'];
                    signal.connect(function slot(p) {
                        signal.disconnect(slot);

                        callback(null, tab[pro]);
                    });
                }
            });
        });

        JSLibs.async.parallel(tasks, cb);
    }
}
