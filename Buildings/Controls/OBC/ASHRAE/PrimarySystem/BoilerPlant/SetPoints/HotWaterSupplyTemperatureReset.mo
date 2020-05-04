within Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.SetPoints;
model HotWaterSupplyTemperatureReset
  parameter Real hotWatSetMax(final unit = "K", displayUnit = "K")
  "The maximum allowed hot-water setpoint temperature";
  parameter Real hotWatSetMin(final unit = "K", displayUnit = "K")
  "The minimum allowed hot-water setpoint temperature";
  parameter Real delTimVal(final unit = "s", displayUnit = "min")
  "Delay time";
  parameter Real samPerVal(final unit = "s", displayUnit = "min")
  "Sample period";
  parameter Integer nPum = 2
  "Number of pumps in the boiler plant loop";
  parameter Integer nHotWatResReqIgn = 2
  "Number of hot-water supply temperature reset requests to be ignored";
  parameter Real triAmoVal(start = -2/1.8, final unit = "K")
  "Setpoint trim value";
  parameter Real resAmoVal(start = 3/1.8, final unit = "K")
  "Setpoint respond value";
  parameter Real maxResVal(start = 7/1.8, final unit = "K")
  "Setpoint maximum respond value";
  parameter Real holTimVal(start = 15*60, final unit = "s", displayUnit = "min")
  "Minimum stage hold time";

public
  G36_PR1.Generic.SetPoints.TrimAndRespond triRes(
    iniSet=hotWatSetMax,
    minSet=hotWatSetMin,
    maxSet=hotWatSetMax,
    delTim=delTimVal,
    samplePeriod=samPerVal,
    numIgnReq=nHotWatResReqIgn,
    triAmo=triAmoVal,
    resAmo=resAmoVal,
    maxRes=maxResVal)
    "Trim and respond controller for hot water supply temperature setpoint"
    annotation (Placement(transformation(extent={{-26,22},{-6,42}})));
  CDL.Interfaces.IntegerInput nHotWatSupResReq
    "Number of hot-water supply temeprature reset requests"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  CDL.Interfaces.RealOutput THotWatSupSet(final unit = "K", displayUnit = "degF")
    "Hot-water supply temperature setpoint"
    annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  CDL.Interfaces.BooleanInput uStaCha
    "Signal indicating plant is in the staging process"
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
  CDL.Interfaces.BooleanInput uHotWatPumSta[nPum] "Status of hot-water pumps"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
  CDL.Logical.Edge edg "Detect start of stage change process"
    annotation (Placement(transformation(extent={{-50,-24},{-30,-4}})));
  CDL.Logical.TrueHoldWithReset truHol(duration=holTimVal)
    "Hold setpoint value for duration of stage change"
    annotation (Placement(transformation(extent={{-50,-50},{-30,-30}})));
  CDL.Discrete.TriggeredSampler triSam
    "Retain last value before stage change initiates"
    annotation (Placement(transformation(extent={{10,22},{30,42}})));
  CDL.Logical.Switch swi
    annotation (Placement(transformation(extent={{36,-10},{56,10}})));
  CDL.Logical.MultiOr mulOr(nu=nPum) "Check if any pumps are turned on"
    annotation (Placement(transformation(extent={{-54,30},{-34,50}})));
equation
  connect(uHotWatPumSta, mulOr.u[1:2]) annotation (Line(points={{-120,40},{-56,40}},
                                  color={255,0,255}));
  connect(mulOr.y, triRes.uDevSta)
    annotation (Line(points={{-32,40},{-28,40}},           color={255,0,255}));
  connect(triRes.y, triSam.u)
    annotation (Line(points={{-4,32},{8,32}},color={0,0,127}));
  connect(truHol.u, uStaCha)
    annotation (Line(points={{-52,-40},{-120,-40}},color={255,0,255}));
  connect(edg.u, uStaCha) annotation (Line(points={{-52,-14},{-56,-14},{-56,-40},
          {-120,-40}},color={255,0,255}));
  connect(edg.y, triSam.trigger) annotation (Line(points={{-28,-14},{20,-14},{20,
          20.2}}, color={255,0,255}));
  connect(triSam.y, swi.u1)
    annotation (Line(points={{32,32},{32,8},{34,8}},         color={0,0,127}));
  connect(swi.u3, triSam.u)
    annotation (Line(points={{34,-8},{0,-8},{0,32},{8,32}}, color={0,0,127}));
  connect(truHol.y, swi.u2) annotation (Line(points={{-28,-40},{30,-40},{30,0},{
          34,0}}, color={255,0,255}));
  connect(triRes.numOfReq, nHotWatSupResReq) annotation (Line(points={{-28,24},{
          -46,24},{-46,0},{-120,0}},color={255,127,0}));
  connect(swi.y, THotWatSupSet)
    annotation (Line(points={{58,0},{120,0}},color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
  Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                                                                                graphics={Rectangle(
          extent={{-100,100},{100,-100}},
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
<li>The setpoint controller is enabled when any of the hot-water supply pumps
are proven on <code>uHotWatPumSta = true</code>, and disabled otherwise.</li>
<li>When enabled, a Trim-and-Respond logic controller reduces the supply
temperature setpoint <code>THotWatSupSet</code> till it receives a sufficient
number of heating hot-water requests <code>nHotWatSupResReq</code> and resets the
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
