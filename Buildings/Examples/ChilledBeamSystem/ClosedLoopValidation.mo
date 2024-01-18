within Buildings.Examples.ChilledBeamSystem;
block ClosedLoopValidation
  extends Modelica.Icons.Example;
  parameter Real schTab[5,2]=[0,0; 8,1; 18,1; 21,0; 24,0]
    "Table defining schedule for enabling plant";

  BaseClasses.TestBed chiBeaTesBed(
    TChiWatRet_nominal=273.15 + 25,
    mChiWatTot_flow_nominal=2.114,
    mAirTot_flow_nominal=1*0.676*1.225,
    mHotWatCoi_nominal=0.078,
    mChiWatCoi_nominal=0.645,
    VRooSou=239.25,
    mChiWatSou_flow_nominal=0.387,
    mAirSou_flow_nominal=1*0.143*1.225,
    mAChiBeaSou_flow_nominal=0.143*1.225,
    VRooEas=103.31,
    mChiWatEas_flow_nominal=0.9,
    mAirEas_flow_nominal=1*0.065*1.225,
    mAChiBeaEas_flow_nominal=1*0.065*1.225,
    VRooNor=239.25,
    mChiWatNor_flow_nominal=0.253,
    mAirNor_flow_nominal=1*0.143*1.225,
    mAChiBeaNor_flow_nominal=0.143*1.225,
    VRooWes=103.31,
    mChiWatWes_flow_nominal=0.262,
    mAirWes_flow_nominal=1*0.065*1.225,
    mAChiBeaWes_flow_nominal=0.065*1.225,
    VRooCor=447.68,
    mChiWatCor_flow_nominal=0.27,
    mAirCor_flow_nominal=1*0.26*1.225,
    mAChiBeaCor_flow_nominal=0.26*1.225) "Chilled beam system test-bed"
    annotation (Placement(transformation(extent={{88,-16},{108,32}})));
  Buildings.Controls.OBC.ChilledBeams.Terminal.Controller terCon[5](
    controllerTypeCoo=Buildings.Controls.OBC.CDL.Types.SimpleController.PID,
    TiCoo=fill(50, 5),
    TdCoo={0.1,100,0.1,0.1,0.1},
    VDes_occ={0.143,0.065,0.143,0.065,0.26},
    VDes_unoccSch={0.028,0.012,0.028,0.012,0.052},
    VDes_unoccUnsch={0.056,0.024,0.056,0.024,0.104})
                         "Terminal controllers"
    annotation (Placement(transformation(extent={{10,40},{30,60}})));
  Buildings.Controls.OBC.ChilledBeams.System.Controller sysCon(nPum=1, nVal=5,
    minPumSpe=0.7,
    TiPumSpe=50,
    kBypVal=10e-3,
    TiBypVal=900)
    annotation (Placement(transformation(extent={{10,-70},{30,-50}})));
  Buildings.Controls.OBC.FDE.DOAS.DOAScontroller DOAScon(
    minDDSPset=400,
    maxDDSPset=500,
    cvDDSPset=450)
    annotation (Placement(transformation(extent={{-4,-16},{16,20}})));
  Buildings.Controls.OBC.CDL.Continuous.MultiMax TZonMax(nin=5)
    annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
  Buildings.Controls.OBC.CDL.Continuous.MultiMax yDamPosMax(nin=5)
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.TimeTable                        enaSch(
    final table=schTab,
    final smoothness=Buildings.Controls.OBC.CDL.Types.Smoothness.ConstantSegments,
    final timeScale=3600) "Table defining when occupancy is expected"
    annotation (Placement(transformation(extent={{-150,70},{-130,90}})));

  Buildings.Controls.OBC.CDL.Continuous.Hysteresis hys(uLow=0.45, uHigh=0.5)
    annotation (Placement(transformation(extent={{-120,70},{-100,90}})));
  Buildings.Controls.OBC.CDL.Routing.BooleanScalarReplicator booRep(nout=5)
    annotation (Placement(transformation(extent={{-90,70},{-70,90}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant uConSig[5](k=fill(false,
        5)) "Constant Boolean source"
    annotation (Placement(transformation(extent={{-90,30},{-70,50}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant chiWatSupTem(k=273.15
         + 7.22) "Chilled water supply temperature"
    annotation (Placement(transformation(extent={{-90,-30},{-70,-10}})));
  Modelica.Blocks.Sources.CombiTimeTable loads(
    tableOnFile=true,
    tableName="tab1",
    fileName=
        "C:/buildings_library/buildings_library_pnnl/VM_script/inputTable_constantSetpoint.txt",
    columns={2,3,4,5,6},
    timeScale=60) "Table defining thermal loads for zone"
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));

equation
  connect(terCon.yReh, chiBeaTesBed.uCAVReh) annotation (Line(points={{32,55},{50,
          55},{50,14},{86,14}},    color={0,0,127}));
  connect(terCon.yChiVal, chiBeaTesBed.uChiWatVal) annotation (Line(points={{32,52.5},
          {48,52.5},{48,22},{86,22}},   color={0,0,127}));
  connect(terCon.yDam, chiBeaTesBed.uCAVDam) annotation (Line(points={{32,50},{
          52,50},{52,18},{86,18}}, color={0,0,127}));
  connect(sysCon.yChiWatPum[1], chiBeaTesBed.uPumSta) annotation (Line(points={{32,-54},
          {54,-54},{54,-6},{86,-6}},          color={255,0,255}));
  connect(sysCon.yPumSpe, chiBeaTesBed.uPumSpe) annotation (Line(points={{32,
          -60},{52,-60},{52,-10},{86,-10}}, color={0,0,127}));
  connect(chiBeaTesBed.yPumSta, sysCon.uPumSta[1]) annotation (Line(points={{110,-6},
          {142,-6},{142,-80},{0,-80},{0,-54},{8,-54}},         color={255,0,255}));
  connect(chiBeaTesBed.dPChiWat, sysCon.dPChiWatLoo) annotation (Line(points={{
          110,-2},{146,-2},{146,-86},{-6,-86},{-6,-60},{8,-60}}, color={0,0,127}));
  connect(chiBeaTesBed.yChiWatVal, sysCon.uValPos) annotation (Line(points={{110,14},
          {140,14},{140,-74},{4,-74},{4,-66},{8,-66}},         color={0,0,127}));
  connect(chiBeaTesBed.yChiWatVal, terCon.uChiVal) annotation (Line(points={{110,14},
          {140,14},{140,80},{0,80},{0,41.25},{8,41.25}},   color={0,0,127}));
  connect(sysCon.yBypValPos, chiBeaTesBed.uBypValPos) annotation (Line(points={{32,-66},
          {44,-66},{44,26},{86,26}},          color={0,0,127}));
  connect(DOAScon.supFanStart, chiBeaTesBed.uFanSta) annotation (Line(points={{18.2,
          15.1294},{30,15.1294},{30,10},{86,10}},      color={255,0,255}));
  connect(DOAScon.supFanSpeed, chiBeaTesBed.uFanSpe) annotation (Line(points={{18.2,
          11.7412},{28,11.7412},{28,6},{86,6}},      color={0,0,127}));
  connect(DOAScon.yRHC, chiBeaTesBed.uHeaCoi) annotation (Line(points={{18.2,5.17647},
          {26,5.17647},{26,2},{86,2}},          color={0,0,127}));
  connect(DOAScon.yCC, chiBeaTesBed.uCooCoi) annotation (Line(points={{18.2,8.35294},
          {24,8.35294},{24,-2},{86,-2}},          color={0,0,127}));
  connect(chiBeaTesBed.dPDOASAir, DOAScon.DDSP) annotation (Line(points={{110,6},
          {138,6},{138,-40},{-20,-40},{-20,11.9529},{-6,11.9529}}, color={0,0,
          127}));
  connect(chiBeaTesBed.TDOASDis, DOAScon.saT) annotation (Line(points={{110,-10},
          {132,-10},{132,-30},{-10,-30},{-10,3.90588},{-6,3.90588}}, color={0,0,
          127}));
  connect(TZonMax.y, DOAScon.highSpaceT) annotation (Line(points={{-18,60},{-10,
          60},{-10,6.65882},{-6,6.65882}}, color={0,0,127}));
  connect(yDamPosMax.y, DOAScon.mostOpenDam) annotation (Line(points={{-18,30},{
          -14,30},{-14,17.0353},{-6,17.0353}},  color={0,0,127}));
  connect(chiBeaTesBed.yFanSta, DOAScon.supFanStatus) annotation (Line(points={{110,2},
          {134,2},{134,38},{-12,38},{-12,14.4941},{-6,14.4941}},         color=
          {255,0,255}));
  connect(chiBeaTesBed.relHumDOASRet, DOAScon.retHum) annotation (Line(points={{110,-14},
          {114,-14},{114,-24},{-16,-24},{-16,9.41176},{-6,9.41176}},
        color={0,0,127}));
  connect(enaSch.y[1], hys.u)
    annotation (Line(points={{-128,80},{-122,80}}, color={0,0,127}));
  connect(hys.y, booRep.u)
    annotation (Line(points={{-98,80},{-92,80}}, color={255,0,255}));
  connect(booRep.y, terCon.uDetOcc) annotation (Line(points={{-68,80},{-4,80},{
          -4,58},{8,58}}, color={255,0,255}));
  connect(uConSig.y, terCon.uConSen) annotation (Line(points={{-68,40},{-60,40},
          {-60,48},{-4,48},{-4,48.75},{8,48.75}},
                                            color={255,0,255}));
  connect(hys.y, DOAScon.occ) annotation (Line(points={{-98,80},{-96,80},{-96,
          19.5765},{-6,19.5765}}, color={255,0,255}));
  connect(chiWatSupTem.y, chiBeaTesBed.TChiWatSup) annotation (Line(points={{
          -68,-20},{40,-20},{40,-14},{86,-14}}, color={0,0,127}));
  connect(chiBeaTesBed.TZon, terCon.TZon) annotation (Line(points={{110,26},{132,
          26},{132,72},{4,72},{4,46.25},{8,46.25}},
                                                  color={0,0,127}));
  connect(chiBeaTesBed.VDisAir_flow, terCon.VDis_flow) annotation (Line(points={{110,22},
          {136,22},{136,76},{2,76},{2,43.75},{8,43.75}},     color={0,0,127}));
  connect(chiBeaTesBed.TZon, TZonMax.u[1:5]) annotation (Line(points={{110,26},
          {132,26},{132,72},{-44,72},{-44,58.4},{-42,58.4}}, color={0,0,127}));
  connect(chiBeaTesBed.yDamPos, yDamPosMax.u[1:5]) annotation (Line(points={{
          110,10},{148,10},{148,86},{-50,86},{-50,28.4},{-42,28.4}}, color={0,0,
          127}));
  connect(loads.y, chiBeaTesBed.QFlo) annotation (Line(points={{-39,-50},{-30,
          -50},{-30,14},{-16,14},{-16,28},{46,28},{46,30},{86,30}}, color={0,0,
          127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}})),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-160,-100},{160,100}})),
    experiment(
      StartTime=16848000,
      StopTime=16934400,
      Interval=600,
      Tolerance=1e-06,
      __Dymola_Algorithm="Cvode"));
end ClosedLoopValidation;
