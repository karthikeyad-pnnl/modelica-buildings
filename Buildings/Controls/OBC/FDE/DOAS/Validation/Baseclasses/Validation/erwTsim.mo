within Buildings.Controls.OBC.FDE.DOAS.Validation.Baseclasses.Validation;
model erwTsim "This model simulates erwTsim"

  Buildings.Controls.OBC.FDE.DOAS.Validation.Baseclasses.erwTsim ERWtemp
    annotation (Placement(transformation(extent={{44,-10},{64,10}})));

  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse erwStartgen(width=0.6, period=2880)
    "Simulates ERW start command."
    annotation (Placement(transformation(extent={{-58,36},{-38,56}})));

  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse bypDamsim(width=0.5, period=2880)
    "Simulates bypass damper signal"
    annotation (Placement(transformation(extent={{-58,6},{-38,26}})));

  CDL.Reals.Sources.Sin raTGen(
    amplitude=2,
    freqHz=1/4800,
    offset=297,
    startTime=0)
    annotation (Placement(transformation(extent={{-58,-26},{-38,-6}})));
  CDL.Reals.Sources.Sin oaTGen(
    amplitude=2,
    freqHz=1/4800,
    offset=288,
    startTime=0)
    annotation (Placement(transformation(extent={{-60,-58},{-40,-38}})));
equation

  connect(bypDamsim.y, ERWtemp.uBypDam) annotation (Line(points={{-36,16},{0,16},
          {0,6},{41.6,6}}, color={255,0,255}));

  connect(erwStartgen.y, ERWtemp.uEneRecWheStart) annotation (Line(points={{-36,
          46},{4,46},{4,2},{41.6,2}}, color={255,0,255}));

  connect(raTGen.y, ERWtemp.TAirRet) annotation (Line(points={{-36,-16},{4,-16},
          {4,-2},{41.6,-2}}, color={0,0,127}));
  connect(oaTGen.y, ERWtemp.TAirOut) annotation (Line(points={{-38,-48},{-12,-48},
          {-12,-34},{16,-34},{16,-6},{41.6,-6}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={Ellipse(lineColor = {75,138,73},
fillColor={255,255,255},
            fillPattern=
FillPattern.Solid,extent={{-100,-100},{100,100}}),
Polygon(lineColor = {0,0,255},fillColor = {75,138,73},
pattern = LinePattern.None,
            fillPattern=
FillPattern.Solid,points={{-36,60},{64,0},{-36,-60},{-36,60}})}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
<li>
September 29, 2020, by Henry Nickels:</br>
First implementation.</li>
</ul>
</html>", info="<html>
<p>
This example simulates
<a href=\"modelica://Buildings.Controls.OBC.FDE.DOAS.erwTsim\">
Buildings.Controls.OBC.FDE.DOAS.erwTsim</a>.
</p>
</html>"),
    experiment(StopTime=5760, __Dymola_Algorithm="Dassl"));
end erwTsim;
