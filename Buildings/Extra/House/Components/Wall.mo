within Buildings.Extra.House.Components;

model Wall
  "Wall structure with thermal conductance, heat capacity and convection"

  parameter .Modelica.SIunits.ThermalConductance G_wall
    "Thermal conductance in wall";
  parameter .Modelica.SIunits.ThermalConductance Gc_wall
    "Convective thermal conductance wall/air";
  parameter .Modelica.SIunits.HeatCapacity C_wall
    "Heat capacity in wall";

  .Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a outside
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  .Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b inside
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  .Modelica.Thermal.HeatTransfer.Components.Convection wallsAirConv
    annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=0,
        origin={32,0})));
  .Modelica.Blocks.Sources.RealExpression realExpression(y=Gc_wall)
    annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=0,
        origin={22,20})));
  LayeredWall wall(
    G_wall1=G_wall,
    G_wall2=G_wall,
    C_wall=C_wall)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
equation
  connect(realExpression.y, wallsAirConv.Gc) annotation (Line(
      points={{26.4,20},{32,20},{32,8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(wallsAirConv.fluid, inside) annotation (Line(
      points={{40,0},{70,0},{70,0},{100,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(outside, wall.port_a) annotation (Line(
      points={{-100,0},{-59.8,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(wall.port_b, wallsAirConv.solid) annotation (Line(
      points={{-40,0},{24,0}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (Diagram(graphics), Icon(graphics={Rectangle(
                  extent={{-80,60},{60,-80}},
                  lineColor={0,0,0},
                  fillPattern=FillPattern.Forward,
                  fillColor={215,215,215}),Polygon(
                  points={{-60,80},{-80,60},{60,60},{80,80},{-60,80}},
                  lineColor={0,0,0},
                  smooth=Smooth.None,
                  fillColor={175,175,175},
                  fillPattern=FillPattern.Forward),Polygon(
                  points={{80,-60},{60,-80},{60,60},{80,80},{80,-60}},
                  lineColor={0,0,0},
                  smooth=Smooth.None,
                  fillColor={175,175,175},
                  fillPattern=FillPattern.Forward),Text(
                  extent={{-108,22},{92,-26}},
                  lineColor={0,0,0},
                  lineThickness=1,
                  fillColor={175,175,175},
                  fillPattern=FillPattern.Solid,
                  textString="%name"),Polygon(
                  points={{-74,66},{-80,60},{60,60},{66,66},{-74,66}},
                  lineColor={0,0,0},
                  smooth=Smooth.None,
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Forward),Polygon(
                  points={{66,-74},{60,-80},{60,60},{66,66},{66,-74}},
                  lineColor={0,0,0},
                  smooth=Smooth.None,
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Forward),Polygon(
                  points={{-60,80},{-66,74},{74,74},{80,80},{-60,80}},
                  lineColor={0,0,0},
                  smooth=Smooth.None,
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Forward),Polygon(
                  points={{80,-60},{74,-66},{74,74},{80,80},{80,-60}},
                  lineColor={0,0,0},
                  smooth=Smooth.None,
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Forward)}));
end Wall;
