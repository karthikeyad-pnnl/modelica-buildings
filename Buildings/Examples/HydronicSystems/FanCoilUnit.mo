within Buildings.Examples.HydronicSystems;
model FanCoilUnit
  extends Modelica.Icons.Example;
  replaceable package MediumA = Buildings.Media.Air(T_default=293.15)
    "Medium model for air";
 replaceable package MediumW = Buildings.Media.Water "Medium model";
   //replaceable package MediumA = Modelica.Media.Interfaces.PartialMedium
    //"Medium model of air";
  replaceable package MediumHW = Modelica.Media.Interfaces.PartialMedium
    "Medium model of hot water";
  replaceable package MediumCHW = Modelica.Media.Interfaces.PartialMedium
    "Medium model of chilled water";

  ThermalZones.EnergyPlus_24_2_0.Examples.SmallOffice.BaseClasses.Floor floor1(
      redeclare package Medium = MediumA)
    annotation (Placement(transformation(extent={{52,80},{130,124}})));

  Fluid.ZoneEquipment.FanCoilUnit.FourPipe fanCoiUni[5](
    redeclare package MediumA = MediumA,
    redeclare package MediumHW = MediumW,
    redeclare package MediumCHW = MediumW,
    mHotWat_flow_nominal={0.21805,0.53883,0.33281,0.50946,0.33236},
    dpAir_nominal=fill(100, 5),
    UAHeaCoi_nominal={2.25*146.06,2.25*146.06,2.25*146.06,2.25*146.06,2.25*146.06},
    mChiWat_flow_nominal={0.23106,0.30892,0.18797,0.2984,0.18781},
    UACooCoi_nominal={2.25*146.06,2.25*146.06,2.25*146.06,2.25*146.06,2.25*146.06},
    mAir_flow_nominal={0.09,0.222,0.1337,0.21303,0.137},
    QHeaCoi_flow_nominal={6036.5,8070.45,4910.71,7795.7,4906.52})
    annotation (Placement(transformation(extent={{20,16},{40,36}})));

  Controls.OBC.ASHRAE.G36.FanCoilUnit.Controller conFCU[5](each TSupSet_max=
        308.15, each TSupSet_min=285.85)
    annotation (Placement(transformation(extent={{-52,-34},{-2,54}})));
  BoundaryConditions.WeatherData.ReaderTMY3 weaDat(each filNam=
        Modelica.Utilities.Files.loadResource(
        "modelica://Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos"),
      computeWetBulbTemperature=false) "Weather data reader"
    annotation (Placement(transformation(extent={{-60,100},{-40,120}})));
  Fluid.Sources.Boundary_pT souHea(
    redeclare package Medium = MediumW,
    p(displayUnit="Pa") = 300000 + 6000,
    T=333.15,
    nPorts=5) "Source for heating coil" annotation (Placement(transformation(
        extent={{-9,-9},{9,9}},
        rotation=90,
        origin={11,-49})));
  Fluid.Sources.Boundary_pT sinHea(
    redeclare package Medium = MediumW,
    p=300000,
    T=328.15,
    nPorts=5) "Sink for heating coil" annotation (Placement(transformation(
        extent={{-9,-9},{9,9}},
        rotation=90,
        origin={-11,-49})));
  Fluid.Sources.Boundary_pT sinCoo(
    redeclare package Medium = MediumW,
    p=300000,
    T=288.15,
    nPorts=5) "Sink for cooling coil" annotation (Placement(transformation(
        extent={{-9,-9},{9,9}},
        rotation=90,
        origin={31,-49})));
  Fluid.Sources.Boundary_pT souCoo(
    redeclare package Medium = MediumW,
    p(displayUnit="Pa") = 300000 + 6000,
    T=279.15,
    nPorts=5) "Source for cooling coil loop" annotation (Placement(
        transformation(
        extent={{-9,-9},{9,9}},
        rotation=90,
        origin={51,-49})));
  Controls.SetPoints.OccupancySchedule           occSch(occupancy=3600*{6,19})
    "Occupancy schedule"
    annotation (Placement(transformation(extent={{-140,30},{-120,50}})));
  Modelica.Blocks.Sources.Constant SetAdj(k=0)
    annotation (Placement(transformation(extent={{-140,90},{-120,110}})));
  Controls.OBC.CDL.Reals.Sources.Constant TOccSetPoi(k=23 + 273.15)
    annotation (Placement(transformation(extent={{-140,0},{-120,20}})));
  Controls.OBC.CDL.Reals.Sources.Constant TUnOccCooSet(k=25 + 273.15)
    annotation (Placement(transformation(extent={{-140,-40},{-120,-20}})));
  Controls.OBC.CDL.Reals.Sources.Constant TUnOccHeaSet(k=21 + 273.15)
    annotation (Placement(transformation(extent={{-140,-80},{-120,-60}})));
  Controls.OBC.CDL.Routing.IntegerScalarReplicator intScaRep(nout=5)
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
  Controls.OBC.CDL.Routing.RealScalarReplicator reaScaRep1(nout=5)
    annotation (Placement(transformation(extent={{-100,120},{-80,140}})));
  Controls.OBC.CDL.Reals.GreaterThreshold greThr
    annotation (Placement(transformation(extent={{54,10},{74,30}})));
  Controls.OBC.CDL.Logical.Timer tim(t=120)
    annotation (Placement(transformation(extent={{80,10},{100,30}})));
  Controls.OBC.CDL.Routing.BooleanScalarReplicator booScaRep(nout=5)
    annotation (Placement(transformation(extent={{112,10},{132,30}})));
  Controls.OBC.CDL.Routing.RealScalarReplicator reaScaRep2(nout=5)
    annotation (Placement(transformation(extent={{-100,90},{-80,110}})));
  Controls.OBC.CDL.Routing.RealScalarReplicator reaScaRep3(nout=5)
    annotation (Placement(transformation(extent={{-100,30},{-80,50}})));
  Controls.OBC.CDL.Routing.BooleanScalarReplicator booScaRep1(nout=5)
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  Controls.OBC.CDL.Routing.RealScalarReplicator reaScaRep4(nout=5)
    annotation (Placement(transformation(extent={{-100,-30},{-80,-10}})));
  Controls.OBC.CDL.Routing.RealScalarReplicator reaScaRep5(nout=5)
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
  Controls.OBC.CDL.Routing.RealScalarReplicator reaScaRep6(nout=5)
    annotation (Placement(transformation(extent={{-100,-90},{-80,-70}})));
  Controls.OBC.CDL.Integers.Sources.Constant LimLev(k=0)
    annotation (Placement(transformation(extent={{-140,60},{-120,80}})));

