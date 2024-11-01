within Buildings.Templates.Plants.Controls.Utilities;
block PlaceholderReal "Output a placeholder signal"
  parameter Boolean have_inp=true
    "Set to true if input signal is available"
    annotation (Evaluate=true);
  parameter Boolean have_inpPh=false
    "Set to true if placeholder value is provided with input signal"
    annotation (Evaluate=true);
  parameter Real u_internal(
    start=0)
    "Placeholder value if input signal is not available"
    annotation (Dialog(enable=not have_inpPh));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput u
    if have_inp
    "Input"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}}),
      iconTransformation(extent={{-140,-20},{-100,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uPh
    if not have_inp and have_inpPh "Input"
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}}),
        iconTransformation(extent={{-140,-80},{-100,-40}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput y
    "Output"
    annotation (Placement(transformation(extent={{100,-20},{140,20}}),
      iconTransformation(extent={{100,-20},{140,20}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant ph(final k=u_internal)
    if not have_inp and not have_inpPh
    "Placeholder signal if input signal is not available"
    annotation (Placement(transformation(extent={{-10,-90},{10,-70}})));
equation
  connect(u, y)
    annotation (Line(points={{-120,0},{120,0}},color={0,0,127}));
  connect(ph.y, y) annotation (Line(points={{12,-80},{80,-80},{80,0},{120,0}},
        color={0,0,127}));
  connect(uPh, y) annotation (Line(points={{-120,-40},{60,-40},{60,0},{120,0}},
        color={0,0,127}));
  annotation (
    defaultComponentName="ph",
    Icon(
      coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,150},{150,110}},
          textString="%name",
          textColor={0,0,255})}),
    Documentation(info="<html>
<p>
This block enables replacing a variable that is conditionally
removed with either a parameter or another input variable.
</p>
<ul>
<li>
If the parameter <code>have_inp</code> is true, the output variable
<code>y</code> is equal to the input variable <code>u</code>.
</li>
<li>
If the parameter <code>have_inp</code> is false and the 
parameter <code>have_inpPh</code> is true, the output variable
<code>y</code> is equal to the input variable <code>uPh</code>.
</li>
<li>
If the parameter <code>have_inp</code> is false and the 
parameter <code>have_inpPh</code> is false, the output variable
<code>y</code> is equal to the parameter <code>u_internal</code>.
</li>
</ul>
</html>", revisions="<html>
<ul>
<li>
March 29, 2024, by Antoine Gautier:<br/>
First implementation.
</li>
</ul>
</html>"));
end PlaceholderReal;
