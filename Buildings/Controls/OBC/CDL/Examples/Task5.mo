within Buildings.Controls.OBC.CDL.Examples;
block Task5
  "Relief damper control for AHUs using actuated dampers without fan based on ASHRAE G36 Section 5.16.8"

  parameter Real dpBuiSet(
    final unit="Pa",
    final quantity="PressureDifference") = 12
    "Building static pressure setpoint";

  parameter Real k(
    min=0.1,
    max=10) = 1
    "Proportional gain for pressure control";

  Buildings.Controls.OBC.CDL.Interfaces.RealInput dpBui(
    final unit="Pa",
    final quantity="PressureDifference")
    "Building static pressure difference";

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput u1SupFan
    "Supply fan status signal";

  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yRelDam(
    final min=0,
    final max=1,
    final unit="1")
    "Relief damper commanded position";

  Buildings.Controls.OBC.CDL.Reals.Sources.Constant setPoi(
    final k=dpBuiSet)
    "Building static pressure setpoint";

  Buildings.Controls.OBC.CDL.Reals.PIDWithReset conP(
    final controllerType=Buildings.Controls.OBC.CDL.Types.SimpleController.P,
    final k=k,
    final yMax=1,
    final yMin=0,
    final reverseActing=true)
    "P-only controller for building pressure";

  Buildings.Controls.OBC.CDL.Reals.Sources.Constant zerPos(
    final k=0)
    "Zero position for disabled damper";

  Buildings.Controls.OBC.CDL.Reals.Switch swi
    "Switch between controlled position and zero position";

  Buildings.Controls.OBC.CDL.Logical.Not not1
    "Negate supply fan signal for reset";

equation
  connect(setPoi.y, conP.u_s);
  connect(dpBui, conP.u_m);
  connect(u1SupFan, swi.u2);
  connect(conP.y, swi.u1);
  connect(zerPos.y, swi.u3);
  connect(swi.y, yRelDam);
  connect(u1SupFan, not1.u);
  connect(not1.y, conP.trigger);

  annotation (
    defaultComponentName="relDamCon",
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
          textColor={0,0,255}),
        Text(
          extent={{-90,40},{90,-40}},
          textColor={0,0,0},
          textString="Relief Damper
Control")}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},{200,100}}),
      graphics={
        Rectangle(extent={{-190,80},{190,-80}}, lineColor={0,0,0}),
        Text(extent={{-180,70},{180,50}}, textColor={0,0,0}, textString="Relief Damper Control - ASHRAE G36 Section 5.16.8")}));

end Task5;
