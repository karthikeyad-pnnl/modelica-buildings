within Buildings.Templates.AirHandlersFans.Data;
record ZonalHVAC "Record for zonal HVAC system"
  extends Buildings.Templates.AirHandlersFans.Data.PartialAirHandler(
    final typ=Buildings.Templates.AirHandlersFans.Types.Configuration.SingleDuct,
    final typCtl=Buildings.Templates.AirHandlersFans.Types.Controller.EPlusAnalog,
    final typFanRet=Buildings.Templates.Components.Types.Fan.None,
    final typFanRel=Buildings.Templates.Components.Types.Fan.None,
    redeclare
      Buildings.Templates.AirHandlersFans.Components.Data.ZonalHVACController
      ctl(
        final typFanSup=typFanSup),
    final mAirSup_flow_nominal=fanSup.m_flow_nominal,
    final mAirRet_flow_nominal=if typFanRet <> Buildings.Templates.Components.Types.Fan.None
         then fanRet.m_flow_nominal elseif typFanRel <> Buildings.Templates.Components.Types.Fan.None
         then fanRel.m_flow_nominal elseif typFanSup <> Buildings.Templates.Components.Types.Fan.None
         then fanSup.m_flow_nominal else 0);

  parameter Buildings.Templates.Components.Types.Coil typCoiHeaPre
    "Type of heating coil in preheat position"
    annotation (Evaluate=true, Dialog(group="Configuration", enable=false));
  parameter Buildings.Templates.Components.Types.Coil typCoiCoo
    "Type of cooling coil"
    annotation (Evaluate=true, Dialog(group="Configuration", enable=false));
  parameter Buildings.Templates.Components.Types.Coil typCoiHeaReh
    "Type of heating coil in reheat position"
    annotation (Evaluate=true, Dialog(group="Configuration", enable=false));
  parameter Buildings.Templates.Components.Types.Valve typValCoiHeaPre
    "Type of valve for heating coil in preheat position"
    annotation (Evaluate=true, Dialog(group="Configuration", enable=false));
  parameter Buildings.Templates.Components.Types.Valve typValCoiCoo
    "Type of valve for cooling coil"
    annotation (Evaluate=true, Dialog(group="Configuration", enable=false));
  parameter Buildings.Templates.Components.Types.Valve typValCoiHeaReh
    "Type of valve for heating coil in reheat position"
    annotation (Evaluate=true, Dialog(group="Configuration", enable=false));

  parameter Buildings.Templates.Components.Data.Fan fanSup(
    final typ=typFanSup)
    "Supply fan"
    annotation (Dialog(
    group="Fans", enable=typFanSup <> Buildings.Templates.Components.Types.Fan.None));

  extends
    Buildings.Templates.AirHandlersFans.Components.Data.OutdoorReliefReturnSection(
    fanRel,
    fanRet,
    damOut(
      m_flow_nominal=mAirSup_flow_nominal),
    damOutMin(
      m_flow_nominal=mOutMin_flow_nominal),
    damRel(
      m_flow_nominal=mAirRet_flow_nominal),
    damRet(
      m_flow_nominal=mAirRet_flow_nominal));

  parameter Buildings.Templates.Components.Data.Coil coiHeaPre(
    final typ=typCoiHeaPre,
    final typVal=typValCoiHeaPre,
    final have_sou=have_souHeaWat,
    mAir_flow_nominal=mAirSup_flow_nominal)
    "Heating coil in preheat position"
    annotation (Dialog(group="Coils",
    enable=typCoiHeaPre <> Buildings.Templates.Components.Types.Coil.None));

  parameter Buildings.Templates.Components.Data.Coil coiCoo(
    final typ=typCoiCoo,
    final typVal=typValCoiCoo,
    final have_sou=have_souChiWat,
    mAir_flow_nominal=mAirSup_flow_nominal)
    "Cooling coil"
    annotation (Dialog(
    group="Coils", enable=typCoiCoo <> Buildings.Templates.Components.Types.Coil.None));

  parameter Buildings.Templates.Components.Data.Coil coiHeaReh(
    final typ=typCoiHeaReh,
    final typVal=typValCoiHeaReh,
    final have_sou=have_souHeaWat,
    mAir_flow_nominal=mAirSup_flow_nominal)
    "Heating coil in reheat position"
    annotation (Dialog(group="Coils",
    enable=typCoiHeaReh <> Buildings.Templates.Components.Types.Coil.None));

annotation (
  defaultComponentPrefixes = "parameter",
  defaultComponentName = "dat",
    Documentation(info="<html>
<p>
This record provides the set of sizing and operating parameters for the class
<a href=\"modelica://Buildings.Templates.AirHandlersFans.VAVMultiZone\">
Buildings.Templates.AirHandlersFans.VAVMultiZone</a>.
</p>
</html>"));
end ZonalHVAC;