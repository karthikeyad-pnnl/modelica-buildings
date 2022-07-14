within Buildings.Extra.House.Rooms;

model WindowRoom
  "Model of single room with extended wall structure and window"
  extends
    .Extra.House.Rooms.Interfaces.PartialRoom;
  parameter .Modelica.SIunits.HeatCapacity C_wall=1410*72
    "heat capacity in wall";
  parameter .Modelica.SIunits.Area A_window=2 "window area";
  parameter .Modelica.SIunits.ThermalConductance Gc_window=0.35
    "convection from window";

  .Modelica.Thermal.HeatTransfer.Components.HeatCapacitor
    airHeatCapacity(C=C_room) "Heat capacity in the room" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={10,10})));
  .Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a winPort
    annotation (Placement(transformation(extent={{94,-10},{114,10}}),
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
  Components.Window window(A_window=A_window,Gc_window=Gc_window)
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Components.Wall wall(
    G_wall=G_wall,
    Gc_wall=Gc_wall,
    C_wall=C_wall)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
equation
  connect(airHeatCapacity.port, window.inside) annotation (Line(
      points={{10,0},{40,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(window.outside, winPort) annotation (Line(
      points={{60,4},{80,4},{80,0},{104,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(window.theta, theta) annotation (Line(
      points={{60.3,-3},{83.15,-3},{83.15,-23},{111,-23}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(window.radiation, radiation) annotation (Line(
      points={{60.3,-6},{80,-6},{80,-47},{111,-47}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(wallPort, wall.outside) annotation (Line(
      points={{-100,0},{-60,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(wall.inside, airHeatCapacity.port) annotation (Line(
      points={{-40,0},{10,0}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (Diagram(graphics), Icon(graphics={Rectangle(
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
end WindowRoom;
