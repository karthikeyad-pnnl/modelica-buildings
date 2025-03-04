within Buildings.Templates.Plants.HeatPumps_PNNL.Components.Controls;
block ExternalEnergyLoopOperationMode
  parameter Real THotRetLim;
  parameter Real TCooRetLim;
  parameter Real dTHotHys;
  parameter Real dTCooHys;
  Buildings.Controls.OBC.CDL.Interfaces.RealInput THotRet annotation (Placement(
        transformation(extent={{-140,-140},{-100,-100}}),
                                                     iconTransformation(extent={{-140,
            -40},{-100,0}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt(k=0)
    annotation (Placement(transformation(extent={{200,40},{220,60}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt1(k=3)
    annotation (Placement(transformation(extent={{160,-140},{180,-120}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt2(k=-2)
    annotation (Placement(transformation(extent={{160,-60},{180,-40}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerOutput yOpeMod annotation (
      Placement(transformation(extent={{280,-20},{320,20}}), iconTransformation(
          extent={{100,-20},{140,20}})));
  Buildings.Controls.OBC.CDL.Integers.Switch intSwi
    annotation (Placement(transformation(extent={{240,-10},{260,10}})));
  Buildings.Controls.OBC.CDL.Integers.Switch intSwi1
    annotation (Placement(transformation(extent={{200,-100},{220,-80}})));
  Buildings.Controls.OBC.CDL.Reals.Hysteresis hys1(
    uLow=THotRetLim - dTHotHys,
    uHigh=THotRetLim)
    annotation (Placement(transformation(extent={{-88,-130},{-68,-110}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput uReqHea annotation (
      Placement(transformation(extent={{-140,120},{-100,160}}),
        iconTransformation(extent={{-140,40},{-100,80}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput uReqCoo annotation (
      Placement(transformation(extent={{-140,-80},{-100,-40}}),
                                                             iconTransformation(
          extent={{-140,0},{-100,40}})));
  Buildings.Controls.OBC.CDL.Integers.Subtract intSub
    annotation (Placement(transformation(extent={{-60,-74},{-40,-54}})));
  Buildings.Controls.OBC.CDL.Conversions.IntegerToReal intToRea
    annotation (Placement(transformation(extent={{-30,-74},{-10,-54}})));
  Buildings.Controls.OBC.CDL.Reals.Hysteresis hys2(uLow=-0.5, uHigh=0.5)
    annotation (Placement(transformation(extent={{0,-74},{20,-54}})));
  Buildings.Controls.OBC.CDL.Integers.GreaterThreshold intGreThr
    annotation (Placement(transformation(extent={{40,20},{60,40}})));
  Buildings.Controls.OBC.CDL.Integers.GreaterThreshold intGreThr1(t=1)
    annotation (Placement(transformation(extent={{40,-20},{60,0}})));
  Buildings.Controls.OBC.CDL.Logical.And and2
    annotation (Placement(transformation(extent={{80,0},{100,20}})));
  Buildings.Controls.OBC.CDL.Logical.Not not2
    annotation (Placement(transformation(extent={{160,10},{180,30}})));
  Buildings.Controls.OBC.CDL.Integers.Equal intEqu
    annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
  Buildings.Controls.OBC.CDL.Integers.Equal intEqu1
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt3(k=0)
    annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
  Buildings.Controls.OBC.CDL.Logical.And and1
    annotation (Placement(transformation(extent={{0,60},{20,80}})));
  Buildings.Controls.OBC.CDL.Logical.Or or1
    annotation (Placement(transformation(extent={{120,10},{140,30}})));
  Buildings.Controls.OBC.CDL.Logical.Not not3
    annotation (Placement(transformation(extent={{-40,-130},{-20,-110}})));
  Buildings.Controls.OBC.CDL.Logical.And and3
    annotation (Placement(transformation(extent={{160,-100},{180,-80}})));
  Buildings.Controls.OBC.CDL.Logical.Or or3
    annotation (Placement(transformation(extent={{200,-10},{220,10}})));
  Buildings.Controls.OBC.CDL.Integers.Equal intEqu2
    annotation (Placement(transformation(extent={{40,120},{60,140}})));
  Buildings.Controls.OBC.CDL.Logical.Not not5
    annotation (Placement(transformation(extent={{40,60},{60,80}})));
  Buildings.Controls.OBC.CDL.Logical.And and4
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
equation
  connect(conInt.y, intSwi.u3) annotation (Line(points={{222,50},{232,50},{232,
          -8},{238,-8}},
                    color={255,127,0}));
  connect(intSwi.y, yOpeMod) annotation (Line(points={{262,0},{300,0}},
               color={255,127,0}));
  connect(intSwi1.y, intSwi.u1) annotation (Line(points={{222,-90},{226,-90},{
          226,8},{238,8}},
                    color={255,127,0}));
  connect(THotRet, hys1.u)
    annotation (Line(points={{-120,-120},{-90,-120}},
                                                    color={0,0,127}));
  connect(uReqHea, intSub.u1) annotation (Line(points={{-120,140},{-86,140},{
          -86,-58},{-62,-58}},
                         color={255,127,0}));
  connect(uReqCoo, intSub.u2) annotation (Line(points={{-120,-60},{-90,-60},{
          -90,-70},{-62,-70}},
                         color={255,127,0}));
  connect(intSub.y, intToRea.u)
    annotation (Line(points={{-38,-64},{-32,-64}},
                                                 color={255,127,0}));
  connect(intToRea.y, hys2.u) annotation (Line(points={{-8,-64},{-2,-64}},
                                               color={0,0,127}));
  connect(conInt2.y, intSwi1.u1) annotation (Line(points={{182,-50},{192,-50},{
          192,-82},{198,-82}},
                          color={255,127,0}));
  connect(conInt1.y, intSwi1.u3) annotation (Line(points={{182,-130},{192,-130},
          {192,-98},{198,-98}},
                     color={255,127,0}));
  connect(uReqHea, intGreThr.u) annotation (Line(points={{-120,140},{-86,140},{
          -86,30},{38,30}},  color={255,127,0}));
  connect(uReqCoo, intGreThr1.u) annotation (Line(points={{-120,-60},{-90,-60},
          {-90,-10},{38,-10}},
                             color={255,127,0}));
  connect(intGreThr.y, and2.u1) annotation (Line(points={{62,30},{72,30},{72,10},
          {78,10}},      color={255,0,255}));
  connect(intGreThr1.y, and2.u2)
    annotation (Line(points={{62,-10},{72,-10},{72,2},{78,2}},
                                                          color={255,0,255}));
  connect(uReqHea, intEqu.u1) annotation (Line(points={{-120,140},{-86,140},{
          -86,80},{-42,80}},
                           color={255,127,0}));
  connect(uReqCoo, intEqu1.u2) annotation (Line(points={{-120,-60},{-90,-60},{
          -90,-10},{-50,-10},{-50,42},{-42,42}},
        color={255,127,0}));
  connect(conInt3.y, intEqu.u2) annotation (Line(points={{-58,60},{-50,60},{-50,
          72},{-42,72}},   color={255,127,0}));
  connect(conInt3.y, intEqu1.u1) annotation (Line(points={{-58,60},{-50,60},{
          -50,50},{-42,50}},   color={255,127,0}));
  connect(and2.y, or1.u2) annotation (Line(points={{102,10},{102,12},{118,12}},
                           color={255,0,255}));
  connect(not2.y, or3.u1) annotation (Line(points={{182,20},{190,20},{190,0},{
          198,0}},
                color={255,0,255}));
  connect(or3.y, intSwi.u2) annotation (Line(points={{222,0},{238,0}},
                                   color={255,0,255}));
  connect(hys1.y, not3.u) annotation (Line(points={{-66,-120},{-42,-120}},
                     color={255,0,255}));
  connect(hys1.y, or3.u2) annotation (Line(points={{-66,-120},{-48,-120},{-48,
          -88},{150,-88},{150,-8},{198,-8}},             color={255,0,255}));
  connect(intEqu.y, and1.u1) annotation (Line(points={{-18,80},{-8,80},{-8,70},
          {-2,70}},        color={255,0,255}));
  connect(intEqu1.y, and1.u2) annotation (Line(points={{-18,50},{-8,50},{-8,62},
          {-2,62}},        color={255,0,255}));
  connect(hys2.y, and3.u1) annotation (Line(points={{22,-64},{112,-64},{112,-90},
          {158,-90}},
                    color={255,0,255}));
  connect(and3.y, intSwi1.u2)
    annotation (Line(points={{182,-90},{198,-90}},
                                                 color={255,0,255}));
  connect(uReqHea, intEqu2.u1) annotation (Line(points={{-120,140},{-86,140},{
          -86,130},{38,130}},                      color={255,127,0}));
  connect(uReqCoo, intEqu2.u2) annotation (Line(points={{-120,-60},{-90,-60},{
          -90,122},{38,122}},
        color={255,127,0}));
  connect(and1.y, not5.u)
    annotation (Line(points={{22,70},{38,70}},   color={255,0,255}));
  connect(not5.y, and4.u2) annotation (Line(points={{62,70},{72,70},{72,82},{78,
          82}},               color={255,0,255}));
  connect(intEqu2.y, and4.u1)
    annotation (Line(points={{62,130},{72,130},{72,90},{78,90}},
                                                  color={255,0,255}));
  connect(and4.y, or1.u1) annotation (Line(points={{102,90},{112,90},{112,20},{
          118,20}},                   color={255,0,255}));
  connect(not3.y, and3.u2) annotation (Line(points={{-18,-120},{110,-120},{110,
          -98},{158,-98}}, color={255,0,255}));
  connect(or1.y, not2.u)
    annotation (Line(points={{142,20},{158,20}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -160},{280,160}}),                                  graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-160},{280,
            160}}), graphics={
        Rectangle(
          extent={{-88,156},{146,-28}},
          lineColor={28,108,200},
          pattern=LinePattern.Dash),
        Text(
          extent={{152,150},{242,108}},
          textColor={28,108,200},
          textString="Check enable
conditions for
heating-cooling mode",
          horizontalAlignment=TextAlignment.Left),
        Rectangle(
          extent={{-76,-44},{38,-76}},
          lineColor={238,46,47},
          pattern=LinePattern.Dash),
        Text(
          extent={{-80,14},{88,-86}},
          textColor={238,46,47},
          horizontalAlignment=TextAlignment.Left,
          textString="Check enable conditions for heating mode"),
        Text(
          extent={{-96,-120},{28,-176}},
          textColor={0,140,72},
          horizontalAlignment=TextAlignment.Left,
          textString="Check enable conditions
for external energy loop cooling"),
        Rectangle(
          extent={{-96,-104},{-10,-136}},
          lineColor={0,140,72},
          pattern=LinePattern.Dash)}));
end ExternalEnergyLoopOperationMode;
