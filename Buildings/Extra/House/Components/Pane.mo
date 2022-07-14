within Buildings.Extra.House.Components;

model Pane
  parameter Real a0 = 0.75 "Efficiency when operating at ambient temperature" annotation(
    Dialog(group = "Efficiency"));
  parameter Real a1 = 4.4 "Linear loss factor" annotation(
    Dialog(group = "Temperature-dependent losses"));
  parameter Real a2 = 0.004 "Quadratic loss factor" annotation(
    Dialog(group = "Temperature-dependent losses"));
  parameter .Modelica.SIunits.Area A "Area of the collector" annotation(
    Dialog(group = "Geometry"));
  Real eff "Collector efficiency";
  Real F "Angle incidence factor";
  Real G_aux "Variable used to avoid G=0";
  .Modelica.Blocks.Interfaces.RealInput G "Global radiation incident" annotation(
    Placement(transformation(extent = {{-120, 30}, {-100, 50}})));
  .Modelica.Blocks.Interfaces.RealInput theta "Angle of incidence" annotation(
    Placement(transformation(extent = {{-120, -50}, {-100, -30}})));
  .Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b "Heat port" annotation(
    Placement(transformation(extent = {{90, -10}, {110, 10}})));
  .Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a "Heat port on outer side of the window" annotation(
    Placement(transformation(extent = {{-114, -10}, {-94, 10}})));
equation
  port_a.Q_flow = -port_b.Q_flow;
  port_b.Q_flow = -eff * A * G "Heat flow generation";
  G_aux = if abs(G) < .Modelica.Constants.eps then .Modelica.Constants.eps else G;
  eff = F * (a0 - a1 * (port_b.T - port_a.T) / G_aux - a2 * (port_b.T - port_a.T) ^ 2 / G_aux);
  F = if theta > 84.4 then 0.0 else 1 - 0.108 * (1 / cos(theta / 360 * 2 * .Modelica.Constants.pi) - 1);
  annotation(
    Diagram(graphics),
    Icon(graphics = {Ellipse(extent = {{-80, 30}, {140, -190}}, pattern = LinePattern.None, fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid, startAngle = DynamicSelect(145, 180 - theta), endAngle = 180, lineColor = {0, 0, 0}), Polygon(points = {{-40, -24}, {-46, -32}, {16, -72}, {6, -76}, {32, -80}, {16, -54}, {18, -68}, {-40, -24}}, smooth = Smooth.None, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, pattern = LinePattern.None), Polygon(points = {{-40, 36}, {-46, 28}, {16, -12}, {6, -16}, {32, -20}, {16, 6}, {18, -8}, {-40, 36}}, smooth = Smooth.None, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, pattern = LinePattern.None), Polygon(points = {{-40, 96}, {-46, 88}, {16, 48}, {6, 44}, {32, 40}, {16, 66}, {18, 52}, {-40, 96}}, smooth = Smooth.None, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, pattern = LinePattern.None), Polygon(points = {{40, 12}, {40, -12}, {60, -12}, {60, -20}, {90, 0}, {60, 20}, {60, 12}, {40, 12}}, smooth = Smooth.None, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, pattern = LinePattern.None), Rectangle(extent = {{34, 90}, {40, -90}}, pattern = LinePattern.None, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid), Line(points = {{32, -80}, {-60, -18}}, color = {0, 0, 0}, smooth = Smooth.None), Line(points = {{32, -80}, {-80, -80}}, color = {0, 0, 0}, smooth = Smooth.None), Line(points = {{-80, -80}, {-76, -46}, {-60, -18}}, color = {0, 0, 0}, smooth = Smooth.Bezier, arrow = {Arrow.None, Arrow.Filled}), Line(points = {{-100, -40}, {-74, -48}}, color = {0, 0, 0}, smooth = Smooth.Bezier), Line(points = {{32, 40}, {-42, 92}}, color = {0, 0, 0}, smooth = Smooth.Bezier, arrow = {Arrow.Filled, Arrow.Filled}), Line(points = {{-100, 40}, {-8, 68}}, color = {0, 0, 0}, smooth = Smooth.Bezier)}),
    Documentation(info = "<html>
<p>Model of a solar collector with efficiency and losses. </p>
<p>The model takes the incidence and the incident angle as inputs. </p>
<p>Efficiency is modelled depending on incident angle.</p>
<p>The losses are dependent on the ambient temperature difference with a linear and a quadratic term.</p>
<p><img src=\"modelica://CourseExamples/images/solar_collector.gif\"/></p>
</html>"));
end Pane;
