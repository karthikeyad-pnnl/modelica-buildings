within Buildings.Controls.OBC.ASHRAE.G36_PR1.BoilerPlant.SetPoints;
model HotWaterSupplyTemperatureReset
  parameter Modelica.SIunits.Temperature hotWatSetMax
  "The maximum allowed hot-water setpoint temperature (in deg. C)";
  parameter Modelica.SIunits.Temperature hotWatSetMin
  "The minimum allowed hot-water setpoint temperature (in deg. C)";
  parameter Modelica.SIunits.Time delTimVal
  "Delay time (in seconds)";
  parameter Modelica.SIunits.Time samPerVal
  "Sample period (in seconds)";

  Generic.SetPoints.TrimAndRespond triRes(
    iniSet=hotWatSetMax,
    minSet=hotWatSetMin,
    maxSet=hotWatSetMax,
    delTim=600,
    samplePeriod=300,
    numIgnReq=2,
    triAmo=-2/1.8,
    resAmo=3/1.8,
    maxRes=7/1.8)
    "Trim and respond controller for hot water supply temperature setpoint"
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  CDL.Interfaces.BooleanInput uPumProSig_a
    "Signal indicating lead pump is proved on"
    annotation (Placement(transformation(extent={{-100,20},{-60,60}})));
  CDL.Interfaces.BooleanInput uPumProSig_b
    "Signal indicating lag pump is proved on"
    annotation (Placement(transformation(extent={{-100,-20},{-60,20}})));
  CDL.Logical.Or or2 "Check to see if either pump is proved on"
    annotation (Placement(transformation(extent={{-30,-2},{-10,18}})));
  CDL.Interfaces.IntegerInput uNumHotWatReq
    "Number of heating hot-water requests"
    annotation (Placement(transformation(extent={{-100,-60},{-60,-20}})));
  CDL.Interfaces.RealOutput hotWatSupTemSet
    "Hot-water supply temperature setpoint"
    annotation (Placement(transformation(extent={{60,-20},{100,20}})));
equation
  connect(or2.u2, uPumProSig_b)
    annotation (Line(points={{-32,0},{-80,0}}, color={255,0,255}));
  connect(or2.y, triRes.uDevSta)
    annotation (Line(points={{-8,8},{8,8}}, color={255,0,255}));
  connect(triRes.numOfReq, uNumHotWatReq) annotation (Line(points={{8,-8},{-20,-8},
          {-20,-40},{-80,-40}}, color={255,127,0}));
  connect(triRes.y, hotWatSupTemSet)
    annotation (Line(points={{32,0},{80,0}}, color={0,0,127}));
  connect(or2.u1, uPumProSig_a) annotation (Line(points={{-32,8},{-40,8},{-40,40},
          {-80,40}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-60,-60},
            {60,60}}), graphics={Rectangle(
          extent={{-60,60},{60,-60}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-50,20},{50,-20}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.None,
          textString="hotWatSupTemRes")}),                       Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-60,-60},{60,60}})),
  Documentation(info="<html>
<p>
Control sequence for hot-water supply temperature setpoint <code>hotWatSupTemSet</code>
for boiler plant loop.
</p>
<h4>Boiler plant loop: Control of hot-water supply temperature setpoint</h4>
<ol>
<li>The setpoint controller is enabled when either of the hot-water supply pumps
is proven on <code>uPumProSig = true</code>, and disabled otherwise.</li>
<li>When enabled, a Trim-and-Respond logic controller reduces the supply
temperature setpoint <code>hotWatSupTemSet</code> till it receives a sufficient
number of heating hot-water requests <code>uNumHotWatReq</code> and resets the
supply temperature setpoint to the initial value <code>hotWatSetMax</code>.
</li>
</ol>
</html>", revisions="<html>
<ul>
<li>
February 23, 2020, by Karthik Devaprasad:<br/>
First implementation.
</li>
</ul>
</html>"));
end HotWaterSupplyTemperatureReset;
