within Buildings.Controls.OBC.FDE.DOAS.Validation;
model Controller "DOAS controller"
  Buildings.Controls.OBC.FDE.DOAS.Controller DOAScon1 "DOAS Controller"
    annotation (Placement(transformation(extent={{38,-12},{58,52}})));
  parameter Real erwDPadj(
    final unit = "K",
    final quantity = "TemperatureDifference") = 5
    "Value subtracted from ERW supply air dewpoint.";
  parameter CDL.Types.SimpleController controllerTypeDeh=Buildings.Controls.OBC.CDL.Types.SimpleController.PI
    "PID controller for cooling air in dehumidification mode";
  parameter Real kDeh(
    final unit="1") = 1
    "Gain of conPIDDeh controller";
  parameter Real TiDeh(
    final unit="s") = 60
    "Time constant of integrator block for conPIDDeh controller";
  parameter Real TdDeh(
    final unit="s") = 0.1
    "Time constant of derivative block for conPIDDeh controller";
  parameter CDL.Types.SimpleController controllerTypeRegOpe=Buildings.Controls.OBC.CDL.Types.SimpleController.PI
    "PID controller for regular cooling coil operation mode";
  parameter Real kRegOpe(
    final unit="1") = 1
    "Gain of conPIDRegOpe controller";
  parameter Real TiRegOpe(
    final unit="s")=60
    "Time constant of integrator block for conPIDRegOpe controller";
  parameter Real TdRegOpe(
    final unit="s")=0.1
    "Time constant of derivative block for conPIDRegOpe controller";
  parameter Real dehumSet(
    final min=0,
    final max=100)=60
    "Dehumidification set point.";
  parameter Real timThrDehDis(
    final unit="s",
    final quantity="Time")=600
    "Continuous time period for which measured relative humidity needs to fall below relative humidity threshold before dehumidification mode is disabled";
  parameter Real timDelDehEna(
    final unit="s",
    final quantity="Time")=120
    "Continuous time period for which supply fan needs to be on before enabling dehumidifaction mode";
  parameter Real timThrDehEna(
    final unit="s",
    final quantity="Time")=5
    "Continuous time period for which relative humidity rises above set point before dehumidifcation mode is enabled";
  parameter Real dTEcoThr(
    final unit = "K",
    final displayUnit = "degC",
    final quantity = "ThermodynamicTemperature") = 2
    "Threshold temperature difference between return air and outdoor air temperature above which economizer mode is enabled";
  parameter Real dTThrEneRec(
    final unit = "K",
    final displayUnit = "degC",
    final quantity = "ThermodynamicTemperature") = 7
    "Absolute temperature difference threshold between outdoor air and return air temperature above which energy recovery is enabled";
  parameter Real dThys(
    final unit = "K",
    final displayUnit = "degC",
    final quantity = "ThermodynamicTemperature") = 0.5
    "Delay time period after temperature difference threshold is crossed for enabling energy recovery mode";
  parameter Real timDelEneRec(
    final unit = "s",
    final quantity = "Time") = 300
    "Minimum delay after OAT/RAT delta falls below set point.";
  parameter CDL.Types.SimpleController controllerTypeEneWheHea=Buildings.Controls.OBC.CDL.Types.SimpleController.PI
    "PI controller for heating loop";
  parameter Real kEneWheHea(
    final unit = "1") = 0.5
    "PID heating loop gain value.";
  parameter Real TiEneWheHea(
    final unit = "s") = 60
    "PID  heating loop time constant of integrator.";
  parameter Real TdEneWheHea(
    final unit = "s") = 0.1
    "PID heatig loop time constant of derivative block";
  parameter Real kEneWheCoo(
    final unit = "1") = 0.5
    "PID cooling loop gain value.";
  parameter Real TiEneWheCoo(
    final unit = "s") = 60 "PID cooling loop time constant of integrator.";
  parameter CDL.Types.SimpleController controllerTypeEneWheCoo=Buildings.Controls.OBC.CDL.Types.SimpleController.PI
    "PI controller for cooling loop";
  parameter Real TdEneWheCoo(
    final unit = "s") = 0.1
    "PID cooling loop time constant of derivative block";
  parameter Real dPSetBui(
    final unit = "Pa",
    final quantity = "PressureDifference") = 15
    "Building static pressure difference set point";
  parameter Real kExhFan(
    final unit = "1") = 0.5
    "PID heating loop gain value.";
  parameter Real TiExhFan(
    final unit = "s") = 60
    "PID loop time constant of integrator.";
  parameter Real TdExhFan(
    final unit= "s") = 0.1
    "Time constant of derivative block";
  parameter CDL.Types.SimpleController controllerTypeExhFan=Buildings.Controls.OBC.CDL.Types.SimpleController.PI
    "Type of controller";
  parameter CDL.Types.SimpleController controllerTypeCoiHea=Buildings.Controls.OBC.CDL.Types.SimpleController.PI
   "Type of controller";
  parameter Real kCoiHea(
   final unit= "1") = 0.5
  "Heating coil SAT PI gain value k.";
  parameter Real TiCoiHea(
   final unit= "s") = 60
  "Heating coil SAT PI time constant value Ti.";
  parameter Real TdCoiHea(
    final unit= "s") = 0.1
    "Time constant of derivative block";
  parameter Boolean is_vav = true
    "True: System has zone terminals with variable damper position. 
    False: System has zone terminals with constant damper position.";
  parameter Real yMinDamSet(
    min = 0,
    final unit = "Pa",
    final quantity = "PressureDifference") = 125
    "Minimum down duct static pressure reset value" annotation(Dialog(group = "DDSP range"));
  parameter Real yMaxDamSet(
    min = 0,
    final unit = "Pa",
    final quantity = "PressureDifference") = 500
    "Maximum down duct static pressure reset value" annotation(Dialog(group = "DDSP range"));
  parameter Real damSet(
    min = 0,
    max = 1,
    final unit = "1") = 0.9
    "DDSP terminal damper percent open set point";
  parameter Real kDam(
    final unit= "1") = 0.5
    "Damper position setpoint PI gain value k.";
  parameter Real TiDam(
    final unit= "s") = 60
    "Damper position setpoint PI time constant value Ti.";
  parameter Real TdDam(
   final unit= "s") = 0.1 "Time constant of derivative block for conPIDDam";
  parameter CDL.Types.SimpleController controllerTypeDam=Buildings.Controls.OBC.CDL.Types.SimpleController.PI
    "Type of controller";
  parameter Real dPDucSetCV(
    min = 0,
    final unit = "Pa",
    final quantity = "PressureDifference") = 250 "Constant volume down duct static pressure set point";
  parameter Real fanSpeMin(
    final unit= "m/s") = 0.0000001
    "Minimum Fan Speed";
  parameter Real kFanSpe(
    final unit= "1") = 0.5 "
    Fan speed set point SAT PI gain value k.";
  parameter Real TdFanSpe(
    final unit= "s") = 60
    "Time constant of derivative block for conPIDFanSpe";
  parameter Real TiFanSpe(
    final unit= "s") = 0.000025
    "Fan speed set point SAT PI time constant value Ti.";
  parameter CDL.Types.SimpleController controllerTypeFanSpe=Buildings.Controls.OBC.CDL.Types.SimpleController.PI
    "Type of controller";
  parameter Real TSupLowSet(
    final unit="K",
    final displayUnit="degC",
    final quantity="ThermodynamicTemperature")=273.15+20
    "Minimum primary supply air temperature reset value";
  parameter Real TSupHigSet(
    final unit="K",
    final displayUnit="degC",
    final quantity="ThermodynamicTemperature")=273.15+24
    "Maximum primary supply air temperature reset value";
  parameter Real THigZon(
    final unit="K",
    final displayUnit="degC",
    final quantity="ThermodynamicTemperature")=273.15+25
    "Maximum zone temperature reset value";
  parameter Real TLowZon(
    final unit="K",
    final displayUnit="degC",
    final quantity="ThermodynamicTemperature")=273.15+21
    "Minimum zone temperature reset value";
  parameter Real TSupCooOff(
    final unit="K",
   final displayUnit="degC",
   final quantity="ThermodynamicTemperature")=2
   "Supply air temperature cooling set point offset.";
  parameter Real TSupHeaOff(
   final unit="K",
   final displayUnit="degC",
   final quantity="ThermodynamicTemperature")=2
   "Supply air temperature heating set point offset.";
  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse OccGen(
    width = 0.8,
    period = 8000,
    shift=1000)
    "Simulates occupancy mode schedule."
  annotation(Placement(transformation(extent={{-88,76},{-68,96}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Sin mostOpenDamGen(
    amplitude=0.1,
    freqHz = 1/5670,
    offset=0.9)
  "Simulates changing terminal unit most open damper position."
  annotation(Placement(transformation(extent={{-50,60},{-30,80}})));
  Buildings.Controls.OBC.CDL.Logical.TrueDelay truDel(
    delayTime = 10,
    delayOnInit = true)
    "Simulates delay from initial fan start command to fan status proof."
  annotation(Placement(visible = true, transformation(origin={44,8},    extent = {{-94, 14}, {-74, 34}}, rotation = 0)));
  Buildings.Controls.OBC.CDL.Reals.Sources.Sin sensorDDSP(
    amplitude = 300,
    freqHz = 1/10800,
    phase=3.9269908169872,
    offset = 400) "Down duct static pressure"
  annotation(Placement(visible = true, transformation(origin = {-6, 0}, extent = {{-92, -18}, {-72, 2}}, rotation = 0)));
  Buildings.Controls.OBC.CDL.Reals.Switch swi
    "Logic switch selects DDSP generator when fan is proven otherwise selects 0."
  annotation(Placement(transformation(extent={{-52,-12},{-32,8}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con0(
    final k = 0) "Real constant 0"
  annotation(Placement(visible = true, transformation(origin={-2,-14},   extent = {{-92, -48}, {-72, -28}}, rotation = 0)));
  Buildings.Controls.OBC.CDL.Reals.Sources.Sin ralHumGen(
    amplitude = 10,
    freqHz = 1/10800,
    phase=1.5707963267949,
    offset = 60,
    startTime = 0)
  "Return humidity sensor simulator."
  annotation(Placement(transformation(extent={{-14,52},{6,72}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Sin erwHumGen(
    amplitude = 5,
    freqHz = 1/7200,
    phase=1.5707963267949,
    offset = 60,
    startTime = 0)
    "ERW humidity sensor simulator."
  annotation(Placement(visible = true, transformation(origin={-52,0},    extent = {{32, -30}, {52, -10}}, rotation = 0)));
  Buildings.Controls.OBC.CDL.Logical.TrueDelay truDel1(
    final delayTime = 10,
    final delayOnInit = true)
    "Simulates delay from initial fan start command to fan status proof."
  annotation(Placement(transformation(extent = {{108, -66}, {128, -46}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Sin bldgSP(
    amplitude = 3,
    freqHz = 1/10800,
    offset = 15) "Building static pressure"
  annotation(Placement(transformation(extent={{-58,-74},{-38,-54}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Sin ccTGen(
    amplitude = 7,
    freqHz = 1/21600,
    phase = 1.0471975511966,
    offset = 283,
    startTime = 0)
    "Cooling coil discharge temperature simulator."
  annotation(Placement(transformation(extent = {{-24, -92}, {-4, -72}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Ramp oaTgen(
    height = 26,
    duration = 8500,
    offset = 275,
    startTime = 500)
    "Outside air temperature generator."
  annotation(Placement(transformation(extent={{24,-48},{44,-28}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Sin raTGen(
    amplitude = 5,
    freqHz = 1/20600,
    phase = 0.34906585039887,
    offset = 294, startTime = 0)
    "Return air temperature simulator."
  annotation(Placement(visible = true, transformation(origin={80,-66},   extent = {{-52, -30}, {-32, -10}}, rotation = 0)));
  Buildings.Controls.OBC.CDL.Reals.Sources.Sin highSpaceTGen(
    amplitude = 3,
    freqHz = 1/3600,
    offset = 296,
    startTime = 1250)
    "Terminal unit high space temperature simulator."
  annotation(Placement(transformation(extent={{-12,4},{8,24}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Sin saTGen(
    amplitude=3,
    freqHz=1/4800,
    phase=0.87266462599716,
    offset=295,
    startTime = 0)
    "Supply air temperature simulator."
  annotation(Placement(transformation(extent = {{-24, -62}, {-4, -42}})));
  Buildings.Controls.OBC.FDE.DOAS.Validation.Baseclasses.erwTsim ERWtemp
    "Energy recovery wheel supply temperature simulator."
    annotation (Placement(transformation(extent={{70,-30},{90,-10}})));
  Buildings.Controls.OBC.CDL.Logical.Pre pre
  annotation(Placement(visible = true, transformation(origin={-82,30},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  CDL.Reals.Sources.Constant TCooSetPoi(k=296) "Zone cooling setpoint"
    annotation (Placement(transformation(extent={{-132,44},{-112,64}})));
  CDL.Reals.Sources.Constant THeaSetPoi(k=294) "Zone heating setpoint"
    annotation (Placement(transformation(extent={{-134,12},{-114,32}})));
equation

  connect(truDel.y, swi.u2) annotation (
    Line(points={{-28,32},{-20,32},{-20,16},{-62,16},{-62,-2},{-54,-2}},
                                                               color = {255, 0, 255}));

  connect(sensorDDSP.y, swi.u1) annotation (
    Line(points={{-76,-8},{-66,-8},{-66,6},{-54,6}},            color = {0, 0, 127}));

  connect(con0.y, swi.u3) annotation (
    Line(points={{-72,-52},{-60,-52},{-60,-10},{-54,-10}},      color = {0, 0, 127}));

  connect(raTGen.y, ERWtemp.TAirRet) annotation (Line(points={{50,-86},{58,-86},
          {58,-22},{67.6,-22}},    color={0,0,127}));

  connect(oaTgen.y, ERWtemp.TAirOut) annotation (Line(points={{46,-38},{54,-38},
          {54,-26},{67.6,-26}},  color={0,0,127}));

  connect(pre.y, truDel.u) annotation (
    Line(points={{-70,30},{-60,30},{-60,32},{-52,32}},          color = {255, 0, 255}));

  connect(OccGen.y, DOAScon1.Occ) annotation (Line(points={{-66,86},{26,86},{26,
          42},{36,42}}, color={255,0,255}));
  connect(truDel.y, DOAScon1.uFanSupPro) annotation (Line(points={{-28,32},{26,
          32},{26,34},{36,34}}, color={255,0,255}));
  connect(DOAScon1.yExhFanSta, truDel1.u) annotation (Line(points={{60,8},{100,
          8},{100,-48},{98,-48},{98,-56},{106,-56}}, color={255,0,255}));
  connect(truDel1.y, DOAScon1.uFanExhPro) annotation (Line(points={{130,-56},{
          138,-56},{138,-72},{54,-72},{54,-68},{14,-68},{14,-6},{36,-6}}, color
        ={255,0,255}));
  connect(DOAScon1.yBypDam, ERWtemp.uBypDam) annotation (Line(points={{60,20},{
          68,20},{68,-6},{67.6,-6},{67.6,-14}}, color={255,0,255}));
  connect(DOAScon1.yEneRecWheEna, ERWtemp.uEneRecWheStart) annotation (Line(
        points={{60,16},{70,16},{70,-6},{92,-6},{92,-14},{96,-14},{96,-28},{88,
          -28},{88,-34},{56,-34},{56,-32},{50,-32},{50,-24},{48,-24},{48,-18},{
          67.6,-18}}, color={0,0,127}));
  connect(ERWtemp.yTSimEneRecWhe, DOAScon1.TAirSupEneWhe) annotation (Line(
        points={{92.4,-20},{98,-20},{98,58},{28,58},{28,-2},{36,-2}}, color={0,
          0,127}));
  connect(DOAScon1.yFanSup, pre.u) annotation (Line(points={{60,36},{98,36},{98,
          62},{-32,62},{-32,42},{-52,42},{-52,30},{-94,30}}, color={255,0,255}));
  connect(mostOpenDamGen.y, DOAScon1.uDamMaxOpe) annotation (Line(points={{-28,
          70},{-18,70},{-18,38},{36,38}}, color={0,0,127}));
  connect(highSpaceTGen.y, DOAScon1.TAirHig) annotation (Line(points={{10,14},{
          24,14},{24,22},{36,22}}, color={0,0,127}));
  connect(DOAScon1.phiAirEneRecWhe, erwHumGen.y) annotation (Line(points={{36,2},
          {12,2},{12,-20},{2,-20}}, color={0,0,127}));
  connect(DOAScon1.phiAirRet, ralHumGen.y) annotation (Line(points={{36,26},{20,
          26},{20,62},{8,62}}, color={0,0,127}));
  connect(DOAScon1.TAirDisCoiCoo, ccTGen.y) annotation (Line(points={{36,6},{18,
          6},{18,-80},{-2,-80},{-2,-82}}, color={0,0,127}));
  connect(DOAScon1.TAirSup, saTGen.y) annotation (Line(points={{36,18},{26,18},
          {26,-8},{16,-8},{16,-52},{-2,-52}}, color={0,0,127}));
  connect(raTGen.y, DOAScon1.TAirRet) annotation (Line(points={{50,-86},{58,-86},
          {58,-22},{22,-22},{22,-10},{20,-10},{20,4},{24,4},{24,14},{36,14}},
        color={0,0,127}));
  connect(oaTgen.y, DOAScon1.TAirOut) annotation (Line(points={{46,-38},{54,-38},
          {54,-20},{28,-20},{28,-4},{24,-4},{24,10},{36,10}}, color={0,0,127}));
  connect(TCooSetPoi.y, DOAScon1.TZonCooSet) annotation (Line(points={{-110,54},
          {-20,54},{-20,48},{24,48},{24,60},{36,60},{36,50}}, color={0,0,127}));
  connect(THeaSetPoi.y, DOAScon1.TZonHeaSet) annotation (Line(points={{-112,22},
          {-102,22},{-102,46},{36,46}}, color={0,0,127}));
  connect(bldgSP.y, DOAScon1.dPAirStaBui) annotation (Line(points={{-36,-64},{
          -28,-64},{-28,-66},{60,-66},{60,-16},{44,-16},{44,-18},{36,-18},{36,
          -10}}, color={0,0,127}));
  connect(swi.y, DOAScon1.dPAirDucSta) annotation (Line(points={{-30,-2},{-16,
          -2},{-16,30},{36,30}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Ellipse(lineColor = {75, 138, 73}, fillColor = {255, 255, 255},
            fillPattern=
FillPattern.Solid, extent = {{-100, -100}, {100, 100}}), Polygon(lineColor = {0, 0, 255}, fillColor = {75, 138, 73}, pattern = LinePattern.None,
            fillPattern=
FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}}),                                Text(textColor = {28, 108, 200}, extent={{-108,
              174},{92,94}},                                                                                                                                               textString = "%name", textStyle = {TextStyle.Bold})}),
    Diagram(coordinateSystem(preserveAspectRatio = false)),
    Documentation(revisions = "<html>
<ul>
<li>
September 28, 2020, by Henry Nickels:</br>
First implementation.</li>
</ul>
</html>", info = "<html>
<p>
This example simulates
<a href=\"modelica://Buildings.Controls.OBC.FDE.DOAS.Controller\">
Buildings.Controls.OBC.FDE.DOAS.Controller</a>.
</p>
</html>"),
        __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Controls/OBC/FDE/DOAS/Validation/Controller.mos"
    "Simulate and plot"),
    experiment(
      StopTime=10800,
      Tolerance=1e-06));
end Controller;
