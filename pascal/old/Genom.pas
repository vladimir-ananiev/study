type
  GenBase = record
    base: string[2]; { основание (пара генов) } 
    count: integer;  { кол-во вхождений основания в геном }
  end;

{ Поиск основания в массиве }
function FindBase(base: string[2]; genBases: array of GenBase): integer;
begin
  for var i:=0 to Length(genBases)-1 do
  begin
    if genBases[i].base = base then
    begin
      result := i;
      exit;
    end;
  end;
  result := -1; 
end;

{ Обработка генома (строки - набора генов) }
{ Формирование массива GenBase }
function ProcessGenom(genom: string): array of GenBase;
begin
  SetLength(result, 0);
  var len := Length(genom);
  if len < 2 then
    exit;
  for var i:=1 to len-1 do
  begin
    var base := Copy(genom, i, 2);
    var index := FindBase(base, result);
    if index = -1 then
    begin
      index := Length(result);
      SetLength(result, index+1);
      result[index].base := base;
      result[index].count := 0;
    end;
    Inc(result[index].count);
  end;
end;

  
begin
  var genomBases1 := ProcessGenom(ReadString);
  var genomBases2 := ProcessGenom(ReadString);

  writeln(genomBases1);
  writeln(genomBases2);

  var level := 0; { степень схожести } 
  
  for var i:=0 to Length(genomBases1)-1 do
  begin
    if FindBase(genomBases1[i].base, genomBases2) <> -1 then
      Inc(level, genomBases1[i].count);
  end;
  
  writeln(level);
end.