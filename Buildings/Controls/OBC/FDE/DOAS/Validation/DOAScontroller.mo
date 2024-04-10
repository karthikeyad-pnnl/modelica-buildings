within Buildings.Controls.OBC.FDE.DOAS.Validation;
model DOAScontroller "DOAS controller"

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
  final unit= "s") = 0.1 "Time constant of derivative block";

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
  final unit= "s") = 0.1 "Time constant of derivative block";

     parameter Boolean is_vav = true
  "True: System has zone terminals with variable damper position. False: System has zone terminals with constant damper position.";

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



  Buildings.Controls.OBC.FDE.DOAS.DOAScontroller DOAScon(
    erwDPadj=erwDPadj,
    controllerTypeDeh=controllerTypeDeh,
    kDeh=kDeh,
    TiDeh=TiDeh,
    TdDeh=TdDeh,
    controllerTypeRegOpe=controllerTypeRegOpe,
    kRegOpe=kRegOpe,
    TiRegOpe=TiRegOpe,
    TdRegOpe=TdRegOpe,
    dehumSet=dehumSet,
    timThrDehDis=timThrDehDis,
    timDelDehEna=timDelDehEna,
    timThrDehEna=timThrDehEna,
    dTEcoThr=dTEcoThr,
    dTThrEneRec=dTThrEneRec,
    dThys=dThys,
    timDelEneRec=timDelEneRec,
    controllerTypeEneWheHea=controllerTypeEneWheHea,
    kEneWheHea=kEneWheHea,
    TiEneWheHea=TiEneWheHea,
    TdEneWheHea=TdEneWheHea,
    kEneWheCoo=kEneWheCoo,
    TiEneWheCoo=TiEneWheCoo,
    controllerTypeEneWheCoo=controllerTypeEneWheCoo,
    TdEneWheCoo=TdEneWheCoo,
    dPSetBui=dPSetBui,
    kExhFan=kExhFan,
    TiExhFan=TiExhFan,
    TdExhFan=TdExhFan,
    controllerTypeExhFan=Buildings.Controls.OBC.CDL.Types.SimpleController.P,
    controllerTypeCoiHea=controllerTypeCoiHea,
    kCoiHea=kCoiHea,
    TiCoiHea=TiCoiHea,
    TdCoiHea=TdCoiHea,
    is_vav=is_vav,
    yMinDamSet=yMinDamSet,
    yMaxDamSet=yMaxDamSet,
    damSet=damSet,
    kDam=kDam,
    TiDam=TiDam,
    TdDam=TdDam,
    controllerTypeDam=controllerTypeDam,
    dPDucSetCV=dPDucSetCV,
    fanSpeMin=fanSpeMin,
    kFanSpe=kFanSpe,
    TdFanSpe=TdFanSpe,
    TiFanSpe=TiFanSpe,
    controllerTypeFanSpe=controllerTypeFanSpe,
    TSupLowSet=TSupLowSet,
    TSupHigSet=TSupHigSet,
    THigZon=THigZon,
    TLowZon=TLowZon,
    TSupCooOff=TSupCooOff,
    TSupHeaOff=TSupHeaOff)
  annotation(Placement(visible = true, transformation(origin = {6, 12}, extent = {{64, -18}, {84, 16}}, rotation = 0)));

  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse OccGen(
  width = 0.8,
  period = 8000,
    shift=1000)
  "Simulates occupancy mode schedule."
  annotation(Placement(transformation(extent = {{-42, 76}, {-22, 96}})));

  Buildings.Controls.OBC.CDL.Reals.Sources.Sin mostOpenDamGen(
  amplitude = 4,
  freqHz = 1/5670,
  offset = 90)
  "Simulates changing terminal unit most open damper position."
  annotation(Placement(transformation(extent = {{-42, 46}, {-22, 66}})));

  Buildings.Controls.OBC.CDL.Logical.TrueDelay truDel(
  delayTime = 10,
  delayOnInit = true)
  "Simulates delay from initial fan start command to fan status proof."
  annotation(Placement(visible = true, transformation(origin = {48, 8}, extent = {{-94, 14}, {-74, 34}}, rotation = 0)));

  Buildings.Controls.OBC.CDL.Reals.Sources.Sin sensorDDSP(
  amplitude = 300,
  freqHz = 1/10800,
  phase = 3.9269908169872,
  offset = 400)
  annotation(Placement(visible = true, transformation(origin = {-6, 0}, extent = {{-92, -18}, {-72, 2}}, rotation = 0)));

  Buildings.Controls.OBC.CDL.Reals.Switch swi
  "Logic switch selects DDSP generator when fan is proven otherwise selects 0."
  annotation(Placement(transformation(extent = {{-52, -2}, {-32, 18}})));

  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con0(
  final k = 0)
  "Real constant 0"
  annotation(Placement(visible = true, transformation(origin = {2, -10}, extent = {{-92, -48}, {-72, -28}}, rotation = 0)));

  Buildings.Controls.OBC.CDL.Reals.Sources.Sin ralHumGen(
  amplitude = 10,
  freqHz = 1/10800,
  phase = 1.5707963267949,
  offset = 60,
  startTime = 0)
  "Return humidity sensor simulator."
  annotation(Placement(transformation(extent = {{2, -16}, {22, 4}})));

  Buildings.Controls.OBC.CDL.Reals.Sources.Sin erwHumGen(
  amplitude = 5,
  freqHz = 1/7200,
  phase = 1.5707963267949,
  offset = 60,
  startTime = 0)
  "ERW humidity sensor simulator."
  annotation(Placement(visible = true, transformation(origin = {-4, -4}, extent = {{32, -30}, {52, -10}}, rotation = 0)));

  Buildings.Controls.OBC.CDL.Logical.TrueDelay truDel1(
  final delayTime = 10,
  final delayOnInit = true)
  "Simulates delay from initial fan start command to fan status proof."
  annotation(Placement(transformation(extent = {{108, -66}, {128, -46}})));

  Buildings.Controls.OBC.CDL.Reals.Sources.Sin bldgSP(
  amplitude = 3,
  freqHz = 1/10800,
  offset = 15)
  annotation(Placement(transformation(extent = {{30, -92}, {50, -72}})));

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
  annotation(Placement(transformation(extent = {{4, -46}, {24, -26}})));

  Buildings.Controls.OBC.CDL.Reals.Sources.Sin raTGen(
  amplitude = 5,
  freqHz = 1/20600,
  phase = 0.34906585039887,
  offset = 294, startTime = 0)
  "Return air temperature simulator."
  annotation(Placement(visible = true, transformation(origin = {-2, -8}, extent = {{-52, -30}, {-32, -10}}, rotation = 0)));

  Buildings.Controls.OBC.CDL.Reals.Sources.Sin highSpaceTGen(
  amplitude = 3,
  freqHz = 1/3600,
  offset = 296,
  startTime = 1250)
  "Terminal unit high space temperature simulator."
  annotation(Placement(transformation(extent = {{-24, -28}, {-4, -8}})));

  Buildings.Controls.OBC.CDL.Reals.Sources.Sin saTGen(
  amplitude = 15,
  freqHz = 1/21600,
  phase = 1.0471975511966,
  offset = 285,
  startTime = 0)
  "Supply air temperature simulator."
  annotation(Placement(transformation(extent = {{-24, -62}, {-4, -42}})));

  Buildings.Controls.OBC.FDE.DOAS.Validation.Baseclasses.erwTsim ERWtemp
    "Energy recovery wheel supply temperature simulator."
    annotation (Placement(transformation(extent={{110,-28},{130,-8}})));

  Buildings.Controls.OBC.CDL.Logical.Pre pre
  annotation(Placement(visible = true, transformation(origin = {-68, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

equation
  connect(OccGen.y,DOAScon.Occ)  annotation (
    Line(points={{-20,86},{58,86},{58,27.6},{68,27.6}},      color = {255, 0, 255}));

  connect(mostOpenDamGen.y, DOAScon.uDamMaxOpe) annotation (Line(points={{-20,
          56},{54,56},{54,25.2},{68,25.2}}, color={0,0,127}));

  connect(truDel.y, DOAScon.uFanSupPro) annotation (Line(points={{-24,32},{50,
          32},{50,22.8},{68,22.8}}, color={255,0,255}));

  connect(truDel.y, swi.u2) annotation (
    Line(points = {{-24, 32}, {-24, 18}, {-54, 18}, {-54, 8}}, color = {255, 0, 255}));

  connect(sensorDDSP.y, swi.u1) annotation (
    Line(points = {{-76, -8}, {-66, -8}, {-66, 16}, {-54, 16}}, color = {0, 0, 127}));

  connect(con0.y, swi.u3) annotation (
    Line(points = {{-68, -48}, {-60, -48}, {-60, 0}, {-54, 0}}, color = {0, 0, 127}));

  connect(ralHumGen.y, DOAScon.phiAirRet) annotation (Line(points={{24,-6},{28,
          -6},{28,18},{68,18}}, color={0,0,127}));

  connect(highSpaceTGen.y, DOAScon.TAirHig) annotation (Line(points={{-2,-18},{
          30,-18},{30,15.4},{68,15.4}}, color={0,0,127}));

  connect(raTGen.y, DOAScon.TAirRet) annotation (Line(points={{-32,-28},{-28,-28},
          {-28,10.4},{68,10.4}}, color={0,0,127}));

  connect(erwHumGen.y, DOAScon.phiAirEneRecWhe) annotation (Line(points={{50,-24},
          {56,-24},{56,2.8},{68,2.8}}, color={0,0,127}));

  connect(DOAScon.yBypDam, ERWtemp.uBypDam) annotation (Line(points={{92.2,11},
          {97.1,11},{97.1,-12},{107.6,-12}}, color={255,0,255}));

  connect(DOAScon.yEneRecWheEna, ERWtemp.uEneRecWheStart) annotation (Line(
        points={{92.2,8},{98,8},{98,-16},{107.6,-16}}, color={255,0,255}));

  connect(raTGen.y, ERWtemp.TAirRet) annotation (Line(points={{-32,-28},{38.8,-28},
          {38.8,-20},{107.6,-20}}, color={0,0,127}));

  connect(ERWtemp.yTSimEneRecWhe, DOAScon.TAirSupEneWhe) annotation (Line(
        points={{132.4,-18},{134,-18},{134,-38},{60,-38},{60,0.4},{68,0.4}},
        color={0,0,127}));

  connect(DOAScon.yExhFanSta, truDel1.u) annotation (Line(points={{92.2,1.6},{
          96,1.6},{96,-56},{106,-56}}, color={255,0,255}));

  connect(truDel1.y, DOAScon.uFanExhPro) annotation (Line(points={{130,-56},{
          134,-56},{134,-74},{58,-74},{58,-2},{68,-2}}, color={255,0,255}));

  connect(bldgSP.y, DOAScon.dPAirStaBui) annotation (Line(points={{52,-82},{54,
          -82},{54,-4.4},{68,-4.4}}, color={0,0,127}));

  connect(oaTgen.y, DOAScon.TAirOut) annotation (Line(points={{26,-36},{32,-36},
          {32,7.8},{68,7.8}}, color={0,0,127}));

  connect(oaTgen.y, ERWtemp.TAirOut) annotation (Line(points={{26,-36},{62,-36},
          {62,-24},{107.6,-24}}, color={0,0,127}));

  connect(swi.y, DOAScon.dPAirDucSta) annotation (Line(points={{-30,8},{16,8},{
          16,20.4},{68,20.4}}, color={0,0,127}));

  connect(saTGen.y, DOAScon.TAirSup) annotation (Line(points={{-2,-52},{26,-52},
          {26,12.8},{68,12.8}}, color={0,0,127}));

  connect(ccTGen.y, DOAScon.TAirDisCoiCoo) annotation (Line(points={{-2,-82},{
          28,-82},{28,5.4},{68,5.4}}, color={0,0,127}));

  connect(DOAScon.yFanSup, pre.u) annotation (Line(points={{92.2,23.4},{-86,
          23.4},{-86,52},{-80,52}}, color={255,0,255}));

  connect(pre.y, truDel.u) annotation (
    Line(points = {{-56, 52}, {-56, 41}, {-48, 41}, {-48, 32}}, color = {255, 0, 255}));

  annotation (
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Ellipse(lineColor = {75, 138, 73}, fillColor = {255, 255, 255},
            fillPattern=
FillPattern.Solid, extent = {{-100, -100}, {100, 100}}), Polygon(lineColor = {0, 0, 255}, fillColor = {75, 138, 73}, pattern = LinePattern.None,
            fillPattern=
FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})}),
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
<a href=\"modelica://Buildings.Controls.OBC.FDE.DOAS.DOAScontroller\">
Buildings.Controls.OBC.FDE.DOAS.DOAScontroller</a>.
</p>
</html>"),
    experiment(StopTime = 10800, __Dymola_Algorithm = "Dassl"));
end DOAScontroller;
