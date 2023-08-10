within Buildings.Templates.Components.Data;
record HeatingCoil "Record for heating coil model"
  extends Buildings.Templates.Components.Data.Coil;
  replaceable parameter
    Buildings.Fluid.DXSystems.Heating.AirSource.Validation.Data.SingleSpeedHeating datCoi
    constrainedby
    Buildings.Fluid.DXSystems.Heating.AirSource.Data.Generic.DXCoil
    "Performance data record of condensor coil"
    annotation(choicesAllMatching=true,
      Dialog(
      enable=typ==Buildings.Templates.Components.Types.Coil.DXHeatingSingleSpeed));

  parameter Modelica.Units.SI.MassFlowRate mAir_flow_nominal(
    final min=0,
    start=if typ==Buildings.Templates.Components.Types.Coil.DXHeatingSingleSpeed
    then datCoi.sta[datCoi.nSta].nomVal.m_flow_nominal
    else 1)
    "Air mass flow rate"
    annotation (
      Dialog(group="Nominal condition",
      enable=typ<>Buildings.Templates.Components.Types.Coil.None and
      typ<>Buildings.Templates.Components.Types.Coil.DXHeatingSingleSpeed));

  parameter Modelica.Units.SI.HeatFlowRate cap_nominal(
    start=if typ==Buildings.Templates.Components.Types.Coil.None then 0
    elseif typ==Buildings.Templates.Components.Types.Coil.DXHeatingSingleSpeed
    then datCoi.sta[datCoi.nSta].nomVal.Q_flow_nominal
    elseif typ==Buildings.Templates.Components.Types.Coil.WaterBasedCooling then -1E4
    else 1E4)
    "Coil capacity"
    annotation(Dialog(group="Nominal condition",
      enable=typ<>Buildings.Templates.Components.Types.Coil.None and
      typ<>Buildings.Templates.Components.Types.Coil.DXHeatingSingleSpeed));

  parameter Modelica.Units.SI.MassFlowRate mWat_flow_nominal(
    final min=0,
    start=if typ==Buildings.Templates.Components.Types.Coil.WaterBasedHeating then
      Q_flow_nominal / 4186 / 10 elseif
      typ==Buildings.Templates.Components.Types.Coil.WaterBasedCooling then
      -Q_flow_nominal / 4186 / 5 else
      0)
    "Liquid mass flow rate"
    annotation (
      Dialog(group="Nominal condition", enable=have_sou));

  final parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal=
    if typ==Buildings.Templates.Components.Types.Coil.WaterBasedHeating or
       typ==Buildings.Templates.Components.Types.Coil.ElectricHeating then abs(cap_nominal)
    else -1 * abs(cap_nominal)
    "Nominal heat flow rate"
    annotation (Dialog(group="Nominal condition"));

  annotation (Documentation(info="<html>
<p>
This record provides the set of sizing and operating parameters for
the classes within
<a href=\"modelica://Buildings.Templates.Components.Coils\">
Buildings.Templates.Components.Coils</a>.
</p>
</html>"));
end HeatingCoil;
