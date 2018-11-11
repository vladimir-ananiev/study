begin
  var ml : array[1..12] of integer := (31,28,31,30,31,30,31,31,30,31,30,31);

  var day := ReadInteger('Day:');
  var month := ReadInteger('Month:');  

  while month <= 12 do
  begin
    writeln(day, '.', month);    
    Inc(day, 7);
    if day > ml[month] then
    begin
      Dec(day, ml[month]);
      Inc(month);      
    end;
  end;    
end.