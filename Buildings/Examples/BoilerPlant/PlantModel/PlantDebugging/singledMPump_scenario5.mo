within Buildings.Examples.BoilerPlant.PlantModel.PlantDebugging;
block singledMPump_scenario5

  parameter Modelica.Units.SI.MassFlowRate mA_flow_nominal = V*1.2*6/3600
    "Nominal mass flow rate"
    annotation(dialog(group="Zone parameters"));

  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal = boiEff1[1]*boiCap1 + boiEff2[1]*boiCap2
    "Nominal heat flow rate of radiator"
    annotation(dialog(group="Radiator parameters"));

  parameter Modelica.Units.SI.HeatFlowRate boiCap1= 2200000
    "Boiler capacity for boiler-1"
    annotation(dialog(group="Boiler parameters"));

  parameter Modelica.Units.SI.HeatFlowRate boiCap2= 2200000
    "Boiler capacity for boiler-2"
    annotation(dialog(group="Boiler parameters"));

  parameter Real boiEff1[6] = {0.6246, 0.7711, -1.2077*10e-15, 0.008576, -0.005933, 0.003156}
    "Efficiency for boiler-1"
    annotation(dialog(group="Boiler parameters"));

  parameter Real boiEff2[6] = {0.6246, 0.7711, -1.2077*10e-15, 0.008576, -0.005933, 0.003156}
    "Efficiency for boiler-2"
    annotation(dialog(group="Boiler parameters"));

  parameter Modelica.Units.SI.Temperature TRadSup_nominal = 273.15+70
    "Radiator nominal supply water temperature"
    annotation(dialog(group="Radiator parameters"));

  parameter Modelica.Units.SI.Temperature TRadRet_nominal = 273.15+50
    "Radiator nominal return water temperature"
    annotation(dialog(group="Radiator parameters"));

  parameter Modelica.Units.SI.MassFlowRate mRad_flow_nominal=0.113 * 1000
    "Radiator nominal mass flow rate"
    annotation(dialog(group="Radiator parameters"));

  parameter Modelica.Units.SI.Temperature TBoiSup_nominal = 273.15+70
    "Boiler nominal supply water temperature"
    annotation(dialog(group="Boiler parameters"));

  parameter Modelica.Units.SI.Temperature TBoiRet_min = 273.15+60
    "Boiler minimum return water temperature"
    annotation(dialog(group="Boiler parameters"));

  parameter Modelica.Units.SI.MassFlowRate mBoi_flow_nominal1=mRad_flow_nominal
    "Boiler-1 nominal mass flow rate"
    annotation(dialog(group="Boiler parameters"));

  parameter Modelica.Units.SI.MassFlowRate mBoi_flow_nominal2=mRad_flow_nominal
    "Boiler-2 nominal mass flow rate"
    annotation(dialog(group="Boiler parameters"));

  parameter Modelica.Units.SI.Volume V=126016.35
    "Room volume"
    annotation(dialog(group="Zone parameters"));

  parameter Modelica.Units.SI.Temperature TAir_nominal=273.15 + 23.9
    "Air temperature at nominal condition"
    annotation(dialog(group="Zone parameters"));

  parameter Real zonTheCap = 2*V*1.2*1500
    "Zone thermal capacitance"
    annotation(dialog(group="Zone parameters"));

  BoilerPlant_Buffalo_NonAdiabaticPipe_singlePump boiPla
    annotation (Placement(transformation(extent={{20,-20},{40,0}})));

  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con(k=true)
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con1(k=273.15)
    annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con2(k=273.15 + 70)
    annotation (Placement(transformation(extent={{-40,-70},{-20,-50}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con3(k=1)
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));

  Buildings.Controls.OBC.CDL.Reals.Gain gai(k=-1)
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
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
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation = 90,
        origin={24,20})));
  ZoneModel_simplified            zoneModel_simplified(
    Q_flow_nominal=4359751.36,
    TRadSup_nominal=333.15,
    TRadRet_nominal=323.15,
    mRad_flow_nominal=96.323,
    V=126016.35,
    zonTheCap=6987976290,
    vol(T_start=283.15),
    heaCap(T(start=10)),
    rad(dp_nominal=40000))
    annotation (Placement(transformation(extent={{20,40},{40,60}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con4(k=500000)
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse booPul(width=0.9, period=3600)
    annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con5(k=0)
    annotation (Placement(transformation(extent={{-40,-100},{-20,-80}})));
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
    annotation (Placement(transformation(extent={{60,-20},{80,0}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con6(k=50000)
    annotation (Placement(transformation(extent={{30,-60},{50,-40}})));
equation
  connect(con.y, boiPla.uBoiSta[1]) annotation (Line(points={{-18,10},{0,10},{0,
          -2},{18,-2}},      color={255,0,255}));
  connect(con.y, boiPla.uBoiSta[2]) annotation (Line(points={{-18,10},{0,10},{0,
          0},{18,0}},        color={255,0,255}));
  connect(con2.y, boiPla.TBoiHotWatSupSet[1]) annotation (Line(points={{-18,-60},
          {10,-60},{10,-17},{18,-17}}, color={0,0,127}));
  connect(con2.y, boiPla.TBoiHotWatSupSet[2]) annotation (Line(points={{-18,-60},
          {10,-60},{10,-15},{18,-15}}, color={0,0,127}));
  connect(con3.y, boiPla.uHotIsoVal[1]) annotation (Line(points={{-18,-30},{-12,
          -30},{-12,-5},{18,-5}},
                              color={0,0,127}));
  connect(con3.y, boiPla.uHotIsoVal[2]) annotation (Line(points={{-18,-30},{-12,
          -30},{-12,-3},{18,-3}},
                              color={0,0,127}));
  connect(zoneModel_simplified.port_a, val3.port_b) annotation (Line(points={{
          26,40},{25,40},{25,30},{24,30}}, color={0,127,255}));
  connect(boiPla.port_b, val3.port_a)
    annotation (Line(points={{24,0},{24,10}}, color={0,127,255}));
  connect(zoneModel_simplified.port_b, boiPla.port_a)
    annotation (Line(points={{34,40},{34,0},{36,0}}, color={0,127,255}));
  connect(gai.y, zoneModel_simplified.u)
    annotation (Line(points={{-18,50},{18,50}}, color={0,0,127}));
  connect(con4.y, gai.u)
    annotation (Line(points={{-58,50},{-42,50}}, color={0,0,127}));
  connect(con3.y, val3.y) annotation (Line(points={{-18,-30},{-12,-30},{-12,20},
          {12,20}}, color={0,0,127}));
  connect(booPul.y, boiPla.uPumSta[1]) annotation (Line(points={{-58,-10},{-40,
          -10},{-40,-7},{18,-7}}, color={255,0,255}));
  connect(con5.y, boiPla.uBypValSig) annotation (Line(points={{-18,-90},{0,-90},
          {0,-13},{18,-13}}, color={0,0,127}));
  connect(boiPla.yPumSta, pumSpeRemDp.uHotWatPum) annotation (Line(points={{42,
          -16},{50,-16},{50,-2},{58,-2}}, color={255,0,255}));
  connect(con6.y, pumSpeRemDp.dpHotWatSet) annotation (Line(points={{52,-50},{
          54,-50},{54,-18},{58,-18}}, color={0,0,127}));
  connect(boiPla.yHotWatDp, pumSpeRemDp.dpHotWat) annotation (Line(points={{42,
          -7},{48,-7},{48,-10},{58,-10}}, color={0,0,127}));
  connect(pumSpeRemDp.yHotWatPumSpe, boiPla.uPumSpe) annotation (Line(points={{
          82,-10},{92,-10},{92,70},{6,70},{6,-10},{18,-10}}, color={0,0,127}));
  connect(zoneModel_simplified.y, boiPla.TZon) annotation (Line(points={{42,50},
          {50,50},{50,80},{-6,80},{-6,-19},{18,-19}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -120},{100,100}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    experiment(
      StopTime=864000,
      Interval=1,
      __Dymola_Algorithm="Dassl"));
end singledMPump_scenario5;
