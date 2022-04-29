within Buildings.ZoneEquipment.Baseclasses;
partial model AirloopInterfaces

  replaceable package MediumA = Buildings.Media.Air
    constrainedby Modelica.Media.Interfaces.PartialCondensingGases
    "Medium model for air";

  extends Buildings.Fluid.Interfaces.PartialTwoPortInterface(
    redeclare package Medium = MediumA);

  parameter Modelica.Units.SI.MassFlowRate mAir_flow_nominal
    "Nominal mass flow rate of air";

  replaceable Fluid.Sensors.TemperatureTwoPort TAirSup(
    redeclare package Medium = MediumA,
    m_flow_nominal=mAir_flow_nominal)
    annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  replaceable Fluid.Sensors.TemperatureTwoPort TAirCon(
    redeclare package Medium = MediumA,
    m_flow_nominal=mAir_flow_nominal)
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  replaceable Fluid.Sensors.VolumeFlowRate VAir_flow(redeclare package Medium
      = MediumA, m_flow_nominal=mAir_flow_nominal)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Controls.OBC.CDL.Interfaces.RealOutput TCon
    "Measured conditioned air temperature"
    annotation (Placement(transformation(extent={{100,40},{140,80}})));
equation
  connect(TAirCon.port_b, port_b)
    annotation (Line(points={{60,0},{100,0}}, color={0,127,255}));
  connect(TAirSup.port_b, VAir_flow.port_a)
    annotation (Line(points={{-50,0},{-40,0}}, color={0,127,255}));
  connect(TAirCon.T, TCon)
    annotation (Line(points={{50,11},{50,60},{120,60}}, color={0,0,127}));
  connect(port_a, TAirSup.port_a)
    annotation (Line(points={{-100,0},{-70,0}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end AirloopInterfaces;
