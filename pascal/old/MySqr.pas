function MySqrt(x:real; y:real:=0.001): real;
begin
  if x < 0 then
    exit;
  var sign := 0;
  var result := x;
  while abs(x - result*result) > y do
  begin
    if result*result < x then
    begin
      var d := 
      sign = 1;
    end
    else
    begin
      sign = -1;
    end;
  end;
end;

begin
  while true do
    writeln(MySqrt(ReadReal));
end.