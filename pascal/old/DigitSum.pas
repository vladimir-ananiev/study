function DigitSum(number:integer): integer;
begin
  number := abs(number);
  result := 0;
  while number > 0 do
  begin
    Inc(result, number mod 10);
    number := number div 10;
  end;
end;

begin
  writeln((DigitSum(ReadInteger))mod 3 = 0 ? 'yes' : 'no');
end.