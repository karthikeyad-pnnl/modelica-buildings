within Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant;
model Controller
  SetPoints.HotWaterSupplyTemperatureReset hotWaterSupplyTemperatureReset
    annotation (Placement(transformation(extent={{12,-12},{24,0}})));
  SetPoints.BypassValvePosition bypassValvePosition
    annotation (Placement(transformation(extent={{-68,30},{-52,46}})));
  SetPoints.PumpSpeed pumpSpeed
    annotation (Placement(transformation(extent={{-28,10},{-8,34}})));
  Subsequences.BoilerStagingController_v2 boilerStagingController_v2_1
    annotation (Placement(transformation(extent={{-32,44},{-8,84}})));
  Subsequences.BoilerPlantEnabler_v4 boilerPlantEnabler_v4_1
    annotation (Placement(transformation(extent={{-80,80},{-56,114}})));
  CDL.Interfaces.BooleanInput uHotWatReq
    "Heating hot-water requests from the heating coil"
    annotation (Placement(transformation(extent={{-140,100},{-100,140}})));
  CDL.Interfaces.RealInput TOut "Outdoor air temperature"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  CDL.Interfaces.RealInput uPriCirFloRat
    "Measured flow-rate in primary circuit"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
  CDL.Interfaces.RealInput uHotWatDifPre
    "Measured differential pressure between hot-water supply and return"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  CDL.Interfaces.RealInput THotWatSup "Measured hot-water supply temperature"
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
  CDL.Interfaces.RealInput THotWatRet "Measured hot-water return temperature"
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
  CDL.Interfaces.BooleanInput uPumProSig_a "Signal proving lead pump is on"
    annotation (Placement(transformation(extent={{-140,-140},{-100,-100}})));
  CDL.Interfaces.BooleanInput uPumProSig_b
    "Signal proving lag pump has been turned on"
    annotation (Placement(transformation(extent={{-140,-180},{-100,-140}})));
  CDL.Integers.OnCounter onCouInt
    annotation (Placement(transformation(extent={{-22,114},{-10,126}})));
  CDL.Logical.Latch lat
    annotation (Placement(transformation(extent={{-86,122},{-72,136}})));
  CDL.Logical.Timer tim
    annotation (Placement(transformation(extent={{-64,122},{-50,136}})));
  CDL.Continuous.GreaterEqualThreshold greEquThr(threshold=10*60)
    annotation (Placement(transformation(extent={{-44,122},{-30,136}})));
  CDL.Logical.FallingEdge falEdg
    annotation (Placement(transformation(extent={{-46,102},{-34,114}})));
  CDL.Interfaces.BooleanOutput yLeaBoiIsoVal
    "Signal to open lead boiler isolation valve"
    annotation (Placement(transformation(extent={{100,100},{140,140}})));
  CDL.Interfaces.BooleanOutput yLagBoiIsoVal
    "Signal to open lag boiler isolation valve"
    annotation (Placement(transformation(extent={{100,20},{140,60}})));
  CDL.Interfaces.BooleanOutput yLeaBoiEnaSig "Signal to enable lead boiler"
    annotation (Placement(transformation(extent={{100,60},{140,100}})));
  CDL.Interfaces.BooleanOutput yLagBoiEnaSig "Signal to enable lag boiler"
    annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  CDL.Interfaces.RealOutput yBypValPos "Bypass valve opening position"
    annotation (Placement(transformation(extent={{100,-60},{140,-20}})));
  CDL.Interfaces.BooleanOutput yLeaPumSta "Lead pump start signal"
    annotation (Placement(transformation(extent={{100,-100},{140,-60}})));
  CDL.Interfaces.BooleanOutput yLagPumSta "Lag pump start signal"
    annotation (Placement(transformation(extent={{100,-140},{140,-100}})));
  CDL.Interfaces.RealOutput yPumSpeSig "Pump speed signal"
    annotation (Placement(transformation(extent={{100,-180},{140,-140}})));
