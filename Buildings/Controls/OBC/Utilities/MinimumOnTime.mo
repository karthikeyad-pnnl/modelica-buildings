within Buildings.Controls.OBC.Utilities;
block MinimumOnTime
  "Keep component enabled for minimum run duration to prevent short cycling"
  parameter Real tEnaMin;
  parameter Real tDisMin;
  CDL.Interfaces.BooleanInput uDis "Component disable signal" annotation (
      Placement(transformation(extent={{-140,-20},{-100,20}}),
        iconTransformation(extent={{-140,-20},{-100,20}})));
  CDL.Interfaces.BooleanOutput yEna "Enable mode output signal" annotation (
      Placement(transformation(extent={{100,-20},{140,20}}), iconTransformation(
          extent={{100,-20},{140,20}})));
  CDL.Logical.Latch lat
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  CDL.Interfaces.BooleanInput uEna "Component enable signal" annotation (
      Placement(transformation(extent={{-140,80},{-100,120}}),
        iconTransformation(extent={{-140,20},{-100,60}})));
  CDL.Interfaces.BooleanInput uEmeOff "Component emergency off signal"
    annotation (Placement(transformation(extent={{-140,-120},{-100,-80}}),
        iconTransformation(extent={{-140,-60},{-100,-20}})));
  CDL.Logical.And andEna
    "Enable component if signal is received and minimum disable time has passed"
    annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
  CDL.Logical.Timer timEna(t=tEnaMin)
    annotation (Placement(transformation(extent={{-20,80},{0,100}})));
  CDL.Logical.And andDis
    "Disable component if signal is received and minimum enable time has passed"
    annotation (Placement(transformation(extent={{-40,-70},{-20,-50}})));
  CDL.Logical.Timer timDis(t=tDisMin)
    annotation (Placement(transformation(extent={{0,40},{20,60}})));
  CDL.Logical.Pre pre
    annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
  CDL.Logical.Not notEna "Check if component is not enabled"
    annotation (Placement(transformation(extent={{-30,40},{-10,60}})));
  CDL.Logical.Or orDisEmeSto
    "Or block to disable component if the either disable or emergency off signal is received"
    annotation (Placement(transformation(extent={{20,-90},{40,-70}})));
equation
  connect(lat.y, yEna)
    annotation (Line(points={{82,0},{120,0}}, color={255,0,255}));
  connect(yEna, yEna)
    annotation (Line(points={{120,0},{120,0},{120,0}}, color={255,0,255}));
  connect(andEna.y, lat.u) annotation (Line(points={{-18,-20},{40,-20},{40,0},{
          58,0}},
               color={255,0,255}));
  connect(lat.y, pre.u) annotation (Line(points={{82,0},{90,0},{90,110},{-70,
          110},{-70,90},{-62,90}},
                                color={255,0,255}));
  connect(orDisEmeSto.y, lat.clr) annotation (Line(points={{42,-80},{46,-80},{
          46,-6},{58,-6}}, color={255,0,255}));
  connect(andDis.y, orDisEmeSto.u1) annotation (Line(points={{-18,-60},{14,-60},
          {14,-80},{18,-80}}, color={255,0,255}));
  connect(pre.y, notEna.u) annotation (Line(points={{-38,90},{-34,90},{-34,50},
          {-32,50}}, color={255,0,255}));
  connect(notEna.y, timDis.u)
    annotation (Line(points={{-8,50},{-2,50}}, color={255,0,255}));
  connect(pre.y, timEna.u)
    annotation (Line(points={{-38,90},{-22,90}},   color={255,0,255}));
  connect(uEmeOff, orDisEmeSto.u2) annotation (Line(points={{-120,-100},{14,
          -100},{14,-88},{18,-88}}, color={255,0,255}));
  connect(timDis.passed, andDis.u1) annotation (Line(points={{22,42},{30,42},{
          30,20},{-60,20},{-60,-60},{-42,-60}}, color={255,0,255}));
  connect(timEna.passed, andEna.u1) annotation (Line(points={{2,82},{40,82},{40,
          10},{-50,10},{-50,-20},{-42,-20}}, color={255,0,255}));
  connect(uEna, andEna.u2) annotation (Line(points={{-120,100},{-80,100},{-80,
          -28},{-42,-28}}, color={255,0,255}));
  connect(uDis, andDis.u2) annotation (Line(points={{-120,0},{-90,0},{-90,-68},
          {-42,-68}}, color={255,0,255}));
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
