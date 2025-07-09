within Buildings.Controls.OBC.FDE.DOAS.Subsequences.Validation;
model DehumidificationMode "This model simulates DehumidificationMode."
Buildings.Controls.OBC.FDE.DOAS.Subsequences.DehumidificationMode DehumMod(
    dehumSet=dehumSet,
    timThrDehDis=timThrDehDis,
    timDelDehEna=timDelDehEna,
    timThrDehEna=timThrDehEna) "Dehumidification mode controller"
    annotation (Placement(visible = true, transformation(origin = {-2, 0}, extent = {{24, -10}, {44, 10}}, rotation = 0)));
  parameter Real dehumSet(
    final quantity = "RelativeDensity",
    final unit ="1",
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
  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse SFproof(
    width=0.75,
    period=5760) "Supply fan enable signal"
    annotation (Placement(transformation(extent={{-28,-36},{-8,-16}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Sin relHumGen(
    amplitude=10,
    freqHz=1/3600,
    phase=0,
    offset=60,
    startTime=1250) "Return air relative humidity"
    annotation (Placement(transformation(extent={{-28,2},{-8,22}})));
equation
  connect(SFproof.y, DehumMod.uFanSupPro) annotation (Line(points={{-6,-26},{8,-26},
          {8,6},{20,6}},            color={255,0,255}));
  connect(relHumGen.y, DehumMod.phiAirRet)
    annotation (Line(points={{-6,12},{8,12},{8,0},{20,0}},   color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent={{-100,-100},{100,100}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points={{-36,60},{64,0},{-36,-60},{-36,60}}),                                            Text(textColor = {28, 108, 200}, extent={{-102,
              168},{98,88}},                                                                                                                                               textString = "%name", textStyle = {TextStyle.Bold})}),
                                                                Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
<li>
September 15, 2020, by Henry Nickels:</br>
First implementation.</li>

<li>
 June 12, 2025, by Cerrina Mouchref, Karthik Devaprasad:</br>
 Improved code as per library conventions. 
 </li>

</ul>
</html>
",        info="<html>
<p>
This example simulates
<a href=\"modelica://Buildings.Controls.OBC.FDE.DOAS.Subsequences.DehumidificationMode\">
Buildings.Controls.OBC.FDE.DOAS.Subsequences.DehumidificationMode</a>.
</p>
</html>"),__Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Controls/OBC/FDE/DOAS/Subsequences/Validation/DehumidificationMode.mos"
    "Simulate and plot"),
    experiment(
      StopTime=7200,
      Tolerance=1e-06));
end DehumidificationMode;
