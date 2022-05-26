within Buildings.Fluid.ZoneEquipment;
block use_case

  replaceable package MediumA = Buildings.Media.Air
    constrainedby Modelica.Media.Interfaces.PartialCondensingGases "Medium model for air";
  replaceable package MediumW = Buildings.Media.Water "Medium model for water";

  Controls.OBC.CDL.Continuous.Sources.Constant con(k=0.5)
    annotation (Placement(transformation(extent={{-140,30},{-120,50}})));
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
    annotation (Placement(transformation(extent={{-30,20},{10,60}})));
  inner ThermalZones.EnergyPlus.Building           building(
    idfName=Modelica.Utilities.Files.loadResource("./Buildings/Resources/Data/ThermalZones/EnergyPlus/Examples/SingleFamilyHouse_TwoSpeed_ZoneAirBalance/SingleFamilyHouse_TwoSpeed_ZoneAirBalance.idf"),
    epwName=Modelica.Utilities.Files.loadResource("./Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.epw"),
    weaName=Modelica.Utilities.Files.loadResource("./Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos"),
    usePrecompiledFMU=false,
    computeWetBulbTemperature=false)
    "Building model"
    annotation (Placement(transformation(extent={{-140,-40},{-120,-20}})));

  Controls.OBC.CDL.Routing.RealScalarReplicator reaScaRep(nout=3)
    annotation (Placement(transformation(extent={{-100,30},{-80,50}})));
  Thermostat thermostat
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Controls.OBC.CDL.Continuous.Sources.Constant con1(k=273.15 + 25)
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  Controls.OBC.CDL.Continuous.Sources.Constant con2(k=273.15 + 23)
    annotation (Placement(transformation(extent={{10,-50},{30,-30}})));
  FCU fCU(
    heatingCoilType=Buildings.Fluid.ZoneEquipment.Types.heatingCoil.heatingHotWater,
    capacityControlMethod=Buildings.Fluid.ZoneEquipment.Types.capacityControl.constantSpeedContinuousFanVariableWater,
    redeclare package MediumA = MediumA,
    redeclare package MediumW = MediumW,
    mAir_flow_nominal=10,
    QHeaCoi_flow_nominal=13866,
    mHotWat_flow_nominal=2*13866/(1000*10),
    dpHeaCoiWat_nominal=100,
    dpHeaCoiAir_nominal=100,
    UAHeaCoi_nominal=1000,
    minSpeRatCooCoi=1,
    dpCooCoiAir_nominal=100,
    mChiWat_flow_nominal=1,
    UACooCoi_nominal=1,
    dpCooCoiWat_nominal=100,
    redeclare Fluid.Movers.Data.Pumps.customFCUFan fanPer)
    annotation (Placement(transformation(extent={{-86,-52},{-42,0}})));
  Controls.OBC.CDL.Continuous.Sources.Constant con3(k=0.4)
    annotation (Placement(transformation(extent={{-140,0},{-120,20}})));
  Fluid.Sources.Outside out(redeclare package Medium = MediumA, nPorts=2)
    annotation (Placement(transformation(extent={{-114,-40},{-94,-20}})));
  Modelica.Blocks.Sources.CombiTimeTable datRea(
    tableOnFile=true,
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "./Buildings/Resources/Data/Fluid/Chillers/Validation/IndirectAbsorptionChiller/IndirectAbsorptionChiller.dat"),
    columns=2:11,
    tableName="EnergyPlus",
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments)
    "Reader for \"IndirectAbsorptionChiller.idf\" EnergyPlus example results"
      annotation (Placement(transformation(extent={{-140,70},{-120,90}})));

equation
  connect(con.y, reaScaRep.u) annotation (Line(points={{-118,40},{-102,40}},
                     color={0,0,127}));
  connect(reaScaRep.y, zon.qGai_flow) annotation (Line(points={{-78,40},{-50,
          40},{-50,50},{-32,50}},
                            color={0,0,127}));
  connect(zon.TAir, thermostat.TZon) annotation (Line(points={{11,58},{32,58},
          {32,8},{38,8}}, color={0,0,127}));
  connect(con1.y, thermostat.TCooSet)
    annotation (Line(points={{32,0},{34,0},{34,2},{38,2}}, color={0,0,127}));
  connect(con2.y, thermostat.THeaSet) annotation (Line(points={{32,-40},{36,
          -40},{36,-2},{38,-2}}, color={0,0,127}));
  connect(thermostat.yCoo, fCU.uCoo) annotation (Line(points={{62,4},{80,4},{
          80,-60},{-20,-60},{-20,14},{-52,14},{-52,2}}, color={0,0,127}));
  connect(thermostat.yHea, fCU.uHea) annotation (Line(points={{62,0},{72,0},{
          72,-66},{-32,-66},{-32,8},{-68,8},{-68,2}}, color={0,0,127}));
  connect(thermostat.yFan, fCU.uFan) annotation (Line(points={{62,-4},{88,-4},
          {88,-72},{-38,-72},{-38,20},{-60,20},{-60,2}}, color={0,0,127}));
  connect(souCoo.ports[1], fCU.port_CCW_inlet) annotation (Line(points={{-20,
          -100},{-20,-80},{-56,-80},{-56,-52}}, color={0,127,255}));
  connect(sinCoo.ports[1], fCU.port_CCW_outlet) annotation (Line(points={{-50,
          -100},{-50,-84},{-60,-84},{-60,-52}}, color={0,127,255}));
  connect(souHea.ports[1], fCU.port_HHW_inlet) annotation (Line(points={{-80,
          -100},{-80,-80},{-68,-80},{-68,-52}}, color={0,127,255}));
  connect(sinHea.ports[1], fCU.port_HHW_outlet) annotation (Line(points={{
          -110,-100},{-110,-76},{-72,-76},{-72,-52}}, color={0,127,255}));
  connect(fCU.port_return, zon.ports[1]) annotation (Line(points={{-42,-22},{
          -12,-22},{-12,20.9}}, color={0,127,255}));
  connect(fCU.port_supply, zon.ports[2]) annotation (Line(points={{-42,-30},{
          -8,-30},{-8,20.9}}, color={0,127,255}));
  connect(con3.y, fCU.uOA)
    annotation (Line(points={{-118,10},{-76,10},{-76,2}}, color={0,0,127}));
  connect(building.weaBus, out.weaBus) annotation (Line(
      points={{-120,-30},{-118,-30},{-118,-29.8},{-114,-29.8}},
      color={255,204,51},
      thickness=0.5));
  connect(out.ports[1], fCU.port_OA_exhaust1) annotation (Line(points={{-94,
          -28},{-90,-28},{-90,-22},{-86,-22}}, color={0,127,255}));
  connect(out.ports[2], fCU.port_OA_inlet1) annotation (Line(points={{-94,-32},
          {-90,-32},{-90,-30},{-86,-30}}, color={0,127,255}));
  connect(fCU.TSupAir, thermostat.TSup) annotation (Line(points={{-40,-2},{0,
          -2},{0,-20},{34,-20},{34,-5},{38,-5}}, color={0,0,127}));
  connect(thermostat.yFan, thermostat.PFan) annotation (Line(points={{62,-4},
          {88,-4},{88,-72},{38,-72},{38,-8}},         color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,
            -160},{160,160}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-160,-160},{160,
            160}})),
    experiment(
      StopTime=864000,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end use_case;
