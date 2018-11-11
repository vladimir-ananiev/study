uses
  GraphABC, Timers, ABCObjects;

var circle2 := new CircleABC(300, 100, 20);
var circle1 := new CircleABC(100, 100, 10);

procedure TimerProc;
begin
  circle1.Move();
  {circle2.Move();}
  if circle1.Center.X>Window.Width then circle1.dx := -circle1.dx
  else if circle1.Center.X<0 then circle1.dx := -circle1.dx;
  if circle1.Center.Y>Window.Height then circle1.dy := -circle1.dy
  else if circle1.Center.Y<0 then circle1.dy := -circle1.dy;
end;

begin
  circle1.dx := 5;
  circle2.dx := 10;
  circle1.dy := 5;
  circle2.dy := 10;
  
  var t := new Timer(10,TimerProc);
  t.Start;
end.