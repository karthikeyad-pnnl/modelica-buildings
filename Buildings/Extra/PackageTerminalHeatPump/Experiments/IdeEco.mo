within Buildings.Extra.PackageTerminalHeatPump.Experiments;
model IdeEco
    .Buildings.Controls.OBC.CDL.Interfaces.RealInput y annotation(Placement(transformation(extent = {{-139.61473215348843,-15.095707264001039},{-99.61473215348842,24.90429273599896}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Controls.OBC.CDL.Continuous.Sources.Constant one(k = 1) annotation(Placement(transformation(extent = {{-76.21637435824753,19.853898510393773},{-56.216374358247535,39.853898510393776}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Controls.OBC.CDL.Continuous.Product pro annotation(Placement(transformation(extent = {{-7.8292718154018885,13.695087336510277},{12.170728184598111,33.69508733651028}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Fluid.Sensors.MassFlowRate senMasFlo(redeclare replaceable package Medium = MediumA) annotation(Placement(transformation(extent = {{-10.0,10.0},{10.0,-10.0}},origin = {19.295728789983762,-14.352190485818053},rotation = -90.0)));
    .Modelica.Fluid.Interfaces.FluidPort_a port_3(redeclare replaceable package Medium = MediumA) annotation(Placement(transformation(extent = {{90.69328064420317,-4.898340802177252},{110.6932806442032,15.101659197822748}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Fluid.Movers.BaseClasses.IdealSource preMasFlo(redeclare replaceable package Medium = MediumA,control_dp(fixed = true)) annotation(Placement(transformation(extent = {{60.0,-4.0},{40.0,16.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Controls.OBC.CDL.Continuous.Feedback feedback annotation(Placement(transformation(extent = {{-42.861015703378364,19.73383283960159},{-22.861015703378364,39.73383283960159}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Fluid.Interfaces.FluidPort_b port_2(redeclare replaceable package Medium = MediumA) annotation(Placement(transformation(extent = {{39.999999999999986,-110.0},{60.000000000000014,-90.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Fluid.Interfaces.FluidPort_a port_1(redeclare replaceable package Medium = MediumA) annotation(Placement(transformation(extent = {{36.0,90.0},{56.0,110.0}},origin = {0.0,0.0},rotation = 0.0)));
equation
    connect(feedback.y,pro.u1) annotation(Line(points = {{-20.861015703378364,29.73383283960159},{-15.345143759390126,29.73383283960159},{-15.345143759390126,29.695087336510277},{-9.829271815401889,29.695087336510277}},color = {0,0,127}));
    connect(senMasFlo.m_flow,pro.u2) annotation(Line(points = {{8.295728789983762,-14.352190485818054},{-15.829271815401889,-14.352190485818054},{-15.829271815401889,17.695087336510277},{-9.829271815401889,17.695087336510277}},color = {0,0,127}));
    connect(senMasFlo.port_a,port_1) annotation(Line(points = {{19.29572878998376,-4.352190485818053},{19.29572878998376,47.82390475709097},{46,47.82390475709097},{46,100}},color = {0,127,255}));
    connect(senMasFlo.port_b,port_2) annotation(Line(points = {{19.295728789983766,-24.352190485818053},{19.295728789983766,-62.17609524290903},{50,-62.17609524290903},{50,-100}},color = {0,127,255}));
    connect(preMasFlo.port_b,senMasFlo.port_a) annotation(Line(points = {{40,6},{19.29572878998376,6},{19.29572878998376,-4.352190485818053}},color = {0,127,255}));
    connect(pro.y,preMasFlo.dp_in) annotation(Line(points = {{14.170728184598111,23.695087336510277},{44,23.695087336510277},{44,14}},color = {0,0,127}));
    connect(preMasFlo.port_a,port_3) annotation(Line(points = {{60,6},{80.28729788075316,6},{80.28729788075316,5.101659197822748},{100.69328064420318,5.101659197822748}},color = {0,127,255}));
    connect(y,feedback.u2) annotation(Line(points = {{-119.61473215348843,4.904292735998961},{-32.861015703378364,4.904292735998961},{-32.861015703378364,17.73383283960159}},color = {0,0,127}));
    connect(one.y,feedback.u1) annotation(Line(points = {{-54.216374358247535,29.853898510393776},{-49.538695030812946,29.853898510393776},{-49.538695030812946,29.73383283960159},{-44.861015703378364,29.73383283960159}},color = {0,0,127}));
    annotation(Icon(coordinateSystem(preserveAspectRatio = false,extent = {{-100.0,-100.0},{100.0,100.0}}),graphics = {Rectangle(fillColor={255,255,255},fillPattern=FillPattern.Solid,extent={{-100.0,-100.0},{100.0,100.0}}),Text(lineColor={0,0,255},extent={{-150,150},{150,110}},textString="%name")}));
end IdeEco;
