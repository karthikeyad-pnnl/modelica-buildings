within Buildings.Templates.Plants.HeatPumps_PNNL.Components.Validation.SystemResizing;
model ExternalEnergyLoop
  import Media;
  extends Modelica.Icons.Example;

  parameter Real mCondWater_flow=656;
  parameter Real mHotWater_flow=58;

  Buildings.Templates.Plants.HeatPumps_PNNL.Components.ExternalEnergyLoop
    externalEnergyLoop(
    mConWat_flow=30*660,
    CoolingCapacity_nominal=30*15e6,
    mRehWat_flow=0.75*70.83,
    HeatingCapacity_nominal=1.2*9.52e6)
    annotation (Placement(transformation(extent={{-10,0},{10,20}})));
  Controls.ExternalEnergy         externalEnergyOpenLoop
    annotation (Placement(transformation(extent={{40,30},{60,50}})));
  BoundaryConditions.WeatherData.ReaderTMY3           weaDat(filNam=
        Modelica.Utilities.Files.loadResource("modelica://Buildings/Resources/weatherdata/USA_NY_Buffalo-Greater.Buffalo.Intl.AP.725280_TMY3.mos"),
      computeWetBulbTemperature=true)  "Weather data reader"
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Fluid.HeatExchangers.ConstantEffectiveness hex(
    redeclare package Medium1 = Media.Water,
    redeclare package Medium2 = Media.Water,
    m1_flow_nominal=mCondWater_flow,
    m2_flow_nominal=mHotWater_flow,
    dp1_nominal=5000,
    dp2_nominal=5000,
    eps=0.9)
    annotation (Placement(transformation(extent={{-72,-60},{-92,-40}})));
  Fluid.HeatExchangers.ConstantEffectiveness hex1(
    redeclare package Medium1 = Media.Water,
    redeclare package Medium2 = Media.Water,
    m1_flow_nominal=externalEnergyLoop.mRehWat_flow,
    m2_flow_nominal=120,
    dp1_nominal=5000,
    dp2_nominal=5000,
    eps=0.9)
    annotation (Placement(transformation(extent={{80,-60},{100,-40}})));
  Buildings.Templates.Components.Sensors.VolumeFlowRate volumeFlowRate1(
    redeclare package Medium = Media.Water,
    m_flow_nominal=mCondWater_flow,
    final typ=Buildings.Templates.Components.Types.SensorVolumeFlowRate.FlowMeter)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-30,-20})));
  Buildings.Templates.Components.Sensors.VolumeFlowRate volumeFlowRate4(
    redeclare package Medium = Media.Water,
    m_flow_nominal=externalEnergyLoop.mRehWat_flow,
    final typ=Buildings.Templates.Components.Types.SensorVolumeFlowRate.FlowMeter)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={24,-20})));
  Fluid.Sources.MassFlowSource_T boundary(redeclare package Medium =
        Buildings.Media.Water,
    use_m_flow_in=false,
    m_flow=120,
    use_T_in=false,
    T=277.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{130,-70},{110,-50}})));
  Fluid.Sources.MassFlowSource_T boundary1(redeclare package Medium =
        Buildings.Media.Water,
    m_flow=0,
    T=353.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-126,-70},{-106,-50}})));
  Fluid.Sources.Boundary_pT bou(redeclare package Medium =
        Buildings.Media.Water, nPorts=1)
    annotation (Placement(transformation(extent={{0,-90},{-20,-70}})));
  Fluid.Sources.Boundary_pT bou1(redeclare package Medium =
        Buildings.Media.Water, nPorts=1)
    annotation (Placement(transformation(extent={{10,-90},{30,-70}})));
  Buildings.Templates.Components.Sensors.Temperature TRetCoo(redeclare package
      Medium = Buildings.Media.Water, m_flow_nominal=120)
    annotation (Placement(transformation(extent={{70,-90},{50,-70}})));
  Buildings.Templates.Components.Sensors.Temperature TRetHea(redeclare package
      Medium = Buildings.Media.Water, m_flow_nominal=mHotWater_flow)
                                                        annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-50,-66})));
  Interface.ExternalEnergyLoop bus annotation (Placement(transformation(extent={
            {-26,100},{14,140}}), iconTransformation(extent={{-248,60},{-208,100}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt(k=-2)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
        Buildings.Media.Water, m_flow_nominal=externalEnergyLoop.mRehWat_flow)
    annotation (Placement(transformation(extent={{40,-30},{60,-10}})));
equation
  connect(externalEnergyOpenLoop.bus, externalEnergyLoop.bus) annotation (Line(
      points={{50,50},{50,62},{4,62},{4,20}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, externalEnergyLoop.busWea) annotation (Line(
      points={{-40,30},{-4,30},{-4,20}},
      color={255,204,51},
      thickness=0.5));
  connect(externalEnergyLoop.portEva_b, volumeFlowRate4.port_a) annotation (
      Line(points={{7,0},{7,-20},{14,-20}},        color={0,127,255}));
  connect(hex1.port_b1, externalEnergyLoop.portEva_a) annotation (Line(points={{100,-44},
          {104,-44},{104,-36},{3,-36},{3,0}},       color={0,127,255}));
  connect(externalEnergyLoop.portCon_b, volumeFlowRate1.port_a) annotation (
      Line(points={{-3,0},{-12,0},{-12,-20},{-20,-20}},color={0,127,255}));
  connect(volumeFlowRate1.port_b, hex.port_a1) annotation (Line(points={{-40,-20},
          {-54,-20},{-54,-44},{-72,-44}},
                                color={0,127,255}));
  connect(hex.port_b1, externalEnergyLoop.portCon_a) annotation (Line(points={{-92,-44},
          {-96,-44},{-96,-34},{-66,-34},{-66,-42},{-8,-42},{-8,0},{-7,0}},
                                                            color={0,127,255}));
  connect(hex1.port_a2, boundary.ports[1]) annotation (Line(points={{100,-56},{104,
          -56},{104,-60},{110,-60}}, color={0,127,255}));
  connect(TRetCoo.port_a, hex1.port_b2)
    annotation (Line(points={{70,-80},{74,-80},{74,-56},{80,-56}},
                                                 color={0,127,255}));
  connect(bou1.ports[1], TRetCoo.port_b) annotation (Line(points={{30,-80},{50,-80}},
                              color={0,127,255}));
  connect(externalEnergyOpenLoop.bus, bus) annotation (Line(
      points={{50,50},{50,62},{-6,62},{-6,120}},
      color={255,204,51},
      thickness=0.5));
  connect(TRetCoo.y, bus.TCooRet) annotation (Line(
      points={{60,-68},{68,-68},{68,62},{-6,62},{-6,120}},
      color={255,204,51},
      thickness=0.5));
  connect(conInt.y, bus.uOpeMod) annotation (Line(
      points={{-78,90},{-6,90},{-6,120}},
      color={255,204,51},
      thickness=0.5));
  connect(TRetHea.y, bus.coolingTowerSystemBus.TRetHea)
                                 annotation (Line(
      points={{-50,-54},{-50,16},{-64,16},{-64,88},{-5.9,88},{-5.9,120.1}},
      color={255,204,51},
      thickness=0.5));
  connect(boundary1.ports[1], hex.port_a2) annotation (Line(points={{-106,-60},{
          -106,-56},{-92,-56}}, color={0,127,255}));
  connect(hex.port_b2, TRetHea.port_a) annotation (Line(points={{-72,-56},{-72,-66},
          {-60,-66}}, color={0,127,255}));
  connect(TRetHea.port_b, bou.ports[1]) annotation (Line(points={{-40,-66},{-20,
          -66},{-20,-80}}, color={0,127,255}));
  connect(volumeFlowRate4.port_b, senTem.port_a)
    annotation (Line(points={{34,-20},{40,-20}}, color={0,127,255}));
  connect(senTem.port_b, hex1.port_a1) annotation (Line(points={{60,-20},{70,
          -20},{70,-44},{80,-44}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}})),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-140,-140},{140,140}})),
    experiment(StopTime=86400, __Dymola_Algorithm="Dassl"));
end ExternalEnergyLoop;
