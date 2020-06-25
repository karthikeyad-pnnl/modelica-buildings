within Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Staging.SetPoints.Validation;
model SetpointController
  "Validates chiller stage status setpoint signal generation for plants with WSE"

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Staging.SetPoints.SetpointController staSetCon(
    final primaryOnly=false,
    final nBoi=2,
    final boiTyp={Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Types.BoilerTypes.condensingBoiler,
        Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Types.BoilerTypes.nonCondensingBoiler},
    final nSta=3,
    final staMat=[1,0; 0,1; 1,1],
    final iniSta=1,
    final boiDesCap={500000,700000},
    final boiFirMin={0.2,0.4},
    final delStaCha=900,
    final avePer=300,
    final fraNonConBoi=0.9,
    final fraConBoi=1.5,
    final delEffCon=600,
    final TDif=10,
    final delFaiCon=900,
    final sigDif=0.1,
    final TDifHys=1,
    final fraMinFir=1.1,
    final delMinFir=300,
    final fraDesCap=0.8,
    final delDesCapNonConBoi=600,
    final delDesCapConBoi=300,
    final TCirDif=3,
    final delTRetDif=300,
    final dTemp=0.1,
    final boiMinCap={100000,200000})
    "Boiler stage setpoint controller"
    annotation (Placement(transformation(extent={{60,140},{80,160}})));

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Staging.SetPoints.SetpointController staSetCon1(
    final nSta=4,
    final staMat={{1,0,0},{0,1,0},{1,1,0},{1,1,1}},
    final chiDesCap={300000,400000,500000},
    final chiMinCap={50000,100000,150000},
    final chiTyp={Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Types.ChillerAndStageTypes.positiveDisplacement,
        Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Types.ChillerAndStageTypes.positiveDisplacement,
        Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Types.ChillerAndStageTypes.constantSpeedCentrifugal})
    "Chiller stage setpoint controller"
    annotation (Placement(transformation(extent={{60,-100},{80,-80}})));

