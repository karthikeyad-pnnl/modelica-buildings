within Buildings.Examples.JointStudyModel;
model Guideline36_BoilerPlant_Testing2
  "Variable air volume flow system with terminal reheat and five thermal zones"
  extends Modelica.Icons.Example;
  package MediumA = Buildings.Media.Air "Medium model for air";
  package MediumW = Buildings.Media.Water "Medium model for water";

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

  Submodels.Guideline36_modified guideline36_modified
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  Controls.OBC.CDL.Logical.Sources.Constant con1(k=true)
    annotation (Placement(transformation(extent={{-50,-70},{-30,-50}})));
  Controls.OBC.CDL.Continuous.Sources.Constant con3(k=1)
    annotation (Placement(transformation(extent={{-50,-100},{-30,-80}})));
  Controls.OBC.CDL.Continuous.Sources.Constant con2(k=273.15 + 70)
    annotation (Placement(transformation(extent={{-50,-160},{-30,-140}})));
  Controls.OBC.CDL.Continuous.Sources.Constant con4(k=0)
    annotation (Placement(transformation(extent={{-50,-130},{-30,-110}})));
  BoilerPlant.PlantModel.BoilerPlant_Buffalo_NonAdiabaticPipe_singlePump boiPla
    annotation (Placement(transformation(extent={{-10,-120},{10,-100}})));
  Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.Generic.Speed_remoteDp
    pumSpeRemDp(
    final nSen=1,
    final nPum=1,
    final minPumSpe=0.1,
    final maxPumSpe=1,
    final k=0.1,
    final Ti=75,
    final Td=10e-9)
    "Hot water pump speed control with remote DP sensor"
    annotation (Placement(transformation(extent={{22,-120},{42,-100}})));
  Controls.OBC.CDL.Continuous.Sources.Constant con6(k=75000)
    annotation (Placement(transformation(extent={{-10,-150},{10,-130}})));
  Controls.OBC.CDL.Continuous.AddParameter addPar(p=1, k=-1)
    annotation (Placement(transformation(extent={{60,40},{80,60}})));
equation
  connect(con1.y, boiPla.uBoiSta[1]) annotation (Line(points={{-28,-60},{-20,
          -60},{-20,-102},{-12,-102}}, color={255,0,255}));
  connect(con1.y, boiPla.uBoiSta[2]) annotation (Line(points={{-28,-60},{-20,
          -60},{-20,-100},{-12,-100}}, color={255,0,255}));
  connect(con1.y, boiPla.uPumSta[1]) annotation (Line(points={{-28,-60},{-20,
          -60},{-20,-107},{-12,-107}}, color={255,0,255}));
  connect(con3.y,boiPla. uHotIsoVal[1]) annotation (Line(points={{-28,-90},{-24,
          -90},{-24,-105},{-12,-105}},
                                color={0,0,127}));
  connect(con3.y,boiPla. uHotIsoVal[2]) annotation (Line(points={{-28,-90},{-24,
          -90},{-24,-103},{-12,-103}},
                                color={0,0,127}));
  connect(con2.y,boiPla. TBoiHotWatSupSet[1]) annotation (Line(points={{-28,
          -150},{-20,-150},{-20,-117},{-12,-117}},
                                        color={0,0,127}));
  connect(con2.y,boiPla. TBoiHotWatSupSet[2]) annotation (Line(points={{-28,
          -150},{-20,-150},{-20,-115},{-12,-115}},
                                        color={0,0,127}));
  connect(boiPla.yPumSta, pumSpeRemDp.uHotWatPum) annotation (Line(points={{12,
          -116},{16,-116},{16,-102},{20,-102}}, color={255,0,255}));
  connect(boiPla.yHotWatDp, pumSpeRemDp.dpHotWat) annotation (Line(points={{12,
          -107},{14,-107},{14,-110},{20,-110}}, color={0,0,127}));
  connect(con6.y, pumSpeRemDp.dpHotWatSet) annotation (Line(points={{12,-140},{
          16,-140},{16,-118},{20,-118}}, color={0,0,127}));
  connect(pumSpeRemDp.yHotWatPumSpe, boiPla.uPumSpe) annotation (Line(points={{
          44,-110},{50,-110},{50,-88},{-16,-88},{-16,-110},{-12,-110}}, color={
          0,0,127}));
  connect(guideline36_modified.TZonAve, boiPla.TZon) annotation (Line(points={{
          12,56},{30,56},{30,-10},{-14,-10},{-14,-119},{-12,-119}}, color={0,0,
          127}));
  connect(guideline36_modified.yHeaCoiSig, addPar.u) annotation (Line(points={{
          12,52},{40,52},{40,50},{58,50}}, color={0,0,127}));
  connect(addPar.y, boiPla.uBypValSig) annotation (Line(points={{82,50},{90,50},
          {90,-80},{-18,-80},{-18,-113},{-12,-113}}, color={0,0,127}));
  connect(boiPla.port_a, guideline36_modified.port_b) annotation (Line(points={
          {6,-100},{6,0},{-2,0},{-2,40}}, color={0,127,255}));
  connect(boiPla.port_b, guideline36_modified.port_a) annotation (Line(points={
          {-6,-100},{-6,-4},{2,-4},{2,40}}, color={0,127,255}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-100,-220},{100,
            100}})),
    __Dymola_Commands(file=
          "modelica://Buildings/Resources/Scripts/Dymola/Examples/VAVReheat/Guideline36.mos"
        "Simulate and plot"),
    experiment(
      StopTime=864000,
      Interval=900,
      __Dymola_Algorithm="Cvode"),
    Icon(coordinateSystem(extent={{-100,-220},{100,100}})));
end Guideline36_BoilerPlant_Testing2;
