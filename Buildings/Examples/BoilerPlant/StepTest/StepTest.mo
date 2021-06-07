within Buildings.Examples.BoilerPlant.StepTest;
block StepTest "Model to test step response of zone model"
  replaceable package MediumA =
      Buildings.Media.Air;

  replaceable package MediumW =
      Buildings.Media.Water
    "Medium model";

  parameter Modelica.SIunits.MassFlowRate mRad_flow_nominal=113.45
    "Radiator nominal mass flow rate"
    annotation(dialog(group="Radiator parameters"));

  parameter Real boiDesCap = 4359751.36;

  parameter Real boiCapRat = 0.3/4.3;

  PlantModel.ZoneModel_simplified zoneModel_simplified(
    Q_flow_nominal=4359751.36,
    TRadSup_nominal=333.15,
    TRadRet_nominal=323.15,
    mRad_flow_nominal=96.323,
    V=126016.35,
    zonTheCap=6987976290)
    annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
    tableOnFile=true,
    tableName="tab1",
    fileName="C:/Users/deva713/OneDrive - PNNL/Documents/Git_repos/modelica-buildings/VM_script/inputTableTxt.txt",
    verboseRead=true,
    columns={9},
    timeScale=60) "Boiler thermal load from EnergyPlus simulation"
    annotation (Placement(transformation(extent={{-140,100},{-120,120}})));

  Controls.OBC.CDL.Continuous.Gain gai(k=-1)
    annotation (Placement(transformation(extent={{-100,100},{-80,120}})));

  Fluid.Actuators.Valves.TwoWayLinear           val3(
    redeclare package Medium = Media.Water,
    final m_flow_nominal=mRad_flow_nominal,
    final dpValve_nominal=0.1,
    y_start=0,
    l=10e-10)
    "Isolation valve for radiator"
    annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
  Controls.OBC.CDL.Continuous.Sources.Constant           con(final k=273.15 + 21.11)
    "Zone temperature setpoint"
    annotation (Placement(transformation(extent={{-50,80},{-30,100}})));
  Controls.OBC.CDL.Continuous.Hysteresis hys(uLow=0.01, uHigh=0.05)
    "Check if radiator control valve opening is above threshold for enabling boiler plant"
    annotation (Placement(transformation(extent={{10,130},{30,150}})));
  Controls.OBC.CDL.Logical.Timer tim(t=30) "Timer"
    annotation (Placement(transformation(extent={{40,130},{60,150}})));
  Controls.OBC.CDL.Conversions.BooleanToInteger booToInt
    annotation (Placement(transformation(extent={{100,80},{120,100}})));
  Controls.OBC.CDL.Continuous.Hysteresis hys1(uLow=0.00045, uHigh=0.00046)
    "Check if radiator control valve opening is above threshold for rasing HHW supply temperature"
    annotation (Placement(transformation(extent={{20,50},{40,70}})));
  Controls.OBC.CDL.Logical.Timer tim1(t=30) "Timer"
    annotation (Placement(transformation(extent={{50,50},{70,70}})));
  Controls.OBC.CDL.Conversions.BooleanToInteger booToInt1(integerTrue=3)
    annotation (Placement(transformation(extent={{80,50},{100,70}})));
  Controls.OBC.CDL.Logical.Latch lat
    annotation (Placement(transformation(extent={{70,130},{90,150}})));
  Controls.OBC.CDL.Logical.Timer tim2(t=60) "Timer"
    annotation (Placement(transformation(extent={{50,90},{70,110}})));
  Controls.OBC.CDL.Logical.Not not1
    annotation (Placement(transformation(extent={{20,90},{40,110}})));
  Controls.OBC.CDL.Continuous.PID           conPID(
    final controllerType=Buildings.Controls.OBC.CDL.Types.SimpleController.PI,
    final k=1*10e-4,
    Ti=10000)
    "Radiator isolation valve controller"
    annotation (Placement(transformation(extent={{-20,80},{0,100}})));
  Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = Media.Water,
    m_flow=mRad_flow_nominal,
    use_T_in=true,
    T=343.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));
  Fluid.FixedResistances.PressureDrop res(
    redeclare package Medium = Media.Water,
    m_flow_nominal=mRad_flow_nominal,
    dp_nominal=20000.1)
    annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  Fluid.Sources.Boundary_pT bou(
    redeclare package Medium = Media.Water,
    p=1500000,
    T=293.15,
    nPorts=2) annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Controls.OBC.CDL.Continuous.Sources.Sine sin(
    amplitude=19,
    freqHz=1/35956,
    offset=324.15)
    annotation (Placement(transformation(extent={{-150,60},{-130,80}})));
  Controls.OBC.CDL.Integers.Sources.Constant conInt(k=1)
    annotation (Placement(transformation(extent={{-150,-140},{-130,-120}})));
  Controls.OBC.CDL.Logical.Sources.Constant con1[2](k=fill(true, 2))
    annotation (Placement(transformation(extent={{-160,-70},{-140,-50}})));
  Controls.OBC.CDL.Logical.Not not2
    annotation (Placement(transformation(extent={{-130,-90},{-110,-70}})));

  Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.SetPoints.HotWaterSupplyTemperatureReset           hotWatSupTemRes(
    final nPum=2,
    final nSta=1,
    final nBoi=1,
    final nHotWatResReqIgn=2,
    final boiTyp={1},
    final TPlaHotWatSetMax=273.15 + 70,
    final TConBoiHotWatSetMax=353.15,
    final TConBoiHotWatSetOff=0,
    final THotWatSetMinNonConBoi=341.48,
    final THotWatSetMinConBoi=305.37,
    final delTimVal=600,
    final samPerVal=300,
    final triAmoVal=-1.111,
    final resAmoVal=1.667,
    final maxResVal=3.889,
    final holTimVal=0)
    "Hot water supply temperature setpoint reset controller"
    annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
