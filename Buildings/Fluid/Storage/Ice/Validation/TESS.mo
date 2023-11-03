within Buildings.Fluid.Storage.Ice.Validation;
model TESS

  replaceable package MediumCHW =
    Buildings.Media.Antifreeze.PropyleneGlycolWater "Medium in the component";

  replaceable package MediumCW =
    Buildings.Media.Water "Medium in the component";

  parameter Modelica.Units.SI.MassFlowRate mCHW_flow_nominal = datChi.mEva_flow_nominal;

  parameter Modelica.Units.SI.MassFlowRate mCW_flow_nominal=datChi.mCon_flow_nominal;

  parameter Modelica.Units.SI.Mass SOC_start=0
    "Start value of ice mass in the tank";

  ControlledTank_uQReq controlledTank_uQReq(
    redeclare package Medium = MediumCHW,
    m_flow_nominal=mCHW_flow_nominal,
    dp_nominal=10,
    SOC_start=SOC_start,
    per=perIceTan)
    annotation (Placement(transformation(extent={{10,-60},{30,-40}})));
  Chillers.ElectricReformulatedEIR electricReformulatedEIR(redeclare package
      Medium1 = MediumCW, redeclare package Medium2 = MediumCHW,
    m1_flow_nominal=mCW_flow_nominal,
    m2_flow_nominal=mCHW_flow_nominal,
    dp1_nominal=10,
    dp2_nominal=10,
    per=datChi)
    annotation (Placement(transformation(extent={{20,40},{40,60}})));
  Actuators.Valves.TwoWayPressureIndependent val(redeclare package Medium =
        MediumCHW,
    m_flow_nominal=mCHW_flow_nominal,
    dpValve_nominal=10,
    y_start=0)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=-90,
        origin={-10,10})));
  Sources.MassFlowSource_T boundary(
    redeclare package Medium = MediumCHW,
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={-44,-70})));
  Movers.FlowControlled_m_flow mov(redeclare package Medium = MediumCHW,
                                   m_flow_nominal=mCHW_flow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=90,
        origin={50,10})));
  Actuators.Valves.TwoWayPressureIndependent val1(redeclare package Medium =
        MediumCHW,
    m_flow_nominal=mCHW_flow_nominal,
    dpValve_nominal=10)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=0,
        origin={54,-60})));
  Sources.Boundary_pT bou(redeclare package Medium = MediumCHW,
                          nPorts=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={82,0})));
  Sources.Boundary_pT bou1(redeclare package Medium = MediumCHW,
                           nPorts=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={80,-60})));
  Modelica.Blocks.Interfaces.RealInput uQReq(final unit="W", final displayUnit="W")
    "Required charge/discharge rate"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}}),
        iconTransformation(extent={{-140,0},{-100,40}})));
  Modelica.Blocks.Interfaces.RealOutput Q_flow(final unit="W")
    "Heat flow rate, positive during charging, negative when melting the ice"
    annotation (Placement(transformation(extent={{100,-30},{120,-10}}),
        iconTransformation(extent={{100,-30},{120,-10}})));
  Controls.OBC.CDL.Continuous.GreaterThreshold greThr
    annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
  Controls.OBC.CDL.Conversions.BooleanToReal booToRea
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  Controls.OBC.CDL.Continuous.MultiplyByParameter gai(k=mCHW_flow_nominal)
    annotation (Placement(transformation(extent={{14,20},{34,40}})));
  Controls.OBC.CDL.Conversions.BooleanToReal booToRea1(realTrue=0, realFalse=1)
    annotation (Placement(transformation(extent={{10,-30},{30,-10}})));
  Sources.Boundary_pT bou2(redeclare package Medium = MediumCW, nPorts=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={82,50})));
  Sources.MassFlowSource_T boundary1(
    redeclare package Medium = MediumCW,
    use_m_flow_in=false,
    m_flow=mCW_flow_nominal,
    use_T_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={-10,70})));
  Modelica.Blocks.Interfaces.RealInput TOut(final unit="K", displayUnit="degC")
    "Prescribed outdoor air temperature"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}}),
        iconTransformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput TRet(final unit="K", displayUnit="degC")
    "Chilled water supply temperature from chiller" annotation (Placement(
        transformation(extent={{-140,-70},{-100,-30}}), iconTransformation(
          extent={{-140,-60},{-100,-20}})));
  Controls.OBC.CDL.Continuous.Sources.Constant con1(k=273.15 - 3)
    annotation (Placement(transformation(extent={{-92,50},{-72,70}})));
  parameter Data.Tank.Generic perIceTan
    annotation (Placement(transformation(extent={{60,70},{80,90}})));
  parameter Chillers.Data.ElectricReformulatedEIR.Generic datChi
    annotation (Placement(transformation(extent={{20,72},{40,92}})));
  Sensors.TemperatureTwoPort senTem(redeclare package Medium = MediumCHW,
      m_flow_nominal=mCHW_flow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=-90,
        origin={-10,-12})));
  Sensors.VolumeFlowRate senVolFlo(redeclare package Medium = MediumCHW,
      m_flow_nominal=mCHW_flow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=-90,
        origin={-10,-36})));
  Sensors.TemperatureTwoPort senTem1(redeclare package Medium = MediumCHW,
      m_flow_nominal=mCHW_flow_nominal)
    annotation (Placement(transformation(extent={{-32,-96},{-12,-76}})));
  Sensors.VolumeFlowRate senVolFlo1(redeclare package Medium = MediumCHW,
      m_flow_nominal=mCHW_flow_nominal)
    annotation (Placement(transformation(extent={{2,-96},{22,-76}})));
  Modelica.Blocks.Interfaces.RealOutput SOC(final unit="1")
    "state of charge"
    annotation (Placement(transformation(extent={{100,10},{120,30}}),
        iconTransformation(extent={{100,10},{120,30}})));

  Modelica.Blocks.Interfaces.RealInput mCHW_flow(
    final unit="kg/s",
    displayUnit="kg/s",
    quantity="MassFlowRate")
    "Measured chiled water flowrate"
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}}),
      iconTransformation(extent={{-140,-120},{-100,-80}})));

