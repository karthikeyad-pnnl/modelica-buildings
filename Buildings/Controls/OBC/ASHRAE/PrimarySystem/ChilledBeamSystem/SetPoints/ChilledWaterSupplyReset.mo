within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChilledBeamSystem.SetPoints;
block ChilledWaterSupplyReset
  "Sequence to generate static pressure setpoint for chilled water loop"

  parameter Integer nVal = 3
    "Number of chilled water control valves on chilled beam manifolds";

  parameter Integer nPum = 2
    "Number of chilled water pumps in chilled beam system";

  parameter Real valPosLowClo(
    final unit="1",
    displayUnit="1") = 0.45
    "Lower limit for sending one request to Trim-and-Respond logic"
    annotation(Dialog(group="Control valve parameters"));

  parameter Real valPosLowOpe(
    final unit="1",
    displayUnit="1") = 0.5
    "Upper limit for sending one request to Trim-and-Respond logic"
    annotation(Dialog(group="Control valve parameters"));

  parameter Real valPosHigClo(
    final unit="1",
    displayUnit="1") = 0.95
    "Lower limit for sending two requests to Trim-and-Respond logic"
    annotation(Dialog(group="Control valve parameters"));

  parameter Real valPosHigOpe(
    final unit="1",
    displayUnit="1") = 0.99
    "Upper limit for sending two requests to Trim-and-Respond logic"
    annotation(Dialog(group="Control valve parameters"));

  parameter Real chiWatStaPreMax(
    final unit="Pa",
    displayUnit="Pa",
    final quantity="Pressure") = 30000
    "Maximum chilled water loop static pressure setpoint"
    annotation(Dialog(group="Trim-and-Respond parameters"));

  parameter Real chiWatStaPreMin(
    final unit="Pa",
    displayUnit="Pa",
    final quantity="Pressure") = 20000
    "Minimum chilled water loop static pressure setpoint"
    annotation(Dialog(group="Trim-and-Respond parameters"));

  parameter Real triAmoVal(
    final unit="Pa",
    displayUnit="Pa",
    final quantity="PressureDifference") = -500
    "Static pressure trim amount"
    annotation(Dialog(group="Trim-and-Respond parameters"));

  parameter Real resAmoVal(
    final unit="Pa",
    displayUnit="Pa",
    final quantity="PressureDifference") = 750
    "Static pressure respond amount"
    annotation(Dialog(group="Trim-and-Respond parameters"));

  parameter Real maxResVal(
    final unit="Pa",
    displayUnit="Pa",
    final quantity="PressureDifference") = 1000
    "Static pressure maximum respond amount"
    annotation(Dialog(group="Trim-and-Respond parameters"));

  parameter Real samPerVal(
    final unit="s",
    displayUnit="s",
    final quantity="Duration") = 30
    "Sample period duration"
    annotation(Dialog(group="Trim-and-Respond parameters"));

  parameter Real delTimVal(
    final unit="s",
    displayUnit="min",
    final quantity="Duration") = 120
    "Delay period duration"
    annotation(Dialog(group="Trim-and-Respond parameters"));

  parameter Real thrTimLow(
    final unit="s",
    displayUnit="s",
    final quantity="Duration") = 60
    "Threshold time for generating one request"
    annotation(Dialog(group="Control valve parameters"));

  parameter Real thrTimHig(
    final unit="s",
    displayUnit="s",
    final quantity="Duration") = 30
    "Threshold time for generating two requests"
    annotation(Dialog(group="Control valve parameters"));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput uValPos(final unit=fill("1",
        nVal), displayUnit=fill("1", nVal))
    "Chilled water control valve position on chilled beams" annotation (
      Placement(transformation(extent={{-140,-20},{-100,20}}),
        iconTransformation(extent={{-140,-20},{-100,20}})));

  CDL.Interfaces.IntegerOutput yChiWatSupReq
    "Number of requests for chilled water supply"
    annotation (Placement(transformation(extent={{100,40},{140,80}})));
  CDL.Interfaces.IntegerOutput TChiWatSupReq
    "Number of requests for chilled water supply temperature reset"
    annotation (Placement(transformation(extent={{100,-60},{140,-20}})));
