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
    annotation (Placement(transformation(extent={{65.94157513480269,30.0},{85.94157513480269,50.0}},rotation = 0.0,origin={-66,0})));
    .Buildings.Controls.OBC.CDL.Continuous.Line LinHeaSupT annotation(Placement(transformation(extent={{44.9658,
            -18.1355},{64.9659,1.86452}},                                                                                                                                               origin={-4.96581,
            -1.86452},                                                                                                                                                                                     rotation = 0.0)));
    .Modelica.Blocks.Interfaces.RealOutput HysInp(unit = "1") "Hysteresis heating input for fan" annotation(Placement(transformation(extent={{100.054,
            -49.1262},{120.054,-29.1262}},                                                                                                                                                                                        rotation = 0.0,origin={
            -0.0544341,-0.873838}), iconTransformation(extent={{100.053,
            -49.1262},{120.053,-29.1262}}, origin={0,0})));
    .Buildings.Controls.OBC.CDL.Continuous.Sources.Constant MaxHeaSupT(k = MaxSupT) "Maximum heating supply load temperature" annotation(Placement(transformation(extent = {{-48.44122211796796,-54.58917303932067},{-28.44122211796796,-34.58917303932067}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Controls.OBC.CDL.Continuous.Sources.Constant ConMin(k = 0) "Minimum PI input" annotation(Placement(transformation(extent = {{-49.67180002336447,13.912997027751256},{-29.67180002336447,33.91299702775126}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Controls.OBC.CDL.Continuous.Sources.Constant ConMax(k = 1) "Maximum PI input" annotation(Placement(transformation(extent={{
            -22.1354,-36.8976},{-2.13545,-16.8976}},                                                                                                                                                                         origin={2.13545,
            -3.10237},                                                                                                                                                                                                        rotation = 0.0)));
    .Buildings.Controls.OBC.CDL.Continuous.Sources.Constant MinHeaSupT(k = MinSupT) "Minimum heating supply load temperature" annotation(Placement(transformation(extent = {{-22.492185293628815,-1.9776149313906473},{-2.4921852936288147,18.022385068609353}},origin={2,0},      rotation = 0.0)));
    .Buildings.Controls.Continuous.LimPID ConHeaSupT(Td = TdHea,Ti = TiHea,k = kHea,controllerType = controllerTypeHea) "Controller for heating supply load temperature" annotation(Placement(transformation(extent = {{-78.03852702643347,-17.95152405418466},{-58.03852702643347,2.0484759458153388}},rotation = 0.0,origin={-2,-2})));
    parameter .Modelica.SIunits.Temp_K MinSupT = 297.05 "Minimum heating supply load temperature";
    parameter .Modelica.SIunits.Temp_K MaxSupT = 318.15 "Maximum heating supply load temperature";
    parameter .Buildings.Controls.OBC.CDL.Types.SimpleController controllerTypeHea = .Buildings.Controls.OBC.CDL.Types.SimpleController.PI "Type of controller" annotation(Dialog(group = "Heating coil signal"));

    Controls.OBC.CDL.Continuous.Line            LinHeaSupT1
                                                           annotation(Placement(transformation(extent={{44.9658,
            -18.1355},{64.9659,1.86452}},                                                                                                                                               origin={-4.96581,
            48.1355},                                                                                                                                                                                      rotation = 0.0)));
    Controls.OBC.CDL.Continuous.Sources.Constant            ConMin1(k=0.5)
                                                                          "Minimum PI input" annotation(Placement(transformation(extent = {{-49.67180002336447,13.912997027751256},{-29.67180002336447,33.91299702775126}},origin={30,56},    rotation = 0.0)));
    Controls.OBC.CDL.Continuous.Sources.Constant            ConMin2(k=0.1)
                                                                          "Minimum PI input" annotation(Placement(transformation(extent = {{-49.67180002336447,13.912997027751256},{-29.67180002336447,33.91299702775126}},origin={-10,36},   rotation = 0.0)));
equation
  connect(conFan.u_s, TSetRooCoo) annotation (Line(points={{-2.05842,40},{-96,
          40},{-96,0},{-110,0}},                 color={0,0,127}));
  connect(TRoo, conFan.u_m) annotation (Line(points={{-110,-60},{9.94158,-60},{
          9.94158,28}},                                                                                                                 color={0,0,127}));
    connect(TSetRooHea,ConHeaSupT.u_s) annotation(Line(points={{-110,60},{
          -92.1479,60},{-92.1479,-9.95152},{-82.0385,-9.95152}},                                                                                                                    color = {0,0,127}));
    connect(TRoo,ConHeaSupT.u_m) annotation(Line(points={{-110,-60},{-70.0385,
          -60},{-70.0385,-21.9515}},                                                                                                    color = {0,0,127}));
    connect(ConHeaSupT.y,HysInp) annotation(Line(points={{-59.0385,-9.95152},{
          -52,-9.95152},{-52,-80},{76.0075,-80},{76.0075,-40},{110,-40}},                                                                                                                                                                       color = {0,0,127}));
    connect(ConMin.y,LinHeaSupT.x1) annotation(Line(points={{-27.6718,23.913},{
          28.1989,23.913},{28.1989,-2},{38,-2}},                                                                                                                                                                                  color = {0,0,127}));
    connect(MinHeaSupT.y,LinHeaSupT.f1) annotation(Line(points={{1.50781,
          8.02239},{21.2368,8.02239},{21.2368,-6.00001},{38,-6.00001}},                                                                                                                                                          color = {0,0,127}));
    connect(MaxHeaSupT.y,LinHeaSupT.f2) annotation(Line(points={{-26.4412,
          -44.5892},{27.7887,-44.5892},{27.7887,-18},{38,-18}},                                                                                                                                                                     color = {0,0,127}));
    connect(ConHeaSupT.y,LinHeaSupT.u) annotation(Line(points={{-59.0385,
          -9.95152},{-7.03636,-9.95152},{-7.03636,-10},{38,-10}},                                                                                                                                                                color = {0,0,127}));
    connect(LinHeaSupT.y,THeaSupSet) annotation(Line(points={{62.0001,-10},{
          87.2523,-10},{87.2523,-8.00497},{109.59,-8.00497}},                                                                                                                                                              color = {0,0,127}));

  connect(conFan.y, LinHeaSupT1.u) annotation (Line(points={{20.9416,40},{30,40},
          {30,40},{38,40}}, color={0,0,127}));
  connect(LinHeaSupT1.y, yFan) annotation (Line(points={{62.0001,40},{90,40},{
          90,40},{110,40}}, color={0,0,127}));
  connect(ConMin1.y, LinHeaSupT1.x1) annotation (Line(points={{2.3282,79.913},{
          30,79.913},{30,48},{38,48}}, color={0,0,127}));
  connect(ConMin2.y, LinHeaSupT1.f1) annotation (Line(points={{-37.6718,59.913},
          {26,59.913},{26,44},{38,44}}, color={0,0,127}));
  connect(ConMax.y, LinHeaSupT.x2) annotation (Line(points={{2,-30},{20,-30},{
          20,-14},{38,-14}}, color={0,0,127}));
  connect(ConMax.y, LinHeaSupT1.x2) annotation (Line(points={{2,-30},{20,-30},{
          20,-14},{32,-14},{32,36},{38,36}}, color={0,0,127}));
  connect(ConMax.y, LinHeaSupT1.f2) annotation (Line(points={{2,-30},{20,-30},{
          20,-14},{32,-14},{32,32},{38,32}}, color={0,0,127}));
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
