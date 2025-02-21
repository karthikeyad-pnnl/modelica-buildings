within Buildings.Templates.AirHandlersFans.Components.Interfaces;
partial block PartialControllerZonalHVAC
  "Interface class for zonal HVAC controller"

//   outer replaceable
//     Buildings.Templates.Components.OutdoorAirMixer.OutdoorAirMixer
//     secOutRel "Outdoor/relief/return air section";
//   outer replaceable Buildings.Templates.Components.Coils.NoCooling coiCoo
//     "Cooling coil";
//   outer replaceable Buildings.Templates.Components.Coils.NoHeating coiHeaPre
//     "Heating coil (preheat position)";
//   outer replaceable Buildings.Templates.Components.Coils.NoHeating coiHeaReh
//     "Heating coil (reheat position)";

  parameter Buildings.Templates.AirHandlersFans.Types.Controller typ
    "Type of controller"
    annotation (Evaluate=true, Dialog(group="Configuration"));

  parameter Buildings.Templates.AirHandlersFans.Components.Data.ZonalHVACController dat(
    final typ=typ,
    final typFanSup = typFanSup,
    final typFanRet = typFanRet,
    final typFanRel = typFanRel)
    "Design and operating parameters"
    annotation (Placement(transformation(extent={{70,70},{90,90}})));

  Buildings.Templates.AirHandlersFans.Interfaces.ZonalHVACBus bus
    "Zonal HVAC control bus"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-100,0}), iconTransformation(
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

  final parameter Buildings.Templates.Components.Types.Fan typFanSup
    "Type of supply fan"
    annotation (Evaluate=true, Dialog(tab="Non-configurable", group="Configuration", enable=false));
  final parameter Buildings.Templates.Components.Types.Fan typFanRel = Buildings.Templates.Components.Types.Fan.None
    "Type of relief fan"
    annotation (Evaluate=true, Dialog(tab="Non-configurable", group="Configuration", enable=false));
  final parameter Buildings.Templates.Components.Types.Fan typFanRet = Buildings.Templates.Components.Types.Fan.None
    "Type of return fan"
    annotation (Evaluate=true, Dialog(tab="Non-configurable", group="Configuration", enable=false));

  BoundaryConditions.WeatherData.Bus           busWea
    "Weather bus"
    annotation (Placement(transformation(extent={{-20,80},{20,120}}),
      iconTransformation(extent={{-10,90},{10,110}})));
  annotation (Documentation(info="<html>
<p>
This partial class provides a standard interface for zonal HVAC controller.
</p>
</html>"),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}})),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid)}));
end PartialControllerZonalHVAC;
