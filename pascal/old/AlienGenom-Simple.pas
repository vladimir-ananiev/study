begin
  var genom1 := ReadString;
  var genom2 := ReadString;
  var level := 0; { степень схожести } 
  
  for var i:=1 to Length(genom1)-1 do
  begin
    var pair := Copy(genom1, i, 2); { очередная пара символов из стрки genom1 }
    if Pos(pair, genom2) <> 0 then  { функция Pos ищет строку pair в строке genom2 } 
      Inc(level);
  end;
  
  writeln(level);
end.