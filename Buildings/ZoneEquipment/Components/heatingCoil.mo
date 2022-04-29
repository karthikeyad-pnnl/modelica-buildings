within Buildings.ZoneEquipment.Components;
model heatingCoil
  extends Buildings.Fluid.Interfaces.PartialTwoPortInterface;

  replaceable package MediumA = Buildings.Media.Air
    constrainedby Modelica.Media.Interfaces.PartialCondensingGases
    "Medium model for air";
  replaceable package MediumW = Buildings.Media.Water
    "Medium model for water";

  parameter Boolean has_heatingCoil
    "Does the zone equipment have a heating coil?";

  parameter Boolean has_heatingCoilHHW
    "Does the zone equipment have a hot water heating coil?"
    annotation(Dialog(enable = has_heatingCoil));

  replaceable Components.heatingCoil_electric heatingCoil_electric1(
    redeclare package MediumA = MediumA,
    redeclare package Medium = MediumA,
    m_flow_nominal=mAir_flow_nominal,
    mAir_flow_nominal=mAir_flow_nominal,
    dp_Coil_nominal=dpHeaCoiAir_nominal,
    QHeaCoi_flow_nominal=QHeaCoi_flow_nominal) if has_heatingCoil and not has_heatingCoilHHW
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));

  replaceable Components.heatingCoil_HHW heatingCoil_HHW1(
    redeclare package MediumA = MediumA,
    redeclare package MediumW = MediumW,
    redeclare package Medium = MediumA,
    m_flow_nominal=mAir_flow_nominal,
    mAir_flow_nominal=mAir_flow_nominal,
    mWat_flow_nominal=mHotWat_flow_nominal,
    dpCoiWat_nominal=dpHeaCoiWat_nominal,
    dpCoiAir_nominal=dpHeaCoiAir_nominal,
    UA_nominal=UAHeaCoi_nominal) if            has_heatingCoil and has_heatingCoilHHW
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

  Controls.OBC.CDL.Interfaces.RealInput uHea if has_heatingCoil
    "Heating level signal"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,120})));

  Fluid.FixedResistances.LosslessPipe pip(redeclare package Medium = MediumA,
      m_flow_nominal=mAir_flow_nominal) if   not has_heatingCoil
    annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
        MediumW) if                                has_heatingCoil and
    has_heatingCoilHHW
    annotation (Placement(transformation(extent={{10,-110},{30,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
        MediumW) if                                has_heatingCoil and
    has_heatingCoilHHW
    annotation (Placement(transformation(extent={{-30,-110},{-10,-90}})));
  parameter Modelica.Units.SI.MassFlowRate mAir_flow_nominal
    "Nominal mass flow rate of air";
  parameter Modelica.Units.SI.HeatFlowRate QHeaCoi_flow_nominal
    "Heat flow rate at u=1, positive for heating";
  parameter Modelica.Units.SI.MassFlowRate mHotWat_flow_nominal
    "Nominal mass flow rate of water";
  parameter Modelica.Units.SI.PressureDifference dpHeaCoiWat_nominal
    "Pressure difference";
  parameter Modelica.Units.SI.PressureDifference dpHeaCoiAir_nominal
    "Pressure difference";
  parameter Modelica.Units.SI.ThermalConductance UAHeaCoi_nominal
    "Thermal conductance at nominal flow, used to compute heat capacity";
equation
  connect(uHea, heatingCoil_electric1.uHea)
    annotation (Line(points={{0,120},{0,120},{0,62}}, color={0,0,127}));
  connect(uHea, heatingCoil_HHW1.uHea) annotation (Line(points={{0,120},{0,80},{
          -20,80},{-20,20},{0,20},{0,12}}, color={0,0,127}));
  connect(port_a, heatingCoil_HHW1.port_a)
    annotation (Line(points={{-100,0},{-10,0}}, color={0,127,255}));
  connect(heatingCoil_HHW1.port_b, port_b)
    annotation (Line(points={{10,0},{100,0}}, color={0,127,255}));
  connect(port_a, heatingCoil_electric1.port_a) annotation (Line(points={{-100,0},
          {-40,0},{-40,50},{-10,50}}, color={0,127,255}));
  connect(heatingCoil_electric1.port_b, port_b) annotation (Line(points={{10,50},
          {60,50},{60,0},{100,0}}, color={0,127,255}));
  connect(port_a, pip.port_a) annotation (Line(points={{-100,0},{-40,0},{-40,-40},
          {-10,-40}}, color={0,127,255}));
  connect(pip.port_b, port_b) annotation (Line(points={{10,-40},{60,-40},{60,0},
          {100,0}}, color={0,127,255}));
  connect(port_a1, heatingCoil_HHW1.port_a1) annotation (Line(points={{20,-100},
          {20,-20},{2,-20},{2,-10}}, color={0,127,255}));
  connect(port_b1, heatingCoil_HHW1.port_b1) annotation (Line(points={{-20,-100},
          {-20,-20},{-2,-20},{-2,-10}}, color={0,127,255}));
  annotation (defaultComponentName="heaCoi",
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end heatingCoil;
