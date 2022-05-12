within Buildings.ZoneEquipment;
block useCase_singleLayer

  replaceable package MediumA = Buildings.Media.Air
    constrainedby Modelica.Media.Interfaces.PartialCondensingGases "Medium model for air";
  replaceable package MediumW = Buildings.Media.Water "Medium model for water";

  Controls.OBC.CDL.Continuous.Sources.Constant con(k=0.5)
    annotation (Placement(transformation(extent={{-140,60},{-120,80}})));
  Fluid.Sources.Boundary_pT sinCoo(
    redeclare package Medium = MediumW,
    p=300000,
    T=279.15,
    nPorts=1) "Sink for cooling coil" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,-110})));
  Fluid.Sources.Boundary_pT souCoo(
    redeclare package Medium = MediumW,
    p(displayUnit="Pa") = 300000 + 6000,
    T=279.15,
    nPorts=1) "Source for cooling coil loop" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,-110})));
  Fluid.Sources.Boundary_pT sinHea(
    redeclare package Medium = MediumW,
    p=300000,
    T=318.15,
    nPorts=1) "Sink for heating coil" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-110,-110})));
  Fluid.Sources.Boundary_pT souHea(
    redeclare package Medium = MediumW,
    p(displayUnit="Pa") = 300000 + 6000,
    T=333.15,
    nPorts=1) "Source for heating coil" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-80,-110})));
  ThermalZones.EnergyPlus.ThermalZone           zon(
    zoneName="LIVING ZONE",
    redeclare package Medium = MediumA,
    nPorts=2)
    "Thermal zone"
    annotation (Placement(transformation(extent={{-26,40},{14,80}})));
  inner ThermalZones.EnergyPlus.Building           building(
    idfName=Modelica.Utilities.Files.loadResource("./Buildings/Resources/Data/ThermalZones/EnergyPlus/Examples/SingleFamilyHouse_TwoSpeed_ZoneAirBalance/SingleFamilyHouse_TwoSpeed_ZoneAirBalance.idf"),
    epwName=Modelica.Utilities.Files.loadResource("./Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.epw"),
    weaName=Modelica.Utilities.Files.loadResource("./Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos"),
    usePrecompiledFMU=false,
    computeWetBulbTemperature=false)
    "Building model"
    annotation (Placement(transformation(extent={{-140,-20},{-120,0}})));

  Controls.OBC.CDL.Routing.RealScalarReplicator reaScaRep(nout=3)
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
  Thermostat thermostat
    annotation (Placement(transformation(extent={{60,60},{80,80}})));
  Controls.OBC.CDL.Continuous.Sources.Constant con1(k=273.15 + 25)
    annotation (Placement(transformation(extent={{0,0},{20,20}})));
  Controls.OBC.CDL.Continuous.Sources.Constant con2(k=273.15 + 23)
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
  Controls.OBC.CDL.Continuous.Sources.Constant con3(k=0.4)
    annotation (Placement(transformation(extent={{-140,-70},{-120,-50}})));
  FCU_singleLayer fCU_singleLayer(
    heatingCoilType=Buildings.ZoneEquipment.Types.heatingCoil.heatingHotWater,
    capacityControlMethod=Buildings.ZoneEquipment.Types.capacityControl.multispeedCyclingFanConstantWater,

    dpAirTot_nominal(displayUnit="Pa") = 100,
    mAirOut_flow_nominal=3,
    redeclare package MediumA = MediumA,
    redeclare package MediumW = MediumW,
    mAir_flow_nominal=10,
    QHeaCoi_flow_nominal=13866,
    mHotWat_flow_nominal=2*13866/(1000*10),
    dpHeaCoiAir_nominal=100,
    UAHeaCoi_nominal=1000,
    minSpeRatCooCoi=1,
    dpCooCoiAir_nominal=100,
    mChiWat_flow_nominal=1,
    UACooCoi_nominal=1,
    dpCooCoiWat_nominal=100,
    redeclare Fluid.Movers.Data.Pumps.customFCUFan fanPer)
    annotation (Placement(transformation(extent={{-70,-40},{-50,-20}})));
  Controller_MultiSpeedCyclingFan_ConstantWaterFlowrate
    controller_MultiSpeedCyclingFan_ConstantWaterFlowrate
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
equation
  connect(con.y, reaScaRep.u) annotation (Line(points={{-118,70},{-102,70}},
                     color={0,0,127}));
  connect(reaScaRep.y, zon.qGai_flow) annotation (Line(points={{-78,70},{-28,70}},
                            color={0,0,127}));
  connect(zon.TAir, thermostat.TZon) annotation (Line(points={{15,78},{58,78}},
                          color={0,0,127}));
  connect(con1.y, thermostat.TCooSet)
    annotation (Line(points={{22,10},{26,10},{26,72},{58,72}},
                                                           color={0,0,127}));
  connect(con2.y, thermostat.THeaSet) annotation (Line(points={{22,-50},{32,-50},
          {32,68},{58,68}},      color={0,0,127}));
  connect(building.weaBus, fCU_singleLayer.weaBus) annotation (Line(
      points={{-120,-10},{-80,-10},{-80,-22},{-68,-22}},
      color={255,204,51},
      thickness=0.5));

  connect(con3.y, fCU_singleLayer.uOA) annotation (Line(points={{-118,-60},{-86,
          -60},{-86,-24},{-72,-24}},
                              color={0,0,127}));
  connect(fCU_singleLayer.port_CCW_inlet, souCoo.ports[1]) annotation (Line(
        points={{-54,-40},{-54,-96},{-20,-96},{-20,-100}}, color={0,127,255}));
  connect(fCU_singleLayer.port_CCW_outlet, sinCoo.ports[1]) annotation (Line(
        points={{-58,-40},{-58,-100},{-50,-100}}, color={0,127,255}));
  connect(fCU_singleLayer.port_HHW_inlet, souHea.ports[1]) annotation (Line(
        points={{-62,-40},{-62,-100},{-80,-100}}, color={0,127,255}));
  connect(fCU_singleLayer.port_HHW_outlet, sinHea.ports[1]) annotation (Line(
        points={{-66,-40},{-66,-94},{-110,-94},{-110,-100}}, color={0,127,255}));
  connect(fCU_singleLayer.TSupAir, thermostat.TSup) annotation (Line(points={{
          -48,-22},{30,-22},{30,65},{58,65}}, color={0,0,127}));
  connect(fCU_singleLayer.port_return, zon.ports[1]) annotation (Line(points={{
          -50,-30},{-8,-30},{-8,40.9}}, color={0,127,255}));
  connect(fCU_singleLayer.port_supply, zon.ports[2]) annotation (Line(points={{
          -50,-34},{-4,-34},{-4,40.9}}, color={0,127,255}));
  connect(thermostat.yFan, thermostat.PFan) annotation (Line(points={{82,66},{
          90,66},{90,56},{34,56},{34,62},{58,62}}, color={0,0,127}));
  connect(con1.y, controller_MultiSpeedCyclingFan_ConstantWaterFlowrate.TCooSet)
    annotation (Line(points={{22,10},{26,10},{26,0},{58,0}}, color={0,0,127}));
  connect(con2.y, controller_MultiSpeedCyclingFan_ConstantWaterFlowrate.THeaSet)
    annotation (Line(points={{22,-50},{32,-50},{32,-4},{58,-4}}, color={0,0,127}));
  connect(zon.TAir, controller_MultiSpeedCyclingFan_ConstantWaterFlowrate.TZon)
    annotation (Line(points={{15,78},{24,78},{24,40},{50,40},{50,4},{58,4}},
        color={0,0,127}));
  connect(controller_MultiSpeedCyclingFan_ConstantWaterFlowrate.yCoo,
    fCU_singleLayer.uCoo) annotation (Line(points={{82,6},{100,6},{100,-80},{
          -82,-80},{-82,-32},{-72,-32}}, color={0,0,127}));
  connect(controller_MultiSpeedCyclingFan_ConstantWaterFlowrate.yHea,
    fCU_singleLayer.uHea) annotation (Line(points={{82,2},{96,2},{96,-78},{-78,
          -78},{-78,-36},{-72,-36}}, color={0,0,127}));
  connect(controller_MultiSpeedCyclingFan_ConstantWaterFlowrate.yFanSpe,
    fCU_singleLayer.uFan) annotation (Line(points={{82,-2},{92,-2},{92,-72},{
          -76,-72},{-76,-28},{-72,-28}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,
            -160},{160,160}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-160,-160},{160,
            160}})),
    experiment(
      StopTime=864000,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end useCase_singleLayer;
