within Buildings.Controls.OBC.CDL.Examples;
block Task1
  "Chiller enable/disable control with deadband to prevent short cycling"

  parameter Real TDeaBan(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature",
    min=0.1) = 2
    "Dead band to prevent short cycling, typical range 1-5 K";

  Buildings.Controls.OBC.CDL.Interfaces.RealInput TChi_CHWST(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "Chilled water supply temperature from chiller";

  Buildings.Controls.OBC.CDL.Interfaces.RealInput TChiSet(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "Set temperature for chilled water leaving chiller";

  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput y
    "Chiller enable signal: true=Enable, false=Disable";

protected
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant deaBan(k=TDeaBan)
    "Dead band constant";

  Buildings.Controls.OBC.CDL.Reals.Add addDeaBan
    "Add dead band to set temperature";

  Buildings.Controls.OBC.CDL.Reals.Greater greEna
    "Check if temperature is greater than setpoint plus deadband for enable";

  Buildings.Controls.OBC.CDL.Reals.LessThreshold lesDisable(t=0)
    "Check if temperature difference is less than or equal to 0 for disable";

  Buildings.Controls.OBC.CDL.Reals.Add tempDiff
    "Calculate temperature difference for disable logic";

  Buildings.Controls.OBC.CDL.Logical.Or logOr
    "Logic to maintain enable state until disable condition";

  Buildings.Controls.OBC.CDL.Logical.TrueFalseHold holEna(
    trueHoldDuration=60,
    falseHoldDuration=60)
    "Hold enable signal to prevent short cycling";

equation
  connect(TChiSet, addDeaBan.u1) annotation (
    Placement(transformation(extent={{-120,10},{-100,30}})));
  connect(deaBan.y, addDeaBan.u2) annotation (
    Placement(transformation(extent={{-120,-10},{-100,10}})));
  connect(TChi_CHWST, greEna.u1) annotation (
    Placement(transformation(extent={{-80,30},{-60,50}})));
  connect(addDeaBan.y, greEna.u2) annotation (
    Placement(transformation(extent={{-80,10},{-60,30}})));
  connect(TChi_CHWST, tempDiff.u1) annotation (
    Placement(transformation(extent={{-80,-30},{-60,-10}})));
  connect(TChiSet, tempDiff.u2) annotation (
    Placement(transformation(extent={{-80,-50},{-60,-30}})));
  connect(tempDiff.y, lesDisable.u) annotation (
    Placement(transformation(extent={{-40,-30},{-20,-10}})));
  connect(greEna.y, logOr.u1) annotation (
    Placement(transformation(extent={{-20,20},{0,40}})));
  connect(lesDisable.y, logOr.u2) annotation (
    Placement(transformation(extent={{-20,-20},{0,0}})));
  connect(logOr.y, holEna.u) annotation (
    Placement(transformation(extent={{20,0},{40,20}})));
  connect(holEna.y, y) annotation (
    Placement(transformation(extent={{60,0},{80,20}})));

  annotation (
    defaultComponentName="chiEna",
    Icon(graphics={
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
        textString="Chiller
Enable")}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-140,-80},{100,60}})));

end Task1;
