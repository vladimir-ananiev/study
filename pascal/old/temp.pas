const
  abet = 'ABCDEFGHIGKLMNOPQRSTUVWXYZ';

function func(n:integer):string;
begin
  result := abet[n];
  if n > 1 then
  begin
    var half := func(n-1);
    result := result + half + half;
  end
end;

function func2(n:integer):string;
begin
  result := '';
  for var i:=1 to n do
    result := abet[i] + result + result;
end;

begin
  for var i:=1 to 8 do
  begin
    var s1 := func(i);
    writeln(s1);
    var s2 := func2(i);
    writeln(s2);
  end;
  //writeln(s[1],s[5],s[95],s[242],s[255]);
end.