within Buildings.Extra.PackageTerminalHeatPump.OpenLoopTesting;
model ConComp
    Buildings.Extra.PackageTerminalHeatPump.FinalizedModel.ConCoolingSetting conCoolingSetting annotation(Placement(transformation(extent = {{-28.0,38.0},{-8.0,58.0}},origin={-2,2},     rotation = 0.0)));
    Buildings.Extra.PackageTerminalHeatPump.FinalizedModel.ControllerHeatingFan conHeaFan annotation(Placement(transformation(extent = {{100.0,34.0},{120.0,54.0}},origin = {0.0,0.0},rotation = 0.0)));
    Buildings.Extra.PackageTerminalHeatPump.FinalizedModel.ConHP conHP annotation(Placement(transformation(extent = {{24.0,-60.0},{44.0,-40.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con(k = 1) annotation(Placement(transformation(extent = {{-94,60},{-74,80}},origin = {0,0},rotation = 0)));
    .Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con2(k = 1) annotation(Placement(transformation(extent = {{-38,-36},{-18,-16}},origin = {0,0},rotation = 0)));
    .Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con3(k = 1) annotation(Placement(transformation(extent = {{56.0,64.0},{76.0,84.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con4(k = 1) annotation(Placement(transformation(extent = {{56.0,34.0},{76.0,54.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Controls.OBC.CDL.Continuous.Sources.Sine sin(freqHz = 1 / 3600) annotation(Placement(transformation(extent = {{-94.0,26.0},{-74.0,46.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Controls.OBC.CDL.Continuous.Sources.Sine sin2(freqHz = 1 / 3600) annotation(Placement(transformation(extent = {{-38,-90},{-18,-70}},origin = {0,0},rotation = 0)));
    .Buildings.Controls.OBC.CDL.Continuous.Sources.Sine sin3(freqHz = 1 / 3600) annotation(Placement(transformation(extent = {{56.0,4.0},{76.0,24.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Sources.BooleanConstant booleanConstant(k = false) annotation(Placement(transformation(extent = {{-94.0,-32.0},{-74.0,-12.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Sources.BooleanConstant booleanConstant2(k = false) annotation(Placement(transformation(extent = {{-94.0,-62.0},{-74.0,-42.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Sources.BooleanConstant booleanConstant3 annotation(Placement(transformation(extent = {{-94.0,-92.0},{-74.0,-72.0}},origin = {0.0,0.0},rotation = 0.0)));
equation
    connect(con3.y,conHeaFan.TSetRooHea) annotation(Line(points = {{78,74},{88.5,74},{88.5,50},{99,50}},color = {0,0,127}));
    connect(con4.y,conHeaFan.TSetRooCoo) annotation(Line(points = {{78,44},{99,44}},color = {0,0,127}));
    connect(con.y,conCoolingSetting.TSetRooCoo) annotation(Line(points={{-72,70},
          {-50.9888,70},{-50.9888,55.9956},{-31.9776,55.9956}},                                                                                                                            color = {0,0,127}));
    connect(con2.y,conHP.THeaSup) annotation(Line(points = {{-16,-26},{3.0111875270703585,-26},{3.0111875270703585,-43.1839648783481},{22.022375054140717,-43.1839648783481}},color = {0,0,127}));
    connect(sin3.y,conHeaFan.TRoo) annotation(Line(points = {{78,14},{88.5,14},{88.5,38},{99,38}},color = {0,0,127}));
    connect(sin.y,conCoolingSetting.TRoo) annotation(Line(points={{-72,36},{
          -50.9683,36},{-50.9683,43.4848},{-31.9366,43.4848}},                                                                                                                         color = {0,0,127}));
    connect(sin2.y,conHP.TCooSup) annotation(Line(points = {{-16,-80},{4,-80},{4,-58.93536206742333},{22.063394317653938,-58.93536206742333}},color = {0,0,127}));
    connect(booleanConstant.y,conHP.ConHeaCoo) annotation(Line(points = {{-73,-22},{-50,-22},{-50,-47.40894902020943},{22.022375054140717,-47.40894902020943}},color = {255,0,255}));
    connect(booleanConstant2.y,conHP.ConHeaSup) annotation(Line(points = {{-73,-52},{-25.468302841173035,-52},{-25.468302841173035,-51.10068273639893},{22.06339431765393,-51.10068273639893}},color = {255,0,255}));
    connect(booleanConstant3.y,conHP.ConHP) annotation(Line(points = {{-73,-82},{-50,-82},{-50,-55.2026090877206},{22.06339431765393,-55.2026090877206}},color = {255,0,255}));
    annotation(Icon(coordinateSystem(preserveAspectRatio = false,extent = {{-100.0,-100.0},{100.0,100.0}}),graphics={  Rectangle(lineColor={0,0,0},fillColor={230,230,230},
            fillPattern =                                                                                                                                                              FillPattern.Solid,extent={{-100.0,-100.0},{100.0,100.0}}),Text(lineColor={0,0,255},extent={{-150,150},{150,110}},textString
            =                                                                                                                                                                                                        "%name")}));
end ConComp;
