within Buildings.Examples.VAVReheat.BaseClasses;
block PowerCalculation

  parameter Real PCooExp
    "Expression for cooling power ";
  Modelica.Blocks.Sources.RealExpression PCoo(y=PCooExp)
    annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
  Modelica.Blocks.Sources.RealExpression PHea(y=PHeaExp)
    annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
  Modelica.Blocks.Sources.RealExpression PFan(y=PFanExp)
    annotation (Placement(transformation(extent={{-80,-30},{-60,-10}})));
  Modelica.Blocks.Sources.RealExpression PReh(y=PRehExp)
    annotation (Placement(transformation(extent={{-80,-70},{-60,-50}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PowerCalculation;
