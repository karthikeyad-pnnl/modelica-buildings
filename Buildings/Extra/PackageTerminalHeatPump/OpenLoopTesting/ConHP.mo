within Buildings.Extra.PackageTerminalHeatPump.OpenLoopTesting;
model ConHP
    .Extra.PackageTerminalHeatPump.FinalizedModel.HVACController hVACController annotation(Placement(transformation(extent = {{-38,2},{-18,22}},origin = {0,0},rotation = 0)));
    .Extra.PackageTerminalHeatPump.Experiments.HPSystem chiDXHeaEco annotation(Placement(transformation(extent = {{54,-12},{94,28}},origin = {0,0},rotation = 0)));
    annotation(Icon(coordinateSystem(preserveAspectRatio = false,extent = {{-100.0,-100.0},{100.0,100.0}}),graphics = {Rectangle(lineColor={0,0,0},fillColor={230,230,230},fillPattern=FillPattern.Solid,extent={{-100.0,-100.0},{100.0,100.0}}),Text(lineColor={0,0,255},extent={{-150,150},{150,110}},textString="%name")}));
end ConHP;
