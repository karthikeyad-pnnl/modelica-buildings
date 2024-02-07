within Buildings.Examples.VAVReheat.BaseClasses;
model ASHRAE2006_RTU
  "Variable air volume flow system with terminal reheat and ASHRAE 2006 control sequence serving five thermal zones"
  extends Buildings.Examples.VAVReheat.BaseClasses.PartialHVAC_RTU(amb(nPorts=3),
    yFanMin=0);

  parameter Real ratVMinVAV_flow[numZon](each final unit="1") = {max(1.5*
    VZonOA_flow_nominal[i]/mCooVAV_flow_nominal[i]/1.2, 0.15) for i in 1:numZon}
    "Minimum discharge air flow rate ratio";

  Controls.FanVFD conFanSup(
    xSet_nominal(displayUnit="Pa") = 410,
    r_N_min=yFanMin)
    "Controller for fan"
    annotation (Placement(transformation(extent={{260,36},{280,56}})));

  Controls.ModeSelector modeSelector
    annotation (Placement(transformation(extent={{-200,-320},{-180,-300}})));

  Controls.ControlBus controlBus
    annotation (Placement(transformation(extent={{-250,-350},{-230,-330}}),
      iconTransformation(extent={{-162,-100},{-142,-80}})));

  Controls.Economizer conEco(
    have_reset=true,
    have_frePro=true,
    VOut_flow_min=Vot_flow_nominal)
           "Controller for economizer"
    annotation (Placement(transformation(extent={{-80,140},{-60,160}})));

  Controls.RoomTemperatureSetpoint TSetRoo(
    final THeaOn=THeaOn,
    final THeaOff=THeaOff,
    final TCooOn=TCooOn,
    final TCooOff=TCooOff)
    annotation (Placement(transformation(extent={{-300,-358},{-280,-338}})));

  Controls.DuctStaticPressureSetpoint pSetDuc(
    nin=5,
    pMin=50)
    "Duct static pressure setpoint"
    annotation (Placement(transformation(extent={{160,-16},{180,4}})));

  Controls.RoomVAV conVAV[numZon](
    have_preIndDam=fill(false, numZon),
    ratVFloMin=ratVMinVAV_flow,
    ratVFloHea=mHeaVAV_flow_nominal ./ mCooVAV_flow_nominal,
    V_flow_nominal=mCooVAV_flow_nominal/1.2)
    "Controller for terminal unit"
    annotation (Placement(transformation(extent={{580,40},{600,60}})));

  Buildings.Controls.OBC.CDL.Logical.Or or2
    annotation (Placement(transformation(extent={{-100,-250},{-80,-230}})));

  Controls.SupplyAirTemperature conTSup(k=0.05, Ti=800)
    "Supply air temperature and economizer controller"
    annotation (Placement(transformation(extent={{-60,-230},{-40,-210}})));

  Controls.SupplyAirTemperatureSetpoint TSupSet
    "Supply air temperature set point"
    annotation (Placement(transformation(extent={{-200,-230},{-180,-210}})));

  Buildings.Fluid.Actuators.Dampers.Exponential damExh(
    from_dp=false,
    riseTime=15,
    dpFixed_nominal=5,
    redeclare package Medium = MediumA,
    m_flow_nominal=mAir_flow_nominal,
    dpDamper_nominal=5) "Exhaust air damper"
    annotation (Placement(transformation(extent={{-30,-20},{-50,0}})));

  Buildings.Controls.OBC.CDL.Continuous.MultiMin TRooMin(
    final nin=numZon,
    u(each final unit="K",
      each displayUnit="degC"),
    y(final unit="K",
      displayUnit="degC"))
    "Minimum room temperature"
    annotation (Placement(transformation(extent={{-340,260},{-320,280}})));

  Utilities.Math.Average TRooAve(
    final nin=numZon,
    u(each final unit="K",
      each displayUnit="degC"),
    y(final unit="K",
      displayUnit="degC")) "Average room temperature"
    annotation (Placement(transformation(extent={{-340,230},{-320,250}})));

  Controls.FreezeStat freSta "Freeze stat for heating coil"
    annotation (Placement(transformation(extent={{-60,-90},{-40,-70}})));

  Buildings.Controls.OBC.CDL.Routing.RealScalarReplicator TRooHeaSet(
    final nout=numZon)
    "Replicate room temperature heating setpoint"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=0, origin={490,64})));

  Buildings.Controls.OBC.CDL.Routing.RealScalarReplicator TRooCooSet(
    final nout=numZon)
    "Replicate room temperature cooling setpoint"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=0, origin={490,30})));

  Buildings.Controls.OBC.RooftopUnits.Controller RTUCon(
    final nCoiHea=nCoiHea,
    final nCoiCoo=nCoiCoo,
    final dUHys=0.2)
    "Controller for rooftop units"
    annotation (Placement(transformation(extent={{1010,232},{1030,260}})));

  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea[nCoiCoo](
    each final realTrue=1,
    each final realFalse=0)
    "Convert Boolean to Real number"
    annotation (Placement(transformation(extent={{1090,246},{1110,266}})));

  Buildings.Controls.OBC.CDL.Continuous.Multiply mul[nCoiCoo]
    "Calculate compressor speed based on product of two inputs"
    annotation (Placement(transformation(extent={{1130,230},{1150,250}})));

  Buildings.Controls.OBC.CDL.Continuous.Hysteresis hys[nCoiHea](
    each final uLow=0.5,
    each final uHigh=1)
    "Check if DXs are on"
    annotation (Placement(transformation(extent={{140,-160},{160,-140}})));

  Buildings.Controls.OBC.CDL.Continuous.Hysteresis hys1[nCoiCoo](
    each final uLow=0.5,
    each final uHigh=1)
    "Check if DXs are on"
    annotation (Placement(transformation(extent={{280,-150},{300,-130}})));

  Buildings.Controls.OBC.CDL.Logical.Timer timDXSta[nCoiHea](
    each final t=120)
    "Output DX heating coils proven on signal when status is enabled for two minutes"
    annotation (Placement(transformation(extent={{180,-160},{200,-140}})));

  Buildings.Controls.OBC.CDL.Logical.Timer timDXSta1[nCoiCoo](
    each final t=120)
    "Output DX cooling coils proven on signal when status is enabled for two minutes"
    annotation (Placement(transformation(extent={{318,-150},{338,-130}})));

  Buildings.Controls.OBC.CDL.Logical.Not not1 "Logical Not"
    annotation (Placement(transformation(extent={{140,-110},{160,-90}})));

  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea2
    "Convert Boolean to Real number"
    annotation (Placement(transformation(extent={{170,-110},{190,-90}})));

  Buildings.Controls.OBC.CDL.Logical.MultiOr mulOr(
    final nin=nCoiHea)
    "Logical Multi Or"
    annotation (Placement(transformation(extent={{102,-110},{122,-90}})));

  Buildings.Controls.OBC.CDL.Logical.MultiOr mulOr1(
    final nin=nCoiCoo)
    "Logical Multi Or"
    annotation (Placement(transformation(extent={{280,-100},{300,-80}})));

  Buildings.Controls.OBC.CDL.Logical.Not not2
    "Logical Not"
    annotation (Placement(transformation(extent={{310,-100},{330,-80}})));

  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea3
    "Convert Boolean to Real number"
    annotation (Placement(transformation(extent={{340,-100},{360,-80}})));

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant demLimLev1(
    final k=0)
    "Demand limit level, assumes to be 0"
    annotation (Placement(transformation(extent={{910,250},{930,270}})));

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt[nCoiHea](
    final k=1:nCoiHea)
    "Constant integer signal"
    annotation (Placement(transformation(extent={{910,280},{930,300}})));

  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con1[nCoiCoo](
    final k=fill(true, nCoiCoo))
    "Constant Boolean signal"
    annotation (Placement(transformation(extent={{910,350},{930,370}})));

  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con2[nCoiHea](
    final k=fill(true, nCoiHea))
    "Constant Boolean signal"
    annotation (Placement(transformation(extent={{910,320},{930,340}})));

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt1[nCoiCoo](
    final k=1:nCoiCoo)
    "Constant integer signal"
    annotation (Placement(transformation(extent={{940,300},{960,320}})));

  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con(k=true)
    annotation (Placement(transformation(extent={{160,100},{180,120}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea4
    annotation (Placement(transformation(extent={{100,34},{120,54}})));
  Buildings.Controls.OBC.CDL.Continuous.Multiply mul1
    annotation (Placement(transformation(extent={{160,36},{180,56}})));
  Buildings.Controls.OBC.CDL.Continuous.AddParameter addPar(p=1e-6)
    annotation (Placement(transformation(extent={{192,36},{212,56}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea5
    "Convert Boolean to Real number"
    annotation (Placement(transformation(extent={{520,-140},{540,-120}})));
  Buildings.Controls.OBC.CDL.Continuous.Multiply mul2
    annotation (Placement(transformation(extent={{556,-126},{576,-106}})));
  Buildings.Controls.OBC.CDL.Continuous.Hysteresis hys2(each final uLow=0.5,
      each final uHigh=1) "Check if DXs are on"
    annotation (Placement(transformation(extent={{480,-140},{500,-120}})));

equation
  connect(controlBus, modeSelector.cb) annotation (Line(
      points={{-240,-340},{-152,-340},{-152,-303.182},{-196.818,-303.182}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      textString="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(TRooAve.y, controlBus.TRooAve) annotation (Line(
      points={{-319,240},{-240,240},{-240,-340}},
      color={0,0,127}),          Text(
      textString="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(TRet.T, conEco.TRet) annotation (Line(
      points={{100,151},{100,174},{-94,174},{-94,153.333},{-81.3333,153.333}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(TSetRoo.controlBus, controlBus) annotation (Line(
      points={{-288,-342},{-264,-342},{-264,-340},{-240,-340}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(dpDisSupFan.p_rel, conFanSup.u_m) annotation (Line(
      points={{397,4.44089e-16},{396,4.44089e-16},{396,0},{380,0},{380,26},{270,
          26},{270,34}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(conEco.VOut_flow, VOut1.V_flow) annotation (Line(
      points={{-81.3333,142.667},{-90,142.667},{-90,80},{-80,80},{-80,-29}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(occSch.tNexOcc, controlBus.dTNexOcc) annotation (Line(
      points={{-299,-204},{-240,-204},{-240,-340}},
      color={0,0,127},
      smooth=Smooth.None), Text(
      textString="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(occSch.occupied, controlBus.occupied) annotation (Line(
      points={{-299,-216},{-240,-216},{-240,-340}},
      color={255,0,255},
      smooth=Smooth.None), Text(
      textString="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(TOut.y, controlBus.TOut) annotation (Line(points={{-279,180},{-240,180},
          {-240,-340}},                            color={0,0,127}), Text(
      textString="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(conEco.controlBus, controlBus) annotation (Line(points={{-70.6667,
          141.467},{-70.6667,120},{-240,120},{-240,-340}},
                                              color={255,204,51}, thickness=0.5));
  connect(or2.u2, modeSelector.yFan) annotation (Line(points={{-102,-248},{-170,
          -248},{-170,-305.455},{-179.091,-305.455}},
                                     color={255,0,255}));
  connect(VAVBox.y_actual, pSetDuc.u) annotation (Line(points={{762,40},{770,40},
          {770,86},{140,86},{140,-6},{158,-6}},     color={0,0,127}));
  connect(TSup.T, conTSup.TSup) annotation (Line(
      points={{570,-29},{570,-20},{592,-20},{592,-188},{-70,-188},{-70,-214},{
          -62,-214}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(conTSup.yOA, conEco.uOATSup) annotation (Line(
      points={{-38,-220},{-28,-220},{-28,-180},{-152,-180},{-152,158.667},{
          -81.3333,158.667}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(or2.y, conTSup.uEna) annotation (Line(points={{-78,-240},{-70,-240},{
          -70,-226},{-62,-226}}, color={255,0,255}));
  connect(modeSelector.yEco, conEco.uEna) annotation (Line(points={{-179.091,
          -314.545},{-160,-314.545},{-160,100},{-73.3333,100},{-73.3333,137.333}},
        color={255,0,255}));
  connect(TMix.T, conEco.TMix) annotation (Line(points={{40,-29},{40,166},{-90,
          166},{-90,148},{-81.3333,148}},
                                     color={0,0,127}));
  connect(controlBus, TSupSet.controlBus) annotation (Line(
      points={{-240,-340},{-240,-228},{-190,-228}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(TSupSet.TSet, conTSup.TSupSet)
    annotation (Line(points={{-178,-220},{-62,-220}},color={0,0,127}));
  connect(damExh.port_a, TRet.port_b) annotation (Line(points={{-30,-10},{-26,-10},
          {-26,140},{90,140}}, color={0,127,255}));
  connect(freSta.y, or2.u1) annotation (Line(points={{-38,-80},{-20,-80},{-20,-100},
          {-108,-100},{-108,-240},{-102,-240}}, color={255,0,255}));
  connect(TRooMin.y, controlBus.TRooMin) annotation (Line(points={{-318,270},{-240,
          270},{-240,-340}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(TRooMin.u, TRoo) annotation (Line(points={{-342,270},{-360,270},{-360,
          320},{-400,320}}, color={0,0,127}));
  connect(TRooAve.u, TRoo) annotation (Line(points={{-342,240},{-360,240},{-360,
          320},{-400,320}}, color={0,0,127}));
  connect(freSta.u, TMix.T) annotation (Line(points={{-62,-80},{-72,-80},{-72,-60},
          {26,-60},{26,-20},{40,-20},{40,-29}}, color={0,0,127}));
  connect(damExh.port_b, amb.ports[3]) annotation (Line(points={{-50,-10},{-100,
          -10},{-100,-45},{-114,-45}}, color={0,127,255}));
  connect(TRoo, conVAV.TRoo) annotation (Line(
      points={{-400,320},{-360,320},{-360,304},{48,304},{48,96},{548,96},{548,47},
          {578,47}}, color={0,0,127}));
  connect(controlBus.TRooSetHea, TRooHeaSet.u) annotation (Line(
      points={{-240,-340},{-176,-340},{-176,64},{478,64}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(controlBus.TRooSetCoo, TRooCooSet.u) annotation (Line(
      points={{-240,-340},{-220,-340},{-220,30},{478,30}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(TRooHeaSet.y, conVAV.TRooHeaSet) annotation (Line(points={{502,64},{552,
          64},{552,58},{578,58}}, color={0,0,127}));
  connect(TRooCooSet.y, conVAV.TRooCooSet) annotation (Line(points={{502,30},{544,
          30},{544,53},{578,53}}, color={0,0,127}));
  connect(conVAV.yDam, VAVBox.yVAV) annotation (Line(points={{602,55},{716,56}},
          color={0,0,127}));
  connect(conVAV.yVal, VAVBox.yHea) annotation (Line(points={{602,45},{608,45},{
          608,46},{716,46}},  color={0,0,127}));
  connect(VAVBox.VSup_flow, conVAV.VDis_flow) annotation (Line(points={{762,56},
          {780,56},{780,90},{570,90},{570,42},{578,42}}, color={0,0,127}));
  connect(x_pTphi.X[1],RTUCon. XOut) annotation (Line(points={{-279,100},{-200,
          100},{-200,240.75},{1008,240.75}},
                                  color={0,0,127}));
  connect(RTUCon.TOut, TOut.y) annotation (Line(points={{1008,242.5},{-210,
          242.5},{-210,180},{-279,180}},
                            color={0,0,127}));
  connect(RTUCon.yDXCooCoi,booToRea. u) annotation (Line(points={{1032,256.5},{
          1060,256.5},{1060,256},{1088,256}},
                 color={255,0,255}));
  connect(booToRea.y,mul. u1) annotation (Line(points={{1112,256},{1120,256},{
          1120,246},{1128,246}},
                            color={0,0,127}));
  connect(RTUCon.yComSpeCoo,mul. u2) annotation (Line(points={{1032,248.333},{
          1080,248.333},{1080,234},{1128,234}},
                                         color={0,0,127}));
  connect(RTUCon.yDXHeaCoi, ParDXCoiHea.on) annotation (Line(points={{1032,
          251.95},{1052,251.95},{1052,252},{1070,252},{1070,-180},{90,-180},{90,
          -48},{99,-48}}, color={255,0,255}));
  connect(timDXSta1.passed,RTUCon. uDXCooCoi) annotation (Line(points={{340,
          -148},{950,-148},{950,258.833},{1008,258.833}},
                                                  color={255,0,255}));
  connect(timDXSta.passed,RTUCon. uDXHeaCoi) annotation (Line(points={{202,-158},
          {960,-158},{960,257.083},{1008,257.083}},
                                            color={255,0,255}));
  connect(hys1.y,timDXSta1. u) annotation (Line(points={{302,-140},{316,-140}},
          color={255,0,255}));
  connect(hys.y,timDXSta. u) annotation (Line(points={{162,-150},{178,-150}},
          color={255,0,255}));
  connect(ParDXCoiCoo.P,hys1. u) annotation (Line(points={{261,-48},{270,-48},{
          270,-140},{278,-140}},       color={0,0,127}));
  connect(ParDXCoiHea.P, hys.u) annotation (Line(points={{121,-32},{130,-32},{130,
          -150},{138,-150}},      color={0,0,127}));
  for i in 1:nCoiCoo loop
  end for;
  for i in 1:nCoiHea loop
    connect(ParDXCoiHea.TOut, TOut.y) annotation (Line(points={{99,-36},{
            80,-36},{80,70},{-220,70},{-220,180},{-279,180}}, color={0,0,127}));
    connect(ParDXCoiHea.phi, Phi.y) annotation (Line(points={{99,-32},{90,
            -32},{90,60},{-260,60},{-260,140},{-279,140}}, color={0,0,127}));
  end for;
  connect(RTUCon.uCooCoi, conTSup.yCoo) annotation (Line(points={{1008,246.117},
          {970,246.117},{970,-226},{-38,-226}},
                                           color={0,0,127}));
  connect(RTUCon.uHeaCoi, conTSup.yHea) annotation (Line(points={{1008,244.25},
          {980,244.25},{980,-214},{-38,-214}},
                                           color={0,0,127}));

  connect(not1.y,booToRea2. u)
    annotation (Line(points={{162,-100},{168,-100}},
                                                   color={255,0,255}));
  connect(mulOr.y, not1.u)
    annotation (Line(points={{124,-100},{138,-100}}, color={255,0,255}));
  connect(RTUCon.yDXHeaCoi[1:nCoiHea], mulOr.u[1:nCoiHea]) annotation (Line(points={{1032,
          251.95},{1070,251.95},{1070,-180},{90,-180},{90,-100},{100,-100}},
                                                                      color={255,
          0,255}));
  connect(not2.y,booToRea3. u)
    annotation (Line(points={{332,-90},{338,-90}}, color={255,0,255}));
  connect(mulOr1.y, not2.u)
    annotation (Line(points={{302,-90},{308,-90}}, color={255,0,255}));
  connect(RTUCon.yDXCooCoi[1:nCoiCoo], mulOr1.u[1:nCoiCoo]) annotation (Line(points={{1032,
          256.5},{1060,256.5},{1060,-170},{260,-170},{260,-90},{278,-90}},color={255,0,255}));
  connect(TSupSet.TSet, RTUCon.TSupCoiSet) annotation (Line(points={{-178,-220},
          {1000,-220},{1000,234},{1008,234},{1008,233.75}},
                                       color={0,0,127}));
  connect(RTUCon.uDemLimLev,demLimLev1. y) annotation (Line(points={{1008,
          248.333},{1008,248},{940,248},{940,260},{932,260}},
                                         color={255,127,0}));
  connect(RTUCon.uCooCoiAva,con1. y) annotation (Line(points={{1008,255.333},{
          1008,256},{1000,256},{1000,360},{932,360}},
                                               color={255,0,255}));
  connect(RTUCon.uHeaCoiAva,con2. y) annotation (Line(points={{1008,253.583},{
          1008,254},{992,254},{992,330},{932,330}},
                                          color={255,0,255}));
  connect(RTUCon.uCooCoiSeq,conInt1. y) annotation (Line(points={{1008,251.833},
          {980,251.833},{980,310},{962,310}},
                                        color={255,127,0}));
  connect(conInt.y, RTUCon.uHeaCoiSeq) annotation (Line(points={{932,290},{970,
          290},{970,250.083},{1008,250.083}},
                                        color={255,127,0}));
  connect(con.y, conFanSup.uFan) annotation (Line(points={{182,110},{220,110},{
          220,52},{258,52}}, color={255,0,255}));
  connect(conFanSup.y, fanSup.y)
    annotation (Line(points={{281,46},{396,46},{396,-28}}, color={0,0,127}));
  connect(booToRea4.y, mul1.u1) annotation (Line(points={{122,44},{150,44},{150,
          52},{158,52}}, color={0,0,127}));
  connect(pSetDuc.y, mul1.u2) annotation (Line(points={{181,-6},{190,-6},{190,
          26},{150,26},{150,40},{158,40}}, color={0,0,127}));
  connect(mul1.y, addPar.u)
    annotation (Line(points={{182,46},{190,46}}, color={0,0,127}));
  connect(addPar.y, conFanSup.u) annotation (Line(points={{214,46},{258,46}},
                             color={0,0,127}));
  connect(modeSelector.yFan, booToRea4.u) annotation (Line(points={{-179.091,
          -305.455},{-174,-305.455},{-174,-306},{-170,-306},{-170,44},{98,44}},
        color={255,0,255}));
  connect(booToRea5.y, mul2.u2) annotation (Line(points={{542,-130},{550,-130},
          {550,-122},{554,-122}},
                       color={0,0,127}));
  connect(mul2.u1, RTUCon.yAuxHea) annotation (Line(points={{554,-110},{550,
          -110},{550,-94},{1032,-94},{1032,240.283}}, color={0,0,127}));
  connect(mul2.y, AuxHeaCoi.u) annotation (Line(points={{578,-116},{586,-116},{
          586,-60},{470,-60},{470,-34},{478,-34}},
                                         color={0,0,127}));
  connect(hys2.y, booToRea5.u)
    annotation (Line(points={{502,-130},{518,-130}}, color={255,0,255}));
  connect(fanSup.y_actual, hys2.u) annotation (Line(points={{407,-33},{407,-34},
          {412,-34},{412,-130},{478,-130}},
                       color={0,0,127}));
  connect(conEco.yRet, damRet.y) annotation (Line(points={{-58.6667,146.667},{
          -12,146.667},{-12,-10}}, color={0,0,127}));
  connect(conEco.yOA, damExh.y) annotation (Line(points={{-58.6667,152},{-40,
          152},{-40,2}}, color={0,0,127}));
  connect(conEco.yOA, damOut.y) annotation (Line(points={{-58.6667,152},{-40,
          152},{-40,20},{-20,20},{-20,-20},{-40,-20},{-40,-28}}, color={0,0,127}));
  connect(ParDXCoiHea.uDam, booToRea2.y) annotation (Line(points={{98,-44},{80,-44},
          {80,-80},{200,-80},{200,-100},{192,-100}}, color={0,0,127}));
  connect(RTUCon.TSupCoiHea, ParDXCoiHea.TAirSupCoi) annotation (Line(points={{
          1008,237.25},{1008,238},{134,238},{134,-46},{122,-46}}, color={0,0,
          127}));
  connect(ParDXCoiCoo.TOut, TOut.y) annotation (Line(points={{239,-44},{224,-44},
          {224,70},{-220,70},{-220,180},{-279,180}}, color={0,0,127}));
  connect(RTUCon.TSupCoiCoo, ParDXCoiCoo.TAirSupCoi) annotation (Line(points={{1008,
          235.5},{990,235.5},{990,-14},{270,-14},{270,-34},{262,-34}}, color={0,
          0,127}));
  connect(booToRea3.y, ParDXCoiCoo.uDam) annotation (Line(points={{362,-90},{
          372,-90},{372,-6},{228,-6},{228,-36},{238,-36}}, color={0,0,127}));
  connect(mul.y, ParDXCoiCoo.speRat) annotation (Line(points={{1152,240},{1160,
          240},{1160,-20},{232,-20},{232,-32},{239,-32}}, color={0,0,127}));
  annotation (
  defaultComponentName="hvac",
    Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-380,-400},{1420,
            660}})),
    Documentation(info="<html>
  <p>
  This model replaced an air handler unit (AHU) within a variable air flow (VAV) system,
  as introduced in 
  <a href=\"modelica://Buildings.Examples.VAVReheat.BaseClasses.ASHRAE2006\">
  Buildings.Examples.VAVReheat.BaseClasses.ASHRAE2006</a>, 
  with a rooftop unit (RTU). 
  </p>
  </html>", revisions="<html>
  <ul>
  <li>
  August 28, 2023, by Junke Wang and Karthik Devaprasad:<br/>
  First implementation.
  </li>
  </ul>
  </html>"),
    Icon(graphics={
        Rectangle(
          extent={{240,172},{220,100}},
          lineColor={175,175,175},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{240,172},{220,100}},
          lineColor={175,175,175},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{400,100},{-158,60}},
          lineColor={175,175,175},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-30,96},{-2,82}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{400,-12},{-158,-52}},
          lineColor={175,175,175},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-78,60},{-118,-12}},
          lineColor={175,175,175},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-46,96},{-12,62}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-36,86},{-22,72}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{42,100},{56,60}},
          lineColor={255,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{104,100},{118,60}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-138,100},{-124,60}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-138,-12},{-124,-52}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-7,20},{7,-20}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward,
          origin={-98,23},
          rotation=90),
        Line(points={{106,60},{106,-6}}, color={0,0,255}),
        Line(points={{116,60},{116,-6}}, color={0,0,255}),
        Line(points={{106,34},{116,34}},   color={0,0,255}),
        Polygon(
          points={{-5,-4},{3,-4},{-1,4},{-5,-4}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          origin={107,16}),
        Ellipse(
          extent={{100,54},{112,42}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{106,54},{100,48},{112,48},{106,54}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-5,4},{3,4},{-1,-4},{-5,4}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          origin={107,24}),
        Line(points={{44,60},{44,-6}},   color={0,0,255}),
        Line(points={{54,60},{54,-6}},   color={0,0,255}),
        Line(points={{44,34},{54,34}},     color={0,0,255}),
        Polygon(
          points={{-5,-4},{3,-4},{-1,4},{-5,-4}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          origin={45,16}),
        Ellipse(
          extent={{38,54},{50,42}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{44,54},{38,48},{50,48},{44,54}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-5,4},{3,4},{-1,-4},{-5,4}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          origin={45,24}),
        Rectangle(
          extent={{320,172},{300,100}},
          lineColor={175,175,175},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{280,172},{260,100}},
          lineColor={175,175,175},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{400,172},{380,100}},
          lineColor={175,175,175},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{360,172},{340,100}},
          lineColor={175,175,175},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{240,20},{220,-12}},
          lineColor={175,175,175},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{280,20},{260,-12}},
          lineColor={175,175,175},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{320,20},{300,-12}},
          lineColor={175,175,175},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{360,20},{340,-12}},
          lineColor={175,175,175},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{400,20},{380,-12}},
          lineColor={175,175,175},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{380,136},{400,124}},
          lineColor={255,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-7,10},{7,-10}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward,
          origin={390,153},
          rotation=90),
        Rectangle(
          extent={{-7,10},{7,-10}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward,
          origin={350,153},
          rotation=90),
        Rectangle(
          extent={{340,136},{360,124}},
          lineColor={255,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{300,136},{320,124}},
          lineColor={255,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-7,10},{7,-10}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward,
          origin={310,153},
          rotation=90),
        Rectangle(
          extent={{-7,10},{7,-10}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward,
          origin={270,153},
          rotation=90),
        Rectangle(
          extent={{260,136},{280,124}},
          lineColor={255,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{220,136},{240,124}},
          lineColor={255,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-7,10},{7,-10}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward,
          origin={230,153},
          rotation=90)}));
end ASHRAE2006_RTU;
