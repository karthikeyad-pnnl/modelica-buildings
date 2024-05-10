within Buildings.Controls.OBC.FDE.DOAS.Validation;
model SupplyTemperatureSetpoint "This model simulates TSupSet"

  parameter Real TSupLowSet(
   final unit="K",
   final displayUnit="degC",
   final quantity="ThermodynamicTemperature")=273.15+20
   "Minimum primary supply air temperature reset value";

  parameter Real TSupHigSet(
   final unit="K",
   final displayUnit="degC",
   final quantity="ThermodynamicTemperature")=273.15+24
   "Maximum primary supply air temperature reset value";

  parameter Real THigZon(
   final unit="K",
   final displayUnit="degC",
   final quantity="ThermodynamicTemperature")=273.15+25
   "Maximum zone temperature reset value";

  parameter Real TLowZon(
   final unit="K",
   final displayUnit="degC",
   final quantity="ThermodynamicTemperature")=273.15+21
   "Minimum zone temperature reset value";

  parameter Real TSupCooOff(
   final unit="K",
   final displayUnit="degC",
   final quantity="ThermodynamicTemperature")=2
   "Supply air temperature cooling set point offset.";

  parameter Real TSupHeaOff(
   final unit="K",
   final displayUnit="degC",
   final quantity="ThermodynamicTemperature")=2
   "Supply air temperature heating set point offset.";


  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse dehumMode(
  width=0.5,
  period=2880)
  annotation (Placement(transformation(extent={{-38,-6},{-18,14}})));

  CDL.Reals.Sources.Sin highSpaceTGen(
    amplitude=3,
    freqHz=1/3600,
    offset=296,
    startTime=1250)
    annotation (Placement(transformation(extent={{-40,-38},{-20,-18}})));
  Buildings.Controls.OBC.FDE.DOAS.SupplyTemperatureSetpoint TSupSetpt(
    TSupLowSet=TSupLowSet,
    TSupHigSet=TSupHigSet,
    THigZon=THigZon,
    TLowZon=TLowZon,
    TSupCooOff=TSupCooOff,
    TSupHeaOff=TSupHeaOff)
    annotation (Placement(transformation(extent={{16,-14},{36,6}})));
equation

  connect(dehumMode.y, TSupSetpt.uDehMod) annotation (Line(points={{-16,4},{-2,
          4},{-2,1},{14,1}}, color={255,0,255}));
  connect(highSpaceTGen.y, TSupSetpt.TAirHig) annotation (Line(points={{-18,-28},
          {-2,-28},{-2,-9},{14,-9}}, color={0,0,127}));
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
end SupplyTemperatureSetpoint;
