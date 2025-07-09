within Buildings.Controls.OBC.FDE.DOAS.Subsequences.Validation;
model SupplyTemperatureSetpoint "This model simulates TSupSet"
  Buildings.Controls.OBC.FDE.DOAS.Subsequences.SupplyTemperatureSetpoint TSupSetpt(
    TSupLowSet=TSupLowSet,
    TSupHigSet=TSupHigSet,
    THigZon=THigZon,
    TLowZon=TLowZon,
    TSupCooOff=TSupCooOff,
    TSupHeaOff=TSupHeaOff) "Supply temperature setpoint controller"
    annotation (Placement(transformation(extent={{16,-14},{36,6}})));
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
    period=2880) "Dehumidifcation mode enable signal"
    annotation (Placement(transformation(extent={{-38,-6},{-18,14}})));

  CDL.Reals.Sources.Sin highSpaceTGen(
    amplitude=3,
    freqHz=1/3600,
    offset=296,
    startTime=1250) "Highest space generation from all terminal units"
    annotation (Placement(transformation(extent={{-40,-38},{-20,-18}})));
  CDL.Reals.Sources.Constant TCooSetPoi(
    k=296)
    "Zone cooling setpoint"
    annotation (Placement(transformation(extent={{-74,-8},{-54,12}})));
  CDL.Reals.Sources.Constant THeaSetPoi(
    k=294)
    "Zone heating setpoint"
    annotation (Placement(transformation(extent={{-68,-76},{-48,-56}})));

equation

  connect(dehumMode.y, TSupSetpt.uDehMod) annotation (Line(points={{-16,4},{-2,4},
          {-2,2},{14,2}},    color={255,0,255}));
  connect(highSpaceTGen.y, TSupSetpt.TAirHig) annotation (Line(points={{-18,-28},
          {-2,-28},{-2,-6},{14,-6}}, color={0,0,127}));
  connect(TCooSetPoi.y, TSupSetpt.TZonCooSet) annotation (Line(points={{-52,2},{
          -42,2},{-42,-10},{-4,-10},{-4,-2},{14,-2}}, color={0,0,127}));
  connect(THeaSetPoi.y, TSupSetpt.TZonHeaSet) annotation (Line(points={{-46,-66},
          {6,-66},{6,-10},{14,-10}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Ellipse(lineColor = {75,138,73},
fillColor={255,255,255},
            fillPattern=
FillPattern.Solid,extent={{-100,-100},{100,100}}),Polygon(lineColor = {0,0,255},
fillColor = {75,138,73},pattern = LinePattern.None,
             fillPattern=
FillPattern.Solid,points={{-36,60},{64,0},{-36,-60},{-36,60}}),                                          Text(textColor = {28, 108, 200}, extent={{-108,
              164},{92,84}},                                                                                                                                               textString = "%name", textStyle = {TextStyle.Bold})}),
Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=5760,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"),
    Documentation(revisions="<html>
<ul>
<li>
September 14, 2020, by Henry Nickels:</br>
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
<a href=\"modelica://Buildings.Controls.OBC.FDE.DOAS.TSupSet\">
Buildings.Controls.OBC.FDE.DOAS.TSupSet</a>.
</p>
</html>"),__Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Controls/OBC/FDE/DOAS/Subsequences/Validation/TSupSet.mos"
    "Simulate and plot"));
end SupplyTemperatureSetpoint;
