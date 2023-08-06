within Buildings.Examples.ChillerPlant;
model ClosedLoop
  DataCenterDiscreteTimeControl dataCenterDiscreteTimeControl
    annotation (Placement(transformation(extent={{70,10},{90,30}})));
  Controls.OBC.CDL.Continuous.Sources.CalendarTime calTim(zerTim=Buildings.Controls.OBC.CDL.Types.ZeroTime.NY2020)
    annotation (Placement(transformation(extent={{-80,68},{-60,88}})));
  Controls.OBC.CDL.Integers.GreaterEqualThreshold intGreEquThr(t=8)
    annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
  Controls.OBC.CDL.Integers.LessEqualThreshold intLesEquThr(t=17)
    annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
  Controls.OBC.CDL.Logical.And and2
    annotation (Placement(transformation(extent={{0,60},{20,80}})));
  Controls.OBC.CDL.Conversions.BooleanToReal booToRea(realTrue=250000)
    annotation (Placement(transformation(extent={{30,60},{50,80}})));
  Controls.OBC.CDL.Continuous.PID conPID(Ti=1000, reverseActing=false)
    annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
  Controls.OBC.CDL.Continuous.Sources.Constant con(k=0)
    annotation (Placement(transformation(extent={{-90,-50},{-70,-30}})));
  Controls.OBC.CDL.Continuous.Limiter lim(uMax=0.5, uMin=0)
    annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
  Controls.OBC.CDL.Continuous.MultiplyByParameter gai(k=12)
    annotation (Placement(transformation(extent={{10,-30},{30,-10}})));
  Controls.OBC.CDL.Continuous.Limiter lim1(uMax=1, uMin=0.5)
    annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
  Controls.OBC.CDL.Continuous.AddParameter addPar(p=-0.5)
    annotation (Placement(transformation(extent={{10,-60},{30,-40}})));
  Controls.OBC.CDL.Continuous.MultiplyByParameter gai1(k=2*(5.56 - 22))
    annotation (Placement(transformation(extent={{40,-60},{60,-40}})));
  Controls.OBC.CDL.Continuous.AddParameter addPar1(p=273.15 + 22)
    annotation (Placement(transformation(extent={{70,-60},{90,-40}})));
  Controls.OBC.CDL.Discrete.FirstOrderHold firOrdHol(samplePeriod=60)
    annotation (Placement(transformation(extent={{60,60},{80,80}})));
equation
  connect(calTim.hour, intGreEquThr.u) annotation (Line(points={{-59,84},{-50,
          84},{-50,80},{-42,80}}, color={255,127,0}));
  connect(calTim.hour, intLesEquThr.u) annotation (Line(points={{-59,84},{-50,
          84},{-50,40},{-42,40}}, color={255,127,0}));
  connect(intGreEquThr.y, and2.u1) annotation (Line(points={{-18,80},{-10,80},{
          -10,70},{-2,70}}, color={255,0,255}));
  connect(intLesEquThr.y, and2.u2) annotation (Line(points={{-18,40},{-10,40},{
          -10,62},{-2,62}}, color={255,0,255}));
  connect(and2.y, booToRea.u) annotation (Line(points={{22,70},{24,70},{24,72},
          {26,72},{26,70},{28,70}}, color={255,0,255}));
  connect(dataCenterDiscreteTimeControl.TDelta, conPID.u_m) annotation (Line(
        points={{92,26},{94,26},{94,-68},{-50,-68},{-50,-52}}, color={0,0,127}));
  connect(con.y, conPID.u_s)
    annotation (Line(points={{-68,-40},{-62,-40}}, color={0,0,127}));
  connect(conPID.y, lim.u) annotation (Line(points={{-38,-40},{-30,-40},{-30,
          -20},{-22,-20}}, color={0,0,127}));
  connect(lim.y, gai.u)
    annotation (Line(points={{2,-20},{8,-20}}, color={0,0,127}));
  connect(gai.y, dataCenterDiscreteTimeControl.uMasFloRat) annotation (Line(
        points={{32,-20},{56,-20},{56,26},{68,26}}, color={0,0,127}));
  connect(conPID.y, lim1.u) annotation (Line(points={{-38,-40},{-30,-40},{-30,
          -50},{-22,-50}}, color={0,0,127}));
  connect(lim1.y, addPar.u)
    annotation (Line(points={{2,-50},{8,-50}}, color={0,0,127}));
  connect(addPar.y, gai1.u)
    annotation (Line(points={{32,-50},{38,-50}}, color={0,0,127}));
  connect(gai1.y, addPar1.u)
    annotation (Line(points={{62,-50},{68,-50}}, color={0,0,127}));
  connect(addPar1.y, dataCenterDiscreteTimeControl.uTCHWSet) annotation (Line(
        points={{92,-50},{96,-50},{96,40},{64,40},{64,20},{68,20}}, color={0,0,
          127}));
  connect(booToRea.y, firOrdHol.u)
    annotation (Line(points={{52,70},{58,70}}, color={0,0,127}));
  connect(firOrdHol.y, dataCenterDiscreteTimeControl.uLoad) annotation (Line(
        points={{82,70},{90,70},{90,50},{50,50},{50,14},{68,14}}, color={0,0,
          127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StartTime=13132800,
      StopTime=15724800,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end ClosedLoop;
