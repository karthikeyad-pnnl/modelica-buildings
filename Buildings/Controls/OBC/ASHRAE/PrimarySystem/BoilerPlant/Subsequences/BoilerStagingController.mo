within Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Subsequences;
model BoilerStagingController
  CDL.Interfaces.RealInput hotWatRetTem "Measured hot-water return temperature"
    annotation (Placement(transformation(extent={{-160,100},{-120,140}})));
  CDL.Interfaces.RealInput priCirFloRat
    "Measured primary circuit hot-water flow-rate"
    annotation (Placement(transformation(extent={{-160,60},{-120,100}})));
  CDL.Interfaces.RealInput hotWatSupTem
    "Measured primary circuit hot-water supply temperature"
    annotation (Placement(transformation(extent={{-160,20},{-120,60}})));
  CDL.Interfaces.RealInput hotWatSupTemSetPoi
    "Hot-water supply temperature setpoint"
    annotation (Placement(transformation(extent={{-160,140},{-120,180}})));
  CDL.Interfaces.BooleanInput boiAlaSta_a "Lead boiler alarm status"
    annotation (Placement(transformation(extent={{-160,-60},{-120,-20}})));
  CDL.Interfaces.BooleanInput boiAlaSta_b "Lag boiler alarm status"
    annotation (Placement(transformation(extent={{-160,-100},{-120,-60}})));
  CDL.Interfaces.BooleanInput pumProSig_a
    "Signal indicating lead pump has been proved on"
    annotation (Placement(transformation(extent={{-160,-140},{-120,-100}})));
  CDL.Interfaces.BooleanInput pumProSig_b
    "Signal indicating lag pump has been proved on"
    annotation (Placement(transformation(extent={{-160,-180},{-120,-140}})));
  CDL.Interfaces.BooleanInput boiEnaSig
    "Boiler-plant enable signal from BoilerPlantEnabler"
    annotation (Placement(transformation(extent={{-160,-20},{-120,20}})));
  CDL.Continuous.Add add2(k2=-1)
    annotation (Placement(transformation(extent={{-108,144},{-88,164}})));
  CDL.Continuous.Product pro
    annotation (Placement(transformation(extent={{-76,138},{-56,158}})));
  CDL.Continuous.Gain gai(k=0.49)
    annotation (Placement(transformation(extent={{-46,138},{-26,158}})));
  CDL.Continuous.Sources.Constant leaBoiFirMin(k=leaBoiFirMinVal)
    "Lowest % firing rate of lead boiler before cycling"
    annotation (Placement(transformation(extent={{-102,110},{-82,130}})));
  CDL.Continuous.Sources.Constant lagBoiFirMin(k=lagBoiFirMinVal)
    "Lowest % firing rate of lag boiler before cycling"
    annotation (Placement(transformation(extent={{-102,74},{-82,94}})));
  CDL.Continuous.Sources.Constant leaBoiNomCap(k=leaBoiNomCapVal)
    "Lead boiler nominal heating capacity"
    annotation (Placement(transformation(extent={{-76,92},{-56,112}})));
  CDL.Continuous.Sources.Constant lagBoiNomCap(k=lagBoiNomCapVal)
    "Lag Boiler nominal heating capacity"
    annotation (Placement(transformation(extent={{-76,56},{-56,76}})));
  CDL.Continuous.Product staOneBoiMinCap "Minimum heating capacity of stage-1"
    annotation (Placement(transformation(extent={{-46,104},{-26,124}})));
  CDL.Continuous.GreaterEqual greEqu
    "Check to find largest B-FiringMin in second stage"
    annotation (Placement(transformation(extent={{-12,100},{8,120}})));
  CDL.Logical.Switch swi "Switch to use larger B-FiringMin value"
    annotation (Placement(transformation(extent={{14,100},{34,120}})));
  CDL.Continuous.Add staTwoBoiNomCap
    "Nominal heating capacity of boilers in stage-2"
    annotation (Placement(transformation(extent={{-44,58},{-24,78}})));
  CDL.Continuous.Product staTwoBoiMinCap "Minimum heating capacity of stage-2"
    annotation (Placement(transformation(extent={{-18,68},{2,88}})));
  CDL.Logical.Switch swi1
    "B-stage_min based on stage currently operating stage"
    annotation (Placement(transformation(extent={{18,64},{38,84}})));
  CDL.Continuous.Sources.Constant leaBoiMinFloRat(k=leaBoiMinFloRatVal)
    "Minimum flo-rate for lead boiler"
    annotation (Placement(transformation(extent={{-96,0},{-76,20}})));
  CDL.Continuous.Sources.Constant lagBoiMinFloRat(k=lagBoiMinFloRatVal)
    "Minimum flow-rate for lag boiler"
    annotation (Placement(transformation(extent={{-64,2},{-44,22}})));
  CDL.Continuous.Add add1
    annotation (Placement(transformation(extent={{-34,2},{-14,22}})));
  CDL.Logical.Switch swi2
    annotation (Placement(transformation(extent={{-4,2},{16,22}})));
  CDL.Continuous.Add add3(k2=-1)
    annotation (Placement(transformation(extent={{-14,32},{6,52}})));
  CDL.Continuous.GreaterEqual greEqu1
    annotation (Placement(transformation(extent={{40,32},{60,52}})));
  CDL.Continuous.MovingMean movMea(delta=15*60)
    annotation (Placement(transformation(extent={{14,32},{34,52}})));
  CDL.Continuous.Sources.Constant con(k=10/1.8)
    annotation (Placement(transformation(extent={{34,4},{54,24}})));
  CDL.Interfaces.BooleanOutput leaBoiIsoValSig
    "Signal to isolation valve for lead boiler"
    annotation (Placement(transformation(extent={{120,60},{160,100}})));
  CDL.Interfaces.BooleanOutput leaBoiEnaSig "Signal to enable lead boiler"
    annotation (Placement(transformation(extent={{120,20},{160,60}})));
  CDL.Interfaces.BooleanOutput lagBoiIsoValSig
    "Signal to isolation valve for lag boiler"
    annotation (Placement(transformation(extent={{120,-20},{160,20}})));
  CDL.Interfaces.BooleanOutput lagBoiEnaSig "Signal to enable lag boiler"
    annotation (Placement(transformation(extent={{120,-60},{160,-20}})));
  CDL.Interfaces.RealOutput hotWatMinFloSetPoi
    "Minimum flow-rate setpoint for hot water"
    annotation (Placement(transformation(extent={{120,-100},{160,-60}})));
  CDL.Logical.TrueHoldWithReset truHol(duration=10*60)
    annotation (Placement(transformation(extent={{6,-24},{26,-4}})));
  CDL.Logical.And and2
    annotation (Placement(transformation(extent={{50,-26},{70,-6}})));
  CDL.Logical.Or or2
    annotation (Placement(transformation(extent={{96,70},{116,90}})));
  CDL.Logical.Or or1
    annotation (Placement(transformation(extent={{96,30},{116,50}})));
  CDL.Continuous.Gain gai1(k=1.5)
    annotation (Placement(transformation(extent={{46,122},{66,142}})));
  CDL.Continuous.MovingMean movMea1(delta=10*60)
    annotation (Placement(transformation(extent={{-100,-56},{-80,-36}})));
  CDL.Continuous.Greater gre
    annotation (Placement(transformation(extent={{-68,-56},{-48,-36}})));
  CDL.Continuous.Gain gai2(k=1.1)
    annotation (Placement(transformation(extent={{46,72},{66,92}})));
  CDL.Logical.LogicalSwitch logSwi
    annotation (Placement(transformation(extent={{-28,-64},{-8,-44}})));
  CDL.Continuous.MovingMean movMea2(delta=5*60)
    annotation (Placement(transformation(extent={{-100,-90},{-80,-70}})));
  CDL.Continuous.GreaterEqual greEqu2
    annotation (Placement(transformation(extent={{-68,-90},{-48,-70}})));
  CDL.Interfaces.RealInput yBypValPos
    "Bypass valve position obtained from BypassValvePosition controller"
    annotation (Placement(transformation(extent={{-160,-220},{-120,-180}})));
  CDL.Continuous.Sources.Constant bypValCloVal(k=0)
    "Constant signal to represent bypass vlave being fully closed"
    annotation (Placement(transformation(extent={{-110,-216},{-90,-196}})));
  CDL.Logical.LogicalSwitch logSwi1
    annotation (Placement(transformation(extent={{-28,-140},{-8,-120}})));
  CDL.Continuous.Greater gre2
    annotation (Placement(transformation(extent={{0,-110},{20,-90}})));
  CDL.Continuous.LessEqual lesEqu
    annotation (Placement(transformation(extent={{-78,-194},{-58,-174}})));
  CDL.Logical.And3 and3
    annotation (Placement(transformation(extent={{2,-64},{22,-44}})));
  CDL.Logical.Or or3
    annotation (Placement(transformation(extent={{44,-114},{64,-94}})));
  CDL.Logical.And and1
    annotation (Placement(transformation(extent={{78,-106},{98,-86}})));
  CDL.Logical.Not not1
    annotation (Placement(transformation(extent={{48,-72},{68,-52}})));
