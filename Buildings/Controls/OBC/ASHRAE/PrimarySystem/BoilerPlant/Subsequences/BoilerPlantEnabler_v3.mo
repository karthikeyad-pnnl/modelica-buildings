within Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Subsequences;
model BoilerPlantEnabler_v3
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
  CDL.Logical.Timer tim
    annotation (Placement(transformation(extent={{30,-104},{50,-84}})));
  CDL.Logical.Timer tim1
    annotation (Placement(transformation(extent={{30,-74},{50,-54}})));
  CDL.Continuous.Sources.Constant con3(k=boiPlaOffStaHolTimVal)
    annotation (Placement(transformation(extent={{-98,-116},{-78,-96}})));
  CDL.Continuous.Sources.Constant con4(k=boiPlaOnStaHolTimVal)
    annotation (Placement(transformation(extent={{56,-56},{76,-36}})));
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
    annotation (Placement(transformation(extent={{-34,-74},{-14,-54}})));
  CDL.Logical.Or or3
    annotation (Placement(transformation(extent={{114,-54},{130,-38}})));
  CDL.Continuous.Less les1
    annotation (Placement(transformation(extent={{110,-90},{124,-78}})));
  CDL.Continuous.Greater gre1
    annotation (Placement(transformation(extent={{66,-84},{80,-68}})));
  CDL.Logical.Latch lat
    annotation (Placement(transformation(extent={{0,-74},{20,-54}})));
  CDL.Logical.Latch lat1
    annotation (Placement(transformation(extent={{0,-104},{20,-84}})));
  CDL.Logical.Edge edg3
    annotation (Placement(transformation(extent={{-82,-68},{-70,-56}})));
  CDL.Logical.Edge edg4
    annotation (Placement(transformation(extent={{-96,-78},{-84,-66}})));
  CDL.Logical.Or or2
    annotation (Placement(transformation(extent={{-34,-104},{-14,-84}})));
  CDL.Logical.FallingEdge falEdg
    annotation (Placement(transformation(extent={{-54,-100},{-42,-88}})));
  CDL.Logical.FallingEdge falEdg2
    annotation (Placement(transformation(extent={{-72,-108},{-60,-96}})));
  CDL.Logical.Pre pre1
    annotation (Placement(transformation(extent={{52,-26},{72,-6}})));
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
  connect(onCouInt.reset, logSwi2.u2)
    annotation (Line(points={{-80,52.8},{-80,50},{16,50}}, color={255,0,255}));
  connect(edg1.u, logSwi2.u2) annotation (Line(points={{-48,108},{-52,108},{-52,
          94},{10,94},{10,50},{16,50}}, color={255,0,255}));
  connect(logSwi2.y, and3.u1) annotation (Line(points={{40,50},{44,50},{44,32},
          {2,32},{2,-16},{6,-16}}, color={255,0,255}));
  connect(con4.y, greEqu1.u2)
    annotation (Line(points={{78,-46},{82,-46},{82,-38}}, color={0,0,127}));
  connect(con3.y, greEqu2.u2) annotation (Line(points={{-76,-106},{-76,-110},{
          68,-110}}, color={0,0,127}));
  connect(greEqu2.u1, tim.y) annotation (Line(points={{68,-102},{64,-102},{64,
          -94},{52,-94}}, color={0,0,127}));
  connect(greEqu1.u1, tim1.y)
    annotation (Line(points={{82,-30},{52,-30},{52,-64}}, color={0,0,127}));
  connect(pre.y, logSwi2.u2) annotation (Line(points={{32,16},{36,16},{36,36},{
          10,36},{10,50},{16,50}}, color={255,0,255}));
  connect(pre.u, boiEnaSig) annotation (Line(points={{8,16},{6,16},{6,4},{138,4},
          {138,0},{160,0}}, color={255,0,255}));
  connect(greEqu1.y, or3.u1) annotation (Line(points={{106,-30},{108,-30},{108,
          -46},{112.4,-46}}, color={255,0,255}));
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
  connect(tim.u, lat1.y)
    annotation (Line(points={{28,-94},{22,-94}}, color={255,0,255}));
  connect(lat.y, tim1.u)
    annotation (Line(points={{22,-64},{28,-64}}, color={255,0,255}));
  connect(logSwi.u1, lat.y) annotation (Line(points={{58,68},{48,68},{48,-42},{
          22,-42},{22,-64}}, color={255,0,255}));
  connect(not1.u, lat1.y) annotation (Line(points={{112,-20},{112,-32},{136,-32},
          {136,-116},{22,-116},{22,-94}}, color={255,0,255}));
  connect(edg4.u, logSwi2.u2) annotation (Line(points={{-97.2,-72},{-98,-72},{
          -98,-46},{36,-46},{36,36},{10,36},{10,50},{16,50}}, color={255,0,255}));
  connect(edg3.y, or1.u1) annotation (Line(points={{-68.8,-62},{-58,-62},{-58,
          -64},{-36,-64}}, color={255,0,255}));
  connect(edg4.y, or1.u2)
    annotation (Line(points={{-82.8,-72},{-36,-72}}, color={255,0,255}));
  connect(or1.y, lat.u)
    annotation (Line(points={{-12,-64},{-2,-64}}, color={255,0,255}));
  connect(or2.y, lat1.u)
    annotation (Line(points={{-12,-94},{-2,-94}}, color={255,0,255}));
  connect(falEdg.y, or2.u1)
    annotation (Line(points={{-40.8,-94},{-36,-94}}, color={255,0,255}));
  connect(falEdg2.u, logSwi2.u2) annotation (Line(points={{-73.2,-102},{-74,
          -102},{-74,-90},{-64,-90},{-64,-46},{36,-46},{36,36},{10,36},{10,50},
          {16,50}}, color={255,0,255}));
  connect(falEdg2.y, or2.u2)
    annotation (Line(points={{-58.8,-102},{-36,-102}}, color={255,0,255}));
  connect(and2.y, logSwi2.u1) annotation (Line(points={{66,186},{66,86},{14,86},
          {14,58},{16,58}}, color={255,0,255}));
  connect(and1.y, logSwi2.u3) annotation (Line(points={{-10,14},{-8,14},{-8,42},
          {16,42}}, color={255,0,255}));
  connect(edg3.u, logSwi.u3) annotation (Line(points={{-83.2,-62},{-86,-62},{
          -86,-48},{6,-48},{6,-28},{44,-28},{44,0},{54,0},{54,52},{58,52}},
        color={255,0,255}));
  connect(falEdg.u, logSwi.u3) annotation (Line(points={{-55.2,-94},{-58,-94},{
          -58,-48},{6,-48},{6,-28},{44,-28},{44,0},{54,0},{54,52},{58,52}},
        color={255,0,255}));
  connect(pre1.u, and3.y)
    annotation (Line(points={{50,-16},{30,-16}}, color={255,0,255}));
  connect(pre1.y, logSwi.u3) annotation (Line(points={{74,-16},{76,-16},{76,0},
          {54,0},{54,52},{58,52}}, color={255,0,255}));
  connect(greEqu2.y, or3.u2) annotation (Line(points={{92,-102},{102,-102},{102,
          -52.4},{112.4,-52.4}}, color={255,0,255}));
  connect(or3.y, lat1.clr) annotation (Line(points={{131.6,-46},{138,-46},{
          138,-112},{-6,-112},{-6,-100},{-2,-100}}, color={255,0,255}));
  connect(lat.clr, lat1.clr) annotation (Line(points={{-2,-70},{-6,-70},{-6,
          -100},{-2,-100}}, color={255,0,255}));
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
          horizontalAlignment=TextAlignment.Left,
          textString="Calculations performed
when boiler plant is disabled")}));
end BoilerPlantEnabler_v3;
