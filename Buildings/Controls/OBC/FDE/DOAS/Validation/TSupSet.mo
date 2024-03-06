within Buildings.Controls.OBC.FDE.DOAS.Validation;
model TSupSet "This model simulates TSupSet"

  parameter Real loPriT(
   final unit="K",
   final displayUnit="degC",
   final quantity="ThermodynamicTemperature")=273.15+20
   "Minimum primary supply air temperature reset value";

  parameter Real hiPriT(
   final unit="K",
   final displayUnit="degC",
   final quantity="ThermodynamicTemperature")=273.15+24
   "Maximum primary supply air temperature reset value";

  parameter Real hiZonT(
   final unit="K",
   final displayUnit="degC",
   final quantity="ThermodynamicTemperature")=273.15+25
   "Maximum zone temperature reset value";

  parameter Real loZonT(
   final unit="K",
   final displayUnit="degC",
   final quantity="ThermodynamicTemperature")=273.15+21
   "Minimum zone temperature reset value";

  parameter Real cooAdj(
   final unit="K",
   final displayUnit="degC",
   final quantity="ThermodynamicTemperature")=2
   "Supply air temperature cooling set point offset.";

  parameter Real heaAdj(
   final unit="K",
   final displayUnit="degC",
   final quantity="ThermodynamicTemperature")=2
   "Supply air temperature heating set point offset.";


  Buildings.Controls.OBC.FDE.DOAS.TSupSet tSupSet
    annotation (Placement(transformation(extent={{22,-10},{42,10}})));

  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse dehumMode(
  width=0.5,
  period=2880)
  annotation (Placement(transformation(extent={{-44,-32},{-24,-12}})));

  CDL.Reals.Sources.Sin highSpaceTGen(
    amplitude=3,
    freqHz=1/3600,
    offset=296,
    startTime=1250)
    annotation (Placement(transformation(extent={{-44,6},{-24,26}})));
equation

  connect(dehumMode.y, tSupSet.dehumMode) annotation (
  Line(points={{-22,-22},{-2,-22},{-2,5},{20,5}},   color={255,0,255}));

  connect(highSpaceTGen.y, tSupSet.highSpaceT) annotation (Line(points={{-22,16},
          {-6,16},{-6,14},{12,14},{12,-5},{20,-5}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Ellipse(lineColor = {75,138,73},
fillColor={255,255,255},
            fillPattern=
FillPattern.Solid,extent={{-100,-100},{100,100}}),Polygon(lineColor = {0,0,255},
fillColor = {75,138,73},pattern = LinePattern.None,
             fillPattern=
FillPattern.Solid,points={{-36,60},{64,0},{-36,-60},{-36,60}})}),
Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=5760, __Dymola_Algorithm="Dassl"),
    Documentation(revisions="<html>
<ul>
<li>
September 14, 2020, by Henry Nickels:</br>
First implementation.</li>
</ul>
</html>", info="<html>
<p>
This example simulates
<a href=\"modelica://Buildings.Controls.OBC.FDE.DOAS.TSupSet\">
Buildings.Controls.OBC.FDE.DOAS.TSupSet</a>.
</p>
</html>"),__Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Controls/OBC/FDE/DOAS/Validation/TSupSet.mos"
    "Simulate and plot"));
end TSupSet;
