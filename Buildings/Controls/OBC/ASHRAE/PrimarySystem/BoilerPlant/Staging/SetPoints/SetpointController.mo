within Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Staging.SetPoints;
block SetpointController
  "Calculates the chiller stage status setpoint signal"

  parameter Boolean have_WSE = false
    "true = plant has a WSE, false = plant does not have WSE"
    annotation (Dialog(tab="General", group="Plant configuration parameters"));

  parameter Boolean serChi = false
    "true = series chillers plant; false = parallel chillers plant"
    annotation (Dialog(tab="General", group="Plant configuration parameters"));

  parameter Boolean anyVsdCen = false
    "Plant contains at least one variable speed centrifugal chiller"
    annotation (Dialog(tab="General", group="Plant configuration parameters"));

  parameter Integer nChi = 2
    "Number of chillers"
    annotation (Dialog(tab="General", group="Chiller configuration parameters"));

  parameter Modelica.SIunits.Power chiDesCap[nChi]
    "Design chiller capacities vector"
    annotation (Dialog(tab="General", group="Chiller configuration parameters"));

  parameter Modelica.SIunits.Power chiMinCap[nChi]
    "Chiller minimum cycling loads vector"
    annotation (Dialog(tab="General", group="Chiller configuration parameters"));

  parameter Integer chiTyp[nChi]={
    Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Types.ChillerAndStageTypes.positiveDisplacement,
    Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Types.ChillerAndStageTypes.variableSpeedCentrifugal}
    "Chiller type. Recommended staging order: positive displacement, variable speed centrifugal, constant speed centrifugal"
    annotation (Dialog(tab="General", group="Chiller configuration parameters"));

  parameter Integer nSta = 3
    "Number of chiller stages"
    annotation (Dialog(tab="General", group="Chiller configuration parameters"));

  parameter Integer staMat[nSta, nChi] = {{1,0},{0,1},{1,1}}
    "Staging matrix with stage as row index and chiller as column index"
    annotation (Dialog(tab="General", group="Chiller configuration parameters"));

  parameter Modelica.SIunits.Time avePer = 300
    "Time period for the capacity requirement rolling average"
    annotation (Dialog(tab="Time parameters", group="Hold and delay parameters"));

  parameter Modelica.SIunits.Time delayStaCha = 900
    "Hold period for each stage change"
    annotation (Dialog(tab="Time parameters", group="Hold and delay parameters"));

  parameter Modelica.SIunits.Time parLoaRatDelay = 900
    "Enable delay for operating and staging part load ratio condition"
    annotation (Dialog(tab="Time parameters", group="Hold and delay parameters"));

  parameter Modelica.SIunits.Time faiSafTruDelay = 900
    "Enable delay for failsafe condition"
    annotation (Dialog(tab="Time parameters", group="Hold and delay parameters"));

  parameter Modelica.SIunits.Time effConTruDelay = 900
    "Enable delay for efficiency condition"
    annotation (Dialog(tab="Time parameters", group="Hold and delay parameters"));

  parameter Modelica.SIunits.Time shortTDelay = 600
    "Short enable delay for staging from zero to first available stage up"
    annotation(Evaluate=true, Dialog(enable=have_WSE, tab="Time parameters", group="Hold and delay parameters"));

  parameter Modelica.SIunits.Time longTDelay = 1200
    "Long enable delay for staging from zero to first available stage up"
    annotation(Evaluate=true, Dialog(enable=have_WSE, tab="Time parameters", group="Hold and delay parameters"));

  parameter Real posDisMult(
    final unit = "1",
    final min = 0,
    final max = 1)=0.8
    "Positive displacement chiller type staging multiplier"
    annotation (Dialog(tab="Conditionals", group="Staging part load ratio parameters"));

  parameter Real conSpeCenMult(
    final unit = "1",
    final min = 0,
    final max = 1)=0.9
    "Constant speed centrifugal chiller type staging multiplier"
    annotation (Dialog(tab="Conditionals", group="Staging part load ratio parameters"));

  parameter Real anyOutOfScoMult(
    final unit = "1",
    final min = 0,
    final max = 1)=0.9
    "Outside of G36 recommended staging order chiller type SPLR multiplier"
    annotation(Evaluate=true, __cdl(ValueInReference=False), Dialog(tab="Conditionals", group="Staging part load ratio parameters"));

  parameter Real varSpeStaMin(
    final unit = "1",
    final min = 0.1,
    final max = 1)=0.45
    "Minimum stage up or down part load ratio for variable speed centrifugal stage types"
    annotation(Evaluate=true, Dialog(enable=anyVsdCen, tab="Conditionals", group="Staging part load ratio parameters"));

  parameter Real varSpeStaMax(
    final unit = "1",
    final min = varSpeStaMin,
    final max = 1)=0.9
    "Maximum stage up or down part load ratio for variable speed centrifugal stage types"
    annotation(Evaluate=true, Dialog(enable=anyVsdCen, tab="Conditionals", group="Staging part load ratio parameters"));

  parameter Modelica.SIunits.TemperatureDifference smallTDif = 1
    "Offset between the chilled water supply temperature and its setpoint for the long condition"
    annotation(Evaluate=true, Dialog(enable=have_WSE, tab="Conditionals", group="Value comparison parameters"));

  parameter Modelica.SIunits.TemperatureDifference largeTDif = 2
    "Offset between the chilled water supply temperature and its setpoint for the short condition"
    annotation(Evaluate=true, Dialog(enable=have_WSE, tab="Conditionals", group="Value comparison parameters"));

  parameter Modelica.SIunits.TemperatureDifference faiSafTDif = 1
    "Offset between the chilled water supply temperature and its setpoint for the failsafe condition"
    annotation (Dialog(tab="Conditionals", group="Value comparison parameters"));

  parameter Modelica.SIunits.PressureDifference dpDif = 2 * 6895
    "Offset between the chilled water pump diferential static pressure and its setpoint"
    annotation (Dialog(tab="Conditionals", group="Value comparison parameters"));

  parameter Modelica.SIunits.TemperatureDifference TDif = 1
    "Offset between the chilled water supply temperature and its setpoint for staging down to WSE only"
    annotation (Dialog(tab="Conditionals", group="Value comparison parameters"));

  parameter Modelica.SIunits.TemperatureDifference TDifHys = 1
    "Hysteresis deadband for temperature"
    annotation (Dialog(tab="Conditionals", group="Value comparison parameters"));

  parameter Modelica.SIunits.PressureDifference faiSafDpDif = 2 * 6895
    "Offset between the chilled water differential pressure and its setpoint"
    annotation (Dialog(tab="Conditionals", group="Value comparison parameters"));

  parameter Modelica.SIunits.PressureDifference dpDifHys = 0.5 * 6895
    "Pressure difference hysteresis deadband"
    annotation (Dialog(tab="Conditionals", group="Value comparison parameters"));

  parameter Real effConSigDif = 0.05
    "Signal hysteresis deadband"
    annotation (Dialog(tab="Conditionals", group="Value comparison parameters"));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uBoiAva[nBoi]
    "Boiler availability status vector"
    annotation (Placement(transformation(extent={{-440,-200},{-400,-160}}),
        iconTransformation(extent={{-140,-210},{-100,-170}})));

  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput u(
    final min=0,
    final max=nSta) "Chiller stage"
    annotation (Placement(transformation(extent={{-440,-130},{-400,-90}}),
        iconTransformation(extent={{-140,-130},{-100,-90}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput THotWatRetPri(final unit="1") if
                       have_WSE
    "Measured temperature of return hot water in primary circuit" annotation (
      Placement(transformation(extent={{-440,30},{-400,70}}),
        iconTransformation(extent={{-140,-90},{-100,-50}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput THotWatRetSec if have_WSE
    "Measured temperature of return hot water in secondary circuit"
    annotation (Placement(transformation(extent={{-440,-10},{-400,30}}),
        iconTransformation(extent={{-140,-40},{-100,0}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput THotWatSupSet(
    final unit="K",
    final quantity="ThermodynamicTemperature")
    "Hot water supply temperature setpoint"
    annotation (Placement(transformation(extent={{-440,270},{-400,310}}),
        iconTransformation(extent={{-140,130},{-100,170}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput VHotWat_flow(
    final quantity="VolumeFlowRate",
    final unit="m3/s") "Measured hot water flow rate"
    annotation (Placement(transformation(extent={{-440,190},{-400,230}}),
        iconTransformation(extent={{-140,-110},{-100,-70}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput uMinFloSet[nSta](final unit="Pa",
      final quantity="PressureDifference") if
                                            not serChi
    "Primary circuit minimum flow setpoint for next higher stage" annotation (
      Placement(transformation(extent={{-440,110},{-400,150}}),
        iconTransformation(extent={{-140,-10},{-100,30}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput THotWatRet(
    final unit="K",
    final quantity="ThermodynamicTemperature") "Hot water return temperature"
    annotation (Placement(transformation(extent={{-440,230},{-400,270}}),
    iconTransformation(extent={{-140,110},{-100,150}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yBoi[nBoi]
    "Boiler status setpoint vector for the current boiler stage setpoint"
    annotation (Placement(transformation(extent={{120,-280},{160,-240}}),
        iconTransformation(extent={{100,-160},{140,-120}})));

  Buildings.Controls.OBC.CDL.Interfaces.IntegerOutput ySta(
    final min=0,
    final max=nSta) "Boiler stage integer setpoint"
    annotation (Placement(
        transformation(extent={{120,-140},{160,-100}}),iconTransformation(
          extent={{100,-20},{140,20}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uPla "Plant enable signal"
                          annotation (Placement(
        transformation(extent={{-440,-100},{-400,-60}}),  iconTransformation(
          extent={{-140,-230},{-100,-190}})));

  CDL.Interfaces.BooleanOutput y "Boiler stage change edge signal"  annotation (
     Placement(transformation(extent={{120,-194},{160,-154}}),
        iconTransformation(extent={{100,-90},{140,-50}})));
  BoilerPlant.Staging.SetPoints.Subsequences.Change cha(final nSta=nSta, final
      delayStaCha=delayStaCha) "Stage change assignment"
    annotation (Placement(transformation(extent={{-20,-180},{0,-160}})));
  BoilerPlant.Staging.SetPoints.Subsequences.BoilerIndices boiInd
    annotation (Placement(transformation(extent={{40,-210},{60,-190}})));
  Subsequences.CapacityRequirement capReq1
    annotation (Placement(transformation(extent={{-360,240},{-340,260}})));
  Subsequences.Configurator conf
    annotation (Placement(transformation(extent={{-360,-180},{-340,-160}})));
  Subsequences.Status sta
    annotation (Placement(transformation(extent={{-310,-220},{-290,-200}})));
  CDL.Interfaces.RealInput THotWatSup(final unit="K", final quantity="ThermodynamicTemperature")
    "Measured hot water supply temperature" annotation (Placement(
        transformation(extent={{-440,150},{-400,190}}), iconTransformation(
          extent={{-140,130},{-100,170}})));
  Subsequences.Capacities cap
    annotation (Placement(transformation(extent={{-270,-180},{-250,-160}})));
  Subsequences.Up staUp
    annotation (Placement(transformation(extent={{-140,-120},{-120,-100}})));
  Subsequences.Down staDow
    annotation (Placement(transformation(extent={{-140,-240},{-120,-220}})));
  CDL.Routing.RealExtractor extIndSig(nin=nSta)
    annotation (Placement(transformation(extent={{-240,-120},{-220,-100}})));
  CDL.Routing.RealExtractor extIndSig1(nin=nSta)
    annotation (Placement(transformation(extent={{-230,-280},{-210,-260}})));
  CDL.Interfaces.RealInput uBypValPos(final unit="Pa", final quantity="PressureDifference") if
                                            not serChi "Bypass valve position"
    annotation (Placement(transformation(extent={{-440,70},{-400,110}}),
        iconTransformation(extent={{-140,-10},{-100,30}})));
equation
  connect(uPla, cha.uPla) annotation (Line(points={{-420,-80},{-280,-80},{-280,
          -140},{-60,-140},{-60,-162},{-22,-162}},
                                             color={255,0,255}));
  connect(cha.ySta, ySta) annotation (Line(points={{2,-166},{20,-166},{20,-120},
          {140,-120}},
                     color={255,127,0}));
  connect(cha.y, y) annotation (Line(points={{2,-174},{140,-174}},
                                      color={255,0,255}));
  connect(boiInd.yChi,yBoi)
    annotation (Line(points={{62,-200},{80,-200},{80,-260},{140,-260}},
                                                     color={255,0,255}));
  connect(cha.ySta,boiInd. u) annotation (Line(points={{2,-166},{20,-166},{20,-200},
          {38,-200}},        color={255,127,0}));
  connect(capReq1.TSupSet, THotWatSupSet) annotation (Line(points={{-362,257},{
          -380,257},{-380,290},{-420,290}},
                                       color={0,0,127}));
  connect(capReq1.TRet, THotWatRet)
    annotation (Line(points={{-362,250},{-420,250}}, color={0,0,127}));
  connect(capReq1.VHotWat_flow, VHotWat_flow) annotation (Line(points={{-362,
          243},{-380,243},{-380,210},{-420,210}},
                                             color={0,0,127}));
  connect(conf.uBoiAva,uBoiAva)  annotation (Line(points={{-362,-170},{-380,-170},
          {-380,-180},{-420,-180}}, color={255,0,255}));
  connect(sta.uAva, conf.yAva) annotation (Line(points={{-312,-216},{-332,-216},
          {-332,-178},{-338,-178}}, color={255,0,255}));
  connect(sta.u, u) annotation (Line(points={{-312,-204},{-328,-204},{-328,-110},
          {-420,-110}},color={255,127,0}));
  connect(conf.yDesCap, cap.uDesCap) annotation (Line(points={{-338,-162},{-310,
          -162},{-310,-161},{-272,-161}}, color={0,0,127}));
  connect(conf.yMinCap, cap.uMinCap) annotation (Line(points={{-338,-166},{-310,
          -166},{-310,-164},{-272,-164}}, color={0,0,127}));
  connect(cap.u, u) annotation (Line(points={{-272,-167},{-308,-167},{-308,-168},
          {-328,-168},{-328,-110},{-420,-110}},
                                              color={255,127,0}));
  connect(sta.yAvaUp, cap.uUp) annotation (Line(points={{-288,-203},{-280,-203},
          {-280,-170},{-272,-170}}, color={255,127,0}));
  connect(sta.yAvaDow, cap.uDown) annotation (Line(points={{-288,-206},{-278,-206},
          {-278,-173},{-272,-173}}, color={255,127,0}));
  connect(sta.yHig, cap.uHig) annotation (Line(points={{-288,-211},{-276,-211},{
          -276,-176},{-272,-176}}, color={255,0,255}));
  connect(sta.yLow, cap.uLow) annotation (Line(points={{-288,-214},{-274,-214},{
          -274,-179},{-272,-179}}, color={255,0,255}));
  connect(conf.yTyp, staDow.uTyp) annotation (Line(points={{-338,-174},{-336,-174},
          {-336,-248},{-139,-248},{-139,-242}}, color={255,127,0}));
  connect(cap.yDes, staUp.uQDes) annotation (Line(points={{-248,-162},{-210,-162},
          {-210,-103},{-142,-103}}, color={0,0,127}));
  connect(cap.yUpMin, staUp.uQUpMin) annotation (Line(points={{-248,-178},{-208,
          -178},{-208,-105},{-142,-105}}, color={0,0,127}));
  connect(conf.yTyp, staUp.uTyp) annotation (Line(points={{-338,-174},{-336,-174},
          {-336,-248},{-206,-248},{-206,-111},{-142,-111}}, color={255,127,0}));
  connect(sta.yAvaCur, staUp.uAvaCur) annotation (Line(points={{-288,-217},{-174,
          -217},{-174,-119},{-142,-119}}, color={255,0,255}));
  connect(THotWatSup, staUp.THotWatSup) annotation (Line(points={{-420,170},{
          -188,170},{-188,-117},{-142,-117}},
                                         color={0,0,127}));
  connect(THotWatSupSet, staUp.THotWatSupSet) annotation (Line(points={{-420,
          290},{-184,290},{-184,-115},{-142,-115}},
                                               color={0,0,127}));
  connect(VHotWat_flow, staUp.uHotWatFloRat) annotation (Line(points={{-420,210},
          {-194,210},{-194,-107},{-142,-107}}, color={0,0,127}));
  connect(staDow.THotWatSupSet, THotWatSupSet) annotation (Line(points={{-142,
          -221},{-184,-221},{-184,290},{-420,290}},
                                              color={0,0,127}));
  connect(staDow.THotWatSup, THotWatSup) annotation (Line(points={{-142,-223},{
          -188,-223},{-188,170},{-420,170}},
                                        color={0,0,127}));
  connect(staDow.uQReq, capReq1.y) annotation (Line(points={{-142,-225},{-180,
          -225},{-180,250},{-338,250}},
                                  color={0,0,127}));
  connect(extIndSig.y, staUp.uUpMinFloSet) annotation (Line(points={{-218,-110},
          {-216,-110},{-216,-109},{-142,-109}}, color={0,0,127}));
  connect(extIndSig.u, uMinFloSet) annotation (Line(points={{-242,-110},{-250,
          -110},{-250,130},{-420,130}},
                                  color={0,0,127}));
  connect(extIndSig.index, sta.yAvaUp) annotation (Line(points={{-230,-122},{-230,
          -154},{-280,-154},{-280,-203},{-288,-203}}, color={255,127,0}));
  connect(extIndSig1.y, staDow.uMinPriPumFlo) annotation (Line(points={{-208,-270},
          {-190,-270},{-190,-235},{-142,-235}}, color={0,0,127}));
  connect(extIndSig1.u, uMinFloSet) annotation (Line(points={{-232,-270},{-240,
          -270},{-240,-130},{-250,-130},{-250,130},{-420,130}},
                                                          color={0,0,127}));
  connect(cap.yMin, staDow.uQMin) annotation (Line(points={{-248,-174},{-190,-174},
          {-190,-227},{-142,-227}}, color={0,0,127}));
  connect(cap.yDowDes, staDow.uQDowDes) annotation (Line(points={{-248,-170},{-192,
          -170},{-192,-231},{-142,-231}}, color={0,0,127}));
  connect(staDow.uBypValPos, uBypValPos) annotation (Line(points={{-142,-229},{
          -172,-229},{-172,90},{-420,90}},
                                        color={0,0,127}));
  connect(THotWatRetPri, staDow.TPriHotWatRet) annotation (Line(points={{-420,50},
          {-170,50},{-170,-237},{-142,-237}},  color={0,0,127}));
  connect(THotWatRetSec, staDow.TSecHotWatRet) annotation (Line(points={{-420,10},
          {-168,10},{-168,-239},{-142,-239}},  color={0,0,127}));
  connect(VHotWat_flow, staDow.uPriCirFloRat) annotation (Line(points={{-420,
          210},{-194,210},{-194,-233},{-142,-233}},
                                               color={0,0,127}));
  connect(extIndSig1.index, u) annotation (Line(points={{-220,-282},{-220,-290},
          {-328,-290},{-328,-110},{-420,-110}},
                                              color={255,127,0}));
  connect(capReq1.y, staUp.uQReq) annotation (Line(points={{-338,250},{-180,250},
          {-180,-101},{-142,-101}}, color={0,0,127}));
  connect(sta.yAvaUp, staUp.uAvaUp) annotation (Line(points={{-288,-203},{-280,
          -203},{-280,-154},{-202,-154},{-202,-113},{-142,-113}},
                                                            color={255,127,0}));
  connect(u, staDow.uCur) annotation (Line(points={{-420,-110},{-328,-110},{
          -328,-252},{-137,-252},{-137,-242}},
                                    color={255,127,0}));
  connect(cha.uAvaUp, sta.yAvaUp) annotation (Line(points={{-22,-166},{-60,-166},
          {-60,-203},{-288,-203}}, color={255,127,0}));
  connect(cha.uAvaDow, sta.yAvaDow) annotation (Line(points={{-22,-170},{-56,
          -170},{-56,-206},{-288,-206}}, color={255,127,0}));
  connect(staUp.yStaUp, cha.uUp) annotation (Line(points={{-118,-110},{-64,-110},
          {-64,-174},{-22,-174}}, color={255,0,255}));
  connect(staDow.y, cha.uDow) annotation (Line(points={{-118,-230},{-64,-230},{
          -64,-178},{-22,-178}}, color={255,0,255}));
  annotation (defaultComponentName = "staSetCon",
        Icon(coordinateSystem(extent={{-400,-300},{120,320}}),
             graphics={
        Rectangle(
        extent={{-100,-160},{100,160}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
        Text(
          extent={{-110,210},{110,172}},
          lineColor={0,0,255},
          textString="%name")}), Diagram(
        coordinateSystem(preserveAspectRatio=false,
        extent={{-400,-300},{120,320}})),
Documentation(info="<html>
<p>
The sequence is a chiller stage status setpoint controller that outputs the 
chiller stage integer index <code>ySta</code>, chiller stage change trigger signal
<code>y</code> and a chiller status vector for the current stage <code>yChi</code>.
</p>
<p>
Implemented according to ASHRAE RP-1711 March 2020 Draft, section 5.2.4.1 - 17.
</p>
<p>
The controller contains the following subsequences:
</p>
<ul>
<li>
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences.CapacityRequirement\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences.CapacityRequirement</a> to calculate
the capacity requirement
</li>
<li>
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences.Configurator\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences.Configurator</a> to allow the user 
to provide the chiller plant configuration parameters such as chiller design and minimal capacities and types. It 
calculates the design and minimal stage capacities, stage type and stage availability
</li>
<li>
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences.Status\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences.Status</a> to calculate
for instance the next higher and lower available stages
</li>
<li>
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences.Capacities\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences.Capacities</a> to calculate
design and minimal stage capacities for current and next available higher and lower stage
</li>
<li>
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences.PartLoadRatios\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences.PartLoadRatios</a> to calculate
operating and staging part load ratios for current and next available higher and lower stage
</li>
<li>
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences.Up\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences.Up</a> to generate
a stage up signal
</li>
<li>
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences.Down\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences.Down</a> to generate
a stage down signal
</li>
<li>
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences.Change\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences.Change</a> to set the stage
based on the initial stage signal and stage up and down signals
</li>
<li>
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences.ChillerIndices\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences.ChillerIndices</a> to generate
the chiller index vector for a given stage
</li>
</ul>
</html>",
revisions="<html>
<ul>
<li>
April 14, 2020, by Milica Grahovac:<br/>
First implementation.
</li>
</ul>
</html>"));
end SetpointController;
