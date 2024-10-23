within Buildings.Examples.ChilledBeamSystem;
model ClosedLoopValidation
  extends Modelica.Icons.Example;
  parameter Real schTab[5, 2] = [0, 0; 8, 1; 18, 1; 21, 0; 24, 0] "Table defining schedule for enabling plant";
  Buildings.Examples.ChilledBeamSystem.BaseClasses.TestBed chiBeaTesBed(TChiWatRet_nominal = 273.15 + 25, mChiWatTot_flow_nominal = 2.114, mAirTot_flow_nominal = 1*0.676*1.225, mHotWatCoi_nominal = 0.078, mChiWatCoi_nominal = 0.645,
    mCooAir_flow_nominal=1*0.676*1.225,
    mHeaAir_flow_nominal=1*0.676*1.225,
    THeaWatInl_nominal=313.15,
    THeaWatOut_nominal=298.15,
    THeaAirInl_nominal=285.85,
    THeaAirDis_nominal=308.15,
    VRooSou = 239.25,
    mChiWatSou_flow_nominal = 0.387,
    mAirSou_flow_nominal = 1*0.143*1.225,
    mAChiBeaSou_flow_nominal = 0.143*1.225,
    VRooEas = 103.31, mChiWatEas_flow_nominal = 0.9,
    mAirEas_flow_nominal = 1*0.065*1.225,
    mAChiBeaEas_flow_nominal = 1*0.065*1.225,
    VRooNor = 239.25,
    mChiWatNor_flow_nominal = 0.253,
    mAirNor_flow_nominal = 1*0.143*1.225,
    mAChiBeaNor_flow_nominal = 0.143*1.225,
    VRooWes = 103.31,
    mChiWatWes_flow_nominal = 0.262,
    mAirWes_flow_nominal = 1*0.065*1.225,
    mAChiBeaWes_flow_nominal = 0.065*1.225,
    VRooCor = 447.68,
    mChiWatCor_flow_nominal = 0.27,
    mAirCor_flow_nominal = 1*0.26*1.225,
    mAChiBeaCor_flow_nominal = 0.26*1.225)
    "Chilled beam system test-bed"
    annotation (Placement(visible = true, transformation(extent={{40,-28},{60,
            20}})));
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
    Placement(visible = true, transformation(origin={-33,-2},   extent = {{-13, -24}, {13, 10}}, rotation = 0)));
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
  Buildings.Controls.OBC.FDE.DOAS.Validation.Baseclasses.erwTsim eRWtemp
    annotation (Placement(visible=true, transformation(
        origin={-82,-78},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Buildings.Controls.OBC.CDL.Reals.Subtract sub annotation (
    Placement(visible = true, transformation(origin={6,-82},      extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Buildings.Controls.OBC.CDL.Routing.BooleanScalarReplicator booleanScalarReplicator(nout = 5) annotation (
    Placement(visible = true, transformation(origin={-36,-42},    extent = {{-90, 70}, {-70, 90}}, rotation = 0)));
  Buildings.Controls.OBC.CDL.Routing.RealScalarReplicator reaScaRep(nout = 5)  annotation (
    Placement(visible = true, transformation(origin = {-26, 98}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Buildings.Controls.OBC.CDL.Routing.RealScalarReplicator realScalarReplicator(nout = 5) annotation (
    Placement(visible = true, transformation(origin = {-30, 142}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(DOAScon.yFanSupSpe, chiBeaTesBed.uFanSpe) annotation (Line(points={{-17.4,
          -1.71429},{-22,-1.71429},{-22,-6},{38,-6}},color={0,0,127}));
  connect(enaSch.y[1], hys.u) annotation (
    Line(points = {{-128, 80}, {-122, 80}}, color = {0, 0, 127}));
  connect(hys.y, booRep.u) annotation (
    Line(points = {{-98, 80}, {-92, 80}}, color = {255, 0, 255}));
//connect(booRep.y, terCon.uDetOcc) annotation(
//Line(points = {{-68, 80}, {-4, 80}, {-4, 58}, {8, 58}}, color = {255, 0, 255}));
  connect(uConSig.y, terCon.uConSen) annotation (
    Line(points={{-66,54},{-66,48},{-4,48},{-4,62.75},{40,62.75}},      color = {255, 0, 255}));
  connect(hys.y,DOAScon.Occ)  annotation (
    Line(points={{-98,80},{-96,80},{-96,6.78571},{-48.6,6.78571}},
                                                            color = {255, 0, 255}));
  connect(chiBeaTesBed.TZon, terCon.TZon) annotation (
    Line(points={{62,16.8},{16,16.8},{16,60.25},{40,60.25}},color = {0, 0, 127}, thickness = 0.5));
  connect(eRWtemp.yTSimEneRecWhe, sub.u2) annotation (Line(points={{-69.6,-78},
          {-30,-78},{-30,-88},{-6,-88}}, color={0,0,127}));
  connect(booRep.y, terCon.uOccExp) annotation (
    Line(points={{-68,80},{-8,80},{-8,70.25},{40,70.25}},    color = {255, 0, 255}, thickness = 0.5));
  connect(TSetRooHea.y[1], reaScaRep.u) annotation (
    Line(points = {{-58, 114}, {-50, 114}, {-50, 98}, {-38, 98}}, color = {0, 0, 127}));
  connect(TSetRooCoo.y[1], realScalarReplicator.u) annotation (
    Line(points = {{-56, 142}, {-42, 142}}, color = {0, 0, 127}));
  connect(realScalarReplicator.y, terCon.TZonCooSet) annotation (
    Line(points={{-18,142},{8,142},{8,65.25},{40,65.25}},    color = {0, 0, 127}, thickness = 0.5));
  connect(chiBeaTesBed.VDisAir_flow, terCon.VDis_flow) annotation (
    Line(points={{62,14.2},{66,14.2},{66,18},{68,18},{68,50},{40,50},{40,57.75}},
                                                          color = {0, 0, 127}, thickness = 0.5));
  connect(occSch.occupied, booleanScalarReplicator.u) annotation (Line(points={
          {-137,34},{-134,34},{-134,38},{-128,38}}, color={255,0,255}));
  connect(booleanScalarReplicator.y, terCon.uOccDet) annotation (Line(points={{
          -104,38},{-102,38},{-102,12},{6,12},{6,72.75},{40,72.75}}, color={255,
          0,255}));
  connect(sysCon.yBypValPos, chiBeaTesBed.uBypValPos) annotation (Line(points={{144,-86},
          {150,-86},{150,-96},{36,-96},{36,-36},{30,-36},{30,14},{38,14}},
                                                                  color={0,0,
          127}));
  connect(chiBeaTesBed.uPumSpe, sysCon.yPumSpe) annotation (Line(points={{38,-22},
          {32,-22},{32,-64},{150,-64},{150,-80},{144,-80}},        color={0,0,
          127}));
  connect(chiBeaTesBed.yChiWatVal, sysCon.uValPos) annotation (Line(points={{62,8},{
          74,8},{74,-86},{120,-86}},         color={0,0,127}));
  connect(chiBeaTesBed.dPChiWat, sysCon.dPChiWatLoo) annotation (Line(points={{62,-8},
          {78,-8},{78,-80},{120,-80}},                              color={0,0,
          127}));
  connect(chiBeaTesBed.yPumSta, sysCon.uPumSta[1]) annotation (Line(points={{62,
          -11.2},{62,-10},{82,-10},{82,-74},{120,-74}},            color={255,0,
          255}));
  connect(DOAScon.yBypDam, eRWtemp.uBypDam) annotation (Line(points={{-17.4,-9},
          {-20,-9},{-20,-42},{-102,-42},{-102,-72},{-94.4,-72}},  color={255,0,
          255}));
  connect(chiBeaTesBed.OutdoorAirTemp, eRWtemp.TAirOut) annotation (Line(points={{62,
          -25.6},{62,-24},{18,-24},{18,-48},{14,-48},{14,-64},{-10,-64},{-10,
          -72},{-52,-72},{-52,-56},{-104,-56},{-104,-84},{-94.4,-84}},
                        color={0,0,127}));
  connect(chiBeaTesBed.OutdoorAirTemp, sub.u1) annotation (Line(points={{62,
          -25.6},{62,-24},{18,-24},{18,-48},{14,-48},{14,-64},{-10,-64},{-10,
          -72},{-12,-72},{-12,-76},{-6,-76}},                       color={0,0,
          127}));
  connect(yDamPosMax.y, DOAScon.uDamMaxOpe) annotation (Line(points={{-36,30},{
          -30,30},{-30,16},{-72,16},{-72,4.35714},{-48.6,4.35714}},
                                                              color={0,0,127}));
  connect(TZonMax.y, DOAScon.TAirHig) annotation (Line(points={{-18,62},{-16,62},
          {-16,34},{-26,34},{-26,18},{-80,18},{-80,-5.35714},{-48.6,-5.35714}},
                                                                          color=
         {0,0,127}));
  connect(chiWatSupTem.y, chiBeaTesBed.TChiWatSup) annotation (Line(points={{-126,
          -16},{-116,-16},{-116,-52},{26,-52},{26,-25.1},{37.9,-25.1}},
                                                          color={0,0,127}));
  connect(chiBeaTesBed.TDOASDis, DOAScon.TAirDisCoiCoo) annotation (Line(points={{62,-14},
          {68,-14},{68,-34},{44,-34},{44,-40},{30,-40},{30,-48},{-24,-48},{-24,
          -38},{-60,-38},{-60,-15.0714},{-48.6,-15.0714}},
                          color={0,0,127}));
  connect(chiBeaTesBed.dPDOASAir, DOAScon.dPAirDucSta) annotation (Line(points={{62,1.2},
          {62,0},{68,0},{68,-14},{66,-14},{66,-32},{-24,-32},{-24,-36},{-58,-36},
          {-58,-0.5},{-48.6,-0.5}},    color={0,0,127}));
  connect(chiBeaTesBed.erwsuphum, DOAScon.phiAirEneRecWhe) annotation (Line(
        points={{62,-16.6},{66,-16.6},{66,-32},{24,-32},{24,-34},{-24,-34},{-24,
          -36},{-58,-36},{-58,-17.5},{-48.6,-17.5}},
        color={0,0,127}));
  connect(eRWtemp.yTSimEneRecWhe, DOAScon.TAirSupEneWhe) annotation (Line(
        points={{-69.6,-78},{-64,-78},{-64,-19.9286},{-48.6,-19.9286}},
                                                                  color={0,0,
          127}));
  connect(DOAScon.TAirSup, DOAScon.TAirDisCoiCoo) annotation (Line(points={{-48.6,
          -7.78571},{-72,-7.78571},{-72,-15.0714},{-48.6,-15.0714}},
                                                         color={0,0,127}));
  connect(chiBeaTesBed.rAT, DOAScon.TAirRet) annotation (Line(points={{62,-22.4},
          {66,-22.4},{66,-32},{40,-32},{40,-30},{-16,-30},{-16,-38},{-58,-38},{
          -58,-10.2143},{-48.6,-10.2143}},
                                     color={0,0,127}));
  connect(DOAScon.TAirOut, chiBeaTesBed.OutdoorAirTemp) annotation (Line(points={{-48.6,
          -12.6429},{-58,-12.6429},{-58,-36},{18,-36},{18,-25.6},{62,-25.6}},
                                                color={0,0,127}));
  connect(chiBeaTesBed.bldgSP, DOAScon.dPAirStaBui) annotation (Line(points={{62,-28},
          {66,-28},{66,-32},{42,-32},{42,-34},{22,-34},{22,-32},{-24,-32},{-24,
          -40},{-48.6,-40},{-48.6,-24.7857}},
        color={0,0,127}));
  connect(DOAScon.uFanSupPro, chiBeaTesBed.yFanSta) annotation (Line(points={{-48.6,
          1.92857},{-48.6,-4},{-58,-4},{-58,14},{28,14},{28,24},{70,24},{70,
          -4.8},{62,-4.8}},
        color={255,0,255}));
  connect(chiBeaTesBed.exhFanSta, DOAScon.uFanExhPro) annotation (Line(points={{62,-2},
          {66,-2},{66,-32},{-24,-32},{-24,-36},{-62,-36},{-62,-22.3571},{-48.6,
          -22.3571}},                  color={255,0,255}));
  connect(TZonMax.u[1:5], chiBeaTesBed.TZon) annotation (Line(points={{-42,62.8},
          {-48,62.8},{-48,44},{16,44},{16,16.8},{62,16.8}},
                                                          color={0,0,127}));
  connect(yDamPosMax.u[1:5], chiBeaTesBed.yDamPos) annotation (Line(points={{-60,
          30.8},{-66,30.8},{-66,20},{-60,20},{-60,18},{-28,18},{-28,16},{-24,16},
          {-24,18},{-18,18},{-18,20},{32,20},{32,22},{72,22},{72,4.2},{62,4.2}},
        color={0,0,127}));
  connect(chiBeaTesBed.yChiWatVal, terCon.uChiVal) annotation (Line(points={{62,8},{
          74,8},{74,44},{40,44},{40,55.25}},
        color={0,0,127}));
  connect(DOAScon.yCoiCoo, chiBeaTesBed.uCooCoi) annotation (Line(points={{-17.4,
          -4.14286},{-22,-4.14286},{-22,0},{32,0},{32,-14},{38,-14}},
                                               color={0,0,127}));
  connect(DOAScon.yEneRecWheEna, eRWtemp.uEneRecWheStart) annotation (Line(
        points={{-17.4,-11.4286},{-22,-11.4286},{-22,-76},{-62,-76},{-62,-50},{
          -112,-50},{-112,-78},{-94.4,-78},{-94.4,-76}},
                                               color={255,0,255}));
  connect(DOAScon.yCoiHea, chiBeaTesBed.uHeaCoi) annotation (Line(points={{-17.4,
          -6.57143},{26,-6.57143},{26,-10},{38,-10}},
                                               color={0,0,127}));
  connect(chiBeaTesBed.uPumSta, sysCon.yChiWatPum[1]) annotation (Line(points={{38,-18},
          {32,-18},{32,-42},{154,-42},{154,-74},{144,-74}},
        color={255,0,255}));
  connect(chiBeaTesBed.uCAVReh, terCon.yReh) annotation (Line(points={{38,2},{
          34,2},{34,78},{70,78},{70,69},{64,69}},      color={0,0,127}));
  connect(terCon.yChiVal, chiBeaTesBed.uChiWatVal) annotation (Line(points={{64,66.5},
          {68,66.5},{68,62},{70,62},{70,22},{34,22},{34,10},{38,10}},
        color={0,0,127}));
  connect(terCon.yDam, chiBeaTesBed.uCAVDam) annotation (Line(points={{64,64},{
          68,64},{68,42},{36,42},{36,22},{34,22},{34,6},{38,6}},      color={0,
          0,127}));
  connect(loads.y, chiBeaTesBed.QFlo) annotation (Line(points={{-139,-50},{-114,
          -50},{-114,14},{-22,14},{-22,18},{38,18}},
                                 color={0,0,127}));
  connect(sub.y, chiBeaTesBed.deltaT) annotation (Line(points={{18,-82},{34,-82},
          {34,-28},{32,-28},{32,8},{38,8}},             color={0,0,127}));
  connect(DOAScon.yFanSup, chiBeaTesBed.uFanSta) annotation (Line(points={{-17.4,
          0.714286},{28,0.714286},{28,-2},{38,-2}},    color={255,0,255}));
  connect(reaScaRep.y, terCon.TZonHeaSet) annotation (Line(points={{-14,98},{0,98},
          {0,68},{20,68},{20,67.75},{40,67.75}}, color={0,0,127}));
  connect(chiBeaTesBed.relHumDOASRet, DOAScon.phiAirRet) annotation (Line(
        points={{62,-19},{66,-19},{66,-32},{-24,-32},{-24,-36},{-58,-36},{-58,
          -20},{-60,-20},{-60,-2.92857},{-48.6,-2.92857}},
                        color={0,0,127}));
  connect(chiBeaTesBed.rAT, eRWtemp.TAirRet) annotation (Line(points={{62,-22.4},
          {66,-22.4},{66,-32},{40,-32},{40,-30},{-16,-30},{-16,-38},{-58,-38},{
          -58,-58},{-100,-58},{-100,-80},{-94.4,-80}},            color={0,0,
          127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}})),
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-160, -100}, {160, 100}})),
    experiment(StartTime = 16848000, StopTime = 16934400, Interval = 600, Tolerance = 1e-06, __Dymola_Algorithm = "Cvode"));
end ClosedLoopValidation;
