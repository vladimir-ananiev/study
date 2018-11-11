function mul(a,b:integer): int64;
begin
  result := 0;
  var la:int64 := a;
  while b<>0 do
  begin
    if (b and 1) <> 0 then
      Inc(result, la);
    b := b shr 1;
    la := la shl 1;  
  end;
end;

begin

  var m := mul(3,3);

  for var i:=0 to 10 do
  begin
    for var j:=0 to 10 do
      write(mul(i,j):6);
    writeln;
  end;
end.