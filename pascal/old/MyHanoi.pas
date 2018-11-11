var 
arr:array of integer;
arr1:array of integer;
arr2:array of integer;

procedure hanoi(n:integer;var otpr,prin,mesh:array of integer);
begin
  
  var x:=n;
  if n<1 then
    exit;

  hanoi(n-1, otpr,mesh,prin);
  
  setlength(prin,length(prin)+1);
  prin[length(prin)-1] :=otpr[length(otpr)-1];
  setlength(otpr,length(otpr)-1);
 
  writeln(arr);
  writeln(arr1);
  writeln(arr2);
  writeln;
 hanoi(n-1, mesh,prin,otpr);
end;

begin
  setlength(arr1,0);
  setlength(arr2,0);
  var v:=readinteger;setlength(arr,v);
  for var i:= v-1 downto 0 do
 begin
   
   arr[v-1-i]:=i+1;
 end;
  writeln(arr);
  writeln(arr1);
  writeln(arr2);
  writeln;
  hanoi(v,arr,arr1,arr2 );
  
end.