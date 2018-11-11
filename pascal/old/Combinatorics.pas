function factorial(a: integer): integer;
begin
  result := 1;
  for var i := 1 to a do
    result := result * (i);
end;
function Desfac(n,k:integer):integer;
begin
  result := 1;
  for var i:= 0 to k-1 do
  begin
    result:= result*(n-i);
  end;
end;
function P(n: integer): integer;
begin
  result := factorial(n);
end;

function A(n, k: integer): integer;
begin
  result := Desfac(n,k);
end;

function C(n,k:integer):integer;
begin
  result:= (factorial(n)) div (factorial(n - k) * FACTORIAL(k));
end;
function Cfast(n,k:integer):integer;
begin
  if k = 0 then
  result:=1
  else if n < k then
  result:=0
  else result := Cfast(n-1,k-1)+Cfast(n-1,k);
end;
begin
  write(' k|');
  for var i := 0 to 10 do
    write(i:10);
  writeln;
  writeln(' n|--------------------------------------------------------------------------------------------------------------');
  for var n := 0 to 10 do
  begin
    write(n:2, '|');
    for var k := 0 to 10 do
    begin
      write(Cfast(n, k):10);
    end;
    writeln;
  end;
  writeln('-----------------------------------------------------------------------------------------------------------------');
end.