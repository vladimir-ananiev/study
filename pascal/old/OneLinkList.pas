type
  ListItem = record
    name: string;
    next: ^ListItem;
  end;

procedure CreateListItem(var list:^ListItem; const name:string);
begin
  New(list);
  list^.name := name;
end;

procedure AddListItem(var list:^ListItem; const name:string);
begin
  var next := list^.next;
  CreateListItem(list^.next, name);
  list := list^.next;
  list^.next := next;
end;

procedure InsertListItem(var list:^ListItem; const name:string);
begin
  var next := list;
  CreateListItem(list, name);
  list^.next := next;
end;

function Length(list:^ListItem): integer;
begin
  while list <> nil do
  begin
    Inc(result);
    list := list^.next;
  end;
end;
  
begin
  var list: ^ListItem;
  
  CreateListItem(list, 'First');
  var first := list;
  AddListItem(list, 'Second');
  AddListItem(list, 'Third');
  AddListItem(list, 'Fourh');
  list := first;
  AddListItem(list, 'First.5');
  InsertListItem(first, 'Zero');

  list := first; 
  while list <> nil do
  begin
    writeln(list^.name);
    list := list^.next;
  end;
  
  writeln('Len = ', Length(first));
end.