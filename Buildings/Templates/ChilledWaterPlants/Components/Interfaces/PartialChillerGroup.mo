within Buildings.Templates.ChilledWaterPlants.Components.Interfaces;
model PartialChillerGroup "Interface class for chiller group"
  replaceable package MediumChiWat = Buildings.Media.Water
    constrainedby Modelica.Media.Interfaces.PartialMedium
    "CHW medium";
  replaceable package MediumCon = Buildings.Media.Water
    constrainedby Modelica.Media.Interfaces.PartialMedium
    "Medium model for condenser cooling fluid";

  parameter Integer nChi
    "Number of chillers"
    annotation (Evaluate=true, Dialog(group="Configuration"));
  parameter Buildings.Templates.Components.Types.Chiller typChi
    "Type of chiller"
    annotation (Evaluate=true, Dialog(group="Configuration"));
  parameter Buildings.Templates.ChilledWaterPlants.Types.ChillerLiftControl typCtrHea(
    start=Buildings.Templates.ChilledWaterPlants.Types.ChillerLiftControl.None)
    "Type of head pressure control"
    annotation (Evaluate=true, Dialog(group="Configuration",
    enable=typChi==Buildings.Templates.Components.Types.Chiller.WaterCooled));
  parameter Buildings.Templates.ChilledWaterPlants.Types.PumpArrangement typArrPumChiWatPri
    "Type of primary CHW pump arrangement"
    annotation (Evaluate=true, Dialog(group="Configuration"));
  parameter Buildings.Templates.ChilledWaterPlants.Types.PumpArrangement typArrPumConWat
    "Type of CW pump arrangement"
    annotation (Evaluate=true, Dialog(group="Configuration",
      enable=typChi==Buildings.Templates.Components.Types.Chiller.WaterCooled));
  parameter Buildings.Templates.Components.Types.PumpMultipleSpeedControl typCtrSpePumConWat
    "Type of CW pump speed control"
    annotation (Evaluate=true, Dialog(group="Configuration",
      enable=typChi==Buildings.Templates.Components.Types.Chiller.WaterCooled));
  parameter Buildings.Templates.ChilledWaterPlants.Types.Economizer typEco
    "Type of WSE"
    annotation (Evaluate=true, Dialog(group="Configuration"));

  final parameter Buildings.Templates.Components.Types.ValveOption typOptValChiWatIso=
    if typArrPumChiWatPri==Buildings.Templates.ChilledWaterPlants.Types.PumpArrangement.Headered
    then Buildings.Templates.Components.Types.ValveOption.Choices else
    Buildings.Templates.Components.Types.ValveOption.NoValve
    "Possible options for chiller CHW isolation valve"
    annotation (Evaluate=true, Dialog(group="Configuration"));
  final parameter Buildings.Templates.Components.Types.ValveOption typOptValConWatIso=
    if typChi<>Buildings.Templates.Components.Types.Chiller.WaterCooled then
      Buildings.Templates.Components.Types.ValveOption.NoValve
    elseif typArrPumConWat==Buildings.Templates.ChilledWaterPlants.Types.PumpArrangement.Dedicated
    then Buildings.Templates.Components.Types.ValveOption.NoValve
    elseif (typCtrHea==Buildings.Templates.ChilledWaterPlants.Types.ChillerLiftControl.None or
      typCtrSpePumConWat<>Buildings.Templates.Components.Types.PumpMultipleSpeedControl.Constant
      and
      typEco==Buildings.Templates.ChilledWaterPlants.Types.Economizer.None) then
    Buildings.Templates.Components.Types.ValveOption.Choices else
    Buildings.Templates.Components.Types.ValveOption.Modulating
    "Possible options for chiller CW isolation valve"
    annotation (Evaluate=true, Dialog(group="Configuration"));

  parameter Buildings.Templates.ChilledWaterPlants.Components.Data.ChillerGroup dat(
    final typChi=typChi,
    final nChi=nChi)
    "Parameter record for chiller group";

  final parameter Modelica.Units.SI.MassFlowRate mChiWatChi_flow_nominal[nChi]=
    dat.mChiWatChi_flow_nominal
    "CHW mass flow rate for each chiller";
  final parameter Modelica.Units.SI.MassFlowRate mConWatChi_flow_nominal[nChi]=
    dat.mConWatChi_flow_nominal
    "CW mass flow rate for each chiller";
  final parameter Modelica.Units.SI.MassFlowRate mConAirChi_flow_nominal[nChi]=
    dat.mConAirChi_flow_nominal
    "Air mass flow rate at condenser for each chiller";
  final parameter Modelica.Units.SI.HeatFlowRate capChi_nominal[nChi]=
    dat.capChi_nominal
    "Cooling capacity for each chiller";
  final parameter Modelica.Units.SI.PressureDifference dpChiWatChi_nominal[nChi]=
    dat.dpChiWatChi_nominal
    "CHW pressure drop for each chiller";
  final parameter Modelica.Units.SI.PressureDifference dpConWatChi_nominal[nChi]=
    dat.dpConWatChi_nominal
    "CW pressure drop for each chiller";
  final parameter Modelica.Units.SI.Temperature TChiWatChiSup_nominal[nChi]=
    dat.TChiWatChiSup_nominal
    "CHW supply temperature for each chiller";

  parameter Buildings.Templates.Components.Data.Valve datValChiWatChiIso[nChi](
    each final typ=Buildings.Templates.Components.Types.Valve.TwoWayTwoPosition,
    final m_flow_nominal=mChiWatChi_flow_nominal,
    each dpValve_nominal=Buildings.Templates.Data.Defaults.dpValIso)
    "Parallel chillers CHW bypass valve parameters"
    annotation (Dialog(enable=false));
  parameter Buildings.Templates.Components.Data.Valve datValConWatChiIso[nChi](
    each final typ=Buildings.Templates.Components.Types.Valve.TwoWayTwoPosition,
    final m_flow_nominal=mConWatChi_flow_nominal,
    each dpValve_nominal=Buildings.Templates.Data.Defaults.dpValIso)
    "Series chillers CHW bypass valve parameters"
    annotation (Dialog(enable=false));

  parameter Modelica.Units.SI.Time tau=30
    "Time constant at nominal flow"
    annotation (Dialog(tab="Dynamics", group="Nominal condition"));
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=
    Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Conservation equations"));

  parameter Boolean allowFlowReversal=true
    "= true to allow flow reversal, false restricts to design direction (port_a -> port_b)"
    annotation (Dialog(tab="Assumptions"), Evaluate=true);

  Modelica.Fluid.Interfaces.FluidPorts_b ports_bChiWat[nChi](
    redeclare each final package Medium = MediumChiWat,
    each m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0),
    each h_outflow(start=MediumChiWat.h_default, nominal=MediumChiWat.h_default))
    "CHW supply"
    annotation (Placement(transformation(extent={{190,80},{210,160}}),
    iconTransformation(extent={{190,260},{210,340}})));
  Modelica.Fluid.Interfaces.FluidPorts_b ports_bCon[nChi](
    redeclare each final package Medium = MediumCon,
    each m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0),
    each h_outflow(start=MediumCon.h_default, nominal=MediumCon.h_default))
    "Condenser cooling fluid return (e.g. from chillers to cooling towers)"
    annotation (Placement(transformation(extent={{-210,80},{-190,160}}),
        iconTransformation(extent={{-210,260},{-190,340}})));
  Modelica.Fluid.Interfaces.FluidPorts_a ports_aCon[nChi](
    redeclare each final package Medium = MediumCon,
    each m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0),
    each h_outflow(start=MediumCon.h_default, nominal=MediumCon.h_default))
    "Condenser cooling fluid supply (e.g. from cooling towers to chillers)"
    annotation (Placement(transformation(extent={{-210,-140},{-190,-60}}),
        iconTransformation(extent={{-210,-340},{-190,-260}})));
  Modelica.Fluid.Interfaces.FluidPorts_a ports_aChiWat[nChi](
    redeclare each final package Medium = MediumChiWat,
    each m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0),
    each h_outflow(start=MediumChiWat.h_default, nominal=MediumChiWat.h_default))
    "CHW return"
    annotation (Placement(transformation(extent={{190,-140},{210, -60}}),
    iconTransformation(extent={{190,-340},{210,-260}})));
  Buildings.Templates.ChilledWaterPlants.Interfaces.Bus bus
    "Plant control bus"
    annotation (Placement(transformation(extent={{-20,180},{20,220}}),
    iconTransformation(extent={{-20,580},{20,620}})));
  annotation (Diagram(coordinateSystem(extent={{-200,-180},{200,200}})),
  Icon(coordinateSystem(preserveAspectRatio=false,
    extent={{-200,-600},{200,600}}), graphics={
        Text(
          extent={{-149,-614},{151,-654}},
          textColor={0,0,255},
          textString="%name"),
    Rectangle(extent={{-200,600},{200,-600}},
            lineColor={28,108,200})}));
end PartialChillerGroup;
