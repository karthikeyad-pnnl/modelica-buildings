within Buildings.Templates.Plants.HeatPumps_PNNL.Components.Controls;
block ExternalEnergyLoopOperationMode
  parameter Real THotRetLim;
  parameter Real TCooRetLim;
  parameter Real dTHotHys;
  parameter Real dTCooHys;
  Buildings.Controls.OBC.CDL.Interfaces.RealInput THotRet annotation (Placement(
        transformation(extent={{-140,-80},{-100,-40}}),
                                                     iconTransformation(extent={{-140,
            -40},{-100,0}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt(k=0)
    annotation (Placement(transformation(extent={{50,10},{70,30}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt1(k=3)
    annotation (Placement(transformation(extent={{40,-80},{60,-60}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt2(k=-2)
    annotation (Placement(transformation(extent={{40,-20},{60,0}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerOutput yOpeMod annotation (
      Placement(transformation(extent={{120,20},{160,60}}),  iconTransformation(
          extent={{100,-20},{140,20}})));
  Buildings.Controls.OBC.CDL.Integers.Switch intSwi
    annotation (Placement(transformation(extent={{80,30},{100,50}})));
  Buildings.Controls.OBC.CDL.Integers.Switch intSwi1
    annotation (Placement(transformation(extent={{80,-50},{100,-30}})));
  Buildings.Controls.OBC.CDL.Reals.Hysteresis hys1(
    uLow=THotRetLim - dTHotHys,
    uHigh=THotRetLim)
    annotation (Placement(transformation(extent={{-88,-70},{-68,-50}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput uReqHea annotation (
      Placement(transformation(extent={{-140,114},{-100,154}}),
        iconTransformation(extent={{-140,40},{-100,80}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput uReqCoo annotation (
      Placement(transformation(extent={{-140,0},{-100,40}}), iconTransformation(
          extent={{-140,0},{-100,40}})));
  Buildings.Controls.OBC.CDL.Integers.Subtract intSub
    annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  Buildings.Controls.OBC.CDL.Conversions.IntegerToReal intToRea
    annotation (Placement(transformation(extent={{-50,-20},{-30,0}})));
  Buildings.Controls.OBC.CDL.Reals.Hysteresis hys2(uLow=-0.5, uHigh=0.5)
    annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
  Buildings.Controls.OBC.CDL.Integers.GreaterThreshold intGreThr
    annotation (Placement(transformation(extent={{-60,70},{-40,90}})));
  Buildings.Controls.OBC.CDL.Integers.GreaterThreshold intGreThr1(t=1)
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  Buildings.Controls.OBC.CDL.Logical.And and2
    annotation (Placement(transformation(extent={{-20,50},{0,70}})));
  Buildings.Controls.OBC.CDL.Logical.Not not2
    annotation (Placement(transformation(extent={{50,90},{70,110}})));
  Buildings.Controls.OBC.CDL.Integers.Equal intEqu
    annotation (Placement(transformation(extent={{-40,130},{-20,150}})));
  Buildings.Controls.OBC.CDL.Integers.Equal intEqu1
    annotation (Placement(transformation(extent={{-40,100},{-20,120}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt3(k=0)
    annotation (Placement(transformation(extent={{-80,110},{-60,130}})));
  Buildings.Controls.OBC.CDL.Logical.And and1
    annotation (Placement(transformation(extent={{-10,120},{10,140}})));
  Buildings.Controls.OBC.CDL.Logical.Or or1
    annotation (Placement(transformation(extent={{20,90},{40,110}})));
  Buildings.Controls.OBC.CDL.Logical.Not not3
    annotation (Placement(transformation(extent={{-50,-70},{-30,-50}})));
  Buildings.Controls.OBC.CDL.Logical.And and3
    annotation (Placement(transformation(extent={{20,-50},{40,-30}})));
  Buildings.Controls.OBC.CDL.Logical.Or or3
    annotation (Placement(transformation(extent={{86,90},{106,110}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TChiRet annotation (Placement(
        transformation(extent={{-140,-140},{-100,-100}}), iconTransformation(
          extent={{-140,-82},{-100,-42}})));
  Buildings.Controls.OBC.CDL.Reals.Hysteresis hys3(uLow=TCooRetLim, uHigh=
        TCooRetLim + dTCooHys)
    annotation (Placement(transformation(extent={{-90,-130},{-70,-110}})));
  Buildings.Controls.OBC.CDL.Logical.Not not1
    annotation (Placement(transformation(extent={{-50,-130},{-30,-110}})));
  Buildings.Controls.OBC.CDL.Logical.Or or2
    annotation (Placement(transformation(extent={{-12,-70},{8,-50}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant
                                         not4(k=false)
    annotation (Placement(transformation(extent={{-10,-126},{10,-106}})));
  Buildings.Controls.OBC.CDL.Integers.Equal intEqu2
    annotation (Placement(transformation(extent={{-40,170},{-20,190}})));
  Buildings.Controls.OBC.CDL.Logical.Not not5
    annotation (Placement(transformation(extent={{20,120},{40,140}})));
  Buildings.Controls.OBC.CDL.Logical.And and4
    annotation (Placement(transformation(extent={{20,170},{40,190}})));
equation
  connect(conInt.y, intSwi.u3) annotation (Line(points={{72,20},{76,20},{76,32},
          {78,32}}, color={255,127,0}));
  connect(intSwi.y, yOpeMod) annotation (Line(points={{102,40},{140,40}},
               color={255,127,0}));
  connect(intSwi1.y, intSwi.u1) annotation (Line(points={{102,-40},{108,-40},{
          108,56},{78,56},{78,48}},
                    color={255,127,0}));
  connect(THotRet, hys1.u)
    annotation (Line(points={{-120,-60},{-90,-60}}, color={0,0,127}));
  connect(uReqHea, intSub.u1) annotation (Line(points={{-120,134},{-86,134},{
          -86,-4},{-82,-4}},
                         color={255,127,0}));
  connect(uReqCoo, intSub.u2) annotation (Line(points={{-120,20},{-90,20},{-90,
          -16},{-82,-16}},
                         color={255,127,0}));
  connect(intSub.y, intToRea.u)
    annotation (Line(points={{-58,-10},{-52,-10}},
                                                 color={255,127,0}));
  connect(intToRea.y, hys2.u) annotation (Line(points={{-28,-10},{-22,-10}},
                                               color={0,0,127}));
  connect(conInt2.y, intSwi1.u1) annotation (Line(points={{62,-10},{70,-10},{70,
          -32},{78,-32}}, color={255,127,0}));
  connect(conInt1.y, intSwi1.u3) annotation (Line(points={{62,-70},{70,-70},{70,
          -48},{78,-48}},
                     color={255,127,0}));
  connect(uReqHea, intGreThr.u) annotation (Line(points={{-120,134},{-86,134},{
          -86,80},{-62,80}}, color={255,127,0}));
  connect(uReqCoo, intGreThr1.u) annotation (Line(points={{-120,20},{-90,20},{
          -90,40},{-62,40}}, color={255,127,0}));
  connect(intGreThr.y, and2.u1) annotation (Line(points={{-38,80},{-28,80},{-28,
          60},{-22,60}}, color={255,0,255}));
  connect(intGreThr1.y, and2.u2)
    annotation (Line(points={{-38,40},{-30,40},{-30,52},{-22,52}},
                                                          color={255,0,255}));
  connect(uReqHea, intEqu.u1) annotation (Line(points={{-120,134},{-84,134},{
          -84,140},{-42,140}},
                           color={255,127,0}));
  connect(uReqCoo, intEqu1.u2) annotation (Line(points={{-120,20},{-90,20},{-90,
          102},{-42,102}},
        color={255,127,0}));
  connect(conInt3.y, intEqu.u2) annotation (Line(points={{-58,120},{-50,120},{
          -50,132},{-42,132}},
                           color={255,127,0}));
  connect(conInt3.y, intEqu1.u1) annotation (Line(points={{-58,120},{-50,120},{
          -50,110},{-42,110}}, color={255,127,0}));
  connect(not2.u, or1.y)
    annotation (Line(points={{48,100},{42,100}},
                                               color={255,0,255}));
  connect(and2.y, or1.u2) annotation (Line(points={{2,60},{10,60},{10,92},{18,
          92}},            color={255,0,255}));
  connect(not2.y, or3.u1) annotation (Line(points={{72,100},{84,100}},
                color={255,0,255}));
  connect(or3.y, intSwi.u2) annotation (Line(points={{108,100},{114,100},{114,
          62},{72,62},{72,40},{78,40}},
                                   color={255,0,255}));
  connect(hys1.y, not3.u) annotation (Line(points={{-66,-60},{-52,-60}},
                     color={255,0,255}));
  connect(hys1.y, or3.u2) annotation (Line(points={{-66,-60},{-58,-60},{-58,-32},
          {6,-32},{6,86},{76,86},{76,92},{84,92}},       color={255,0,255}));
  connect(intEqu.y, and1.u1) annotation (Line(points={{-18,140},{-14,140},{-14,
          130},{-12,130}}, color={255,0,255}));
  connect(intEqu1.y, and1.u2) annotation (Line(points={{-18,110},{-14,110},{-14,
          122},{-12,122}}, color={255,0,255}));
  connect(TChiRet, hys3.u)
    annotation (Line(points={{-120,-120},{-92,-120}}, color={0,0,127}));
  connect(hys3.y, not1.u)
    annotation (Line(points={{-68,-120},{-52,-120}}, color={255,0,255}));
  connect(not3.y, or2.u1)
    annotation (Line(points={{-28,-60},{-14,-60}}, color={255,0,255}));
  connect(or2.y, and3.u2) annotation (Line(points={{10,-60},{10,-56},{18,-56},{
          18,-48}}, color={255,0,255}));
  connect(hys2.y, and3.u1) annotation (Line(points={{2,-10},{12,-10},{12,-40},{
          18,-40}}, color={255,0,255}));
  connect(and3.y, intSwi1.u2)
    annotation (Line(points={{42,-40},{78,-40}}, color={255,0,255}));
  connect(not4.y, or2.u2) annotation (Line(points={{12,-116},{18,-116},{18,-76},
          {-14,-76},{-14,-68}}, color={255,0,255}));
  connect(uReqHea, intEqu2.u1) annotation (Line(points={{-120,134},{-84,134},{
          -84,140},{-48,140},{-48,180},{-42,180}}, color={255,127,0}));
  connect(uReqCoo, intEqu2.u2) annotation (Line(points={{-120,20},{-90,20},{-90,
          102},{-48,102},{-48,144},{-46,144},{-46,166},{-42,166},{-42,172}},
        color={255,127,0}));
  connect(and1.y, not5.u)
    annotation (Line(points={{12,130},{18,130}}, color={255,0,255}));
  connect(not5.y, and4.u2) annotation (Line(points={{42,130},{48,130},{48,164},
          {18,164},{18,172}}, color={255,0,255}));
  connect(intEqu2.y, and4.u1)
    annotation (Line(points={{-18,180},{18,180}}, color={255,0,255}));
  connect(and4.y, or1.u1) annotation (Line(points={{42,180},{52,180},{52,114},{
          12,114},{12,100},{18,100}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}),                                        graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-160},{120,160}}),
                    graphics={
        Rectangle(
          extent={{-88,156},{44,24}},
          lineColor={28,108,200},
          pattern=LinePattern.Dash),
        Text(
          extent={{46,154},{122,124}},
          textColor={28,108,200},
          textString="Check enable
conditions for
heating-cooling mode",
          horizontalAlignment=TextAlignment.Left),
        Rectangle(
          extent={{-96,10},{18,-22}},
          lineColor={238,46,47},
          pattern=LinePattern.Dash),
        Text(
          extent={{-84,44},{40,-12}},
          textColor={238,46,47},
          horizontalAlignment=TextAlignment.Left,
          textString="Check enable conditions for heating mode"),
        Text(
          extent={{-96,-60},{28,-116}},
          textColor={0,140,72},
          horizontalAlignment=TextAlignment.Left,
          textString="Check enable conditions
for external energy loop cooling"),
        Rectangle(
          extent={{-96,-44},{-20,-76}},
          lineColor={0,140,72},
          pattern=LinePattern.Dash)}));
end ExternalEnergyLoopOperationMode;
