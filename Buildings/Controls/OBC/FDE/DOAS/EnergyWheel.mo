within Buildings.Controls.OBC.FDE.DOAS;
block EnergyWheel "This block commands the energy recovery wheel and associated bypass dampers."
  parameter Real recSet(
  final unit = "K",
  final displayUnit = "degC",
  final quantity = "ThermodynamicTemperature") = 7 +273.15
  "Energy recovery set point.";

   parameter Real Thys(
  final unit = "K",
  final displayUnit = "degC",
  final quantity = "ThermodynamicTemperature") = 0.5
  "Energy recovery set point.";

  parameter Real recSetDelay(
  final unit = "s",
  final quantity = "Time") = 300
  "Minimum delay after OAT/RAT delta falls below set point.";

  parameter Real kGain_heat(
  final unit = "1") = 0.00001
  "PID heating loop gain value.";

  parameter Real conTi_heat(
  final unit = "s") = 0.00025
  "PID  heating loop time constant of integrator.";

  parameter Real kGain_cool(
  final unit = "1") = 0.00001
  "PID cooling loop gain value.";

  parameter Real conTi_cool(
  final unit = "s") = 0.00025 "PID cooling loop time constant of integrator.";

// ---inputs---
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput supFanProof "True when the supply fan is proven on."
  annotation(Placement(transformation(extent = {{-142, 60}, {-102, 100}}),
     iconTransformation(extent = {{-142, 58}, {-102, 98}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput oaT
  "Outside air temperature sensor."
  annotation(Placement(transformation(extent = {{-142, -38}, {-102, 2}}),
    iconTransformation(extent = {{-142, -38}, {-102, 2}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput raT
  "Return air temperature sensor."
  annotation(Placement(transformation(extent = {{-142, 0}, {-102, 40}}),
    iconTransformation(extent = {{-142, -2}, {-102, 38}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput ecoMode "True when economizer mode is active."
  annotation(Placement(transformation(extent = {{-142, 30}, {-102, 70}}),
    iconTransformation(extent = {{-142, 28}, {-102, 68}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput erwT
  "Energy recovery wheel supply air temperature."
  annotation(Placement(transformation(extent = {{-142, -74}, {-102, -34}}),
    iconTransformation(extent = {{-142, -68}, {-102, -28}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput supPrimSP "Primary supply air temperature set point."
  annotation(Placement(transformation(extent = {{-142, -106}, {-102, -66}}),
    iconTransformation(extent = {{-142, -98}, {-102, -58}})));

// ---outputs---
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput erwStart "Command to start the energy recovery wheel."
  annotation(Placement(transformation(extent = {{102, 0}, {142, 40}}),
    iconTransformation(extent = {{102, -20}, {142, 20}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealOutput erwSpeed(
  final unit = "1",
  final min = 0,
  final max = 1)
  "Energy recovery wheel speed command."
  annotation (Placement(transformation(extent = {{102, -96}, {142, -56}}),
    iconTransformation(extent = {{102, -80}, {142, -40}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput bypDam
  "Bypass damper command; true when commanded full open."
  annotation(Placement(transformation(extent = {{102, 46}, {142, 86}}),
    iconTransformation(extent = {{102, 40}, {142, 80}})));

  Buildings.Controls.OBC.CDL.Continuous.Subtract                   difference
  "Subtract outside air temperature from return air temperature."
  annotation(Placement(visible = true, transformation(origin = {24, 2}, extent = {{-90, -10}, {-70, 10}}, rotation = 0)));

  Buildings.Controls.OBC.CDL.Continuous.Abs abs
  "Absolute value of OAT-RAT difference."
  annotation(Placement(visible = true, transformation(origin = {26, 2}, extent = {{-62, -10}, {-42, 10}}, rotation = 0)));

  Buildings.Controls.OBC.CDL.Logical.TrueDelay truDel(
  delayTime = recSetDelay,
  delayOnInit = true)
  "Recovery set point delay before disabling energy wheel."
  annotation(Placement(visible = true, transformation(origin = {30, 28}, extent = {{2, -38}, {22, -18}}, rotation = 0)));

  Buildings.Controls.OBC.CDL.Logical.And3 and3
  "Logical AND; true when fan is proven, economizer mode is off, and ERW 
   temperature start conditions are met."
  annotation(Placement(transformation(extent = {{62, 10}, {82, 30}})));

  Buildings.Controls.OBC.CDL.Logical.Not not1
  "Logical NOT; true when economizer mode is off."
  annotation(Placement(transformation(extent = {{-26, 40}, {-6, 60}})));

  Buildings.Controls.OBC.CDL.Continuous.Max max
  "Outputs maximum value of two ERW temperature PI loops."
  annotation (
    Placement(transformation(extent = {{-62, -78}, {-42, -58}})));

  Buildings.Controls.OBC.CDL.Continuous.Switch swi
  "Logical switch outputs ERW temperature PI maximum output 
   when erwStart command is true."
   annotation(Placement(transformation(extent = {{66, -86}, {86, -66}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con0(final k = 0) "Real constant 0."
  annotation(Placement(transformation(extent = {{30, -94}, {50, -74}})));

  Buildings.Controls.OBC.CDL.Logical.And and1
  "Logical AND; true when fan is proven and unit is in economizer mode."
  annotation(Placement(transformation(extent = {{-64, 56}, {-44, 76}})));

  Buildings.Controls.OBC.CDL.Logical.Or or2
  "Logical OR."
  annotation(Placement(transformation(extent = {{62, 56}, {82, 76}})));

  Buildings.Controls.OBC.CDL.Logical.Not not2
  "Logical NOT; true when ERW start command is off."
  annotation(Placement(transformation(extent = {{34, 40}, {54, 60}})));

  Buildings.Controls.OBC.CDL.Continuous.PID conPID_heat(
  Ti = conTi_heat,
  k = kGain_heat)
  "PID loop if heating"
  annotation(Placement(visible = true, transformation(origin = {-82, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

  Buildings.Controls.OBC.CDL.Continuous.PID conPID_cool(
  Ti = conTi_cool,
  k = kGain_cool)
   "PID loop if cooling"
   annotation(Placement(visible = true, transformation(origin = {-80, -82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

  Buildings.Controls.OBC.CDL.Continuous.Hysteresis hys(uHigh = recSet, uLow = recSet - Thys)  annotation (
    Placement(visible = true, transformation(origin={8,2},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(not1.u, ecoMode) annotation (
    Line(points = {{-28, 50}, {-122, 50}}, color = {255, 0, 255}));

  connect(not1.y, and3.u2) annotation (
    Line(points = {{-4, 50}, {0, 50}, {0, 20}, {60, 20}}, color = {255, 0, 255}));

  connect(supFanProof, and3.u1) annotation (
    Line(points = {{-122, 80}, {8, 80}, {8, 28}, {60, 28}}, color = {255, 0, 255}));

  connect(and3.y, erwStart) annotation (
    Line(points = {{84, 20}, {122, 20}}, color = {255, 0, 255}));

  connect(max.y, swi.u1) annotation (
    Line(points = {{-40, -68}, {64, -68}}, color = {0, 0, 127}));

  connect(and3.y, swi.u2) annotation (
    Line(points = {{84, 20}, {88, 20}, {88, -58}, {56, -58}, {56, -76}, {64, -76}}, color = {255, 0, 255}));

  connect(con0.y, swi.u3) annotation (
    Line(points = {{52, -84}, {64, -84}}, color = {0, 0, 127}));

  connect(swi.y, erwSpeed) annotation (
    Line(points = {{88, -76}, {122, -76}}, color = {0, 0, 127}));
  connect(ecoMode, and1.u2) annotation (
    Line(points = {{-122, 50}, {-94, 50}, {-94, 58}, {-66, 58}}, color = {255, 0, 255}));

  connect(supFanProof, and1.u1) annotation (
    Line(points = {{-122, 80}, {-94, 80}, {-94, 66}, {-66, 66}}, color = {255, 0, 255}));

  connect(and1.y, or2.u1) annotation (
    Line(points = {{-42, 66}, {60, 66}}, color = {255, 0, 255}));

  connect(not2.y, or2.u2) annotation (
    Line(points = {{56, 50}, {58, 50}, {58, 58}, {60, 58}}, color = {255, 0, 255}));

  connect(and3.y, not2.u) annotation (
    Line(points = {{84, 20}, {88, 20}, {88, 36}, {28, 36}, {28, 50}, {32, 50}}, color = {255, 0, 255}));

  connect(or2.y, bypDam) annotation (
    Line(points = {{84, 66}, {122, 66}}, color = {255, 0, 255}));

  connect(supPrimSP, conPID_cool.u_s) annotation (
    Line(points = {{-122, -86}, {-105, -86}, {-105, -82}, {-92, -82}}, color = {0, 0, 127}));

  connect(supPrimSP, conPID_heat.u_s) annotation (
    Line(points = {{-122, -86}, {-122, -84}, {-94, -84}, {-94, -50}}, color = {0, 0, 127}));

  connect(erwT, conPID_heat.u_m) annotation (
    Line(points = {{-122, -54}, {-102, -54}, {-102, -62}, {-82, -62}}, color = {0, 0, 127}));

  connect(erwT, conPID_cool.u_m) annotation (
    Line(points = {{-122, -54}, {-100, -54}, {-100, -94}, {-80, -94}}, color = {0, 0, 127}));

  connect(conPID_heat.y, max.u1) annotation (
    Line(points = {{-70, -50}, {-70, -58}, {-64, -58}, {-64, -62}}, color = {0, 0, 127}));

  connect(conPID_cool.y, max.u2) annotation (
    Line(points = {{-68, -82}, {-64, -82}, {-64, -74}}, color = {0, 0, 127}));

  connect(raT, difference.u1) annotation (
    Line(points = {{-122, 20}, {-122, 8}, {-68, 8}}, color = {0, 0, 127}));

  connect(oaT, difference.u2) annotation (
    Line(points = {{-122, -18}, {-122, -4}, {-68, -4}}, color = {0, 0, 127}));

  connect(difference.y, abs.u) annotation (
    Line(points = {{-44, 2}, {-38, 2}}, color = {0, 0, 127}));

  connect(hys.y, truDel.u) annotation (
    Line(points={{20,2},{25,2},{25,0},{30,0}},
                                         color = {255, 0, 255}));

  connect(truDel.y, and3.u3) annotation (
    Line(points = {{54, 0}, {54, 12}, {60, 12}}, color = {255, 0, 255}));

  connect(abs.y, hys.u)
    annotation (Line(points={{-14, 2}, {-4, 2}}, color={0,0,127}));
  annotation (
    defaultComponentName = "ERWcon",
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(fillColor = {255, 255, 255},
            fillPattern=
FillPattern.Solid, extent = {{-100, 100}, {100, -100}}, radius = 10), Line(points = {{48, 0}, {-2, 0}}), Text(textColor = {28, 108, 200}, extent = {{-88, 180}, {92, 76}}, textString = "%name", textStyle = {TextStyle.Bold}), Text(textColor = {28, 108, 200}, extent = {{-98, 84}, {-54, 70}}, textString = "supFanProof"), Text(textColor = {28, 108, 200}, extent = {{-98, 54}, {-62, 44}}, textString = "ecoMode"), Text(textColor = {28, 108, 200}, extent = {{-108, 24}, {-72, 14}}, textString = "raT"), Text(textColor = {28, 108, 200}, extent = {{-108, -12}, {-72, -22}}, textString = "oaT"), Text(textColor = {28, 108, 200}, extent = {{-106, -42}, {-70, -52}}, textString = "erwT"), Text(textColor = {28, 108, 200}, extent = {{-96, -70}, {-56, -82}}, textString = "supPrimSP"), Text(textColor = {28, 108, 200}, extent = {{62, -54}, {98, -64}}, textString = "erwSpeed"), Text(textColor = {28, 108, 200}, extent = {{60, 4}, {96, -6}}, textString = "erwStart"), Text(textColor = {28, 108, 200}, extent = {{60, 66}, {96, 56}}, textString = "bypDam"), Ellipse(lineColor = {28, 108, 200}, fillColor = {170, 255, 255},
            fillPattern=
FillPattern.Solid, extent = {{-14, 64}, {28, -68}}), Rectangle(lineColor = {170, 255, 255}, fillColor = {170, 255, 255},
            fillPattern=
FillPattern.Solid, extent = {{-8, 64}, {8, -68}}), Ellipse(lineColor = {28, 108, 200}, fillColor = {170, 255, 255},
            fillPattern=
FillPattern.Solid, extent = {{-28, 64}, {14, -68}}), Rectangle(lineColor = {0, 140, 72}, fillColor = {0, 140, 72},
            fillPattern=
FillPattern.Solid, extent = {{32, -34}, {72, -36}}), Polygon(lineColor = {0, 140, 72}, fillColor = {0, 140, 72},
            fillPattern = FillPattern.Solid, points = {{72, -34}, {58, -28}, {58, -34}, {72, -34}}), Rectangle(lineColor = {28, 108, 200}, fillColor = {28, 108, 200},
            fillPattern=
FillPattern.Solid, extent = {{-70, -34}, {-30, -36}}), Polygon(lineColor = {28, 108, 200}, fillColor = {28, 108, 200},
            fillPattern=
FillPattern.Solid, points = {{-30, -34}, {-44, -28}, {-44, -34}, {-30, -34}}), Line(points = {{-8, 0}, {-58, 0}}), Rectangle(lineColor = {0, 140, 72}, fillColor = {0, 140, 72},
            fillPattern=
FillPattern.Solid, extent = {{-70, 30}, {-30, 28}}), Polygon(lineColor = {0, 140, 72}, fillColor = {0, 140, 72},
            fillPattern=
FillPattern.Solid, points = {{-56, 30}, {-56, 36}, {-70, 30}, {-56, 30}}), Polygon(lineColor = {238, 46, 47}, fillColor = {238, 46, 47},
            fillPattern=
FillPattern.Solid, points = {{44, 30}, {44, 36}, {30, 30}, {44, 30}}), Rectangle(lineColor = {238, 46, 47}, fillColor = {238, 46, 47},
            fillPattern=
FillPattern.Solid, extent = {{30, 30}, {70, 28}})}),
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}})),
    Documentation(revisions = "<html>
<ul>
<li>
September 15, 2020, by Henry Nickels:</br>
First implementation.</li>
</ul>
</html>", info = "<html>
<h4>Energy Recovery Wheel Start/Stop.</h4>
<p>This block commands the ERW to start 
(<code>erwStart</code>) when the DOAS is energized
(<code>supFanProof</code>) and the absolute difference between 
return air temperature (<code>raT</code>) and outside air temperature
(<code>oaT</code>) is greater than the recovery set point 
(<code>recSet</code>). When the DOAS is not energized, economizer
mode is enabled 
(<code>ecoMode</code>), or the RAT/OAT difference falls below the
recovery set point for longer than the recovery set point delay 
(<code>recSetDelay</code>) the ERW will be commanded to stop.</p>
<h4>ERW Speed Control</h4>
<p>The ERW speed 
(<code>erwSpeed</code>) is modulated to  maintain the energy recovery
supply temperature (<code>erwT</code>) at the primary supply air
 temperature set point (<code>supPrimSP</code>).</p>
<h4>Bypass Damper Control</h4>
When the DOAS is energized and in economizer mode or the ERW is stopped, 
the bypass dampers shall be commanded fully open to bypass
(<code>bypDam</code>). When the DOAS is de-energized or the DOAS is 
energized and the ERW is started, the bypass dampers shall be 
commanded closed to bypass.</p>
</html>"));
end EnergyWheel;
