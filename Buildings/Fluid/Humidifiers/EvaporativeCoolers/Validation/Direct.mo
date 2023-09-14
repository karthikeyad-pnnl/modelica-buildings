within Buildings.Fluid.Humidifiers.EvaporativeCoolers.Validation;
model Direct "Validation model for a direct evaporative cooler"

  extends Modelica.Icons.Example;

  replaceable package MediumA = Buildings.Media.Air;

  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal = 2;

  Buildings.Fluid.Humidifiers.EvaporativeCoolers.Direct dirEvaCoo(
    redeclare package Medium = MediumA,
    m_flow_nominal=m_flow_nominal,
    dep=0.2,
    padAre=0.6) "Direct evaporative cooler" annotation (Placement(visible=true,
        transformation(
        origin={0,0},
        extent={{-10,-10},{10,10}},
        rotation=0)));

  Buildings.Fluid.Sources.Boundary_pT sink(
    redeclare final package Medium = MediumA,
    T = 340,
    use_T_in = false,
    nPorts=1)
    annotation (
    Placement(visible = true, transformation(origin={102,0},      extent = {{-10, -10}, {10, 10}}, rotation = -180)));

  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
    columns = 2:10,
    fileName=ModelicaServices.ExternalReferences.loadResource("modelica://Buildings/Resources/Data/Fluid/Humidifiers/EvaporativeCoolers/Direct/Direct.dat"),
    tableName = "EnergyPlus",
    tableOnFile = true,
    timeScale = 1)
    annotation (Placement(visible = true,
      transformation(origin={-120,40},
      extent = {{-10, -10}, {10, 10}},
      rotation = 0)));

  Buildings.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = MediumA,
    m_flow = 1,
    use_C_in = false,
    use_T_in = true,
    use_Xi_in = true,
    use_m_flow_in = true,
    nPorts=1)                                                                                                                                                                              annotation (
    Placement(visible = true, transformation(origin={-30,0},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));

  Buildings.Fluid.Sensors.TemperatureTwoPort senTem1(
    redeclare package Medium = MediumA,
    initType = Modelica.Blocks.Types.Init.InitialOutput,
    m_flow_nominal = m_flow_nominal,
    T_start(displayUnit="K") = 293.15)                                                                                                                                            annotation (
    Placement(visible = true, transformation(origin={30,0},      extent = {{-10, -10}, {10, 10}}, rotation = 0)));

  Buildings.Fluid.Sensors.MassFractionTwoPort senMasFra1(
    redeclare package Medium = MediumA,
    m_flow_nominal = m_flow_nominal)  annotation (
    Placement(visible = true, transformation(origin={60,0},      extent = {{-10, -10}, {10, 10}}, rotation = 0)));

  Modelica.Blocks.Math.Mean mean(f=1/600)     annotation (
    Placement(visible = true, transformation(origin={50,60},   extent = {{-10, -10}, {10, 10}}, rotation = 0)));

  Modelica.Blocks.Math.Mean mean2(f=1/600)    annotation (
    Placement(visible = true, transformation(origin={90,30},   extent = {{-10, -10}, {10, 10}}, rotation = 0)));

  Buildings.Utilities.Psychrometrics.ToTotalAir toTotAirIn
    "Convert inlet air humidity ratio denominator from dry air to total air"
    annotation (Placement(transformation(extent={{-90,-60},{-70,-40}})));

  Buildings.Utilities.Psychrometrics.ToTotalAir toTotAirOut
    "Convert outlet air humidity ratio denominator from dry air to total air"
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));

  Modelica.Blocks.Math.UnitConversions.From_degC from_degCIn
    "Convert inlet temperature from deg C to Kelvin"
    annotation (Placement(transformation(extent={{-90,-30},{-70,-10}})));

  Modelica.Blocks.Math.UnitConversions.To_degC to_degCOut
    "Convert outlet temperature from Kelvin to deg C"
    annotation (Placement(transformation(extent={{80,50},{100,70}})));
equation
  connect(combiTimeTable.y[9], boundary.m_flow_in) annotation (
    Line(points={{-109,40},{-100,40},{-100,8},{-42,8}}, color = {0, 0, 127}));
  connect(dirEvaCoo.port_b, senTem1.port_a)
    annotation (Line(points={{10,0},{20,0}}, color={0,127,255}));
  connect(senTem1.T, mean.u) annotation (
    Line(points={{30,11},{30,60},{38,60}},                    color = {0, 0, 127}));
  connect(senMasFra1.X, mean2.u) annotation (
    Line(points={{60,11},{60,30},{78,30}},         color = {0, 0, 127}));
  connect(combiTimeTable.y[6], toTotAirIn.XiDry) annotation (Line(points={{-109,40},
          {-100,40},{-100,-50},{-91,-50}},      color={0,0,127}));
  connect(toTotAirIn.XiTotalAir, boundary.Xi_in[1]) annotation (Line(points={{-69,-50},
          {-50,-50},{-50,-4},{-42,-4}},       color={0,0,127}));
  connect(combiTimeTable.y[8], toTotAirOut.XiDry)
    annotation (Line(points={{-109,40},{-81,40}},  color={0,0,127}));
  connect(combiTimeTable.y[5], from_degCIn.u) annotation (Line(points={{-109,40},
          {-100,40},{-100,-20},{-92,-20}}, color={0,0,127}));
  connect(from_degCIn.y, boundary.T_in) annotation (Line(points={{-69,-20},{-60,
          -20},{-60,4},{-42,4}}, color={0,0,127}));
  connect(mean.y, to_degCOut.u)
    annotation (Line(points={{61,60},{78,60}}, color={0,0,127}));
  connect(senMasFra1.port_a, senTem1.port_b)
    annotation (Line(points={{50,0},{40,0}}, color={0,127,255}));
  connect(senMasFra1.port_b, sink.ports[1])
    annotation (Line(points={{70,0},{92,0}},   color={0,127,255}));
  connect(boundary.ports[1], dirEvaCoo.port_a)
    annotation (Line(points={{-20,0},{-10,0}}, color={0,127,255}));
  annotation (
    Placement(visible = true, transformation(origin = {-62, 66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)),
    Diagram(coordinateSystem(extent={{-140,-100},{140,100}})),
    experiment(
      StopTime=1200000,
      Interval=60,
      __Dymola_Algorithm="Cvode"),
    Documentation(info="<html>
<p>Model that demonstrates the use of the <a href=\"modelica://Buildings.Fluid.Humidifiers.EvaporativeCoolers.Direct\">
Buildings.Fluid.Humidifiers.EvaporativeCoolers.Direct</a> evaporative cooler model. </p>
</html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})),
    __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Fluid/Humidifiers/EvaporativeCoolers/Validation/Direct.mos"
        "Simulate and plot"));
end Direct;
