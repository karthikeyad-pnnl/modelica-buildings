within Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Subsequences;
model BoilerPlantEnabler "Sequence to enable/disable boiler plant based on heating hot-water requirements"
  parameter Integer nHotWatReqIgn(min=0) = 0
  "Number of hot-water requests to be ignored before turning on boiler plant loop";
  parameter Integer nSchRow(min=1) = 4
  "Number of rows to be created for boiler plant schedule table";
  parameter Real TLocOut(final unit = "K", displayUnit = "K") = (273+(80-32)/1.8)
  "Boiler lock-out temperature for outdoor air";
  parameter Real boiPlaOffStaHolTimVal(final unit = "s", displayUnit = "s") = 15*60
  "Minimum time for which the boiler plant has to stay off once it has been switched off";
  parameter Real boiPlaOnStaHolTimVal(final unit = "s", displayUnit = "s") = 15*60
  "Minimum time for which the boiler plant has to stay on once it has been switched on";
  parameter Real boiEnaSchTab[nSchRow,2] = [0,1; 6,1; 18,1; 24,1]
  "Table defining schedule for enabling boiler";
  parameter Real staOnHeaWatReqTim(final unit = "s", displayUnit = "s") = 3*60
  "Time-limit for receiving hot-water requests to keep boiler plant on";
  CDL.Interfaces.RealInput TOut "Measured outdoor air temperature"
    annotation (Placement(transformation(extent={{-160,-70},{-120,-30}}),
        iconTransformation(extent={{-140,-70},{-100,-30}})));
  CDL.Interfaces.BooleanOutput boiEnaSig "Boiler enable signal"
    annotation (Placement(transformation(extent={{120,-20},{160,20}}),
        iconTransformation(extent={{100,-20},{140,20}})));
  CDL.Continuous.Sources.TimeTable boiEnaSch(table=boiEnaSchTab,
    smoothness=Buildings.Controls.OBC.CDL.Types.Smoothness.ConstantSegments,
                                                                 timeScale=3600)
    "Schedule table defining when boiler can be enabled"
    annotation (Placement(transformation(extent={{-98,-96},{-78,-76}})));
  CDL.Continuous.GreaterThreshold greThr(threshold=0.5)
    "Block to check if schedule lets the controller enable the plant or not"
    annotation (Placement(transformation(extent={{-72,-96},{-52,-76}})));
  CDL.Interfaces.IntegerInput hotWatSupResReq
    "Number of heating hot-water requests from heating coil"
    annotation (Placement(transformation(extent={{-160,30},{-120,70}}),
        iconTransformation(extent={{-140,30},{-100,70}})));
  CDL.Integers.GreaterThreshold intGreThr(threshold=nHotWatReqIgn)
    "Check to find if number of requests is greater than number of requests to be ignored"
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  CDL.Logical.Latch lat
    "Block to maintain plant status till the conditions to change it are met"
    annotation (Placement(transformation(extent={{88,-10},{108,10}})));
  CDL.Logical.MultiAnd mulAnd(nu=4)
    "Block to check if all the conditions for turning on plant have been met"
    annotation (Placement(transformation(extent={{42,74},{62,94}})));
  CDL.Logical.MultiOr mulOr(nu=3)
    "Block to check if any conditions except plant-on time have been satisfied to turn off plant"
    annotation (Placement(transformation(extent={{26,-70},{46,-50}})));
  CDL.Logical.And and2
    "Block to check if all conditions have been met to turn off the plant"
    annotation (Placement(transformation(extent={{54,-32},{74,-12}})));
  CDL.Logical.Not not1
    annotation (Placement(transformation(extent={{-10,-96},{10,-76}})));
  CDL.Continuous.AddParameter addPar(p=TLocOut, k=-1)
    "Block comparing measured outdoor air temperature to boiler lockout temperature"
    annotation (Placement(transformation(extent={{-114,-60},{-94,-40}})));
  CDL.Logical.Timer tim "Time since plant has been turned on"
    annotation (Placement(transformation(extent={{-40,-4},{-20,16}})));
  CDL.Continuous.Hysteresis hys(uLow=-1/1.8, uHigh=0)
    "Hysteresis loop to prevent cycling of boiler plant based on lockout temperature condition"
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
  CDL.Logical.Not not3
    annotation (Placement(transformation(extent={{-46,-40},{-26,-20}})));
  CDL.Logical.Timer tim1
    "Time since number of requests was greater than number of ignores"
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  CDL.Continuous.GreaterThreshold greThr1(threshold=staOnHeaWatReqTim)
    "Time limit for receiving requests to maintain status on"
    annotation (Placement(transformation(extent={{6,-40},{26,-20}})));
  CDL.Logical.Not not4
    annotation (Placement(transformation(extent={{-42,32},{-22,52}})));
  CDL.Logical.Timer tim2 "Time since plant has been turned off"
    annotation (Placement(transformation(extent={{-12,32},{8,52}})));
  CDL.Continuous.GreaterEqualThreshold boiPlaOnStaHolTim(threshold=
        boiPlaOnStaHolTimVal)
    "Minimum amount of time to hold the boiler plant on"
    annotation (Placement(transformation(extent={{-12,-4},{8,16}})));
  CDL.Continuous.GreaterEqualThreshold boiPlaOffStaHolTim(threshold=
        boiPlaOffStaHolTimVal)
    "Minimum amount of time to hold boiler plant off"
    annotation (Placement(transformation(extent={{16,32},{36,52}})));
  CDL.Logical.Pre pre
    annotation (Placement(transformation(extent={{52,20},{72,40}})));
  CDL.Logical.Not not2
    annotation (Placement(transformation(extent={{-30,-70},{-10,-50}})));
