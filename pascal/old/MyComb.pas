function DescFact(n,k:integer): integer;
begin
  if n<k then
    result := 0
  else if k=0 then
    result := 1
  else
    result := n * DescFact(n-1,k-1);
end;

{function Fact(n:integer): integer;
begin
  result := DescFact(n,n);
end;}

function A(n,k:integer): integer;
begin
  result := DescFact(n,k);
end;

function P(n:integer): integer;
begin
  result := A(n,n);
end;

function C(n,k:integer): integer;
begin
  result := A(n,k) div P(k);
end;

function CFast(n,k:integer): integer;
begin
  if n < k then
    result := 0
  else if k=0 then
    result := 1
  else
    result := CFast(n-1,k) + CFast(n-1,k-1);
end;

function MessageBox(h: integer; m,c: string; t: integer): integer; 
external 'User32.dll' name 'MessageBox'; 


begin
  write(' k|');
  for var i:=0 to 10 do
    write(i:10);
  writeln;
  writeln(' n|--------------------------------------------------------------------------------------------------------------');
  
  var start := Milliseconds;
  
  for var n:=0 to 10 do
  begin
    write(n:2,'|');
    for var k:=0 to 10 do
    begin
      //write((IntToStr(CFast(n,k)) + '=' + IntToStr(C(n,k))):10);
      var cc := 0;
      for var i:=1 to 1000000 do
        cc := C(n,k);
      write(cc:10);
    end;
    writeln;
  end;
  writeln('-----------------------------------------------------------------------------------------------------------------');

  writeln(Milliseconds-start);

  //MessageBox(0,'Hello!','Сообщение',0);
 
end.