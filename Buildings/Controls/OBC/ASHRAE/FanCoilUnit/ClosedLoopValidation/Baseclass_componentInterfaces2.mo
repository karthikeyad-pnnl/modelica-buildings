within Buildings.Controls.OBC.ASHRAE.FanCoilUnit.ClosedLoopValidation;
partial model Baseclass_componentInterfaces2

  parameter Boolean has_economizer
    "Does the zone equipment have an economizer?";

  parameter Boolean has_coolingCoil
    "Does the zone equipment have a cooling coil?";

  parameter Boolean has_coolingCoilCCW
    "Does the zone equipment have a chilled water cooling coil?";

  parameter Boolean has_heatingCoil
    "Does the zone equipment have a heating coil?";

  parameter Boolean has_heatingCoilHHW
    "Does the zone equipment have a hot water heating coil?";

  parameter Real mAir_flow_nominal
    "Nominal air flow rate";

  parameter Real mHHW_flow_nominal
    "Nominal HHW flow rate";

  parameter Real mCCW_flow_nominal
    "Nominal CCW flow rate";

  extends Buildings.Controls.OBC.ASHRAE.FanCoilUnit.ClosedLoopValidation.Baseclass_externalInterfaces;

  Fluid.Actuators.Dampers.MixingBox eco(
    redeclare package Medium = MediumA,
    mOut_flow_nominal=mAir_flow_nominal,
    dpDamOut_nominal=50,
    mRec_flow_nominal=mAir_flow_nominal,
    dpDamRec_nominal=50,
    mExh_flow_nominal=mAir_flow_nominal,
    dpDamExh_nominal=50) if                has_economizer
    annotation (Placement(transformation(extent={{-166,0},{-146,20}})));
  Fluid.Sensors.VolumeFlowRate senVolFlo2(redeclare package Medium = MediumA,
                                          m_flow_nominal=mAir_flow_nominal) if
                                             has_economizer
    annotation (Placement(transformation(extent={{-200,-50},{-180,-30}})));
  Fluid.Sensors.TemperatureTwoPort senTem2(redeclare package Medium = MediumA,
      m_flow_nominal=mAir_flow_nominal)
    annotation (Placement(transformation(extent={{-140,-50},{-120,-30}})));
  replaceable Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.VariableSpeed coolingCoil_DX(
      redeclare package Medium = MediumA, dp_nominal=50) if
    has_coolingCoil and not has_coolingCoilCCW
    annotation (Placement(transformation(extent={{60,-50},{80,-30}})));
  replaceable Buildings.Fluid.HeatExchangers.HeaterCooler_u heatingCoil_electric(
      redeclare package Medium = MediumA, m_flow_nominal=mAir_flow_nominal,
    dp_nominal=50) if
    has_heatingCoil and not has_heatingCoilHHW
    annotation (Placement(transformation(extent={{-50,-50},{-30,-30}})));
  Fluid.Movers.FlowControlled_m_flow fan(redeclare package Medium = MediumA,
      m_flow_nominal=mAir_flow_nominal,
    dp_nominal=1000)
    annotation (Placement(transformation(extent={{-100,-50},{-80,-30}})));
  replaceable Fluid.HeatExchangers.DryCoilCounterFlow heatingCoil_HHW(
    redeclare package Medium1 = MediumW,
    redeclare package Medium2 = MediumA,
    m1_flow_nominal=mHHW_flow_nominal,
    m2_flow_nominal=mAir_flow_nominal,
    dp1_nominal=50,
    dp2_nominal=50,
    UA_nominal=1000) if
    has_heatingCoil and has_heatingCoilHHW
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={-40,0})));
  replaceable Fluid.HeatExchangers.WetCoilCounterFlow coolingCoil_CCW(
    redeclare package Medium1 = MediumW,
    redeclare package Medium2 = MediumA,
    m1_flow_nominal=mCCW_flow_nominal,
    m2_flow_nominal=mAir_flow_nominal,
    dp1_nominal=50,
    dp2_nominal=50,
    UA_nominal=1000) if
    has_coolingCoil and has_coolingCoilCCW
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={70,0})));
  Fluid.Actuators.Valves.TwoWayLinear val(redeclare package Medium = MediumW,
    m_flow_nominal=mCCW_flow_nominal,
    dpValve_nominal=50) if                   has_coolingCoil and
    has_coolingCoilCCW
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=90,
        origin={90,-110})));
  Fluid.Actuators.Valves.TwoWayLinear val1(redeclare package Medium = MediumW,
    m_flow_nominal=mHHW_flow_nominal,
    dpValve_nominal=50) if                    has_heatingCoil and
    has_heatingCoilHHW
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=90,
        origin={-20,-110})));
  Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium = MediumA,
      m_flow_nominal=mAir_flow_nominal)
    annotation (Placement(transformation(extent={{0,-50},{20,-30}})));
  Fluid.Sensors.TemperatureTwoPort senTem1(redeclare package Medium = MediumA,
      m_flow_nominal=mAir_flow_nominal)
    annotation (Placement(transformation(extent={{150,-50},{170,-30}})));
  Fluid.Sensors.VolumeFlowRate senVolFlo(redeclare package Medium = MediumA,
      m_flow_nominal=mAir_flow_nominal)
    annotation (Placement(transformation(extent={{180,-50},{200,-30}})));
  Fluid.Sensors.VolumeFlowRate senVolFlo1(redeclare package Medium = MediumA,
      m_flow_nominal=mAir_flow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={180,40})));
  Fluid.FixedResistances.LosslessPipe pip(redeclare package Medium = MediumA,
      m_flow_nominal=mAir_flow_nominal) if   not has_economizer
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={-110,60})));
  Controls.OBC.CDL.Interfaces.RealOutput TMixAir
    annotation (Placement(transformation(extent={{220,180},{260,220}})));
  Controls.OBC.CDL.Interfaces.RealOutput THeaAir
    annotation (Placement(transformation(extent={{220,140},{260,180}})));
  Controls.OBC.CDL.Interfaces.RealOutput TDisAir
    annotation (Placement(transformation(extent={{220,100},{260,140}})));
  Controls.OBC.CDL.Interfaces.RealOutput VDisAir_nominal
    annotation (Placement(transformation(extent={{220,-180},{260,-140}})));
  Controls.OBC.CDL.Interfaces.RealOutput VRetAir_nominal
    annotation (Placement(transformation(extent={{220,-140},{260,-100}})));
  Controls.OBC.CDL.Interfaces.RealOutput VOA_nominal if has_economizer
    annotation (Placement(transformation(extent={{220,-100},{260,-60}})));
  Controls.OBC.CDL.Interfaces.RealInput uOA if has_economizer
    annotation (Placement(transformation(extent={{-260,40},{-220,80}})));
  BoundaryConditions.WeatherData.Bus weaBus if has_coolingCoil and not
    has_coolingCoilCCW                      annotation (Placement(
        transformation(extent={{-210,180},{-170,220}}), iconTransformation(
          extent={{-466,-14},{-446,6}})));
  Controls.OBC.CDL.Interfaces.RealOutput PFan
    annotation (Placement(transformation(extent={{220,220},{260,260}})));
  Fluid.Sensors.VolumeFlowRate senVolFlo3(redeclare package Medium = MediumW,
      m_flow_nominal=mHHW_flow_nominal) if has_heatingCoil and
    has_heatingCoilHHW
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=90,
        origin={-40,-180})));
  Fluid.Sensors.VolumeFlowRate senVolFlo4(redeclare package Medium = MediumW,
      m_flow_nominal=mCCW_flow_nominal) if has_coolingCoil and
    has_coolingCoilCCW
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=90,
        origin={80,-180})));
  Fluid.Sensors.TemperatureTwoPort senTem3(redeclare package Medium = MediumW,
      m_flow_nominal=mCCW_flow_nominal) if has_coolingCoil and
    has_coolingCoilCCW
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=90,
        origin={80,-220})));
  Fluid.Sensors.TemperatureTwoPort senTem4(redeclare package Medium = MediumW,
      m_flow_nominal=mHHW_flow_nominal) if has_heatingCoil and
    has_heatingCoilHHW
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=90,
        origin={-40,-220})));
  Fluid.Sensors.TemperatureTwoPort senTem5(redeclare package Medium = MediumW,
      m_flow_nominal=mHHW_flow_nominal) if has_heatingCoil and
    has_heatingCoilHHW
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=270,
        origin={-80,-200})));
  Fluid.Sensors.TemperatureTwoPort senTem6(redeclare package Medium = MediumW,
      m_flow_nominal=mCCW_flow_nominal) if has_coolingCoil and
    has_coolingCoilCCW
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=270,
        origin={50,-200})));
