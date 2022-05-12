within Buildings.ZoneEquipment.Baseclasses;
partial model ExternalInterfaces

  replaceable package MediumA = Buildings.Media.Air
    constrainedby Modelica.Media.Interfaces.PartialCondensingGases "Medium model for air";
  replaceable package MediumW = Buildings.Media.Water "Medium model for water";

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

  Modelica.Fluid.Interfaces.FluidPort_a port_CCW_inlet(redeclare package Medium =
               MediumW) if                                has_coolingCoil and has_coolingCoilCCW
    annotation (Placement(transformation(extent={{70,-270},{90,-250}})));

  Modelica.Fluid.Interfaces.FluidPort_b port_HHW_outlet(redeclare package
      Medium = MediumW) if                                 has_heatingCoil and has_heatingCoilHHW
    annotation (Placement(transformation(extent={{-90,-270},{-70,-250}})));

  Modelica.Fluid.Interfaces.FluidPort_a port_HHW_inlet(redeclare package Medium =
               MediumW) if                                has_heatingCoil and has_heatingCoilHHW
    annotation (Placement(transformation(extent={{-50,-270},{-30,-250}})));

  Controls.OBC.CDL.Interfaces.RealInput uHea if has_heatingCoil
    "Heating loop signal"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=-90,
        origin={-40,280})));
  Controls.OBC.CDL.Interfaces.RealInput uCoo if has_coolingCoil
    "Cooling loop signal" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={120,280})));
  Controls.OBC.CDL.Interfaces.RealInput uFan "Fan signal"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={40,280})));
  Controls.OBC.CDL.Interfaces.RealOutput TSupAir "Supply air temperature"
    annotation (Placement(transformation(extent={{220,220},{260,260}})));
  Controls.OBC.CDL.Interfaces.RealOutput VSupAir_flow "Supply air flowrate"
    annotation (Placement(transformation(extent={{220,180},{260,220}})));
  Controls.OBC.CDL.Interfaces.RealInput uOA if  has_heatingCoil
    "Outdoor air signal" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-120,280})));
protected
  Boolean has_coolingCoil
    "Does the zone equipment have a cooling coil?";

  Boolean has_coolingCoilCCW
    "Does the zone equipment have a chilled water cooling coil?";

  Boolean has_heatingCoil
    "Does the zone equipment have a heating coil?";

  Boolean has_heatingCoilHHW
    "Does the zone equipment have a hot water heating coil?";
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-220,
            -260},{220,260}}), graphics={Rectangle(
          extent={{-220,260},{220,-260}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-220,-260},{220,
            260}})));
end ExternalInterfaces;