equation
  connect(boiEnaSig, boiEnaSig)
    annotation (Line(points={{140,0},{140,0}}, color={255,0,255}));
  connect(boiEnaSch.y[1], greThr.u)
    annotation (Line(points={{-76,-86},{-74,-86}}, color={0,0,127}));
  connect(intGreThr.u, hotWatSupResReq)
    annotation (Line(points={{-102,50},{-140,50}},  color={255,127,0}));
  connect(lat.y, boiEnaSig)
    annotation (Line(points={{110,0},{140,0}}, color={255,0,255}));
  connect(mulAnd.y, lat.u) annotation (Line(points={{64,84},{80,84},{80,0},{86,0}},
               color={255,0,255}));
  connect(mulOr.y, and2.u2) annotation (Line(points={{48,-60},{50,-60},{50,-30},
          {52,-30}}, color={255,0,255}));
  connect(and2.y, lat.clr) annotation (Line(points={{76,-22},{84,-22},{84,-6},{86,
          -6}}, color={255,0,255}));
  connect(addPar.u, TOut)
    annotation (Line(points={{-116,-50},{-140,-50}},
                                                color={0,0,127}));
  connect(greThr.y, not1.u)
    annotation (Line(points={{-50,-86},{-12,-86}},   color={255,0,255}));
  connect(hys.u, addPar.y) annotation (Line(points={{-82,-50},{-92,-50}},
               color={0,0,127}));
  connect(intGreThr.y, not3.u) annotation (Line(points={{-78,50},{-60,50},{-60,
          -30},{-48,-30}}, color={255,0,255}));
  connect(not3.y, tim1.u)
    annotation (Line(points={{-24,-30},{-22,-30}}, color={255,0,255}));
  connect(tim1.y, greThr1.u)
    annotation (Line(points={{2,-30},{4,-30}},  color={0,0,127}));
  connect(mulAnd.u[1], not3.u) annotation (Line(points={{40,89.25},{-60,89.25},{
          -60,-30},{-48,-30}},  color={255,0,255}));
  connect(hys.y, mulAnd.u[2]) annotation (Line(points={{-58,-50},{-54,-50},{-54,
          86},{16,86},{16,85.75},{40,85.75}},
                    color={255,0,255}));
  connect(mulAnd.u[3], greThr.y) annotation (Line(points={{40,82.25},{-6,82.25},
          {-6,82},{-50,82},{-50,-86}}, color={255,0,255}));
  connect(greThr1.y, mulOr.u[1]) annotation (Line(points={{28,-30},{32,-30},{32,
          -46},{24,-46},{24,-55.3333}}, color={255,0,255}));
  connect(not4.y, tim2.u)
    annotation (Line(points={{-20,42},{-14,42}},
                                             color={255,0,255}));
  connect(tim.y, boiPlaOnStaHolTim.u)
    annotation (Line(points={{-18,6},{-14,6}},color={0,0,127}));
  connect(tim2.y, boiPlaOffStaHolTim.u)
    annotation (Line(points={{10,42},{14,42}}, color={0,0,127}));
  connect(boiPlaOnStaHolTim.y, and2.u1) annotation (Line(points={{10,6},{50,6},{
          50,-22},{52,-22}},  color={255,0,255}));
  connect(boiPlaOffStaHolTim.y, mulAnd.u[4])
    annotation (Line(points={{38,42},{40,42},{40,78.75}}, color={255,0,255}));
  connect(pre.u, boiEnaSig) annotation (Line(points={{50,30},{48,30},{48,16},{112,
          16},{112,0},{140,0}},     color={255,0,255}));
  connect(pre.y, not4.u) annotation (Line(points={{74,30},{76,30},{76,46},{44,46},
          {44,24},{-46,24},{-46,42},{-44,42}},        color={255,0,255}));
  connect(tim.u, not4.u) annotation (Line(points={{-42,6},{-46,6},{-46,42},{-44,
          42}}, color={255,0,255}));
  connect(pre.u, lat.y) annotation (Line(points={{50,30},{48,30},{48,16},{112,16},
          {112,0},{110,0}}, color={255,0,255}));
  connect(not2.y, mulOr.u[2]) annotation (Line(points={{-8,-60},{8,-60},{8,-60},
          {24,-60}}, color={255,0,255}));
  connect(not1.y, mulOr.u[3]) annotation (Line(points={{12,-86},{20,-86},{20,
          -64.6667},{24,-64.6667}},
                          color={255,0,255}));
  connect(not2.u, hys.y) annotation (Line(points={{-32,-60},{-54,-60},{-54,-50},
          {-58,-50}}, color={255,0,255}));
  annotation (defaultComponentName = "boiPlaEna",
  Icon(graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineThickness=0.1),
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineThickness=5,
          borderPattern=BorderPattern.Raised),
        Text(
          extent={{-120,146},{100,108}},
          lineColor={0,0,255},
          textString="%name"),
        Ellipse(extent={{-80,80},{80,-80}}, lineColor={28,108,200},fillColor={170,255,213},
          fillPattern=FillPattern.Solid),
        Ellipse(extent={{-90,90},{90,-90}}, lineColor={28,108,200}),
        Rectangle(extent={{-75,2},{75,-2}}, lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-66,46},{76,10}},
          lineColor={28,108,200},
          textString="START"),
        Text(
          extent={{-66,-8},{76,-44}},
          lineColor={28,108,200},
          textString="STOP")},
          coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
  Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-120,-100},{120,100}})),
  Documentation(info="<html>
<p>
Block that generates boiler plant enable signal according to ASHRAE RP-1711
Advanced Sequences of Operation for HVAC Systems Phase II – Central Plants and
Hydronic Systems (December 31, 2019), section 5.3.2.1, 5.3.2.2, and 5.3.2.3.
</p>
<p>
The boiler plant should be enabled and disabled according to following sequences:
</p>
<ol>
<li>
An enabling schedule should be included to allow operators to lock out the 
boiler plant during off-hour, e.g. to allow off-hour operation of HVAC systems
except the boiler plant. The default schedule shall be 24/7 and be adjustable.
</li>
<li>
The plant should be enabled in the lowest stage when the plant has been
disabled for at least <code>boiPlaOffStaHolTimVal</code>, e.g. 15 minutes and: 
<ul>
<li>
Number of boiler plant requests is greater than number of requests to be ignored,
ie, <code>hotWatSupResReq</code> &gt; <code>nHotWatReqIgn</code>
(<code>nHotWatReqIgn</code> should default to 0 and be adjustable), and,
</li>
<li>
Measured outdoor air temperature is lower than boiler lockout temperature, ie,
<code>TOut</code> &lt; <code>TLocOut</code>, and,
</li>
<li>
The boiler enable schedule <code>boiEnaSchTab</code> is active.
</li>
</ul>
</li>
<li>
The plant should be disabled when it has been enabled for at least 
<code>boiPlaOnStaHolTimVal</code>, e.g. 15 minutes and:
<ul>
<li>
Number of boiler plant requests is less than number of requests to be ignored,ie,
<code>hotWatSupResReq</code> &le; <code>ignReq</code> for a time <code>staOnHeaWatReqTim</code>, or,
</li>
<li>
Outdoor air temperature is 1 &deg;F greater than boiler lockout temperature,ie,
<code>TOut</code> &gt; <code>TLocOut</code> + 1 &deg;F, or,
</li>
<li>
The boiler enable schedule <code>boiEnaSchTab</code> is inactive.
</li>
</ul>
</li>
</ol>
<p align=\"center\">
<img alt=\"Validation plot for BoilerPlantEnabler\"
src=\"modelica://Buildings/Resources/Images/Controls/OBC/ASHRAE/PrimarySystem/BoilerPlant/Subsequences/BoilerPlantEnabler.png\"/>
<br/>
Validation plot generated from model <a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Subsequences.Validation.BoilerPlantEnabler\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Subsequences.Validation.BoilerPlantEnabler</a>.
</p>
</html>",
revisions="<html>
<ul>
<li>
April 17, 2020, by Karthik Devaprasad:<br/>
First implementation.
</li>
</ul>
</html>"));
end BoilerPlantEnabler;
