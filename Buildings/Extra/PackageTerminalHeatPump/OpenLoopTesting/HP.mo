within Buildings.Extra.PackageTerminalHeatPump.OpenLoopTesting;
model HP

  replaceable package MediumA =
    Buildings.Media.Air
    "Medium in the component";

  Buildings.Extra.PackageTerminalHeatPump.Experiments.HPSystem heaPumSys(perHP=
        Experiments.HP_openLoop())
    annotation (Placement(transformation(extent={{0,10},{40,40}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Sine sin2(
    amplitude=0.25,                                       freqHz = 1 / 3600,
    offset=0.5)
    annotation(Placement(transformation(extent={{-80,70},{-60,90}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con2(k=273.15 + 23.9)
    annotation(Placement(transformation(extent = {{-76.0,-30.0},{-56.0,-10.0}},origin={-4,-60},   rotation = 0.0)));
  Buildings.Fluid.Sources.Boundary_pT boundary_pT(
    redeclare package Medium = MediumA,
    T=297,
    nPorts=1,
    p=101325)
    annotation (Placement(visible = true, transformation(origin={70,30},    extent = {{-10, -10}, {10, 10}})));
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
    annotation (Placement(visible = true, transformation(origin={70,-10},   extent = {{-10, -10}, {10, 10}})));
  Controls.OBC.CDL.Continuous.Sources.Sine sin(
    amplitude=10,
    freqHz=1/3600,
    offset=273.15 + 23.9)
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  Controls.OBC.CDL.Continuous.Greater gre
    annotation (Placement(transformation(extent={{0,-50},{20,-30}})));
  Controls.OBC.CDL.Continuous.Less les
    annotation (Placement(transformation(extent={{0,-90},{20,-70}})));
  Controls.OBC.CDL.Conversions.BooleanToInteger booToInt
    annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
  Controls.OBC.CDL.Conversions.BooleanToInteger booToInt1(integerTrue=-1)
    annotation (Placement(transformation(extent={{40,-90},{60,-70}})));
  Controls.OBC.CDL.Integers.Add addInt
    annotation (Placement(transformation(extent={{80,-70},{100,-50}})));
  Controls.OBC.CDL.Continuous.Sources.Constant           con1(k=0.2)
    annotation(Placement(transformation(extent = {{-76.0,-30.0},{-56.0,-10.0}},origin={-4,50},    rotation = 0.0)));
equation
  connect(sin2.y, heaPumSys.uFan)
    annotation (Line(points={{-58,80},{-20,80},{-20,38},{-2,38}},
                                                      color={0,0,127}));
  connect(heaPumSys.supplyAir, boundary_pT.ports[1]) annotation (Line(points={{40.2,23},
          {52,23},{52,52},{90,52},{90,30},{80,30}},          color={0,127,255}));
  connect(weaDat.weaBus, heaPumSys.weaBus) annotation (Line(
      points={{30,80},{40,80},{40,60},{4.2,60},{4.2,37.8}},
      color={255,204,51},
      thickness=0.5));
  connect(boundary_pT1.ports[1], heaPumSys.returnAir) annotation (Line(points={{80,-10},
          {90,-10},{90,16},{40.2,16}},                        color={0,127,255}));
  connect(sin.y, heaPumSys.TSetHP) annotation (Line(points={{-58,-40},{-20,-40},
          {-20,2},{-2,2}}, color={0,0,127}));
  connect(sin.y, gre.u1)
    annotation (Line(points={{-58,-40},{-2,-40}}, color={0,0,127}));
  connect(con2.y, gre.u2) annotation (Line(points={{-58,-80},{-10,-80},{-10,-48},
          {-2,-48}}, color={0,0,127}));
  connect(sin.y, les.u1) annotation (Line(points={{-58,-40},{-6,-40},{-6,-80},{
          -2,-80}}, color={0,0,127}));
  connect(con2.y, les.u2) annotation (Line(points={{-58,-80},{-10,-80},{-10,-88},
          {-2,-88}}, color={0,0,127}));
  connect(gre.y, booToInt.u)
    annotation (Line(points={{22,-40},{38,-40}}, color={255,0,255}));
  connect(les.y, booToInt1.u)
    annotation (Line(points={{22,-80},{38,-80}}, color={255,0,255}));
  connect(booToInt.y, addInt.u1) annotation (Line(points={{62,-40},{70,-40},{70,
          -54},{78,-54}}, color={255,127,0}));
  connect(booToInt1.y, addInt.u2) annotation (Line(points={{62,-80},{70,-80},{
          70,-66},{78,-66}}, color={255,127,0}));
  connect(addInt.y, heaPumSys.u) annotation (Line(points={{102,-60},{110,-60},{
          110,-120},{-30,-120},{-30,8.5016},{-1.9653,8.5016}}, color={255,127,0}));
  connect(con1.y, heaPumSys.uEco) annotation (Line(points={{-58,30},{-20,30},{
          -20,18},{-2,18}}, color={0,0,127}));
    annotation (
    Icon(coordinateSystem(preserveAspectRatio = false, extent={{-140,-140},{140,
            140}}),                                                                          graphics={  Rectangle(fillColor = {230, 230, 230},
            fillPattern =                                                                                                                                     FillPattern.Solid, extent = {{-100, -100}, {100, 100}}), Text(lineColor = {0, 0, 255}, extent = {{-150, 150}, {150, 110}}, textString = "%name")}),
      experiment(StopTime=3600, __Dymola_Algorithm="Dassl"),
    Diagram(coordinateSystem(extent={{-140,-140},{140,140}})));
end HP;
