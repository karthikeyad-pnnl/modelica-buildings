within Buildings.Extra.PackageTerminalHeatPump.OpenLoopTesting;
model HP_Backup
    .Extra.PackageTerminalHeatPump.Experiments.HPSystem chiDXHeaEco annotation(Placement(transformation(extent = {{2.0,-2.0},{42.0,38.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Extra.PackageTerminalHeatPump.Experiments.HPSystem chiDXHeaEco2 annotation(Placement(transformation(extent = {{164.0,0.0},{204.0,40.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Controls.OBC.CDL.Continuous.Sources.Sine sin2(freqHz = 1 / 3600) annotation(Placement(transformation(extent = {{-76.0,64.0},{-56.0,84.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Controls.OBC.CDL.Continuous.Sources.Sine sin4(freqHz = 1 / 1800) annotation(Placement(transformation(extent = {{-76.0,32.0},{-56.0,52.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Controls.OBC.CDL.Continuous.Sources.Sine sin5(freqHz = 1 / 3600) annotation(Placement(transformation(extent = {{118.0,-34.0},{138.0,-14.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt(k = 1) annotation(Placement(transformation(extent = {{-76.0,0.0},{-56.0,20.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt2(k = -1) annotation(Placement(transformation(extent = {{118.0,-2.0},{138.0,18.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con2(k = 1) annotation(Placement(transformation(extent = {{-76.0,-30.0},{-56.0,-10.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con5(k = 1) annotation(Placement(transformation(extent = {{116.0,30.0},{136.0,50.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con6(k = 1) annotation(Placement(transformation(extent = {{116.0,60.0},{136.0,80.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam = Modelica.Utilities.Files.loadResource("modelica://Buildings/Resources/weatherdata/DRYCOLD.mos"), pAtm(displayUnit = "pPa"), pAtmSou = Buildings.BoundaryConditions.Types.DataSource.File) annotation(Placement(visible = true, transformation(origin = {-12, -6}, extent = {{38, 84}, {58, 104}}, rotation = 0)));
    Buildings.Fluid.Sources.Boundary_pT bou1(T = 297, nPorts = 2, p = 101325, redeclare package Medium = Buildings.Media.Air)  annotation(
    Placement(visible = true, transformation(origin = {228, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Buildings.Fluid.Sources.Boundary_pT boundary_pT(T = 297, nPorts = 2, p = 101325, redeclare package Medium = Buildings.Media.Air) annotation(
    Placement(visible = true, transformation(origin = {72, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(conInt.y, chiDXHeaEco.u) annotation(
    Line(points = {{-54, 10}, {-26.982628163007327, 10}, {-26.982628163007327, 6.501556225665123}, {0.03474367398534639, 6.501556225665123}}, color = {255, 127, 0}));
  connect(con2.y, chiDXHeaEco.TSetHP) annotation(
    Line(points = {{-54, -20}, {0, -20}, {0, 0}}, color = {0, 0, 127}));
  connect(sin4.y, chiDXHeaEco.uEco) annotation(
    Line(points = {{-54, 42}, {-27, 42}, {-27, 16}, {0, 16}}, color = {0, 0, 127}));
  connect(sin2.y, chiDXHeaEco.uFan) annotation(
    Line(points = {{-54, 74}, {0, 74}, {0, 36}}, color = {0, 0, 127}));
  connect(con6.y, chiDXHeaEco2.uFan) annotation(
    Line(points = {{138, 70}, {162, 70}, {162, 38}}, color = {0, 0, 127}));
  connect(con5.y, chiDXHeaEco2.uEco) annotation(
    Line(points = {{138, 40}, {150, 40}, {150, 18}, {162, 18}}, color = {0, 0, 127}));
  connect(conInt2.y, chiDXHeaEco2.u) annotation(
    Line(points = {{140, 8}, {150.01737183699268, 8}, {150.01737183699268, 8.501556225665123}, {162.03474367398536, 8.501556225665123}}, color = {255, 127, 0}));
  connect(sin5.y, chiDXHeaEco2.TSetHP) annotation(
    Line(points = {{140, -24}, {162, -24}, {162, 2}}, color = {0, 0, 127}));
  connect(weaDat.weaBus, chiDXHeaEco.weaBus) annotation(
    Line(points = {{46, 88}, {46, 54}, {6.2, 54}, {6.2, 35.8}}, color = {255, 204, 51}));
  connect(weaDat.weaBus, chiDXHeaEco2.weaBus) annotation(
    Line(points = {{46, 88}, {168.2, 88}, {168.2, 37.8}}, color = {255, 204, 51}));
  connect(chiDXHeaEco2.supplyAir, bou1.ports[1]) annotation(
    Line(points = {{204, 28}, {212, 28}, {212, 40}, {238, 40}, {238, 8}}, color = {0, 127, 255}));
  connect(chiDXHeaEco2.returnAir, bou1.ports[2]) annotation(
    Line(points = {{204, 20}, {245, 20}, {245, 8}, {238, 8}}, color = {0, 127, 255}));
  connect(chiDXHeaEco.supplyAir, boundary_pT.ports[1]) annotation(
    Line(points = {{42, 26}, {52, 26}, {52, 52}, {92, 52}, {92, 22}, {82, 22}}, color = {0, 127, 255}));
  connect(chiDXHeaEco.returnAir, boundary_pT.ports[2]) annotation(
    Line(points = {{42, 18}, {54, 18}, {54, 2}, {94, 2}, {94, 22}, {82, 22}}, color = {0, 127, 255}));
protected
    annotation(
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(fillColor = {230, 230, 230}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}), Text(lineColor = {0, 0, 255}, extent = {{-150, 150}, {150, 110}}, textString = "%name")}));
end HP_Backup;
