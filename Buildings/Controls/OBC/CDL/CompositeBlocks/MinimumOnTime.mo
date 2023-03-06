within Buildings.Controls.OBC.CDL.CompositeBlocks;
block MinimumOnTime
  "Keep component enabled for minimum run duration to prevent short cycling"
  parameter Real tEnaMin;
  parameter Real tDisMin;
  Interfaces.BooleanInput uDis "Component disable signal"   annotation (
      Placement(transformation(extent={{-140,20},{-100,60}}),
        iconTransformation(extent={{-140,-20},{-100,20}})));
  Interfaces.BooleanOutput yEna "Enable mode output signal" annotation (
      Placement(transformation(extent={{100,-20},{140,20}}), iconTransformation(
          extent={{100,-20},{140,20}})));
  Logical.Latch lat
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Interfaces.BooleanInput uEna "Component enable signal" annotation (Placement(
        transformation(extent={{-140,60},{-100,100}}), iconTransformation(
          extent={{-140,20},{-100,60}})));
  Interfaces.BooleanInput uEmeOff "Component emergency off signal" annotation (
      Placement(transformation(extent={{-140,-120},{-100,-80}}),
        iconTransformation(extent={{-140,-60},{-100,-20}})));
  Logical.And andEna
    "Enable component if signal is received and minimum disable time has passed"
    annotation (Placement(transformation(extent={{-60,70},{-40,90}})));
  Logical.Timer timEna(t=tEnaMin)
    annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
  Logical.And andDis
    "Disable component if signal is received and minimum enable time has passed"
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  Logical.Timer timDis(t=tDisMin)
    annotation (Placement(transformation(extent={{-20,-90},{0,-70}})));
  Logical.Pre pre
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  Logical.Not not1
    annotation (Placement(transformation(extent={{-50,-90},{-30,-70}})));
  Logical.Or or2
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
equation
  connect(lat.y, yEna)
    annotation (Line(points={{82,0},{120,0}}, color={255,0,255}));
  connect(yEna, yEna)
    annotation (Line(points={{120,0},{120,0},{120,0}}, color={255,0,255}));
  connect(uEna, andEna.u1)
    annotation (Line(points={{-120,80},{-62,80}}, color={255,0,255}));
  connect(andEna.y, lat.u) annotation (Line(points={{-38,80},{52,80},{52,0},{58,
          0}}, color={255,0,255}));
  connect(lat.y, pre.u) annotation (Line(points={{82,0},{90,0},{90,-20},{-90,-20},
          {-90,-40},{-82,-40}}, color={255,0,255}));
  connect(or2.y, lat.clr) annotation (Line(points={{42,0},{46,0},{46,-6},{58,-6}},
        color={255,0,255}));
  connect(andDis.y, or2.u1) annotation (Line(points={{-38,40},{14,40},{14,0},{18,
          0}}, color={255,0,255}));
  connect(uDis, andDis.u1)
    annotation (Line(points={{-120,40},{-62,40}}, color={255,0,255}));
  connect(pre.y, not1.u) annotation (Line(points={{-58,-40},{-54,-40},{-54,-80},
          {-52,-80}}, color={255,0,255}));
  connect(not1.y, timDis.u)
    annotation (Line(points={{-28,-80},{-22,-80}}, color={255,0,255}));
  connect(pre.y, timEna.u)
    annotation (Line(points={{-58,-40},{-42,-40}}, color={255,0,255}));
  connect(uEmeOff, or2.u2) annotation (Line(points={{-120,-100},{14,-100},{14,-8},
          {18,-8}}, color={255,0,255}));
  connect(timDis.passed, andEna.u2) annotation (Line(points={{2,-88},{6,-88},{6,
          100},{-70,100},{-70,72},{-62,72}}, color={255,0,255}));
  connect(timEna.passed, andDis.u2) annotation (Line(points={{-18,-48},{-10,-48},
          {-10,110},{-80,110},{-80,32},{-62,32}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}),                                        graphics={
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
          preserveAspectRatio=false, extent={{-100,-120},{100,120}})));
end MinimumOnTime;
