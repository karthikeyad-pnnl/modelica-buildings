within Buildings.Examples.BoilerPlant.PlantModel.PlantDebugging;
block singledMPump_scenario1

  parameter Modelica.SIunits.MassFlowRate mA_flow_nominal = V*1.2*6/3600
    "Nominal mass flow rate"
    annotation(dialog(group="Zone parameters"));

  parameter Modelica.SIunits.HeatFlowRate Q_flow_nominal = boiEff1[1]*boiCap1 + boiEff2[1]*boiCap2
    "Nominal heat flow rate of radiator"
    annotation(dialog(group="Radiator parameters"));

  parameter Modelica.SIunits.HeatFlowRate boiCap1= 2200000
    "Boiler capacity for boiler-1"
    annotation(dialog(group="Boiler parameters"));

  parameter Modelica.SIunits.HeatFlowRate boiCap2= 2200000
    "Boiler capacity for boiler-2"
    annotation(dialog(group="Boiler parameters"));

  parameter Real boiEff1[6] = {0.6246, 0.7711, -1.2077*10e-15, 0.008576, -0.005933, 0.003156}
    "Efficiency for boiler-1"
    annotation(dialog(group="Boiler parameters"));

  parameter Real boiEff2[6] = {0.6246, 0.7711, -1.2077*10e-15, 0.008576, -0.005933, 0.003156}
    "Efficiency for boiler-2"
    annotation(dialog(group="Boiler parameters"));

  parameter Modelica.SIunits.Temperature TRadSup_nominal = 273.15+70
    "Radiator nominal supply water temperature"
    annotation(dialog(group="Radiator parameters"));

  parameter Modelica.SIunits.Temperature TRadRet_nominal = 273.15+50
    "Radiator nominal return water temperature"
    annotation(dialog(group="Radiator parameters"));

  parameter Modelica.SIunits.MassFlowRate mRad_flow_nominal=0.113 * 1000
    "Radiator nominal mass flow rate"
    annotation(dialog(group="Radiator parameters"));

  parameter Modelica.SIunits.Temperature TBoiSup_nominal = 273.15+70
    "Boiler nominal supply water temperature"
    annotation(dialog(group="Boiler parameters"));

  parameter Modelica.SIunits.Temperature TBoiRet_min = 273.15+60
    "Boiler minimum return water temperature"
    annotation(dialog(group="Boiler parameters"));

  parameter Modelica.SIunits.MassFlowRate mBoi_flow_nominal1=mRad_flow_nominal
    "Boiler-1 nominal mass flow rate"
    annotation(dialog(group="Boiler parameters"));

  parameter Modelica.SIunits.MassFlowRate mBoi_flow_nominal2=mRad_flow_nominal
    "Boiler-2 nominal mass flow rate"
    annotation(dialog(group="Boiler parameters"));

  parameter Modelica.SIunits.Volume V=126016.35
    "Room volume"
    annotation(dialog(group="Zone parameters"));

  parameter Modelica.SIunits.Temperature TAir_nominal=273.15 + 23.9
    "Air temperature at nominal condition"
    annotation(dialog(group="Zone parameters"));

  parameter Real zonTheCap = 2*V*1.2*1500
    "Zone thermal capacitance"
    annotation(dialog(group="Zone parameters"));

  BoilerPlant_Buffalo_NonAdiabaticPipe_singlePump boiPla
    annotation (Placement(transformation(extent={{20,-20},{40,0}})));

  Controls.OBC.CDL.Logical.Sources.Constant con(k=true)
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  Controls.OBC.CDL.Continuous.Sources.Constant con1(k=273.15)
    annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
  Controls.OBC.CDL.Continuous.Sources.Constant con2(k=273.15 + 70)
    annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
  Controls.OBC.CDL.Continuous.Sources.Constant con3(k=1)
    annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));

  Controls.OBC.CDL.Continuous.Gain gai(k=-1)
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
  Controls.OBC.CDL.Continuous.Sources.Constant con4(k=500000)
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  Controls.OBC.CDL.Continuous.Sources.Constant con5(k=0)
    annotation (Placement(transformation(extent={{-40,-90},{-20,-70}})));
equation
  connect(con.y, boiPla.uBoiSta[1]) annotation (Line(points={{-18,10},{0,10},{0,
          -2},{18,-2}},      color={255,0,255}));
  connect(con.y, boiPla.uBoiSta[2]) annotation (Line(points={{-18,10},{0,10},{0,
          0},{18,0}},        color={255,0,255}));
  connect(con.y, boiPla.uPumSta[1]) annotation (Line(points={{-18,10},{0,10},{0,
          -7},{18,-7}},      color={255,0,255}));
  connect(con1.y, boiPla.TZon) annotation (Line(points={{-18,80},{-8,80},{-8,
          -19},{18,-19}},color={0,0,127}));
  connect(con2.y, boiPla.TBoiHotWatSupSet[1]) annotation (Line(points={{-18,-50},
          {10,-50},{10,-17},{18,-17}}, color={0,0,127}));
  connect(con2.y, boiPla.TBoiHotWatSupSet[2]) annotation (Line(points={{-18,-50},
          {10,-50},{10,-15},{18,-15}}, color={0,0,127}));
  connect(con3.y, boiPla.uHotIsoVal[1]) annotation (Line(points={{-18,-20},{-12,
          -20},{-12,-5},{18,-5}},
                              color={0,0,127}));
  connect(con3.y, boiPla.uHotIsoVal[2]) annotation (Line(points={{-18,-20},{-12,
          -20},{-12,-3},{18,-3}},
                              color={0,0,127}));
  connect(con3.y, boiPla.uPumSpe) annotation (Line(points={{-18,-20},{-12,-20},
          {-12,-10},{18,-10}},
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
  connect(con3.y, val3.y) annotation (Line(points={{-18,-20},{-12,-20},{-12,20},
          {12,20}}, color={0,0,127}));
  connect(con5.y, boiPla.uBypValSig) annotation (Line(points={{-18,-80},{0,-80},
          {0,-13},{18,-13}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -120},{100,100}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    experiment(
      StopTime=864000,
      Interval=1,
      __Dymola_Algorithm="Dassl"));
end singledMPump_scenario1;
