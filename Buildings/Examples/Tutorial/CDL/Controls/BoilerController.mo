within Buildings.Examples.Tutorial.CDL.Controls;
block BoilerController
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput boiStaSig
    "Boiler on/off status from main controller"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput u
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput y
    annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Buildings.Controls.OBC.CDL.Continuous.Hysteresis hys(uLow=273.15 + 70, uHigh=273.15
         + 90)
    annotation (Placement(transformation(extent={{-76,-50},{-56,-30}})));
  Buildings.Controls.OBC.CDL.Logical.And and2
    annotation (Placement(transformation(extent={{-28,-10},{-8,10}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea
    annotation (Placement(transformation(extent={{14,-10},{34,10}})));
  Buildings.Controls.OBC.CDL.Logical.Not not1
    annotation (Placement(transformation(extent={{-48,-50},{-28,-30}})));
equation
  connect(hys.u, u) annotation (Line(points={{-78,-40},{-100,-40},{-100,-40},{-120,
          -40}}, color={0,0,127}));
  connect(and2.u1, boiStaSig) annotation (Line(points={{-30,0},{-50,0},{-50,40},
          {-120,40}}, color={255,0,255}));
  connect(booToRea.y, y)
    annotation (Line(points={{36,0},{120,0}}, color={0,0,127}));
  connect(and2.y, booToRea.u)
    annotation (Line(points={{-6,0},{12,0}}, color={255,0,255}));
  connect(hys.y, not1.u)
    annotation (Line(points={{-54,-40},{-50,-40}}, color={255,0,255}));
  connect(not1.y, and2.u2) annotation (Line(points={{-26,-40},{-28,-40},{-28,-8},
          {-30,-8}}, color={255,0,255}));
  annotation (
  defaultComponentName = "conBoi",
  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end BoilerController;
