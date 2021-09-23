within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChilledBeamSystem.SecondaryPumps;
block Controller
  "Controller for chilled water pumps in chilled beam systems"

  parameter Integer nPum = 2
    "Total number of chilled water pumps"
    annotation (Dialog(group="System parameters"));

  parameter Integer nVal = 3
    "Total number of chilled water control valves on chilled beams"
    annotation (Dialog(group="System parameters"));

  parameter Integer nSen=2
    "Total number of remote differential pressure sensors"
    annotation (Dialog(group="System parameters"));

  parameter Real minPumSpe(
    final unit="1",
    displayUnit="1",
    final min=0,
    final max=maxPumSpe) = 0.1
    "Minimum pump speed"
    annotation (Dialog(group="Pump parameters"));

  parameter Real maxPumSpe(
    final unit="1",
    displayUnit="1",
    final min=minPumSpe,
    final max=1) = 1
    "Maximum pump speed"
    annotation (Dialog(group="Pump parameters"));

  parameter Real valPosClo(
    final unit="1",
    displayUnit="1")=0.05
    "Valve position at which it is deemed to be closed"
    annotation (Dialog(tab="Pump control parameters",
      group="Pump enable parameters"));

  parameter Real valPosOpe(
    final unit="1",
    displayUnit="1")=0.1
    "Valve position at which it is deemed to be open"
    annotation (Dialog(tab="Pump control parameters",
      group="Pump enable parameters"));

  parameter Real valOpeThr(
    final unit="s",
    displayUnit="s",
    final quantity="time")=30
    "Minimum threshold time for which a valve has to be open to enable lead pump"
    annotation (Dialog(tab="Pump control parameters",
      group="Pump enable parameters"));

  parameter Real valCloThr(
    final unit="s",
    displayUnit="s",
    final quantity="time")=60
    "Minimum threshold time for which all valves have to be closed to disable lead pump"
    annotation (Dialog(tab="Pump control parameters",
      group="Pump enable parameters"));

  parameter Real speLim(
    final unit="1",
    displayUnit="1") = 0.75
    "Speed limit with longer enable delay for enabling next lag pump"
    annotation (Dialog(tab="Pump control parameters",
      group="Pump staging parameters"));

  parameter Real speLim1(
    final unit="1",
    displayUnit="1") = 0.9
    "Speed limit with shorter enable delay for enabling next lag pump"
    annotation (Dialog(tab="Pump control parameters",
      group="Pump staging parameters"));

  parameter Real speLim2(
    final unit="1",
    displayUnit="1") = 0.25
    "Speed limit for disabling last lag pump"
    annotation (Dialog(tab="Pump control parameters",
      group="Pump staging parameters"));

  parameter Real timPer1(
    final unit="s",
    displayUnit="s",
    final quantity="time") = 120
    "Delay time period for enabling next lag pump at speed limit speLim"
    annotation (Dialog(tab="Pump control parameters",
      group="Pump staging parameters"));

  parameter Real timPer2(
    final unit="s",
    displayUnit="s",
    final quantity="time") = 60
    "Delay time period for enabling next lag pump at speed limit speLim1"
    annotation (Dialog(tab="Pump control parameters",
      group="Pump staging parameters"));

  parameter Real timPer3(
    final unit="s",
    displayUnit="s",
    final quantity="time") = 120
    "Delay time period for disabling last lag pump"
    annotation (Dialog(tab="Pump control parameters",
      group="Pump staging parameters"));

  parameter Real k(
    final unit="1",
    displayUnit="1",
    final min=0) = 1
    "Gain of controller"
    annotation (Dialog(tab="Pump control parameters",
      group="PID parameters"));

  parameter Real Ti(
    final unit="s",
    displayUnit="s",
    final quantity="time",
    final min=0) = 0.5
    "Time constant of integrator block"
    annotation (Dialog(tab="Pump control parameters",
      group="PID parameters"));

  parameter Real Td(
    final unit="s",
    displayUnit="s",
    final quantity="time",
    final min=0) = 0.1
    "Time constant of derivative block"
    annotation (Dialog(tab="Pump control parameters",
      group="PID parameters"));

  parameter Real sigDif(
    final unit="1",
    displayUnit="1")=0.01
    "Constant value used in hysteresis for checking pump speed"
    annotation (Dialog(tab="Advanced"));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uChiWatPum[nPum]
    "Pumps operating status"
    annotation (Placement(transformation(extent={{-320,110},{-280,150}}),
      iconTransformation(extent={{-140,20},{-100,60}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput uValPos[nVal]
    "Chilled water control valve position on chilled beams"
    annotation (Placement(transformation(extent={{-320,60},{-280,100}}),
      iconTransformation(extent={{-140,-20},{-100,20}})));

  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput uPumLeaLag[nPum]
    "Chilled water pump lead-lag order"
    annotation (Placement(transformation(extent={{-320,150},{-280,190}}),
      iconTransformation(extent={{-140,60},{-100,100}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput dpChiWat_remote[nSen](
    final unit=fill("Pa", nSen),
    final quantity=fill("PressureDifference", nSen),
    displayUnit=fill("Pa", nSen))
    "Chilled water differential static pressure from remote sensor"
    annotation (Placement(transformation(extent={{-320,-180},{-280,-140}}),
      iconTransformation(extent={{-140,-60},{-100,-20}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput dpChiWatSet(
    final unit="Pa",
    final quantity="PressureDifference",
    displayUnit="Pa")
    "Chilled water differential static pressure setpoint"
    annotation (Placement(transformation(extent={{-320,-210},{-280,-170}}),
      iconTransformation(extent={{-140,-100},{-100,-60}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yChiWatPum[nPum]
    "Chilled water pump status"
    annotation (Placement(transformation(extent={{280,-20},{320,20}}),
      iconTransformation(extent={{100,0},{140,40}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yPumSpe(
    final min=0,
    final max=1,
    final unit="1",
    displayUnit="1")
    "Chilled water pump speed"
    annotation (Placement(transformation(extent={{280,-210},{320,-170}}),
        iconTransformation(extent={{100,-40},{140,0}})));

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChilledBeamSystem.SecondaryPumps.Subsequences.EnableLag_pumpSpeed
    enaLagSecPum(
    final speLim=speLim,
    final speLim1=speLim1,
    final speLim2=speLim2,
    final timPer=timPer1,
    final timPer1=timPer2,
    final timPer2=timPer3,
    sigDif=sigDif)
    "Enable and disable lag pumps using pump speed"
    annotation (Placement(transformation(extent={{-120,28},{-100,48}})));

protected
  parameter Integer pumInd[nPum]={i for i in 1:nPum}
    "Pump index, {1,2,...,n}";

  Buildings.Controls.OBC.CDL.Logical.LogicalSwitch logSwi[nPum]
    "Logical switch"
    annotation (Placement(transformation(extent={{180,-10},{200,10}})));

  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con[nPum](
    final k=fill(false, nPum))
    "Boolean source"
    annotation (Placement(transformation(extent={{122,-40},{142,-20}})));

  Buildings.Controls.OBC.CDL.Routing.BooleanReplicator booRep(
    final nout=nPum)
    "Boolean replicator"
    annotation (Placement(transformation(extent={{118,86},{138,106}})));

  Buildings.Controls.OBC.CDL.Discrete.UnitDelay uniDel(final samplePeriod=60)
    "Unit delay for pump speed"
    annotation (Placement(transformation(extent={{-200,28},{-180,48}})));

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChilledBeamSystem.SecondaryPumps.Subsequences.EnableLead
    enaLeaPum(
    nVal=nVal,
    valPosClo=valPosClo,
    valPosOpe=valPosOpe,
    valOpeThr=valOpeThr,
    valCloThr=valCloThr)
    "Enable lead pump"
    annotation (Placement(transformation(extent={{-200,70},{-180,90}})));

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChilledBeamSystem.SecondaryPumps.Subsequences.Speed_remoteDp
    pumSpeRemDp(
    final nSen=nSen,
    final nPum=nPum,
    final minPumSpe=minPumSpe,
    final maxPumSpe=maxPumSpe,
    final k=k,
    final Ti=Ti,
    final Td=Td)
    "Chilled water pump speed control with remote DP sensor"
    annotation (Placement(transformation(extent={{-20,-200},{0,-180}})));

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt(
    final k=1)
    "Constant one"
    annotation (Placement(transformation(extent={{-252,134},{-232,154}})));

  Buildings.Controls.OBC.CDL.Conversions.IntegerToReal intToRea[nPum]
    "Convert integer to real number"
    annotation (Placement(transformation(extent={{-200,160},{-180,180}})));

  Buildings.Controls.OBC.CDL.Routing.RealExtractor leaPum(
    final nin=nPum)
    "Lead pump index"
    annotation (Placement(transformation(extent={{-60,160},{-40,180}})));

  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToInt
    "Convert real input to integer output"
    annotation (Placement(transformation(extent={{-20,160},{0,180}})));

  Buildings.Controls.OBC.CDL.Routing.RealExtractor nexLagPum(
    final allowOutOfRange=true,
    final nin=nPum,
    final outOfRangeValue=0)
    "Next lag pump"
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));

  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToInt1
    "Convert real input to integer output"
    annotation (Placement(transformation(extent={{-8,-60},{12,-40}})));

  Buildings.Controls.OBC.CDL.Routing.RealExtractor lasLagPum(
    final allowOutOfRange=true,
    final nin=nPum,
    final outOfRangeValue=0)
    "Last lag pump"
    annotation (Placement(transformation(extent={{-80,-110},{-60,-90}})));

  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToInt2
    "Convert real input to integer output"
    annotation (Placement(transformation(extent={{-8,-110},{12,-90}})));

  Buildings.Controls.OBC.CDL.Conversions.BooleanToInteger booToInt[nPum]
    "Convert boolean to integer"
    annotation (Placement(transformation(extent={{-250,-130},{-230,-110}})));

  Buildings.Controls.OBC.CDL.Integers.MultiSum mulSumInt(
    final nin=nPum)
    "Sum of integer inputs"
    annotation (Placement(transformation(extent={{-200,-130},{-180,-110}})));

  Buildings.Controls.OBC.CDL.Integers.Add addInt
    "Integer add"
    annotation (Placement(transformation(extent={{-120,-80},{-100,-60}})));

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChilledBeamSystem.SecondaryPumps.Subsequences.ChangeStatus
    chaPumSta1(
    final nPum=nPum)
    "Change lead pump status"
    annotation (Placement(transformation(extent={{58,68},{80,88}})));

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChilledBeamSystem.SecondaryPumps.Subsequences.ChangeStatus
    chaPumSta4(
    final nPum=nPum)
    "Change lag pump status"
    annotation (Placement(transformation(extent={{122,-10},{144,10}})));

  Buildings.Controls.OBC.CDL.Integers.LessEqualThreshold intLesEquThr(
    final t=1)
    "Prevent status changer from disabling lead pump"
    annotation (Placement(transformation(extent={{-118,-36},{-98,-16}})));

  Buildings.Controls.OBC.CDL.Integers.GreaterEqualThreshold intGreEquThr(
    final t=1)
    "Prevent status changer from enabling lead pump"
    annotation (Placement(transformation(extent={{-120,-2},{-100,18}})));

  Buildings.Controls.OBC.CDL.Logical.And and1
    "Logical And"
    annotation (Placement(transformation(extent={{-30,32},{-10,52}})));

  Buildings.Controls.OBC.CDL.Logical.Or or3
    "Logical Or"
    annotation (Placement(transformation(extent={{-20,-8},{0,12}})));

equation
  connect(uPumLeaLag, intToRea.u)
    annotation (Line(points={{-300,170},{-202,170}}, color={255,127,0}));

  connect(intToRea.y, leaPum.u)
    annotation (Line(points={{-178,170},{-62,170}}, color={0,0,127}));

  connect(conInt.y, leaPum.index)
    annotation (Line(points={{-230,144},{-50,144},{-50,158}}, color={255,127,0}));

  connect(leaPum.y, reaToInt.u)
    annotation (Line(points={{-38,170},{-22,170}},color={0,0,127}));

  connect(intToRea.y, nexLagPum.u)
    annotation (Line(points={{-178,170},{-160,170},{-160,-50},{-82,-50}},
      color={0,0,127}));

  connect(intToRea.y, lasLagPum.u)
    annotation (Line(points={{-178,170},{-160,170},{-160,-100},{-82,-100}},
      color={0,0,127}));

  connect(uChiWatPum, booToInt.u)
    annotation (Line(points={{-300,130},{-260,130},{-260,-120},{-252,-120}},
      color={255,0,255}));

  connect(booToInt.y, mulSumInt.u)
    annotation (Line(points={{-228,-120},{-202,-120}}, color={255,127,0}));

  connect(addInt.y, nexLagPum.index)
    annotation (Line(points={{-98,-70},{-70,-70},{-70,-62}}, color={255,127,0}));

  connect(mulSumInt.y, addInt.u2)
    annotation (Line(points={{-178,-120},{-128,-120},{-128,-76},{-122,-76}},
      color={255,127,0}));

  connect(conInt.y, addInt.u1)
    annotation (Line(points={{-230,144},{-140,144},{-140,-64},{-122,-64}},
      color={255,127,0}));

  connect(mulSumInt.y, lasLagPum.index)
    annotation (Line(points={{-178,-120},{-70,-120},{-70,-112}}, color={255,127,0}));

  connect(reaToInt.y, chaPumSta1.uNexLagPum) annotation (Line(points={{2,170},{46,
          170},{46,74},{56,74}},     color={255,127,0}));

  connect(reaToInt.y, chaPumSta1.uLasLagPum) annotation (Line(points={{2,170},{46,
          170},{46,70},{56,70}},     color={255,127,0}));

  connect(enaLeaPum.yLea, chaPumSta1.uNexLagPumSta) annotation (Line(points={{-178,
          80},{-62,80},{-62,86},{56,86}}, color={255,0,255}));

  connect(enaLeaPum.yLea, chaPumSta1.uLasLagPumSta) annotation (Line(points={{-178,
          80},{36,80},{36,83},{56,83}}, color={255,0,255}));

  connect(uniDel.y, enaLagSecPum.uPumSpe)
    annotation (Line(points={{-178,38},{-122,38}}, color={0,0,127}));

  connect(reaToInt1.y, chaPumSta4.uNexLagPum) annotation (Line(points={{14,-50},
          {32,-50},{32,-4},{120,-4}},color={255,127,0}));

  connect(reaToInt2.y, chaPumSta4.uLasLagPum) annotation (Line(points={{14,-100},
          {38,-100},{38,-8},{120,-8}},color={255,127,0}));

  connect(nexLagPum.y, reaToInt1.u)
    annotation (Line(points={{-58,-50},{-10,-50}}, color={0,0,127}));

  connect(lasLagPum.y, reaToInt2.u)
    annotation (Line(points={{-58,-100},{-10,-100}}, color={0,0,127}));

  connect(mulSumInt.y, intLesEquThr.u) annotation (Line(points={{-178,-120},{-166,
          -120},{-166,-26},{-120,-26}},   color={255,127,0}));

  connect(mulSumInt.y, intGreEquThr.u) annotation (Line(points={{-178,-120},{-166,
          -120},{-166,8},{-122,8}},      color={255,127,0}));

  connect(enaLagSecPum.yUp, and1.u1)
    annotation (Line(points={{-98,42},{-32,42}}, color={255,0,255}));

  connect(intGreEquThr.y, and1.u2) annotation (Line(points={{-98,8},{-40,8},{-40,
          34},{-32,34}},      color={255,0,255}));

  connect(intLesEquThr.y, or3.u2) annotation (Line(points={{-96,-26},{-28,-26},{
          -28,-6},{-22,-6}},  color={255,0,255}));

  connect(enaLagSecPum.yDown, or3.u1) annotation (Line(points={{-98,34},{-48,34},
          {-48,2},{-22,2}}, color={255,0,255}));

  connect(and1.y, chaPumSta4.uNexLagPumSta) annotation (Line(points={{-8,42},{28,
          42},{28,8},{120,8}},  color={255,0,255}));

  connect(or3.y, chaPumSta4.uLasLagPumSta) annotation (Line(points={{2,2},{20,2},
          {20,5},{120,5}},  color={255,0,255}));

  connect(uValPos, enaLeaPum.uValPos)
    annotation (Line(points={{-300,80},{-202,80}}, color={0,0,127}));

  connect(uChiWatPum, chaPumSta1.uChiWatPum) annotation (Line(points={{-300,130},
          {-260,130},{-260,100},{42,100},{42,78},{56,78}}, color={255,0,255}));

  connect(chaPumSta1.yChiWatPum, chaPumSta4.uChiWatPum) annotation (Line(points=
         {{80,78},{100,78},{100,0},{120,0}}, color={255,0,255}));

  connect(uChiWatPum, pumSpeRemDp.uChiWatPum) annotation (Line(points={{-300,130},
          {-260,130},{-260,-182},{-22,-182}}, color={255,0,255}));

  connect(dpChiWat_remote, pumSpeRemDp.dpChiWat) annotation (Line(points={{-300,
          -160},{-40,-160},{-40,-190},{-22,-190}}, color={0,0,127}));

  connect(dpChiWatSet, pumSpeRemDp.dpChiWatSet) annotation (Line(points={{-300,-190},
          {-62,-190},{-62,-198},{-22,-198}}, color={0,0,127}));

  connect(pumSpeRemDp.yChiWatPumSpe, yPumSpe) annotation (Line(points={{2,-190},
          {150,-190},{150,-190},{300,-190}}, color={0,0,127}));

  connect(pumSpeRemDp.yChiWatPumSpe, uniDel.u) annotation (Line(points={{2,-190},
          {40,-190},{40,-220},{-220,-220},{-220,38},{-202,38}}, color={0,0,127}));

  connect(logSwi.y, yChiWatPum)
    annotation (Line(points={{202,0},{300,0}}, color={255,0,255}));

  connect(con.y, logSwi.u3) annotation (Line(points={{144,-30},{162,-30},{162,-8},
          {178,-8}}, color={255,0,255}));

  connect(chaPumSta4.yChiWatPum, logSwi.u1) annotation (Line(points={{144,0},{162,
          0},{162,8},{178,8}}, color={255,0,255}));

  connect(booRep.y, logSwi.u2) annotation (Line(points={{140,96},{170,96},{170,0},
          {178,0}}, color={255,0,255}));

  connect(enaLeaPum.yLea, booRep.u) annotation (Line(points={{-178,80},{-62,80},
          {-62,96},{116,96}}, color={255,0,255}));

annotation (defaultComponentName="secPumCon",
  Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-280,-240},{280,200}}),
        graphics={
          Rectangle(
          extent={{-274,198},{274,60}},
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
          Text(
          extent={{206,200},{270,184}},
          pattern=LinePattern.None,
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127},
          horizontalAlignment=TextAlignment.Right,
          textString="Enable lead pump"),
          Rectangle(
          extent={{-276,56},{274,-136}},
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
          Text(
          extent={{192,52},{270,36}},
          pattern=LinePattern.None,
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127},
          horizontalAlignment=TextAlignment.Right,
          textString="Enable next lag pump"),
          Text(
          extent={{188,-126},{266,-136}},
          pattern=LinePattern.None,
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127},
          horizontalAlignment=TextAlignment.Right,
          textString="Disable last lag pump"),
          Rectangle(
          extent={{-276,-142},{276,-236}},
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
          Text(
          extent={{222,-144},{268,-156}},
          pattern=LinePattern.None,
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127},
          horizontalAlignment=TextAlignment.Right,
          textString="Pump speed")}),
 Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
       graphics={
        Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-100,140},{100,100}},
          lineColor={0,0,255},
          textString="%name"),
        Rectangle(
          extent={{-80,60},{82,-60}},
          lineColor={28,108,200},
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          borderPattern=BorderPattern.Raised),
        Polygon(
          points={{-80,60},{-14,4},{-80,-60},{-80,60}},
          lineColor={175,175,175},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid)}),
  Documentation(info="<html>
<p>
Pump control sequences for chilled beam systems. It consists of:
</p>
<ul>
<li>
Subsequence to enable lead pump, 
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChilledBeamSystem.SecondaryPumps.Subsequences.EnableLead\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChilledBeamSystem.SecondaryPumps.Subsequences.EnableLead</a>.
</li>
<li>
Subsequences to stage lag pumps using pump speed
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChilledBeamSystem.SecondaryPumps.Subsequences.EnableLag_pumpSpeed\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChilledBeamSystem.SecondaryPumps.Subsequences.EnableLag_pumpSpeed</a>.
</li>
<li>
Subsequences to control pump speed where the remote DP sensor(s) is hardwired to 
the system controller
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChilledBeamSystem.SecondaryPumps.Subsequences.Speed_remoteDp\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChilledBeamSystem.SecondaryPumps.Subsequences.Speed_remoteDp</a>.
</li>
</ul>      
</html>",
revisions="<html>
<ul>
<li>
June 9, 2021, by Karthik Devaprasad:<br/>
First implementation.
</li>
</ul>
</html>"));
end Controller;
