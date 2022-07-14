within Buildings.Extra.PackageTerminalHeatPump.FinalizedModel;

model ControllerHeatingFan "Controller for heating coil and fan signal"
  extends .Modelica.Blocks.Icons.Block;
  parameter Real kHea(final unit="1/K")=0.1
    "Gain for heating coil control signal"
    annotation(Dialog(group="Heating coil signal"));
  parameter Real TiHea(
    final unit="s",
    final quantity="Time")=900
    "Time constant of integrator block for heating coil control signal"
    annotation(Dialog(group="Heating coil signal",
    enable=controllerTypeHea == .Buildings.Controls.OBC.CDL.Types.SimpleController.PI
        or controllerTypeHea == .Buildings.Controls.OBC.CDL.Types.SimpleController.PID));
  parameter Real TdHea(
    final unit="s",
    final quantity="Time")=0.1
    "Time constant of derivative block for heating coil control signal"
    annotation (Dialog(group="Heating coil signal",
      enable=controllerTypeHea == .Buildings.Controls.OBC.CDL.Types.SimpleController.PD
          or controllerTypeHea == .Buildings.Controls.OBC.CDL.Types.SimpleController.PID));
  parameter .Buildings.Controls.OBC.CDL.Types.SimpleController controllerTypeFan=
    .Buildings.Controls.OBC.CDL.Types.SimpleController.PI
    "Type of controller"
    annotation(Dialog(group="Fan signal"));
  parameter Real kFan(final unit="1/K")=0.1
    "Gain for fan signal"
    annotation(Dialog(group="Fan signal"));
  parameter Real TiFan(
    final unit="s",
    final quantity="Time")=900
    "Time constant of integrator block for fan signal"
    annotation(Dialog(group="Fan signal",
    enable=controllerTypeFan == .Buildings.Controls.OBC.CDL.Types.SimpleController.PI
        or controllerTypeFan == .Buildings.Controls.OBC.CDL.Types.SimpleController.PID));
  parameter Real TdFan(
    final unit="s",
    final quantity="Time")=0.1
    "Time constant of derivative block for fan signal"
    annotation (Dialog(group="Fan signal",
      enable=controllerTypeFan == .Buildings.Controls.OBC.CDL.Types.SimpleController.PD
          or controllerTypeFan == .Buildings.Controls.OBC.CDL.Types.SimpleController.PID));
  parameter Real minAirFlo(
    final min=0,
    final max=1,
    final unit="1")
    "Minimum airflow fraction of system";

  .Modelica.Blocks.Interfaces.RealInput TSetRooCoo(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "Zone cooling setpoint"
    annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));
  .Modelica.Blocks.Interfaces.RealInput TRoo(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "Zone temperature measurement"
    annotation (Placement(transformation(extent={{-120.0,-70.0},{-100.0,-50.0}},rotation = 0.0,origin = {0.0,0.0})));
  .Modelica.Blocks.Interfaces.RealInput TSetRooHea(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "Zone heating setpoint"
    annotation (Placement(transformation(extent={{-120,50},{-100,70}})));
  .Modelica.Blocks.Interfaces.RealOutput yFan(
    final unit="1")
    "Control signal for fan"
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  .Modelica.Blocks.Interfaces.RealOutput THeaSupSet(
    final unit="1")
    "Heating supply load temperature"
    annotation (Placement(transformation(extent={{99.58980736486785,-18.00497445969097},{119.58980736486785,1.9950255403090278}},rotation = 0.0,origin = {0.0,0.0})));
  .Buildings.Controls.Continuous.LimPID conFan(
    final controllerType=controllerTypeFan,
    final k=kFan,
    final Ti=TiFan,
    final Td=TdFan,
    final yMax=1,
    final yMin=minAirFlo,
    final reverseActing=false)
    "Controller for fan"
    annotation (Placement(transformation(extent={{65.94157513480269,30.0},{85.94157513480269,50.0}},rotation = 0.0,origin = {0.0,0.0})));
    .Buildings.Controls.OBC.CDL.Continuous.Line LinHeaSupT annotation(Placement(transformation(extent = {{44.96581310771039,-18.135478918064102},{64.96581310771039,1.864521081935898}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.RealOutput HysInp(unit = "1") "Hysteresis heating input for fan" annotation(Placement(transformation(extent = {{100.05345040550635,-49.126164324229336},{120.05345040550635,-29.126164324229336}},rotation = 0.0,origin = {0.0,0.0})));
    .Buildings.Controls.OBC.CDL.Continuous.Sources.Constant MaxHeaSupT(k = MaxSupT) "Maximum heating supply load temperature" annotation(Placement(transformation(extent = {{-48.44122211796796,-54.58917303932067},{-28.44122211796796,-34.58917303932067}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Controls.OBC.CDL.Continuous.Sources.Constant ConMin(k = 0) "Minimum PI input" annotation(Placement(transformation(extent = {{-49.67180002336447,13.912997027751256},{-29.67180002336447,33.91299702775126}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Controls.OBC.CDL.Continuous.Sources.Constant ConMax(k = 1) "Maximum PI input" annotation(Placement(transformation(extent = {{-22.135443064002935,-36.89743932313118},{-2.135443064002935,-16.89743932313118}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Controls.OBC.CDL.Continuous.Sources.Constant MinHeaSupT(k = MinSupT) "Minimum heating supply load temperature" annotation(Placement(transformation(extent = {{-22.492185293628815,-1.9776149313906473},{-2.4921852936288147,18.022385068609353}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Controls.Continuous.LimPID ConHeaSupT(Td = TdHea,Ti = TiHea,k = kHea,controllerType = controllerTypeHea) "Controller for heating supply load temperature" annotation(Placement(transformation(extent = {{-78.03852702643347,-17.95152405418466},{-58.03852702643347,2.0484759458153388}},rotation = 0.0,origin = {0.0,0.0})));
    parameter .Modelica.SIunits.Temp_K MinSupT = 297.05 "Minimum heating supply load temperature";
    parameter .Modelica.SIunits.Temp_K MaxSupT = 318.15 "Maximum heating supply load temperature";
    parameter .Buildings.Controls.OBC.CDL.Types.SimpleController controllerTypeHea = .Buildings.Controls.OBC.CDL.Types.SimpleController.PI "Type of controller" annotation(Dialog(group = "Heating coil signal"));

equation
  connect(conFan.u_s, TSetRooCoo) annotation (Line(points={{63.94157513480269,40},{-92.30577905396501,40},{-92.30577905396501,0},{-110,0}},
                                                 color={0,0,127}));
  connect(TRoo, conFan.u_m) annotation (Line(points={{-110,-60},{75.94157513480269,-60},{75.94157513480269,28}},                        color={0,0,127}));
  connect(conFan.y, yFan)   annotation (Line(points={{86.94157513480269,40},{110,40}},
                                                   color={0,0,127}));
    connect(TSetRooHea,ConHeaSupT.u_s) annotation(Line(points = {{-110,60},{-92.14791506729156,60},{-92.14791506729156,-7.951524054184661},{-80.03852702643347,-7.951524054184661}},color = {0,0,127}));
    connect(TRoo,ConHeaSupT.u_m) annotation(Line(points = {{-110,-60},{-68.03852702643347,-60},{-68.03852702643347,-19.95152405418466}},color = {0,0,127}));
    connect(ConHeaSupT.y,HysInp) annotation(Line(points = {{-57.03852702643347,-7.9515240541846595},{-53.48010216123616,-7.9515240541846595},{-53.48010216123616,-60.04598871596986},{76.00746168953641,-60.04598871596986},{76.00746168953641,-39.126164324229336},{110.05345040550635,-39.126164324229336}},color = {0,0,127}));
    connect(ConMin.y,LinHeaSupT.x1) annotation(Line(points = {{-27.67180002336447,23.912997027751256},{28.198878242952397,23.912997027751256},{28.198878242952397,-0.13547891806410206},{42.96581310771039,-0.13547891806410206}},color = {0,0,127}));
    connect(MinHeaSupT.y,LinHeaSupT.f1) annotation(Line(points = {{-0.4921852936288147,8.022385068609353},{21.236813907040787,8.022385068609353},{21.236813907040787,-4.135478918064102},{42.96581310771039,-4.135478918064102}},color = {0,0,127}));
    connect(ConMax.y,LinHeaSupT.x2) annotation(Line(points = {{-0.13544306400293493,-26.89743932313118},{21.415185021853727,-26.89743932313118},{21.415185021853727,-12.135478918064102},{42.96581310771039,-12.135478918064102}},color = {0,0,127}));
    connect(MaxHeaSupT.y,LinHeaSupT.f2) annotation(Line(points = {{-26.44122211796796,-44.58917303932067},{27.788685607820195,-44.58917303932067},{27.788685607820195,-16.135478918064102},{42.96581310771039,-16.135478918064102}},color = {0,0,127}));
    connect(ConHeaSupT.y,LinHeaSupT.u) annotation(Line(points = {{-57.03852702643347,-7.951524054184661},{-7.036356959361541,-7.951524054184661},{-7.036356959361541,-8.135478918064102},{42.96581310771039,-8.135478918064102}},color = {0,0,127}));
    connect(LinHeaSupT.y,THeaSupSet) annotation(Line(points = {{66.96581310771039,-8.135478918064102},{87.2523286484587,-8.135478918064102},{87.2523286484587,-8.004974459690972},{109.58980736486785,-8.004974459690972}},color = {0,0,127}));

  annotation (
  defaultComponentName="conHeaFan",
  Documentation(info="<html>
<p>
Controller for heating coil and fan speed.
</p>
</html>", revisions="<html>
<ul>
<li>
July 21, 2020, by Kun Zhang:<br/>
Exposed PID control parameters to allow users to tune for their specific systems.
</li>
<li>
June 21, 2017, by Michael Wetter:<br/>
Refactored implementation.
</li>
<li>
June 1, 2017, by David Blum:<br/>
First implementation.
</li>
</ul>
</html>"));
end ControllerHeatingFan;
