within Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Staging;
block FailsafeCondition "Failsafe condition used in staging up and down"

  parameter Real samPer = 900
    "Sampling period for temperatures";

  Buildings.Controls.OBC.CDL.Interfaces.RealInput THotWatSupSet(
    final unit="K",
    final quantity="ThermodynamicTemperature")
    "Hot water supply temperature setpoint"
    annotation (Placement(transformation(extent={{-140,30},{-100,70}}),
        iconTransformation(extent={{-140,30},{-100,70}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput THotWatSup(
    final unit="K",
    final quantity="ThermodynamicTemperature") "Hot water supply temperature"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}}),
        iconTransformation(extent={{-140,-20},{-100,20}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput y "Failsafe condition for chiller staging"
    annotation (Placement(transformation(extent={{100,-20},{140,20}}),
        iconTransformation(extent={{100,-20},{140,20}})));

  CDL.Continuous.Add add2(k2=-1)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  CDL.Continuous.Hysteresis hys(uLow=TDiffSta - 1, uHigh=TDiffSta)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  CDL.Logical.TrueDelay truDel(delayTime=samPer, delayOnInit=true)
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  CDL.Interfaces.BooleanInput uAvaCur "Availability of current stage"
    annotation (Placement(transformation(extent={{-140,-70},{-100,-30}})));
  CDL.Logical.Or or2
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  CDL.Logical.Not not1
    annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
equation

  connect(add2.u2, THotWatSup) annotation (Line(points={{-82,-6},{-90,-6},{-90,
          0},{-120,0}},     color={0,0,127}));
  connect(add2.u1, THotWatSupSet) annotation (Line(points={{-82,6},{-90,6},{-90,
          50},{-120,50}}, color={0,0,127}));
  connect(add2.y, hys.u)
    annotation (Line(points={{-58,0},{-42,0}}, color={0,0,127}));
  connect(hys.y, truDel.u)
    annotation (Line(points={{-18,0},{-2,0}}, color={255,0,255}));
  connect(or2.y, y)
    annotation (Line(points={{62,0},{120,0}}, color={255,0,255}));
  connect(truDel.y, or2.u1)
    annotation (Line(points={{22,0},{38,0}}, color={255,0,255}));
  connect(not1.u, uAvaCur)
    annotation (Line(points={{-42,-50},{-120,-50}}, color={255,0,255}));
  connect(not1.y, or2.u2) annotation (Line(points={{-18,-50},{28,-50},{28,-8},{
          38,-8}}, color={255,0,255}));
annotation (defaultComponentName = "faiSafCon",
        Icon(coordinateSystem(extent={{-100,-80},{100,100}}),
             graphics={
        Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
        Text(
          extent={{-120,146},{100,108}},
          lineColor={0,0,255},
          textString="%name")}),
        Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}})),
Documentation(info="<html>
<p>Failsafe condition used in staging up and down, implemented according to the specification provided in section 5.2.4.15. 1711 March 2020 Draft. The subsequence applies to primary-only plants with and without a WSE. The sequence contains a boolean flag to differentiate between parallel and series chiller plants. </p>
</html>",
revisions="<html>
<ul>
<li>
January 21, 2019, by Milica Grahovac:<br/>
First implementation.
</li>
</ul>
</html>"));
end FailsafeCondition;
