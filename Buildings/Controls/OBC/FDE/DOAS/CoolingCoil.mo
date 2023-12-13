within Buildings.Controls.OBC.FDE.DOAS;
block CoolingCoil "This block commands the cooling coil."
  parameter Real cctPIk = 0.0000001
    "Cooling coil CCT PI gain value k.";

  parameter Real cctPITi = 0.000025
    "Cooling coil CCT PI time constant value Ti.";

  parameter Real SAccPIk = 0.0000001
    "Cooling coil SAT PI gain value k.";

  parameter Real SAccPITi = 0.000025
    "Cooling coil SAT PI time constant value Ti.";

  parameter Real erwDPadj(
    final unit = "K",
    final displayUnit = "degC",
    final quantity = "ThermodynamicTemperature") = 5
    "Value subtracted from ERW supply air dewpoint.";

  // ---inputs---
  Buildings.Controls.OBC.CDL.Interfaces.RealInput saT(
    final unit = "K",
    final displayUnit = "degC",
    final quantity = "ThermodynamicTemperature")
    "Supply air temperature sensor."
    annotation (Placement(transformation(extent = {{-142, -56}, {-102, -16}}),
      iconTransformation(extent = {{-142, 36}, {-102, 76}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput supCooSP(
    final unit = "K",
    final displayUnit = "degC",
    final quantity = "ThermodynamicTemperature")
    "Supply air temperature cooling set point."
    annotation (Placement(transformation(extent = {{-142, -86}, {-102, -46}}),
      iconTransformation(extent = {{-142, 8}, {-102, 48}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput supFanProof
    "True when supply fan is proven on."
    annotation (Placement(transformation(extent = {{-142, -116}, {-102, -76}}),
      iconTransformation(extent = {{-142, 64}, {-102, 104}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput erwHum(
    final min = 0,
    final max = 1,
    unit = "1")
    "ERW relative humidity sensor"
    annotation (Placement(transformation(extent = {{-142, 34}, {-102, 74}}),
      iconTransformation(extent = {{-142, -78}, {-102, -38}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput erwT(
    final unit = "K",
    final displayUnit = "degC",
    final quantity = "ThermodynamicTemperature")
    "ERW dry bulb temperature sensor."
    annotation (Placement(transformation(extent = {{-142, 4}, {-102, 44}}),
      iconTransformation(extent = {{-142, -104}, {-102, -64}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput ccT(
    final unit = "K",
    final displayUnit = "degC",
    final quantity = "ThermodynamicTemperature")
    "Cooling coil discharge air temperature sensor."
    annotation (Placement(transformation(extent = {{-142, 64}, {-102, 104}}),
      iconTransformation(extent = {{-142, -52}, {-102, -12}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput dehumMode
    "True when dehumidification mode is on."
    annotation (Placement(transformation(extent = {{-142, -24}, {-102, 16}}),
      iconTransformation(extent = {{-142, -26}, {-102, 14}})));

  // ---outputs---
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yCC
    "Cooling coil control signal"
    annotation (Placement(transformation(extent = {{102, 56}, {142, 96}}),
      iconTransformation(extent = {{102, -20}, {142, 20}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant erwAdjDP(
    final k = erwDPadj)
    "ERW dewpoint set point adjustment"
    annotation (Placement(transformation(extent = {{-76, 12}, {-56, 32}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con0(
    final k = 0)
    "Real constant 0"
    annotation (Placement(transformation(extent = {{-20, -62}, {0, -42}})));

  Buildings.Controls.OBC.CDL.Continuous.Add sub(
    final k2 = -1)
    annotation (Placement(transformation(extent = {{-44, 32}, {-24, 52}})));

  Buildings.Controls.OBC.CDL.Logical.Switch swi
    "Logical switch outputs supply air PI value when fan is proven on."
    annotation (Placement(transformation(extent = {{14, -54}, {34, -34}})));

  Buildings.Controls.OBC.CDL.Logical.Switch swi1
    "Logical switch passes different PI calculations to yCC based on dehumidification 
    mode."
    annotation (Placement(transformation(extent = {{58, 66}, {78, 86}})));

  Buildings.Controls.OBC.CDL.Logical.And and2
    "Logical AND;true when dehumidification is on and supply fan is proven on."
    annotation (Placement(transformation(extent = {{-20, -14}, {0, 8}})));

  Buildings.Controls.OBC.CDL.Continuous.Add add2
    "Convert dewpoint degC to K"
    annotation (Placement(transformation(extent = {{-14, 26}, {6, 46}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant conKel(
    final k = 273.15)
    "Real constant 273.15"
    annotation (Placement(transformation(extent = {{-44, 6}, {-24, 26}})));

  Buildings.Controls.OBC.CDL.Continuous.PID conPID2
    annotation (Placement(visible = true, transformation(origin = {-62, -42},
      extent = {{-10, -10}, {10, 10}}, rotation = 0)));

  Buildings.Controls.OBC.CDL.Continuous.PID conPID
    annotation (Placement(visible = true,
      transformation(origin = {14, 80}, extent = {{-10, -10}, {10, 10}})));

  Buildings.Controls.OBC.CDL.Psychrometrics.DewPoint_TDryBulPhi dewPoi
    annotation (Placement(visible = true,
      transformation(origin = {-66, 48},
      extent = {{-10, -10}, {10, 10}}, rotation = 0)));

equation
  connect(con0.y, swi.u3) annotation (
    Line(points = {{2, -52}, {12, -52}}, color = {0, 0, 127}));

  connect(erwAdjDP.y, sub.u2) annotation (
    Line(points = {{-54, 22}, {-50, 22}, {-50, 36}, {-46, 36}}, color = {0, 0, 127}));

  connect(swi.u2, supFanProof) annotation (
    Line(points = {{12, -44}, {6, -44}, {6, -96}, {-122, -96}}, color = {255, 0, 255}));

  connect(and2.u1, dehumMode) annotation (
    Line(points = {{-22, -3}, {-78, -3}, {-78, -4}, {-122, -4}}, color = {255, 0, 255}));

  connect(supFanProof, and2.u2) annotation (
    Line(points = {{-122, -96}, {-42, -96}, {-42, -11.8}, {-22, -11.8}}, color = {255, 0, 255}));

  connect(and2.y, swi1.u2) annotation (
    Line(points = {{2, -3}, {36, -3}, {36, 76}, {56, 76}}, color = {255, 0, 255}));

  connect(swi1.y, yCC) annotation (
    Line(points = {{80, 76}, {122, 76}}, color = {0, 0, 127}));

  connect(swi.y, swi1.u3) annotation (
    Line(points = {{36, -44}, {46, -44}, {46, 68}, {56, 68}}, color = {0, 0, 127}));

  connect(sub.y, add2.u1) annotation (
    Line(points = {{-22, 42}, {-16, 42}}, color = {0, 0, 127}));

  connect(conKel.y, add2.u2) annotation (
    Line(points = {{-22, 16}, {-20, 16}, {-20, 30}, {-16, 30}}, color = {0, 0, 127}));

  connect(saT, conPID2.u_m) annotation (
    Line(points = {{-122, -36}, {-90, -36}, {-90, -54}, {-62, -54}}, color = {0, 0, 127}));

  connect(supCooSP, conPID2.u_s) annotation (
    Line(points = {{-122, -66}, {-80, -66}, {-80, -42}, {-74, -42}}, color = {0, 0, 127}));

  connect(conPID2.y, swi.u1) annotation (
    Line(points = {{-50, -42}, {-17, -42}, {-17, -36}, {12, -36}}, color = {0, 0, 127}));

  connect(ccT, conPID.u_m) annotation (
    Line(points = {{-122, 84}, {-22, 84}, {-22, 68}, {14, 68}}, color = {0, 0, 127}));

  connect(add2.y, conPID.u_s) annotation (
    Line(points = {{8, 36}, {-2, 36}, {-2, 80}, {2, 80}}, color = {0, 0, 127}));

  connect(conPID.y, swi1.u1) annotation (
    Line(points = {{26, 80}, {56, 80}, {56, 84}}, color = {0, 0, 127}));

  connect(erwT, dewPoi.TDryBul) annotation (
    Line(points = {{-122, 24}, {-88, 24}, {-88, 54}, {-78, 54}}, color = {0, 0, 127}));

  connect(erwHum, dewPoi.phi) annotation (
    Line(points = {{-122, 54}, {-94, 54}, {-94, 42}, {-78, 42}}, color = {0, 0, 127}));

  connect(dewPoi.TDewPoi, sub.u1) annotation (
    Line(points = {{-54, 48}, {-46, 48}}, color = {0, 0, 127}));

  annotation (
    defaultComponentName = "Cooling",
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(lineColor = {179, 151, 128}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                                                                                  FillPattern.Solid, extent = {{-100, 100}, {100, -100}}, radius = 10), Text(textColor = {28, 108, 200}, extent = {{-90, 180}, {90, 76}}, textString = "%name", textStyle = {TextStyle.Bold}), Text(textColor = {28, 108, 200}, extent = {{-98, 92}, {-54, 78}}, textString = "supFanProof"), Text(textColor = {28, 108, 200}, extent = {{-110, 62}, {-70, 50}}, textString = "saT"), Text(textColor = {28, 108, 200}, extent = {{-98, 34}, {-58, 22}}, textString = "supCooSP"), Text(textColor = {28, 108, 200}, extent = {{-108, -26}, {-68, -38}}, textString = "ccT"), Text(textColor = {28, 108, 200}, extent = {{-100, -52}, {-60, -64}}, textString = "erwHum"), Text(textColor = {28, 108, 200}, extent = {{-108, -78}, {-68, -90}}, textString = "erwT"), Text(textColor = {28, 108, 200}, extent = {{-98, 0}, {-58, -12}}, textString = "dehumMode"), Text(textColor = {28, 108, 200}, extent = {{62, 8}, {106, -8}}, textString = "yCC"), Rectangle(lineColor = {28, 108, 200}, fillColor = {85, 255, 255},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid, extent = {{-22, 68}, {6, -66}}), Rectangle(lineColor = {28, 108, 200}, fillColor = {0, 0, 255},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid, extent = {{-14, 58}, {68, 56}}), Ellipse(lineColor = {28, 108, 200}, fillColor = {0, 0, 255},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid, extent = {{-16, 60}, {-10, 54}}), Rectangle(lineColor = {28, 108, 200}, fillColor = {0, 0, 255},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid, extent = {{-2, -56}, {80, -58}}), Ellipse(lineColor = {28, 108, 200}, fillColor = {0, 0, 255},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid, extent = {{-4, -54}, {2, -60}}), Polygon(lineColor = {127, 0, 0}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid, points = {{42, -58}, {30, -66}, {30, -50}, {42, -58}}), Polygon(lineColor = {127, 0, 0}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid, points = {{42, -58}, {54, -66}, {54, -50}, {42, -58}}), Ellipse(lineColor = {127, 0, 0}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid, extent = {{38, -54}, {46, -62}}), Ellipse(lineColor = {127, 0, 0}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid, extent = {{36, -32}, {48, -46}}), Rectangle(lineColor = {127, 0, 0}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid, extent = {{36, -38}, {48, -48}}), Line(points = {{42, -48}, {42, -54}}, color = {127, 0, 0})}),
    Diagram(coordinateSystem(preserveAspectRatio = false)),
    Documentation(revisions = "<html>
<ul>
<li>
September 17, 2020, by Henry Nickels:</br>
First implementation.</li>
</ul>
</html>", info = "<html>
<h4>Normal Operation</h4>
<p>When the DOAS is energized 
(<code>supFanProof</code>) the cooling coil will
be commanded 
(<code>yCC</code>) to maintain the 
supply air temperature 
(<code>saT</code>) at the supply air temperature cooling set point 
(<code>supCooSP</code>). 

<h4>Dehumidification Operation</h4>
<p>When the DOAS is energized 
(<code>supFanProof</code>) and in dehumidification mode 
(<code>dehumMode</code>) the cooling coil will
be commanded 
(<code>yCC</code>) to maintain the cooling coil temperature 
(<code>ccT</code>) at an adjustable value 
(<code>erwDPadj</code>) below the energy recovery supply
dewpoint (<code>Dewpt.dpT</code>). The dewpoint value is calculated 
from the energy recovery supply relative humidity 
(<code>erwHum</code>) and temperature 
(<code>erwT</code>).</p>
</html>"));
end CoolingCoil;
