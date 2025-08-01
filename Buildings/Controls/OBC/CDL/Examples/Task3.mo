within Buildings.Controls.OBC.CDL.Examples;
block Task3 "Cooling tower speed control based on operating mode"

  parameter Real kCW = 1.0 "Gain of condenser water PID controller";
  parameter Real TiCW = 60.0 "Time constant of integrator block for condenser water";
  parameter Real TdCW = 10.0 "Time constant of derivative block for condenser water";
  parameter Real kCHW = 0.8 "Gain of chilled water PID controller";
  parameter Real TiCHW = 90.0 "Time constant of integrator block for chilled water";
  parameter Real TdCHW = 15.0 "Time constant of derivative block for chilled water";

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
    "Cooling mode: 0-Free Cooling, 1-Partially Mechanical Cooling, 2-Fully Mechanical Cooling";

  Buildings.Controls.OBC.CDL.Interfaces.RealOutput y(
    final min=0,
    final max=1,
    final unit="1")
    "Cooling tower fan speed signal";

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant freeCoolingMode(k=0)
    "Free cooling mode constant";

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant partialMechMode(k=1)
    "Partially mechanical cooling mode constant";

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant fullMechMode(k=2)
    "Fully mechanical cooling mode constant";

  Buildings.Controls.OBC.CDL.Integers.Equal isFreeCooling
    "Check if in free cooling mode";

  Buildings.Controls.OBC.CDL.Integers.Equal isPartialMech
    "Check if in partially mechanical cooling mode";

  Buildings.Controls.OBC.CDL.Integers.Equal isFullMech
    "Check if in fully mechanical cooling mode";

  Buildings.Controls.OBC.CDL.Reals.PID cwPID(
    controllerType=Buildings.Controls.OBC.CDL.Types.SimpleController.PID,
    k=kCW,
    Ti=TiCW,
    Td=TdCW,
    yMax=1,
    yMin=0)
    "PID controller for condenser water temperature";

  Buildings.Controls.OBC.CDL.Reals.PID chwPID(
    controllerType=Buildings.Controls.OBC.CDL.Types.SimpleController.PID,
    k=kCHW,
    Ti=TiCHW,
    Td=TdCHW,
    yMax=1,
    yMin=0)
    "PID controller for chilled water temperature";

  Buildings.Controls.OBC.CDL.Reals.Sources.Constant maxSpeed(k=1.0)
    "Maximum speed for partially mechanical cooling mode";

  Buildings.Controls.OBC.CDL.Reals.Sources.Constant zeroSpeed(k=0.0)
    "Zero speed source";

  Buildings.Controls.OBC.CDL.Reals.Switch fcSwitch
    "Switch for free cooling mode";

  Buildings.Controls.OBC.CDL.Reals.Switch pmcSwitch
    "Switch for partially mechanical cooling mode";

  Buildings.Controls.OBC.CDL.Reals.Switch fmcSwitch
    "Switch for fully mechanical cooling mode";

equation
  connect(cooMod, isFreeCooling.u1);
  connect(freeCoolingMode.y, isFreeCooling.u2);
  connect(cooMod, isPartialMech.u1);
  connect(partialMechMode.y, isPartialMech.u2);
  connect(cooMod, isFullMech.u1);
  connect(fullMechMode.y, isFullMech.u2);

  connect(TCWSupSet, cwPID.u_s);
  connect(TCWSup, cwPID.u_m);
  connect(TCHWSupSet, chwPID.u_s);
  connect(TCHWSup, chwPID.u_m);

  connect(isFreeCooling.y, fcSwitch.u2);
  connect(chwPID.y, fcSwitch.u1);
  connect(zeroSpeed.y, fcSwitch.u3);

  connect(isPartialMech.y, pmcSwitch.u2);
  connect(maxSpeed.y, pmcSwitch.u1);
  connect(fcSwitch.y, pmcSwitch.u3);

  connect(isFullMech.y, fmcSwitch.u2);
  connect(cwPID.y, fmcSwitch.u1);
  connect(pmcSwitch.y, fmcSwitch.u3);

  connect(fmcSwitch.y, y);

  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false), graphics={
      Rectangle(extent={{-180,80},{-120,20}}, lineColor={28,108,200}),
      Text(extent={{-178,60},{-122,40}}, textString="Mode\nConstants"),
      Rectangle(extent={{-100,100},{-40,60}}, lineColor={28,108,200}),
      Text(extent={{-98,90},{-42,70}}, textString="Mode\nDetection"),
      Rectangle(extent={{-100,40},{-40,0}}, lineColor={28,108,200}),
      Text(extent={{-98,30},{-42,10}}, textString="CHW\nPID"),
      Rectangle(extent={{-100,-20},{-40,-60}}, lineColor={28,108,200}),
      Text(extent={{-98,-30},{-42,-50}}, textString="CW\nPID"),
      Rectangle(extent={{0,80},{60,40}}, lineColor={28,108,200}),
      Text(extent={{2,70},{58,50}}, textString="FC\nSwitch"),
      Rectangle(extent={{0,20},{60,-20}}, lineColor={28,108,200}),
      Text(extent={{2,10},{58,-10}}, textString="PMC\nSwitch"),
      Rectangle(extent={{0,-40},{60,-80}}, lineColor={28,108,200}),
      Text(extent={{2,-50},{58,-70}}, textString="FMC\nSwitch"),
      Rectangle(extent={{80,20},{120,-20}}, lineColor={28,108,200}),
      Text(extent={{82,10},{118,-10}}, textString="Output")}));

end Task3;
