within Buildings.Controls.OBC.CDL.Examples;
block Task1
  "Control block for enabling and disabling a chiller based on chilled water supply temperature and setpoint with deadband"

  parameter Real TDeaBan(
    final unit="K",
    final displayUnit="degC",
    final quantity="ThermodynamicTemperature")=1
    "Deadband to prevent short cycling";

  Buildings.Controls.OBC.CDL.Interfaces.RealInput TChi_CHWST(
    final unit="K",
    final displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "Chilled water supply temperature";

  Buildings.Controls.OBC.CDL.Interfaces.RealInput TChiSet(
    final unit="K",
    final displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "Set temperature for chilled water leaving chiller";

  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput y
    "Chiller enable signal: true to enable, false to disable";

  Buildings.Controls.OBC.CDL.Reals.Subtract sub
    "Compute temperature difference TChi_CHWST - TChiSet"
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));

  Buildings.Controls.OBC.CDL.Reals.Hysteresis hys(
    final uLow=0,
    final uHigh=TDeaBan,
    final pre_y_start=false)
    "Hysteresis: enable if difference > TDeaBan, disable if difference <= 0"
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));

equation
  connect(TChi_CHWST, sub.u1);
  connect(TChiSet, sub.u2);
  connect(sub.y, hys.u);
  connect(hys.y, y);

  annotation (
    defaultComponentName="chiEna",
    Icon(graphics={
        Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-100,40},{0,0}},
          lineColor={0,0,127},
          textString="TChi"),
        Text(
          extent={{0,-40},{100,0}},
          lineColor={0,0,127},
          textString="CHWST"),
        Text(
          extent={{-100,-40},{0,-80}},
          lineColor={0,0,127},
          textString="TChi"),
        Text(
          extent={{0,-80},{100,-120}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="Set"),
        Line(
          points={{0,-60},{0,60}},
          color={0,0,127},
          pattern=LinePattern.Dash),
        Line(
          points={{-60,-60},{-60,-20},{-20,20},{20,-20},{60,-60}},
          color={0,0,127},
          thickness=0.5)}),
    Diagram(graphics={
        Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-98,98},{102,38}},
          lineColor={0,0,255},
          textString="%name"),
        Line(
          points={{-80,60},{-80,-80}},
          color={0,0,127},
          thickness=0.5),
        Line(
          points={{100,60},{80,60}},
          color={0,0,127},
          thickness=0.5),
        Line(
          points={{80,40},{20,40}},
          color={0,0,127},
          thickness=0.5),
        Line(
          points={{-20,20},{-20,-20}},
          color={0,0,127},
          thickness=0.5)}),
    Documentation(info="<html>
<p>
Block that enables the chiller if the chilled water supply temperature <code>TChi_CHWST</code>
exceeds the setpoint <code>TChiSet</code> plus the deadband <code>TDeaBan</code>,
and disables it if <code>TChi_CHWST</code> is less than or equal to <code>TChiSet</code>.
The hysteresis prevents short cycling.
</p>
</html>"));
end Task1;