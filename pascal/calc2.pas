type
  TLexemKind = (LexNone, LexNumber, LexOperation, LexFunction);
  TOperation = (OpNone, OpAdd, OpSub, OpMul, OpDiv, OpOpen, OpClose);
  TNumber = real;
  TLexem = record
    kind: TLexemKind;
    text: string;
    number: TNumber;
    operation: TOperation;
  end;
  TLexemArray = array of TLexem;

var
  numberChars: set of char;
  operationChars : set of char;
  functionChars : set of char;
  lexemStack: TLexemArray;

function isNumberChar(c: char) := c in numberChars;
function isOperationChar(c: char) := c in operationChars;
function isFunctionChar(c: char) := c in functionChars;
function numberFromString(str:string) := real.Parse(str.Replace('.',','));

procedure initCharSets;
begin
  numberChars    := ['0','1','2','3','4','5','6','7','8','9','.'];
  operationChars := ['+','-','*','/','(',')'];
  functionChars  := ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'];
end;

procedure addLexem(var lexems:TLexemArray; const lexem:TLexem);
begin
  var oldLen := Length(lexems);
  SetLength(lexems, oldLen + 1);
  lexems[oldLen] := lexem;
end;

{ --------------------------------- }
{ Lexem stack                       }
{ --------------------------------- }
function peekLexem := lexemStack[Length(lexemStack) - 1];
function isStackEmpty := Length(lexemStack) = 0;
procedure pushLexem(const lexem: TLexem) := addLexem(lexemStack, lexem);
function popLexem: TLexem;
begin
  var newLen := Length(lexemStack) - 1;
  result := lexemStack[newLen];
  SetLength(lexemStack, newLen);
end;
procedure pushNumber(const number:TNumber);
begin
  var lexem: TLexem;
  lexem.kind := LexNumber;
  lexem.number := number;
  lexem.operation := OpNone;
  pushLexem(lexem);
end;

function operationPriority(const lexem: TLexem): integer;
begin
  case lexem.operation of
    OpAdd, OpSub:
      result := 1;
    OpMul, OpDiv:
      result := 2;
    else
      result := 0;
  end;
end;

function charLexemKind(c: char): TLexemKind;
begin
  if isNumberChar(c) then
    result := LexNumber
  else if isOperationChar(c) then
    result := LexOperation
  else if isFunctionChar(c) then
    result := LexFunction
  else
    result := LexNone;
end;

function operationFromString(str:string): TOperation;
begin
  case str[1] of
    '+': result := OpAdd;
    '-': result := OpSub;
    '*': result := OpMul;
    '/': result := OpDiv;
    '(': result := OpOpen;
    ')': result := OpClose;
    else result := OpNone;
  end;
end;

procedure saveLexem(var lexems:TLexemArray; lexem:TLexem);
begin
  if lexem.kind = LexNumber then
    lexems.number := numberFromString(lexem.text)
  else if lexem.kind = LexOperation then
    lexems.operation := operationFromString(lexem.text);
  addLexem(lexems, lexem);
end;

function extractLexems(expression: string): TLexemArray;
var
  currentLexem: TLexem;
begin
  var expr := expression + ' ';
  currentLexem.kind := LexNone;
  var i := 1;
  while i <= Length(expr) do
  begin
    var c := expr[i];
    var cLexKind := charLexemKind(c);
    var newLexem := (cLexKind <> currentLexem.kind) or ((cLexKind <> LexNumber) and (cLexKind <> LexFunction));
    if newLexem then
    begin
      if currentLexem.kind <> LexNone then
        saveLexem(result, currentLexem);
      currentLexem.kind := cLexKind;
      currentLexem.text := string(c);
    end
    else
    begin
      if cLexKind <> LexNone then
        currentLexem.text := currentLexem.text + c;
    end;
    Inc(i);
  end;
end;

function buildPostfixForm(lexems:TLexemArray): TLexemArray;
begin
  var i := 0;
  while i < Length(lexems) do
  begin
    var lexem := lexems[i];   
    if lexem.kind = LexNumber then
      addLexem(result, lexem)
    else if lexem.kind = LexOperation then
    begin
      case lexem.operation of
        OpOpen:
          pushLexem(lexem);
        OpClose:
        begin
          while (not isStackEmpty) and (peekLexem.operation <> OpOpen) do
            addLexem(result, popLexem);
          popLexem
        end
        else
        begin
          while (not isStackEmpty) and (operationPriority(lexem) <= operationPriority(peekLexem)) and (peekLexem.operation <> OpOpen) do
            addLexem(result, popLexem);
          pushLexem(lexem);
        end
      end
    end;
    Inc(i); 
  end;
  while not isStackEmpty do
    addLexem(result, popLexem);
end;

function calculate(lexems:TLexemArray): TNumber;
begin
  for var i:=0 to Length(lexems)-1 do
  begin
    if lexems[i].kind = LexNumber then
      pushNumber(lexems[i].number)
    else 
    begin
      var b := popLexem;
      var a := popLexem;
      case lexems[i].operation of
        OpAdd: pushNumber(a.number + b.number);
        OpSub: pushNumber(a.number - b.number);
        OpMul: pushNumber(a.number * b.number);
        OpDiv: pushNumber(a.number / b.number);
      end;
    end; 
  end;
  result := popLexem.number;
end;


begin
  initCharSets;
  while true do
  begin
    var expr := ReadString;
    if expr.Length = 0 then
      break;
    var lexems := extractLexems(expr);
    var postfixForm := buildPostfixForm(lexems);
    writeln(lexems);
    writeln;
    writeln(postfixForm);
    writeln;
    writeln(calculate(postfixForm));
  end;
end.














