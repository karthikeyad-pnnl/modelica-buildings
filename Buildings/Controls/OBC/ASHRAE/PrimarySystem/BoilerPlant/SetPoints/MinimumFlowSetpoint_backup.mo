within Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.SetPoints;
block MinimumFlowSetpoint_backup "Hot water minimum flow setpoint"

  parameter Integer nBoi(
    final min=1) = 3
    "Total number of boilers";

  parameter Integer nSta(
    final min=1) = 5
    "Total number of stages";

  parameter Integer boiStaMat[nSta, nBoi] = {{1,0,0},{0,1,0},{1,1,0},{0,1,1},{1,1,1}}
    "Boiler staging matrix";

  parameter Real minFloSet[nBoi](
    final unit="m3/s",
    displayUnit="m3/s",
    final quantity="VolumeFlowRate",
    final min=1e-6,
    final max=maxFloSet) = {0.005, 0.005, 0.005}
    "Design minimum hot water flow through each boiler";

  parameter Real maxFloSet[nBoi](
    final unit="m3/s",
    displayUnit="m3/s",
    final quantity="VolumeFlowRate",
    final min=minFloSet) = {0.025, 0.025, 0.025}
    "Design maximum hot water flow through each boiler";

  CDL.Continuous.Sources.Constant con[nSta,nBoi](k=minFloSetMat)
    "Design minimum boiler flowrate"
    annotation (Placement(transformation(extent={{-120,110},{-100,130}})));
  CDL.Continuous.Sources.Constant con1[nSta,nBoi](k=maxFloSetMat)
    "Design maximum boiler flowrate"
    annotation (Placement(transformation(extent={{-120,70},{-100,90}})));
  CDL.Interfaces.IntegerInput uStaSet "Staging setpoint"
    annotation (Placement(transformation(extent={{-180,-130},{-140,-90}})));
  CDL.Interfaces.BooleanInput uOnOff
    "Signal indicating stage change with boilers being both enabled and disabled"
    annotation (Placement(transformation(extent={{-180,-50},{-140,-10}})));
  CDL.Continuous.Sources.Constant con2[nSta,nBoi](k=boiStaMat)
    "Boiler staging matrix"
    annotation (Placement(transformation(extent={{-120,40},{-100,60}})));
  CDL.Integers.Change cha
    annotation (Placement(transformation(extent={{-118,-120},{-98,-100}})));
  CDL.Interfaces.BooleanInput uStaChaPro
    "Signal indicating completion of stage change process"
    annotation (Placement(transformation(extent={{-180,-90},{-140,-50}})));
  CDL.Logical.Latch lat
    "Set minimum flow setpoint as per 5.3.8.2 if uOnOff=True, else as per 5.3.8.1"
    annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
  CDL.Logical.And and2 "Logical And"
    annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
  CDL.Continuous.Product pro[nSta,nBoi] "Element-wise product"
    annotation (Placement(transformation(extent={{-80,110},{-60,130}})));
  CDL.Continuous.Product pro1[nSta,nBoi] "Element-wise product"
    annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
  CDL.Continuous.Division div[nSta,nBoi] "Element-wise division"
    annotation (Placement(transformation(extent={{-20,104},{0,124}})));
  CDL.Continuous.AddParameter addPar[nSta,nBoi](p=1e-6, k=1)
    "Prevent divison by zero"
    annotation (Placement(transformation(extent={{-50,70},{-30,90}})));
  CDL.Continuous.MatrixMax matMax(
    rowMax=true,                  nRow=nSta, nCol=nBoi)
    annotation (Placement(transformation(extent={{20,104},{40,124}})));
  CDL.Continuous.MatrixGain matGai(K=boiStaMat)
    "Sum of maximum flowrates of operating boilers"
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  CDL.Continuous.Sources.Constant con3[nBoi](k=maxFloSet)
    "Design maximum boiler flowrate"
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  CDL.Continuous.Product pro2[nSta] "Element-wise product"
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  CDL.Routing.RealExtractor extIndSig(nin=nSta)
    "Extract minimum flow ratio of current setpoint during stage-up"
    annotation (Placement(transformation(extent={{60,104},{80,124}})));
  CDL.Routing.RealExtractor extIndSig1(nin=nSta)
    "Extract minimum flow ratio of previous setpoint during stage-up"
    annotation (Placement(transformation(extent={{60,70},{80,90}})));
  CDL.Integers.Add addInt(k2=-1)
    annotation (Placement(transformation(extent={{20,70},{40,90}})));
  CDL.Integers.Sources.Constant conInt(k=1) "Constant Integer source"
    annotation (Placement(transformation(extent={{-20,70},{0,90}})));
  CDL.Continuous.Max max
    annotation (Placement(transformation(extent={{100,90},{120,110}})));
  CDL.Routing.RealExtractor extIndSig2(nin=nSta)
    "Extract minimum flow ratio of current setpoint during stage-up"
    annotation (Placement(transformation(extent={{0,40},{20,60}})));
  CDL.Continuous.Add add2
    annotation (Placement(transformation(extent={{60,40},{80,60}})));
  CDL.Routing.RealExtractor extIndSig3(nin=nSta)
    "Extract minimum flow ratio of previous setpoint during stage-up"
    annotation (Placement(transformation(extent={{30,20},{50,40}})));
  CDL.Integers.Equal intEqu[nSta]
    "Compare index of stages to previous stage setpoint during stage-down"
    annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  CDL.Integers.Sources.Constant conInt1[nSta](k=staInd)
    "Constant Integer source"
    annotation (Placement(transformation(extent={{-110,-40},{-90,-20}})));
  CDL.Routing.IntegerReplicator intRep
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  CDL.Continuous.Add add1[nSta,nBoi](k1=fill(
        1,
        nSta,
        nBoi), k2=fill(
        -1,
        nSta,
        nBoi)) annotation (Placement(transformation(extent={{70,-10},{90,10}})));
  CDL.Conversions.BooleanToReal booToRea[nSta](realTrue=fill(1, nSta),
      realFalse=fill(0, nSta)) "Boolean to Real conversion"
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  CDL.Routing.RealReplicator reaRep[nSta](nout=fill(nBoi, nSta))
    "Replicate row vector into matrix"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  CDL.Continuous.Product pro3
                            [nSta,nBoi] "Element-wise product"
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  CDL.Continuous.LessThreshold lesThr[nSta,nBoi](threshold=fill(
        0,
        nSta,
        nBoi)) "Identify boiler being turned off"
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  CDL.Conversions.BooleanToReal booToRea1[nSta,nBoi](realTrue=fill(
        1,
        nSta,
        nBoi), realFalse=fill(
        0,
        nSta,
        nBoi)) "Convert Boolean to Real"
    annotation (Placement(transformation(extent={{-30,-40},{-10,-20}})));
  CDL.Continuous.Product pro4
                            [nSta,nBoi] "Element-wise product"
    annotation (Placement(transformation(extent={{10,-40},{30,-20}})));
  CDL.Continuous.MatrixMax matMax1(
    rowMax=true,
    nRow=nSta,
    nCol=nBoi)
    "Reduce matrix to row vector"
    annotation (Placement(transformation(extent={{50,-40},{70,-20}})));

