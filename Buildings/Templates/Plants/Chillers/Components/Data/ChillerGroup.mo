within Buildings.Templates.Plants.Chillers.Components.Data;
record ChillerGroup
  "Record for chiller group model"
  extends Modelica.Icons.Record;
  parameter Integer nChi(
    start =1, final min=1)
    "Number of chillers (as installed)"
    annotation (Evaluate=true,
    Dialog(group="Configuration",
      enable=false));
  parameter Buildings.Templates.Components.Types.Chiller typ
    "Type of chiller"
    annotation (Evaluate=true,
    Dialog(group="Configuration",
      enable=false));
  parameter Modelica.Units.SI.MassFlowRate mChiWatChi_flow_nominal[nChi](
    each final min=0)
    "CHW mass flow rate - Each chiller"
    annotation (Dialog(group="Nominal condition"));
  parameter Modelica.Units.SI.MassFlowRate mConWatChi_flow_nominal[nChi](
    each final min=0,
    start=fill(0, nChi))
    "CW mass flow rate - Each chiller"
    annotation (Dialog(group="Nominal condition",
      enable=typ==Buildings.Templates.Components.Types.Chiller.WaterCooled));
  final parameter Modelica.Units.SI.MassFlowRate mConChi_flow_nominal[nChi]=if typ ==
    Buildings.Templates.Components.Types.Chiller.WaterCooled then mConWatChi_flow_nominal
    else Buildings.Templates.Data.Defaults.ratMFloAirByCapChi * abs(capChi_nominal)
    "Condenser cooling fluid mass flow rate - Each chiller"
    annotation (Dialog(group="Nominal condition"));
  parameter Modelica.Units.SI.PressureDifference dpChiWatChi_nominal[nChi](
    each final min=0,
    each start=Buildings.Templates.Data.Defaults.dpChiWatChi)
    "CHW pressure drop - Each chiller"
    annotation (Dialog(group="Nominal condition"));
  parameter Modelica.Units.SI.PressureDifference dpConChi_nominal[nChi](
    each final min=0,
    each start=if typ == Buildings.Templates.Components.Types.Chiller.WaterCooled
      then Buildings.Templates.Data.Defaults.dpConWatChi elseif
      typ == Buildings.Templates.Components.Types.Chiller.AirCooled
      then Buildings.Templates.Data.Defaults.dpAirChi else 0)
    "Condenser cooling fluid pressure drop"
    annotation (Dialog(group="Nominal condition",
      enable=typ==Buildings.Templates.Components.Types.Chiller.WaterCooled));
  parameter Modelica.Units.SI.HeatFlowRate capChi_nominal[nChi](
    each final min=0)
    "Cooling capacity - Each chiller"
    annotation (Dialog(group="Nominal condition"));
  parameter Modelica.Units.SI.Temperature TChiWatSupChi_nominal[nChi](
    each final min=260)
    "Design (lowest) CHW supply temperature - Each chiller"
    annotation (Dialog(group="Nominal condition"));
  parameter Modelica.Units.SI.Temperature TConChi_nominal[nChi](
    each final min=273.15)
    "Condenser entering or leaving fluid temperature (depending on per.use_TConOutForTab) - Each chiller"
    annotation (Dialog(group="Nominal condition"));
  replaceable parameter Buildings.Fluid.Chillers.ModularReversible.Data.TableData2DLoadDep.Generic perChi[nChi](
    mCon_flow_nominal=mConChi_flow_nominal,
    mEva_flow_nominal=mChiWatChi_flow_nominal,
    dpCon_nominal=dpConChi_nominal,
    dpEva_nominal=dpChiWatChi_nominal,
    tabLowBou={[
      TConChi_nominal[i] - 30, TChiWatSupChi_nominal[i] - 2;
      TConChi_nominal[i] + 10, TChiWatSupChi_nominal[i] - 2] for i in 1:nChi},
    each devIde="")
    constrainedby Buildings.Fluid.Chillers.ModularReversible.Data.TableData2DLoadDep.Generic
    "Chiller performance data"
    annotation (choicesAllMatching=true);
  annotation (
    defaultComponentName="datChi",
    Documentation(
      info="<html>
<p>
This record provides the set of sizing and operating parameters for
chiller group models that can be found within
<a href=\"modelica://Buildings.Templates.Plants.Chillers.Components.ChillerGroups\">
Buildings.Templates.Plants.Chillers.Components.ChillerGroups</a>.
</p>
<p>
Within this class, the design values declared at the top-level
are propagated by default to the performance data record <code>per</code>
under the assumption that the nominal conditions used for assessing the
performance data match the design conditions.
However, the nominal, minimum and maximum value of the
condenser cooling fluid temperature are overwritten if the performance data
record is redeclared.
(This is a limitation that comes from the constraint to make this record class
(type-)compatible with chiller group models using
<a href=\"modelica://Buildings.Fluid.Chillers.ElectricReformulatedEIR\">
Buildings.Fluid.Chillers.ElectricReformulatedEIRs</a>
instead of
<a href=\"modelica://Buildings.Fluid.Chillers.ElectricEIR\">
Buildings.Fluid.Chillers.ElectricEIR</a>).
</p>
<p>
Note that, among those propagated parameters, the only meaningful parameter
is the chiller capacity that should be consistent with the value
used for performance assessment.
Regarding the nominal value of the condenser cooling fluid, it may
only yield a warning if an inconsistent value is used.
All other propagated parameters have no impact on the
computation of the chiller performance and are informative
only inside the performance data record.
</p>
<p>
The validation model
<a href=\"modelica://Buildings.Templates.Plants.Chillers.Components.Validation.RecordChillerGroup\">
Buildings.Templates.Plants.Chillers.Components.Validation.RecordChillerGroup</a>
illustrates how the default bindings from this class may be
overwritten when redeclaring the performance data record,
and how different performance curves may be assigned to each chiller
inside the same group.
</p>
</html>"));
end ChillerGroup;
