within Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Subsequences;
model BoilerPlantEnabler_v2
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
  CDL.Logical.LogicalSwitch logSwi2
    annotation (Placement(transformation(extent={{18,40},{38,60}})));
  CDL.Logical.And and3
    annotation (Placement(transformation(extent={{8,-26},{28,-6}})));
  CDL.Logical.Edge edg1
    annotation (Placement(transformation(extent={{-46,98},{-26,118}})));
  CDL.Logical.TrueHoldWithReset truHol(duration=3*60)
    annotation (Placement(transformation(extent={{-16,98},{4,118}})));
  CDL.Logical.Switch swi
    annotation (Placement(transformation(extent={{-28,164},{-8,184}})));
  CDL.Continuous.Sources.Constant con2(k=(numHotWatReqIgnVal + 1)/(3*60))
    annotation (Placement(transformation(extent={{-84,186},{-64,206}})));
  CDL.Logical.Edge edg
    annotation (Placement(transformation(extent={{-26,-74},{-6,-54}})));
  CDL.Logical.FallingEdge falEdg
    annotation (Placement(transformation(extent={{-26,-104},{-6,-84}})));
  CDL.Logical.Timer tim(accumulate=true)
    annotation (Placement(transformation(extent={{30,-104},{50,-84}})));
  CDL.Logical.Timer tim1(accumulate=true)
    annotation (Placement(transformation(extent={{30,-74},{50,-54}})));
  CDL.Logical.TrueHoldWithReset truHol1(duration=boiPlaOnStaHolTimVal)
    annotation (Placement(transformation(extent={{0,-74},{20,-54}})));
  CDL.Logical.TrueHoldWithReset truHol2(duration=boiPlaOffStaHolTimVal)
    annotation (Placement(transformation(extent={{0,-104},{20,-84}})));
  CDL.Continuous.Sources.Constant con3(k=boiPlaOffStaHolTimVal - 1)
    annotation (Placement(transformation(extent={{-98,-116},{-78,-96}})));
  CDL.Continuous.Sources.Constant con4(k=boiPlaOnStaHolTimVal - 1)
    annotation (Placement(transformation(extent={{58,-56},{78,-36}})));
  CDL.Logical.LogicalSwitch logSwi
    annotation (Placement(transformation(extent={{60,50},{80,70}})));
  CDL.Continuous.GreaterEqual greEqu1
    annotation (Placement(transformation(extent={{84,-40},{104,-20}})));
  CDL.Continuous.GreaterEqual greEqu2
    annotation (Placement(transformation(extent={{70,-112},{90,-92}})));
  CDL.Logical.LogicalSwitch logSwi1
    annotation (Placement(transformation(extent={{84,16},{104,36}})));
  CDL.Logical.Not not1
    annotation (Placement(transformation(extent={{114,-30},{134,-10}})));
  CDL.Logical.Pre pre
    annotation (Placement(transformation(extent={{10,6},{30,26}})));
  CDL.Logical.Or or1
    annotation (Placement(transformation(extent={{-54,-74},{-34,-54}})));
  CDL.Logical.And and4
    annotation (Placement(transformation(extent={{-54,-104},{-34,-84}})));
  CDL.Logical.Or or3
    annotation (Placement(transformation(extent={{114,-54},{130,-38}})));
  CDL.Logical.Or or4
    annotation (Placement(transformation(extent={{102,-110},{116,-96}})));
  CDL.Continuous.Less les1
    annotation (Placement(transformation(extent={{110,-90},{124,-78}})));
  CDL.Continuous.Greater gre1
    annotation (Placement(transformation(extent={{66,-84},{80,-68}})));
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
  connect(boiPlaEnaSig, and3.u2) annotation (Line(points={{-120,-60},{-96,-60},
          {-96,-50},{2,-50},{2,-24},{6,-24}},
                      color={255,0,255}));
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
  connect(and2.y, logSwi2.u1) annotation (Line(points={{66,186},{70,186},{70,
          172},{38,172},{38,124},{14,124},{14,58},{16,58}}, color={255,0,255}));
  connect(and1.y, logSwi2.u3) annotation (Line(points={{-10,14},{4,14},{4,42},{
          16,42}}, color={255,0,255}));
  connect(onCouInt.reset, logSwi2.u2)
    annotation (Line(points={{-80,52.8},{-80,50},{16,50}}, color={255,0,255}));
  connect(edg1.u, logSwi2.u2) annotation (Line(points={{-48,108},{-52,108},{-52,
          94},{10,94},{10,50},{16,50}}, color={255,0,255}));
  connect(truHol1.y, tim1.u)
    annotation (Line(points={{22,-64},{28,-64}}, color={255,0,255}));
  connect(edg.y, truHol1.u)
    annotation (Line(points={{-4,-64},{-2,-64}}, color={255,0,255}));
  connect(tim.u, truHol2.y)
    annotation (Line(points={{28,-94},{22,-94}}, color={255,0,255}));
  connect(falEdg.y, truHol2.u)
    annotation (Line(points={{-4,-94},{-2,-94}}, color={255,0,255}));
  connect(logSwi2.y, and3.u1) annotation (Line(points={{40,50},{44,50},{44,32},
          {2,32},{2,-16},{6,-16}}, color={255,0,255}));
  connect(logSwi.u1, truHol1.y) annotation (Line(points={{58,68},{50,68},{50,
          -42},{22,-42},{22,-64}}, color={255,0,255}));
  connect(con4.y, greEqu1.u2)
    annotation (Line(points={{80,-46},{82,-46},{82,-38}}, color={0,0,127}));
  connect(con3.y, greEqu2.u2) annotation (Line(points={{-76,-106},{-76,-110},{
          68,-110}}, color={0,0,127}));
  connect(greEqu2.u1, tim.y) annotation (Line(points={{68,-102},{64,-102},{64,
          -94},{52,-94}}, color={0,0,127}));
  connect(greEqu1.u1, tim1.y)
    annotation (Line(points={{82,-30},{52,-30},{52,-64}}, color={0,0,127}));
  connect(not1.u, truHol2.y) annotation (Line(points={{112,-20},{112,-32},{136,
          -32},{136,-116},{26,-116},{26,-94},{22,-94}}, color={255,0,255}));
  connect(pre.y, logSwi2.u2) annotation (Line(points={{32,16},{36,16},{36,36},{
          10,36},{10,50},{16,50}}, color={255,0,255}));
  connect(pre.u, boiEnaSig) annotation (Line(points={{8,16},{6,16},{6,-4},{138,
          -4},{138,0},{160,0}}, color={255,0,255}));
  connect(and3.y, logSwi.u3) annotation (Line(points={{30,-16},{56,-16},{56,52},
          {58,52}}, color={255,0,255}));
  connect(edg.u, or1.y)
    annotation (Line(points={{-28,-64},{-32,-64}}, color={255,0,255}));
  connect(or1.u1, logSwi2.u2) annotation (Line(points={{-56,-64},{-62,-64},{-62,
          -46},{36,-46},{36,36},{10,36},{10,50},{16,50}}, color={255,0,255}));
  connect(or1.u2, logSwi.u3) annotation (Line(points={{-56,-72},{-66,-72},{-66,
          -52},{34,-52},{34,-16},{56,-16},{56,52},{58,52}}, color={255,0,255}));
  connect(falEdg.u, and4.y)
    annotation (Line(points={{-28,-94},{-32,-94}}, color={255,0,255}));
  connect(and4.u1, logSwi2.u2) annotation (Line(points={{-56,-94},{-60,-94},{
          -60,-64},{-62,-64},{-62,-46},{36,-46},{36,36},{10,36},{10,50},{16,50}},
        color={255,0,255}));
  connect(and4.u2, logSwi.u3) annotation (Line(points={{-56,-102},{-66,-102},{
          -66,-52},{34,-52},{34,-16},{56,-16},{56,52},{58,52}}, color={255,0,
          255}));
  connect(greEqu1.y, or3.u1) annotation (Line(points={{106,-30},{108,-30},{108,
          -46},{112.4,-46}}, color={255,0,255}));
  connect(or3.u2, truHol1.u) annotation (Line(points={{112.4,-52.4},{112.4,-62},
          {54,-62},{54,-80},{-2,-80},{-2,-64}}, color={255,0,255}));
  connect(or3.y, tim1.reset) annotation (Line(points={{131.6,-46},{132,-46},{
          132,-64},{56,-64},{56,-78},{24,-78},{24,-72},{28,-72}}, color={255,0,
          255}));
  connect(greEqu2.y, or4.u1) annotation (Line(points={{92,-102},{98,-102},{98,
          -103},{100.6,-103}}, color={255,0,255}));
  connect(or4.u2, falEdg.y) annotation (Line(points={{100.6,-108.6},{94,-108.6},
          {94,-118},{-4,-118},{-4,-94}}, color={255,0,255}));
  connect(or4.y, tim.reset) annotation (Line(points={{117.4,-103},{120,-103},{
          120,-112},{28,-112},{28,-102}}, color={255,0,255}));
  connect(not1.y, logSwi1.u1) annotation (Line(points={{136,-20},{136,12},{70,
          12},{70,34},{82,34}}, color={255,0,255}));
  connect(les1.u2, tim.y) annotation (Line(points={{108.6,-88.8},{60,-88.8},{60,
          -94},{52,-94}}, color={0,0,127}));
  connect(les1.u1, tim1.y) annotation (Line(points={{108.6,-84},{90,-84},{90,
          -64},{52,-64}}, color={0,0,127}));
  connect(les1.y, logSwi1.u2) annotation (Line(points={{125.4,-84},{130,-84},{
          130,-82},{134,-82},{134,-56},{80,-56},{80,26},{82,26}}, color={255,0,
          255}));
  connect(logSwi1.u3, logSwi.y) annotation (Line(points={{82,18},{74,18},{74,48},
          {84,48},{84,60},{82,60}}, color={255,0,255}));
  connect(gre1.u1, tim1.y) annotation (Line(points={{64.6,-76},{60,-76},{60,-64},
          {52,-64}}, color={0,0,127}));
  connect(gre1.u2, tim.y) annotation (Line(points={{64.6,-82.4},{60,-82.4},{60,
          -94},{52,-94}}, color={0,0,127}));
  connect(gre1.y, logSwi.u2) annotation (Line(points={{81.4,-76},{110,-76},{110,
          10},{52,10},{52,60},{58,60}}, color={255,0,255}));
  connect(logSwi1.y, boiEnaSig) annotation (Line(points={{106,26},{138,26},{138,
          0},{160,0}}, color={255,0,255}));
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
          extent={{-72,-22},{-2,-52}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.None,
          fontSize=12,
          horizontalAlignment=TextAlignment.Left,
          textString="Calculations performed
when boiler plant is disabled")}));
end BoilerPlantEnabler_v2;
