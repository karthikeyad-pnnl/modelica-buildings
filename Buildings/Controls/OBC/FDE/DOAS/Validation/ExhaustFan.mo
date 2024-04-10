within Buildings.Controls.OBC.FDE.DOAS.Validation;
model ExhaustFan "This model simulates ExhaustFanController"

  parameter Real dPSetBui(
  final unit = "Pa",
  final quantity = "PressureDifference") = 15
  "Building static pressure difference set point";

  parameter Real kExhFan(
  final unit = "1") = 0.5
  "PID heating loop gain value.";

  parameter Real TiExhFan(
  final unit = "s") = 60
  "PID loop time constant of integrator.";

  parameter Real TdExhFan(
  final unit= "s") = 0.1 "Time constant of derivative block";

   parameter CDL.Types.SimpleController controllerTypeExhFan=Buildings.Controls.OBC.CDL.Types.SimpleController.PI
    "Type of controller";

  Buildings.Controls.OBC.CDL.Logical.TrueDelay truDel(
    delayTime=10,
    delayOnInit=true)
    "Simulates delay between fan start command and status feedback."
      annotation (Placement(transformation(extent={{14,-40},{34,-20}})));

  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse SFproof(
    width=0.75,
    period=5760)
      annotation (Placement(transformation(extent={{-34,8},{-14,28}})));

  Buildings.Controls.OBC.CDL.Reals.Sources.Sin bldgSP(
    amplitude=3,
    freqHz=1/3280,
    offset=15)
    annotation (Placement(transformation(extent={{-34,-26},{-14,-6}})));

  Buildings.Controls.OBC.FDE.DOAS.ExhaustFan EFcon(
    dPSetBui=dPSetBui,
    kExhFan=kExhFan,
    TiExhFan=TiExhFan,
    TdExhFan=TdExhFan,
    controllerTypeExhFan=controllerTypeExhFan)
    annotation (Placement(transformation(extent={{44,-12},{64,8}})));
equation

  connect(SFproof.y, EFcon.uFanSupPro) annotation (Line(points={{-12,18},{16,18},
          {16,4},{42,4}}, color={255,0,255}));
  connect(bldgSP.y, EFcon.dPAirStaBui) annotation (Line(points={{-12,-16},{16,-16},
          {16,-8.4},{42,-8.4}}, color={0,0,127}));
  connect(truDel.y, EFcon.uFanExhPro) annotation (Line(points={{36,-30},{38,-30},
          {38,-2},{42,-2}}, color={255,0,255}));
  connect(EFcon.yExhFanSta, truDel.u) annotation (Line(points={{66,4},{74,4},{74,
          -64},{-2,-64},{-2,-30},{12,-30}}, color={255,0,255}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={Ellipse(lineColor = {75,138,73},fillColor={255,255,255},
            fillPattern=
FillPattern.Solid,extent={{-100,-100},{100,100}}),Polygon(lineColor = {0,0,255},fillColor = {75,138,73}, pattern = LinePattern.None,
            fillPattern=
FillPattern.Solid,points={{-36,60},{64,0},{-36,-60},{-36,60}})}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
<li>
September 14, 2020, by Henry Nickels:</br>
First implementation.</li>
</ul>
</html>", info="<html>
<p>
This example simulates
<a href=\"modelica://Buildings.Controls.OBC.FDE.DOAS.ExhaustFanController\">
Buildings.Controls.OBC.FDE.DOAS.ExhaustFanController</a>.
</p>
</html>"),
    experiment(StopTime=5760, __Dymola_Algorithm="Dassl"),
    __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Controls/OBC/FDE/DOAS/Validation/ExhaustFan.mos"
    "Simulate and plot"));
end ExhaustFan;
