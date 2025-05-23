grammar Forth

entry Forth: (words+=WORD | numbers+=INT)*;

// Person:
//     'person' name=ID;

// Greeting:
//     'Hello' person=[Person:ID] '!';

hidden terminal WS: /\s+/;
terminal INT returns number: /[+/-]?[0-9]+/;
terminal WORD: /[^ \t\r\n]+/;
// terminal STRING: /"(\\.|[^"\\])*"|'(\\.|[^'\\])*'/;

hidden terminal ML_COMMENT: /\([\s\S]*\)/;
hidden terminal SL_COMMENT: /\\[^\r\n]*/;
hidden terminal SHEBANG   : /#![^\r\n]*/;
