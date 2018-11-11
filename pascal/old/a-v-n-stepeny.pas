var
  mulCount: integer := 0;

function mul(a, b: real): real;
begin
  if (a=0) or (b=0) then
    result := 0
  else if a = 1 then
    result := b
  else if b = 1 then
    result := a
  else
  begin
    result := a * b;
    Inc(mulCount);
  end;
end;

function pow_simple(a: real; n: integer): real;
begin
  result := 1;
  while n > 0 do
  begin
    result := mul(result, a);
    Dec(n);
  end;
end;

function pow_opt(a: real; n: integer): real;
begin
  if n = 0 then
    result := 1
  else if n = 1 then
    result := a
  else
  begin
    var n1 := n div 2;
    var pow1 := pow_opt(a, n1);
    result := mul(pow1,pow1);
    var n2 := n - n1;
    if n1 <> n2 then
      result := mul(result,a);
  end;
end;

begin
  var a := 2;
  while true do
  begin
    var n := ReadInteger('n=');
    mulCount := 0;
    writeln('pow_simple = ', pow_simple(a,n), '. Mul Count = ', mulCount);
    mulCount := 0;
    writeln('pow_opt = ', pow_opt(a,n), '. Mul Count = ', mulCount);
  end;
end.