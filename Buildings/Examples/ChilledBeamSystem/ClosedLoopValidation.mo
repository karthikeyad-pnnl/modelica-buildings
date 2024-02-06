within Buildings.Examples.ChilledBeamSystem;

model ClosedLoopValidation
  extends Modelica.Icons.Example;
  parameter Real schTab[5, 2] = [0, 0; 8, 1; 18, 1; 21, 0; 24, 0] "Table defining schedule for enabling plant";
  Buildings.Examples.ChilledBeamSystem.BaseClasses.TestBed chiBeaTesBed(TChiWatRet_nominal = 273.15 + 25, mChiWatTot_flow_nominal = 2.114, mAirTot_flow_nominal = 1*0.676*1.225, mHotWatCoi_nominal = 0.078, mChiWatCoi_nominal = 0.645, VRooSou = 239.25, mChiWatSou_flow_nominal = 0.387, mAirSou_flow_nominal = 1*0.143*1.225, mAChiBeaSou_flow_nominal = 0.143*1.225, VRooEas = 103.31, mChiWatEas_flow_nominal = 0.9, mAirEas_flow_nominal = 1*0.065*1.225, mAChiBeaEas_flow_nominal = 1*0.065*1.225, VRooNor = 239.25, mChiWatNor_flow_nominal = 0.253, mAirNor_flow_nominal = 1*0.143*1.225, mAChiBeaNor_flow_nominal = 0.143*1.225, VRooWes = 103.31, mChiWatWes_flow_nominal = 0.262, mAirWes_flow_nominal = 1*0.065*1.225, mAChiBeaWes_flow_nominal = 0.065*1.225, VRooCor = 447.68, mChiWatCor_flow_nominal = 0.27, mAirCor_flow_nominal = 1*0.26*1.225, mAChiBeaCor_flow_nominal = 0.26*1.225) "Chilled beam system test-bed" annotation(
    Placement(visible = true, transformation(origin = {-24, -16}, extent = {{88, -16}, {108, 32}}, rotation = 0)));
  Buildings.Controls.OBC.ChilledBeams.Terminal.Controller terCon[5](TdCoo = {0.1, 100, 0.1, 0.1, 0.1}, TiCoo = fill(50, 5), VDes_occ = {0.143, 0.065, 0.143, 0.065, 0.26}, VDes_unoccSch = {0.028, 0.012, 0.028, 0.012, 0.052}, VDes_unoccUnsch = {0.056, 0.024, 0.056, 0.024, 0.104}, controllerTypeCoo = fill(Buildings.Controls.OBC.CDL.Types.SimpleController.PID, 5)) "Terminal controllers" annotation(
    Placement(visible = true, transformation(origin = {20, 0}, extent = {{10, 40}, {30, 60}}, rotation = 0)));
  Buildings.Controls.OBC.ChilledBeams.System.Controller sysCon(nPum = 1, nVal = 5, minPumSpe = 0.7, TiPumSpe = 50, kBypVal = 10e-3, TiBypVal = 900) annotation(
    Placement(visible = true, transformation(origin = {-6, -18}, extent = {{10, -70}, {30, -50}}, rotation = 0)));
  Buildings.Controls.OBC.FDE.DOAS.DOAScontroller DOAScon(minDDSPset = 400, maxDDSPset = 500, cvDDSPset = 450) annotation(
    Placement(visible = true, transformation(origin = {17, -2}, extent = {{-13, -24}, {13, 10}}, rotation = 0)));
  Buildings.Controls.OBC.CDL.Continuous.MultiMax TZonMax(nin = 5) annotation(
    Placement(transformation(extent = {{-40, 50}, {-20, 70}})));
  Buildings.Controls.OBC.CDL.Continuous.MultiMax yDamPosMax(nin = 5) annotation(
    Placement(transformation(extent = {{-40, 20}, {-20, 40}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.TimeTable enaSch(final table = schTab, final smoothness = Buildings.Controls.OBC.CDL.Types.Smoothness.ConstantSegments, final timeScale = 3600) "Table defining when occupancy is expected" annotation(
    Placement(transformation(extent = {{-150, 70}, {-130, 90}})));
  Buildings.Controls.OBC.CDL.Continuous.Hysteresis hys(uLow = 0.45, uHigh = 0.5) annotation(
    Placement(transformation(extent = {{-120, 70}, {-100, 90}})));
  Buildings.Controls.OBC.CDL.Routing.BooleanScalarReplicator booRep(nout = 5) annotation(
    Placement(transformation(extent = {{-90, 70}, {-70, 90}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant uConSig[5](k = fill(false, 5)) "Constant Boolean source" annotation(
    Placement(visible = true, transformation(origin = {16, 0}, extent = {{-90, 30}, {-70, 50}}, rotation = 0)));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant chiWatSupTem(k = 273.15 + 7.22) "Chilled water supply temperature" annotation(
    Placement(transformation(extent = {{-90, -30}, {-70, -10}})));
  Modelica.Blocks.Sources.CombiTimeTable loads(tableOnFile = true, tableName = "tab1", fileName = "C:/buildings_library/buildings_library_pnnl/VM_script/inputTable_constantSetpoint.txt", columns = {2, 3, 4, 5, 6}, timeScale = 60) "Table defining thermal loads for zone" annotation(
    Placement(transformation(extent = {{-60, -60}, {-40, -40}})));
  Buildings.Controls.OBC.CDL.Logical.TrueDelay truDel(delayTime = 10) annotation(
    Placement(visible = true, transformation(origin = {-20, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Buildings.Controls.SetPoints.OccupancySchedule occSch(occupancy = 3600*{8, 18}) annotation(
    Placement(visible = true, transformation(origin = {6, 74}, extent = {{-152, -44}, {-132, -24}}, rotation = 0)));
  Buildings.Controls.OBC.CDL.Continuous.Sources.TimeTable TSetRooHea(extrapolation = Buildings.Controls.OBC.CDL.Types.Extrapolation.Periodic, smoothness = Buildings.Controls.OBC.CDL.Types.Smoothness.ConstantSegments, table = [0, 15 + 273.15; 8*3600, 20 + 273.15; 18*3600, 15 + 273.15; 24*3600, 15 + 273.15]) annotation(
    Placement(visible = true, transformation(origin = {72, 64}, extent = {{-152, 40}, {-132, 60}}, rotation = 0)));
  Buildings.Controls.OBC.CDL.Continuous.Sources.TimeTable TSetRooCoo(extrapolation = Buildings.Controls.OBC.CDL.Types.Extrapolation.Periodic, smoothness = Buildings.Controls.OBC.CDL.Types.Smoothness.ConstantSegments, table = [0, 30 + 273.15; 8*3600, 25 + 273.15; 18*3600, 30 + 273.15; 24*3600, 30 + 273.15]) annotation(
    Placement(visible = true, transformation(origin = {74, 122}, extent = {{-152, 10}, {-132, 30}}, rotation = 0)));
  Buildings.Controls.OBC.FDE.DOAS.erwTsim eRWtemp annotation(
    Placement(visible = true, transformation(origin = {-108, -72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Controls.OBC.CDL.Continuous.Subtract sub annotation(
    Placement(visible = true, transformation(origin = {-64, -84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Buildings.Controls.OBC.CDL.Routing.BooleanScalarReplicator booleanScalarReplicator(nout = 5) annotation(
    Placement(visible = true, transformation(origin = {-22, -40}, extent = {{-90, 70}, {-70, 90}}, rotation = 0)));
  Controls.OBC.CDL.Routing.RealScalarReplicator reaScaRep(nout = 5)  annotation(
    Placement(visible = true, transformation(origin = {-26, 98}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Buildings.Controls.OBC.CDL.Routing.RealScalarReplicator realScalarReplicator(nout = 5) annotation(
    Placement(visible = true, transformation(origin = {-30, 142}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(terCon.yReh, chiBeaTesBed.uCAVReh) annotation(
    Line(points = {{52, 55}, {52, 26.5}, {62, 26.5}, {62, -2}}, color = {0, 0, 127}));
  connect(terCon.yChiVal, chiBeaTesBed.uChiWatVal) annotation(
    Line(points = {{52, 52.5}, {52, 29.25}, {62, 29.25}, {62, 6}}, color = {0, 0, 127}));
  connect(terCon.yDam, chiBeaTesBed.uCAVDam) annotation(
    Line(points = {{52, 50}, {52, 26}, {62, 26}, {62, 2}}, color = {0, 0, 127}));
  connect(sysCon.yChiWatPum[1], chiBeaTesBed.uPumSta) annotation(
    Line(points = {{26, -72}, {26, -46}, {62, -46}, {62, -22}}, color = {255, 0, 255}));
  connect(sysCon.yPumSpe, chiBeaTesBed.uPumSpe) annotation(
    Line(points = {{26, -78}, {37, -78}, {37, -26}, {62, -26}}, color = {0, 0, 127}));
  connect(chiBeaTesBed.yPumSta, sysCon.uPumSta[1]) annotation(
    Line(points = {{86, -22}, {-34, -22}, {-34, -72}, {2, -72}}, color = {255, 0, 255}));
  connect(chiBeaTesBed.dPChiWat, sysCon.dPChiWatLoo) annotation(
    Line(points = {{86, -18}, {-51, -18}, {-51, -78}, {2, -78}}, color = {0, 0, 127}));
  connect(chiBeaTesBed.yChiWatVal, sysCon.uValPos) annotation(
    Line(points = {{86, -2}, {67, -2}, {67, -84}, {2, -84}}, color = {0, 0, 127}));
  connect(chiBeaTesBed.yChiWatVal, terCon.uChiVal) annotation(
    Line(points = {{86, -2}, {86, 18.5}, {28, 18.5}, {28, 41}}, color = {0, 0, 127}));
  connect(sysCon.yBypValPos, chiBeaTesBed.uBypValPos) annotation(
    Line(points = {{26, -84}, {75, -84}, {75, 10}, {62, 10}}, color = {0, 0, 127}));
  connect(DOAScon.supFanStart, chiBeaTesBed.uFanSta) annotation(
    Line(points = {{33, 3}, {33, 23.5}, {62, 23.5}, {62, -6}}, color = {255, 0, 255}));
  connect(DOAScon.supFanSpeed, chiBeaTesBed.uFanSpe) annotation(
    Line(points = {{33, 0}, {32.5, 0}, {32.5, -10}, {62, -10}}, color = {0, 0, 127}));
  connect(DOAScon.yRHC, chiBeaTesBed.uHeaCoi) annotation(
    Line(points = {{33, -6}, {33, 14.5}, {62, 14.5}, {62, -14}}, color = {0, 0, 127}));
  connect(DOAScon.yCC, chiBeaTesBed.uCooCoi) annotation(
    Line(points = {{33, -3}, {33, -18}, {62, -18}}, color = {0, 0, 127}));
  connect(chiBeaTesBed.TDOASDis, DOAScon.saT) annotation(
    Line(points = {{86, -26}, {86, -11.5}, {1, -11.5}, {1, -7}}, color = {0, 0, 127}));
  connect(TZonMax.y, DOAScon.highSpaceT) annotation(
    Line(points = {{-18, 60}, {-18, 27.5}, {1, 27.5}, {1, -5}}, color = {0, 0, 127}));
  connect(yDamPosMax.y, DOAScon.mostOpenDam) annotation(
    Line(points = {{-18, 30}, {-18, 5}, {1, 5}}, color = {0, 0, 127}));
  connect(chiBeaTesBed.yFanSta, DOAScon.supFanStatus) annotation(
    Line(points = {{86, -14}, {86, 1.5}, {1, 1.5}, {1, 3}}, color = {255, 0, 255}));
  connect(chiBeaTesBed.relHumDOASRet, DOAScon.retHum) annotation(
    Line(points = {{86, -30}, {86, -2}, {1, -2}}, color = {0, 0, 127}));
  connect(enaSch.y[1], hys.u) annotation(
    Line(points = {{-128, 80}, {-122, 80}}, color = {0, 0, 127}));
  connect(hys.y, booRep.u) annotation(
    Line(points = {{-98, 80}, {-92, 80}}, color = {255, 0, 255}));
//connect(booRep.y, terCon.uDetOcc) annotation(
//Line(points = {{-68, 80}, {-4, 80}, {-4, 58}, {8, 58}}, color = {255, 0, 255}));
  connect(uConSig.y, terCon.uConSen) annotation(
    Line(points = {{-52, 40}, {-52, 48}, {-4, 48}, {-4, 49}, {28, 49}}, color = {255, 0, 255}));
  connect(hys.y, DOAScon.occ) annotation(
    Line(points = {{-98, 80}, {-96, 80}, {-96, 8}, {1, 8}}, color = {255, 0, 255}));
  connect(chiWatSupTem.y, chiBeaTesBed.TChiWatSup) annotation(
    Line(points = {{-68, -20}, {-3, -20}, {-3, -30}, {62, -30}}, color = {0, 0, 127}));
  connect(chiBeaTesBed.TZon, terCon.TZon) annotation(
    Line(points = {{86, 10}, {86, 46}, {28, 46}}, color = {0, 0, 127}));
  connect(chiBeaTesBed.VDisAir_flow, terCon.VDis_flow) annotation(
    Line(points = {{86, 6}, {86, 44}, {28, 44}}, color = {0, 0, 127}));
  connect(chiBeaTesBed.TZon, TZonMax.u[1:5]) annotation(
    Line(points = {{86, 10}, {86, 58.4}, {-42, 58.4}}, color = {0, 0, 127}));
  connect(chiBeaTesBed.yDamPos, yDamPosMax.u[1:5]) annotation(
    Line(points = {{86, -6}, {86, 28.4}, {-42, 28.4}}, color = {0, 0, 127}));
  connect(loads.y, chiBeaTesBed.QFlo) annotation(
    Line(points = {{-39, -50}, {31.5, -50}, {31.5, 14}, {62, 14}}, color = {0, 0, 127}));
  connect(chiBeaTesBed.yFanSta, truDel.u) annotation(
    Line(points = {{86, -14}, {86, -45}, {-32, -45}, {-32, -76}}, color = {255, 0, 255}));
  connect(truDel.y, DOAScon.exhFanProof) annotation(
    Line(points = {{-8, -76}, {-8, -52.5}, {1, -52.5}, {1, -22}}, color = {255, 0, 255}));
  connect(chiBeaTesBed.TDOASDis, DOAScon.raT) annotation(
    Line(points = {{86, -26}, {37.5, -26}, {37.5, -10}, {1, -10}}, color = {0, 0, 127}));
  connect(chiBeaTesBed.dPDOASAir, DOAScon.DDSP) annotation(
    Line(points = {{86, -10}, {28.5, -10}, {28.5, 0}, {1, 0}}, color = {0, 0, 127}));
  connect(DOAScon.oaT, chiBeaTesBed.OutdoorAirTemp) annotation(
    Line(points = {{1, -12}, {1, -16.5}, {86, -16.5}, {86, -30}}, color = {0, 0, 127}));
  connect(DOAScon.bypDam, eRWtemp.bypDam) annotation(
    Line(points = {{33, -9}, {33, -66}, {-120, -66}}, color = {255, 0, 255}));
  connect(DOAScon.erwStart, eRWtemp.erwStart) annotation(
    Line(points = {{33, -12}, {33, -70}, {-120, -70}}, color = {255, 0, 255}));
  connect(DOAScon.erwT, eRWtemp.erwTsim) annotation(
    Line(points = {{1, -20}, {1, -72}, {-96, -72}}, color = {0, 0, 127}));
  connect(eRWtemp.oaT, chiBeaTesBed.OutdoorAirTemp) annotation(
    Line(points = {{-120, -78}, {-120, -65}, {86, -65}, {86, -30}}, color = {0, 0, 127}));
  connect(terCon.VDis_flow, chiBeaTesBed.VDisAir_flow) annotation(
    Line(points = {{28, 44}, {86, 44}, {86, 6}}, color = {0, 0, 127}, thickness = 0.5));
  connect(chiBeaTesBed.TZon, terCon.TZon) annotation(
    Line(points = {{86, 10}, {20, 10}, {20, 46}, {28, 46}}, color = {0, 0, 127}, thickness = 0.5));
  connect(chiBeaTesBed.TDOASDis, DOAScon.ccT) annotation(
    Line(points = {{86, -26}, {-28, -26}, {-28, -15}, {1, -15}}, color = {0, 0, 127}));
  connect(eRWtemp.erwTsim, sub.u2) annotation(
    Line(points = {{-96, -72}, {-6, -72}, {-6, -90}, {-76, -90}}, color = {0, 0, 127}));
  connect(chiBeaTesBed.OutdoorAirTemp, sub.u1) annotation(
    Line(points = {{86, -32}, {-76, -32}, {-76, -78}}, color = {0, 0, 127}));
  connect(sub.y, chiBeaTesBed.deltaT) annotation(
    Line(points = {{-52, -84}, {50, -84}, {50, 4}, {62, 4}}, color = {0, 0, 127}));
  connect(booRep.y, terCon.uOccExp) annotation(
    Line(points = {{-68, 80}, {-8, 80}, {-8, 56}, {28, 56}}, color = {255, 0, 255}, thickness = 0.5));
  connect(occSch.occupied, booleanScalarReplicator.u) annotation(
    Line(points = {{-124, 34}, {-118, 34}, {-118, 40}, {-114, 40}}, color = {255, 0, 255}));
  connect(booleanScalarReplicator.y, terCon.uOccDet) annotation(
    Line(points = {{-90, 40}, {18, 40}, {18, 58}, {28, 58}}, color = {255, 0, 255}, thickness = 0.5));
  connect(TSetRooHea.y[1], reaScaRep.u) annotation(
    Line(points = {{-58, 114}, {-50, 114}, {-50, 98}, {-38, 98}}, color = {0, 0, 127}));
  connect(reaScaRep.y, terCon.TZonHeaSet) annotation(
    Line(points = {{-14, 98}, {12, 98}, {12, 54}, {28, 54}}, color = {0, 0, 127}, thickness = 0.5));
  connect(TSetRooCoo.y[1], realScalarReplicator.u) annotation(
    Line(points = {{-56, 142}, {-42, 142}}, color = {0, 0, 127}));
  connect(realScalarReplicator.y, terCon.TZonCooSet) annotation(
    Line(points = {{-18, 142}, {8, 142}, {8, 52}, {28, 52}}, color = {0, 0, 127}, thickness = 0.5));
  connect(chiBeaTesBed.rAT, DOAScon.raT) annotation(
    Line(points = {{86, -30}, {114, -30}, {114, -10}, {1, -10}}, color = {0, 0, 127}));
  connect(chiBeaTesBed.VDisAir_flow, terCon.VDis_flow) annotation(
    Line(points = {{86, 6}, {22, 6}, {22, 44}, {28, 44}}, color = {0, 0, 127}, thickness = 0.5));
  connect(chiBeaTesBed.bldgSP, DOAScon.bldgSP) annotation(
    Line(points = {{86, -32}, {1, -32}, {1, -24}}, color = {0, 0, 127}));
  connect(chiBeaTesBed.erwsuphum, DOAScon.erwHum) annotation(
    Line(points = {{86, -24}, {1, -24}, {1, -17}}, color = {0, 0, 127}));
  connect(chiBeaTesBed.rAT, eRWtemp.raT) annotation(
    Line(points = {{86, -30}, {-120, -30}, {-120, -74}}, color = {0, 0, 127}));
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}})),
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-160, -100}, {160, 100}})),
    experiment(StartTime = 16848000, StopTime = 16934400, Interval = 600, Tolerance = 1e-06, __Dymola_Algorithm = "Cvode"));
end ClosedLoopValidation;
