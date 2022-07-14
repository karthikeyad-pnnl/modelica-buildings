within Buildings.Extra.House.Examples;

model WindowHouse

  Rooms.WindowRoom house
    annotation (Placement(transformation(extent={{20,-18},{60,22}})));
  .Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature outTemp
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  .Modelica.Blocks.Sources.Sine theta(
    amplitude=55.5,
    freqHz=1/86400,
    offset=97.5,
    phase=1.5707963267949) annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=180,
        origin={93,-4})));
  .Modelica.Blocks.Sources.Sine radiation(
    freqHz=1/86400,
    amplitude=500,
    phase=-1.5707963267949) annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=180,
        origin={93,-26})));
  .Modelica.Blocks.Sources.Constant const(k=273.15)
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
equation
  connect(outTemp.port, house.wallPort) annotation (Line(
      points={{-20,30},{0,30},{0,2},{19.6,2}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(const.y, outTemp.T) annotation (Line(
      points={{-59,30},{-42,30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(house.theta, theta.y) annotation (Line(
      points={{60.6,-4},{72.95,-4},{72.95,-4},{85.3,-4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(house.radiation, radiation.y) annotation (Line(
      points={{60.6,-10},{74,-10},{74,-26},{85.3,-26}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(outTemp.port, house.winPort) annotation (Line(
      points={{-20,30},{-20,50},{72,50},{72,2},{60.8,2}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (Diagram(graphics));
end WindowHouse;
