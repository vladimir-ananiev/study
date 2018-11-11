type
  { Пара оснований }
  BasePair = record
    pair: string[2]; { пара оснований } 
    count: integer;  { кол-во вхождений пары в геном }
  end;

{ Поиск пары оснований в массиве }
function FindBasePair(pair: string[2]; pairs: array of BasePair): integer;
begin
  for var i:=0 to Length(pairs)-1 do
  begin
    if pairs[i].pair = pair then
    begin
      result := i;
      exit;
    end;
  end;
  result := -1; { возвращаем -1 если пара не найдена }
end;

{ Обработка генома (строки - набора оснований) }
{ Формирование массива пар оснований }
function ProcessGenom(genom: string): array of BasePair;
begin
  SetLength(result, 0);
  var len := Length(genom);
  if len < 2 then
    exit;
  for var i:=1 to len-1 do
  begin
    var pair := Copy(genom, i, 2);
    var index := FindBasePair(pair, result);
    if index = -1 then
    begin
      index := Length(result);
      SetLength(result, index+1);
      result[index].pair := pair;
      result[index].count := 0;
    end;
    Inc(result[index].count);
  end;
end;

{ Основная программа }
begin
  var pairs1 := ProcessGenom(ReadString);
  var pairs2 := ProcessGenom(ReadString);

  writeln(pairs1);
  writeln(pairs2);

  var level := 0; { степень схожести } 
  
  for var i:=0 to Length(pairs1)-1 do
  begin
    if FindBasePair(pairs1[i].pair, pairs2) <> -1 then
      Inc(level, pairs1[i].count);
  end;
  
  writeln(level);
end.