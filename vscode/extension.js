const vscode = require('vscode');

function hello() {
    vscode.window.showInformationMessage('FORTH/hello');
}

function repl() {
    vscode.window.showInformationMessage('FORTH/repl');
}

async function activate(context) {
    console.log(activate, context);
    let hello = vscode.commands.registerCommand('FORTH.hello', hello);
    context.subscriptions.push(hello);
    let repl = vscode.commands.registerCommand('FORTH.repl', repl);
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
