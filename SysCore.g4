// SysCore.g4

// !!! This is a PARSER
// also discarded
grammar SysCore;

// Keywords
CLASS: 'class';
FUNC: 'func';
VAR: 'var';
TYPE: 'type';
IMPORT: 'import';
PACKAGE: 'package';
LAMBDA: '=>';
IF: 'if';
THEN: 'then';
ELSE: 'else';
WHILE: 'while';
DO: 'do';

// Literals
INT_LITERAL: [0-9]+;
STRING_LITERAL: '"' (~["\r\n] | '\\' ["\r\n])* '"';
IDENTIFIER: [a-zA-Z_][a-zA-Z_0-9]*;

// Whitespace and comments
WS: [ \t\r\n]+ -> skip;
COMMENT: '//' ~[\r\n]* -> skip;
BLOCK_COMMENT: '/*'.*? '*/' -> skip;

// Program structure
program: (importStatement | packageStatement | classDefinition)*;

importStatement: IMPORT IDENTIFIER ';';
packageStatement: PACKAGE IDENTIFIER ';';
classDefinition: CLASS IDENTIFIER '{' (funcDefinition | varDefinition)* '}';

funcDefinition: FUNC IDENTIFIER '(' parameterList ')' (':' type)? block;
varDefinition: VAR IDENTIFIER ':' type ('=' expression)? ';';
parameterList: (IDENTIFIER ':' type (',' IDENTIFIER ':' type)*)?;
type: IDENTIFIER | 'int' | 'string';
block: '{' statement* '}';
statement: expression ';' | ifStatement | whileStatement | funcCall | assignStatement;
expression: term ((ADD | SUB) term)*;
term: factor ((MUL | DIV) factor)*;
factor: IDENTIFIER | INT_LITERAL | STRING_LITERAL | lambdaExpression | '(' expression ')' | funcCall;
ADD: '+';
SUB: '-';
MUL: '*';
DIV: '/';

ifStatement: IF expression THEN block (ELSE block)?;
whileStatement: WHILE expression DO block;
funcCall: IDENTIFIER '(' (expression (',' expression)*)? ')' ';';
assignStatement: IDENTIFIER LAMBDA '(' (IDENTIFIER ':' type (',' IDENTIFIER ':' type)*)? ')' block ';';
lambdaExpression: '(' (IDENTIFIER ':' type (',' IDENTIFIER ':' type)*)? ')' block;

// Type inference and explicit type annotations
typeAnnotation: ':' type;

// System administration-specific features
processManagement: 'process' IDENTIFIER '.' IDENTIFIER '(' (expression (',' expression)*)? ')' ';';
fileIO: 'file' IDENTIFIER '.' (('read' | 'write') STRING_LITERAL) '(' (expression)? ')' ';';

// Additional functional programming features
map: 'map' '(' IDENTIFIER '(' (IDENTIFIER ':' type (',' IDENTIFIER ':' type)*)? ')' block ')' ';';
filter: 'filter' '(' IDENTIFIER '(' (IDENTIFIER ':' type (',' IDENTIFIER ':' type)*)? ')' block ')' ';';
reduce: 'reduce' '(' IDENTIFIER '(' (IDENTIFIER ':' type (',' IDENTIFIER ':' type)*)? ')' block ')' ';';
