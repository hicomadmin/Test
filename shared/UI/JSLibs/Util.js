.pragma library
var rootItem;
function initRootItem(item) {
    rootItem = item;
}

function createTimer(opts, fn) {
    opts = opts || {};
    opts.parent = opts.parent || rootItem;
    opts.interval = opts.interval || 1;
    opts.repeat = opts.repeat || false;
    opts.triggeredOnStart = opts.triggeredOnStart || false;

    var obj = Qt.createQmlObject(
                'import QtQuick 2.3; Timer {' +
                    'interval: ' + opts.interval + ';' +
                    'repeat: ' + opts.repeat + ';' +
                    'triggeredOnStart: ' + opts.triggeredOnStart +
                '}',
                opts.parent);
    if (obj && fn) obj.triggered.connect(fn);
    else console.error('createTimer err.');
    return obj;
}

function setTimeout(fn, timeout) {
    var timer = createTimer({
        repeat: false,
        interval: timeout,
        triggeredOnStart: false
    }, fn);
    timer.start();
    return timer;
}

function clearTimeout(timer) {
    if (timer) timer.destroy();
}

function setInterval(fn, interval) {
    var timer = createTimer({
        repeat: true,
        interval: interval,
        triggeredOnStart: false
    }, fn);
    timer.start();
    return timer;
}

function clearInterval(interval) {
    if (interval) interval.destroy();
}

function createComponent(url) {
    var com = Qt.createComponent(url, 0);
    var result;

    if (com.status == 1) result = com;
    else if (status == 3) console.error(com.errorString());
    return result;
}

function createComponentAsync(url, cb) {
    var com = Qt.createComponent(url, 1);

    if (com.status == 1) {
        if (cb) cb(null, com);
    } else {
        com.statusChanged.connect(function (status) {
            if (status == 1) {
                if (cb) cb(null, com);
            } else if (status == 3) {
                if (cb) cb(com.errorString(), com);
            }
        });
    }
    return com;
}

function createObject(com, opts) {
    opts = opts || {};
    var res = com.createObject(opts.parent || rootItem, opts.properties || {});

    if (!res) {
        res = com.errorString();
    }
    return res;
}

function createObjectAsync(com, opts, cb) {
    opts = opts || {};

    var incubator = com.incubateObject(opts.parent || rootItem, opts.properties || {}, Qt.Synchronous); // Fixme, use Asynchronous has a bug.

    if (incubator.status != 1) {
        incubator.onStatusChanged = function () {
            if (incubator.status == 1) {
                // Ready
                if (cb) cb(null, incubator.object, com);
            } else if (incubator.status == 3) {
                // Error
                if (cb) cb('createObjectAsync err');
            }
            if (opts.destroyCom) com.destroy();
        };
    } else {
        if (cb) cb(null, incubator.object, com);
    }

    return incubator;
}

function createComponentObject(url, opts) {
    var com = createComponent(url);
    var obj;

    if (com) {
        obj = createObject(com, opts);

        if (opts.destroyCom) com.destroy();
    }
    return obj;
}

function createComponentObjectAsync(url, opts, cb) {
    createComponentAsync(url, function (err, com) {
        if (err) return cb && cb(err);

        opts.destroyCom = true;
        createObjectAsync(com, opts, cb);
    });
}

function ucfirst(str) {
    if(!!str) return str[0].toUpperCase() + str.substr(1);
    else return str;
}

function formatTime(millisecond) {
    if (!millisecond || millisecond <1) {
        return "00:00"
    }
    var min = Math.floor(millisecond/60000);
    var sec =  Math.round((millisecond%60000)/1000);
    if (sec < 10) sec = "0" + sec;
    if (min < 10) min = "0" + min;
    return min + ":" + sec
}
