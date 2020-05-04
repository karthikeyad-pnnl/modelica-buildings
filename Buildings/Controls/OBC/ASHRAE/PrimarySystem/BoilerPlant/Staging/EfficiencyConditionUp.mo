within Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Staging;
block EfficiencyConditionUp "Efficiency condition used in staging up and down"
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
  CDL.Interfaces.RealInput uQUpMin
    "Minimum capacity of the next available stage"
    annotation (Placement(transformation(extent={{-160,0},{-120,40}}),
        iconTransformation(extent={{-140,10},{-100,50}})));
  CDL.Interfaces.RealInput uUpMinFloSetPoi
    "Minimum flow setpoint for the next higher stage"
    annotation (Placement(transformation(extent={{-160,-80},{-120,-40}}),
        iconTransformation(extent={{-140,-50},{-100,-10}})));
  CDL.Continuous.Division div
    annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
  CDL.Interfaces.RealInput uQDes "Design heating capacity of current stage"
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
  CDL.Continuous.Hysteresis hys1(uLow=perNonConBoi - 0.1, uHigh=perNonConBoi)
    annotation (Placement(transformation(extent={{-30,70},{-10,90}})));
  CDL.Continuous.Hysteresis hys2(uLow=perConBoi - 0.1, uHigh=perConBoi)
    annotation (Placement(transformation(extent={{-30,10},{-10,30}})));
  CDL.Logical.TrueDelay truDel(delayTime=samPer, delayOnInit=true)
    annotation (Placement(transformation(extent={{0,10},{20,30}})));
  CDL.Logical.TrueDelay truDel1(delayTime=samPer, delayOnInit=true)
    annotation (Placement(transformation(extent={{0,70},{20,90}})));
  CDL.Interfaces.IntegerInput uTyp[nSta]
    "Matrix of boiler types for all stages (1 if non-condensing boilers are absent, 2 if present)"
    annotation (Placement(transformation(extent={{-160,-120},{-120,-80}}),
    iconTransformation(extent={{-140,-80},{-100,-40}})));
  CDL.Interfaces.IntegerInput uAvaUp
    "Stage number of next available higher stage"
    annotation (Placement(transformation(extent={{-160,-160},{-120,-120}}),
    iconTransformation(extent={{-140,-110},{-100,-70}})));
  CDL.Conversions.IntegerToReal intToRea[nSta]
    annotation (Placement(transformation(extent={{-100,-110},{-80,-90}})));
  CDL.Routing.RealExtractor extIndSig(nin=nSta)
    annotation (Placement(transformation(extent={{-60,-110},{-40,-90}})));
  CDL.Continuous.GreaterThreshold greThr(threshold=1)
    annotation (Placement(transformation(extent={{-20,-110},{0,-90}})));
  CDL.Logical.LogicalSwitch logSwi
    annotation (Placement(transformation(extent={{40,40},{60,60}})));
  CDL.Logical.And and2
    annotation (Placement(transformation(extent={{80,-10},{100,10}})));
  CDL.Logical.LogicalSwitch logSwi1
    annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
protected
  Buildings.Controls.OBC.CDL.Continuous.Add add(
    final k2=-1) "Subtracts part load ratios"
    annotation (Placement(transformation(extent={{-100,30},{-80,50}})));
  CDL.Continuous.Add                        add1(final k2=-1)
                 "Subtracts part load ratios"
    annotation (Placement(transformation(extent={{-100,-50},{-80,-30}})));
