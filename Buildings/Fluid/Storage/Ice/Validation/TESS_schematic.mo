within Buildings.Fluid.Storage.Ice.Validation;
model TESS_schematic

  replaceable package MediumCHW =
    Buildings.Media.Antifreeze.PropyleneGlycolWater "Medium in the component";

  replaceable package MediumCW =
    Buildings.Media.Water "Medium in the component";

  parameter Modelica.Units.SI.MassFlowRate mCHW_flow_nominal = datChi.mEva_flow_nominal;

  parameter Modelica.Units.SI.MassFlowRate mCW_flow_nominal=datChi.mCon_flow_nominal;

  parameter Modelica.Units.SI.Mass SOC_start=0
    "Start value of ice mass in the tank";

  ControlledTank_uQReq iceTank(
    redeclare package Medium = MediumCHW,
    m_flow_nominal=mCHW_flow_nominal,
    dp_nominal=10,
    SOC_start=SOC_start,
    per=perIceTan)
    annotation (Placement(transformation(extent={{58,-60},{78,-40}})));
  Chillers.ElectricReformulatedEIR chiller(
    redeclare package Medium1 = MediumCW,
    redeclare package Medium2 = MediumCHW,
    m1_flow_nominal=mCW_flow_nominal,
    m2_flow_nominal=mCHW_flow_nominal,
    dp1_nominal=10,
    dp2_nominal=10,
    per=datChi) annotation (Placement(transformation(extent={{68,40},{88,60}})));
  Actuators.Valves.TwoWayPressureIndependent chargingValve(
    redeclare package Medium = MediumCHW,
    m_flow_nominal=mCHW_flow_nominal,
    dpValve_nominal=10) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={38,10})));
  Sources.MassFlowSource_T returnCHW(
    redeclare package Medium = MediumCHW,
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1) annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          origin={4,-70})));
  Movers.FlowControlled_m_flow chargingPump(redeclare package Medium =
        MediumCHW, m_flow_nominal=mCHW_flow_nominal) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={98,10})));
  Actuators.Valves.TwoWayPressureIndependent dischargeValve(
    redeclare package Medium = MediumCHW,
    m_flow_nominal=mCHW_flow_nominal,
    dpValve_nominal=10) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={102,-78})));
  Sources.Boundary_pT supplyCHW(redeclare package Medium = MediumCHW, nPorts=1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={128,-78})));
  Modelica.Blocks.Interfaces.RealInput uQReq(final unit="W", final displayUnit="W")
    "Required charge/discharge rate"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}}),
        iconTransformation(extent={{-140,0},{-100,40}})));
  Modelica.Blocks.Interfaces.RealOutput Q_flow(final unit="W")
    "Heat flow rate, positive during charging, negative when melting the ice"
    annotation (Placement(transformation(extent={{140,-30},{160,-10}}),
        iconTransformation(extent={{100,-30},{120,-10}})));
  Controls.OBC.CDL.Continuous.GreaterThreshold greThr
    annotation (Placement(transformation(extent={{-82,20},{-62,40}})));
  Controls.OBC.CDL.Conversions.BooleanToReal booToRea
    annotation (Placement(transformation(extent={{-46,20},{-26,40}})));
  Controls.OBC.CDL.Continuous.MultiplyByParameter gai(k=mCHW_flow_nominal)
    annotation (Placement(transformation(extent={{-6,20},{14,40}})));
  Controls.OBC.CDL.Conversions.BooleanToReal booToRea1(realTrue=0, realFalse=1)
    annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
  Sources.Boundary_pT bou2(redeclare package Medium = MediumCW, nPorts=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={130,50})));
  Sources.MassFlowSource_T boundary1(
    redeclare package Medium = MediumCW,
    use_m_flow_in=false,
    m_flow=mCW_flow_nominal,
    use_T_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={42,66})));
  Modelica.Blocks.Interfaces.RealInput TOut(final unit="K", displayUnit="degC")
    "Prescribed outdoor air temperature"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}}),
        iconTransformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput TRet(final unit="K", displayUnit="degC")
    "Chilled water supply temperature from chiller" annotation (Placement(
        transformation(extent={{-140,-70},{-100,-30}}), iconTransformation(
          extent={{-140,-60},{-100,-20}})));
  Controls.OBC.CDL.Continuous.Sources.Constant con1(k=273.15 - 5)
    annotation (Placement(transformation(extent={{-92,50},{-72,70}})));
  parameter Data.Tank.Generic perIceTan
    annotation (Placement(transformation(extent={{76,72},{96,92}})));
  parameter Chillers.Data.ElectricReformulatedEIR.Generic datChi
    annotation (Placement(transformation(extent={{106,72},{126,92}})));
  Modelica.Blocks.Interfaces.RealOutput SOC(final unit="1")
    "state of charge"
    annotation (Placement(transformation(extent={{140,10},{160,30}}),
        iconTransformation(extent={{100,10},{120,30}})));

  Modelica.Blocks.Interfaces.RealInput mCHW_flow(
    final unit="kg/s",
    displayUnit="kg/s",
    quantity="MassFlowRate")
    "Measured chiled water flowrate"
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}}),
      iconTransformation(extent={{-140,-120},{-100,-80}})));

