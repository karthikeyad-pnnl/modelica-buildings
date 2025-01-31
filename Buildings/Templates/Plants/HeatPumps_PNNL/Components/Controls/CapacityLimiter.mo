within Buildings.Templates.Plants.HeatPumps_PNNL.Components.Controls;
block CapacityLimiter
  parameter Real TSupHeaLim=273.15+70;
  parameter Real TSupCooLim=273.15+5;
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TSupCoo annotation (Placement(
        transformation(extent={{-140,20},{-100,60}}), iconTransformation(extent={{-140,
            -20},{-100,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TSupHea annotation (Placement(
        transformation(extent={{-140,-60},{-100,-20}}), iconTransformation(
          extent={{-140,-60},{-100,-20}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yHea annotation (
      Placement(transformation(extent={{100,-20},{140,20}}),iconTransformation(
          extent={{100,-20},{140,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uHea annotation (Placement(
        transformation(extent={{-140,60},{-100,100}}), iconTransformation(
          extent={{-140,20},{-100,60}})));
  Buildings.Controls.OBC.CDL.Logical.Switch logSwi
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Buildings.Controls.OBC.CDL.Reals.GreaterThreshold greThr(t=TSupHeaLim, h=5)
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  Buildings.Controls.OBC.CDL.Reals.LessThreshold lesThr(t=TSupCooLim, h=1)
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  Buildings.Controls.OBC.CDL.Logical.Not not1
    annotation (Placement(transformation(extent={{20,30},{40,50}})));
  Buildings.Controls.OBC.CDL.Logical.Or or2
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
equation
  connect(uHea, logSwi.u3) annotation (Line(points={{-120,80},{-28,80},{-28,40},
          {0,40},{0,-8},{58,-8}},
                color={255,0,255}));
  connect(logSwi.y, yHea) annotation (Line(points={{82,0},{94,0},{94,0},{120,0}},
                color={255,0,255}));
  connect(TSupHea, greThr.u)
    annotation (Line(points={{-120,-40},{-82,-40}}, color={0,0,127}));
  connect(TSupCoo, lesThr.u)
    annotation (Line(points={{-120,40},{-82,40}}, color={0,0,127}));
  connect(uHea, not1.u) annotation (Line(points={{-120,80},{-28,80},{-28,40},{
          18,40}}, color={255,0,255}));
  connect(not1.y, logSwi.u1) annotation (Line(points={{42,40},{50,40},{50,8},{
          58,8}}, color={255,0,255}));
  connect(lesThr.y, or2.u1) annotation (Line(points={{-58,40},{-48,40},{-48,0},
          {-42,0}}, color={255,0,255}));
  connect(greThr.y, or2.u2) annotation (Line(points={{-58,-40},{-50,-40},{-50,
          -8},{-42,-8}}, color={255,0,255}));
  connect(or2.y, logSwi.u2)
    annotation (Line(points={{-18,0},{58,0}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CapacityLimiter;
