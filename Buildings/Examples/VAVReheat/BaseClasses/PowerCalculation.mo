within Buildings.Examples.VAVReheat.BaseClasses;
model PowerCalculation

  input Real PCooExp
    "Expression for cooling power consumption";

  input Real PHeaExp
    "Expression for heating power consumption";

  input Real PFanExp
    "Expression for fan power consumption";

  input Real PRehExp
    "Expression for reheat power consumption";

  Buildings.Controls.OBC.CDL.Interfaces.RealOutput PTot
    "Total power consumption"
    annotation (Placement(transformation(extent={{100,-20},{140,20}}),
      iconTransformation(extent={{100,-20},{140,20}})));

  Modelica.Blocks.Sources.RealExpression PCoo(
    final y=PCooExp)
    "Cooling power component"
    annotation (Placement(transformation(extent={{-80,50},{-60,70}})));

  Modelica.Blocks.Sources.RealExpression PHea(
    final y=PHeaExp)
    "Heating power component"
    annotation (Placement(transformation(extent={{-80,10},{-60,30}})));

  Modelica.Blocks.Sources.RealExpression PFan(
    final y=PFanExp)
    "Fan power component"
    annotation (Placement(transformation(extent={{-80,-30},{-60,-10}})));

  Modelica.Blocks.Sources.RealExpression PReh(
    final y=PRehExp)
    "Reheat power component"
    annotation (Placement(transformation(extent={{-80,-70},{-60,-50}})));

  Buildings.Controls.OBC.CDL.Continuous.MultiSum mulSum(
    final nin=4)
    "Sum of all components"
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));

equation
  connect(mulSum.y, PTot)
    annotation (Line(points={{62,0},{120,0}}, color={0,0,127}));
  connect(PCoo.y, mulSum.u[1]) annotation (Line(points={{-59,60},{20,60},{20,1.5},
          {38,1.5}}, color={0,0,127}));
  connect(PHea.y, mulSum.u[2]) annotation (Line(points={{-59,20},{0,20},{0,0.5},
          {38,0.5}}, color={0,0,127}));
  connect(PFan.y, mulSum.u[3]) annotation (Line(points={{-59,-20},{0,-20},{0,-0.5},
          {38,-0.5}}, color={0,0,127}));
  connect(PReh.y, mulSum.u[4]) annotation (Line(points={{-59,-60},{20,-60},{20,-1.5},
          {38,-1.5}}, color={0,0,127}));
  annotation (defaultComponentName="PTot",
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
                                        Text(
        extent={{-100,140},{100,100}},
        textString="%name",
        textColor={0,0,255})}),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PowerCalculation;
