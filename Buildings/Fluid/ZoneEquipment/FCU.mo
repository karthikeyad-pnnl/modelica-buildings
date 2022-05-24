within Buildings.Fluid.ZoneEquipment;
model FCU

  parameter Buildings.Fluid.ZoneEquipment.Types.heatingCoil heatingCoilType
    "Type of heating coil used in the FCU";

  parameter Buildings.Fluid.ZoneEquipment.Types.capacityControl capacityControlMethod
    "Type of capacity control method";

  parameter Modelica.Units.SI.HeatFlowRate QHeaCoi_flow_nominal
    "Heat flow rate at u=1, positive for heating";
  parameter Modelica.Units.SI.MassFlowRate mHotWat_flow_nominal
    "Nominal mass flow rate of water";
  parameter Modelica.Units.SI.PressureDifference dpHeaCoiWat_nominal
    "Pressure difference";
  parameter Modelica.Units.SI.PressureDifference dpHeaCoiAir_nominal
    "Pressure difference";
  parameter Modelica.Units.SI.ThermalConductance UAHeaCoi_nominal
    "Thermal conductance at nominal flow, used to compute heat capacity";
  parameter Real minSpeRatCooCoi "Minimum speed ratio";
  parameter Modelica.Units.SI.PressureDifference dpCooCoiAir_nominal
    "Pressure difference";
  parameter Modelica.Units.SI.MassFlowRate mChiWat_flow_nominal
    "Nominal mass flow rate of water";
  parameter Modelica.Units.SI.ThermalConductance UACooCoi_nominal
    "Thermal conductance at nominal flow, used to compute heat capacity";
  parameter Modelica.Units.SI.PressureDifference dpCooCoiWat_nominal
    "Pressure difference";

  extends Buildings.Fluid.ZoneEquipment.Baseclasses.PartialComponent(
    redeclare Buildings.Fluid.ZoneEquipment.Components.coolingCoil coi2(
      m_flow_nominal=mAir_flow_nominal,
      final has_coolingCoil=has_coolingCoil,
      final has_coolingCoilCCW=has_coolingCoilCCW,
      mAir_flow_nominal=mAir_flow_nominal,
      minSpeRatCooCoi=minSpeRatCooCoi,
      dpCooCoiAir_nominal=dpCooCoiAir_nominal,
      dpCooCoiWat_nominal=dpCooCoiWat_nominal,
      mChiWat_flow_nominal=mChiWat_flow_nominal,
      UACooCoi_nominal=UACooCoi_nominal,
      redeclare package Medium = MediumA,
      redeclare package MediumA = MediumA,
      redeclare package MediumW = MediumW),
    redeclare Buildings.Fluid.ZoneEquipment.Components.heatingCoil coi1(
      m_flow_nominal=mAir_flow_nominal,
      final has_heatingCoil=has_heatingCoil,
      final has_heatingCoilHHW=has_heatingCoilHHW_flag,
      mAir_flow_nominal=mAir_flow_nominal,
      QHeaCoi_flow_nominal=QHeaCoi_flow_nominal,
      mHotWat_flow_nominal=mHotWat_flow_nominal,
      dpHeaCoiWat_nominal=dpHeaCoiWat_nominal,
      dpHeaCoiAir_nominal=dpHeaCoiAir_nominal,
      UAHeaCoi_nominal=UAHeaCoi_nominal,
      redeclare package Medium = MediumA,
      redeclare package MediumA = MediumA,
      redeclare package MediumW = MediumW),
    redeclare Buildings.Fluid.ZoneEquipment.Components.economizer eco(
      mAirOut_flow_nominal=mAirOut_flow_nominal,
      m_flow_nominal=mAir_flow_nominal,
      has_economizer=has_economizer,
      mAir_flow_nominal=mAir_flow_nominal,
      redeclare package Medium = MediumA,
      redeclare package MediumA = MediumA),
    final has_economizer=true,
    final has_coolingCoil=true,
    final has_coolingCoilCCW=true,
    final has_heatingCoil=true,
    has_heatingCoilHHW=has_heatingCoilHHW_flag,
    fan(per=fanPer, addPowerToMedium=fanAddPowerToMedium));

//     parameter Boolean has_heatingCoil = true
//       "Does the zone equipment have a heating coil?";
//
//     parameter Boolean has_coolingCoil = true
//       "Does the zone equipment have a heating coil?";
//
//     parameter Boolean has_coolingCoilCCW = true
//       "Does the zone equipment have a hot water heating coil?"
//       annotation(Dialog(enable = has_coolingCoil));

  parameter Modelica.Units.SI.MassFlowRate mAirOut_flow_nominal
    "Nominal mass flow rate of outdoor air";
protected
  Boolean has_heatingCoilHHW_flag = heatingCoilType ==Buildings.Fluid.ZoneEquipment.Types.heatingCoil.heatingHotWater
    "Does the zone equipment have a hot water heating coil?"
    annotation(Dialog(enable=has_heatingCoil));

  replaceable parameter Fluid.Movers.Data.Generic fanPer constrainedby
    Buildings.Fluid.Movers.Data.Generic
    "Record with performance data for supply fan"
    annotation (choicesAllMatching=true,
      Placement(transformation(extent={{52,60},{72,80}})));

  parameter Boolean fanAddPowerToMedium=true
    "Set to false to avoid any power (=heat and flow work) being added to medium (may give simpler equations)";
equation
  connect(uHea, coi1.uHea) annotation (Line(points={{-40,280},{-40,120},{-50,
          120},{-50,-28}}, color={0,0,127}));
  connect(uCoo, coi2.uCoo) annotation (Line(points={{120,280},{120,82},{30,82},
          {30,-28}}, color={0,0,127}));
  connect(TAmb, coi2.TAmb)
    annotation (Line(points={{-240,220},{26,220},{26,-28}}, color={0,0,127}));
  connect(senTem.T, TSupAir) annotation (Line(points={{170,-29},{172,-29},{172,240},
          {240,240}}, color={0,0,127}));
  connect(senVolFlo.V_flow, VSupAir_flow)
    annotation (Line(points={{130,-29},{130,200},{240,200}}, color={0,0,127}));
  connect(port_CCW_inlet, coi2.port_a1) annotation (Line(points={{80,-260},{80,
          -70},{32,-70},{32,-50}}, color={0,127,255}));
  connect(port_CCW_outlet, coi2.port_b1) annotation (Line(points={{40,-260},{40,
          -80},{28,-80},{28,-50}}, color={0,127,255}));
  connect(port_HHW_inlet, coi1.port_a1) annotation (Line(points={{-40,-260},{-40,
          -80},{-48,-80},{-48,-50}}, color={0,127,255}));
  connect(port_HHW_outlet, coi1.port_b1) annotation (Line(points={{-80,-260},{-80,
          -80},{-52,-80},{-52,-50}}, color={0,127,255}));
  connect(port_OA_exhaust1, eco.port_Exh) annotation (Line(points={{-220,40},{-150,
          40},{-150,-44},{-120,-44}}, color={0,127,255}));
  connect(port_OA_inlet1, eco.port_Out) annotation (Line(points={{-220,-40},{-160,
          -40},{-160,-36},{-120,-36}}, color={0,127,255}));
  connect(uOA, eco.uEco) annotation (Line(points={{-120,280},{-120,0},{-110,0},
          {-110,-28}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end FCU;
