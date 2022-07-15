within Buildings.Extra.PackageTerminalHeatPump.Experiments;
model HPEco
    .Buildings.Controls.OBC.CDL.Interfaces.RealInput u annotation(Placement(transformation(extent = {{-148.80048743150053,57.184589189426646},{-108.80048743150053,97.18458918942665}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Controls.OBC.CDL.Interfaces.RealInput u2 annotation(Placement(transformation(extent = {{-148.0,-18.0},{-108.0,22.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Controls.OBC.CDL.Interfaces.IntegerInput u3 annotation(Placement(transformation(extent = {{-149.21068006663268,-64.23243080969485},{-109.21068006663268,-24.23243080969484}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Controls.OBC.CDL.Interfaces.RealInput u4 annotation(Placement(transformation(extent = {{-148.80048743150053,-99.5089974310612},{-108.80048743150053,-59.5089974310612}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation(Placement(transformation(extent = {{-140.0,20.0},{-100.0,60.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Fluid.Sources.Outside out(nPorts = 2) annotation(Placement(transformation(extent = {{-102.0,28.0},{-82.0,48.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Fluid.Sensors.TemperatureTwoPort senTem annotation(Placement(transformation(extent = {{-42.0,28.0},{-22.0,48.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Extra.PackageTerminalHeatPump.Experiments.IdeEco ideEco annotation(Placement(transformation(extent = {{10.0,-10.0},{-10.0,10.0}},origin = {-60.0,40.0},rotation = 90.0)));
    .Buildings.Fluid.Movers.FlowControlled_m_flow fan annotation(Placement(transformation(extent = {{-12.0,28.0},{8.0,48.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Controls.OBC.CDL.Continuous.Gain gai annotation(Placement(transformation(extent = {{-64,70},{-44,90}},origin = {0,0},rotation = 0)));
    .Buildings.Controls.OBC.CDL.Interfaces.RealOutput y annotation(Placement(transformation(extent = {{102.0,64.0},{142.0,104.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Controls.OBC.CDL.Interfaces.RealOutput y2 annotation(Placement(transformation(extent = {{104.0,22.0},{144.0,62.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Controls.OBC.CDL.Interfaces.RealOutput y3 annotation(Placement(transformation(extent = {{104.0,-80.0},{144.0,-40.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Fluid.Interfaces.FluidPort_a port_a annotation(Placement(transformation(extent = {{102.0,-10.0},{122.0,10.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Fluid.Interfaces.FluidPort_b port_b annotation(Placement(transformation(extent = {{102.0,-38.0},{122.0,-18.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Fluid.FixedResistances.PressureDrop res annotation(Placement(transformation(extent = {{16.0,28.0},{36.0,48.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Fluid.HeatPumps.EquationFitReversible heaPum annotation(Placement(transformation(extent = {{38.0,-82.0},{58.0,-62.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Fluid.Sources.MassFlowSource_T boundary(nPorts = 1) annotation(Placement(transformation(extent = {{94.0,-82.0},{74.0,-62.0}},origin = {0.0,0.0},rotation = 0.0)));
equation
    connect(u,gai.u) annotation(Line(points = {{-128.80048743150053,77.18458918942665},{-97.40024371575026,77.18458918942665},{-97.40024371575026,80},{-66,80}},color = {0,0,127}));
    connect(u3,heaPum.uMod) annotation(Line(points = {{-129.21068006663268,-44.23243080969485},{-49.10534003331634,-44.23243080969485},{-49.10534003331634,-72},{37,-72}},color = {255,127,0}));
    connect(u4,heaPum.TSet) annotation(Line(points = {{-128.80048743150053,-79.5089974310612},{-96,-79.5089974310612},{-96,-63},{36.6,-63}},color = {0,0,127}));
    connect(out.ports[1],heaPum.port_b2) annotation(Line(points = {{-82,38},{-78,38},{-78,-78},{38,-78}},color = {0,127,255}));
    connect(senTem.port_b,fan.port_a) annotation(Line(points = {{-22,38},{-12,38}},color = {0,127,255}));
    connect(fan.port_b,res.port_a) annotation(Line(points = {{8,38},{16,38}},color = {0,127,255}));
    connect(gai.y,fan.m_flow_in) annotation(Line(points = {{-42,80},{-2,80},{-2,50}},color = {0,0,127}));
    connect(senTem.T,y3) annotation(Line(points = {{-32,49},{-32,57},{44,57},{44,-50},{96,-50},{96,-60},{124,-60}},color = {0,0,127}));
    connect(fan.P,y) annotation(Line(points = {{9,47},{9,84},{122,84}},color = {0,0,127}));
    connect(heaPum.P,y2) annotation(Line(points = {{59,-72.2},{68,-72.2},{68,42},{124,42}},color = {0,0,127}));
    connect(boundary.ports[1],heaPum.port_a2) annotation(Line(points = {{74,-72},{58,-72},{58,-78}},color = {0,127,255}));
    connect(heaPum.port_a1,res.port_b) annotation(Line(points = {{38,-66},{26,-66},{26,-40},{42,-40},{42,38},{36,38}},color = {0,127,255}));
    connect(u2,ideEco.y) annotation(Line(points = {{-128,2},{-106,2},{-106,63.961473215348846},{-60.490429273599894,63.961473215348846},{-60.490429273599894,51.961473215348846}},color = {0,0,127}));
    connect(weaBus,out.weaBus) annotation(Line(points = {{-120,40},{-110,40},{-110,38.2},{-102,38.2}},color = {255,204,51}));
    connect(heaPum.port_b1,port_a) annotation(Line(points = {{58,-66},{62,-66},{62,0},{112,0}},color = {0,127,255}));
    connect(port_b,out.ports[2]) annotation(Line(points = {{112,-28},{-78,-28},{-78,38},{-82,38}},color = {0,127,255}));
    annotation(Icon(coordinateSystem(preserveAspectRatio = false,extent = {{-100.0,-100.0},{100.0,100.0}}),graphics={  Rectangle(lineColor={0,0,0},fillColor={230,230,230},
            fillPattern =                                                                                                                                                              FillPattern.Solid,extent={{-100.0,-100.0},{100.0,100.0}}),Text(lineColor={0,0,255},extent={{-150,150},{150,110}},textString
            =                                                                                                                                                                                                        "%name")}));
end HPEco;
