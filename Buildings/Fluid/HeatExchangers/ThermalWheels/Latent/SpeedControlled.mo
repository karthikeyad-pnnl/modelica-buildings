within Buildings.Fluid.HeatExchangers.ThermalWheels.Latent;
model SpeedControlled
  "Enthalpy recovery wheel with a variable speed drive"
  extends
    Buildings.Fluid.HeatExchangers.ThermalWheels.Latent.BaseClasses.PartialWheel;
  parameter Real a[:] = {1}
    "Coefficients for power consumption curve for rotor. The sum of the elements must be equal to 1"
    annotation (Dialog(group="Efficiency"));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput uSpe(
    final unit="1",
    final max=1)
    "Wheel speed ratio"
    annotation (Placement(transformation(extent={{-220,-20},{-180,20}}),
        iconTransformation(extent={{-140,-20},{-100,20}})));
protected
  Modelica.Blocks.Sources.RealExpression PEle(
    final y=P_nominal*Buildings.Utilities.Math.Functions.polynomial(a=a, x=uSpe))
    "Electric power consumption"
    annotation (Placement(transformation(extent={{60,-100},{80,-80}})));

initial equation
  assert(abs(sum(a)-1) < Modelica.Constants.eps,
         "In " + getInstanceName() + ": Power efficiency curve is wrong. 
         The sum of the coefficients for power efficiency curve must be 1.",
         level=AssertionLevel.error);

equation
  connect(P, PEle.y)
    annotation (Line(points={{120,-90},{81,-90}}, color={0,0,127}));
  connect(port_a1, hex.port_a1) annotation (Line(points={{-180,80},{-40,80},{
          -40,6},{-10,6}},
                       color={0,127,255}));
  connect(hex.port_a2, port_a2) annotation (Line(points={{10,-6},{60,-6},{60,-60},
          {100,-60}}, color={0,127,255}));
  connect(effCal.uSpe, uSpe)
    annotation (Line(points={{-102,0},{-200,0}}, color={0,0,127}));
annotation (
   defaultComponentName="whe",
        Icon(coordinateSystem(extent={{-100,-100},{100,100}}),
   graphics={
        Polygon(
          points={{0,100},{0,100}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.None)}),
          Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},{100,100}})),
Documentation(info="<html>
<p>
Model of an enthalpy recovery wheel, which has the 
wheel speed as the input to control the heat recovery.
</p>
<p>
This model does not require geometric data. The performance is defined by specifying
the part load (75% of the nominal supply flow rate) and nominal sensible and latent
heat exchanger effectiveness in both heating and cooling conditions.
</p>
<p>
The operation of the heat recovery wheel is adjustable by modulating the wheel speed.
</p>
<p>
Accordingly, the power consumption of this wheel is calculated by
</p>
<p align=\"center\" style=\"font-style:italic;\">
P = P_nominal * (a<sub>1</sub> + a<sub>2</sub> uSpe + a<sub>3</sub> uSpe<sup>2</sup> + ...),
</p>
<p>
where <code>P_nominal</code> is the nominal wheel power consumption,
<code>uSpe</code> is the wheel speed ratio, 
and the <code>a[:]</code> are the coefficients for power efficiency curve.
The sum of the coefficients must be <i>1</i>, otherwise the model stops with an error.
Thus, when the speed ratio <code>uSpe=1</code>, the power consumption is equal to
nominal consumption <code>P=P_nominal</code>.
</p>
<p>
The sensible and latent effectiveness is calculated with
<a href=\"modelica://Buildings.Fluid.HeatExchangers.ThermalWheels.Latent.BaseClasses.Effectiveness\">
Buildings.Fluid.HeatExchangers.ThermalWheels.Latent.BaseClasses.Effectiveness</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
September 29, 2023, by Sen Huang:<br/>
First implementation.
</li>
</ul>
</html>"));
end SpeedControlled;
