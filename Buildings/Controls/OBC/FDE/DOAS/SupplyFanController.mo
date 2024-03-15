within Buildings.Controls.OBC.FDE.DOAS;
block SupplyFanController "This block manages start, stop, status, and speed of the supply fan."

  parameter Real minDDSPset(
  min = 0,
  final unit = "Pa",
  final quantity = "PressureDifference") = 125
  "Minimum down duct static pressure reset value" annotation(Dialog(group = "DDSP range"));

  parameter Real maxDDSPset(
  min = 0,
  final unit = "Pa",
  final quantity = "PressureDifference") = 500
  "Maximum down duct static pressure reset value" annotation(Dialog(group = "DDSP range"));

  parameter Real cvDDSPset(
  min = 0,
  final unit = "Pa",
  final quantity = "PressureDifference") = 250 "Constant volume down duct static pressure set point";

  parameter Real damSet(
  min = 0,
  max = 1,
  final unit = "1") = 0.9
  "DDSP terminal damper percent open set point";

  parameter Boolean vvUnit = true
  "Set true when unit serves variable volume system.";

  parameter Real DampspPIk = 0.0000001
  "Damper position setpoint PI gain value k.";

  parameter Real DampspPITi = 0.000025
  "Damper position setpoint PI time constant value Ti.";

  parameter Real FSspPIk = 0.0000001 "
  Fan speed set point SAT PI gain value k.";

  parameter Real MinFS = 0.0000001
  "Minimum Fan Speed";

  parameter Real FSspPITi = 0.000025
  "Fan speed set point SAT PI time constant value Ti.";
  // ---inputs---
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput occ
  "True when occupied mode is active"
  annotation(Placement(transformation(extent = {{-142, 60}, {-102, 100}}), iconTransformation(extent = {{-140, 50}, {-100, 90}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput mostOpenDam if vvUnit
  "Most open damper position from all terminal units served."
  annotation(Placement(transformation(extent = {{-142, -24}, {-102, 16}}), iconTransformation(extent = {{-140, 14}, {-100, 54}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput supFanStatus
  "True when supply fan is proven on."
  annotation(Placement(transformation(extent = {{-142, 22}, {-102, 62}}), iconTransformation(extent = {{-140, -56}, {-100, -16}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput DDSP "Down duct static pressure measurement."
  annotation(Placement(transformation(extent = {{-142, -106}, {-102, -66}}), iconTransformation(extent = {{-140, -92}, {-100, -52}})));
  // ---outputs---
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yFanSup
    "Supply fan enable signal" annotation (Placement(transformation(extent={{
            102,60},{142,100}}), iconTransformation(extent={{100,32},{140,72}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yFanSupSpe
    "Supply fan speed signal" annotation (Placement(transformation(extent={{102,
            -50},{142,-10}}), iconTransformation(extent={{100,-64},{140,-24}})));

  Buildings.Controls.OBC.CDL.Reals.Sources.Constant dampSet(
   k = damSet) if vvUnit
   "Most open damper position set point."
   annotation(Placement(transformation(extent = {{-98, 4}, {-78, 24}})));

  Buildings.Controls.OBC.CDL.Reals.Sources.Constant cvDDSPsetpt(
  final k = cvDDSPset) if not vvUnit
  "DDSP set point for constant volume systems." annotation(Placement(transformation(extent = {{-72, -64}, {-52, -44}})));

  Buildings.Controls.OBC.CDL.Reals.Switch swi
  "Swtich passes fan speed set point when true; 0 when false."
  annotation(Placement(transformation(extent = {{14, -40}, {34, -20}})));

  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con0(
  k = MinFS)
  "Real constant 0"
  annotation(Placement(transformation(extent = {{-26, -64}, {-6, -44}})));

  Buildings.Controls.OBC.CDL.Reals.PID DamperSPPI(
  Ti = DampspPITi,
  k = DampspPIk,
    yMax=maxDDSPset,
    yMin=minDDSPset,
    reverseActing=false) if
                    vvUnit
  annotation(Placement(visible = true, transformation(origin = {-38, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

  Buildings.Controls.OBC.CDL.Reals.PID FanSpeedSPPI(
  Ti = FSspPITi,
  k = FSspPIk)
  annotation(Placement(visible = true, transformation(origin = {62, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

  Buildings.Controls.OBC.CDL.Logical.Timer
  tim(t = 300)
  annotation(Placement(visible = true, transformation(origin = {-8, 88}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

equation
  connect(con0.y, swi.u3) annotation (
  Line(points = {{-4, -54}, {4, -54}, {4, -38}, {12, -38}}, color = {0, 0, 127}));

  connect(supFanStatus, swi.u2) annotation (
    Line(points = {{-122, 42}, {0, 42}, {0, -30}, {12, -30}}, color = {255, 0, 255}));

  connect(cvDDSPsetpt.y, swi.u1) annotation (
  Line(points = {{-50, -54}, {-34, -54}, {-34, -22}, {12, -22}}, color = {0, 0, 127}));

  connect(dampSet.y, DamperSPPI.u_s) annotation (
  Line(points = {{-76, 14}, {-71, 14}, {-71, 22}, {-50, 22}}, color = {0, 0, 127}));

  connect(mostOpenDam, DamperSPPI.u_m) annotation (
  Line(points = {{-122, -4}, {-38, -4}, {-38, 10}}, color = {0, 0, 127}));

  connect(DamperSPPI.y, swi.u1) annotation (
  Line(points = {{-26, 22}, {-26, -22}, {12, -22}}, color = {0, 0, 127}));

  connect(swi.y, FanSpeedSPPI.u_s) annotation (
  Line(points = {{36, -30}, {50, -30}}, color = {0, 0, 127}));

  connect(DDSP, FanSpeedSPPI.u_m) annotation (
    Line(points = {{-122, -86}, {62, -86}, {62, -42}}, color = {0, 0, 127}));

  connect(FanSpeedSPPI.y, yFanSupSpe)
    annotation (Line(points={{74,-30},{122,-30}}, color={0,0,127}));

  connect(occ, tim.u) annotation (
    Line(points = {{-122, 80}, {-69, 80}, {-69, 88}, {-20, 88}}, color = {255, 0, 255}));

  connect(tim.passed, yFanSup)
    annotation (Line(points={{4,80},{122,80}}, color={255,0,255}));

  annotation (
    defaultComponentName = "SFcon",
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(lineColor = {179, 151, 128}, fillColor = {255, 255, 255},
            fillPattern=
FillPattern.Solid, extent = {{-100, 100}, {100, -100}}, radius = 10), Rectangle(lineColor = {162, 29, 33}, fillColor = {255, 255, 255},
            fillPattern=
FillPattern.Solid, extent = {{-8, 40}, {54, -14}}), Text(textColor = {28, 108, 200}, extent = {{-90, 180}, {90, 76}}, textString = "%name", textStyle = {TextStyle.Bold}), Ellipse(lineColor = {162, 29, 33}, fillColor = {255, 255, 255},
            fillPattern=
FillPattern.Solid, extent = {{-54, 40}, {28, -42}}), Ellipse(lineColor = {162, 29, 33}, fillColor = {255, 255, 255},
            fillPattern=
FillPattern.Solid, extent = {{-24, 12}, {0, -12}}), Text(textColor = {28, 108, 200}, extent = {{-108, 78}, {-64, 62}}, textString = "occ"), Text(textColor = {28, 108, 200}, extent = {{-100, -30}, {-58, -44}}, textString = "Status"), Text(textColor = {28, 108, 200}, extent = {{62, 60}, {106, 44}}, textString = "Start"), Text(textColor = {28, 108, 200}, extent = {{56, 8}, {106, -8}}, textString = "Proof"), Text(textColor = {28, 108, 200}, extent = {{-102, -66}, {-60, -78}}, textString = "DDSP"), Text(textColor = {28, 108, 200}, extent = {{56, -36}, {106, -52}}, textString = "Speed"), Line(points = {{-54, 54}, {-10, 52}, {-50, 52}}, color = {0, 127, 0}, pattern = LinePattern.None), Line(points = {{-52, 50}, {-2, 48}, {30, 54}, {-26, 68}, {134, 70}, {148, 22}, {152, 42}}, color = {0, 127, 0}, pattern = LinePattern.None), Line(points = {{-68, 72}, {6, 72}}, color = {0, 127, 0}, pattern = LinePattern.None), Line(points = {{-52, 70}, {6, 66}, {-28, 66}}, color = {0, 127, 0}, pattern = LinePattern.None), Line(points = {{42, 60}, {36, 54}, {28, 70}, {42, 62}}, color = {0, 127, 0}, pattern = LinePattern.None), Text(textColor = {28, 108, 200}, extent = {{-96, 44}, {-52, 28}}, textString = "openDam")}),
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}})),
    Documentation(revisions = "<html>
<ul>
<li>
September 11, 2020, by Henry Nickels:</br>
First implementation.</li>
</ul>
</html>", info = "<html>
<h4>Supply Fan Start/Stop.</h4>
<p>This block commands the supply fan to start 
(<code>supFanStart</code>) when the unit enters occupied
(<code>occ</code>) mode. When supply fan status
(<code>SupFanStatus</code>) is proven, fan speed control
(<code>SupFanSpeed</code>) is enabled and the
supply fan proof (<code>supFanProof</code>) is turned on.</p>
<h4>Down Duct Static Pressure Control</h4>
<p>The supply fan speed 
(<code>supFanSpeed</code>) is modulated to  maintain
the down duct static pressure (<code>DDSP</code>) at
set point. The down duct set point is reset between minimum 
(<code>minDDSPset</code>) and maximum 
(<code>maxDDSPset</code>) values determined by TAB. The reset is
based on the most open damper
(<code>mostOpenDam</code>) remaining at a specific position
(<code>damSet</code>) (i.e. The terminal unit air flow set point is satisfied
 with its primary air damper 90% open).</p>
<p>There is also an option for a fixed down duct static pressure set point
(<code>cvDDSPset</code>) when the variable volume parameter
<code>vvUnit</code> is false.
</p>
</html>"));
end SupplyFanController;
