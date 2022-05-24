within Buildings.Fluid.ZoneEquipment.Components;
model economizer
  extends Buildings.Fluid.Interfaces.PartialTwoPortInterface(
    redeclare package Medium = MediumA);

  replaceable package MediumA = Buildings.Media.Air
    constrainedby Modelica.Media.Interfaces.PartialCondensingGases
    "Medium model for air";

  parameter Boolean has_economizer;

  parameter Modelica.Units.SI.MassFlowRate mAir_flow_nominal
    "Nominal mass flow rate of air";

  parameter Modelica.Units.SI.MassFlowRate mAirOut_flow_nominal
    "Nominal mass flow rate of outdoor air";

  Modelica.Fluid.Interfaces.FluidPort_a port_Out(redeclare package Medium =
        MediumA)
    annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_Exh(redeclare package Medium =
        MediumA)
    annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
  Fluid.Actuators.Dampers.MixingBox eco(
    redeclare package Medium = MediumA,
    mOut_flow_nominal=mAirOut_flow_nominal,
    dpDamOut_nominal=50,
    mRec_flow_nominal=mAir_flow_nominal,
    dpDamRec_nominal=50,
    mExh_flow_nominal=mAirOut_flow_nominal,
    dpDamExh_nominal=50) if                has_economizer
    annotation (Placement(transformation(extent={{-10,-8},{10,12}})));
  Controls.OBC.CDL.Interfaces.RealInput uEco "Economizer control signal"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,120})));
  Fluid.Sensors.VolumeFlowRate VAirOut_flow(redeclare package Medium =
        MediumA, m_flow_nominal=mAir_flow_nominal)
    annotation (Placement(transformation(extent={{-90,30},{-70,50}})));
  Fluid.Sensors.VolumeFlowRate VAirMix_flow(redeclare package Medium =
        MediumA, m_flow_nominal=mAir_flow_nominal)
                                            "Mixed air flowrate"
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Fluid.Sensors.VolumeFlowRate VAirRet_flow(redeclare package Medium =
        MediumA, m_flow_nominal=mAir_flow_nominal)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Fluid.Sensors.TemperatureTwoPort TOutSen(redeclare package Medium = MediumA,
      m_flow_nominal=mAir_flow_nominal)    "Outdoor air temperature sensor"
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  Fluid.Sensors.TemperatureTwoPort TRetSen(redeclare package Medium = MediumA,
      m_flow_nominal=mAir_flow_nominal)    "Return air temperature sensor"
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Fluid.Sensors.TemperatureTwoPort TMixSen(redeclare package Medium = MediumA,
      m_flow_nominal=mAir_flow_nominal)    "Mixed air temperature sensor"
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  Controls.OBC.CDL.Interfaces.RealOutput TMix
    "Measured mixed air temperature"
    annotation (Placement(transformation(extent={{100,20},{140,60}})));
  Controls.OBC.CDL.Interfaces.RealOutput VOut_flow
    "Measured outdoor air flowrate"
    annotation (Placement(transformation(extent={{100,60},{140,100}})));
equation
  connect(port_Exh, eco.port_Exh) annotation (Line(points={{-100,-40},{-10,
          -40},{-10,-4}}, color={0,127,255}));
  connect(uEco, eco.y)
    annotation (Line(points={{0,120},{0,14}}, color={0,0,127}));
  connect(port_Out, VAirOut_flow.port_a)
    annotation (Line(points={{-100,40},{-90,40}}, color={0,127,255}));
  connect(VAirMix_flow.port_b, port_b)
    annotation (Line(points={{80,0},{100,0}}, color={0,127,255}));
  connect(port_a, VAirRet_flow.port_a)
    annotation (Line(points={{-100,0},{-80,0}}, color={0,127,255}));
  connect(VAirOut_flow.port_b, TOutSen.port_a)
    annotation (Line(points={{-70,40},{-60,40}}, color={0,127,255}));
  connect(VAirRet_flow.port_b, TRetSen.port_a)
    annotation (Line(points={{-60,0},{-50,0}}, color={0,127,255}));
  connect(TRetSen.port_b, eco.port_Ret) annotation (Line(points={{-30,0},{-20,
          0},{-20,-20},{10,-20},{10,-4}}, color={0,127,255}));
  connect(eco.port_Sup, TMixSen.port_a) annotation (Line(points={{10,8},{20,8},
          {20,0},{30,0}}, color={0,127,255}));
  connect(TMixSen.port_b, VAirMix_flow.port_a)
    annotation (Line(points={{50,0},{60,0}}, color={0,127,255}));
  connect(TMixSen.T, TMix)
    annotation (Line(points={{40,11},{40,40},{120,40}}, color={0,0,127}));
  connect(VAirOut_flow.V_flow, VOut_flow)
    annotation (Line(points={{-80,51},{-80,80},{120,80}}, color={0,0,127}));
  connect(TOutSen.port_b, eco.port_Out) annotation (Line(points={{-40,40},{
          -20,40},{-20,8},{-10,8}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end economizer;
