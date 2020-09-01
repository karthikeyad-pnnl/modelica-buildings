within Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.SecondaryPumps.Validation;
model Controller
    "Validate boiler water pump control sequence"

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.SecondaryPumps.Controller
    priPumCon(
    final variableSecondary=true,
    final secondaryFlowSensor=true,
    final nPum=2,
    final nPumPri=2,
    final nBoi=2,
    final nSen=2,
    final nPum_nominal=2,
    final minPumSpe=0.1,
    final maxPumSpe=1,
    final VHotWat_flow_nominal=0.5,
    final maxLocDp=5*6894.75,
    final minLocDp=5*6894.75,
    final offTimThr=180,
    final timPer=600,
    final staCon=-0.03,
    final relFloHys=0.01,
    final k=1,
    final Ti=10,
    final Td=0.1,
    final speedControlType=Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Types.SecondaryPumpSpeedControlTypes.remoteDP)
    "Testing pump configuration 1"
    annotation (Placement(transformation(extent={{-160,140},{-140,180}})));

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.SecondaryPumps.Controller
    priPumCon1(
    final variableSecondary=true,
    final secondaryFlowSensor=true,
    final nPum=2,
    final nPumPri=2,
    final nBoi=2,
    final nSen=2,
    final nPum_nominal=2,
    final minPumSpe=0.1,
    final maxPumSpe=1,
    final VHotWat_flow_nominal=0.5,
    final maxLocDp=10,
    final minLocDp=5,
    final offTimThr=180,
    final timPer=600,
    final staCon=-0.03,
    final relFloHys=0.01,
    final k=1,
    final Ti=0.5,
    final Td=0.1,
    final speedControlType=Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Types.SecondaryPumpSpeedControlTypes.localDP)
    "Testing pump configuration 2"
    annotation (Placement(transformation(extent={{200,130},{220,170}})));

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.SecondaryPumps.Controller
    priPumCon2(
    final variableSecondary=true,
    final secondaryFlowSensor=false,
    final nPum=2,
    final nPumPri=2,
    final nBoi=2,
    final nSen=2,
    final nPum_nominal=2,
    final minPumSpe=0.1,
    final maxPumSpe=1,
    final VHotWat_flow_nominal=0.5,
    final speLim=0.9,
    final speLim1=0.99,
    final speLim2=0.4,
    final timPer1=300,
    final timPer2=60,
    final timPer3=600,
    final maxLocDp=10,
    final minLocDp=5,
    final offTimThr=180,
    final timPer=600,
    final staCon=-0.03,
    final relFloHys=0.01,
    final k=1,
    final Ti=0.5,
    final Td=0.1,
    final speedControlType=Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Types.SecondaryPumpSpeedControlTypes.remoteDP)
    "Testing pump configuration 3"
    annotation (Placement(transformation(extent={{-160,-10},{-140,30}})));

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.SecondaryPumps.Controller
    priPumCon3(
    final variableSecondary=true,
    final secondaryFlowSensor=false,
    final nPum=2,
    final nPumPri=2,
    final nBoi=2,
    final nSen=2,
    final nPum_nominal=2,
    final minPumSpe=0.1,
    final maxPumSpe=1,
    final VHotWat_flow_nominal=0.5,
    final speLim=0.9,
    final speLim1=0.99,
    final speLim2=0.4,
    final timPer1=300,
    final timPer2=60,
    final timPer3=600,
    final maxLocDp=10,
    final minLocDp=5,
    final offTimThr=180,
    final timPer=600,
    final staCon=-0.03,
    final relFloHys=0.01,
    final k=1,
    final Ti=0.5,
    final Td=0.1,
    final speedControlType=Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Types.SecondaryPumpSpeedControlTypes.localDP)
    "Testing pump configuration 4"
    annotation (Placement(transformation(extent={{200,-30},{220,10}})));

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.SecondaryPumps.Controller
    priPumCon4(
    final variableSecondary=false,
    final nPum=2,
    final nPumPri=2,
    final nBoi=2,
    final nSen=2,
    final nPum_nominal=2,
    final minPumSpe=0.1,
    final maxPumSpe=1,
    final VHotWat_flow_nominal=0.5,
    final maxLocDp=10,
    final minLocDp=5,
    final offTimThr=180,
    final timPer=600,
    final staCon=-0.03,
    final relFloHys=0.01,
    final k=1,
    final Ti=0.5,
    final Td=0.1)
    "Testing pump configuration 5"
    annotation (Placement(transformation(extent={{-160,-170},{-140,-130}})));

  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse booPul(
    final width=1,
    final period=3600,
    final startTime=10)
    "Boolean pulse"
    annotation (Placement(transformation(extent={{-320,190},{-300,210}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.Pulse pul(
    final amplitude=2,
    final width=1,
    final period=3500,
    final nperiod=1,
    final offset=0,
    final startTime=0)
    "Real pulse"
    annotation (Placement(transformation(extent={{-330,150},{-310,170}})));

  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToInt
    "Real to Integer conversion"
    annotation (Placement(transformation(extent={{-300,150},{-280,170}})));

  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse booPul1(
    final width=1,
    final period=3600,
    final startTime=10)
    "Boolean pulse"
    annotation (Placement(transformation(extent={{50,200},{70,220}})));

  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToInt1
    "Real to Integer conversion"
    annotation (Placement(transformation(extent={{70,160},{90,180}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.Pulse pul1(
    final amplitude=2,
    final width=1,
    final period=3500,
    final nperiod=1,
    final offset=0,
    final startTime=0)
    "Real pulse"
    annotation (Placement(transformation(extent={{40,160},{60,180}})));

  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse booPul2(
    final width=1,
    final period=3600,
    final startTime=10)
    "Boolean pulse"
    annotation (Placement(transformation(extent={{-310,60},{-290,80}})));

  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToInt2
    "Real to Integer conversion"
    annotation (Placement(transformation(extent={{-290,20},{-270,40}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.Pulse pul2(
    final amplitude=2,
    final width=1,
    final period=3500,
    final nperiod=1,
    final offset=0,
    final startTime=0)
    "Real pulse"
    annotation (Placement(transformation(extent={{-320,20},{-300,40}})));

  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse booPul3(
    final width=1,
    final period=3600,
    final startTime=10)
    "Boolean pulse"
    annotation (Placement(transformation(extent={{40,50},{60,70}})));

  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToInt3
    "Real to Integer conversion"
    annotation (Placement(transformation(extent={{60,10},{80,30}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.Pulse pul3(
    final amplitude=2,
    final width=1,
    final period=3500,
    final nperiod=1,
    final offset=0,
    final startTime=0)
    "Real pulse"
    annotation (Placement(transformation(extent={{30,10},{50,30}})));

  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse booPul4(
    final width=1,
    final period=3600,
    final startTime=10)
    "Boolean pulse"
    annotation (Placement(transformation(extent={{-300,-120},{-280,-100}})));

  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToInt4
    "Real to Integer conversion"
    annotation (Placement(transformation(extent={{-280,-160},{-260,-140}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.Pulse pul4(
    final amplitude=2,
    final width=1,
    final period=3500,
    final nperiod=1,
    final offset=0,
    final startTime=0)
    "Real pulse"
    annotation (Placement(transformation(extent={{-310,-160},{-290,-140}})));

  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse booPul5(
    final width=0.5,
    final period=900,
    final startTime=60)
    "Boolean pulse"
    annotation (Placement(transformation(extent={{-300,-200},{-280,-180}})));

  CDL.Continuous.Sources.Pulse                        pul5(
    final amplitude=0.6,
    final width=0.5,
    final period=3600,
    final nperiod=1,
    final offset=0.35,
    final startTime=0)
    "Real pulse"
    annotation (Placement(transformation(extent={{-320,100},{-300,120}})));
  CDL.Continuous.Sources.Pulse                        pul6(
    final amplitude=0.6,
    final width=0.5,
    final period=3600,
    final nperiod=1,
    final offset=0.35,
    final startTime=0)
    "Real pulse"
    annotation (Placement(transformation(extent={{60,90},{80,110}})));
  CDL.Continuous.Sources.Pulse                        pul7(
    final amplitude=0.6,
    final width=0.5,
    final period=3600,
    final nperiod=1,
    final offset=0.35,
    final startTime=0)
    "Real pulse"
    annotation (Placement(transformation(extent={{-300,-50},{-280,-30}})));
  CDL.Continuous.Sources.Pulse                        pul8(
    final amplitude=0.6,
    final width=0.5,
    final period=3600,
    final nperiod=1,
    final offset=0.35,
    final startTime=0)
    "Real pulse"
    annotation (Placement(transformation(extent={{80,-90},{100,-70}})));
protected
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt[2](
    final k={2,1})
    "Pump rotation"
    annotation (Placement(transformation(extent={{-210,200},{-190,220}})));

  Buildings.Controls.OBC.CDL.Logical.Pre pre1[2](
    final pre_u_start=fill(false, 2))
    "Logical pre block"
    annotation (Placement(transformation(extent={{-120,150},{-100,170}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.Sine sin[2](
    final amplitude=0.5,
    final freqHz=1/1800,
    final offset=1)
    "Sine signal"
    annotation (Placement(transformation(extent={{-260,120},{-240,140}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.Sine sin1(
    final amplitude=0.1,
    final freqHz=1/3600,
    final offset=0.25)
    "Sine signal"
    annotation (Placement(transformation(extent={{-260,150},{-240,170}})));

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt1[2](
    final k={2,1})
    "Pump rotation"
    annotation (Placement(transformation(extent={{150,190},{170,210}})));

  Buildings.Controls.OBC.CDL.Logical.Pre pre2[2](
    final pre_u_start=fill(false, 2))
    "Logical pre block"
    annotation (Placement(transformation(extent={{240,140},{260,160}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.Sine sin2[2](
    final amplitude=0.5,
    final freqHz=1/1800,
    final offset=1)
    "Sine signal"
    annotation (Placement(transformation(extent={{80,130},{100,150}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.Sine sin3(
    final amplitude=0.1,
    final freqHz=1/3600,
    final offset=0.25)
    "Sine signal"
    annotation (Placement(transformation(extent={{40,130},{60,150}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.Sine sin4(
    final amplitude=5,
    final freqHz=1/900,
    final offset=7.5)
    "Sine signal"
    annotation (Placement(transformation(extent={{160,70},{180,90}})));

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt2[2](
    final k={2,1})
    "Pump rotation"
    annotation (Placement(transformation(extent={{-210,50},{-190,70}})));

  Buildings.Controls.OBC.CDL.Logical.Pre pre3[2](
    final pre_u_start=fill(false, 2))
    "Logical pre block"
    annotation (Placement(transformation(extent={{-120,0},{-100,20}})));

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt3[2](
    final k={2,1})
    "Pump rotation"
    annotation (Placement(transformation(extent={{150,30},{170,50}})));

  Buildings.Controls.OBC.CDL.Logical.Pre pre4[2](
    final pre_u_start=fill(false, 2))
    "Logical pre block"
    annotation (Placement(transformation(extent={{240,-20},{260,0}})));

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt4[2](
    final k={2,1})
    "Pump rotation"
    annotation (Placement(transformation(extent={{-210,-110},{-190,-90}})));

  Buildings.Controls.OBC.CDL.Logical.Pre pre5[2](
    final pre_u_start=fill(false, 2))
    "Logical pre block"
    annotation (Placement(transformation(extent={{-120,-160},{-100,-140}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con1(
    final k=1)
    "Constant Real source"
    annotation (Placement(transformation(extent={{-250,200},{-230,220}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con3(
    final k=1)
    "Constant Real source"
    annotation (Placement(transformation(extent={{120,110},{140,130}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant                        con4(
    final k=1)
    "Constant Real source"
    annotation (Placement(transformation(extent={{-260,0},{-240,20}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.Sine                        sin6
                                                        [2](
    final amplitude=0.5,
    final freqHz=1/1800,
    final offset=1)
    "Sine signal"
    annotation (Placement(transformation(extent={{-260,-30},{-240,-10}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.Sine                        sin5(
    final amplitude=5,
    final freqHz=1/900,
    final offset=7.5)
    "Sine signal"
    annotation (Placement(transformation(extent={{80,-20},{100,0}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.Sine                        sin7[2](
    final amplitude=0.5,
    final freqHz=1/1800,
    final offset=1)
    "Sine signal"
    annotation (Placement(transformation(extent={{120,-40},{140,-20}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant                        con6(
    final k=1)
    "Constant Real source"
    annotation (Placement(transformation(extent={{120,-70},{140,-50}})));

equation
  connect(conInt.y, priPumCon.uPumLeaLag) annotation (Line(points={{-188,210},{-170,
          210},{-170,178.2},{-162,178.2}},
                                       color={255,127,0}));

  connect(priPumCon.yHotWatPum, pre1.u)
    annotation (Line(points={{-138,160},{-122,160}}, color={255,0,255}));

  connect(sin1.y, priPumCon.VHotWat_flow) annotation (Line(points={{-238,160},{-184,
          160},{-184,162},{-162,162}},                       color={0,0,127}));

  connect(sin.y, priPumCon.dpHotWat_remote) annotation (Line(points={{-238,130},
          {-176,130},{-176,150},{-162,150}}, color={0,0,127}));

  connect(conInt1.y, priPumCon1.uPumLeaLag) annotation (Line(points={{172,200},{
          190,200},{190,168.2},{198,168.2}},
                                         color={255,127,0}));

  connect(priPumCon1.yHotWatPum, pre2.u)
    annotation (Line(points={{222,150},{238,150}}, color={255,0,255}));

  connect(sin3.y, priPumCon1.VHotWat_flow) annotation (Line(points={{62,140},{
          70,140},{70,156},{160,156},{160,152},{198,152}},
                                                         color={0,0,127}));

  connect(sin2.y, priPumCon1.dpHotWat_remote) annotation (Line(points={{102,140},
          {198,140}},                     color={0,0,127}));

  connect(sin4.y, priPumCon1.dpHotWat_local) annotation (Line(points={{182,80},{
          194,80},{194,144},{198,144}},   color={0,0,127}));

  connect(conInt2.y,priPumCon2. uPumLeaLag) annotation (Line(points={{-188,60},{
          -170,60},{-170,28.2},{-162,28.2}},
                                         color={255,127,0}));

  connect(priPumCon2.yHotWatPum,pre3. u)
    annotation (Line(points={{-138,10},{-122,10}}, color={255,0,255}));

  connect(conInt3.y,priPumCon3. uPumLeaLag) annotation (Line(points={{172,40},{190,
          40},{190,8.2},{198,8.2}},      color={255,127,0}));

  connect(priPumCon3.yHotWatPum,pre4. u)
    annotation (Line(points={{222,-10},{238,-10}}, color={255,0,255}));

  connect(conInt4.y,priPumCon4. uPumLeaLag) annotation (Line(points={{-188,-100},
          {-170,-100},{-170,-131.8},{-162,-131.8}},
                                         color={255,127,0}));

  connect(priPumCon4.yHotWatPum,pre5. u)
    annotation (Line(points={{-138,-150},{-122,-150}},
                                                   color={255,0,255}));

  connect(con1.y, priPumCon.dpHotWatSet) annotation (Line(points={{-228,210},{-224,
          210},{-224,146},{-162,146}},      color={0,0,127}));

  connect(pre1.y, priPumCon.uHotWatPum) annotation (Line(points={{-98,160},{-90,
          160},{-90,200},{-174,200},{-174,174},{-162,174}},       color={255,0,
          255}));

  connect(pre2.y, priPumCon1.uHotWatPum) annotation (Line(points={{262,150},{282,
          150},{282,220},{120,220},{120,164},{198,164}},     color={255,0,255}));

  connect(con3.y, priPumCon1.dpHotWatSet) annotation (Line(points={{142,120},{170,
          120},{170,136},{198,136}},     color={0,0,127}));

  connect(pre3.y, priPumCon2.uHotWatPum) annotation (Line(points={{-98,10},{-90,
          10},{-90,78},{-220,78},{-220,24},{-162,24}},          color={255,0,
          255}));

  connect(pre4.y, priPumCon3.uHotWatPum) annotation (Line(points={{262,-10},{270,
          -10},{270,60},{140,60},{140,4},{198,4}},           color={255,0,255}));

  connect(pre5.y, priPumCon4.uHotWatPum) annotation (Line(points={{-98,-150},{-90,
          -150},{-90,-80},{-220,-80},{-220,-136},{-162,-136}},   color={255,0,
          255}));

  connect(sin6.y, priPumCon2.dpHotWat_remote) annotation (Line(points={{-238,-20},
          {-180,-20},{-180,0},{-162,0}},      color={0,0,127}));

  connect(con4.y, priPumCon2.dpHotWatSet) annotation (Line(points={{-238,10},{-200,
          10},{-200,-4},{-162,-4}},    color={0,0,127}));

  connect(sin5.y, priPumCon3.dpHotWat_local) annotation (Line(points={{102,-10},
          {180,-10},{180,-16},{198,-16}},
                                       color={0,0,127}));

  connect(sin7.y, priPumCon3.dpHotWat_remote) annotation (Line(points={{142,-30},
          {148,-30},{148,-20},{198,-20}}, color={0,0,127}));

  connect(con6.y, priPumCon3.dpHotWatSet) annotation (Line(points={{142,-60},{154,
          -60},{154,-24},{198,-24}},     color={0,0,127}));

  connect(booPul.y, priPumCon.uPlaEna) annotation (Line(points={{-298,200},{-260,
          200},{-260,190},{-180,190},{-180,170},{-162,170}}, color={255,0,255}));

  connect(reaToInt.u, pul.y)
    annotation (Line(points={{-302,160},{-308,160}}, color={0,0,127}));

  connect(reaToInt.y, priPumCon.supResReq) annotation (Line(points={{-278,160},{
          -270,160},{-270,180},{-186,180},{-186,166},{-162,166}},     color={255,
          127,0}));

  connect(booPul1.y, priPumCon1.uPlaEna) annotation (Line(points={{72,210},{140,
          210},{140,160},{198,160}}, color={255,0,255}));

  connect(pul1.y, reaToInt1.u)
    annotation (Line(points={{62,170},{68,170}}, color={0,0,127}));

  connect(reaToInt1.y, priPumCon1.supResReq) annotation (Line(points={{92,170},
          {164,170},{164,156},{198,156}},    color={255,127,0}));

  connect(booPul2.y, priPumCon2.uPlaEna) annotation (Line(points={{-288,70},{-224,
          70},{-224,20},{-162,20}}, color={255,0,255}));

  connect(pul2.y, reaToInt2.u)
    annotation (Line(points={{-298,30},{-292,30}}, color={0,0,127}));

  connect(reaToInt2.y, priPumCon2.supResReq) annotation (Line(points={{-268,30},
          {-228,30},{-228,16},{-162,16}},     color={255,127,0}));

  connect(booPul3.y, priPumCon3.uPlaEna) annotation (Line(points={{62,60},{134,60},
          {134,0},{198,0}}, color={255,0,255}));

  connect(pul3.y, reaToInt3.u)
    annotation (Line(points={{52,20},{58,20}}, color={0,0,127}));

  connect(reaToInt3.y, priPumCon3.supResReq) annotation (Line(points={{82,20},{128,
          20},{128,-4},{198,-4}},     color={255,127,0}));

  connect(booPul4.y, priPumCon4.uPlaEna) annotation (Line(points={{-278,-110},{-224,
          -110},{-224,-140},{-162,-140}}, color={255,0,255}));

  connect(pul4.y, reaToInt4.u)
    annotation (Line(points={{-288,-150},{-282,-150}}, color={0,0,127}));

  connect(reaToInt4.y, priPumCon4.supResReq) annotation (Line(points={{-258,-150},
          {-240,-150},{-240,-144},{-162,-144}},     color={255,127,0}));

  connect(booPul4.y, priPumCon4.uPriPumSta[1]) annotation (Line(points={{-278,-110},
          {-224,-110},{-224,-153},{-162,-153}},     color={255,0,255}));

  connect(booPul5.y, priPumCon4.uPriPumSta[2]) annotation (Line(points={{-278,-190},
          {-230,-190},{-230,-151},{-162,-151}},     color={255,0,255}));

  connect(pul5.y, priPumCon.uMaxSecPumSpeCon) annotation (Line(points={{-298,
          110},{-170,110},{-170,142},{-162,142}}, color={0,0,127}));
  connect(pul6.y, priPumCon1.uMaxSecPumSpeCon) annotation (Line(points={{82,100},
          {186,100},{186,132},{198,132}}, color={0,0,127}));
  connect(pul7.y, priPumCon2.uMaxSecPumSpeCon) annotation (Line(points={{-278,
          -40},{-170,-40},{-170,-8},{-162,-8}}, color={0,0,127}));
  connect(pul8.y, priPumCon3.uMaxSecPumSpeCon) annotation (Line(points={{102,
          -80},{190,-80},{190,-28},{198,-28}}, color={0,0,127}));
annotation (
  experiment(
      StopTime=3600,
      Interval=0.5,
      Tolerance=1e-06,
      __Dymola_Algorithm="Cvode"),
  __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Controls/OBC/ASHRAE/PrimarySystem/BoilerPlant/Pumps/PrimaryPumps/Validation/Controller.mos"
    "Simulate and plot"),
  Documentation(info="<html>
<p>
This example validates
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.PrimaryPumps.Controller\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.PrimaryPumps.Controller</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
August 21, 2020, by Karthik Devaprasad:<br/>
First implementation.
</li>
</ul>
</html>"),
  Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                         graphics={
        Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent = {{-100,-100},{100,100}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points = {{-36,60},{64,0},{-36,-60},{-36,60}})}), Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-340,-300},{340,300}})));
end Controller;
