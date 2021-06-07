within Buildings.Examples.BoilerPlant.StepTest;
block StepTestModel_onlySimplified
  "Model to test step response of zone model"
  replaceable package MediumA =
      Buildings.Media.Air;

  replaceable package MediumW =
      Buildings.Media.Water
    "Medium model";

  parameter Modelica.SIunits.MassFlowRate mRad_flow_nominal=96.323
    "Radiator nominal mass flow rate"
    annotation(dialog(group="Radiator parameters"));

  parameter Real boiDesCap = 4359751.36/2;

  parameter Real boiCapRat = 1;

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
  PlantModel.BoilerPlant_Buffalo boiPla(
    boiCap1=4359751.36/2,
    boiCap2=4359751.36/2,
    mRad_flow_nominal=mRad_flow_nominal,
    TBoiSup_nominal=333.15,
    TBoiRet_min=323.15)
    annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
  Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Controller_baseline           controller(
    final have_priOnl=true,
    final have_varPriPum=true,
    final have_varSecPum=false,
    final nSenPri=1,
    final nPumPri_nominal=2,
    final nPumSec=0,
    final nSenSec=0,
    final nPumSec_nominal=0,
    TPlaHotWatSetMax=273.15 + 70,
    triAmoVal=-10e-6,
    resAmoVal=10e-6,
    maxResVal=10e-6,
    final VHotWatPri_flow_nominal=0.0006,
    final maxLocDpPri=4000,
    final minLocDpPri=4000,
    final VHotWatSec_flow_nominal=1e-6,
    final nBoi=2,
    final boiTyp={Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Types.BoilerTypes.condensingBoiler,
        Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Types.BoilerTypes.condensingBoiler},
    final nSta=3,
    final staMat=[1,0; 0,1; 1,1],
    final boiDesCap={boiCapRat*boiDesCap*0.8,(2 - boiCapRat)*boiDesCap*0.8},
    final boiFirMin={0.2,0.3},
    final minFloSet={0.2*boiCapRat*0.0003,0.3*(2 - boiCapRat)*0.0003},
    final maxFloSet={boiCapRat*0.0003,(2 - boiCapRat)*0.0003},
    final bypSetRat=0.000005,
    final nPumPri=2,
    final TMinSupNonConBoi=333.2,
    final k_bypVal=1,
    final Ti_bypVal=50,
    final Td_bypVal=10e-9,
    final boiDesFlo={boiCapRat*0.0003,(2 - boiCapRat)*0.0003},
    final k_priPum=1,
    final Ti_priPum=90,
    final Td_priPum=3,
    final minPriPumSpeSta={0,0,0},
    final speConTypPri=Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Types.PrimaryPumpSpeedControlTypes.remoteDP)
    "Boiler plant controller"
    annotation (Placement(transformation(extent={{-110,-48},{-90,20}})));

  Fluid.Actuators.Valves.TwoWayLinear           val3(
    redeclare package Medium = Media.Water,
    final m_flow_nominal=mRad_flow_nominal,
    final dpValve_nominal=0.1)
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
  Controls.OBC.CDL.Continuous.Hysteresis hys1(uLow=0.85, uHigh=0.9)
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
    Ti=30)
    "Radiator isolation valve controller"
    annotation (Placement(transformation(extent={{-20,80},{0,100}})));
  Controls.OBC.CDL.Continuous.Sources.Constant           con1(final k=273.15 + 1)
    "Zone temperature setpoint"
    annotation (Placement(transformation(extent={{-152,30},{-132,50}})));
  Controls.OBC.CDL.Discrete.UnitDelay uniDel(samplePeriod=1)
    annotation (Placement(transformation(extent={{-80,-48},{-60,-28}})));
  Controls.OBC.CDL.Routing.RealReplicator reaRep(nout=2)
    annotation (Placement(transformation(extent={{-50,-48},{-30,-28}})));
  Controls.OBC.CDL.Logical.Sources.Constant           con3[2](final k=fill(true,
        2))
    "Constant boiler availability status"
    annotation (Placement(transformation(extent={{-140,-140},{-120,-120}})));
