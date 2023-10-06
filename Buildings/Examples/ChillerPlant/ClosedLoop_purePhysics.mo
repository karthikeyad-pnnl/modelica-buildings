within Buildings.Examples.ChillerPlant;

model ClosedLoop_purePhysics
  Buildings.Examples.ChillerPlant.DataCenterDiscreteTimeControl_purePhysics dataCenterDiscreteTimeControl
    annotation (Placement(transformation(extent={{70.0,12.0},{90.0,32.0}},rotation = 0.0,origin = {0.0,0.0})));
  .Buildings.Controls.OBC.CDL.Continuous.Sources.CalendarTime calTim(zerTim=.Buildings.Controls.OBC.CDL.Types.ZeroTime.NY2020)
    annotation (Placement(transformation(extent={{-90,68},{-70,88}})));
  .Buildings.Controls.OBC.CDL.Integers.GreaterEqualThreshold intGreEquThr(t=8)
    annotation (Placement(transformation(extent={{-60,70},{-40,90}})));
  .Buildings.Controls.OBC.CDL.Integers.LessEqualThreshold intLesEquThr(t=17)
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  .Buildings.Controls.OBC.CDL.Logical.And and2
    annotation (Placement(transformation(extent={{-30,60},{-10,80}})));
  .Buildings.Controls.OBC.CDL.Continuous.PID conPID(Ti=1e6, reverseActing=false)
    annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
  .Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con(k=0)
    annotation (Placement(transformation(extent={{-90,-50},{-70,-30}})));
  .Buildings.Controls.OBC.CDL.Continuous.Limiter lim(uMax=0.9, uMin=0)
    annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
  .Buildings.Controls.OBC.CDL.Continuous.MultiplyByParameter gai(k=12 / lim.uMax)
    annotation (Placement(transformation(extent={{10,-30},{30,-10}})));
  .Buildings.Controls.OBC.CDL.Continuous.AddParameter addPar(p=-lim.uMax)
    annotation (Placement(transformation(extent={{-20.0,-60.0},{0.0,-40.0}},rotation = 0.0,origin = {0.0,0.0})));
  .Buildings.Controls.OBC.CDL.Continuous.MultiplyByParameter gai1(k=(5.56 - 22) / lim2.uMax)
    annotation (Placement(transformation(extent={{40,-60},{60,-40}})));
  .Buildings.Controls.OBC.CDL.Continuous.AddParameter addPar1(p=273.15 + 22)
    annotation (Placement(transformation(extent={{70,-60},{90,-40}})));
  .Buildings.Controls.OBC.CDL.Logical.Timer tim
    annotation (Placement(transformation(extent={{0,60},{20,80}})));
  .Buildings.Controls.OBC.CDL.Continuous.MultiplyByParameter gai2(k=250000/(9*3600))
    annotation (Placement(transformation(extent={{30,60},{50,80}})));
    .Buildings.Controls.OBC.CDL.Continuous.Limiter lim2(uMin = 0,uMax = 1 - lim.uMax) annotation(Placement(transformation(extent = {{10.0,-60.0},{30.0,-40.0}},rotation = 0.0,origin = {0.0,0.0})));
    .Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con2(k = 297.15) annotation(Placement(transformation(extent = {{-60.0,-2.0},{-40.0,18.0}},rotation = 0.0,origin = {0.0,0.0})));
    .Buildings.Controls.OBC.CDL.Continuous.GreaterThreshold greThr annotation(Placement(transformation(extent = {{108,8},{128,28}},origin = {0,0},rotation = 0)));
    .Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea annotation(Placement(transformation(extent = {{138,8},{158,28}},origin = {0,0},rotation = 0)));
    .Buildings.Controls.OBC.CDL.Continuous.Multiply mul annotation(Placement(transformation(extent = {{174,2},{194,22}},origin = {0,0},rotation = 0)));
    .Buildings.Controls.OBC.CDL.Continuous.PID conPID2(reverseActing = false,Ti = 1000) annotation(Placement(transformation(extent = {{-20.0,26.0},{0.0,46.0}},origin = {0.0,0.0},rotation = 0.0)));
