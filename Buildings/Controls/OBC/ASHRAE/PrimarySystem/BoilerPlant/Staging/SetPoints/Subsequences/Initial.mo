within Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Staging.SetPoints.Subsequences;
block Initial "Outputs the initial stage"

  parameter Boolean have_WSE = true
    "true = plant has a WSE, false = plant does not have WSE";

  parameter Real wseDt = 1
    "Offset for checking waterside economizer leaving water temperature"
    annotation (Dialog(tab="Advanced", enable=have_WSE));

  parameter Modelica.SIunits.TemperatureDifference heaExcAppDes=2
    "Design heat exchanger approach"
    annotation (Dialog(group="Waterside economizer", enable=have_WSE));

  parameter Modelica.SIunits.TemperatureDifference cooTowAppDes=2
    "Design cooling tower approach"
    annotation (Dialog(group="Waterside economizer", enable=have_WSE));

  parameter Modelica.SIunits.Temperature TOutWetDes=288.15
    "Design outdoor air wet bulb temperature"
    annotation (Dialog(group="Waterside economizer", enable=have_WSE));

  parameter Modelica.SIunits.VolumeFlowRate VHeaExcDes_flow=0.01
    "Desing heat exchanger chilled water flow rate"
    annotation (Dialog(group="Waterside economizer", enable=have_WSE));

  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput uUp
    "First higher available chiller stage"
    annotation (Placement(transformation(extent={{-280,-100},{-240,-60}}),
      iconTransformation(extent={{-140,-20},{-100,20}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput TOutWet(
    final unit="K",
    final quantity="ThermodynamicTemperature") if have_WSE
    "Outdoor air wet bulb temperature"
    annotation (Placement(transformation(extent={{-280,10},{-240,50}}),
      iconTransformation(extent={{-140,70},{-100,110}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput uTunPar if have_WSE
    "Tuning parameter as at last plant disable"
    annotation (Placement(transformation(extent={{-280,-60},{-240,-20}}),
      iconTransformation(extent={{-140,40},{-100,80}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput TChiWatSupSet(
    final unit="K",
    final quantity="ThermodynamicTemperature") if have_WSE
    "Chilled water supply setpoint"
    annotation (Placement(transformation(extent={{-280,50},{-240,90}}),
      iconTransformation(extent={{-140,10},{-100,50}})));

  Buildings.Controls.OBC.CDL.Interfaces.IntegerOutput yIni
    "Initial chiller plant stage"
    annotation (Placement(transformation(extent={{240,-10},{260,10}}),
    iconTransformation(extent={{100,-10},{120,10}})));

protected
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Economizer.Subsequences.PredictedOutletTemperature
    wseTOut(
    final heaExcAppDes=heaExcAppDes,
    final cooTowAppDes=cooTowAppDes,
    final TOutWetDes=TOutWetDes,
    final VHeaExcDes_flow=VHeaExcDes_flow) if have_WSE
    "Waterside economizer outlet temperature predictor"
    annotation (Placement(transformation(extent={{-140,-20},{-120,0}})));

  Buildings.Controls.OBC.CDL.Conversions.IntegerToReal intToRea "Type converter"
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));

  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToInt "Type converter"
    annotation (Placement(transformation(extent={{160,-10},{180,10}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant staZer(
    final k=0)
    "Zero stage"
    annotation (Placement(transformation(extent={{0,60},{20,80}})));

  Buildings.Controls.OBC.CDL.Continuous.Hysteresis hys1(
    final uLow=0,
    final uHigh=wseDt) if have_WSE
    "Check if the initial predicted heat exchange leaving water temperature is greater than chilled water supply temperature setpoint less offset"
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));

  Buildings.Controls.OBC.CDL.Continuous.Feedback feedback if have_WSE
    "Difference between predicted heat exchanger leaving water temperature and chilled water supply temperature setpoint"
    annotation (Placement(transformation(extent={{-110,40},{-90,60}})));

  Buildings.Controls.OBC.CDL.Logical.Switch swi "Logical switch"
    annotation (Placement(transformation(extent={{60,40},{80,60}})));

  Buildings.Controls.OBC.CDL.Logical.Sources.Constant noWSE(
    final k=false) if not have_WSE "Replacement signal for no WSE case"
    annotation (Placement(transformation(extent={{-60,0},{-40,20}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con3(
    final k=VHeaExcDes_flow) if have_WSE
    "Design heat exchanger chiller water flow rate"
    annotation (Placement(transformation(extent={{-220,-20},{-200,0}})));

equation
  connect(reaToInt.y, yIni)
    annotation (Line(points={{182,0},{250,0}}, color={255,127,0}));
  connect(feedback.y,hys1. u)
    annotation (Line(points={{-88,50},{-62,50}}, color={0,0,127}));
  connect(noWSE.y,swi. u2)
    annotation (Line(points={{-38,10},{-20,10},{-20,50},{58,50}},
      color={255,0,255}));
  connect(hys1.y,swi. u2)
    annotation (Line(points={{-38,50},{58,50}}, color={255,0,255}));
  connect(wseTOut.TOutWet,TOutWet)
    annotation (Line(points={{-142,-2},{-180,-2},{-180,30},{-260,30}},
      color={0,0,127}));
  connect(con3.y,wseTOut. VChiWat_flow)
    annotation (Line(points={{-198,-10},{-142,-10}},
      color={0,0,127}));
  connect(wseTOut.uTunPar,uTunPar)
    annotation (Line(points={{-142,-18},{-180,-18},{-180,-40},{-260,-40}},
      color={0,0,127}));
  connect(wseTOut.y,feedback. u2)
    annotation (Line(points={{-118,-10},{-100,-10},{-100,38}}, color={0,0,127}));
  connect(TChiWatSupSet,feedback. u1)
    annotation (Line(points={{-260,70},{-170,70},{-170,50},{-112,50}},
      color={0,0,127}));
  connect(staZer.y,swi. u1)
    annotation (Line(points={{22,70},{40,70},{40,58},{58,58}}, color={0,0,127}));
  connect(uUp, intToRea.u) annotation (Line(points={{-260,-80},{-100,-80},{-100,
          -30},{-62,-30}}, color={255,127,0}));
  connect(intToRea.y, swi.u3) annotation (Line(points={{-38,-30},{40,-30},{40,42},
          {58,42}}, color={0,0,127}));
  connect(swi.y, reaToInt.u) annotation (Line(points={{82,50},{140,50},{140,0},{
          158,0}}, color={0,0,127}));
annotation (defaultComponentName = "iniSta",
        Icon(graphics={
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
          extent={{-240,-100},{240,100}})),
          Documentation(info="<html>
<p>This subsequence is not directly specified in 1711 as it provides a side calculation pertaining to generalization of the staging sequences for any number of chillers and stages provided by the user. </p>
<p>Determines the initial stage upon plant startup for both plants with and without a WSE. Implemented according to section 5.2.4.15. 1711 March 2020 Draft, under 8. (primary-only) and 15. (primary-secondary) plants. </p>
<p>The initial stage <span style=\"font-family: monospace;\">yIni</span> is defined as: </p>
<p>When the plant is enabled and the plant has no waterside economizer (<span style=\"font-family: monospace;\">have_WSE</span>=false), the initial stage will be the lowest available stage <span style=\"font-family: monospace;\">uUp</span>.</p>
<p>When the plant is enabled and the plant has waterside economizer (<span style=\"font-family: monospace;\">have_WSE</span>=true), the initial stage will be: </p>
<ul>
<li>If predicted waterside economizer outlet temperature calculated using <a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Economizer.Subsequences.PredictedOutletTemperature\">Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Economizer.Subsequences.PredictedOutletTemperature</a> with predicted heat exchanger part load ratio <span style=\"font-family: monospace;\">PLRHeaExc</span> set to 1 is at least <span style=\"font-family: monospace;\">wseDt</span> below the chilled water supply temperature setpoint <span style=\"font-family: monospace;\">TChiWatSupSet</span>, then the initial stage will be 0, meaning that the plant initiates in a waterside economizer only mode. </li>
<li>Otherwise, the initial stage will be the lowest available stage <span style=\"font-family: monospace;\">uUp</span>. </li>
</ul>
</html>",
revisions="<html>
<ul>
<li>
March 12, 2020, by Milica Grahovac:<br/>
First implementation.
</li>
</ul>
</html>"));
end Initial;
