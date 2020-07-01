within Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Staging.SetPoints.Validation;
model SetpointController
  "Validates chiller stage status setpoint signal generation for plants with WSE"

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Staging.SetPoints.SetpointController staSetCon(
    final primaryOnly=false,
    final nBoi=2,
    final boiTyp={Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Types.BoilerTypes.condensingBoiler,
        Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Types.BoilerTypes.condensingBoiler},
    final nSta=3,
    final staMat=[1,0; 0,1; 1,1],
    final iniSta=1,
    final boiDesCap={1000000,1500000},
    final boiFirMin={0.2,0.3},
    final bMinPriPumSpeSta={0,0,0},
    final delStaCha=900,
    final avePer=300,
    final fraNonConBoi=0.9,
    final fraConBoi=1.5,
    final delEffCon=600,
    final TDif=10,
    final delFaiCon=900,
    final sigDif=0.01,
    final TDifHys=1,
    final fraMinFir=1.1,
    final delMinFir=300,
    final fraDesCap=0.8,
    final delDesCapNonConBoi=600,
    final delDesCapConBoi=300,
    final TCirDif=3,
    final delTRetDif=300,
    final dTemp=0.1)
    "Boiler stage setpoint controller"
    annotation (Placement(transformation(extent={{60,140},{80,160}})));

  CDL.Logical.FallingEdge falEdg
    annotation (Placement(transformation(extent={{160,60},{180,80}})));
  CDL.Routing.RealReplicator reaRep(nout=3)
    annotation (Placement(transformation(extent={{-120,110},{-100,130}})));
