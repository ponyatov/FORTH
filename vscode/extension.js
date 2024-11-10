const vscode = require('vscode');

function hello() {
    vscode.window.showInformationMessage('boss/hello');
}

function repl() {
    vscode.window.showInformationMessage('boss/repl');
}

async function activate(context) {
    console.log(activate, context);
    let hello = vscode.commands.registerCommand('boss.hello', hello);
    context.subscriptions.push(hello);
    let repl = vscode.commands.registerCommand('boss.repl', repl);
    context.subscriptions.push(repl);
}

function deactivate() {
    console.log(deactivate);
}

module.exports = {
    activate,
    deactivate,
    hello,repl
}
