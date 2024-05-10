within Buildings.Controls.OBC.FDE.DOAS.Validation;
model DehumMode "This model simulates DehumMode."

  parameter Real dehumSet(
    final min=0,
    final max=100)=60
   "Dehumidification set point.";

  parameter Real timThrDehDis(
    final unit="s",
    final quantity="Time")=600
    "Continuous time period for which measured relative humidity needs to fall below relative humidity threshold before dehumidification mode is disabled";

  parameter Real timDelDehEna(
    final unit="s",
    final quantity="Time")=120
    "Continuous time period for which supply fan needs to be on before enabling dehumidifaction mode";

  parameter Real timThrDehEna(
    final unit="s",
    final quantity="Time")=5
    "Continuous time period for which relative humidity rises above set point before dehumidifcation mode is enabled";

  Buildings.Controls.OBC.FDE.DOAS.DehumMode DehumMod(
    dehumSet=dehumSet,
    timThrDehDis=timThrDehDis,
    timDelDehEna=timDelDehEna,
    timThrDehEna=timThrDehEna)
    annotation (Placement(visible = true, transformation(origin = {-2, 0}, extent = {{24, -10}, {44, 10}}, rotation = 0)));

  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse SFproof(
    width=0.75,
    period=5760)
    annotation (Placement(transformation(extent={{-28,-36},{-8,-16}})));

  Buildings.Controls.OBC.CDL.Reals.Sources.Sin relHumGen(
    amplitude=10,
    freqHz=1/3600,
    phase=0,
    offset=60,
    startTime=1250)
    annotation (Placement(transformation(extent={{-28,2},{-8,22}})));

equation

  connect(SFproof.y, DehumMod.uFanSupPro) annotation (Line(points={{-6,-26},{8,
          -26},{8,7.2},{19.8,7.2}}, color={255,0,255}));

  connect(relHumGen.y, DehumMod.phiAirRet)
    annotation (Line(points={{-6,12},{8,12},{8,0},{19.8,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent={{-100,-100},{100,100}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points={{-36,60},{64,0},{-36,-60},{-36,60}})}), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
<li>
September 15, 2020, by Henry Nickels:</br>
First implementation.</li>
</ul>
</html>", info="<html>
<p>
This example simulates
<a href=\"modelica://Buildings.Controls.OBC.FDE.DOAS.DehumMode\">
Buildings.Controls.OBC.FDE.DOAS.DehumMode</a>.
</p>
</html>"),__Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Controls/OBC/FDE/DOAS/Validation/DehumMode.mos"
    "Simulate and plot"));
end DehumMode;
