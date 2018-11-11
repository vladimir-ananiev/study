function fiveMin(a,b,c:integer): integer;
begin
  var f := a + b/3 - c/3;
  result := Trunc(f);
  if Int(f) < f then
    Inc(result);
end;

begin
  writeln(fiveMin(ReadInteger,ReadInteger,ReadInteger))
end.