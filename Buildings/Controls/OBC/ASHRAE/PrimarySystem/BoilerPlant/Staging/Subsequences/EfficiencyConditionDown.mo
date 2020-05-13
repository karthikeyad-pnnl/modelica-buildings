within Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Staging.Subsequences;
block EfficiencyConditionDown
  "Efficiency condition used in staging up and down"
  parameter Integer nSta = 5 "Number of stages in the boiler plant";
  parameter Real perNonConBoi = 0.9 "Percentage value of B-Stage minimum at
  which the efficiency condition is satisfied for non-condensing boilers"
  annotation(Evaluate=true, Dialog(enable=nonConBoiOnl));
  parameter Real perConBoi = 0.9 "Percentage value of B-Stage minimum at
  which the efficiency condition is satisfied for condensing boilers"
  annotation(Evaluate=true, Dialog(enable=not
                                             (nonConBoiOnl)));
  parameter Real sigDif = 0.05
    "Signal hysteresis deadband";
  parameter Real samPer = 10*60
  "Sampling period for heating capacity and heating requirement";
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uQReq(final unit="1")
    "Heating capacity required"                      annotation (Placement(
        transformation(extent={{-160,40},{-120,80}}),iconTransformation(extent={{-140,70},
            {-100,110}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uHotWatFloRat(final unit="1")
    "Measured hot-water flow-rate" annotation (Placement(transformation(extent={
            {-160,-40},{-120,0}}), iconTransformation(extent={{-140,-20},{-100,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yEffCon
    "Efficiency condition for boiler staging" annotation (Placement(
        transformation(extent={{120,-20},{160,20}}), iconTransformation(extent={{100,-20},
            {140,20}})));
  CDL.Interfaces.RealInput uMinFloSetPoi
    "Minimum flow setpoint for the next higher stage" annotation (Placement(
        transformation(extent={{-160,-80},{-120,-40}}), iconTransformation(
          extent={{-140,-50},{-100,-10}})));
  CDL.Interfaces.RealInput uQMin "Design heating capacity of current stage"
    annotation (Placement(transformation(extent={{-160,80},{-120,120}}),
    iconTransformation(extent={{-140,40},{-100,80}})));
  CDL.Continuous.Add add2(k1=-1)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  CDL.Continuous.Division div1
    annotation (Placement(transformation(extent={{-60,70},{-40,90}})));
  CDL.Continuous.Division div2
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
  CDL.Continuous.Hysteresis hys(uLow=-0.1, uHigh=0)
    annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
  CDL.Logical.Sources.Constant con1(k=true)
    annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
  CDL.Continuous.Hysteresis hys1(uLow=perConBoi, uHigh=perConBoi + 0.1)
    annotation (Placement(transformation(extent={{-30,70},{-10,90}})));
  CDL.Logical.TrueDelay truDel1(delayTime=samPer, delayOnInit=true)
    annotation (Placement(transformation(extent={{40,70},{60,90}})));
  CDL.Logical.And and2
    annotation (Placement(transformation(extent={{80,-10},{100,10}})));
  CDL.Logical.LogicalSwitch logSwi1
    annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
  CDL.Logical.Not not1
    annotation (Placement(transformation(extent={{4,70},{24,90}})));
protected
  CDL.Continuous.Add                        add1(final k2=-1)
                 "Subtracts part load ratios"
    annotation (Placement(transformation(extent={{-100,-50},{-80,-30}})));
equation
  connect(add2.u1,uQMin)  annotation (Line(points={{-102,96},{-110,96},{-110,100},
          {-140,100}}, color={0,0,127}));
  connect(add2.u2, uQReq) annotation (Line(points={{-102,84},{-110,84},{-110,60},
          {-140,60}}, color={0,0,127}));
  connect(div1.u1, add2.y) annotation (Line(points={{-62,86},{-70,86},{-70,90},{
          -78,90}}, color={0,0,127}));
  connect(div1.u2,uQMin)  annotation (Line(points={{-62,74},{-114,74},{-114,100},
          {-140,100}}, color={0,0,127}));
  connect(add1.u1, uHotWatFloRat) annotation (Line(points={{-102,-34},{-110,-34},
          {-110,-20},{-140,-20}}, color={0,0,127}));
  connect(add1.u2, uMinFloSetPoi) annotation (Line(points={{-102,-46},{-110,-46},
          {-110,-60},{-140,-60}}, color={0,0,127}));
  connect(add1.y, div2.u1) annotation (Line(points={{-78,-40},{-70,-40},{-70,-44},
          {-62,-44}}, color={0,0,127}));
  connect(div2.u2, uMinFloSetPoi) annotation (Line(points={{-62,-56},{-110,-56},
          {-110,-60},{-140,-60}}, color={0,0,127}));
  connect(div2.y, hys.u)
    annotation (Line(points={{-38,-50},{-22,-50}}, color={0,0,127}));
  connect(div1.y, hys1.u)
    annotation (Line(points={{-38,80},{-32,80}}, color={0,0,127}));
  connect(and2.y, yEffCon)
    annotation (Line(points={{102,0},{140,0}}, color={255,0,255}));
  connect(logSwi1.y, and2.u2) annotation (Line(points={{62,-30},{70,-30},{70,-8},
          {78,-8}}, color={255,0,255}));
  connect(con1.y, logSwi1.u1) annotation (Line(points={{2,-10},{36,-10},{36,-22},
          {38,-22}}, color={255,0,255}));
  connect(hys.y, logSwi1.u3) annotation (Line(points={{2,-50},{36,-50},{36,-38},
          {38,-38}}, color={255,0,255}));
  connect(not1.u, hys1.y)
    annotation (Line(points={{2,80},{-8,80}}, color={255,0,255}));
  connect(not1.y, truDel1.u)
    annotation (Line(points={{26,80},{38,80}}, color={255,0,255}));
  connect(and2.u1, truDel1.y) annotation (Line(points={{78,0},{70,0},{70,80},{
          62,80}}, color={255,0,255}));
annotation (defaultComponentName = "effCon",
        Icon(coordinateSystem(extent={{-100,-100},{100,100}}),
             graphics={
        Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
        Text(
          extent={{-120,146},{100,108}},
          lineColor={0,0,255},
          textString="%name")}),
        Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-120,-160},{120,120}})),
Documentation(info="<html>
<p>Efficiency condition used in staging up and down for plants primary-only and primary-secondary plants, both with and without a water side economizer. implemented according to the specification provided in 5.2.4.15., 1711 March 2020 Draft. </p>
</html>",
revisions="<html>
<ul>
<li>
April 5, 2020, by Milica Grahovac:<br/>
First implementation.
</li>
</ul>
</html>"));
end EfficiencyConditionDown;
