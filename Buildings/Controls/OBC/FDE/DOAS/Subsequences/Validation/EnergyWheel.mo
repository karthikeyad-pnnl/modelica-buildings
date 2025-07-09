within Buildings.Controls.OBC.FDE.DOAS.Subsequences.Validation;
model EnergyWheel "This model simulates EnergyWheel."
  Buildings.Controls.OBC.FDE.DOAS.Subsequences.EnergyWheel ERWcon
    "Economizer mode controller"
    annotation (Placement(transformation(extent={{14,-12},{34,8}})));
  parameter Real dTThrEneRec(
    final unit = "K",
    final displayUnit = "degC",
    final quantity = "ThermodynamicTemperature") = 7
    "Absolute temperature difference threshold between outdoor air and return air temperature above which energy recovery is enabled";
  parameter Real dThys(
    final unit = "K",
    final displayUnit = "degC",
    final quantity = "ThermodynamicTemperature") = 0.5
    "Delay time period after temperature difference threshold is crossed for enabling energy recovery mode";
  parameter Real timDelEneRec(
    final unit = "s",
    final quantity = "Time") = 300
    "Minimum delay after OAT/RAT delta falls below set point.";
  parameter CDL.Types.SimpleController controllerTypeEneWheHea=Buildings.Controls.OBC.CDL.Types.SimpleController.PI
    "PI controller for heating loop";
  parameter Real kEneWheHea(
    final unit = "1") = 0.5
    "PID heating loop gain value.";
  parameter Real TiEneWheHea(
    final unit = "s",
    final quantity = "Time") = 60
    "PID  heating loop time constant of integrator.";
  parameter Real TdEneWheHea(
    final unit = "s",
    final quantity = "Time") = 0.1
    "PID heatig loop time constant of derivative block";
  parameter Real kEneWheCoo(
    final unit = "1") = 0.5
    "PID cooling loop gain value.";
  parameter Real TiEneWheCoo(
    final unit = "s",
    final quantity = "Time") = 60
    "PID cooling loop time constant of integrator.";
  parameter CDL.Types.SimpleController controllerTypeEneWheCoo=Buildings.Controls.OBC.CDL.Types.SimpleController.PI
    "PI controller for cooling loop";
  parameter Real TdEneWheCoo(
    final unit = "s",
    final quantity = "Time") = 0.1
    "PID cooling loop time constant of derivative block";
  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse SFproof(
    width=0.75,
    period=5760) "Supply fan enable signal"
    annotation (Placement(transformation(extent={{-62,72},{-42,92}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse ecoMode(
    width=0.5,
    period=2880) "Economizer mode enable signal"
    annotation (Placement(transformation(extent={{-62,40},{-42,60}})));
  CDL.Reals.Sources.Sin raTGen(
    amplitude=2,
    freqHz=1/4800,
    phase=0.034906585039887,
    offset=297,
    startTime=0)
    annotation (Placement(transformation(extent={{-62,4},{-42,24}})));
  CDL.Reals.Sources.Sin oaTGen(
    amplitude=2,
    freqHz=1/4800,
    offset=288,
    startTime=0) "Outdoor air temperature"
    annotation (Placement(transformation(extent={{-62,-30},{-42,-10}})));
  CDL.Reals.Sources.Sin erwTGen(
    amplitude=6,
    freqHz=1/2100,
    offset=294,
    startTime=12) "Energy recovery wheel supply air temperature"
    annotation (Placement(transformation(extent={{-62,-62},{-42,-42}})));
  CDL.Reals.Sources.Sin supPrimGen(
    amplitude=2,
    freqHz=1/3100,
    offset=295,
    startTime=12) "Primary supply air temperature setpoint"
    annotation (Placement(transformation(extent={{-62,-94},{-42,-74}})));
equation
  connect(SFproof.y, ERWcon.uFanSupPro) annotation (Line(points={{-40,82},{4,82},
          {4,6},{12,6}}, color={255,0,255}));
  connect(ecoMode.y, ERWcon.uEcoMod) annotation (Line(points={{-40,50},{2,50},{
          2,4},{12,4}}, color={255,0,255}));
  connect(raTGen.y, ERWcon.TAirRet) annotation (Line(points={{-40,14},{-2,14},{
          -2,0},{12,0}}, color={0,0,127}));
  connect(oaTGen.y, ERWcon.TAirOut) annotation (Line(points={{-40,-20},{4,-20},
          {4,-4},{12,-4}}, color={0,0,127}));
  connect(erwTGen.y, ERWcon.TAirSupEneWhe) annotation (Line(points={{-40,-52},{
          -26,-52},{-26,-6},{12,-6}}, color={0,0,127}));
  connect(supPrimGen.y, ERWcon.TAirSupSetEneWhe)
    annotation (Line(points={{-40,-84},{12,-84},{12,-10}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Ellipse(lineColor = {75,138,73},
fillColor={255,255,255},
            fillPattern=
FillPattern.Solid, extent={{-100,-100},{100,100}}),
Polygon(lineColor = {0,0,255},fillColor = {75,138,73}, pattern = LinePattern.None,
              fillPattern=
FillPattern.Solid,points={{-36,60},{64,0},{-36,-60},{-36,60}}),                                          Text(textColor = {28, 108, 200}, extent={{-98,170},
              {102,90}},                                                                                                                                                   textString = "%name", textStyle = {TextStyle.Bold})}),
Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=7200,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"),
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
<a href=\"modelica://Buildings.Controls.OBC.FDE.DOAS.Subsequences.EnergyWheel\">
Buildings.Controls.OBC.FDE.DOAS.Subsequences.EnergyWheel</a>.
</p>
</html>"),
    __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Controls/OBC/FDE/DOAS/Subsequences/Validation/EnergyWheel.mos"
    "Simulate and plot"));
end EnergyWheel;
