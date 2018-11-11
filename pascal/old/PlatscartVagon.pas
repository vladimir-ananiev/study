{ Номер купе по номеру места}
function RoomBySeat(seat:integer): integer;
begin
  result := 0;
  if (seat < 1) or (seat > 54) then
    exit;
  if seat > 36 then
    result := 9 - ((seat-37) div 2)
  else
    result := ((seat-1) div 4) + 1;
end;

var
  rooms: array[1..9] of integer; { количества свободных мест в купе }
begin
  { Изначально считаем, что во всех купе 0 свободных мест}
  for var i:=1 to 9 do
    rooms[i] := 0;
  
  var N := ReadInteger('Free seat count:');
  
  { Вводим номера свободных мест и считаем сколько их в каком купе}
  for var i:=1 to N do
  begin
    var seat := ReadInteger('Seat number:');
    var room := RoomBySeat(seat);
    if room = 0 then
    begin
      writeln('Wrong seat number. Bye...');
      exit;
    end;
    Inc(rooms[room]);
  end;
  
  { Находим самую длинную последовательность полностью свободных купе } 
  var len := 0; { длина тек. последовательности }
  var maxLen := 0; { максимальная }
  for var i:=1 to 9 do
  begin
    if rooms[i] < 6 then
    begin
      len := 0;
      continue;
    end;
    Inc(len);
    if len > maxLen then
      maxLen := len;
  end;
  
  writeln('Max room length = ', maxLen);
end.