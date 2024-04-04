within Buildings.Controls.OBC.FDE.DOAS.Validation;
model EnergyWheel "This model simulates EnergyWheel."

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
  final unit = "1") = 0.00001
  "PID heating loop gain value.";

  parameter Real TiEneWheHea(
  final unit = "s") = 0.00025
  "PID  heating loop time constant of integrator.";

  parameter Real TdEneWheHea(
  final unit = "s") = 0.1
  "PID heatig loop time constant of derivative block";

  parameter Real kEneWheCoo(
  final unit = "1") = 0.00001
  "PID cooling loop gain value.";

  parameter Real TiEneWheCoo(
  final unit = "s") = 0.00025 "PID cooling loop time constant of integrator.";

  parameter CDL.Types.SimpleController controllerTypeEneWheCoo=Buildings.Controls.OBC.CDL.Types.SimpleController.PI
  "PI controller for cooling loop";

  parameter Real TdEneWheCoo(
  final unit = "s") = 0.1
  "PID cooling loop time constant of derivative block";

  Buildings.Controls.OBC.FDE.DOAS.EnergyWheel ERWcon(
    dTThrEneRec=dTThrEneRec,
    dThys=dThys,
    timDelEneRec=timDelEneRec,
    controllerTypeEneWheHea=controllerTypeEneWheHea,
    kEneWheHea=kEneWheHea,
    TiEneWheHea=TiEneWheHea,
    TdEneWheHea=TdEneWheHea,
    kEneWheCoo=kEneWheCoo,
    TiEneWheCoo=TiEneWheCoo,
    controllerTypeEneWheCoo=controllerTypeEneWheCoo,
    TdEneWheCoo=TdEneWheCoo)
    annotation (Placement(transformation(extent={{50,-10},{70,10}})));

  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse SFproof(
    width=0.75,
    period=5760)
    annotation (Placement(transformation(extent={{-62,72},{-42,92}})));

  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse ecoMode(
    width=0.5,
    period=2880)
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
    startTime=0)
    annotation (Placement(transformation(extent={{-62,-30},{-42,-10}})));
  CDL.Reals.Sources.Sin erwTGen(
    amplitude=6,
    freqHz=1/2100,
    offset=294,
    startTime=12)
    annotation (Placement(transformation(extent={{-62,-62},{-42,-42}})));
  CDL.Reals.Sources.Sin supPrimGen(
    amplitude=2,
    freqHz=1/3100,
    offset=295,
    startTime=12)
    annotation (Placement(transformation(extent={{-62,-94},{-42,-74}})));
equation
  connect(SFproof.y, ERWcon.uFanSupPro) annotation (
  Line(points={{-40,82},{4,82},{4,7.8},{47.8,7.8}}, color={255,0,255}));

  connect(ecoMode.y, ERWcon.uEcoMod) annotation (
    Line(points={{-40,50},{0,50},{0,4.8},{47.8,4.8}}, color={255,0,255}));

  connect(raTGen.y, ERWcon.TAirRet) annotation (Line(points={{-40,14},{-20,14},{-20,
          1.8},{47.8,1.8}}, color={0,0,127}));
  connect(oaTGen.y, ERWcon.TAirOut) annotation (Line(points={{-40,-20},{-18,-20},{
          -18,-2},{47.8,-2},{47.8,-1.8}}, color={0,0,127}));
  connect(erwTGen.y, ERWcon.TAirSupEneWhe) annotation (Line(points={{-40,-52},{-22,-52},
          {-22,-32},{-6,-32},{-6,-4.8},{47.8,-4.8}}, color={0,0,127}));
  connect(supPrimGen.y, ERWcon.TAirSupSetEneWhe) annotation (Line(points={{-40,-84},{
          -10,-84},{-10,-52},{10,-52},{10,-7.8},{47.8,-7.8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Ellipse(lineColor = {75,138,73},
fillColor={255,255,255},
            fillPattern=
FillPattern.Solid, extent={{-100,-100},{100,100}}),
Polygon(lineColor = {0,0,255},fillColor = {75,138,73}, pattern = LinePattern.None,
              fillPattern=
FillPattern.Solid,points={{-36,60},{64,0},{-36,-60},{-36,60}})}),
Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=5760, __Dymola_Algorithm="Dassl"),
    Documentation(revisions="<html>
<ul>
<li>
September 16, 2020, by Henry Nickels:</br>
First implementation.</li>
</ul>
</html>", info="<html>
<p>
This example simulates
<a href=\"modelica://Buildings.Controls.OBC.FDE.DOAS.EnergyWheel\">
Buildings.Controls.OBC.FDE.DOAS.EnergyWheel</a>.
</p>
</html>"),
    __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Controls/OBC/FDE/DOAS/Validation/EnergyWheel.mos"
    "Simulate and plot"));
end EnergyWheel;
