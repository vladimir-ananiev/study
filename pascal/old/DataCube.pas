type
  Point = array of integer;
  DataCube = record
    sizes: array of integer;
    data:  array of real;
    muls:  array of integer;
  end;

function CreateCube(params sizes:array of integer): DataCube;
begin
  var cellCount := 1;
  SetLength(result.sizes, Length(sizes));
  SetLength(result.muls, Length(sizes));
  for var i:=0 to Length(sizes)-1 do
  begin
    result.sizes[i] := sizes[i];
    result.muls[i] := cellCount;
    cellCount := cellCount * sizes[i];
  end;
  SetLength(result.data, cellCount);
end;

function CreateSubCube(const cube:DataCube; const dinIndex,dimCount:integer): DataCube;
begin
  var subCube := CreateCube();
end;

function CreatePoint(params pt: array of integer): Point;
begin
  SetLength(result, Length(pt));
  for var i:=0 to Length(pt)-1 do
    result[i] := pt[i];
end;

function GetCellOffset(const cube:DataCube; const pt:Point): integer;
begin
  result := 0;
  for var i:=0 to Length(pt)-1 do  
    Inc(result, cube.muls[i]*pt[i]);
end;

procedure SetCell(cube:DataCube; const pt:Point; const value:real);
begin
  cube.data[GetCellOffset(cube,pt)] := value;
end;
procedure SetCell(cube:DataCube; value:real);
begin
  SetCell(cube, nil, value);
end;

function GetCell(const cube:DataCube; const pt:Point): real;
begin
  result := cube.data[GetCellOffset(cube,pt)];
end;
function GetCell(const cube:DataCube): real;
begin
  result := GetCell(cube, nil);
end;

procedure PrintCube(const cube:DataCube);
begin
  if Length(cube.sizes) = 0 then
  begin
    writeln(GetCell(cube));
    exit;
  end;
  if Length(cube.sizes) = 1 then
  begin
    writeln(cube.data);
    exit;
  end;
  if Length(cube.sizes) = 2 then
  begin
    for var i1:=0 to cube.sizes[1]-1 do
    begin
      for var i0:=0 to cube.sizes[0]-1 do
        write(GetCell(cube, CreatePoint(i0, i1)):5);
      writeln;
    end;
    exit;
  end;
end;

begin
  var cube0 := CreateCube();
  SetCell(cube0, 99);
  
  var cube1 := CreateCube(10);
  for var i:=0 to 9 do
    SetCell(cube1, CreatePoint(i), i+1);
  
  var cube2 := CreateCube(8, 5);
  for var i1:=0 to 4 do
    for var i0:=0 to 7 do
      SetCell(cube2, CreatePoint(i0, i1), (i0+1)*(i1+1));
      
  PrintCube(cube0);
  PrintCube(cube1);
  PrintCube(cube2);
end.