equation
  connect(gai.y, zoneModel_simplified.u)
    annotation (Line(points={{-78,110},{-56,110},{-56,60},{-42,60}},
                                                 color={0,0,127}));
  connect(controller.yBoi, boiPla.uBoiSta) annotation (Line(points={{-88,0},{-80,
          0},{-80,-2},{-62,-2}}, color={255,0,255}));
  connect(controller.TBoiHotWatSupSet, boiPla.TBoiHotWatSupSet) annotation (
      Line(points={{-88,-4},{-80,-4},{-80,-18},{-62,-18}}, color={0,0,127}));
  connect(controller.yHotWatIsoVal, boiPla.uHotIsoVal) annotation (Line(points={
          {-88,-8},{-74,-8},{-74,-5},{-62,-5}}, color={0,0,127}));
  connect(controller.yPriPum, boiPla.uPumSta) annotation (Line(points={{-88,-16},
          {-72,-16},{-72,-8},{-62,-8}}, color={255,0,255}));
  connect(controller.yPriPumSpe, boiPla.uPumSpe) annotation (Line(points={{-88,-20},
          {-66,-20},{-66,-12},{-62,-12}}, color={0,0,127}));
  connect(controller.yBypValPos, boiPla.uBypValSig) annotation (Line(points={{-88,
          -12},{-68,-12},{-68,-15},{-62,-15}}, color={0,0,127}));
  connect(boiPla.port_b, val3.port_a) annotation (Line(points={{-56,0},{-56,8},{
          -80,8},{-80,40},{-70,40}}, color={0,127,255}));
  connect(val3.port_b, zoneModel_simplified.port_a) annotation (Line(points={{-50,
          40},{-42,40},{-42,50},{-34,50}}, color={0,127,255}));
  connect(zoneModel_simplified.port_b, boiPla.port_a) annotation (Line(points={{
          -26,50},{-26,20},{-44,20},{-44,0}}, color={0,127,255}));
  connect(boiPla.ySupTem, controller.TSupPri) annotation (Line(points={{-38,-1},
          {30,-1},{30,-60},{-130,-60},{-130,9},{-112,9}}, color={0,0,127}));
  connect(boiPla.yRetTem, controller.TRetPri) annotation (Line(points={{-38,-4},
          {28,-4},{28,-58},{-128,-58},{-128,6},{-112,6}}, color={0,0,127}));
  connect(boiPla.VHotWat_flow, controller.VHotWatPri_flow) annotation (Line(
        points={{-38,-10},{26,-10},{26,-56},{-126,-56},{-126,3},{-112,3}},
        color={0,0,127}));
  connect(boiPla.yHotWatDp, controller.dpHotWatPri_rem) annotation (Line(points=
         {{-38,-7},{24,-7},{24,-54},{-124,-54},{-124,-3},{-112,-3}}, color={0,0,
          127}));
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
  connect(booToInt1.y, controller.TSupResReq) annotation (Line(points={{102,60},
          {120,60},{120,-72},{-140,-72},{-140,18},{-112,18}}, color={255,127,0}));
  connect(booToInt.y, controller.supResReq) annotation (Line(points={{122,90},{130,
          90},{130,-80},{-150,-80},{-150,15},{-112,15}}, color={255,127,0}));
  connect(con1.y, controller.TOut) annotation (Line(points={{-130,40},{-120,40},
          {-120,12},{-112,12}}, color={0,0,127}));
  connect(boiPla.yBoiSta, controller.uBoi) annotation (Line(points={{-38,-13},{-10,
          -13},{-10,-14},{18,-14},{18,-52},{-120,-52},{-120,-31},{-112,-31}},
        color={255,0,255}));
  connect(boiPla.yPumSta, controller.uPriPum) annotation (Line(points={{-38,-16},
          {14,-16},{14,-50},{-118,-50},{-118,-34},{-112,-34}}, color={255,0,255}));
  connect(boiPla.yHotWatIsoVal, controller.uHotWatIsoVal) annotation (Line(
        points={{-38,-19},{-14,-19},{-14,-20},{12,-20},{12,-64},{-116,-64},{-116,
          -40},{-112,-40}}, color={0,0,127}));
  connect(boiPla.yBypValPos, controller.uBypValPos) annotation (Line(points={{-38,
          2},{20,2},{20,-68},{-114,-68},{-114,-43},{-112,-43}}, color={0,0,127}));
  connect(controller.yPriPumSpe, uniDel.u) annotation (Line(points={{-88,-20},{-86,
          -20},{-86,-38},{-82,-38}}, color={0,0,127}));
  connect(uniDel.y, reaRep.u)
    annotation (Line(points={{-58,-38},{-52,-38}}, color={0,0,127}));
  connect(reaRep.y, controller.uPriPumSpe) annotation (Line(points={{-28,-38},{-20,
          -38},{-20,-76},{-112,-76},{-112,-46}}, color={0,0,127}));
  connect(conPID.y, val3.y) annotation (Line(points={{2,90},{6,90},{6,116},{-60,
          116},{-60,52}}, color={0,0,127}));
  connect(combiTimeTable.y[1], gai.u)
    annotation (Line(points={{-119,110},{-102,110}},
                                                  color={0,0,127}));
  connect(con3.y, controller.uBoiAva) annotation (Line(points={{-118,-130},{
          -110,-130},{-110,-98},{-136,-98},{-136,-6},{-112,-6}}, color={255,0,
          255}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,-160},{160,160}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-160,-160},{160,
            160}})),
    experiment(
      StopTime=864000,
      Interval=60,
      __Dymola_Algorithm="Cvode"));
end StepTestModel_onlySimplified;
