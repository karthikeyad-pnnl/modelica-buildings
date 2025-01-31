within Buildings.Templates.Plants.HeatPumps_PNNL.Components.Interface;
model PartialHeatPumpGroup_WaterToWater_heatRecovery
  "Interface for heat pump group"
  /*
  MediumChiWat is for internal use only.
  It is the same as MediumCon for reversible HP.
  Non-reversible HP that can be controlled to produce either HW or CHW
  shall be modeled with chiller components (as a chiller/heater).
  */
    final package MediumChiWat=Buildings.Media.Water
    "CHW medium";
  /*
  Derived classes representing AWHP shall use:
  redeclare final package MediumCon = MediumAir
  */
    replaceable package MediumCon=Buildings.Media.Water
    constrainedby Modelica.Media.Interfaces.PartialMedium
    "Source-side medium";
  parameter Integer nHp(
    final min=1)
    "Number of heat pumps"
    annotation (Evaluate=true,
    Dialog(group="Configuration"));
  parameter Buildings.Templates.Components.Types.Chiller typ
    "Equipment type"
    annotation (Evaluate=true,
    Dialog(group="Configuration"));
  parameter Buildings.Templates.Plants.HeatPumps.Components.Data.HeatPumpGroup_heatRecovery dat(
    nHp=nHp,
    typ=typ,
    cpChiWat_default=cpChiWat_default,
    cpCon_default=cpCon_default)
    "Design and operating parameters"
    annotation (Placement(transformation(extent={{170,170},{190,190}})),
    __ctrlFlow(enable=false));
  final parameter Buildings.Templates.Components.Data.Chiller datHp[nHp](
    each final cpCon_default=cpCon_default,
    each final cpChiWat_default=cpChiWat_default,
    each final mCon_flow_nominal=dat.mCon_flow_nominal,
    each final mChiWat_flow_nominal=dat.mChiWat_flow_nominal,
    each final dpChiWat_nominal=dat.dpChiWat_nominal,
    each final TConLvg_nominal=dat.TConLvg_nominal,
    each final TConEnt_nominal=dat.TConEnt_nominal,
    each final dpCon_nominal=dat.dpCon_nominal,
    each final per=dat.per,
    each final cap_nominal=dat.cap_nominal,
    each final TChiWatSup_nominal=dat.TChiWatSup_nominal)
    "Design and operating parameters - Each heat pump";

  // Start of dummy parameters for assignment

  final parameter Modelica.Units.SI.MassFlowRate mCon_flow_nominal=dat.mCon_flow_nominal
    "Design HW mass flow rate - Each heat pump";
  final parameter Modelica.Units.SI.HeatFlowRate capHeaHp_nominal=dat.cap_nominal
    "Design heating capacity - Each heat pump";
  final parameter Modelica.Units.SI.HeatFlowRate QHeaHp_flow_nominal=abs(capHeaHp_nominal)
    "Design heating heat flow rate - Each heat pump";
  final parameter Modelica.Units.SI.PressureDifference dpCon_nominal=dat.dpCon_nominal
    "Design HW pressure drop - Each heat pump";
  final parameter Modelica.Units.SI.Temperature TConLvg_nominal=dat.TConLvg_nominal
    "Design HW supply temperature - Each heat pump";
  final parameter Modelica.Units.SI.Temperature TConEnt_nominal=dat.TConEnt_nominal
    "Design HW return temperature - Each heat pump";
  final parameter Modelica.Units.SI.MassFlowRate mChiWat_flow_nominal=dat.mChiWat_flow_nominal
    "Design CHW mass flow rate - Each heat pump"
    annotation (Dialog(group="Nominal condition"));
  final parameter Modelica.Units.SI.PressureDifference dpChiWat_nominal=dat.dpChiWat_nominal
    "Design CHW pressure drop - Each heat pump";
  final parameter Modelica.Units.SI.HeatFlowRate cap_nominal=dat.cap_nominal
    "Design cooling capacity - Each heat pump";
  final parameter Modelica.Units.SI.HeatFlowRate QCooHp_flow_nominal=- abs(cap_nominal)
    "Design cooling heat flow rate - Each heat pump";
  final parameter Modelica.Units.SI.Temperature TChiWatSup_nominal=dat.TChiWatSup_nominal
    "Design CHW supply temperature - Each heat pump";

  //

  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation (Evaluate=true,
    Dialog(tab="Dynamics",group="Conservation equations"));
  parameter Boolean allowFlowReversal=true
    "Load side flow reversal: false to simplify equations, assuming, but not enforcing, no flow reversal"
    annotation (Dialog(tab="Assumptions"),
    Evaluate=true);
  parameter Boolean allowFlowReversalSou=true
    "Source side flow reversal: false to simplify equations, assuming, but not enforcing, no flow reversal"
    annotation (Dialog(tab="Assumptions",
      enable=Buildings.Templates.Components.Types.HeatPump.WaterToWater),
    Evaluate=true);
  parameter Boolean have_preDroChiHeaWat=true
    "Set to true for CHW/HW pressure drop computed by this model, false for external computation"
    annotation (Evaluate=true,
    Dialog(tab="Assumptions"));
  parameter Boolean have_preDroSou=true
    "Set to true for source fluid pressure drop computed by this model, false for external computation"
    annotation (Evaluate=true,
    Dialog(tab="Assumptions",
      enable=Buildings.Templates.Components.Types.HeatPump.WaterToWater));

  //
  final parameter MediumChiWat.SpecificHeatCapacity cpChiWat_default=
    MediumChiWat.specificHeatCapacityCp(staChiWat_default)
    "CHW default specific heat capacity";
  final parameter MediumChiWat.ThermodynamicState staChiWat_default=MediumChiWat.setState_pTX(
    T=TChiWatSup_nominal,
    p=MediumChiWat.p_default,
    X=MediumChiWat.X_default)
    "CHW default state";
  final parameter MediumCon.SpecificHeatCapacity cpCon_default=MediumCon.specificHeatCapacityCp(
    staCon_default)
    "Condenser fluid default specific heat capacity";
  final parameter MediumCon.ThermodynamicState staCon_default=MediumCon.setState_pTX(
    T=TConLvg_nominal,
    p=MediumCon.p_default,
    X=MediumCon.X_default)
    "Condenser fluid default state";

  //End of dummy parameters
  Modelica.Fluid.Interfaces.FluidPorts_b ports_bChiWat[nHp](
    redeclare each final package Medium = MediumCon,
    each m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0),
    each h_outflow(start=MediumCon.h_default, nominal=MediumCon.h_default))
    "CHW supply (from heat pumps)" annotation (Placement(transformation(
        extent={{-10,-40},{10,40}},
        rotation=90,
        origin={-120,200}), iconTransformation(
        extent={{-10,-40},{10,40}},
        rotation=90,
        origin={-500,400})));

  Modelica.Fluid.Interfaces.FluidPorts_a ports_aChiWat[nHp](
    redeclare each final package Medium = MediumCon,
    each m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0),
    each h_outflow(start=MediumCon.h_default, nominal=MediumCon.h_default))
    "CHW Return (To heat pumps)" annotation (Placement(transformation(
        extent={{-10,-40},{10,40}},
        rotation=90,
        origin={120,200}), iconTransformation(
        extent={{-10,-40},{10,40}},
        rotation=90,
        origin={500,400})));

  Modelica.Fluid.Interfaces.FluidPorts_b ports_bHotWat[nHp](
    redeclare each final package Medium = MediumCon,
    each m_flow(max=if allowFlowReversalSou then +Modelica.Constants.inf
           else 0),
    each h_outflow(start=MediumCon.h_default, nominal=MediumCon.h_default))
    "HW Supply (from heat pumps)" annotation (Placement(
      iconVisible=typ == Buildings.Templates.Components.Types.HeatPump.WaterToWater,
      transformation(
        extent={{-10,-40},{10,40}},
        rotation=90,
        origin={120,-200}),
      iconTransformation(
        extent={{-10,-40},{10,40}},
        rotation=90,
        origin={500,-398})));

  Modelica.Fluid.Interfaces.FluidPorts_a ports_aHotWat[nHp](
    redeclare each final package Medium = MediumCon,
    each m_flow(min=if allowFlowReversalSou then -Modelica.Constants.inf
           else 0),
    each h_outflow(start=MediumCon.h_default, nominal=MediumCon.h_default))
    "HW Return (to heat pumps)" annotation (Placement(
      iconVisible=typ == Buildings.Templates.Components.Types.HeatPump.WaterToWater,
      transformation(
        extent={{-10,-40},{10,40}},
        rotation=90,
        origin={-120,-200}),
      iconTransformation(
        extent={{-10,-40},{10,40}},
        rotation=90,
        origin={-500,-400})));

  Buildings.Templates.Plants.HeatPumps.Interfaces.Bus bus
    "Plant control bus"
    annotation (Placement(transformation(extent={{-20,180},{20,220}}),
      iconTransformation(extent={{-20,380},{20,420}})));
  // Diagnostics
  parameter Boolean show_T=false
    "= true, if actual temperature at port is computed"
    annotation (Dialog(tab="Advanced",group="Diagnostics"),HideResult=true);
  MediumCon.ThermodynamicState sta_aChiHeaWat[nHp]=
      MediumCon.setState_phX(
        ports_aChiWat.p,
        noEvent(actualStream(ports_aChiWat.h_outflow)),
        noEvent(actualStream(ports_aChiWat.Xi_outflow))) if show_T
    "CHW/HW medium properties in port_aChiHeaWat";
  MediumCon.ThermodynamicState sta_bChiHeaWat[nHp]=
      MediumCon.setState_phX(
        ports_bChiWat.p,
        noEvent(actualStream(ports_bChiWat.h_outflow)),
        noEvent(actualStream(ports_bChiWat.Xi_outflow))) if show_T
    "CHW/HW medium properties in port_bChiHeaWat";
  MediumCon.ThermodynamicState sta_aSou[nHp]=MediumCon.setState_phX(
        ports_aHotWat.p,
        noEvent(actualStream(ports_aHotWat.h_outflow)),
        noEvent(actualStream(ports_aHotWat.Xi_outflow))) if show_T
    "Source medium properties in port_aSou";
  MediumCon.ThermodynamicState sta_bSou[nHp]=MediumCon.setState_phX(
        ports_bHotWat.p,
        noEvent(actualStream(ports_bHotWat.h_outflow)),
        noEvent(actualStream(ports_bHotWat.Xi_outflow))) if show_T
    "Source medium properties in port_bSou";
