within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.SetPoints.Subsequences;
block CapacityRequirement
  "Cooling capacity requirement"

  parameter Real avePer(
    final unit="s",
    final quantity="Time",
    final displayUnit="h")=300
    "Time period for the rolling average";

  parameter Real holPer(
    final unit="s",
    final quantity="Time",
    final displayUnit="h")=900
    "Time period for the value hold at stage change";

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput chaPro
    "Stage change process status, true = on, false = off"
    annotation (Placement(transformation(extent={{-180,90},{-140,130}}),
        iconTransformation(extent={{-140,-100},{-100,-60}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput TChiWatSupSet(
    final unit="K",
    final quantity="ThermodynamicTemperature")
    "Chilled water supply temperature setpoint"
    annotation (Placement(transformation(extent={{-180,-10},{-140,30}}),
        iconTransformation(extent={{-140,70},{-100,110}})));

protected
  constant Modelica.SIunits.Density rhoWat = 1000 "Water density";

  Buildings.Controls.OBC.CDL.Discrete.TriggeredSampler triSam
    "Triggered sampler"
    annotation (Placement(transformation(extent={{-40,120},{-20,140}})));

  Buildings.Controls.OBC.CDL.Logical.TrueFalseHold truFalHol(
    final trueHoldDuration=holPer,
    final falseHoldDuration=0) "True hold"
    annotation (Placement(transformation(extent={{-40,70},{-20,90}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant minLim(
    final k=0)
    "Minimum capacity requirement limit"
    annotation (Placement(transformation(extent={{60,-30},{80,-10}})));

  Buildings.Controls.OBC.CDL.Continuous.Add add2(
    final k1=-1) "Adder"
    annotation (Placement(transformation(extent={{-80,-30},{-60,-10}})));

equation
   connect(VChiWat_flow, pro2.u1) annotation (Line(points={{-160,-130},{-130,-130},
          {-130,-74},{-22,-74}}, color={0,0,127}));
  connect(max.u1, minLim.y) annotation (Line(points={{98,-64},{90,-64},{90,-20},
          {82,-20}}, color={0,0,127}));
  connect(movMea.y, max.u2) annotation (Line(points={{82,-70},{90,-70},{90,-76},
          {98,-76}}, color={0,0,127}));
  connect(max.y, triSam.u) annotation (Line(points={{122,-70},{130,-70},{130,20},
          {-60,20},{-60,130},{-42,130}}, color={0,0,127}));
  connect(chaPro, edg.u)
    annotation (Line(points={{-160,110},{-102,110}}, color={255,0,255}));
  connect(edg.y, triSam.trigger) annotation (Line(points={{-78,110},{-30,110},{
          -30,118.2}},
                  color={255,0,255}));
  connect(truFalHol.y, swi.u2) annotation (Line(points={{-18,80},{40,80},{40,
          130},{78,130}}, color={255,0,255}));
  annotation (...removed as used in testing a python script),
Documentation(info="<html>
<p>
Unit specification rename script.
</p>
</html>",
revisions="<html>
<ul>
<li>
May 29, 2020, by Milica Grahovac:<br/>
Test file
</li>
</ul>
</html>"));
end CapacityRequirement;