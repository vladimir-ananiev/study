begin
  var A := ReadInteger('A:');
  var B := ReadInteger('B:');
  var C := ReadInteger('C:');
  var N := ReadInteger('N:');
  
  var z := (N+B+A-3*C) div 4;
  var y := (C+z) - B;
  var x := 2*(C+z) - A;
  
  if (x<1) or (y<1) or (z<1) or ((x+y+z)>N) then
    writeln('0')
  else
  begin
    writeln(x);
    writeln(y);
    writeln(z);
  end;
end.