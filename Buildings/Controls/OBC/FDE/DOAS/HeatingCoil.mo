within Buildings.Controls.OBC.FDE.DOAS;
block HeatingCoil "This block commands the heating coil."
  parameter Real SArhcPIk = 0.0000001
  "Heating coil SAT PI gain value k.";

  parameter Real SArhcPITi = 0.000025
  "Heating coil SAT PI time constant value Ti.";

  // ---inputs---
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput supFanProof
  "True when supply fan is proven on."
  annotation(Placement(transformation(extent = {{-142, -20}, {-102, 20}}), iconTransformation(extent = {{-142, -20}, {-102, 20}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput saT "Supply air temperature sensor value."
  annotation(Placement(transformation(extent = {{-142, -60}, {-102, -20}}), iconTransformation(extent = {{-142, -70}, {-102, -30}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput supHeaSP
  "Supply air temperature heating set point." annotation(Placement(transformation(extent = {{-142, 16}, {-102, 56}}), iconTransformation(extent = {{-142, 28}, {-102, 68}})));

  // ---outputs---
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yRHC "Reheat coil valve command."
  annotation(Placement(transformation(extent = {{102, -20}, {142, 20}}), iconTransformation(extent = {{102, -20}, {142, 20}})));

  Buildings.Controls.OBC.CDL.Reals.Switch swi
  "Logical switch passes supply air heating set point when supply fan is proven otherwise sends 0 set point." annotation(Placement(transformation(extent={{36,-12},
            {56,8}})));

  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con0(
  final k = 0)
  "Real constant 0"
  annotation(Placement(transformation(extent={{-20,-38},{0,-18}})));

  Buildings.Controls.OBC.CDL.Reals.PID conPID1(
  Ti = SArhcPITi,
  k = SArhcPIk)
  annotation(Placement(visible = true, transformation(origin={-30,24},  extent = {{-10, -10}, {10, 10}}, rotation = 0)));

equation

  connect(swi.u2, supFanProof) annotation (
    Line(points={{34,-2},{-62,-2},{-62,0},{-122,0}},
                                         color = {255, 0, 255}));

  connect(con0.y, swi.u3) annotation (
    Line(points={{2,-28},{12,-28},{12,-12},{28,-12},{28,-10},{34,-10}},
                                                                  color = {0, 0, 127}));

  connect(saT, conPID1.u_m) annotation (
    Line(points={{-122,-40},{-30,-40},{-30,12}},       color = {0, 0, 127}));

  connect(conPID1.y, swi.u1) annotation (Line(points={{-18,24},{-4,24},{-4,6},{
          34,6}}, color={0,0,127}));
  connect(supHeaSP, conPID1.u_s) annotation (Line(points={{-122,36},{-86,36},{
          -86,32},{-50,32},{-50,24},{-42,24}}, color={0,0,127}));
  connect(swi.y, yRHC) annotation (Line(points={{58,-2},{90,-2},{90,0},{122,0}},
        color={0,0,127}));
  annotation (
    defaultComponentName = "Heating",
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(lineColor = {179, 151, 128}, fillColor = {255, 255, 255},
            fillPattern=
FillPattern.Solid, extent = {{-100, 100}, {100, -100}}, radius = 10), Rectangle(lineColor = {238, 46, 47}, fillColor = {254, 56, 30},
            fillPattern=
FillPattern.Solid, extent = {{-22, 68}, {6, -66}}), Rectangle(fillColor = {162, 29, 33},
            fillPattern=
FillPattern.Solid, extent = {{-14, 58}, {68, 56}}), Ellipse(lineColor = {28, 108, 200}, fillColor = {162, 29, 33},
            fillPattern=
FillPattern.Solid, extent = {{-16, 60}, {-10, 54}}), Rectangle(fillColor = {162, 29, 33},
            fillPattern=
FillPattern.Solid, extent = {{-2, -56}, {80, -58}}), Ellipse(lineColor = {28, 108, 200}, fillColor = {162, 29, 33},
            fillPattern=
FillPattern.Solid, extent = {{-4, -54}, {2, -60}}), Polygon(lineColor = {127, 0, 0}, fillColor = {255, 255, 255},
            fillPattern=
FillPattern.Solid, points = {{42, -58}, {30, -66}, {30, -50}, {42, -58}}), Polygon(lineColor = {127, 0, 0}, fillColor = {255, 255, 255},
            fillPattern=
FillPattern.Solid, points = {{42, -58}, {54, -66}, {54, -50}, {42, -58}}), Ellipse(lineColor = {127, 0, 0}, fillColor = {255, 255, 255},
            fillPattern=
FillPattern.Solid, extent = {{38, -54}, {46, -62}}), Line(points = {{42, -48}, {42, -54}}, color = {127, 0, 0}), Ellipse(lineColor = {127, 0, 0}, fillColor = {255, 255, 255},
            fillPattern=
FillPattern.Solid, extent = {{36, -32}, {48, -46}}), Rectangle(lineColor = {127, 0, 0}, fillColor = {255, 255, 255},
            fillPattern=
FillPattern.Solid, extent = {{36, -38}, {48, -48}}), Text(textColor = {28, 108, 200}, extent = {{-90, 180}, {90, 76}}, textString = "%name", textStyle = {TextStyle.Bold}), Text(textColor = {28, 108, 200}, extent = {{-98, 8}, {-54, -6}}, textString = "supFanProof"), Text(textColor = {28, 108, 200}, extent = {{58, 8}, {102, -6}}, textString = "yRHC"), Text(textColor = {28, 108, 200}, extent = {{-98, 54}, {-58, 44}}, textString = "supHeaSP"), Text(textColor = {28, 108, 200}, extent = {{-108, -42}, {-68, -54}}, textString = "saT")}),
    Diagram(coordinateSystem(preserveAspectRatio = false)),
    experiment(StopTime = 5760, __Dymola_Algorithm = "Dassl"));
end HeatingCoil;