equation
  connect(boilerStagingController_v2_1.boiEnaSig, boilerPlantEnabler_v4_1.boiEnaSig)
    annotation (Line(points={{-34,66},{-44,66},{-44,92},{-54,92}}, color={255,
          0,255}));
  connect(boilerPlantEnabler_v4_1.hotWatReq, uHotWatReq) annotation (Line(
        points={{-82,100},{-92,100},{-92,120},{-120,120}}, color={255,0,255}));
  connect(boilerPlantEnabler_v4_1.uOutAirTem, TOut) annotation (Line(points={
          {-82,92},{-90,92},{-90,80},{-120,80}}, color={0,0,127}));
  connect(uPriCirFloRat, bypassValvePosition.priCirFloRat)
    annotation (Line(points={{-120,40},{-70,40}}, color={0,0,127}));
  connect(pumpSpeed.uPriCirFloRat, bypassValvePosition.priCirFloRat)
    annotation (Line(points={{-30,24},{-80,24},{-80,40},{-70,40}}, color={0,0,
          127}));
  connect(pumpSpeed.uHotWatDifPre, uHotWatDifPre) annotation (Line(points={{
          -30,20},{-80,20},{-80,0},{-120,0}}, color={0,0,127}));
  connect(bypassValvePosition.uPumProSig_a, uPumProSig_a) annotation (Line(
        points={{-70,36},{-76,36},{-76,-120},{-120,-120}}, color={255,0,255}));
  connect(bypassValvePosition.uPumProSig_b, uPumProSig_b) annotation (Line(
        points={{-70,32},{-74,32},{-74,-160},{-120,-160}}, color={255,0,255}));
  connect(pumpSpeed.uPumProSig_a, uPumProSig_a) annotation (Line(points={{-30,
          16},{-76,16},{-76,-120},{-120,-120}}, color={255,0,255}));
  connect(pumpSpeed.uPumProSig_b, uPumProSig_b) annotation (Line(points={{-30,
          12},{-74,12},{-74,-160},{-120,-160}}, color={255,0,255}));
  connect(boilerStagingController_v2_1.leaBoiIsoValSig, pumpSpeed.IsoValSig_a)
    annotation (Line(points={{-6,74},{0,74},{0,40},{-36,40},{-36,32},{-30,32}},
        color={255,0,255}));
  connect(boilerStagingController_v2_1.lagBoiIsoValSig, pumpSpeed.IsoValSig_b)
    annotation (Line(points={{-6,66},{-2,66},{-2,36},{-34,36},{-34,28},{-30,
          28}}, color={255,0,255}));
  connect(hotWaterSupplyTemperatureReset.uPumProSig_a, uPumProSig_a)
    annotation (Line(points={{10,-2},{-76,-2},{-76,-120},{-120,-120}}, color=
          {255,0,255}));
  connect(hotWaterSupplyTemperatureReset.uPumProSig_b, uPumProSig_b)
    annotation (Line(points={{10,-6},{-74,-6},{-74,-160},{-120,-160}}, color=
          {255,0,255}));
  connect(boilerStagingController_v2_1.pumProSig_a, uPumProSig_a) annotation (
     Line(points={{-34,54},{-46,54},{-46,16},{-76,16},{-76,-120},{-120,-120}},
        color={255,0,255}));
  connect(boilerStagingController_v2_1.pumProSig_b, uPumProSig_b) annotation (
     Line(points={{-34,50},{-44,50},{-44,12},{-74,12},{-74,-160},{-120,-160}},
        color={255,0,255}));
  connect(boilerStagingController_v2_1.yBypValPos, bypassValvePosition.yBypValPos)
    annotation (Line(points={{-34,46},{-42,46},{-42,38},{-50,38}}, color={0,0,
          127}));
  connect(onCouInt.trigger, uHotWatReq)
    annotation (Line(points={{-23.2,120},{-120,120}}, color={255,0,255}));
  connect(onCouInt.y, hotWaterSupplyTemperatureReset.uNumHotWatReq)
    annotation (Line(points={{-8.8,120},{6,120},{6,-10},{10,-10}}, color={255,
          127,0}));
  connect(lat.u, uHotWatReq) annotation (Line(points={{-87.4,129},{-92,129},{
          -92,120},{-120,120}}, color={255,0,255}));
  connect(tim.u, lat.y)
    annotation (Line(points={{-65.4,129},{-70.6,129}}, color={255,0,255}));
  connect(tim.y, greEquThr.u)
    annotation (Line(points={{-48.6,129},{-45.4,129}}, color={0,0,127}));
  connect(greEquThr.y, lat.clr) annotation (Line(points={{-28.6,129},{-26,129},
          {-26,118},{-90,118},{-90,124.8},{-87.4,124.8}}, color={255,0,255}));
  connect(falEdg.y, onCouInt.reset) annotation (Line(points={{-32.8,108},{-16,
          108},{-16,112.8}}, color={255,0,255}));
  connect(falEdg.u, lat.y) annotation (Line(points={{-47.2,108},{-52,108},{
          -52,116},{-68,116},{-68,129},{-70.6,129}}, color={255,0,255}));
  connect(hotWaterSupplyTemperatureReset.hotWatSupTemSet,
    boilerStagingController_v2_1.hotWatSupTemSetPoi) annotation (Line(points=
          {{26,-6},{30,-6},{30,88},{-38,88},{-38,82},{-34,82}}, color={0,0,
          127}));
  connect(boilerStagingController_v2_1.hotWatMinFloSetPoi,
    bypassValvePosition.boiMinFloSet) annotation (Line(points={{-6,58},{2,58},
          {2,86},{-48,86},{-48,48},{-72,48},{-72,44},{-70,44}}, color={0,0,
          127}));
  connect(THotWatRet, boilerStagingController_v2_1.hotWatRetTem) annotation (
      Line(points={{-120,-80},{-38,-80},{-38,78},{-34,78}}, color={0,0,127}));
  connect(boilerStagingController_v2_1.priCirFloRat, bypassValvePosition.priCirFloRat)
    annotation (Line(points={{-34,74},{-40,74},{-40,24},{-80,24},{-80,40},{
          -70,40}}, color={0,0,127}));
  connect(boilerStagingController_v2_1.hotWatSupTem, THotWatSup) annotation (
      Line(points={{-34,70},{-84,70},{-84,-40},{-120,-40}}, color={0,0,127}));
  connect(yLeaBoiIsoVal, boilerStagingController_v2_1.leaBoiIsoValSig)
    annotation (Line(points={{120,120},{10,120},{10,122},{-6,122},{-6,74}},
        color={255,0,255}));
  connect(boilerStagingController_v2_1.leaBoiEnaSig, yLeaBoiEnaSig)
    annotation (Line(points={{-6,70},{-4,70},{-4,80},{120,80}}, color={255,0,
          255}));
  connect(yLagBoiIsoVal, pumpSpeed.IsoValSig_b) annotation (Line(points={{120,
          40},{90,40},{90,66},{-2,66},{-2,36},{-34,36},{-34,28},{-30,28}},
        color={255,0,255}));
  connect(boilerStagingController_v2_1.lagBoiEnaSig, yLagBoiEnaSig)
    annotation (Line(points={{-6,62},{86,62},{86,0},{120,0}}, color={255,0,
          255}));
  connect(yBypValPos, bypassValvePosition.yBypValPos) annotation (Line(points=
         {{120,-40},{-42,-40},{-42,38},{-50,38}}, color={0,0,127}));
  connect(yLeaPumSta, pumpSpeed.yPumSta_a) annotation (Line(points={{120,-80},
          {-4,-80},{-4,28},{-6,28}}, color={255,0,255}));
  connect(yLagPumSta, pumpSpeed.yPumSta_b) annotation (Line(points={{120,-120},
          {-2,-120},{-2,22},{-6,22}}, color={255,0,255}));
  connect(yPumSpeSig, pumpSpeed.yPumSpe) annotation (Line(points={{120,-160},
          {0,-160},{0,16},{-6,16}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -180},{100,140}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-180},{100,
            140}})));
end Controller;
