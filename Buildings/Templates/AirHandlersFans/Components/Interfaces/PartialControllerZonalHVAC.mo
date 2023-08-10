within Buildings.Templates.AirHandlersFans.Components.Interfaces;
partial block PartialControllerZonalHVAC
  "Interface class for zonal HVAC controller"

  outer replaceable
    Buildings.Templates.AirHandlersFans.Components.Interfaces.PartialOutdoorReliefReturnSection
    secOutRel "Outdoor/relief/return air section";
  outer replaceable Buildings.Templates.Components.Coils.None coiCoo
    "Cooling coil";
  outer replaceable Buildings.Templates.Components.Coils.None coiHeaPre
    "Heating coil (preheat position)";
  outer replaceable Buildings.Templates.Components.Coils.None coiHeaReh
    "Heating coil (reheat position)";

  parameter Buildings.Templates.AirHandlersFans.Types.Controller typ
    "Type of controller"
    annotation (Evaluate=true, Dialog(group="Configuration"));

  parameter Buildings.Templates.AirHandlersFans.Components.Data.ZonalHVACController dat(
    final typ=typ,
    final typFanSup=typFanSup)
    "Design and operating parameters"
    annotation (Placement(transformation(extent={{120,120},{140,140}})));

  Buildings.Templates.AirHandlersFans.Interfaces.Bus bus
    "Zonal HVAC control bus"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-160,0}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-100,0})));

  parameter Boolean use_TMix=true
    "Set to true if mixed air temperature measurement is enabled"
    annotation(Dialog(
     group="Economizer",
     enable=secOutRel.typ<>Buildings.Templates.AirHandlersFans.Types.OutdoorReliefReturnSection.HundredPctOutdoorAir));

  parameter Boolean have_CO2Sen=false
    "Set to true if there are zones with CO2 sensor"
    annotation (Dialog(group="Configuration",
      enable=
      typ==Buildings.Templates.AirHandlersFans.Types.Controller.G36VAVMultiZone and
      typSecOut==Buildings.Controls.OBC.ASHRAE.G36.Types.OutdoorAirSection.DedicatedDampersPressure and
      stdVen==Buildings.Controls.OBC.ASHRAE.G36.Types.VentilationStandard.California_Title_24));

  annotation (Documentation(info="<html>
<p>
This partial class provides a standard interface for zonal HVAC controller.
</p>
</html>"),
    Diagram(coordinateSystem(extent={{-160,-160},{160,160}})),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid)}));
end PartialControllerZonalHVAC;
