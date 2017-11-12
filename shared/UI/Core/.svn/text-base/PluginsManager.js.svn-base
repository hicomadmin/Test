.pragma library
Qt.include("../JSLibs/ThreeParts.js")

var allPlugins = {};

function append(name, opts) {
    if (!name) return console.error('Plugin append err, name is invalid.');

    opts = opts || {};
    if (!opts.item) return console.error('Plugin append err, item is invalid.');

    allPlugins[name]= allPlugins[name] || [];

    allPlugins[name].push({item: opts.item}); // TODO 其他需要保存的数据需要后续扩展
}

function remove(name, item) {
    if (!name || !item) return console.error('Plugin remove err, name or item is invalid.');

    allPlugins[name] = allPlugins[name] || [];
    var plugins = allPlugins[name];
    var plugin = _.findWhere(plugins, {item: item});

    if (plugin) {
        allPlugins[name].splice(_.indexOf(plugins, plugin), 1);
        if (plugin.item.destroy) plugin.item.destroy();
    }
}

function clear(name) {
    if (!name) return console.error('Plugin clear err, name or item is invalid.');

    allPlugins[name] = allPlugins[name] || [];

    _.each(allPlugins[name], function (plugin) {
        if (plugin.destroy) plugin.destroy();
    });
    allPlugins[name] = undefined;
}

function findOne(name) {
    if (!name) return console.error('Plugin findOne err, name or item is invalid.');
    allPlugins[name] = allPlugins[name] || [];
    return allPlugins[name][0];
}

function findByItem(name, item) {
    if (!name || !item) return console.error('Plugin findByItem err, name or item is invalid.');

    return _.findWhere(allPlugins[name] || [], {item: item});
}
