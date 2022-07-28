within Buildings.Extra.PackageTerminalHeatPump.FinalizedModel;
model ConCoolingSetting
    .Buildings.Controls.OBC.CDL.Interfaces.RealInput TSetRooCoo annotation(Placement(transformation(extent = {{-139.77624945859282,39.95649851387564},{-99.77624945859284,79.95649851387563}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Controls.OBC.CDL.Interfaces.RealInput TRoo annotation(Placement(transformation(extent = {{-139.36605682346072,-85.15225520143534},{-99.36605682346072,-45.15225520143534}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Controls.Continuous.LimPID ConCooSupT annotation(Placement(transformation(extent = {{-62.91484993204957,-9.521433580288598},{-42.91484993204957,10.478566419711402}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Controls.OBC.CDL.Continuous.Line CooSupT annotation(Placement(transformation(extent = {{64.6550595940545,-9.521433580288624},{84.6550595940545,10.478566419711376}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Controls.OBC.CDL.Continuous.Sources.Constant ConMax(k = 0) annotation(Placement(transformation(extent = {{-34.61155810793004,39.29149000043929},{-14.611558107930037,59.29149000043929}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Controls.OBC.CDL.Continuous.Sources.Constant TSupMax(k = TCooMax) annotation(Placement(transformation(extent = {{-3.0267252027531484,13.449353987112755},{16.97327479724685,33.44935398711276}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Controls.OBC.CDL.Continuous.Sources.Constant ConMin(k=0.5) annotation(Placement(transformation(extent = {{-35.842136013326524,-30.441257972029142},{-15.842136013326524,-10.441257972029142}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Controls.OBC.CDL.Continuous.Sources.Constant TSupMin(k = TCooMin) annotation(Placement(transformation(extent = {{0.6650085134363231,-54.23243080969484},{20.665008513436323,-34.23243080969484}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Controls.OBC.CDL.Interfaces.RealOutput TCooSupSet annotation(Placement(transformation(extent = {{98.95586418832849,-19.11124094515644},{138.95586418832846,20.88875905484356}},origin = {0.0,0.0},rotation = 0.0)));
    parameter .Modelica.SIunits.Temp_K TCooMax = 293.15 "Max cooling supply load temperature";
    parameter .Modelica.SIunits.Temp_K TCooMin = 273.15 "Max cooling supply load temperature";
equation
    connect(TSetRooCoo,ConCooSupT.u_s) annotation(Line(points = {{-119.77624945859283,59.95649851387563},{-92.55064601288728,59.95649851387563},{-92.55064601288728,0.47856641971140235},{-64.91484993204958,0.47856641971140235}},color = {0,0,127}));
    connect(TRoo,ConCooSupT.u_m) annotation(Line(points = {{-119.36605682346072,-65.15225520143534},{-94.34430608039851,-65.15225520143534},{-94.34430608039851,-35.26039962737072},{-52.91484993204957,-35.26039962737072},{-52.91484993204957,-11.521433580288598}},color = {0,0,127}));
    connect(ConCooSupT.y,CooSupT.u) annotation(Line(points = {{-41.91484993204957,0.47856641971140235},{10.165008513436383,0.47856641971140235},{10.165008513436383,0.4785664197113757},{62.65505959405451,0.4785664197113757}},color = {0,0,127}));
    connect(ConMax.y,CooSupT.x1) annotation(Line(points = {{-12.611558107930037,49.29149000043929},{50.349280540089495,49.29149000043929},{50.349280540089495,8.478566419711376},{62.65505959405451,8.478566419711376}},color = {0,0,127}));
    connect(TSupMax.y,CooSupT.f1) annotation(Line(points = {{18.97327479724685,23.449353987112758},{40.81416719565068,23.449353987112758},{40.81416719565068,4.478566419711376},{62.65505959405451,4.478566419711376}},color = {0,0,127}));
    connect(ConMin.y,CooSupT.x2) annotation(Line(points = {{-13.842136013326524,-20.441257972029142},{24.40646179036399,-20.441257972029142},{24.40646179036399,-3.5214335802886243},{62.65505959405451,-3.5214335802886243}},color = {0,0,127}));
    connect(TSupMin.y,CooSupT.f2) annotation(Line(points = {{22.665008513436323,-44.23243080969484},{47.88812472929651,-44.23243080969484},{47.88812472929651,-7.521433580288624},{62.65505959405451,-7.521433580288624}},color = {0,0,127}));
    connect(CooSupT.y,TCooSupSet) annotation(Line(points = {{86.6550595940545,0.4785664197113757},{95.42199445881246,0.4785664197113757},{95.42199445881246,0.8887590548435611},{118.95586418832848,0.8887590548435611}},color = {0,0,127}));
    annotation(Icon(coordinateSystem(preserveAspectRatio = false,extent = {{-100.0,-100.0},{100.0,100.0}}),graphics={  Rectangle(fillColor={255,255,255},
            fillPattern =                                                                                                                                            FillPattern.Solid,extent={{-100.0,-100.0},{100.0,100.0}}),Text(lineColor={0,0,255},extent={{-150,150},{150,110}},textString
            =                                                                                                                                                                                                        "%name")}));
end ConCoolingSetting;
