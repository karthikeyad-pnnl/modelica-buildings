within Buildings.Templates.Plants.HeatPumps.Validation;
model CoolingCoilAssembly
  extends Buildings.Fluid.Interfaces.PartialTwoPortInterface;
  replaceable package MediumA=Buildings.Media.Air
    constrainedby Modelica.Media.Interfaces.PartialMedium
    "Main medium (common for CHW and HW)";
  parameter Real mAir_flow_nominal
    "Nominal cooling air flow rate";
  Fluid.HeatExchangers.WetCoilCounterFlow cooCoi(redeclare package Medium1 =
        Medium, redeclare package Medium2 = MediumA,
    m1_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}})));
  Buildings.Controls.OBC.CDL.Reals.PID conValChiWat(
    each k=0.1,
    each Ti=60,
    each final reverseActing=false) "Chilled water valve controller"
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  Fluid.Sensors.TemperatureTwoPort senTemCooSup1(redeclare package Medium =
        MediumA, m_flow_nominal=pla.mChiWat_flow_nominal)
    annotation (Placement(transformation(extent={{-20,10},{-40,30}})));
  Fluid.Sources.Boundary_pT bou(redeclare package Medium = MediumA, nPorts=1)
    annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
  Fluid.Sensors.TemperatureTwoPort senTemCooSup(redeclare package Medium =
        Medium, m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-40,-36},{-20,-16}})));
  Fluid.Actuators.Valves.TwoWayEqualPercentage valDisChiWat(
    redeclare final package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    dpValve_nominal=3E4,
    dpFixed_nominal=datAll.pla.ctl.dpChiWatRemSet_max[1] - 3E4)
    if have_chiWat
    "Distribution system approximated by variable flow resistance"
    annotation (Placement(transformation(extent={{30,-36},{50,-16}})));
  Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = MediumA,
    use_Xi_in=true,
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{80,10},{60,30}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TAirSupSet
    "Supply air temperature setpoint" annotation (Placement(transformation(
          extent={{-140,40},{-100,80}}), iconTransformation(extent={{-140,20},{
            -100,60}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TAirMix
    "Measured mixed air temperature" annotation (Placement(transformation(
          extent={{-140,-80},{-100,-40}}), iconTransformation(extent={{-140,-60},
            {-100,-20}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput XiAirMix
    "Measured mixed air humidity ratio" annotation (Placement(transformation(
          extent={{-140,-120},{-100,-80}}), iconTransformation(extent={{-140,
            -100},{-100,-60}})));
  Buildings.Controls.OBC.CDL.Reals.AddParameter addPar(p=1)
    annotation (Placement(transformation(extent={{-60,-130},{-40,-110}})));
  Buildings.Controls.OBC.CDL.Reals.Divide div1
    annotation (Placement(transformation(extent={{-20,-90},{0,-70}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gai(k=-1)
    annotation (Placement(transformation(extent={{20,-130},{40,-110}})));
  Buildings.Controls.OBC.CDL.Reals.AddParameter addPar1(p=1)
    annotation (Placement(transformation(extent={{60,-130},{80,-110}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput mAir_flow
    "Measured mixed air temperature" annotation (Placement(transformation(
          extent={{-140,80},{-100,120}}), iconTransformation(extent={{-140,60},
            {-100,100}})));
  Buildings.Controls.OBC.ASHRAE.G36.AHUs.MultiZone.VAV.SetPoints.PlantRequests reqPlaRes(final
      heaCoi=Buildings.Controls.OBC.ASHRAE.G36.Types.HeatingCoil.WaterBased,
      final cooCoi=if have_chiWat then Buildings.Controls.OBC.ASHRAE.G36.Types.CoolingCoil.WaterBased
         else Buildings.Controls.OBC.ASHRAE.G36.Types.CoolingCoil.None)
    "Plant and reset request"
    annotation (Placement(transformation(extent={{40,60},{60,80}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con(k=0)
    annotation (Placement(transformation(extent={{-60,70},{-40,90}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerOutput yChiWatResReq
    "Chilled water reset request"
    annotation (Placement(transformation(extent={{100,60},{140,100}}),
        iconTransformation(extent={{100,60},{140,100}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerOutput yChiPlaReq
    "Chiller plant request"
    annotation (Placement(transformation(extent={{100,20},{140,60}}),
        iconTransformation(extent={{100,20},{140,60}})));
equation
  connect(bou.ports[1], senTemCooSup1.port_b)
    annotation (Line(points={{-60,20},{-40,20}}, color={0,127,255}));
  connect(senTemCooSup1.port_a, cooCoi.port_b2) annotation (Line(points={{-20,
          20},{-16,20},{-16,6},{-10,6}}, color={0,127,255}));
  connect(cooCoi.port_a2, boundary.ports[1]) annotation (Line(points={{10,6},{
          54,6},{54,20},{60,20}}, color={0,127,255}));
  connect(senTemCooSup1.T, conValChiWat.u_m) annotation (Line(points={{-30,31},
          {-30,34},{0,34},{0,38}}, color={0,0,127}));
  connect(conValChiWat.y, valDisChiWat.y)
    annotation (Line(points={{12,50},{40,50},{40,-14}}, color={0,0,127}));
  connect(senTemCooSup.port_b, cooCoi.port_a1) annotation (Line(points={{-20,
          -26},{-16,-26},{-16,-6},{-10,-6}}, color={0,127,255}));
  connect(senTemCooSup.port_a, port_a) annotation (Line(points={{-40,-26},{-90,
          -26},{-90,0},{-100,0}}, color={0,127,255}));
  connect(cooCoi.port_b1, valDisChiWat.port_a) annotation (Line(points={{10,-6},
          {26,-6},{26,-26},{30,-26}}, color={0,127,255}));
  connect(valDisChiWat.port_b, port_b) annotation (Line(points={{50,-26},{62,
          -26},{62,0},{100,0}}, color={0,127,255}));
  connect(TAirSupSet, conValChiWat.u_s) annotation (Line(points={{-120,60},{-20,
          60},{-20,50},{-12,50}}, color={0,0,127}));
  connect(TAirMix, boundary.T_in) annotation (Line(points={{-120,-60},{92,-60},
          {92,24},{82,24}}, color={0,0,127}));
  connect(XiAirMix, addPar.u) annotation (Line(points={{-120,-100},{-80,-100},{
          -80,-120},{-62,-120}}, color={0,0,127}));
  connect(XiAirMix, div1.u1) annotation (Line(points={{-120,-100},{-32,-100},{
          -32,-74},{-22,-74}}, color={0,0,127}));
  connect(addPar.y, div1.u2) annotation (Line(points={{-38,-120},{-30,-120},{
          -30,-86},{-22,-86}}, color={0,0,127}));
  connect(div1.y, boundary.Xi_in[1]) annotation (Line(points={{2,-80},{116,-80},
          {116,16},{82,16}}, color={0,0,127}));
  connect(div1.y, gai.u) annotation (Line(points={{2,-80},{10,-80},{10,-120},{
          18,-120}}, color={0,0,127}));
  connect(gai.y, addPar1.u)
    annotation (Line(points={{42,-120},{58,-120}}, color={0,0,127}));
  connect(addPar1.y, boundary.Xi_in[2]) annotation (Line(points={{82,-120},{90,
          -120},{90,-80},{116,-80},{116,16},{82,16}}, color={0,0,127}));
  connect(mAir_flow, boundary.m_flow_in) annotation (Line(points={{-120,100},{
          94,100},{94,28},{82,28}}, color={0,0,127}));
  connect(conValChiWat.y, reqPlaRes.uCooCoiSet) annotation (Line(points={{12,50},
          {28,50},{28,67},{38,67}}, color={0,0,127}));
  connect(TAirSupSet, reqPlaRes.TAirSupSet) annotation (Line(points={{-120,60},
          {-20,60},{-20,73},{38,73}}, color={0,0,127}));
  connect(senTemCooSup1.T, reqPlaRes.TAirSup)
    annotation (Line(points={{-30,31},{-30,78},{38,78}}, color={0,0,127}));
  connect(con.y, reqPlaRes.uHeaCoiSet) annotation (Line(points={{-38,80},{20,80},
          {20,62},{38,62}}, color={0,0,127}));
  connect(reqPlaRes.yChiPlaReq, yChiPlaReq) annotation (Line(points={{62,73},{
          80,73},{80,40},{120,40}}, color={255,127,0}));
  connect(reqPlaRes.yChiWatResReq, yChiWatResReq) annotation (Line(points={{62,
          78},{80,78},{80,80},{120,80}}, color={255,127,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CoolingCoilAssembly;
