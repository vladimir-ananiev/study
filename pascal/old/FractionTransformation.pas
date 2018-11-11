type
  { Дробь }
  Fraction = record
    num: integer;   { числитель}
    den: integer; { знаменатель }
  end;

{ Считывание дроби с клавиатуры }
function ReadFraction(prompt: string := ''): Fraction;
begin
  if Length(prompt) > 0 then
    write(prompt, ' ');
  result.num := ReadInteger('Numerator:');
  result.den := ReadInteger('Denominator:');
end;

{ Вычисление НОД }
function HighestCommonFactor(a,b: integer): integer;
begin
  if a < b then
    swap(a,b);
  result := b;
  while true do
  begin
    var r := a mod b; { остаток }
    if r = 0 then
      break;
    a := b;
    b := r;
  end;
  result := b;
end;

{ Сокращение дроби }
procedure ReduceFraction(var f: Fraction);
begin
  var hcf := HighestCommonFactor(f.num, f.den);
  f.num := f.num div hcf;
  f.den := f.den div hcf;
end;

procedure HSF_Test;
begin
  while true do
  begin
    var a := ReadInteger;
    if a = 0 then exit;
    var b := ReadInteger;
    if b = 0 then exit;
    writeln(HighestCommonFactor(a,b));
  end;
end;

{ Основная программа }
begin

 

  var f1 := ReadFraction('Fraction 1:');
  var f2 := ReadFraction('Fraction 2:');
  var steps := 0;

  while true do
  begin
    steps:=steps+1;
    f1.num:=f1.num+1; 
    f1.den:=f1.den+1;
    ReduceFraction(f1);
    if f1 = f2 then
    break; 
    if (f1.num > f2.num) and (f1.den > f2.den) and (f1.den-1 = f1.num) then
    begin
      steps:=0;
      break;
    end;
  end;

  writeln('Step count: ', steps);
end.