equation
  connect(add.u2, uQUpMin) annotation (Line(points={{-102,34},{-110,34},{-110,20},
          {-140,20}}, color={0,0,127}));
  connect(add.u1, uQReq) annotation (Line(points={{-102,46},{-110,46},{-110,60},
          {-140,60}}, color={0,0,127}));
  connect(div.u1, add.y) annotation (Line(points={{-62,26},{-70,26},{-70,40},{-78,
          40}}, color={0,0,127}));
  connect(div.u2, uQUpMin) annotation (Line(points={{-62,14},{-110,14},{-110,20},
          {-140,20}}, color={0,0,127}));
  connect(add2.u1, uQDes) annotation (Line(points={{-102,96},{-110,96},{-110,100},
          {-140,100}}, color={0,0,127}));
  connect(add2.u2, uQReq) annotation (Line(points={{-102,84},{-110,84},{-110,60},
          {-140,60}}, color={0,0,127}));
  connect(div1.u1, add2.y) annotation (Line(points={{-62,86},{-70,86},{-70,90},{
          -78,90}}, color={0,0,127}));
  connect(div1.u2, uQDes) annotation (Line(points={{-62,74},{-114,74},{-114,100},
          {-140,100}}, color={0,0,127}));
  connect(add1.u1, uHotWatFloRat) annotation (Line(points={{-102,-34},{-110,-34},
          {-110,-20},{-140,-20}}, color={0,0,127}));
  connect(add1.u2, uUpMinFloSetPoi) annotation (Line(points={{-102,-46},{-110,-46},
          {-110,-60},{-140,-60}}, color={0,0,127}));
  connect(add1.y, div2.u1) annotation (Line(points={{-78,-40},{-70,-40},{-70,-44},
          {-62,-44}}, color={0,0,127}));
  connect(div2.u2, uUpMinFloSetPoi) annotation (Line(points={{-62,-56},{-110,-56},
          {-110,-60},{-140,-60}}, color={0,0,127}));
  connect(div2.y, hys.u)
    annotation (Line(points={{-38,-50},{-22,-50}}, color={0,0,127}));
  connect(div1.y, hys1.u)
    annotation (Line(points={{-38,80},{-32,80}}, color={0,0,127}));
  connect(div.y, hys2.u)
    annotation (Line(points={{-38,20},{-32,20}}, color={0,0,127}));
  connect(truDel1.u, hys1.y)
    annotation (Line(points={{-2,80},{-8,80}}, color={255,0,255}));
  connect(truDel.u, hys2.y) annotation (Line(points={{-2,20},{-6,20},{-6,20},{-8,
          20}}, color={255,0,255}));
  connect(intToRea.u, uTyp)
    annotation (Line(points={{-102,-100},{-140,-100}}, color={255,127,0}));
  connect(extIndSig.u, intToRea.y)
    annotation (Line(points={{-62,-100},{-78,-100}}, color={0,0,127}));
  connect(extIndSig.index, uAvaUp) annotation (Line(points={{-50,-112},{-50,-140},
          {-140,-140}}, color={255,127,0}));
  connect(greThr.u, extIndSig.y)
    annotation (Line(points={{-22,-100},{-38,-100}}, color={0,0,127}));
  connect(greThr.y, logSwi.u2) annotation (Line(points={{2,-100},{30,-100},{30,50},
          {38,50}}, color={255,0,255}));
  connect(truDel.y, logSwi.u3) annotation (Line(points={{22,20},{36,20},{36,42},
          {38,42}}, color={255,0,255}));
  connect(truDel1.y, logSwi.u1) annotation (Line(points={{22,80},{36,80},{36,58},
          {38,58}}, color={255,0,255}));
  connect(and2.y, yEffCon)
    annotation (Line(points={{102,0},{140,0}}, color={255,0,255}));
  connect(logSwi.y, and2.u1) annotation (Line(points={{62,50},{70,50},{70,0},{78,
          0}}, color={255,0,255}));
  connect(logSwi1.y, and2.u2) annotation (Line(points={{62,-30},{70,-30},{70,-8},
          {78,-8}}, color={255,0,255}));
  connect(con1.y, logSwi1.u1) annotation (Line(points={{2,-10},{36,-10},{36,-22},
          {38,-22}}, color={255,0,255}));
  connect(hys.y, logSwi1.u3) annotation (Line(points={{2,-50},{36,-50},{36,-38},
          {38,-38}}, color={255,0,255}));
  connect(logSwi1.u2, greThr.y) annotation (Line(points={{38,-30},{30,-30},{30,
          -100},{2,-100}}, color={255,0,255}));
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
end EfficiencyConditionUp;
