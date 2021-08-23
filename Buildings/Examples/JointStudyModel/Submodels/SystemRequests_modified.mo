within Buildings.Examples.JointStudyModel.Submodels;
block SystemRequests_modified
  "Output system requests for VAV reheat terminal unit control"

  parameter Real samplePeriod(
    final unit="s",
    final quantity="Time")=120
    "Sample period of component, set to the same value as the trim and respond that process yPreSetReq";

  parameter Boolean have_heaWatCoi
    "Flag, true if there is a hot water coil";
  parameter Boolean have_heaPla "Flag, true if there is a boiler plant";

  parameter Real errTZonCoo_1(
    final unit="K",
    final displayUnit="K",
    final quantity="TemperatureDifference")=2.8
    "Limit value of difference between zone temperature and cooling setpoint
    for generating 3 cooling SAT reset requests";
  parameter Real errTZonCoo_2(
    final unit="K",
    final displayUnit="K",
    final quantity="TemperatureDifference")=1.7
    "Limit value of difference between zone temperature and cooling setpoint
    for generating 2 cooling SAT reset requests";
  parameter Real errTDis_1(
    final unit="K",
    final displayUnit="K",
    final quantity="TemperatureDifference")=17
    "Limit value of difference between discharge air temperature and its setpoint
    for generating 3 hot water reset requests";
  parameter Real errTDis_2(
    final unit="K",
    final displayUnit="K",
    final quantity="TemperatureDifference")=8.3
    "Limit value of difference between discharge air temperature and its setpoint
    for generating 2 hot water reset requests";

  parameter Real durTimTem(
    final unit="s",
    final quantity="Time")=120
    "Duration time of zone temperature exceeds setpoint"
    annotation(Dialog(group="Duration times"));
  parameter Real durTimFlo(
    final unit="s",
    final quantity="Time")=60
    "Duration time of airflow rate less than setpoint"
    annotation(Dialog(group="Duration times"));
  parameter Real durTimDisAir(
    final unit="s",
    final quantity="Time")=300
    "Duration time of discharge air temperature is less than setpoint"
    annotation(Dialog(group="Duration times"));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput TDisHeaSet(
    final unit="K",
    final displayUnit="degC",
    final quantity="ThermodynamicTemperature") if have_heaWatCoi
    "Discharge airflow setpoint temperature for heating"
    annotation (Placement(transformation(extent={{-220,60},{-180,100}}),
        iconTransformation(extent={{-140,40},{-100,80}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TDis(
    final unit="K",
    final displayUnit="degC",
    final quantity="ThermodynamicTemperature") if have_heaWatCoi
    "Measured discharge airflow temperature"
    annotation (Placement(transformation(extent={{-220,-20},{-180,20}}),
        iconTransformation(extent={{-140,-20},{-100,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uHeaVal(
    final min=0,
    final max=1,
    final unit="1") if have_heaWatCoi "Heating valve position"
    annotation (Placement(transformation(extent={{-220,-80},{-180,-40}}),
        iconTransformation(extent={{-140,-80},{-100,-40}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerOutput yHeaValResReq if have_heaWatCoi
    "Hot water reset requests"
    annotation (Placement(transformation(extent={{180,30},{220,70}}),
        iconTransformation(extent={{100,30},{140,70}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerOutput yHeaPlaReq if (have_heaWatCoi and have_heaPla)
    "Heating plant request"
    annotation (Placement(transformation(extent={{180,-160},{220,-120}}),
        iconTransformation(extent={{100,-70},{140,-30}})));
  Buildings.Controls.OBC.CDL.Continuous.Hysteresis hys8(
    final uLow=-0.1,
    final uHigh=0.1) if have_heaWatCoi
    "Check if discharge air temperature is errTDis_1 less than setpoint"
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  Buildings.Controls.OBC.CDL.Continuous.Hysteresis hys9(
    final uLow=-0.1,
    final uHigh=0.1) if have_heaWatCoi
    "Check if discharge air temperature is errTDis_2 less than setpoint"
    annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
  Buildings.Controls.OBC.CDL.Continuous.Hysteresis hys10(
    final uLow=0.85,
    final uHigh=0.95) if have_heaWatCoi
    "Check if valve position is greater than 0.95"
    annotation (Placement(transformation(extent={{-140,-70},{-120,-50}})));
  Buildings.Controls.OBC.CDL.Continuous.Hysteresis hys11(
    final uHigh=0.95,
    final uLow=0.1) if (have_heaWatCoi and have_heaPla)
    "Check if valve position is greater than 0.95"
    annotation (Placement(transformation(extent={{-140,-150},{-120,-130}})));

protected
  Buildings.Controls.OBC.CDL.Continuous.Add add6(final k2=-1) if have_heaWatCoi
    "Calculate difference of discharge temperature (plus errTDis_1) and its setpoint"
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  Buildings.Controls.OBC.CDL.Continuous.Add add7(final k2=-1) if have_heaWatCoi
    "Calculate difference of discharge temperature (plus errTDis_2) and its setpoint"
    annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  Buildings.Controls.OBC.CDL.Continuous.AddParameter addPar(
    final k=1,
    final p=errTDis_1) if have_heaWatCoi
    "Discharge temperature plus errTDis_1"
    annotation (Placement(transformation(extent={{-140,18},{-120,38}})));
  Buildings.Controls.OBC.CDL.Continuous.AddParameter addPar1(
    final k=1,
    final p=errTDis_2) if have_heaWatCoi
    "Discharge temperature plus errTDis_2"
    annotation (Placement(transformation(extent={{-140,-40},{-120,-20}})));
  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToInt2 if have_heaWatCoi
    "Convert real to integer value"
    annotation (Placement(transformation(extent={{140,40},{160,60}})));
  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToInt3 if (have_heaWatCoi and
    have_heaPla)
    "Convert real to integer value"
    annotation (Placement(transformation(extent={{140,-150},{160,-130}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant thrHeaResReq(
    final k=3) if have_heaWatCoi
    "Constant 3"
    annotation (Placement(transformation(extent={{40,70},{60,90}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant twoHeaResReq(
    final k=2) if have_heaWatCoi
    "Constant 2"
    annotation (Placement(transformation(extent={{40,10},{60,30}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant oneHeaResReq(
    final k=1) if have_heaWatCoi
    "Constant 1"
    annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant zerHeaResReq(
    final k=0) if have_heaWatCoi
    "Constant 0"
    annotation (Placement(transformation(extent={{40,-90},{60,-70}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant zerBoiPlaReq(
    final k=0) if (have_heaWatCoi
     and have_heaPla)
    "Constant 0"
    annotation (Placement(transformation(extent={{40,-170},{60,-150}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant oneBoiPlaReq(
    final k=1) if (have_heaWatCoi and have_heaPla)
    "Constant 1"
    annotation (Placement(transformation(extent={{40,-130},{60,-110}})));
  Buildings.Controls.OBC.CDL.Logical.Switch swi7 if have_heaWatCoi
    "Output 3 or other request "
    annotation (Placement(transformation(extent={{100,40},{120,60}})));
  Buildings.Controls.OBC.CDL.Logical.Switch swi8 if have_heaWatCoi
    "Output 2 or other request "
    annotation (Placement(transformation(extent={{100,-20},{120,0}})));
  Buildings.Controls.OBC.CDL.Logical.Switch swi9 if have_heaWatCoi
    "Output 0 or 1 request "
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
  Buildings.Controls.OBC.CDL.Logical.Switch swi10 if (have_heaWatCoi and
    have_heaPla)
    "Output 0 or 1 request "
    annotation (Placement(transformation(extent={{100,-150},{120,-130}})));
  Buildings.Controls.OBC.CDL.Logical.TrueDelay tim4(delayTime=durTimDisAir) if have_heaWatCoi
    "Check if it is more than durTimDisAir"
    annotation (Placement(transformation(extent={{0,40},{20,60}})));
  Buildings.Controls.OBC.CDL.Logical.TrueDelay tim5(delayTime=durTimDisAir) if have_heaWatCoi
    "Check if it is more than durTimDisAir"
    annotation (Placement(transformation(extent={{0,-20},{20,0}})));

equation
  connect(TDis, addPar.u)
    annotation (Line(points={{-200,0},{-160,0},{-160,28},{-142,28}},
      color={0,0,127}));
  connect(addPar.y, add6.u2)
    annotation (Line(points={{-118,28},{-108,28},{-108,44},{-82,44}},
      color={0,0,127}));
  connect(TDisHeaSet, add6.u1)
    annotation (Line(points={{-200,80},{-100,80},{-100,56},{-82,56}},
      color={0,0,127}));
  connect(add6.y, hys8.u)
    annotation (Line(points={{-58,50},{-42,50}},     color={0,0,127}));
  connect(addPar1.y, add7.u2)
    annotation (Line(points={{-118,-30},{-108,-30},{-108,-16},{-82,-16}},
      color={0,0,127}));
  connect(add7.y, hys9.u)
    annotation (Line(points={{-58,-10},{-42,-10}},   color={0,0,127}));
  connect(hys9.y, tim5.u)
    annotation (Line(points={{-18,-10},{-2,-10}},   color={255,0,255}));
  connect(thrHeaResReq.y, swi7.u1)
    annotation (Line(points={{62,80},{80,80},{80,58},{98,58}},
      color={0,0,127}));
  connect(twoHeaResReq.y, swi8.u1)
    annotation (Line(points={{62,20},{80,20},{80,-2},{98,-2}},
      color={0,0,127}));
  connect(swi8.y, swi7.u3)
    annotation (Line(points={{122,-10},{140,-10},{140,30},{80,30},{80,42},{98,42}},
                  color={0,0,127}));
  connect(TDis, addPar1.u)
    annotation (Line(points={{-200,0},{-160,0},{-160,-30},{-142,-30}},
      color={0,0,127}));
  connect(TDisHeaSet, add7.u1)
    annotation (Line(points={{-200,80},{-100,80},{-100,-4},{-82,-4}},
      color={0,0,127}));
  connect(uHeaVal, hys10.u)
    annotation (Line(points={{-200,-60},{-142,-60}},   color={0,0,127}));
  connect(hys10.y, swi9.u2)
    annotation (Line(points={{-118,-60},{98,-60}},   color={255,0,255}));
  connect(oneHeaResReq.y, swi9.u1)
    annotation (Line(points={{62,-40},{80,-40},{80,-52},{98,-52}},
      color={0,0,127}));
  connect(zerHeaResReq.y, swi9.u3)
    annotation (Line(points={{62,-80},{80,-80},{80,-68},{98,-68}},
      color={0,0,127}));
  connect(swi9.y, swi8.u3)
    annotation (Line(points={{122,-60},{140,-60},{140,-30},{80,-30},{80,-18},{98,
          -18}},  color={0,0,127}));
  connect(swi7.y, reaToInt2.u)
    annotation (Line(points={{122,50},{138,50}},     color={0,0,127}));
  connect(reaToInt2.y, yHeaValResReq)
    annotation (Line(points={{162,50},{200,50}},     color={255,127,0}));
  connect(uHeaVal, hys11.u)
    annotation (Line(points={{-200,-60},{-160,-60},{-160,-140},{-142,-140}},
      color={0,0,127}));
  connect(hys11.y, swi10.u2)
    annotation (Line(points={{-118,-140},{98,-140}}, color={255,0,255}));
  connect(oneBoiPlaReq.y, swi10.u1)
    annotation (Line(points={{62,-120},{80,-120},{80,-132},{98,-132}},
      color={0,0,127}));
  connect(zerBoiPlaReq.y, swi10.u3)
    annotation (Line(points={{62,-160},{80,-160},{80,-148},{98,-148}},
      color={0,0,127}));
  connect(swi10.y, reaToInt3.u)
    annotation (Line(points={{122,-140},{138,-140}}, color={0,0,127}));
  connect(reaToInt3.y,yHeaPlaReq)
    annotation (Line(points={{162,-140},{200,-140}}, color={255,127,0}));
  connect(tim5.y, swi8.u2)
    annotation (Line(points={{22,-10},{98,-10}},   color={255,0,255}));
  connect(hys8.y, tim4.u)
    annotation (Line(points={{-18,50},{-2,50}},     color={255,0,255}));
  connect(tim4.y, swi7.u2)
    annotation (Line(points={{22,50},{98,50}},     color={255,0,255}));

annotation (
  defaultComponentName="sysReqRehBox",
  Diagram(coordinateSystem(preserveAspectRatio=
            false, extent={{-180,-180},{180,100}}),
      graphics={
        Rectangle(
          extent={{-158,88},{158,-88}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-158,-112},{158,-168}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Text(
          extent={{-152,-70},{-26,-90}},
          lineColor={0,0,255},
          horizontalAlignment=TextAlignment.Left,
          textString="Hot water reset requests"),
        Text(
          extent={{-150,-150},{-12,-172}},
          lineColor={0,0,255},
          horizontalAlignment=TextAlignment.Left,
          textString="Boiler plant reset requests")}),
     Icon(coordinateSystem(extent={{-100,-100},{100,100}}),
          graphics={
        Text(
          extent={{-100,140},{100,100}},
          lineColor={0,0,255},
          textString="%name"),
        Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
        Text(
          extent={{-98,68},{-52,52}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          visible = (have_heaWatCoi or have_heaPla),
          textString="TDisHeaSet"),
        Text(
          extent={{-98,4},{-64,-6}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          visible = (have_heaWatCoi or have_heaPla),
          textString="TDis"),
        Text(
          extent={{-98,-56},{-64,-66}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          visible = (have_heaWatCoi or have_heaPla),
          textString="uHeaVal"),
        Text(
          extent={{42,62},{98,42}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          horizontalAlignment=TextAlignment.Right,
          visible = have_heaWatCoi,
          textString="yHeaValResReq"),
        Text(
          extent={{58,-44},{98,-60}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          horizontalAlignment=TextAlignment.Right,
          visible = (have_heaWatCoi or have_heaPla),
          textString="yHeaPlaReq")}),
  Documentation(info="<html>
<p>
This sequence outputs the system reset requests, i.e.,
</p>
<ul>
<li>
the cooling supply air temperature
reset requests <code>yZonTemResReq</code>,
</li>
<li>
the static pressure reset requests
<code>yZonPreResReq</code>,
</li>
<li>
the hot water reset requests <code>yHeaValResReq</code>, and
</li>
<li>
the boiler plant reset requests <code>yHeaPlaReq</code>.
</li>
</ul>
<p>
The calculations are according to ASHRAE
Guideline 36 (G36), PART 5.E.9, in the steps shown below.
</p>
<h4>a. Cooling SAT reset requests <code>yZonTemResReq</code></h4>
<ol>
<li>
If the zone temperature <code>TZon</code> exceeds the zone cooling setpoint
<code>TZonCooSet</code> by 2.8 &deg;C (5 &deg;F)) for 2 minutes and after suppression
period due to setpoint change per G36 Part 5.A.20, send 3 requests
(<code>yZonTemResReq=3</code>).
</li>
<li>
Else if the zone temperature <code>TZon</code> exceeds the zone cooling setpoint
<code>TZonCooSet</code> by 1.7 &deg;C (3 &deg;F) for 2 minutes and after suppression
period due to setpoint change per G36 Part 5.A.20, send 2 requests
(<code>yZonTemResReq=3</code>).
</li>
<li>
Else if the cooling loop <code>uCoo</code> is greater than 95%, send 1 request
(<code>yZonTemResReq=1</code>) until <code>uCoo</code> is less than 85%.
</li>
<li>
Else if <code>uCoo</code> is less than 95%, send 0 request (<code>yZonTemResReq=0</code>).
</li>
</ol>
<h4>b. Static pressure reset requests <code>yZonPreResReq</code></h4>
<ol>
<li>
If the measured airflow <code>VDis_flow</code> is less than 50% of setpoint
<code>VDisSet_flow</code> while it is greater than zero for 1 minute, send 3 requests
(<code>yZonPreResReq=3</code>).
</li>
<li>
Else if the measured airflow <code>VDis_flow</code> is less than 70% of setpoint
<code>VDisSet_flow</code> while it is greater than zero for 1 minute, send 2 requests
(<code>yZonPreResReq=2</code>).
</li>
<li>
Else if the damper position <code>uDam</code> is greater than 95%, send 1 request
(<code>yZonPreResReq=1</code>) until <code>uDam</code> is less than 85%.
</li>
<li>
Else if <code>uDam</code> is less than 95%, send 0 request (<code>yZonPreResReq=0</code>).
</li>
</ol>
<h4>c. If there is a hot water coil (<code>have_heaWatCoi=true</code>),
hot water reset requests <code>yHeaValResReq</code></h4>
<ol>
<li>
If the discharge air temperature <code>TDis</code> is 17 &deg;C (30 &deg;F)
less than the setpoint <code>TDisHeaSet</code> for 5 minutes, send 3 requests
(<code>yHeaValResReq=3</code>).
</li>
<li>
Else if the discharge air temperature <code>TDis</code> is 8.3 &deg;C (15 &deg;F)
less than the setpoint <code>TDisHeaSet</code> for 5 minutes, send 2 requests
(<code>yHeaValResReq=2</code>).
</li>
<li>
Else if the hot water valve position <code>uHeaVal</code> is greater than 95%, send 1 request
(<code>yHeaValResReq=1</code>) until <code>uHeaVal</code> is less than 85%.
</li>
<li>
Else if <code>uHeaVal</code> is less than 95%, send 0 request (<code>yHeaValResReq=0</code>).
</li>
</ol>
<h4>d. If there is hot water coil (<code>have_heaWatCoi=true</code>) and a boiler plant
(<code>have_boiPla=true</code>), send the boiler plant that serves the zone a boiler
plant requests <code>yHeaPlaReq</code> as follows:</h4>
<ol>
<li>
If the hot water valve position <code>uHeaVal</code> is greater than 95%, send 1 request
(<code>yHeaPlaReq=1</code>) until <code>uHeaVal</code> is less than 10%.
</li>
<li>
Else if <code>uHeaVal</code> is less than 95%, send 0 request (<code>yHeaPlaReq=0</code>).
</li>
</ol>
<h4>Implementation</h4>
<p>
Some input signals are time sampled, because the output that is generated
from these inputs are used in the trim and respond logic, which
is also time sampled. However, signals that use a delay are not
sampled, as sampling were to change the dynamic response.
</p>
</html>", revisions="<html>
<ul>
<li>
September 13, 2017, by Jianjun Hu:<br/>
First implementation.
</li>
</ul>
</html>"));
end SystemRequests_modified;