equation
  connect(calTim.hour, intGreEquThr.u) annotation (Line(points={{-69,84},{-66,
          84},{-66,80},{-62,80}}, color={255,127,0}));
  connect(calTim.hour, intLesEquThr.u) annotation (Line(points={{-69,84},{-66,
          84},{-66,40},{-62,40}}, color={255,127,0}));
  connect(intGreEquThr.y, and2.u1) annotation (Line(points={{-38,80},{-36,80},{
          -36,70},{-32,70}}, color={255,0,255}));
  connect(intLesEquThr.y, and2.u2) annotation (Line(points={{-38,40},{-36,40},{
          -36,62},{-32,62}}, color={255,0,255}));
  connect(con.y, conPID.u_s)
    annotation (Line(points={{-68,-40},{-62,-40}}, color={0,0,127}));
  connect(conPID.y, lim.u) annotation (Line(points={{-38,-40},{-30,-40},{-30,
          -20},{-22,-20}}, color={0,0,127}));
  connect(lim.y, gai.u)
    annotation (Line(points={{2,-20},{8,-20}}, color={0,0,127}));
  connect(gai.y, dataCenterDiscreteTimeControl.uMasFloRat) annotation (Line(
        points={{32,-20},{56,-20},{56,28},{68,28}}, color={0,0,127}));
  connect(gai1.y, addPar1.u)
    annotation (Line(points={{62,-50},{68,-50}}, color={0,0,127}));
  connect(addPar1.y, dataCenterDiscreteTimeControl.uTCHWSet) annotation (Line(
        points={{92,-50},{96,-50},{96,40},{64,40},{64,24},{68,24}}, color={0,0,
          127}));
  connect(and2.y, tim.u)
    annotation (Line(points={{-8,70},{-2,70}}, color={255,0,255}));
  connect(tim.y, gai2.u)
    annotation (Line(points={{22,70},{28,70}}, color={0,0,127}));
  connect(gai2.y, dataCenterDiscreteTimeControl.uLoad) annotation (Line(points=
          {{52,70},{60,70},{60,20},{68,20}}, color={0,0,127}));
  connect(conPID.y, addPar.u) annotation (Line(points={{-38,-40},{-30,-40},{-30,-50},{-22,-50}}, color={0,0,127}));
    connect(addPar.y,lim2.u) annotation(Line(points = {{2,-50},{8,-50}},color = {0,0,127}));
    connect(lim2.y,gai1.u) annotation(Line(points = {{32,-50},{38,-50}},color = {0,0,127}));
    connect(dataCenterDiscreteTimeControl.mSupAir_flow,greThr.u) annotation(Line(points = {{92,12},{100,12},{100,18},{106,18}},color = {0,0,127}));
    connect(greThr.y,booToRea.u) annotation(Line(points = {{130,18},{136,18}},color = {255,0,255}));
    connect(booToRea.y,mul.u1) annotation(Line(points = {{160,18},{172,18}},color = {0,0,127}));
    connect(dataCenterDiscreteTimeControl.TSupAirDelta,mul.u2) annotation(Line(points = {{92,16},{104,16},{104,6},{172,6}},color = {0,0,127}));
    connect(mul.y,conPID.u_m) annotation(Line(points = {{196,12},{200,12},{200,-68},{-50,-68},{-50,-52}},color = {0,0,127}));
    connect(con2.y,conPID2.u_s) annotation(Line(points = {{-38,8},{-30,8},{-30,36},{-22,36}},color = {0,0,127}));
    connect(dataCenterDiscreteTimeControl.TRoo,conPID2.u_m) annotation(Line(points = {{92,8},{98,8},{98,6},{-10,6},{-10,24}},color = {0,0,127}));
    connect(dataCenterDiscreteTimeControl.uFan,conPID2.y) annotation(Line(points = {{68,16},{35,16},{35,36},{2,36}},color = {0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StartTime=13132800,
      StopTime=13392000,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end ClosedLoop_purePhysics;
