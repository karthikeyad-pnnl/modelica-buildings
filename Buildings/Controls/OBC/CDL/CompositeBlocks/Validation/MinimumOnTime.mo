within Buildings.Controls.OBC.CDL.CompositeBlocks.Validation;
model MinimumOnTime
  Buildings.Controls.OBC.CDL.CompositeBlocks.MinimumOnTime minimumOnTime(
      tEnaMin=40, tDisMin=40)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Logical.Sources.Pulse booPul(period=50)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Buildings.Controls.OBC.CDL.CompositeBlocks.MinimumOnTime minimumOnTime1(
      tEnaMin=40, tDisMin=0)
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  Buildings.Controls.OBC.CDL.CompositeBlocks.MinimumOnTime minimumOnTime2(
      tEnaMin=0, tDisMin=40)
    annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
equation
  connect(booPul.y, minimumOnTime.uEna)
    annotation (Line(points={{-38,0},{-12,0}}, color={255,0,255}));
  connect(booPul.y, minimumOnTime1.uEna) annotation (Line(points={{-38,0},{-20,
          0},{-20,40},{-12,40}}, color={255,0,255}));
  connect(booPul.y, minimumOnTime2.uEna) annotation (Line(points={{-38,0},{-20,
          0},{-20,-40},{-12,-40}}, color={255,0,255}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Ellipse(
          lineColor={75,138,73},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          extent={{-100,-100},{100,100}}),
        Polygon(
          lineColor={0,0,255},
          fillColor={75,138,73},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{-36,60},{64,0},{-36,-60},{-36,60}})}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=200, __Dymola_Algorithm="Dassl"));
end MinimumOnTime;