protected
  parameter Integer boiInd[nBoi]={i for i in 1:nBoi}
    "Boiler index, {1,2,...,n}";

  parameter Integer staInd[nSta]={i for i in 1:nSta}
    "Stage index, {1,2,...,n}";

  parameter Real minFloSetMat[nSta, nBoi] = {minFloSet[i] for i in 1:nBoi, j in 1:nSta}
    "Boiler minimum design flowrate expanded for element-wise multiplication
    with the staging matrix";

  parameter Real maxFloSetMat[nSta, nBoi] = {maxFloSet[i] for i in 1:nBoi, j in 1:nSta}
    "Boiler maximum design flowrate expanded for element-wise multiplication
    with the staging matrix";

equation
  connect(uStaSet, cha.u)
    annotation (Line(points={{-160,-110},{-120,-110}},
                                                     color={255,127,0}));
  connect(lat.u, and2.y)
    annotation (Line(points={{-42,-70},{-58,-70}},
                                               color={255,0,255}));
  connect(uOnOff, and2.u1)
    annotation (Line(points={{-160,-30},{-120,-30},{-120,-70},{-82,-70}},
                                                color={255,0,255}));
  connect(cha.up, and2.u2) annotation (Line(points={{-96,-104},{-90,-104},{-90,-78},
          {-82,-78}},color={255,0,255}));
  connect(uStaChaPro, lat.clr) annotation (Line(points={{-160,-70},{-132,-70},{-132,
          -88},{-50,-88},{-50,-76},{-42,-76}},
                         color={255,0,255}));
  connect(con.y, pro.u1) annotation (Line(points={{-98,120},{-90,120},{-90,126},
          {-82,126}}, color={0,0,127}));
  connect(con2.y, pro.u2) annotation (Line(points={{-98,50},{-90,50},{-90,114},
          {-82,114}},color={0,0,127}));
  connect(con1.y, pro1.u1) annotation (Line(points={{-98,80},{-92,80},{-92,86},{
          -82,86}}, color={0,0,127}));
  connect(con2.y, pro1.u2) annotation (Line(points={{-98,50},{-90,50},{-90,74},
          {-82,74}},color={0,0,127}));
  connect(pro.y, div.u1)
    annotation (Line(points={{-58,120},{-22,120}}, color={0,0,127}));
  connect(pro1.y, addPar.u)
    annotation (Line(points={{-58,80},{-52,80}}, color={0,0,127}));
  connect(addPar.y, div.u2) annotation (Line(points={{-28,80},{-24,80},{-24,108},
          {-22,108}}, color={0,0,127}));
  connect(con3.y, matGai.u)
    annotation (Line(points={{-58,50},{-42,50}}, color={0,0,127}));
  connect(div.y, matMax.u)
    annotation (Line(points={{2,114},{18,114}}, color={0,0,127}));
  connect(matMax.y, extIndSig.u)
    annotation (Line(points={{42,114},{58,114}}, color={0,0,127}));
  connect(uStaSet, extIndSig.index) annotation (Line(points={{-160,-110},{-128,-110},
          {-128,100},{70,100},{70,102}}, color={255,127,0}));
  connect(matMax.y, extIndSig1.u) annotation (Line(points={{42,114},{50,114},{50,
          80},{58,80}}, color={0,0,127}));
  connect(conInt.y, addInt.u2) annotation (Line(points={{2,80},{10,80},{10,74},{
          18,74}}, color={255,127,0}));
  connect(uStaSet, addInt.u1) annotation (Line(points={{-160,-110},{-128,-110},{
          -128,100},{10,100},{10,86},{18,86}}, color={255,127,0}));
  connect(extIndSig.y, max.u1) annotation (Line(points={{82,114},{90,114},{90,106},
          {98,106}}, color={0,0,127}));
  connect(extIndSig1.y, max.u2) annotation (Line(points={{82,80},{90,80},{90,94},
          {98,94}}, color={0,0,127}));
  connect(addInt.y, extIndSig1.index) annotation (Line(points={{42,80},{46,80},{
          46,66},{70,66},{70,68}}, color={255,127,0}));
  connect(matGai.y, extIndSig2.u)
    annotation (Line(points={{-18,50},{-2,50}}, color={0,0,127}));
  connect(uStaSet, extIndSig2.index) annotation (Line(points={{-160,-110},{-128,
          -110},{-128,28},{10,28},{10,38}}, color={255,127,0}));
  connect(conInt1.y, intEqu.u2) annotation (Line(points={{-88,-30},{-80,-30},{-80,
          -8},{-72,-8}}, color={255,127,0}));
  connect(intRep.y, intEqu.u1)
    annotation (Line(points={{-88,0},{-72,0}}, color={255,127,0}));
  connect(addInt.y, intRep.u) annotation (Line(points={{42,80},{46,80},{46,66},{
          -136,66},{-136,0},{-112,0}}, color={255,127,0}));
  connect(intEqu.y, booToRea.u)
    annotation (Line(points={{-48,0},{-42,0}}, color={255,0,255}));
  connect(booToRea.y, reaRep.u)
    annotation (Line(points={{-18,0},{-12,0}}, color={0,0,127}));
  connect(reaRep.y, pro3.u2)
    annotation (Line(points={{12,0},{20,0},{20,-6},{28,-6}}, color={0,0,127}));
  connect(con2.y, pro3.u1) annotation (Line(points={{-98,50},{-90,50},{-90,16},
          {20,16},{20,6},{28,6}},color={0,0,127}));
  connect(pro3.y, add1.u2)
    annotation (Line(points={{52,0},{60,0},{60,-6},{68,-6}}, color={0,0,127}));
  connect(con2.y, add1.u1) annotation (Line(points={{-98,50},{-90,50},{-90,16},
          {60,16},{60,6},{68,6}},color={0,0,127}));
  connect(add1.y, lesThr.u) annotation (Line(points={{92,0},{100,0},{100,-14},{-70,
          -14},{-70,-30},{-62,-30}}, color={0,0,127}));
  connect(lesThr.y, booToRea1.u)
    annotation (Line(points={{-38,-30},{-32,-30}}, color={255,0,255}));
  connect(booToRea1.y, pro4.u2) annotation (Line(points={{-8,-30},{0,-30},{0,-36},
          {8,-36}}, color={0,0,127}));
  connect(con2.y, pro4.u1) annotation (Line(points={{-98,50},{-90,50},{-90,16},
          {-16,16},{-16,-12},{0,-12},{0,-24},{8,-24}},color={0,0,127}));
  connect(pro4.y, matMax1.u)
    annotation (Line(points={{32,-30},{48,-30}}, color={0,0,127}));
