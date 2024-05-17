within Buildings.Examples.JointStudyModel;
model Guideline36_BoilerPlant_SimpleControls
  "Variable air volume flow system with terminal reheat and five thermal zones"
  extends Modelica.Icons.Example;
  package MediumA = Buildings.Media.Air "Medium model for air";
  package MediumW = Buildings.Media.Water "Medium model for water";

  Submodels.Guideline36_modified guideline36_modified
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  BoilerPlant.PlantModel.BoilerPlant_Buffalo_NonAdiabaticPipe_singlePump boiPla
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Controls.OBC.CDL.Logical.Sources.Constant con(k=true)
    annotation (Placement(transformation(extent={{-50,40},{-30,60}})));
  Controls.OBC.CDL.Continuous.Sources.Constant con3(k=1)
    annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
  Controls.OBC.CDL.Continuous.Sources.Constant con2(k=273.15 + 70)
    annotation (Placement(transformation(extent={{-50,-50},{-30,-30}})));
  Controls.OBC.CDL.Continuous.Sources.Constant con1(k=0)
    annotation (Placement(transformation(extent={{-50,-20},{-30,0}})));
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
    annotation (Placement(transformation(extent={{22,-10},{42,10}})));
  Controls.OBC.CDL.Continuous.Sources.Constant con6(k=75000)
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  Controls.OBC.CDL.Continuous.Sources.Constant con4(k=0.113*0.2)
    annotation (Placement(transformation(extent={{-20,-90},{0,-70}})));
  Fluid.FixedResistances.Pipe pip(
    redeclare package Medium = MediumW,
    m_flow_nominal=100,
    dp_nominal=10000,
    thicknessIns=0.001,
    lambdaIns=100,
    length=100)
    annotation (Placement(transformation(extent={{46,42},{66,62}})));
protected
  Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.BypassValve.BypassValvePosition           bypValPos(
    nPum=1,
    final k=1,
    final Ti=0.5,
    final Td=0.1)
    "Bypass valve controller"
    annotation (Placement(transformation(extent={{20,-60},{40,-40}})));
equation
  connect(con.y, boiPla.uBoiSta[1]) annotation (Line(points={{-28,50},{-20,50},
          {-20,8},{-12,8}}, color={255,0,255}));
  connect(con.y, boiPla.uBoiSta[2]) annotation (Line(points={{-28,50},{-20,50},
          {-20,10},{-12,10}}, color={255,0,255}));
  connect(con.y, boiPla.uPumSta[1]) annotation (Line(points={{-28,50},{-20,50},
          {-20,3},{-12,3}}, color={255,0,255}));
  connect(con3.y, boiPla.uHotIsoVal[1]) annotation (Line(points={{-28,20},{-24,
          20},{-24,5},{-12,5}}, color={0,0,127}));
  connect(con3.y, boiPla.uHotIsoVal[2]) annotation (Line(points={{-28,20},{-24,
          20},{-24,7},{-12,7}}, color={0,0,127}));
  connect(con2.y, boiPla.TBoiHotWatSupSet[1]) annotation (Line(points={{-28,-40},
          {-20,-40},{-20,-7},{-12,-7}}, color={0,0,127}));
  connect(con2.y, boiPla.TBoiHotWatSupSet[2]) annotation (Line(points={{-28,-40},
          {-20,-40},{-20,-5},{-12,-5}}, color={0,0,127}));
  connect(guideline36_modified.TZonAve, boiPla.TZon) annotation (Line(points={{12,56},
          {20,56},{20,30},{-16,30},{-16,-9},{-12,-9}},        color={0,0,127}));
  connect(boiPla.yPumSta, pumSpeRemDp.uHotWatPum) annotation (Line(points={{12,
          -6},{16,-6},{16,8},{20,8}}, color={255,0,255}));
  connect(boiPla.yHotWatDp, pumSpeRemDp.dpHotWat)
    annotation (Line(points={{12,3},{18,3},{18,0},{20,0}}, color={0,0,127}));
  connect(con6.y, pumSpeRemDp.dpHotWatSet) annotation (Line(points={{12,-30},{
          18,-30},{18,-8},{20,-8}}, color={0,0,127}));
  connect(pumSpeRemDp.yHotWatPumSpe, boiPla.uPumSpe) annotation (Line(points={{
          44,0},{50,0},{50,26},{-26,26},{-26,0},{-12,0}}, color={0,0,127}));
  connect(boiPla.VHotWat_flow, bypValPos.VHotWat_flow) annotation (Line(points=
          {{12,0},{14,0},{14,-48},{18,-48}}, color={0,0,127}));
  connect(boiPla.yPumSta, bypValPos.uPumSta) annotation (Line(points={{12,-6},{
          16,-6},{16,-52},{18,-52}}, color={255,0,255}));
  connect(con1.y, bypValPos.uMinBypValPos) annotation (Line(points={{-28,-10},{
          -24,-10},{-24,-56},{18,-56}}, color={0,0,127}));
  connect(con4.y, bypValPos.VHotWatMinSet_flow) annotation (Line(points={{2,-80},
          {12,-80},{12,-44},{18,-44}}, color={0,0,127}));
  connect(bypValPos.yBypValPos, boiPla.uBypValSig) annotation (Line(points={{42,
          -50},{54,-50},{54,24},{-22,24},{-22,-3},{-12,-3}}, color={0,0,127}));
  connect(boiPla.port_b, pip.port_a) annotation (Line(points={{-6,10},{-6,20},{
          32,20},{32,52},{46,52}}, color={0,127,255}));
  connect(pip.port_b, boiPla.port_a) annotation (Line(points={{66,52},{74,52},{
          74,16},{6,16},{6,10}}, color={0,127,255}));
  connect(boiPla.port_b, guideline36_modified.port_a) annotation (Line(points={
          {-6,10},{-6,16},{2,16},{2,40}}, color={0,127,255}));
  connect(guideline36_modified.port_b, boiPla.port_a) annotation (Line(points={
          {-2,40},{-2,18},{6,18},{6,10}}, color={0,127,255}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-100,-100},{100,
            100}})),
    __Dymola_Commands(file=
          "modelica://Buildings/Resources/Scripts/Dymola/Examples/VAVReheat/Guideline36.mos"
        "Simulate and plot"),
    experiment(
      StopTime=864000,
      Interval=900,
      __Dymola_Algorithm="Cvode"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})));
end Guideline36_BoilerPlant_SimpleControls;
