within Buildings.Fluid.HeatExchangers.ThermalWheels.Sensible.BaseClasses.Validation;
model Effectiveness
  "Test model for calculating the input effectiveness of a sensible heat exchanger"
  extends Modelica.Icons.Example;
  Buildings.Fluid.HeatExchangers.ThermalWheels.Sensible.BaseClasses.Effectiveness
    epsCal(
    epsCoo_nominal=0.8,
    epsCooPL=0.75,
    epsHea_nominal=0.7,
    epsHeaPL=0.6,
    VSup_flow_nominal=1) "Effectiveness calculator"
    annotation (Placement(transformation(extent={{-12,-10},{8,10}})));
  Modelica.Blocks.Sources.Ramp whSpe(
    height=0.7,
    duration=60,
    offset=0.3,
    startTime=60)
    "Wheel speed"
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Blocks.Sources.Ramp TSup(
    height=5,
    duration=60,
    offset=273.15 + 20,
    startTime=0)
    "Supply air temperature"
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  Modelica.Blocks.Sources.Ramp TExh(
    height=20,
    duration=60,
    offset=273.15 + 15,
    startTime=0)
    "Exhaust air temperature"
    annotation (Placement(transformation(extent={{-80,-90},{-60,-70}})));
  Modelica.Blocks.Sources.Ramp VSup(
    height=0.4,
    duration=60,
    offset=0.6,
    startTime=0)
    "Supply air flow rate"
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Modelica.Blocks.Sources.Ramp VExh(
    height=0.2,
    duration=60,
    offset=0.8,
    startTime=0)
    "Exhaust air flow rate"
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
equation
  connect(VSup.y, epsCal.VSup_flow)
    annotation (Line(points={{-59,70},{-28,70},{-28,8},{-14,8}}, color={0,0,127}));
  connect(VExh.y, epsCal.VExh_flow)
    annotation (Line(points={{-59,30},{-40,30},{-40,4},{-14,4}}, color={0,0,127}));
  connect(whSpe.y, epsCal.uSpe)
    annotation (Line(points={{-59,0},{-14,0}}, color={0,0,127}));
  connect(TSup.y, epsCal.TSup)
    annotation (Line(points={{-59,-40},{-40,-40},{-40,-4},{-14,-4}}, color={0,0,127}));
  connect(TExh.y, epsCal.TExh)
    annotation (Line(points={{-59,-80},{-28,-80},{-28,-8},{-14,-8}}, color={0,0,127}));

annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(Tolerance=1e-6, StopTime=120),
    __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Fluid/HeatExchangers/ThermalWheels/Sensible/BaseClasses/Validation/Effectiveness.mos"
        "Simulate and plot"),
Documentation(info="<html>
<p>
Validation test for the block
<a href=\"modelica://Buildings.Fluid.HeatExchangers.ThermalWheels.Sensible.BaseClasses.Effectiveness\">
Buildings.Fluid.HeatExchangers.ThermalWheels.Sensible.BaseClasses.Effectiveness</a>.
</p>
<p>
The input signals are configured as follows:
</p>
<ul>
<li>
In the first 20 seconds, the supply air temperature <i>TSup</i> is greater than
the exhaust air temperature <i>TExh</i>. After that,
<i>TSup</i> is less than <i>TExh</i>, leading to a heating mode.
</li>
<li>
In the first 60 seconds, the supply air flow rate, <i>VSup</i>, and the
exhaust air flow rate, <i>VExh</i>, change from 
0.6 to 1 and 0.8 to 1 respectively. The flow rates then stay constant.
</li>
<li> 
In the first 60 seconds, the wheel speed <i>uSpe</i> keeps constant.
It then increases from 0.3 to 1 during the period from 60 seconds to 120
seconds.
</li> 
</ul>
<p>
The expected outputs are:
</p>
<ul>
<li>
The sensible effectiveness <code>eps</code> increases in the whole
simulation period. 
</li>
<li>
At 20 seconds, <code>eps</code> changes significantly as the exchanger
changes from the cooling mode to the heating mode.
</li>
</ul>
</html>", revisions="<html>
<ul>
<li>
January 8, 2024, by Sen Huang:<br/>
First implementation.
</li>
</ul>
</html>"));
end Effectiveness;
