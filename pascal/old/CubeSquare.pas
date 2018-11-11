begin
  var a := ReadInteger;
  var b := ReadInteger;
  var k := ReadInteger;
  var p := 0;

  for var x:=a to b do
  begin
    var x2 := x*x;
    for var y:=a to b do
    begin
      var y3 := y*y*y;
      if ((a<=x2)and(x2<=b)) and ((a<=y3)and(y3<=b)) and (abs(x2-y3)<=k) then
      begin
        writeln('a=', a, ', b=', b);
        Inc(p);
      end;
    end;
  end;
  
  writeln(p);
end.