equation
  connect(chiller.port_b2, chargingValve.port_a)
    annotation (Line(points={{68,44},{38,44},{38,20}}, color={0,127,255}));
  connect(chargingPump.port_b, chiller.port_a2)
    annotation (Line(points={{98,20},{98,44},{88,44}}, color={0,127,255}));
  connect(uQReq, iceTank.uQReq) annotation (Line(points={{-120,0},{-90,0},{-90,
          -44},{56,-44}}, color={0,0,127}));
  connect(iceTank.Q_flow, Q_flow) annotation (Line(points={{79,-46},{124,-46},{
          124,-20},{150,-20}}, color={0,0,127}));
  connect(uQReq, greThr.u) annotation (Line(points={{-120,0},{-90,0},{-90,30},{
          -84,30}},
                color={0,0,127}));
  connect(greThr.y, booToRea.u) annotation (Line(points={{-60,30},{-48,30}},
                         color={255,0,255}));
  connect(booToRea.y, chargingValve.y) annotation (Line(points={{-24,30},{-18,
          30},{-18,-8},{50,-8},{50,10}}, color={0,0,127}));
  connect(chargingPump.m_flow_in, gai.y)
    annotation (Line(points={{86,10},{86,30},{16,30}}, color={0,0,127}));
  connect(booToRea.y, gai.u)
    annotation (Line(points={{-24,30},{-8,30}}, color={0,0,127}));
  connect(iceTank.port_b, dischargeValve.port_a) annotation (Line(points={{78,
          -50},{84,-50},{84,-78},{92,-78}}, color={0,127,255}));
  connect(dischargeValve.port_b, supplyCHW.ports[1])
    annotation (Line(points={{112,-78},{118,-78}}, color={0,127,255}));
  connect(iceTank.port_b, chargingPump.port_a)
    annotation (Line(points={{78,-50},{98,-50},{98,0}}, color={0,127,255}));
  connect(greThr.y, booToRea1.u) annotation (Line(points={{-60,30},{-54,30},{
          -54,-20},{-42,-20}},
                         color={255,0,255}));
  connect(booToRea1.y, dischargeValve.y)
    annotation (Line(points={{-18,-20},{102,-20},{102,-66}}, color={0,0,127}));
  connect(chiller.port_b1, bou2.ports[1])
    annotation (Line(points={{88,56},{88,50},{120,50}}, color={0,127,255}));
  connect(boundary1.ports[1], chiller.port_a1)
    annotation (Line(points={{52,66},{52,56},{68,56}}, color={0,127,255}));
  connect(TOut, boundary1.T_in) annotation (Line(points={{-120,80},{-30,80},{
          -30,70},{30,70}},
                         color={0,0,127}));
  connect(greThr.y, chiller.on) annotation (Line(points={{-60,30},{-54,30},{-54,
          53},{66,53}}, color={255,0,255}));
  connect(TRet, returnCHW.T_in) annotation (Line(points={{-120,-50},{-60,-50},{
          -60,-66},{-8,-66}}, color={0,0,127}));
  connect(con1.y, chiller.TSet) annotation (Line(points={{-70,60},{-40,60},{-40,
          47},{66,47}}, color={0,0,127}));
  connect(iceTank.SOC, SOC) annotation (Line(points={{79,-54},{120,-54},{120,20},
          {150,20}}, color={0,0,127}));
  connect(mCHW_flow, returnCHW.m_flow_in) annotation (Line(points={{-120,-80},{
          -80,-80},{-80,-62},{-8,-62}}, color={0,0,127}));
  connect(returnCHW.ports[1], iceTank.port_a)
    annotation (Line(points={{14,-70},{14,-50},{58,-50}}, color={0,127,255}));
  connect(chargingValve.port_b, iceTank.port_a)
    annotation (Line(points={{38,0},{38,-50},{58,-50}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{140,100}}),                                  graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,140},{150,100}},
          textString="%name",
          textColor={0,0,255})}),                                Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{140,
            100}})));
end TESS_schematic;
