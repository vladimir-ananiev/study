var
  k:integer;
function Gorshock(a,n:integer):integer;
begin
  if n = 1 then
  result:=a
  else 
  begin
    var n1:=n div 2;
    var n2:=n-n1;
    result:=Gorshock(a,n1);
    result:=result*result;inc(k);
    if n1<>n2 then 
    begin
    result:=result*a;inc(k);
    end;
  end;
end;
begin
  var n,a:integer;
  readln(a,n);
  writeln(Gorshock(a,n));
  writeln(k);
end.