within Buildings.ZoneEquipment.Baseclasses;
partial model PartialComponent
  extends Buildings.ZoneEquipment.Baseclasses.ExternalInterfaces;

  Boolean has_economizer;
  replaceable Fluid.Interfaces.PartialTwoPortInterface coi2
    annotation (Placement(transformation(extent={{20,-50},{40,-30}})));
  Fluid.Movers.SpeedControlled_y fan(
    redeclare package Medium = MediumA)
    annotation (Placement(transformation(extent={{80,-50},{100,-30}})));
  Fluid.Sensors.VolumeFlowRate senVolFlo(
    redeclare package Medium = MediumA,
    m_flow_nominal=mAir_flow_nominal)
    annotation (Placement(transformation(extent={{120,-50},{140,-30}})));
  Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium = MediumA,
      m_flow_nominal=mAir_flow_nominal)
    annotation (Placement(transformation(extent={{160,-50},{180,-30}})));
  replaceable Fluid.Interfaces.PartialTwoPortInterface eco
    annotation (Placement(transformation(extent={{-120,-50},{-100,-30}})));
  replaceable Fluid.Interfaces.PartialTwoPortInterface coi1
    annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_OA_inlet1(
    redeclare package Medium=MediumA) if has_economizer
    annotation (Placement(transformation(extent={{-230,-50},{-210,-30}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_OA_exhaust1(
    redeclare package Medium = MediumA) if has_economizer
    annotation (Placement(transformation(extent={{-230,30},{-210,50}})));
  Controls.OBC.CDL.Interfaces.RealInput TAmb if has_coolingCoil and not has_coolingCoilCCW
    "Ambient outdoor air temperature"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        origin={-240,220})));

  parameter Modelica.Units.SI.MassFlowRate mAir_flow_nominal
    "Nominal mass flow rate, used for regularization near zero flow";
equation
  connect(coi2.port_b, fan.port_a)
    annotation (Line(points={{40,-40},{80,-40}}, color={0,127,255}));
  connect(fan.port_b, senVolFlo.port_a)
    annotation (Line(points={{100,-40},{120,-40}}, color={0,127,255}));
  connect(senVolFlo.port_b, senTem.port_a)
    annotation (Line(points={{140,-40},{160,-40}}, color={0,127,255}));
  connect(senTem.port_b, port_supply)
    annotation (Line(points={{180,-40},{220,-40}}, color={0,127,255}));
  connect(port_return, eco.port_a) annotation (Line(points={{220,40},{-140,40},
          {-140,-40},{-120,-40}}, color={0,127,255}));
  connect(uFan, fan.y) annotation (Line(points={{40,280},{40,0},{90,0},{90,
          -28}},
        color={0,0,127}));
  connect(eco.port_b, coi1.port_a)
    annotation (Line(points={{-100,-40},{-60,-40}}, color={0,127,255}));
  connect(coi1.port_b, coi2.port_a)
    annotation (Line(points={{-40,-40},{20,-40}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PartialComponent;
