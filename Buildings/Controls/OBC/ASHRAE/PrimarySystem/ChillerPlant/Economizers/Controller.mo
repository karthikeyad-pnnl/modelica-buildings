within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Economizers;
block Controller "Waterside economizer (WSE) enable/disable status"

  parameter Real holdPeriod(
    final unit="s",
    final quantity="Time",
    displayUnit="h")=1200
    "WSE minimum on or off time"
  annotation(Dialog(group="Enable parameters"));

  parameter Real delDis(
    final unit="s",
    final quantity="Time")=120
  "Delay disable time period"
  annotation(Dialog(group="Enable parameters"));

  parameter Real TOffsetEna(
    final unit="K",
    final quantity="TemperatureDifference",
    displayUnit="degC")=2
    "Temperature offset between the chilled water return upstream of WSE and the predicted WSE output"
  annotation(Dialog(group="Enable parameters"));

  parameter Real TOffsetDis(
    final unit="K",
    final quantity="TemperatureDifference",
    displayUnit="degC")=1
    "Temperature offset between the chilled water return upstream and downstream WSE"
  annotation(Dialog(group="Enable parameters"));

  parameter Real heaExcAppDes(
    final unit="K",
    final quantity="TemperatureDifference",
    displayUnit="degC")=2
    "Design heat exchanger approach"
    annotation(Dialog(group="Design parameters"));

  parameter Real cooTowAppDes(
    final unit="K",
    final quantity="TemperatureDifference",
    displayUnit="degC")=2
    "Design cooling tower approach"
    annotation(Dialog(group="Design parameters"));

  parameter Real TOutWetDes(
    final unit="K",
    final quantity="TemperatureDifference",
    displayUnit="degC")=288.15
    "Design outdoor air wet bulb temperature"
    annotation(Dialog(group="Design parameters"));

  parameter Real hysDt(
    final unit="K",
    final quantity="TemperatureDifference",
    displayUnit="degC")=1
     "Deadband temperature used in hysteresis block"
    annotation (Evaluate=true, Dialog(tab="Advanced", group="Hysteresis"));

  parameter Real VHeaExcDes_flow(
    final unit="m3/s",
    final quantity="VolumeFlowRate",
    displayUnit="m3/s")=0.015
      "Desing heat exchanger chilled water volume flow rate"
    annotation(Dialog(group="Design parameters"));

  parameter Real step(
    final unit="1")=0.02
    "Incremental step used to reduce or increase the water-side economizer tuning parameter"
    annotation (Evaluate=true, Dialog(tab="Advanced", group="Tuning"));

  parameter Real wseOnTimDec(
    final unit="s",
    final quantity="Time",
    displayUnit="h") = 3600
    "Economizer enable time needed to allow decrease of the tuning parameter"
    annotation (Evaluate=true,Dialog(tab="Advanced", group="Tuning"));

  parameter Real wseOnTimInc(
    final unit="s",
    final quantity="Time",
    displayUnit="h") = 1800
    "Economizer enable time needed to allow increase of the tuning parameter"
    annotation (Evaluate=true,Dialog(tab="Advanced", group="Tuning"));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput TOutWet(
    final unit="K",
    final quantity="ThermodynamicTemperature")
    "Outdoor air wet bulb temperature"
    annotation (Placement(transformation(extent={{-220,80},{-180,120}}),
        iconTransformation(extent={{-140,60},{-100,100}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput TChiWatRet(
    final unit="K",
    final quantity="ThermodynamicTemperature")
    "Chiller water return temperature upstream of the WSE"
    annotation (Placement(transformation(extent={{-220,40},{-180,80}}),
        iconTransformation(extent={{-140,20},{-100,60}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput TChiWatRetDow(
    final unit="K",
    final quantity="ThermodynamicTemperature")
    "Chiller water return temperature downstream of the WSE"
    annotation (Placement(transformation(extent={{-220,0},{-180,40}}),
        iconTransformation(extent={{-140,-20},{-100,20}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput uTowFanSpeMax(
    final min=0,
    final max=1,
    final unit="1")
    "Maximum cooling tower fan speed"
    annotation (Placement(transformation(extent={{-220,-120},{-180,-80}}),
    iconTransformation(extent={{-140,-100},{-100,-60}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput VChiWat_flow(
    final quantity="VolumeFlowRate",
    final unit="m3/s")
    "Measured chilled water volume flow rate"
    annotation (Placement(transformation(extent={{-220,-60},{-180,-20}}),
    iconTransformation(extent={{-140,-60},{-100,-20}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput y
    "WSE enable/disable status"
    annotation (Placement(transformation(extent={{180,70},{200,90}}),
    iconTransformation(extent={{100,40},{120,60}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yTunPar
    "Tuning parameter"
    annotation (Placement(transformation(extent={{180,-100},{200,-80}}),
      iconTransformation(extent={{100,-60},{120,-40}})));

  Buildings.Controls.OBC.CDL.Continuous.LessThreshold enaTChiWatRet(
    final t=delDis)
    "Enable condition based on chilled water return temperature upstream and downstream WSE"
    annotation (Placement(transformation(extent={{60,-20},{80,0}})));

  Buildings.Controls.OBC.CDL.Continuous.Hysteresis enaTWet(
    final uLow = TOffsetEna - hysDt/2,
    final uHigh = TOffsetEna + hysDt/2)
    "Enable condition based on the outdoor wet bulb temperature"
    annotation (Placement(transformation(extent={{20,40},{40,60}})));

  CDL.Interfaces.RealOutput TWsePre(final quantity="ThermodynamicTemperature",
      final unit="K") "Predicted waterside economizer outlet temperature"
    annotation (Placement(transformation(extent={{180,-10},{200,10}}),
        iconTransformation(extent={{100,-10},{120,10}})));
protected
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Economizers.Subsequences.Tuning wseTun(
    final step=step,
    final wseOnTimDec=wseOnTimDec,
    final wseOnTimInc=wseOnTimInc)
    "Tuning parameter for the WSE outlet temperature calculation"
    annotation (Placement(transformation(extent={{-140,-100},{-120,-80}})));

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Economizers.Subsequences.PredictedOutletTemperature wseTOut(
    final heaExcAppDes=heaExcAppDes,
    final cooTowAppDes=cooTowAppDes,
    final TOutWetDes=TOutWetDes,
    final VHeaExcDes_flow=VHeaExcDes_flow)
    "Calculates the predicted WSE outlet temperature"
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));

  Buildings.Controls.OBC.CDL.Continuous.Add add2(
    final k2=-1) "Adder"
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));

  Buildings.Controls.OBC.CDL.Logical.Pre pre "Logical pre"
    annotation (Placement(transformation(extent={{140,-60},{160,-40}})));

  Buildings.Controls.OBC.CDL.Continuous.Add add1(
    final k1=1,
    final k2=-1) "Adder"
    annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));

  Buildings.Controls.OBC.CDL.Logical.TrueFalseHold truFalHol(
    final trueHoldDuration=holdPeriod,
    final falseHoldDuration=holdPeriod)
    "Keeps a signal constant for a given time period"
    annotation (Placement(transformation(extent={{140,20},{160,40}})));

  Buildings.Controls.OBC.CDL.Logical.And and2 "And"
    annotation (Placement(transformation(extent={{100,40},{120,60}})));

  Buildings.Controls.OBC.CDL.Continuous.Hysteresis hys(
    final uLow = TOffsetDis - hysDt/2,
    final uHigh = TOffsetDis + hysDt/2)
    "Hysteresis comparing CHW temperatures upstream and downstream WSE"
    annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));

  Buildings.Controls.OBC.CDL.Logical.Timer timer
    "Measures the disable condition satisfied time "
    annotation (Placement(transformation(extent={{20,-20},{40,0}})));

  Buildings.Controls.OBC.CDL.Logical.Not not1 "Logical not"
    annotation (Placement(transformation(extent={{-20,-20},{0,0}})));

equation
  connect(uTowFanSpeMax, wseTun.uTowFanSpeMax) annotation (Line(points={{-200,-100},
          {-150,-100},{-150,-95},{-142,-95}}, color={0,0,127}));
  connect(TOutWet, wseTOut.TOutWet)
    annotation (Line(points={{-200,100},{-120,100},{-120,58},{-102,58}},
    color={0,0,127}));
  connect(VChiWat_flow, wseTOut.VChiWat_flow)
    annotation (Line(points={{-200,-40},{-120,-40},{-120,50},{-102,50}},
    color={0,0,127}));
  connect(pre.y,wseTun.uWseSta)
    annotation (Line(points={{162,-50},{170,-50},{170,-70},{-150,-70},{-150,-85},
          {-142,-85}},color={255,0,255}));
  connect(TChiWatRet, add1.u1)
    annotation (Line(points={{-200,60},{-140,60},{-140,-4},{-102,-4}},
          color={0,0,127}));
  connect(truFalHol.y, pre.u)
    annotation (Line(points={{162,30},{170,30},{170,-30},{130,-30},{130,-50},{138,-50}},
          color={255,0,255}));
  connect(truFalHol.y, y) annotation (
    Line(points={{162,30},{170,30},{170,80},{190,80}},
                                                     color={255,0,255}));
  connect(enaTWet.y, and2.u1)
    annotation (Line(points={{42,50},{98,50}}, color={255,0,255}));
  connect(truFalHol.u, and2.y)
    annotation (Line(points={{138,30},{130,30},{130,50},{122,50}},
    color={255,0,255}));
  connect(timer.y, enaTChiWatRet.u)
    annotation (Line(points={{42,-10},{58,-10}}, color={0,0,127}));
  connect(TChiWatRetDow, add1.u2)
    annotation (Line(points={{-200,20},{-160,20},{-160,-16},{-102,-16}},
    color={0,0,127}));
  connect(add1.y, hys.u)
    annotation (Line(points={{-78,-10},{-62,-10}},color={0,0,127}));
  connect(hys.y, not1.u)
    annotation (Line(points={{-38,-10},{-22,-10}}, color={255,0,255}));
  connect(not1.y, timer.u)
    annotation (Line(points={{2,-10},{18,-10}}, color={255,0,255}));
  connect(enaTChiWatRet.y, and2.u2) annotation (Line(points={{82,-10},{90,-10},{
          90,42},{98,42}}, color={255,0,255}));
  connect(wseTun.y, wseTOut.uTunPar) annotation (Line(points={{-119,-90},{-110,-90},
          {-110,42},{-102,42}},color={0,0,127}));
  connect(wseTOut.y, add2.u2) annotation (Line(points={{-78,50},{-50,50},{-50,44},
          {-22,44}}, color={0,0,127}));
  connect(TChiWatRet, add2.u1) annotation (Line(points={{-200,60},{-140,60},{-140,
          70},{-50,70},{-50,56},{-22,56}}, color={0,0,127}));
  connect(add2.y, enaTWet.u)
    annotation (Line(points={{2,50},{18,50}}, color={0,0,127}));
  connect(wseTun.y, yTunPar)
    annotation (Line(points={{-119,-90},{190,-90}}, color={0,0,127}));
  connect(wseTOut.y, TWsePre) annotation (Line(points={{-78,50},{-50,50},{-50,
          20},{120,20},{120,0},{190,0}}, color={0,0,127}));
  annotation (defaultComponentName = "wseSta",
        Icon(graphics={
        Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
        Text(
          extent={{-120,146},{100,108}},
          lineColor={0,0,255},
          textString="%name"),
        Rectangle(
          extent={{-82,64},{80,-56}},
          lineColor={28,108,200},
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          borderPattern=BorderPattern.Raised),
        Polygon(
          points={{-82,64},{-16,8},{-82,-56},{-82,64}},
          lineColor={175,175,175},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{6,60},{72,-52}},
          lineColor={28,108,200},
          lineThickness=0.5),
        Line(
          points={{6,-52},{72,60}},
          color={28,108,200},
          thickness=0.5)}),
        Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-180,-120},{180,120}})),
Documentation(info="<html>
<p>
Waterside economizer (WSE) control sequence per ASHRAE RP-1711, July Draft, section 5.2.3.
It implements the enable/disable conditions as provided in sections 5.2.3.1. and 5.2.3.2.
</p>
<p>
The sequence controls the WSE status as follows:
</p>
<ul>
<li>
Enable WSE if it has been disabled for at least <code>holdPeriod</code> of time and the chilled water return
temperature (CHWRT) upstream of WSE, <code>TChiWatRet</code>, is greater than the WSE predicted heat
exchanger leaving water temperature (PHXLWT) increased in <code>TOffsetEna</code>.
</li>
<li>
Disable WSE if it has been enabled for at least <code>holdPeriod</code> of time and CHWRT downstream of
WSE, <code>TChiWatRetDow</code>, is greater than <code>TChiWatRet</code> decreased in <code>TOffsetDis</code>
for <code>delDis</code> time period.
</li>
</ul>
<p>
The WSE control sequence uses the following subsequences:
</p>
<ul>
<li>
Calculation of the PHXLWT at given conditions:
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Economizers.Subsequences.PredictedOutletTemperature\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Economizers.Subsequences.PredictedOutletTemperature</a>.
</li>
<li>
Calculation of the tuning parameter used as an input to PHXLWT calculation:
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Economizers.Subsequences.Tuning\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Economizers.Subsequences.Tuning</a>.
</li>
</ul>
</html>",
revisions="<html>
<ul>
<li>
October 13, 2018, by Milica Grahovac:<br/>
First implementation.
</li>
</ul>
</html>"));
end Controller;
