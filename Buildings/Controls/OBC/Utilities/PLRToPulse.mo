within Buildings.Controls.OBC.Utilities;
block PLRToPulse
  parameter Real timePeriod = 15*60
    "Time period for PLR sampling";
  CDL.Continuous.MultiplyByParameter gai(k=timePeriod)
    annotation (Placement(transformation(extent={{-20,60},{0,80}})));
  CDL.Discrete.TriggeredSampler triSam
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  CDL.Logical.Timer tim
    annotation (Placement(transformation(extent={{-20,30},{0,50}})));
  CDL.Interfaces.BooleanOutput y annotation (Placement(transformation(extent={{100,-20},
            {140,20}}),        iconTransformation(extent={{100,-20},{140,20}})));
  CDL.Interfaces.RealInput uPLR annotation (Placement(transformation(extent={{
            -140,60},{-100,100}}), iconTransformation(extent={{-140,-20},{-100,20}})));
  CDL.Continuous.Subtract sub
    annotation (Placement(transformation(extent={{20,50},{40,70}})));
  CDL.Continuous.Hysteresis hys(uLow=-0.001, uHigh=0.001)
    annotation (Placement(transformation(extent={{50,50},{70,70}})));
  CDL.Logical.TrueFalseHold truFalHol1(trueHoldDuration=30, falseHoldDuration=0)
    annotation (Placement(transformation(extent={{80,70},{100,90}})));
  CDL.Logical.Sources.Pulse         booPul(width=1/timePeriod,
                                           period=timePeriod)
    annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
  CDL.Continuous.Less les
    annotation (Placement(transformation(extent={{20,20},{40,40}})));
  CDL.Logical.Latch lat
    annotation (Placement(transformation(extent={{-50,30},{-30,50}})));
  CDL.Logical.Pre pre
    annotation (Placement(transformation(extent={{50,20},{70,40}})));
  CDL.Logical.And and2
    annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
  CDL.Logical.Not not1
    annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
equation
  connect(triSam.y, gai.u)
    annotation (Line(points={{-38,70},{-22,70}}, color={0,0,127}));
  connect(uPLR, triSam.u) annotation (Line(points={{-120,80},{-90,80},{-90,70},
          {-62,70}}, color={0,0,127}));
  connect(tim.y, sub.u1) annotation (Line(points={{2,40},{10,40},{10,66},{18,66}},
        color={0,0,127}));
  connect(gai.y, sub.u2) annotation (Line(points={{2,70},{14,70},{14,54},{18,54}},
        color={0,0,127}));
  connect(sub.y, hys.u)
    annotation (Line(points={{42,60},{48,60}}, color={0,0,127}));
  connect(gai.y, les.u1) annotation (Line(points={{2,70},{14,70},{14,30},{18,30}},
        color={0,0,127}));
  connect(tim.y, les.u2) annotation (Line(points={{2,40},{10,40},{10,22},{18,22}},
        color={0,0,127}));
  connect(lat.y, tim.u)
    annotation (Line(points={{-28,40},{-22,40}}, color={255,0,255}));
  connect(les.y, pre.u)
    annotation (Line(points={{42,30},{48,30}}, color={255,0,255}));
  connect(pre.y, truFalHol1.u) annotation (Line(points={{72,30},{76,30},{76,80},
          {78,80}}, color={255,0,255}));
  connect(pre.y, lat.clr) annotation (Line(points={{72,30},{76,30},{76,10},{-60,
          10},{-60,34},{-52,34}}, color={255,0,255}));
  connect(lat.y, y) annotation (Line(points={{-28,40},{-26,40},{-26,0},{120,0}},
                    color={255,0,255}));
  connect(booPul.y, and2.u1)
    annotation (Line(points={{-38,-40},{-22,-40}}, color={255,0,255}));
  connect(and2.y, triSam.trigger) annotation (Line(points={{2,-40},{10,-40},{10,
          -20},{-70,-20},{-70,54},{-50,54},{-50,58}}, color={255,0,255}));
  connect(and2.y, lat.u) annotation (Line(points={{2,-40},{10,-40},{10,-20},{
          -70,-20},{-70,40},{-52,40}}, color={255,0,255}));
  connect(not1.y, and2.u2) annotation (Line(points={{-38,-70},{-30,-70},{-30,
          -48},{-22,-48}}, color={255,0,255}));
  connect(pre.y, not1.u) annotation (Line(points={{72,30},{76,30},{76,-90},{-70,
          -90},{-70,-70},{-62,-70}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PLRToPulse;
