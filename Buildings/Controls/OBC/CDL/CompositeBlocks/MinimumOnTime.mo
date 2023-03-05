within Buildings.Controls.OBC.CDL.CompositeBlocks;
block MinimumOnTime
  "Keep component enabled for minimum run duration to prevent short cycling"
  parameter Real tEnaMin;
  parameter Real tDisMin;
  Interfaces.BooleanInput uEna "Enable status input signal" annotation (
      Placement(transformation(extent={{-140,-20},{-100,20}}),
        iconTransformation(extent={{-140,-20},{-100,20}})));
  Interfaces.BooleanOutput yEna "Enable mode output signal" annotation (
      Placement(transformation(extent={{100,-20},{140,20}}), iconTransformation(
          extent={{100,-20},{140,20}})));
  Logical.Or or2
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Logical.TrueFalseHold falHol(trueHoldDuration=0, falseHoldDuration=tDisMin)
    "Hold false signal"
    annotation (Placement(transformation(extent={{0,-50},{20,-30}})));
  Logical.TrueFalseHold truHol(trueHoldDuration=tEnaMin, falseHoldDuration=0)
    annotation (Placement(transformation(extent={{0,30},{20,50}})));
  Logical.And and2
    annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
  Logical.Or or1
    annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
equation
  connect(or2.y, yEna)
    annotation (Line(points={{82,0},{120,0}}, color={255,0,255}));
  connect(truHol.u, and2.y)
    annotation (Line(points={{-2,40},{-18,40}}, color={255,0,255}));
  connect(uEna, and2.u2) annotation (Line(points={{-120,0},{-50,0},{-50,32},{-42,
          32}}, color={255,0,255}));
  connect(truHol.y, or2.u1) annotation (Line(points={{22,40},{50,40},{50,0},{58,
          0}}, color={255,0,255}));
  connect(falHol.y, or2.u2) annotation (Line(points={{22,-40},{40,-40},{40,-8},{
          58,-8}}, color={255,0,255}));
  connect(falHol.y, and2.u1) annotation (Line(points={{22,-40},{40,-40},{40,80},
          {-50,80},{-50,40},{-42,40}}, color={255,0,255}));
  connect(or1.y, falHol.u)
    annotation (Line(points={{-18,-40},{-2,-40}}, color={255,0,255}));
  connect(truHol.y, or1.u2) annotation (Line(points={{22,40},{50,40},{50,-80},{-50,
          -80},{-50,-48},{-42,-48}}, color={255,0,255}));
  connect(uEna, or1.u1) annotation (Line(points={{-120,0},{-50,0},{-50,-40},{-42,
          -40}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-84,40},{82,-40}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="MinOnTim")}), Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end MinimumOnTime;
