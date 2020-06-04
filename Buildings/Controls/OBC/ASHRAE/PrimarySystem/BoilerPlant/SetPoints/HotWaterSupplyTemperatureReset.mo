within Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.SetPoints;
block HotWaterSupplyTemperatureReset
  "Block to calculate hot-water setpoint for hot water supply temperature"

  parameter Integer nPum = 2
    "Number of pumps in the boiler plant loop"
    annotation(Dialog(group="Plant parameters"));

  parameter Integer nSta = 3
    "Number of stages in the boiler plant"
    annotation(Dialog(group="Plant parameters"));

  parameter Integer nBoi = 2
    "Number of boilers in the plant"
    annotation(Dialog(group="Plant parameters"));

  parameter Integer nHotWatResReqIgn = 2
    "Number of hot-water supply temperature reset requests to be ignored"
    annotation(Dialog(group="Trim-and-Respond Logic parameters"));

  parameter Real boiTyp[nBoi]={
    Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Types.BoilerTypes.condensingBoiler,
    Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Types.BoilerTypes.condensingBoiler}
    "Boiler type vector"
    annotation(Dialog(group="Plant parameters"));

  parameter Real TPlaHotWatSetMax(
    final unit="K",
    final displayUnit="K",
    final quantity="ThermodynamicTemperature") = 353.15
    "The maximum allowed hot-water setpoint temperature for the plant"
    annotation(Dialog(group="Trim-and-Respond Logic parameters"));

  parameter Real TConBoiHotWatSetMax(
    final unit="K",
    final displayUnit="K",
    final quantity="ThermodynamicTemperature") = 353.15
    "The maximum allowed hot water setpoint temperature for condensing boilers"
    annotation(Dialog(group="Trim-and-Respond Logic parameters"));

  parameter Real TConBoiHotWatSetOff(
    final unit="K",
    final displayUnit="K",
    final quantity="TemperatureDifference") = -10
    "The offset for hot water setpoint temperature for condensing boilers in 
    non-condensing stage type"
    annotation(Dialog(group="Plant parameters"));

  parameter Real THotWatSetMinNonConBoi(
    final unit="K",
    final displayUnit="K",
    final quantity="ThermodynamicTemperature") = 341.48
    "The minimum allowed hot-water setpoint temperature for non-condensing boilers"
    annotation(Dialog(group="Trim-and-Respond Logic parameters"));

  parameter Real THotWatSetMinConBoi(
    final unit="K",
    final displayUnit="K",
    final quantity="ThermodynamicTemperature") = 305.37
    "The minimum allowed hot-water setpoint temperature for condensing boilers"
    annotation(Dialog(group="Trim-and-Respond Logic parameters"));

  parameter Real delTimVal(
    final unit="s",
    final displayUnit="s",
    final quantity="Time") = 600
    "Delay time"
    annotation(Dialog(group="Trim-and-Respond Logic parameters"));

  parameter Real samPerVal(
    final unit="s",
    final displayUnit="s",
    final quantity="Time") = 300
    "Sample period"
    annotation(Dialog(group="Trim-and-Respond Logic parameters"));

  parameter Real triAmoVal(
    final unit="K",
    final displayUnit="K",
    final quantity="TemperatureDifference") = -2
    "Setpoint trim value"
    annotation(Dialog(group="Trim-and-Respond Logic parameters"));

  parameter Real resAmoVal(
    final unit="K",
    final displayUnit="K",
    final quantity="TemperatureDifference") = 3
    "Setpoint respond value"
    annotation(Dialog(group="Trim-and-Respond Logic parameters"));

  parameter Real maxResVal(
    final unit="K",
    final displayUnit="K",
    final quantity="TemperatureDifference") = 7
    "Setpoint maximum respond value"
    annotation(Dialog(group="Trim-and-Respond Logic parameters"));

  parameter Real holTimVal(
    final unit="s",
    final displayUnit="s",
    final quantity="Time") = 900
    "Minimum setpoint hold time for stage change process"
    annotation(Dialog(group="Plant parameters"));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uStaCha
    "Signal indicating plant is in the staging process"
    annotation (Placement(transformation(extent={{-180,-20},{-140,20}}),
      iconTransformation(extent={{-140,-20},{-100,20}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uHotWatPumSta[nPum]
    "Status of hot-water pumps"
    annotation (Placement(transformation(extent={{-180,70},{-140,110}}),
      iconTransformation(extent={{-140,60},{-100,100}})));

  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput nHotWatSupResReq
    "Number of hot-water supply temperature reset requests"
    annotation (Placement(transformation(extent={{-180,30},{-140,70}}),
      iconTransformation(extent={{-140,20},{-100,60}})));

  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput uTyp[nSta]
    "Stage type vector for boiler plant"
    annotation (Placement(transformation(extent={{-180,-90},{-140,-50}}),
      iconTransformation(extent={{-140,-60},{-100,-20}})));

  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput uCur
    "Current stage index"
    annotation (Placement(transformation(extent={{-180,-140},{-140,-100}}),
      iconTransformation(extent={{-140,-100},{-100,-60}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealOutput TPlaHotWatSupSet(
    final unit="K",
    final displayUnit="K",
    final quantity="ThermodynamicTemperature")
    "Hot-water supply temperature setpoint for the plant"
    annotation (Placement(transformation(extent={{140,-20},{180,20}}),
      iconTransformation(extent={{100,20},{140,60}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealOutput TBoiHotWatSupSet[nBoi](
    final unit=fill("K",nBoi),
    final displayUnit=fill("K",nBoi),
    final quantity=fill("ThermodynamicTemperature",nBoi))
    "Temperature setpoint vector for boilers"
    annotation (Placement(transformation(extent={{140,-250},{180,-210}}),
      iconTransformation(extent={{100,-60},{140,-20}})));

  Buildings.Controls.OBC.CDL.Logical.Switch swi1 "Select plant setpoint based on stage type"
    annotation (Placement(transformation(extent={{10,60},{30,80}})));

  Buildings.Controls.OBC.CDL.Routing.RealExtractor extIndSig(nin=nSta)
    "Extract stage type for current stage"
    annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));

  Buildings.Controls.OBC.CDL.Conversions.IntegerToReal intToRea[nSta]
    "Integer to Real conversion"
    annotation (Placement(transformation(extent={{-120,-80},{-100,-60}})));

  Buildings.Controls.OBC.CDL.Continuous.GreaterThreshold greThr(
    final threshold=Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Types.BoilerTypes.condensingBoiler)
    "Check for non-condensing stage type"
    annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));

  Buildings.Controls.OBC.ASHRAE.G36_PR1.Generic.SetPoints.TrimAndRespond triRes(
    final iniSet=hotWatSetMax,
    final minSet=hotWatSetMinNonConBoi,
    final maxSet=hotWatSetMax,
    final delTim=delTimVal,
    final samplePeriod=samPerVal,
    final numIgnReq=nHotWatResReqIgn,
    final triAmo=triAmoVal,
    final resAmo=resAmoVal,
    final maxRes=maxResVal)
    "Trim and respond controller for non-condensing stage type"
    annotation (Placement(transformation(extent={{-40,80},{-20,100}})));

  Buildings.Controls.OBC.CDL.Logical.Edge edg "Detect start of stage change process"
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));

  Buildings.Controls.OBC.CDL.Logical.TrueHoldWithReset truHol(duration=holTimVal)
    "Hold setpoint value for duration of stage change"
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));

  Buildings.Controls.OBC.CDL.Discrete.TriggeredSampler triSam
    "Retain last value before stage change initiates"
    annotation (Placement(transformation(extent={{50,40},{70,60}})));

  Buildings.Controls.OBC.CDL.Logical.Switch swi "Logical switch"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));

  Buildings.Controls.OBC.CDL.Logical.MultiOr mulOr(nu=nPum) "Check if any pumps are turned on"
    annotation (Placement(transformation(extent={{-120,80},{-100,100}})));

  Buildings.Controls.OBC.ASHRAE.G36_PR1.Generic.SetPoints.TrimAndRespond                               triRes1(
    final iniSet=hotWatSetMax,
    final minSet=hotWatSetMinConBoi,
    final maxSet=hotWatSetMax,
    final delTim=delTimVal,
    final samplePeriod=samPerVal,
    final numIgnReq=nHotWatResReqIgn,
    final triAmo=triAmoVal,
    final resAmo=resAmoVal,
    final maxRes=maxResVal)
    "Trim and respond controller for condensing stage type"
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant boiTypVec[nBoi](k=boiTyp)
                                                  "Boiler type vector"
    annotation (Placement(transformation(extent={{-120,-260},{-100,-240}})));

  Buildings.Controls.OBC.CDL.Integers.GreaterThreshold greThr1[nBoi](threshold=fill(Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Types.BoilerTypes.condensingBoiler,
        nBoi)) "Identify non-condensing boilers in plant"
    annotation (Placement(transformation(extent={{-80,-260},{-60,-240}})));

  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea[nBoi](realTrue=0, realFalse=1)
    "Generate binary vector to identify condensing boilers"
    annotation (Placement(transformation(extent={{-40,-240},{-20,-220}})));

  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea1[nBoi](realTrue=1, realFalse=0)
    "Generate binary vector to identify non-condensing boilers"
    annotation (Placement(transformation(extent={{-40,-280},{-20,-260}})));

  Buildings.Controls.OBC.CDL.Routing.RealReplicator reaRep(nout=nBoi)
    "Convert temperature setpoint into vector"
    annotation (Placement(transformation(extent={{10,-200},{30,-180}})));

  Buildings.Controls.OBC.CDL.Continuous.Product pro[nBoi]
    "Element-wise product"
    annotation (Placement(transformation(extent={{60,-200},{80,-180}})));

  Buildings.Controls.OBC.CDL.Logical.Switch swi2 "Logical Switch"
    annotation (Placement(transformation(extent={{-40,-200},{-20,-180}})));

  Buildings.Controls.OBC.CDL.Continuous.Add add2[nBoi]
    "Combine setpoint vectors for condensing and non-condensing boilers"
    annotation (Placement(transformation(extent={{100,-240},{120,-220}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con(k=TConBoiHotWatSetMax)
    "Design setpoint for condensing boilers"
    annotation (Placement(transformation(extent={{-120,-160},{-100,-140}})));

  Buildings.Controls.OBC.CDL.Continuous.AddParameter addPar(p=TConBoiHotWatSetOff, k=1)
    "Boiler setpoint for condensing boilers in non-condensing type stage"
    annotation (Placement(transformation(extent={{-120,-200},{-100,-180}})));

  Buildings.Controls.OBC.CDL.Continuous.Min min
    "Ensure condensing boiler setpoint does not exceed design setpoint"
    annotation (Placement(transformation(extent={{-80,-180},{-60,-160}})));

  Buildings.Controls.OBC.CDL.Routing.RealReplicator reaRep1(nout=nBoi)
    "Convert temperature setpoint into vector"
    annotation (Placement(transformation(extent={{10,-310},{30,-290}})));

  Buildings.Controls.OBC.CDL.Continuous.Product pro1
                            [nBoi] "Element-wise product"
    annotation (Placement(transformation(extent={{60,-280},{80,-260}})));

equation
  connect(uHotWatPumSta, mulOr.u[1:2]) annotation (Line(points={{-160,90},{-122,
          90}},                   color={255,0,255}));
  connect(mulOr.y, triRes.uDevSta)
    annotation (Line(points={{-98,90},{-60,90},{-60,98},{-42,98}},
                                                           color={255,0,255}));
  connect(truHol.u, uStaCha)
    annotation (Line(points={{-42,-30},{-50,-30},{-50,0},{-160,0}},
                                                   color={255,0,255}));
  connect(edg.u, uStaCha) annotation (Line(points={{-42,0},{-160,0}},
                      color={255,0,255}));
  connect(edg.y, triSam.trigger) annotation (Line(points={{-18,0},{60,0},{60,38.2}},
                  color={255,0,255}));
  connect(triSam.y, swi.u1)
    annotation (Line(points={{72,50},{80,50},{80,8},{98,8}}, color={0,0,127}));
  connect(truHol.y, swi.u2) annotation (Line(points={{-18,-30},{80,-30},{80,0},{
          98,0}}, color={255,0,255}));
  connect(triRes.numOfReq, nHotWatSupResReq) annotation (Line(points={{-42,82},{
          -50,82},{-50,50},{-160,50}},
                                    color={255,127,0}));
  connect(swi.y, TPlaHotWatSupSet)
    annotation (Line(points={{122,0},{160,0}}, color={0,0,127}));
  connect(swi1.y, triSam.u) annotation (Line(points={{32,70},{40,70},{40,50},{48,
          50}}, color={0,0,127}));
  connect(triRes.y, swi1.u1) annotation (Line(points={{-18,90},{0,90},{0,78},{8,
          78}},   color={0,0,127}));
  connect(triRes1.y, swi1.u3)
    annotation (Line(points={{-18,50},{0,50},{0,62},{8,62}}, color={0,0,127}));
  connect(triRes1.numOfReq, nHotWatSupResReq) annotation (Line(points={{-42,42},
          {-50,42},{-50,50},{-160,50}}, color={255,127,0}));
  connect(triRes1.uDevSta, mulOr.y) annotation (Line(points={{-42,58},{-60,58},{
          -60,90},{-98,90}},   color={255,0,255}));
  connect(swi1.y, swi.u3) annotation (Line(points={{32,70},{40,70},{40,-8},{98,-8}},
        color={0,0,127}));
  connect(uCur, extIndSig.index) annotation (Line(points={{-160,-120},{-70,-120},
          {-70,-82}}, color={255,127,0}));
  connect(extIndSig.u, intToRea.y)
    annotation (Line(points={{-82,-70},{-98,-70}}, color={0,0,127}));
  connect(intToRea.u, uTyp)
    annotation (Line(points={{-122,-70},{-160,-70}}, color={255,127,0}));
  connect(extIndSig.y, greThr.u)
    annotation (Line(points={{-58,-70},{-42,-70}}, color={0,0,127}));
  connect(greThr.y, swi1.u2) annotation (Line(points={{-18,-70},{-10,-70},{-10,70},
          {8,70}}, color={255,0,255}));
  connect(boiTypVec.y, greThr1.u)
    annotation (Line(points={{-98,-250},{-82,-250}},  color={0,0,127}));
  connect(booToRea1.u, greThr1.y) annotation (Line(points={{-42,-270},{-50,-270},
          {-50,-250},{-58,-250}}, color={255,0,255}));
  connect(booToRea.u, greThr1.y) annotation (Line(points={{-42,-230},{-50,-230},
          {-50,-250},{-58,-250}}, color={255,0,255}));
  connect(add2.y, TBoiHotWatSupSet)
    annotation (Line(points={{122,-230},{160,-230}}, color={0,0,127}));
  connect(swi2.u2, greThr.y) annotation (Line(points={{-42,-190},{-50,-190},{-50,
          -100},{-10,-100},{-10,-70},{-18,-70}},
                           color={255,0,255}));
  connect(swi2.u3, swi.y) annotation (Line(points={{-42,-198},{-46,-198},{-46,-210},
          {-130,-210},{-130,-130},{130,-130},{130,0},{122,0}},
                                      color={0,0,127}));
  connect(addPar.u, swi.y) annotation (Line(points={{-122,-190},{-130,-190},{-130,
          -130},{130,-130},{130,0},{122,0}}, color={0,0,127}));
  connect(min.u1, con.y) annotation (Line(points={{-82,-164},{-90,-164},{-90,-150},
          {-98,-150}}, color={0,0,127}));
  connect(min.u2, addPar.y) annotation (Line(points={{-82,-176},{-90,-176},{-90,
          -190},{-98,-190}}, color={0,0,127}));
  connect(min.y, swi2.u1) annotation (Line(points={{-58,-170},{-46,-170},{-46,-182},
          {-42,-182}}, color={0,0,127}));
  connect(swi2.y, reaRep.u)
    annotation (Line(points={{-18,-190},{8,-190}},color={0,0,127}));
  connect(pro.u1, reaRep.y) annotation (Line(points={{58,-184},{50,-184},{50,-190},
          {32,-190}}, color={0,0,127}));
  connect(reaRep1.u, swi.y) annotation (Line(points={{8,-300},{-130,-300},{-130,
          -130},{130,-130},{130,0},{122,0}}, color={0,0,127}));
  connect(booToRea.y, pro.u2) annotation (Line(points={{-18,-230},{50,-230},{50,
          -196},{58,-196}}, color={0,0,127}));
  connect(pro.y, add2.u1) annotation (Line(points={{82,-190},{90,-190},{90,-224},
          {98,-224}}, color={0,0,127}));
  connect(reaRep1.y, pro1.u2) annotation (Line(points={{32,-300},{50,-300},{50,-276},
          {58,-276}}, color={0,0,127}));
  connect(booToRea1.y, pro1.u1) annotation (Line(points={{-18,-270},{50,-270},{50,
          -264},{58,-264}}, color={0,0,127}));
  connect(pro1.y, add2.u2) annotation (Line(points={{82,-270},{90,-270},{90,-236},
          {98,-236}}, color={0,0,127}));
  annotation(defaultComponentName="hotWatSupTemRes",
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-140,
            -320},{140,120}})),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                                                                                graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-50,20},{50,-20}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.None,
          textString="hotWatSupTemRes"),
          Text(
          extent={{-100,150},{100,110}},
          lineColor={0,0,255},
          textString="%name")}),
  Documentation(info="<html>
<p>
Control sequence for hot-water supply temperature setpoint <code>hotWatSupTemSet</code>
for boiler plant loop.
</p>
<h4>Boiler plant loop: Control of hot-water supply temperature setpoint</h4>
<ol>
<li>The setpoint controller is enabled when any of the hot-water supply pumps
are proven on <code>uHotWatPumSta = true</code>, and disabled otherwise.</li>
<li>When enabled, a Trim-and-Respond logic controller reduces the supply
temperature setpoint <code>THotWatSupSet</code> till it receives a sufficient
number of heating hot-water requests <code>nHotWatSupResReq</code> and resets the
supply temperature setpoint to the initial value <code>hotWatSetMax</code>.
</li>
</ol>
</html>", revisions="<html>
<ul>
<li>
February 23, 2020, by Karthik Devaprasad:<br/>
First implementation.
</li>
</ul>
</html>"));
end HotWaterSupplyTemperatureReset;
