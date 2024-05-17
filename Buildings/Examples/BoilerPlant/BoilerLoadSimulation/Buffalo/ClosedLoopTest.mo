within Buildings.Examples.BoilerPlant.BoilerLoadSimulation.Buffalo;
block ClosedLoopTest "Model to test step response of zone model"
  replaceable package MediumA =
      Buildings.Media.Air;

  replaceable package MediumW =
      Buildings.Media.Water
    "Medium model";

  parameter Modelica.Units.SI.MassFlowRate mRad_flow_nominal=96.323
    "Radiator nominal mass flow rate"
    annotation(dialog(group="Radiator parameters"));

  parameter Real boiDesCap = 4359751.36;

  parameter Real boiCapRat = 2/4.3;

  PlantModel.ZoneModel_simplified zoneModel_simplified(
    Q_flow_nominal=4359751.36,
    TRadSup_nominal=333.15,
    TRadRet_nominal=323.15,
    mRad_flow_nominal=96.323,
    V=126016.35,
    zonTheCap=6987976290,
    vol(T_start=283.15),
    heaCap(T(start=10)),
    rad(dp_nominal=40000))
    annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
    tableOnFile=true,
    tableName="tab1",
    fileName=
        "C:/buildings_library/buildings_library_pnnl/VM_script/inputTableTxt.txt",
    verboseRead=true,
    columns={2,5},
    timeScale=60) "Boiler thermal load from EnergyPlus simulation"
    annotation (Placement(transformation(extent={{-140,100},{-120,120}})));

  Buildings.Controls.OBC.CDL.Reals.Gain gai(k=-1)
    annotation (Placement(transformation(extent={{-100,100},{-80,120}})));
  Buildings.Examples.BoilerPlant.PlantModel.BoilerPlant_Buffalo_NonAdiabaticPipe_dPMover boiPla(
    boiCap1=(1 - boiCapRat)*boiDesCap,
    boiCap2=(boiCapRat)*boiDesCap,
    mRad_flow_nominal=mRad_flow_nominal,
    TBoiSup_nominal=333.15,
    TBoiRet_min=323.15,
    conPID(
      controllerType=Buildings.Controls.OBC.CDL.Types.SimpleController.PI,
      k=fill(10e-3, 2),
      Ti=fill(90, 2)),
    dpValve_nominal_value(displayUnit="bar") = 20000,
    dpFixed_nominal_value(displayUnit="bar") = 1000)
    annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Controller           controller(
    final have_priOnl=true,
    final have_varPriPum=true,
    final have_varSecPum=false,
    final nSenPri=1,
    final nPumPri_nominal=2,
    final nPumSec=0,
    final nSenSec=0,
    final nPumSec_nominal=0,
    TPlaHotWatSetMax=273.15 + 70,
    triAmoVal=-1.111,
    resAmoVal=1.667,
    maxResVal=3.889,
    final VHotWatPri_flow_nominal=0.02,
    final maxLocDpPri=4000,
    final minLocDpPri=4000,
    final VHotWatSec_flow_nominal=1e-6,
    final nBoi=2,
    final boiTyp={Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Types.BoilerTypes.condensingBoiler,
        Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Types.BoilerTypes.condensingBoiler},
    final nSta=3,
    final staMat=[1,0; 0,1; 1,1],
    final boiDesCap={boiCapRat*boiDesCap,(1 - boiCapRat)*boiDesCap},
    final boiFirMin={0.2,0.3},
    final minFloSet={0.2*boiCapRat*mRad_flow_nominal/2000,0.3*(1 - boiCapRat)*
        mRad_flow_nominal/2000},
    final maxFloSet={boiCapRat*mRad_flow_nominal/2000,(1 - boiCapRat)*
        mRad_flow_nominal/2000},
    final bypSetRat=0.000005,
    final nPumPri=2,
    final TMinSupNonConBoi=333.2,
    final k_bypVal=1,
    final Ti_bypVal=90,
    final Td_bypVal=10e-9,
    final boiDesFlo=controller.maxFloSet,
    final k_priPum=1,
    final Ti_priPum=75,
    final Td_priPum=3,
    final minPriPumSpeSta={0,0,0},
    final speConTypPri=Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Types.PrimaryPumpSpeedControlTypes.remoteDP)
    "Boiler plant controller"
    annotation (Placement(transformation(extent={{-110,-48},{-90,20}})));

  Fluid.Actuators.Valves.TwoWayLinear           val3(
    redeclare package Medium = Media.Water,
    final m_flow_nominal=mRad_flow_nominal,
    deltaM=0.1,
    final dpValve_nominal=6000,
    use_inputFilter=true,
    y_start=0,
    dpFixed_nominal=1000,
    l=10e-10)
    "Isolation valve for radiator"
    annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant           con(final k=21.11)
    "Zone temperature setpoint"
    annotation (Placement(transformation(extent={{-140,130},{-120,150}})));
  Buildings.Controls.OBC.CDL.Reals.Hysteresis hys(uLow=0.05, uHigh=0.1)
    "Check if radiator control valve opening is above threshold for enabling boiler plant"
    annotation (Placement(transformation(extent={{10,130},{30,150}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToInteger booToInt
    annotation (Placement(transformation(extent={{100,130},{120,150}})));
  Buildings.Controls.OBC.CDL.Reals.Hysteresis hys1(uLow=0.85, uHigh=0.9)
    "Check if radiator control valve opening is above threshold for rasing HHW supply temperature"
    annotation (Placement(transformation(extent={{20,50},{40,70}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToInteger booToInt1(integerTrue=3)
    annotation (Placement(transformation(extent={{80,50},{100,70}})));
  Buildings.Controls.OBC.CDL.Reals.PID           conPID(
    final controllerType=Buildings.Controls.OBC.CDL.Types.SimpleController.PI,
    final k=10e-2,
    Ti=300)
    "Radiator isolation valve controller"
    annotation (Placement(transformation(extent={{-20,80},{0,100}})));
  Buildings.Controls.OBC.CDL.Discrete.UnitDelay uniDel(samplePeriod=60)
    annotation (Placement(transformation(extent={{-80,-48},{-60,-28}})));
  Buildings.Controls.OBC.CDL.Routing.RealScalarReplicator reaRep(nout=2)
    annotation (Placement(transformation(extent={{-40,-48},{-20,-28}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant           con3[2](final k=fill(true,
        2))
    "Constant boiler availability status"
    annotation (Placement(transformation(extent={{-140,-140},{-120,-120}})));
  BoundaryConditions.WeatherData.ReaderTMY3           weaDat(final filNam=
        ModelicaServices.ExternalReferences.loadResource("modelica://Buildings/Resources/weatherdata/USA_NY_Buffalo-Greater.Buffalo.Intl.AP.725280_TMY3.mos"))
    "Weather data reader"
    annotation (Placement(transformation(extent={{-150,60},{-130,80}})));
  BoundaryConditions.WeatherData.Bus           weaBus
    "Weather bus"
    annotation (Placement(transformation(extent={{-120,60},{-100,80}}),
        iconTransformation(extent={{-56,104},{-36,124}})));
  Buildings.Controls.OBC.CDL.Reals.AddParameter addPar(p=273.15, k=1)
    annotation (Placement(transformation(extent={{-60,130},{-40,150}})));
equation
  connect(gai.y, zoneModel_simplified.u)
    annotation (Line(points={{-78,110},{-56,110},{-56,60},{-42,60}},
                                                 color={0,0,127}));
  connect(controller.yBoi, boiPla.uBoiSta) annotation (Line(points={{-88,0},{
          -80,0},{-80,-1},{-62,-1}},
                                 color={255,0,255}));
  connect(controller.TBoiHotWatSupSet, boiPla.TBoiHotWatSupSet) annotation (
      Line(points={{-88,-4},{-80,-4},{-80,-16},{-62,-16}}, color={0,0,127}));
  connect(controller.yHotWatIsoVal, boiPla.uHotIsoVal) annotation (Line(points={{-88,-8},
          {-74,-8},{-74,-4},{-62,-4}},          color={0,0,127}));
  connect(controller.yPriPum, boiPla.uPumSta) annotation (Line(points={{-88,-16},
          {-72,-16},{-72,-7},{-62,-7}}, color={255,0,255}));
  connect(controller.yPriPumSpe, boiPla.uPumSpe) annotation (Line(points={{-88,-20},
          {-66,-20},{-66,-10},{-62,-10}}, color={0,0,127}));
  connect(controller.yBypValPos, boiPla.uBypValSig) annotation (Line(points={{-88,-12},
          {-68,-12},{-68,-13},{-62,-13}},      color={0,0,127}));
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
  connect(conPID.y,hys. u) annotation (Line(points={{2,90},{6,90},{6,140},{8,140}},
                 color={0,0,127}));
  connect(zoneModel_simplified.y, conPID.u_m)
    annotation (Line(points={{-18,60},{-10,60},{-10,78}}, color={0,0,127}));
  connect(conPID.y, hys1.u)
    annotation (Line(points={{2,90},{6,90},{6,60},{18,60}}, color={0,0,127}));
  connect(booToInt1.y, controller.TSupResReq) annotation (Line(points={{102,60},
          {120,60},{120,-72},{-140,-72},{-140,18},{-112,18}}, color={255,127,0}));
  connect(booToInt.y, controller.supResReq) annotation (Line(points={{122,140},
          {130,140},{130,-80},{-150,-80},{-150,15},{-112,15}},
                                                         color={255,127,0}));
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
    annotation (Line(points={{-58,-38},{-42,-38}}, color={0,0,127}));
  connect(reaRep.y, controller.uPriPumSpe) annotation (Line(points={{-18,-38},{-8,
          -38},{-8,-76},{-112,-76},{-112,-46}},  color={0,0,127}));
  connect(conPID.y, val3.y) annotation (Line(points={{2,90},{6,90},{6,116},{-60,
          116},{-60,52}}, color={0,0,127}));
  connect(con3.y, controller.uBoiAva) annotation (Line(points={{-118,-130},{
          -110,-130},{-110,-98},{-136,-98},{-136,-6},{-112,-6}}, color={255,0,
          255}));
  connect(weaDat.weaBus,weaBus)  annotation (Line(
      points={{-130,70},{-110,70}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      textString="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(weaBus.TDryBul, controller.TOut) annotation (Line(
      points={{-110,70},{-110,60},{-120,60},{-120,12},{-112,12}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(zoneModel_simplified.y, boiPla.TZon) annotation (Line(points={{-18,60},
          {-10,60},{-10,12},{-64,12},{-64,-19},{-62,-19}}, color={0,0,127}));
  connect(combiTimeTable.y[1], gai.u)
    annotation (Line(points={{-119,110},{-102,110}}, color={0,0,127}));
  connect(addPar.y, conPID.u_s) annotation (Line(points={{-38,140},{-30,140},{
          -30,90},{-22,90}}, color={0,0,127}));
  connect(hys.y, booToInt.u)
    annotation (Line(points={{32,140},{98,140}}, color={255,0,255}));
  connect(hys1.y, booToInt1.u)
    annotation (Line(points={{42,60},{78,60}}, color={255,0,255}));
  connect(combiTimeTable.y[2], addPar.u) annotation (Line(points={{-119,110},{
          -110,110},{-110,140},{-62,140}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,-160},{160,160}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-160,-160},{160,
            160}})),
    experiment(
      StopTime=2764800,
      Interval=1,
      __Dymola_Algorithm="Cvode"));
end ClosedLoopTest;
