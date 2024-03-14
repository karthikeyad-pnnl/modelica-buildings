within Buildings.Controls.OBC.FDE.DOAS;

block Dewpoint "Calculates dewpoint temperature from Tdb and relative humidity."
  // ---inputs---
  Buildings.Controls.OBC.CDL.Interfaces.RealInput relHum(final min = 0, final max = 100) "Relative humidity sensor" annotation(
    Placement(transformation(extent = {{-142, 52}, {-102, 92}}), iconTransformation(extent = {{-142, 40}, {-102, 80}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput dbT(final unit = "K", final displayUnit = "degC", final quantity = "ThermodynamicTemperature") "Dry bulb temperature sensor." annotation(
    Placement(transformation(extent = {{-142, 12}, {-102, 52}}), iconTransformation(extent = {{-142, -80}, {-102, -40}})));
  // ---outputs---
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput dpT(final unit = "K", final displayUnit = "degC", final quantity = "ThermodynamicTemperature") "Dewpoint temperature" annotation(
    Placement(transformation(extent = {{102, -96}, {142, -56}}), iconTransformation(extent = {{102, -20}, {142, 20}})));
  Buildings.Controls.OBC.CDL.Reals.Log log "Calculate natural log of input value." annotation(
    Placement(transformation(extent = {{-32, 56}, {-12, 76}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con100(final k = 100) "Real constant 100" annotation(
    Placement(transformation(extent = {{-92, 46}, {-72, 66}})));
  Buildings.Controls.OBC.CDL.Reals.Multiply pro "Calculate the product of dry bulb temperature (degC) and 17.27" annotation(
    Placement(transformation(extent = {{-30, 16}, {-10, 36}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con1727(final k = 17.27) "Real constant 17.27" annotation(
    Placement(visible = true, transformation(origin = {6, 2}, extent = {{-62, -10}, {-42, 10}}, rotation = 0)));
  Buildings.Controls.OBC.CDL.Reals.Add add2 "Add dry bulb temperature (degC) and 237.3" annotation(
    Placement(transformation(extent = {{-30, -34}, {-10, -14}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con2373(final k = 237.3) "Real constant 237.3" annotation(
    Placement(transformation(extent = {{-62, -52}, {-42, -32}})));
  Buildings.Controls.OBC.CDL.Reals.Add add1 "Add two values." annotation(
    Placement(transformation(extent = {{30, 16}, {50, 36}})));
  Buildings.Controls.OBC.CDL.Reals.Multiply pro1 "Output product of two inputs" annotation(
    Placement(visible = true, transformation(origin = {8, 4}, extent = {{4, -46}, {24, -26}}, rotation = 0)));
  Buildings.Controls.OBC.CDL.Reals.Add add3 "Output the sum of two inputs" annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{32, -80}, {52, -60}}, rotation = 0)));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con1(final k = 1) "Real constant 1" annotation(
    Placement(transformation(extent = {{4, -72}, {24, -52}})));
 //Buildings.Controls.OBC.CDL.Reals.Add add4(final k2 = -1) "Subtract 273.15 from dry bulb temperature." annotation(
    //Placement(transformation(extent = {{-92, 16}, {-72, 36}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con27315(final k = 273.15) "Real constant 273.15" annotation(
    Placement(visible = true, transformation(origin = {-18, -14}, extent = {{-92, -14}, {-72, 6}}, rotation = 0)));
  Buildings.Controls.OBC.CDL.Reals.Add add5 "Add 273.15 to the final value to output dew point temperature in K" annotation(
    Placement(transformation(extent = {{70, -86}, {90, -66}})));
  Buildings.Controls.OBC.CDL.Reals.Divide div4 "Divide relative humidity by 100" annotation(
    Placement(visible = true, transformation(origin = {-52, 74}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  CDL.Reals.Divide div "Output first input divided by second input" annotation(
    Placement(visible = true, transformation(origin = {10, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Buildings.Controls.OBC.CDL.Reals.Divide div1 "Output first input divided by second input" annotation(
    Placement(visible = true, transformation(origin = {82, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Buildings.Controls.OBC.CDL.Reals.Divide div2 annotation(
    Placement(visible = true, transformation(origin = {72, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 Buildings.Controls.OBC.CDL.Reals.Subtract sub "subtract 273.15 from dry bulb temp" annotation(
    Placement(visible = true, transformation(origin = {-76, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(con1727.y, pro.u2) annotation(
    Line(points = {{-34, 2}, {-34, 20}, {-32, 20}}, color = {0, 0, 127}));
  connect(con2373.y, add2.u2) annotation(
    Line(points = {{-40, -42}, {-36, -42}, {-36, -30}, {-32, -30}}, color = {0, 0, 127}));
  connect(log.y, add1.u1) annotation(
    Line(points = {{-10, 66}, {24, 66}, {24, 32}, {28, 32}}, color = {0, 0, 127}));
  connect(con2373.y, pro1.u2) annotation(
    Line(points = {{-40, -42}, {-18, -42}, {-18, -38}, {10, -38}}, color = {0, 0, 127}));
  connect(add3.u1, con1.y) annotation(
    Line(points = {{30, -64}, {28, -64}, {28, -62}, {26, -62}}, color = {0, 0, 127}));
 // connect(con27315.y, add4.u2) annotation(
    //Line(points = {{-88, -18}, {-88, 14}, {-98, 14}, {-98, 20}, {-94, 20}}, color = {0, 0, 127}));
  //connect(dbT, add4.u1) annotation(
   // Line(points = {{-122, 32}, {-94, 32}}, color = {0, 0, 127}));
  //connect(add4.y, pro.u1) annotation(
    //Line(points = {{-70, 26}, {-52, 26}, {-52, 32}, {-32, 32}}, color = {0, 0, 127}));
  //connect(add4.y, add2.u1) annotation(
    //Line(points = {{-70, 26}, {-64, 26}, {-64, -18}, {-32, -18}}, color = {0, 0, 127}));
  connect(add5.y, dpT) annotation(
    Line(points = {{92, -76}, {122, -76}}, color = {0, 0, 127}));
  connect(con27315.y, add5.u2) annotation(
    Line(points = {{-88, -18}, {-88, -68}, {-22, -68}, {-22, -82}, {68, -82}}, color = {0, 0, 127}));
  connect(relHum, div4.u1) annotation(
    Line(points = {{-122, 72}, {-82, 72}, {-82, 80}, {-64, 80}}, color = {0, 0, 127}));
  connect(con100.y, div4.u2) annotation(
    Line(points = {{-70, 56}, {-68, 56}, {-68, 68}, {-64, 68}}, color = {0, 0, 127}));
  connect(div4.y, log.u) annotation(
    Line(points = {{-40, 74}, {-38, 74}, {-38, 66}, {-34, 66}}, color = {0, 0, 127}));
  connect(add2.y, div.u2) annotation(
    Line(points = {{-8, -24}, {-6, -24}, {-6, 8}, {-2, 8}}, color = {0, 0, 127}));
  connect(pro.y, div.u1) annotation(
    Line(points = {{-8, 26}, {-6, 26}, {-6, 20}, {-2, 20}}, color = {0, 0, 127}));
  connect(div.y, add1.u2) annotation(
    Line(points = {{22, 14}, {22, 20}, {28, 20}}, color = {0, 0, 127}));
  connect(add1.y, div1.u1) annotation(
    Line(points = {{52, 26}, {70, 26}}, color = {0, 0, 127}));
  connect(con1727.y, div1.u2) annotation(
    Line(points = {{-34, 2}, {64, 2}, {64, 14}, {70, 14}}, color = {0, 0, 127}));
  connect(div1.y, add3.u2) annotation(
    Line(points = {{94, 20}, {108, 20}, {108, -18}, {-6, -18}, {-6, -76}, {30, -76}}, color = {0, 0, 127}));
  connect(pro1.y, div2.u1) annotation(
    Line(points = {{34, -32}, {47, -32}, {47, -34}, {60, -34}}, color = {0, 0, 127}));
  connect(add3.y, div2.u2) annotation(
    Line(points = {{54, -70}, {54, -59}, {60, -59}, {60, -46}}, color = {0, 0, 127}));
  connect(div2.y, add5.u1) annotation(
    Line(points = {{84, -40}, {94, -40}, {94, -56}, {62, -56}, {62, -70}, {68, -70}}, color = {0, 0, 127}));
 connect(dbT, sub.u1) annotation(
    Line(points = {{-122, 32}, {-88, 32}}, color = {0, 0, 127}));
 connect(con27315.y, sub.u2) annotation(
    Line(points = {{-88, -18}, {-82, -18}, {-82, 6}, {-96, 6}, {-96, 20}, {-88, 20}}, color = {0, 0, 127}));
 connect(sub.y, pro.u1) annotation(
    Line(points = {{-64, 26}, {-50, 26}, {-50, 32}, {-32, 32}}, color = {0, 0, 127}));
 connect(sub.y, add2.u1) annotation(
    Line(points = {{-64, 26}, {-64, -18}, {-32, -18}}, color = {0, 0, 127}));
 connect(div1.y, pro1.u1) annotation(
    Line(points = {{94, 20}, {94, -8}, {2, -8}, {2, -26}, {10, -26}}, color = {0, 0, 127}));
  annotation(
    defaultComponentName = "Dewpt",
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Text(textColor = {28, 108, 200}, extent = {{-90, 180}, {90, 76}}, textString = "%name", textStyle = {TextStyle.Bold}), Rectangle(lineColor = {179, 151, 128}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}, radius = 10), Text(textColor = {28, 108, 200}, extent = {{-60, 66}, {28, -30}}, textString = "T"), Text(textColor = {28, 108, 200}, extent = {{-28, 0}, {62, -60}}, textString = "dp"), Text(textColor = {28, 108, 200}, extent = {{-96, 74}, {-58, 46}}, textString = "relHum"), Text(textColor = {28, 108, 200}, extent = {{-96, -50}, {-66, -70}}, textString = "dbT"), Text(textColor = {28, 108, 200}, extent = {{64, 12}, {98, -12}}, textString = "%dpT")}),
    Diagram(coordinateSystem(preserveAspectRatio = false)),
    Documentation(revisions = "<html>
<ul>
<li>
September 16, 2020, by Henry Nickels:</br>
First implementation.</li>
</ul>
</html>", info = "<html>
<h4>Dewpoint Temperature Calculation</h4>
<p>This block calculates dewpoint 
(<code>dpT</code>) using a reduced formula that only
requires dry bulb temperature 
(<code>dbT</code>) and relative humidity 
(<code>relHum</code>) inputs.
</p> 
</html>"));
end Dewpoint;
