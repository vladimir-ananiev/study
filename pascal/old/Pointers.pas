type
  Item = record
    name: string;
    next,prev: ^Item;
  end;
  
procedure PrintItems(it:^Item);
begin
  while it <> nil do
  begin
    writeln(it^.name);
    it := it^.next;
  end;
end;
  
function AddItem(it:^Item; name:string): ^Item;
begin
  New(it^.next);
  result := it^.next;
  result^.name := name;
end;
  
var
  r: Item;
  list,added: ^Item;
begin
  New(list);
  list^.name := 'Begin';
  added := list;

  for var i:=1 to 10 do
    added := AddItem(added, 'Item'+IntToStr(i));
    
  PrintItems(list);
end.