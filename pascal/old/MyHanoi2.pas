var
  step:integer:=0;
  
procedure DrawTowers(towers:array of array of integer);
begin
  writeln('Step ', step, ':');
  var maxLen := 0;
  for var i:=0 to Length(towers)-1 do
    if Length(towers[i]) > maxLen then
      maxLen := Length(towers[i]);
      
  for var i:=maxLen-1 downto 0 do
  begin
    write('|');
    for var j:=0 to Length(towers)-1 do
      if i < Length(towers[j]) then      
        write(towers[j][i]:3, '|')
      else
        write(' |':4);
    writeln;
  end;
  writeln('-------------');
end;

procedure PrintTowers(towers:array of array of integer);
begin
  DrawTowers(towers);
  Inc(step);
  exit;
  for var i:=0 to Length(towers)-1 do
    writeln(towers[i]);
  writeln;
end;

procedure push(var arr:array of integer; value:integer);
begin
  var oldLen := Length(arr);
  SetLength(arr, oldLen+1);
  arr[oldLen] := value;
end;

function pop(var arr:array of integer):integer;
begin
  var newLen := Length(arr)-1;
  result := arr[newLen];
  SetLength(arr, newLen);
end;

procedure hanoi(towers: array of array of integer; n,s,d,t:integer);
begin
  if n<1 then
    exit;

  hanoi(towers, n-1, s,t,d);

  push(towers[d], pop(towers[s]));  

  PrintTowers(towers);

  hanoi(towers, n-1, t,d,s);
end;

begin
  var t := 3;
  var n := 10;
  var towers: array of array of integer;
  
  SetLength(towers, t);
  for var i:=1 to t-1 do
    SetLength(towers[i], 0);

  SetLength(towers[0], n);
  for var i:=0 to n-1 do
    towers[0][i] := n-i;

  PrintTowers(towers);

  hanoi(towers, n, 0, 1, 2);
end.