within Buildings.ZoneEquipment.Components;
model coolingCoil

  extends Buildings.Fluid.Interfaces.PartialTwoPortInterface;

  replaceable package MediumA = Buildings.Media.Air
    constrainedby Modelica.Media.Interfaces.PartialCondensingGases
    "Medium model for air";
  replaceable package MediumW = Buildings.Media.Water
    "Medium model for water";

  parameter Modelica.Units.SI.MassFlowRate mAir_flow_nominal
    "Nominal mass flow rate of air";
  parameter Real minSpeRatCooCoi "Minimum speed ratio";
  parameter Modelica.Units.SI.PressureDifference dpCooCoiAir_nominal
    "Pressure difference";
  parameter Modelica.Units.SI.PressureDifference dpCooCoiWat_nominal
    "Pressure difference";
  parameter Modelica.Units.SI.MassFlowRate mChiWat_flow_nominal
    "Nominal mass flow rate of water";
  parameter Modelica.Units.SI.ThermalConductance UACooCoi_nominal
    "Thermal conductance at nominal flow, used to compute heat capacity";

  parameter Boolean has_coolingCoil
    "Does the zone equipment have a heating coil?";

  parameter Boolean has_coolingCoilCCW
    "Does the zone equipment have a hot water heating coil?"
    annotation(Dialog(enable = has_coolingCoil));

  replaceable Buildings.ZoneEquipment.Components.coolingCoil_electric
    coolingCoil_electric1(
    redeclare package MediumA = MediumA,
    redeclare package Medium = MediumA,
    m_flow_nominal=mAir_flow_nominal,
    mAir_flow_nominal=mAir_flow_nominal,
    minSpeRat=minSpeRatCooCoi,
    dpCooCoi_nominal=dpCooCoiAir_nominal) if has_coolingCoil and not
    has_coolingCoilCCW
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  replaceable Buildings.ZoneEquipment.Components.coolingCoil_CCW
    coolingCoil_CCW1(
    redeclare package MediumA = MediumA,
    redeclare package MediumW = MediumW,
    redeclare package Medium = MediumA,
    m_flow_nominal=mAir_flow_nominal,
    mAir_flow_nominal=mAir_flow_nominal,
    mWat_flow_nominal=mChiWat_flow_nominal,
    dpCoiAir_nominal=dpCooCoiAir_nominal,
    dpCoiWat_nominal=dpCooCoiWat_nominal,
    UA_nominal=UACooCoi_nominal) if has_coolingCoil and has_coolingCoilCCW
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Controls.OBC.CDL.Interfaces.RealInput uCoo if has_coolingCoil
    "Cooling level signal"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,120})));
  Fluid.FixedResistances.LosslessPipe pip(
    redeclare package Medium = MediumA,
    m_flow_nominal=mAir_flow_nominal) if not has_coolingCoil
    annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
        MediumW) if                                has_coolingCoil and has_coolingCoilCCW
    annotation (Placement(transformation(extent={{10,-110},{30,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
        MediumW) if                                has_coolingCoil and has_coolingCoilCCW
    annotation (Placement(transformation(extent={{-30,-110},{-10,-90}})));
  Controls.OBC.CDL.Interfaces.RealInput TAmb if has_coolingCoil
     and not has_coolingCoilCCW "Ambient outdoor air temperature"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-40,120})));
equation
  connect(pip.port_b, port_b) annotation (Line(points={{10,-40},{60,-40},{60,0},
          {100,0}}, color={0,127,255}));
  connect(TAmb, coolingCoil_electric1.TAmb) annotation (Line(points={{-40,120},{
          -40,72},{-4,72},{-4,62}}, color={0,0,127}));
  connect(uCoo, coolingCoil_electric1.uCoo)
    annotation (Line(points={{0,120},{0,62}}, color={0,0,127}));
  connect(uCoo, coolingCoil_CCW1.uCoo) annotation (Line(points={{0,120},{0,80},{
          -20,80},{-20,20},{0,20},{0,12}}, color={0,0,127}));
  connect(port_a, coolingCoil_electric1.port_a) annotation (Line(points={{-100,0},
          {-40,0},{-40,50},{-10,50}}, color={0,127,255}));
  connect(port_a, coolingCoil_CCW1.port_a)
    annotation (Line(points={{-100,0},{-10,0}}, color={0,127,255}));
  connect(port_a, pip.port_a) annotation (Line(points={{-100,0},{-40,0},{-40,-40},
          {-10,-40}}, color={0,127,255}));
  connect(coolingCoil_electric1.port_b, port_b) annotation (Line(points={{10,50},
          {60,50},{60,0},{100,0}}, color={0,127,255}));
  connect(coolingCoil_CCW1.port_b, port_b)
    annotation (Line(points={{10,0},{100,0}}, color={0,127,255}));
  connect(port_a1, coolingCoil_CCW1.port_a1) annotation (Line(points={{20,-100},
          {20,-20},{2,-20},{2,-10}}, color={0,127,255}));
  connect(port_b1, coolingCoil_CCW1.port_b1) annotation (Line(points={{-20,-100},
          {-20,-20},{-2,-20},{-2,-10}}, color={0,127,255}));
  annotation (defaultComponentName="heaCoi",
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end coolingCoil;