protected
  Buildings.Controls.OBC.CDL.Logical.Timer tim(final t=fill(thrTimLow, nVal))
    "Check if threshold time for generating one request has been exceeded"
    annotation (Placement(transformation(extent={{-50,70},{-30,90}})));

  Buildings.Controls.OBC.CDL.Logical.Timer tim1(final t=fill(thrTimHig, nVal))
    "Check if threshold time for generating two requests has been exceeded"
    annotation (Placement(transformation(extent={{-50,30},{-30,50}})));

  Buildings.Controls.OBC.CDL.Continuous.Hysteresis hys1(final uLow=fill(
        valPosLowCloReq, nVal), final uHigh=fill(valPosLowOpeReq, nVal))
    "Check if chilled water control valve is at limit required to send one request"
    annotation (Placement(transformation(extent={{-80,70},{-60,90}})));

  Buildings.Controls.OBC.CDL.Continuous.Hysteresis hys2(final uLow=fill(
        valPosHigClo, nVal), final uHigh=fill(valPosHigOpe, nVal))
    "Check if chilled water control valve is at limit required to send two requests"
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));

  Buildings.Controls.OBC.CDL.Conversions.BooleanToInteger booToInt
    "Boolean to Integer conversion"
    annotation (Placement(transformation(extent={{10,70},{30,90}})));

  Buildings.Controls.OBC.CDL.Conversions.BooleanToInteger booToInt1(
    final integerTrue=2)
    "Boolean to Integer conversion"
    annotation (Placement(transformation(extent={{10,30},{30,50}})));

  Buildings.Controls.OBC.CDL.Integers.Max maxInt
    "Find maximum integer output"
    annotation (Placement(transformation(extent={{40,50},{60,70}})));

protected
  CDL.Logical.Timer tim2(final t=fill(thrTimLow, nVal))
    "Check if threshold time for generating one request has been exceeded"
    annotation (Placement(transformation(extent={{-50,-30},{-30,-10}})));
  CDL.Logical.Timer tim3(final t=fill(thrTimHig, nVal))
    "Check if threshold time for generating two requests has been exceeded"
    annotation (Placement(transformation(extent={{-50,-70},{-30,-50}})));
  CDL.Continuous.Hysteresis hys3(final uLow=fill(valPosLowClo, nVal), final
      uHigh=fill(valPosLowOpe, nVal))
    "Check if chilled water control valve is at limit required to send one request"
    annotation (Placement(transformation(extent={{-80,-30},{-60,-10}})));
  CDL.Continuous.Hysteresis hys4(final uLow=fill(valPosHigClo, nVal), final
      uHigh=fill(valPosHigOpe, nVal))
    "Check if chilled water control valve is at limit required to send two requests"
    annotation (Placement(transformation(extent={{-80,-70},{-60,-50}})));
  CDL.Conversions.BooleanToInteger                        booToInt2
    "Boolean to Integer conversion"
    annotation (Placement(transformation(extent={{10,-30},{30,-10}})));
  CDL.Conversions.BooleanToInteger                        booToInt3(final
      integerTrue=2)
    "Boolean to Integer conversion"
    annotation (Placement(transformation(extent={{10,-70},{30,-50}})));
  CDL.Integers.Max                        maxInt1
    "Find maximum integer output"
    annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
