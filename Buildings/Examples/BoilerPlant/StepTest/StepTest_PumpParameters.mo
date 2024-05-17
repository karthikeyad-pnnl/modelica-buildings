within Buildings.Examples.BoilerPlant.StepTest;
block StepTest_PumpParameters
  "Model to test step response of zone model"
  replaceable package MediumA =
      Buildings.Media.Air;

  replaceable package MediumW =
      Buildings.Media.Water
    "Medium model";

  parameter Modelica.Units.SI.MassFlowRate mRad_flow_nominal=96.323
    "Radiator nominal mass flow rate"
    annotation(dialog(group="Radiator parameters"));

  parameter Real boiDesCap = 4359751.36;

  parameter Real boiCapRat = 0.3/4.3;

  Fluid.FixedResistances.PressureDrop res(
    redeclare package Medium = Media.Water,
    m_flow_nominal=mRad_flow_nominal,
    dp_nominal=20100)
    annotation (Placement(transformation(extent={{30,120},{50,140}})));
  Fluid.Sources.Boundary_pT bou1(
    redeclare package Medium = Media.Water,
    p=1500000,
    T=293.15,
    nPorts=1) annotation (Placement(transformation(extent={{120,-120},{140,-100}})));
  Fluid.Movers.SpeedControlled_y           pum(
    redeclare package Medium = Media.Water,
    final allowFlowReversal=true,
    redeclare Fluid.Movers.Data.Pumps.Wilo.customPumpCurves_Buffalo per,
    final inputType=Buildings.Fluid.Types.InputType.Continuous,
    final addPowerToMedium=false,
    final riseTime=60)
    "Hot water primary pump-1"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
      rotation=90,
      origin={-60,30})));
  Fluid.Movers.SpeedControlled_y           pum1(
    redeclare package Medium = Media.Water,
    final allowFlowReversal=true,
    redeclare Fluid.Movers.Data.Pumps.Wilo.customPumpCurves_Buffalo per,
    final inputType=Buildings.Fluid.Types.InputType.Continuous,
    final addPowerToMedium=false,
    final riseTime=60)
    "Hot water primary pump-2"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
      rotation=90,
      origin={20,30})));
  Fluid.Actuators.Valves.TwoWayLinear           val4(
    redeclare package Medium = Media.Water,
    final m_flow_nominal=mRad_flow_nominal/2,
    final dpValve_nominal=0.1,
    riseTime=15)               "Valve to prevent reverse flow through pump"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
      rotation=90,
        origin={-60,0})));
  Fluid.Actuators.Valves.TwoWayLinear                     val5(
    redeclare package Medium = Media.Water,
    final m_flow_nominal=mRad_flow_nominal/2,
    final dpValve_nominal=0.1,
    riseTime=15)               "Valve to prevent reverse flow through pump"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
      rotation=90,
        origin={20,0})));
  Fluid.FixedResistances.Junction           spl2(
    redeclare package Medium = MediumW,
    final energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    final m_flow_nominal={mRad_flow_nominal,-mRad_flow_nominal/2,-
        mRad_flow_nominal/2},
    final dp_nominal={0,0,-200})
    "Splitter"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
      rotation=90,
      origin={-20,-30})));
  Fluid.FixedResistances.Junction           spl3(
    redeclare package Medium = MediumW,
    final energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    final m_flow_nominal={mRad_flow_nominal/2,-mRad_flow_nominal,
        mRad_flow_nominal/2},
    final dp_nominal={0,0,-200})
    "Splitter"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
      rotation=90,
      origin={-20,70})));
  Fluid.FixedResistances.PressureDrop res1(
    redeclare package Medium = Media.Water,
    m_flow_nominal=mRad_flow_nominal,
    dp_nominal=5000)
    annotation (Placement(transformation(extent={{40,-90},{60,-70}})));
  Fluid.FixedResistances.PressureDrop res2(
    redeclare package Medium = Media.Water,
    m_flow_nominal=mRad_flow_nominal,
    dp_nominal=5000)
    annotation (Placement(transformation(extent={{40,-150},{60,-130}})));
  Fluid.FixedResistances.Junction           spl6(
    redeclare package Medium = MediumW,
    final energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    final m_flow_nominal={-mRad_flow_nominal,mRad_flow_nominal,-
        mRad_flow_nominal},
    final dp_nominal={0,0,-200})
    "Splitter"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
      rotation=0,
      origin={90,-80})));
  Fluid.FixedResistances.Junction           spl1(
    redeclare package Medium = MediumW,
    final energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    final m_flow_nominal={mRad_flow_nominal,-mRad_flow_nominal,
        mRad_flow_nominal},
    final dp_nominal={0,0,-200})
    "Splitter"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
      rotation=90,
      origin={-20,-80})));
  Fluid.Actuators.Valves.TwoWayLinear           val2(
    redeclare package Medium = Media.Water,
    final m_flow_nominal=mRad_flow_nominal,
    final dpValve_nominal=0.1,
    init=Modelica.Blocks.Types.Init.InitialState,
    y_start=0)
    "Isolation valve for boiler-1"
    annotation (Placement(transformation(extent={{10,-90},{30,-70}})));
  Fluid.Actuators.Valves.TwoWayLinear           val1(
    redeclare package Medium = Media.Water,
    final m_flow_nominal=mRad_flow_nominal,
    final dpValve_nominal=0.1,
    init=Modelica.Blocks.Types.Init.InitialState,
    y_start=0)
    "Isolation valve for boiler-2"
    annotation (Placement(transformation(extent={{10,-150},{30,-130}})));
  Fluid.Sensors.RelativePressure           senRelPre(redeclare package Medium =
        Media.Water)
    "Differential pressure sensor between hot water supply and return"
    annotation (Placement(transformation(extent={{60,80},{80,100}})));
  Fluid.Actuators.Valves.TwoWayLinear           val3(
    redeclare package Medium = Media.Water,
    final m_flow_nominal=mRad_flow_nominal,
    final dpValve_nominal=0.1,
    use_inputFilter=false,
    l=10e-10)
    "Isolation valve for radiator"
    annotation (Placement(transformation(extent={{-20,120},{0,140}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con(k=0.00025)
    annotation (Placement(transformation(extent={{-100,130},{-80,150}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con1(k=4000)
    annotation (Placement(transformation(extent={{-100,90},{-80,110}})));
  Buildings.Controls.OBC.CDL.Reals.PID conPID(
    controllerType=Buildings.Controls.OBC.CDL.Types.SimpleController.PI,
    k=0.25*10e-3,
    Ti=45,
    Td=3,
    yMax=1,
    yMin=0.1) annotation (Placement(transformation(extent={{40,50},{60,70}})));
  Buildings.Controls.OBC.CDL.Routing.RealScalarReplicator reaRep(nout=2)
    annotation (Placement(transformation(extent={{80,50},{100,70}})));
  Buildings.Controls.OBC.CDL.Reals.Product pro[2]
    annotation (Placement(transformation(extent={{-110,20},{-90,40}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Pulse pul[2](period={1800,3600})
    annotation (Placement(transformation(extent={{-150,80},{-130,100}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Pulse pul1[2](period={7200,14400})
    annotation (Placement(transformation(extent={{-120,-80},{-100,-60}})));
equation
  connect(pum.port_b,spl3. port_1) annotation (Line(points={{-60,40},{-60,50},{-20,
          50},{-20,60}},        color={0,127,255}));
  connect(pum1.port_b,spl3. port_3)
    annotation (Line(points={{20,40},{20,70},{-10,70}},color={0,127,255}));
  connect(val4.port_b,pum. port_a)
    annotation (Line(points={{-60,10},{-60,20}},   color={0,127,255}));
  connect(val5.port_b,pum1. port_a)
    annotation (Line(points={{20,10},{20,20}},   color={0,127,255}));
  connect(spl2.port_3,val5. port_a) annotation (Line(points={{-10,-30},{20,-30},
          {20,-10}}, color={0,127,255}));
  connect(spl2.port_2,val4. port_a) annotation (Line(points={{-20,-20},{-20,-16},
          {-60,-16},{-60,-10}}, color={0,127,255}));
  connect(val1.port_a,spl1. port_1) annotation (Line(points={{10,-140},{-20,-140},
          {-20,-90}},         color={0,127,255}));
  connect(val2.port_a,spl1. port_3)
    annotation (Line(points={{10,-80},{-10,-80}},     color={0,127,255}));
  connect(spl1.port_2, spl2.port_1)
    annotation (Line(points={{-20,-70},{-20,-40}}, color={0,127,255}));
  connect(res1.port_b, spl6.port_1)
    annotation (Line(points={{60,-80},{80,-80}}, color={0,127,255}));
  connect(val2.port_b, res1.port_a)
    annotation (Line(points={{30,-80},{40,-80}}, color={0,127,255}));
  connect(val1.port_b, res2.port_a)
    annotation (Line(points={{30,-140},{40,-140}}, color={0,127,255}));
  connect(res2.port_b, spl6.port_3) annotation (Line(points={{60,-140},{90,-140},
          {90,-90}}, color={0,127,255}));
  connect(spl6.port_2, bou1.ports[1]) annotation (Line(points={{100,-80},{150,-80},
          {150,-110},{140,-110}}, color={0,127,255}));
  connect(senRelPre.port_a, spl3.port_2)
    annotation (Line(points={{60,90},{-20,90},{-20,80}}, color={0,127,255}));
  connect(senRelPre.port_b, res.port_b)
    annotation (Line(points={{80,90},{80,130},{50,130}}, color={0,127,255}));
  connect(res.port_b, spl6.port_2) annotation (Line(points={{50,130},{120,130},{
          120,-80},{100,-80}}, color={0,127,255}));
  connect(spl3.port_2, val3.port_a)
    annotation (Line(points={{-20,80},{-20,130}}, color={0,127,255}));
  connect(val3.port_b, res.port_a)
    annotation (Line(points={{0,130},{30,130}}, color={0,127,255}));
  connect(con.y, val3.y) annotation (Line(points={{-78,140},{-60,140},{-60,150},
          {-10,150},{-10,142}}, color={0,0,127}));
  connect(con1.y, conPID.u_s) annotation (Line(points={{-78,100},{30,100},{30,60},
          {38,60}}, color={0,0,127}));
  connect(senRelPre.p_rel, conPID.u_m) annotation (Line(points={{70,81},{70,40},
          {50,40},{50,48}}, color={0,0,127}));
  connect(conPID.y, reaRep.u)
    annotation (Line(points={{62,60},{78,60}}, color={0,0,127}));
  connect(reaRep.y, pro.u2) annotation (Line(points={{102,60},{110,60},{110,-50},
          {-140,-50},{-140,24},{-112,24}}, color={0,0,127}));
  connect(pro[1].y, pum.y)
    annotation (Line(points={{-88,30},{-72,30}}, color={0,0,127}));
  connect(pro[2].y, pum1.y) annotation (Line(points={{-88,30},{-80,30},{-80,44},
          {0,44},{0,30},{8,30}}, color={0,0,127}));
  connect(pul.y, pro.u1) annotation (Line(points={{-128,90},{-120,90},{-120,36},
          {-112,36}}, color={0,0,127}));
  connect(pul[1].y, val4.y) annotation (Line(points={{-128,90},{-120,90},{-120,0},
          {-72,0}}, color={0,0,127}));
  connect(pul[2].y, val5.y) annotation (Line(points={{-128,90},{-120,90},{-120,14},
          {-20,14},{-20,0},{8,0}}, color={0,0,127}));
  connect(pul1[1].y, val2.y) annotation (Line(points={{-98,-70},{-50,-70},{-50,-60},
          {20,-60},{20,-68}}, color={0,0,127}));
  connect(pul1[2].y, val1.y) annotation (Line(points={{-98,-70},{-50,-70},{-50,-120},
          {20,-120},{20,-128}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,-160},{160,160}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-160,-160},{160,
            160}})),
    experiment(
      StopTime=28800,
      Interval=60,
      __Dymola_Algorithm="Cvode"));
end StepTest_PumpParameters;
