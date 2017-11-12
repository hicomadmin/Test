import QtQuick 2.3
import QtQuick.Controls 1.2
import 'qrc:/UI/Controls' as UControls
import 'qrc:/UI/JSLibs/ThreeParts.js' as JSLibs

Flow {
    id: flow
    spacing: 1
    Row {
        width: parent.width
        UControls.Button {
            width: parent.width / 5
            height: 40
            onClicked: series()
            Text {
                anchors.centerIn: parent
                text: 'series'
            }
        }
        UControls.Button {
            width: parent.width / 5
            height: 40
            onClicked: parallel()
            Text {
                anchors.centerIn: parent
                text: 'parallel'
            }
        }
        UControls.Button {
            width: parent.width / 5
            height: 40
            onClicked: parallelLimit()
            Text {
                anchors.centerIn: parent
                text: 'parallelLimit'
            }
        }
        UControls.Button {
            width: parent.width / 5
            height: 40
            onClicked: waterfall()
            Text {
                anchors.centerIn: parent
                text: 'waterfall'
            }
        }
        UControls.Button {
            width: parent.width / 5
            height: 40
            onClicked: auto()
            Text {
                anchors.centerIn: parent
                text: 'auto'
            }
        }
    }
    Component {
        id: com
        Rectangle {
            height: 40
        }
    }

    function series() {
        var times = [];
        for (var i = 0; i < 20; i++) times.push(i);

        var tasks = [];
        JSLibs._.each(times, function (index) {
            tasks.push(function (cb) {
                console.log('createObjectAsync series index=', index);

                var timer = JSLibs.setTimeout(function () {
                    JSLibs.createObjectAsync(com, {parent: flow, properties: {color: 'red', width: 10}}, cb);
                    JSLibs.clearTimeout(timer);
                }, 10)
            });
        });
        JSLibs.async.series(tasks, function (err, results) {
            if (err) return console.error(err);
            console.log('createObjectAsync parallel success', results.length);
        });
    }

    function parallel() {
        var times = [];
        for (var i = 0; i < 20; i++) times.push(i);

        var tasks = [];
        JSLibs._.each(times, function (index) {
            tasks.push(function (cb) {
                console.log('createObjectAsync parallel index=', index);

                var timer = JSLibs.setTimeout(function () {
                    JSLibs.createObjectAsync(com, {parent: flow, properties: {color: 'red', width: 10}}, cb);
                    JSLibs.clearTimeout(timer);
                }, 200)
            });
        });
        JSLibs.async.parallel(tasks, function (err, results) {
            if (err) return console.error(err);
            console.log('createObjectAsync parallel success', results.length);
        });
    }

    function parallelLimit() {
        var times = [];
        for (var i = 0; i < 20; i++) times.push(i);

        var tasks = [];
        JSLibs._.each(times, function (index) {
            tasks.push(function (cb) {
                console.log('createObjectAsync parallel index=', index);

                var timer = JSLibs.setTimeout(function () {
                    JSLibs.createObjectAsync(com, {parent: flow, properties: {color: 'red', width: 10}}, cb);
                    JSLibs.clearTimeout(timer);
                }, 200)
            });
        });
        JSLibs.async.parallelLimit(tasks, 2, function (err, results) {
            if (err) return console.error(err);
            console.log('createObjectAsync parallel success', results.length);
        });
    }

    function waterfall() {
        JSLibs.async.waterfall([
            function (cb) {
                console.log('createObjectAsync waterfall first');
                JSLibs.createObjectAsync(com, {parent: flow, properties: {color: 'red', width: 10}}, cb);
            },
            function (first, cb) {
                console.log('createObjectAsync waterfall second');
                JSLibs.createObjectAsync(com, {parent: flow, properties: {color: 'green', width: first.width + 10}}, cb);
            },
            function (second, cb) {
                console.log('createObjectAsync waterfall third');
                JSLibs.createObjectAsync(com, {parent: flow, properties: {color: 'blue', width: second.width + 10}}, cb);
            }
        ],
        function (err, third) {
            if (err) return console.error(err);
            console.log('createObjectAsync waterfall success', third.width);
        });
    }

    function auto() {
        JSLibs.async.auto({
            red: function (cb) {
              console.log('createObjectAsync waterfall red');
              JSLibs.createObjectAsync(com, {parent: flow, properties: {color: 'red', width: 10}}, cb);
            },
            green: function (cb) {
              console.log('createObjectAsync waterfall green');
              JSLibs.createObjectAsync(com, {parent: flow, properties: {color: 'green', width: 30}}, cb);
            },
            blue: ['red', 'green', function (cb, results) {
              console.log('createObjectAsync waterfall blue');
              JSLibs.createObjectAsync(com, {parent: flow, properties: {color: 'blue', width: (results.red.width + results.green.width) / 2}}, cb);
            }]
        },
        function (err, results) {
            if (err) return console.error(err);
            var redObj = results.red;
            var greenObj = results.green;
            var blueObj = results.blue;

            console.log('createObjectAsync waterfall success', redObj.width, greenObj.width, blueObj.width);
        });
    }
}
