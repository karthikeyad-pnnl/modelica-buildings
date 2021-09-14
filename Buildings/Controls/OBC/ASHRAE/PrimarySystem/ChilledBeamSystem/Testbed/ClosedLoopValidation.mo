within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChilledBeamSystem.Testbed;
block ClosedLoopValidation
  parameter Real schTab[5,2]=[0,0; 8,1; 18,1; 21,0; 24,0]
    "Table defining schedule for enabling plant";

  TestBed testBed
    annotation (Placement(transformation(extent={{60,-20},{128,20}})));
  TerminalController terCon[2](
    VDes_occ=0.5,
    VDes_unoccSch=0.1,
    VDes_unoccUnsch=0.2) "Terminal controllers"
    annotation (Placement(transformation(extent={{10,40},{30,60}})));
  SystemController sysCon(nPum=1, nVal=2)
    annotation (Placement(transformation(extent={{10,-70},{30,-50}})));
  FDE.DOAS.DOAScontroller_modified DOAScon
    annotation (Placement(transformation(extent={{-4,-18},{16,18}})));
  CDL.Continuous.MultiMax mulMax(nin=2)
    annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
  CDL.Continuous.MultiMax mulMax1(nin=2)
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  CDL.Continuous.Sources.TimeTable                        enaSch(
    final table=schTab,
    final smoothness=Buildings.Controls.OBC.CDL.Types.Smoothness.ConstantSegments,
    final timeScale=3600)
    "Table defining when occupancy is expected"
    annotation (Placement(transformation(extent={{-150,70},{-130,90}})));

  CDL.Continuous.Hysteresis hys
    annotation (Placement(transformation(extent={{-120,70},{-100,90}})));
  CDL.Routing.BooleanReplicator booRep(nout=2)
    annotation (Placement(transformation(extent={{-90,70},{-70,90}})));
  CDL.Logical.Sources.Constant con[2](k=fill(false, 2))
    "Constant Boolean source"
    annotation (Placement(transformation(extent={{-90,30},{-70,50}})));
  CDL.Continuous.Sources.Constant con1(k=273.15 + 12)
    annotation (Placement(transformation(extent={{-90,-30},{-70,-10}})));
