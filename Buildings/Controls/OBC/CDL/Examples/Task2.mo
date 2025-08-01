within Buildings.Controls.OBC.CDL.Examples;
block Task2
  "Chilled water minimum flow bypass valve controller for primary-only plants"

  parameter Real k(min=100*Modelica.Constants.eps) = 0.1
    "Gain of controller";
  parameter Real Ti(
    final quantity="Time",
    final unit="s",
    min=100*Modelica.Constants.eps) = 300
    "Time constant of integrator block";
  parameter Real r(min=100*Modelica.Constants.eps) = 1
    "Typical range of control error";

  Buildings.Controls.OBC.CDL.Interfaces.RealInput VChiWat_flow(
    final unit="m3/s",
    final quantity="VolumeFlowRate")
    "Measured chilled water flow rate through chillers";

  Buildings.Controls.OBC.CDL.Interfaces.RealInput VChiWatSet_flow(
    final unit="m3/s",
    final quantity="VolumeFlowRate")
    "Minimum chilled water flow setpoint";

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uChiWatPum
    "Maximum status feedback of all chilled water pumps";

  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yValPos(
    final min=0,
    final max=1,
    final unit="1")
    "Chilled water minimum flow bypass valve position";

  Buildings.Controls.OBC.CDL.Reals.Sources.Constant valFullOpen(k=1)
    "Valve 100% open signal";

  Buildings.Controls.OBC.CDL.Reals.PIDWithReset pidController(
    controllerType=Buildings.Controls.OBC.CDL.Types.SimpleController.PI,
    k=k,
    Ti=Ti,
    r=r,
    yMax=1,
    yMin=0,
    reverseActing=true,
    y_reset=1)
    "PID controller for bypass valve";

  Buildings.Controls.OBC.CDL.Reals.Switch valSwitch
    "Switch for valve position based on pump status";

  Buildings.Controls.OBC.CDL.Logical.Not notPumStatus
    "Negated pump status for reset trigger";

equation
  connect(VChiWatSet_flow, pidController.u_s);
  connect(VChiWat_flow, pidController.u_m);
  connect(uChiWatPum, notPumStatus.u);
  connect(notPumStatus.y, pidController.trigger);
  connect(uChiWatPum, valSwitch.u2);
  connect(pidController.y, valSwitch.u1);
  connect(valFullOpen.y, valSwitch.u3);
  connect(valSwitch.y, yValPos);

  annotation(
    Diagram(coordinateSystem(extent={{-120,-80},{120,80}}), graphics={
      Rectangle(extent={{-100,60},{-60,20}}, lineColor={0,0,0}),
      Text(extent={{-98,50},{-62,30}}, textString="valFullOpen", fontSize=10),
      Rectangle(extent={{-40,60},{40,-60}}, lineColor={0,0,0}),
      Text(extent={{-38,68},{38,52}}, textString="pidController", fontSize=10),
      Rectangle(extent={{60,40},{100,-40}}, lineColor={0,0,0}),
      Text(extent={{62,30},{98,10}}, textString="valSwitch", fontSize=10),
      Rectangle(extent={{-100,-20},{-60,-60}}, lineColor={0,0,0}),
      Text(extent={{-98,-30},{-62,-50}}, textString="notPumStatus", fontSize=10)}));

end Task2;
