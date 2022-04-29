within Buildings.ZoneEquipment.Baseclasses;
partial model WaterloopInterfaces

  replaceable package MediumA = Buildings.Media.Air
    constrainedby Modelica.Media.Interfaces.PartialCondensingGases
    "Medium model for air";
  replaceable package MediumW = Buildings.Media.Water
    "Medium model for water";

  extends Buildings.Fluid.Interfaces.PartialTwoPortInterface(
    redeclare package Medium = MediumA);

  parameter Modelica.Units.SI.MassFlowRate mAir_flow_nominal
    "Nominal mass flow rate of air";

  parameter Modelica.Units.SI.MassFlowRate mWat_flow_nominal
    "Nominal mass flow rate of water";

  replaceable Fluid.Sensors.TemperatureTwoPort TAirSup(redeclare package Medium
      = MediumA, m_flow_nominal=mAir_flow_nominal)
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  replaceable Fluid.Sensors.TemperatureTwoPort TAirRet(redeclare package Medium
      = MediumA, m_flow_nominal=mAir_flow_nominal)
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  replaceable Fluid.Sensors.VolumeFlowRate VAir_flow(redeclare package Medium
      = MediumA, m_flow_nominal=mAir_flow_nominal)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
        MediumW)
    annotation (Placement(transformation(extent={{10,-110},{30,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
        MediumW)
    annotation (Placement(transformation(extent={{-30,-110},{-10,-90}})));
  replaceable Fluid.Sensors.TemperatureTwoPort TWatSup(redeclare package Medium
      = MediumW, m_flow_nominal=mWat_flow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=90,
        origin={20,-70})));
  replaceable Fluid.Sensors.VolumeFlowRate VWat_flow(redeclare package Medium
      = MediumW, m_flow_nominal=mWat_flow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=90,
        origin={20,-40})));
  replaceable Fluid.Sensors.TemperatureTwoPort TWatRet(redeclare package Medium
      = MediumW, m_flow_nominal=mWat_flow_nominal)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-20,-60})));
  Components.PowerCalculation POut "Power output of heating coil"
    annotation (Placement(transformation(extent={{20,50},{40,70}})));
  Components.PowerCalculation PConsumed "Power consumption of heating coil"
    annotation (Placement(transformation(extent={{60,-70},{80,-50}})));
  replaceable Fluid.Actuators.Valves.TwoWayLinear val(
    redeclare package Medium = MediumW,
    m_flow_nominal=mWat_flow_nominal,
    dpValve_nominal=50)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
      rotation=90,
        origin={-20,-30})));
  replaceable Fluid.Interfaces.PartialFourPortInterface
    partialFourPortInterface(
    redeclare package Medium1 = MediumW,
    redeclare package Medium2 = MediumA,
    m1_flow_nominal=mWat_flow_nominal,
    m2_flow_nominal=mAir_flow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={6,-6})));
  Controls.OBC.CDL.Interfaces.RealOutput TCon
    "Measured conditioned air temperature"
    annotation (Placement(transformation(extent={{100,40},{140,80}}),
        iconTransformation(extent={{100,40},{140,80}})));
equation
  connect(port_a, TAirSup.port_a)
    annotation (Line(points={{-100,0},{-90,0}}, color={0,127,255}));
  connect(TAirSup.port_b, VAir_flow.port_a)
    annotation (Line(points={{-70,0},{-60,0}}, color={0,127,255}));
  connect(port_a1, TWatSup.port_a)
    annotation (Line(points={{20,-100},{20,-80}}, color={0,127,255}));
  connect(TWatSup.port_b, VWat_flow.port_a)
    annotation (Line(points={{20,-60},{20,-50}}, color={0,127,255}));
  connect(port_b1, TWatRet.port_b)
    annotation (Line(points={{-20,-100},{-20,-70}}, color={0,127,255}));
  connect(VAir_flow.V_flow, POut.V_flow)
    annotation (Line(points={{-50,11},{-50,56},{18,56}}, color={0,0,127}));
  connect(TAirRet.T, POut.TOut) annotation (Line(points={{50,11},{50,40},{8,40},
          {8,60},{18,60}}, color={0,0,127}));
  connect(TAirSup.T, POut.TIn)
    annotation (Line(points={{-80,11},{-80,64},{18,64}}, color={0,0,127}));
  connect(VWat_flow.V_flow, PConsumed.V_flow) annotation (Line(points={{9,-40},{
          6,-40},{6,-64},{58,-64}}, color={0,0,127}));
  connect(TWatSup.T, PConsumed.TIn) annotation (Line(points={{9,-70},{0,-70},{0,
          -56},{58,-56}}, color={0,0,127}));
  connect(TWatRet.T, PConsumed.TOut)
    annotation (Line(points={{-9,-60},{58,-60}}, color={0,0,127}));
  connect(VWat_flow.port_b, partialFourPortInterface.port_a1) annotation (
      Line(points={{20,-30},{20,-12},{16,-12}}, color={0,127,255}));
  connect(TAirRet.T, TCon)
    annotation (Line(points={{50,11},{50,60},{120,60}}, color={0,0,127}));
  connect(TWatRet.port_a, val.port_a)
    annotation (Line(points={{-20,-50},{-20,-40}}, color={0,127,255}));
  connect(val.port_b, partialFourPortInterface.port_b1) annotation (Line(points=
         {{-20,-20},{-20,-12},{-4,-12}}, color={0,127,255}));
  connect(VAir_flow.port_b, partialFourPortInterface.port_a2)
    annotation (Line(points={{-40,0},{-4,0}}, color={0,127,255}));
  connect(TAirRet.port_b, port_b) annotation (Line(points={{60,0},{80,0},{80,0},
          {100,0}}, color={0,127,255}));
  connect(partialFourPortInterface.port_b2, TAirRet.port_a) annotation (Line(
        points={{16,-1.77636e-15},{28,-1.77636e-15},{28,0},{40,0}}, color={0,127,
          255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end WaterloopInterfaces;
