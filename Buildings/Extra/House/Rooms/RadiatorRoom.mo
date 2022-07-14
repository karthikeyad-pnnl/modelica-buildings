within Buildings.Extra.House.Rooms;

model RadiatorRoom
  "Model of single room with extended wall structure and radiator"
  extends
    .Extra.House.Rooms.Interfaces.PartialRoom;

  parameter .Modelica.SIunits.HeatCapacity C_wall=1410*72
    "heat capacity in wall";
  parameter .Modelica.SIunits.Area A_window=2 "window area";
  parameter .Modelica.SIunits.ThermalConductance Gc_window=0.35
    "Convection from window";
  parameter .Modelica.SIunits.Temperature T_ref=293.15
    "Reference room temperature (used in radiator)";

  .Modelica.Thermal.HeatTransfer.Components.HeatCapacitor
    airHeatCapacity(C=C_room) "Heat capacity in the room" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={10,10})));

  .Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        .Modelica.Media.Water.StandardWater) annotation (Placement(
        transformation(extent={{-112,-100},{-92,-80}}),
        iconTransformation(extent={{-112,-100},{-92,-80}})));
  .Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        .Modelica.Media.Water.StandardWater) annotation (Placement(
        transformation(extent={{92,-100},{112,-80}}),
        iconTransformation(extent={{92,-100},{112,-80}})));
  .Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a winPort
    annotation (Placement(transformation(extent={{90,-10},{110,10}}),
        iconTransformation(extent={{94,-10},{114,10}})));

  .Modelica.Blocks.Interfaces.RealInput theta annotation (Placement(
        transformation(
        extent={{-11,-11},{11,11}},
        rotation=180,
        origin={111,-23}), iconTransformation(
        extent={{-11,-11},{11,11}},
        rotation=180,
        origin={103,-30})));
  .Modelica.Blocks.Interfaces.RealInput radiation annotation (Placement(
        transformation(
        extent={{-11,-11},{11,11}},
        rotation=180,
        origin={111,-47}), iconTransformation(
        extent={{-11,-11},{11,11}},
        rotation=180,
        origin={103,-60})));
  Components.Wall wall(
    G_wall=G_wall,
    Gc_wall=Gc_wall,
    C_wall=C_wall)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Components.Window window(A_window=A_window, Gc_window=Gc_window)
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Components.Radiator radiator(T_ref=T_ref)
    annotation (Placement(transformation(extent={{0,-80},{20,-60}})));

equation
  connect(wallPort, wall.outside) annotation (Line(
      points={{-100,0},{-60,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(wall.inside, airHeatCapacity.port) annotation (Line(
      points={{-40,0},{10,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(airHeatCapacity.port, window.inside) annotation (Line(
      points={{10,0},{40,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(window.outside, winPort) annotation (Line(
      points={{60,4},{80,4},{80,0},{100,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(window.theta, theta) annotation (Line(
      points={{60.3,-3},{82.15,-3},{82.15,-23},{111,-23}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(window.radiation, radiation) annotation (Line(
      points={{60.3,-6},{80,-6},{80,-47},{111,-47}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(port_a, radiator.inPort) annotation (Line(
      points={{-102,-90},{-52,-90},{-52,-70},{0,-70}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(radiator.outPort, port_b) annotation (Line(
      points={{20,-70},{60,-70},{60,-90},{102,-90}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(airHeatCapacity.port, radiator.heatPort) annotation (Line(
      points={{10,0},{10,-60}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (
    uses(Modelica(version="3.1")),
    Diagram(graphics),
    Icon(graphics={Rectangle(
                  extent={{22,-2},{62,-42}},
                  lineColor={255,255,255},
                  lineThickness=1,
                  fillColor={170,213,255},
                  fillPattern=FillPattern.VerticalCylinder),Rectangle(
                  extent={{22,-2},{62,-42}},
                  lineThickness=1,
                  pattern=LinePattern.None,
                  lineColor={0,0,0}),Line(
                  points={{42,-1},{42,-43}},
                  color={255,255,255},
                  thickness=1,
                  smooth=Smooth.None),Line(
                  points={{21,-22},{63,-22}},
                  color={255,255,255},
                  thickness=1,
                  smooth=Smooth.None),Rectangle(
                  extent={{22,-64},{60,-92}},
                  lineColor={215,215,215},
                  fillColor={238,238,238},
                  fillPattern=FillPattern.Solid),Rectangle(
                  extent={{22,-64},{24,-92}},
                  lineColor={215,215,215},
                  fillColor={235,235,235},
                  fillPattern=FillPattern.VerticalCylinder),Rectangle(
                  extent={{28,-64},{30,-92}},
                  lineColor={215,215,215},
                  fillColor={235,235,235},
                  fillPattern=FillPattern.VerticalCylinder),Rectangle(
                  extent={{34,-64},{36,-92}},
                  lineColor={215,215,215},
                  fillColor={235,235,235},
                  fillPattern=FillPattern.VerticalCylinder),Rectangle(
                  extent={{40,-64},{42,-92}},
                  lineColor={215,215,215},
                  fillColor={235,235,235},
                  fillPattern=FillPattern.VerticalCylinder),Rectangle(
                  extent={{46,-64},{48,-92}},
                  lineColor={215,215,215},
                  fillColor={235,235,235},
                  fillPattern=FillPattern.VerticalCylinder),Rectangle(
                  extent={{52,-64},{54,-92}},
                  lineColor={215,215,215},
                  fillColor={235,235,235},
                  fillPattern=FillPattern.VerticalCylinder),Rectangle(
                  extent={{58,-64},{60,-92}},
                  lineColor={215,215,215},
                  fillColor={235,235,235},
                  fillPattern=FillPattern.VerticalCylinder),Rectangle(
                  extent={{22,-62},{60,-64}},
                  lineColor={215,215,215},
                  fillPattern=FillPattern.Solid,
                  fillColor={238,238,238}),Rectangle(
                  extent={{22,-92},{60,-94}},
                  lineColor={215,215,215},
                  fillPattern=FillPattern.Solid,
                  fillColor={238,238,238}),Rectangle(
                  extent={{-84,20},{-80,-100}},
                  lineColor={0,0,0},
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Forward,
                  lineThickness=0.5),Rectangle(
                  extent={{80,20},{84,-100}},
                  lineColor={0,0,0},
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Forward,
                  lineThickness=0.5)}));
end RadiatorRoom;
