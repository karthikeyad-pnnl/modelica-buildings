within Buildings.Controls.OBC.FDE.DOAS.Validation;
model EconomizerMode "This model simulates EconMode."

  parameter Real dTEcoThr(
  final unit = "K",
  final displayUnit = "degC",
  final quantity = "ThermodynamicTemperature") = 2
  "Threshold temperature difference between return air and outdoor air temperature above which economizer mode is enabled";



  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse                        SFproof(
  width=0.75,
  period=5760)
  annotation (Placement(transformation(extent={{-30,32},{-10,52}})));

  Buildings.Controls.OBC.CDL.Reals.Sources.Sin oaTGen(
    amplitude=5,
    freqHz=1/4800,
    offset=296,
    startTime=202)
    annotation (Placement(transformation(extent={{-28,-10},{-8,10}})));

  Buildings.Controls.OBC.CDL.Reals.Sources.Sin supCooSPgen(
    amplitude=5,
    freqHz=1/3600,
    offset=297,
    startTime=960)
    annotation (Placement(transformation(extent={{-28,-50},{-8,-30}})));

  Buildings.Controls.OBC.FDE.DOAS.EconomizerMode EconMod(dTEcoThr=dTEcoThr)
    annotation (Placement(transformation(extent={{42,-14},{62,6}})));
equation

  connect(SFproof.y, EconMod.uFanSupPro) annotation (Line(points={{-8,42},{6,42},
          {6,28},{24,28},{24,3},{39.8,3}}, color={255,0,255}));
  connect(oaTGen.y, EconMod.TAirOut) annotation (Line(points={{-6,0},{18,0},{18,
          -4},{39.8,-4}}, color={0,0,127}));
  connect(supCooSPgen.y, EconMod.TAirSupSetCoo) annotation (Line(points={{-6,-40},
          {10,-40},{10,-16},{30,-16},{30,-11},{39.8,-11}}, color={0,0,127}));
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
<a href=\"modelica://Buildings.Controls.OBC.FDE.DOAS.EconMode\">
Buildings.Controls.OBC.FDE.DOAS.EconimizerMode</a>.
</p>
</html>"),
    experiment(StopTime=5760, __Dymola_Algorithm="Dassl"),
    __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Controls/OBC/FDE/DOAS/Validation/EconomizerMode.mos"
    "Simulate and plot"));
end EconomizerMode;
