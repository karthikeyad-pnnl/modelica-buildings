within Buildings.Controls.OBC.ASHRAE.G36_PR1.BoilerPlant.SetPoints.Validation;
model BypassValvePosition
  Buildings.Controls.OBC.ASHRAE.G36_PR1.BoilerPlant.SetPoints.BypassValvePosition
    bypassValvePosition(Ti=2)
    annotation (Placement(transformation(extent={{-52,-10},{-32,10}})));
  CDL.Logical.Sources.Pulse booPul(period=30, startTime=1)
    annotation (Placement(transformation(extent={{-90,-40},{-70,-20}})));
  CDL.Continuous.Sources.Constant con(k=1.5)
    annotation (Placement(transformation(extent={{-90,20},{-70,40}})));
  CDL.Continuous.Sources.Sine sin(
    amplitude=0.5,
    freqHz=0.1,
    offset=1.5,
    startTime=1)
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
equation
  connect(booPul.y, bypassValvePosition.uPumProSig_a) annotation (Line(points={
          {-68,-30},{-62,-30},{-62,-2},{-54,-2}}, color={255,0,255}));
  connect(con.y, bypassValvePosition.boiMinFloSet) annotation (Line(points={{
          -68,30},{-62,30},{-62,6},{-54,6}}, color={0,0,127}));
  connect(sin.y, bypassValvePosition.priCirFloRat)
    annotation (Line(points={{-68,0},{-62,0},{-62,2},{-54,2}},
                                               color={0,0,127}));
  annotation (
  Documentation(info="<html>
<p>
This example validates
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.G36_PR1.BoilerPlant.Setpoints.BypassValvePosition\">
Buildings.Controls.OBC.ASHRAE.G36_PR1.BoilerPlant.Setpoints.BypassValvePosition</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
February 21, 2020, by Karthik Devaprasad:<br/>
First implementation.
</li>
</ul>
</html>"),
  Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent={{-100,-100},{100,100}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points={{-36,60},{64,0},{-36,-60},{-36,60}})}),  Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end BypassValvePosition;