equation
  connect(add2.u1, hotWatSupTemSetPoi)
    annotation (Line(points={{-110,160},{-140,160}}, color={0,0,127}));
  connect(add2.u2, hotWatRetTem) annotation (Line(points={{-110,148},{-114,148},
          {-114,120},{-140,120}}, color={0,0,127}));
  connect(pro.u1, add2.y)
    annotation (Line(points={{-78,154},{-86,154}}, color={0,0,127}));
  connect(pro.u2, priCirFloRat) annotation (Line(points={{-78,142},{-110,142},{
          -110,80},{-140,80}}, color={0,0,127}));
  connect(pro.y, gai.u)
    annotation (Line(points={{-54,148},{-48,148}}, color={0,0,127}));
  connect(leaBoiFirMin.y, staOneBoiMinCap.u1)
    annotation (Line(points={{-80,120},{-48,120}}, color={0,0,127}));
  connect(leaBoiNomCap.y, staOneBoiMinCap.u2) annotation (Line(points={{-54,102},
          {-50,102},{-50,108},{-48,108}}, color={0,0,127}));
  connect(greEqu.y, swi.u2)
    annotation (Line(points={{10,110},{12,110}}, color={255,0,255}));
  connect(lagBoiFirMin.y, greEqu.u2) annotation (Line(points={{-80,84},{-46,84},
          {-46,102},{-14,102}}, color={0,0,127}));
  connect(swi.u1, staOneBoiMinCap.u1) annotation (Line(points={{12,118},{10,118},
          {10,132},{-66,132},{-66,120},{-48,120}}, color={0,0,127}));
  connect(swi.u3, greEqu.u2) annotation (Line(points={{12,102},{10,102},{10,98},
          {-18,98},{-18,102},{-14,102}}, color={0,0,127}));
  connect(staTwoBoiNomCap.u1, staOneBoiMinCap.u2) annotation (Line(points={{-46,
          74},{-50,74},{-50,108},{-48,108}}, color={0,0,127}));
  connect(staTwoBoiNomCap.y, staTwoBoiMinCap.u2)
    annotation (Line(points={{-22,68},{-22,72},{-20,72}}, color={0,0,127}));
  connect(swi.y, staTwoBoiMinCap.u1) annotation (Line(points={{36,110},{50,110},
          {50,96},{-24,96},{-24,84},{-20,84}}, color={0,0,127}));
  connect(greEqu.u1, staOneBoiMinCap.u1) annotation (Line(points={{-14,110},{
          -18,110},{-18,132},{-66,132},{-66,120},{-48,120}}, color={0,0,127}));
  connect(lagBoiMinFloRat.y, add1.u1) annotation (Line(points={{-42,12},{-40,12},
          {-40,18},{-36,18}}, color={0,0,127}));
  connect(leaBoiMinFloRat.y, add1.u2) annotation (Line(points={{-74,10},{-72,10},
          {-72,-6},{-38,-6},{-38,6},{-36,6}}, color={0,0,127}));
  connect(add1.y, swi2.u1) annotation (Line(points={{-12,12},{-8,12},{-8,20},{
          -6,20}}, color={0,0,127}));
  connect(swi2.u3, add1.u2) annotation (Line(points={{-6,4},{-12,4},{-12,0},{
          -38,0},{-38,6},{-36,6}}, color={0,0,127}));
  connect(staOneBoiMinCap.y, swi1.u3) annotation (Line(points={{-24,114},{-16,
          114},{-16,128},{38,128},{38,92},{10,92},{10,66},{16,66}}, color={0,0,
          127}));
  connect(staTwoBoiMinCap.y, swi1.u1) annotation (Line(points={{4,78},{12,78},{
          12,82},{16,82}}, color={0,0,127}));
  connect(add3.u2, hotWatSupTem) annotation (Line(points={{-16,36},{-28,36},{
          -28,40},{-140,40}}, color={0,0,127}));
  connect(add3.u1, hotWatSupTemSetPoi) annotation (Line(points={{-16,48},{-20,
          48},{-20,58},{70,58},{70,172},{-114,172},{-114,160},{-140,160}},
        color={0,0,127}));
  connect(greEqu1.u1, movMea.y)
    annotation (Line(points={{38,42},{36,42}}, color={0,0,127}));
  connect(con.y, greEqu1.u2) annotation (Line(points={{56,14},{60,14},{60,30},{
          36,30},{36,34},{38,34}}, color={0,0,127}));
  connect(add3.y, movMea.u)
    annotation (Line(points={{8,42},{12,42}}, color={0,0,127}));
  connect(lagBoiNomCap.y, staTwoBoiNomCap.u2) annotation (Line(points={{-54,66},
          {-50,66},{-50,62},{-46,62}}, color={0,0,127}));
  connect(boiEnaSig, truHol.u) annotation (Line(points={{-140,0},{-112,0},{-112,
          -14},{4,-14}}, color={255,0,255}));
  connect(pumProSig_a, and2.u2) annotation (Line(points={{-140,-120},{-110,-120},
          {-110,-20},{0,-20},{0,-26},{30,-26},{30,-24},{48,-24}}, color={255,0,
          255}));
  connect(truHol.y, and2.u1) annotation (Line(points={{28,-14},{38,-14},{38,-16},
          {48,-16}}, color={255,0,255}));
  connect(or1.y, leaBoiEnaSig)
    annotation (Line(points={{118,40},{140,40}}, color={255,0,255}));
  connect(leaBoiIsoValSig, or2.y)
    annotation (Line(points={{140,80},{118,80}}, color={255,0,255}));
  connect(or2.u1, and2.u1) annotation (Line(points={{94,80},{76,80},{76,50},{68,
          50},{68,-2},{44,-2},{44,-16},{48,-16}}, color={255,0,255}));
  connect(gai1.u, swi1.u1) annotation (Line(points={{44,132},{40,132},{40,90},{
          12,90},{12,82},{16,82}}, color={0,0,127}));
  connect(gai.y, movMea1.u) annotation (Line(points={{-24,148},{90,148},{90,-28},
          {-108,-28},{-108,-46},{-102,-46}}, color={0,0,127}));
  connect(movMea1.y, gre.u1)
    annotation (Line(points={{-78,-46},{-70,-46}}, color={0,0,127}));
  connect(gai1.y, gre.u2) annotation (Line(points={{68,132},{86,132},{86,-30},{
          -74,-30},{-74,-54},{-70,-54}}, color={0,0,127}));
  connect(and2.y, or1.u1)
    annotation (Line(points={{72,-16},{72,40},{94,40}}, color={255,0,255}));
  connect(gai2.u, swi1.u1) annotation (Line(points={{44,82},{40,82},{40,90},{12,
          90},{12,82},{16,82}}, color={0,0,127}));
  connect(gre.y, logSwi.u1)
    annotation (Line(points={{-46,-46},{-30,-46}}, color={255,0,255}));
  connect(movMea2.u, movMea1.u) annotation (Line(points={{-102,-80},{-108,-80},
          {-108,-46},{-102,-46}}, color={0,0,127}));
  connect(greEqu2.y, logSwi.u3) annotation (Line(points={{-46,-80},{-40,-80},{
          -40,-62},{-30,-62}}, color={255,0,255}));
  connect(movMea2.y, greEqu2.u1)
    annotation (Line(points={{-78,-80},{-70,-80}}, color={0,0,127}));
  connect(gai2.y, greEqu2.u2) annotation (Line(points={{68,82},{80,82},{80,-36},
          {-44,-36},{-44,-94},{-74,-94},{-74,-88},{-70,-88}}, color={0,0,127}));
  connect(swi2.y, hotWatMinFloSetPoi) annotation (Line(points={{18,12},{32,12},
          {32,-80},{140,-80}}, color={0,0,127}));
  connect(gre2.u1, priCirFloRat) annotation (Line(points={{-2,-100},{-116,-100},
          {-116,80},{-140,80}}, color={0,0,127}));
  connect(gre2.u2, add1.y) annotation (Line(points={{-2,-108},{-6,-108},{-6,12},
          {-12,12}}, color={0,0,127}));
  connect(gre2.y, logSwi1.u1) annotation (Line(points={{22,-100},{24,-100},{24,
          -114},{-34,-114},{-34,-122},{-30,-122}}, color={255,0,255}));
  connect(bypValCloVal.y, lesEqu.u2) annotation (Line(points={{-88,-206},{-84,
          -206},{-84,-192},{-80,-192}}, color={0,0,127}));
  connect(lesEqu.u1, yBypValPos) annotation (Line(points={{-80,-184},{-116,-184},
          {-116,-200},{-140,-200}}, color={0,0,127}));
  connect(lesEqu.y, logSwi1.u3) annotation (Line(points={{-56,-184},{-52,-184},
          {-52,-138},{-30,-138}}, color={255,0,255}));
  connect(and3.u2, logSwi.y)
    annotation (Line(points={{0,-54},{-6,-54}}, color={255,0,255}));
  connect(logSwi1.y, and3.u3) annotation (Line(points={{-6,-130},{26,-130},{26,
          -84},{-4,-84},{-4,-62},{0,-62}}, color={255,0,255}));
  connect(and3.u1, truHol.u) annotation (Line(points={{0,-46},{-4,-46},{-4,-14},
          {4,-14}}, color={255,0,255}));
  connect(and3.y, or3.u2) annotation (Line(points={{24,-54},{30,-54},{30,-112},
          {42,-112}}, color={255,0,255}));
  connect(greEqu1.y, or3.u1) annotation (Line(points={{62,42},{76,42},{76,-40},
          {36,-40},{36,-104},{42,-104}}, color={255,0,255}));
  connect(or3.y, and1.u2)
    annotation (Line(points={{66,-104},{76,-104}}, color={255,0,255}));
  connect(not1.u, and2.u1) annotation (Line(points={{46,-62},{40,-62},{40,-16},
          {48,-16}}, color={255,0,255}));
  connect(not1.y, and1.u1) annotation (Line(points={{70,-62},{72,-62},{72,-96},
          {76,-96}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-120,
            -220},{120,180}})), Diagram(coordinateSystem(preserveAspectRatio=
            false, extent={{-120,-220},{120,180}})));
end BoilerStagingController;
