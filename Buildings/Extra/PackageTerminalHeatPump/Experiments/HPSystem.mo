within Buildings.Extra.PackageTerminalHeatPump.Experiments;
model HPSystem "HVAC system model with a dry cooling coil, air-cooled chiller, electric heating coil,
  variable speed fan, and mixing box with economizer control."
  replaceable package MediumA = Buildings.Media.Air
    "Medium model for air";

  parameter Buildings.Fluid.HeatPumps.Data.EquationFitReversible.Generic perHP
   "Performance data"
    annotation (choicesAllMatching=true, Placement(transformation(extent={{-160,
            130},{-140,150}})));

  parameter .Modelica.Units.SI.DimensionlessRatio COP_nominal = 5.5 "Nominal COP of the chiller";
  parameter .Modelica.Units.SI.MassFlowRate mAir_flow_nominal = 1 "Design airflow rate of system" annotation (
    Dialog(group = "Air design"));
  parameter .Modelica.Units.SI.PressureDifference dp_nominal(displayUnit = "Pa") = 500 "Design pressure drop of flow leg with fan" annotation (
    Dialog(group = "Air design"));
  parameter .Modelica.Units.SI.MassFlowRate mChiCon_flow_nominal = 1 "Design airflow rate of system" annotation (
    Dialog(group = "Air design"));
  .Modelica.Blocks.Interfaces.RealInput uFan(final unit = "1") "Fan control signal" annotation (
    Placement(transformation(extent = {{-240, 140}, {-200, 180}}), iconTransformation(extent = {{-240, 140}, {-200, 180}})));
  .Modelica.Blocks.Interfaces.RealInput TSetHP(final unit = "K", displayUnit = "degC", final quantity = "ThermodynamicTemperature") "Set point for leaving heat pump air supply temperature" annotation (
    Placement(transformation(extent={{-240,-60},{-200,-20}}),        iconTransformation(extent = {{-240, -220}, {-200, -180}})));
  .Modelica.Blocks.Interfaces.RealInput uEco "Control signal for economizer" annotation (
    Placement(transformation(extent={{-240,80},{-200,120}}),       iconTransformation(extent = {{-240, -60}, {-200, -20}})));
  .Modelica.Fluid.Interfaces.FluidPort_a supplyAir(redeclare replaceable
      package                                                                    Medium = MediumA) "Supply air" annotation (
    Placement(transformation(extent={{190,50},{210,70}}),      iconTransformation(extent={{192,0},
            {212,20}})));
  .Modelica.Fluid.Interfaces.FluidPort_b returnAir(redeclare replaceable
      package                                                                    Medium = MediumA) "Return air" annotation (
    Placement(transformation(extent = {{192.0, -30.0}, {212.0, -10.0}}, rotation = 0.0, origin = {0.0, 0.0}), iconTransformation(extent={{192,-70},
            {212,-50}})));
  .Modelica.Blocks.Interfaces.RealOutput PFan(final unit = "W") "Electrical power consumed by the supply fan" annotation (
    Placement(transformation(extent={{200,150},{220,170}}),      iconTransformation(extent = {{202, 150}, {222, 170}})));
  .Modelica.Blocks.Interfaces.RealOutput PHP(final unit = "W") "Electrical power consumed by the heat pump" annotation (
    Placement(transformation(extent={{200,30},{220,50}}),        iconTransformation(extent={{202,-30},
            {222,-10}})));
  .Modelica.Blocks.Interfaces.RealOutput TMix(final unit = "K", displayUnit = "degC", final quantity = "ThermodynamicTemperature")
    "Mixed air temperature"                                                                                                                                annotation (
    Placement(transformation(extent={{200,130},{220,150}}),      iconTransformation(extent={{202,110},
            {222,130}})));
  .Buildings.BoundaryConditions.WeatherData.Bus weaBus "Weather bus" annotation (
    Placement(transformation(extent = {{-200.0, 22.0}, {-160.0, 62.0}}, rotation = 0.0, origin = {0.0, 0.0}), iconTransformation(extent = {{-168, 148}, {-148, 168}})));
  .Buildings.Fluid.Movers.FlowControlled_m_flow fanSup(final m_flow_nominal = mAir_flow_nominal,
    redeclare Fluid.Movers.Data.Generic per,                                                                                                           final dp_nominal = 875,
    final energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,                                                                                                                                                                                                        final use_inputFilter = false, redeclare
      replaceable package                                                                                                                                                                                                         Medium = MediumA) "Supply fan" annotation (
    Placement(transformation(extent = {{-30, 30}, {-10, 50}})));
  .Buildings.Fluid.FixedResistances.PressureDrop totalRes(final m_flow_nominal = mAir_flow_nominal, final dp_nominal = dp_nominal,                                  redeclare
      replaceable package                                                                                                                                                                         Medium = MediumA) "Total resistance" annotation (
    Placement(transformation(extent = {{10, 30}, {30, 50}})));
  .Buildings.Fluid.Sources.Outside out(final nPorts=2,   redeclare replaceable
      package                                                                          Medium = MediumA) "Boundary conditions for outside air" annotation (
    Placement(transformation(extent = {{-138.59042894472765, 29.60845248464657}, {-118.59042894472765, 49.60845248464657}}, rotation = 0.0, origin = {0.0, 0.0})));
  .Buildings.Fluid.Sensors.TemperatureTwoPort senTMixAir(final m_flow_nominal = mAir_flow_nominal,                                  final tau = 0, redeclare
      replaceable package                                                                                                                                                        Medium = MediumA)
    "Mixed air temperature sensor"                                                                                                                                                                                                annotation (
    Placement(transformation(extent = {{-60, 30}, {-40, 50}})));
  .Modelica.Blocks.Math.Gain gaiFan(k = mAir_flow_nominal) "Gain for fan mass flow rate" annotation (
    Placement(transformation(extent={{-80,150},{-60,170}})));
  Buildings.Extra.PackageTerminalHeatPump.Experiments.IdeEco ideEco(redeclare
      package Medium = MediumA, m_flow_nominal=mAir_flow_nominal)                                                                                 "Ideal economizer" annotation (
    Placement(transformation(rotation = 90, extent = {{10, -10}, {-10, 10}}, origin={-90,50})));
  .Buildings.Fluid.HeatPumps.EquationFitReversible heaPum(redeclare
      replaceable package                                                               Medium1 = MediumA, redeclare
      replaceable package                                                                                                                Medium2 = MediumA,
    per=perHP)                                                                                                                                                                                                         annotation (
    Placement(transformation(extent = {{94.88708110681092, -177.88257798819242}, {114.88708110681092, -157.88257798819242}}, origin={-14,202},    rotation = 0.0)));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData souOutAir(
    redeclare replaceable package Medium = MediumA,
    final nPorts = 1,
    final m_flow = mChiCon_flow_nominal)
    "Mass flow source for chiller"
    annotation (Placement(transformation(extent = {{10, -10}, {-10, 10}}, origin={130,10})));

  .Buildings.Controls.OBC.CDL.Interfaces.IntegerInput u annotation (
    Placement(transformation(extent={{-239.655,-154.984},{-199.655,-114.984}},                                                origin={
            -0.345072,134.984},                                                                                                                    rotation = 0.0),
        iconTransformation(extent={{-239.653,-154.984},{-199.653,-114.984}},
          origin={0,0})));
  Fluid.Sensors.TemperatureTwoPort senTSupAir(
    final m_flow_nominal=mAir_flow_nominal,
    final tau=0,
    redeclare replaceable package Medium = MediumA)
    "Mixed air temperature sensor"
    annotation (Placement(transformation(extent={{120,50},{140,70}})));
  Modelica.Blocks.Interfaces.RealOutput TSup(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature") "Supply air temperature"
    annotation (Placement(transformation(extent={{200,110},{220,130}}),
        iconTransformation(extent={{202,70},{222,90}})));
  Fluid.Sensors.VolumeFlowRate senVolFlo(redeclare package Medium = MediumA,
      m_flow_nominal=mAir_flow_nominal)
    annotation (Placement(transformation(extent={{160,50},{180,70}})));
  Modelica.Blocks.Interfaces.RealOutput VSupAir_flow(
    final quantity="VolumeFlowRate",
    final unit="m3/s")
    "Supply air volume flowrate"
    annotation (Placement(transformation(extent={{200,90},{220,110}}),
        iconTransformation(extent={{202,30},{222,50}})));

equation
  connect(fanSup.port_b, totalRes.port_a) annotation (
    Line(points = {{-10, 40}, {10, 40}}, color = {0, 127, 255}));
  connect(fanSup.P, PFan) annotation (
    Line(points={{-9,49},{-8,49},{-8,160},{210,160}},          color = {0, 0, 127}));
  connect(weaBus, out.weaBus) annotation (
    Line(points={{-180,42},{-138.59,42},{-138.59,39.8085}},
                                                          color = {255, 204, 51}, thickness = 0.5),
    Text(textString = "%first", index = -1, extent = {{-6, 3}, {-6, 3}}));
  connect(senTMixAir.port_b, fanSup.port_a) annotation (
    Line(points = {{-40, 40}, {-30, 40}}, color = {0, 127, 255}));
  connect(gaiFan.y, fanSup.m_flow_in) annotation (
    Line(points={{-59,160},{-20,160},{-20,52}},        color = {0, 0, 127}));
  connect(gaiFan.u, uFan) annotation (
    Line(points={{-82,160},{-220,160}},                                color = {0, 0, 127}));
  connect(senTMixAir.T, TMix) annotation (
    Line(points={{-50,51},{-50,140},{210,140}},                              color = {0, 0, 127}));
  connect(uEco, ideEco.y) annotation (
    Line(points={{-220,100},{-148,100},{-148,70},{-90,70},{-90,61}},            color = {0, 0, 127}));
  connect(totalRes.port_b, heaPum.port_a1) annotation (
    Line(points={{30,40},{62.4435,40},{62.4435,40.1174},{80.8871,40.1174}},                                                                color = {0, 127, 255}));
  connect(heaPum.TSet, TSetHP) annotation (
    Line(points={{79.4871,43.1174},{40,43.1174},{40,-40},{-220,-40}},                                                                                                                                                                color = {0, 0, 127}));
  connect(heaPum.P, PHP) annotation (
    Line(points={{101.887,33.9174},{123.075,33.9174},{123.075,34},{148,34},{148,
          40},{210,40}},                                                                                                                                                                                                        color = {0, 0, 127}));
  connect(heaPum.uMod, u) annotation (
    Line(points={{79.8871,34.1174},{70,34.1174},{70,0},{-76,0},{-76,7.10543e-15},
          {-220,7.10543e-15}},                                                                                                                                                                 color = {255, 127, 0}));
  connect(heaPum.port_b2, out.ports[1]) annotation (
    Line(points={{80.8871,28.1174},{60,28.1174},{60,10},{-112,10},{-112,41.6085},
          {-118.59,41.6085}},                                                                                                                    color = {0, 127, 255}));
  connect(souOutAir.ports[1], heaPum.port_a2) annotation (
    Line(points={{120,10},{110,10},{110,28},{100.887,28},{100.887,28.1174}},                            color = {0, 127, 255}));
  connect(weaBus, souOutAir.weaBus) annotation (
    Line(points={{-180,42},{-180,-60},{160,-60},{160,10.2},{140,10.2}},                  color = {255, 204, 51}));
  connect(ideEco.port_3, returnAir) annotation (Line(points={{-90,40},{-90,-20},
          {202,-20}}, color={0,127,255}));
  connect(ideEco.port_2, senTMixAir.port_a) annotation (Line(points={{-80.2,44},
          {-70,44},{-70,40},{-60,40}}, color={0,127,255}));
  connect(ideEco.port_1, out.ports[2]) annotation (Line(points={{-99.8,44},{
          -108,44},{-108,37.6085},{-118.59,37.6085}}, color={0,127,255}));
  connect(heaPum.port_b1, senTSupAir.port_a) annotation (Line(points={{100.887,
          40.1174},{110.444,40.1174},{110.444,60},{120,60}},
                                                    color={0,127,255}));
  connect(senTSupAir.T, TSup)
    annotation (Line(points={{130,71},{130,120},{210,120}}, color={0,0,127}));
  connect(senTSupAir.port_b, senVolFlo.port_a)
    annotation (Line(points={{140,60},{160,60}}, color={0,127,255}));
  connect(senVolFlo.port_b, supplyAir)
    annotation (Line(points={{180,60},{200,60}}, color={0,127,255}));
  connect(senVolFlo.V_flow, VSupAir_flow)
    annotation (Line(points={{170,71},{170,100},{210,100}}, color={0,0,127}));
  annotation (
    defaultComponentName = "chiDXHeaEco",
    Icon(coordinateSystem(preserveAspectRatio = false, extent={{-200,-120},{200,
            180}}),                                                                          graphics={  Rectangle(extent = {{-200, 180}, {202, -220}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                                                                                                                 FillPattern.Solid), Rectangle(extent = {{182, 60}, {-158, 20}}, lineColor = {175, 175, 175}, fillColor = {175, 175, 175},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid), Rectangle(extent = {{-30, 56}, {-2, 42}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid), Rectangle(extent = {{182, -52}, {-158, -92}}, lineColor = {175, 175, 175}, fillColor = {175, 175, 175},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid), Rectangle(extent = {{-78, 20}, {-118, -52}}, lineColor = {175, 175, 175}, fillColor = {175, 175, 175},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid), Ellipse(extent = {{-46, 56}, {-12, 22}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid), Ellipse(extent = {{-36, 46}, {-22, 32}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid), Rectangle(extent = {{42, 60}, {56, 20}}, lineColor = {255, 0, 0}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                                                                                                                        FillPattern.Backward), Rectangle(extent = {{104, 60}, {118, 20}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                                                                                                                        FillPattern.Backward), Rectangle(extent = {{44, 74}, {54, 66}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                                                                                                                        FillPattern.Backward), Rectangle(extent = {{40, 76}, {58, 74}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                                                                                                                        FillPattern.Backward), Line(points = {{46, 76}, {46, 80}}, color = {0, 0, 0}), Line(points = {{52, 76}, {52, 80}}, color = {0, 0, 0}), Line(points = {{50, 60}, {50, 68}}, color = {0, 0, 0}), Rectangle(extent = {{-138, 60}, {-124, 20}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                                                                                                                        FillPattern.Backward), Rectangle(extent = {{-138, -52}, {-124, -92}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                                                                                                                        FillPattern.Backward), Rectangle(extent = {{-7, 20}, {7, -20}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                                                                                                                        FillPattern.Backward, origin = {-98, -17}, rotation = 90), Line(points = {{202, 120}, {88, 120}, {88, 66}}, color = {0, 0, 127}), Line(points = {{200, 138}, {50, 138}, {50, 88}}, color = {0, 0, 127}), Line(points = {{200, 160}, {-28, 160}, {-28, 70}}, color = {0, 0, 127}), Line(points = {{106, 20}, {106, -46}}, color = {0, 0, 255}), Line(points = {{116, 20}, {116, -46}}, color = {0, 0, 255}), Line(points = {{106, -6}, {116, -6}}, color = {0, 0, 255}), Polygon(points = {{-3, 4}, {-3, -4}, {3, 0}, {-3, 4}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid, origin = {117, -4}, rotation = -90), Polygon(points = {{112, -2}, {112, -10}, {118, -6}, {112, -2}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid), Polygon(points = {{-4, -3}, {4, -3}, {0, 3}, {-4, -3}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid, origin = {117, -8}), Line(points = {{118, -6}, {124, -6}}, color = {0, 0, 0}), Line(points = {{124, -4}, {124, -10}}, color = {0, 0, 0}), Ellipse(extent = {{98, -104}, {126, -132}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid), Polygon(points = {{112, -104}, {100, -124}, {124, -124}, {112, -104}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid), Line(points = {{116, -96}, {116, -104}}, color = {0, 0, 255}), Line(points = {{106, -96}, {106, -104}}, color = {0, 0, 255}), Ellipse(extent = {{86, -128}, {112, -138}}, lineColor = {0, 0, 0}, fillColor = {95, 95, 95},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid), Ellipse(extent = {{112, -128}, {138, -138}}, lineColor = {0, 0, 0}, fillColor = {95, 95, 95},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid), Ellipse(extent = {{110, -28}, {122, -38}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid), Polygon(points = {{116, -28}, {112, -36}, {120, -36}, {116, -28}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid), Line(points = {{202, 100}, {134, 100}, {134, 66}}, color = {0, 0, 127}), Line(points = {{126, -34}, {134, -34}, {134, 16}}, color = {0, 0, 127}), Line(points = {{94, -116}, {88, -116}, {88, 16}}, color = {0, 0, 127}), Text(extent = {{-154, 260}, {164, 196}}, textString = "%name", lineColor = {0, 0, 255})}),
    Diagram(coordinateSystem(preserveAspectRatio = false, extent={{-200,-120},{
            200,180}})),
    Documentation(info = "<html>
<p>
This is a conventional single zone VAV HVAC system model. The system contains
a variable speed supply fan, electric heating coil, water-based cooling coil,
economizer, and air-cooled chiller. The control of the system is that of
conventional VAV heating and cooling. During cooling, the supply air
temperature is held constant while the supply air flow is modulated from
maximum to minimum according to zone load. This is done by modulating the
fan speed. During heating, the supply air flow is held at a constant minimum
while the heating coil is modulated accoding to zone load. The mass flow of
chilled water through the cooling coil is controlled by a three-way valve to
maintain the supply air temperature setpoint during cooling.
The mixing box maintains the minimum outside airflow fraction unless
conditions for economizer are met, in which case the economizer controller
adjusts the outside airflow fraction to meet a mixed air temperature setpoint.
The economizer is enabled if the outside air drybulb temperature is lower
than the return air temperature and the system is not in heating mode.
</p>
<p>
There are a number of assumptions in the model. Pressure drops through the
system are collected into a single component. The mass flow of return air
is equal to the mass flow of supply air. The mass flow of outside air and
relief air in the mixing box is ideally controlled so that the supply air is
composed of the specified outside airflow fraction, rather than having
feedback control of damper positions. The cooling coil is a dry coil model.
</p>
</html>", revisions = "<html>
<ul>
<li>
February 25, 2021, by Baptiste Ravache:<br/>
Inverse the sign of <code>cooCoi.Q_flow_nominal</code> to respect the heat flow convention.
</li>
<li>
September 08, 2017, by Thierry S. Nouidui:<br/>
Removed experiment annotation.
</li>
<li>
June 21, 2017, by Michael Wetter:<br/>
Refactored implementation.
</li>
<li>
June 1, 2017, by David Blum:<br/>
First implementation.
</li>
</ul>
</html>"));
end HPSystem;