equation
  connect(electricReformulatedEIR.port_b2, val.port_a)
    annotation (Line(points={{20,44},{-10,44},{-10,20}}, color={0,127,255}));
  connect(mov.port_b, electricReformulatedEIR.port_a2)
    annotation (Line(points={{50,20},{50,44},{40,44}}, color={0,127,255}));
  connect(mov.port_a, bou.ports[1])
    annotation (Line(points={{50,0},{72,0}}, color={0,127,255}));
  connect(uQReq, controlledTank_uQReq.uQReq) annotation (Line(points={{-120,0},{
          -80,0},{-80,-44},{8,-44}}, color={0,0,127}));
  connect(controlledTank_uQReq.Q_flow, Q_flow) annotation (Line(points={{31,-46},
          {80,-46},{80,-20},{110,-20}}, color={0,0,127}));
  connect(uQReq, greThr.u) annotation (Line(points={{-120,0},{-80,0},{-80,40},{-72,
          40}}, color={0,0,127}));
  connect(greThr.y, booToRea.u) annotation (Line(points={{-48,40},{-44,40},{-44,
          30},{-42,30}}, color={255,0,255}));
  connect(booToRea.y, val.y) annotation (Line(points={{-18,30},{6,30},{6,10},{2,
          10}},   color={0,0,127}));
  connect(mov.m_flow_in, gai.y)
    annotation (Line(points={{38,10},{38,30},{36,30}}, color={0,0,127}));
  connect(controlledTank_uQReq.port_b, val1.port_a) annotation (Line(points={{30,
          -50},{40,-50},{40,-60},{44,-60}}, color={0,127,255}));
  connect(val1.port_b, bou1.ports[1])
    annotation (Line(points={{64,-60},{70,-60}}, color={0,127,255}));
  connect(controlledTank_uQReq.port_b, mov.port_a)
    annotation (Line(points={{30,-50},{50,-50},{50,0}}, color={0,127,255}));
  connect(greThr.y, booToRea1.u) annotation (Line(points={{-48,40},{-44,40},{-44,
          -20},{8,-20}}, color={255,0,255}));
  connect(booToRea1.y, val1.y)
    annotation (Line(points={{32,-20},{54,-20},{54,-48}}, color={0,0,127}));
  connect(electricReformulatedEIR.port_b1, bou2.ports[1]) annotation (Line(
        points={{40,56},{60,56},{60,50},{72,50}}, color={0,127,255}));
  connect(boundary1.ports[1], electricReformulatedEIR.port_a1) annotation (Line(
        points={{0,70},{10,70},{10,56},{20,56}}, color={0,127,255}));
  connect(TOut, boundary1.T_in) annotation (Line(points={{-120,80},{-30,80},{-30,
          74},{-22,74}}, color={0,0,127}));
  connect(greThr.y, electricReformulatedEIR.on) annotation (Line(points={{-48,40},
          {-44,40},{-44,53},{18,53}}, color={255,0,255}));
  connect(TRet, boundary.T_in) annotation (Line(points={{-120,-50},{-60,-50},{-60,
          -66},{-56,-66}}, color={0,0,127}));
  connect(con1.y, electricReformulatedEIR.TSet) annotation (Line(points={{-70,60},
          {-10,60},{-10,47},{18,47}}, color={0,0,127}));
  connect(senTem1.port_b, senVolFlo1.port_a)
    annotation (Line(points={{-12,-86},{2,-86}}, color={0,127,255}));
  connect(boundary.ports[1], senTem1.port_a) annotation (Line(points={{-34,-70},
          {-34,-86},{-32,-86}}, color={0,127,255}));
  connect(senVolFlo1.port_b, controlledTank_uQReq.port_a) annotation (Line(
        points={{22,-86},{34,-86},{34,-68},{-10,-68},{-10,-50},{10,-50}}, color=
         {0,127,255}));
  connect(senVolFlo.port_b, controlledTank_uQReq.port_a) annotation (Line(
        points={{-10,-46},{-10,-50},{10,-50}}, color={0,127,255}));
  connect(val.port_b, senTem.port_a)
    annotation (Line(points={{-10,-3.55271e-15},{-10,-2}}, color={0,127,255}));
  connect(senVolFlo.port_a, senTem.port_b)
    annotation (Line(points={{-10,-26},{-10,-22}}, color={0,127,255}));
  connect(controlledTank_uQReq.SOC, SOC) annotation (Line(points={{31,-54},{38,-54},
          {38,-30},{66,-30},{66,20},{110,20}}, color={0,0,127}));
  connect(mCHW_flow, boundary.m_flow_in) annotation (Line(points={{-120,-80},{
          -80,-80},{-80,-62},{-56,-62}}, color={0,0,127}));
  connect(val.y_actual, gai.u) annotation (Line(points={{-3,5},{-3,0},{8,0},{8,
          30},{12,30}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,140},{150,100}},
          textString="%name",
          textColor={0,0,255})}),                                Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TESS;
