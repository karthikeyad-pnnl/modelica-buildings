within Buildings.Extra.House.Examples;

model RadiatorHouse

  Rooms.RadiatorRoom house
    annotation (Placement(transformation(extent={{20,-18},{60,22}})));
  .Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature outTemp
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  .Modelica.Fluid.Sources.FixedBoundary sink(
    nPorts=1,
    redeclare package Medium = .Modelica.Media.Water.StandardWater,
    p=100000,
    T=303.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,-50})));
  .Modelica.Fluid.Sources.FixedBoundary source(
    nPorts=1,
    redeclare package Medium = .Modelica.Media.Water.StandardWater,
    p=250000,
    T=343.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,-50})));
  .Modelica.Blocks.Sources.Sine theta(
    amplitude=55.5,
    freqHz=1/86400,
    offset=97.5,
    phase=1.5707963267949) annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=180,
        origin={93,6})));
  .Modelica.Blocks.Sources.Sine radiation(
    freqHz=1/86400,
    amplitude=800,
    phase=-1.5707963267949) annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=180,
        origin={93,-16})));
  .Modelica.Blocks.Sources.Constant const(k=273.15)
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
equation
  connect(outTemp.port, house.wallPort) annotation (Line(
      points={{-20,30},{0,30},{0,2},{19.6,2}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(house.port_b, sink.ports[1]) annotation (Line(
      points={{60.4,-16},{70,-16},{70,-50},{80,-50}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(house.port_a, source.ports[1]) annotation (Line(
      points={{19.6,-16},{2,-16},{2,-50},{-20,-50}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(house.theta, theta.y) annotation (Line(
      points={{60.6,-4},{78,-4},{78,6},{85.3,6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(house.radiation, radiation.y) annotation (Line(
      points={{60.6,-10},{78,-10},{78,-16},{85.3,-16}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(house.winPort, outTemp.port) annotation (Line(
      points={{60.8,2},{72,2},{72,50},{-20,50},{-20,30}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(const.y, outTemp.T) annotation (Line(
      points={{-59,30},{-42,30}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(graphics));
end RadiatorHouse;
