within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Pumps.ChilledWater.Subsequences.Validation;
model Speed_primary_remoteDp
  "Validate sequence of controlling chilled water pump speed for primary-only plants with remote DP sensor hardwired to the plant controller"

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Pumps.ChilledWater.Subsequences.Speed_primary_remoteDp
    chiPumSpe(nSen=2, nPum=2)
    "Chilled water pump speed control based remote pressure difference sensor"
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));

protected
  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse pumSta[2](
    final width=fill(0.95, 2),
    final period=fill(10, 2),
    final startTime=fill(1, 2)) "Pump status"
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant difPreSet(
    final k=8.5*6894.75)
    "Pressure difference setpoint"
    annotation (Placement(transformation(extent={{-60,-90},{-40,-70}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Sine remPreSen1(
    final offset=8.5*6894.75,
    final freqHz=1/10,
    final amplitude=1.5*6894.75) "Remote pressure difference sensor reading"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Sine remPreSen2(
    final offset=8.5*6894.75,
    final freqHz=1/10,
    final startTime=2,
    final amplitude=1*6894.75) "Remote pressure difference sensor reading"
    annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));

equation
  connect(difPreSet.y, chiPumSpe.dpChiWatSet)
    annotation (Line(points={{-38,-80},{-20,-80},{-20,-8},{18,-8}},
      color={0,0,127}));
  connect(pumSta.y, chiPumSpe.uChiWatPum)
    annotation (Line(points={{-38,40},{-20,40},{-20,8},{18,8}},
      color={255,0,255}));
  connect(remPreSen1.y, chiPumSpe.dpChiWat[1])
    annotation (Line(points={{-38,0},{-10,0},{-10,-1},{18,-1}},
      color={0,0,127}));
  connect(remPreSen2.y, chiPumSpe.dpChiWat[2])
    annotation (Line(points={{-38,-40},{-28,-40},{-28,1},{18,1}},
      color={0,0,127}));

annotation (
  experiment(StopTime=10.0, Tolerance=1e-06),
  __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Controls/OBC/ASHRAE/PrimarySystem/ChillerPlant/Pumps/ChilledWater/Subsequences/Validation/Speed_primary_remoteDp.mos"
    "Simulate and plot"),
  Documentation(info="<html>
<p>
This example validates
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Pumps.ChilledWater.Subsequences.Speed_primary_remoteDp\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Pumps.ChilledWater.Subsequences.Speed_primary_remoteDp</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
Arpil 4, 2019, by Jianjun Hu:<br/>
First implementation.
</li>
</ul>
</html>"),
  Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                         graphics={
        Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent = {{-100,-100},{100,100}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points = {{-36,60},{64,0},{-36,-60},{-36,60}})}), Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})));
end Speed_primary_remoteDp;
