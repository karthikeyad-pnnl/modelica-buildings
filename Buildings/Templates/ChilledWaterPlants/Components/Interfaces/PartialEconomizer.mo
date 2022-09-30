within Buildings.Templates.ChilledWaterPlants.Components.Interfaces;
partial model PartialEconomizer "Partial waterside economizer model"
  extends Buildings.Fluid.Interfaces.PartialTwoPortInterface(
    redeclare final package Medium=MediumChiWat,
    final m_flow_nominal=mChiWat_flow_nominal);

  replaceable package MediumChiWat = Buildings.Media.Water
    constrainedby Modelica.Media.Interfaces.PartialMedium
    "CHW medium";
  replaceable package MediumConWat = Buildings.Media.Water
    constrainedby Modelica.Media.Interfaces.PartialMedium
    "CW medium";

  parameter Buildings.Templates.ChilledWaterPlants.Types.Economizer typ
    "Type of equipment"
    annotation (Evaluate=true, Dialog(group="Configuration", enable=false));

  parameter Buildings.Templates.ChilledWaterPlants.Components.Data.Economizer
    dat(final typ=typ)
    "Design and operating parameters";

  final parameter Modelica.Units.SI.MassFlowRate mChiWat_flow_nominal(
    final min=0)=dat.mChiWat_flow_nominal
    "CHW mass flow rate";
  final parameter Modelica.Units.SI.MassFlowRate mConWat_flow_nominal(
    final min=0)=dat.mConWat_flow_nominal
    "CHW mass flow rate";
  final parameter Modelica.Units.SI.PressureDifference dpChiWat_nominal(
    final min=0,
    displayUnit="Pa")=dat.dpChiWat_nominal
    "CHW pressure drop";
  final parameter Modelica.Units.SI.PressureDifference dpConWat_nominal(
    final min=0,
    displayUnit="Pa")=dat.dpConWat_nominal
    "CW pressure drop";
  final parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal(
    final max=0)=-1*dat.cap_nominal
    "Heat flow rate";
  final parameter Buildings.Templates.Components.Data.Valve datValConWatIso(
    final typ=if typ<>Buildings.Templates.ChilledWaterPlants.Types.Economizer.None
    then Buildings.Templates.Components.Types.Valve.TwoWayTwoPosition else
    Buildings.Templates.Components.Types.Valve.None,
    final m_flow_nominal=mConWat_flow_nominal,
    final dpValve_nominal=dat.dpValConWatIso_nominal,
    final dpFixed_nominal=dpConWat_nominal)
    "WSE CW isolation valve";
  final parameter Buildings.Templates.Components.Data.Valve datValChiWatByp(
    final typ=if typ==Buildings.Templates.ChilledWaterPlants.Types.Economizer.HeatExchangerWithValve
    then Buildings.Templates.Components.Types.Valve.TwoWayModulating else
    Buildings.Templates.Components.Types.Valve.None,
    final m_flow_nominal=mChiWat_flow_nominal,
    final dpValve_nominal=dat.dpValChiWatByp_nominal)
    "WSE CHW bypass valve";
  final parameter Buildings.Templates.Components.Data.PumpSingle datPumChiWat(
    final typ=if typ==Buildings.Templates.ChilledWaterPlants.Types.Economizer.HeatExchangerWithPump
    then Buildings.Templates.Components.Types.Pump.Single else
    Buildings.Templates.Components.Types.Pump.None,
    final m_flow_nominal=mChiWat_flow_nominal,
    final dp_nominal=dat.dpPumChiWat_nominal,
    final per=dat.perPumChiWat)
    "Heat exchanger CHW pump";

  Modelica.Fluid.Interfaces.FluidPort_a port_aConWat(
   redeclare final package Medium = MediumConWat,
   m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0),
   h_outflow(start = MediumConWat.h_default, nominal = MediumConWat.h_default))
   if typ<>Buildings.Templates.ChilledWaterPlants.Types.Economizer.None
   "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{90,70},{110,90}}),
        iconTransformation(extent={{90,80},{110,100}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_bConWat(
   redeclare final package Medium = MediumConWat,
   m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0),
   h_outflow(start = MediumConWat.h_default, nominal = MediumConWat.h_default))
   if typ<>Buildings.Templates.ChilledWaterPlants.Types.Economizer.None
    "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{-90,70},{-110,90}}),
        iconTransformation(extent={{-90,80},{-110,100}})));

  Buildings.Templates.ChilledWaterPlants.Interfaces.Bus bus
    if typ<>Buildings.Templates.ChilledWaterPlants.Types.Economizer.None
    "Plant control bus"
    annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={0,100}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={0,100})));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false),
    graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),
     Diagram(coordinateSystem(preserveAspectRatio=false)));

end PartialEconomizer;