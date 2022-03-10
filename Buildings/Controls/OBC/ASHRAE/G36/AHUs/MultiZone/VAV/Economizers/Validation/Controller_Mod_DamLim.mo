within Buildings.Controls.OBC.ASHRAE.G36.AHUs.MultiZone.VAV.Economizers.Validation;
model Controller_Mod_DamLim
  "Validation model for multi zone VAV AHU economizer operation: damper modulation and minimum ooutdoor air requirement damper position limits"

  Buildings.Controls.OBC.ASHRAE.G36.AHUs.MultiZone.VAV.Economizers.Controller eco(
    final minOADes=Buildings.Controls.OBC.ASHRAE.G36.Types.MultizoneAHUMinOADesigns.SeparateDamper_AFMS,
    final buiPreCon=Buildings.Controls.OBC.ASHRAE.G36.Types.BuildingPressureControlTypes.ReliefFan,
    final use_enthalpy=false) "Multi zone VAV AHU economizer"
    annotation (Placement(transformation(extent={{20,-20},{40,20}})));
  Buildings.Controls.OBC.ASHRAE.G36.AHUs.MultiZone.VAV.Economizers.Controller eco1(
    final minOADes=Buildings.Controls.OBC.ASHRAE.G36.Types.MultizoneAHUMinOADesigns.SeparateDamper_DP,
    final buiPreCon=Buildings.Controls.OBC.ASHRAE.G36.Types.BuildingPressureControlTypes.ReturnFanAir,
    final use_enthalpy=false) "Multi zone VAV AHU economizer"
    annotation (Placement(transformation(extent={{100,-60},{120,-20}})));

