within Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Subsequences;
model BoilerPlantEnabler_v4
  parameter Integer numHotWatReqIgnVal(start=0, min=0)
  "Number of hot-water requests to be ignored before turning on boiler plant loop";
  parameter Real boiLocOutAirTemVal(start=29.444, final unit = "K", displayUnit = "degC")
  "Boiler lock-out temperature for outdoor air";
  parameter Real boiPlaOffStaHolTimVal(start=15*60, final unit = "s", displayUnit = "min")
  "Minimum time for which the boiler plant has to stay off once it has been switched off";
  parameter Real boiPlaOnStaHolTimVal(start=15*60, final unit = "s", displayUnit = "min")
  "Minimum time for which the boiler plant has to stay on once it has been switched on";
  parameter Real boiEnaSchTab[4,2] = [0,1; 6*3600,1; 18*3600,1; 24*3600,1]
  "Table defining schedule for enabling boiler";
  CDL.Interfaces.RealInput uOutAirTem "Outdoor air temperature"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
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
  CDL.Logical.Timer tim(accumulate=false)
    annotation (Placement(transformation(extent={{30,-104},{50,-84}})));
  CDL.Logical.Timer tim1(accumulate=false)
    annotation (Placement(transformation(extent={{30,-74},{50,-54}})));
  CDL.Continuous.Sources.Constant con3(k=boiPlaOffStaHolTimVal)
    annotation (Placement(transformation(extent={{-98,-116},{-78,-96}})));
  CDL.Continuous.Sources.Constant con4(k=boiPlaOnStaHolTimVal)
    annotation (Placement(transformation(extent={{56,-56},{76,-36}})));
  CDL.Continuous.GreaterEqual greEqu1
    annotation (Placement(transformation(extent={{84,-40},{104,-20}})));
  CDL.Continuous.GreaterEqual greEqu2
    annotation (Placement(transformation(extent={{70,-112},{90,-92}})));
  CDL.Logical.Pre pre
    annotation (Placement(transformation(extent={{10,6},{30,26}})));
  CDL.Logical.Not not2
    annotation (Placement(transformation(extent={{-10,-104},{10,-84}})));
  CDL.Logical.Latch lat
    annotation (Placement(transformation(extent={{116,16},{136,36}})));
  CDL.Logical.And and4
    annotation (Placement(transformation(extent={{116,-38},{136,-18}})));
  CDL.Logical.And and5
    annotation (Placement(transformation(extent={{116,-64},{136,-44}})));
  CDL.Logical.Not not1
    annotation (Placement(transformation(extent={{86,-64},{106,-44}})));
  CDL.Continuous.Sources.TimeTable boiEnaSch(table=boiEnaSchTab, timeScale=3600)
    "Schedule table defining when boiler can be enabled"
    annotation (Placement(transformation(extent={{-94,-76},{-74,-56}})));
  CDL.Continuous.GreaterThreshold greThr(threshold=0.5)
    annotation (Placement(transformation(extent={{-60,-76},{-40,-56}})));
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
  connect(and2.y, logSwi2.u1) annotation (Line(points={{66,186},{66,86},{14,86},
          {14,58},{16,58}}, color={255,0,255}));
  connect(and1.y, logSwi2.u3) annotation (Line(points={{-10,14},{-8,14},{-8,42},
          {16,42}}, color={255,0,255}));
  connect(not2.u, logSwi2.u2) annotation (Line(points={{-12,-94},{-18,-94},{-18,
          -50},{36,-50},{36,36},{10,36},{10,50},{16,50}}, color={255,0,255}));
  connect(lat.y, boiEnaSig)
    annotation (Line(points={{138,26},{138,0},{160,0}}, color={255,0,255}));
  connect(tim1.u, logSwi2.u2) annotation (Line(points={{28,-64},{18,-64},{18,-48},
          {36,-48},{36,36},{10,36},{10,50},{16,50}}, color={255,0,255}));
  connect(not2.y, tim.u)
    annotation (Line(points={{12,-94},{28,-94}}, color={255,0,255}));
  connect(greEqu2.y, and4.u2) annotation (Line(points={{92,-102},{108,-102},{108,
          -36},{114,-36}}, color={255,0,255}));
  connect(and4.y, lat.u) annotation (Line(points={{138,-28},{138,-16},{112,-16},
          {112,26},{114,26}}, color={255,0,255}));
  connect(not1.y, and5.u1)
    annotation (Line(points={{108,-54},{114,-54}}, color={255,0,255}));
  connect(and5.u2, greEqu1.y) annotation (Line(points={{114,-62},{112,-62},{112,
          -30},{106,-30}}, color={255,0,255}));
  connect(and5.y, lat.clr) annotation (Line(points={{138,-54},{138,-42},{110,-42},
          {110,20},{114,20}}, color={255,0,255}));
  connect(and3.y, and4.u1) annotation (Line(points={{30,-16},{108,-16},{108,-28},
          {114,-28}}, color={255,0,255}));
  connect(not1.u, and4.u1) annotation (Line(points={{84,-54},{80,-54},{80,-16},{
          108,-16},{108,-28},{114,-28}}, color={255,0,255}));
  connect(greThr.y, and3.u2) annotation (Line(points={{-38,-66},{0,-66},{0,-24},
          {6,-24}}, color={255,0,255}));
  connect(boiEnaSch.y[1], greThr.u)
    annotation (Line(points={{-72,-66},{-62,-66}}, color={0,0,127}));
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
end BoilerPlantEnabler_v4;