protected
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant cooWarTim(
    final k=0)
    "Cooldown and warm-up time"
    annotation (Placement(transformation(extent={{-140,120},{-120,140}})));

equation
  connect(conFCU.yFan, fanCoiUni.uFan) annotation (Line(points={{0.5,27.6},{18,
          27.6},{18,28},{19,28}},
                              color={0,0,127}));
  connect(conFCU.yCooCoi, fanCoiUni.uCoo) annotation (Line(points={{0.5,10},{8,
          10},{8,24},{19,24}},           color={0,0,127}));
  connect(conFCU.yHeaCoi, fanCoiUni.uHea) annotation (Line(points={{0.5,14.4},{
          18,14.4},{18,20},{19,20}},    color={0,0,127}));
  connect(intScaRep.y, conFCU.uCooDemLimLev) annotation (Line(points={{-78,70},{
          -76,70},{-76,12},{-62,12},{-62,16.6},{-54.5,16.6}},
                                                       color={255,127,0}));
  connect(intScaRep.y, conFCU.uHeaDemLimLev) annotation (Line(points={{-78,70},{
          -76,70},{-76,12.2},{-54.5,12.2}},                              color=
          {255,127,0}));
  connect(cooWarTim.y, reaScaRep1.u) annotation (Line(points={{-118,130},{-102,130}},
                                     color={0,0,127}));
  connect(reaScaRep1.y, conFCU.warUpTim) annotation (Line(points={{-78,130},{-70,
          130},{-70,96},{-62,96},{-62,49.6},{-54.5,49.6}},
                                      color={0,0,127}));
  connect(reaScaRep1.y, conFCU.cooDowTim) annotation (Line(points={{-78,130},{-70,
          130},{-70,96},{-62,96},{-62,45.2},{-54.5,45.2}},
                                      color={0,0,127}));
  connect(greThr.y, tim.u) annotation (Line(points={{76,20},{78,20}},
               color={255,0,255}));
  connect(fanCoiUni[1].yFan_actual, greThr.u) annotation (Line(points={{40.5,34},
          {44,34},{44,20},{52,20}},       color={0,0,127}));
  connect(tim.passed, booScaRep.u)
    annotation (Line(points={{102,12},{104,12},{104,20},{110,20}},
                                                        color={255,0,255}));
  connect(booScaRep.y, conFCU.u1Fan) annotation (Line(points={{134,20},{142,20},
          {142,-64},{-54,-64},{-54,-38},{-60,-38},{-60,-32},{-62,-32},{-62,-23},
          {-54.5,-23}},                 color={255,0,255}));
  connect(fanCoiUni.TAirSup, conFCU.TSup) annotation (Line(points={{41,21.2},{
          44,21.2},{44,-4},{66,-4},{66,-62},{-70,-62},{-70,7.8},{-54.5,7.8}},
                                                            color={0,0,127}));
  connect(SetAdj.y, reaScaRep2.u)
    annotation (Line(points={{-119,100},{-102,100}}, color={0,0,127}));
  connect(reaScaRep2.y, conFCU.setAdj) annotation (Line(points={{-78,100},{-66,100},
          {-66,34.2},{-54.75,34.2}},
                                  color={0,0,127}));
  connect(occSch.tNexOcc, reaScaRep3.u) annotation (Line(points={{-119,46},{-112,
          46},{-112,40},{-102,40}},           color={0,0,127}));
  connect(reaScaRep3.y, conFCU.tNexOcc) annotation (Line(points={{-78,40},{-78,40.8},
          {-54.5,40.8}},                     color={0,0,127}));
  connect(occSch.occupied, booScaRep1.u) annotation (Line(points={{-119,34},{-108,
          34},{-108,10},{-102,10}},  color={255,0,255}));
  connect(booScaRep1.y, conFCU.u1Occ) annotation (Line(points={{-78,10},{-64,10},
          {-64,21.22},{-54.5,21.22}},  color={255,0,255}));
  connect(TOccSetPoi.y, reaScaRep4.u) annotation (Line(points={{-118,10},{-112,10},
          {-112,-20},{-102,-20}},          color={0,0,127}));
  connect(reaScaRep4.y, conFCU.TOccHeaSet) annotation (Line(points={{-78,-20},{-68,
          -20},{-68,-6},{-62,-6},{-62,-1},{-54.5,-1}},        color={0,0,127}));
  connect(reaScaRep4.y, conFCU.TOccCooSet) annotation (Line(points={{-78,-20},{-68,
          -20},{-68,-5.4},{-54.5,-5.4}},  color={0,0,127}));
  connect(TUnOccCooSet.y, reaScaRep5.u)
    annotation (Line(points={{-118,-30},{-108,-30},{-108,-50},{-102,-50}},
                                                        color={0,0,127}));
  connect(reaScaRep5.y, conFCU.TUnoCooSet) annotation (Line(points={{-78,-50},{-64,
          -50},{-64,-16},{-62,-16},{-62,-14.2},{-54.5,-14.2}},
                                          color={0,0,127}));
  connect(TUnOccHeaSet.y, reaScaRep6.u) annotation (Line(points={{-118,-70},{-110,
          -70},{-110,-80},{-102,-80}},
                                   color={0,0,127}));
  connect(reaScaRep6.y, conFCU.TUnoHeaSet) annotation (Line(points={{-78,-80},{-68,
          -80},{-68,-9.8},{-54.5,-9.8}},  color={0,0,127}));

  connect(LimLev.y, intScaRep.u)
    annotation (Line(points={{-118,70},{-102,70}},     color={255,127,0}));
  connect(fanCoiUni[1].port_Air_a, floor1.portsCor[1]) annotation (Line(points={{40,28},
          {48,28},{48,98},{46,98},{46,128},{81.3348,128},{81.3348,103.015}},
                             color={0,127,255}));
  connect(fanCoiUni[1].port_Air_b, floor1.portsCor[2]) annotation (Line(points={{40,24},
          {42,24},{42,28},{48,28},{48,98},{46,98},{46,128},{83.0304,128},{
          83.0304,103.015}},                                         color={0,
          127,255}));
  connect(fanCoiUni[2].port_Air_a, floor1.portsSou[1]) annotation (Line(points={{40,28},
          {48,28},{48,76},{81.3348,76},{81.3348,89.4769}},           color={0,
          127,255}));
  connect(fanCoiUni[2].port_Air_b, floor1.portsSou[2]) annotation (Line(points={{40,24},
          {42,24},{42,28},{48,28},{48,76},{83.0304,76},{83.0304,89.4769}},
                                                                       color={0,
          127,255}));
  connect(fanCoiUni[3].port_Air_a, floor1.portsEas[1]) annotation (Line(points={{40,28},
          {48,28},{48,76},{138,76},{138,103.015},{119.996,103.015}},
                     color={0,127,255}));
  connect(fanCoiUni[3].port_Air_b, floor1.portsEas[2]) annotation (Line(points={{40,24},
          {42,24},{42,28},{48,28},{48,76},{138,76},{138,103.015},{121.691,
          103.015}},         color={0,127,255}));
  connect(fanCoiUni[4].port_Air_a, floor1.portsNor[1]) annotation (Line(points={{40,28},
          {48,28},{48,98},{46,98},{46,128},{81.3348,128},{81.3348,114.523}},
                             color={0,127,255}));
  connect(fanCoiUni[4].port_Air_b, floor1.portsNor[2]) annotation (Line(points={{40,24},
          {42,24},{42,28},{48,28},{48,98},{46,98},{46,128},{83.0304,128},{
          83.0304,114.523}},               color={0,127,255}));
  connect(fanCoiUni[5].port_Air_a, floor1.portsWes[1]) annotation (Line(points={{40,28},
          {48,28},{48,98},{46,98},{46,103.015},{60.3087,103.015}},
        color={0,127,255}));
  connect(fanCoiUni[5].port_Air_b, floor1.portsWes[2]) annotation (Line(points={{40,24},
          {42,24},{42,28},{48,28},{48,98},{46,98},{46,103.015},{62.0043,103.015}},
                                       color={0,127,255}));
  connect(floor1.TRooAir[5], conFCU[1].TZon) annotation (Line(points={{131.696,
          102.677},{134,102.677},{134,108},{144,108},{144,-68},{-62,-68},{-62,
          -34},{-66,-34},{-66,-14},{-64,-14},{-64,3.4},{-54.5,3.4}},
                                                        color={0,0,127}));
  connect(conFCU[2].TZon, floor1.TRooAir[1]) annotation (Line(points={{-54.5,
          3.4},{-64,3.4},{-64,-14},{-66,-14},{-66,-34},{-62,-34},{-62,-68},{144,
          -68},{144,106},{131.696,106},{131.696,101.323}},        color={0,0,127}));
  connect(conFCU[3].TZon, floor1.TRooAir[2]) annotation (Line(points={{-54.5,
          3.4},{-64,3.4},{-64,-14},{-66,-14},{-66,-34},{-62,-34},{-62,-68},{144,
          -68},{144,106},{131.696,106},{131.696,101.662}},        color={0,0,127}));
  connect(conFCU[4].TZon, floor1.TRooAir[3]) annotation (Line(points={{-54.5,
          3.4},{-64,3.4},{-64,-14},{-66,-14},{-66,-34},{-62,-34},{-62,-68},{144,
          -68},{144,106},{131.696,106},{131.696,102}},            color={0,0,127}));
  connect(conFCU[5].TZon, floor1.TRooAir[4]) annotation (Line(points={{-54.5,
          3.4},{-64,3.4},{-64,-14},{-66,-14},{-66,-34},{-62,-34},{-62,-68},{144,
          -68},{144,106},{131.696,106},{131.696,102.338}},        color={0,0,127}));
  connect(sinHea.ports, fanCoiUni.port_HW_b) annotation (Line(points={{-11,-40},
          {-24,-40},{-24,-66},{68,-66},{68,-2},{24,-2},{24,16}}, color={0,127,
          255}));
  connect(fanCoiUni.port_HW_a, souHea.ports) annotation (Line(points={{27,16},{
          27,-36},{11,-36},{11,-40}}, color={0,127,255}));
  connect(fanCoiUni.port_CHW_a, souCoo.ports) annotation (Line(points={{36,16},
          {36,-36},{51,-36},{51,-40}}, color={0,127,255}));
  connect(fanCoiUni.port_CHW_b, sinCoo.ports) annotation (Line(points={{33,16},
          {33,-36},{31,-36},{31,-40}}, color={0,127,255}));
  connect(weaDat.weaBus, floor1.weaBus) annotation (Line(
      points={{-40,110},{42,110},{42,136},{101.174,136},{101.174,130.769}},
      color={255,204,51},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}})),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-160,-100},{160,160}})),
    experiment(
      StartTime=259200,
      StopTime=345600,
      Interval=60,
      Tolerance=1e-07,
      __Dymola_Algorithm="Cvode"),
    Documentation(info="<html>
<p><span style=\"font-family: Arial;\">This model consist of an HVAC system, a building envelope model and a model for air flow through building leakage and through open doors. The HVAC system consists of an electric heating coil, a hot-water heating coil, a chilled water heating coil, and a fan. The figure below shows a schematic of the HVAC system.</span></p>
</html>"));
end FanCoilUnit;
