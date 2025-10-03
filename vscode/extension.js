const vscode = require('vscode');

function hello() {
    vscode.window.showInformationMessage('pyf/hello');
}

async function activate(context) {
    vscode.window.showInformationMessage('pyf/activate');
    context.subscriptions.push(
        vscode.commands.registerCommand('dponyatov.pyf.hello', hello)
    );
}

function deactivate() {
    vscode.window.showInformationMessage('pyf/deactivate');
}

module.exports = {
    activate,
    deactivate,
    hello,
};
