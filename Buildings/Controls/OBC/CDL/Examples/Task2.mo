within Buildings.Controls.OBC.CDL.Examples;
block Task2
  "Chilled water minimum flow bypass valve controller for primary-only plants"

  parameter Real k = 0.5 "Proportional gain of bypass valve PID controller";
  parameter Real Ti = 120 "Integral time constant of bypass valve PID controller";
  parameter Real Td = 0 "Derivative time constant of bypass valve PID controller";
  parameter Real yMin = 0 "Minimum valve position";
  parameter Real yMax = 1 "Maximum valve position";
  parameter Real y_start = 1 "Initial valve position";

  Buildings.Controls.OBC.CDL.Interfaces.RealInput VChiWat_flow(
    final unit="m3/s",
    final quantity="VolumeFlowRate",
    final min=0)
    "Measured chilled water flow rate through chillers";

  Buildings.Controls.OBC.CDL.Interfaces.RealInput VChiWatSet_flow(
    final unit="m3/s",
    final quantity="VolumeFlowRate",
    final min=0)
    "Minimum chilled water flow setpoint";

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uChiWatPum
    "Maximum status feedback of all chilled water pumps";

  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yValPos(
    final min=0,
    final max=1,
    final unit="1")
    "Chilled water minimum flow bypass valve position";

  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput uPidEna
    "PID controller enable status";

  Buildings.Controls.OBC.CDL.Reals.PIDWithReset pidCon(
    controllerType=Buildings.Controls.OBC.CDL.Types.SimpleController.PID,
    k=k,
    Ti=Ti,
    Td=Td,
    reverseActing=true,
    yMax=yMax,
    yMin=yMin,
    y_reset=1,
    xi_start=y_start)
    "PID controller for bypass valve";

  Buildings.Controls.OBC.CDL.Reals.Sources.Constant valFullOpen(k=1)
    "Constant signal for 100% valve opening";

  Buildings.Controls.OBC.CDL.Logical.Not notPumStatus
    "Negated pump status signal";

  Buildings.Controls.OBC.CDL.Reals.Switch valSwitch
    "Switch between PID output and full open position";

equation
  connect(VChiWatSet_flow, pidCon.u_s);
  connect(VChiWat_flow, pidCon.u_m);
  connect(uChiWatPum, notPumStatus.u);
  connect(notPumStatus.y, pidCon.trigger);
  connect(uChiWatPum, valSwitch.u2);
  connect(pidCon.y, valSwitch.u1);
  connect(valFullOpen.y, valSwitch.u3);
  connect(valSwitch.y, yValPos);
  connect(uChiWatPum, uPidEna);

  annotation(
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,150},{150,110}},
          textString="%name",
          textColor={0,0,255})}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-300,-200},{300,200}}),
      graphics={
        Rectangle(extent={{-280,-20},{-240,20}}, lineColor={0,0,127}),
        Text(extent={{-260,-40},{-260,-40}}, textString="VChiWatSet_flow"),
        Rectangle(extent={{-280,-80},{-240,-40}}, lineColor={0,0,127}),
        Text(extent={{-260,-100},{-260,-100}}, textString="VChiWat_flow"),
        Rectangle(extent={{-280,40},{-240,80}}, lineColor={255,0,255}),
        Text(extent={{-260,20},{-260,20}}, textString="uChiWatPum"),
        Rectangle(extent={{-180,40},{-140,80}}, lineColor={255,0,255}),
        Text(extent={{-160,20},{-160,20}}, textString="notPumStatus"),
        Rectangle(extent={{-80,-80},{0,20}}, lineColor={0,0,127}),
        Text(extent={{-40,-100},{-40,-100}}, textString="pidCon"),
        Rectangle(extent={{80,-20},{160,20}}, lineColor={0,0,127}),
        Text(extent={{120,-40},{120,-40}}, textString="valSwitch"),
        Rectangle(extent={{80,40},{160,80}}, lineColor={0,0,127}),
        Text(extent={{120,20},{120,20}}, textString="valFullOpen"),
        Rectangle(extent={{220,-20},{280,20}}, lineColor={0,0,127}),
        Text(extent={{250,-40},{250,-40}}, textString="yValPos"),
        Rectangle(extent={{220,40},{280,80}}, lineColor={255,0,255}),
        Text(extent={{250,20},{250,20}}, textString="uPidEna")}));

end Task2;
