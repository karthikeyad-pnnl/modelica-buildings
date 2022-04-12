within Buildings.Controls.OBC.ASHRAE.FanCoilUnit.ClosedLoopValidation;
partial model Baseclass_externalInterfaces

  replaceable package MediumA = Buildings.Media.Air
    constrainedby Modelica.Media.Interfaces.PartialCondensingGases "Medium model for air";
  replaceable package MediumW = Buildings.Media.Water "Medium model for water";

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

  Modelica.Fluid.Interfaces.FluidPort_a port_return(redeclare package Medium =
        MediumA)
    "Return air port from zone"
    annotation (Placement(transformation(extent={{210,30},{230,50}})));

  Modelica.Fluid.Interfaces.FluidPort_b port_supply(redeclare package Medium =
        MediumA)
    "Supply air port to the zone"
    annotation (Placement(transformation(extent={{210,-50},{230,-30}})));

  Modelica.Fluid.Interfaces.FluidPort_b port_CCW_outlet(redeclare package
      Medium = MediumW) if                                 has_coolingCoil and has_coolingCoilCCW
    annotation (Placement(transformation(extent={{30,-270},{50,-250}})));

  Modelica.Fluid.Interfaces.FluidPort_a port_CCW_inlet(redeclare package Medium
      =        MediumW) if                                has_coolingCoil and has_coolingCoilCCW
    annotation (Placement(transformation(extent={{70,-270},{90,-250}})));

  Modelica.Fluid.Interfaces.FluidPort_b port_HHW_outlet(redeclare package
      Medium = MediumW) if                                 has_heatingCoil and has_heatingCoilHHW
    annotation (Placement(transformation(extent={{-90,-270},{-70,-250}})));

  Modelica.Fluid.Interfaces.FluidPort_a port_HHW_inlet(redeclare package Medium
      =        MediumW) if                                has_heatingCoil and has_heatingCoilHHW
    annotation (Placement(transformation(extent={{-50,-270},{-30,-250}})));

  Modelica.Fluid.Interfaces.FluidPort_a port_OA_inlet(redeclare package Medium
      =        MediumA) if                               has_economizer
    annotation (Placement(transformation(extent={{-230,-50},{-210,-30}})));

  Modelica.Fluid.Interfaces.FluidPort_b port_OA_exhaust(redeclare package
      Medium = MediumA) if                                 has_economizer
    annotation (Placement(transformation(extent={{-230,30},{-210,50}})));

  Controls.OBC.CDL.Interfaces.RealInput uHea if has_heatingCoil
    "Heating loop signal"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=-90,
        origin={-120,280})));
  Controls.OBC.CDL.Interfaces.RealInput uCoo if has_coolingCoil
    "Cooling loop signal" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={120,280})));
  Controls.OBC.CDL.Interfaces.RealInput uFan if has_heatingCoil "Fan signal"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,280})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-220,
            -260},{220,260}}), graphics={Rectangle(
          extent={{-220,260},{220,-260}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-220,-260},{220,
            260}})));
end Baseclass_externalInterfaces;
