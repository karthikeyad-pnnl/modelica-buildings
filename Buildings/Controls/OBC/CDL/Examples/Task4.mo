within Buildings.Controls.OBC.CDL.Examples;
block Task4
  "Chilled water reset request and chiller plant request based on Section 5.16.16 of Guideline 36"

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

  Buildings.Controls.OBC.CDL.Reals.Subtract delTAir
    "Temperature difference";

  Buildings.Controls.OBC.CDL.Reals.GreaterThreshold greThr3K(
    final t=3)
    "Check if temperature difference exceeds 3K";

  Buildings.Controls.OBC.CDL.Reals.GreaterThreshold greThr2K(
    final t=2)
    "Check if temperature difference exceeds 2K";

  Buildings.Controls.OBC.CDL.Logical.Timer tim3K(
    final t=120)
    "Timer for 3K exceedance";

  Buildings.Controls.OBC.CDL.Logical.Timer tim2K(
    final t=120)
    "Timer for 2K exceedance";

  Buildings.Controls.OBC.CDL.Reals.Hysteresis hysCooCoiRes(
    final uLow=0.85,
    final uHigh=0.95)
    "Hysteresis for chilled water reset valve position";

  Buildings.Controls.OBC.CDL.Reals.Hysteresis hysCooCoiPla(
    final uLow=0.10,
    final uHigh=0.95)
    "Hysteresis for plant request valve position";

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant con3(
    final k=3)
    "Constant 3 for reset request";

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant con2(
    final k=2)
    "Constant 2 for reset request";

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant con1(
    final k=1)
    "Constant 1 for reset request";

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant con0(
    final k=0)
    "Constant 0 for reset request";

  Buildings.Controls.OBC.CDL.Logical.And and3KReq
    "3K temperature condition with timer";

  Buildings.Controls.OBC.CDL.Logical.And and2KReqTemp
    "2K temperature condition with timer";

  Buildings.Controls.OBC.CDL.Logical.And and2KReq
    "2K temperature condition and not 3K";

  Buildings.Controls.OBC.CDL.Logical.Not not3KReq
    "NOT of 3K condition";

  Buildings.Controls.OBC.CDL.Logical.Or or3K2K
    "Either 3K or 2K condition active";

  Buildings.Controls.OBC.CDL.Logical.Not notTempReq
    "NOT of any temperature request";

  Buildings.Controls.OBC.CDL.Logical.And andValReq
    "Valve request when no temperature request";

  Buildings.Controls.OBC.CDL.Integers.Switch swi3KReq
    "Switch for 3K request";

  Buildings.Controls.OBC.CDL.Integers.Switch swi2KReq
    "Switch for 2K request";

  Buildings.Controls.OBC.CDL.Integers.Switch swiValReq
    "Switch for valve request";

  Buildings.Controls.OBC.CDL.Integers.Switch swiPlaReq
    "Switch for plant request";

equation
  connect(TAirSup, delTAir.u1) annotation (Placement(transformation(extent={{-200,80},{-180,100}})));
  connect(TAirSupSet, delTAir.u2) annotation (Placement(transformation(extent={{-200,60},{-180,80}})));

  connect(delTAir.y, greThr3K.u) annotation (Placement(transformation(extent={{-160,90},{-140,110}})));
  connect(delTAir.y, greThr2K.u) annotation (Placement(transformation(extent={{-160,70},{-140,90}})));

  connect(greThr3K.y, tim3K.u) annotation (Placement(transformation(extent={{-120,90},{-100,110}})));
  connect(greThr2K.y, tim2K.u) annotation (Placement(transformation(extent={{-120,70},{-100,90}})));

  connect(tim3K.passed, and3KReq.u1) annotation (Placement(transformation(extent={{-80,100},{-60,120}})));
  connect(greThr3K.y, and3KReq.u2) annotation (Placement(transformation(extent={{-80,80},{-60,100}})));

  connect(and3KReq.y, not3KReq.u) annotation (Placement(transformation(extent={{-40,110},{-20,130}})));
  connect(tim2K.passed, and2KReqTemp.u1) annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  connect(greThr2K.y, and2KReqTemp.u2) annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  connect(and2KReqTemp.y, and2KReq.u1) annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
  connect(not3KReq.y, and2KReq.u2) annotation (Placement(transformation(extent={{-40,30},{-20,50}})));

  connect(and3KReq.y, or3K2K.u1) annotation (Placement(transformation(extent={{0,70},{20,90}})));
  connect(and2KReq.y, or3K2K.u2) annotation (Placement(transformation(extent={{0,50},{20,70}})));
  connect(or3K2K.y, notTempReq.u) annotation (Placement(transformation(extent={{40,60},{60,80}})));

  connect(uCooCoi, hysCooCoiRes.u) annotation (Placement(transformation(extent={{-200,10},{-180,30}})));
  connect(uCooCoi, hysCooCoiPla.u) annotation (Placement(transformation(extent={{-200,-30},{-180,-10}})));

  connect(hysCooCoiRes.y, andValReq.u1) annotation (Placement(transformation(extent={{-120,20},{-100,40}})));
  connect(notTempReq.y, andValReq.u2) annotation (Placement(transformation(extent={{-120,0},{-100,20}})));

  connect(and3KReq.y, swi3KReq.u2) annotation (Placement(transformation(extent={{80,100},{100,120}})));
  connect(con3.y, swi3KReq.u1) annotation (Placement(transformation(extent={{60,120},{80,140}})));
  connect(swi2KReq.y, swi3KReq.u3) annotation (Placement(transformation(extent={{60,80},{80,100}})));

  connect(and2KReq.y, swi2KReq.u2) annotation (Placement(transformation(extent={{80,60},{100,80}})));
  connect(con2.y, swi2KReq.u1) annotation (Placement(transformation(extent={{60,80},{80,100}})));
  connect(swiValReq.y, swi2KReq.u3) annotation (Placement(transformation(extent={{60,40},{80,60}})));

  connect(andValReq.y, swiValReq.u2) annotation (Placement(transformation(extent={{80,20},{100,40}})));
  connect(con1.y, swiValReq.u1) annotation (Placement(transformation(extent={{60,40},{80,60}})));
  connect(con0.y, swiValReq.u3) annotation (Placement(transformation(extent={{60,0},{80,20}})));

  connect(hysCooCoiPla.y, swiPlaReq.u2) annotation (Placement(transformation(extent={{80,-30},{100,-10}})));
  connect(con1.y, swiPlaReq.u1) annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  connect(con0.y, swiPlaReq.u3) annotation (Placement(transformation(extent={{60,-50},{80,-30}})));

  connect(swi3KReq.y, yChiWatResReq) annotation (Placement(transformation(extent={{120,100},{140,120}})));
  connect(swiPlaReq.y, yChiPlaReq) annotation (Placement(transformation(extent={{120,-30},{140,-10}})));

end Task4;