equation
  connect(senVolFlo1.port_b, eco.port_Ret) annotation (Line(points={{170,40},{-134,
          40},{-134,4},{-146,4}}, color={0,127,255}));
  connect(port_OA_inlet, senVolFlo2.port_a)
    annotation (Line(points={{-220,-40},{-200,-40}}, color={0,127,255}));
  connect(senVolFlo2.port_b, eco.port_Out) annotation (Line(points={{-180,-40},{
          -170,-40},{-170,16},{-166,16}}, color={0,127,255}));
  connect(port_OA_exhaust, eco.port_Exh) annotation (Line(points={{-220,40},{-180,
          40},{-180,4},{-166,4}}, color={0,127,255}));
  connect(eco.port_Sup, senTem2.port_a) annotation (Line(points={{-146,16},{-140,
          16},{-140,-40}}, color={0,127,255}));
  connect(val1.port_b,heatingCoil_HHW. port_a1)
    annotation (Line(points={{-20,-100},{-20,-6},{-30,-6}},
                                                        color={0,127,255}));
  connect(val.port_b,coolingCoil_CCW. port_a1) annotation (Line(points={{90,-100},
          {90,-6},{80,-6}},        color={0,127,255}));
  connect(fan.port_b,heatingCoil_electric. port_a)
    annotation (Line(points={{-80,-40},{-50,-40}},  color={0,127,255}));
  connect(fan.port_b,heatingCoil_HHW. port_a2) annotation (Line(points={{-80,-40},
          {-70,-40},{-70,6},{-50,6}}, color={0,127,255}));
  connect(heatingCoil_HHW.port_b2,senTem. port_a) annotation (Line(points={{-30,6},
          {-10,6},{-10,-40},{0,-40}},      color={0,127,255}));
  connect(heatingCoil_electric.port_b,senTem. port_a)
    annotation (Line(points={{-30,-40},{0,-40}},   color={0,127,255}));
  connect(senTem.port_b,coolingCoil_CCW. port_a2) annotation (Line(points={{20,-40},
          {40,-40},{40,6},{60,6}}, color={0,127,255}));
  connect(senTem.port_b,coolingCoil_DX. port_a)
    annotation (Line(points={{20,-40},{60,-40}}, color={0,127,255}));
  connect(coolingCoil_CCW.port_b2,senTem1. port_a) annotation (Line(points={{80,6},{
          110,6},{110,-40},{150,-40}},     color={0,127,255}));
  connect(coolingCoil_DX.port_b,senTem1. port_a)
    annotation (Line(points={{80,-40},{150,-40}}, color={0,127,255}));
  connect(senTem1.port_b,senVolFlo. port_a)
    annotation (Line(points={{170,-40},{180,-40}}, color={0,127,255}));
  connect(senVolFlo.port_b, port_supply)
    annotation (Line(points={{200,-40},{220,-40}}, color={0,127,255}));
  connect(senVolFlo1.port_a, port_return)
    annotation (Line(points={{190,40},{220,40}}, color={0,127,255}));
  connect(senTem2.port_b, fan.port_a)
    annotation (Line(points={{-120,-40},{-100,-40}}, color={0,127,255}));
  connect(senVolFlo1.port_b, pip.port_a) annotation (Line(points={{170,40},{-94,
          40},{-94,60},{-100,60}}, color={0,127,255}));
  connect(pip.port_b, senTem2.port_a) annotation (Line(points={{-120,60},{-140,60},
          {-140,-40}}, color={0,127,255}));
  connect(senTem2.T, TMixAir) annotation (Line(points={{-130,-29},{-130,200},{240,
          200}}, color={0,0,127}));
  connect(senTem.T, THeaAir)
    annotation (Line(points={{10,-29},{10,160},{240,160}}, color={0,0,127}));
  connect(senTem1.T, TDisAir)
    annotation (Line(points={{160,-29},{160,120},{240,120}}, color={0,0,127}));
  connect(senVolFlo2.V_flow, VOA_nominal) annotation (Line(points={{-190,-29},{-190,
          -20},{-160,-20},{-160,-80},{240,-80}},   color={0,0,127}));
  connect(senVolFlo.V_flow, VDisAir_nominal) annotation (Line(points={{190,-29},
          {190,-20},{206,-20},{206,-160},{240,-160}}, color={0,0,127}));
  connect(senVolFlo1.V_flow, VRetAir_nominal) annotation (Line(points={{180,29},
          {180,20},{174,20},{174,-120},{240,-120}}, color={0,0,127}));
  connect(uOA, eco.y)
    annotation (Line(points={{-240,60},{-156,60},{-156,22}}, color={0,0,127}));
  connect(weaBus.TDryBul, coolingCoil_DX.TConIn) annotation (Line(
      points={{-190,200},{-170,200},{-170,188},{46,188},{46,-37},{59,-37}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(senVolFlo3.port_b, val1.port_a) annotation (Line(points={{-40,-170},{-40,
          -140},{-20,-140},{-20,-120}}, color={0,127,255}));
  connect(senVolFlo4.port_b, val.port_a) annotation (Line(points={{80,-170},{80,
          -140},{90,-140},{90,-120}}, color={0,127,255}));
  connect(port_CCW_inlet, senTem3.port_a)
    annotation (Line(points={{80,-260},{80,-230}}, color={0,127,255}));
  connect(senTem3.port_b, senVolFlo4.port_a)
    annotation (Line(points={{80,-210},{80,-190}}, color={0,127,255}));
  connect(port_HHW_inlet, senTem4.port_a)
    annotation (Line(points={{-40,-260},{-40,-230}}, color={0,127,255}));
  connect(senTem4.port_b, senVolFlo3.port_a)
    annotation (Line(points={{-40,-210},{-40,-190}}, color={0,127,255}));
  connect(port_HHW_outlet, senTem5.port_b)
    annotation (Line(points={{-80,-260},{-80,-210}}, color={0,127,255}));
  connect(senTem5.port_a, heatingCoil_HHW.port_b1) annotation (Line(points={{
          -80,-190},{-80,-140},{-60,-140},{-60,-6},{-50,-6}}, color={0,127,
          255}));
  connect(coolingCoil_CCW.port_b1, senTem6.port_a)
    annotation (Line(points={{60,-6},{50,-6},{50,-190}}, color={0,127,255}));
  connect(senTem6.port_b, port_CCW_outlet) annotation (Line(points={{50,-210},
          {50,-260},{40,-260}}, color={0,127,255}));
  connect(fan.P, PFan) annotation (Line(points={{-79,-31},{-76,-31},{-76,240},
          {240,240}}, color={0,0,127}));
  connect(uFan, fan.m_flow_in) annotation (Line(points={{0,280},{0,20},{-90,20},
          {-90,-28}}, color={0,0,127}));
  connect(uCoo, val.y) annotation (Line(points={{120,280},{120,-70},{70,-70},{
          70,-110},{78,-110}}, color={0,0,127}));
  connect(uHea, val1.y) annotation (Line(points={{-120,280},{-120,102},{-66,102},
          {-66,-110},{-32,-110}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-220,-260},
            {220,260}})),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-220,-260},{220,260}})));
end Baseclass_componentInterfaces2;