protected
  parameter Modelica.SIunits.Temperature TChiWatSupSet = 285.15
  "Chilled water supply set temperature";

  parameter Modelica.SIunits.Temperature aveTChiWatRet = 288.15
  "Average measured chilled water return temperature";

  parameter Modelica.SIunits.Time minStaRuntime = 900
    "Minimum stage runtime";

  parameter Modelica.SIunits.VolumeFlowRate aveVChiWat_flow = 0.05
    "Average measured chilled water flow rate";

  Buildings.Controls.OBC.CDL.Continuous.Sources.Sine TChiWatRet(
    final amplitude=7,
    final offset=273.15 + 15,
    final freqHz=1/21600)
    "Chiller water return temeprature"
    annotation (Placement(transformation(extent={{-200,140},{-180,160}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.Sine chiWatFlow(
    final offset=0,
    final freqHz=1/21600,
    final amplitude=0.037)
    "Chilled water flow"
    annotation (Placement(transformation(extent={{-200,100},{-180,120}})));

  Buildings.Controls.OBC.CDL.Logical.Sources.Constant chiAva[2](
    final k={true,true})
    "Chiller availability vector"
    annotation (Placement(transformation(extent={{-52,16},{-32,36}})));

  Buildings.Controls.OBC.CDL.Continuous.Max max "Maximum"
    annotation (Placement(transformation(extent={{-160,100},{-140,120}})));

  Buildings.Controls.OBC.CDL.Discrete.ZeroOrderHold zerOrdHol(
    final samplePeriod=10)
    annotation (Placement(transformation(extent={{140,140},{160,160}})));

  Buildings.Controls.OBC.CDL.Conversions.IntegerToReal intToRea
    annotation (Placement(transformation(extent={{98,148},{118,168}})));

  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToInt
    annotation (Placement(transformation(extent={{180,140},{200,160}})));

  Buildings.Controls.OBC.CDL.Logical.TrueFalseHold truFalHol(
    final trueHoldDuration=0,
    final falseHoldDuration=900)
    annotation (Placement(transformation(extent={{100,60},{120,80}})));

  Buildings.Controls.OBC.CDL.Logical.Pre pre
    annotation (Placement(transformation(extent={{140,60},{160,80}})));

  Buildings.Controls.OBC.CDL.Logical.Sources.Constant plaSta(
    final k=true)
    "Plant status"
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));

  Buildings.Controls.OBC.CDL.Logical.TrueDelay truDel(
    final delayTime=10,
    final delayOnInit=true)
    annotation (Placement(transformation(extent={{-20,60},{0,80}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.Ramp TCWSup(
    final height=-2.1,
    final duration=300,
    final offset=273.15 + 16,
    final startTime=1500) "Chilled water supply temperature ramp"
    annotation (Placement(transformation(extent={{-120,100},{-100,120}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.Sine TChiWatRet1(
    final amplitude=7,
    final offset=273.15 + 15,
    final freqHz=1/21600)
    "Chiller water return temeprature"
    annotation (Placement(transformation(extent={{-200,-100},{-180,-80}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.Sine chiWatFlow1(
    final offset=0,
    final freqHz=1/21600,
    final amplitude=0.037)
    "Chilled water flow"
    annotation (Placement(transformation(extent={{-200,-140},{-180,-120}})));

  Buildings.Controls.OBC.CDL.Logical.Sources.Constant chiAva1[3](
    final k={true,true,true})
    "Chiller availability vector"
    annotation (Placement(transformation(extent={{-120,-40},{-100,-20}})));

  Buildings.Controls.OBC.CDL.Continuous.Max max1 "Maximum"
    annotation (Placement(transformation(extent={{-160,-140},{-140,-120}})));

  Buildings.Controls.OBC.CDL.Discrete.ZeroOrderHold zerOrdHol1(
    final samplePeriod=10) "Zero order hold"
    annotation (Placement(transformation(extent={{140,-100},{160,-80}})));

  Buildings.Controls.OBC.CDL.Conversions.IntegerToReal intToRea1 "Type converter"
    annotation (Placement(transformation(extent={{100,-100},{120,-80}})));

  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToInt1 "Type converter"
    annotation (Placement(transformation(extent={{180,-100},{200,-80}})));

  Buildings.Controls.OBC.CDL.Logical.TrueFalseHold truFalHol1(
    final trueHoldDuration=0,
    final falseHoldDuration=900) "Holds true value"
    annotation (Placement(transformation(extent={{100,-180},{120,-160}})));

  Buildings.Controls.OBC.CDL.Logical.Pre pre1 "Logical pre"
    annotation (Placement(transformation(extent={{140,-180},{160,-160}})));

  Buildings.Controls.OBC.CDL.Logical.Sources.Constant plaSta1(
    final k=true) "Plant status"
    annotation (Placement(transformation(extent={{-60,-180},{-40,-160}})));

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt1(
    final k=0) "Constant"
    annotation (Placement(transformation(extent={{-20,-140},{0,-120}})));

  Buildings.Controls.OBC.CDL.Logical.TrueDelay truDel1(
    final delayTime=10,
    final delayOnInit=true) "True delay"
    annotation (Placement(transformation(extent={{-20,-180},{0,-160}})));

  Buildings.Controls.OBC.CDL.Continuous.AddParameter wseTPre1(
    final p=-3,
    final k=1)
    "Predicted WSE outlet temperature"
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.Ramp TCWSup1(
    final height=-2.1,
    final duration=300,
    final offset=273.15 + 16,
    final startTime=1500) "Chilled water supply temperature ramp"
    annotation (Placement(transformation(extent={{-120,-140},{-100,-120}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.TimeTable wseSta1(
    final table=[0,1; 1500,1; 1500,0; 12500,0;
        12500,1; 14000,1], smoothness=Buildings.Controls.OBC.CDL.Types.Smoothness.LinearSegments)
    "WSE is on during low loads, off during high loads"
    annotation (Placement(transformation(extent={{-60,-220},{-40,-200}})));

  Buildings.Controls.OBC.CDL.Continuous.GreaterThreshold greThr1(
    final threshold=0.5) "Greater than threshold"
    annotation (Placement(transformation(extent={{-20,-220},{0,-200}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant TCWSupSet(
    final k=273.15 + 14)
    "Chilled water supply temperature setpoint"
    annotation (Placement(transformation(extent={{-120,160},{-100,180}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant zero(
    final k=0) "Constant"
    annotation (Placement(transformation(extent={{-200,60},{-180,80}})));

protected
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant dpChiWat1(
    final k=65*6895)
    "Chilled water differential pressure"
    annotation (Placement(transformation(extent={{-120,-230},{-100,-210}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant TCWSupSet1(
    final k=273.15 + 14)
    "Chilled water supply temperature setpoint"
    annotation (Placement(transformation(extent={{-120,-80},{-100,-60}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant dpChiWatSet1(
    final k=65*6895)
    "Chilled water differential pressure setpoint"
    annotation (Placement(transformation(extent={{-120,-180},{-100,-160}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant zero1(
    final k=0) "Constant"
    annotation (Placement(transformation(extent={{-200,-180},{-180,-160}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.Ramp maxTowFanSpe1(
    final height=-0.05,
    final duration=60,
    final offset=1,
    final startTime=13000) "Constant"
    annotation (Placement(transformation(extent={{-160,-60},{-140,-40}})));

equation
  connect(zero.y,max. u2) annotation (Line(points={{-178,70},{-170,70},{-170,
          104},{-162,104}},
                       color={0,0,127}));
  connect(chiWatFlow.y,max. u1) annotation (Line(points={{-178,110},{-170,110},
          {-170,116},{-162,116}},color={0,0,127}));
  connect(staSetCon.VChiWat_flow,max. y) annotation (Line(points={{58,141},{-130,141},
          {-130,110},{-138,110}},
                            color={0,0,127}));
  connect(TChiWatRet.y,staSetCon. TChiWatRet) annotation (Line(points={{-178,150},{-130,
          150},{-130,145},{58,145}},
                                  color={0,0,127}));
  connect(staSetCon.ySta,intToRea. u)
    annotation (Line(points={{82,159},{90,159},{90,158},{96,158}},
                                               color={255,127,0}));
  connect(intToRea.y,zerOrdHol. u)
    annotation (Line(points={{120,158},{130,158},{130,150},{138,150}},
                                                 color={0,0,127}));
  connect(zerOrdHol.y,reaToInt. u)
    annotation (Line(points={{162,150},{178,150}},
                                                 color={0,0,127}));
  connect(reaToInt.y,staSetCon. u) annotation (Line(points={{202,150},{210,150},
          {210,100},{50,100},{50,137},{58,137}},
                                     color={255,127,0}));
  connect(staSetCon.y,truFalHol. u) annotation (Line(points={{82,150},{90,150},{
          90,70},{98,70}},
                     color={255,0,255}));
  connect(truFalHol.y,pre. u)
    annotation (Line(points={{122,70},{138,70}},   color={255,0,255}));
  connect(truDel.y,staSetCon. uPla) annotation (Line(points={{2,70},{34,70},{34,
          140},{58,140}},
                    color={255,0,255}));
  connect(TCWSupSet.y, staSetCon.TChiWatSupSet) annotation (Line(points={{-98,170},{
          -20,170},{-20,165},{58,165}}, color={0,0,127}));
  connect(TCWSup.y, staSetCon.TChiWatSup) annotation (Line(points={{-98,110},{-70,110},
          {-70,163},{58,163}},                     color={0,0,127}));
  connect(dpChiWatSet1.y, staSetCon1.dpChiWatPumSet) annotation (Line(points={{-98,
          -170},{-92,-170},{-92,-89},{58,-89}}, color={0,0,127}));
  connect(dpChiWat1.y, staSetCon1.dpChiWatPum) annotation (Line(points={{-98,-220},{
          -90,-220},{-90,-87},{58,-87}}, color={0,0,127}));
  connect(chiAva1.y, staSetCon1.uChiAva) annotation (Line(points={{-98,-30},{-28,-30},
          {-28,-109},{58,-109}}, color={255,0,255}));
  connect(zero1.y, max1.u2) annotation (Line(points={{-178,-170},{-170,-170},{
          -170,-136},{-162,-136}}, color={0,0,127}));
  connect(chiWatFlow1.y, max1.u1) annotation (Line(points={{-178,-130},{-170,
          -130},{-170,-124},{-162,-124}}, color={0,0,127}));
  connect(staSetCon1.VChiWat_flow, max1.y) annotation (Line(points={{58,-99},{-130,
          -99},{-130,-130},{-138,-130}}, color={0,0,127}));
  connect(TChiWatRet1.y, staSetCon1.TChiWatRet) annotation (Line(points={{-178,-90},{
          -130,-90},{-130,-95},{58,-95}}, color={0,0,127}));
  connect(staSetCon1.ySta, intToRea1.u)
    annotation (Line(points={{82,-81},{90,-81},{90,-90},{98,-90}},
                                                 color={255,127,0}));
  connect(intToRea1.y, zerOrdHol1.u)
    annotation (Line(points={{122,-90},{138,-90}}, color={0,0,127}));
  connect(zerOrdHol1.y, reaToInt1.u)
    annotation (Line(points={{162,-90},{178,-90}}, color={0,0,127}));
  connect(reaToInt1.y, staSetCon1.u) annotation (Line(points={{202,-90},{210,-90},
          {210,-140},{50,-140},{50,-103},{58,-103}},color={255,127,0}));
  connect(staSetCon1.y, truFalHol1.u) annotation (Line(points={{82,-90},{90,-90},
          {90,-170},{98,-170}},
                            color={255,0,255}));
  connect(truFalHol1.y, pre1.u)
    annotation (Line(points={{122,-170},{138,-170}}, color={255,0,255}));
  connect(pre1.y, staSetCon1.chaPro) annotation (Line(points={{162,-170},{170,-170},{
          170,-190},{40,-190},{40,-107},{58,-107}}, color={255,0,255}));
  connect(staSetCon1.uIni, conInt1.y) annotation (Line(points={{58,-102.8},{28,-102.8},
          {28,-130},{2,-130}}, color={255,127,0}));
  connect(plaSta1.y, truDel1.u)
    annotation (Line(points={{-38,-170},{-22,-170}}, color={255,0,255}));
  connect(truDel1.y, staSetCon1.uPla) annotation (Line(points={{2,-170},{34,-170},
          {34,-100},{58,-100}},
                            color={255,0,255}));
  connect(maxTowFanSpe1.y, staSetCon1.uTowFanSpeMax) annotation (Line(points={{-138,
          -50},{34,-50},{34,-92},{58,-92}}, color={0,0,127}));
  connect(TCWSupSet1.y, wseTPre1.u) annotation (Line(points={{-98,-70},{-80,-70},
          {-80,-24},{-16,-24},{-16,-30},{-2,-30}}, color={0,0,127}));
  connect(staSetCon1.TWsePre, wseTPre1.y) annotation (Line(points={{58,-97},{42,-97},
          {42,-98},{30,-98},{30,-30},{22,-30}}, color={0,0,127}));
  connect(TCWSupSet1.y, staSetCon1.TChiWatSupSet) annotation (Line(points={{-98,-70},
          {-20,-70},{-20,-75},{58,-75}}, color={0,0,127}));
  connect(TCWSup1.y, staSetCon1.TChiWatSup) annotation (Line(points={{-98,-130},{-70,
          -130},{-70,-77},{58,-77}}, color={0,0,127}));
  connect(wseSta1.y[1], greThr1.u)
    annotation (Line(points={{-38,-210},{-22,-210}}, color={0,0,127}));
  connect(greThr1.y, staSetCon1.uWseSta) annotation (Line(points={{2,-210},{32,-210},
          {32,-105},{58,-105}}, color={255,0,255}));
  connect(plaSta.y, truDel.u) annotation (Line(points={{-38,70},{-30,70},{-30,70},
          {-22,70}}, color={255,0,255}));
annotation (
 experiment(StopTime=14000.0, Tolerance=1e-06),
  __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Controls/OBC/ASHRAE/PrimarySystem/ChillerPlant/Staging/Validation/SetpointController_WSE.mos"
    "Simulate and plot"),
  Documentation(info="<html>
<p>
This example validates
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Staging.SetPoints.SetpointController\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Staging.SetPoints.SetpointController</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
March 26, 2020, by Milica Grahovac:<br/>
First implementation.
</li>
</ul>
</html>"),
Icon(graphics={
        Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent = {{-100,-100},{100,100}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points = {{-36,60},{64,0},{-36,-60},{-36,60}})}),Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-220,-240},{220,240}})));
end SetpointController;
