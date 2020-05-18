within Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Staging.Subsequences;
block Down "Generates a stage down signal"

  parameter Boolean primaryOnly = false
    "Is the boiler plant a primary-only, condensing boiler plant?";

  parameter Real curStaMinFirDel = 300
    "Delay for staging based on minimum firing ratio of current stage";

  parameter Real bypValConDel = 300 if primaryOnly
    "Enable delay for bypass valve position condition";

  parameter Real curStaMinFirPer = 130
    "Percentage ratio of QRequired to BFiringMin for minimum firing ratio condition";

  parameter Real lowStaDesCapPer =  80
    "Percentage ratio of QRequired to design capacity of next lower stage for lower design capacity ratio condition";

  parameter Real lowStaDesCapDelNonConBoi = 600
    "Enable delay for lower stage design capacity ratio condition for non-condensing boilers";

  parameter Real lowStaDesCapDelConBoi = 300
    "Enable delay for lower stage design capacity ratio condition for non-condensing boilers";

  parameter Real dFloRat = 0.1
    "Hysteresis deadband for measured flow-rate";

  parameter Real dTemp = 0.1
    "Hysteresis deadband for measured temperatures";

  parameter Real TCirDiff = 3
  "Required measured return water temperature difference between the primary and secondary circuits for staging down";

  parameter Real cirRetTemDiffDel = 300
    "Enable delay for measured hot water return temperature difference condition";

  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput y
    "Stage down signal"
    annotation (Placement(transformation(extent={{180,-10},{200,10}}),
        iconTransformation(extent={{100,-20},{140,20}})));

  CDL.Interfaces.RealInput THotWatSupSet
    "Hot water supply temperature setpoint"
    annotation (Placement(transformation(extent={{-220,130},{-180,170}})));
  CDL.Interfaces.RealInput THotWatSup "Measured hot water supply temperature"
    annotation (Placement(transformation(extent={{-220,100},{-180,140}})));
  CDL.Interfaces.BooleanInput uAvaLow
    "Signal indicating availability of next lower stage"
    annotation (Placement(transformation(extent={{-220,70},{-180,110}})));
  Subsequences.FailsafeCondition faiSafCon
    annotation (Placement(transformation(extent={{-160,112},{-140,130}})));
  CDL.Logical.Not not1
    annotation (Placement(transformation(extent={{-120,110},{-100,130}})));

  CDL.Interfaces.RealInput uQReq "Heating capacity required"
    annotation (Placement(transformation(extent={{-220,40},{-180,80}})));
  CDL.Interfaces.RealInput uQMin "Minimum firing capacity of current stage"
    annotation (Placement(transformation(extent={{-220,10},{-180,50}})));
  CDL.Continuous.Division div
    annotation (Placement(transformation(extent={{-140,34},{-120,54}})));
  CDL.Continuous.Hysteresis hys(uLow=curStaMinFirPer/100, uHigh=curStaMinFirPer/
        100 + 0.01)
    annotation (Placement(transformation(extent={{-110,34},{-90,54}})));
  CDL.Logical.TrueDelay truDel(delayTime=curStaMinFirDel)
    annotation (Placement(transformation(extent={{-50,34},{-30,54}})));
  CDL.Logical.Or or2 if primaryOnly
    annotation (Placement(transformation(extent={{0,10},{20,30}})));
  CDL.Interfaces.RealInput uBypValPos if primaryOnly
  "Bypass valve position"
    annotation (Placement(transformation(extent={{-220,-20},{-180,20}})));
  CDL.Continuous.GreaterThreshold greThr if primaryOnly
    annotation (Placement(transformation(extent={{-160,-10},{-140,10}})));
  CDL.Logical.TrueDelay truDel1(delayTime=bypValConDel) if
                                   primaryOnly
    annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));
  CDL.Interfaces.RealInput uQDowDes
    "Design capacity of the next lower available stage"
    annotation (Placement(transformation(extent={{-220,-50},{-180,-10}})));
  CDL.Continuous.Division div1
    annotation (Placement(transformation(extent={{-160,-50},{-140,-30}})));
  CDL.Continuous.Hysteresis hys1(uLow=lowStaDesCapPer/100, uHigh=
        lowStaDesCapPer/100 + 0.01)
    annotation (Placement(transformation(extent={{-120,-50},{-100,-30}})));
  CDL.Logical.TrueDelay truDel2(delayTime=lowStaDesCapDelNonConBoi)
    annotation (Placement(transformation(extent={{40,-30},{60,-10}})));
  CDL.Logical.And3 and3
    annotation (Placement(transformation(extent={{140,-10},{160,10}})));
  CDL.Interfaces.RealInput uPriCirFloRat if not primaryOnly
  "Measured primary circuit flow rate"
    annotation (Placement(transformation(extent={{-220,-80},{-180,-40}})));
  CDL.Interfaces.RealInput uMinPriPumSpe if not primaryOnly
    "Minimum primary pump speed for the current stage"
    annotation (Placement(transformation(extent={{-220,-110},{-180,-70}})));
  CDL.Continuous.Add add3(k2=-1) if not primaryOnly
    annotation (Placement(transformation(extent={{-160,-90},{-140,-70}})));
  CDL.Continuous.Hysteresis hys2(uLow=-dFloRat,
                                            uHigh=0) if not primaryOnly
    annotation (Placement(transformation(extent={{-120,-90},{-100,-70}})));
  CDL.Interfaces.RealInput TPriHotWatRet if not primaryOnly
    "Measured primary hot water return temperature"
    annotation (Placement(transformation(extent={{-220,-140},{-180,-100}})));
  CDL.Interfaces.RealInput TSecHotWatRet if not primaryOnly
    "Measured secondary hot water return temperature"
    annotation (Placement(transformation(extent={{-220,-170},{-180,-130}})));
  CDL.Continuous.Add add4(k2=-1) if not primaryOnly
    annotation (Placement(transformation(extent={{-160,-140},{-140,-120}})));
  CDL.Continuous.Hysteresis hys3(uLow=cirTempDiff - dTemp, uHigh=cirTempDiff) if
                                                       not primaryOnly
    annotation (Placement(transformation(extent={{-130,-140},{-110,-120}})));
  CDL.Logical.TrueDelay truDel3(delayTime=cirRetTemDiffDel) if
                                   not primaryOnly
    annotation (Placement(transformation(extent={{-100,-140},{-80,-120}})));
  CDL.Logical.And and2 if not primaryOnly
    annotation (Placement(transformation(extent={{-40,-108},{-20,-88}})));
  CDL.Logical.Or or1 if not primaryOnly
    annotation (Placement(transformation(extent={{0,-100},{20,-80}})));
  CDL.Logical.TrueDelay truDel4(delayTime=lowStaDesCapDelConBoi)
    annotation (Placement(transformation(extent={{40,-70},{60,-50}})));
  CDL.Logical.LogicalSwitch logSwi
    annotation (Placement(transformation(extent={{80,-50},{100,-30}})));
  CDL.Logical.Sources.Constant con1(k=true) if not primaryOnly
    annotation (Placement(transformation(extent={{80,-80},{100,-60}})));
  CDL.Interfaces.IntegerInput uTyp[nSta]
    "Type matrix to identify boiler types in each stage"
    annotation (Placement(transformation(extent={{-220,130},{-180,170}},
                                         rotation=90,
        origin={0,-20})));
  CDL.Interfaces.IntegerInput uAvaDow "Next available lower stage"
    annotation (Placement(transformation(extent={{-220,90},{-180,130}},
                                         rotation=90,
        origin={0,-20})));
  CDL.Routing.RealExtractor extIndSig(nin=nSta)
    annotation (Placement(transformation(extent={{-100,-180},{-80,-160}})));
  CDL.Conversions.IntegerToReal intToRea[nSta]
    annotation (Placement(transformation(extent={{-140,-180},{-120,-160}})));
  CDL.Continuous.GreaterThreshold greThr1(threshold=1)
    annotation (Placement(transformation(extent={{-60,-180},{-40,-160}})));
  CDL.Logical.LogicalSwitch logSwi1 if not primaryOnly
    annotation (Placement(transformation(extent={{120,-100},{140,-80}})));
  CDL.Logical.Not not2
    annotation (Placement(transformation(extent={{-80,34},{-60,54}})));
  CDL.Logical.Not not3
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
equation
  connect(faiSafCon.TSupSet, THotWatSupSet) annotation (Line(points={{-162,125},
          {-176,125},{-176,150},{-200,150}}, color={0,0,127}));
  connect(faiSafCon.TSup, THotWatSup)
    annotation (Line(points={{-162,120},{-200,120}}, color={0,0,127}));
  connect(faiSafCon.uAvaCur, uAvaLow) annotation (Line(points={{-162,115},{-174,
          115},{-174,90},{-200,90}}, color={255,0,255}));
  connect(not1.u, faiSafCon.y)
    annotation (Line(points={{-122,120},{-138,120}}, color={255,0,255}));
  connect(div.u2, uQMin) annotation (Line(points={{-142,38},{-150,38},{-150,30},
          {-200,30}}, color={0,0,127}));
  connect(hys.u, div.y)
    annotation (Line(points={{-112,44},{-118,44}},
                                                 color={0,0,127}));
  connect(or2.u1, truDel.y) annotation (Line(points={{-2,20},{-10,20},{-10,44},{
          -28,44}},  color={255,0,255}));
  connect(greThr.u, uBypValPos)
    annotation (Line(points={{-162,0},{-200,0}}, color={0,0,127}));
  connect(truDel1.y, or2.u2) annotation (Line(points={{-98,0},{-20,0},{-20,12},
          {-2,12}}, color={255,0,255}));
  connect(div1.u2, uQDowDes) annotation (Line(points={{-162,-46},{-172,-46},{-172,
          -30},{-200,-30}},                            color={0,0,127}));
  connect(hys1.u, div1.y)
    annotation (Line(points={{-122,-40},{-138,-40}},
                                                   color={0,0,127}));
  connect(and3.y, y)
    annotation (Line(points={{162,0},{190,0}}, color={255,0,255}));
  connect(and3.u1, not1.y) annotation (Line(points={{138,8},{120,8},{120,120},{
          -98,120}}, color={255,0,255}));
  connect(and3.u2, or2.y) annotation (Line(points={{138,0},{114,0},{114,20},{22,
          20}}, color={255,0,255}));
  connect(add3.u1, uPriCirFloRat) annotation (Line(points={{-162,-74},{-168,-74},
          {-168,-60},{-200,-60}}, color={0,0,127}));
  connect(add3.u2, uMinPriPumSpe) annotation (Line(points={{-162,-86},{-168,-86},
          {-168,-90},{-200,-90}}, color={0,0,127}));
  connect(hys2.u, add3.y)
    annotation (Line(points={{-122,-80},{-138,-80}}, color={0,0,127}));
  connect(add4.u1, TPriHotWatRet) annotation (Line(points={{-162,-124},{-168,
          -124},{-168,-120},{-200,-120}}, color={0,0,127}));
  connect(add4.u2, TSecHotWatRet) annotation (Line(points={{-162,-136},{-168,
          -136},{-168,-150},{-200,-150}}, color={0,0,127}));
  connect(hys3.u, add4.y)
    annotation (Line(points={{-132,-130},{-138,-130}}, color={0,0,127}));
  connect(truDel3.u, hys3.y)
    annotation (Line(points={{-102,-130},{-108,-130}},
                                                     color={255,0,255}));
  connect(and2.u1, hys2.y) annotation (Line(points={{-42,-98},{-50,-98},{-50,-80},
          {-98,-80}},      color={255,0,255}));
  connect(and2.u2, truDel3.y) annotation (Line(points={{-42,-106},{-50,-106},{-50,
          -130},{-78,-130}},     color={255,0,255}));
  connect(and2.y, or1.u2)
    annotation (Line(points={{-18,-98},{-2,-98}},   color={255,0,255}));
  connect(or1.u1, truDel.y) annotation (Line(points={{-2,-90},{-10,-90},{-10,44},
          {-28,44}}, color={255,0,255}));
  connect(truDel4.y, logSwi.u3) annotation (Line(points={{62,-60},{70,-60},{70,-48},
          {78,-48}}, color={255,0,255}));
  connect(truDel2.y, logSwi.u1)
    annotation (Line(points={{62,-20},{70,-20},{70,-32},{78,-32}},
                                                 color={255,0,255}));
  connect(logSwi.y, and3.u3) annotation (Line(points={{102,-40},{120,-40},{120,-8},
          {138,-8}}, color={255,0,255}));
  connect(intToRea.u, uTyp) annotation (Line(points={{-142,-170},{-150,-170},{-150,
          -220}}, color={255,127,0}));
  connect(intToRea.y, extIndSig.u)
    annotation (Line(points={{-118,-170},{-102,-170}}, color={0,0,127}));
  connect(uAvaDow, extIndSig.index) annotation (Line(points={{-110,-220},{-110,-190},
          {-90,-190},{-90,-182}}, color={255,127,0}));
  connect(greThr1.u, extIndSig.y)
    annotation (Line(points={{-62,-170},{-78,-170}}, color={0,0,127}));
  connect(greThr1.y, logSwi.u2) annotation (Line(points={{-38,-170},{74,-170},{74,
          -40},{78,-40}}, color={255,0,255}));
  connect(con1.y, logSwi1.u1) annotation (Line(points={{102,-70},{112,-70},{112,
          -82},{118,-82}}, color={255,0,255}));
  connect(or1.y, logSwi1.u3) annotation (Line(points={{22,-90},{70,-90},{70,-98},
          {118,-98}}, color={255,0,255}));
  connect(logSwi1.u2, logSwi.u2) annotation (Line(points={{118,-90},{74,-90},{74,
          -40},{78,-40}}, color={255,0,255}));
  connect(and3.u2, logSwi1.y) annotation (Line(points={{138,0},{114,0},{114,-20},
          {150,-20},{150,-90},{142,-90}}, color={255,0,255}));
  connect(div.u1, uQReq) annotation (Line(points={{-142,50},{-150,50},{-150,60},
          {-200,60}}, color={0,0,127}));
  connect(div1.u1, uQReq) annotation (Line(points={{-162,-34},{-166,-34},{-166,60},
          {-200,60}}, color={0,0,127}));
  connect(truDel.u, not2.y)
    annotation (Line(points={{-52,44},{-58,44}}, color={255,0,255}));
  connect(not2.u, hys.y)
    annotation (Line(points={{-82,44},{-88,44}}, color={255,0,255}));
  connect(hys1.y, not3.u)
    annotation (Line(points={{-98,-40},{-82,-40}}, color={255,0,255}));
  connect(not3.y, truDel2.u) annotation (Line(points={{-58,-40},{20,-40},{20,-20},
          {38,-20}}, color={255,0,255}));
  connect(truDel4.u, not3.y) annotation (Line(points={{38,-60},{20,-60},{20,-40},
          {-58,-40}}, color={255,0,255}));
  connect(greThr.y, truDel1.u)
    annotation (Line(points={{-138,0},{-122,0}}, color={255,0,255}));
  annotation (defaultComponentName = "staDow",
        Icon(coordinateSystem(extent={{-180,-200},{180,180}}),
             graphics={
        Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
        Text(
          extent={{-120,154},{100,116}},
          lineColor={0,0,255},
          textString="%name"),
        Rectangle(extent={{-80,-10},{-20,-22}}, lineColor={0,0,127}),
        Rectangle(extent={{-80,-28},{-20,-40}}, lineColor={0,0,127}),
        Rectangle(extent={{-76,-22},{-72,-28}}, lineColor={0,0,127}),
        Rectangle(extent={{-28,-22},{-24,-28}}, lineColor={0,0,127}),
        Rectangle(extent={{20,-10},{80,-22}}, lineColor={0,0,127}),
        Rectangle(extent={{20,-28},{80,-40}}, lineColor={0,0,127}),
        Rectangle(extent={{24,-22},{28,-28}}, lineColor={0,0,127}),
        Rectangle(extent={{72,-22},{76,-28}}, lineColor={0,0,127}),
        Rectangle(extent={{-80,30},{-20,18}}, lineColor={0,0,127}),
        Rectangle(extent={{-80,12},{-20,0}}, lineColor={0,0,127}),
        Rectangle(extent={{-76,18},{-72,12}}, lineColor={0,0,127}),
        Rectangle(extent={{-28,18},{-24,12}}, lineColor={0,0,127})}),
                                          Diagram(
        coordinateSystem(preserveAspectRatio=false,
        extent={{-180,-200},{180,180}})),
Documentation(info="<html>
<p>
Outputs a boolean stage down signal <code>y</code> when:
</p>
<ul>
<li>
Operating <code>uOpeDow</code> part load ratio of the next available stage down is below 
its staging <code>uStaDow</code> part load ratio for at least <code>parLoaRatDelay</code>, and
</li>
<li>
Failsafe condition is not <code>true</code>.
</li>
</ul>
<p>
If the plant has a WSE, staging from the lowest available chiller stage to 
WSE stage occurs when:
<ul>
<li>
WSE is enabled, and
</li>
<li>
The predicted WSE return temperature <code>TWsePre</code> is sufficently under the 
chilled water supply temperature setpoint <code>TChiWatSupSet</code> for defined periods of time, and 
</li>
<li>
Maximum cooling tower fan speed <code>uTowFanSpeMax</code> is below 100%
</li>
</ul>
<p>
The implementation is according to ASHRAE RP1711 March 2020 draft, section 5.2.4.15.
and can be used for both primary-only plants with and without a WSE.
</p>
</html>",
revisions="<html>
<ul>
<li>
January 02, 2020, by Milica Grahovac:<br/>
First implementation.
</li>
</ul>
</html>"));
end Down;