equation
  connect(terCon.yReh, testBed.uCAVReh)
    annotation (Line(points={{32,58},{50,58},{50,7},{58,7}},
                                                           color={0,0,127}));
  connect(terCon.yChiVal, testBed.uChiWatVal) annotation (Line(points={{32,54},
          {48,54},{48,14},{58,14}},color={0,0,127}));
  connect(terCon.yDam, testBed.uCAVDam)
    annotation (Line(points={{32,50},{52,50},{52,11},{58,11}},
                                                             color={0,0,127}));
  connect(sysCon.yChiWatPum[1], testBed.uPumSta) annotation (Line(points={{32,-56},
          {54,-56},{54,-11},{58,-11}},
                                    color={255,0,255}));
  connect(sysCon.yPumSpe, testBed.uPumSpe) annotation (Line(points={{32,-60},{
          52,-60},{52,-14},{58,-14}},
                                 color={0,0,127}));
  connect(testBed.yPumSta, sysCon.uPumSta[1]) annotation (Line(points={{130,-12},
          {142,-12},{142,-80},{-2,-80},{-2,-56},{8,-56}},   color={255,0,255}));
  connect(testBed.dPChiWat, sysCon.dPChiWatLoo) annotation (Line(points={{130,-9},
          {146,-9},{146,-86},{-6,-86},{-6,-60},{8,-60}},   color={0,0,127}));
  connect(testBed.yChiWatVal, sysCon.uValPos) annotation (Line(points={{130,8},
          {140,8},{140,-74},{4,-74},{4,-64},{8,-64}}, color={0,0,127}));
  connect(testBed.yChiWatVal, terCon.uChiVal) annotation (Line(points={{130,8},
          {140,8},{140,80},{0,80},{0,42},{8,42}}, color={0,0,127}));
  connect(testBed.TZon, terCon.TZon) annotation (Line(points={{130,16},{136,16},
          {136,74},{4,74},{4,50},{8,50}},  color={0,0,127}));
  connect(testBed.VDisAir, terCon.VDis_flow) annotation (Line(points={{130,4},{
          138,4},{138,76},{2,76},{2,46},{8,46}},  color={0,0,127}));
  connect(sysCon.yBypValPos, testBed.uBypValPos) annotation (Line(points={{32,-64},
          {44,-64},{44,17},{58,17}},color={0,0,127}));
  connect(DOAScon.supFanStart, testBed.uFanSta) annotation (Line(points={{18.2,
          13.1294},{30,13.1294},{30,4},{58,4}},  color={255,0,255}));
  connect(DOAScon.supFanSpeed, testBed.uFanSpe) annotation (Line(points={{18.2,
          9.74118},{28,9.74118},{28,1},{58,1}},  color={0,0,127}));
  connect(DOAScon.yRHC, testBed.uHeaCoi) annotation (Line(points={{18.2,3.17647},
          {26,3.17647},{26,-5},{58,-5}},  color={0,0,127}));
  connect(DOAScon.yCC, testBed.uCooCoi) annotation (Line(points={{18.2,6.35294},
          {24,6.35294},{24,-8},{58,-8}},  color={0,0,127}));
  connect(testBed.dPDOASAir, DOAScon.DDSP) annotation (Line(points={{130,-2},{
          138,-2},{138,-40},{-20,-40},{-20,9.95294},{-6,9.95294}},
                                                               color={0,0,127}));
  connect(testBed.TDOASDis, DOAScon.saT) annotation (Line(points={{130,-15},{
          132,-15},{132,-30},{-10,-30},{-10,1.90588},{-6,1.90588}},
                                                           color={0,0,127}));
  connect(mulMax.y, DOAScon.highSpaceT) annotation (Line(points={{-18,60},{-10,
          60},{-10,4.65882},{-6,4.65882}},
                                        color={0,0,127}));
  connect(testBed.TZon, mulMax.u[1:2]) annotation (Line(points={{130,16},{136,
          16},{136,74},{4,74},{4,86},{-46,86},{-46,59},{-42,59}},color={0,0,127}));
  connect(testBed.yDamPos, mulMax1.u[1:2]) annotation (Line(points={{130,1},{
          144,1},{144,90},{-48,90},{-48,29},{-42,29}},
                                               color={0,0,127}));
  connect(mulMax1.y, DOAScon.mostOpenDam) annotation (Line(points={{-18,30},{
          -14,30},{-14,15.0353},{-6,15.0353}},
                                            color={0,0,127}));
  connect(testBed.yFanSta, DOAScon.supFanStatus) annotation (Line(points={{130,-5},
          {134,-5},{134,38},{-12,38},{-12,12.4941},{-6,12.4941}},color={255,0,255}));
  connect(testBed.relHumDOASRet, DOAScon.retHum) annotation (Line(points={{130,-18},
          {134,-18},{134,-36},{-16,-36},{-16,7.41176},{-6,7.41176}},color={0,0,127}));
  connect(enaSch.y[1], hys.u)
    annotation (Line(points={{-128,80},{-122,80}}, color={0,0,127}));
  connect(hys.y, booRep.u)
    annotation (Line(points={{-98,80},{-92,80}}, color={255,0,255}));
  connect(booRep.y, terCon.uDetOcc) annotation (Line(points={{-68,80},{-4,80},{
          -4,58},{8,58}}, color={255,0,255}));
  connect(con.y, terCon.uConSen) annotation (Line(points={{-68,40},{-60,40},{
          -60,48},{-4,48},{-4,54},{8,54}}, color={255,0,255}));
  connect(hys.y, DOAScon.occ) annotation (Line(points={{-98,80},{-96,80},{-96,
          17.5765},{-6,17.5765}}, color={255,0,255}));
  connect(con1.y, testBed.TChiWatSup) annotation (Line(points={{-68,-20},{40,
          -20},{40,-18},{58,-18}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,-100},
            {160,100}})),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-160,-100},{160,100}})));
end ClosedLoopValidation;
