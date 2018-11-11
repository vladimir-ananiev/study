var spaces: array of integer;
function GetMaxAndSplit: integer;
begin
  var spacesLen := Length(spaces);
  var maxInd := 0;
  for var i:=0 to spacesLen-1 do
    if spaces[i] > spaces[maxInd] then
      maxInd := i;
  result := spaces[maxInd];
  var part1 := (result-1) div 2;
  var part2 := (result-1) - part1; { part2 будет больше на 1 или равно part1 }
  spaces[maxInd] := part2;
  if part2 = 0 then
    exit;
  if part1 = 0 then
    exit;
  SetLength(spaces, spacesLen+1);
  spaces[spacesLen] := part1;
end;

begin
  var N := ReadInteger('Free seat count: ');
  var K := ReadInteger('Pupil count: ');
  if K > N then
  begin
    writeln('Too many pupils:), bye...');
    exit;
  end;
  
  var space1, space2: integer;
  SetLength(spaces, 1);
  spaces[0] := N;
  
  for var i:=1 to K do
  begin
    var maxSpace := GetMaxAndSplit;
    Dec(maxSpace); { очередной школьник занимает место }
    space1 := maxSpace div 2;
    space2 := maxSpace - space1;
    write(i,'. ', maxSpace, ' -> ', space1, '+', space2, ' -> ');
    {if space2 = 0 then
      break;}
    writeln(spaces);
  end;
  writeln(space1);
  writeln(space2);
end.