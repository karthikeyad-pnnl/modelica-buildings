within Buildings.Experimental.OpenBuildingControl.CDL.Continuous;
block Truncation
  "Discards the fractional portion of input and provides a whole number output"

  Interfaces.RealInput u "Connector of Real input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}}),
        iconTransformation(extent={{-140,-20},{-100,20}})));

  Interfaces.IntegerOutput y "Connector of Integer output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}}),
        iconTransformation(extent={{100,-10},{120,10}})));

equation
  y = if (u > 0) then integer(u) else integer(u + 1.0);
  annotation (
    defaultComponentName="tru",
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
                                Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
        Line(points={{0,68},{0,-80}},     color={192,192,192}),
        Polygon(
          points={{0,90},{-8,68},{8,68},{0,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-90,0},{82,0}},     color={192,192,192}),
        Polygon(
          points={{90,0},{68,8},{68,-8},{90,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-99,-44},{-66,-44}}),
        Line(points={{-67,-22},{-34,-22}}),
        Line(points={{-33,0},{0,0}}),
        Line(points={{-1,0},{32,0}}),
        Line(points={{33,24},{66,24}}),
        Line(points={{65,46},{98,46}}),
        Text(
          lineColor={0,0,255},
          extent={{-150,110},{150,150}},
          textString="%name")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}})),
    Documentation(info="<html>
<p>
Block that outputs the input, truncated to the next smallest integer if the input is positive,
or the next largest integer if the input is negative.
</p>

</html>", revisions="<html>
<ul>
<li>
March 31, 2017, by Jianjun Hu:<br/>
Change block output from <code>Interfaces.RealOutput</code>
to <code>Interfaces.IntegerOutput</code>.
</li>
</ul>
<ul>
<li>
March 22, 2017, by Jianjun Hu:<br/>
First implementation, based on the implementation of the
Modelica Standard Library.
</li>
</ul>
</html>"));
end Truncation;
