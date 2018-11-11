function SegmentCount(n:integer): longint;
begin
  result := n;
  if n > 1 then
    result := result + SegmentCount(n-1);
end;

begin
  writeln(SegmentCount(ReadInteger) * SegmentCount(ReadInteger));
end.