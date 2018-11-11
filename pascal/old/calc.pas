var
  stack: array of string;
function empty(): boolean;
begin
  result := Length(stack) = 0;
end;
procedure push(const t:string);
begin
  var oldLlen := Length(stack);
  SetLength(stack, oldLlen+1);
  stack[oldLlen] := t;
end;
function peek(): string;
begin
  result := stack[Length(stack)-1];
end;
function pop(): string;
begin
  var newLen := Length(stack) - 1;
  result := stack[newLen];
  SetLength(stack, newLen);
end;

function tryParseReal(const s:string; var r:real): boolean;
begin
  result := real.TryParse(s.Replace('.',','),r);
end;

function isDigDec(c:char): boolean;
begin
  var chars := '0123456789.';
  result := Pos(string(c), chars) <> 0;
end;
function isNumber(const s:string): boolean;
begin
  var r: real;
  result := tryParseReal(s, r);
end;
function isLAO(const o:string): boolean; { left associative operator }
begin
  result := Pos(o,'+-*/') <> 0;
end;
function isRAO(const o:string): boolean; { right associative operator }
begin
  result := Pos(o,'^') <> 0;
end;
function isOperator(const t:string): boolean;
begin
  result := isLAO(t) or isRAO(t);
end;
function precedence(const t:string): integer;
begin
  if (t='+') or (t='-') then
    result := 100
  else if (t='*') or (t='/') then
    result := 200
  else if (t='^') then
    result := 300
  else
    result := 0;
end;

procedure append(var a:array of string; const s:string);
begin
  var len := Length(a);
  SetLength(a, len+1);
    a[len] := s;
end;
procedure append(var a1:array of string; a2:array of string);
begin
  var len1 := Length(a1);
  var len2 := Length(a2);
  SetLength(a1, len1+len2);
  for var i:=0 to len2-1 do
    a1[len1+i] := a2[i];
end;

function parseOperator(const t:string):array of string;
begin
  var tPrec := precedence(t);
  while (not empty) and ((precedence(peek)>tPrec) or ((precedence(peek)=tPrec)and isLAO(peek))) do
      append(result,pop);
  push(t);
end;

function parseClosure():array of string;
begin
  while (not empty) and (peek <> '(') do
    append(result,pop);
  pop;
end;

function parse(const expr:string): array of string;
begin
  var i := 1;
  while i <= Length(expr) do
  begin
    var number: string;
    while (i<=Length(expr)) and isDigDec(expr[i]) do
    begin
      number := number + expr[i];
      Inc(i);
    end;
    if number <> '' then
    begin
      if isNumber(number) then
        append(result, number);
    end
    else
    begin
      if isOperator(expr[i]) then
        append(result, parseOperator(expr[i]))
      else if expr[i] = '(' then
        push(expr[i])
      else if expr[i] = ')' then
        append(result, parseClosure);
      Inc(i);
    end;
  end;
  while not empty do
    append(result, pop);
end;

var
  nstack: array of real;
procedure npush(const n:real);
begin
  var oldLlen := Length(nstack);
  SetLength(nstack, oldLlen+1);
  nstack[oldLlen] := n;
end;
function npeek(): real;
begin
  result := nstack[Length(nstack)-1];
end;
function npop(): real;
begin
  var newLen := Length(nstack) - 1;
  result := nstack[newLen];
  SetLength(nstack, newLen);
end;

function run(const postfix:array of string): real;
begin
  var i := 0;
  while i < Length(postfix) do
  begin
    var t := postfix[i];
    Inc(i);
    var number:real;
    if tryParseReal(t,number) then
      npush(number)
    else if isOperator(t) then
    begin
      var n2 := npop;
      var n1 := npop;
      if t = '+' then
        number := n1 + n2
      else if t = '-' then
        number := n1 - n2
      else if t = '*' then
        number := n1 * n2
      else if t = '/' then
        number := n1 / n2
      else if t = '^' then
        number := n1 ** n2;
      npush(number);
    end;
  end;
  result := npop;
end;

procedure test(const expr:string; const resexp:real);
begin
  //writeln(expr);
  var res := run(parse(expr));
  write(expr, ' = ', res, ': ');
  if res = resexp then
    writeln('OK')
  else
    writeln('Fail, expected: ' +resexp);
end;

procedure tests();
begin
  test('1', 1);
  test('1.3', 1.3);
  test('123.321', 123.321);

  test('1 - 2.5', -1.5);
  test('0 - 5.2', -5.2);
  test('1024 + 1977.204', 3001.204);
  
  
end;

begin
  tests;
  while true do
  begin
    var expr := ReadString;
    if Length(expr) = 0 then
      exit;
    var postfix := parse(expr);
    //writeln(postfix);
    writeln(run(postfix));
  end;
end.