within Buildings.Extra.House.Examples;

model House

  Rooms.Room house
    annotation (Placement(transformation(extent={{20,-18},{60,22}})));
  .Modelica.Blocks.Sources.Sine sineTemp(
    amplitude=5,
    freqHz=1/86400,
    phase=-1.5707963267949,
    offset=273.15)
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  .Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature outTemp
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
equation
  connect(sineTemp.y, outTemp.T) annotation (Line(
      points={{-59,30},{-42,30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(outTemp.port, house.wallPort) annotation (Line(
      points={{-20,30},{0,30},{0,2},{19.6,2}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (Diagram(graphics));
end House;
