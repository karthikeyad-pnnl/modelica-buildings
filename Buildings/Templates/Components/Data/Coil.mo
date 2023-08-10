within Buildings.Templates.Components.Data;
record Coil "Record for coil model"
  extends Modelica.Icons.Record;

  parameter Buildings.Templates.Components.Types.Coil typ
    "Equipment type"
    annotation (Dialog(group="Configuration", enable=false), Evaluate=true);
  parameter Buildings.Templates.Components.Types.Valve typVal
    "Type of valve"
    annotation (Dialog(group="Configuration", enable=false), Evaluate=true);
  parameter Boolean have_sou
    "Set to true for fluid ports on the source side"
    annotation (Dialog(group="Configuration"), Evaluate=true);

  /*
For evaporator coils this is also provided by the performance data record.
The coil model shall generate a warning in case the design value exceeds
the maximum value from the performance data record.
*/

  parameter Modelica.Units.SI.PressureDifference dpAir_nominal(
    final min=0,
    displayUnit="Pa",
    start=if typ==Buildings.Templates.Components.Types.Coil.None then 0 else
    100)
    "Air pressure drop"
    annotation (
      Dialog(group="Nominal condition",
        enable=typ<>Buildings.Templates.Components.Types.Coil.None));

  parameter Modelica.Units.SI.PressureDifference dpWat_nominal(
    final min=0,
    displayUnit="Pa",
    start=if typ==Buildings.Templates.Components.Types.Coil.WaterBasedHeating then
    0.5e4 elseif typ==Buildings.Templates.Components.Types.Coil.WaterBasedCooling then
    3e4 else
    0)
    "Liquid pressure drop across coil"
    annotation(Dialog(group="Nominal condition",
      enable=have_sou));
  parameter Modelica.Units.SI.PressureDifference dpValve_nominal(
    final min=0,
    displayUnit="Pa",
    start=if typVal==Buildings.Templates.Components.Types.Valve.None then 0
    else dpWat_nominal / 2)
    "Liquid pressure drop across fully open valve"
    annotation(Dialog(group="Nominal condition",
      enable=have_sou and typVal<>Buildings.Templates.Components.Types.Valve.None));

  /*
For evaporator coils this is also provided by the performance data record.
The coil model shall generate a warning in case the design value exceeds
the maximum value from the performance data record.
*/

  parameter Modelica.Units.SI.Temperature TWatEnt_nominal(
    final min=273.15,
    displayUnit="degC",
    start=if typ==Buildings.Templates.Components.Types.Coil.WaterBasedHeating then 50+273.15
    elseif typ==Buildings.Templates.Components.Types.Coil.WaterBasedCooling then 7+273.15
    else 273.15)
    "Nominal entering liquid temperature"
    annotation (Dialog(
      group="Nominal condition",
      enable=have_sou));
  parameter Modelica.Units.SI.Temperature TAirEnt_nominal(
    final min=243.15,
    displayUnit="degC",
    start=if typ==Buildings.Templates.Components.Types.Coil.WaterBasedCooling then 30+273.15
    else 273.15)
    "Nominal entering air temperature"
    annotation (Dialog(
      group="Nominal condition",
      enable=have_sou));
  parameter Modelica.Units.SI.MassFraction wAirEnt_nominal(
    final min=0,
    start=0.01)
    "Nominal entering air humidity ratio"
    annotation (Dialog(
      group="Nominal condition",
      enable=typ==Buildings.Templates.Components.Types.Coil.WaterBasedCooling));

  annotation (Documentation(info="<html>
<p>
This record provides the set of sizing and operating parameters for
the classes within
<a href=\"modelica://Buildings.Templates.Components.Coils\">
Buildings.Templates.Components.Coils</a>.
</p>
</html>"));
end Coil;