protected
  Buildings.Templates.Components.Interfaces.Bus busHp[nHp]
    "Heat pump control bus"
    annotation (Placement(transformation(extent={{40,120},{80,160}}),
      iconTransformation(extent={{-522,206},{-482,246}})));
equation
  connect(bus.hp, busHp)
    annotation (Line(points={{0,200},{0,140},{60,140}},
                                                      color={255,204,51},thickness=0.5));
  annotation (Diagram(coordinateSystem(extent={{-200,-200},{200,200}})), Icon(
        coordinateSystem(preserveAspectRatio=false, extent={{-2400,-400},{2400,
            400}}), graphics={
        Bitmap(
          extent={{1880,160},{1960,240}},
          fileName=
              "modelica://Buildings/Resources/Images/Templates/Components/Boilers/ControllerOnboard.svg",
          visible=nHp >= 1),
        Rectangle(
          extent={{2240,400},{1960,0}},
          lineColor={0,0,0},
          lineThickness=1,
          visible=nHp >= 1,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{1960,250},{2240,150}},
          textColor={0,0,0},
          visible=nHp >= 1,
          textString="HP-1"),
        Bitmap(
          extent={{1080,160},{1160,240}},
          fileName="modelica://Buildings/Resources/Images/Templates/Components/Boilers/ControllerOnboard.svg",
          visible=nHp >= 2),
        Rectangle(
          extent={{1440,400},{1160,0}},
          lineColor={0,0,0},
          lineThickness=1,
          visible=nHp >= 2,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{1160,250},{1440,150}},
          textColor={0,0,0},
          visible=nHp >= 2,
          textString="HP-2"),
        Bitmap(
          extent={{280,160},{360,240}},
          fileName="modelica://Buildings/Resources/Images/Templates/Components/Boilers/ControllerOnboard.svg",
          visible=nHp >= 3),
        Rectangle(
          extent={{640,400},{360,0}},
          lineColor={0,0,0},
          lineThickness=1,
          visible=nHp >= 3,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{360,250},{640,150}},
          textColor={0,0,0},
          visible=nHp >= 3,
          textString="HP-3"),
        Bitmap(
          extent={{-520,160},{-440,240}},
          fileName="modelica://Buildings/Resources/Images/Templates/Components/Boilers/ControllerOnboard.svg",
          visible=nHp >= 4),
        Rectangle(
          extent={{-160,400},{-440,0}},
          lineColor={0,0,0},
          lineThickness=1,
          visible=nHp >= 4,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-440,250},{-160,150}},
          textColor={0,0,0},
          visible=nHp >= 4,
          textString="HP-4"),
        Bitmap(
          extent={{-1320,160},{-1240,240}},
          fileName="modelica://Buildings/Resources/Images/Templates/Components/Boilers/ControllerOnboard.svg",
          visible=nHp >= 5),
        Rectangle(
          extent={{-960,400},{-1240,0}},
          lineColor={0,0,0},
          lineThickness=1,
          visible=nHp >= 5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-1240,250},{-960,150}},
          textColor={0,0,0},
          visible=nHp >= 5,
          textString="HP-5"),
        Bitmap(
          extent={{-2120,160},{-2040,240}},
          fileName="modelica://Buildings/Resources/Images/Templates/Components/Boilers/ControllerOnboard.svg",
          visible=nHp >= 6),
        Rectangle(
          extent={{-1760,400},{-2040,0}},
          lineColor={0,0,0},
          lineThickness=1,
          visible=nHp >= 6,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-2040,250},{-1760,150}},
          textColor={0,0,0},
          visible=nHp >= 6,
          textString="HP-6")}),
    Documentation(info="<html>
<p>
This partial class provides a standard interface for heat pump
group models.
</p>
</html>"));
end PartialHeatPumpGroup_WaterToWater_heatRecovery;
