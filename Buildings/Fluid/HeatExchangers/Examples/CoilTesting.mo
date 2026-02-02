within Buildings.Fluid.HeatExchangers.Examples;
model CoilTesting
  "Testing dry-heating coil"
  extends Modelica.Icons.Example;
  package MediumWat = Buildings.Media.Water "Medium model for water";
  package MediumAir = Buildings.Media.Air
    "Medium model for air";
  parameter Modelica.Units.SI.Temperature T_aWat_nominal=60 + 273.15
    "Nominal water inlet temperature";
  parameter Modelica.Units.SI.Temperature T_bWat_nominal=57.22 + 273.15
    "Nominal water outlet temperature";
  parameter Modelica.Units.SI.Temperature T_aAir_nominal=4 + 273.15
    "Nominal air inlet temperature";
  parameter Modelica.Units.SI.Temperature T_bAir_nominal=12.78 + 273.15
    "Nominal air outlet temperature";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal=mWat_flow_nominal*4200*
      (T_aWat_nominal - T_bWat_nominal) "Nominal heat transfer";
  parameter Modelica.Units.SI.MassFlowRate mWat_flow_nominal=5.4
    "Nominal mass flow rate medium 1";
  parameter Modelica.Units.SI.MassFlowRate mAir_flow_nominal=7.6
    "Nominal mass flow rate medium 2";
  DryCoilEffectivenessNTU                                hex(
    redeclare package Medium1 = MediumWat,
    redeclare package Medium2 = MediumAir,
    m1_flow_nominal=mWat_flow_nominal,
    m2_flow_nominal=mAir_flow_nominal,
    dp2_nominal(displayUnit="Pa") = 3000,
    configuration=Buildings.Fluid.Types.HeatExchangerConfiguration.CrossFlowStream1UnmixedStream2Mixed,
    allowFlowReversal1=true,
    allowFlowReversal2=true,
    dp1_nominal(displayUnit="Pa") = 3000,
    Q_flow_nominal=Q_flow_nominal,
    T_a1_nominal=T_aWat_nominal,
    T_a2_nominal=T_aAir_nominal,
    show_T=true)             annotation (Placement(transformation(extent={{-10,30},
            {10,50}})));
  DryCoilEffectivenessNTU                                hex1(
    redeclare package Medium1 = MediumAir,
    redeclare package Medium2 = MediumWat,
    m1_flow_nominal=mAir_flow_nominal,
    m2_flow_nominal=mWat_flow_nominal,
    dp2_nominal(displayUnit="Pa") = 3000,
    configuration=Buildings.Fluid.Types.HeatExchangerConfiguration.CrossFlowStream1MixedStream2Unmixed,
    allowFlowReversal1=true,
    allowFlowReversal2=true,
    dp1_nominal(displayUnit="Pa") = 3000,
    Q_flow_nominal=Q_flow_nominal,
    T_a1_nominal=T_aAir_nominal,
    T_a2_nominal=T_aWat_nominal,
    show_T=true)             annotation (Placement(transformation(extent={{-10,-30},
            {10,-50}})));
  Sources.MassFlowSource_T                 sin_2(
    X={0.01,0.99},
    T=T_aAir_nominal,
    nPorts=1,
    redeclare package Medium = MediumAir,
    use_m_flow_in=true) "Sink for air"
    annotation (Placement(transformation(extent={{-70,-70},{-50,-50}})));
  Sources.MassFlowSource_T                 sin_1(
    T=T_aWat_nominal,
    nPorts=1,
    redeclare package Medium = MediumWat,
    use_m_flow_in=true) "Sink for water"
    annotation (Placement(transformation(extent={{70,-30},{50,-10}})));
  Sources.Boundary_pT                 sou_2(
    nPorts=1,
    redeclare package Medium = MediumAir,
    T=T_bAir_nominal,
    X={0.01,1 - 0.01}) "Source for air"
    annotation (Placement(transformation(extent={{70,-70},{50,-50}})));
  Sources.Boundary_pT                 sou_1(
    nPorts=1,
    redeclare package Medium = MediumWat,
    use_T_in=false,
    T=T_bWat_nominal)
                    "Source for water"
    annotation (Placement(transformation(extent={{-70,-30},{-50,-10}})));
  Modelica.Blocks.Math.Gain mAir_flow(k=mAir_flow_nominal)
                                                          "Air mass flow rate"
    annotation (Placement(transformation(extent={{-120,-70},{-100,-50}})));
  Modelica.Blocks.Math.Gain mWat_flow(k=mWat_flow_nominal)
    "Water mass flow rate"
    annotation (Placement(transformation(extent={{120,-30},{100,-10}})));
  Sources.Boundary_pT                 sou_3(
    nPorts=1,
    redeclare package Medium = MediumWat,
    use_T_in=false,
    T=T_bWat_nominal)
                    "Source for water"
    annotation (Placement(transformation(extent={{70,50},{50,70}})));
  Sources.MassFlowSource_T                 sin_4(
    nPorts=1,
    redeclare package Medium = MediumWat,
    T=T_aWat_nominal,
    use_m_flow_in=true) "Sink for water"
    annotation (Placement(transformation(extent={{-70,50},{-50,70}})));
  Sources.Boundary_pT                 sou_4(
    nPorts=1,
    redeclare package Medium = MediumAir,
    T=T_bAir_nominal) "Source for air"
    annotation (Placement(transformation(extent={{-70,10},{-50,30}})));
  Modelica.Blocks.Math.Gain mWat_flow1(k=mWat_flow_nominal)
    "Water mass flow rate"
    annotation (Placement(transformation(extent={{-120,50},{-100,70}})));
  Sources.MassFlowSource_T                 sin_3(
    X={0.01,0.99},
    nPorts=1,
    redeclare package Medium = MediumAir,
    T=T_aAir_nominal,
    use_m_flow_in=true) "Sink for air"
    annotation (Placement(transformation(extent={{70,10},{50,30}})));
  Modelica.Blocks.Math.Gain mAir_flow1(k=mAir_flow_nominal)
                                                          "Air mass flow rate"
    annotation (Placement(transformation(extent={{120,10},{100,30}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.TimeTable mAirGai1(table=[0,0; 1,0.1; 2,0.2; 3,0.3; 4,
        0.4; 5,0.5; 6,0.6; 7,0.7; 8,0.8; 9,0.9; 10,1],
    smoothness=Buildings.Controls.OBC.CDL.Types.Smoothness.ConstantSegments,
    extrapolation=Buildings.Controls.OBC.CDL.Types.Extrapolation.HoldLastPoint,
            timeScale=3600)
    "Gain for air mass flow rate"
    annotation (Placement(transformation(extent={{160,10},{140,30}})));
  Controls.OBC.CDL.Reals.Sources.Constant con(k=1)
    annotation (Placement(transformation(extent={{-160,50},{-140,70}})));
  Controls.OBC.CDL.Reals.Sources.Constant con1(k=1)
    annotation (Placement(transformation(extent={{160,-30},{140,-10}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.TimeTable mAirGai2(table=[0,0; 1,0.1; 2,0.2; 3,0.3; 4,
        0.4; 5,0.5; 6,0.6; 7,0.7; 8,0.8; 9,0.9; 10,1],
    smoothness=Buildings.Controls.OBC.CDL.Types.Smoothness.ConstantSegments,
    extrapolation=Buildings.Controls.OBC.CDL.Types.Extrapolation.HoldLastPoint,
                                                  timeScale=3600)
    "Gain for air mass flow rate"
    annotation (Placement(transformation(extent={{-160,-70},{-140,-50}})));
  Sensors.TemperatureTwoPort senTem(redeclare package Medium = MediumWat,
      m_flow_nominal=mWat_flow_nominal)
    annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
  Sensors.TemperatureTwoPort senTem1(redeclare package Medium = MediumWat,
      m_flow_nominal=mWat_flow_nominal)
    annotation (Placement(transformation(extent={{20,50},{40,70}})));
  Sensors.TemperatureTwoPort senTem2(redeclare package Medium = MediumAir,
      m_flow_nominal=mAir_flow_nominal)
    annotation (Placement(transformation(extent={{40,10},{20,30}})));
  Sensors.TemperatureTwoPort senTem3(redeclare package Medium = MediumAir,
      m_flow_nominal=mAir_flow_nominal)
    annotation (Placement(transformation(extent={{-20,10},{-40,30}})));
  Sensors.TemperatureTwoPort senTem4(redeclare package Medium = MediumWat,
      m_flow_nominal=mWat_flow_nominal)
    annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
  Sensors.TemperatureTwoPort senTem5(redeclare package Medium = MediumWat,
      m_flow_nominal=mWat_flow_nominal)
    annotation (Placement(transformation(extent={{20,-30},{40,-10}})));
  Sensors.TemperatureTwoPort senTem6(redeclare package Medium = MediumAir,
      m_flow_nominal=mAir_flow_nominal)
    annotation (Placement(transformation(extent={{-20,-70},{-40,-50}})));
  Sensors.TemperatureTwoPort senTem7(redeclare package Medium = MediumAir,
      m_flow_nominal=mAir_flow_nominal)
    annotation (Placement(transformation(extent={{40,-70},{20,-50}})));
equation
  connect(mWat_flow.y, sin_1.m_flow_in) annotation (Line(points={{99,-20},{80,-20},
          {80,-12},{72,-12}}, color={0,0,127}));
  connect(mAir_flow.y, sin_2.m_flow_in) annotation (Line(points={{-99,-60},{-82,
          -60},{-82,-52},{-72,-52}}, color={0,0,127}));
  connect(mWat_flow1.y, sin_4.m_flow_in) annotation (Line(points={{-99,60},{-82,
          60},{-82,68},{-72,68}}, color={0,0,127}));
  connect(mAir_flow1.y, sin_3.m_flow_in) annotation (Line(points={{99,20},{82,20},
          {82,28},{72,28}}, color={0,0,127}));
  connect(con.y, mWat_flow1.u)
    annotation (Line(points={{-138,60},{-122,60}}, color={0,0,127}));
  connect(con1.y, mWat_flow.u)
    annotation (Line(points={{138,-20},{122,-20}}, color={0,0,127}));
  connect(sin_4.ports[1], senTem.port_a)
    annotation (Line(points={{-50,60},{-40,60}}, color={0,127,255}));
  connect(senTem.port_b, hex.port_a1)
    annotation (Line(points={{-20,60},{-20,46},{-10,46}}, color={0,127,255}));
  connect(hex.port_b1, senTem1.port_a)
    annotation (Line(points={{10,46},{20,46},{20,60}}, color={0,127,255}));
  connect(senTem1.port_b, sou_3.ports[1])
    annotation (Line(points={{40,60},{50,60}}, color={0,127,255}));
  connect(sin_3.ports[1], senTem2.port_a)
    annotation (Line(points={{50,20},{40,20}}, color={0,127,255}));
  connect(senTem2.port_b, hex.port_a2)
    annotation (Line(points={{20,20},{20,34},{10,34}}, color={0,127,255}));
  connect(sou_4.ports[1], senTem3.port_b)
    annotation (Line(points={{-50,20},{-40,20}}, color={0,127,255}));
  connect(senTem3.port_a, hex.port_b2)
    annotation (Line(points={{-20,20},{-20,34},{-10,34}}, color={0,127,255}));
  connect(sou_1.ports[1], senTem4.port_a)
    annotation (Line(points={{-50,-20},{-40,-20}}, color={0,127,255}));
  connect(senTem4.port_b, hex1.port_b2) annotation (Line(points={{-20,-20},{-20,
          -34},{-10,-34}}, color={0,127,255}));
  connect(sin_1.ports[1], senTem5.port_b)
    annotation (Line(points={{50,-20},{40,-20}}, color={0,127,255}));
  connect(senTem5.port_a, hex1.port_a2)
    annotation (Line(points={{20,-20},{20,-34},{10,-34}}, color={0,127,255}));
  connect(sin_2.ports[1], senTem6.port_b)
    annotation (Line(points={{-50,-60},{-40,-60}}, color={0,127,255}));
  connect(senTem6.port_a, hex1.port_a1) annotation (Line(points={{-20,-60},{-20,
          -46},{-10,-46}}, color={0,127,255}));
  connect(hex1.port_b1, senTem7.port_b)
    annotation (Line(points={{10,-46},{20,-46},{20,-60}}, color={0,127,255}));
  connect(senTem7.port_a, sou_2.ports[1])
    annotation (Line(points={{40,-60},{50,-60}}, color={0,127,255}));
  connect(mAirGai2.y[1], mAir_flow.u)
    annotation (Line(points={{-138,-60},{-122,-60}}, color={0,0,127}));
  connect(mAirGai1.y[1], mAir_flow1.u)
    annotation (Line(points={{138,20},{122,20}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}})),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-180,-120},{180,120}})),
    experiment(
      StopTime=39600,
      Tolerance=1e-05,
      __Dymola_Algorithm="Cvode"));
end CoilTesting;
