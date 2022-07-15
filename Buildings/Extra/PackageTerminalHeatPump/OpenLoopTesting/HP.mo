within Buildings.Extra.PackageTerminalHeatPump.OpenLoopTesting;
model HP

  replaceable package MediumA =
    Buildings.Media.Air
    "Medium in the component";

  Buildings.Extra.PackageTerminalHeatPump.Experiments.HPSystem heaPumSys(perHP=
        Experiments.HP_openLoop())
    annotation (Placement(transformation(extent={{2.0,-2.0},{42.0,38.0}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Sine sin2(
    amplitude=0.5,                                        freqHz = 1 / 3600,
    offset=0.5)
    annotation(Placement(transformation(extent = {{-76.0,64.0},{-56.0,84.0}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Sine sin4(
    amplitude=0.5,                                        freqHz = 1 / 1800,
    offset=0.5)
    annotation(Placement(transformation(extent = {{-76.0,32.0},{-56.0,52.0}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt(k = 1)
    annotation(Placement(transformation(extent = {{-76.0,0.0},{-56.0,20.0}},origin = {0.0,0.0},rotation = 0.0)));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con2(k=273.15 + 23.9)
    annotation(Placement(transformation(extent = {{-76.0,-30.0},{-56.0,-10.0}},origin = {0.0,0.0},rotation = 0.0)));
  Buildings.Fluid.Sources.Boundary_pT boundary_pT(
    redeclare package Medium = MediumA,
    T=297,
    nPorts=1,
    p=101325)
    annotation (Placement(visible = true, transformation(origin = {72, 22}, extent = {{-10, -10}, {10, 10}})));
  BoundaryConditions.WeatherData.ReaderTMY3           weaDat(
      computeWetBulbTemperature=false, filNam=
        Modelica.Utilities.Files.loadResource(
        "./Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos"))
    "Weather data"
    annotation (Placement(transformation(extent={{10,70},{30,90}})));
  Fluid.Sources.Boundary_pT           boundary_pT1(
    redeclare package Medium = MediumA,
    T=297,
    nPorts=1,
    p=101325)
    annotation (Placement(visible = true, transformation(origin={70,-20},   extent = {{-10, -10}, {10, 10}})));
equation
  connect(conInt.y, heaPumSys.u) annotation (Line(points={{-54,10},{-26.982628163007327,
          10},{-26.982628163007327,6.501556225665123},{0.03474367398534639,
          6.501556225665123}}, color={255,127,0}));
  connect(con2.y, heaPumSys.TSetHP)
    annotation (Line(points={{-54,-20},{0,-20},{0,0}}, color={0,0,127}));
  connect(sin4.y, heaPumSys.uEco) annotation (Line(points={{-54,42},{-27,42},{-27,
          16},{0,16}}, color={0,0,127}));
  connect(sin2.y, heaPumSys.uFan)
    annotation (Line(points={{-54,74},{0,74},{0,36}}, color={0,0,127}));
  connect(heaPumSys.supplyAir, boundary_pT.ports[1]) annotation (Line(points={{
          42.2,26},{52,26},{52,52},{92,52},{92,22},{82,22}}, color={0,127,255}));
  connect(weaDat.weaBus, heaPumSys.weaBus) annotation (Line(
      points={{30,80},{40,80},{40,60},{6.2,60},{6.2,35.8}},
      color={255,204,51},
      thickness=0.5));
  connect(boundary_pT1.ports[1], heaPumSys.returnAir) annotation (Line(points={
          {80,-20},{90,-20},{90,8},{60,8},{60,18},{42.2,18}}, color={0,127,255}));
    annotation (
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(fillColor = {230, 230, 230},
            fillPattern =                                                                                                                                     FillPattern.Solid, extent = {{-100, -100}, {100, 100}}), Text(lineColor = {0, 0, 255}, extent = {{-150, 150}, {150, 110}}, textString = "%name")}),
      experiment(StopTime=3600, __Dymola_Algorithm="Dassl"));
end HP;
