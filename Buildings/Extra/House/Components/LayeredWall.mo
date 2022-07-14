within Buildings.Extra.House.Components;

model LayeredWall

  parameter .Modelica.SIunits.ThermalConductance G_wall1
    "Thermal conductance of wall 1";
  parameter .Modelica.SIunits.ThermalConductance G_wall2
    "Thermal conductance of wall 2";
  parameter .Modelica.SIunits.HeatCapacity C_wall "Heat capacity";

  .Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
    annotation (Placement(transformation(extent={{-108,-10},{-88,10}})));
  .Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  .Modelica.Thermal.HeatTransfer.Components.ThermalConductor layer1(G=
        G_wall1)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  .Modelica.Thermal.HeatTransfer.Components.ThermalConductor layer2(G=
        G_wall2)
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  .Modelica.Thermal.HeatTransfer.Components.HeatCapacitor
    wallHeatCapacity(C=C_wall)
    annotation (Placement(transformation(extent={{-10,0},{10,20}})));
equation
  connect(port_a, layer1.port_a) annotation (Line(
      points={{-98,0},{-60,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(layer1.port_b, wallHeatCapacity.port) annotation (Line(
      points={{-40,0},{0,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(wallHeatCapacity.port, layer2.port_a) annotation (Line(
      points={{0,0},{40,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(layer2.port_b, port_b) annotation (Line(
      points={{60,0},{100,0}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (Diagram(graphics), Icon(graphics={Rectangle(
                  extent={{-100,100},{100,-100}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Rectangle(
                  extent={{-62,66},{-34,-62}},
                  lineColor={0,0,0},
                  fillColor={175,175,175},
                  fillPattern=FillPattern.Forward),Rectangle(
                  extent={{34,66},{62,-62}},
                  lineColor={0,0,0},
                  fillColor={175,175,175},
                  fillPattern=FillPattern.Forward),Rectangle(
                  extent={{-34,66},{34,-62}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Forward),Line(
                  points={{-88,0},{-62,0}},
                  color={252,0,0},
                  smooth=Smooth.None,
                  thickness=1),Line(
                  points={{62,0},{90,0}},
                  color={252,0,0},
                  smooth=Smooth.None,
                  thickness=1),Text(
                  extent={{-38,-56},{46,-96}},
                  lineColor={0,0,0},
                  lineThickness=1,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Forward,
                  textString="%name")}));
end LayeredWall;
