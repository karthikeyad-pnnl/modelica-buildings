within Buildings.Extra.PackageTerminalHeatPump.OpenLoopTesting;
model HouseModel
    .TrainingPack.Day4.W4_ExternalCode.HouseExercises.Rooms.Interfaces.AirFlowWindowRoom airFlowWindowRoom annotation(Placement(transformation(extent = {{-4.470346645526092,11.5296533544739},{28.470346645526092,44.4703466455261}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con(k = 273) annotation(Placement(transformation(extent = {{-72,4},{-52,24}},origin = {0,0},rotation = 0)));
    .Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con2(k = 1) annotation(Placement(transformation(extent = {{72.0,66.0},{92.0,86.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con3(k = 1) annotation(Placement(transformation(extent = {{40.0,66.0},{60.0,86.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Fluid.Sources.Boundary_pT bou(nPorts = 1,redeclare package Medium = Buildings.Media.Air) annotation(Placement(transformation(extent = {{-94.0,34.0},{-74.0,54.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Fluid.Sources.Boundary_pT bou2(nPorts = 1,redeclare package Medium = Buildings.Media.Air) annotation(Placement(transformation(extent = {{-94.0,66.0},{-74.0,86.0}},origin = {0.0,0.0},rotation = 0.0)));
equation
    connect(con3.y,airFlowWindowRoom.Theta) annotation(Line(points = {{62,76},{68,76},{68,35.57635945694201},{29.129160511347138,35.57635945694201}},color = {0,0,127}));
    connect(con2.y,airFlowWindowRoom.Radiation) annotation(Line(points = {{94,76},{100,76},{100,30.635255463284174},{29.129160511347138,30.635255463284174}},color = {0,0,127}));
    connect(con.y,airFlowWindowRoom.TOut) annotation(Line(points = {{-50,14},{-28.223394121494614,14},{-28.223394121494614,25.694151469626348},{-6.446788242989225,25.694151469626348}},color = {0,0,127}));
    connect(airFlowWindowRoom.SupAir,bou2.ports[1]) annotation(Line(points = {{-5.129160511347138,39.19983571895774},{-39.56458025567357,39.19983571895774},{-39.56458025567357,76},{-74,76}},color = {0,127,255}));
    connect(airFlowWindowRoom.RetAir,bou.ports[1]) annotation(Line(points = {{-5.129160511347138,35.57635945694201},{-39.56458025567357,35.57635945694201},{-39.56458025567357,44},{-74,44}},color = {0,127,255}));
    annotation(Icon(coordinateSystem(preserveAspectRatio = false,extent = {{-100.0,-100.0},{100.0,100.0}}),graphics = {Rectangle(lineColor={0,0,0},fillColor={230,230,230},fillPattern=FillPattern.Solid,extent={{-100.0,-100.0},{100.0,100.0}}),Text(lineColor={0,0,255},extent={{-150,150},{150,110}},textString="%name")}));
end HouseModel;
