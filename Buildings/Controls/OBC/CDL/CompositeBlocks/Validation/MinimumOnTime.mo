within Buildings.Controls.OBC.CDL.CompositeBlocks.Validation;
model MinimumOnTime
  Buildings.Controls.OBC.CDL.CompositeBlocks.MinimumOnTime minimumOnTime(
      tEnaMin=40, tDisMin=40)
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Logical.Sources.Pulse booPul(period=50)
    annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
  Buildings.Controls.OBC.CDL.CompositeBlocks.MinimumOnTime minimumOnTime1(
      tEnaMin=40, tDisMin=0)
    annotation (Placement(transformation(extent={{20,30},{40,50}})));
  Buildings.Controls.OBC.CDL.CompositeBlocks.MinimumOnTime minimumOnTime2(
      tEnaMin=0, tDisMin=40)
    annotation (Placement(transformation(extent={{20,-50},{40,-30}})));
  Logical.Not not1
    annotation (Placement(transformation(extent={{-40,10},{-20,30}})));
  Logical.Sources.Pulse booPul1(
    width=1/200,
    period=180,
    shift=180)
    annotation (Placement(transformation(extent={{-80,-70},{-60,-50}})));
equation
  connect(booPul.y, minimumOnTime1.uEna) annotation (Line(points={{-58,20},{-50,
          20},{-50,44},{18,44}}, color={255,0,255}));
  connect(booPul.y, minimumOnTime.uEna) annotation (Line(points={{-58,20},{-50,
          20},{-50,4},{18,4}}, color={255,0,255}));
  connect(booPul.y, minimumOnTime2.uEna) annotation (Line(points={{-58,20},{-50,
          20},{-50,-36},{18,-36}}, color={255,0,255}));
  connect(booPul.y, not1.u)
    annotation (Line(points={{-58,20},{-42,20}}, color={255,0,255}));
  connect(not1.y, minimumOnTime1.uDis) annotation (Line(points={{-18,20},{-10,
          20},{-10,40},{18,40}}, color={255,0,255}));
  connect(not1.y, minimumOnTime.uDis) annotation (Line(points={{-18,20},{-10,20},
          {-10,0},{18,0}}, color={255,0,255}));
  connect(not1.y, minimumOnTime2.uDis) annotation (Line(points={{-18,20},{-10,
          20},{-10,-40},{18,-40}}, color={255,0,255}));
  connect(booPul1.y, minimumOnTime1.uEmeOff) annotation (Line(points={{-58,-60},
          {0,-60},{0,36},{18,36}}, color={255,0,255}));
  connect(booPul1.y, minimumOnTime.uEmeOff) annotation (Line(points={{-58,-60},
          {0,-60},{0,-4},{18,-4}}, color={255,0,255}));
  connect(booPul1.y, minimumOnTime2.uEmeOff) annotation (Line(points={{-58,-60},
          {0,-60},{0,-44},{18,-44}}, color={255,0,255}));
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
