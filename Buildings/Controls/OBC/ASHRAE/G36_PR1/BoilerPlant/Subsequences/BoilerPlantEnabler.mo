within Buildings.Controls.OBC.ASHRAE.G36_PR1.BoilerPlant.Subsequences;
model BoilerPlantEnabler
  parameter Integer numHotWatReqIgnVal(start=0, min=0)
  "Number of hot-water requests to be ignored before turning on boiler plant loop";
  parameter Modelica.SIunits.Temperature boiLocOutAirTemVal(start=29.444)
  "Boiler lock-out temperature for outdoor air";
  parameter Modelica.SIunits.Time boiPlaOffStaHolTimVal( start=15*60, min=0)
  "Minimum time for which the boiler plant has to stay off once it has been switched off";
  parameter Modelica.SIunits.Time boiPlaOnStaHolTimVal( start=15*60, min=0)
  "Minimum time for which the boiler plant has to stay on once it has been switched on";
  CDL.Interfaces.RealInput uOutAirTem "Outdoor air temperature"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  CDL.Interfaces.BooleanInput boiPlaEnaSig
    "Signal enabling boiler plant to be turned on"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  CDL.Interfaces.BooleanOutput boiEnaSig "Boiler enable signal"
    annotation (Placement(transformation(extent={{140,-20},{180,20}})));
  CDL.Continuous.Sources.Constant boiLocOutAirTem(k=boiLocOutAirTemVal)
    "Outdoor air temperature for boiler lockout"
    annotation (Placement(transformation(extent={{-94,-40},{-74,-20}})));
  CDL.Integers.Greater intGre
    "Check to ensure number of requests is greater than number of ignores"
    annotation (Placement(transformation(extent={{-58,22},{-38,42}})));
  CDL.Integers.Sources.Constant numHotWatReqIgn(k=numHotWatReqIgnVal)
    "Number of hot-water requests to be ignored"
    annotation (Placement(transformation(extent={{-88,18},{-68,38}})));
  CDL.Interfaces.BooleanInput hotWatReq
    "Hot-water request signal from heating coil"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  CDL.Continuous.MovingMean movMea(delta=3*60)
    "Block that counts number of requests in the previous 3 minutes"
    annotation (Placement(transformation(extent={{-58,156},{-38,176}})));
  CDL.Conversions.BooleanToReal booToRea
    "Convert boolean request into real pulse"
    annotation (Placement(transformation(extent={{-86,156},{-66,176}})));
  CDL.Continuous.Greater gre
    "Check to make sure more hot water requests than number of ignored requests have been received in last 3 minutes"
    annotation (Placement(transformation(extent={{16,182},{36,202}})));
  CDL.Continuous.Sources.Constant con(k=numHotWatReqIgnVal/(3*60))
    "Number of hot water requests in last 3 minutes to be ignored"
    annotation (Placement(transformation(extent={{-16,138},{4,158}})));
  CDL.Logical.And and2
    "Combination of number of requests and outdoor air conditions"
    annotation (Placement(transformation(extent={{44,176},{64,196}})));
  CDL.Continuous.Sources.Constant con1(k=boiLocOutAirTemVal - (1/1.8))
    "Boiler lockout temperature-1"
    annotation (Placement(transformation(extent={{-84,86},{-64,106}})));
  CDL.Continuous.LessEqual lesEqu1
    "Check to make sure outdoor air temperature is less than boiler lockout temperature-1"
    annotation (Placement(transformation(extent={{-82,118},{-62,138}})));
  CDL.Integers.OnCounter onCouInt
    "Number of requests counter when boiler-plant is off"
    annotation (Placement(transformation(extent={{-86,54},{-74,66}})));
  CDL.Logical.And and1
    "Combination of number of requests and boiler lockout temperature conditions"
    annotation (Placement(transformation(extent={{-32,4},{-12,24}})));
  CDL.Continuous.Less les
    "Check to make sure outdoor air temperature is less than boiler lockout temperature"
    annotation (Placement(transformation(extent={{-66,-10},{-46,10}})));
  CDL.Logical.FallingEdge falEdg
    annotation (Placement(transformation(extent={{22,-30},{42,-10}})));
  CDL.Logical.TrueHoldWithReset boiPlaOffStaHolTim(duration=
        boiPlaOffStaHolTimVal) "Boiler-plant off status hold time"
    annotation (Placement(transformation(extent={{52,-30},{72,-10}})));
  CDL.Logical.Not not1
    annotation (Placement(transformation(extent={{14,-64},{34,-44}})));
  CDL.Logical.LogicalSwitch logSwi
    annotation (Placement(transformation(extent={{42,-72},{62,-52}})));
  CDL.Logical.Edge edg
    annotation (Placement(transformation(extent={{-92,-98},{-72,-78}})));
  CDL.Logical.TrueHoldWithReset boiPlaOnStaHolTim(duration=boiPlaOnStaHolTimVal)
    "Boiler-plant on status hold time"
    annotation (Placement(transformation(extent={{-64,-98},{-44,-78}})));
  CDL.Logical.LogicalSwitch logSwi1
    annotation (Placement(transformation(extent={{6,-98},{26,-78}})));
  CDL.Logical.LogicalSwitch logSwi2
    annotation (Placement(transformation(extent={{18,40},{38,60}})));
  CDL.Logical.And and3
    annotation (Placement(transformation(extent={{20,0},{40,20}})));
  CDL.Logical.Timer tim(accumulate=true)
    annotation (Placement(transformation(extent={{72,-62},{92,-42}})));
  CDL.Logical.Timer tim1(accumulate=true)
    annotation (Placement(transformation(extent={{68,-90},{88,-70}})));
  CDL.Logical.LogicalSwitch logSwi3
    annotation (Placement(transformation(extent={{110,-82},{130,-62}})));
  CDL.Logical.Edge edg1
    annotation (Placement(transformation(extent={{-46,98},{-26,118}})));
  CDL.Logical.TrueHoldWithReset truHol(duration=3*60)
    annotation (Placement(transformation(extent={{-16,98},{4,118}})));
  CDL.Logical.Switch swi
    annotation (Placement(transformation(extent={{-28,164},{-8,184}})));
  CDL.Continuous.Sources.Constant con2(k=(numHotWatReqIgnVal + 1)/(3*60))
    annotation (Placement(transformation(extent={{-84,186},{-64,206}})));
  CDL.Continuous.GreaterEqual greEqu
    annotation (Placement(transformation(extent={{86,-10},{106,10}})));
  CDL.Logical.Pre pre
    annotation (Placement(transformation(extent={{112,14},{132,34}})));
  CDL.Logical.Change cha
    annotation (Placement(transformation(extent={{50,84},{70,104}})));
  CDL.Logical.Change cha1
    annotation (Placement(transformation(extent={{-28,46},{-8,66}})));
  CDL.Logical.Or or2
    annotation (Placement(transformation(extent={{78,50},{98,70}})));
  CDL.Logical.LogicalSwitch logSwi4
    annotation (Placement(transformation(extent={{108,78},{128,98}})));
  CDL.Logical.LogicalSwitch logSwi5
    annotation (Placement(transformation(extent={{110,42},{130,62}})));
  CDL.Logical.Sources.Constant con3(k=false)
    annotation (Placement(transformation(extent={{104,124},{124,144}})));
  CDL.Logical.FallingEdge falEdg1
    annotation (Placement(transformation(extent={{20,98},{32,110}})));
  CDL.Logical.Or or1
    annotation (Placement(transformation(extent={{34,78},{44,88}})));
  CDL.Logical.Edge edg2
    annotation (Placement(transformation(extent={{80,20},{90,30}})));
  CDL.Logical.Or or3
    annotation (Placement(transformation(extent={{44,-114},{54,-104}})));
