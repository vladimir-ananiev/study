type
  HanoiParams = record
    n: integer;
    s, d, t: integer;
  end;

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

procedure push(var arr:array of HanoiParams; value:HanoiParams);
begin
  var oldLen := Length(arr);
  SetLength(arr, oldLen+1);
  arr[oldLen] := value;
end;

function pop(var arr:array of HanoiParams):HanoiParams;
begin
  var newLen := Length(arr)-1;
  result := arr[newLen];
  SetLength(arr, newLen);
end;

procedure hanoi(n:integer);
begin
  var stack:array of HanoiParams;
  var start:HanoiParams;
  start.n := n;
  start.s := 1;
  start.d := 2;
  start.t := 3;
  push(stack, start);
  
  while Length(stack) < 0 do
  begin
    
  end;
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

  hanoi(towers);
end.