annotation (
  defaultComponentName="minBoiFloSet",
  Icon(coordinateSystem(extent={{-140,-140},{140,140}}),
       graphics={
        Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,127},
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          borderPattern=BorderPattern.Raised),
        Text(
          extent={{-120,146},{100,108}},
          lineColor={0,0,255},
          textString="%name"),
        Rectangle(extent={{-36,42},{0,28}}, lineColor={28,108,200}),
        Rectangle(extent={{-36,28},{0,14}}, lineColor={28,108,200}),
        Rectangle(extent={{-36,14},{0,0}}, lineColor={28,108,200}),
        Rectangle(extent={{-36,0},{0,-14}}, lineColor={28,108,200}),
        Rectangle(extent={{-36,-14},{0,-28}}, lineColor={28,108,200}),
        Text(
          extent={{-32,38},{-12,32}},
          lineColor={28,108,200},
          textString="Stage #"),
        Text(
          extent={{-30,24},{-10,18}},
          lineColor={28,108,200},
          textString="0"),
        Text(
          extent={{-30,10},{-10,4}},
          lineColor={28,108,200},
          textString="1"),
        Text(
          extent={{-30,-4},{-10,-10}},
          lineColor={28,108,200},
          textString="2"),
        Rectangle(extent={{-36,-28},{0,-42}}, lineColor={28,108,200}),
        Text(
          extent={{-30,-18},{-10,-24}},
          lineColor={28,108,200},
          textString="..."),
        Text(
          extent={{-30,-32},{-10,-38}},
          lineColor={28,108,200},
          textString="n"),
        Rectangle(extent={{2,42},{38,28}}, lineColor={28,108,200}),
        Rectangle(extent={{2,28},{38,14}}, lineColor={28,108,200}),
        Rectangle(extent={{2,14},{38,0}}, lineColor={28,108,200}),
        Rectangle(extent={{2,0},{38,-14}}, lineColor={28,108,200}),
        Rectangle(extent={{2,-14},{38,-28}}, lineColor={28,108,200}),
        Text(
          extent={{8,38},{34,32}},
          lineColor={28,108,200},
          textString="Min flow"),
        Text(
          extent={{6,24},{34,18}},
          lineColor={28,108,200},
          textString="minFloSet[1]"),
        Rectangle(extent={{2,-28},{38,-42}}, lineColor={28,108,200}),
        Text(
          extent={{8,-18},{28,-24}},
          lineColor={28,108,200},
          textString="..."),
        Text(
          extent={{6,10},{34,4}},
          lineColor={28,108,200},
          textString="minFloSet[2]"),
        Text(
          extent={{6,-32},{34,-38}},
          lineColor={28,108,200},
          textString="minFloSet[n]"),
        Text(
          extent={{6,-4},{34,-10}},
          lineColor={28,108,200},
          textString="minFloSet[3]"),
        Text(
          extent={{-98,20},{-44,4}},
          lineColor={255,127,0},
          textString="nexEnaChi"),
        Text(
          extent={{-98,0},{-44,-16}},
          lineColor={255,127,0},
          textString="nexDisChi"),
        Text(
          extent={{-98,-82},{-52,-96}},
          lineColor={255,0,255},
          textString="uStaDow"),
        Text(
          extent={{-102,-64},{-60,-76}},
          lineColor={255,0,255},
          textString="uOnOff"),
        Text(
          extent={{-98,-32},{-52,-46}},
          lineColor={255,0,255},
          textString="uSubCha"),
        Text(
          extent={{-98,98},{-58,84}},
          lineColor={255,0,255},
          textString="uStaUp"),
        Text(
          extent={{-98,78},{-38,64}},
          lineColor={255,0,255},
          textString="uUpsDevSta"),
        Text(
          extent={{-98,48},{-70,34}},
          lineColor={255,0,255},
          textString="uChi"),
        Text(
          extent={{44,6},{98,-6}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="yChiWatMinFloSet")}),
  Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-140,-140},{140,140}})),
  Documentation(info="<html>
<p>
Block that outputs hot water minimum flow setpoint for primary-only
plants with a minimum flow bypass valve,
according to ASHRAE RP-1711 Advanced Sequences of Operation for HVAC Systems Phase II –
Central Plants and Hydronic Systems (Draft 4 on March 26, 2019),
section 5.2.8 Hot water minimum flow bypass valve.
</p>
<p>
1. For plants with parallel boilers, bypass valve shall modulate to maintain minimum
flow as measured by the hot water flow meter at a setpoint that ensures minimum
flow through all operating boilers, as follows:
</p>
<ul>
<li>
For the operating boilers in current stage, identify the boiler with the
highest ratio of <code>minFloSet</code> to <code>maxFloSet</code>.
</li>
<li>
Calculate the minimum flow setpoint as the highest ratio multiplied by the sum
of <code>maxFloSet</code> for the operating boilers.
</li>
</ul>
<table summary=\"summary\" border=\"1\">
<tr>
<th> Boiler </th>
<th> Minimum flow </th>
<th> Maximum flow </th>
</tr>
<tr>
<td align=\"center\">1</td>
<td align=\"center\"><code>minFloSet</code>[1]</td>
<td align=\"center\"><code>maxFloSet</code>[1]</td>
</tr>
<tr>
<td align=\"center\">2</td>
<td align=\"center\"><code>minFloSet</code>[2]</td>
<td align=\"center\"><code>maxFloSet</code>[2]</td>
</tr>
<tr>
<td align=\"center\">...</td>
<td align=\"center\">...</td>
<td align=\"center\">...</td>
</tr>
</table>
<br/>

<p>
2. For plants with series boilers, bypass valve shall modulate to maintain minimum
flow as measured by the hot water flow meter at a setpoint equal to the largest
<code>minFloSet</code> of the operating boilers in current stage.
</p>
<p>
3. If there is any stage change requiring a boiler on and another boiler off,
the minimum flow setpoint shall temporarily change to account for the
<code>minFloSet</code> of both the boiler to be enabled and to be disabled
prior to starting the newly enabled boiler.
</p>
<p>
Note that when there is a stage change requiring a change in the
minimum flow setpoint, the change should be slowly.
For example, this could be accomplished by resetting the setpoint X GPM/second,
where <code>X = (NewSetpoint - OldSetpoint) / byPasSetTim</code>.
</p>
</html>", revisions="<html>
<ul>
<li>
January 31, 2019, by Jianjun Hu:<br/>
First implementation.
</li>
</ul>
</html>"));
end MinimumFlowSetpoint_backup;