equation

  connect(uValPos, hys1.u) annotation (Line(points={{-120,0},{-90,0},{-90,80},{
          -82,80}},  color={0,0,127}));

  connect(uValPos, hys2.u) annotation (Line(points={{-120,0},{-90,0},{-90,40},{
          -82,40}},  color={0,0,127}));

  connect(booToInt.y, maxInt.u1) annotation (Line(points={{32,80},{36,80},{36,
          66},{38,66}},
                    color={255,127,0}));

  connect(booToInt1.y, maxInt.u2) annotation (Line(points={{32,40},{36,40},{36,
          54},{38,54}},
                    color={255,127,0}));

  connect(hys1.y, tim.u)
    annotation (Line(points={{-58,80},{-52,80}},   color={255,0,255}));
  connect(hys2.y, tim1.u)
    annotation (Line(points={{-58,40},{-52,40}},   color={255,0,255}));
  connect(tim.passed, booToInt.u) annotation (Line(points={{-28,72},{-10,72},{
          -10,80},{8,80}}, color={255,0,255}));
  connect(tim1.passed, booToInt1.u) annotation (Line(points={{-28,32},{-10,32},
          {-10,40},{8,40}}, color={255,0,255}));
  connect(booToInt2.y, maxInt1.u1) annotation (Line(points={{32,-20},{36,-20},{
          36,-34},{38,-34}}, color={255,127,0}));
  connect(booToInt3.y, maxInt1.u2) annotation (Line(points={{32,-60},{36,-60},{
          36,-46},{38,-46}}, color={255,127,0}));
  connect(hys3.y, tim2.u)
    annotation (Line(points={{-58,-20},{-52,-20}}, color={255,0,255}));
  connect(hys4.y,tim3. u)
    annotation (Line(points={{-58,-60},{-52,-60}}, color={255,0,255}));
  connect(tim2.passed, booToInt2.u) annotation (Line(points={{-28,-28},{-10,-28},
          {-10,-20},{8,-20}}, color={255,0,255}));
  connect(tim3.passed, booToInt3.u) annotation (Line(points={{-28,-68},{-10,-68},
          {-10,-60},{8,-60}}, color={255,0,255}));
  connect(uValPos, hys3.u) annotation (Line(points={{-120,0},{-90,0},{-90,-20},
          {-82,-20}}, color={0,0,127}));
  connect(uValPos, hys4.u) annotation (Line(points={{-120,0},{-90,0},{-90,-60},
          {-82,-60}}, color={0,0,127}));
  connect(maxInt.y, yChiWatSupReq)
    annotation (Line(points={{62,60},{120,60}}, color={255,127,0}));
  connect(maxInt1.y, TChiWatSupReq)
    annotation (Line(points={{62,-40},{120,-40}}, color={255,127,0}));
annotation(defaultComponentName="chiWatStaPreSetRes",
  Icon(coordinateSystem(preserveAspectRatio=false),
          graphics={
            Text(
              extent={{-100,150},{100,110}},
              lineColor={0,0,255},
              textString="%name"),
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={28,108,200},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-50,20},{50,-20}},
              lineColor={28,108,200},
              fillColor={255,255,255},
              fillPattern=FillPattern.None,
      textString="chiWatStaPreSetRes")}),
  Diagram(coordinateSystem(preserveAspectRatio=false)),
  Documentation(info="<html>
<p>
Sequences for calculating chilled water static pressure setpoint in chilled beam 
systems.
</p>
<p>
The trim-and-respond logic is activated if any of the chilled water control valves 
<code>uValPos</code> are open greater than <code>valPosOpe</code> and deactivated
if less than <code>valPosClo</code>. The requests for static pressure reset are
generated as follows:
<ul>
<li>
one request is generated if a control valve is open greater than <code>valPosLowOpe</code>
for <code>thrTimLow</code> continuously.
</li>
<li>
two requests are generated if a control valve is open greater than <code>valPosHigOpe</code>
for <code>thrTimHig</code> continuously.
</li>
<li>
no requests are generated otherwise.
</li>
</ul>
</p>
<p>
The trim-and-respond parameters are as follows:
<br>
<table summary=\"summary\" border=\"1\">
  <tr><th> Variable </th> <th> Value </th> <th> Definition </th> </tr>
  <tr><td>Device</td><td>Any chilled water pump</td> <td>Associated device</td></tr>
  <tr><td>iniSet</td><td><code>chiWatStaPreMax</code></td><td>Initial setpoint</td></tr>
  <tr><td>minSet</td><td><code>chiWatStaPreMin</code></td><td>Minimum setpoint</td></tr>
  <tr><td>maxSet</td><td><code>chiWatStaPreMax</code></td><td>Maximum setpoint</td></tr>
  <tr><td>delTim</td><td><code>delTimVal</code></td><td>Delay timer</td></tr>
  <tr><td>samplePeriod</td><td><code>samPerVal</code></td><td>Time step</td></tr>
  <tr><td>numIgnReq</td><td><code>0</code></td><td>Number of ignored requests</td></tr>
  <tr><td>triAmo</td><td><code>triAmoVal</code></td><td>Trim amount</td></tr>
  <tr><td>resAmo</td><td><code>resAmoVal</code></td><td>Respond amount</td></tr>
  <tr><td>maxRes</td><td><code>maxResVal</code></td><td>Maximum response per time interval</td></tr>
</table>
</p>
</html>",
revisions="<html>
<ul>
<li>
June 16, 2021, by Karthik Devaprasad:<br/>
First implementation.
</li>
</ul>
</html>"));
end ChilledWaterSupplyReset;
