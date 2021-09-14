within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChilledBeamSystem;
block SystemController "Main chilled beam system controller"

  parameter Integer nPum=2
    "Number of chilled water pumps"
    annotation (Dialog(group="System parameters"));

  parameter Integer pumStaOrd[nPum]={i for i in 1:nPum}
    "Chilled water pump staging order";

  parameter Integer nVal = 3
    "Total number of chilled water control valves on chilled beams"
    annotation (Dialog(group="System parameters"));

  parameter Real minPumSpe(
    final unit="1",
    displayUnit="1",
    final min=0,
    final max=maxPumSpe) = 0.1
    "Minimum pump speed"
    annotation (Dialog(group="Pump parameters"));

  parameter Real maxPumSpe(
    final unit="1",
    displayUnit="1",
    final min=minPumSpe,
    final max=1) = 1
    "Maximum pump speed"
    annotation (Dialog(group="Pump parameters"));

  parameter Real valPosClo(
    final unit="1",
    displayUnit="1")=0.05
    "Valve position at which it is deemed to be closed"
    annotation (Dialog(tab="Pump control parameters",
      group="Pump enable parameters"));

  parameter Real valPosOpe(
    final unit="1",
    displayUnit="1")=0.1
    "Valve position at which it is deemed to be open"
    annotation (Dialog(tab="Pump control parameters",
      group="Pump enable parameters"));

  parameter Real valOpeThr(
    final unit="s",
    displayUnit="s",
    final quantity="time")=30
    "Minimum threshold time for which a valve has to be open to enable lead pump"
    annotation (Dialog(tab="Pump control parameters",
      group="Pump enable parameters"));

  parameter Real valCloThr(
    final unit="s",
    displayUnit="s",
    final quantity="time")=60
    "Minimum threshold time for which all valves have to be closed to disable lead pump"
    annotation (Dialog(tab="Pump control parameters",
      group="Pump enable parameters"));

  parameter Real speLim(
    final unit="1",
    displayUnit="1") = 0.75
    "Speed limit with longer enable delay for enabling next lag pump"
    annotation (Dialog(tab="Pump control parameters",
      group="Pump staging parameters"));

  parameter Real speLim1(
    final unit="1",
    displayUnit="1") = 0.9
    "Speed limit with shorter enable delay for enabling next lag pump"
    annotation (Dialog(tab="Pump control parameters",
      group="Pump staging parameters"));

  parameter Real speLim2(
    final unit="1",
    displayUnit="1") = 0.25
    "Speed limit for disabling last lag pump"
    annotation (Dialog(tab="Pump control parameters",
      group="Pump staging parameters"));

  parameter Real timPer1(
    final unit="s",
    displayUnit="s",
    final quantity="time") = 120
    "Delay time period for enabling next lag pump at speed limit speLim"
    annotation (Dialog(tab="Pump control parameters",
      group="Pump staging parameters"));

  parameter Real timPer2(
    final unit="s",
    displayUnit="s",
    final quantity="time") = 60
    "Delay time period for enabling next lag pump at speed limit speLim1"
    annotation (Dialog(tab="Pump control parameters",
      group="Pump staging parameters"));

  parameter Real timPer3(
    final unit="s",
    displayUnit="s",
    final quantity="time") = 120
    "Delay time period for disabling last lag pump"
    annotation (Dialog(tab="Pump control parameters",
      group="Pump staging parameters"));

  parameter Real kPumSpe(
    final unit="1",
    displayUnit="1",
    final min=0) = 1
    "Gain of controller"
    annotation (Dialog(tab="Pump control parameters",
      group="PID parameters"));

  parameter Real TiPumSpe(
    final unit="s",
    displayUnit="s",
    final quantity="time",
    final min=0) = 0.5
    "Time constant of integrator block"
    annotation (Dialog(tab="Pump control parameters",
      group="PID parameters"));

  parameter Real TdPumSpe(
    final unit="s",
    displayUnit="s",
    final quantity="time",
    final min=0) = 0.1
    "Time constant of derivative block"
    annotation (Dialog(tab="Pump control parameters",
      group="PID parameters"));

  parameter Real dPChiWatMax(
    final unit="Pa",
    displayUnit="Pa",
    final quantity="PressureDifference") = 50000
    "Maximum allowed differential pressure in the chilled water loop"
    annotation(Dialog(group="System parameters"));

  parameter Real kBypVal(
    final unit="1",
    displayUnit="1") = 1
    "Gain of controller"
    annotation (Dialog(tab="Bypass valve parameters",
      group="PID parameters"));

  parameter Real TiBypVal(
    final unit="s",
    displayUnit="s",
    final quantity="Time") = 0.5
    "Time constant of integrator block"
    annotation (Dialog(tab="Bypass valve parameters",
      group="PID parameters"));

  parameter Real TdBypVal(
    final unit="s",
    displayUnit="s",
    final quantity="time",
    final min=0) = 0.1
    "Time constant of derivative block"
    annotation (Dialog(tab="Bypass valve parameters",
      group="PID parameters"));

  parameter Real dPumSpe=0.01
    "Value added to minimum pump speed to get upper hysteresis limit"
    annotation (Dialog(tab="Pump control parameters",
      group="Advanced"));

  parameter Real valPosLowClo(
    final unit="1",
    displayUnit="1") = 0.45
    "Lower limit for sending one request to Trim-and-Respond logic"
    annotation(Dialog(tab="Chilled water static pressure reset", group="Control valve parameters"));

  parameter Real valPosLowOpe(
    final unit="1",
    displayUnit="1") = 0.5
    "Upper limit for sending one request to Trim-and-Respond logic"
    annotation(Dialog(tab="Chilled water static pressure reset", group="Control valve parameters"));

  parameter Real valPosHigClo(
    final unit="1",
    displayUnit="1") = 0.95
    "Lower limit for sending two requests to Trim-and-Respond logic"
    annotation(Dialog(tab="Chilled water static pressure reset", group="Control valve parameters"));

  parameter Real valPosHigOpe(
    final unit="1",
    displayUnit="1") = 0.99
    "Upper limit for sending two requests to Trim-and-Respond logic"
    annotation(Dialog(tab="Chilled water static pressure reset", group="Control valve parameters"));

  parameter Real chiWatStaPreMax(
    final unit="Pa",
    displayUnit="Pa",
    final quantity="Pressure") = 30000
    "Maximum chilled water loop static pressure setpoint"
    annotation(Dialog(tab="Chilled water static pressure reset", group="Trim-and-Respond parameters"));

  parameter Real chiWatStaPreMin(
    final unit="Pa",
    displayUnit="Pa",
    final quantity="Pressure") = 20000
    "Minimum chilled water loop static pressure setpoint"
    annotation(Dialog(tab="Chilled water static pressure reset", group="Trim-and-Respond parameters"));

  parameter Real triAmoVal(
    final unit="Pa",
    displayUnit="Pa",
    final quantity="PressureDifference") = -500
    "Static pressure trim amount"
    annotation(Dialog(tab="Chilled water static pressure reset", group="Trim-and-Respond parameters"));

  parameter Real resAmoVal(
    final unit="Pa",
    displayUnit="Pa",
    final quantity="PressureDifference") = 750
    "Static pressure respond amount"
    annotation(Dialog(tab="Chilled water static pressure reset", group="Trim-and-Respond parameters"));

  parameter Real maxResVal(
    final unit="Pa",
    displayUnit="Pa",
    final quantity="PressureDifference") = 1000
    "Static pressure maximum respond amount"
    annotation(Dialog(tab="Chilled water static pressure reset", group="Trim-and-Respond parameters"));

  parameter Real samPerVal(
    final unit="s",
    displayUnit="s",
    final quantity="Duration") = 30
    "Sample period duration"
    annotation(Dialog(tab="Chilled water static pressure reset", group="Trim-and-Respond parameters"));

  parameter Real delTimVal(
    final unit="s",
    displayUnit="min",
    final quantity="Duration") = 120
    "Delay period duration"
    annotation(Dialog(tab="Chilled water static pressure reset", group="Trim-and-Respond parameters"));

  parameter Real thrTimLow(
    final unit="s",
    displayUnit="s",
    final quantity="Duration") = 60
    "Threshold time for generating one request"
    annotation(Dialog(tab="Chilled water static pressure reset", group="Control valve parameters"));

  parameter Real thrTimHig(
    final unit="s",
    displayUnit="s",
    final quantity="Duration") = 30
    "Threshold time for generating two requests"
    annotation(Dialog(tab="Chilled water static pressure reset", group="Control valve parameters"));

  parameter CDL.Types.SimpleController controllerTypeBypVal=Buildings.Controls.OBC.CDL.Types.SimpleController.PI
    "Type of controller for bypass valve position"
    annotation (Dialog(tab="Bypass valve parameters",
      group="PID parameters"));

  CDL.Interfaces.BooleanInput uPumSta[nPum] "Pump status from plant"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));

  CDL.Interfaces.RealInput dPChiWatLoo
    "Measured chilled water loop differential pressure"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  CDL.Interfaces.RealInput uValPos[nVal]
    "Measured chilled beam manifold control valve position"
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));

  CDL.Interfaces.BooleanOutput yChiWatPum[nPum]
    "Chilled water pump enable signal"
    annotation (Placement(transformation(extent={{100,20},{140,60}})));
  CDL.Interfaces.RealOutput yPumSpe "Chilled water pump speed signal"
    annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  CDL.Interfaces.RealOutput yBypValPos "Bypass valve position signal"
    annotation (Placement(transformation(extent={{100,-60},{140,-20}})));

  SecondaryPumps.Controller secPumCon(
    nPum=nPum,
    nVal=nVal,                        nSen=1,
    minPumSpe=minPumSpe,
    maxPumSpe=maxPumSpe,
    speLim=speLim,
    speLim1=speLim1,
    speLim2=speLim2,
    timPer1=timPer1,
    timPer2=timPer2,
    timPer3=timPer3,
    k=kPumSpe,
    Ti=TiPumSpe,
    Td=TdPumSpe)
    annotation (Placement(transformation(extent={{0,20},{20,40}})));
  SetPoints.ChilledWaterStaticPressureSetpointReset chiWatStaPreSetRes(
    nVal=nVal,
    nPum=nPum,
    valPosLowClo=valPosLowClo,
    valPosLowOpe=valPosLowOpe,
    valPosHigClo=valPosHigClo,
    valPosHigOpe=valPosHigOpe,
    chiWatStaPreMax=chiWatStaPreMax,
    chiWatStaPreMin=chiWatStaPreMin,
    triAmoVal=triAmoVal,
    resAmoVal=resAmoVal,
    maxResVal=maxResVal,
    samPerVal=samPerVal,
    delTimVal=delTimVal,
    thrTimLow=thrTimLow,
    thrTimHig=thrTimHig)
    annotation (Placement(transformation(extent={{-40,-70},{-20,-50}})));
  SetPoints.BypassValvePosition bypValPos(
    nPum=nPum,
    minPumSpe=minPumSpe,
    dPumSpe=dPumSpe,
    dPChiWatMax=dPChiWatMax,
    k=kBypVal,
    Ti=TiBypVal,
    Td=TdBypVal,
    controllerType=controllerTypeBypVal)
    annotation (Placement(transformation(extent={{40,-40},{60,-20}})));

  CDL.Integers.Sources.Constant conInt[nPum](k=pumStaOrd)
    "Constant integer source"
    annotation (Placement(transformation(extent={{-80,50},{-60,70}})));

