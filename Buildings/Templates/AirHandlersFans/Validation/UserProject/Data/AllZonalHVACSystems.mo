within Buildings.Templates.AirHandlersFans.Validation.UserProject.Data;
class AllZonalHVACSystems
  "Top-level (whole building) system parameters"

  parameter Buildings.Templates.Types.Units sysUni
    "Unit system";

  /*
  The construct below where a replaceable model is used inside the `outer`
  component declaration is for validation purposes only, where various configuration
  classes are tested with the same instance name `VAV_1`.
  It is needed here because
  - the `inner` instance must be a subtype of the `outer` component, and
  - the `outer` component references only the subcomponents from its own type
  (as opposed to all the subcomponents from the `inner` type), and
  - modification of an outer declaration is prohibited.
  The standard export workflow should use an explicit reference to the configuration
  class for each MZVAV model instance.
  */
  replaceable model ZonalHVAC =
    Buildings.Templates.AirHandlersFans.Interfaces.ZonalHVAC
    "Model of Zonal HVAC system";

  outer ZonalHVAC VAV_1
    "Instance of MZVAV model";

  parameter Buildings.Templates.AirHandlersFans.Data.ZonalHVAC dat_VAV_1(
    final typ=VAV_1.typ,
    final typFanSup=VAV_1.typFanSup,
    final typFanRet=Buildings.Templates.Components.Types.Fan.None,
    final typFanRel=Buildings.Templates.Components.Types.Fan.None,
    final have_souChiWat=VAV_1.have_souChiWat,
    final have_souHeaWat=VAV_1.have_souHeaWat,
    final typCoiHeaPre=VAV_1.coiHeaPre.typ,
    final typCoiCoo=VAV_1.coiCoo.typ,
    final typCoiHeaReh=VAV_1.coiHeaReh.typ,
    final typValCoiHeaPre=VAV_1.coiHeaPre.typVal,
    final typValCoiCoo=VAV_1.coiCoo.typVal,
    final typValCoiHeaReh=VAV_1.coiHeaReh.typVal,
    final typDamOut=VAV_1.secOutRel.typDamOut,
    final typDamOutMin=VAV_1.secOutRel.dat.typDamOutMin,
    final typDamRet=VAV_1.secOutRel.typDamRet,
    final typDamRel=VAV_1.secOutRel.typDamRel,
    final typCtl=VAV_1.ctl.typ,
    id="VAV_1",
    damOut(dp_nominal=15),
    damOutMin(dp_nominal=15),
    damRel(dp_nominal=15),
    damRet(dp_nominal=15),
    mOutMin_flow_nominal=0.2,
    fanSup(m_flow_nominal=1, dp_nominal=500),
    fanRel(m_flow_nominal=1, dp_nominal=200),
    fanRet(m_flow_nominal=1, dp_nominal=200),
    coiHeaPre(
      cap_nominal=1e4,
      dpAir_nominal=100,
      dpWat_nominal=0.5e4,
      dpValve_nominal=0.3e4,
      mWat_flow_nominal=1e4/4186/10,
      TAirEnt_nominal=273.15,
      TWatEnt_nominal=50 + 273.15),
    coiHeaReh(
      cap_nominal=1e4,
      dpAir_nominal=100,
      dpWat_nominal=0.5e4,
      dpValve_nominal=0.3e4,
      mWat_flow_nominal=1e4/4186/10,
      TAirEnt_nominal=273.15,
      TWatEnt_nominal=50 + 273.15),
    coiCoo(
      cap_nominal=1e4,
      dpAir_nominal=100,
      dpWat_nominal=3e4,
      dpValve_nominal=2e4,
      mWat_flow_nominal=1e4/4186/5,
      TAirEnt_nominal=30 + 273.15,
      TWatEnt_nominal=7 + 273.15,
      wAirEnt_nominal=0.012))
    "Parameters for system VAV_1"
    annotation (Dialog(group="Air handlers and fans"));

annotation (
  defaultComponentPrefixes = "inner parameter",
  defaultComponentName = "datAll",
    Documentation(info="<html>
<p>
This class provides the set of sizing and operating parameters for
the whole HVAC system.
It is aimed for validation purposes only.
</p>
</html>"),
    Icon(graphics={
        Text(
          textColor={0,0,255},
          extent={{-150,60},{150,100}},
          textString="%name"),
        Rectangle(
          origin={0,-25},
          lineColor={64,64,64},
          fillColor={85,255,255},
          fillPattern=FillPattern.Solid,
          extent={{-100.0,-75.0},{100.0,75.0}},
          radius=25.0),
        Line(
          points={{-100,0},{100,0}},
          color={64,64,64}),
        Line(
          origin={0,-50},
          points={{-100.0,0.0},{100.0,0.0}},
          color={64,64,64}),
        Line(
          origin={0,-25},
          points={{0.0,75.0},{0.0,-75.0}},
          color={64,64,64})}));
end AllZonalHVACSystems;
