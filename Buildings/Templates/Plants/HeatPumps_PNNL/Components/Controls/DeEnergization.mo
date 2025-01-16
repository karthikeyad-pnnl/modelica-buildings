within Buildings.Templates.Plants.HeatPumps_PNNL.Components.Controls;
block DeEnergization
  parameter Real THotRetLim;
  parameter Real TCooRetLim;
  parameter Real dTHotHys;
  parameter Real dTCooHys;
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TRetHeaCon annotation (
      Placement(transformation(extent={{-140,20},{-100,60}}),iconTransformation(
          extent={{-140,20},{-100,60}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TRetCooCon annotation (
      Placement(transformation(extent={{-140,-20},{-100,20}}),
        iconTransformation(extent={{-140,-20},{-100,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yEna annotation (
      Placement(transformation(extent={{100,-20},{140,20}}), iconTransformation(
          extent={{100,-20},{140,20}})));
  Buildings.Controls.OBC.CDL.Reals.Hysteresis hys1(uLow=THotRetLim - dTHotHys,
                                                                         uHigh=
        THotRetLim)
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  Buildings.Controls.OBC.CDL.Logical.Or or2
    annotation (Placement(transformation(extent={{-20,30},{0,50}})));
  Buildings.Controls.OBC.CDL.Reals.Hysteresis hys2(uLow=TCooRetLim, uHigh=
        TCooRetLim + dTCooHys)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Buildings.Controls.OBC.CDL.Logical.Not not1
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Buildings.Controls.OBC.CDL.Logical.Latch lat
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uEna annotation (Placement(
        transformation(extent={{-140,-60},{-100,-20}}), iconTransformation(
          extent={{-140,-60},{-100,-20}})));
  Buildings.Controls.OBC.CDL.Logical.And and2
    annotation (Placement(transformation(extent={{20,30},{40,50}})));
  Buildings.Controls.OBC.CDL.Logical.FallingEdge falEdg
    annotation (Placement(transformation(extent={{0,-30},{20,-10}})));
  Buildings.Controls.OBC.CDL.Logical.Or or1
    annotation (Placement(transformation(extent={{72,-10},{92,10}})));
equation
  connect(TRetHeaCon, hys1.u)
    annotation (Line(points={{-120,40},{-82,40}}, color={0,0,127}));
  connect(hys1.y, or2.u1)
    annotation (Line(points={{-58,40},{-22,40}}, color={255,0,255}));
  connect(TRetCooCon, hys2.u)
    annotation (Line(points={{-120,0},{-82,0}}, color={0,0,127}));
  connect(hys2.y, not1.u)
    annotation (Line(points={{-58,0},{-42,0}}, color={255,0,255}));
  connect(not1.y, or2.u2) annotation (Line(points={{-18,0},{-12,0},{-12,26},{-22,
          26},{-22,32}}, color={255,0,255}));
  connect(or2.y, and2.u1)
    annotation (Line(points={{2,40},{18,40}}, color={255,0,255}));
  connect(and2.y, lat.u) annotation (Line(points={{42,40},{48,40},{48,14},{32,14},
          {32,0},{38,0}}, color={255,0,255}));
  connect(uEna, and2.u2) annotation (Line(points={{-120,-40},{-10,-40},{-10,2},{
          10,2},{10,32},{18,32}}, color={255,0,255}));
  connect(falEdg.y, lat.clr) annotation (Line(points={{22,-20},{32,-20},{32,-6},
          {38,-6}}, color={255,0,255}));
  connect(or2.y, falEdg.u) annotation (Line(points={{2,40},{8,40},{8,-6},{-8,-6},
          {-8,-20},{-2,-20}}, color={255,0,255}));
  connect(lat.y, or1.u1)
    annotation (Line(points={{62,0},{70,0}}, color={255,0,255}));
  connect(or1.y, yEna)
    annotation (Line(points={{94,0},{120,0}}, color={255,0,255}));
  connect(uEna, or1.u2) annotation (Line(points={{-120,-40},{-10,-40},{-10,-34},
          {70,-34},{70,-8}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}), Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end DeEnergization;
