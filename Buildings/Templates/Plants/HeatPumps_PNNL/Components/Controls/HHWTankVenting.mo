within Buildings.Templates.Plants.HeatPumps_PNNL.Components.Controls;
block HHWTankVenting
  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput uOpeMod annotation (
      Placement(transformation(extent={{-140,20},{-100,60}}),
        iconTransformation(extent={{-140,20},{-100,60}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput THotWatTan annotation (
      Placement(transformation(extent={{-140,-60},{-100,-20}}),
        iconTransformation(extent={{-140,-60},{-100,-20}})));
  Buildings.Controls.OBC.CDL.Reals.Hysteresis hys(uLow=273.15 + 65, uHigh=
        273.15 + 75)
    annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
  Buildings.Controls.OBC.CDL.Integers.Equal intEqu
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt(k=0)
    annotation (Placement(transformation(extent={{-90,0},{-70,20}})));
  Buildings.Controls.OBC.CDL.Logical.And and2
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yVen annotation (
      Placement(transformation(extent={{100,-20},{140,20}}), iconTransformation(
          extent={{100,-20},{140,20}})));
equation
  connect(THotWatTan, hys.u)
    annotation (Line(points={{-120,-40},{-62,-40}}, color={0,0,127}));
  connect(uOpeMod, intEqu.u1)
    annotation (Line(points={{-120,40},{-62,40}}, color={255,127,0}));
  connect(conInt.y, intEqu.u2)
    annotation (Line(points={{-68,10},{-62,10},{-62,32}}, color={255,127,0}));
  connect(intEqu.y, and2.u1) annotation (Line(points={{-38,40},{10,40},{10,0},{
          18,0}}, color={255,0,255}));
  connect(hys.y, and2.u2) annotation (Line(points={{-38,-40},{10,-40},{10,-8},{
          18,-8}}, color={255,0,255}));
  connect(and2.y, yVen)
    annotation (Line(points={{42,0},{120,0}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,140},{150,100}},
          textString="%name",
          textColor={0,0,255})}), Diagram(coordinateSystem(preserveAspectRatio=
            false)));
end HHWTankVenting;
