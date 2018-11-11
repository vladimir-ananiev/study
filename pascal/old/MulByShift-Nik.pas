function mul(a, b: integer): int64;
begin
  while b <> 0 do
  begin
    if (b and 1) = 1 then
      Inc(result, a);
    a := a shl 1;
    b := b shr 1;
  end;
end;

begin
  var error := false;
  
  for var i := 0 to 10000 do
  begin
    for var j := 0 to 10000 do
      if mul(i, j) <> (i * j) then
      begin
        error := true;
        writeln('Error at ', i, '*', j);
        exit;
      end;
  end;
  
  if not error then
    writeln('All OK!!!');
end.