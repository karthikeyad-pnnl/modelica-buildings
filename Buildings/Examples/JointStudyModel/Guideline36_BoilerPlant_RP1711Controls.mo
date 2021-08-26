within Buildings.Examples.JointStudyModel;
model Guideline36_BoilerPlant_RP1711Controls
  "Variable air volume flow system with terminal reheat and five thermal zones"
  extends Modelica.Icons.Example;
  package MediumA = Buildings.Media.Air "Medium model for air";
  package MediumW = Buildings.Media.Water "Medium model for water";

  parameter Modelica.SIunits.MassFlowRate mRad_flow_nominal=m_flow_nominal*1000*40/4200/10
    "Radiator nominal mass flow rate"
    annotation(dialog(group="Radiator parameters"));

  parameter Real boiDesCap = 400000;

  parameter Real boiCapRat = 2/4.3;

  parameter Modelica.SIunits.PressureDifference dpValve_nominal_value=6000
    "Nominal pressure drop of fully open valve, used if CvData=Buildings.Fluid.Types.CvTypes.OpPoint";
  parameter Modelica.SIunits.PressureDifference dpFixed_nominal_value=1000
    "Pressure drop of pipe and other resistances that are in series";

  parameter Modelica.SIunits.Area AFloCor=guideline36_modified.flo.cor.AFlo "Floor area corridor";
  parameter Modelica.SIunits.Area AFloSou=guideline36_modified.flo.sou.AFlo "Floor area south";
  parameter Modelica.SIunits.Area AFloNor=guideline36_modified.flo.nor.AFlo "Floor area north";
  parameter Modelica.SIunits.Area AFloEas=guideline36_modified.flo.eas.AFlo "Floor area east";
  parameter Modelica.SIunits.Area AFloWes=guideline36_modified.flo.wes.AFlo "Floor area west";

  parameter Modelica.SIunits.Volume VRooCor=AFloCor*guideline36_modified.flo.hRoo
    "Room volume corridor";
  parameter Modelica.SIunits.Volume VRooSou=AFloSou*guideline36_modified.flo.hRoo
    "Room volume south";
  parameter Modelica.SIunits.Volume VRooNor=AFloNor*guideline36_modified.flo.hRoo
    "Room volume north";
  parameter Modelica.SIunits.Volume VRooEas=AFloEas*guideline36_modified.flo.hRoo "Room volume east";
  parameter Modelica.SIunits.Volume VRooWes=AFloWes*guideline36_modified.flo.hRoo "Room volume west";

  constant Real conv=1.2/3600 "Conversion factor for nominal mass flow rate";
  parameter Modelica.SIunits.MassFlowRate mCor_flow_nominal=6*VRooCor*conv
    "Design mass flow rate core";
  parameter Modelica.SIunits.MassFlowRate mSou_flow_nominal=6*VRooSou*conv
    "Design mass flow rate perimeter 1";
  parameter Modelica.SIunits.MassFlowRate mEas_flow_nominal=9*VRooEas*conv
    "Design mass flow rate perimeter 2";
  parameter Modelica.SIunits.MassFlowRate mNor_flow_nominal=6*VRooNor*conv
    "Design mass flow rate perimeter 3";
  parameter Modelica.SIunits.MassFlowRate mWes_flow_nominal=7*VRooWes*conv
    "Design mass flow rate perimeter 4";
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal=0.7*(mCor_flow_nominal
       + mSou_flow_nominal + mEas_flow_nominal + mNor_flow_nominal +
      mWes_flow_nominal) "Nominal mass flow rate";

  Submodels.Guideline36_modified guideline36_modified(conAHU(kTSup=1,
                                                              TiTSup=1800))
    annotation (Placement(transformation(extent={{20,34},{40,54}})));

  BoilerPlant.PlantModel.BoilerPlant_Buffalo_NonAdiabaticPipe_singlePump boiPla(
    boiCap1=(1 - boiCapRat)*boiDesCap,
    boiCap2=(boiCapRat)*boiDesCap,
    mRad_flow_nominal=mRad_flow_nominal,
    TBoiSup_nominal=333.15,
    TBoiRet_min=323.15,
    conPID(
      controllerType=Buildings.Controls.OBC.CDL.Types.SimpleController.PI,
      k=fill(10e-3, 2),
      Ti=fill(90, 2)),
    dpValve_nominal_value(displayUnit="Pa") = 20000,
    dpFixed_nominal_value(displayUnit="Pa") = 1000,
    tim1(t=120))
    annotation (Placement(transformation(extent={{20,-20},{40,0}})));
  Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Controller                     controller(
    final have_priOnl=true,
    final have_varPriPum=true,
    final have_varSecPum=false,
    final nSenPri=1,
    final nPumPri_nominal=1,
    final nPumSec=0,
    final nSenSec=0,
    final nPumSec_nominal=0,
    TPlaHotWatSetMax=273.15 + 50,
    triAmoVal=-1.111,
    resAmoVal=1.667,
    maxResVal=3.889,
    final VHotWatPri_flow_nominal=0.02,
    final maxLocDpPri=50000,
    final minLocDpPri=50000,
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
    final nPumPri=1,
    final TMinSupNonConBoi=333.2,
    final k_bypVal=1,
    final Ti_bypVal=90,
    final Td_bypVal=10e-9,
    final boiDesFlo=controller.maxFloSet,
    final k_priPum=0.1,
    final Ti_priPum=75,
    final Td_priPum=10e-9,
    final minPriPumSpeSta={0,0,0},
    final speConTypPri=Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Types.PrimaryPumpSpeedControlTypes.remoteDP)
    "Boiler plant controller"
    annotation (Placement(transformation(extent={{-40,-38},{-20,30}})));

  BoundaryConditions.WeatherData.ReaderTMY3           weaDat(final filNam=
        ModelicaServices.ExternalReferences.loadResource("modelica://Buildings/Resources/weatherdata/USA_NY_Buffalo-Greater.Buffalo.Intl.AP.725280_TMY3.mos"))
    "Weather data reader"
    annotation (Placement(transformation(extent={{-90,50},{-70,70}})));
  BoundaryConditions.WeatherData.Bus           weaBus
    "Weather bus"
    annotation (Placement(transformation(extent={{-70,50},{-50,70}}),
        iconTransformation(extent={{-56,104},{-36,124}})));
  Controls.OBC.CDL.Logical.Sources.Constant con[2](k=fill(true, 2))
    "Constant Boolean source"
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
equation
  connect(guideline36_modified.TZonAve, boiPla.TZon) annotation (Line(points={{42,50},
          {50,50},{50,14},{10,14},{10,-19},{18,-19}},               color={0,0,
          127}));
  connect(boiPla.port_a, guideline36_modified.port_b) annotation (Line(points={{36,0},{
          36,10},{28,10},{28,34}},        color={0,127,255}));
  connect(boiPla.port_b, guideline36_modified.port_a) annotation (Line(points={{24,0},{
          24,8},{32,8},{32,34}},            color={0,127,255}));
  connect(controller.yBoi, boiPla.uBoiSta) annotation (Line(points={{-18,10},{0,
          10},{0,-1},{18,-1}}, color={255,0,255}));
  connect(controller.TBoiHotWatSupSet, boiPla.TBoiHotWatSupSet) annotation (
      Line(points={{-18,6},{8,6},{8,-16},{18,-16}}, color={0,0,127}));
  connect(controller.yHotWatIsoVal, boiPla.uHotIsoVal) annotation (Line(points={
          {-18,2},{14,2},{14,-4},{18,-4}}, color={0,0,127}));
  connect(controller.yBypValPos, boiPla.uBypValSig) annotation (Line(points={{-18,
          -2},{12,-2},{12,-13},{18,-13}}, color={0,0,127}));
  connect(controller.yPriPum, boiPla.uPumSta) annotation (Line(points={{-18,-6},
          {14,-6},{14,-7},{18,-7}}, color={255,0,255}));
  connect(controller.yPriPumSpe, boiPla.uPumSpe)
    annotation (Line(points={{-18,-10},{18,-10}}, color={0,0,127}));
  connect(boiPla.yBypValPos, controller.uBypValPos) annotation (Line(points={{42,
          2},{80,2},{80,-80},{-60,-80},{-60,-33},{-42,-33}}, color={0,0,127}));
  connect(boiPla.ySupTem, controller.TSupPri) annotation (Line(points={{42,-1},{
          78,-1},{78,-78},{-58,-78},{-58,19},{-42,19}}, color={0,0,127}));
  connect(boiPla.yRetTem, controller.TRetPri) annotation (Line(points={{42,-4},{
          76,-4},{76,-76},{-56,-76},{-56,16},{-42,16}}, color={0,0,127}));
  connect(boiPla.yHotWatDp, controller.dpHotWatPri_rem) annotation (Line(points=
         {{42,-7},{74,-7},{74,-74},{-54,-74},{-54,7},{-42,7}}, color={0,0,127}));
  connect(boiPla.VHotWat_flow, controller.VHotWatPri_flow) annotation (Line(
        points={{42,-10},{72,-10},{72,-72},{-52,-72},{-52,13},{-42,13}}, color={
          0,0,127}));
  connect(boiPla.yPumSta, controller.uPriPum) annotation (Line(points={{42,-16},
          {68,-16},{68,-68},{-48,-68},{-48,-24},{-42,-24}}, color={255,0,255}));
  connect(boiPla.yBoiSta, controller.uBoi) annotation (Line(points={{42,-13},{70,
          -13},{70,-70},{-50,-70},{-50,-21},{-42,-21}}, color={255,0,255}));
  connect(boiPla.yHotWatIsoVal, controller.uHotWatIsoVal) annotation (Line(
        points={{42,-19},{66,-19},{66,-66},{-46,-66},{-46,-30},{-42,-30}},
        color={0,0,127}));
  connect(weaDat.weaBus,weaBus)  annotation (Line(
      points={{-70,60},{-60,60}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      textString="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(weaBus.TDryBul, controller.TOut) annotation (Line(
      points={{-60,60},{-60,22},{-42,22}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(guideline36_modified.yHeaPlaReq, controller.supResReq) annotation (
      Line(points={{42,38},{48,38},{48,60},{-48,60},{-48,25},{-42,25}}, color={255,
          127,0}));
  connect(guideline36_modified.yHeaValResReq, controller.TSupResReq)
    annotation (Line(points={{42,42},{46,42},{46,56},{-46,56},{-46,28},{-42,28}},
        color={255,127,0}));
  connect(con.y, controller.uBoiAva) annotation (Line(points={{-68,0},{-60,0},{-60,
          4},{-42,4}}, color={255,0,255}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-100,-100},{100,
            100}})),
    __Dymola_Commands(file=
          "modelica://Buildings/Resources/Scripts/Dymola/Examples/VAVReheat/Guideline36.mos"
        "Simulate and plot"),
    experiment(
      StartTime=86400,
      StopTime=192800,
      Interval=60,
      __Dymola_Algorithm="Cvode"),
    Icon(coordinateSystem(extent={{-100,-120},{100,100}})));
end Guideline36_BoilerPlant_RP1711Controls;