equation
  connect(numHotWatReqIgn.y, intGre.u2) annotation (Line(points={{-66,28},{-64,28},
          {-64,24},{-60,24}}, color={255,127,0}));
  connect(booToRea.u, hotWatReq) annotation (Line(points={{-88,166},{-98,166},{-98,
          80},{-120,80}}, color={255,0,255}));
  connect(booToRea.y, movMea.u) annotation (Line(points={{-64,166},{-60,166}},
                           color={0,0,127}));
  connect(con1.y, lesEqu1.u2) annotation (Line(points={{-62,96},{-56,96},{-56,114},
          {-88,114},{-88,120},{-84,120}}, color={0,0,127}));
  connect(lesEqu1.u1, uOutAirTem) annotation (Line(points={{-84,128},{-94,128},{
          -94,0},{-120,0}}, color={0,0,127}));
  connect(onCouInt.trigger, hotWatReq) annotation (Line(points={{-87.2,60},{-92,
          60},{-92,80},{-120,80}}, color={255,0,255}));
  connect(onCouInt.y, intGre.u1) annotation (Line(points={{-72.8,60},{-66,60},{-66,
          32},{-60,32}}, color={255,127,0}));
  connect(and1.u1, intGre.y) annotation (Line(points={{-34,14},{-36,14},{-36,32},
          {-36,32}}, color={255,0,255}));
  connect(les.y, and1.u2) annotation (Line(points={{-44,0},{-40,0},{-40,6},{-34,
          6}}, color={255,0,255}));
  connect(boiLocOutAirTem.y, les.u2) annotation (Line(points={{-72,-30},{-70,-30},
          {-70,-8},{-68,-8}}, color={0,0,127}));
  connect(les.u1, uOutAirTem)
    annotation (Line(points={{-68,0},{-120,0}}, color={0,0,127}));
  connect(falEdg.y, boiPlaOffStaHolTim.u)
    annotation (Line(points={{44,-20},{50,-20}}, color={255,0,255}));
  connect(not1.y, logSwi.u1)
    annotation (Line(points={{36,-54},{40,-54}}, color={255,0,255}));
  connect(boiPlaOffStaHolTim.y, not1.u) annotation (Line(points={{74,-20},{78,
          -20},{78,-36},{8,-36},{8,-54},{12,-54}},
                                                color={255,0,255}));
  connect(logSwi.u2, not1.u) annotation (Line(points={{40,-62},{36,-62},{36,-68},
          {8,-68},{8,-54},{12,-54}},   color={255,0,255}));
  connect(edg.y, boiPlaOnStaHolTim.u)
    annotation (Line(points={{-70,-88},{-66,-88}}, color={255,0,255}));
  connect(logSwi1.u1, logSwi1.u2) annotation (Line(points={{4,-80},{-30,-80},{
          -30,-88},{4,-88}},
                         color={255,0,255}));
  connect(logSwi2.y, and3.u1) annotation (Line(points={{40,50},{44,50},{44,28},{
          12,28},{12,10},{18,10}}, color={255,0,255}));
  connect(boiPlaEnaSig, and3.u2) annotation (Line(points={{-120,-60},{2,-60},{2,
          2},{18,2}}, color={255,0,255}));
  connect(tim.u, not1.u) annotation (Line(points={{70,-52},{70,-36},{8,-36},{8,
          -54},{12,-54}},          color={255,0,255}));
  connect(tim1.u, logSwi1.u2) annotation (Line(points={{66,-80},{30,-80},{30,
          -72},{-34,-72},{-34,-88},{4,-88}},
                                      color={255,0,255}));
  connect(logSwi.y, logSwi3.u1) annotation (Line(points={{64,-62},{66,-62},{66,
          -64},{108,-64}},
                      color={255,0,255}));
  connect(logSwi1.y, logSwi3.u3) annotation (Line(points={{28,-88},{62,-88},{62,
          -98},{96,-98},{96,-80},{108,-80}}, color={255,0,255}));
  connect(boiEnaSig, boiEnaSig)
    annotation (Line(points={{160,0},{160,0}}, color={255,0,255}));
  connect(con.y, gre.u2) annotation (Line(points={{6,148},{8,148},{8,184},{14,184}},
        color={0,0,127}));
  connect(lesEqu1.y, and2.u2) annotation (Line(points={{-60,128},{34,128},{34,178},
          {42,178}}, color={255,0,255}));
  connect(gre.y, and2.u1) annotation (Line(points={{38,192},{40,192},{40,186},{42,
          186}}, color={255,0,255}));
  connect(edg1.y, truHol.u)
    annotation (Line(points={{-24,108},{-18,108}}, color={255,0,255}));
  connect(movMea.y, swi.u3)
    annotation (Line(points={{-36,166},{-30,166}}, color={0,0,127}));
  connect(truHol.y, swi.u2) annotation (Line(points={{6,108},{12,108},{12,132},{
          -34,132},{-34,174},{-30,174}}, color={255,0,255}));
  connect(con2.y, swi.u1) annotation (Line(points={{-62,196},{-38,196},{-38,182},
          {-30,182}}, color={0,0,127}));
  connect(swi.y, gre.u1) annotation (Line(points={{-6,174},{-4,174},{-4,192},{14,
          192}}, color={0,0,127}));
  connect(logSwi1.u3, and3.y) annotation (Line(points={{4,-96},{0,-96},{0,-70},
          {6,-70},{6,-2},{46,-2},{46,10},{42,10}}, color={255,0,255}));
  connect(falEdg.u, and3.y) annotation (Line(points={{20,-20},{6,-20},{6,-2},{
          46,-2},{46,10},{42,10}}, color={255,0,255}));
  connect(logSwi.u3, and3.y) annotation (Line(points={{40,-70},{6,-70},{6,-2},{
          46,-2},{46,10},{42,10}}, color={255,0,255}));
  connect(edg.u, and3.y) annotation (Line(points={{-94,-88},{-98,-88},{-98,-70},
          {6,-70},{6,-2},{46,-2},{46,10},{42,10}}, color={255,0,255}));
  connect(boiPlaOnStaHolTim.y, logSwi1.u2)
    annotation (Line(points={{-42,-88},{4,-88}}, color={255,0,255}));
  connect(and2.y, logSwi2.u1) annotation (Line(points={{66,186},{70,186},{70,
          172},{38,172},{38,124},{14,124},{14,58},{16,58}}, color={255,0,255}));
  connect(and1.y, logSwi2.u3) annotation (Line(points={{-10,14},{4,14},{4,42},{
          16,42}}, color={255,0,255}));
  connect(tim.y, greEqu.u1) annotation (Line(points={{94,-52},{98,-52},{98,-16},
          {78,-16},{78,0},{84,0}}, color={0,0,127}));
  connect(tim1.y, greEqu.u2) annotation (Line(points={{90,-80},{94,-80},{94,-76},
          {96,-76},{96,-18},{80,-18},{80,-8},{84,-8}}, color={0,0,127}));
  connect(greEqu.y, logSwi3.u2) annotation (Line(points={{108,0},{108,-60},{104,
          -60},{104,-72},{108,-72}}, color={255,0,255}));
  connect(logSwi3.y, boiEnaSig) annotation (Line(points={{132,-72},{136,-72},{
          136,0},{160,0}}, color={255,0,255}));
  connect(pre.u, boiEnaSig) annotation (Line(points={{110,24},{106,24},{106,12},
          {136,12},{136,0},{160,0}}, color={255,0,255}));
  connect(pre.y, logSwi2.u2) annotation (Line(points={{134,24},{136,24},{136,38},
          {10,38},{10,50},{16,50}}, color={255,0,255}));
  connect(onCouInt.reset, logSwi2.u2)
    annotation (Line(points={{-80,52.8},{-80,50},{16,50}}, color={255,0,255}));
  connect(edg1.u, logSwi2.u2) annotation (Line(points={{-48,108},{-52,108},{-52,
          94},{10,94},{10,50},{16,50}}, color={255,0,255}));
  connect(cha.u, logSwi2.u1) annotation (Line(points={{48,94},{14,94},{14,58},{
          16,58}}, color={255,0,255}));
  connect(cha1.u, logSwi2.u3) annotation (Line(points={{-30,56},{-34,56},{-34,
          38},{-8,38},{-8,14},{4,14},{4,42},{16,42}}, color={255,0,255}));
  connect(cha1.y, or2.u2) annotation (Line(points={{-6,56},{2,56},{2,66},{50,66},
          {50,52},{76,52}}, color={255,0,255}));
  connect(cha.y, or2.u1) annotation (Line(points={{72,94},{74,94},{74,60},{76,
          60}}, color={255,0,255}));
  connect(or2.y, logSwi5.u1)
    annotation (Line(points={{100,60},{108,60}}, color={255,0,255}));
  connect(logSwi4.u3, logSwi5.u1) annotation (Line(points={{106,80},{102,80},{
          102,60},{108,60}}, color={255,0,255}));
  connect(con3.y, logSwi4.u1) annotation (Line(points={{126,134},{128,134},{128,
          118},{104,118},{104,96},{106,96}}, color={255,0,255}));
  connect(logSwi5.u3, logSwi4.u1) annotation (Line(points={{108,44},{104,44},{
          104,96},{106,96}}, color={255,0,255}));
  connect(logSwi4.u2, logSwi3.u2) annotation (Line(points={{106,88},{88,88},{88,
          80},{68,80},{68,8},{82,8},{82,-12},{108,-12},{108,-60},{104,-60},{104,
          -72},{108,-72}}, color={255,0,255}));
  connect(logSwi5.u2, logSwi3.u2) annotation (Line(points={{108,52},{100,52},{
          100,46},{68,46},{68,8},{82,8},{82,-12},{108,-12},{108,-60},{104,-60},
          {104,-72},{108,-72}}, color={255,0,255}));
  connect(falEdg1.u, logSwi2.u2) annotation (Line(points={{18.8,104},{10,104},{
          10,50},{16,50}}, color={255,0,255}));
  connect(falEdg1.y, or1.u1) annotation (Line(points={{33.2,104},{36,104},{36,
          92},{28,92},{28,83},{33,83}}, color={255,0,255}));
  connect(or1.u2, logSwi4.y) annotation (Line(points={{33,79},{26,79},{26,96},{
          46,96},{46,114},{134,114},{134,88},{130,88}}, color={255,0,255}));
  connect(or1.y, tim.reset) annotation (Line(points={{45,83},{48,83},{48,-46},{
          64,-46},{64,-60},{70,-60}}, color={255,0,255}));
  connect(edg2.u, logSwi2.u2) annotation (Line(points={{79,25},{72,25},{72,38},
          {10,38},{10,50},{16,50}}, color={255,0,255}));
  connect(edg2.y, or3.u2) annotation (Line(points={{91,25},{108,25},{108,10},{
          138,10},{138,-110},{60,-110},{60,-118},{40,-118},{40,-113},{43,-113}},
        color={255,0,255}));
  connect(logSwi5.y, or3.u1) annotation (Line(points={{132,52},{134,52},{134,
          -100},{40,-100},{40,-109},{43,-109}}, color={255,0,255}));
  connect(or3.y, tim1.reset) annotation (Line(points={{55,-109},{66,-109},{66,
          -88}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -120},{140,220}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-120},{140,
            220}}),
        graphics={
        Rectangle(
          extent={{-90,212},{86,76}},
          lineColor={28,108,200},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-62,232},{70,184}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.None,
          textString="Calculations performed when boiler plant is enabled"),
        Rectangle(
          extent={{-98,70},{-4,-44}},
          lineColor={28,108,200},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-72,-14},{60,-62}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.None,
          fontSize=12,
          textString="Calculations performed
when boiler plant is disabled",
          horizontalAlignment=TextAlignment.Left)}));
end BoilerPlantEnabler;
