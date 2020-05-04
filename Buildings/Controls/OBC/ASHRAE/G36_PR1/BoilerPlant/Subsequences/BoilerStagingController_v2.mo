within Buildings.Controls.OBC.ASHRAE.G36_PR1.BoilerPlant.Subsequences;
model BoilerStagingController_v2
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
  CDL.Continuous.Gain gai(k=1)
    annotation (Placement(transformation(extent={{-46,138},{-26,158}})));
  CDL.Continuous.Sources.Constant leaBoiFirMin(k=leaBoiFirMinVal)
    "Lowest % firing rate of lead boiler before cycling"
    annotation (Placement(transformation(extent={{-102,110},{-92,120}})));
  CDL.Continuous.Sources.Constant lagBoiFirMin(k=lagBoiFirMinVal)
    "Lowest % firing rate of lag boiler before cycling"
    annotation (Placement(transformation(extent={{-104,80},{-94,90}})));
  CDL.Continuous.Sources.Constant leaBoiNomCap(k=leaBoiNomCapVal)
    "Lead boiler nominal heating capacity"
    annotation (Placement(transformation(extent={{-92,94},{-82,104}})));
  CDL.Continuous.Sources.Constant lagBoiNomCap(k=lagBoiNomCapVal)
    "Lag Boiler nominal heating capacity"
    annotation (Placement(transformation(extent={{-92,64},{-82,74}})));
  CDL.Continuous.Product staOneBoiMinCap "Minimum heating capacity of stage-1"
    annotation (Placement(transformation(extent={{-76,104},{-66,114}})));
  CDL.Continuous.GreaterEqual greEqu
    "Check to find largest B-FiringMin in second stage"
    annotation (Placement(transformation(extent={{-60,100},{-50,110}})));
  CDL.Logical.Switch swi "Switch to use larger B-FiringMin value"
    annotation (Placement(transformation(extent={{-42,100},{-32,110}})));
  CDL.Continuous.Add staTwoBoiNomCap
    "Nominal heating capacity of boilers in stage-2"
    annotation (Placement(transformation(extent={{-72,84},{-62,94}})));
  CDL.Continuous.Product staTwoBoiMinCap "Minimum heating capacity of stage-2"
    annotation (Placement(transformation(extent={{-54,82},{-44,92}})));
  CDL.Logical.Switch swi1 "B-stage_min based on stage currently operating"
    annotation (Placement(transformation(extent={{-18,94},{-6,106}})));
  CDL.Continuous.Sources.Constant leaBoiMinFloRat(k=leaBoiMinFloRatVal)
    "Minimum flo-rate for lead boiler"
    annotation (Placement(transformation(extent={{18,-142},{28,-132}})));
  CDL.Continuous.Sources.Constant lagBoiMinFloRat(k=lagBoiMinFloRatVal)
    "Minimum flow-rate for lag boiler"
    annotation (Placement(transformation(extent={{36,-136},{46,-126}})));
  CDL.Continuous.Add add1
    annotation (Placement(transformation(extent={{52,-136},{62,-126}})));
  CDL.Logical.Switch swi2
    annotation (Placement(transformation(extent={{70,-134},{80,-124}})));
  CDL.Continuous.Sources.Constant con(k=10/1.8)
    annotation (Placement(transformation(extent={{-70,-114},{-58,-102}})));
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
  CDL.Continuous.Gain gai1(k=1.5)
    annotation (Placement(transformation(extent={{46,122},{56,132}})));
  CDL.Continuous.Gain gai2(k=1.1)
    annotation (Placement(transformation(extent={{46,72},{56,82}})));
  CDL.Interfaces.RealInput yBypValPos
    "Bypass valve position obtained from BypassValvePosition controller"
    annotation (Placement(transformation(extent={{-160,-220},{-120,-180}})));
  CDL.Continuous.Sources.Constant bypValCloVal(k=0)
    "Constant signal to represent bypass vlave being fully closed"
    annotation (Placement(transformation(extent={{-110,-214},{-90,-194}})));
  CDL.Continuous.LessEqual lesEqu
    annotation (Placement(transformation(extent={{-78,-194},{-58,-174}})));
  CDL.Discrete.Sampler qReqSam(samplePeriod=qReqSamRat)
    "Sampler for Q-required calculations"
    annotation (Placement(transformation(extent={{-16,138},{4,158}})));
  CDL.Continuous.MovingMean movMea(delta=5*60)
    annotation (Placement(transformation(extent={{14,138},{34,158}})));
  CDL.Logical.Not not1
    annotation (Placement(transformation(extent={{-118,-46},{-106,-34}})));
  CDL.Logical.Not not2
    annotation (Placement(transformation(extent={{-116,-108},{-104,-96}})));
  CDL.Logical.Edge edg
    annotation (Placement(transformation(extent={{-94,20},{-82,32}})));
  CDL.Logical.FallingEdge falEdg
    annotation (Placement(transformation(extent={{-94,-2},{-82,10}})));
  CDL.Logical.Or or2
    annotation (Placement(transformation(extent={{-74,20},{-62,32}})));
  CDL.Logical.Latch lat
    annotation (Placement(transformation(extent={{-54,20},{-42,32}})));
  CDL.Logical.Timer tim
    annotation (Placement(transformation(extent={{-32,20},{-20,32}})));
  CDL.Continuous.GreaterEqual greEqu1
    annotation (Placement(transformation(extent={{-10,20},{2,32}})));
  CDL.Continuous.Sources.Constant minStaRun(k=minStaRunVal)
    "Minimum stage run-time"
    annotation (Placement(transformation(extent={{-100,-24},{-88,-12}})));
  CDL.Logical.Or or1
    annotation (Placement(transformation(extent={{-72,-2},{-60,10}})));
  CDL.Logical.Latch lat1
    annotation (Placement(transformation(extent={{-54,-2},{-42,10}})));
  CDL.Logical.Timer tim1
    annotation (Placement(transformation(extent={{-32,-4},{-20,8}})));
  CDL.Continuous.GreaterEqual greEqu2
    annotation (Placement(transformation(extent={{-10,-4},{2,8}})));
  CDL.Logical.Or or3
    annotation (Placement(transformation(extent={{6,10},{18,22}})));
  CDL.Logical.Or or4
    annotation (Placement(transformation(extent={{-74,40},{-62,52}})));
  CDL.Logical.Or or5
    annotation (Placement(transformation(extent={{-72,-20},{-60,-8}})));
  CDL.Continuous.Greater gre
    annotation (Placement(transformation(extent={{-12,42},{0,54}})));
  CDL.Continuous.Less les
    annotation (Placement(transformation(extent={{-8,-20},{4,-8}})));
  CDL.Logical.LogicalSwitch logSwi
    annotation (Placement(transformation(extent={{4,42},{16,54}})));
  CDL.Logical.LogicalSwitch logSwi1
    annotation (Placement(transformation(extent={{26,42},{38,54}})));
  CDL.Logical.Edge edg1
    annotation (Placement(transformation(extent={{-114,14},{-102,26}})));
  CDL.Logical.FallingEdge falEdg1
    annotation (Placement(transformation(extent={{-114,-14},{-102,-2}})));
  CDL.Logical.Or or6
    annotation (Placement(transformation(extent={{90,60},{102,72}})));
  CDL.Logical.And and2
    annotation (Placement(transformation(extent={{106,56},{118,68}})));
  CDL.Logical.FallingEdge falEdg2
    annotation (Placement(transformation(extent={{32,22},{44,34}})));
  CDL.Logical.TrueHoldWithReset truHol(duration=3*60)
    annotation (Placement(transformation(extent={{50,22},{62,34}})));
  CDL.Logical.Edge edg2
    annotation (Placement(transformation(extent={{-88,-60},{-76,-48}})));
  CDL.Logical.Or or7
    annotation (Placement(transformation(extent={{-70,-60},{-58,-48}})));
  CDL.Logical.Latch lat2
    annotation (Placement(transformation(extent={{-52,-60},{-40,-48}})));
  CDL.Logical.FallingEdge falEdg3
    annotation (Placement(transformation(extent={{-88,-80},{-76,-68}})));
  CDL.Logical.Or or8
    annotation (Placement(transformation(extent={{-70,-80},{-58,-68}})));
  CDL.Logical.Latch lat3
    annotation (Placement(transformation(extent={{-52,-80},{-40,-68}})));
  CDL.Logical.Pre pre
    annotation (Placement(transformation(extent={{42,42},{54,54}})));
  CDL.Logical.Timer tim2
    annotation (Placement(transformation(extent={{-34,-60},{-22,-48}})));
  CDL.Logical.Timer tim3
    annotation (Placement(transformation(extent={{-34,-80},{-22,-68}})));
  CDL.Continuous.GreaterEqual greEqu3
    annotation (Placement(transformation(extent={{-14,-60},{-2,-48}})));
  CDL.Continuous.GreaterEqual greEqu4
    annotation (Placement(transformation(extent={{-14,-80},{-2,-68}})));
  CDL.Logical.Or or9
    annotation (Placement(transformation(extent={{-70,-96},{-58,-84}})));
  CDL.Logical.Or or10
    annotation (Placement(transformation(extent={{-70,-42},{-58,-30}})));
  CDL.Logical.Or or11
    annotation (Placement(transformation(extent={{2,-68},{14,-56}})));
  CDL.Continuous.Greater gre1
    annotation (Placement(transformation(extent={{-14,-42},{-2,-30}})));
  CDL.Continuous.Less les1
    annotation (Placement(transformation(extent={{-14,-96},{-2,-84}})));
  CDL.Logical.LogicalSwitch logSwi2
    annotation (Placement(transformation(extent={{4,-42},{16,-30}})));
  CDL.Logical.LogicalSwitch logSwi3
    annotation (Placement(transformation(extent={{24,-42},{36,-30}})));
  CDL.Logical.Pre pre1
    annotation (Placement(transformation(extent={{40,-42},{52,-30}})));
  CDL.Logical.Edge edg3
    annotation (Placement(transformation(extent={{-104,-66},{-92,-54}})));
  CDL.Logical.FallingEdge falEdg4
    annotation (Placement(transformation(extent={{-104,-86},{-92,-74}})));
  CDL.Logical.And and1
    annotation (Placement(transformation(extent={{106,-6},{118,6}})));
  CDL.Logical.Or or12
    annotation (Placement(transformation(extent={{90,-4},{102,8}})));
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
    annotation (Line(points={{-91,115},{-82,115},{-82,112},{-77,112}},
                                                   color={0,0,127}));
  connect(leaBoiNomCap.y, staOneBoiMinCap.u2) annotation (Line(points={{-81,99},
          {-78,99},{-78,106},{-77,106}},  color={0,0,127}));
  connect(greEqu.y, swi.u2)
    annotation (Line(points={{-49,105},{-43,105}},
                                                 color={255,0,255}));
  connect(lagBoiFirMin.y, greEqu.u2) annotation (Line(points={{-93,85},{-80,85},
          {-80,101},{-61,101}}, color={0,0,127}));
  connect(swi.u1, staOneBoiMinCap.u1) annotation (Line(points={{-43,109},{-48,
          109},{-48,118},{-82,118},{-82,112},{-77,112}},
                                                   color={0,0,127}));
  connect(swi.u3, greEqu.u2) annotation (Line(points={{-43,101},{-46,101},{-46,
          98},{-80,98},{-80,101},{-61,101}},
                                         color={0,0,127}));
  connect(staTwoBoiNomCap.u1, staOneBoiMinCap.u2) annotation (Line(points={{-73,92},
          {-78,92},{-78,106},{-77,106}},     color={0,0,127}));
  connect(staTwoBoiNomCap.y, staTwoBoiMinCap.u2)
    annotation (Line(points={{-61,89},{-61,84},{-55,84}}, color={0,0,127}));
  connect(swi.y, staTwoBoiMinCap.u1) annotation (Line(points={{-31,105},{-30,
          105},{-30,96},{-58,96},{-58,90},{-55,90}},
                                               color={0,0,127}));
  connect(greEqu.u1, staOneBoiMinCap.u1) annotation (Line(points={{-61,105},{
          -62,105},{-62,118},{-82,118},{-82,112},{-77,112}}, color={0,0,127}));
  connect(lagBoiMinFloRat.y, add1.u1) annotation (Line(points={{47,-131},{50,
          -131},{50,-128},{51,-128}},
                              color={0,0,127}));
  connect(leaBoiMinFloRat.y, add1.u2) annotation (Line(points={{29,-137},{30,
          -137},{30,-136},{32,-136},{32,-142},{48,-142},{48,-134},{51,-134}},
                                              color={0,0,127}));
  connect(add1.y, swi2.u1) annotation (Line(points={{63,-131},{64,-131},{64,
          -132},{66,-132},{66,-125},{69,-125}},
                   color={0,0,127}));
  connect(swi2.u3, add1.u2) annotation (Line(points={{69,-133},{64,-133},{64,
          -138},{48,-138},{48,-134},{51,-134}},
                                   color={0,0,127}));
  connect(staOneBoiMinCap.y, swi1.u3) annotation (Line(points={{-65,109},{-64,
          109},{-64,114},{-26,114},{-26,95.2},{-19.2,95.2}},        color={0,0,
          127}));
  connect(staTwoBoiMinCap.y, swi1.u1) annotation (Line(points={{-43,87},{-24,87},
          {-24,104.8},{-19.2,104.8}},
                           color={0,0,127}));
  connect(lagBoiNomCap.y, staTwoBoiNomCap.u2) annotation (Line(points={{-81,69},
          {-80,69},{-80,84},{-78,84},{-78,86},{-73,86}},
                                       color={0,0,127}));
  connect(gai1.u, swi1.u1) annotation (Line(points={{45,127},{40,127},{40,90},{
          -22,90},{-22,104.8},{-19.2,104.8}},
                                   color={0,0,127}));
  connect(gai2.u, swi1.u1) annotation (Line(points={{45,77},{40,77},{40,90},{
          -22,90},{-22,104.8},{-19.2,104.8}},
                                color={0,0,127}));
  connect(swi2.y, hotWatMinFloSetPoi) annotation (Line(points={{81,-129},{84,
          -129},{84,-80},{140,-80}},
                               color={0,0,127}));
  connect(bypValCloVal.y, lesEqu.u2) annotation (Line(points={{-88,-204},{-84,
          -204},{-84,-192},{-80,-192}}, color={0,0,127}));
  connect(lesEqu.u1, yBypValPos) annotation (Line(points={{-80,-184},{-116,-184},
          {-116,-200},{-140,-200}}, color={0,0,127}));
  connect(qReqSam.u, gai.y)
    annotation (Line(points={{-18,148},{-24,148}}, color={0,0,127}));
  connect(qReqSam.y, movMea.u)
    annotation (Line(points={{6,148},{12,148}}, color={0,0,127}));
  connect(boiAlaSta_a, not1.u)
    annotation (Line(points={{-140,-40},{-119.2,-40}}, color={255,0,255}));
  connect(not2.u, boiAlaSta_b)
    annotation (Line(points={{-117.2,-102},{-118,-102},{-118,-80},{-140,-80}},
                                                       color={255,0,255}));
  connect(edg.y, or2.u1)
    annotation (Line(points={{-80.8,26},{-75.2,26}}, color={255,0,255}));
  connect(or2.y, lat.u)
    annotation (Line(points={{-60.8,26},{-55.2,26}}, color={255,0,255}));
  connect(lat.y, tim.u)
    annotation (Line(points={{-40.8,26},{-33.2,26}}, color={255,0,255}));
  connect(tim.y, greEqu1.u1)
    annotation (Line(points={{-18.8,26},{-11.2,26}},
                                                   color={0,0,127}));
  connect(or1.y, lat1.u)
    annotation (Line(points={{-58.8,4},{-55.2,4}}, color={255,0,255}));
  connect(lat1.y, tim1.u) annotation (Line(points={{-40.8,4},{-36,4},{-36,2},{
          -33.2,2}}, color={255,0,255}));
  connect(minStaRun.y, greEqu2.u2) annotation (Line(points={{-86.8,-18},{-84,
          -18},{-84,-22},{-14,-22},{-14,-2},{-12,-2},{-12,-2.8},{-11.2,-2.8}},
                                                                         color=
          {0,0,127}));
  connect(tim1.y, greEqu2.u1)
    annotation (Line(points={{-18.8,2},{-11.2,2}},
                                                 color={0,0,127}));
  connect(greEqu1.u2, greEqu2.u2) annotation (Line(points={{-11.2,21.2},{-14,
          21.2},{-14,-2},{-12,-2},{-12,-2.8},{-11.2,-2.8}},
                                                color={0,0,127}));
  connect(greEqu2.y, or3.u2) annotation (Line(points={{3.2,2},{3.2,11.2},{4.8,
          11.2}},      color={255,0,255}));
  connect(greEqu1.y, or3.u1) annotation (Line(points={{3.2,26},{3.2,16},{4.8,16}},
                color={255,0,255}));
  connect(or3.y, or5.u1) annotation (Line(points={{19.2,16},{22,16},{22,-6},{
          -74,-6},{-74,-14},{-73.2,-14}}, color={255,0,255}));
  connect(or5.y, lat1.clr) annotation (Line(points={{-58.8,-14},{-56,-14},{-56,
          0.4},{-55.2,0.4}}, color={255,0,255}));
  connect(or4.u2, or5.u1) annotation (Line(points={{-75.2,41.2},{-76,41.2},{-76,
          38},{22,38},{22,-6},{-74,-6},{-74,-14},{-73.2,-14}}, color={255,0,255}));
  connect(or4.y, lat.clr) annotation (Line(points={{-60.8,46},{-58,46},{-58,22},
          {-56,22},{-56,22.4},{-55.2,22.4}}, color={255,0,255}));
  connect(falEdg.y, or1.u1)
    annotation (Line(points={{-80.8,4},{-73.2,4}}, color={255,0,255}));
  connect(gre.u1, greEqu1.u1) annotation (Line(points={{-13.2,48},{-18,48},{-18,
          26},{-11.2,26}},
                         color={0,0,127}));
  connect(gre.u2, greEqu2.u1) annotation (Line(points={{-13.2,43.2},{-16,43.2},
          {-16,2},{-11.2,2}},
                           color={0,0,127}));
  connect(les.u1, greEqu1.u1) annotation (Line(points={{-9.2,-14},{-18,-14},{
          -18,26},{-11.2,26}},
                             color={0,0,127}));
  connect(les.u2, greEqu2.u1) annotation (Line(points={{-9.2,-18.8},{-10,-18.8},
          {-10,-18},{-16,-18},{-16,2},{-11.2,2}},
                            color={0,0,127}));
  connect(gre.y, logSwi.u2)
    annotation (Line(points={{1.2,48},{2.8,48}},  color={255,0,255}));
  connect(logSwi.u1, tim.u) annotation (Line(points={{2.8,52.8},{2,52.8},{2,56},
          {-16,56},{-16,50},{-38,50},{-38,26},{-33.2,26}},
                           color={255,0,255}));
  connect(logSwi.y, logSwi1.u3) annotation (Line(points={{17.2,48},{18,48},{18,
          43.2},{24.8,43.2}}, color={255,0,255}));
  connect(les.y, logSwi1.u2) annotation (Line(points={{5.2,-14},{24,-14},{24,48},
          {24.8,48}}, color={255,0,255}));
  connect(logSwi.u3, falEdg.u) annotation (Line(points={{2.8,43.2},{2,43.2},{2,
          40},{-50,40},{-50,36},{-98,36},{-98,4},{-95.2,4}}, color={255,0,255}));
  connect(edg.u, falEdg.u) annotation (Line(points={{-95.2,26},{-98,26},{-98,4},
          {-95.2,4}}, color={255,0,255}));
  connect(logSwi1.u1, tim1.u) annotation (Line(points={{24.8,52.8},{18,52.8},{
          18,58},{-18,58},{-18,52},{-36,52},{-36,2},{-33.2,2}},
                             color={255,0,255}));
  connect(boiEnaSig, falEdg.u) annotation (Line(points={{-140,0},{-118,0},{-118,
          4},{-95.2,4}}, color={255,0,255}));
  connect(edg1.y, or2.u2) annotation (Line(points={{-100.8,20},{-96,20},{-96,14},
          {-76,14},{-76,22},{-75.2,22},{-75.2,21.2}}, color={255,0,255}));
  connect(falEdg1.y, or1.u2) annotation (Line(points={{-100.8,-8},{-80,-8},{-80,
          -0.8},{-73.2,-0.8}}, color={255,0,255}));
  connect(or4.u1, or1.u2) annotation (Line(points={{-75.2,46},{-78,46},{-78,
          -0.8},{-73.2,-0.8}}, color={255,0,255}));
  connect(or5.u2, or2.u2) annotation (Line(points={{-73.2,-18.8},{-76,-18.8},{
          -76,22},{-75.2,22},{-75.2,21.2}}, color={255,0,255}));
  connect(pumProSig_a, leaBoiEnaSig) annotation (Line(points={{-140,-120},{80,
          -120},{80,20},{28,20},{28,38},{82,38},{82,40},{140,40}},      color={
          255,0,255}));
  connect(or6.u1, edg1.u) annotation (Line(points={{88.8,66},{58,66},{58,60},{
          -20,60},{-20,54},{-80,54},{-80,38},{-114,38},{-114,20},{-115.2,20}},
                                                              color={255,0,255}));
  connect(falEdg1.u, edg1.u) annotation (Line(points={{-115.2,-8},{-116,-8},{
          -116,20},{-115.2,20}}, color={255,0,255}));
  connect(or6.y, and2.u1)
    annotation (Line(points={{103.2,66},{104,66},{104,62},{104.8,62}},
                                                   color={255,0,255}));
  connect(and2.y, leaBoiIsoValSig) annotation (Line(points={{119.2,62},{120,62},
          {120,80},{140,80}}, color={255,0,255}));
  connect(and2.u2, not1.y) annotation (Line(points={{104.8,57.2},{104,57.2},{
          104,58},{62,58},{62,40},{26,40},{26,-20},{-86,-20},{-86,-28},{-104,
          -28},{-104,-40},{-104.8,-40}},                          color={255,0,
          255}));
  connect(falEdg2.y, truHol.u)
    annotation (Line(points={{45.2,28},{48.8,28}}, color={255,0,255}));
  connect(truHol.y, or6.u2) annotation (Line(points={{63.2,28},{64,28},{64,44},
          {60,44},{60,61.2},{88.8,61.2}}, color={255,0,255}));
  connect(falEdg2.u, leaBoiEnaSig) annotation (Line(points={{30.8,28},{28,28},{
          28,38},{82,38},{82,40},{140,40}}, color={255,0,255}));
  connect(or7.u1, edg2.y)
    annotation (Line(points={{-71.2,-54},{-74.8,-54}}, color={255,0,255}));
  connect(lat2.u, or7.y)
    annotation (Line(points={{-53.2,-54},{-56.8,-54}}, color={255,0,255}));
  connect(or8.u1, falEdg3.y)
    annotation (Line(points={{-71.2,-74},{-74.8,-74}}, color={255,0,255}));
  connect(or8.y, lat3.u)
    annotation (Line(points={{-56.8,-74},{-53.2,-74}}, color={255,0,255}));
  connect(logSwi1.y, pre.u)
    annotation (Line(points={{39.2,48},{40.8,48}}, color={255,0,255}));
  connect(pre.y, edg1.u) annotation (Line(points={{55.2,48},{58,48},{58,60},{
          -20,60},{-20,54},{-80,54},{-80,38},{-114,38},{-114,20},{-115.2,20}},
        color={255,0,255}));
  connect(lat2.y, tim2.u)
    annotation (Line(points={{-38.8,-54},{-35.2,-54}}, color={255,0,255}));
  connect(lat3.y, tim3.u)
    annotation (Line(points={{-38.8,-74},{-35.2,-74}}, color={255,0,255}));
  connect(tim2.y, greEqu3.u1)
    annotation (Line(points={{-20.8,-54},{-15.2,-54}}, color={0,0,127}));
  connect(tim3.y, greEqu4.u1)
    annotation (Line(points={{-20.8,-74},{-15.2,-74}}, color={0,0,127}));
  connect(or11.u1, greEqu3.y) annotation (Line(points={{0.8,-62},{0,-62},{0,-54},
          {-0.8,-54}}, color={255,0,255}));
  connect(or11.u2, greEqu4.y) annotation (Line(points={{0.8,-66.8},{0,-66.8},{0,
          -74},{-0.8,-74}}, color={255,0,255}));
  connect(or11.y, or10.u2) annotation (Line(points={{15.2,-62},{16,-62},{16,-44},
          {-72,-44},{-72,-40.8},{-71.2,-40.8}}, color={255,0,255}));
  connect(or9.u1, or11.y) annotation (Line(points={{-71.2,-90},{-72,-90},{-72,
          -82},{16,-82},{16,-62},{15.2,-62}}, color={255,0,255}));
  connect(gre1.u1, tim2.y) annotation (Line(points={{-15.2,-36},{-20,-36},{-20,
          -54},{-20.8,-54}}, color={0,0,127}));
  connect(gre1.u2, greEqu4.u1) annotation (Line(points={{-15.2,-40.8},{-18,
          -40.8},{-18,-74},{-15.2,-74}}, color={0,0,127}));
  connect(les1.u1, greEqu3.u1) annotation (Line(points={{-15.2,-90},{-20,-90},{
          -20,-54},{-15.2,-54}}, color={0,0,127}));
  connect(les1.u2, greEqu4.u1) annotation (Line(points={{-15.2,-94.8},{-18,
          -94.8},{-18,-74},{-15.2,-74}}, color={0,0,127}));
  connect(gre1.y, logSwi2.u2)
    annotation (Line(points={{-0.8,-36},{2.8,-36}}, color={255,0,255}));
  connect(logSwi2.u1, tim2.u) annotation (Line(points={{2.8,-31.2},{0,-31.2},{0,
          -28},{-16,-28},{-16,-34},{-22,-34},{-22,-42},{-38,-42},{-38,-54},{
          -35.2,-54}}, color={255,0,255}));
  connect(logSwi2.u3, edg2.u) annotation (Line(points={{2.8,-40.8},{0,-40.8},{0,
          -46},{-90,-46},{-90,-54},{-89.2,-54}}, color={255,0,255}));
  connect(logSwi2.y, logSwi3.u3) annotation (Line(points={{17.2,-36},{18,-36},{
          18,-40.8},{22.8,-40.8}}, color={255,0,255}));
  connect(logSwi3.u2, les1.y) annotation (Line(points={{22.8,-36},{20,-36},{20,
          -86},{0,-86},{0,-90},{-0.8,-90}}, color={255,0,255}));
  connect(logSwi3.u1, tim3.u) annotation (Line(points={{22.8,-31.2},{22,-31.2},
          {22,-84},{-38,-84},{-38,-74},{-35.2,-74}}, color={255,0,255}));
  connect(or9.y, lat3.clr) annotation (Line(points={{-56.8,-90},{-56,-90},{-56,
          -77.6},{-53.2,-77.6}}, color={255,0,255}));
  connect(or10.y, lat2.clr) annotation (Line(points={{-56.8,-36},{-56,-36},{-56,
          -57.6},{-53.2,-57.6}}, color={255,0,255}));
  connect(logSwi3.y, pre1.u)
    annotation (Line(points={{37.2,-36},{38.8,-36}}, color={255,0,255}));
  connect(falEdg3.u, edg2.u) annotation (Line(points={{-89.2,-74},{-90,-74},{
          -90,-54},{-89.2,-54}}, color={255,0,255}));
  connect(pre1.y, edg3.u) annotation (Line(points={{53.2,-36},{54,-36},{54,-26},
          {-18,-26},{-18,-32},{-24,-32},{-24,-48},{-106,-48},{-106,-60},{-105.2,
          -60}}, color={255,0,255}));
  connect(falEdg4.u, edg3.u) annotation (Line(points={{-105.2,-80},{-106,-80},{
          -106,-60},{-105.2,-60}}, color={255,0,255}));
  connect(edg3.y, or7.u2) annotation (Line(points={{-90.8,-60},{-72,-60},{-72,
          -58.8},{-71.2,-58.8}}, color={255,0,255}));
  connect(falEdg4.y, or8.u2) annotation (Line(points={{-90.8,-80},{-72,-80},{
          -72,-78.8},{-71.2,-78.8}}, color={255,0,255}));
  connect(or9.u2, or7.u2) annotation (Line(points={{-71.2,-94.8},{-74,-94.8},{
          -74,-60},{-72,-60},{-72,-58.8},{-71.2,-58.8}}, color={255,0,255}));
  connect(or10.u1, or8.u2) annotation (Line(points={{-71.2,-36},{-71.2,-36},{
          -71.2,-78.8}}, color={255,0,255}));
  connect(lagBoiIsoValSig, and1.y)
    annotation (Line(points={{140,0},{119.2,0}}, color={255,0,255}));
  connect(not2.y, and1.u2) annotation (Line(points={{-102.8,-102},{-100,-102},{
          -100,-98},{2,-98},{2,-88},{24,-88},{24,-44},{56,-44},{56,-4.8},{104.8,
          -4.8}}, color={255,0,255}));
  connect(or12.y, and1.u1) annotation (Line(points={{103.2,2},{104,2},{104,0},{
          104.8,0}}, color={255,0,255}));
  connect(or12.u2, edg3.u) annotation (Line(points={{88.8,-2.8},{54,-2.8},{54,
          -26},{-18,-26},{-18,-32},{-24,-32},{-24,-48},{-106,-48},{-106,-60},{
          -105.2,-60}}, color={255,0,255}));
  connect(greEqu3.u2, greEqu2.u2) annotation (Line(points={{-15.2,-58.8},{-16,
          -58.8},{-16,-22},{-14,-22},{-14,-2},{-12,-2},{-12,-2.8},{-11.2,-2.8}},
        color={0,0,127}));
  connect(greEqu4.u2, greEqu2.u2) annotation (Line(points={{-15.2,-78.8},{-16,
          -78.8},{-16,-22},{-14,-22},{-14,-2},{-12,-2},{-12,-2.8},{-11.2,-2.8}},
        color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-120,
            -220},{120,180}})), Diagram(coordinateSystem(preserveAspectRatio=
            false, extent={{-120,-220},{120,180}})));
end BoilerStagingController_v2;