protected
  final parameter Real TOutCutoff(
    final unit="K",
    final displayUnit="degC",
    final quantity="ThermodynamicTemperature")=297.15
    "Outdoor temperature high limit cutoff";

  final parameter Real minVOutSet_flow(
    final unit="m3/s",
    final quantity="VolumeFlowRate")=0.71
    "Example volumetric airflow setpoint, 15cfm/occupant, 100 occupants";
  final parameter Real VOutMin_flow(
    final unit="m3/s",
    final quantity="VolumeFlowRate")=0.61
    "Minimal measured volumetric airflow";
  final parameter Real incVOutSet_flow(
    final unit="m3/s",
    final quantity="VolumeFlowRate")=(minVOutSet_flow - VOutMin_flow)*2.2
    "Maximum volumetric airflow increase during the example simulation";

  Buildings.Controls.OBC.CDL.Logical.Sources.Constant fanSta(final k=true)
    "Fan is on"
    annotation (Placement(transformation(extent={{-80,-110},{-60,-90}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant freProSta(
    final k=Buildings.Controls.OBC.ASHRAE.G36.Types.FreezeProtectionStages.stage0)
    "Freeze protection status is 0"
    annotation (Placement(transformation(extent={{-80,-150},{-60,-130}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant opeMod(
    final k=Buildings.Controls.OBC.ASHRAE.G36.Types.OperationModes.occupied)
    "AHU operation mode is Occupied"
    annotation (Placement(transformation(extent={{-120,-130},{-100,-110}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant TOutBelowCutoff(
    final k=TOutCutoff - 5) "Outdoor air temperature is slightly below the cutoff"
    annotation (Placement(transformation(extent={{-120,70},{-100,90}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant TOutCut1(
    final k=TOutCutoff) "OA temperature high limit cutoff"
    annotation (Placement(transformation(extent={{-120,30},{-100,50}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant VOutMinSet_flow(
    final k=minVOutSet_flow)
    "Outdoor airflow rate setpoint, example assumes 15cfm/occupant and 100 occupants"
    annotation (Placement(transformation(extent={{-80,90},{-60,110}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Ramp VOut_flow(
    final offset=VOutMin_flow,
    final duration=1800,
    final height=incVOutSet_flow) "Measured outdoor air volumetric airflow"
    annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Ramp uTSup(
    final duration=1800,
    final height=2,
    final offset=-1)
    "Supply air temperature control signal"
    annotation (Placement(transformation(extent={{-120,-50},{-100,-30}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Ramp outDamPos(
    final duration=1800,
    final height=0.7,
    final offset=0.1) "Outdoor damper position"
    annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Ramp supFanSpe(
    final duration=1800,
    final height=0.5,
    final offset=0.2) "Supply fan speed"
    annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Ramp dpDam2(
    final duration=1800,
    final offset=120,
    final height=52)  "Pressure accross outdoor air damper"
    annotation (Placement(transformation(extent={{-80,-70},{-60,-50}})));

equation
  connect(fanSta.y, eco.uSupFan) annotation (Line(points={{-58,-100},{-28,-100},
          {-28,-13},{18,-13}}, color={255,0,255}));
  connect(freProSta.y, eco.uFreProSta) annotation (Line(points={{-58,-140},{-20,
          -140},{-20,-19},{18,-19}}, color={255,127,0}));
  connect(opeMod.y, eco.uOpeMod) annotation (Line(points={{-98,-120},{-24,-120},
          {-24,-16},{18,-16}}, color={255,127,0}));
  connect(TOutBelowCutoff.y, eco.TOut) annotation (Line(points={{-98,80},{-20,80},
          {-20,-2},{18,-2}}, color={0,0,127}));
  connect(TOutCut1.y, eco.TOutCut) annotation (Line(points={{-98,40},{-24,40},{-24,
          -4},{18,-4}}, color={0,0,127}));
  connect(VOut_flow.y, eco.VOut_flow_normalized) annotation (Line(points={{-58,60},
          {-4,60},{-4,16},{18,16}}, color={0,0,127}));
  connect(VOutMinSet_flow.y, eco.VOutMinSet_flow_normalized) annotation (Line(
        points={{-58,100},{0,100},{0,19},{18,19}}, color={0,0,127}));
  connect(TOutBelowCutoff.y, eco1.TOut) annotation (Line(points={{-98,80},{76,80},
          {76,-42},{98,-42}}, color={0,0,127}));
  connect(TOutCut1.y, eco1.TOutCut) annotation (Line(points={{-98,40},{60,40},{60,
          -44},{98,-44}}, color={0,0,127}));
  connect(VOutMinSet_flow.y, eco1.VOutMinSet_flow_normalized) annotation (Line(
        points={{-58,100},{80,100},{80,-21},{98,-21}}, color={0,0,127}));
  connect(fanSta.y, eco1.uSupFan) annotation (Line(points={{-58,-100},{-28,-100},
          {-28,-53},{98,-53}}, color={255,0,255}));
  connect(freProSta.y, eco1.uFreProSta) annotation (Line(points={{-58,-140},{-20,
          -140},{-20,-59},{98,-59}}, color={255,127,0}));
  connect(opeMod.y, eco1.uOpeMod) annotation (Line(points={{-98,-120},{-24,-120},
          {-24,-56},{98,-56}}, color={255,127,0}));
  connect(uTSup.y, eco.uTSup) annotation (Line(points={{-98,-40},{0,-40},{0,4},{
          18,4}}, color={0,0,127}));
  connect(uTSup.y, eco1.uTSup) annotation (Line(points={{-98,-40},{0,-40},{0,-36},
          {98,-36}}, color={0,0,127}));
  connect(outDamPos.y, eco.uOutDamPos) annotation (Line(points={{-58,20},{-8,20},
          {-8,13},{18,13}}, color={0,0,127}));
  connect(supFanSpe.y, eco.uSupFanSpe) annotation (Line(points={{-98,0},{-12,0},
          {-12,10},{18,10}}, color={0,0,127}));
  connect(outDamPos.y, eco1.uOutDamPos) annotation (Line(points={{-58,20},{-8,20},
          {-8,-27},{98,-27}}, color={0,0,127}));
  connect(supFanSpe.y, eco1.uSupFanSpe) annotation (Line(points={{-98,0},{-12,0},
          {-12,-30},{98,-30}}, color={0,0,127}));
  connect(dpDam2.y, eco1.dpMinOutDam) annotation (Line(points={{-58,-60},{-32,-60},
          {-32,-33},{98,-33}}, color={0,0,127}));

annotation (
    experiment(StopTime=1800.0, Tolerance=1e-06),
    __Dymola_Commands(file=
          "modelica://Buildings/Resources/Scripts/Dymola/Controls/OBC/ASHRAE/G36/AHUs/MultiZone/VAV/Economizers/Validation/Controller_Mod_DamLim.mos"
        "Simulate and plot"),
    Icon(graphics={Ellipse(
          lineColor={75,138,73},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          extent={{-100,-100},{100,100}}), Polygon(
          lineColor={0,0,255},
          fillColor={75,138,73},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{-36,58},{64,-2},{-36,-62},{-36,58}})}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-140,-160},{
            140,140}}), graphics={
        Text(
          extent={{92,14},{140,-10}},
          lineColor={0,0,0},
          horizontalAlignment=TextAlignment.Left,
          textString="Economizer fully enabled -
validate damper position
and damper position limits
(example without
enthalpy measurement)"),
        Text(
          extent={{6,50},{56,28}},
          lineColor={0,0,0},
          horizontalAlignment=TextAlignment.Left,
          textString="Economizer fully enabled -
validate damper position
and damper position limits")}),
    Documentation(info="<html>
<p>
This example validates
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.G36.AHUs.MultiZone.VAV.Economizers.Controller\">
Buildings.Controls.OBC.ASHRAE.G36.AHUs.MultiZone.VAV.Economizers.Controller</a> control loops:
minimum outdoor air damper position limits control loop (<code>eco</code> block) and modulation
control loop (<code>eco1</code> block) for <code>VOut_flow</code> and <code>TSup</code> control signals.
Both control loops are enabled during the validation test.
</p>
</html>", revisions="<html>
<ul>
<li>
February 5, 2022, by Jianjun Hu:<br/>
First implementation.
</li>
</ul>
</html>"));
end Controller_Mod_DamLim;