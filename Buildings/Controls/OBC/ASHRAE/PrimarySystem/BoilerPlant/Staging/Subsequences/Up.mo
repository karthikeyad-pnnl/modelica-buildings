within Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Staging.Subsequences;
block Up "Generates a stage up signal"
  parameter Boolean have_WSE = true
    "true = plant has a WSE, false = plant does not have WSE";

  parameter Boolean serChi = false
    "true = series chillers plant; false = parallel chillers plant";

  parameter Modelica.SIunits.Time effConTruDelay = 900
    "Enable delay for efficiency condition";

  parameter Modelica.SIunits.Time faiSafTruDelay = 900
    "Enable delay for failsafe condition";

  parameter Modelica.SIunits.Time shortTDelay = 600
    "Short enable delay for staging from zero to first available stage up"
    annotation(Evaluate=true, Dialog(enable=have_WSE));

  parameter Modelica.SIunits.Time longTDelay = 1200
    "Long enable delay for staging from zero to first available stage up"
    annotation(Evaluate=true, Dialog(enable=have_WSE));

  parameter Modelica.SIunits.TemperatureDifference faiSafTDif = 1
    "Offset between the chilled water supply temperature and its setpoint";

  parameter Modelica.SIunits.TemperatureDifference TDifHys = 1
    "Hysteresis deadband for temperature";

  parameter Modelica.SIunits.TemperatureDifference smallTDif = 1
    "Offset between the chilled water supply temperature and its setpoint for the long condition"
    annotation(Evaluate=true, Dialog(enable=have_WSE));

  parameter Modelica.SIunits.TemperatureDifference largeTDif = 2
    "Offset between the chilled water supply temperature and its setpoint for the short condition"
    annotation(Evaluate=true, Dialog(enable=have_WSE));

  parameter Modelica.SIunits.PressureDifference faiSafDpDif = 2 * 6895
    "Offset between the chilled water differential pressure and its setpoint";

  parameter Modelica.SIunits.PressureDifference dpDifHys = 0.5 * 6895
    "Pressure difference hysteresis deadband";

  parameter Real effConSigDif = 0.05
    "Signal hysteresis deadband";

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uAvaCur
    "Current stage availability status"
    annotation (Placement(transformation(extent={{-140,-160},{-100,-120}}),
        iconTransformation(extent={{-140,-110},{-100,-70}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput THotWatSupSet(
    final unit="K",
    final quantity="ThermodynamicTemperature")
    "Hot water supply temperature setpoint"
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}}),
    iconTransformation(extent={{-140,30},{-100,70}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput THotWatSup(
    final unit="K",
    final quantity="ThermodynamicTemperature")
    "Measured hot water supply temperature"
    annotation (Placement(transformation(extent={{-140,-130},{-100,-90}}),
    iconTransformation(extent={{-140,10},{-100,50}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yStaUp "Stage up signal"
    annotation (Placement(transformation(extent={{100,-20},{140,20}}),
        iconTransformation(extent={{100,-20},{140,20}})));

  EfficiencyCondition effCon "Efficiency condition for staging up"
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));

  Subsequences.FailsafeCondition faiSafCon
    "Failsafe condition for staging up and down"
    annotation (Placement(transformation(extent={{-60,-102},{-40,-84}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput uQUpMin
    "Minimum heating capacity of next available stage"
    annotation (Placement(transformation(extent={{-140,50},{-100,90}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput uHotWatFloRat
    "Measured hot water flow rate"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput uUpMinFloSetPoi
    "Minimum flow setpoint for next available higher stage"
    annotation (Placement(transformation(extent={{-140,-10},{-100,30}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput uQDes
    "Design heating capacity of the current stage"
    annotation (Placement(transformation(extent={{-140,80},{-100,120}})));
  CDL.Interfaces.RealInput uQReq "Calculated heating capacity requirement"
    annotation (Placement(transformation(extent={{-140,110},{-100,150}})));
  CDL.Interfaces.IntegerInput uTyp[nSta]
    "Boiler-type vector specifying boiler-type in each stage"
    annotation (Placement(transformation(extent={{-140,-40},{-100,0}})));
  CDL.Interfaces.IntegerInput uAvaUp "Index of next available higher stage"
    annotation (Placement(transformation(extent={{-140,-70},{-100,-30}})));

  CDL.Logical.Not not1 "Logical not"
    annotation (Placement(transformation(extent={{-60,-150},{-40,-130}})));
  CDL.Logical.MultiOr mulOr(nu=3) "Logical Or"
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
equation
  connect(effCon.uQReq, uQReq) annotation (Line(points={{-62,49},{-64,49},{-64,
          130},{-120,130}}, color={0,0,127}));
  connect(effCon.uQDes, uQDes) annotation (Line(points={{-62,46},{-72,46},{-72,
          100},{-120,100}}, color={0,0,127}));
  connect(effCon.uQUpMin, uQUpMin) annotation (Line(points={{-62,43},{-80,43},{
          -80,70},{-120,70}}, color={0,0,127}));
  connect(effCon.uHotWatFloRat, uHotWatFloRat)
    annotation (Line(points={{-62,40},{-120,40}}, color={0,0,127}));
  connect(effCon.uUpMinFloSetPoi, uUpMinFloSetPoi) annotation (Line(points={{
          -62,37},{-80,37},{-80,10},{-120,10}}, color={0,0,127}));
  connect(effCon.uTyp, uTyp) annotation (Line(points={{-62,34},{-72,34},{-72,
          -20},{-120,-20}}, color={255,127,0}));
  connect(effCon.uAvaUp, uAvaUp) annotation (Line(points={{-62,31},{-64,31},{
          -64,-50},{-120,-50}}, color={255,127,0}));
  connect(faiSafCon.TSupSet, THotWatSupSet) annotation (Line(points={{-62,-89},{
          -80,-89},{-80,-80},{-120,-80}},  color={0,0,127}));
  connect(faiSafCon.TSup, THotWatSup) annotation (Line(points={{-62,-99},{-80,-99},
          {-80,-110},{-120,-110}}, color={0,0,127}));
  connect(mulOr.y, yStaUp)
    annotation (Line(points={{62,0},{120,0}}, color={255,0,255}));
  connect(effCon.yEffCon, mulOr.u[1]) annotation (Line(points={{-38,40},{10,40},
          {10,4.66667},{38,4.66667}},
                                    color={255,0,255}));
  connect(faiSafCon.y, mulOr.u[2]) annotation (Line(points={{-38,-94},{0,-94},{0,
          0},{38,0}}, color={255,0,255}));
  connect(not1.u, uAvaCur)
    annotation (Line(points={{-62,-140},{-120,-140}}, color={255,0,255}));
  connect(not1.y, mulOr.u[3]) annotation (Line(points={{-38,-140},{10,-140},{10,
          -4.66667},{38,-4.66667}}, color={255,0,255}));
  annotation (defaultComponentName = "staUp",
        Icon(coordinateSystem(extent={{-100,-160},{100,160}}),
             graphics={
        Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
        Text(
          extent={{-120,146},{100,108}},
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
        Rectangle(extent={{20,30},{80,18}}, lineColor={0,0,127}),
        Rectangle(extent={{20,12},{80,0}}, lineColor={0,0,127}),
        Rectangle(extent={{24,18},{28,12}}, lineColor={0,0,127}),
        Rectangle(extent={{72,18},{76,12}}, lineColor={0,0,127}),
        Line(points={{130,-48}}, color={0,0,127})}), Diagram(
        coordinateSystem(preserveAspectRatio=false,
        extent={{-100,-160},{100,160}})),
Documentation(info="<html>
<p>Outputs a boolean stage up signal <code>y</code> based on the 
various plant operation conditions that get provided as input signals. 
Implemented according to 1711 March 2020 Draft, section 5.2.4.15.
 and applies to primary-only plant with and without a WSE.
</p>
<p>
The stage up signal becomes <code>true</code> when:
</p>
<ul>
<li>
Current stage becomes unavailable, or
</li>
<li>
Efficiency condition is true, or
</li>
<li>
Failsafe condition is true.
</li>
</ul>
<p>
If <code>have_WSE</code> boolean flag is true, staging up from WSE only to the first available 
stage occurs when the chilled water supply temperature is sufficienctly above its setpoint
for either a shorter or a longer time period
</p>
</html>",
revisions="<html>
<ul>
<li>
January 28, 2019, by Milica Grahovac:<br/>
First implementation.
</li>
</ul>
</html>"));
end Up;
