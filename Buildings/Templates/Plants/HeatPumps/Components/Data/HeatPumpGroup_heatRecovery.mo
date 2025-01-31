within Buildings.Templates.Plants.HeatPumps.Components.Data;
record HeatPumpGroup_heatRecovery
  extends Modelica.Icons.Record;
  parameter Integer nHp(
    final min=1)
    "Number of heat pumps"
    annotation (Evaluate=true,
    Dialog(group="Configuration",
      enable=false));
  parameter Boolean use_datDes=true
    "Set to true to use specified design conditions, false to use data from performance record"
    annotation (Evaluate=true,
    __ctrlFlow(enable=false));
  parameter Buildings.Templates.Components.Types.Chiller typ
    "Type of chiller"
    annotation (Evaluate=true,
    Dialog(group="Configuration",
      enable=false));
  parameter Modelica.Units.SI.SpecificHeatCapacity cpChiWat_default=Buildings.Utilities.Psychrometrics.Constants.cpWatLiq
    "CHW default specific heat capacity"
    annotation (Dialog(group="Configuration",
      enable=false));
  parameter Modelica.Units.SI.SpecificHeatCapacity cpCon_default=if typ ==
    Buildings.Templates.Components.Types.Chiller.AirCooled then Buildings.Utilities.Psychrometrics.Constants.cpAir
    else Buildings.Utilities.Psychrometrics.Constants.cpWatLiq
    "Condenser cooling fluid default specific heat capacity"
    annotation (Dialog(group="Configuration",
      enable=false));
  parameter Modelica.Units.SI.MassFlowRate mChiWat_flow_nominal(
    start=if not use_datDes then per.mEva_flow_nominal else 1E-3,
    final min=0)
    "CHW mass flow rate"
    annotation (Dialog(group="Nominal condition",
      enable=typ<>Buildings.Templates.Components.Types.Chiller.None and use_datDes));
  parameter Modelica.Units.SI.MassFlowRate mCon_flow_nominal(
    start=if not use_datDes then per.mCon_flow_nominal elseif typ == Buildings.Templates.Components.Types.Chiller.AirCooled
      then Buildings.Templates.Data.Defaults.mAirFloByCapChi * abs(cap_nominal)
      else 1E-3,
    final min=0)
    "Condenser cooling fluid (e.g. CW) mass flow rate"
    annotation (Dialog(group="Nominal condition",
      enable=typ==Buildings.Templates.Components.Types.Chiller.WaterCooled and use_datDes));
  parameter Modelica.Units.SI.HeatFlowRate capHea_nominal(
    start=if not use_datDes then abs(per.QEva_flow_nominal) else 1E-3)
    "Heating capacity"
    annotation (Dialog(group="Nominal condition",
      enable=typ<>Buildings.Templates.Components.Types.Chiller.None and use_datDes));
  parameter Modelica.Units.SI.HeatFlowRate capCoo_nominal(
    start=if not use_datDes then abs(per.QEva_flow_nominal) else 1E-3)
    "Cooling capacity"
    annotation (Dialog(group="Nominal condition",
      enable=typ<>Buildings.Templates.Components.Types.Chiller.None and use_datDes));
  final parameter Modelica.Units.SI.HeatFlowRate cap_nominal(
    start=if not use_datDes then abs(per.QEva_flow_nominal) else 1E-3) = -max(capHea_nominal, capCoo_nominal)
    "Cooling capacity"
    annotation (Dialog(group="Nominal condition",
      enable=typ<>Buildings.Templates.Components.Types.Chiller.None and use_datDes));
  final parameter Modelica.Units.SI.HeatFlowRate QCon_flow_nominal(
    final min=0)=abs(cap_nominal) *(1 / COP_nominal + 1)
    "Condenser heat flow rate"
    annotation (Dialog(group="Nominal condition"));
  parameter Real COP_nominal(
    start=if not use_datDes then per.COP_nominal else Buildings.Templates.Data.Defaults.COPChiAirCoo,
    final min=1,
    final unit="1")
    "Cooling COP"
    annotation (Dialog(group="Nominal condition",
      enable=typ<>Buildings.Templates.Components.Types.Chiller.None and use_datDes));
  parameter Modelica.Units.SI.PressureDifference dpChiWat_nominal(
    final min=0,
    start=if typ == Buildings.Templates.Components.Types.Chiller.None then 0
      else Buildings.Templates.Data.Defaults.dpChiWatChi)
    "CHW pressure drop"
    annotation (Dialog(group="Nominal condition",
      enable=typ<>Buildings.Templates.Components.Types.Chiller.None));
  parameter Modelica.Units.SI.PressureDifference dpCon_nominal(
    final min=0,
    start=if typ == Buildings.Templates.Components.Types.Chiller.WaterCooled
      then Buildings.Templates.Data.Defaults.dpConWatChi elseif typ == Buildings.Templates.Components.Types.Chiller.AirCooled
      then Buildings.Templates.Data.Defaults.dpAirChi else 0)
    "Condenser cooling fluid pressure drop"
    annotation (Dialog(group="Nominal condition",
      enable=typ==Buildings.Templates.Components.Types.Chiller.WaterCooled));
  parameter Modelica.Units.SI.Temperature TChiWatSup_nominal(
    start=if not use_datDes then per.TEvaLvg_nominal else Buildings.Templates.Data.Defaults.TChiWatSup,
    final min=260)
    "CHW supply temperature"
    annotation (Dialog(group="Nominal condition",
      enable=typ<>Buildings.Templates.Components.Types.Chiller.None and use_datDes));
  final parameter Modelica.Units.SI.Temperature TChiWatRet_nominal(
    final min=260)=if typ == Buildings.Templates.Components.Types.Chiller.None
    then TChiWatSup_nominal else TChiWatSup_nominal + abs(cap_nominal) /
    cpChiWat_default / mChiWat_flow_nominal
    "CHW return temperature"
    annotation (Dialog(group="Nominal condition"));
  parameter Modelica.Units.SI.Temperature TChiWatSup_min(
    start=if not use_datDes then per.TEvaLvgMin else Buildings.Templates.Data.Defaults.TChiWatSup_min)=
    Buildings.Templates.Data.Defaults.TChiWatSup_min
    "Minimum CHW supply temperature"
    annotation (Dialog(group="Operating limits",
      enable=typ<>Buildings.Templates.Components.Types.Chiller.None and use_datDes));
  parameter Modelica.Units.SI.Temperature TChiWatSup_max(
    start=if not use_datDes then per.TEvaLvgMax else Buildings.Templates.Data.Defaults.TChiWatSup_max)=
    Buildings.Templates.Data.Defaults.TChiWatSup_max
    "Maximum CHW supply temperature"
    annotation (Dialog(group="Operating limits",
      enable=typ<>Buildings.Templates.Components.Types.Chiller.None and use_datDes));
  parameter Modelica.Units.SI.Temperature TConEnt_nominal(
    final min=273.15,
    start=if not use_datDes then per.TConLvg_nominal - QCon_flow_nominal /
      mCon_flow_nominal / cpCon_default else Buildings.Templates.Data.Defaults.TConEnt_max)
    "Condenser entering fluid temperature (CW or air)"
    annotation (Dialog(group="Nominal condition",
      enable=typ<>Buildings.Templates.Components.Types.Chiller.None and use_datDes));
  // The following parameter is not declared as final to allow parameterization
  // based on leaving CHW temperature.
  parameter Modelica.Units.SI.Temperature TConLvg_nominal=if not use_datDes then per.TConLvg_nominal
    else TConEnt_nominal + QCon_flow_nominal / mCon_flow_nominal / cpCon_default
    "Condenser leaving fluid temperature (CW or air)"
    annotation (Dialog(group="Nominal condition",
      enable=typ<>Buildings.Templates.Components.Types.Chiller.None and use_datDes));
  parameter Modelica.Units.SI.Temperature TConLvg_min(
    start=if not use_datDes then per.TConLvgMin else Buildings.Templates.Data.Defaults.TConLvg_min,
    final min=273.15)=Buildings.Templates.Data.Defaults.TConLvg_min
    "Minimum condenser leaving fluid temperature (CW or air)"
    annotation (Dialog(group="Operating limits",
      enable=typ<>Buildings.Templates.Components.Types.Chiller.None and use_datDes));
  parameter Modelica.Units.SI.Temperature TConLvg_max(
    start=if not use_datDes then per.TConLvgMax else Buildings.Templates.Data.Defaults.TConLvg_max,
    final min=273.15)=Buildings.Templates.Data.Defaults.TConLvg_max
    "Maximum condenser leaving fluid temperature (CW or air)"
    annotation (Dialog(group="Operating limits",
      enable=typ<>Buildings.Templates.Components.Types.Chiller.None and use_datDes));
  parameter Real PLRUnl_min(
    start=if not use_datDes then per.PLRMinUnl else 0,
    final min=PLR_min,
    final max=1)=PLR_min
    "Minimum unloading ratio (before engaging hot gas bypass, if any)"
    annotation (Dialog(enable=typ<>Buildings.Templates.Components.Types.Chiller.None
      and use_datDes));
  parameter Real PLR_min(
    start=if not use_datDes then per.PLRMin else 0,
    final min=0,
    final max=1)=0.15
    "Minimum part load ratio before cycling"
    annotation (Dialog(enable=typ<>Buildings.Templates.Components.Types.Chiller.None
      and use_datDes));
  replaceable parameter Buildings.Fluid.Chillers.Data.ElectricReformulatedEIR.Generic per(
    TConLvg_nominal=if use_datDes then TConLvg_nominal else 273.15,
    TConLvgMin=if use_datDes then TConLvg_min else 273.15,
    TConLvgMax=if use_datDes then TConLvg_max else 273.15,
    COP_nominal=if use_datDes then COP_nominal else 1.1,
    QEva_flow_nominal=if use_datDes then - abs(cap_nominal) else 1E-3,
    TEvaLvg_nominal=if use_datDes then TChiWatSup_nominal else 273.15,
    TEvaLvgMin=if use_datDes then TChiWatSup_nominal else 273.15,
    TEvaLvgMax=if use_datDes then TChiWatSup_max else 273.15,
    PLRMin=if use_datDes then PLR_min else 0,
    PLRMinUnl=if use_datDes then PLRUnl_min else 0,
    PLRMax=1.0,
    etaMotor=1.0,
    mEva_flow_nominal=if use_datDes then mChiWat_flow_nominal else 1E-3,
    mCon_flow_nominal=if use_datDes then mCon_flow_nominal else 1E-3,
    capFunT={1, 0, 0, 0, 0, 0},
    EIRFunT={1, 0, 0, 0, 0, 0},
    EIRFunPLR={1, 0, 0, 0, 0, 0, 0, 0, 0, 0})
    constrainedby Buildings.Fluid.Chillers.Data.ElectricReformulatedEIR.Generic
    "Chiller performance data"
    annotation (choicesAllMatching=true,
    Dialog(enable=typ<>Buildings.Templates.Components.Types.Chiller.None and use_datDes));
  final parameter Real COPPer_nominal(
    final min=0,
    final unit="1")=if typ == Buildings.Templates.Components.Types.Chiller.None
    then per.COP_nominal else per.COP_nominal / Buildings.Utilities.Math.Functions.biquadratic(
    a=per.EIRFunT,
    x1=Modelica.Units.Conversions.to_degC(TChiWatSup_nominal),
    x2=Modelica.Units.Conversions.to_degC(TConLvg_nominal)) / Buildings.Utilities.Math.Functions.bicubic(
    a=per.EIRFunPLR,
    x1=Modelica.Units.Conversions.to_degC(TConLvg_nominal),
    x2=1)
    "Cooling COP computed from performance record"
    annotation (Dialog(group="Nominal condition"));
  final parameter Modelica.Units.SI.HeatFlowRate capPer_flow_nominal=if typ ==
    Buildings.Templates.Components.Types.Chiller.None then abs(per.QEva_flow_nominal)
    else abs(per.QEva_flow_nominal) * Buildings.Utilities.Math.Functions.biquadratic(
    a=per.capFunT,
    x1=Modelica.Units.Conversions.to_degC(TChiWatSup_nominal),
    x2=Modelica.Units.Conversions.to_degC(TConLvg_nominal))
    "Cooling capacity computed from performance record"
    annotation (Dialog(group="Nominal condition"));
  final parameter Buildings.Fluid.Chillers.Data.ElectricReformulatedEIR.Generic perSca(
    final COP_nominal=per.COP_nominal * COP_nominal / COPPer_nominal,
    final QEva_flow_nominal=per.QEva_flow_nominal * abs(cap_nominal) /
      capPer_flow_nominal,
    final EIRFunPLR=per.EIRFunPLR,
    final EIRFunT=per.EIRFunT,
    final PLRMax=per.PLRMax,
    final PLRMin=per.PLRMin,
    final PLRMinUnl=per.PLRMinUnl,
    final TConLvgMax=per.TConLvgMax,
    final TConLvgMin=per.TConLvgMin,
    final TConLvg_nominal=per.TConLvg_nominal,
    final TEvaLvgMax=per.TEvaLvgMax,
    final TEvaLvgMin=per.TEvaLvgMin,
    final TEvaLvg_nominal=per.TEvaLvg_nominal,
    final capFunT=per.capFunT,
    final etaMotor=per.etaMotor,
    final mCon_flow_nominal=per.mCon_flow_nominal,
    final mEva_flow_nominal=per.mEva_flow_nominal)
    "Chiller performance data scaled to specified design capacity and COP"
    annotation (choicesAllMatching=true);
  annotation (
    defaultComponentPrefixes="parameter",
    defaultComponentName="datHp",
    Documentation(info="<html>
<p>
This record provides the set of parameters for heat pump group models 
that can be found within
<a href=\"modelica://Buildings.Templates.Plants.HeatPumps.Components.HeatPumpGroups\">
Buildings.Templates.Plants.HeatPumps.Components.HeatPumpGroups</a>.
</p>
<p>
Only identical heat pumps are currently supported.
</p>
</html>"));
end HeatPumpGroup_heatRecovery;
