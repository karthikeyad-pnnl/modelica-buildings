within Buildings.Controls.OBC.CDL.Examples;
block Task3 "Cooling tower fan speed control based on cooling mode"

  Buildings.Controls.OBC.CDL.Interfaces.RealInput TCWSupSet(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "Condenser water supply temperature setpoint";

  Buildings.Controls.OBC.CDL.Interfaces.RealInput TCWSup(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "Condenser water supply temperature measurement";

  Buildings.Controls.OBC.CDL.Interfaces.RealInput TCHWSupSet(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "Chilled water supply temperature setpoint";

  Buildings.Controls.OBC.CDL.Interfaces.RealInput TCHWSup(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "Chilled water supply temperature measurement";

  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput cooMod
    "Cooling mode: 0-Free Cooling, 1-Partially Mechanical, 2-Fully Mechanical";

  Buildings.Controls.OBC.CDL.Interfaces.RealOutput y(
    final min=0,
    final max=1,
    final unit="1")
    "Cooling tower fan speed signal";

  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput freeCoolingActive
    "Free cooling mode active status";

  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput partialMechActive
    "Partially mechanical cooling mode active status";

  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput fullyMechActive
    "Fully mechanical cooling mode active status";

  Buildings.Controls.OBC.CDL.Integers.Equal freeCoolingMode
    "Check if in Free Cooling mode";

  Buildings.Controls.OBC.CDL.Integers.Equal partialMechMode
    "Check if in Partially Mechanical Cooling mode";

  Buildings.Controls.OBC.CDL.Integers.Equal fullyMechMode
    "Check if in Fully Mechanical Cooling mode";

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant freeCoolingValue(k=0)
    "Free cooling mode value";

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant partialMechValue(k=1)
    "Partially mechanical cooling mode value";

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant fullyMechValue(k=2)
    "Fully mechanical cooling mode value";

  Buildings.Controls.OBC.CDL.Reals.Sources.Constant fullSpeed(k=1.0)
    "Full speed for PMC mode";

  Buildings.Controls.OBC.CDL.Reals.Sources.Constant minSpeed(k=0.1)
    "Minimum speed for equipment protection";

  Buildings.Controls.OBC.CDL.Reals.Sources.Constant cwTempMin(k=273.15)
    "Minimum valid condenser water temperature";

  Buildings.Controls.OBC.CDL.Reals.Sources.Constant cwTempMax(k=333.15)
    "Maximum valid condenser water temperature";

  Buildings.Controls.OBC.CDL.Reals.Sources.Constant chwTempMin(k=271.15)
    "Minimum valid chilled water temperature";

  Buildings.Controls.OBC.CDL.Reals.Sources.Constant chwTempMax(k=298.15)
    "Maximum valid chilled water temperature";

  Buildings.Controls.OBC.CDL.Reals.PIDWithReset cwPID(
    controllerType=Buildings.Controls.OBC.CDL.Types.SimpleController.PID,
    k=2.0,
    Ti=120,
    Td=30,
    yMax=1.0,
    yMin=0.0,
    reverseActing=true)
    "PID controller for condenser water temperature";

  Buildings.Controls.OBC.CDL.Reals.PIDWithReset chwPID(
    controllerType=Buildings.Controls.OBC.CDL.Types.SimpleController.PID,
    k=1.5,
    Ti=180,
    Td=45,
    yMax=1.0,
    yMin=0.0,
    reverseActing=true)
    "PID controller for chilled water temperature";

  Buildings.Controls.OBC.CDL.Reals.Hysteresis cwTempDeadband(
    uLow=-0.5,
    uHigh=0.5)
    "Deadband for condenser water temperature control";

  Buildings.Controls.OBC.CDL.Reals.Hysteresis chwTempDeadband(
    uLow=-0.5,
    uHigh=0.5)
    "Deadband for chilled water temperature control";

  Buildings.Controls.OBC.CDL.Reals.Add cwTempError
    "Condenser water temperature error";

  Buildings.Controls.OBC.CDL.Reals.Add chwTempError
    "Chilled water temperature error";

  Buildings.Controls.OBC.CDL.Reals.Sources.Constant negOne(k=-1.0)
    "Negative one constant";

  Buildings.Controls.OBC.CDL.Reals.Multiply cwErrorNeg
    "Negate condenser water measurement";

  Buildings.Controls.OBC.CDL.Reals.Multiply chwErrorNeg
    "Negate chilled water measurement";

  Buildings.Controls.OBC.CDL.Reals.Max maxWithMinSpeed1
    "Ensure minimum speed for CW control";

  Buildings.Controls.OBC.CDL.Reals.Max maxWithMinSpeed2
    "Ensure minimum speed for CHW control";

  Buildings.Controls.OBC.CDL.Reals.Switch cwControlOutput
    "Switch CW control based on deadband";

  Buildings.Controls.OBC.CDL.Reals.Switch chwControlOutput
    "Switch CHW control based on deadband";

  Buildings.Controls.OBC.CDL.Reals.Switch freeCoolingSwitch
    "Switch for free cooling mode";

  Buildings.Controls.OBC.CDL.Reals.Switch partialMechSwitch
    "Switch for partial mechanical mode";

  Buildings.Controls.OBC.CDL.Reals.Switch fullyMechSwitch
    "Switch for fully mechanical mode";

  Buildings.Controls.OBC.CDL.Integers.GreaterEqualThreshold validModeCheck(t=0)
    "Check if mode is >= 0";

  Buildings.Controls.OBC.CDL.Integers.LessEqualThreshold validModeCheck2(t=2)
    "Check if mode is <= 2";

  Buildings.Controls.OBC.CDL.Logical.And validMode
    "Combine mode validation checks";

  Buildings.Controls.OBC.CDL.Reals.GreaterThreshold cwTempValidMin
    "Check CW temp above minimum";

  Buildings.Controls.OBC.CDL.Reals.LessThreshold cwTempValidMax
    "Check CW temp below maximum";

  Buildings.Controls.OBC.CDL.Reals.GreaterThreshold chwTempValidMin
    "Check CHW temp above minimum";

  Buildings.Controls.OBC.CDL.Reals.LessThreshold chwTempValidMax
    "Check CHW temp below maximum";

  Buildings.Controls.OBC.CDL.Logical.And cwTempValid
    "CW temperature validation";

  Buildings.Controls.OBC.CDL.Logical.And chwTempValid
    "CHW temperature validation";

  Buildings.Controls.OBC.CDL.Logical.And allInputsValid
    "All inputs validation";

  Buildings.Controls.OBC.CDL.Reals.Switch safetySwitch
    "Switch to min speed if invalid inputs";

  Buildings.Controls.OBC.CDL.Logical.Timer minRuntimeTimer(t=300)
    "Minimum runtime timer";

  Buildings.Controls.OBC.CDL.Reals.GreaterThreshold speedAboveMin(t=0.15)
    "Check if speed above minimum threshold";

  Buildings.Controls.OBC.CDL.Reals.MovingAverage speedFilter(delta=5)
    "Moving average filter for speed output";

  Buildings.Controls.OBC.CDL.Reals.Switch runtimeProtection
    "Runtime protection switch";

  Buildings.Controls.OBC.CDL.Reals.FirstOrderFilter finalRateLimit(
    T=3.0,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0.1)
    "Final rate limiting for smooth transitions";

equation
  connect(cooMod, freeCoolingMode.u1) annotation(Line(points={{-220,80},{-200,80},{-200,60},{-180,60}}, color={255,127,0}));
  connect(freeCoolingValue.y, freeCoolingMode.u2) annotation(Line(points={{-200,40},{-180,40},{-180,55}}, color={255,127,0}));
  connect(cooMod, partialMechMode.u1) annotation(Line(points={{-220,80},{-200,80},{-200,20},{-180,20}}, color={255,127,0}));
  connect(partialMechValue.y, partialMechMode.u2) annotation(Line(points={{-200,0},{-180,0},{-180,15}}, color={255,127,0}));
  connect(cooMod, fullyMechMode.u1) annotation(Line(points={{-220,80},{-200,80},{-200,-20},{-180,-20}}, color={255,127,0}));
  connect(fullyMechValue.y, fullyMechMode.u2) annotation(Line(points={{-200,-40},{-180,-40},{-180,-25}}, color={255,127,0}));

  connect(TCWSup, cwErrorNeg.u1) annotation(Line(points={{-220,40},{-160,40},{-160,100},{-140,100}}, color={0,0,127}));
  connect(negOne.y, cwErrorNeg.u2) annotation(Line(points={{-180,120},{-140,120},{-140,95}}, color={0,0,127}));
  connect(TCWSupSet, cwTempError.u1) annotation(Line(points={{-220,60},{-160,60},{-160,80},{-120,80}}, color={0,0,127}));
  connect(cwErrorNeg.y, cwTempError.u2) annotation(Line(points={{-120,97},{-100,97},{-100,75},{-120,75}}, color={0,0,127}));

  connect(TCHWSup, chwErrorNeg.u1) annotation(Line(points={{-220,0},{-160,0},{-160,50},{-140,50}}, color={0,0,127}));
  connect(negOne.y, chwErrorNeg.u2) annotation(Line(points={{-180,120},{-150,120},{-150,45},{-140,45}}, color={0,0,127}));
  connect(TCHWSupSet, chwTempError.u1) annotation(Line(points={{-220,20},{-160,20},{-160,30},{-120,30}}, color={0,0,127}));
  connect(chwErrorNeg.y, chwTempError.u2) annotation(Line(points={{-120,47},{-100,47},{-100,25},{-120,25}}, color={0,0,127}));

  connect(cwTempError.y, cwTempDeadband.u) annotation(Line(points={{-100,77},{-80,77},{-80,100},{-60,100}}, color={0,0,127}));
  connect(chwTempError.y, chwTempDeadband.u) annotation(Line(points={{-100,27},{-80,27},{-80,50},{-60,50}}, color={0,0,127}));

  connect(TCWSupSet, cwPID.u_s) annotation(Line(points={{-220,60},{-40,60},{-40,80},{-20,80}}, color={0,0,127}));
  connect(TCWSup, cwPID.u_m) annotation(Line(points={{-220,40},{-40,40},{-40,68},{-20,68}}, color={0,0,127}));
  connect(fullyMechMode.y, cwPID.trigger) annotation(Line(points={{-160,-23},{-30,-23},{-30,72},{-20,72}}, color={255,0,255}));

  connect(TCHWSupSet, chwPID.u_s) annotation(Line(points={{-220,20},{-40,20},{-40,30},{-20,30}}, color={0,0,127}));
  connect(TCHWSup, chwPID.u_m) annotation(Line(points={{-220,0},{-40,0},{-40,18},{-20,18}}, color={0,0,127}));
  connect(freeCoolingMode.y, chwPID.trigger) annotation(Line(points={{-160,57},{-30,57},{-30,22},{-20,22}}, color={255,0,255}));

  connect(cwPID.y, maxWithMinSpeed1.u1) annotation(Line(points={{0,80},{20,80},{20,86},{40,86}}, color={0,0,127}));
  connect(minSpeed.y, maxWithMinSpeed1.u2) annotation(Line(points={{-160,-60},{30,-60},{30,80},{40,80}}, color={0,0,127}));
  connect(chwPID.y, maxWithMinSpeed2.u1) annotation(Line(points={{0,30},{20,30},{20,36},{40,36}}, color={0,0,127}));
  connect(minSpeed.y, maxWithMinSpeed2.u2) annotation(Line(points={{-160,-60},{30,-60},{30,30},{40,30}}, color={0,0,127}));

  connect(maxWithMinSpeed1.y, cwControlOutput.u1) annotation(Line(points={{60,83},{80,83},{80,90},{100,90}}, color={0,0,127}));
  connect(cwTempDeadband.y, cwControlOutput.u2) annotation(Line(points={{-40,100},{80,100},{80,86},{100,86}}, color={255,0,255}));
  connect(minSpeed.y, cwControlOutput.u3) annotation(Line(points={{-160,-60},{80,-60},{80,82},{100,82}}, color={0,0,127}));

  connect(maxWithMinSpeed2.y, chwControlOutput.u1) annotation(Line(points={{60,33},{80,33},{80,40},{100,40}}, color={0,0,127}));
  connect(chwTempDeadband.y, chwControlOutput.u2) annotation(Line(points={{-40,50},{80,50},{80,36},{100,36}}, color={255,0,255}));
  connect(minSpeed.y, chwControlOutput.u3) annotation(Line(points={{-160,-60},{80,-60},{80,32},{100,32}}, color={0,0,127}));

  connect(chwControlOutput.y, freeCoolingSwitch.u1) annotation(Line(points={{120,36},{140,36},{140,70},{160,70}}, color={0,0,127}));
  connect(freeCoolingMode.y, freeCoolingSwitch.u2) annotation(Line(points={{-160,57},{140,57},{140,66},{160,66}}, color={255,0,255}));
  connect(minSpeed.y, freeCoolingSwitch.u3) annotation(Line(points={{-160,-60},{140,-60},{140,62},{160,62}}, color={0,0,127}));

  connect(fullSpeed.y, partialMechSwitch.u1) annotation(Line(points={{-160,140},{140,140},{140,20},{160,20}}, color={0,0,127}));
  connect(partialMechMode.y, partialMechSwitch.u2) annotation(Line(points={{-160,17},{140,17},{140,16},{160,16}}, color={255,0,255}));
  connect(freeCoolingSwitch.y, partialMechSwitch.u3) annotation(Line(points={{180,66},{200,66},{200,12},{160,12}}, color={0,0,127}));

  connect(cwControlOutput.y, fullyMechSwitch.u1) annotation(Line(points={{120,86},{140,86},{140,-30},{160,-30}}, color={0,0,127}));
  connect(fullyMechMode.y, fullyMechSwitch.u2) annotation(Line(points={{-160,-23},{140,-23},{140,-34},{160,-34}}, color={255,0,255}));
  connect(partialMechSwitch.y, fullyMechSwitch.u3) annotation(Line(points={{180,16},{200,16},{200,-38},{160,-38}}, color={0,0,127}));

  connect(cooMod, validModeCheck.u) annotation(Line(points={{-220,80},{-100,80},{-100,-80},{-80,-80}}, color={255,127,0}));
  connect(cooMod, validModeCheck2.u) annotation(Line(points={{-220,80},{-100,80},{-100,-100},{-80,-100}}, color={255,127,0}));
  connect(validModeCheck.y, validMode.u1) annotation(Line(points={{-60,-80},{-40,-80},{-40,-90},{-20,-90}}, color={255,0,255}));
  connect(validModeCheck2.y, validMode.u2) annotation(Line(points={{-60,-100},{-40,-100},{-40,-98},{-20,-98}}, color={255,0,255}));

  connect(TCWSup, cwTempValidMin.u) annotation(Line(points={{-220,40},{-120,40},{-120,-120},{-100,-120}}, color={0,0,127}));
  connect(cwTempMin.y, cwTempValidMin.threshold) annotation(Line(points={{-160,-80},{-110,-80},{-110,-126},{-100,-126}}, color={0,0,127}));
  connect(TCWSup, cwTempValidMax.u) annotation(Line(points={{-220,40},{-120,40},{-120,-140},{-100,-140}}, color={0,0,127}));
  connect(cwTempMax.y, cwTempValidMax.threshold) annotation(Line(points={{-160,-100},{-110,-100},{-110,-146},{-100,-146}}, color={0,0,127}));

  connect(TCHWSup, chwTempValidMin.u) annotation(Line(points={{-220,0},{-120,0},{-120,-160},{-100,-160}}, color={0,0,127}));
  connect(chwTempMin.y, chwTempValidMin.threshold) annotation(Line(points={{-160,-120},{-110,-120},{-110,-166},{-100,-166}}, color={0,0,127}));
  connect(TCHWSup, chwTempValidMax.u) annotation(Line(points={{-220,0},{-120,0},{-120,-180},{-100,-180}}, color={0,0,127}));
  connect(chwTempMax.y, chwTempValidMax.threshold) annotation(Line(points={{-160,-140},{-110,-140},{-110,-186},{-100,-186}}, color={0,0,127}));

  connect(cwTempValidMin.y, cwTempValid.u1) annotation(Line(points={{-80,-120},{-60,-120},{-60,-130},{-40,-130}}, color={255,0,255}));
  connect(cwTempValidMax.y, cwTempValid.u2) annotation(Line(points={{-80,-140},{-60,-140},{-60,-138},{-40,-138}}, color={255,0,255}));
  connect(chwTempValidMin.y, chwTempValid.u1) annotation(Line(points={{-80,-160},{-60,-160},{-60,-150},{-40,-150}}, color={255,0,255}));
  connect(chwTempValidMax.y, chwTempValid.u2) annotation(Line(points={{-80,-180},{-60,-180},{-60,-158},{-40,-158}}, color={255,0,255}));

  connect(validMode.y, allInputsValid.u1) annotation(Line(points={{0,-94},{20,-94},{20,-110},{40,-110}}, color={255,0,255}));
  connect(cwTempValid.y, allInputsValid.u2) annotation(Line(points={{-20,-134},{20,-134},{20,-118},{40,-118}}, color={255,0,255}));

  connect(fullyMechSwitch.y, safetySwitch.u1) annotation(Line(points={{180,-34},{220,-34},{220,46},{240,46}}, color={0,0,127}));
  connect(allInputsValid.y, safetySwitch.u2) annotation(Line(points={{60,-114},{220,-114},{220,40},{240,40}}, color={255,0,255}));
  connect(minSpeed.y, safetySwitch.u3) annotation(Line(points={{-160,-60},{220,-60},{220,34},{240,34}}, color={0,0,127}));

  connect(safetySwitch.y, speedAboveMin.u) annotation(Line(points={{260,40},{280,40},{280,0},{300,0}}, color={0,0,127}));
  connect(speedAboveMin.y, minRuntimeTimer.u) annotation(Line(points={{320,0},{340,0},{340,-20},{360,-20}}, color={255,0,255}));

  connect(safetySwitch.y, runtimeProtection.u1) annotation(Line(points={{260,40},{280,40},{280,-40},{300,-40}}, color={0,0,127}));
  connect(minRuntimeTimer.y, runtimeProtection.u2) annotation(Line(points={{380,-20},{390,-20},{390,-44},{300,-44}}, color={255,0,255}));
  connect(minSpeed.y, runtimeProtection.u3) annotation(Line(points={{-160,-60},{280,-60},{280,-48},{300,-48}}, color={0,0,127}));

  connect(runtimeProtection.y, speedFilter.u) annotation(Line(points={{320,-44},{340,-44},{340,-80},{360,-80}}, color={0,0,127}));
  connect(speedFilter.y, finalRateLimit.u) annotation(Line(points={{380,-80},{400,-80},{400,80},{420,80}}, color={0,0,127}));
  connect(finalRateLimit.y, y) annotation(Line(points={{440,80},{460,80}}, color={0,0,127}));

  connect(freeCoolingMode.y, freeCoolingActive) annotation(Line(points={{-160,57},{-140,57},{-140,120},{460,120}}, color={255,0,255}));
  connect(partialMechMode.y, partialMechActive) annotation(Line(points={{-160,17},{-140,17},{-140,100},{460,100}}, color={255,0,255}));
  connect(fullyMechMode.y, fullyMechActive) annotation(Line(points={{-160,-23},{-140,-23},{-140,60},{460,60}}, color={255,0,255}));

  annotation(
    Diagram(coordinateSystem(extent={{-240,-200},{480,160}}), graphics={
      Rectangle(extent={{-230,-190},{470,150}}, lineColor={28,108,200}),
      Text(extent={{-220,140},{470,125}}, textString="Enhanced Cooling Tower Speed Control with Validation and Runtime Protection")}),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={
      Rectangle(extent={{-100,-100},{100,100}}, lineColor={28,108,200}),
      Text(extent={{-80,80},{80,60}}, textString="CT Speed"),
      Text(extent={{-80,40},{80,20}}, textString="Control"),
      Text(extent={{-80,0},{80,-20}}, textString="Enhanced")}));
end Task3;
