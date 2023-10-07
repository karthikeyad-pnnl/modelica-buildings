within Buildings.Controls.OBC.RooftopUnits.DXCoil.Subsequences;
block NextCoil_v2 "Find next coil to turn on"
  parameter Integer nCoi
    "Number of coils";
  CDL.Interfaces.BooleanInput                        uDXCoi[nCoi]
    "DX coil status"
    annotation (Placement(transformation(extent={{-180,-80},{-140,-40}}),
      iconTransformation(extent={{-140,-80},{-100,-40}})));
  CDL.Interfaces.BooleanInput                        uDXCoiAva[nCoi]
    "DX coil availability"
    annotation (Placement(transformation(extent={{-180,-40},{-140,0}}),
      iconTransformation(extent={{-140,-40},{-100,0}})));
  CDL.Interfaces.BooleanInput uStaUp "Stage up signal" annotation (Placement(
        transformation(extent={{-180,0},{-140,40}}),  iconTransformation(extent={{-140,0},
            {-100,40}})));
  CDL.Interfaces.BooleanOutput yStaUp
    "Signal indicating coil to be enabled has been found" annotation (Placement(
        transformation(extent={{420,-20},{460,20}}),  iconTransformation(extent={{100,0},
            {140,40}})));
  CDL.Interfaces.IntegerOutput yNexCoi "Next coil to be enabled" annotation (
      Placement(transformation(extent={{420,-60},{460,-20}}),
        iconTransformation(extent={{100,-40},{140,0}})));

  CDL.Interfaces.IntegerInput                        uCoiSeq[nCoi]
    "DX coil available sequence order"
    annotation (Placement(transformation(extent={{-180,40},{-140,80}}),
      iconTransformation(extent={{-140,40},{-100,80}})));
  CDL.Logical.Latch latSki[nCoi] "Track coils that have been skipped over"
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  CDL.Logical.Latch latSkiAva[nCoi]
    "Track coils that have been skipped over, but are now available"
    annotation (Placement(transformation(extent={{40,20},{60,40}})));
  CDL.Logical.And and2[nCoi]
    "Check for coils that were skipped but are now available"
    annotation (Placement(transformation(extent={{0,20},{20,40}})));
  CDL.Logical.Edge edg[nCoi]
    "Check for coils that become available from unavailable"
    annotation (Placement(transformation(extent={{-100,-30},{-80,-10}})));
  CDL.Logical.Edge edg1[nCoi] "Check for coils that are enabled"
    annotation (Placement(transformation(extent={{-120,-70},{-100,-50}})));
  CDL.Routing.IntegerExtractor extIndIntOriSeq(nin=nCoi)
    "Next coil based on original sequence (skipped coils assumed enabled)"
    annotation (Placement(transformation(extent={{330,-90},{350,-70}})));
  CDL.Conversions.BooleanToInteger booToIntSki[nCoi]
    "Convert skipped coils into ones"
    annotation (Placement(transformation(extent={{240,-110},{260,-90}})));
  CDL.Conversions.BooleanToInteger booToIntEna[nCoi]
    "Convert enabled coils into ones"
    annotation (Placement(transformation(extent={{-120,-150},{-100,-130}})));
  CDL.Integers.MultiSum mulSumInt(nin=2*nCoi)
    annotation (Placement(transformation(extent={{280,-130},{300,-110}})));
  CDL.Integers.Switch intSwi
    annotation (Placement(transformation(extent={{380,-50},{400,-30}})));
  CDL.Logical.Timer tim[nCoi] "Check time since coil was skipped over"
    annotation (Placement(transformation(extent={{0,70},{20,90}})));
  CDL.Continuous.Round rou[nCoi](n=0)
    annotation (Placement(transformation(extent={{40,100},{60,120}})));
  CDL.Continuous.MultiMax mulMax(nin=nCoi)
    annotation (Placement(transformation(extent={{80,130},{100,150}})));
  CDL.Conversions.BooleanToInteger booToInt[nCoi]
    "Convert previously-skipped, now-available coils to 1"
    annotation (Placement(transformation(extent={{80,70},{100,90}})));
  CDL.Conversions.RealToInteger reaToInt1[nCoi]
    "Convert skip times to integers"
    annotation (Placement(transformation(extent={{110,100},{130,120}})));
  CDL.Integers.Multiply mulInt[nCoi]
    annotation (Placement(transformation(extent={{160,90},{180,110}})));
  CDL.Conversions.RealToInteger reaToInt2 "Convert max skip time to integer"
    annotation (Placement(transformation(extent={{110,130},{130,150}})));
  CDL.Integers.Equal intEqu[nCoi] "Check if time for coil matches max time"
    annotation (Placement(transformation(extent={{200,120},{220,140}})));
  CDL.Routing.IntegerScalarReplicator intScaRep(nout=nCoi)
    "Replicate max time for comparison block"
    annotation (Placement(transformation(extent={{160,130},{180,150}})));
  CDL.Conversions.BooleanToInteger booToInt1[nCoi]
    "Convert Boolean to integer for counting matching signals"
    annotation (Placement(transformation(extent={{230,120},{250,140}})));
  CDL.Integers.MultiSum mulSumInt1(nin=nCoi)
    annotation (Placement(transformation(extent={{260,120},{280,140}})));
  CDL.Integers.Switch intSwi1
    annotation (Placement(transformation(extent={{332,120},{352,140}})));
  CDL.Integers.GreaterThreshold intGreThr1(t=1)
    annotation (Placement(transformation(extent={{300,120},{320,140}})));
  CDL.Integers.Multiply mulInt1[nCoi]
    annotation (Placement(transformation(extent={{260,70},{280,90}})));
  CDL.Integers.Sources.Constant conInt[nCoi](k=coiInd)
    annotation (Placement(transformation(extent={{200,50},{220,70}})));
  CDL.Integers.MultiSum mulSumInt2(nin=nCoi)
    annotation (Placement(transformation(extent={{300,70},{320,90}})));
  CDL.Conversions.IntegerToReal intToRea1[nCoi]
    annotation (Placement(transformation(extent={{300,160},{320,180}})));
  CDL.Integers.MultiSum mulSumInt3(nin=nCoi)
    annotation (Placement(transformation(extent={{148,-50},{168,-30}})));
  CDL.Integers.GreaterThreshold intGreThr2
    annotation (Placement(transformation(extent={{180,-50},{200,-30}})));
  CDL.Continuous.MultiMin mulMin(nin=nCoi)
    annotation (Placement(transformation(extent={{330,160},{350,180}})));
  CDL.Conversions.RealToInteger reaToInt3
    annotation (Placement(transformation(extent={{360,160},{380,180}})));
  CDL.Integers.AddParameter addPar1(p=1)
    annotation (Placement(transformation(extent={{310,-130},{330,-110}})));
  CDL.Logical.Or or2
    annotation (Placement(transformation(extent={{150,240},{170,260}})));
  CDL.Integers.Equal intEqu1[nCoi]
    annotation (Placement(transformation(extent={{-60,260},{-40,280}})));
  CDL.Routing.IntegerScalarReplicator intScaRep1(nout=nCoi)
    annotation (Placement(transformation(extent={{360,-130},{380,-110}})));
  CDL.Logical.And and1[nCoi]
    annotation (Placement(transformation(extent={{0,240},{20,260}})));
  CDL.Logical.MultiOr mulOr(nin=nCoi)
    annotation (Placement(transformation(extent={{80,240},{100,260}})));
  CDL.Logical.And and3
    annotation (Placement(transformation(extent={{200,220},{220,240}})));
  CDL.Logical.Not not1
    annotation (Placement(transformation(extent={{240,260},{260,280}})));
  CDL.Logical.And and4
    annotation (Placement(transformation(extent={{280,260},{300,280}})));
  CDL.Routing.BooleanScalarReplicator booScaRep(nout=nCoi)
    annotation (Placement(transformation(extent={{320,260},{340,280}})));
  CDL.Logical.And and5[nCoi]
    annotation (Placement(transformation(extent={{0,280},{20,300}})));
  CDL.Logical.VariablePulse varPul(period=30)
    annotation (Placement(transformation(extent={{60,160},{80,180}})));
  CDL.Logical.Or or1
    annotation (Placement(transformation(extent={{110,210},{130,230}})));
  CDL.Logical.MultiOr mulOr1(nin=nCoi)
    annotation (Placement(transformation(extent={{-40,160},{-20,180}})));
  CDL.Logical.Latch lat
    annotation (Placement(transformation(extent={{0,160},{20,180}})));
  CDL.Conversions.BooleanToReal booToRea(realTrue=1 - (1/30))
    annotation (Placement(transformation(extent={{30,160},{50,180}})));
  CDL.Logical.Pre pre
    annotation (Placement(transformation(extent={{150,160},{170,180}})));
  CDL.Logical.Pre pre1[nCoi]
    annotation (Placement(transformation(extent={{-30,260},{-10,280}})));
  CDL.Logical.Pre pre2[nCoi]
    annotation (Placement(transformation(extent={{348,260},{368,280}})));
  CDL.Logical.TrueFalseHold truFalHol[nCoi](trueHoldDuration=30,
      falseHoldDuration=0)
    annotation (Placement(transformation(extent={{-40,80},{-20,100}})));
  CDL.Logical.TrueFalseHold truFalHol1[nCoi](trueHoldDuration=30,
      falseHoldDuration=0)
    annotation (Placement(transformation(extent={{-38,-50},{-18,-30}})));
  CDL.Logical.TrueFalseHold truFalHol2[nCoi](trueHoldDuration=30,
      falseHoldDuration=0)
    annotation (Placement(transformation(extent={{42,-52},{62,-32}})));
  CDL.Logical.TrueFalseHold truFalHol3[nCoi](trueHoldDuration=30,
      falseHoldDuration=0)
    annotation (Placement(transformation(extent={{44,68},{64,88}})));
  CDL.Logical.TrueFalseHold truFalHol4(trueHoldDuration=30, falseHoldDuration=0)
    annotation (Placement(transformation(extent={{2,130},{22,150}})));
  CDL.Logical.TrueFalseHold truFalHol5(trueHoldDuration=30, falseHoldDuration=0)
    annotation (Placement(transformation(extent={{58,192},{78,212}})));
  CDL.Logical.TrueFalseHold truFalHol6(trueHoldDuration=30, falseHoldDuration=0)
    annotation (Placement(transformation(extent={{360,200},{380,220}})));
  CDL.Logical.Not not2
    annotation (Placement(transformation(extent={{90,160},{110,180}})));
  CDL.Logical.And and6
    annotation (Placement(transformation(extent={{118,160},{138,180}})));
  CDL.Logical.Or or3[nCoi]
    annotation (Placement(transformation(extent={{8,-80},{28,-60}})));
  CDL.Logical.FallingEdge falEdg[nCoi]
    annotation (Placement(transformation(extent={{-40,-76},{-20,-56}})));
