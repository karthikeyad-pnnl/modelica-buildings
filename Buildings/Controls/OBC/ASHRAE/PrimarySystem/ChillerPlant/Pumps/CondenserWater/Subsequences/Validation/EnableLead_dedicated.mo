within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Pumps.CondenserWater.Subsequences.Validation;
model EnableLead_dedicated
  "Validate sequence for enabling lead pump of plants with dedicated condenser water pumps"

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Pumps.CondenserWater.Subsequences.EnableLead_dedicated
    enaLeaConPum
    "Enable lead condenser water pump when the lead chiller is enabled"
    annotation (Placement(transformation(extent={{40,10},{60,30}})));
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Pumps.CondenserWater.Subsequences.EnableLead_dedicated
    disLeaConPum
    "Disable lead pump due to that the lead chiller has been proven off"
    annotation (Placement(transformation(extent={{40,-30},{60,-10}})));

protected
  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse booPul(
    final period=3600,
    final startTime=300)
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  Buildings.Controls.OBC.CDL.Logical.Latch lat
    "Maintains a true signal until conditions changes"
    annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con(
    final k=false) "Constant false"
    annotation (Placement(transformation(extent={{-60,-70},{-40,-50}})));

equation
  connect(booPul.y,enaLeaConPum. uLeaChiEna)
    annotation (Line(points={{2,50},{20,50},{20,28},{38,28}}, color={255,0,255}));
  connect(booPul.y, enaLeaConPum.uLeaChiSta)
    annotation (Line(points={{2,50},{20,50},{20,20},{38,20}}, color={255,0,255}));
  connect(booPul.y,disLeaConPum. uLeaChiEna)
    annotation (Line(points={{2,50},{20,50},{20,-12},{38,-12}}, color={255,0,255}));
  connect(booPul.y, disLeaConPum.uLeaChiSta)
    annotation (Line(points={{2,50},{20,50},{20,-20},{38,-20}}, color={255,0,255}));
  connect(booPul.y, lat.u)
    annotation (Line(points={{2,50},{20,50},{20,-20},{-40,-20},{-40,-40},{-22,-40}},
      color={255,0,255}));
  connect(booPul.y, enaLeaConPum.uLeaConWatReq)
    annotation (Line(points={{2,50},{20,50},{20,12},{38,12}}, color={255,0,255}));
  connect(lat.y,disLeaConPum. uLeaConWatReq)
    annotation (Line(points={{2,-40},{20,-40},{20,-28},{38,-28}}, color={255,0,255}));
  connect(con.y, lat.clr)
    annotation (Line(points={{-38,-60},{-30,-60},{-30,-46},{-22,-46}},
      color={255,0,255}));

annotation (
  experiment(StopTime=3600.0, Tolerance=1e-06),
  __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Controls/OBC/ASHRAE/PrimarySystem/ChillerPlant/Pumps/CondenserWater/Subsequences/Validation/EnableLead_dedicated.mos"
    "Simulate and plot"),
  Documentation(info="<html>
<p>
This example validates
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Pumps.CondenserWater.Subsequences.EnableLead_dedicated\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Pumps.CondenserWater.Subsequences.EnableLead_dedicated</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
August 4, 2019, by Jianjun Hu:<br/>
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
end EnableLead_dedicated;
