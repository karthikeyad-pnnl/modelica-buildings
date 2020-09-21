﻿within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Tower.Staging.Subsequences;
block CellsNumber
  "Sequence for identifying total number of enabling cells"

  parameter Boolean have_WSE = true
    "Flag to indicate if the plant has waterside economizer";
  parameter Integer nConWatPum = 2 "Total number of condenser water pumps";
  parameter Integer nTowCel = 4
    "Total number of cooling tower cells";
  parameter Integer totChiSta = 6
    "Total number of plant stages, stage zero should be counted as one stage";
  parameter Real staVec[totChiSta]={0,0.5,1,1.5,2,2.5}
    "Plant stage vector with size of total number of stages, element value like x.5 means chiller stage x plus WSE";
  parameter Real towCelOnSet[totChiSta] = {0,2,2,4,4,4}
    "Design number of tower fan cells that should be ON, according to current chiller stage and WSE status";
  parameter Real speChe = 0.01
    "Lower threshold value to check if condenser water pump is proven on"
    annotation (Dialog(tab="Advanced"));

  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput uChiSta
    "Current chiller stage"
    annotation (Placement(transformation(extent={{-300,80},{-260,120}}),
      iconTransformation(extent={{-140,70},{-100,110}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput uChiStaSet
    "Current chiller stage setpoint integer"
    annotation (Placement(transformation(extent={{-300,40},{-260,80}}),
      iconTransformation(extent={{-140,40},{-100,80}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uTowStaCha
    "Cooling tower stage change command from plant staging process"
    annotation (Placement(transformation(extent={{-300,0},{-260,40}}),
      iconTransformation(extent={{-140,0},{-100,40}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uWse if have_WSE
    "Water side economizer status: true = ON, false = OFF"
    annotation (Placement(transformation(extent={{-300,-60},{-260,-20}}),
      iconTransformation(extent={{-140,-40},{-100,0}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uLeaConWatPum
    "Enabling status of lead condenser water pump"
    annotation (Placement(transformation(extent={{-300,-140},{-260,-100}}),
      iconTransformation(extent={{-140,-80},{-100,-40}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uConWatPumSpe[nConWatPum](
      final unit=fill("1", nConWatPum)) "Current condenser water pump speed"
    annotation (Placement(transformation(extent={{-300,-180},{-260,-140}}),
        iconTransformation(extent={{-140,-110},{-100,-70}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerOutput yNumCel
    "Total number of enabled cells"
    annotation (Placement(transformation(extent={{260,-20},{300,20}}),
      iconTransformation(extent={{100,-20},{140,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yLeaCel
    "Lead tower cell status"
    annotation (Placement(transformation(extent={{260,-140},{300,-100}}),
      iconTransformation(extent={{100,-80},{140,-40}})));

  Buildings.Controls.OBC.CDL.Logical.Switch swi
    "Chiller stage index to identify total number of enabling cells"
    annotation (Placement(transformation(extent={{-120,90},{-100,110}})));

protected
  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToInt
    "Convert real input to integer output"
    annotation (Placement(transformation(extent={{220,-10},{240,10}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea1
    "Convert boolean input to real output"
    annotation (Placement(transformation(extent={{-160,-50},{-140,-30}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con2(
    final k=false) if not have_WSE
    "Constant false"
    annotation (Placement(transformation(extent={{-220,-80},{-200,-60}})));
  Buildings.Controls.OBC.CDL.Continuous.Add add3 "Add real inputs"
    annotation (Placement(transformation(extent={{-80,-30},{-60,-10}})));
  Buildings.Controls.OBC.CDL.Routing.RealReplicator reaRep(
    final nout=totChiSta) "Replicate real input"
    annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con4[totChiSta](
    final k=staVec) "Stage indicator array"
    annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
  Buildings.Controls.OBC.CDL.Continuous.Add add4[totChiSta](
    final k1=fill(1, totChiSta),
    final k2=fill(-1,totChiSta)) "Sum of real inputs"
    annotation (Placement(transformation(extent={{20,-50},{40,-30}})));
  Buildings.Controls.OBC.CDL.Continuous.GreaterEqualThreshold greEquThr[totChiSta](
    final threshold=fill(-0.1,totChiSta)) "Check stage indicator"
    annotation (Placement(transformation(extent={{60,-50},{80,-30}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToInteger booToInt[totChiSta]
    "Convert boolean input to integer"
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
  Buildings.Controls.OBC.CDL.Integers.MultiSum mulSumInt(
    final nin=totChiSta) "Sun of input vector "
    annotation (Placement(transformation(extent={{140,-50},{160,-30}})));
  Buildings.Controls.OBC.CDL.Routing.RealExtractor celOnNum(
    final nin=totChiSta)
    "Number of cells should be enabled at current plant stage"
    annotation (Placement(transformation(extent={{180,-10},{200,10}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con5[totChiSta](
    final k=towCelOnSet)
    "Number of enabling cells at each stage"
    annotation (Placement(transformation(extent={{140,-10},{160,10}})));
  Buildings.Controls.OBC.CDL.Continuous.Hysteresis proOn[nConWatPum](
    final uLow=fill(speChe, nConWatPum),
    final uHigh=fill(2*speChe, nConWatPum))
    "Check if the condenser water pump is proven on"
    annotation (Placement(transformation(extent={{-220,-170},{-200,-150}})));
  Buildings.Controls.OBC.CDL.Conversions.IntegerToReal intToRea1
    "Convert integer input to real"
    annotation (Placement(transformation(extent={{-220,130},{-200,150}})));
  Buildings.Controls.OBC.CDL.Conversions.IntegerToReal intToRea2
    "Convert integer input to real"
    annotation (Placement(transformation(extent={{-220,50},{-200,70}})));
  Buildings.Controls.OBC.CDL.Logical.Latch leaCel
    "Lead cell status"
    annotation (Placement(transformation(extent={{140,-130},{160,-110}})));
  Buildings.Controls.OBC.CDL.Logical.Not conPumOff
    "All condenser water pumps are off"
    annotation (Placement(transformation(extent={{80,-170},{100,-150}})));
  Buildings.Controls.OBC.CDL.Integers.Equal norOpe
    "Normal operation, not in the chiller stage changeprocess"
    annotation (Placement(transformation(extent={{-220,90},{-200,110}})));
  Buildings.Controls.OBC.CDL.Logical.Switch swi1
    "Chiller stage index in the staging process"
    annotation (Placement(transformation(extent={{-160,10},{-140,30}})));
  Buildings.Controls.OBC.CDL.Logical.MultiOr mulOr(
    final nu=nConWatPum)
    "Check if any condenser water pump is running"
    annotation (Placement(transformation(extent={{-140,-170},{-120,-150}})));

equation
  connect(uWse, booToRea1.u)
    annotation (Line(points={{-280,-40},{-162,-40}}, color={255,0,255}));
  connect(con2.y, booToRea1.u)
    annotation (Line(points={{-198,-70},{-180,-70},{-180,-40},{-162,-40}},
      color={255,0,255}));
  connect(booToRea1.y, add3.u2)
    annotation (Line(points={{-138,-40},{-120,-40},{-120,-26},{-82,-26}},
      color={0,0,127}));
  connect(add3.y, reaRep.u)
    annotation (Line(points={{-58,-20},{-42,-20}}, color={0,0,127}));
  connect(reaRep.y, add4.u1)
    annotation (Line(points={{-18,-20},{0,-20},{0,-34},{18,-34}},
      color={0,0,127}));
  connect(con4.y, add4.u2)
    annotation (Line(points={{-18,-70},{0,-70},{0,-46},{18,-46}},
      color={0,0,127}));
  connect(greEquThr.y, booToInt.u)
    annotation (Line(points={{82,-40},{98,-40}}, color={255,0,255}));
  connect(add4.y, greEquThr.u)
    annotation (Line(points={{42,-40},{58,-40}}, color={0,0,127}));
  connect(con5.y, celOnNum.u)
    annotation (Line(points={{162,0},{178,0}}, color={0,0,127}));
  connect(mulSumInt.y, celOnNum.index)
    annotation (Line(points={{162,-40},{190,-40},{190,-12}}, color={255,127,0}));
  connect(celOnNum.y, reaToInt.u)
    annotation (Line(points={{202,0},{218,0}}, color={0,0,127}));
  connect(booToInt.y, mulSumInt.u)
    annotation (Line(points={{122,-40},{138,-40}}, color={255,127,0}));
  connect(uConWatPumSpe, proOn.u)
    annotation (Line(points={{-280,-160},{-222,-160}}, color={0,0,127}));
  connect(uLeaConWatPum, leaCel.u)
    annotation (Line(points={{-280,-120},{138,-120}},  color={255,0,255}));
  connect(conPumOff.y, leaCel.clr)
    annotation (Line(points={{102,-160},{120,-160},{120,-126},{138,-126}},
      color={255,0,255}));
  connect(uChiSta, norOpe.u1)
    annotation (Line(points={{-280,100},{-222,100}}, color={255,127,0}));
  connect(norOpe.y, swi.u2)
    annotation (Line(points={{-198,100},{-122,100}}, color={255,0,255}));
  connect(intToRea1.y, swi.u1)
    annotation (Line(points={{-198,140},{-170,140},{-170,108},{-122,108}},
      color={0,0,127}));
  connect(uTowStaCha, swi1.u2)
    annotation (Line(points={{-280,20},{-162,20}}, color={255,0,255}));
  connect(uChiSta, intToRea1.u) annotation (Line(points={{-280,100},{-240,100},
          {-240,140},{-222,140}}, color={255,127,0}));
  connect(uChiStaSet, norOpe.u2) annotation (Line(points={{-280,60},{-240,60},{
          -240,92},{-222,92}}, color={255,127,0}));
  connect(uChiStaSet, intToRea2.u)
    annotation (Line(points={{-280,60},{-222,60}}, color={255,127,0}));
  connect(intToRea2.y, swi1.u1) annotation (Line(points={{-198,60},{-180,60},{
          -180,28},{-162,28}}, color={0,0,127}));
  connect(intToRea1.y, swi1.u3) annotation (Line(points={{-198,140},{-170,140},
          {-170,12},{-162,12}}, color={0,0,127}));
  connect(swi1.y, swi.u3) annotation (Line(points={{-138,20},{-130,20},{-130,92},
          {-122,92}}, color={0,0,127}));
  connect(swi.y, add3.u1) annotation (Line(points={{-98,100},{-90,100},{-90,-14},
          {-82,-14}}, color={0,0,127}));
  connect(reaToInt.y, yNumCel)
    annotation (Line(points={{242,0},{280,0}}, color={255,127,0}));
  connect(leaCel.y, yLeaCel)
    annotation (Line(points={{162,-120},{280,-120}}, color={255,0,255}));
  connect(proOn.y, mulOr.u) annotation (Line(points={{-198,-160},{-170,-160},{-170,
          -160},{-142,-160}},           color={255,0,255}));
  connect(mulOr.y, conPumOff.u)
    annotation (Line(points={{-118,-160},{78,-160}}, color={255,0,255}));

annotation (
  defaultComponentName="enaCelNum",
  Icon(coordinateSystem(extent={{-100,-100},{100,100}}),
       graphics={
        Text(
          extent={{-100,150},{100,110}},
          lineColor={0,0,255},
          textString="%name"),
        Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-96,-84},{-18,-96}},
          lineColor={0,0,127},
          textString="uConWatPumSpe"),
        Text(
          extent={{-96,-54},{-18,-66}},
          lineColor={255,0,255},
          textString="uLeaConWatPum"),
        Text(
          extent={{-98,-12},{-72,-26}},
          lineColor={255,0,255},
          textString="uWse"),
        Text(
          extent={{-98,26},{-40,14}},
          lineColor={255,0,255},
          textString="uTowStaCha"),
        Text(
          extent={{-98,66},{-44,54}},
          lineColor={255,127,0},
          textString="uChiStaSet"),
        Text(
          extent={{-100,96},{-56,84}},
          lineColor={255,127,0},
          textString="uChiSta"),
        Text(
          extent={{54,6},{98,-6}},
          lineColor={255,127,0},
          textString="yNumCel"),
        Text(
          extent={{56,-52},{98,-64}},
          lineColor={255,0,255},
          textString="yLeaCel")}),
  Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-260,-180},{260,180}}),
        graphics={
          Text(
          extent={{-228,178},{-106,158}},
          pattern=LinePattern.None,
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127},
          horizontalAlignment=TextAlignment.Right,
          textString="Identify total number of operation cells")}),
  Documentation(info="<html>
<p>
This block outputs total number of enabling tower cells according to current plant
stage and generates boolean output to enable or disable lead tower cell(s).
It is implemented according to 
ASHRAE RP-1711 Advanced Sequences of Operation for HVAC Systems Phase II –
Central Plants and Hydronic Systems (Draft on March 23, 2020), 
section 5.2.12.1,
</p>
<ul>
<li>item 2 which specifies number of enabled cooling tower cells according to
plant stage.
</li>
<li>item 3 and 4, which specifies when the cooling tower cells should be enabled 
and disabled.
</li>
</ul>
<p>
The number of enabled tower cells shall be set by chiller stage per the table below.
Note that the table would need to be edited by the system design team for each plant 
based on the condenser water flow per stage, number of towers in the plant, and 
tower minimum flow requirements.
</p>

<table summary=\"summary\" border=\"1\">
<tr>
<th>Chiller stage </th> 
<th>Number of enabled cells </th>  
</tr>
<tr>
<td align=\"center\">0</td>
<td align=\"center\">0</td>
</tr>
<tr>
<td align=\"center\">0+WSE</td>
<td align=\"center\">2</td>
</tr>
<tr>
<td align=\"center\">1</td>
<td align=\"center\">2</td>
</tr>
<tr>
<td align=\"center\">1+WSE</td>
<td align=\"center\">4</td>
</tr>
<tr>
<td align=\"center\">2</td>
<td align=\"center\">4</td>
</tr>
<tr>
<td align=\"center\">2+WSE</td>
<td align=\"center\">4</td>
</tr>
</table>
<br/>

<p>
If there is change of plant stage <code>uChiSta</code> or waterside economizer 
status <code>uWseSta</code>, the cells should be enabled or disabled as below:
</p>
<ul>
<li>
Lead cell(s) shall be enabled when the lead condenser water pump is enabled. Lead
cell(s) shall be disabled when all condenser water pumps are proven off.
</li>
<li>
Tower stage changes shall be initiated concurrently with condenser water pump stage
and/or condenser water pump speed changes. 
</li>
</ul>
<p>
The input <code>uTowStaCha</code> is the output from the chiller staging process.
They indicate in the chiller staging process (<code>uChiSta</code> &ne; <code>uChiStaSet</code>)
when to change the condenser water pump status so also stage the tower cells.
</p>
</html>", revisions="<html>
<ul>
<li>
September 12, 2019, by Jianjun Hu:<br/>
First implementation.
</li>
</ul>
</html>"));
end CellsNumber;
