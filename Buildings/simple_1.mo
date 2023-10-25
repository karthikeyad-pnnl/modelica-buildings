within Buildings;

model simple_1
    
    .Modelica.Blocks.Interfaces.RealInput x annotation(Placement(transformation(extent = {{-54,-56},{-14,-16}},origin = {0,0},rotation = 0)));
    .Modelica.Blocks.Interfaces.RealInput u annotation(Placement(transformation(extent = {{-54,-16},{-14,24}},origin = {0,0},rotation = 0)));
    .Modelica.Blocks.Interfaces.RealOutput y annotation(Placement(transformation(extent = {{82,-6},{102,14}},origin = {0,0},rotation = 0)));
    equation
    y = u+x;
    annotation(Icon(coordinateSystem(preserveAspectRatio = false,extent = {{-100.0,-100.0},{100.0,100.0}}),graphics = {Rectangle(lineColor={0,0,0},fillColor={230,230,230},fillPattern=FillPattern.Solid,extent={{-100.0,-100.0},{100.0,100.0}}),Text(lineColor={0,0,255},extent={{-150,150},{150,110}},textString="%name")}));
end simple_1;