protected
  parameter Integer coiInd[nCoi]={i for i in 1:nCoi}
    "DX coil index, {1,2,...,n}";
equation
  connect(latSki.y, and2.u1)
    annotation (Line(points={{-18,30},{-2,30}}, color={255,0,255}));
  connect(uDXCoiAva, edg.u)
    annotation (Line(points={{-160,-20},{-102,-20}},color={255,0,255}));
  connect(edg.y, and2.u2) annotation (Line(points={{-78,-20},{-6,-20},{-6,22},{-2,
          22}},     color={255,0,255}));
  connect(and2.y, latSkiAva.u)
    annotation (Line(points={{22,30},{38,30}}, color={255,0,255}));
  connect(uDXCoi, edg1.u)
    annotation (Line(points={{-160,-60},{-122,-60}}, color={255,0,255}));
  connect(edg1.y, latSki.clr) annotation (Line(points={{-98,-60},{-60,-60},{-60,
          24},{-42,24}}, color={255,0,255}));
  connect(uCoiSeq, extIndIntOriSeq.u) annotation (Line(points={{-160,60},{100,60},
          {100,-80},{328,-80}},  color={255,127,0}));
  connect(latSki.y, booToIntSki.u) annotation (Line(points={{-18,30},{-10,30},{-10,
          -100},{238,-100}},
                          color={255,0,255}));
  connect(uDXCoi, booToIntEna.u) annotation (Line(points={{-160,-60},{-130,-60},
          {-130,-140},{-122,-140}},
                                  color={255,0,255}));
  connect(booToIntSki.y, mulSumInt.u[1:nCoi]) annotation (Line(points={{262,-100},
          {268,-100},{268,-118},{278,-118},{278,-120}},
                                                 color={255,127,0}));
  connect(booToIntEna.y, mulSumInt.u[nCoi+1:2*nCoi]) annotation (Line(points={{-98,
          -140},{268,-140},{268,-120},{278,-120}},
                                          color={255,127,0}));
  connect(intSwi.y, yNexCoi)
    annotation (Line(points={{402,-40},{440,-40}}, color={255,127,0}));
  connect(extIndIntOriSeq.y, intSwi.u3) annotation (Line(points={{352,-80},{360,
          -80},{360,-48},{378,-48}}, color={255,127,0}));
  connect(latSki.y, tim.u) annotation (Line(points={{-18,30},{-10,30},{-10,80},{
          -2,80}}, color={255,0,255}));
  connect(tim.y, rou.u) annotation (Line(points={{22,80},{32,80},{32,110},{38,
          110}},
        color={0,0,127}));
  connect(rou.y, mulMax.u[1:nCoi]) annotation (Line(points={{62,110},{70,110},{70,
          140},{78,140}},
                     color={0,0,127}));
  connect(latSkiAva.y, booToInt.u) annotation (Line(points={{62,30},{70,30},{70,
          80},{78,80}}, color={255,0,255}));
  connect(rou.y, reaToInt1.u)
    annotation (Line(points={{62,110},{108,110}}, color={0,0,127}));
  connect(reaToInt1.y, mulInt.u1) annotation (Line(points={{132,110},{150,110},{
          150,106},{158,106}}, color={255,127,0}));
  connect(booToInt.y, mulInt.u2) annotation (Line(points={{102,80},{150,80},{150,
          94},{158,94}}, color={255,127,0}));
  connect(mulMax.y, reaToInt2.u) annotation (Line(points={{102,140},{108,140}},
                           color={0,0,127}));
  connect(reaToInt2.y, intScaRep.u)
    annotation (Line(points={{132,140},{158,140}}, color={255,127,0}));
  connect(intScaRep.y, intEqu.u1) annotation (Line(points={{182,140},{190,140},{
          190,130},{198,130}}, color={255,127,0}));
  connect(mulInt.y, intEqu.u2) annotation (Line(points={{182,100},{190,100},{190,
          122},{198,122}}, color={255,127,0}));
  connect(intEqu.y, booToInt1.u)
    annotation (Line(points={{222,130},{228,130}}, color={255,0,255}));
  connect(booToInt1.y, mulSumInt1.u[1:nCoi])
    annotation (Line(points={{252,130},{258,130}}, color={255,127,0}));
  connect(mulSumInt1.y, intGreThr1.u)
    annotation (Line(points={{282,130},{298,130}}, color={255,127,0}));
  connect(intGreThr1.y, intSwi1.u2)
    annotation (Line(points={{322,130},{330,130}}, color={255,0,255}));
  connect(booToInt1.y, mulInt1.u1) annotation (Line(points={{252,130},{256,130},
          {256,86},{258,86}}, color={255,127,0}));
  connect(conInt.y, mulInt1.u2) annotation (Line(points={{222,60},{240,60},{240,
          74},{258,74}}, color={255,127,0}));
  connect(mulInt1.y, mulSumInt2.u[1:nCoi])
    annotation (Line(points={{282,80},{290,80},{290,80},{298,80}},
                                                 color={255,127,0}));
  connect(mulSumInt2.y, intSwi1.u3) annotation (Line(points={{322,80},{326,80},{
          326,122},{330,122}}, color={255,127,0}));
  connect(booToInt.y, mulSumInt3.u[1:nCoi]) annotation (Line(points={{102,80},{120,
          80},{120,-40},{146,-40}},                  color={255,127,0}));
  connect(mulSumInt3.y, intGreThr2.u)
    annotation (Line(points={{170,-40},{178,-40}}, color={255,127,0}));
  connect(mulInt1.y, intToRea1.u) annotation (Line(points={{282,80},{290,80},{290,
          170},{298,170}}, color={255,127,0}));
  connect(intToRea1.y, mulMin.u[1:nCoi])
    annotation (Line(points={{322,170},{328,170}}, color={0,0,127}));
  connect(mulMin.y, reaToInt3.u)
    annotation (Line(points={{352,170},{358,170}}, color={0,0,127}));
  connect(reaToInt3.y, intSwi1.u1) annotation (Line(points={{382,170},{390,170},
          {390,152},{324,152},{324,138},{330,138}}, color={255,127,0}));
  connect(intGreThr2.y, intSwi.u2)
    annotation (Line(points={{202,-40},{378,-40}}, color={255,0,255}));
  connect(mulSumInt.y, addPar1.u)
    annotation (Line(points={{302,-120},{308,-120}}, color={255,127,0}));
  connect(addPar1.y, extIndIntOriSeq.index) annotation (Line(points={{332,-120},
          {340,-120},{340,-92}}, color={255,127,0}));
  connect(intGreThr2.y, or2.u2) annotation (Line(points={{202,-40},{220,-40},{
          220,-70},{144,-70},{144,242},{148,242}},
                                               color={255,0,255}));
  connect(addPar1.y, intScaRep1.u)
    annotation (Line(points={{332,-120},{358,-120}}, color={255,127,0}));
  connect(intScaRep1.y, intEqu1.u2) annotation (Line(points={{382,-120},{388,-120},
          {388,-160},{-72,-160},{-72,262},{-62,262}}, color={255,127,0}));
  connect(conInt.y, intEqu1.u1) annotation (Line(points={{222,60},{240,60},{240,
          0},{-80,0},{-80,270},{-62,270}},                 color={255,127,0}));
  connect(uDXCoiAva, and1.u2) annotation (Line(points={{-160,-20},{-120,-20},{-120,
          242},{-2,242}}, color={255,0,255}));
  connect(and1.y, mulOr.u[1:nCoi])
    annotation (Line(points={{22,250},{78,250}}, color={255,0,255}));
  connect(mulOr.y, or2.u1)
    annotation (Line(points={{102,250},{148,250}}, color={255,0,255}));
  connect(or2.y, and3.u1) annotation (Line(points={{172,250},{180,250},{180,230},
          {198,230}}, color={255,0,255}));
  connect(and3.y, yStaUp) annotation (Line(points={{222,230},{408,230},{408,0},
          {440,0}}, color={255,0,255}));
  connect(or2.y, not1.u) annotation (Line(points={{172,250},{180,250},{180,270},
          {238,270}}, color={255,0,255}));
  connect(not1.y, and4.u1)
    annotation (Line(points={{262,270},{278,270}}, color={255,0,255}));
  connect(and4.y, booScaRep.u)
    annotation (Line(points={{302,270},{318,270}}, color={255,0,255}));
  connect(and5.y, latSki.u) annotation (Line(points={{22,290},{40,290},{40,200},
          {-50,200},{-50,30},{-42,30}}, color={255,0,255}));
  connect(or1.y, and3.u2) annotation (Line(points={{132,220},{180,220},{180,222},
          {198,222}}, color={255,0,255}));
  connect(or1.y, and4.u2) annotation (Line(points={{132,220},{180,220},{180,210},
          {270,210},{270,262},{278,262}}, color={255,0,255}));
  connect(uStaUp, or1.u1) annotation (Line(points={{-160,20},{-100,20},{-100,220},
          {108,220}}, color={255,0,255}));
  connect(and5.y, mulOr1.u[1:nCoi]) annotation (Line(points={{22,290},{40,290},{40,
          200},{-50,200},{-50,170},{-42,170}}, color={255,0,255}));
  connect(mulOr1.y, lat.u)
    annotation (Line(points={{-18,170},{-2,170}}, color={255,0,255}));
  connect(and3.y, lat.clr) annotation (Line(points={{222,230},{232,230},{232,312},
          {-10,312},{-10,164},{-2,164}}, color={255,0,255}));
  connect(lat.y, booToRea.u)
    annotation (Line(points={{22,170},{28,170}}, color={255,0,255}));
  connect(booToRea.y, varPul.u)
    annotation (Line(points={{52,170},{58,170}}, color={0,0,127}));
  connect(intEqu1.y, pre1.u)
    annotation (Line(points={{-38,270},{-32,270}}, color={255,0,255}));
  connect(pre1.y, and5.u2) annotation (Line(points={{-8,270},{-4,270},{-4,282},
          {-2,282}}, color={255,0,255}));
  connect(pre1.y, and1.u1) annotation (Line(points={{-8,270},{-4,270},{-4,250},
          {-2,250}}, color={255,0,255}));
  connect(booScaRep.y, pre2.u)
    annotation (Line(points={{342,270},{346,270}}, color={255,0,255}));
  connect(pre2.y, and5.u1) annotation (Line(points={{370,270},{380,270},{380,
          320},{-4,320},{-4,290},{-2,290}}, color={255,0,255}));
  connect(latSki.clr, truFalHol1.u) annotation (Line(points={{-42,24},{-40,24},
          {-40,-40},{-40,-40}}, color={255,0,255}));
  connect(latSki.u, truFalHol.u)
    annotation (Line(points={{-42,30},{-42,90},{-42,90}}, color={255,0,255}));
  connect(latSkiAva.clr, truFalHol2.u) annotation (Line(points={{38,24},{38,-10},
          {38,-42},{40,-42}}, color={255,0,255}));
  connect(latSkiAva.u, truFalHol3.u) annotation (Line(points={{38,30},{42,30},{
          42,78},{42,78}}, color={255,0,255}));
  connect(lat.u, truFalHol5.u) annotation (Line(points={{-2,170},{-6,170},{-6,
          202},{56,202}}, color={255,0,255}));
  connect(lat.clr, truFalHol4.u) annotation (Line(points={{-2,164},{0,164},{0,
          140},{0,140}}, color={255,0,255}));
  connect(and3.y, truFalHol6.u) annotation (Line(points={{222,230},{291,230},{
          291,210},{358,210}}, color={255,0,255}));
  connect(pre.y, or1.u2) annotation (Line(points={{172,170},{180,170},{180,190},
          {100,190},{100,212},{108,212}}, color={255,0,255}));
  connect(varPul.y, not2.u)
    annotation (Line(points={{82,170},{88,170}}, color={255,0,255}));
  connect(pre.u, and6.y)
    annotation (Line(points={{148,170},{140,170}}, color={255,0,255}));
  connect(not2.y, and6.u1)
    annotation (Line(points={{112,170},{116,170}}, color={255,0,255}));
  connect(lat.y, and6.u2) annotation (Line(points={{22,170},{26,170},{26,186},{
          114,186},{114,162},{116,162}}, color={255,0,255}));
  connect(or3.y, latSkiAva.clr) annotation (Line(points={{30,-70},{34,-70},{34,
          24},{38,24}}, color={255,0,255}));
  connect(edg1.y, or3.u2) annotation (Line(points={{-98,-60},{-60,-60},{-60,-78},
          {6,-78}}, color={255,0,255}));
  connect(falEdg.y, or3.u1) annotation (Line(points={{-18,-66},{0,-66},{0,-70},
          {6,-70}}, color={255,0,255}));
  connect(uDXCoiAva, falEdg.u) annotation (Line(points={{-160,-20},{-120,-20},{
          -120,-40},{-50,-40},{-50,-66},{-42,-66}}, color={255,0,255}));
  connect(intSwi1.y, intSwi.u1) annotation (Line(points={{354,130},{370,130},{
          370,-32},{378,-32}}, color={255,127,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                         graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}), Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-140,-180},{420,340}})));
end NextCoil_v2;
