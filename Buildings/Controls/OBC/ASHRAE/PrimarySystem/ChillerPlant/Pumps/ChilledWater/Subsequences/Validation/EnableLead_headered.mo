within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Pumps.ChilledWater.Subsequences.Validation;
model EnableLead_headered
  "Validate sequence for enabling lead pump of plants with headered primary chilled water pumps"

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Pumps.ChilledWater.Subsequences.EnableLead_headered
    enaLeaChiPum(nChi=3)
    "Enable lead chilled water pump based on the status of chilled water isolation valves"
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));

protected
  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse isoVal(
    final period=3600,
    final startTime=300) "Isolation valve status"
    annotation (Placement(transformation(extent={{-20,50},{0,70}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse isoVal1(
    final period=3600,
    final startTime=600) "Isolation valve status"
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse isoVal2(
    final period=3600,
    final startTime=1000) "Isolation valve status"
    annotation (Placement(transformation(extent={{-20,-70},{0,-50}})));

equation
  connect(isoVal.y, enaLeaChiPum.uChiIsoVal[3])
    annotation (Line(points={{2,60},{20,60},{20,1.33333},{38,1.33333}},
      color={255,0,255}));
  connect(isoVal1.y, enaLeaChiPum.uChiIsoVal[2])
    annotation (Line(points={{2,0},{38,0}}, color={255,0,255}));
  connect(isoVal2.y, enaLeaChiPum.uChiIsoVal[1])
    annotation (Line(points={{2,-60},{20,-60},{20,-1.33333},{38,-1.33333}},
      color={255,0,255}));

annotation (
  experiment(StopTime=3600.0, Tolerance=1e-06),
  __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Controls/OBC/ASHRAE/PrimarySystem/ChillerPlant/Pumps/ChilledWater/Subsequences/Validation/EnableLead_headered.mos"
    "Simulate and plot"),
  Documentation(info="<html>
<p>
This example validates
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Pumps.ChilledWater.Subsequences.EnableLead_headered\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Pumps.ChilledWater.Subsequences.EnableLead_headered</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
Arpil 4, 2019, by Jianjun Hu:<br/>
First implementation.
</li>
</ul>
</html>"),
  Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={
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
end EnableLead_headered;