//protected
  parameter Modelica.SIunits.Temperature TChiWatSupSet = 285.15
  "Chilled water supply set temperature";

  parameter Modelica.SIunits.Temperature aveTChiWatRet = 288.15
  "Average measured chilled water return temperature";

  parameter Modelica.SIunits.Time minStaRuntime = 900
    "Minimum stage runtime";

  parameter Modelica.SIunits.VolumeFlowRate aveVChiWat_flow = 0.05
    "Average measured chilled water flow rate";

  Buildings.Controls.OBC.CDL.Continuous.Sources.Sine THotWatRet(
    final amplitude=7,
    phase=0,
    final offset=273.15 + 22,
    final freqHz=1/21600) "Hot water return temeprature"
    annotation (Placement(transformation(extent={{-80,170},{-60,190}})));

  Buildings.Controls.OBC.CDL.Logical.Sources.Constant boiAva[2](
    final k={true,true}) "Boiler availability vector"
    annotation (Placement(transformation(extent={{-160,10},{-140,30}})));

  Buildings.Controls.OBC.CDL.Discrete.ZeroOrderHold zerOrdHol(
    final samplePeriod=10)
    annotation (Placement(transformation(extent={{140,148},{160,168}})));

  Buildings.Controls.OBC.CDL.Conversions.IntegerToReal intToRea
    annotation (Placement(transformation(extent={{100,148},{120,168}})));

  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToInt
    annotation (Placement(transformation(extent={{180,148},{200,168}})));

  Buildings.Controls.OBC.CDL.Logical.TrueFalseHold truFalHol(
    final trueHoldDuration=0,
    final falseHoldDuration=900)
    annotation (Placement(transformation(extent={{100,60},{120,80}})));

  Buildings.Controls.OBC.CDL.Logical.Pre pre
    annotation (Placement(transformation(extent={{130,60},{150,80}})));

  Buildings.Controls.OBC.CDL.Logical.Sources.Constant plaSta(
    final k=true)
    "Plant status"
    annotation (Placement(transformation(extent={{-160,40},{-140,60}})));

  Buildings.Controls.OBC.CDL.Logical.TrueDelay truDel(
    final delayTime=10,
    final delayOnInit=true)
    annotation (Placement(transformation(extent={{-120,40},{-100,60}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant THotWatSupSet(final k=
        273.15 + 30) "Hot water supply temperature setpoint"
    annotation (Placement(transformation(extent={{-80,202},{-60,222}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant zero(final k=10^(-10))
               "Constant"
    annotation (Placement(transformation(extent={{-160,110},{-140,130}})));

  CDL.Continuous.Sources.Constant THotWatSup(final k=273.15 + 30)
    "Hot water supply temperature"
    annotation (Placement(transformation(extent={{-80,130},{-60,150}})));
  CDL.Continuous.Sources.Constant VHotWat_flow(final k=0.037)
    "Hot water flow rate"
    annotation (Placement(transformation(extent={{-160,170},{-140,190}})));
  CDL.Continuous.Sources.Constant THotWatRetSec(final k=273.15 + 26)
    "Hot water secondary loop return temperature"
    annotation (Placement(transformation(extent={{-80,90},{-60,110}})));
  CDL.Continuous.Sources.Sine uPumSpe(
    final amplitude=1,
    final offset=0,
    final freqHz=1/21600) "Pump speed signal"
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
equation
  connect(staSetCon.ySta,intToRea. u)
    annotation (Line(points={{82,158},{98,158}},
                                               color={255,127,0}));
  connect(intToRea.y,zerOrdHol. u)
    annotation (Line(points={{122,158},{138,158}},
                                                 color={0,0,127}));
  connect(zerOrdHol.y,reaToInt. u)
    annotation (Line(points={{162,158},{178,158}},
                                                 color={0,0,127}));
  connect(reaToInt.y,staSetCon. u) annotation (Line(points={{202,158},{210,158},
          {210,100},{48,100},{48,137},{58,137}},
                                     color={255,127,0}));
  connect(staSetCon.yChaEdg, truFalHol.u) annotation (Line(points={{82,150},{90,
          150},{90,70},{98,70}}, color={255,0,255}));
  connect(truFalHol.y,pre. u)
    annotation (Line(points={{122,70},{128,70}},   color={255,0,255}));
  connect(truDel.y,staSetCon. uPla) annotation (Line(points={{-98,50},{32,50},{32,
          140},{58,140}},
                    color={255,0,255}));
  connect(plaSta.y, truDel.u) annotation (Line(points={{-138,50},{-122,50}},
                     color={255,0,255}));
  connect(pre.y, falEdg.u)
    annotation (Line(points={{152,70},{158,70}}, color={255,0,255}));
  connect(falEdg.y, staSetCon.uStaChaProEnd) annotation (Line(points={{182,70},
          {190,70},{190,50},{61,50},{61,130}}, color={255,0,255}));
  connect(THotWatSupSet.y, staSetCon.THotWatSupSet) annotation (Line(points={{-58,212},
          {-30,212},{-30,167},{58,167}},          color={0,0,127}));
  connect(THotWatRet.y, staSetCon.THotWatRet) annotation (Line(points={{-58,180},
          {-48,180},{-48,164},{58,164}}, color={0,0,127}));
  connect(THotWatSup.y, staSetCon.THotWatSup) annotation (Line(points={{-58,140},
          {-40,140},{-40,158},{58,158}}, color={0,0,127}));
  connect(zero.y, reaRep.u) annotation (Line(points={{-138,120},{-122,120}},
                                 color={0,0,127}));
  connect(reaRep.y, staSetCon.VMinSet_flow) annotation (Line(points={{-98,120},{
          -30,120},{-30,155},{58,155}},  color={0,0,127}));
  connect(boiAva.y, staSetCon.uBoiAva) annotation (Line(points={{-138,20},{40,20},
          {40,134},{58,134}}, color={255,0,255}));
  connect(VHotWat_flow.y, staSetCon.VHotWat_flow) annotation (Line(points={{-138,
          180},{-100,180},{-100,161},{58,161}}, color={0,0,127}));
  connect(THotWatRet.y, staSetCon.THotWatRetPri) annotation (Line(points={{-58,180},
          {-48,180},{-48,149},{58,149}}, color={0,0,127}));
  connect(THotWatRetSec.y, staSetCon.THotWatRetSec) annotation (Line(points={{-58,
          100},{-24,100},{-24,146},{58,146}}, color={0,0,127}));
  connect(uPumSpe.y, staSetCon.uPumSpe) annotation (Line(points={{-58,70},{-16,70},
          {-16,143},{58,143}}, color={0,0,127}));
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