equation
  connect(gai.y, zoneModel_simplified.u)
    annotation (Line(points={{-78,110},{-56,110},{-56,60},{-42,60}},
                                                 color={0,0,127}));
  connect(val3.port_b, zoneModel_simplified.port_a) annotation (Line(points={{-50,
          40},{-42,40},{-42,50},{-34,50}}, color={0,127,255}));
  connect(con.y,conPID. u_s)
    annotation (Line(points={{-28,90},{-22,90}},
                                               color={0,0,127}));
  connect(conPID.y,hys. u) annotation (Line(points={{2,90},{6,90},{6,140},{8,140}},
                 color={0,0,127}));
  connect(hys.y,tim. u)
    annotation (Line(points={{32,140},{38,140}},   color={255,0,255}));
  connect(booToInt.u,lat. y) annotation (Line(points={{98,90},{96,90},{96,140},{
          92,140}},   color={255,0,255}));
  connect(tim.passed,lat. u) annotation (Line(points={{62,132},{64,132},{64,140},
          {68,140}},  color={255,0,255}));
  connect(tim2.u,not1. y)
    annotation (Line(points={{48,100},{42,100}}, color={255,0,255}));
  connect(hys.y,not1. u) annotation (Line(points={{32,140},{34,140},{34,118},{14,
          118},{14,100},{18,100}}, color={255,0,255}));
  connect(tim2.passed,lat. clr) annotation (Line(points={{72,92},{80,92},{80,118},
          {66,118},{66,134},{68,134}},       color={255,0,255}));
  connect(zoneModel_simplified.y, conPID.u_m)
    annotation (Line(points={{-18,60},{-10,60},{-10,78}}, color={0,0,127}));
  connect(conPID.y, hys1.u)
    annotation (Line(points={{2,90},{6,90},{6,60},{18,60}}, color={0,0,127}));
  connect(hys1.y, tim1.u)
    annotation (Line(points={{42,60},{48,60}}, color={255,0,255}));
  connect(tim1.passed, booToInt1.u) annotation (Line(points={{72,52},{76,52},{76,
          60},{78,60}}, color={255,0,255}));
  connect(conPID.y, val3.y) annotation (Line(points={{2,90},{6,90},{6,116},{-60,
          116},{-60,52}}, color={0,0,127}));
  connect(boundary.ports[1], val3.port_a) annotation (Line(points={{-100,2},{-90,
          2},{-90,40},{-70,40}}, color={0,127,255}));
  connect(boundary.ports[2], res.port_a) annotation (Line(points={{-100,-2},{-86,
          -2},{-86,0},{-70,0}}, color={0,127,255}));
  connect(res.port_b, bou.ports[1]) annotation (Line(points={{-50,0},{-28,0},{-28,
          -20},{12,-20},{12,2},{0,2}}, color={0,127,255}));
  connect(zoneModel_simplified.port_b, bou.ports[2]) annotation (Line(points={{-26,
          50},{-26,40},{20,40},{20,-2},{0,-2}}, color={0,127,255}));
  connect(combiTimeTable.y[1], gai.u)
    annotation (Line(points={{-119,110},{-102,110}}, color={0,0,127}));
  connect(hotWatSupTemRes.TPlaHotWatSupSet, boundary.T_in) annotation (Line(
        points={{-58,-66},{-50,-66},{-50,-40},{-140,-40},{-140,4},{-122,4}},
        color={0,0,127}));
  connect(booToInt1.y, hotWatSupTemRes.nHotWatSupResReq) annotation (Line(
        points={{102,60},{120,60},{120,-90},{-100,-90},{-100,-66},{-82,-66}},
        color={255,127,0}));
  connect(conInt.y, hotWatSupTemRes.uTyp[1]) annotation (Line(points={{-128,-130},
          {-90,-130},{-90,-74},{-82,-74}}, color={255,127,0}));
  connect(conInt.y, hotWatSupTemRes.uCurStaSet) annotation (Line(points={{-128,-130},
          {-90,-130},{-90,-78},{-82,-78}}, color={255,127,0}));
  connect(not2.y, hotWatSupTemRes.uStaCha) annotation (Line(points={{-108,-80},{
          -94,-80},{-94,-70},{-82,-70}}, color={255,0,255}));
  connect(con1.y, hotWatSupTemRes.uHotWatPumSta) annotation (Line(points={{-138,
          -60},{-94,-60},{-94,-62},{-82,-62}}, color={255,0,255}));
  connect(con1[1].y, not2.u) annotation (Line(points={{-138,-60},{-136,-60},{-136,
          -80},{-132,-80}}, color={255,0,255}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,-160},{160,160}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-160,-160},{160,
            160}})),
    experiment(
      StopTime=864000,
      Interval=60,
      __Dymola_Algorithm="Cvode"));
end StepTest;
