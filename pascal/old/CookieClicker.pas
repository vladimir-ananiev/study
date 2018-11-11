begin
  var C := ReadInteger('C:');
  var P := ReadInteger('P:');
  var N := ReadInteger('N:');
  
  var time := 0;
  var cookieCount := 0;
  var factoryCount := 0;
  
  while cookieCount < N do
  begin
    Inc(time);
    Inc(cookieCount, 1 + factoryCount*P);
    writeln('time=', time, ', cookieCount=', cookieCount);
    
    if cookieCount >= C then
    begin
      var timeLeftIfDontBuy := (N - cookieCount) div (1 + factoryCount*P);
      var timeLeftIfBuy := (N - (cookieCount-C)) div (1 + (factoryCount+1)*P);
      
      if timeLeftIfBuy < timeLeftIfDontBuy then
      begin
        Inc(factoryCount);
        Dec(cookieCount, C);
        writeln('factoryCount=', factoryCount, ', cookieCount=', cookieCount);
      end;
    end;
  end;
  writeln;  
  writeln(time);  
  writeln(factoryCount);  
end.
