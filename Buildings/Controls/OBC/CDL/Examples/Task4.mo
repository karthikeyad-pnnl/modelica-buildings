within Buildings.Controls.OBC.CDL.Examples;
block Task4
  "Chilled water reset request and chiller plant request based on Guideline 36 Section 5.16.16"

  Buildings.Controls.OBC.CDL.Interfaces.RealInput TAirSup(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "Supply air temperature";

  Buildings.Controls.OBC.CDL.Interfaces.RealInput TAirSupSet(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "Supply air temperature setpoint";

  Buildings.Controls.OBC.CDL.Interfaces.RealInput uCooCoi(
    final min=0,
    final max=1,
    final unit="1")
    "Chilled water valve position";

  Buildings.Controls.OBC.CDL.Interfaces.IntegerOutput yChiWatResReq
    "Chilled water reset request";

  Buildings.Controls.OBC.CDL.Interfaces.IntegerOutput yChiPlaReq
    "Chiller plant request";

protected
  Buildings.Controls.OBC.CDL.Reals.Subtract temDif
    "Temperature difference";

  Buildings.Controls.OBC.CDL.Reals.GreaterThreshold gre3K(
    t=3.0,
    h=0.1)
    "3K threshold with hysteresis";

  Buildings.Controls.OBC.CDL.Reals.GreaterThreshold gre2K(
    t=2.0,
    h=0.1)
    "2K threshold with hysteresis";

  Buildings.Controls.OBC.CDL.Logical.Timer tim3K(t=120)
    "2 minute timer for 3K threshold";

  Buildings.Controls.OBC.CDL.Logical.Timer tim2K(t=120)
    "2 minute timer for 2K threshold";

  Buildings.Controls.OBC.CDL.Logical.And and2KOnly
    "AND for 2K condition without 3K";

  Buildings.Controls.OBC.CDL.Reals.Hysteresis hysValvePos95(
    uLow=0.85,
    uHigh=0.95,
    pre_y_start=false)
    "Hysteresis for 95% valve position condition";

  Buildings.Controls.OBC.CDL.Reals.Hysteresis hysValvePos10(
    uLow=0.10,
    uHigh=0.95,
    pre_y_start=false)
    "Hysteresis for chiller plant valve condition";

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant con3Req(k=3)
    "3 requests constant";

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant con2Req(k=2)
    "2 requests constant";

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant con1Req(k=1)
    "1 request constant";

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant con0Req(k=0)
    "0 requests constant";

  Buildings.Controls.OBC.CDL.Integers.Switch swi3K
    "Switch for 3K condition";

  Buildings.Controls.OBC.CDL.Integers.Switch swi2K
    "Switch for 2K condition";

  Buildings.Controls.OBC.CDL.Integers.Switch swiVal
    "Switch for valve condition";

  Buildings.Controls.OBC.CDL.Integers.Switch swiPla
    "Switch for chiller plant condition";

  Buildings.Controls.OBC.CDL.Logical.Or or3K2K
    "Logical OR for temperature conditions";

equation
  connect(TAirSup, temDif.u1) annotation (Placement(transformation(extent={{-380,240},{-360,260}})));
  connect(TAirSupSet, temDif.u2) annotation (Placement(transformation(extent={{-380,200},{-360,220}})));
  connect(temDif.y, gre3K.u) annotation (Placement(transformation(extent={{-320,240},{-300,260}})));
  connect(temDif.y, gre2K.u) annotation (Placement(transformation(extent={{-320,180},{-300,200}})));
  connect(gre3K.y, tim3K.u) annotation (Placement(transformation(extent={{-260,240},{-240,260}})));
  connect(gre2K.y, tim2K.u) annotation (Placement(transformation(extent={{-260,180},{-240,200}})));
  connect(tim2K.passed, and2KOnly.u1) annotation (Placement(transformation(extent={{-200,160},{-180,180}})));
  connect(tim3K.passed, and2KOnly.u2) annotation (Placement(transformation(extent={{-200,140},{-180,160}})));
  connect(uCooCoi, hysValvePos95.u) annotation (Placement(transformation(extent={{-380,60},{-360,80}})));
  connect(uCooCoi, hysValvePos10.u) annotation (Placement(transformation(extent={{-380,20},{-360,40}})));
  connect(tim3K.passed, swi3K.u2) annotation (Placement(transformation(extent={{-120,240},{-100,260}})));
  connect(con3Req.y, swi3K.u1) annotation (Placement(transformation(extent={{-120,260},{-100,280}})));
  connect(con0Req.y, swi3K.u3) annotation (Placement(transformation(extent={{-120,220},{-100,240}})));
  connect(and2KOnly.y, swi2K.u2) annotation (Placement(transformation(extent={{-120,180},{-100,200}})));
  connect(con2Req.y, swi2K.u1) annotation (Placement(transformation(extent={{-120,200},{-100,220}})));
  connect(con0Req.y, swi2K.u3) annotation (Placement(transformation(extent={{-120,160},{-100,180}})));
  connect(hysValvePos95.y, swiVal.u2) annotation (Placement(transformation(extent={{-120,60},{-100,80}})));
  connect(con1Req.y, swiVal.u1) annotation (Placement(transformation(extent={{-120,80},{-100,100}})));
  connect(con0Req.y, swiVal.u3) annotation (Placement(transformation(extent={{-120,40},{-100,60}})));
  connect(hysValvePos10.y, swiPla.u2) annotation (Placement(transformation(extent={{-120,20},{-100,40}})));
  connect(con1Req.y, swiPla.u1) annotation (Placement(transformation(extent={{-120,40},{-100,60}})));
  connect(con0Req.y, swiPla.u3) annotation (Placement(transformation(extent={{-120,0},{-100,20}})));
  connect(tim3K.passed, or3K2K.u1) annotation (Placement(transformation(extent={{-60,140},{-40,160}})));
  connect(and2KOnly.y, or3K2K.u2) annotation (Placement(transformation(extent={{-60,120},{-40,140}})));
  connect(swi3K.y, yChiWatResReq) annotation (Placement(transformation(extent={{380,240},{400,260}})));
  connect(swiPla.y, yChiPlaReq) annotation (Placement(transformation(extent={{380,20},{400,40}})));

  annotation (
    Diagram(coordinateSystem(extent={{-400,-300},{400,300}}), graphics={
      Rectangle(
        extent={{-390,290},{390,-290}},
        lineColor={0,0,0},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid)}),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={
      Rectangle(
        extent={{-100,100},{100,-100}},
        lineColor={0,0,0},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
      Text(
        extent={{-80,20},{80,-20}},
        textColor={0,0,255},
        textString="ChiWat&ChiPla
Request")}));

end Task4;