equation
  connect(chiWatStaPreSetRes.yStaPreSetPoi, secPumCon.dpChiWatSet) annotation (
      Line(points={{-18,-60},{-10,-60},{-10,22},{-2,22}}, color={0,0,127}));
  connect(uPumSta, bypValPos.uPumSta) annotation (Line(points={{-120,40},{-50,40},
          {-50,-25},{38,-25}},
                            color={255,0,255}));
  connect(uPumSta, secPumCon.uChiWatPum) annotation (Line(points={{-120,40},{-50,
          40},{-50,34},{-2,34}},     color={255,0,255}));
  connect(uPumSta, chiWatStaPreSetRes.uPumSta) annotation (Line(points={{-120,40},
          {-50,40},{-50,-55},{-42,-55}},   color={255,0,255}));
  connect(conInt.y, secPumCon.uPumLeaLag) annotation (Line(points={{-58,60},{-40,
          60},{-40,38},{-2,38}},     color={255,127,0}));
  connect(secPumCon.yPumSpe, bypValPos.uPumSpe) annotation (Line(points={{22,28},
          {30,28},{30,-30},{38,-30}},
                                    color={0,0,127}));
  connect(dPChiWatLoo, bypValPos.dpChiWatLoo) annotation (Line(points={{-120,0},
          {-90,0},{-90,-35},{38,-35}},color={0,0,127}));
  connect(dPChiWatLoo, secPumCon.dpChiWat_remote[1]) annotation (Line(points={{-120,0},
          {-90,0},{-90,20},{-20,20},{-20,26},{-2,26}},           color={0,0,127}));
  connect(uValPos, secPumCon.uValPos) annotation (Line(points={{-120,-40},{-60,-40},
          {-60,30},{-2,30}},                   color={0,0,127}));
  connect(uValPos, chiWatStaPreSetRes.uValPos) annotation (Line(points={{-120,-40},
          {-60,-40},{-60,-65},{-42,-65}},
                                        color={0,0,127}));
  connect(secPumCon.yChiWatPum, yChiWatPum) annotation (Line(points={{22,32},{30,
          32},{30,40},{120,40}}, color={255,0,255}));
  connect(secPumCon.yPumSpe, yPumSpe) annotation (Line(points={{22,28},{30,28},{
          30,0},{120,0}}, color={0,0,127}));
  connect(bypValPos.yBypValPos, yBypValPos) annotation (Line(points={{62,-30},{80,
          -30},{80,-40},{120,-40}}, color={0,0,127}));
  annotation (defaultComponentName="sysCon",
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Text(
          extent={{-120,160},{114,108}},
          textString="%name",
          lineColor={0,0,255}),
                 Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid)}),              Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SystemController;
