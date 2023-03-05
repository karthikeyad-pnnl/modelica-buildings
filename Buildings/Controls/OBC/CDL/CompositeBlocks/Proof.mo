within Buildings.Controls.OBC.CDL.CompositeBlocks;
block Proof
  "Composite block for equipment proven on"

  parameter Real meaDis
    "Percent limit for measured signal below which component is assumed to be disabled";

  parameter Real meaEna
    "Percent limit for measured signal above which component is assumed to be enabled";

  parameter Real mea_nominal
    "Nominal value for measured signal from component, which is used to normalize the signal";

  parameter Real tau
    "Time constant for the device";

  parameter Real tAla
    "Time limit beyond which alarm is triggered if the device is not proven on";

  Interfaces.BooleanInput uDes
    "Desired state"
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}}),
      iconTransformation(extent={{-140,-60},{-100,-20}})));

  Interfaces.RealInput uMea
    "Measured signal"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}}),
      iconTransformation(extent={{-140,20},{-100,60}})));

  Interfaces.BooleanOutput yPro
    "Equipment proven on signal"
    annotation (Placement(transformation(extent={{100,20},{140,60}}),
      iconTransformation(extent={{100,20},{140,60}})));

  Interfaces.BooleanOutput yAla
    "Alarm signal"
    annotation (Placement(transformation(extent={{100,-60},{140,-20}}),
      iconTransformation(extent={{100,-60},{140,-20}})));

  Continuous.Hysteresis hys(uLow=meaDis, uHigh=meaEna)
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));

  Continuous.MultiplyByParameter gai(k=1/mea_nominal)
    "Normalize measured signal by dividng it by it's nominal value"
    annotation (Placement(transformation(extent={{-90,30},{-70,50}})));

  Logical.Timer tim(t=tau)
    "Ensure compoenent is at enabled position for minimum duration"
    annotation (Placement(transformation(extent={{-30,30},{-10,50}})));

  Logical.Not not1
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  Logical.And and2
    annotation (Placement(transformation(extent={{70,-50},{90,-30}})));
  Logical.Timer tim1(t=tAla)
    "Check if component responds in time allowed before alarm is triggered"
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
equation
  connect(gai.y, hys.u)
    annotation (Line(points={{-68,40},{-62,40}}, color={0,0,127}));
  connect(uMea, gai.u)
    annotation (Line(points={{-120,40},{-92,40}}, color={0,0,127}));
  connect(hys.y, tim.u)
    annotation (Line(points={{-38,40},{-32,40}}, color={255,0,255}));
  connect(tim.passed, yPro) annotation (Line(points={{-8,32},{0,32},{0,40},{120,
          40}}, color={255,0,255}));
  connect(tim.passed, not1.u)
    annotation (Line(points={{-8,32},{0,32},{0,0},{8,0}}, color={255,0,255}));
  connect(and2.y, yAla)
    annotation (Line(points={{92,-40},{120,-40}}, color={255,0,255}));
  connect(not1.y, tim1.u)
    annotation (Line(points={{32,0},{38,0}}, color={255,0,255}));
  connect(tim1.passed, and2.u1) annotation (Line(points={{62,-8},{64,-8},{64,-40},
          {68,-40}}, color={255,0,255}));
  connect(uDes, and2.u2) annotation (Line(points={{-120,-40},{40,-40},{40,-48},{
          68,-48}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-100,40},{100,-40}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="Proof")}),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Proof;
