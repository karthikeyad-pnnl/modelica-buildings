within Buildings;
package Chilled_Beam_Test
  model ClosedLoopValidation_test1
    extends Modelica.Icons.Example;
    parameter Real schTab[5, 2] = [0, 0; 8, 1; 18, 1; 21, 0; 24, 0] "Table defining schedule for enabling plant";
    Buildings.Examples.ChilledBeamSystem.BaseClasses.TestBed chiBeaTesBed(TChiWatRet_nominal = 273.15 + 25, mChiWatTot_flow_nominal = 2.114, mAirTot_flow_nominal = 1*0.676*1.225, mHotWatCoi_nominal = 0.078, mChiWatCoi_nominal = 0.645,
      mCooAir_flow_nominal=1*0.676*1.225,
      mHeaAir_flow_nominal=1*0.676*1.225,
      THeaWatInl_nominal=313.15,
      THeaWatOut_nominal=298.15,
      THeaAirInl_nominal=285.85,
      THeaAirDis_nominal=308.15,                                                                                                                                                                                                     VRooSou = 239.25, mChiWatSou_flow_nominal = 0.387, mAirSou_flow_nominal = 1*0.143*1.225, mAChiBeaSou_flow_nominal = 0.143*1.225, VRooEas = 103.31, mChiWatEas_flow_nominal = 0.9, mAirEas_flow_nominal = 1*0.065*1.225, mAChiBeaEas_flow_nominal = 1*0.065*1.225, VRooNor = 239.25, mChiWatNor_flow_nominal = 0.253, mAirNor_flow_nominal = 1*0.143*1.225, mAChiBeaNor_flow_nominal = 0.143*1.225, VRooWes = 103.31, mChiWatWes_flow_nominal = 0.262, mAirWes_flow_nominal = 1*0.065*1.225, mAChiBeaWes_flow_nominal = 0.065*1.225, VRooCor = 447.68, mChiWatCor_flow_nominal = 0.27, mAirCor_flow_nominal = 1*0.26*1.225, mAChiBeaCor_flow_nominal = 0.26*1.225) "Chilled beam system test-bed" annotation (
      Placement(visible = true, transformation(origin={-98,-24},    extent = {{88, -16}, {108, 32}}, rotation = 0)));
    Buildings.Controls.OBC.ChilledBeams.Terminal.Controller terCon[5](TdCoo = {0.1, 100, 0.1, 0.1, 0.1}, TiCoo = fill(50, 5), VDes_occ = {0.143, 0.065, 0.143, 0.065, 0.26}, VDes_unoccSch = {0.028, 0.012, 0.028, 0.012, 0.052}, VDes_unoccUnsch = {0.056, 0.024, 0.056, 0.024, 0.104}, controllerTypeCoo = fill(Buildings.Controls.OBC.CDL.Types.SimpleController.PID, 5)) "Terminal controllers" annotation (
      Placement(visible = true, transformation(origin={32,14},   extent = {{10, 40}, {30, 60}}, rotation = 0)));
    Buildings.Controls.OBC.ChilledBeams.System.Controller sysCon(nPum = 1, nVal = 5, minPumSpe = 0.7,
      maxPumSpe=1,                                                                                    TiPumSpe = 50,
      dPChiWatMax=1,                                                                                                 kBypVal = 10e-3, TiBypVal = 900,
      chiWatStaPreMax=1,
      chiWatStaPreMin=1,
      triAmoVal=0,
      resAmoVal=1,
      maxResVal=1,
      samPerVal=1,
      delTimVal=60)                                                                                                                                   annotation (
      Placement(visible = true, transformation(origin={112,-20},   extent = {{10, -70}, {30, -50}}, rotation = 0)));
    Buildings.Controls.OBC.FDE.DOAS.DOAScontroller DOAScon   annotation (
      Placement(visible = true, transformation(origin={-39,-10},  extent = {{-13, -24}, {13, 10}}, rotation = 0)));
    Buildings.Controls.OBC.CDL.Reals.MultiMax TZonMax(nin=5)   annotation (
      Placement(transformation(extent={{-40,52},{-20,72}})));
    Buildings.Controls.OBC.CDL.Reals.MultiMax yDamPosMax(nin=5)   annotation (
      Placement(transformation(extent={{-58,20},{-38,40}})));
    Buildings.Controls.OBC.CDL.Reals.Sources.TimeTable enaSch(final table = schTab, final smoothness = Buildings.Controls.OBC.CDL.Types.Smoothness.ConstantSegments, final timeScale = 3600) "Table defining when occupancy is expected" annotation (
      Placement(transformation(extent = {{-150, 70}, {-130, 90}})));
    Buildings.Controls.OBC.CDL.Reals.Hysteresis hys(uLow = 0.45, uHigh = 0.5) annotation (
      Placement(transformation(extent = {{-120, 70}, {-100, 90}})));
    Buildings.Controls.OBC.CDL.Routing.BooleanScalarReplicator booRep(nout = 5) annotation (
      Placement(transformation(extent = {{-90, 70}, {-70, 90}})));
    Buildings.Controls.OBC.CDL.Logical.Sources.Constant uConSig[5](k = fill(false, 5)) "Constant Boolean source" annotation (
      Placement(visible = true, transformation(origin={2,14},    extent = {{-90, 30}, {-70, 50}}, rotation = 0)));
    Buildings.Controls.OBC.CDL.Reals.Sources.Constant chiWatSupTem(k = 273.15 + 7.22) "Chilled water supply temperature" annotation (
      Placement(transformation(extent={{-148,-26},{-128,-6}})));
    Modelica.Blocks.Sources.CombiTimeTable loads(
      tableOnFile = true,
      tableName = "tab1",
      fileName=ModelicaServices.ExternalReferences.loadResource(
          "./Buildings/Resources/Data/Examples/ChilledBeamSystem/zoneLoads.txt"),
      columns = {2, 3, 4, 5, 6},
      timeScale = 60)
      "Table defining thermal loads for zone"
      annotation (Placement(transformation(extent={{-160,-60},{-140,-40}})));
    Buildings.Controls.SetPoints.OccupancySchedule occSch(occupancy = 3600*{8, 18}) annotation (
      Placement(visible = true, transformation(origin={-6,74},   extent = {{-152, -44}, {-132, -24}}, rotation = 0)));
    Buildings.Controls.OBC.CDL.Reals.Sources.TimeTable TSetRooHea(extrapolation = Buildings.Controls.OBC.CDL.Types.Extrapolation.Periodic, smoothness = Buildings.Controls.OBC.CDL.Types.Smoothness.ConstantSegments, table = [0, 15 + 273.15; 8*3600, 20 + 273.15; 18*3600, 15 + 273.15; 24*3600, 15 + 273.15]) annotation (
      Placement(visible = true, transformation(origin = {72, 64}, extent = {{-152, 40}, {-132, 60}}, rotation = 0)));
    Buildings.Controls.OBC.CDL.Reals.Sources.TimeTable TSetRooCoo(extrapolation = Buildings.Controls.OBC.CDL.Types.Extrapolation.Periodic, smoothness = Buildings.Controls.OBC.CDL.Types.Smoothness.ConstantSegments, table = [0, 30 + 273.15; 8*3600, 25 + 273.15; 18*3600, 30 + 273.15; 24*3600, 30 + 273.15]) annotation (
      Placement(visible = true, transformation(origin = {74, 122}, extent = {{-152, 10}, {-132, 30}}, rotation = 0)));
    Buildings.Controls.OBC.CDL.Routing.BooleanScalarReplicator booleanScalarReplicator(nout = 5) annotation (
      Placement(visible = true, transformation(origin={-36,-42},    extent = {{-90, 70}, {-70, 90}}, rotation = 0)));
    Buildings.Controls.OBC.CDL.Routing.RealScalarReplicator reaScaRep(nout = 5)  annotation (
      Placement(visible = true, transformation(origin = {-26, 98}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Buildings.Controls.OBC.CDL.Routing.RealScalarReplicator realScalarReplicator(nout = 5) annotation (
      Placement(visible = true, transformation(origin = {-30, 142}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Controls.OBC.CDL.Reals.Sources.Constant deltaT_constant(k=5)
      annotation (Placement(transformation(extent={{-144,4},{-130,18}})));
    Controls.OBC.CDL.Reals.Sources.Constant ERW_drybulb_temp(k=295)
      annotation (Placement(transformation(extent={{-126,-46},{-112,-32}})));
  equation
    connect(DOAScon.yFanSupSpe, chiBeaTesBed.uFanSpe) annotation (Line(points={{-23.14,
            -7.8},{-15.5,-7.8},{-15.5,-18},{-12,-18}}, color={0,0,127}));
    connect(enaSch.y[1], hys.u) annotation (
      Line(points = {{-128, 80}, {-122, 80}}, color = {0, 0, 127}));
    connect(hys.y, booRep.u) annotation (
      Line(points = {{-98, 80}, {-92, 80}}, color = {255, 0, 255}));
  //connect(booRep.y, terCon.uDetOcc) annotation(
  //Line(points = {{-68, 80}, {-4, 80}, {-4, 58}, {8, 58}}, color = {255, 0, 255}));
    connect(uConSig.y, terCon.uConSen) annotation (
      Line(points={{-66,54},{-66,48},{-4,48},{-4,62.75},{40,62.75}},      color = {255, 0, 255}));
    connect(hys.y,DOAScon.Occ)  annotation (
      Line(points={{-98,80},{-96,80},{-96,-0.4},{-54.6,-0.4}},color = {255, 0, 255}));
    connect(chiBeaTesBed.TZon, terCon.TZon) annotation (
      Line(points={{12,4.8},{20,4.8},{20,60.25},{40,60.25}},  color = {0, 0, 127}, thickness = 0.5));
    connect(booRep.y, terCon.uOccExp) annotation (
      Line(points={{-68,80},{-8,80},{-8,70.25},{40,70.25}},    color = {255, 0, 255}, thickness = 0.5));
    connect(TSetRooHea.y[1], reaScaRep.u) annotation (
      Line(points = {{-58, 114}, {-50, 114}, {-50, 98}, {-38, 98}}, color = {0, 0, 127}));
    connect(TSetRooCoo.y[1], realScalarReplicator.u) annotation (
      Line(points = {{-56, 142}, {-42, 142}}, color = {0, 0, 127}));
    connect(realScalarReplicator.y, terCon.TZonCooSet) annotation (
      Line(points={{-18,142},{8,142},{8,65.25},{40,65.25}},    color = {0, 0, 127}, thickness = 0.5));
    connect(chiBeaTesBed.VDisAir_flow, terCon.VDis_flow) annotation (
      Line(points={{12,2.2},{22,2.2},{22,57.75},{40,57.75}},color = {0, 0, 127}, thickness = 0.5));
    connect(occSch.occupied, booleanScalarReplicator.u) annotation (Line(points={
            {-137,34},{-134,34},{-134,38},{-128,38}}, color={255,0,255}));
    connect(booleanScalarReplicator.y, terCon.uOccDet) annotation (Line(points={{
            -104,38},{-102,38},{-102,12},{6,12},{6,72.75},{40,72.75}}, color={255,
            0,255}));
    connect(sysCon.yBypValPos, chiBeaTesBed.uBypValPos) annotation (Line(points={
            {144,-86},{148,-86},{148,16},{-20,16},{-20,2},{-12,2}}, color={0,0,
            127}));
    connect(chiBeaTesBed.uPumSpe, sysCon.yPumSpe) annotation (Line(points={{-12,
            -34},{-16,-34},{-16,-60},{156,-60},{156,-80},{144,-80}}, color={0,0,
            127}));
    connect(chiBeaTesBed.yChiWatVal, sysCon.uValPos) annotation (Line(points={{12,
            -4},{106,-4},{106,-86},{120,-86}}, color={0,0,127}));
    connect(chiBeaTesBed.dPChiWat, sysCon.dPChiWatLoo) annotation (Line(points={{
            12,-20},{58,-20},{58,-24},{102,-24},{102,-80},{120,-80}}, color={0,0,
            127}));
    connect(chiBeaTesBed.yPumSta, sysCon.uPumSta[1]) annotation (Line(points={{12,
            -23.2},{50,-23.2},{50,-30},{98,-30},{98,-74},{120,-74}}, color={255,0,
            255}));
    connect(yDamPosMax.y, DOAScon.uDamMaxOpe) annotation (Line(points={{-36,30},{
            -30,30},{-30,16},{-72,16},{-72,-2.8},{-54.6,-2.8}}, color={0,0,127}));
    connect(TZonMax.y, DOAScon.TAirHig) annotation (Line(points={{-18,62},{-16,62},
            {-16,34},{-26,34},{-26,18},{-80,18},{-80,-12.6},{-54.6,-12.6}}, color=
           {0,0,127}));
    connect(chiWatSupTem.y, chiBeaTesBed.TChiWatSup) annotation (Line(points={{
            -126,-16},{-86,-16},{-86,-37.1},{-12.1,-37.1}}, color={0,0,127}));
    connect(chiBeaTesBed.TDOASDis, DOAScon.TAirDisCoiCoo) annotation (Line(points=
           {{12,-26},{22,-26},{22,-50},{-24,-50},{-24,-34},{-74,-34},{-74,-22.6},
            {-54.6,-22.6}}, color={0,0,127}));
    connect(chiBeaTesBed.dPDOASAir, DOAScon.dPAirDucSta) annotation (Line(points=
            {{12,-10.8},{30,-10.8},{30,-10},{50,-10},{50,24},{-28,24},{-28,6},{-62,
            6},{-62,-7.6},{-54.6,-7.6}}, color={0,0,127}));
    connect(chiBeaTesBed.erwsuphum, DOAScon.phiAirEneRecWhe) annotation (Line(
          points={{12,-28.6},{16,-28.6},{16,-66},{-70,-66},{-70,-25.2},{-54.6,-25.2}},
          color={0,0,127}));
    connect(DOAScon.TAirSup, DOAScon.TAirDisCoiCoo) annotation (Line(points={{-54.6,
            -15.2},{-72,-15.2},{-72,-22.6},{-54.6,-22.6}}, color={0,0,127}));
    connect(chiBeaTesBed.rAT, DOAScon.TAirRet) annotation (Line(points={{12,-34.4},
            {36,-34.4},{36,-34},{46,-34},{46,-94},{-106,-94},{-106,-17.6},{-54.6,
            -17.6}},                   color={0,0,127}));
    connect(DOAScon.TAirOut, chiBeaTesBed.OutdoorAirTemp) annotation (Line(points=
           {{-54.6,-20.2},{-92,-20.2},{-92,-56},{-52,-56},{-52,-72},{-12,-72},{-12,
            -48},{18,-48},{18,-37.6},{12,-37.6}}, color={0,0,127}));
    connect(chiBeaTesBed.bldgSP, DOAScon.dPAirStaBui) annotation (Line(points={{
            12,-40},{12,-46},{-14,-46},{-14,-40},{-58,-40},{-58,-32.4},{-54.6,-32.4}},
          color={0,0,127}));
    connect(DOAScon.uFanSupPro, chiBeaTesBed.yFanSta) annotation (Line(points={{-54.6,
            -5.2},{-58,-5.2},{-58,8},{-16,8},{-16,20},{18,20},{18,-16.8},{12,-16.8}},
          color={255,0,255}));
    connect(chiBeaTesBed.exhFanSta, DOAScon.uFanExhPro) annotation (Line(points={
            {12,-14},{20,-14},{20,-16},{28,-16},{28,-54},{-22,-54},{-22,-44},{-62,
            -44},{-62,-30},{-54.6,-30}}, color={255,0,255}));
    connect(TZonMax.u[1:5], chiBeaTesBed.TZon) annotation (Line(points={{-42,60.4},
            {-44,60.4},{-44,46},{16,46},{16,4.8},{12,4.8}}, color={0,0,127}));
    connect(yDamPosMax.u[1:5], chiBeaTesBed.yDamPos) annotation (Line(points={{
            -60,28.4},{-60,50},{-50,50},{-50,48},{26,48},{26,-7.8},{12,-7.8}},
          color={0,0,127}));
    connect(chiBeaTesBed.yChiWatVal, terCon.uChiVal) annotation (Line(points={{12,
            -4},{22,-4},{22,0},{36,0},{36,48},{38,48},{38,55.25},{40,55.25}},
          color={0,0,127}));
    connect(DOAScon.yCoiCoo, chiBeaTesBed.uCooCoi) annotation (Line(points={{-23.14,
            -11},{-18,-11},{-18,-26},{-12,-26}}, color={0,0,127}));
    connect(DOAScon.yCoiHea, chiBeaTesBed.uHeaCoi) annotation (Line(points={{-23.14,
            -14},{-18,-14},{-18,-22},{-12,-22}}, color={0,0,127}));
    connect(chiBeaTesBed.uPumSta, sysCon.yChiWatPum[1]) annotation (Line(points={
            {-12,-30},{-18,-30},{-18,-62},{76,-62},{76,-40},{144,-40},{144,-74}},
          color={255,0,255}));
    connect(chiBeaTesBed.uCAVReh, terCon.yReh) annotation (Line(points={{-12,-10},
            {-22,-10},{-22,42},{92,42},{92,69},{64,69}}, color={0,0,127}));
    connect(terCon.yChiVal, chiBeaTesBed.uChiWatVal) annotation (Line(points={{64,
            66.5},{76,66.5},{76,66},{84,66},{84,32},{-16,32},{-16,-2},{-12,-2}},
          color={0,0,127}));
    connect(terCon.yDam, chiBeaTesBed.uCAVDam) annotation (Line(points={{64,64},{
            72,64},{72,62},{78,62},{78,36},{-20,36},{-20,-6},{-12,-6}}, color={0,
            0,127}));
    connect(loads.y, chiBeaTesBed.QFlo) annotation (Line(points={{-139,-50},{-14,-50},
            {-14,6},{-12,6}},      color={0,0,127}));
    connect(DOAScon.yFanSup, chiBeaTesBed.uFanSta) annotation (Line(points={{-23.14,
            -4.6},{-17.57,-4.6},{-17.57,-14},{-12,-14}}, color={255,0,255}));
    connect(reaScaRep.y, terCon.TZonHeaSet) annotation (Line(points={{-14,98},{0,98},
            {0,68},{20,68},{20,67.75},{40,67.75}}, color={0,0,127}));
    connect(chiBeaTesBed.relHumDOASRet, DOAScon.phiAirRet) annotation (Line(
          points={{12,-31},{30,-31},{30,-52},{-76,-52},{-76,-10},{-54.6,-10}},
          color={0,0,127}));
    connect(deltaT_constant.y, chiBeaTesBed.deltaT) annotation (Line(points={{
            -128.6,11},{-86,11},{-86,24},{-60,24},{-60,14},{-18,14},{-18,-4},{
            -12,-4}}, color={0,0,127}));
    connect(ERW_drybulb_temp.y, DOAScon.TAirSupEneWhe) annotation (Line(points=
            {{-110.6,-39},{-66,-39},{-66,-27.6},{-54.6,-27.6}}, color={0,0,127}));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}})),
      Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-160, -100}, {160, 100}})),
      experiment(StartTime = 16848000, StopTime = 16934400, Interval = 600, Tolerance = 1e-06, __Dymola_Algorithm = "Cvode"));
  end ClosedLoopValidation_test1;

  model ClosedLoopValidation_test2
    extends Modelica.Icons.Example;
    parameter Real schTab[5, 2] = [0, 0; 8, 1; 18, 1; 21, 0; 24, 0] "Table defining schedule for enabling plant";
    Buildings.Chilled_Beam_Test.TestBed_test2 chiBeaTesBed(
      TChiWatRet_nominal=273.15 + 25,
      mChiWatTot_flow_nominal=2.114,
      mAirTot_flow_nominal=1*0.676*1.225,
      mHotWatCoi_nominal=0.078,
      mChiWatCoi_nominal=0.645,
      mCooAir_flow_nominal=1*0.676*1.225,
      mHeaAir_flow_nominal=1*0.676*1.225,
      THeaWatInl_nominal=313.15,
      THeaWatOut_nominal=298.15,
      THeaAirInl_nominal=285.85,
      THeaAirDis_nominal=308.15,
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
      annotation (Placement(visible=true, transformation(
          origin={-98,-24},
          extent={{88,-16},{108,32}},
          rotation=0)));
    Buildings.Controls.OBC.ChilledBeams.Terminal.Controller terCon[5](TdCoo = {0.1, 100, 0.1, 0.1, 0.1}, TiCoo = fill(50, 5), VDes_occ = {0.143, 0.065, 0.143, 0.065, 0.26}, VDes_unoccSch = {0.028, 0.012, 0.028, 0.012, 0.052}, VDes_unoccUnsch = {0.056, 0.024, 0.056, 0.024, 0.104}, controllerTypeCoo = fill(Buildings.Controls.OBC.CDL.Types.SimpleController.PID, 5)) "Terminal controllers" annotation (
      Placement(visible = true, transformation(origin={32,14},   extent = {{10, 40}, {30, 60}}, rotation = 0)));
    Buildings.Controls.OBC.ChilledBeams.System.Controller sysCon(nPum = 1, nVal = 5, minPumSpe = 0.7,
      maxPumSpe=1,                                                                                    TiPumSpe = 50,
      dPChiWatMax=1,                                                                                                 kBypVal = 10e-3, TiBypVal = 900,
      chiWatStaPreMax=1,
      chiWatStaPreMin=1,
      triAmoVal=0,
      resAmoVal=1,
      maxResVal=1,
      samPerVal=1,
      delTimVal=60)                                                                                                                                   annotation (
      Placement(visible = true, transformation(origin={112,-20},   extent = {{10, -70}, {30, -50}}, rotation = 0)));
    Buildings.Controls.OBC.FDE.DOAS.DOAScontroller DOAScon   annotation (
      Placement(visible = true, transformation(origin={-39,-10},  extent = {{-13, -24}, {13, 10}}, rotation = 0)));
    Buildings.Controls.OBC.CDL.Reals.MultiMax TZonMax(nin=5)   annotation (
      Placement(transformation(extent={{-40,52},{-20,72}})));
    Buildings.Controls.OBC.CDL.Reals.MultiMax yDamPosMax(nin=5)   annotation (
      Placement(transformation(extent={{-58,20},{-38,40}})));
    Buildings.Controls.OBC.CDL.Reals.Sources.TimeTable enaSch(final table = schTab, final smoothness = Buildings.Controls.OBC.CDL.Types.Smoothness.ConstantSegments, final timeScale = 3600) "Table defining when occupancy is expected" annotation (
      Placement(transformation(extent = {{-150, 70}, {-130, 90}})));
    Buildings.Controls.OBC.CDL.Reals.Hysteresis hys(uLow = 0.45, uHigh = 0.5) annotation (
      Placement(transformation(extent = {{-120, 70}, {-100, 90}})));
    Buildings.Controls.OBC.CDL.Routing.BooleanScalarReplicator booRep(nout = 5) annotation (
      Placement(transformation(extent = {{-90, 70}, {-70, 90}})));
    Buildings.Controls.OBC.CDL.Logical.Sources.Constant uConSig[5](k = fill(false, 5)) "Constant Boolean source" annotation (
      Placement(visible = true, transformation(origin={2,14},    extent = {{-90, 30}, {-70, 50}}, rotation = 0)));
    Buildings.Controls.OBC.CDL.Reals.Sources.Constant chiWatSupTem(k = 273.15 + 7.22) "Chilled water supply temperature" annotation (
      Placement(transformation(extent={{-148,-26},{-128,-6}})));
    Modelica.Blocks.Sources.CombiTimeTable loads(
      tableOnFile = true,
      tableName = "tab1",
      fileName=ModelicaServices.ExternalReferences.loadResource(
          "./Buildings/Resources/Data/Examples/ChilledBeamSystem/zoneLoads.txt"),
      columns = {2, 3, 4, 5, 6},
      timeScale = 60)
      "Table defining thermal loads for zone"
      annotation (Placement(transformation(extent={{-160,-60},{-140,-40}})));
    Buildings.Controls.SetPoints.OccupancySchedule occSch(occupancy = 3600*{8, 18}) annotation (
      Placement(visible = true, transformation(origin={-6,74},   extent = {{-152, -44}, {-132, -24}}, rotation = 0)));
    Buildings.Controls.OBC.CDL.Reals.Sources.TimeTable TSetRooHea(extrapolation = Buildings.Controls.OBC.CDL.Types.Extrapolation.Periodic, smoothness = Buildings.Controls.OBC.CDL.Types.Smoothness.ConstantSegments, table = [0, 15 + 273.15; 8*3600, 20 + 273.15; 18*3600, 15 + 273.15; 24*3600, 15 + 273.15]) annotation (
      Placement(visible = true, transformation(origin = {72, 64}, extent = {{-152, 40}, {-132, 60}}, rotation = 0)));
    Buildings.Controls.OBC.CDL.Reals.Sources.TimeTable TSetRooCoo(extrapolation = Buildings.Controls.OBC.CDL.Types.Extrapolation.Periodic, smoothness = Buildings.Controls.OBC.CDL.Types.Smoothness.ConstantSegments, table = [0, 30 + 273.15; 8*3600, 25 + 273.15; 18*3600, 30 + 273.15; 24*3600, 30 + 273.15]) annotation (
      Placement(visible = true, transformation(origin = {74, 122}, extent = {{-152, 10}, {-132, 30}}, rotation = 0)));
    Buildings.Controls.OBC.CDL.Routing.BooleanScalarReplicator booleanScalarReplicator(nout = 5) annotation (
      Placement(visible = true, transformation(origin={-36,-42},    extent = {{-90, 70}, {-70, 90}}, rotation = 0)));
    Buildings.Controls.OBC.CDL.Routing.RealScalarReplicator reaScaRep(nout = 5)  annotation (
      Placement(visible = true, transformation(origin = {-26, 98}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Buildings.Controls.OBC.CDL.Routing.RealScalarReplicator realScalarReplicator(nout = 5) annotation (
      Placement(visible = true, transformation(origin = {-30, 142}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Controls.OBC.CDL.Reals.Sources.Constant deltaT_constant(k=5)
      annotation (Placement(transformation(extent={{-138,4},{-124,18}})));
    Controls.OBC.CDL.Reals.Sources.Constant ERW_Drybulb_temp(k=295)
      annotation (Placement(transformation(extent={{-126,-44},{-112,-30}})));
  equation
    connect(DOAScon.yFanSupSpe, chiBeaTesBed.uFanSpe) annotation (Line(points={{-23.14,
            -7.8},{-15.5,-7.8},{-15.5,-18},{-12,-18}}, color={0,0,127}));
    connect(enaSch.y[1], hys.u) annotation (
      Line(points = {{-128, 80}, {-122, 80}}, color = {0, 0, 127}));
    connect(hys.y, booRep.u) annotation (
      Line(points = {{-98, 80}, {-92, 80}}, color = {255, 0, 255}));
  //connect(booRep.y, terCon.uDetOcc) annotation(
  //Line(points = {{-68, 80}, {-4, 80}, {-4, 58}, {8, 58}}, color = {255, 0, 255}));
    connect(uConSig.y, terCon.uConSen) annotation (
      Line(points={{-66,54},{-66,48},{-4,48},{-4,62.75},{40,62.75}},      color = {255, 0, 255}));
    connect(hys.y,DOAScon.Occ)  annotation (
      Line(points={{-98,80},{-96,80},{-96,-0.4},{-54.6,-0.4}},color = {255, 0, 255}));
    connect(chiBeaTesBed.TZon, terCon.TZon) annotation (
      Line(points={{12,4.8},{20,4.8},{20,60.25},{40,60.25}},  color = {0, 0, 127}, thickness = 0.5));
    connect(booRep.y, terCon.uOccExp) annotation (
      Line(points={{-68,80},{-8,80},{-8,70.25},{40,70.25}},    color = {255, 0, 255}, thickness = 0.5));
    connect(TSetRooHea.y[1], reaScaRep.u) annotation (
      Line(points = {{-58, 114}, {-50, 114}, {-50, 98}, {-38, 98}}, color = {0, 0, 127}));
    connect(TSetRooCoo.y[1], realScalarReplicator.u) annotation (
      Line(points = {{-56, 142}, {-42, 142}}, color = {0, 0, 127}));
    connect(realScalarReplicator.y, terCon.TZonCooSet) annotation (
      Line(points={{-18,142},{8,142},{8,65.25},{40,65.25}},    color = {0, 0, 127}, thickness = 0.5));
    connect(chiBeaTesBed.VDisAir_flow, terCon.VDis_flow) annotation (
      Line(points={{12,2.2},{22,2.2},{22,57.75},{40,57.75}},color = {0, 0, 127}, thickness = 0.5));
    connect(occSch.occupied, booleanScalarReplicator.u) annotation (Line(points={
            {-137,34},{-134,34},{-134,38},{-128,38}}, color={255,0,255}));
    connect(booleanScalarReplicator.y, terCon.uOccDet) annotation (Line(points={{
            -104,38},{-102,38},{-102,12},{6,12},{6,72.75},{40,72.75}}, color={255,
            0,255}));
    connect(sysCon.yBypValPos, chiBeaTesBed.uBypValPos) annotation (Line(points={
            {144,-86},{148,-86},{148,16},{-20,16},{-20,2},{-12,2}}, color={0,0,
            127}));
    connect(chiBeaTesBed.uPumSpe, sysCon.yPumSpe) annotation (Line(points={{-12,
            -34},{-16,-34},{-16,-60},{156,-60},{156,-80},{144,-80}}, color={0,0,
            127}));
    connect(chiBeaTesBed.yChiWatVal, sysCon.uValPos) annotation (Line(points={{12,
            -4},{106,-4},{106,-86},{120,-86}}, color={0,0,127}));
    connect(chiBeaTesBed.dPChiWat, sysCon.dPChiWatLoo) annotation (Line(points={{
            12,-20},{58,-20},{58,-24},{102,-24},{102,-80},{120,-80}}, color={0,0,
            127}));
    connect(chiBeaTesBed.yPumSta, sysCon.uPumSta[1]) annotation (Line(points={{12,
            -23.2},{50,-23.2},{50,-30},{98,-30},{98,-74},{120,-74}}, color={255,0,
            255}));
    connect(yDamPosMax.y, DOAScon.uDamMaxOpe) annotation (Line(points={{-36,30},{
            -30,30},{-30,16},{-72,16},{-72,-2.8},{-54.6,-2.8}}, color={0,0,127}));
    connect(TZonMax.y, DOAScon.TAirHig) annotation (Line(points={{-18,62},{-16,62},
            {-16,34},{-26,34},{-26,18},{-80,18},{-80,-12.6},{-54.6,-12.6}}, color=
           {0,0,127}));
    connect(chiWatSupTem.y, chiBeaTesBed.TChiWatSup) annotation (Line(points={{
            -126,-16},{-86,-16},{-86,-37.1},{-12.1,-37.1}}, color={0,0,127}));
    connect(chiBeaTesBed.TDOASDis, DOAScon.TAirDisCoiCoo) annotation (Line(points=
           {{12,-26},{22,-26},{22,-50},{-24,-50},{-24,-34},{-74,-34},{-74,-22.6},
            {-54.6,-22.6}}, color={0,0,127}));
    connect(chiBeaTesBed.dPDOASAir, DOAScon.dPAirDucSta) annotation (Line(points=
            {{12,-10.8},{30,-10.8},{30,-10},{50,-10},{50,24},{-28,24},{-28,6},{-62,
            6},{-62,-7.6},{-54.6,-7.6}}, color={0,0,127}));
    connect(chiBeaTesBed.erwsuphum, DOAScon.phiAirEneRecWhe) annotation (Line(
          points={{12,-28.6},{16,-28.6},{16,-66},{-70,-66},{-70,-25.2},{-54.6,-25.2}},
          color={0,0,127}));
    connect(DOAScon.TAirSup, DOAScon.TAirDisCoiCoo) annotation (Line(points={{-54.6,
            -15.2},{-72,-15.2},{-72,-22.6},{-54.6,-22.6}}, color={0,0,127}));
    connect(chiBeaTesBed.rAT, DOAScon.TAirRet) annotation (Line(points={{12,-34.4},
            {36,-34.4},{36,-34},{46,-34},{46,-94},{-106,-94},{-106,-17.6},{-54.6,
            -17.6}},                   color={0,0,127}));
    connect(DOAScon.TAirOut, chiBeaTesBed.OutdoorAirTemp) annotation (Line(points=
           {{-54.6,-20.2},{-92,-20.2},{-92,-56},{-52,-56},{-52,-72},{-12,-72},{-12,
            -48},{18,-48},{18,-37.6},{12,-37.6}}, color={0,0,127}));
    connect(chiBeaTesBed.bldgSP, DOAScon.dPAirStaBui) annotation (Line(points={{
            12,-40},{12,-46},{-14,-46},{-14,-40},{-58,-40},{-58,-32.4},{-54.6,-32.4}},
          color={0,0,127}));
    connect(DOAScon.uFanSupPro, chiBeaTesBed.yFanSta) annotation (Line(points={{-54.6,
            -5.2},{-58,-5.2},{-58,8},{-16,8},{-16,20},{18,20},{18,-16.8},{12,-16.8}},
          color={255,0,255}));
    connect(chiBeaTesBed.exhFanSta, DOAScon.uFanExhPro) annotation (Line(points={
            {12,-14},{20,-14},{20,-16},{28,-16},{28,-54},{-22,-54},{-22,-44},{-62,
            -44},{-62,-30},{-54.6,-30}}, color={255,0,255}));
    connect(TZonMax.u[1:5], chiBeaTesBed.TZon) annotation (Line(points={{-42,60.4},
            {-44,60.4},{-44,46},{16,46},{16,4.8},{12,4.8}}, color={0,0,127}));
    connect(yDamPosMax.u[1:5], chiBeaTesBed.yDamPos) annotation (Line(points={{
            -60,28.4},{-60,50},{-50,50},{-50,48},{26,48},{26,-7.8},{12,-7.8}},
          color={0,0,127}));
    connect(chiBeaTesBed.yChiWatVal, terCon.uChiVal) annotation (Line(points={{12,
            -4},{22,-4},{22,0},{36,0},{36,48},{38,48},{38,55.25},{40,55.25}},
          color={0,0,127}));
    connect(DOAScon.yCoiCoo, chiBeaTesBed.uCooCoi) annotation (Line(points={{-23.14,
            -11},{-18,-11},{-18,-26},{-12,-26}}, color={0,0,127}));
    connect(DOAScon.yCoiHea, chiBeaTesBed.uHeaCoi) annotation (Line(points={{-23.14,
            -14},{-18,-14},{-18,-22},{-12,-22}}, color={0,0,127}));
    connect(chiBeaTesBed.uPumSta, sysCon.yChiWatPum[1]) annotation (Line(points={
            {-12,-30},{-18,-30},{-18,-62},{76,-62},{76,-40},{144,-40},{144,-74}},
          color={255,0,255}));
    connect(chiBeaTesBed.uCAVReh, terCon.yReh) annotation (Line(points={{-12,-10},
            {-22,-10},{-22,42},{92,42},{92,69},{64,69}}, color={0,0,127}));
    connect(terCon.yChiVal, chiBeaTesBed.uChiWatVal) annotation (Line(points={{64,
            66.5},{76,66.5},{76,66},{84,66},{84,32},{-16,32},{-16,-2},{-12,-2}},
          color={0,0,127}));
    connect(terCon.yDam, chiBeaTesBed.uCAVDam) annotation (Line(points={{64,64},{
            72,64},{72,62},{78,62},{78,36},{-20,36},{-20,-6},{-12,-6}}, color={0,
            0,127}));
    connect(loads.y, chiBeaTesBed.QFlo) annotation (Line(points={{-139,-50},{-14,-50},
            {-14,6},{-12,6}},      color={0,0,127}));
    connect(DOAScon.yFanSup, chiBeaTesBed.uFanSta) annotation (Line(points={{-23.14,
            -4.6},{-17.57,-4.6},{-17.57,-14},{-12,-14}}, color={255,0,255}));
    connect(reaScaRep.y, terCon.TZonHeaSet) annotation (Line(points={{-14,98},{0,98},
            {0,68},{20,68},{20,67.75},{40,67.75}}, color={0,0,127}));
    connect(chiBeaTesBed.relHumDOASRet, DOAScon.phiAirRet) annotation (Line(
          points={{12,-31},{30,-31},{30,-52},{-76,-52},{-76,-10},{-54.6,-10}},
          color={0,0,127}));
    connect(deltaT_constant.y, chiBeaTesBed.deltaT) annotation (Line(points={{
            -122.6,11},{-16,11},{-16,-4},{-12,-4}}, color={0,0,127}));
    connect(ERW_Drybulb_temp.y, DOAScon.TAirSupEneWhe) annotation (Line(points=
            {{-110.6,-37},{-80,-37},{-80,-27.6},{-54.6,-27.6}}, color={0,0,127}));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}})),
      Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-160, -100}, {160, 100}})),
      experiment(StartTime = 16848000, StopTime = 16934400, Interval = 600, Tolerance = 1e-06, __Dymola_Algorithm = "Cvode"));
  end ClosedLoopValidation_test2;

  block TestBed_test2
    "Testbed consisting of a 5-zone building model paired with DOAS and chilled water supply system"
    replaceable package MediumA = Buildings.Media.Air "Medium model";
    replaceable package MediumW = Buildings.Media.Water "Medium model";
    parameter Real hRoo = 2.74 "Height of room";
    parameter Modelica.Units.SI.PressureDifference dpValve_nominal = 6000 "Nominal pressure drop of fully open valve, used if CvData=Buildings.Fluid.Types.CvTypes.OpPoint";
    parameter Modelica.Units.SI.PressureDifference dpFixed_nominal = 0 "Pressure drop of pipe and other resistances that are in series";
    parameter Real TChiWatSup_nominal = 273.15 + 15.56 "Nominal chilled water supply temperature into zone";
    parameter Real TChiWatRet_nominal = 273.15 + 19 "Nominal chilled water return temperature from zone";
    parameter Real mChiWatTot_flow_nominal = mChiWatSou_flow_nominal + mChiWatEas_flow_nominal + mChiWatNor_flow_nominal + mChiWatWes_flow_nominal + mChiWatCor_flow_nominal "Total nominal chilled water flow rate through all five zones";
    parameter Real mAirTot_flow_nominal = mAirSou_flow_nominal + mAirEas_flow_nominal + mAirNor_flow_nominal + mAirWes_flow_nominal + mAirCor_flow_nominal "Total nominal air flow rate through all five zones";
    parameter Real mHotWatCoi_nominal = 96 "Hot water mass flow rate through AHU heating coil";
    parameter Real mChiWatCoi_nominal = 96 "Chilled water mass flow rate through AHU cooling coil";
    parameter Real mHotWatReh_nominal = mAirTot_flow_nominal*1000*15/4200/10 "Hot water mass flow rate through CAV terminal reheat coils";

    // Cerrina Added Parameters
     parameter Modelica.Units.SI.MassFlowRate mCooAir_flow_nominal "Nominal air mass flow rate from cooling sizing calculations";
    parameter Modelica.Units.SI.MassFlowRate mHeaAir_flow_nominal "Nominal air mass flow rate from heating sizing calculations";
    final parameter Modelica.Units.SI.MassFlowRate mHeaWat_flow_nominal= QHea_flow_nominal/(cpWatLiq*(THeaWatInl_nominal - THeaWatOut_nominal)) "Nominal mass flow rate of hot water to reheat coil";
    parameter Modelica.Units.SI.Temperature THeaWatInl_nominal(start=55 + 273.15,
        displayUnit="degC") "Reheat coil nominal inlet water temperature";
    parameter Modelica.Units.SI.Temperature THeaWatOut_nominal(start=
          THeaWatInl_nominal - 10, displayUnit="degC")
      "Reheat coil nominal outlet water temperature";
    parameter Modelica.Units.SI.Temperature THeaAirInl_nominal(start=12 + 273.15,
        displayUnit="degC")
      "Inlet air nominal temperature into VAV box during heating";
    parameter Modelica.Units.SI.Temperature THeaAirDis_nominal(start=28 + 273.15,
        displayUnit="degC")
      "Discharge air temperature from VAV box during heating";
    parameter Modelica.Units.SI.HeatFlowRate QHea_flow_nominal=
        mHeaAir_flow_nominal * cpAir * (THeaAirDis_nominal-THeaAirInl_nominal)
      "Nominal heating heat flow rate";
    constant Modelica.Units.SI.SpecificHeatCapacity cpAir=Buildings.Utilities.Psychrometrics.Constants.cpAir
      "Air specific heat capacity";
    constant Modelica.Units.SI.SpecificHeatCapacity cpWatLiq=Buildings.Utilities.Psychrometrics.Constants.cpWatLiq
      "Water specific heat capacity";

    // South zone
    parameter Real QSou_flow_nominal = -100000 "Nominal heat flow into south zone" annotation (
      Dialog(group = "South zone"));
    parameter Real VRooSou = 500 "Volume of zone air in south zone" annotation (
      Dialog(group = "South zone"));
    parameter Real mChiWatSou_flow_nominal = 0.2 "Chilled water volume flow rate into zone" annotation (
      Dialog(group = "South zone"));
    parameter Real mAirSou_flow_nominal = 0.2 "Discharge air volume flow rate into zone" annotation (
      Dialog(group = "South zone"));
    parameter Real mAChiBeaSou_flow_nominal = 0.2 "Discharge air volume flow rate into zone" annotation (
      Dialog(group = "South zone"));
    // East zone
    parameter Real QEas_flow_nominal = -100000 "Nominal heat flow into east zone" annotation (
      Dialog(group = "East zone"));
    parameter Real VRooEas = 500 "Volume of zone air in east zone" annotation (
      Dialog(group = "East zone"));
    parameter Real mChiWatEas_flow_nominal = 0.2 "Chilled water volume flow rate into zone" annotation (
      Dialog(group = "East zone"));
    parameter Real mAirEas_flow_nominal = 0.2 "Discharge air volume flow rate into zone" annotation (
      Dialog(group = "East zone"));
    parameter Real mAChiBeaEas_flow_nominal = 0.2 "Discharge air volume flow rate into zone" annotation (
      Dialog(group = "East zone"));
    // North zone
    parameter Real QNor_flow_nominal = -100000 "Nominal heat flow into north zone" annotation (
      Dialog(group = "North zone"));
    parameter Real VRooNor = 500 "Volume of zone air in north zone" annotation (
      Dialog(group = "North zone"));
    parameter Real mChiWatNor_flow_nominal = 0.2 "Chilled water volume flow rate into zone" annotation (
      Dialog(group = "North zone"));
    parameter Real mAirNor_flow_nominal = 0.2 "Discharge air volume flow rate into zone" annotation (
      Dialog(group = "North zone"));
    parameter Real mAChiBeaNor_flow_nominal = 0.2 "Discharge air volume flow rate into zone" annotation (
      Dialog(group = "North zone"));
    // West zone
    parameter Real QWes_flow_nominal = -100000 "Nominal heat flow into west zone" annotation (
      Dialog(group = "West zone"));
    parameter Real VRooWes = 500 "Volume of zone air in west zone" annotation (
      Dialog(group = "West zone"));
    parameter Real mChiWatWes_flow_nominal = 0.2 "Chilled water volume flow rate into zone" annotation (
      Dialog(group = "West zone"));
    parameter Real mAirWes_flow_nominal = 0.2 "Discharge air volume flow rate into zone" annotation (
      Dialog(group = "West zone"));
    parameter Real mAChiBeaWes_flow_nominal = 0.2 "Discharge air volume flow rate into zone" annotation (
      Dialog(group = "West zone"));
    // Core zone
    parameter Real QCor_flow_nominal = -100000 "Nominal heat flow into core zone" annotation (
      Dialog(group = "Core zone"));
    parameter Real VRooCor = 500 "Volume of zone air in core zone" annotation (
      Dialog(group = "Core zone"));
    parameter Real mChiWatCor_flow_nominal = 0.2 "Chilled water volume flow rate into zone" annotation (
      Dialog(group = "Core zone"));
    parameter Real mAirCor_flow_nominal = 0.2 "Discharge air volume flow rate into zone" annotation (
      Dialog(group = "Core zone"));
    parameter Real mAChiBeaCor_flow_nominal = 0.2 "Discharge air volume flow rate into zone" annotation (
      Dialog(group = "Core zone"));
    parameter HeatTransfer.Data.OpaqueConstructions.Generic conExtWal(final nLay = 3, final material = {matWoo, matIns, matGyp}) "Exterior construction" annotation (
      Placement(transformation(extent = {{380, 312}, {400, 332}})));
    parameter HeatTransfer.Data.OpaqueConstructions.Generic conIntWal(final nLay = 1, final material = {matGyp2}) "Interior wall construction" annotation (
      Placement(transformation(extent = {{420, 312}, {440, 332}})));
    parameter HeatTransfer.Data.Solids.Plywood matWoo(final x = 0.01, final k = 0.11, final d = 544, final nStaRef = 1) "Wood for exterior construction" annotation (
      Placement(transformation(extent = {{452, 308}, {472, 328}})));
    parameter HeatTransfer.Data.Solids.Generic matIns(final x = 0.087, final k = 0.049, final c = 836.8, final d = 265, final nStaRef = 5) "Steelframe construction with insulation" annotation (
      Placement(transformation(extent = {{492, 308}, {512, 328}})));
    parameter HeatTransfer.Data.Solids.GypsumBoard matGyp(final x = 0.0127, final k = 0.16, final c = 830, final d = 784, final nStaRef = 2) "Gypsum board" annotation (
      Placement(transformation(extent = {{450, 280}, {470, 300}})));
    parameter HeatTransfer.Data.Solids.GypsumBoard matGyp2(final x = 0.025, final k = 0.16, final c = 830, final d = 784, final nStaRef = 2) "Gypsum board" annotation (
      Placement(transformation(extent = {{490, 280}, {510, 300}})));
    Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uPumSta "Pump enable signal" annotation (
      Placement(transformation(extent = {{-380, -130}, {-340, -90}}), iconTransformation(extent = {{-140, -160}, {-100, -120}})));
    Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uFanSta "Supply fan enable signal" annotation (
      Placement(transformation(extent = {{-380, 20}, {-340, 60}}), iconTransformation(extent = {{-140, 0}, {-100, 40}})));
    Buildings.Controls.OBC.CDL.Interfaces.RealInput uFanSpe "Fan speed signal" annotation (
      Placement(transformation(extent = {{-380, -10}, {-340, 30}}), iconTransformation(extent = {{-140, -40}, {-100, 0}})));
    Buildings.Controls.OBC.CDL.Interfaces.RealInput uPumSpe "Pump speed signal" annotation (
      Placement(transformation(extent = {{-380, -160}, {-340, -120}}), iconTransformation(extent = {{-140, -200}, {-100, -160}})));
    Buildings.Controls.OBC.CDL.Interfaces.RealInput TChiWatSup "Chilled water supply temperature" annotation (
      Placement(visible = true, transformation(origin = {0, 0}, extent = {{-380, -200}, {-340, -160}}, rotation = 0), iconTransformation(origin = {-121, -211}, extent = {{-21, -21}, {21, 21}}, rotation = 0)));
    Buildings.Controls.OBC.CDL.Interfaces.RealInput uHeaCoi "Heating coil control signal" annotation (
      Placement(transformation(extent = {{-380, -70}, {-340, -30}}), iconTransformation(extent = {{-140, -80}, {-100, -40}})));
    Buildings.Controls.OBC.CDL.Interfaces.RealInput uCooCoi "AHU cooling coil control signal" annotation (
      Placement(transformation(extent = {{-380, -100}, {-340, -60}}), iconTransformation(extent = {{-140, -120}, {-100, -80}})));
    Buildings.Controls.OBC.CDL.Interfaces.RealInput uCAVDam[5] "CAV damper signal" annotation (
      Placement(transformation(extent = {{-380, 120}, {-340, 160}}), iconTransformation(extent = {{-140, 80}, {-100, 120}})));
    Buildings.Controls.OBC.CDL.Interfaces.RealInput uCAVReh[5] "CAV reheat signal" annotation (
      Placement(transformation(extent = {{-380, 80}, {-340, 120}}), iconTransformation(extent = {{-140, 40}, {-100, 80}})));
    Buildings.Controls.OBC.CDL.Interfaces.RealInput uBypValPos "Bypass valve position signal" annotation (
      Placement(transformation(extent = {{-380, 200}, {-340, 240}}), iconTransformation(extent = {{-140, 160}, {-100, 200}})));
    Buildings.Controls.OBC.CDL.Interfaces.RealInput uChiWatVal[5] "Chilled water valve position signal" annotation (
      Placement(transformation(extent = {{-380, 160}, {-340, 200}}), iconTransformation(extent = {{-140, 120}, {-100, 160}})));
    Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yPumSta "Pump proven on" annotation (
      Placement(visible = true, transformation(origin = {2, 30}, extent = {{580, -140}, {620, -100}}, rotation = 0), iconTransformation(origin={0,68},    extent = {{100, -160}, {140, -120}}, rotation = 0)));
    Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yFanSta "Supply fan proven on" annotation (
      Placement(visible = true, transformation(origin = {-2, 32}, extent = {{580, -70}, {620, -30}}, rotation = 0), iconTransformation(origin={0,52},   extent = {{100, -80}, {140, -40}}, rotation = 0)));
    Buildings.Controls.OBC.CDL.Interfaces.RealOutput dPChiWat "Measured chilled water differential presure" annotation (
      Placement(visible = true, transformation(origin = {-2, 20}, extent = {{580, -110}, {620, -70}}, rotation = 0), iconTransformation(origin={0,60},    extent = {{100, -120}, {140, -80}}, rotation = 0)));
    Buildings.Controls.OBC.CDL.Interfaces.RealOutput dPDOASAir "Measured airloop differential presure" annotation (
      Placement(visible = true, transformation(origin = {0, 36}, extent = {{580, -40}, {620, 0}}, rotation = 0), iconTransformation(origin={0,72},   extent = {{100, -40}, {140, 0}}, rotation = 0)));
    Buildings.Controls.OBC.CDL.Interfaces.RealOutput TDOASDis(final unit = "K", displayUnit = "K", final quantity = "ThermodynamicTemperature") "Measured DOAS discharge air temperature" annotation (
      Placement(visible = true, transformation(origin = {0, 28}, extent = {{580, -170}, {620, -130}}, rotation = 0), iconTransformation(origin={0,80},    extent = {{100, -200}, {140, -160}}, rotation = 0)));
    Buildings.Controls.OBC.CDL.Interfaces.RealOutput yChiWatVal[5] "Measured chilled water valve position" annotation (
      Placement(transformation(extent = {{580, 60}, {620, 100}}), iconTransformation(extent={{100,100},
              {140,140}})));
    Buildings.Controls.OBC.CDL.Interfaces.RealOutput yBypValPos "Measured bypass valve position" annotation (
      Placement(transformation(extent = {{580, 100}, {620, 140}}), iconTransformation(extent={{100,130},
              {140,170}})));
    Buildings.Controls.OBC.CDL.Interfaces.RealOutput yDamPos[5] "Measured CAV damper position" annotation (
      Placement(visible = true, transformation(origin = {2, 46}, extent = {{580, -10}, {620, 30}}, rotation = 0), iconTransformation(origin={0,62},   extent = {{100, 0}, {140, 40}}, rotation = 0)));
    Buildings.Controls.OBC.CDL.Interfaces.RealOutput relHumDOASRet "Measured DOAS return air relative humidity" annotation (
      Placement(visible = true, transformation(origin = {2, 28}, extent = {{580, -200}, {620, -160}}, rotation = 0), iconTransformation(origin={0,70},    extent = {{100, -240}, {140, -200}}, rotation = 0)));
    Buildings.Controls.OBC.CDL.Interfaces.RealOutput TZon[5] "Measured zone temperature" annotation (
      Placement(transformation(extent = {{580, 240}, {620, 280}}), iconTransformation(extent={{100,188},
              {140,228}})));
    Buildings.Controls.OBC.CDL.Interfaces.RealOutput yRelHumZon[5] "Measured zone relative humidity" annotation (
      Placement(transformation(extent = {{580, 280}, {620, 320}}), iconTransformation(extent={{100,212},
              {140,252}})));
    Buildings.Controls.OBC.CDL.Interfaces.RealOutput VDisAir_flow[5] "Measured zone discharge air volume flow rate" annotation (
      Placement(transformation(extent = {{580, 200}, {620, 240}}), iconTransformation(extent={{100,162},
              {140,202}})));
    Buildings.Fluid.FixedResistances.Junction jun(redeclare package Medium = MediumW, final m_flow_nominal = {mChiWatTot_flow_nominal, -mChiWatTot_flow_nominal, -mChiWatTot_flow_nominal}, final dp_nominal = {0, 0, 0}) "Chilled water splitter" annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {100, -40})));
    Buildings.Fluid.FixedResistances.Junction jun3(redeclare package Medium = MediumW, final m_flow_nominal = {mChiWatTot_flow_nominal, -mChiWatTot_flow_nominal, mChiWatTot_flow_nominal}, final dp_nominal = {0, 0, 0}) "Chilled water mixer" annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin = {250, -40})));
    Buildings.Fluid.Actuators.Valves.TwoWayLinear val(redeclare package Medium
        =                                                                        MediumW, final m_flow_nominal = mChiWatSou_flow_nominal, final dpValve_nominal = dpValve_nominal, final dpFixed_nominal = dpFixed_nominal) "Chilled beam control valve for south zone" annotation (
      Placement(transformation(extent = {{120, -50}, {140, -30}})));
    Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(final filNam=
          ModelicaServices.ExternalReferences.loadResource(
          "./Buildings/Resources/weatherdata/USA_AZ_Phoenix-Sky.Harbor.Intl.AP.722780_TMY3.mos"))                                                                                                             "Weather data" annotation (
      Placement(visible = true, transformation(origin = {-14, -14}, extent = {{-310, -20}, {-290, 0}}, rotation = 0)));
    Buildings.BoundaryConditions.WeatherData.Bus weaBus "Weather Data Bus" annotation (
      Placement(visible = true, transformation(origin = {-16, -6}, extent = {{-280, -20}, {-260, 0}}, rotation = 0), iconTransformation(origin = {0, 0}, extent = {{0, 0}, {0, 0}}, rotation = 0)));
    Buildings.Fluid.Sources.Outside amb(redeclare package Medium = MediumA, final nPorts=5)   "Ambient conditions" annotation (
      Placement(visible = true, transformation(origin={-44,-26},    extent = {{-250, -20}, {-228, 2}}, rotation = 0)));
    Buildings.Fluid.HeatExchangers.WetCoilCounterFlow cooCoi(final show_T = true, final UA_nominal = 3*mAirTot_flow_nominal*1000*15/Buildings.Fluid.HeatExchangers.BaseClasses.lmtd(T_a1 = 26.2, T_b1 = 12.8, T_a2 = 6, T_b2 = 16), redeclare
        package Medium1 =                                                                                                                                                                                                         MediumW, redeclare
        package Medium2 =                                                                                                                                                                                                         MediumA, final m1_flow_nominal = mAirTot_flow_nominal*1000*15/4200/10, final m2_flow_nominal = mAirTot_flow_nominal, final dp2_nominal = 0, final dp1_nominal = 0, final energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, final allowFlowReversal1 = true, final allowFlowReversal2 = true) "Cooling coil" annotation (
      Placement(transformation(extent = {{-110, 4}, {-130, -16}})));
    Buildings.Fluid.Sources.Boundary_pT sinHea(redeclare package Medium = MediumW, p = 100000, T = 318.15, nPorts = 1) "Sink for heating coil" annotation (
      Placement(visible = true, transformation(origin = {-212, -74}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Buildings.Fluid.Sources.Boundary_pT sinCoo(redeclare package Medium = MediumW, final p = 100000, final T = 285.15, final nPorts = 1) "Sink for cooling coil" annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {-140, -70})));
    Buildings.Fluid.Sources.MassFlowSource_T souCoo(redeclare package Medium = MediumW, final T = 280.372, final nPorts = 1, final use_m_flow_in = true) "Source for cooling coil" annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {-100, -70})));
    Buildings.Fluid.Sources.MassFlowSource_T souHea(redeclare package Medium = MediumW, final T = 318.15, final use_m_flow_in = true, final nPorts = 1) "Source for heating coil" annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {-170, -70})));
    Buildings.Fluid.HeatExchangers.DryCoilEffectivenessNTU heaCoi(final show_T = true, redeclare
        package Medium1 =                                                                                          MediumW, redeclare
        package Medium2 =                                                                                                                               MediumA, final m1_flow_nominal = mAirTot_flow_nominal*1000*(10 - (-20))/4200/10, final m2_flow_nominal = mAirTot_flow_nominal, final configuration = Buildings.Fluid.Types.HeatExchangerConfiguration.CounterFlow, final Q_flow_nominal = mAirTot_flow_nominal*1006*(16.7 - 8.5), final dp1_nominal = 0, final dp2_nominal = 200 + 200 + 100 + 40, final allowFlowReversal1 = false, final allowFlowReversal2 = false, final T_a1_nominal = 318.15, final T_a2_nominal = 281.65) "Heating coil" annotation (
      Placement(visible = true, transformation(origin = {26, -10}, extent = {{-180, 4}, {-200, -16}}, rotation = 0)));
    Buildings.Examples.VAVReheat.BaseClasses.VAVReheatBox souCAVTer(redeclare
        package MediumA =                                                                       MediumA, redeclare
        package MediumW =                                                                                                            MediumW,
      mCooAir_flow_nominal=mCooAir_flow_nominal,
      mHeaAir_flow_nominal=mHeaAir_flow_nominal,                                                                                              final VRoo = VRooSou, final allowFlowReversal = false,
      THeaWatInl_nominal=THeaWatInl_nominal,
      THeaWatOut_nominal=THeaWatOut_nominal,
      THeaAirInl_nominal=THeaAirInl_nominal,
      THeaAirDis_nominal=THeaAirDis_nominal)                                                                                                                                                         "CAV terminal for south zone" annotation (
      Placement(transformation(extent = {{390, -130}, {430, -90}})));
    Buildings.Fluid.FixedResistances.Junction jun5(redeclare package Medium = MediumA, final m_flow_nominal = {mAirTot_flow_nominal, -mAirTot_flow_nominal, mAirTot_flow_nominal}, final dp_nominal = {0, 0, 0}) "Return air mixer" annotation (
      Placement(transformation(extent = {{-40, 150}, {-20, 170}})));
    Buildings.Fluid.Sources.Boundary_pT sinCoo1(redeclare package Medium = MediumW, final p = 100000, final T = 297.04, final nPorts = 2) "Sink for chillede water" annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {250, -176})));
    Buildings.Fluid.Sources.Boundary_pT souCoo1(redeclare package Medium = MediumW, final p = 100000, final use_T_in = true, final T = 285.15, final nPorts = 1) "Source for chilled water to chilled beam manifolds" annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {100, -174})));
    Buildings.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium
        =                                                                        MediumA, final m_flow_nominal = mAirTot_flow_nominal) "AHU discharge air temperature sensor" annotation (
      Placement(transformation(extent = {{-40, -10}, {-20, 10}})));
    Buildings.Fluid.Sensors.RelativePressure senRelPre(redeclare package Medium
        =                                                                         MediumW) "Differential pressure sensor between chilled water supply and return" annotation (
      Placement(transformation(extent = {{150, -80}, {170, -60}})));
    Buildings.Fluid.Sensors.RelativePressure senRelPre1(redeclare package
        Medium =                                                                   MediumA) "Differential pressure sensor between AHU discharge and outdoor air" annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin={-50,32})));
    Modelica.Blocks.Routing.DeMultiplex demux(final n = 5) "Demultiplexer for chilled water valve signals" annotation (
      Placement(transformation(extent={{42,-30},{62,-10}})));
    Buildings.Controls.OBC.CDL.Reals.Hysteresis hys(final uLow = 0.04, final uHigh = 0.05) "Block for generating pump proven on signal" annotation (
      Placement(transformation(extent = {{140, -120}, {160, -100}})));
    Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea "Convert pump enable signal to Real signal" annotation (
      Placement(transformation(extent = {{-320, -120}, {-300, -100}})));
    Buildings.Controls.OBC.CDL.Reals.Multiply pro "Find pump flow signal by multiplying enable signal with speed signal" annotation (
      Placement(transformation(extent = {{-280, -140}, {-260, -120}})));
    Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gai(final k = mHotWatCoi_nominal) "Multiply control signal by nominal flowrate" annotation (
      Placement(transformation(extent = {{-320, -60}, {-300, -40}})));
    Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gai1(final k = mChiWatCoi_nominal) "Multiply control signal by nominal flowrate" annotation (
      Placement(transformation(extent = {{-320, -90}, {-300, -70}})));
    Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea1 "Convert fan enable signal to Real signal" annotation (
      Placement(visible = true, transformation(origin = {-8, -2}, extent = {{-320, 30}, {-300, 50}}, rotation = 0)));
    Buildings.Controls.OBC.CDL.Reals.Multiply pro1 "Find fan flow signal by multiplying enable signal with speed signal" annotation (
      Placement(visible = true, transformation(origin={-18,10},   extent = {{-280, 10}, {-260, 30}}, rotation = 0)));
    Modelica.Blocks.Routing.Multiplex mux1(final n = 5) "Multiplexer for chilled water valve position measurements" annotation (
      Placement(transformation(extent = {{160, 70}, {180, 90}})));
    Modelica.Blocks.Routing.DeMultiplex demux1(final n = 5) "Demultiplexer for CAV terminal damper signals" annotation (
      Placement(transformation(extent = {{300, -260}, {320, -240}})));
    Modelica.Blocks.Routing.DeMultiplex demux2(n = 5) "Demultiplexer for CAV terminal reheat signals" annotation (
      Placement(transformation(extent = {{300, -300}, {320, -280}})));
    Modelica.Blocks.Routing.Multiplex mux3(n = 5) "Multiplexer for CAV terminal damper position measurements" annotation (
      Placement(transformation(extent = {{490, -20}, {510, 0}})));
    Buildings.Fluid.Sensors.RelativeHumidityTwoPort senRelHum(redeclare package
        Medium =                                                                         MediumA, m_flow_nominal = mAirTot_flow_nominal) "Relative humidity sensor" annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {-90, 160})));
    Buildings.Examples.ChilledBeamSystem.BaseClasses.ZoneModel_simplified nor(nConExt = 0, nConExtWin = 0, nConPar = 0, nConBou = 3, nSurBou = 0, datConBou(layers = {conIntWal, conIntWal, conIntWal}, A = {6.47, 40.76, 6.47}*hRoo, til = {Buildings.Types.Tilt.Wall, Buildings.Types.Tilt.Wall, Buildings.Types.Tilt.Wall}), redeclare
        package MediumA =                                                                                                                                                                                                         MediumA, redeclare
        package MediumW =                                                                                                                                                                                                         MediumW, Q_flow_nominal = QNor_flow_nominal, TRadSup_nominal = TChiWatSup_nominal, TRadRet_nominal = TChiWatRet_nominal, mRad_flow_nominal = mChiWatNor_flow_nominal, V = VRooNor, TAir_nominal = 297.04, mA_flow_nominal = mAirNor_flow_nominal, mAChiBea_flow_nominal = mAChiBeaNor_flow_nominal) "North zone" annotation (
      Placement(transformation(extent = {{180, 300}, {200, 320}})));
    Buildings.Examples.ChilledBeamSystem.BaseClasses.ZoneModel_simplified wes(nConExt = 0, nConExtWin = 0, nConPar = 0, nConBou = 3, nSurBou = 0, datConBou(layers = {conIntWal, conIntWal, conIntWal}, A = {6.47, 40.76, 6.47}*hRoo, til = {Buildings.Types.Tilt.Wall, Buildings.Types.Tilt.Wall, Buildings.Types.Tilt.Wall}), redeclare
        package MediumA =                                                                                                                                                                                                         MediumA, redeclare
        package MediumW =                                                                                                                                                                                                         MediumW, Q_flow_nominal = QWes_flow_nominal, TRadSup_nominal = TChiWatSup_nominal, TRadRet_nominal = TChiWatRet_nominal, mRad_flow_nominal = mChiWatWes_flow_nominal, V = VRooWes, TAir_nominal = 297.04, mA_flow_nominal = mAirWes_flow_nominal, mAChiBea_flow_nominal = mAChiBeaWes_flow_nominal) "West zone" annotation (
      Placement(transformation(extent = {{120, 240}, {140, 260}})));
    Buildings.Examples.ChilledBeamSystem.BaseClasses.ZoneModel_simplified cor(nConExt = 0, nConExtWin = 0, nConPar = 0, nConBou = 3, nSurBou = 0, datConBou(layers = {conIntWal, conIntWal, conIntWal}, A = {6.47, 40.76, 6.47}*hRoo, til = {Buildings.Types.Tilt.Wall, Buildings.Types.Tilt.Wall, Buildings.Types.Tilt.Wall}), redeclare
        package MediumA =                                                                                                                                                                                                         MediumA, redeclare
        package MediumW =                                                                                                                                                                                                         MediumW, Q_flow_nominal = QCor_flow_nominal, TRadSup_nominal = TChiWatSup_nominal, TRadRet_nominal = TChiWatRet_nominal, mRad_flow_nominal = mChiWatCor_flow_nominal, V = VRooCor, TAir_nominal = 297.04, mA_flow_nominal = mAirCor_flow_nominal, mAChiBea_flow_nominal = mAChiBeaCor_flow_nominal) "Core zone" annotation (
      Placement(transformation(extent = {{180, 240}, {200, 260}})));
    Buildings.Examples.ChilledBeamSystem.BaseClasses.ZoneModel_simplified eas(nConExt = 0, nConExtWin = 0, nConPar = 0, nConBou = 3, nSurBou = 0, datConBou(layers = {conIntWal, conIntWal, conIntWal}, A = {6.47, 40.76, 6.47}*hRoo, til = {Buildings.Types.Tilt.Wall, Buildings.Types.Tilt.Wall, Buildings.Types.Tilt.Wall}), redeclare
        package MediumA =                                                                                                                                                                                                         MediumA, redeclare
        package MediumW =                                                                                                                                                                                                         MediumW, Q_flow_nominal = QEas_flow_nominal, TRadSup_nominal = TChiWatSup_nominal, TRadRet_nominal = TChiWatRet_nominal, mRad_flow_nominal = mChiWatEas_flow_nominal, V = VRooEas, TAir_nominal = 297.04, mA_flow_nominal = mAirEas_flow_nominal, mAChiBea_flow_nominal = mAChiBeaEas_flow_nominal) "East zone" annotation (
      Placement(transformation(extent = {{240, 240}, {260, 260}})));
    Buildings.Examples.ChilledBeamSystem.BaseClasses.ZoneModel_simplified sou(nConExt = 0, nConExtWin = 0, nConPar = 0, nConBou = 3, nSurBou = 0, datConBou(layers = {conIntWal, conIntWal, conIntWal}, A = {6.47, 40.76, 6.47}*hRoo, til = {Buildings.Types.Tilt.Wall, Buildings.Types.Tilt.Wall, Buildings.Types.Tilt.Wall}), redeclare
        package MediumA =                                                                                                                                                                                                         MediumA, redeclare
        package MediumW =                                                                                                                                                                                                         MediumW, Q_flow_nominal = QSou_flow_nominal, TRadSup_nominal = TChiWatSup_nominal, TRadRet_nominal = TChiWatRet_nominal, mRad_flow_nominal = mChiWatSou_flow_nominal, V = VRooSou, TAir_nominal = 297.04, mA_flow_nominal = mAirSou_flow_nominal, mAChiBea_flow_nominal = mAChiBeaSou_flow_nominal) "South zone" annotation (
      Placement(transformation(extent = {{180, 180}, {200, 200}})));
    Buildings.BoundaryConditions.WeatherData.Bus zonMeaBus "Zone measurements bus" annotation (
      Placement(visible = true, transformation(origin = {0, 0}, extent = {{204, 262}, {224, 282}}, rotation = 0), iconTransformation(origin = {0, 0}, extent = {{0, 0}, {0, 0}}, rotation = 0)));
    Modelica.Blocks.Routing.Multiplex5 multiplex5_1 "Multiplexer for zone temperature measurements" annotation (
      Placement(visible = true, transformation(origin = {0, 0}, extent = {{300, 250}, {320, 270}}, rotation = 0)));
    Modelica.Blocks.Routing.Multiplex5 multiplex5_2 "Multiplexer for zone relative humidity measurements" annotation (
      Placement(transformation(extent = {{300, 290}, {320, 310}})));
    Modelica.Blocks.Routing.Multiplex5 multiplex5_3 "Multiplexer for zone discharge air volume flowrate measurements" annotation (
      Placement(transformation(extent = {{300, 210}, {320, 230}})));
    Buildings.Fluid.FixedResistances.Junction jun6(redeclare package Medium = MediumA, m_flow_nominal = {mAirTot_flow_nominal, -mAirTot_flow_nominal, mAirTot_flow_nominal}, dp_nominal = {0, 0, 0}) "Return air mixer" annotation (
      Placement(transformation(extent = {{-10, 150}, {10, 170}})));
    Buildings.Fluid.FixedResistances.Junction jun7(redeclare package Medium = MediumA, m_flow_nominal = {mAirTot_flow_nominal, -mAirTot_flow_nominal, mAirTot_flow_nominal}, dp_nominal = {0, 0, 0}) "Return air mixer" annotation (
      Placement(transformation(extent = {{20, 150}, {40, 170}})));
    Buildings.Fluid.FixedResistances.Junction jun8(redeclare package Medium = MediumA, m_flow_nominal = {mAirTot_flow_nominal, -mAirTot_flow_nominal, mAirTot_flow_nominal}, dp_nominal = {0, 0, 0}) "Return air mixer" annotation (
      Placement(transformation(extent = {{50, 150}, {70, 170}})));
    Fluid.FixedResistances.Junction jun1(redeclare package Medium = MediumW, m_flow_nominal = {mChiWatTot_flow_nominal, -mChiWatTot_flow_nominal, -mChiWatTot_flow_nominal}, dp_nominal = {0, 0, 0}) "Chilled water splitter" annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {100, 0})));
    Fluid.FixedResistances.Junction jun9(redeclare package Medium = MediumW, m_flow_nominal = {mChiWatTot_flow_nominal, -mChiWatTot_flow_nominal, -mChiWatTot_flow_nominal}, dp_nominal = {0, 0, 0}) "Chilled water splitter" annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {100, 40})));
    Fluid.FixedResistances.Junction jun10(redeclare package Medium = MediumW, m_flow_nominal = {mChiWatTot_flow_nominal, -mChiWatTot_flow_nominal, -mChiWatTot_flow_nominal}, dp_nominal = {0, 0, 0}) "Chilled water splitter" annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {100, 80})));
    Fluid.FixedResistances.Junction jun11(redeclare package Medium = MediumW, m_flow_nominal = {mChiWatTot_flow_nominal, -mChiWatTot_flow_nominal, -mChiWatTot_flow_nominal}, dp_nominal = {0, 0, 0}) "Chilled water splitter" annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {100, 120})));
    Fluid.Actuators.Valves.TwoWayLinear val1(redeclare package Medium = MediumW, m_flow_nominal = mChiWatEas_flow_nominal, dpValve_nominal = dpValve_nominal, dpFixed_nominal = dpFixed_nominal) "Chilled beam control valve for east zone" annotation (
      Placement(transformation(extent = {{120, -10}, {140, 10}})));
    Fluid.Actuators.Valves.TwoWayLinear val3(redeclare package Medium = MediumW, m_flow_nominal = mChiWatNor_flow_nominal, dpValve_nominal = dpValve_nominal, dpFixed_nominal = dpFixed_nominal) "Chilled beam control valve for north zone" annotation (
      Placement(transformation(extent = {{120, 30}, {140, 50}})));
    Fluid.Actuators.Valves.TwoWayLinear val4(redeclare package Medium = MediumW, m_flow_nominal = mChiWatWes_flow_nominal, dpValve_nominal = dpValve_nominal, dpFixed_nominal = dpFixed_nominal) "Chilled beam control valve for west zone" annotation (
      Placement(transformation(extent = {{120, 70}, {140, 90}})));
    Fluid.Actuators.Valves.TwoWayLinear val5(redeclare package Medium = MediumW, m_flow_nominal = mChiWatCor_flow_nominal, dpValve_nominal = dpValve_nominal, dpFixed_nominal = dpFixed_nominal) "Chilled beam control valve for core zone" annotation (
      Placement(transformation(extent = {{120, 110}, {140, 130}})));
    Fluid.Actuators.Valves.TwoWayLinear val2(redeclare package Medium = MediumW, m_flow_nominal = mChiWatTot_flow_nominal, dpValve_nominal = dpValve_nominal, dpFixed_nominal = dpFixed_nominal) "Chilled water bypass valve" annotation (
      Placement(transformation(extent = {{160, 130}, {180, 150}})));
    Fluid.FixedResistances.Junction jun2(redeclare package Medium = MediumW, m_flow_nominal = {mChiWatTot_flow_nominal, -mChiWatTot_flow_nominal, mChiWatTot_flow_nominal}, dp_nominal = {0, 0, 0}) "Chilled water mixer" annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin = {250, 0})));
    Fluid.FixedResistances.Junction jun12(redeclare package Medium = MediumW, m_flow_nominal = {mChiWatTot_flow_nominal, -mChiWatTot_flow_nominal, mChiWatTot_flow_nominal}, dp_nominal = {0, 0, 0}) "Chilled water mixer" annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin = {250, 40})));
    Fluid.FixedResistances.Junction jun13(redeclare package Medium = MediumW, m_flow_nominal = {mChiWatTot_flow_nominal, -mChiWatTot_flow_nominal, mChiWatTot_flow_nominal}, dp_nominal = {0, 0, 0}) "Chilled water mixer" annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin = {250, 80})));
    Fluid.FixedResistances.Junction jun14(redeclare package Medium = MediumW, m_flow_nominal = {mChiWatTot_flow_nominal, -mChiWatTot_flow_nominal, mChiWatTot_flow_nominal}, dp_nominal = {0, 0, 0}) "Chilled water mixer" annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin = {250, 120})));
    Fluid.FixedResistances.Junction jun4(redeclare package Medium = MediumA, m_flow_nominal = {mAirTot_flow_nominal, -mAirTot_flow_nominal, -mAirTot_flow_nominal}, dp_nominal = {0, 0, 0}) "Supply air splitter" annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {350, -130})));
    Buildings.Examples.VAVReheat.BaseClasses.VAVReheatBox easCAVTer(redeclare
        package MediumA =                                                                       MediumA, redeclare
        package MediumW =                                                                                                            MediumW,
      mCooAir_flow_nominal=mCooAir_flow_nominal,
      mHeaAir_flow_nominal=mHeaAir_flow_nominal,                                                                                              VRoo = VRooEas, allowFlowReversal = false,
      THeaWatInl_nominal=THeaWatInl_nominal,
      THeaWatOut_nominal=THeaWatOut_nominal,
      THeaAirInl_nominal=THeaAirInl_nominal,
      THeaAirDis_nominal=THeaAirDis_nominal)                                                                                                                                             "CAV terminal for east zone" annotation (
      Placement(transformation(extent = {{390, -70}, {430, -30}})));
    Fluid.FixedResistances.Junction jun15(redeclare package Medium = MediumA, m_flow_nominal = {mAirTot_flow_nominal, -mAirTot_flow_nominal, -mAirTot_flow_nominal}, dp_nominal = {0, 0, 0}) "Supply air splitter" annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {350, -70})));
    Buildings.Examples.VAVReheat.BaseClasses.VAVReheatBox norCAVTer(redeclare
        package MediumA =                                                                       MediumA, redeclare
        package MediumW =                                                                                                            MediumW,
      mCooAir_flow_nominal=mCooAir_flow_nominal,
      mHeaAir_flow_nominal=mHeaAir_flow_nominal,                                                                                              VRoo = VRooNor, allowFlowReversal = false,
      THeaWatInl_nominal=THeaWatInl_nominal,
      THeaWatOut_nominal=THeaWatOut_nominal,
      THeaAirInl_nominal=THeaAirInl_nominal,
      THeaAirDis_nominal=THeaAirDis_nominal)                                                                                                                                             "CAV terminal for north zone" annotation (
      Placement(transformation(extent = {{390, -10}, {430, 30}})));
    Fluid.FixedResistances.Junction jun16(redeclare package Medium = MediumA, m_flow_nominal = {mAirTot_flow_nominal, -mAirTot_flow_nominal, -mAirTot_flow_nominal}, dp_nominal = {0, 0, 0}) "Supply air splitter" annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {350, -10})));
    Buildings.Examples.VAVReheat.BaseClasses.VAVReheatBox wesCAVTer(redeclare
        package MediumA =                                                                       MediumA, redeclare
        package MediumW =                                                                                                            MediumW,
      mCooAir_flow_nominal=mCooAir_flow_nominal,
      mHeaAir_flow_nominal=mHeaAir_flow_nominal,                                                                                              VRoo = VRooWes, allowFlowReversal = false,
      THeaWatInl_nominal=THeaWatInl_nominal,
      THeaWatOut_nominal=THeaWatOut_nominal,
      THeaAirInl_nominal=THeaAirInl_nominal,
      THeaAirDis_nominal=THeaAirDis_nominal)                                                                                                                                             "CAV terminal for west zone" annotation (
      Placement(transformation(extent = {{390, 50}, {430, 90}})));
    Fluid.FixedResistances.Junction jun17(redeclare package Medium = MediumA, m_flow_nominal = {mAirTot_flow_nominal, -mAirTot_flow_nominal, -mAirTot_flow_nominal}, dp_nominal = {0, 0, 0}) "Supply air splitter" annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {350, 50})));
    Buildings.Examples.VAVReheat.BaseClasses.VAVReheatBox corCAVTer(redeclare
        package MediumA =                                                                       MediumA, redeclare
        package MediumW =                                                                                                            MediumW,
      mCooAir_flow_nominal=mCooAir_flow_nominal,
      mHeaAir_flow_nominal=mHeaAir_flow_nominal,                                                                                                                                                                                        VRoo = VRooCor, allowFlowReversal = false,
      THeaWatInl_nominal=THeaWatInl_nominal,
      THeaWatOut_nominal=THeaWatOut_nominal,
      THeaAirInl_nominal=THeaAirInl_nominal,
      THeaAirDis_nominal=THeaAirDis_nominal)                                                                                                                                                                                                         "CAV terminal for core zone" annotation (
      Placement(visible = true, transformation(origin = {0, -2}, extent = {{390, 110}, {430, 150}}, rotation = 0)));
    Modelica.Blocks.Routing.DeMultiplex demux3(n = 5) "Demultiplexer for zone heat gain signal" annotation (
      Placement(transformation(extent = {{80, 280}, {100, 300}})));
    Buildings.Controls.OBC.CDL.Interfaces.RealInput QFlo[5] "Heat flow rate into the zone" annotation (
      Placement(transformation(extent = {{-380, 270}, {-340, 310}}), iconTransformation(extent = {{-140, 200}, {-100, 240}})));
    Buildings.Controls.OBC.CDL.Logical.Pre pre1 "Logical pre block" annotation (
      Placement(visible = true, transformation(origin = {-14, 8}, extent = {{-320, 60}, {-300, 80}}, rotation = 0)));
    Fluid.FixedResistances.Junction jun18(redeclare package Medium = MediumW, m_flow_nominal = {mAirTot_flow_nominal, -mAirTot_flow_nominal, -mAirTot_flow_nominal}, dp_nominal = {0, 0, 0}) "Hot water splitter" annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {320, -80})));
    Fluid.FixedResistances.Junction jun22(redeclare package Medium = MediumW, m_flow_nominal = {mChiWatTot_flow_nominal, -mChiWatTot_flow_nominal, mChiWatTot_flow_nominal}, dp_nominal = {0, 0, 0}) "Hot water mixer" annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin = {480, 70})));
    Fluid.FixedResistances.Junction jun23(redeclare package Medium = MediumW, m_flow_nominal = {mChiWatTot_flow_nominal, -mChiWatTot_flow_nominal, mChiWatTot_flow_nominal}, dp_nominal = {0, 0, 0}) "Hot water mixer" annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin = {480, 20})));
    Buildings.Fluid.FixedResistances.Junction jun24(redeclare package Medium = MediumW, m_flow_nominal = {mChiWatTot_flow_nominal, -mChiWatTot_flow_nominal, mChiWatTot_flow_nominal}, dp_nominal = {0, 0, 0}) "Hot water mixer" annotation (
      Placement(visible = true, transformation(origin = {480, -50}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Fluid.FixedResistances.Junction jun25(redeclare package Medium = MediumW, m_flow_nominal = {mChiWatTot_flow_nominal, -mChiWatTot_flow_nominal, mChiWatTot_flow_nominal}, dp_nominal = {0, 0, 0}) "Hot water mixer" annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin = {480, -90})));
    Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gaiM_flow(final k = mAirTot_flow_nominal*1000*15/4200/10) "Calculate hot water mass flowrate based on reheat signal" annotation (
      Placement(transformation(extent = {{140, -290}, {160, -270}})));
    Fluid.Sources.MassFlowSource_T souTer(redeclare package Medium = MediumW, nPorts = 1, use_m_flow_in = true, T = 323.15) "Hot water source for terminal boxes " annotation (
      Placement(transformation(extent = {{180, -290}, {200, -270}})));
    Buildings.Controls.OBC.CDL.Reals.MultiMax mulMax(nin = 5) "Find maximum reheat signal for generating hot water" annotation (
      Placement(transformation(extent = {{100, -290}, {120, -270}})));
    Fluid.Sources.Boundary_pT sinTer(redeclare package Medium = MediumW, p(displayUnit = "Pa") = 3E5, nPorts = 1) "Hot water sink for terminal boxes" annotation (
      Placement(transformation(extent = {{450, -260}, {470, -240}})));
    Fluid.FixedResistances.Junction jun19(redeclare package Medium = MediumW, m_flow_nominal = {mAirTot_flow_nominal, -mAirTot_flow_nominal, -mAirTot_flow_nominal}, dp_nominal = {0, 0, 0}) "Hot water splitter" annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {320, -30})));
    Fluid.FixedResistances.Junction jun20(redeclare package Medium = MediumW, m_flow_nominal = {mAirTot_flow_nominal, -mAirTot_flow_nominal, -mAirTot_flow_nominal}, dp_nominal = {0, 0, 0}) "Hot water splitter" annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {320, 20})));
    Fluid.FixedResistances.Junction jun21(redeclare package Medium = MediumW, m_flow_nominal = {mAirTot_flow_nominal, -mAirTot_flow_nominal, -mAirTot_flow_nominal}, dp_nominal = {0, 0, 0}) "Hot water splitter" annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {320, 70})));
    Buildings.Controls.OBC.CDL.Interfaces.RealOutput OutdoorAirTemp "Outdoor Air Dry Bulb Temperature" annotation (
      Placement(visible = true, transformation(origin={8,-52},    extent = {{580, -200}, {620, -160}}, rotation = 0), iconTransformation(origin = {0, 4}, extent = {{100, -240}, {140, -200}}, rotation = 0)));
    Buildings.Controls.OBC.CDL.Logical.TrueDelay truDel(delayTime = 10) annotation (
      Placement(visible = true, transformation(origin = {-288, 84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput exhFanSta "Exhaust Fan Proven on" annotation (
      Placement(visible = true, transformation(origin = {0, 0}, extent = {{580, -70}, {620, -30}}, rotation = 0), iconTransformation(origin={0,80},    extent = {{100, -80}, {140, -40}}, rotation = 0)));
    Fluid.Sensors.TemperatureTwoPort senTem1(redeclare package Medium = MediumA, m_flow_nominal = mAirTot_flow_nominal) annotation (
      Placement(visible = true, transformation(origin = {-158, 160}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Buildings.Fluid.Sensors.RelativePressure relativePressure(redeclare package
        Medium =                                                                         MediumA) annotation (
      Placement(visible = true, transformation(origin = {-130, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Buildings.Controls.OBC.CDL.Interfaces.RealOutput bldgSP "Building Static Pressure SetPoint" annotation (
      Placement(visible = true, transformation(origin = {0, -136}, extent = {{580, -200}, {620, -160}}, rotation = 0), iconTransformation(origin = {-480, -60}, extent = {{580, -200}, {620, -160}}, rotation = 0)));
    Buildings.Fluid.MixingVolumes.MixingVolume vol(redeclare package Medium = MediumA, V = 1.2*100, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, m_flow_nominal = mAirTot_flow_nominal)             annotation (
      Placement(visible = true, transformation(origin={-202,52},    extent = {{6, -16}, {26, 4}}, rotation = 0)));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHea annotation (
      Placement(visible = true, transformation(origin = {-150, 44}, extent = {{-100, -10}, {-80, 10}}, rotation = 0)));
    Buildings.Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium = MediumA) annotation (
      Placement(visible = true, transformation(origin = {-236, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Buildings.Controls.OBC.CDL.Interfaces.RealInput deltaT annotation (
      Placement(visible = true, transformation(origin = {-360, -16}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 120}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Buildings.Controls.OBC.CDL.Reals.Multiply mul annotation (
      Placement(visible = true, transformation(origin = {-256, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gai2(k = 1006) annotation (
      Placement(visible = true, transformation(origin = {-312, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Buildings.Controls.OBC.CDL.Interfaces.RealOutput rAT annotation (
      Placement(visible = true, transformation(origin = {0, -94}, extent = {{580, -200}, {620, -160}}, rotation = 0), iconTransformation(origin={0,36},   extent = {{100, -240}, {140, -200}}, rotation = 0)));
    Buildings.Controls.OBC.CDL.Interfaces.RealOutput erwsuphum "ERW supply relative humidity sensor" annotation (
      Placement(visible = true, transformation(origin = {0, -14}, extent = {{580, -200}, {620, -160}}, rotation = 0), iconTransformation(origin={0,94},    extent = {{100, -240}, {140, -200}}, rotation = 0)));
    Buildings.Fluid.Sensors.RelativeHumidityTwoPort senRelHum1(redeclare
        package Medium =                                                                  MediumA,
        m_flow_nominal=mAirTot_flow_nominal)                                                       annotation (
      Placement(visible = true, transformation(origin={-188,12},   extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Buildings.Fluid.Movers.Preconfigured.SpeedControlled_y mov(redeclare
        package Medium =                                                                  MediumA, dp_nominal(displayUnit = "Pa") = 2000, m_flow_nominal = mAirTot_flow_nominal)  annotation (
      Placement(visible = true, transformation(origin = {-64, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Buildings.Fluid.Movers.Preconfigured.SpeedControlled_y mov1(redeclare
        package Medium =                                                                   MediumW, dp_nominal(displayUnit = "Pa") = 60000, m_flow_nominal = mChiWatTot_flow_nominal)  annotation (
      Placement(visible = true, transformation(origin = {74, -116}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Controls.OBC.CDL.Reals.Sources.Constant con(k=0)
      annotation (Placement(transformation(extent={{-288,40},{-268,60}})));
  equation
    connect(jun.port_3, val.port_a) annotation (
      Line(points = {{110, -40}, {120, -40}}, color = {0, 127, 255}));
    connect(weaDat.weaBus, weaBus) annotation (
      Line(points = {{-304, -24}, {-304, -16}, {-286, -16}}, color = {255, 204, 51}, thickness = 0.5));
    connect(weaBus, amb.weaBus) annotation (
      Line(points={{-286,-16},{-262,-16},{-262,-34.78},{-294,-34.78}},    color = {255, 204, 51}, thickness = 0.5));
    connect(cooCoi.port_b1, sinCoo.ports[1]) annotation (
      Line(points={{-130,-12},{-140,-12},{-140,-60}},        color = {28, 108, 200}, thickness = 0.5));
    connect(heaCoi.port_b2, cooCoi.port_a2) annotation (
      Line(points = {{-154, -10}, {-143, -10}, {-143, 0}, {-130, 0}}, color = {0, 127, 255}, thickness = 0.5));
    connect(souHea.ports[1], heaCoi.port_a1) annotation (
      Line(points = {{-170, -60}, {-170, -36}, {-154, -36}, {-154, -22}}, color = {28, 108, 200}, thickness = 0.5));
    connect(heaCoi.port_b1, sinHea.ports[1]) annotation (
      Line(points = {{-174, -22}, {-212, -22}, {-212, -64}}, color = {28, 108, 200}, thickness = 0.5));
    connect(jun3.port_2, sinCoo1.ports[1]) annotation (
      Line(points = {{250, -50}, {250, -166}, {248, -166}}, color = {0, 127, 255}));
    connect(senRelPre.port_b, sinCoo1.ports[2]) annotation (
      Line(points = {{170, -70}, {252, -70}, {252, -166}}, color = {0, 127, 255}));
    connect(uPumSta, booToRea.u) annotation (
      Line(points = {{-360, -110}, {-322, -110}}, color = {255, 0, 255}));
    connect(booToRea.y, pro.u1) annotation (
      Line(points = {{-298, -110}, {-290, -110}, {-290, -124}, {-282, -124}}, color = {0, 0, 127}));
    connect(uPumSpe, pro.u2) annotation (
      Line(points = {{-360, -140}, {-290, -140}, {-290, -136}, {-282, -136}}, color = {0, 0, 127}));
    connect(TChiWatSup, souCoo1.T_in) annotation (
      Line(points = {{-360, -180}, {80, -180}, {80, -194}, {96, -194}, {96, -186}}, color = {0, 0, 127}));
    connect(uCooCoi, gai1.u) annotation (
      Line(points = {{-360, -80}, {-322, -80}}, color = {0, 0, 127}));
    connect(gai1.y, souCoo.m_flow_in) annotation (
      Line(points = {{-298, -80}, {-270, -80}, {-270, -110}, {-108, -110}, {-108, -82}}, color = {0, 0, 127}));
    connect(uHeaCoi, gai.u) annotation (
      Line(points = {{-360, -50}, {-322, -50}}, color = {0, 0, 127}));
    connect(gai.y, souHea.m_flow_in) annotation (
      Line(points = {{-298, -50}, {-260, -50}, {-260, -92}, {-178, -92}, {-178, -82}}, color = {0, 0, 127}));
    connect(senTem.T, TDOASDis) annotation (
      Line(points = {{-30, 11}, {-30, 20}, {-10, 20}, {-10, -152}, {348, -152}, {348, -122}, {600, -122}}, color = {0, 0, 127}));
    connect(uFanSta, booToRea1.u) annotation (
      Line(points = {{-360, 40}, {-341, 40}, {-341, 38}, {-330, 38}}, color = {255, 0, 255}));
    connect(booToRea1.y, pro1.u1) annotation (
      Line(points={{-306,38},{-306,36},{-300,36}},                    color = {0, 0, 127}));
    connect(uFanSpe, pro1.u2) annotation (
      Line(points={{-360,10},{-330,10},{-330,24},{-300,24}},          color = {0, 0, 127}));
    connect(val.y_actual, mux1.u[1]) annotation (
      Line(points = {{135, -33}, {154, -33}, {154, 85.6}, {160, 85.6}}, color = {0, 0, 127}));
    connect(demux.y[1], val.y) annotation (
      Line(points={{62,-14.4},{130,-14.4},{130,-28}},        color = {0, 0, 127}));
    connect(senRelHum.port_a, jun5.port_1) annotation (
      Line(points = {{-80, 160}, {-40, 160}}, color = {0, 127, 255}));
    connect(senRelHum.phi, relHumDOASRet) annotation (
      Line(points = {{-90.1, 149}, {-90.1, -152}, {602, -152}}, color = {0, 0, 127}));
    connect(wes.port_a, sou.port_a) annotation (
      Line(points = {{130, 260}, {130, 270}, {170, 270}, {170, 230}, {190, 230}, {190, 200}}, color = {191, 0, 0}));
    connect(wes.port_a, nor.port_a) annotation (
      Line(points = {{130, 260}, {130, 270}, {170, 270}, {170, 330}, {190, 330}, {190, 320}}, color = {191, 0, 0}));
    connect(nor.port_a, eas.port_a) annotation (
      Line(points = {{190, 320}, {190, 330}, {250, 330}, {250, 260}}, color = {191, 0, 0}));
    connect(eas.port_a, sou.port_a) annotation (
      Line(points = {{250, 260}, {250, 264}, {210, 264}, {210, 230}, {190, 230}, {190, 200}}, color = {191, 0, 0}));
    connect(wes.port_a, cor.port_a) annotation (
      Line(points = {{130, 260}, {130, 270}, {190, 270}, {190, 260}}, color = {191, 0, 0}));
    connect(eas.port_a, cor.port_a) annotation (
      Line(points = {{250, 260}, {250, 264}, {190, 264}, {190, 260}}, color = {191, 0, 0}));
    connect(sou.yRelHumZon, zonMeaBus.yRelHumSou) annotation (
      Line(points = {{202, 198}, {214, 198}, {214, 272}}, color = {0, 0, 127}));
    connect(sou.TZon, zonMeaBus.TSou) annotation (
      Line(points = {{202, 194}, {214, 194}, {214, 272}}, color = {0, 0, 127}));
    connect(sou.VDisAir_flow, zonMeaBus.VAirSou) annotation (
      Line(points = {{202, 190}, {214, 190}, {214, 272}}, color = {0, 0, 127}));
    connect(wes.yRelHumZon, zonMeaBus.yRelHumWes) annotation (
      Line(points = {{142, 258}, {172, 258}, {172, 272}, {214, 272}}, color = {0, 0, 127}));
    connect(wes.TZon, zonMeaBus.TWes) annotation (
      Line(points = {{142, 254}, {172, 254}, {172, 272}, {214, 272}}, color = {0, 0, 127}));
    connect(wes.VDisAir_flow, zonMeaBus.VAirWes) annotation (
      Line(points = {{142, 250}, {172, 250}, {172, 272}, {214, 272}}, color = {0, 0, 127}));
    connect(nor.yRelHumZon, zonMeaBus.yRelHumNor) annotation (
      Line(points = {{202, 318}, {214, 318}, {214, 272}}, color = {0, 0, 127}));
    connect(nor.TZon, zonMeaBus.TNor) annotation (
      Line(points = {{202, 314}, {214, 314}, {214, 272}}, color = {0, 0, 127}));
    connect(nor.VDisAir_flow, zonMeaBus.VAirNor) annotation (
      Line(points = {{202, 310}, {214, 310}, {214, 272}}, color = {0, 0, 127}));
    connect(eas.yRelHumZon, zonMeaBus.yRelHumEas) annotation (
      Line(points = {{262, 258}, {268, 258}, {268, 272}, {214, 272}}, color = {0, 0, 127}));
    connect(eas.TZon, zonMeaBus.TEas) annotation (
      Line(points = {{262, 254}, {268, 254}, {268, 272}, {214, 272}}, color = {0, 0, 127}));
    connect(eas.VDisAir_flow, zonMeaBus.VAirEas) annotation (
      Line(points = {{262, 250}, {268, 250}, {268, 272}, {214, 272}}, color = {0, 0, 127}));
    connect(cor.yRelHumZon, zonMeaBus.yRelHumCor) annotation (
      Line(points = {{202, 258}, {214, 258}, {214, 272}}, color = {0, 0, 127}));
    connect(cor.TZon, zonMeaBus.TCor) annotation (
      Line(points = {{202, 254}, {214, 254}, {214, 272}}, color = {0, 0, 127}));
    connect(cor.VDisAir_flow, zonMeaBus.VAirCor) annotation (
      Line(points = {{202, 250}, {214, 250}, {214, 272}}, color = {0, 0, 127}));
    connect(multiplex5_1.y, TZon) annotation (
      Line(points = {{321, 260}, {600, 260}}, color = {0, 0, 127}));
    connect(multiplex5_1.u1[1], zonMeaBus.TSou) annotation (
      Line(points = {{298, 270}, {280, 270}, {280, 272}, {214, 272}}, color = {0, 0, 127}));
    connect(multiplex5_1.u2[1], zonMeaBus.TEas) annotation (
      Line(points = {{298, 265}, {280, 265}, {280, 272}, {214, 272}}, color = {0, 0, 127}));
    connect(multiplex5_1.u3[1], zonMeaBus.TNor) annotation (
      Line(points = {{298, 260}, {280, 260}, {280, 272}, {214, 272}}, color = {0, 0, 127}));
    connect(multiplex5_1.u4[1], zonMeaBus.TWes) annotation (
      Line(points = {{298, 255}, {280, 255}, {280, 272}, {214, 272}}, color = {0, 0, 127}));
    connect(multiplex5_1.u5[1], zonMeaBus.TCor) annotation (
      Line(points = {{298, 250}, {280, 250}, {280, 272}, {214, 272}}, color = {0, 0, 127}));
    connect(multiplex5_3.y, VDisAir_flow) annotation (
      Line(points = {{321, 220}, {600, 220}}, color = {0, 0, 127}));
    connect(multiplex5_2.y, yRelHumZon) annotation (
      Line(points = {{321, 300}, {600, 300}}, color = {0, 0, 127}));
    connect(multiplex5_2.u1[1], zonMeaBus.yRelHumSou) annotation (
      Line(points = {{298, 310}, {280, 310}, {280, 272}, {214, 272}}, color = {0, 0, 127}));
    connect(multiplex5_2.u2[1], zonMeaBus.yRelHumEas) annotation (
      Line(points = {{298, 305}, {280, 305}, {280, 272}, {214, 272}}, color = {0, 0, 127}));
    connect(multiplex5_2.u3[1], zonMeaBus.yRelHumNor) annotation (
      Line(points = {{298, 300}, {280, 300}, {280, 272}, {214, 272}}, color = {0, 0, 127}));
    connect(multiplex5_2.u4[1], zonMeaBus.yRelHumWes) annotation (
      Line(points = {{298, 295}, {280, 295}, {280, 272}, {214, 272}}, color = {0, 0, 127}));
    connect(multiplex5_2.u5[1], zonMeaBus.yRelHumCor) annotation (
      Line(points = {{298, 290}, {280, 290}, {280, 272}, {214, 272}}, color = {0, 0, 127}));
    connect(multiplex5_3.u1[1], zonMeaBus.VAirSou) annotation (
      Line(points = {{298, 230}, {280, 230}, {280, 272}, {214, 272}}, color = {0, 0, 127}));
    connect(multiplex5_3.u2[1], zonMeaBus.VAirEas) annotation (
      Line(points = {{298, 225}, {280, 225}, {280, 272}, {214, 272}}, color = {0, 0, 127}));
    connect(multiplex5_3.u3[1], zonMeaBus.VAirNor) annotation (
      Line(points = {{298, 220}, {280, 220}, {280, 272}, {214, 272}}, color = {0, 0, 127}));
    connect(multiplex5_3.u4[1], zonMeaBus.VAirWes) annotation (
      Line(points = {{298, 215}, {280, 215}, {280, 272}, {214, 272}}, color = {0, 0, 127}));
    connect(multiplex5_3.u5[1], zonMeaBus.VAirCor) annotation (
      Line(points = {{298, 210}, {280, 210}, {280, 272}, {214, 272}}, color = {0, 0, 127}));
    connect(jun5.port_2, jun6.port_1) annotation (
      Line(points = {{-20, 160}, {-10, 160}}, color = {0, 127, 255}));
    connect(jun6.port_2, jun7.port_1) annotation (
      Line(points = {{10, 160}, {20, 160}}, color = {0, 127, 255}));
    connect(jun7.port_2, jun8.port_1) annotation (
      Line(points = {{40, 160}, {50, 160}}, color = {0, 127, 255}));
    connect(sou.portAir_b, jun8.port_3) annotation (
      Line(points = {{180, 186}, {160, 186}, {160, 150}, {60, 150}}, color = {0, 127, 255}));
    connect(eas.portAir_b, jun8.port_2) annotation (
      Line(points = {{240, 246}, {230, 246}, {230, 210}, {140, 210}, {140, 160}, {70, 160}}, color = {0, 127, 255}));
    connect(nor.portAir_b, jun7.port_3) annotation (
      Line(points = {{180, 306}, {160, 306}, {160, 210}, {140, 210}, {140, 170}, {46, 170}, {46, 150}, {30, 150}}, color = {0, 127, 255}));
    connect(wes.portAir_b, jun6.port_3) annotation (
      Line(points = {{120, 246}, {112, 246}, {112, 170}, {14, 170}, {14, 150}, {0, 150}}, color = {0, 127, 255}));
    connect(cor.portAir_b, jun5.port_3) annotation (
      Line(points = {{180, 246}, {160, 246}, {160, 210}, {140, 210}, {140, 170}, {-14, 170}, {-14, 150}, {-30, 150}}, color = {0, 127, 255}));
    connect(jun.port_2, jun1.port_1) annotation (
      Line(points = {{100, -30}, {100, -10}}, color = {0, 127, 255}));
    connect(jun1.port_2, jun9.port_1) annotation (
      Line(points = {{100, 10}, {100, 30}}, color = {0, 127, 255}));
    connect(jun9.port_2, jun10.port_1) annotation (
      Line(points = {{100, 50}, {100, 70}}, color = {0, 127, 255}));
    connect(jun10.port_2, jun11.port_1) annotation (
      Line(points = {{100, 90}, {100, 110}}, color = {0, 127, 255}));
    connect(jun1.port_3, val1.port_a) annotation (
      Line(points = {{110, 0}, {120, 0}}, color = {0, 127, 255}));
    connect(jun9.port_3, val3.port_a) annotation (
      Line(points = {{110, 40}, {120, 40}}, color = {0, 127, 255}));
    connect(jun10.port_3, val4.port_a) annotation (
      Line(points = {{110, 80}, {120, 80}}, color = {0, 127, 255}));
    connect(jun11.port_3, val5.port_a) annotation (
      Line(points = {{110, 120}, {120, 120}}, color = {0, 127, 255}));
    connect(jun11.port_2, val2.port_a) annotation (
      Line(points = {{100, 130}, {100, 140}, {160, 140}}, color = {0, 127, 255}));
    connect(val2.port_b, jun14.port_1) annotation (
      Line(points = {{180, 140}, {250, 140}, {250, 130}}, color = {0, 127, 255}));
    connect(jun14.port_2, jun13.port_1) annotation (
      Line(points = {{250, 110}, {250, 90}}, color = {0, 127, 255}));
    connect(jun13.port_2, jun12.port_1) annotation (
      Line(points = {{250, 70}, {250, 50}}, color = {0, 127, 255}));
    connect(jun12.port_2, jun2.port_1) annotation (
      Line(points = {{250, 30}, {250, 10}}, color = {0, 127, 255}));
    connect(jun2.port_2, jun3.port_1) annotation (
      Line(points = {{250, -10}, {250, -30}}, color = {0, 127, 255}));
    connect(val.port_b, sou.portChiWat_a) annotation (
      Line(points = {{140, -40}, {150, -40}, {150, 170}, {186, 170}, {186, 180}}, color = {0, 127, 255}));
    connect(val1.port_b, eas.portChiWat_a) annotation (
      Line(points = {{140, 0}, {150, 0}, {150, 170}, {246, 170}, {246, 240}}, color = {0, 127, 255}));
    connect(val3.port_b, nor.portChiWat_a) annotation (
      Line(points = {{140, 40}, {150, 40}, {150, 170}, {224, 170}, {224, 290}, {186, 290}, {186, 300}}, color = {0, 127, 255}));
    connect(val4.port_b, wes.portChiWat_a) annotation (
      Line(points = {{140, 80}, {150, 80}, {150, 180}, {126, 180}, {126, 240}}, color = {0, 127, 255}));
    connect(val5.port_b, cor.portChiWat_a) annotation (
      Line(points = {{140, 120}, {150, 120}, {150, 220}, {186, 220}, {186, 240}}, color = {0, 127, 255}));
    connect(cor.portChiWat_b, jun14.port_3) annotation (
      Line(points = {{194, 240}, {194, 220}, {228, 220}, {228, 120}, {240, 120}}, color = {0, 127, 255}));
    connect(wes.portChiWat_b, jun13.port_3) annotation (
      Line(points = {{134, 240}, {134, 164}, {228, 164}, {228, 80}, {240, 80}}, color = {0, 127, 255}));
    connect(nor.portChiWat_b, jun12.port_3) annotation (
      Line(points = {{194, 300}, {194, 294}, {228, 294}, {228, 40}, {240, 40}}, color = {0, 127, 255}));
    connect(eas.portChiWat_b, jun2.port_3) annotation (
      Line(points = {{254, 240}, {254, 216}, {228, 216}, {228, 0}, {240, 0}}, color = {0, 127, 255}));
    connect(sou.portChiWat_b, jun3.port_3) annotation (
      Line(points = {{194, 180}, {194, 164}, {228, 164}, {228, -40}, {240, -40}}, color = {0, 127, 255}));
    connect(uChiWatVal, demux.u) annotation (
      Line(points={{-360,180},{-240,180},{-240,140},{0,140},{0,-20},{40,-20}},              color = {0, 0, 127}));
    connect(demux.y[2], val1.y) annotation (
      Line(points={{62,-17.2},{80,-17.2},{80,18},{130,18},{130,12}},            color = {0, 0, 127}));
    connect(demux.y[3], val3.y) annotation (
      Line(points={{62,-20},{80,-20},{80,60},{130,60},{130,52}},            color = {0, 0, 127}));
    connect(demux.y[4], val4.y) annotation (
      Line(points={{62,-22.8},{80,-22.8},{80,100},{130,100},{130,92}},            color = {0, 0, 127}));
    connect(demux.y[5], val5.y) annotation (
      Line(points={{62,-25.6},{80,-25.6},{80,138},{130,138},{130,132}},            color = {0, 0, 127}));
    connect(uBypValPos, val2.y) annotation (
      Line(points = {{-360, 220}, {100, 220}, {100, 158}, {170, 158}, {170, 152}}, color = {0, 0, 127}));
    connect(val1.y_actual, mux1.u[2]) annotation (
      Line(points = {{135, 7}, {154, 7}, {154, 82.8}, {160, 82.8}}, color = {0, 0, 127}));
    connect(val3.y_actual, mux1.u[3]) annotation (
      Line(points = {{135, 47}, {154, 47}, {154, 80}, {160, 80}}, color = {0, 0, 127}));
    connect(val4.y_actual, mux1.u[4]) annotation (
      Line(points = {{135, 87}, {154, 87}, {154, 77.2}, {160, 77.2}}, color = {0, 0, 127}));
    connect(val5.y_actual, mux1.u[5]) annotation (
      Line(points = {{135, 127}, {154, 127}, {154, 74.4}, {160, 74.4}}, color = {0, 0, 127}));
    connect(mux1.y, yChiWatVal) annotation (
      Line(points = {{181, 80}, {200, 80}, {200, -200}, {520, -200}, {520, 80}, {600, 80}}, color = {0, 0, 127}));
    connect(jun4.port_3, souCAVTer.port_aAir) annotation (
      Line(points = {{360, -130}, {410, -130}}, color = {0, 127, 255}));
    connect(jun15.port_3, easCAVTer.port_aAir) annotation (
      Line(points = {{360, -70}, {410, -70}}, color = {0, 127, 255}));
    connect(jun16.port_3, norCAVTer.port_aAir) annotation (
      Line(points = {{360, -10}, {410, -10}}, color = {0, 127, 255}));
    connect(jun17.port_3, wesCAVTer.port_aAir) annotation (
      Line(points = {{360, 50}, {410, 50}}, color = {0, 127, 255}));
    connect(senTem.port_b, jun4.port_1) annotation (
      Line(points = {{-20, 0}, {10, 0}, {10, -214}, {350, -214}, {350, -140}}, color = {0, 127, 255}));
    connect(jun4.port_2, jun15.port_1) annotation (
      Line(points = {{350, -120}, {350, -80}}, color = {0, 127, 255}));
    connect(jun15.port_2, jun16.port_1) annotation (
      Line(points = {{350, -60}, {350, -20}}, color = {0, 127, 255}));
    connect(jun16.port_2, jun17.port_1) annotation (
      Line(points = {{350, 0}, {350, 40}}, color = {0, 127, 255}));
    connect(jun17.port_2, corCAVTer.port_aAir) annotation (
      Line(points = {{350, 60}, {350, 108}, {410, 108}}, color = {0, 127, 255}));
    connect(demux1.y[1], souCAVTer.yVAV) annotation (
      Line(points = {{320, -244.4}, {374, -244.4}, {374, -94}, {386, -94}}, color = {0, 0, 127}));
    connect(demux1.y[2], easCAVTer.yVAV) annotation (
      Line(points = {{320, -247.2}, {374, -247.2}, {374, -34}, {386, -34}}, color = {0, 0, 127}));
    connect(demux1.y[3], norCAVTer.yVAV) annotation (
      Line(points = {{320, -250}, {374, -250}, {374, 26}, {386, 26}}, color = {0, 0, 127}));
    connect(demux1.y[4], wesCAVTer.yVAV) annotation (
      Line(points = {{320, -252.8}, {374, -252.8}, {374, 86}, {386, 86}}, color = {0, 0, 127}));
    connect(demux1.y[5], corCAVTer.yVAV) annotation (
      Line(points = {{320, -255.6}, {374, -255.6}, {374, 144}, {386, 144}}, color = {0, 0, 127}));
    connect(demux2.y[1], souCAVTer.yHea) annotation (
      Line(points = {{320, -284.4}, {368, -284.4}, {368, -104}, {386, -104}}, color = {0, 0, 127}));
    connect(demux2.y[2], easCAVTer.yHea) annotation (
      Line(points = {{320, -287.2}, {368, -287.2}, {368, -44}, {386, -44}}, color = {0, 0, 127}));
    connect(demux2.y[3], norCAVTer.yHea) annotation (
      Line(points = {{320, -290}, {368, -290}, {368, 16}, {386, 16}}, color = {0, 0, 127}));
    connect(demux2.y[4], wesCAVTer.yHea) annotation (
      Line(points = {{320, -292.8}, {368, -292.8}, {368, 76}, {386, 76}}, color = {0, 0, 127}));
    connect(demux2.y[5], corCAVTer.yHea) annotation (
      Line(points = {{320, -295.6}, {368, -295.6}, {368, 134}, {386, 134}}, color = {0, 0, 127}));
    connect(souCAVTer.y_actual, mux3.u[1]) annotation (
      Line(points = {{432, -110}, {450, -110}, {450, -4.4}, {490, -4.4}}, color = {0, 0, 127}));
    connect(easCAVTer.y_actual, mux3.u[2]) annotation (
      Line(points = {{432, -50}, {450, -50}, {450, -7.2}, {490, -7.2}}, color = {0, 0, 127}));
    connect(norCAVTer.y_actual, mux3.u[3]) annotation (
      Line(points = {{432, 10}, {450, 10}, {450, -10}, {490, -10}}, color = {0, 0, 127}));
    connect(wesCAVTer.y_actual, mux3.u[4]) annotation (
      Line(points = {{432, 70}, {450, 70}, {450, -12.8}, {490, -12.8}}, color = {0, 0, 127}));
    connect(corCAVTer.y_actual, mux3.u[5]) annotation (
      Line(points = {{432, 128}, {450, 128}, {450, -15.6}, {490, -15.6}}, color = {0, 0, 127}));
    connect(mux3.y, yDamPos) annotation (
      Line(points = {{511, -10}, {560, -10}, {560, 56}, {602, 56}}, color = {0, 0, 127}));
    connect(uCAVDam, demux1.u) annotation (
      Line(points = {{-360, 140}, {-250, 140}, {-250, 120}, {16, 120}, {16, -90}, {280, -90}, {280, -250}, {298, -250}}, color = {0, 0, 127}));
    connect(uCAVReh, demux2.u) annotation (
      Line(points = {{-360, 100}, {-4, 100}, {-4, -148}, {290, -148}, {290, -290}, {298, -290}}, color = {0, 0, 127}));
    connect(souCAVTer.port_bAir, sou.portAir_a) annotation (
      Line(points = {{410, -90}, {440, -90}, {440, 180}, {220, 180}, {220, 186}, {200, 186}}, color = {0, 127, 255}));
    connect(easCAVTer.port_bAir, eas.portAir_a) annotation (
      Line(points = {{410, -30}, {440, -30}, {440, 180}, {268, 180}, {268, 246}, {260, 246}}, color = {0, 127, 255}));
    connect(norCAVTer.port_bAir, nor.portAir_a) annotation (
      Line(points = {{410, 30}, {440, 30}, {440, 180}, {220, 180}, {220, 306}, {200, 306}}, color = {0, 127, 255}));
    connect(wesCAVTer.port_bAir, wes.portAir_a) annotation (
      Line(points = {{410, 90}, {440, 90}, {440, 180}, {220, 180}, {220, 224}, {146, 224}, {146, 246}, {140, 246}}, color = {0, 127, 255}));
    connect(corCAVTer.port_bAir, cor.portAir_a) annotation (
      Line(points = {{410, 148}, {440, 148}, {440, 180}, {220, 180}, {220, 224}, {206, 224}, {206, 246}, {200, 246}}, color = {0, 127, 255}));
    connect(val2.y_actual, yBypValPos) annotation (
      Line(points = {{175, 147}, {360, 147}, {360, 170}, {520, 170}, {520, 120}, {600, 120}}, color = {0, 0, 127}));
    connect(senRelPre1.p_rel, dPDOASAir) annotation (
      Line(points={{-41,32},{4,32},{4,-158},{540,-158},{540,16},{600,16}},              color = {0, 0, 127}));
    connect(hys.y, yPumSta) annotation (
      Line(points = {{162, -110}, {196, -110}, {196, -204}, {546, -204}, {546, -90}, {602, -90}}, color = {255, 0, 255}));
    connect(senRelPre.p_rel, dPChiWat) annotation (
      Line(points = {{160, -79}, {160, -84}, {186, -84}, {186, -212}, {560, -212}, {560, -70}, {598, -70}}, color = {0, 0, 127}));
    connect(QFlo, demux3.u) annotation (
      Line(points = {{-360, 290}, {78, 290}}, color = {0, 0, 127}));
    connect(demux3.y[1], sou.QFlo) annotation (
      Line(points = {{100, 295.6}, {106, 295.6}, {106, 194}, {178, 194}}, color = {0, 0, 127}));
    connect(demux3.y[2], eas.QFlo) annotation (
      Line(points = {{100, 292.8}, {180, 292.8}, {180, 280}, {234, 280}, {234, 254}, {238, 254}}, color = {0, 0, 127}));
    connect(demux3.y[3], nor.QFlo) annotation (
      Line(points = {{100, 290}, {106, 290}, {106, 314}, {178, 314}}, color = {0, 0, 127}));
    connect(demux3.y[4], wes.QFlo) annotation (
      Line(points = {{100, 287.2}, {106, 287.2}, {106, 254}, {118, 254}}, color = {0, 0, 127}));
    connect(demux3.y[5], cor.QFlo) annotation (
      Line(points = {{100, 284.4}, {106, 284.4}, {106, 234}, {176, 234}, {176, 254}, {178, 254}}, color = {0, 0, 127}));
    connect(val.y_actual, sou.uVal) annotation (
      Line(points = {{135, -33}, {154, -33}, {154, 190}, {178, 190}}, color = {0, 0, 127}));
    connect(val1.y_actual, eas.uVal) annotation (
      Line(points = {{135, 7}, {154, 7}, {154, 204}, {234, 204}, {234, 250}, {238, 250}}, color = {0, 0, 127}));
    connect(val3.y_actual, nor.uVal) annotation (
      Line(points = {{135, 47}, {154, 47}, {154, 310}, {178, 310}}, color = {0, 0, 127}));
    connect(val4.y_actual, wes.uVal) annotation (
      Line(points = {{135, 87}, {154, 87}, {154, 220}, {110, 220}, {110, 250}, {118, 250}}, color = {0, 0, 127}));
    connect(val5.y_actual, cor.uVal) annotation (
      Line(points = {{135, 127}, {154, 127}, {154, 248}, {174, 248}, {174, 250}, {178, 250}}, color = {0, 0, 127}));
    connect(uFanSta, pre1.u) annotation (
      Line(points = {{-360, 40}, {-336, 40}, {-336, 78}}, color = {255, 0, 255}));
    connect(pre1.y, yFanSta) annotation (
      Line(points={{-312,78},{-306,78},{-306,66},{-300,66},{-300,64},{-254,64},{
            -254,68},{-38,68},{-38,-174},{50,-174},{50,-208},{554,-208},{554,-18},
            {598,-18}},                                                                                                color = {255, 0, 255}));
    connect(souTer.m_flow_in, gaiM_flow.y) annotation (
      Line(points = {{178, -272}, {170, -272}, {170, -280}, {162, -280}}, color = {0, 0, 127}));
    connect(mulMax.y, gaiM_flow.u) annotation (
      Line(points = {{122, -280}, {138, -280}}, color = {0, 0, 127}));
    connect(uCAVReh, mulMax.u[1:5]) annotation (
      Line(points = {{-360, 100}, {-4, 100}, {-4, -281.6}, {98, -281.6}}, color = {0, 0, 127}));
    connect(souTer.ports[1], jun18.port_1) annotation (
      Line(points = {{200, -280}, {260, -280}, {260, -230}, {320, -230}, {320, -90}}, color = {0, 127, 255}));
    connect(jun22.port_2, jun23.port_1) annotation (
      Line(points = {{480, 60}, {480, 30}}, color = {0, 127, 255}));
    connect(jun23.port_2, jun24.port_1) annotation (
      Line(points = {{480, 10}, {480, -40}}, color = {0, 127, 255}));
    connect(jun24.port_2, jun25.port_1) annotation (
      Line(points = {{480, -60}, {480, -80}}, color = {0, 127, 255}));
    connect(jun25.port_2, sinTer.ports[1]) annotation (
      Line(points = {{480, -100}, {480, -250}, {470, -250}, {470, -250}}, color = {0, 127, 255}));
    connect(jun18.port_2, jun19.port_1) annotation (
      Line(points = {{320, -70}, {320, -40}}, color = {0, 127, 255}));
    connect(jun19.port_2, jun20.port_1) annotation (
      Line(points = {{320, -20}, {320, 10}}, color = {0, 127, 255}));
    connect(jun20.port_2, jun21.port_1) annotation (
      Line(points = {{320, 30}, {320, 60}}, color = {0, 127, 255}));
    connect(pre1.y, truDel.u) annotation (
      Line(points = {{-312, 78}, {-300, 78}, {-300, 84}}, color = {255, 0, 255}));
    connect(senTem1.port_b, senRelHum.port_b) annotation (
      Line(points = {{-148, 160}, {-100, 160}}, color = {0, 127, 255}));
    connect(amb.ports[1], senTem1.port_a) annotation (
      Line(points={{-272,-31.48},{-202,-31.48},{-202,160},{-168,160}},    color = {0, 127, 255}));
    connect(cooCoi.port_a1, souCoo.ports[1]) annotation (
      Line(points = {{-110, -12}, {-100, -12}, {-100, -60}}, color = {0, 127, 255}));
    connect(eas.portAir_b, relativePressure.port_a) annotation (
      Line(points = {{240, 246}, {240, 44}, {-130, 44}}, color = {0, 127, 255}));
    connect(amb.ports[2], senMasFlo.port_a) annotation (
      Line(points={{-272,-33.24},{-272,-8},{-246,-8}},     color = {0, 127, 255}));
    connect(deltaT, gai2.u) annotation (
      Line(points = {{-360, -16}, {-336, -16}, {-336, -2}, {-324, -2}}, color = {0, 0, 127}));
    connect(jun21.port_2, corCAVTer.port_aHeaWat) annotation (
      Line(points = {{320, 80}, {320, 128}, {390, 128}}, color = {0, 127, 255}));
    connect(corCAVTer.port_bHeaWat, jun22.port_3) annotation (
      Line(points = {{390, 116}, {470, 116}, {470, 70}}, color = {0, 127, 255}));
    connect(jun20.port_3, wesCAVTer.port_aHeaWat) annotation (
      Line(points = {{330, 20}, {378, 20}, {378, 70}, {390, 70}}, color = {0, 127, 255}));
    connect(wesCAVTer.port_bHeaWat, jun23.port_3) annotation (
      Line(points = {{390, 58}, {470, 58}, {470, 20}}, color = {0, 127, 255}));
    connect(jun19.port_3, norCAVTer.port_aHeaWat) annotation (
      Line(points = {{330, -30}, {382, -30}, {382, 10}, {390, 10}}, color = {0, 127, 255}));
    connect(jun21.port_3, easCAVTer.port_aHeaWat) annotation (
      Line(points = {{330, 70}, {338, 70}, {338, -50}, {390, -50}}, color = {0, 127, 255}));
    connect(easCAVTer.port_bHeaWat, jun24.port_3) annotation (
      Line(points = {{390, -62}, {470, -62}, {470, -50}}, color = {0, 127, 255}));
    connect(jun18.port_3, souCAVTer.port_aHeaWat) annotation (
      Line(points = {{330, -80}, {342, -80}, {342, -110}, {390, -110}}, color = {0, 127, 255}));
    connect(souCAVTer.port_bHeaWat, jun25.port_3) annotation (
      Line(points = {{390, -122}, {378, -122}, {378, -144}, {460, -144}, {460, -90}, {470, -90}}, color = {0, 127, 255}));
    connect(norCAVTer.port_bHeaWat, jun22.port_1) annotation (
      Line(points = {{390, -2}, {458, -2}, {458, 80}, {480, 80}}, color = {0, 127, 255}));
    connect(senTem1.T, rAT) annotation (
      Line(points={{-158,171},{-114,171},{-114,172},{-68,172},{-68,-312},{470,
            -312},{470,-274},{600,-274}},                                                          color = {0, 0, 127}));
    connect(senRelHum1.port_b, heaCoi.port_a2) annotation (
      Line(points={{-178,12},{-174,12},{-174,-10}},      color = {0, 127, 255}));
    connect(cooCoi.port_b2, mov.port_a) annotation (
      Line(points = {{-110, 0}, {-74, 0}, {-74, -18}}, color = {0, 127, 255}));
    connect(mov.port_b, senTem.port_a) annotation (
      Line(points = {{-54, -18}, {-54, 0}, {-40, 0}}, color = {0, 127, 255}));
    connect(mov1.y_actual, hys.u) annotation (
      Line(points = {{67, -105}, {108, -105}, {108, -110}, {138, -110}}, color = {0, 0, 127}));
    connect(mov1.port_b, jun.port_1) annotation (
      Line(points = {{74, -106}, {100, -106}, {100, -50}}, color = {0, 127, 255}));
    connect(mov1.port_b, senRelPre.port_a) annotation (
      Line(points = {{74, -106}, {124, -106}, {124, -70}, {150, -70}}, color = {0, 127, 255}));
    connect(mov1.port_a, souCoo1.ports[1]) annotation (
      Line(points = {{74, -126}, {100, -126}, {100, -164}}, color = {0, 127, 255}));
    connect(pro.y, mov1.y) annotation (
      Line(points = {{-258, -130}, {36, -130}, {36, -116}, {62, -116}}, color = {0, 0, 127}));
    connect(weaBus.TDryBul, OutdoorAirTemp) annotation (Line(
        points={{-285.95,-15.95},{-258,-15.95},{-258,-60},{-244,-60},{-244,-224},
            {574,-224},{574,-232},{608,-232}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(senTem.port_b, senRelPre1.port_a) annotation (Line(points={{-20,0},{
            -36,0},{-36,16},{-50,16},{-50,22}}, color={0,127,255}));
    connect(gai2.y, mul.u1) annotation (Line(points={{-300,-2},{-288,-2},{-288,0},
            {-276,0},{-276,24},{-268,24}}, color={0,0,127}));
    connect(senMasFlo.m_flow, mul.u2) annotation (Line(points={{-236,3},{-254,3},
            {-254,0},{-272,0},{-272,12},{-268,12}}, color={0,0,127}));
    connect(pro1.y, mov.y)
      annotation (Line(points={{-276,30},{-64,30},{-64,-6}}, color={0,0,127}));
    connect(preHea.port, vol.heatPort) annotation (Line(points={{-230,44},{-220,
            44},{-220,46},{-196,46}}, color={191,0,0}));
    connect(relativePressure.p_rel, bldgSP) annotation (Line(points={{-121,54},{
            -100,54},{-100,50},{-82,50},{-82,-340},{530,-340},{530,-316},{600,
            -316}}, color={0,0,127}));
    connect(senRelPre1.port_b, amb.ports[3]) annotation (Line(points={{-50,42},
            {24,42},{24,88},{-102,88},{-102,38},{-144,38},{-144,-26},{-272,-26},
            {-272,-35}},   color={0,127,255}));
    connect(senRelHum1.phi, erwsuphum) annotation (Line(points={{-187.9,23},{
            -198,23},{-198,-254},{272,-254},{272,-194},{600,-194}},
                                                               color={0,0,127}));
    connect(relativePressure.port_b, amb.ports[4]) annotation (Line(points={{-130,64},
            {-142,64},{-142,62},{-148,62},{-148,-36.76},{-272,-36.76}},   color={
            0,127,255}));
    connect(truDel.y, exhFanSta) annotation (Line(points={{-276,84},{-122,84},{
            -122,80},{28,80},{28,-130},{306,-130},{306,-180},{510,-180},{510,-50},
            {600,-50}}, color={255,0,255}));
    connect(amb.ports[5], senRelHum1.port_a) annotation (Line(points={{-272,
            -38.52},{-220,-38.52},{-220,12},{-198,12}},
                                                      color={0,127,255}));
    connect(con.y, preHea.Q_flow) annotation (Line(points={{-266,50},{-258,50},
            {-258,44},{-250,44}}, color={0,0,127}));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -240}, {100, 240}}), graphics={  Text(textColor = {0, 0, 255}, extent = {{-140, 280}, {140, 240}}, textString = "%name"), Rectangle(origin = {-1, -5}, lineColor = {0, 0, 127}, fillColor = {255, 255, 255},
              fillPattern =                                                                                                                                                                                                        FillPattern.Solid, extent = {{-101, -247}, {101, 247}})}),
      Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-340, -320}, {580, 340}})));
  end TestBed_test2;

  package ChilledBeamSystem_ERW

    extends Modelica.Icons.ExamplesPackage;

    model ClosedLoopValidation
      extends Modelica.Icons.Example;
      parameter Real schTab[5, 2] = [0, 0; 8, 1; 18, 1; 21, 0; 24, 0] "Table defining schedule for enabling plant";
      Buildings.Chilled_Beam_Test.ChilledBeamSystem_ERW.BaseClasses.TestBed chiBeaTesBed(
        TChiWatRet_nominal=273.15 + 25,
        mChiWatTot_flow_nominal=2.114,
        mAirTot_flow_nominal=1*0.676*1.225,
        mHotWatCoi_nominal=0.078,
        mChiWatCoi_nominal=0.645,
        mCooAir_flow_nominal=1*0.676*1.225,
        mHeaAir_flow_nominal=1*0.676*1.225,
        THeaWatInl_nominal=313.15,
        THeaWatOut_nominal=298.15,
        THeaAirInl_nominal=285.85,
        THeaAirDis_nominal=308.15,
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
        annotation (Placement(visible=true, transformation(
            origin={-98,-26},
            extent={{88,-16},{108,32}},
            rotation=0)));
      Buildings.Controls.OBC.ChilledBeams.Terminal.Controller terCon[5](TdCoo = {0.1, 100, 0.1, 0.1, 0.1}, TiCoo = fill(50, 5), VDes_occ = {0.143, 0.065, 0.143, 0.065, 0.26}, VDes_unoccSch = {0.028, 0.012, 0.028, 0.012, 0.052}, VDes_unoccUnsch = {0.056, 0.024, 0.056, 0.024, 0.104}, controllerTypeCoo = fill(Buildings.Controls.OBC.CDL.Types.SimpleController.PID, 5)) "Terminal controllers" annotation (
        Placement(visible = true, transformation(origin={32,14},   extent = {{10, 40}, {30, 60}}, rotation = 0)));
      Buildings.Controls.OBC.ChilledBeams.System.Controller sysCon(nPum = 1, nVal = 5, minPumSpe = 0.7,
        maxPumSpe=1,                                                                                    TiPumSpe = 50,
        dPChiWatMax=1,                                                                                                 kBypVal = 10e-3, TiBypVal = 900,
        chiWatStaPreMax=1,
        chiWatStaPreMin=1,
        triAmoVal=0,
        resAmoVal=1,
        maxResVal=1,
        samPerVal=1,
        delTimVal=60)                                                                                                                                   annotation (
        Placement(visible = true, transformation(origin={112,-20},   extent = {{10, -70}, {30, -50}}, rotation = 0)));
      Buildings.Controls.OBC.FDE.DOAS.DOAScontroller DOAScon   annotation (
        Placement(visible = true, transformation(origin={-39,-10},  extent = {{-13, -24}, {13, 10}}, rotation = 0)));
      Buildings.Controls.OBC.CDL.Reals.MultiMax TZonMax(nin=5)   annotation (
        Placement(transformation(extent={{-40,52},{-20,72}})));
      Buildings.Controls.OBC.CDL.Reals.MultiMax yDamPosMax(nin=5)   annotation (
        Placement(transformation(extent={{-58,20},{-38,40}})));
      Buildings.Controls.OBC.CDL.Reals.Sources.TimeTable enaSch(final table = schTab, final smoothness = Buildings.Controls.OBC.CDL.Types.Smoothness.ConstantSegments, final timeScale = 3600) "Table defining when occupancy is expected" annotation (
        Placement(transformation(extent = {{-150, 70}, {-130, 90}})));
      Buildings.Controls.OBC.CDL.Reals.Hysteresis hys(uLow = 0.45, uHigh = 0.5) annotation (
        Placement(transformation(extent = {{-120, 70}, {-100, 90}})));
      Buildings.Controls.OBC.CDL.Routing.BooleanScalarReplicator booRep(nout = 5) annotation (
        Placement(transformation(extent = {{-90, 70}, {-70, 90}})));
      Buildings.Controls.OBC.CDL.Logical.Sources.Constant uConSig[5](k = fill(false, 5)) "Constant Boolean source" annotation (
        Placement(visible = true, transformation(origin={2,14},    extent = {{-90, 30}, {-70, 50}}, rotation = 0)));
      Buildings.Controls.OBC.CDL.Reals.Sources.Constant chiWatSupTem(k = 273.15 + 7.22) "Chilled water supply temperature" annotation (
        Placement(transformation(extent={{-148,-26},{-128,-6}})));
      Modelica.Blocks.Sources.CombiTimeTable loads(
        tableOnFile = true,
        tableName = "tab1",
        fileName=ModelicaServices.ExternalReferences.loadResource(
            "./Buildings/Resources/Data/Examples/ChilledBeamSystem/zoneLoads.txt"),
        columns = {2, 3, 4, 5, 6},
        timeScale = 60)
        "Table defining thermal loads for zone"
        annotation (Placement(transformation(extent={{-160,-60},{-140,-40}})));
      Buildings.Controls.SetPoints.OccupancySchedule occSch(occupancy = 3600*{8, 18}) annotation (
        Placement(visible = true, transformation(origin={-6,74},   extent = {{-152, -44}, {-132, -24}}, rotation = 0)));
      Buildings.Controls.OBC.CDL.Reals.Sources.TimeTable TSetRooHea(extrapolation = Buildings.Controls.OBC.CDL.Types.Extrapolation.Periodic, smoothness = Buildings.Controls.OBC.CDL.Types.Smoothness.ConstantSegments, table = [0, 15 + 273.15; 8*3600, 20 + 273.15; 18*3600, 15 + 273.15; 24*3600, 15 + 273.15]) annotation (
        Placement(visible = true, transformation(origin = {72, 64}, extent = {{-152, 40}, {-132, 60}}, rotation = 0)));
      Buildings.Controls.OBC.CDL.Reals.Sources.TimeTable TSetRooCoo(extrapolation = Buildings.Controls.OBC.CDL.Types.Extrapolation.Periodic, smoothness = Buildings.Controls.OBC.CDL.Types.Smoothness.ConstantSegments, table = [0, 30 + 273.15; 8*3600, 25 + 273.15; 18*3600, 30 + 273.15; 24*3600, 30 + 273.15]) annotation (
        Placement(visible = true, transformation(origin = {74, 122}, extent = {{-152, 10}, {-132, 30}}, rotation = 0)));
      Buildings.Controls.OBC.CDL.Routing.BooleanScalarReplicator booleanScalarReplicator(nout = 5) annotation (
        Placement(visible = true, transformation(origin={-36,-42},    extent = {{-90, 70}, {-70, 90}}, rotation = 0)));
      Buildings.Controls.OBC.CDL.Routing.RealScalarReplicator reaScaRep(nout = 5)  annotation (
        Placement(visible = true, transformation(origin = {-26, 98}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Buildings.Controls.OBC.CDL.Routing.RealScalarReplicator realScalarReplicator(nout = 5) annotation (
        Placement(visible = true, transformation(origin = {-30, 142}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(DOAScon.yFanSupSpe, chiBeaTesBed.uFanSpe) annotation (Line(points={{-23.14,
              -7.8},{-15.5,-7.8},{-15.5,-21.2},{-12.2,-21.2}},
                                                         color={0,0,127}));
      connect(enaSch.y[1], hys.u) annotation (
        Line(points = {{-128, 80}, {-122, 80}}, color = {0, 0, 127}));
      connect(hys.y, booRep.u) annotation (
        Line(points = {{-98, 80}, {-92, 80}}, color = {255, 0, 255}));
    //connect(booRep.y, terCon.uDetOcc) annotation(
    //Line(points = {{-68, 80}, {-4, 80}, {-4, 58}, {8, 58}}, color = {255, 0, 255}));
      connect(uConSig.y, terCon.uConSen) annotation (
        Line(points={{-66,54},{-66,48},{-4,48},{-4,62.75},{40,62.75}},      color = {255, 0, 255}));
      connect(hys.y,DOAScon.Occ)  annotation (
        Line(points={{-98,80},{-96,80},{-96,-0.4},{-54.6,-0.4}},color = {255, 0, 255}));
      connect(chiBeaTesBed.TZon, terCon.TZon) annotation (
        Line(points={{12,2.8},{20,2.8},{20,60.25},{40,60.25}},  color = {0, 0, 127}, thickness = 0.5));
      connect(booRep.y, terCon.uOccExp) annotation (
        Line(points={{-68,80},{-8,80},{-8,70.25},{40,70.25}},    color = {255, 0, 255}, thickness = 0.5));
      connect(TSetRooHea.y[1], reaScaRep.u) annotation (
        Line(points = {{-58, 114}, {-50, 114}, {-50, 98}, {-38, 98}}, color = {0, 0, 127}));
      connect(TSetRooCoo.y[1], realScalarReplicator.u) annotation (
        Line(points = {{-56, 142}, {-42, 142}}, color = {0, 0, 127}));
      connect(realScalarReplicator.y, terCon.TZonCooSet) annotation (
        Line(points={{-18,142},{8,142},{8,65.25},{40,65.25}},    color = {0, 0, 127}, thickness = 0.5));
      connect(chiBeaTesBed.VDisAir_flow, terCon.VDis_flow) annotation (
        Line(points={{12,0.2},{22,0.2},{22,57.75},{40,57.75}},color = {0, 0, 127}, thickness = 0.5));
      connect(occSch.occupied, booleanScalarReplicator.u) annotation (Line(points={
              {-137,34},{-134,34},{-134,38},{-128,38}}, color={255,0,255}));
      connect(booleanScalarReplicator.y, terCon.uOccDet) annotation (Line(points={{
              -104,38},{-102,38},{-102,12},{6,12},{6,72.75},{40,72.75}}, color={255,
              0,255}));
      connect(sysCon.yBypValPos, chiBeaTesBed.uBypValPos) annotation (Line(points={{144,-86},
              {148,-86},{148,16},{-20,16},{-20,0},{-12,0}},           color={0,0,
              127}));
      connect(chiBeaTesBed.uPumSpe, sysCon.yPumSpe) annotation (Line(points={{-12,-36},
              {-16,-36},{-16,-60},{156,-60},{156,-80},{144,-80}},      color={0,0,
              127}));
      connect(chiBeaTesBed.yChiWatVal, sysCon.uValPos) annotation (Line(points={{12,-6},
              {106,-6},{106,-86},{120,-86}},     color={0,0,127}));
      connect(chiBeaTesBed.dPChiWat, sysCon.dPChiWatLoo) annotation (Line(points={{12,-22},
              {58,-22},{58,-24},{102,-24},{102,-80},{120,-80}},         color={0,0,
              127}));
      connect(chiBeaTesBed.yPumSta, sysCon.uPumSta[1]) annotation (Line(points={{12,
              -25.2},{50,-25.2},{50,-30},{98,-30},{98,-74},{120,-74}}, color={255,0,
              255}));
      connect(yDamPosMax.y, DOAScon.uDamMaxOpe) annotation (Line(points={{-36,30},{
              -30,30},{-30,16},{-72,16},{-72,-2.8},{-54.6,-2.8}}, color={0,0,127}));
      connect(TZonMax.y, DOAScon.TAirHig) annotation (Line(points={{-18,62},{-16,62},
              {-16,34},{-26,34},{-26,18},{-80,18},{-80,-12.6},{-54.6,-12.6}}, color=
             {0,0,127}));
      connect(chiWatSupTem.y, chiBeaTesBed.TChiWatSup) annotation (Line(points={{-126,
              -16},{-86,-16},{-86,-39.1},{-12.1,-39.1}},      color={0,0,127}));
      connect(chiBeaTesBed.TDOASDis, DOAScon.TAirDisCoiCoo) annotation (Line(points={{12,-28},
              {22,-28},{22,-50},{-24,-50},{-24,-34},{-74,-34},{-74,-22.6},{
              -54.6,-22.6}},  color={0,0,127}));
      connect(chiBeaTesBed.dPDOASAir, DOAScon.dPAirDucSta) annotation (Line(points={{12,
              -12.8},{30,-12.8},{30,-10},{50,-10},{50,24},{-28,24},{-28,6},{-62,
              6},{-62,-7.6},{-54.6,-7.6}}, color={0,0,127}));
      connect(chiBeaTesBed.erwsuphum, DOAScon.phiAirEneRecWhe) annotation (Line(
            points={{12,-30.6},{16,-30.6},{16,-66},{-70,-66},{-70,-25.2},{-54.6,
              -25.2}},
            color={0,0,127}));
      connect(DOAScon.TAirSup, DOAScon.TAirDisCoiCoo) annotation (Line(points={{-54.6,
              -15.2},{-72,-15.2},{-72,-22.6},{-54.6,-22.6}}, color={0,0,127}));
      connect(chiBeaTesBed.rAT, DOAScon.TAirRet) annotation (Line(points={{11.8,
              -35.6},{36,-35.6},{36,-34},{46,-34},{46,-94},{-106,-94},{-106,
              -17.6},{-54.6,-17.6}},     color={0,0,127}));
      connect(DOAScon.TAirOut, chiBeaTesBed.OutdoorAirTemp) annotation (Line(points={{-54.6,
              -20.2},{-92,-20.2},{-92,-56},{-52,-56},{-52,-72},{-12,-72},{-12,
              -48},{18,-48},{18,-38.4},{12,-38.4}}, color={0,0,127}));
      connect(chiBeaTesBed.bldgSP, DOAScon.dPAirStaBui) annotation (Line(points={{12,
              -40.4},{12,-46},{-14,-46},{-14,-40},{-58,-40},{-58,-32.4},{-54.6,
              -32.4}},
            color={0,0,127}));
      connect(DOAScon.uFanSupPro, chiBeaTesBed.yFanSta) annotation (Line(points={{-54.6,
              -5.2},{-58,-5.2},{-58,8},{-16,8},{-16,20},{18,20},{18,-18.8},{12,
              -18.8}},
            color={255,0,255}));
      connect(chiBeaTesBed.exhFanSta, DOAScon.uFanExhPro) annotation (Line(points={{12,-16},
              {28,-16},{28,-54},{-22,-54},{-22,-44},{-62,-44},{-62,-30},{-54.6,
              -30}},                       color={255,0,255}));
      connect(TZonMax.u[1:5], chiBeaTesBed.TZon) annotation (Line(points={{-42,
              60.4},{-44,60.4},{-44,46},{16,46},{16,2.8},{12,2.8}},
                                                              color={0,0,127}));
      connect(yDamPosMax.u[1:5], chiBeaTesBed.yDamPos) annotation (Line(points={{-60,
              28.4},{-60,50},{-50,50},{-50,48},{26,48},{26,-9.8},{12,-9.8}},
            color={0,0,127}));
      connect(chiBeaTesBed.yChiWatVal, terCon.uChiVal) annotation (Line(points={{12,-6},
              {22,-6},{22,0},{36,0},{36,48},{38,48},{38,55.25},{40,55.25}},
            color={0,0,127}));
      connect(DOAScon.yCoiCoo, chiBeaTesBed.uCooCoi) annotation (Line(points={{-23.14,
              -11},{-18,-11},{-18,-28},{-12,-28}}, color={0,0,127}));
      connect(DOAScon.yCoiHea, chiBeaTesBed.uHeaCoi) annotation (Line(points={{-23.14,
              -14},{-18,-14},{-18,-24},{-12,-24}}, color={0,0,127}));
      connect(chiBeaTesBed.uPumSta, sysCon.yChiWatPum[1]) annotation (Line(points={{-12,-32},
              {-18,-32},{-18,-62},{76,-62},{76,-40},{144,-40},{144,-74}},
            color={255,0,255}));
      connect(chiBeaTesBed.uCAVReh, terCon.yReh) annotation (Line(points={{-12,-12},
              {-22,-12},{-22,42},{92,42},{92,69},{64,69}}, color={0,0,127}));
      connect(terCon.yChiVal, chiBeaTesBed.uChiWatVal) annotation (Line(points={{64,66.5},
              {76,66.5},{76,66},{84,66},{84,32},{-16,32},{-16,-4},{-12,-4}},
            color={0,0,127}));
      connect(terCon.yDam, chiBeaTesBed.uCAVDam) annotation (Line(points={{64,64},
              {72,64},{72,62},{78,62},{78,36},{-20,36},{-20,-8},{-12,-8}},color={0,
              0,127}));
      connect(loads.y, chiBeaTesBed.QFlo) annotation (Line(points={{-139,-50},{
              -14,-50},{-14,4},{-12,4}},
                                     color={0,0,127}));
      connect(DOAScon.yFanSup, chiBeaTesBed.uFanSta) annotation (Line(points={{-23.14,
              -4.6},{-17.57,-4.6},{-17.57,-16},{-12,-16}}, color={255,0,255}));
      connect(reaScaRep.y, terCon.TZonHeaSet) annotation (Line(points={{-14,98},{0,98},
              {0,68},{20,68},{20,67.75},{40,67.75}}, color={0,0,127}));
      connect(chiBeaTesBed.relHumDOASRet, DOAScon.phiAirRet) annotation (Line(
            points={{12,-33},{30,-33},{30,-52},{-76,-52},{-76,-10},{-54.6,-10}},
            color={0,0,127}));
      connect(DOAScon.yEneRecWheSpe, chiBeaTesBed.uEneRecWheSpe) annotation (
          Line(points={{-23.14,-23.2},{-17.57,-23.2},{-17.57,-18.6},{-12.2,
              -18.6}}, color={0,0,127}));
      connect(chiBeaTesBed.TEneWhe, DOAScon.TAirSupEneWhe) annotation (Line(
            points={{12,-42.6},{26,-42.6},{26,-46},{36,-46},{36,-60},{-66,-60},
              {-66,-27.6},{-54.6,-27.6}}, color={0,0,127}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}})),
        Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-160, -100}, {160, 100}})),
        experiment(StartTime = 16848000, StopTime = 16934400, Interval = 600, Tolerance = 1e-06, __Dymola_Algorithm = "Cvode"));
    end ClosedLoopValidation;

    package Data
      extends Modelica.Icons.RecordsPackage;
      record FanCurve "Fan data for chilled beam example model"
        extends Fluid.Movers.Data.Generic(
          speed_nominal=(2900*2*3.14)/60,
          etaHydMet=Buildings.Fluid.Movers.BaseClasses.Types.HydraulicEfficiencyMethod.Power_VolumeFlowRate,
          etaMotMet=Buildings.Fluid.Movers.BaseClasses.Types.MotorEfficiencyMethod.NotProvided,
          power(V_flow={0,0.676,1.352}, P={0,200,400}),
          pressure(V_flow={0,0.676,1.352}, dp={2000,1000,0}),
          motorCooledByFluid=true);
        annotation (
      defaultComponentPrefixes="parameter",
      defaultComponentName="per",
      Documentation(info="<html>
<p>Data from:<a href=\"http://productfinder.wilo.com/com/en/c0000002200012eb000020023/_0000001d000149e80001003a/product.html\"> http://productfinder.wilo.com/com/en/c0000002200012eb000020023/_0000001d000149e80001003a/product.html</a></p>
<p>See <a href=\"modelica://Buildings.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to6\">Buildings.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to6 </a>for more information about how the data is derived. </p>
</html>",         revisions="<html>
<ul>
<li>
June 01, 2017, by Iago Cupeiro:
<br/>
Changed data link to the English version
</li>
<li>
February 17, 2016, by Michael Wetter:<br/>
Updated parameter names for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/396\">#396</a>.
</li>
<li>
December 12, 2014, by Michael Wetter:<br/>
Added <code>defaultComponentPrefixes</code> and
<code>defaultComponentName</code> annotations.
</li>
<li>April 22, 2014
    by Filip Jorissen:<br/>
       Initial version
</li>
</ul>
</html>"));
      end FanCurve;

      record PumpCurve "Pump data for chilled beam example model"
        extends Fluid.Movers.Data.Generic(
          speed_nominal=2900,
          etaHydMet=Buildings.Fluid.Movers.BaseClasses.Types.HydraulicEfficiencyMethod.Power_VolumeFlowRate,
          etaMotMet=Buildings.Fluid.Movers.BaseClasses.Types.MotorEfficiencyMethod.NotProvided,
          power(V_flow={0,0.001514,0.003028}, P={0,200,400}),
          pressure(V_flow={0,0.001514,0.003028}, dp={60000,30000,0}),
          motorCooledByFluid=true);
        annotation (
      defaultComponentPrefixes="parameter",
      defaultComponentName="per",
      Documentation(info="<html>
<p>Data from:<a href=\"http://productfinder.wilo.com/com/en/c0000002200012eb000020023/_0000001d000149e80001003a/product.html\"> http://productfinder.wilo.com/com/en/c0000002200012eb000020023/_0000001d000149e80001003a/product.html</a></p>
<p>See <a href=\"modelica://Buildings.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to6\">Buildings.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to6 </a>for more information about how the data is derived. </p>
</html>",         revisions="<html>
<ul>
<li>
June 01, 2017, by Iago Cupeiro:
<br/>
Changed data link to the English version
</li>
<li>
February 17, 2016, by Michael Wetter:<br/>
Updated parameter names for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/396\">#396</a>.
</li>
<li>
December 12, 2014, by Michael Wetter:<br/>
Added <code>defaultComponentPrefixes</code> and
<code>defaultComponentName</code> annotations.
</li>
<li>April 22, 2014
    by Filip Jorissen:<br/>
       Initial version
</li>
</ul>
</html>"));
      end PumpCurve;
    end Data;

    package Validation

      extends Modelica.Icons.ExamplesPackage;

      block ZoneModel_simplified
        "Validation model for zone model"
        extends Modelica.Icons.Example;
        Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChilledBeamSystem.Testbed.ZoneModel_simplified
          zoneModel_simplified
          annotation (Placement(transformation(extent={{-10,20},{10,40}})));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end ZoneModel_simplified;
    end Validation;

    package BaseClasses
      extends Modelica.Icons.BasesPackage;

      block TestBed "Testbed consisting of a 5-zone building model paired with DOAS and chilled water supply system"
        replaceable package MediumA = Buildings.Media.Air "Medium model";
        replaceable package MediumW = Buildings.Media.Water "Medium model";
        parameter Real hRoo = 2.74 "Height of room";
        parameter Modelica.Units.SI.PressureDifference dpValve_nominal = 6000 "Nominal pressure drop of fully open valve, used if CvData=Buildings.Fluid.Types.CvTypes.OpPoint";
        parameter Modelica.Units.SI.PressureDifference dpFixed_nominal = 0 "Pressure drop of pipe and other resistances that are in series";
        parameter Real TChiWatSup_nominal = 273.15 + 15.56 "Nominal chilled water supply temperature into zone";
        parameter Real TChiWatRet_nominal = 273.15 + 19 "Nominal chilled water return temperature from zone";
        parameter Real mChiWatTot_flow_nominal = mChiWatSou_flow_nominal + mChiWatEas_flow_nominal + mChiWatNor_flow_nominal + mChiWatWes_flow_nominal + mChiWatCor_flow_nominal "Total nominal chilled water flow rate through all five zones";
        parameter Real mAirTot_flow_nominal = mAirSou_flow_nominal + mAirEas_flow_nominal + mAirNor_flow_nominal + mAirWes_flow_nominal + mAirCor_flow_nominal "Total nominal air flow rate through all five zones";
        parameter Real mHotWatCoi_nominal = 96 "Hot water mass flow rate through AHU heating coil";
        parameter Real mChiWatCoi_nominal = 96 "Chilled water mass flow rate through AHU cooling coil";
        parameter Real mHotWatReh_nominal = mAirTot_flow_nominal*1000*15/4200/10 "Hot water mass flow rate through CAV terminal reheat coils";

        // Cerrina Added Parameters
         parameter Modelica.Units.SI.MassFlowRate mCooAir_flow_nominal "Nominal air mass flow rate from cooling sizing calculations";
        parameter Modelica.Units.SI.MassFlowRate mHeaAir_flow_nominal "Nominal air mass flow rate from heating sizing calculations";
        final parameter Modelica.Units.SI.MassFlowRate mHeaWat_flow_nominal= QHea_flow_nominal/(cpWatLiq*(THeaWatInl_nominal - THeaWatOut_nominal)) "Nominal mass flow rate of hot water to reheat coil";
        parameter Modelica.Units.SI.Temperature THeaWatInl_nominal(start=55 + 273.15,
            displayUnit="degC") "Reheat coil nominal inlet water temperature";
        parameter Modelica.Units.SI.Temperature THeaWatOut_nominal(start=
              THeaWatInl_nominal - 10, displayUnit="degC")
          "Reheat coil nominal outlet water temperature";
        parameter Modelica.Units.SI.Temperature THeaAirInl_nominal(start=12 + 273.15,
            displayUnit="degC")
          "Inlet air nominal temperature into VAV box during heating";
        parameter Modelica.Units.SI.Temperature THeaAirDis_nominal(start=28 + 273.15,
            displayUnit="degC")
          "Discharge air temperature from VAV box during heating";
        parameter Modelica.Units.SI.HeatFlowRate QHea_flow_nominal=
            mHeaAir_flow_nominal * cpAir * (THeaAirDis_nominal-THeaAirInl_nominal)
          "Nominal heating heat flow rate";
        constant Modelica.Units.SI.SpecificHeatCapacity cpAir=Buildings.Utilities.Psychrometrics.Constants.cpAir
          "Air specific heat capacity";
        constant Modelica.Units.SI.SpecificHeatCapacity cpWatLiq=Buildings.Utilities.Psychrometrics.Constants.cpWatLiq
          "Water specific heat capacity";

        // South zone
        parameter Real QSou_flow_nominal = -100000 "Nominal heat flow into south zone" annotation (
          Dialog(group = "South zone"));
        parameter Real VRooSou = 500 "Volume of zone air in south zone" annotation (
          Dialog(group = "South zone"));
        parameter Real mChiWatSou_flow_nominal = 0.2 "Chilled water volume flow rate into zone" annotation (
          Dialog(group = "South zone"));
        parameter Real mAirSou_flow_nominal = 0.2 "Discharge air volume flow rate into zone" annotation (
          Dialog(group = "South zone"));
        parameter Real mAChiBeaSou_flow_nominal = 0.2 "Discharge air volume flow rate into zone" annotation (
          Dialog(group = "South zone"));
        // East zone
        parameter Real QEas_flow_nominal = -100000 "Nominal heat flow into east zone" annotation (
          Dialog(group = "East zone"));
        parameter Real VRooEas = 500 "Volume of zone air in east zone" annotation (
          Dialog(group = "East zone"));
        parameter Real mChiWatEas_flow_nominal = 0.2 "Chilled water volume flow rate into zone" annotation (
          Dialog(group = "East zone"));
        parameter Real mAirEas_flow_nominal = 0.2 "Discharge air volume flow rate into zone" annotation (
          Dialog(group = "East zone"));
        parameter Real mAChiBeaEas_flow_nominal = 0.2 "Discharge air volume flow rate into zone" annotation (
          Dialog(group = "East zone"));
        // North zone
        parameter Real QNor_flow_nominal = -100000 "Nominal heat flow into north zone" annotation (
          Dialog(group = "North zone"));
        parameter Real VRooNor = 500 "Volume of zone air in north zone" annotation (
          Dialog(group = "North zone"));
        parameter Real mChiWatNor_flow_nominal = 0.2 "Chilled water volume flow rate into zone" annotation (
          Dialog(group = "North zone"));
        parameter Real mAirNor_flow_nominal = 0.2 "Discharge air volume flow rate into zone" annotation (
          Dialog(group = "North zone"));
        parameter Real mAChiBeaNor_flow_nominal = 0.2 "Discharge air volume flow rate into zone" annotation (
          Dialog(group = "North zone"));
        // West zone
        parameter Real QWes_flow_nominal = -100000 "Nominal heat flow into west zone" annotation (
          Dialog(group = "West zone"));
        parameter Real VRooWes = 500 "Volume of zone air in west zone" annotation (
          Dialog(group = "West zone"));
        parameter Real mChiWatWes_flow_nominal = 0.2 "Chilled water volume flow rate into zone" annotation (
          Dialog(group = "West zone"));
        parameter Real mAirWes_flow_nominal = 0.2 "Discharge air volume flow rate into zone" annotation (
          Dialog(group = "West zone"));
        parameter Real mAChiBeaWes_flow_nominal = 0.2 "Discharge air volume flow rate into zone" annotation (
          Dialog(group = "West zone"));
        // Core zone
        parameter Real QCor_flow_nominal = -100000 "Nominal heat flow into core zone" annotation (
          Dialog(group = "Core zone"));
        parameter Real VRooCor = 500 "Volume of zone air in core zone" annotation (
          Dialog(group = "Core zone"));
        parameter Real mChiWatCor_flow_nominal = 0.2 "Chilled water volume flow rate into zone" annotation (
          Dialog(group = "Core zone"));
        parameter Real mAirCor_flow_nominal = 0.2 "Discharge air volume flow rate into zone" annotation (
          Dialog(group = "Core zone"));
        parameter Real mAChiBeaCor_flow_nominal = 0.2 "Discharge air volume flow rate into zone" annotation (
          Dialog(group = "Core zone"));
        parameter HeatTransfer.Data.OpaqueConstructions.Generic conExtWal(final nLay = 3, final material = {matWoo, matIns, matGyp}) "Exterior construction" annotation (
          Placement(transformation(extent = {{380, 312}, {400, 332}})));
        parameter HeatTransfer.Data.OpaqueConstructions.Generic conIntWal(final nLay = 1, final material = {matGyp2}) "Interior wall construction" annotation (
          Placement(transformation(extent = {{420, 312}, {440, 332}})));
        parameter HeatTransfer.Data.Solids.Plywood matWoo(final x = 0.01, final k = 0.11, final d = 544, final nStaRef = 1) "Wood for exterior construction" annotation (
          Placement(transformation(extent = {{452, 308}, {472, 328}})));
        parameter HeatTransfer.Data.Solids.Generic matIns(final x = 0.087, final k = 0.049, final c = 836.8, final d = 265, final nStaRef = 5) "Steelframe construction with insulation" annotation (
          Placement(transformation(extent = {{492, 308}, {512, 328}})));
        parameter HeatTransfer.Data.Solids.GypsumBoard matGyp(final x = 0.0127, final k = 0.16, final c = 830, final d = 784, final nStaRef = 2) "Gypsum board" annotation (
          Placement(transformation(extent = {{450, 280}, {470, 300}})));
        parameter HeatTransfer.Data.Solids.GypsumBoard matGyp2(final x = 0.025, final k = 0.16, final c = 830, final d = 784, final nStaRef = 2) "Gypsum board" annotation (
          Placement(transformation(extent = {{490, 280}, {510, 300}})));
        Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uPumSta "Pump enable signal" annotation (
          Placement(transformation(extent = {{-380, -130}, {-340, -90}}), iconTransformation(extent = {{-140, -160}, {-100, -120}})));
        Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uFanSta "Supply fan enable signal" annotation (
          Placement(transformation(extent={{-382,48},{-342,88}}),      iconTransformation(extent = {{-140, 0}, {-100, 40}})));
        Buildings.Controls.OBC.CDL.Interfaces.RealInput uFanSpe
          "Fan speed signal"                                                       annotation (
          Placement(transformation(extent={{-380,18},{-340,58}}),       iconTransformation(extent={{-142,
                  -52},{-102,-12}})));
        Buildings.Controls.OBC.CDL.Interfaces.RealInput uPumSpe "Pump speed signal" annotation (
          Placement(transformation(extent = {{-380, -160}, {-340, -120}}), iconTransformation(extent = {{-140, -200}, {-100, -160}})));
        Buildings.Controls.OBC.CDL.Interfaces.RealInput TChiWatSup "Chilled water supply temperature" annotation (
          Placement(visible = true, transformation(origin = {0, 0}, extent = {{-380, -200}, {-340, -160}}, rotation = 0), iconTransformation(origin = {-121, -211}, extent = {{-21, -21}, {21, 21}}, rotation = 0)));
        Buildings.Controls.OBC.CDL.Interfaces.RealInput uHeaCoi "Heating coil control signal" annotation (
          Placement(transformation(extent = {{-380, -70}, {-340, -30}}), iconTransformation(extent = {{-140, -80}, {-100, -40}})));
        Buildings.Controls.OBC.CDL.Interfaces.RealInput uCooCoi "AHU cooling coil control signal" annotation (
          Placement(transformation(extent = {{-380, -100}, {-340, -60}}), iconTransformation(extent = {{-140, -120}, {-100, -80}})));
        Buildings.Controls.OBC.CDL.Interfaces.RealInput uCAVDam[5] "CAV damper signal" annotation (
          Placement(transformation(extent = {{-380, 120}, {-340, 160}}), iconTransformation(extent = {{-140, 80}, {-100, 120}})));
        Buildings.Controls.OBC.CDL.Interfaces.RealInput uCAVReh[5] "CAV reheat signal" annotation (
          Placement(transformation(extent = {{-380, 80}, {-340, 120}}), iconTransformation(extent = {{-140, 40}, {-100, 80}})));
        Buildings.Controls.OBC.CDL.Interfaces.RealInput uBypValPos "Bypass valve position signal" annotation (
          Placement(transformation(extent = {{-380, 200}, {-340, 240}}), iconTransformation(extent = {{-140, 160}, {-100, 200}})));
        Buildings.Controls.OBC.CDL.Interfaces.RealInput uChiWatVal[5] "Chilled water valve position signal" annotation (
          Placement(transformation(extent = {{-380, 160}, {-340, 200}}), iconTransformation(extent = {{-140, 120}, {-100, 160}})));
        Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yPumSta "Pump proven on" annotation (
          Placement(visible = true, transformation(origin = {2, 30}, extent = {{580, -140}, {620, -100}}, rotation = 0), iconTransformation(origin={0,68},    extent = {{100, -160}, {140, -120}}, rotation = 0)));
        Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yFanSta "Supply fan proven on" annotation (
          Placement(visible = true, transformation(origin = {-2, 32}, extent = {{580, -70}, {620, -30}}, rotation = 0), iconTransformation(origin={0,52},   extent = {{100, -80}, {140, -40}}, rotation = 0)));
        Buildings.Controls.OBC.CDL.Interfaces.RealOutput dPChiWat "Measured chilled water differential presure" annotation (
          Placement(visible = true, transformation(origin = {-2, 20}, extent = {{580, -110}, {620, -70}}, rotation = 0), iconTransformation(origin={0,60},    extent = {{100, -120}, {140, -80}}, rotation = 0)));
        Buildings.Controls.OBC.CDL.Interfaces.RealOutput dPDOASAir "Measured airloop differential presure" annotation (
          Placement(visible = true, transformation(origin = {0, 36}, extent = {{580, -40}, {620, 0}}, rotation = 0), iconTransformation(origin={0,72},   extent = {{100, -40}, {140, 0}}, rotation = 0)));
        Buildings.Controls.OBC.CDL.Interfaces.RealOutput TDOASDis(final unit = "K", displayUnit = "K", final quantity = "ThermodynamicTemperature") "Measured DOAS discharge air temperature" annotation (
          Placement(visible = true, transformation(origin = {0, 28}, extent = {{580, -170}, {620, -130}}, rotation = 0), iconTransformation(origin={0,80},    extent = {{100, -200}, {140, -160}}, rotation = 0)));
        Buildings.Controls.OBC.CDL.Interfaces.RealOutput yChiWatVal[5] "Measured chilled water valve position" annotation (
          Placement(transformation(extent = {{580, 60}, {620, 100}}), iconTransformation(extent={{100,100},
                  {140,140}})));
        Buildings.Controls.OBC.CDL.Interfaces.RealOutput yBypValPos "Measured bypass valve position" annotation (
          Placement(transformation(extent = {{580, 100}, {620, 140}}), iconTransformation(extent={{100,130},
                  {140,170}})));
        Buildings.Controls.OBC.CDL.Interfaces.RealOutput yDamPos[5] "Measured CAV damper position" annotation (
          Placement(visible = true, transformation(origin = {2, 46}, extent = {{580, -10}, {620, 30}}, rotation = 0), iconTransformation(origin={0,62},   extent = {{100, 0}, {140, 40}}, rotation = 0)));
        Buildings.Controls.OBC.CDL.Interfaces.RealOutput relHumDOASRet "Measured DOAS return air relative humidity" annotation (
          Placement(visible = true, transformation(origin = {2, 28}, extent = {{580, -200}, {620, -160}}, rotation = 0), iconTransformation(origin={0,70},    extent = {{100, -240}, {140, -200}}, rotation = 0)));
        Buildings.Controls.OBC.CDL.Interfaces.RealOutput TZon[5] "Measured zone temperature" annotation (
          Placement(transformation(extent = {{580, 240}, {620, 280}}), iconTransformation(extent={{100,188},
                  {140,228}})));
        Buildings.Controls.OBC.CDL.Interfaces.RealOutput yRelHumZon[5] "Measured zone relative humidity" annotation (
          Placement(transformation(extent = {{580, 280}, {620, 320}}), iconTransformation(extent={{100,212},
                  {140,252}})));
        Buildings.Controls.OBC.CDL.Interfaces.RealOutput VDisAir_flow[5] "Measured zone discharge air volume flow rate" annotation (
          Placement(transformation(extent = {{580, 200}, {620, 240}}), iconTransformation(extent={{100,162},
                  {140,202}})));
        Buildings.Fluid.FixedResistances.Junction jun(redeclare package Medium
            =                                                                    MediumW, final m_flow_nominal = {mChiWatTot_flow_nominal, -mChiWatTot_flow_nominal, -mChiWatTot_flow_nominal}, final dp_nominal = {0, 0, 0}) "Chilled water splitter" annotation (
          Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {100, -40})));
        Buildings.Fluid.FixedResistances.Junction jun3(redeclare package Medium
            =                                                                     MediumW, final m_flow_nominal = {mChiWatTot_flow_nominal, -mChiWatTot_flow_nominal, mChiWatTot_flow_nominal}, final dp_nominal = {0, 0, 0}) "Chilled water mixer" annotation (
          Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin = {250, -40})));
        Buildings.Fluid.Actuators.Valves.TwoWayLinear val(redeclare package
            Medium =                                                                 MediumW, final m_flow_nominal = mChiWatSou_flow_nominal, final dpValve_nominal = dpValve_nominal, final dpFixed_nominal = dpFixed_nominal) "Chilled beam control valve for south zone" annotation (
          Placement(transformation(extent = {{120, -50}, {140, -30}})));
        Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(final filNam=
              ModelicaServices.ExternalReferences.loadResource(
              "./Buildings/Resources/weatherdata/USA_AZ_Phoenix-Sky.Harbor.Intl.AP.722780_TMY3.mos"))                                                                                                             "Weather data" annotation (
          Placement(visible = true, transformation(origin={-40,-12},    extent = {{-310, -20}, {-290, 0}}, rotation = 0)));
        Buildings.BoundaryConditions.WeatherData.Bus weaBus "Weather Data Bus" annotation (
          Placement(visible = true, transformation(origin = {-16, -6}, extent = {{-280, -20}, {-260, 0}}, rotation = 0), iconTransformation(origin = {0, 0}, extent = {{0, 0}, {0, 0}}, rotation = 0)));
        Buildings.Fluid.Sources.Outside amb(redeclare package Medium = MediumA, final nPorts=6)   "Ambient conditions" annotation (
          Placement(visible = true, transformation(origin={-62,-22},    extent = {{-250, -20}, {-228, 2}}, rotation = 0)));
        Buildings.Fluid.HeatExchangers.WetCoilCounterFlow cooCoi(final show_T = true, final UA_nominal = 3*mAirTot_flow_nominal*1000*15/Buildings.Fluid.HeatExchangers.BaseClasses.lmtd(T_a1 = 26.2, T_b1 = 12.8, T_a2 = 6, T_b2 = 16), redeclare
            package Medium1 =                                                                                                                                                                                                         MediumW, redeclare
            package Medium2 =                                                                                                                                                                                                         MediumA, final m1_flow_nominal = mAirTot_flow_nominal*1000*15/4200/10, final m2_flow_nominal = mAirTot_flow_nominal, final dp2_nominal = 0, final dp1_nominal = 0, final energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, final allowFlowReversal1 = true, final allowFlowReversal2 = true) "Cooling coil" annotation (
          Placement(transformation(extent = {{-110, 4}, {-130, -16}})));
        Buildings.Fluid.Sources.Boundary_pT sinHea(redeclare package Medium = MediumW, p = 100000, T = 318.15, nPorts = 1) "Sink for heating coil" annotation (
          Placement(visible = true, transformation(origin = {-212, -74}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        Buildings.Fluid.Sources.Boundary_pT sinCoo(redeclare package Medium = MediumW, final p = 100000, final T = 285.15, final nPorts = 1) "Sink for cooling coil" annotation (
          Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {-140, -70})));
        Buildings.Fluid.Sources.MassFlowSource_T souCoo(redeclare package
            Medium =                                                               MediumW, final T = 280.372, final nPorts = 1, final use_m_flow_in = true) "Source for cooling coil" annotation (
          Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {-100, -70})));
        Buildings.Fluid.Sources.MassFlowSource_T souHea(redeclare package
            Medium =                                                               MediumW, final T = 318.15, final use_m_flow_in = true, final nPorts = 1) "Source for heating coil" annotation (
          Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {-170, -70})));
        Buildings.Fluid.HeatExchangers.DryCoilEffectivenessNTU heaCoi(final show_T = true, redeclare
            package Medium1 =                                                                                          MediumW, redeclare
            package Medium2 =                                                                                                                               MediumA, final m1_flow_nominal = mAirTot_flow_nominal*1000*(10 - (-20))/4200/10, final m2_flow_nominal = mAirTot_flow_nominal, final configuration = Buildings.Fluid.Types.HeatExchangerConfiguration.CounterFlow, final Q_flow_nominal = mAirTot_flow_nominal*1006*(16.7 - 8.5), final dp1_nominal = 0, final dp2_nominal = 200 + 200 + 100 + 40, final allowFlowReversal1 = false, final allowFlowReversal2 = false, final T_a1_nominal = 318.15, final T_a2_nominal = 281.65) "Heating coil" annotation (
          Placement(visible = true, transformation(origin = {26, -10}, extent = {{-180, 4}, {-200, -16}}, rotation = 0)));
        Buildings.Examples.VAVReheat.BaseClasses.VAVReheatBox souCAVTer(redeclare
            package MediumA =                                                                       MediumA, redeclare
            package MediumW =                                                                                                            MediumW,
          mCooAir_flow_nominal=mCooAir_flow_nominal,
          mHeaAir_flow_nominal=mHeaAir_flow_nominal,                                                                                              final VRoo = VRooSou, final allowFlowReversal = false,
          THeaWatInl_nominal=THeaWatInl_nominal,
          THeaWatOut_nominal=THeaWatOut_nominal,
          THeaAirInl_nominal=THeaAirInl_nominal,
          THeaAirDis_nominal=THeaAirDis_nominal)                                                                                                                                                         "CAV terminal for south zone" annotation (
          Placement(transformation(extent = {{390, -130}, {430, -90}})));
        Buildings.Fluid.FixedResistances.Junction jun5(redeclare package Medium
            =                                                                     MediumA, final m_flow_nominal = {mAirTot_flow_nominal, -mAirTot_flow_nominal, mAirTot_flow_nominal}, final dp_nominal = {0, 0, 0}) "Return air mixer" annotation (
          Placement(transformation(extent = {{-40, 150}, {-20, 170}})));
        Buildings.Fluid.Sources.Boundary_pT sinCoo1(redeclare package Medium = MediumW, final p = 100000, final T = 297.04, final nPorts = 2) "Sink for chillede water" annotation (
          Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {250, -176})));
        Buildings.Fluid.Sources.Boundary_pT souCoo1(redeclare package Medium = MediumW, final p = 100000, final use_T_in = true, final T = 285.15, final nPorts = 1) "Source for chilled water to chilled beam manifolds" annotation (
          Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {100, -174})));
        Buildings.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package
            Medium =                                                                 MediumA, final m_flow_nominal = mAirTot_flow_nominal) "AHU discharge air temperature sensor" annotation (
          Placement(transformation(extent = {{-40, -10}, {-20, 10}})));
        Buildings.Fluid.Sensors.RelativePressure senRelPre(redeclare package
            Medium =                                                                  MediumW) "Differential pressure sensor between chilled water supply and return" annotation (
          Placement(transformation(extent = {{150, -80}, {170, -60}})));
        Buildings.Fluid.Sensors.RelativePressure senRelPre1(redeclare package
            Medium =                                                                   MediumA) "Differential pressure sensor between AHU discharge and outdoor air" annotation (
          Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin={-50,32})));
        Modelica.Blocks.Routing.DeMultiplex demux(final n = 5) "Demultiplexer for chilled water valve signals" annotation (
          Placement(transformation(extent={{42,-30},{62,-10}})));
        Buildings.Controls.OBC.CDL.Reals.Hysteresis hys(final uLow = 0.04, final uHigh = 0.05) "Block for generating pump proven on signal" annotation (
          Placement(transformation(extent = {{140, -120}, {160, -100}})));
        Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea "Convert pump enable signal to Real signal" annotation (
          Placement(transformation(extent = {{-320, -120}, {-300, -100}})));
        Buildings.Controls.OBC.CDL.Reals.Multiply pro "Find pump flow signal by multiplying enable signal with speed signal" annotation (
          Placement(transformation(extent = {{-280, -140}, {-260, -120}})));
        Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gai(final k = mHotWatCoi_nominal) "Multiply control signal by nominal flowrate" annotation (
          Placement(transformation(extent = {{-320, -60}, {-300, -40}})));
        Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gai1(final k = mChiWatCoi_nominal) "Multiply control signal by nominal flowrate" annotation (
          Placement(transformation(extent = {{-320, -90}, {-300, -70}})));
        Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea1 "Convert fan enable signal to Real signal" annotation (
          Placement(visible = true, transformation(origin={-8,10},    extent = {{-320, 30}, {-300, 50}}, rotation = 0)));
        Buildings.Controls.OBC.CDL.Reals.Multiply pro1 "Find fan flow signal by multiplying enable signal with speed signal" annotation (
          Placement(visible = true, transformation(origin={-18,10},   extent = {{-280, 10}, {-260, 30}}, rotation = 0)));
        Modelica.Blocks.Routing.Multiplex mux1(final n = 5) "Multiplexer for chilled water valve position measurements" annotation (
          Placement(transformation(extent = {{160, 70}, {180, 90}})));
        Modelica.Blocks.Routing.DeMultiplex demux1(final n = 5) "Demultiplexer for CAV terminal damper signals" annotation (
          Placement(transformation(extent = {{300, -260}, {320, -240}})));
        Modelica.Blocks.Routing.DeMultiplex demux2(n = 5) "Demultiplexer for CAV terminal reheat signals" annotation (
          Placement(transformation(extent = {{300, -300}, {320, -280}})));
        Modelica.Blocks.Routing.Multiplex mux3(n = 5) "Multiplexer for CAV terminal damper position measurements" annotation (
          Placement(transformation(extent = {{490, -20}, {510, 0}})));
        Buildings.Fluid.Sensors.RelativeHumidityTwoPort senRelHum(redeclare
            package Medium =                                                                 MediumA, m_flow_nominal = mAirTot_flow_nominal) "Relative humidity sensor" annotation (
          Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {-90, 160})));
        Buildings.Chilled_Beam_Test.ChilledBeamSystem_ERW.BaseClasses.ZoneModel_simplified
          nor(
          nConExt=0,
          nConExtWin=0,
          nConPar=0,
          nConBou=3,
          nSurBou=0,
          datConBou(
            layers={conIntWal,conIntWal,conIntWal},
            A={6.47,40.76,6.47}*hRoo,
            til={Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall}),

          redeclare package MediumA = MediumA,
          redeclare package MediumW = MediumW,
          Q_flow_nominal=QNor_flow_nominal,
          TRadSup_nominal=TChiWatSup_nominal,
          TRadRet_nominal=TChiWatRet_nominal,
          mRad_flow_nominal=mChiWatNor_flow_nominal,
          V=VRooNor,
          TAir_nominal=297.04,
          mA_flow_nominal=mAirNor_flow_nominal,
          mAChiBea_flow_nominal=mAChiBeaNor_flow_nominal) "North zone"
          annotation (Placement(transformation(extent={{180,300},{200,320}})));

        Buildings.Chilled_Beam_Test.ChilledBeamSystem_ERW.BaseClasses.ZoneModel_simplified
          wes(
          nConExt=0,
          nConExtWin=0,
          nConPar=0,
          nConBou=3,
          nSurBou=0,
          datConBou(
            layers={conIntWal,conIntWal,conIntWal},
            A={6.47,40.76,6.47}*hRoo,
            til={Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall}),

          redeclare package MediumA = MediumA,
          redeclare package MediumW = MediumW,
          Q_flow_nominal=QWes_flow_nominal,
          TRadSup_nominal=TChiWatSup_nominal,
          TRadRet_nominal=TChiWatRet_nominal,
          mRad_flow_nominal=mChiWatWes_flow_nominal,
          V=VRooWes,
          TAir_nominal=297.04,
          mA_flow_nominal=mAirWes_flow_nominal,
          mAChiBea_flow_nominal=mAChiBeaWes_flow_nominal) "West zone"
          annotation (Placement(transformation(extent={{120,240},{140,260}})));

        Buildings.Chilled_Beam_Test.ChilledBeamSystem_ERW.BaseClasses.ZoneModel_simplified
          cor(
          nConExt=0,
          nConExtWin=0,
          nConPar=0,
          nConBou=3,
          nSurBou=0,
          datConBou(
            layers={conIntWal,conIntWal,conIntWal},
            A={6.47,40.76,6.47}*hRoo,
            til={Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall}),

          redeclare package MediumA = MediumA,
          redeclare package MediumW = MediumW,
          Q_flow_nominal=QCor_flow_nominal,
          TRadSup_nominal=TChiWatSup_nominal,
          TRadRet_nominal=TChiWatRet_nominal,
          mRad_flow_nominal=mChiWatCor_flow_nominal,
          V=VRooCor,
          TAir_nominal=297.04,
          mA_flow_nominal=mAirCor_flow_nominal,
          mAChiBea_flow_nominal=mAChiBeaCor_flow_nominal) "Core zone"
          annotation (Placement(transformation(extent={{180,240},{200,260}})));

        Buildings.Chilled_Beam_Test.ChilledBeamSystem_ERW.BaseClasses.ZoneModel_simplified
          eas(
          nConExt=0,
          nConExtWin=0,
          nConPar=0,
          nConBou=3,
          nSurBou=0,
          datConBou(
            layers={conIntWal,conIntWal,conIntWal},
            A={6.47,40.76,6.47}*hRoo,
            til={Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall}),

          redeclare package MediumA = MediumA,
          redeclare package MediumW = MediumW,
          Q_flow_nominal=QEas_flow_nominal,
          TRadSup_nominal=TChiWatSup_nominal,
          TRadRet_nominal=TChiWatRet_nominal,
          mRad_flow_nominal=mChiWatEas_flow_nominal,
          V=VRooEas,
          TAir_nominal=297.04,
          mA_flow_nominal=mAirEas_flow_nominal,
          mAChiBea_flow_nominal=mAChiBeaEas_flow_nominal) "East zone"
          annotation (Placement(transformation(extent={{240,240},{260,260}})));

        Buildings.Chilled_Beam_Test.ChilledBeamSystem_ERW.BaseClasses.ZoneModel_simplified
          sou(
          nConExt=0,
          nConExtWin=0,
          nConPar=0,
          nConBou=3,
          nSurBou=0,
          datConBou(
            layers={conIntWal,conIntWal,conIntWal},
            A={6.47,40.76,6.47}*hRoo,
            til={Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall}),

          redeclare package MediumA = MediumA,
          redeclare package MediumW = MediumW,
          Q_flow_nominal=QSou_flow_nominal,
          TRadSup_nominal=TChiWatSup_nominal,
          TRadRet_nominal=TChiWatRet_nominal,
          mRad_flow_nominal=mChiWatSou_flow_nominal,
          V=VRooSou,
          TAir_nominal=297.04,
          mA_flow_nominal=mAirSou_flow_nominal,
          mAChiBea_flow_nominal=mAChiBeaSou_flow_nominal) "South zone"
          annotation (Placement(transformation(extent={{180,180},{200,200}})));

        Buildings.BoundaryConditions.WeatherData.Bus zonMeaBus "Zone measurements bus" annotation (
          Placement(visible = true, transformation(origin = {0, 0}, extent = {{204, 262}, {224, 282}}, rotation = 0), iconTransformation(origin = {0, 0}, extent = {{0, 0}, {0, 0}}, rotation = 0)));
        Modelica.Blocks.Routing.Multiplex5 multiplex5_1 "Multiplexer for zone temperature measurements" annotation (
          Placement(visible = true, transformation(origin = {0, 0}, extent = {{300, 250}, {320, 270}}, rotation = 0)));
        Modelica.Blocks.Routing.Multiplex5 multiplex5_2 "Multiplexer for zone relative humidity measurements" annotation (
          Placement(transformation(extent = {{300, 290}, {320, 310}})));
        Modelica.Blocks.Routing.Multiplex5 multiplex5_3 "Multiplexer for zone discharge air volume flowrate measurements" annotation (
          Placement(transformation(extent = {{300, 210}, {320, 230}})));
        Buildings.Fluid.FixedResistances.Junction jun6(redeclare package Medium
            =                                                                     MediumA, m_flow_nominal = {mAirTot_flow_nominal, -mAirTot_flow_nominal, mAirTot_flow_nominal}, dp_nominal = {0, 0, 0}) "Return air mixer" annotation (
          Placement(transformation(extent = {{-10, 150}, {10, 170}})));
        Buildings.Fluid.FixedResistances.Junction jun7(redeclare package Medium
            =                                                                     MediumA, m_flow_nominal = {mAirTot_flow_nominal, -mAirTot_flow_nominal, mAirTot_flow_nominal}, dp_nominal = {0, 0, 0}) "Return air mixer" annotation (
          Placement(transformation(extent = {{20, 150}, {40, 170}})));
        Buildings.Fluid.FixedResistances.Junction jun8(redeclare package Medium
            =                                                                     MediumA, m_flow_nominal = {mAirTot_flow_nominal, -mAirTot_flow_nominal, mAirTot_flow_nominal}, dp_nominal = {0, 0, 0}) "Return air mixer" annotation (
          Placement(transformation(extent = {{50, 150}, {70, 170}})));
        Fluid.FixedResistances.Junction jun1(redeclare package Medium = MediumW, m_flow_nominal = {mChiWatTot_flow_nominal, -mChiWatTot_flow_nominal, -mChiWatTot_flow_nominal}, dp_nominal = {0, 0, 0}) "Chilled water splitter" annotation (
          Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {100, 0})));
        Fluid.FixedResistances.Junction jun9(redeclare package Medium = MediumW, m_flow_nominal = {mChiWatTot_flow_nominal, -mChiWatTot_flow_nominal, -mChiWatTot_flow_nominal}, dp_nominal = {0, 0, 0}) "Chilled water splitter" annotation (
          Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {100, 40})));
        Fluid.FixedResistances.Junction jun10(redeclare package Medium = MediumW, m_flow_nominal = {mChiWatTot_flow_nominal, -mChiWatTot_flow_nominal, -mChiWatTot_flow_nominal}, dp_nominal = {0, 0, 0}) "Chilled water splitter" annotation (
          Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {100, 80})));
        Fluid.FixedResistances.Junction jun11(redeclare package Medium = MediumW, m_flow_nominal = {mChiWatTot_flow_nominal, -mChiWatTot_flow_nominal, -mChiWatTot_flow_nominal}, dp_nominal = {0, 0, 0}) "Chilled water splitter" annotation (
          Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {100, 120})));
        Fluid.Actuators.Valves.TwoWayLinear val1(redeclare package Medium = MediumW, m_flow_nominal = mChiWatEas_flow_nominal, dpValve_nominal = dpValve_nominal, dpFixed_nominal = dpFixed_nominal) "Chilled beam control valve for east zone" annotation (
          Placement(transformation(extent = {{120, -10}, {140, 10}})));
        Fluid.Actuators.Valves.TwoWayLinear val3(redeclare package Medium = MediumW, m_flow_nominal = mChiWatNor_flow_nominal, dpValve_nominal = dpValve_nominal, dpFixed_nominal = dpFixed_nominal) "Chilled beam control valve for north zone" annotation (
          Placement(transformation(extent = {{120, 30}, {140, 50}})));
        Fluid.Actuators.Valves.TwoWayLinear val4(redeclare package Medium = MediumW, m_flow_nominal = mChiWatWes_flow_nominal, dpValve_nominal = dpValve_nominal, dpFixed_nominal = dpFixed_nominal) "Chilled beam control valve for west zone" annotation (
          Placement(transformation(extent = {{120, 70}, {140, 90}})));
        Fluid.Actuators.Valves.TwoWayLinear val5(redeclare package Medium = MediumW, m_flow_nominal = mChiWatCor_flow_nominal, dpValve_nominal = dpValve_nominal, dpFixed_nominal = dpFixed_nominal) "Chilled beam control valve for core zone" annotation (
          Placement(transformation(extent = {{120, 110}, {140, 130}})));
        Fluid.Actuators.Valves.TwoWayLinear val2(redeclare package Medium = MediumW, m_flow_nominal = mChiWatTot_flow_nominal, dpValve_nominal = dpValve_nominal, dpFixed_nominal = dpFixed_nominal) "Chilled water bypass valve" annotation (
          Placement(transformation(extent = {{160, 130}, {180, 150}})));
        Fluid.FixedResistances.Junction jun2(redeclare package Medium = MediumW, m_flow_nominal = {mChiWatTot_flow_nominal, -mChiWatTot_flow_nominal, mChiWatTot_flow_nominal}, dp_nominal = {0, 0, 0}) "Chilled water mixer" annotation (
          Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin = {250, 0})));
        Fluid.FixedResistances.Junction jun12(redeclare package Medium = MediumW, m_flow_nominal = {mChiWatTot_flow_nominal, -mChiWatTot_flow_nominal, mChiWatTot_flow_nominal}, dp_nominal = {0, 0, 0}) "Chilled water mixer" annotation (
          Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin = {250, 40})));
        Fluid.FixedResistances.Junction jun13(redeclare package Medium = MediumW, m_flow_nominal = {mChiWatTot_flow_nominal, -mChiWatTot_flow_nominal, mChiWatTot_flow_nominal}, dp_nominal = {0, 0, 0}) "Chilled water mixer" annotation (
          Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin = {250, 80})));
        Fluid.FixedResistances.Junction jun14(redeclare package Medium = MediumW, m_flow_nominal = {mChiWatTot_flow_nominal, -mChiWatTot_flow_nominal, mChiWatTot_flow_nominal}, dp_nominal = {0, 0, 0}) "Chilled water mixer" annotation (
          Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin = {250, 120})));
        Fluid.FixedResistances.Junction jun4(redeclare package Medium = MediumA, m_flow_nominal = {mAirTot_flow_nominal, -mAirTot_flow_nominal, -mAirTot_flow_nominal}, dp_nominal = {0, 0, 0}) "Supply air splitter" annotation (
          Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {350, -130})));
        Buildings.Examples.VAVReheat.BaseClasses.VAVReheatBox easCAVTer(redeclare
            package MediumA =                                                                       MediumA, redeclare
            package MediumW =                                                                                                            MediumW,
          mCooAir_flow_nominal=mCooAir_flow_nominal,
          mHeaAir_flow_nominal=mHeaAir_flow_nominal,                                                                                              VRoo = VRooEas, allowFlowReversal = false,
          THeaWatInl_nominal=THeaWatInl_nominal,
          THeaWatOut_nominal=THeaWatOut_nominal,
          THeaAirInl_nominal=THeaAirInl_nominal,
          THeaAirDis_nominal=THeaAirDis_nominal)                                                                                                                                             "CAV terminal for east zone" annotation (
          Placement(transformation(extent = {{390, -70}, {430, -30}})));
        Fluid.FixedResistances.Junction jun15(redeclare package Medium = MediumA, m_flow_nominal = {mAirTot_flow_nominal, -mAirTot_flow_nominal, -mAirTot_flow_nominal}, dp_nominal = {0, 0, 0}) "Supply air splitter" annotation (
          Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {350, -70})));
        Buildings.Examples.VAVReheat.BaseClasses.VAVReheatBox norCAVTer(redeclare
            package MediumA =                                                                       MediumA, redeclare
            package MediumW =                                                                                                            MediumW,
          mCooAir_flow_nominal=mCooAir_flow_nominal,
          mHeaAir_flow_nominal=mHeaAir_flow_nominal,                                                                                              VRoo = VRooNor, allowFlowReversal = false,
          THeaWatInl_nominal=THeaWatInl_nominal,
          THeaWatOut_nominal=THeaWatOut_nominal,
          THeaAirInl_nominal=THeaAirInl_nominal,
          THeaAirDis_nominal=THeaAirDis_nominal)                                                                                                                                             "CAV terminal for north zone" annotation (
          Placement(transformation(extent = {{390, -10}, {430, 30}})));
        Fluid.FixedResistances.Junction jun16(redeclare package Medium = MediumA, m_flow_nominal = {mAirTot_flow_nominal, -mAirTot_flow_nominal, -mAirTot_flow_nominal}, dp_nominal = {0, 0, 0}) "Supply air splitter" annotation (
          Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {350, -10})));
        Buildings.Examples.VAVReheat.BaseClasses.VAVReheatBox wesCAVTer(redeclare
            package MediumA =                                                                       MediumA, redeclare
            package MediumW =                                                                                                            MediumW,
          mCooAir_flow_nominal=mCooAir_flow_nominal,
          mHeaAir_flow_nominal=mHeaAir_flow_nominal,                                                                                              VRoo = VRooWes, allowFlowReversal = false,
          THeaWatInl_nominal=THeaWatInl_nominal,
          THeaWatOut_nominal=THeaWatOut_nominal,
          THeaAirInl_nominal=THeaAirInl_nominal,
          THeaAirDis_nominal=THeaAirDis_nominal)                                                                                                                                             "CAV terminal for west zone" annotation (
          Placement(transformation(extent = {{390, 50}, {430, 90}})));
        Fluid.FixedResistances.Junction jun17(redeclare package Medium = MediumA, m_flow_nominal = {mAirTot_flow_nominal, -mAirTot_flow_nominal, -mAirTot_flow_nominal}, dp_nominal = {0, 0, 0}) "Supply air splitter" annotation (
          Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {350, 50})));
        Buildings.Examples.VAVReheat.BaseClasses.VAVReheatBox corCAVTer(redeclare
            package MediumA =                                                                       MediumA, redeclare
            package MediumW =                                                                                                            MediumW,
          mCooAir_flow_nominal=mCooAir_flow_nominal,
          mHeaAir_flow_nominal=mHeaAir_flow_nominal,                                                                                                                                                                                        VRoo = VRooCor, allowFlowReversal = false,
          THeaWatInl_nominal=THeaWatInl_nominal,
          THeaWatOut_nominal=THeaWatOut_nominal,
          THeaAirInl_nominal=THeaAirInl_nominal,
          THeaAirDis_nominal=THeaAirDis_nominal)                                                                                                                                                                                                         "CAV terminal for core zone" annotation (
          Placement(visible = true, transformation(origin = {0, -2}, extent = {{390, 110}, {430, 150}}, rotation = 0)));
        Modelica.Blocks.Routing.DeMultiplex demux3(n = 5) "Demultiplexer for zone heat gain signal" annotation (
          Placement(transformation(extent = {{80, 280}, {100, 300}})));
        Buildings.Controls.OBC.CDL.Interfaces.RealInput QFlo[5] "Heat flow rate into the zone" annotation (
          Placement(transformation(extent = {{-380, 270}, {-340, 310}}), iconTransformation(extent = {{-140, 200}, {-100, 240}})));
        Buildings.Controls.OBC.CDL.Logical.Pre pre1 "Logical pre block" annotation (
          Placement(visible = true, transformation(origin = {-14, 8}, extent = {{-320, 60}, {-300, 80}}, rotation = 0)));
        Fluid.FixedResistances.Junction jun18(redeclare package Medium = MediumW, m_flow_nominal = {mAirTot_flow_nominal, -mAirTot_flow_nominal, -mAirTot_flow_nominal}, dp_nominal = {0, 0, 0}) "Hot water splitter" annotation (
          Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {320, -80})));
        Fluid.FixedResistances.Junction jun22(redeclare package Medium = MediumW, m_flow_nominal = {mChiWatTot_flow_nominal, -mChiWatTot_flow_nominal, mChiWatTot_flow_nominal}, dp_nominal = {0, 0, 0}) "Hot water mixer" annotation (
          Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin = {480, 70})));
        Fluid.FixedResistances.Junction jun23(redeclare package Medium = MediumW, m_flow_nominal = {mChiWatTot_flow_nominal, -mChiWatTot_flow_nominal, mChiWatTot_flow_nominal}, dp_nominal = {0, 0, 0}) "Hot water mixer" annotation (
          Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin = {480, 20})));
        Buildings.Fluid.FixedResistances.Junction jun24(redeclare package
            Medium =                                                               MediumW, m_flow_nominal = {mChiWatTot_flow_nominal, -mChiWatTot_flow_nominal, mChiWatTot_flow_nominal}, dp_nominal = {0, 0, 0}) "Hot water mixer" annotation (
          Placement(visible = true, transformation(origin = {480, -50}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        Fluid.FixedResistances.Junction jun25(redeclare package Medium = MediumW, m_flow_nominal = {mChiWatTot_flow_nominal, -mChiWatTot_flow_nominal, mChiWatTot_flow_nominal}, dp_nominal = {0, 0, 0}) "Hot water mixer" annotation (
          Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin = {480, -90})));
        Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gaiM_flow(final k = mAirTot_flow_nominal*1000*15/4200/10) "Calculate hot water mass flowrate based on reheat signal" annotation (
          Placement(transformation(extent = {{140, -290}, {160, -270}})));
        Fluid.Sources.MassFlowSource_T souTer(redeclare package Medium = MediumW, nPorts = 1, use_m_flow_in = true, T = 323.15) "Hot water source for terminal boxes " annotation (
          Placement(transformation(extent = {{180, -290}, {200, -270}})));
        Buildings.Controls.OBC.CDL.Reals.MultiMax mulMax(nin = 5) "Find maximum reheat signal for generating hot water" annotation (
          Placement(transformation(extent = {{100, -290}, {120, -270}})));
        Fluid.Sources.Boundary_pT sinTer(redeclare package Medium = MediumW, p(displayUnit = "Pa") = 3E5, nPorts = 1) "Hot water sink for terminal boxes" annotation (
          Placement(transformation(extent = {{450, -260}, {470, -240}})));
        Fluid.FixedResistances.Junction jun19(redeclare package Medium = MediumW, m_flow_nominal = {mAirTot_flow_nominal, -mAirTot_flow_nominal, -mAirTot_flow_nominal}, dp_nominal = {0, 0, 0}) "Hot water splitter" annotation (
          Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {320, -30})));
        Fluid.FixedResistances.Junction jun20(redeclare package Medium = MediumW, m_flow_nominal = {mAirTot_flow_nominal, -mAirTot_flow_nominal, -mAirTot_flow_nominal}, dp_nominal = {0, 0, 0}) "Hot water splitter" annotation (
          Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {320, 20})));
        Fluid.FixedResistances.Junction jun21(redeclare package Medium = MediumW, m_flow_nominal = {mAirTot_flow_nominal, -mAirTot_flow_nominal, -mAirTot_flow_nominal}, dp_nominal = {0, 0, 0}) "Hot water splitter" annotation (
          Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {320, 70})));
        Buildings.Controls.OBC.CDL.Interfaces.RealOutput OutdoorAirTemp "Outdoor Air Dry Bulb Temperature" annotation (
          Placement(visible = true, transformation(origin={8,-52},    extent = {{580, -200}, {620, -160}}, rotation = 0), iconTransformation(origin={0,16},   extent = {{100, -240}, {140, -200}}, rotation = 0)));
        Buildings.Controls.OBC.CDL.Logical.TrueDelay truDel(delayTime = 10) annotation (
          Placement(visible = true, transformation(origin = {-288, 84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput exhFanSta "Exhaust Fan Proven on" annotation (
          Placement(visible = true, transformation(origin = {0, 0}, extent = {{580, -70}, {620, -30}}, rotation = 0), iconTransformation(origin={0,80},    extent = {{100, -80}, {140, -40}}, rotation = 0)));
        Fluid.Sensors.TemperatureTwoPort senTem1(redeclare package Medium = MediumA, m_flow_nominal = mAirTot_flow_nominal) annotation (
          Placement(visible = true, transformation(origin = {-158, 160}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Buildings.Fluid.Sensors.RelativePressure relativePressure(redeclare
            package Medium =                                                                 MediumA) annotation (
          Placement(visible = true, transformation(origin = {-130, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        Buildings.Controls.OBC.CDL.Interfaces.RealOutput bldgSP "Building Static Pressure SetPoint" annotation (
          Placement(visible = true, transformation(origin={4,-106},    extent = {{580, -200}, {620, -160}}, rotation = 0), iconTransformation(origin={-480,-44},    extent = {{580, -200}, {620, -160}}, rotation = 0)));
        Buildings.Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium
            =                                                                     MediumA) annotation (
          Placement(visible = true, transformation(origin={-296,6},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Buildings.Controls.OBC.CDL.Interfaces.RealOutput rAT annotation (
          Placement(visible = true, transformation(origin={2,-76},    extent = {{580, -200}, {620, -160}}, rotation = 0), iconTransformation(origin={-2,44},  extent = {{100, -240}, {140, -200}}, rotation = 0)));
        Buildings.Controls.OBC.CDL.Interfaces.RealOutput erwsuphum "ERW supply relative humidity sensor" annotation (
          Placement(visible = true, transformation(origin = {0, -14}, extent = {{580, -200}, {620, -160}}, rotation = 0), iconTransformation(origin={0,94},    extent = {{100, -240}, {140, -200}}, rotation = 0)));
        Buildings.Fluid.Sensors.RelativeHumidityTwoPort senRelHum1(redeclare
            package Medium =                                                                  MediumA,
            m_flow_nominal=mAirTot_flow_nominal)                                                       annotation (
          Placement(visible = true, transformation(origin={-186,16},   extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Buildings.Fluid.Movers.Preconfigured.SpeedControlled_y mov(redeclare
            package Medium =                                                                  MediumA, dp_nominal(displayUnit = "Pa") = 2000, m_flow_nominal = mAirTot_flow_nominal)  annotation (
          Placement(visible = true, transformation(origin = {-64, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Buildings.Fluid.Movers.Preconfigured.SpeedControlled_y mov1(redeclare
            package Medium =                                                                   MediumW, dp_nominal(displayUnit = "Pa") = 60000, m_flow_nominal = mChiWatTot_flow_nominal)  annotation (
          Placement(visible = true, transformation(origin = {74, -116}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        Controls.OBC.CDL.Interfaces.RealInput uEneRecWheSpe
          "Energy Recovery speed signal" annotation (Placement(transformation(
                extent={{-380,-10},{-340,30}}), iconTransformation(extent={{
                  -142,-26},{-102,14}})));
        Fluid.HeatExchangers.ThermalWheels.Sensible.SpeedControlled whe(
          redeclare package Medium1 = MediumA,
          redeclare package Medium2 = MediumA,
          m1_flow_nominal=mAirTot_flow_nominal,
          m2_flow_nominal=mAirTot_flow_nominal,
          P_nominal=100)
          annotation (Placement(transformation(extent={{-260,6},{-240,26}})));
        Fluid.Sensors.TemperatureTwoPort senTemEneWhe(redeclare package Medium
            = MediumA, m_flow_nominal=mAirTot_flow_nominal) annotation (
            Placement(visible=true, transformation(
              origin={-220,32},
              extent={{-10,-10},{10,10}},
              rotation=0)));
        Controls.OBC.CDL.Interfaces.RealOutput           TEneWhe
          "Temperature of air leaving the energy recovery wheel"                                    annotation (
          Placement(visible = true, transformation(origin={2,-130},    extent = {{580, -200}, {620, -160}}, rotation = 0), iconTransformation(origin={-480,-66},    extent = {{580, -200}, {620, -160}}, rotation = 0)));
      equation
        connect(jun.port_3, val.port_a) annotation (
          Line(points = {{110, -40}, {120, -40}}, color = {0, 127, 255}));
        connect(weaDat.weaBus, weaBus) annotation (
          Line(points={{-330,-22},{-330,-16},{-286,-16}},        color = {255, 204, 51}, thickness = 0.5));
        connect(weaBus, amb.weaBus) annotation (
          Line(points={{-286,-16},{-300,-16},{-300,-30.78},{-312,-30.78}},    color = {255, 204, 51}, thickness = 0.5));
        connect(cooCoi.port_b1, sinCoo.ports[1]) annotation (
          Line(points={{-130,-12},{-140,-12},{-140,-60}},        color = {28, 108, 200}, thickness = 0.5));
        connect(heaCoi.port_b2, cooCoi.port_a2) annotation (
          Line(points = {{-154, -10}, {-143, -10}, {-143, 0}, {-130, 0}}, color = {0, 127, 255}, thickness = 0.5));
        connect(souHea.ports[1], heaCoi.port_a1) annotation (
          Line(points = {{-170, -60}, {-170, -36}, {-154, -36}, {-154, -22}}, color = {28, 108, 200}, thickness = 0.5));
        connect(heaCoi.port_b1, sinHea.ports[1]) annotation (
          Line(points = {{-174, -22}, {-212, -22}, {-212, -64}}, color = {28, 108, 200}, thickness = 0.5));
        connect(jun3.port_2, sinCoo1.ports[1]) annotation (
          Line(points = {{250, -50}, {250, -166}, {248, -166}}, color = {0, 127, 255}));
        connect(senRelPre.port_b, sinCoo1.ports[2]) annotation (
          Line(points = {{170, -70}, {252, -70}, {252, -166}}, color = {0, 127, 255}));
        connect(uPumSta, booToRea.u) annotation (
          Line(points = {{-360, -110}, {-322, -110}}, color = {255, 0, 255}));
        connect(booToRea.y, pro.u1) annotation (
          Line(points = {{-298, -110}, {-290, -110}, {-290, -124}, {-282, -124}}, color = {0, 0, 127}));
        connect(uPumSpe, pro.u2) annotation (
          Line(points = {{-360, -140}, {-290, -140}, {-290, -136}, {-282, -136}}, color = {0, 0, 127}));
        connect(TChiWatSup, souCoo1.T_in) annotation (
          Line(points = {{-360, -180}, {80, -180}, {80, -194}, {96, -194}, {96, -186}}, color = {0, 0, 127}));
        connect(uCooCoi, gai1.u) annotation (
          Line(points = {{-360, -80}, {-322, -80}}, color = {0, 0, 127}));
        connect(gai1.y, souCoo.m_flow_in) annotation (
          Line(points = {{-298, -80}, {-270, -80}, {-270, -110}, {-108, -110}, {-108, -82}}, color = {0, 0, 127}));
        connect(uHeaCoi, gai.u) annotation (
          Line(points = {{-360, -50}, {-322, -50}}, color = {0, 0, 127}));
        connect(gai.y, souHea.m_flow_in) annotation (
          Line(points = {{-298, -50}, {-260, -50}, {-260, -92}, {-178, -92}, {-178, -82}}, color = {0, 0, 127}));
        connect(senTem.T, TDOASDis) annotation (
          Line(points = {{-30, 11}, {-30, 20}, {-10, 20}, {-10, -152}, {348, -152}, {348, -122}, {600, -122}}, color = {0, 0, 127}));
        connect(uFanSta, booToRea1.u) annotation (
          Line(points={{-362,68},{-341,68},{-341,50},{-330,50}},          color = {255, 0, 255}));
        connect(booToRea1.y, pro1.u1) annotation (
          Line(points={{-306,50},{-306,36},{-300,36}},                    color = {0, 0, 127}));
        connect(uFanSpe, pro1.u2) annotation (
          Line(points={{-360,38},{-330,38},{-330,24},{-300,24}},          color = {0, 0, 127}));
        connect(val.y_actual, mux1.u[1]) annotation (
          Line(points = {{135, -33}, {154, -33}, {154, 85.6}, {160, 85.6}}, color = {0, 0, 127}));
        connect(demux.y[1], val.y) annotation (
          Line(points={{62,-14.4},{130,-14.4},{130,-28}},        color = {0, 0, 127}));
        connect(senRelHum.port_a, jun5.port_1) annotation (
          Line(points = {{-80, 160}, {-40, 160}}, color = {0, 127, 255}));
        connect(senRelHum.phi, relHumDOASRet) annotation (
          Line(points = {{-90.1, 149}, {-90.1, -152}, {602, -152}}, color = {0, 0, 127}));
        connect(wes.port_a, sou.port_a) annotation (
          Line(points = {{130, 260}, {130, 270}, {170, 270}, {170, 230}, {190, 230}, {190, 200}}, color = {191, 0, 0}));
        connect(wes.port_a, nor.port_a) annotation (
          Line(points = {{130, 260}, {130, 270}, {170, 270}, {170, 330}, {190, 330}, {190, 320}}, color = {191, 0, 0}));
        connect(nor.port_a, eas.port_a) annotation (
          Line(points = {{190, 320}, {190, 330}, {250, 330}, {250, 260}}, color = {191, 0, 0}));
        connect(eas.port_a, sou.port_a) annotation (
          Line(points = {{250, 260}, {250, 264}, {210, 264}, {210, 230}, {190, 230}, {190, 200}}, color = {191, 0, 0}));
        connect(wes.port_a, cor.port_a) annotation (
          Line(points = {{130, 260}, {130, 270}, {190, 270}, {190, 260}}, color = {191, 0, 0}));
        connect(eas.port_a, cor.port_a) annotation (
          Line(points = {{250, 260}, {250, 264}, {190, 264}, {190, 260}}, color = {191, 0, 0}));
        connect(sou.yRelHumZon, zonMeaBus.yRelHumSou) annotation (
          Line(points = {{202, 198}, {214, 198}, {214, 272}}, color = {0, 0, 127}));
        connect(sou.TZon, zonMeaBus.TSou) annotation (
          Line(points = {{202, 194}, {214, 194}, {214, 272}}, color = {0, 0, 127}));
        connect(sou.VDisAir_flow, zonMeaBus.VAirSou) annotation (
          Line(points = {{202, 190}, {214, 190}, {214, 272}}, color = {0, 0, 127}));
        connect(wes.yRelHumZon, zonMeaBus.yRelHumWes) annotation (
          Line(points = {{142, 258}, {172, 258}, {172, 272}, {214, 272}}, color = {0, 0, 127}));
        connect(wes.TZon, zonMeaBus.TWes) annotation (
          Line(points = {{142, 254}, {172, 254}, {172, 272}, {214, 272}}, color = {0, 0, 127}));
        connect(wes.VDisAir_flow, zonMeaBus.VAirWes) annotation (
          Line(points = {{142, 250}, {172, 250}, {172, 272}, {214, 272}}, color = {0, 0, 127}));
        connect(nor.yRelHumZon, zonMeaBus.yRelHumNor) annotation (
          Line(points = {{202, 318}, {214, 318}, {214, 272}}, color = {0, 0, 127}));
        connect(nor.TZon, zonMeaBus.TNor) annotation (
          Line(points = {{202, 314}, {214, 314}, {214, 272}}, color = {0, 0, 127}));
        connect(nor.VDisAir_flow, zonMeaBus.VAirNor) annotation (
          Line(points = {{202, 310}, {214, 310}, {214, 272}}, color = {0, 0, 127}));
        connect(eas.yRelHumZon, zonMeaBus.yRelHumEas) annotation (
          Line(points = {{262, 258}, {268, 258}, {268, 272}, {214, 272}}, color = {0, 0, 127}));
        connect(eas.TZon, zonMeaBus.TEas) annotation (
          Line(points = {{262, 254}, {268, 254}, {268, 272}, {214, 272}}, color = {0, 0, 127}));
        connect(eas.VDisAir_flow, zonMeaBus.VAirEas) annotation (
          Line(points = {{262, 250}, {268, 250}, {268, 272}, {214, 272}}, color = {0, 0, 127}));
        connect(cor.yRelHumZon, zonMeaBus.yRelHumCor) annotation (
          Line(points = {{202, 258}, {214, 258}, {214, 272}}, color = {0, 0, 127}));
        connect(cor.TZon, zonMeaBus.TCor) annotation (
          Line(points = {{202, 254}, {214, 254}, {214, 272}}, color = {0, 0, 127}));
        connect(cor.VDisAir_flow, zonMeaBus.VAirCor) annotation (
          Line(points = {{202, 250}, {214, 250}, {214, 272}}, color = {0, 0, 127}));
        connect(multiplex5_1.y, TZon) annotation (
          Line(points = {{321, 260}, {600, 260}}, color = {0, 0, 127}));
        connect(multiplex5_1.u1[1], zonMeaBus.TSou) annotation (
          Line(points = {{298, 270}, {280, 270}, {280, 272}, {214, 272}}, color = {0, 0, 127}));
        connect(multiplex5_1.u2[1], zonMeaBus.TEas) annotation (
          Line(points = {{298, 265}, {280, 265}, {280, 272}, {214, 272}}, color = {0, 0, 127}));
        connect(multiplex5_1.u3[1], zonMeaBus.TNor) annotation (
          Line(points = {{298, 260}, {280, 260}, {280, 272}, {214, 272}}, color = {0, 0, 127}));
        connect(multiplex5_1.u4[1], zonMeaBus.TWes) annotation (
          Line(points = {{298, 255}, {280, 255}, {280, 272}, {214, 272}}, color = {0, 0, 127}));
        connect(multiplex5_1.u5[1], zonMeaBus.TCor) annotation (
          Line(points = {{298, 250}, {280, 250}, {280, 272}, {214, 272}}, color = {0, 0, 127}));
        connect(multiplex5_3.y, VDisAir_flow) annotation (
          Line(points = {{321, 220}, {600, 220}}, color = {0, 0, 127}));
        connect(multiplex5_2.y, yRelHumZon) annotation (
          Line(points = {{321, 300}, {600, 300}}, color = {0, 0, 127}));
        connect(multiplex5_2.u1[1], zonMeaBus.yRelHumSou) annotation (
          Line(points = {{298, 310}, {280, 310}, {280, 272}, {214, 272}}, color = {0, 0, 127}));
        connect(multiplex5_2.u2[1], zonMeaBus.yRelHumEas) annotation (
          Line(points = {{298, 305}, {280, 305}, {280, 272}, {214, 272}}, color = {0, 0, 127}));
        connect(multiplex5_2.u3[1], zonMeaBus.yRelHumNor) annotation (
          Line(points = {{298, 300}, {280, 300}, {280, 272}, {214, 272}}, color = {0, 0, 127}));
        connect(multiplex5_2.u4[1], zonMeaBus.yRelHumWes) annotation (
          Line(points = {{298, 295}, {280, 295}, {280, 272}, {214, 272}}, color = {0, 0, 127}));
        connect(multiplex5_2.u5[1], zonMeaBus.yRelHumCor) annotation (
          Line(points = {{298, 290}, {280, 290}, {280, 272}, {214, 272}}, color = {0, 0, 127}));
        connect(multiplex5_3.u1[1], zonMeaBus.VAirSou) annotation (
          Line(points = {{298, 230}, {280, 230}, {280, 272}, {214, 272}}, color = {0, 0, 127}));
        connect(multiplex5_3.u2[1], zonMeaBus.VAirEas) annotation (
          Line(points = {{298, 225}, {280, 225}, {280, 272}, {214, 272}}, color = {0, 0, 127}));
        connect(multiplex5_3.u3[1], zonMeaBus.VAirNor) annotation (
          Line(points = {{298, 220}, {280, 220}, {280, 272}, {214, 272}}, color = {0, 0, 127}));
        connect(multiplex5_3.u4[1], zonMeaBus.VAirWes) annotation (
          Line(points = {{298, 215}, {280, 215}, {280, 272}, {214, 272}}, color = {0, 0, 127}));
        connect(multiplex5_3.u5[1], zonMeaBus.VAirCor) annotation (
          Line(points = {{298, 210}, {280, 210}, {280, 272}, {214, 272}}, color = {0, 0, 127}));
        connect(jun5.port_2, jun6.port_1) annotation (
          Line(points = {{-20, 160}, {-10, 160}}, color = {0, 127, 255}));
        connect(jun6.port_2, jun7.port_1) annotation (
          Line(points = {{10, 160}, {20, 160}}, color = {0, 127, 255}));
        connect(jun7.port_2, jun8.port_1) annotation (
          Line(points = {{40, 160}, {50, 160}}, color = {0, 127, 255}));
        connect(sou.portAir_b, jun8.port_3) annotation (
          Line(points = {{180, 186}, {160, 186}, {160, 150}, {60, 150}}, color = {0, 127, 255}));
        connect(eas.portAir_b, jun8.port_2) annotation (
          Line(points = {{240, 246}, {230, 246}, {230, 210}, {140, 210}, {140, 160}, {70, 160}}, color = {0, 127, 255}));
        connect(nor.portAir_b, jun7.port_3) annotation (
          Line(points = {{180, 306}, {160, 306}, {160, 210}, {140, 210}, {140, 170}, {46, 170}, {46, 150}, {30, 150}}, color = {0, 127, 255}));
        connect(wes.portAir_b, jun6.port_3) annotation (
          Line(points = {{120, 246}, {112, 246}, {112, 170}, {14, 170}, {14, 150}, {0, 150}}, color = {0, 127, 255}));
        connect(cor.portAir_b, jun5.port_3) annotation (
          Line(points = {{180, 246}, {160, 246}, {160, 210}, {140, 210}, {140, 170}, {-14, 170}, {-14, 150}, {-30, 150}}, color = {0, 127, 255}));
        connect(jun.port_2, jun1.port_1) annotation (
          Line(points = {{100, -30}, {100, -10}}, color = {0, 127, 255}));
        connect(jun1.port_2, jun9.port_1) annotation (
          Line(points = {{100, 10}, {100, 30}}, color = {0, 127, 255}));
        connect(jun9.port_2, jun10.port_1) annotation (
          Line(points = {{100, 50}, {100, 70}}, color = {0, 127, 255}));
        connect(jun10.port_2, jun11.port_1) annotation (
          Line(points = {{100, 90}, {100, 110}}, color = {0, 127, 255}));
        connect(jun1.port_3, val1.port_a) annotation (
          Line(points = {{110, 0}, {120, 0}}, color = {0, 127, 255}));
        connect(jun9.port_3, val3.port_a) annotation (
          Line(points = {{110, 40}, {120, 40}}, color = {0, 127, 255}));
        connect(jun10.port_3, val4.port_a) annotation (
          Line(points = {{110, 80}, {120, 80}}, color = {0, 127, 255}));
        connect(jun11.port_3, val5.port_a) annotation (
          Line(points = {{110, 120}, {120, 120}}, color = {0, 127, 255}));
        connect(jun11.port_2, val2.port_a) annotation (
          Line(points = {{100, 130}, {100, 140}, {160, 140}}, color = {0, 127, 255}));
        connect(val2.port_b, jun14.port_1) annotation (
          Line(points = {{180, 140}, {250, 140}, {250, 130}}, color = {0, 127, 255}));
        connect(jun14.port_2, jun13.port_1) annotation (
          Line(points = {{250, 110}, {250, 90}}, color = {0, 127, 255}));
        connect(jun13.port_2, jun12.port_1) annotation (
          Line(points = {{250, 70}, {250, 50}}, color = {0, 127, 255}));
        connect(jun12.port_2, jun2.port_1) annotation (
          Line(points = {{250, 30}, {250, 10}}, color = {0, 127, 255}));
        connect(jun2.port_2, jun3.port_1) annotation (
          Line(points = {{250, -10}, {250, -30}}, color = {0, 127, 255}));
        connect(val.port_b, sou.portChiWat_a) annotation (
          Line(points = {{140, -40}, {150, -40}, {150, 170}, {186, 170}, {186, 180}}, color = {0, 127, 255}));
        connect(val1.port_b, eas.portChiWat_a) annotation (
          Line(points = {{140, 0}, {150, 0}, {150, 170}, {246, 170}, {246, 240}}, color = {0, 127, 255}));
        connect(val3.port_b, nor.portChiWat_a) annotation (
          Line(points = {{140, 40}, {150, 40}, {150, 170}, {224, 170}, {224, 290}, {186, 290}, {186, 300}}, color = {0, 127, 255}));
        connect(val4.port_b, wes.portChiWat_a) annotation (
          Line(points = {{140, 80}, {150, 80}, {150, 180}, {126, 180}, {126, 240}}, color = {0, 127, 255}));
        connect(val5.port_b, cor.portChiWat_a) annotation (
          Line(points = {{140, 120}, {150, 120}, {150, 220}, {186, 220}, {186, 240}}, color = {0, 127, 255}));
        connect(cor.portChiWat_b, jun14.port_3) annotation (
          Line(points = {{194, 240}, {194, 220}, {228, 220}, {228, 120}, {240, 120}}, color = {0, 127, 255}));
        connect(wes.portChiWat_b, jun13.port_3) annotation (
          Line(points = {{134, 240}, {134, 164}, {228, 164}, {228, 80}, {240, 80}}, color = {0, 127, 255}));
        connect(nor.portChiWat_b, jun12.port_3) annotation (
          Line(points = {{194, 300}, {194, 294}, {228, 294}, {228, 40}, {240, 40}}, color = {0, 127, 255}));
        connect(eas.portChiWat_b, jun2.port_3) annotation (
          Line(points = {{254, 240}, {254, 216}, {228, 216}, {228, 0}, {240, 0}}, color = {0, 127, 255}));
        connect(sou.portChiWat_b, jun3.port_3) annotation (
          Line(points = {{194, 180}, {194, 164}, {228, 164}, {228, -40}, {240, -40}}, color = {0, 127, 255}));
        connect(uChiWatVal, demux.u) annotation (
          Line(points={{-360,180},{-240,180},{-240,140},{0,140},{0,-20},{40,-20}},              color = {0, 0, 127}));
        connect(demux.y[2], val1.y) annotation (
          Line(points={{62,-17.2},{80,-17.2},{80,18},{130,18},{130,12}},            color = {0, 0, 127}));
        connect(demux.y[3], val3.y) annotation (
          Line(points={{62,-20},{80,-20},{80,60},{130,60},{130,52}},            color = {0, 0, 127}));
        connect(demux.y[4], val4.y) annotation (
          Line(points={{62,-22.8},{80,-22.8},{80,100},{130,100},{130,92}},            color = {0, 0, 127}));
        connect(demux.y[5], val5.y) annotation (
          Line(points={{62,-25.6},{80,-25.6},{80,138},{130,138},{130,132}},            color = {0, 0, 127}));
        connect(uBypValPos, val2.y) annotation (
          Line(points = {{-360, 220}, {100, 220}, {100, 158}, {170, 158}, {170, 152}}, color = {0, 0, 127}));
        connect(val1.y_actual, mux1.u[2]) annotation (
          Line(points = {{135, 7}, {154, 7}, {154, 82.8}, {160, 82.8}}, color = {0, 0, 127}));
        connect(val3.y_actual, mux1.u[3]) annotation (
          Line(points = {{135, 47}, {154, 47}, {154, 80}, {160, 80}}, color = {0, 0, 127}));
        connect(val4.y_actual, mux1.u[4]) annotation (
          Line(points = {{135, 87}, {154, 87}, {154, 77.2}, {160, 77.2}}, color = {0, 0, 127}));
        connect(val5.y_actual, mux1.u[5]) annotation (
          Line(points = {{135, 127}, {154, 127}, {154, 74.4}, {160, 74.4}}, color = {0, 0, 127}));
        connect(mux1.y, yChiWatVal) annotation (
          Line(points = {{181, 80}, {200, 80}, {200, -200}, {520, -200}, {520, 80}, {600, 80}}, color = {0, 0, 127}));
        connect(jun4.port_3, souCAVTer.port_aAir) annotation (
          Line(points = {{360, -130}, {410, -130}}, color = {0, 127, 255}));
        connect(jun15.port_3, easCAVTer.port_aAir) annotation (
          Line(points = {{360, -70}, {410, -70}}, color = {0, 127, 255}));
        connect(jun16.port_3, norCAVTer.port_aAir) annotation (
          Line(points = {{360, -10}, {410, -10}}, color = {0, 127, 255}));
        connect(jun17.port_3, wesCAVTer.port_aAir) annotation (
          Line(points = {{360, 50}, {410, 50}}, color = {0, 127, 255}));
        connect(senTem.port_b, jun4.port_1) annotation (
          Line(points = {{-20, 0}, {10, 0}, {10, -214}, {350, -214}, {350, -140}}, color = {0, 127, 255}));
        connect(jun4.port_2, jun15.port_1) annotation (
          Line(points = {{350, -120}, {350, -80}}, color = {0, 127, 255}));
        connect(jun15.port_2, jun16.port_1) annotation (
          Line(points = {{350, -60}, {350, -20}}, color = {0, 127, 255}));
        connect(jun16.port_2, jun17.port_1) annotation (
          Line(points = {{350, 0}, {350, 40}}, color = {0, 127, 255}));
        connect(jun17.port_2, corCAVTer.port_aAir) annotation (
          Line(points = {{350, 60}, {350, 108}, {410, 108}}, color = {0, 127, 255}));
        connect(demux1.y[1], souCAVTer.yVAV) annotation (
          Line(points = {{320, -244.4}, {374, -244.4}, {374, -94}, {386, -94}}, color = {0, 0, 127}));
        connect(demux1.y[2], easCAVTer.yVAV) annotation (
          Line(points = {{320, -247.2}, {374, -247.2}, {374, -34}, {386, -34}}, color = {0, 0, 127}));
        connect(demux1.y[3], norCAVTer.yVAV) annotation (
          Line(points = {{320, -250}, {374, -250}, {374, 26}, {386, 26}}, color = {0, 0, 127}));
        connect(demux1.y[4], wesCAVTer.yVAV) annotation (
          Line(points = {{320, -252.8}, {374, -252.8}, {374, 86}, {386, 86}}, color = {0, 0, 127}));
        connect(demux1.y[5], corCAVTer.yVAV) annotation (
          Line(points = {{320, -255.6}, {374, -255.6}, {374, 144}, {386, 144}}, color = {0, 0, 127}));
        connect(demux2.y[1], souCAVTer.yHea) annotation (
          Line(points = {{320, -284.4}, {368, -284.4}, {368, -104}, {386, -104}}, color = {0, 0, 127}));
        connect(demux2.y[2], easCAVTer.yHea) annotation (
          Line(points = {{320, -287.2}, {368, -287.2}, {368, -44}, {386, -44}}, color = {0, 0, 127}));
        connect(demux2.y[3], norCAVTer.yHea) annotation (
          Line(points = {{320, -290}, {368, -290}, {368, 16}, {386, 16}}, color = {0, 0, 127}));
        connect(demux2.y[4], wesCAVTer.yHea) annotation (
          Line(points = {{320, -292.8}, {368, -292.8}, {368, 76}, {386, 76}}, color = {0, 0, 127}));
        connect(demux2.y[5], corCAVTer.yHea) annotation (
          Line(points = {{320, -295.6}, {368, -295.6}, {368, 134}, {386, 134}}, color = {0, 0, 127}));
        connect(souCAVTer.y_actual, mux3.u[1]) annotation (
          Line(points = {{432, -110}, {450, -110}, {450, -4.4}, {490, -4.4}}, color = {0, 0, 127}));
        connect(easCAVTer.y_actual, mux3.u[2]) annotation (
          Line(points = {{432, -50}, {450, -50}, {450, -7.2}, {490, -7.2}}, color = {0, 0, 127}));
        connect(norCAVTer.y_actual, mux3.u[3]) annotation (
          Line(points = {{432, 10}, {450, 10}, {450, -10}, {490, -10}}, color = {0, 0, 127}));
        connect(wesCAVTer.y_actual, mux3.u[4]) annotation (
          Line(points = {{432, 70}, {450, 70}, {450, -12.8}, {490, -12.8}}, color = {0, 0, 127}));
        connect(corCAVTer.y_actual, mux3.u[5]) annotation (
          Line(points = {{432, 128}, {450, 128}, {450, -15.6}, {490, -15.6}}, color = {0, 0, 127}));
        connect(mux3.y, yDamPos) annotation (
          Line(points = {{511, -10}, {560, -10}, {560, 56}, {602, 56}}, color = {0, 0, 127}));
        connect(uCAVDam, demux1.u) annotation (
          Line(points = {{-360, 140}, {-250, 140}, {-250, 120}, {16, 120}, {16, -90}, {280, -90}, {280, -250}, {298, -250}}, color = {0, 0, 127}));
        connect(uCAVReh, demux2.u) annotation (
          Line(points = {{-360, 100}, {-4, 100}, {-4, -148}, {290, -148}, {290, -290}, {298, -290}}, color = {0, 0, 127}));
        connect(souCAVTer.port_bAir, sou.portAir_a) annotation (
          Line(points = {{410, -90}, {440, -90}, {440, 180}, {220, 180}, {220, 186}, {200, 186}}, color = {0, 127, 255}));
        connect(easCAVTer.port_bAir, eas.portAir_a) annotation (
          Line(points = {{410, -30}, {440, -30}, {440, 180}, {268, 180}, {268, 246}, {260, 246}}, color = {0, 127, 255}));
        connect(norCAVTer.port_bAir, nor.portAir_a) annotation (
          Line(points = {{410, 30}, {440, 30}, {440, 180}, {220, 180}, {220, 306}, {200, 306}}, color = {0, 127, 255}));
        connect(wesCAVTer.port_bAir, wes.portAir_a) annotation (
          Line(points = {{410, 90}, {440, 90}, {440, 180}, {220, 180}, {220, 224}, {146, 224}, {146, 246}, {140, 246}}, color = {0, 127, 255}));
        connect(corCAVTer.port_bAir, cor.portAir_a) annotation (
          Line(points = {{410, 148}, {440, 148}, {440, 180}, {220, 180}, {220, 224}, {206, 224}, {206, 246}, {200, 246}}, color = {0, 127, 255}));
        connect(val2.y_actual, yBypValPos) annotation (
          Line(points = {{175, 147}, {360, 147}, {360, 170}, {520, 170}, {520, 120}, {600, 120}}, color = {0, 0, 127}));
        connect(senRelPre1.p_rel, dPDOASAir) annotation (
          Line(points={{-41,32},{4,32},{4,-158},{540,-158},{540,16},{600,16}},              color = {0, 0, 127}));
        connect(hys.y, yPumSta) annotation (
          Line(points = {{162, -110}, {196, -110}, {196, -204}, {546, -204}, {546, -90}, {602, -90}}, color = {255, 0, 255}));
        connect(senRelPre.p_rel, dPChiWat) annotation (
          Line(points = {{160, -79}, {160, -84}, {186, -84}, {186, -212}, {560, -212}, {560, -70}, {598, -70}}, color = {0, 0, 127}));
        connect(QFlo, demux3.u) annotation (
          Line(points = {{-360, 290}, {78, 290}}, color = {0, 0, 127}));
        connect(demux3.y[1], sou.QFlo) annotation (
          Line(points = {{100, 295.6}, {106, 295.6}, {106, 194}, {178, 194}}, color = {0, 0, 127}));
        connect(demux3.y[2], eas.QFlo) annotation (
          Line(points = {{100, 292.8}, {180, 292.8}, {180, 280}, {234, 280}, {234, 254}, {238, 254}}, color = {0, 0, 127}));
        connect(demux3.y[3], nor.QFlo) annotation (
          Line(points = {{100, 290}, {106, 290}, {106, 314}, {178, 314}}, color = {0, 0, 127}));
        connect(demux3.y[4], wes.QFlo) annotation (
          Line(points = {{100, 287.2}, {106, 287.2}, {106, 254}, {118, 254}}, color = {0, 0, 127}));
        connect(demux3.y[5], cor.QFlo) annotation (
          Line(points = {{100, 284.4}, {106, 284.4}, {106, 234}, {176, 234}, {176, 254}, {178, 254}}, color = {0, 0, 127}));
        connect(val.y_actual, sou.uVal) annotation (
          Line(points = {{135, -33}, {154, -33}, {154, 190}, {178, 190}}, color = {0, 0, 127}));
        connect(val1.y_actual, eas.uVal) annotation (
          Line(points = {{135, 7}, {154, 7}, {154, 204}, {234, 204}, {234, 250}, {238, 250}}, color = {0, 0, 127}));
        connect(val3.y_actual, nor.uVal) annotation (
          Line(points = {{135, 47}, {154, 47}, {154, 310}, {178, 310}}, color = {0, 0, 127}));
        connect(val4.y_actual, wes.uVal) annotation (
          Line(points = {{135, 87}, {154, 87}, {154, 220}, {110, 220}, {110, 250}, {118, 250}}, color = {0, 0, 127}));
        connect(val5.y_actual, cor.uVal) annotation (
          Line(points = {{135, 127}, {154, 127}, {154, 248}, {174, 248}, {174, 250}, {178, 250}}, color = {0, 0, 127}));
        connect(uFanSta, pre1.u) annotation (
          Line(points={{-362,68},{-336,68},{-336,78}},        color = {255, 0, 255}));
        connect(pre1.y, yFanSta) annotation (
          Line(points={{-312,78},{-306,78},{-306,66},{-300,66},{-300,64},{-254,64},{
                -254,68},{-38,68},{-38,-174},{50,-174},{50,-208},{554,-208},{554,-18},
                {598,-18}},                                                                                                color = {255, 0, 255}));
        connect(souTer.m_flow_in, gaiM_flow.y) annotation (
          Line(points = {{178, -272}, {170, -272}, {170, -280}, {162, -280}}, color = {0, 0, 127}));
        connect(mulMax.y, gaiM_flow.u) annotation (
          Line(points = {{122, -280}, {138, -280}}, color = {0, 0, 127}));
        connect(uCAVReh, mulMax.u[1:5]) annotation (
          Line(points = {{-360, 100}, {-4, 100}, {-4, -281.6}, {98, -281.6}}, color = {0, 0, 127}));
        connect(souTer.ports[1], jun18.port_1) annotation (
          Line(points = {{200, -280}, {260, -280}, {260, -230}, {320, -230}, {320, -90}}, color = {0, 127, 255}));
        connect(jun22.port_2, jun23.port_1) annotation (
          Line(points = {{480, 60}, {480, 30}}, color = {0, 127, 255}));
        connect(jun23.port_2, jun24.port_1) annotation (
          Line(points = {{480, 10}, {480, -40}}, color = {0, 127, 255}));
        connect(jun24.port_2, jun25.port_1) annotation (
          Line(points = {{480, -60}, {480, -80}}, color = {0, 127, 255}));
        connect(jun25.port_2, sinTer.ports[1]) annotation (
          Line(points = {{480, -100}, {480, -250}, {470, -250}, {470, -250}}, color = {0, 127, 255}));
        connect(jun18.port_2, jun19.port_1) annotation (
          Line(points = {{320, -70}, {320, -40}}, color = {0, 127, 255}));
        connect(jun19.port_2, jun20.port_1) annotation (
          Line(points = {{320, -20}, {320, 10}}, color = {0, 127, 255}));
        connect(jun20.port_2, jun21.port_1) annotation (
          Line(points = {{320, 30}, {320, 60}}, color = {0, 127, 255}));
        connect(pre1.y, truDel.u) annotation (
          Line(points = {{-312, 78}, {-300, 78}, {-300, 84}}, color = {255, 0, 255}));
        connect(senTem1.port_b, senRelHum.port_b) annotation (
          Line(points = {{-148, 160}, {-100, 160}}, color = {0, 127, 255}));
        connect(cooCoi.port_a1, souCoo.ports[1]) annotation (
          Line(points = {{-110, -12}, {-100, -12}, {-100, -60}}, color = {0, 127, 255}));
        connect(eas.portAir_b, relativePressure.port_a) annotation (
          Line(points = {{240, 246}, {240, 44}, {-130, 44}}, color = {0, 127, 255}));
        connect(amb.ports[1], senMasFlo.port_a) annotation (
          Line(points={{-290,-27.3333},{-290,6},{-306,6}},     color = {0, 127, 255}));
        connect(jun21.port_2, corCAVTer.port_aHeaWat) annotation (
          Line(points = {{320, 80}, {320, 128}, {390, 128}}, color = {0, 127, 255}));
        connect(corCAVTer.port_bHeaWat, jun22.port_3) annotation (
          Line(points = {{390, 116}, {470, 116}, {470, 70}}, color = {0, 127, 255}));
        connect(jun20.port_3, wesCAVTer.port_aHeaWat) annotation (
          Line(points = {{330, 20}, {378, 20}, {378, 70}, {390, 70}}, color = {0, 127, 255}));
        connect(wesCAVTer.port_bHeaWat, jun23.port_3) annotation (
          Line(points = {{390, 58}, {470, 58}, {470, 20}}, color = {0, 127, 255}));
        connect(jun19.port_3, norCAVTer.port_aHeaWat) annotation (
          Line(points = {{330, -30}, {382, -30}, {382, 10}, {390, 10}}, color = {0, 127, 255}));
        connect(jun21.port_3, easCAVTer.port_aHeaWat) annotation (
          Line(points = {{330, 70}, {338, 70}, {338, -50}, {390, -50}}, color = {0, 127, 255}));
        connect(easCAVTer.port_bHeaWat, jun24.port_3) annotation (
          Line(points = {{390, -62}, {470, -62}, {470, -50}}, color = {0, 127, 255}));
        connect(jun18.port_3, souCAVTer.port_aHeaWat) annotation (
          Line(points = {{330, -80}, {342, -80}, {342, -110}, {390, -110}}, color = {0, 127, 255}));
        connect(souCAVTer.port_bHeaWat, jun25.port_3) annotation (
          Line(points = {{390, -122}, {378, -122}, {378, -144}, {460, -144}, {460, -90}, {470, -90}}, color = {0, 127, 255}));
        connect(norCAVTer.port_bHeaWat, jun22.port_1) annotation (
          Line(points = {{390, -2}, {458, -2}, {458, 80}, {480, 80}}, color = {0, 127, 255}));
        connect(senTem1.T, rAT) annotation (
          Line(points={{-158,171},{-114,171},{-114,172},{-68,172},{-68,-312},{
                470,-312},{470,-256},{602,-256}},                                                      color = {0, 0, 127}));
        connect(senRelHum1.port_b, heaCoi.port_a2) annotation (
          Line(points={{-176,16},{-174,16},{-174,-10}},      color = {0, 127, 255}));
        connect(cooCoi.port_b2, mov.port_a) annotation (
          Line(points = {{-110, 0}, {-74, 0}, {-74, -18}}, color = {0, 127, 255}));
        connect(mov.port_b, senTem.port_a) annotation (
          Line(points = {{-54, -18}, {-54, 0}, {-40, 0}}, color = {0, 127, 255}));
        connect(mov1.y_actual, hys.u) annotation (
          Line(points = {{67, -105}, {108, -105}, {108, -110}, {138, -110}}, color = {0, 0, 127}));
        connect(mov1.port_b, jun.port_1) annotation (
          Line(points = {{74, -106}, {100, -106}, {100, -50}}, color = {0, 127, 255}));
        connect(mov1.port_b, senRelPre.port_a) annotation (
          Line(points = {{74, -106}, {124, -106}, {124, -70}, {150, -70}}, color = {0, 127, 255}));
        connect(mov1.port_a, souCoo1.ports[1]) annotation (
          Line(points = {{74, -126}, {100, -126}, {100, -164}}, color = {0, 127, 255}));
        connect(pro.y, mov1.y) annotation (
          Line(points = {{-258, -130}, {36, -130}, {36, -116}, {62, -116}}, color = {0, 0, 127}));
        connect(weaBus.TDryBul, OutdoorAirTemp) annotation (Line(
            points={{-285.95,-15.95},{-258,-15.95},{-258,-60},{-244,-60},{-244,-224},
                {574,-224},{574,-232},{608,-232}},
            color={255,204,51},
            thickness=0.5), Text(
            string="%first",
            index=-1,
            extent={{-6,3},{-6,3}},
            horizontalAlignment=TextAlignment.Right));
        connect(senTem.port_b, senRelPre1.port_a) annotation (Line(points={{-20,0},{
                -36,0},{-36,16},{-50,16},{-50,22}}, color={0,127,255}));
        connect(pro1.y, mov.y)
          annotation (Line(points={{-276,30},{-64,30},{-64,-6}}, color={0,0,127}));
        connect(relativePressure.p_rel, bldgSP) annotation (Line(points={{-121,54},
                {-100,54},{-100,50},{-82,50},{-82,-340},{530,-340},{530,-286},{
                604,-286}},
                        color={0,0,127}));
        connect(senRelPre1.port_b, amb.ports[2]) annotation (Line(points={{-50,42},
                {24,42},{24,88},{-102,88},{-102,38},{-170,38},{-170,-28.8},{
                -290,-28.8}},  color={0,127,255}));
        connect(senRelHum1.phi, erwsuphum) annotation (Line(points={{-185.9,27},
                {-198,27},{-198,-254},{272,-254},{272,-194},{600,-194}},
                                                                   color={0,0,127}));
        connect(relativePressure.port_b, amb.ports[3]) annotation (Line(points={{-130,64},
                {-142,64},{-142,62},{-210,62},{-210,-30.2667},{-290,-30.2667}},
                                                                              color={
                0,127,255}));
        connect(truDel.y, exhFanSta) annotation (Line(points={{-276,84},{-122,84},{
                -122,80},{28,80},{28,-130},{306,-130},{306,-180},{510,-180},{510,-50},
                {600,-50}}, color={255,0,255}));
        connect(uEneRecWheSpe, whe.uSpe) annotation (Line(points={{-360,10},{
                -326,10},{-326,16},{-262,16}}, color={0,0,127}));
        connect(senMasFlo.port_b, whe.port_a1) annotation (Line(points={{-286,6},
                {-246,6},{-246,22},{-260,22}},      color={0,127,255}));
        connect(senTem1.port_a, whe.port_a2) annotation (Line(points={{-168,160},
                {-192,160},{-192,10},{-240,10}}, color={0,127,255}));
        connect(whe.port_b2, amb.ports[4]) annotation (Line(points={{-260,10},{
                -246,10},{-246,0},{-264,0},{-264,-31.7333},{-290,-31.7333}},
                                                                       color={0,
                127,255}));
        connect(whe.port_b1, senTemEneWhe.port_a) annotation (Line(points={{
                -240,22},{-236,22},{-236,32},{-230,32}}, color={0,127,255}));
        connect(senTemEneWhe.port_b, senRelHum1.port_a) annotation (Line(points=
               {{-210,32},{-204,32},{-204,16},{-196,16}}, color={0,127,255}));
        connect(bldgSP, bldgSP)
          annotation (Line(points={{604,-286},{604,-286}}, color={0,0,127}));
        connect(senTemEneWhe.T, TEneWhe) annotation (Line(points={{-220,43},{
                -184,43},{-184,-394},{556,-394},{556,-310},{602,-310}}, color={
                0,0,127}));
        annotation (
          Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -240}, {100, 240}}), graphics={  Text(textColor = {0, 0, 255}, extent = {{-140, 280}, {140, 240}}, textString = "%name"), Rectangle(origin = {-1, -5}, lineColor = {0, 0, 127}, fillColor = {255, 255, 255},
                  fillPattern =                                                                                                                                                                                                        FillPattern.Solid, extent = {{-101, -247}, {101, 247}})}),
          Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-340, -320}, {580, 340}})));
      end TestBed;

      package Validation

        block ZoneModel_simplified
          "Validation model for zone model"
          extends Modelica.Icons.Example;
          Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChilledBeamSystem.Testbed.ZoneModel_simplified
            zoneModel_simplified
            annotation (Placement(transformation(extent={{-10,20},{10,40}})));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end ZoneModel_simplified;
      annotation (Icon(graphics={
              Rectangle(
                lineColor={200,200,200},
                fillColor={248,248,248},
                fillPattern=FillPattern.HorizontalCylinder,
                extent={{-100,-100},{100,100}},
                radius=25.0),
              Rectangle(
                lineColor={128,128,128},
                extent={{-100,-100},{100,100}},
                radius=25.0),
              Polygon(
                origin={8,14},
                lineColor={78,138,73},
                fillColor={78,138,73},
                pattern=LinePattern.None,
                fillPattern=FillPattern.Solid,
                points={{-58.0,46.0},{42.0,-14.0},{-58.0,-74.0},{-58.0,46.0}})}));
      end Validation;

      block ZoneModel_simplified
        "Zone model containing components for zone mixed air volume, thermal capacitance and a chilled beam manifold with air circulation fan"
        extends Buildings.ThermalZones.Detailed.BaseClasses.ConstructionRecords;

        replaceable package MediumA =Buildings.Media.Air
          "Air medium model";

        replaceable package MediumW =Buildings.Media.Water
          "Water medium model";

        Buildings.Controls.OBC.CDL.Interfaces.RealInput QFlo "Power gained by zone"
          annotation (Placement(transformation(extent={{-240,-20},{-200,20}}),
              iconTransformation(extent={{-140,20},{-100,60}})));
        Buildings.Controls.OBC.CDL.Interfaces.RealOutput TZon(
          final unit="K",
          displayUnit="degC",
          final quantity="ThermodynamicTemperature") "Measured zone temperature"
          annotation (Placement(transformation(extent={{200,-20},{240,20}}),
              iconTransformation(extent={{100,20},{140,60}})));

        Buildings.Controls.OBC.CDL.Interfaces.RealOutput yRelHumZon(
          final unit="1",
          displayUnit="1")
          "Zone relative humidity"
          annotation (Placement(transformation(extent={{200,70},{240,110}}),
            iconTransformation(extent={{100,60},{140,100}})));

        Buildings.Controls.OBC.CDL.Interfaces.RealOutput VDisAir_flow "Discharge air volume flow rate"
          annotation (Placement(transformation(extent={{200,-100},{240,-60}}),
              iconTransformation(extent={{100,-20},{140,20}})));

        Buildings.Fluid.Sensors.Temperature zonTem(redeclare package Medium = MediumA)
          "Zone temperature sensor"
          annotation (Placement(transformation(extent={{160,-10},{180,10}})));

        Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heaCap(C=
              zonTheCap)
          "Heat capacity for furniture and walls"
          annotation (Placement(transformation(extent={{6,14},{26,34}})));

        Buildings.Fluid.MixingVolumes.MixingVolume vol(
          redeclare package Medium = MediumA,
          energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
          m_flow_nominal=mAChiBea_flow_nominal + mA_flow_nominal,
          V=1.2*V,
          nPorts=6) "Zone air volume"
                    annotation (Placement(transformation(extent={{6,-16},{26,4}})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHea
          "Prescribed heat flow"
          annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));

        parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal = 4359751.36
          "Nominal heat flow rate of radiator"
          annotation(dialog(group="Radiator parameters"));

        parameter Modelica.Units.SI.Temperature TRadSup_nominal = 273.15+70
          "Radiator nominal supply water temperature"
          annotation(dialog(group="Radiator parameters"));

        parameter Modelica.Units.SI.Temperature TRadRet_nominal = 273.15+50
          "Radiator nominal return water temperature"
          annotation(dialog(group="Radiator parameters"));

        parameter Modelica.Units.SI.MassFlowRate mRad_flow_nominal=0.000604*1000
          "Radiator nominal mass flow rate"
          annotation(dialog(group="Radiator parameters"));

        parameter Modelica.Units.SI.Volume V=1200
          "Room volume"
          annotation(dialog(group="Zone parameters"));

        parameter Real zonTheCap(
          final unit="J/K",
          displayUnit="J/K",
          final quantity="HeatCapacity") = 2*V*1.2*1500
          "Zone thermal capacitance"
          annotation(dialog(group="Zone parameters"));

        parameter Modelica.Units.SI.Temperature TAir_nominal=273.15 + 23.9
          "Air temperature at nominal condition"
          annotation(dialog(group="Zone parameters"));

        parameter Modelica.Units.SI.MassFlowRate mA_flow_nominal = V*1.2*6/3600
          "Nominal mass flow rate"
          annotation(dialog(group="Zone parameters"));

        parameter Modelica.Units.SI.MassFlowRate mAChiBea_flow_nominal = V*1.2*6/3600
          "Nominal mass flow rate"
          annotation(dialog(group="Zone parameters"));

        Modelica.Fluid.Interfaces.FluidPort_a portChiWat_a(redeclare package
            Medium =
              MediumW) "CHW inlet port" annotation (Placement(transformation(extent={{
                  -50,-210},{-30,-190}}), iconTransformation(extent={{-50,-110},{-30,-90}})));
        Modelica.Fluid.Interfaces.FluidPort_b portChiWat_b(redeclare package
            Medium =
              MediumW) "CHW outlet port" annotation (Placement(transformation(extent={
                  {30,-210},{50,-190}}), iconTransformation(extent={{30,-110},{50,-90}})));
        Modelica.Fluid.Interfaces.FluidPort_a portAir_a(redeclare package
            Medium =
              MediumA) "Air inlet port" annotation (Placement(transformation(extent={{
                  -210,-60},{-190,-40}}), iconTransformation(extent={{90,-50},{110,
                  -30}})));
        Modelica.Fluid.Interfaces.FluidPort_b portAir_b(redeclare package
            Medium =
              MediumA) "Air outlet port" annotation (Placement(transformation(extent={
                  {190,-60},{210,-40}}), iconTransformation(extent={{-110,-50},{-90,
                  -30}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
          annotation (Placement(transformation(extent={{-10,90},{10,110}})));
        Fluid.Sensors.RelativeHumidity senRelHum(redeclare package Medium = MediumA)
          annotation (Placement(transformation(extent={{80,80},{100,100}})));
        Fluid.Sensors.VolumeFlowRate senVolFlo(redeclare package Medium = MediumA,
            m_flow_nominal=mA_flow_nominal)
          annotation (Placement(transformation(extent={{-140,-60},{-120,-40}})));

        Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium = MediumW,
            m_flow_nominal=mRad_flow_nominal)
          annotation (Placement(transformation(extent={{-40,-160},{-20,-140}})));
        Fluid.Sensors.TemperatureTwoPort senTem1(redeclare package Medium = MediumW,
            m_flow_nominal=mRad_flow_nominal)
          annotation (Placement(transformation(extent={{20,-160},{40,-140}})));
        Fluid.HeatExchangers.ActiveBeams.Cooling actBea(
          redeclare package MediumWat = MediumW,
          redeclare package MediumAir = MediumA,
          redeclare
            Fluid.HeatExchangers.ActiveBeams.Data.Trox.DID632A_nozzleH_length6ft_cooling
            perCoo)
          annotation (Placement(transformation(extent={{-14,-168},{14,-144}})));
        Fluid.Movers.FlowControlled_m_flow fan(
          redeclare package Medium = MediumA,
          m_flow_nominal=mAChiBea_flow_nominal,
          redeclare Fluid.Movers.Data.Generic per,
          addPowerToMedium=false,
          dp_nominal=5000)
          annotation (Placement(transformation(extent={{-20,-110},{0,-90}})));
        Buildings.Controls.OBC.CDL.Interfaces.RealInput uVal "Chilled water valve signal" annotation (
            Placement(transformation(extent={{-240,-100},{-200,-60}}),
              iconTransformation(extent={{-140,-20},{-100,20}})));
        Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gai(k=mA_flow_nominal) "Gain"
          annotation (Placement(transformation(extent={{-180,-90},{-160,-70}})));
        ThermalZones.Detailed.Constructions.Construction conBou[nConBou](
          A=datConBou.A,
          til=datConBou.til,
          final layers=datConBou.layers,
          steadyStateInitial=datConBou.steadyStateInitial,
          T_a_start=datConBou.T_a_start,
          T_b_start=datConBou.T_b_start,
          final stateAtSurface_a=datConBou.stateAtSurface_a,
          final stateAtSurface_b=datConBou.stateAtSurface_b) if   haveConBou
          "Heat conduction through opaque constructions that have the boundary conditions of the other side exposed"
          annotation (Placement(transformation(extent={{-6,34},{-46,74}})));
        parameter ThermalZones.Detailed.BaseClasses.ParameterConstruction           datConBou[nConBou](
          each A=0,
          each layers=dummyCon,
          each til=0,
          each azi=0) "Data for construction boundary"
          annotation (Placement(transformation(extent={{-180,160},{-160,180}})),  HideResult=true);
      equation
        connect(zonTem.T, TZon)
          annotation (Line(points={{177,0},{220,0}}, color={0,0,127}));
        connect(vol.ports[1], zonTem.port) annotation (Line(points={{12.6667,-16},{
                12.6667,-20},{170,-20},{170,-10}},
                                      color={0,127,255}));
        connect(QFlo, preHea.Q_flow)
          annotation (Line(points={{-220,0},{-100,0}}, color={0,0,127}));
        connect(heaCap.port, vol.heatPort)
          annotation (Line(points={{16,14},{0,14},{0,-6},{6,-6}}, color={191,0,0}));
        connect(preHea.port, vol.heatPort)
          annotation (Line(points={{-80,0},{0,0},{0,-6},{6,-6}}, color={191,0,0}));
        connect(portAir_b, vol.ports[2])
          annotation (Line(points={{200,-50},{14,-50},{14,-16}}, color={0,127,255}));
        connect(senRelHum.port, vol.ports[3])
          annotation (Line(points={{90,80},{90,-16},{15.3333,-16}},
                                                               color={0,127,255}));
        connect(portAir_a, senVolFlo.port_a)
          annotation (Line(points={{-200,-50},{-140,-50}}, color={0,127,255}));
        connect(senVolFlo.port_b, vol.ports[4]) annotation (Line(points={{-120,-50},{
                16.6667,-50},{16.6667,-16}},
                                color={0,127,255}));
        connect(senRelHum.phi, yRelHumZon) annotation (Line(points={{101,90},{220,90}},
                                    color={0,0,127}));
        connect(senVolFlo.V_flow, VDisAir_flow) annotation (Line(points={{-130,-39},{
                -130,-20},{-6,-20},{-6,-80},{220,-80}},
                                                     color={0,0,127}));
        connect(portChiWat_a, senTem.port_a)
          annotation (Line(points={{-40,-200},{-40,-150}}, color={0,127,255}));
        connect(senTem1.port_b, portChiWat_b)
          annotation (Line(points={{40,-150},{40,-200}}, color={0,127,255}));
        connect(senTem.port_b, actBea.watCoo_a)
          annotation (Line(points={{-20,-150},{-14,-150}}, color={0,127,255}));
        connect(actBea.watCoo_b, senTem1.port_a)
          annotation (Line(points={{14,-150},{20,-150}}, color={0,127,255}));
        connect(uVal, gai.u)
          annotation (Line(points={{-220,-80},{-182,-80}},   color={0,0,127}));
        connect(gai.y, fan.m_flow_in) annotation (Line(points={{-158,-80},{-10,-80},{
                -10,-88}},   color={0,0,127}));
        connect(actBea.air_a, vol.ports[5]) annotation (Line(points={{14,-162},{60,-162},
                {60,-40},{18,-40},{18,-16}},     color={0,127,255}));
        connect(fan.port_a, actBea.air_b) annotation (Line(points={{-20,-100},{-36,
                -100},{-36,-162},{-14,-162}},
                                        color={0,127,255}));
        connect(fan.port_b, vol.ports[6]) annotation (Line(points={{0,-100},{19.3333,
                -100},{19.3333,-16}},                     color={0,127,255}));
        connect(actBea.heaPor, vol.heatPort) annotation (Line(points={{0,-168},{0,-180},
                {80,-180},{80,-30},{0,-30},{0,-6},{6,-6}}, color={191,0,0}));
        connect(vol.heatPort, conBou[1].opa_a) annotation (Line(points={{6,-6},{-10,
                -6},{-10,67.3333},{-6,67.3333}}, color={191,0,0}));
        connect(conBou[1].opa_b, port_a) annotation (Line(points={{-46.1333,67.3333},
                {-46.1333,84},{0,84},{0,100}}, color={191,0,0}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                  {100,100}}), graphics={          Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,0},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-120,20},{120,-20}},
                textString="%name",
                lineColor={0,0,255})}),
                                Diagram(coordinateSystem(preserveAspectRatio=false,
                extent={{-200,-200},{200,200}})),
          experiment(
            StartTime=6393600,
            StopTime=6566400,
            Interval=60,
            Tolerance=1e-06,
            __Dymola_Algorithm="Cvode"));
      end ZoneModel_simplified;
    end BaseClasses;
  end ChilledBeamSystem_ERW;
  annotation ();
end Chilled_Beam_Test;
