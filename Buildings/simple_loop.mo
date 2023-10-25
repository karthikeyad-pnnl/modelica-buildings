within Buildings;
model simple_loop
    .Modelica.Blocks.Sources.Step step(startTime = 1) annotation(Placement(transformation(extent = {{-32,-30},{-12,-10}},origin = {0,0},rotation = 0)));
    .Buildings.simple simple annotation(Placement(transformation(extent = {{18,-30},{38,-10}},origin = {0,0},rotation = 0)));
equation
    connect(step.y,simple.u) annotation(Line(points = {{-11,-20},{6.800000000000001,-20},{6.800000000000001,-19.6},{24.6,-19.6}},color = {0,0,127}));
    annotation(Icon(coordinateSystem(preserveAspectRatio = false,extent = {{-100.0,-100.0},{100.0,100.0}}),graphics = {Rectangle(lineColor={0,0,0},fillColor={230,230,230},fillPattern=FillPattern.Solid,extent={{-100.0,-100.0},{100.0,100.0}}),Text(lineColor={0,0,255},extent={{-150,150},{150,110}},textString="%name")}));
end simple_loop;
