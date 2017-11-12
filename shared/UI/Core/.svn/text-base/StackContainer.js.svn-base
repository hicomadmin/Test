var stack = [];
var cacheStack = {};

function push(item) {
    if (!item) return console.error('StackContainer push err, invalid item.');
    stack.push(item);
    return item;
}

function pop() {
    if (stack.length <= 0) return console.error('StackContainer pop err, empty stack.');
    return stackView.pop();
}

function current() {
    if (stack.length <= 0) return console.error('StackContainer pop err, empty stack.');
    return stack[stack.length - 1];
}

/* BEGIN by Zhang Yi, 2016.12.01
 * Add this logic for keeping elements which need to be upper than the inEl.
*/
function insert(item, index) {
    if (!item) return console.error('StackContainer insert err, invalid item.');
    stack.splice(stack.length - index, 0, item);
    return item;
}

function removeAfterIndex(index, keep) {
    keep = keep || 0
    return stack.splice(index, stack.length - index - keep);
}
/* END - by Zhang Yi, 2016.12.01 */

function removeStack(deletePos, deleteCount) {
    return stack.splice(deletePos, deleteCount);
}
