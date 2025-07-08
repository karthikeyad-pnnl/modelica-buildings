within Buildings.Controls.OBC.FDE.DOAS.Subsequences.Validation;
model CoolingCoil "This model simulates CoolingCoil"
  Buildings.Controls.OBC.FDE.DOAS.Subsequences.CoolingCoil conCoiCoo
    "Cooling coil controller"
    annotation (Placement(transformation(extent={{52,-10},{72,10}})));
  parameter Real erwDPadj(
    final unit = "K",
    final quantity = "TemperatureDifference") = 5
    "Value subtracted from ERW supply air dewpoint.";
  parameter CDL.Types.SimpleController controllerTypeDeh=Buildings.Controls.OBC.CDL.Types.SimpleController.PI
    "PID controller for cooling air in dehumidification mode";
  parameter Real kDeh(
    final unit="1") = 1
    "Gain of conPIDDeh controller";
  parameter Real TiDeh(
    final unit="s",
    final quantity="Time") = 60
    "Time constant of integrator block for conPIDDeh controller";
  parameter Real TdDeh(
    final unit="s",
    final quantity="Time") = 0.1
    "Time constant of derivative block for conPIDDeh controller";
  parameter CDL.Types.SimpleController controllerTypeRegOpe=Buildings.Controls.OBC.CDL.Types.SimpleController.PI
    "PID controller for regular cooling coil operation mode";
  parameter Real kRegOpe(
    final unit="1") = 1
    "Gain of conPIDRegOpe controller";
  parameter Real TiRegOpe(
    final unit="s",
    final quantity="Time")=60
    "Time constant of integrator block for conPIDRegOpe controller";
  parameter Real TdRegOpe(
    final unit="s",
    final quantity="Time")=0.1
    "Time constant of derivative block for conPIDRegOpe controller";
  parameter Real dehumSet(
    final quantity ="RelativeDensity",
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
    width=0.8,
    period=5760,
    shift=300) "Supply fan signal"
    annotation (Placement(transformation(extent={{-62,60},{-42,80}})));
   Buildings.Controls.OBC.CDL.Reals.Sources.Sin saTGen(
    amplitude=3,
    freqHz=1/4800,
    phase=0.87266462599716,
    offset=295,
    startTime=0) "Supply air temperture"
    annotation (Placement(transformation(extent={{-26,40},{-6,60}})));
   Buildings.Controls.OBC.CDL.Reals.Sources.Sin TCoiCoo(
    amplitude=3,
    freqHz=1/4800,
    phase=0,
    offset=293,
    startTime=0) "Cooling coil temperature signal"
    annotation (Placement(transformation(extent={{-60,-28},{-40,-8}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse dehumMode(
    width=0.5,
    period=4700,
    shift=1000) "Dehumidification mode enable signal"
    annotation (Placement(transformation(extent={{-26,-6},{-6,14}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Sin supCooGen(
    amplitude=2,
    freqHz=1/3100,
    offset=293,
    startTime=12) "Cooling setpoint"
    annotation (Placement(transformation(extent={{-62,16},{-42,36}})));
   Buildings.Controls.OBC.CDL.Reals.Sources.Sin erwTGen(
    amplitude=3,
    freqHz=1/4800,
    phase=0,
    offset=294,
    startTime=0)
    "Dry bulb temperature of air conditioned by energy recovery wheel"
    annotation (Placement(transformation(extent={{-60,-66},{-40,-46}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Sin erwHumGen(
    amplitude=0.25,
    freqHz=1/3600,
    offset=0.5,
    startTime=1250)
    "Relative humidity of air conditioned by the energy recovery wheel"
    annotation (Placement(transformation(extent={{-26,-48},{-6,-28}})));
equation
  connect(SFproof.y, conCoiCoo.uFanSupPro) annotation (Line(points={{-40,70},{
          44,70},{44,16},{42,16},{42,8},{50,8}}, color={255,0,255}));
  connect(saTGen.y, conCoiCoo.TAirSup)
    annotation (Line(points={{-4,50},{40,50},{40,6},{50,6}}, color={0,0,127}));
  connect(supCooGen.y, conCoiCoo.TAirSupSetCoo) annotation (Line(points={{-40,
          26},{48,26},{48,16},{50,16},{50,4}}, color={0,0,127}));
  connect(dehumMode.y, conCoiCoo.uDeh)
    annotation (Line(points={{-4,4},{40,4},{40,0},{50,0}}, color={255,0,255}));
  connect(TCoiCoo.y, conCoiCoo.TAirDis) annotation (Line(points={{-38,-18},{38,
          -18},{38,-6},{48,-6},{48,-2},{50,-2}}, color={0,0,127}));
  connect(erwHumGen.y, conCoiCoo.phiAirEneRecWhe) annotation (Line(points={{-4,
          -38},{40,-38},{40,-4},{50,-4}}, color={0,0,127}));
  connect(erwTGen.y, conCoiCoo.TAirEneRecWhe) annotation (Line(points={{-38,-56},
          {48,-56},{48,-14},{50,-14},{50,-6.2}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={Ellipse(lineColor = {75,138,73},
fillColor={255,255,255},
            fillPattern=
FillPattern.Solid,extent={{-100,-100},{100,100}}),
Polygon(lineColor = {0,0,255},fillColor = {75,138,73},
pattern = LinePattern.None,
            fillPattern=
FillPattern.Solid,
points={{-36,60},{64,0},{-36,-60},{-36,60}}),                                                            Text(textColor = {28, 108, 200}, extent={{-102,
              170},{98,90}},                                                                                                                                               textString = "%name", textStyle = {TextStyle.Bold})}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
<li>
September 20, 2020, by Henry Nickels:</br>
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
<a href=\"modelica://Buildings.Controls.OBC.FDE.DOAS.Subsequences.CoolingCoil\">
Buildings.Controls.OBC.FDE.DOAS.Subsequences.CoolingCoil</a>.
</p>
</html>"),
    experiment(StopTime=5760, __Dymola_Algorithm="Dassl"),
    __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Controls/OBC/FDE/DOAS/Subsequences/Validation/CoolingCoil.mos"
    "Simulate and plot"));
end CoolingCoil;
