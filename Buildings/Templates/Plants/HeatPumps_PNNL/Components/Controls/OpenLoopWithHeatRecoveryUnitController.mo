within Buildings.Templates.Plants.HeatPumps_PNNL.Components.Controls;
block OpenLoopWithHeatRecoveryUnitController
  "Open-loop controller"

  extends
    Buildings.Templates.Plants.HeatPumps_PNNL.Components.Controls.PartialController(
    final typ=Buildings.Templates.Plants.HeatPumps.Types.Controller.OpenLoop);
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant TChiWatSupSet[nHp](
    y(each final unit="K",
      each displayUnit="degC"),
    each k=Buildings.Templates.Data.Defaults.TChiWatSup)
    "Heat pump CHW supply temperature set point"
    annotation (Placement(transformation(extent={{-140,330},{-160,350}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.TimeTable y1ValHeaWatHpInlIso[nHp](
    each table=[0,1; 1,1; 3,1; 5,1],
    each timeScale=1000,
    each period=5000)
    if cfg.have_heaWat and cfg.have_valHpInlIso
    "Heat pump inlet HW isolation valve opening signal"
    annotation (Placement(transformation(extent={{-180,250},{-200,270}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.TimeTable y1ValHeaWatHpOutIso[nHp](
    each table=[0,1; 1,1; 3,1; 5,1],
    each timeScale=1000,
    each period=5000)
    if cfg.have_heaWat and cfg.have_valHpOutIso
    "Heat pump outlet HW isolation valve opening signal"
    annotation (Placement(transformation(extent={{-180,210},{-200,230}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.TimeTable y1ValChiWatHpInlIso[nHp](
    each table=[0,1; 3.1,1; 5,1],
    each timeScale=1000,
    each period=5000)
    if cfg.have_chiWat and cfg.have_valHpInlIso
    "Heat pump inlet CHW isolation valve opening signal"
    annotation (Placement(transformation(extent={{-180,-90},{-200,-70}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.TimeTable y1ValChiWatHpOutIso[nHp](
    each table=[0,1; 3.1,1; 5,1],
    each timeScale=1000,
    each period=5000)
    if cfg.have_chiWat and cfg.have_valHpOutIso
    "Heat pump outlet CHW isolation valve opening signal"
    annotation (Placement(transformation(extent={{-180,-130},{-200,-110}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.TimeTable y1Hp[nHp](
    each table=[
      0, 0;
      1, 0;
      1, 1;
      5, 1],
    each timeScale=1000,
    each period=5000)
    "Heat pump start/stop command"
    annotation (Placement(transformation(extent={{-180,330},{-200,350}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.TimeTable y1HeaHp[nHp](
    each table=[0,0; 3,0; 5,0],
    each timeScale=1000,
    each period=5000)
    if cfg.is_rev
    "Heat pump heating mode command"
    annotation (Placement(transformation(extent={{-180,290},{-200,310}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.TimeTable y1PumHeaWatPri[cfg.nPumHeaWatPri](
    each table=if cfg.have_pumChiWatPriDed or not cfg.have_chiWat then
                                                                      [
      0, 0;
      1, 1;
      3, 0;
      5, 0] else
                [
      0, 0;
      1, 1;
      3, 0;
      3.1, 1;
      5, 0],
    each timeScale=1000,
    each period=5000)
    if cfg.have_heaWat
    "Primary CHW pump start/stop command"
    annotation (Placement(transformation(extent={{-180,170},{-200,190}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.TimeTable y1PumChiWatPri[cfg.nPumChiWatPri](
    each table=[
      0, 0;
      3.1, 1;
      5, 0],
    each timeScale=1000,
    each period=5000)
    if cfg.have_pumChiWatPriDed
    "Primary CHW pump start/stop command"
    annotation (Placement(transformation(extent={{-180,-210},{-200,-190}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.TimeTable y1PumHeaWatSec[cfg.nPumHeaWatSec](
    each table=[
      0, 0;
      1, 1;
      3, 0;
      5, 0],
    each timeScale=1000,
    each period=5000)
    if cfg.typPumHeaWatSec <> Buildings.Templates.Plants.HeatPumps.Types.PumpsSecondary.None
    "Secondary HW pump start/stop command"
    annotation (Placement(transformation(extent={{-180,130},{-200,150}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.TimeTable y1PumChiWatSec[cfg.nPumChiWatSec](
    each table=[
      0, 0;
      3, 1;
      5, 1],
    each timeScale=1000,
    each period=5000)
    if cfg.typPumChiWatSec <> Buildings.Templates.Plants.HeatPumps.Types.PumpsSecondary.None
    "Secondary CHW pump start/stop command"
    annotation (Placement(transformation(extent={{-180,-250},{-200,-230}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant yPumHeaWatSec(
    k=1)
    if cfg.typPumHeaWatSec <> Buildings.Templates.Plants.HeatPumps.Types.PumpsSecondary.None
    "Secondary HW pump speed signal"
    annotation (Placement(transformation(extent={{-140,130},{-160,150}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant yPumChiWatSec(
    k=1)
    if cfg.typPumChiWatSec <> Buildings.Templates.Plants.HeatPumps.Types.PumpsSecondary.None
    "Secondary CHW pump speed signal"
    annotation (Placement(transformation(extent={{-140,-250},{-160,-230}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant tru[nHp](each final k=
        false)
    if not cfg.is_rev
    "Constant"
    annotation (Placement(transformation(extent={{-80,250},{-100,270}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant yPumHeaWatPriHdr(k=1)
    if cfg.have_heaWat and cfg.have_pumHeaWatPriVar and
      cfg.typArrPumPri==Buildings.Templates.Components.Types.PumpArrangement.Headered
    "Headered primary HW pump speed signal"
    annotation (Placement(transformation(extent={{-140,170},{-160,190}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant yPumChiWatPriHdr(k=1)
    if cfg.have_chiWat and cfg.have_pumHeaWatPriVar and
      cfg.typArrPumPri==Buildings.Templates.Components.Types.PumpArrangement.Headered
    "Headered primary CHW pump speed signal"
    annotation (Placement(transformation(extent={{-140,-210},{-160,-190}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant yPumHeaWatPriDed[cfg.nPumHeaWatPri](
     each k=1) if cfg.have_heaWat and cfg.have_pumHeaWatPriVar and cfg.typArrPumPri
     == Buildings.Templates.Components.Types.PumpArrangement.Dedicated
    "Dedicated primary HW pump speed signal"
    annotation (Placement(transformation(extent={{-100,170},{-120,190}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant yPumChiWatPriDed[cfg.nPumChiWatPri](
     each k=1) if cfg.have_pumChiWatPriDed and cfg.have_pumHeaWatPriVar
    "Dedicated primary CHW pump speed signal"
    annotation (Placement(transformation(extent={{-100,-210},{-120,-190}})));
  HeatRecoveryUnitController heatRecoveryUnitController
    annotation (Placement(transformation(extent={{-50,-200},{40,-4}})));
  Buildings.Controls.OBC.CDL.Routing.BooleanScalarReplicator booScaRep
    annotation (Placement(transformation(extent={{80,-100},{100,-80}})));
  Modelica.Blocks.Routing.RealPassThrough realPassThrough
    annotation (Placement(transformation(extent={{-140,58},{-120,78}})));
  Buildings.Controls.OBC.CDL.Reals.Switch TSet[nHp](y(each final unit="K",
        each displayUnit="degC"))
    "Active supply temperature setpoint"
    annotation (Placement(transformation(extent={{-120,300},{-140,320}})));
  Buildings.Controls.OBC.CDL.Routing.RealScalarReplicator reaScaRep(nout=nHp)
    annotation (Placement(transformation(extent={{-38,220},{-58,240}})));
  Modelica.Blocks.Routing.IntegerPassThrough integerPassThrough
    annotation (Placement(transformation(extent={{-190,80},{-170,100}})));
  Buildings.Controls.OBC.CDL.Routing.RealScalarReplicator reaScaRep1(nout=nHp)
    annotation (Placement(transformation(extent={{-80,330},{-100,350}})));
  Modelica.Blocks.Routing.RealPassThrough realPassThrough1
    annotation (Placement(transformation(extent={{-140,30},{-120,50}})));
  Buildings.Controls.OBC.CDL.Integers.Equal intEqu
    annotation (Placement(transformation(extent={{0,80},{20,100}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt(k=-2)
    annotation (Placement(transformation(extent={{-40,100},{-20,120}})));
  Buildings.Controls.OBC.CDL.Routing.BooleanScalarReplicator booScaRep1(nout=
        nHp) annotation (Placement(transformation(extent={{80,220},{100,240}})));
  Buildings.Controls.OBC.CDL.Logical.Not not1
    annotation (Placement(transformation(extent={{70,190},{90,210}})));
  Buildings.Controls.OBC.CDL.Routing.BooleanScalarReplicator booScaRep2(nout=
        nHp)
    annotation (Placement(transformation(extent={{100,190},{120,210}})));
  Buildings.Controls.OBC.CDL.Routing.BooleanScalarReplicator booScaRep3(nout=
        nHp)
    annotation (Placement(transformation(extent={{40,300},{20,320}})));
  CapacityLimiter capacityLimiter
    annotation (Placement(transformation(extent={{60,80},{80,100}})));
  Interface.ExternalEnergyLoop bus_extEne annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={260,0}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={100,2})));
  Buildings.Controls.OBC.CDL.Logical.MultiOr mulOr(nin=3)
    annotation (Placement(transformation(extent={{80,300},{60,320}})));
  Buildings.Controls.OBC.CDL.Integers.Equal intEqu1
    annotation (Placement(transformation(extent={{0,40},{20,60}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt1(k=3)
    annotation (Placement(transformation(extent={{-30,20},{-10,40}})));
  Buildings.Controls.OBC.CDL.Integers.Equal intEqu2
    annotation (Placement(transformation(extent={{0,150},{20,170}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt2(k=0)
    annotation (Placement(transformation(extent={{-40,130},{-20,150}})));
  Buildings.Controls.OBC.CDL.Logical.And and2
    annotation (Placement(transformation(extent={{40,150},{60,170}})));
  Buildings.Controls.OBC.CDL.Logical.MultiAnd and1(nin=3)
    annotation (Placement(transformation(extent={{40,110},{60,130}})));
  Buildings.Controls.OBC.CDL.Logical.MultiAnd and3(nin=3)
    annotation (Placement(transformation(extent={{80,40},{100,60}})));
equation
  /* Control point connection - start */
  connect(y1PumHeaWatPri.y[1], busPumHeaWatPri.y1);
  connect(yPumHeaWatPriHdr.y, busPumHeaWatPri.y);
  connect(yPumHeaWatPriDed.y, busPumHeaWatPri.y);
  connect(y1PumHeaWatSec.y[1], busPumHeaWatSec.y1);
  connect(yPumHeaWatSec.y, busPumHeaWatSec.y);
//  connect(y1ValHeaWatHpInlIso.y[1], busValHeaWatHpInlIso.y1);
//  connect(y1ValHeaWatHpOutIso.y[1], busValHeaWatHpOutIso.y1);
  connect(yPumChiWatSec.y, busPumChiWatSec.y);
//  connect(y1ValChiWatHpOutIso.y[1], busValChiWatHpOutIso.y1);
  connect(y1PumChiWatPri.y[1], busPumChiWatPri.y1);
  connect(yPumChiWatPriHdr.y, busPumChiWatPri.y);
  connect(yPumChiWatPriDed.y, busPumChiWatPri.y);
//  connect(y1ValChiWatHpInlIso.y[1], busValChiWatHpInlIso.y1);
  connect(y1PumChiWatSec.y[1], busPumChiWatSec.y1);
  //connect(y1Hp.y[1], busHp.y1);
  connect(y1HeaHp.y[1], busHp.y1Hea);
  /* Control point connection - stop */



// Heat Recovery Unit Control Input Connection
  connect(bus.TSupCoo, heatRecoveryUnitController.TSupCoo);
  connect(bus.TSupCooSet, heatRecoveryUnitController.TSupCooSet);
  connect(bus.TSupHea, heatRecoveryUnitController.TSupHea);
  connect(bus.TSupHeaSet, heatRecoveryUnitController.TSupHeaSet);
  connect(bus.uDpHea, heatRecoveryUnitController.uDpHea);
  connect(bus.uDpCoo, heatRecoveryUnitController.uDpCoo);
  connect(bus.uDpHeaSet, heatRecoveryUnitController.uDpHeaSet);
  connect(bus.uDpCooSet, heatRecoveryUnitController.uDpCooSet);
  connect(bus_HeaPum.y1_actual[1], heatRecoveryUnitController.uHeaPumPro);
  connect(bus_CooPum.y1_actual[1], heatRecoveryUnitController.uCooPumPro);
// Heat Recovery Unit Control Output Connection
  //connect(realPassThrough.y, busHp[1].TSet);
    connect(heatRecoveryUnitController.yVal, busValHeaWatHpInlIso[1].y1);
  connect(heatRecoveryUnitController.yVal, busValHeaWatHpOutIso[1].y1);
  connect(heatRecoveryUnitController.yVal, busValChiWatHpOutIso[1].y1);
    connect(heatRecoveryUnitController.yVal, busValChiWatHpInlIso[1].y1);
 // connect(heatRecoveryUnitController.yPum, bus_HeaPum.y1);
 //  connect(heatRecoveryUnitController.yPum, bus_CooPum.y1);
 connect(TSet.y, busHp.TSupSet);



  connect(heatRecoveryUnitController.yPum, booScaRep.u) annotation (Line(points={{49,
          -89.75},{63.5,-89.75},{63.5,-90},{78,-90}}, color={255,0,255}));
  connect(heatRecoveryUnitController.yPumSpeHea, bus_HeaPum.y) annotation (
      Line(points={{49,-114.25},{49,-112},{64,-112},{64,-324},{-164,-324},{-164,
          -372}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(booScaRep.y[1], bus_HeaPum.y1[1]) annotation (Line(points={{102,-90},{
          136,-90},{136,-316},{128,-316},{128,-404},{-164,-404},{-164,-372}},
        color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(heatRecoveryUnitController.yPumSpeCoo, bus_CooPum.y) annotation (Line(
        points={{49,-138.75},{49,-136},{70,-136},{70,-358}},
                                                          color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(booScaRep.y[1], bus_CooPum.y1[1]) annotation (Line(points={{102,-90},{
          136,-90},{136,-316},{128,-316},{128,-404},{70,-404},{70,-358}},
                                                                     color={255,
          0,255}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(bus.uPlaEna, heatRecoveryUnitController.uEna) annotation (Line(
      points={{-260,0},{-76,0},{-76,40},{-40,40},{-40,20.5},{-59,20.5}},
      color={255,204,51},
      thickness=0.5));
  connect(reaScaRep.y, TSet.u3) annotation (Line(points={{-60,230},{-60,228},{
          -118,228},{-118,302}}, color={0,0,127}));
  connect(bus.uOpeMod, integerPassThrough.u) annotation (Line(
      points={{-260,0},{-200,0},{-200,90},{-192,90}},
      color={255,204,51},
      thickness=0.5));
  connect(bus.TSetCoo, reaScaRep.u) annotation (Line(
      points={{-260,0},{-84,0},{-84,208},{-20,208},{-20,230},{-36,230}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(reaScaRep1.y, TSet.u1) annotation (Line(points={{-102,340},{-108,340},
          {-108,318},{-118,318}}, color={0,0,127}));
  connect(bus.TSetHea, reaScaRep1.u) annotation (Line(
      points={{-260,0},{-80,0},{-80,204},{-16,204},{-16,340},{-78,340}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(bus.TSetHea, realPassThrough.u) annotation (Line(
      points={{-260,0},{-152,0},{-152,68},{-142,68}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(bus.TSetCoo, realPassThrough1.u) annotation (Line(
      points={{-260,0},{-156,0},{-156,40},{-142,40}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(conInt.y, intEqu.u2) annotation (Line(points={{-18,110},{-12,110},{-12,
          82},{-2,82}},
                     color={255,127,0}));
  connect(integerPassThrough.y, intEqu.u1) annotation (Line(points={{-169,90},{-2,
          90}},                             color={255,127,0}));
  connect(booScaRep1.y, TSet.u2) annotation (Line(points={{102,230},{114,230},{114,
          252},{-66,252},{-66,310},{-118,310}}, color={255,0,255}));
  connect(not1.y, booScaRep2.u)
    annotation (Line(points={{92,200},{98,200}}, color={255,0,255}));
  connect(booScaRep2.y, busHp.y1Coo) annotation (Line(points={{122,200},{132,200},
          {132,356},{-172,356},{-172,340},{-240,340}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(booScaRep3.y, busHp.y1) annotation (Line(points={{18,310},{-12,310},{-12,
          376},{-240,376},{-240,340}},      color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(intEqu.y, capacityLimiter.uHea)
    annotation (Line(points={{22,90},{44,90},{44,94},{58,94}},
                                                       color={255,0,255}));
  connect(capacityLimiter.yHea, booScaRep1.u) annotation (Line(points={{82,90},
          {92,90},{92,180},{52,180},{52,230},{78,230}}, color={255,0,255}));
  connect(capacityLimiter.yHea, not1.u) annotation (Line(points={{82,90},{92,90},
          {92,180},{52,180},{52,200},{68,200}}, color={255,0,255}));
  connect(bus.TRetHeaCon, capacityLimiter.TSupHea) annotation (Line(
      points={{-260,0},{56,0},{56,86},{58,86}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(bus.TRetCooCon, capacityLimiter.TSupCoo) annotation (Line(
      points={{-260,0},{44,0},{44,90},{58,90}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(mulOr.y, booScaRep3.u)
    annotation (Line(points={{58,310},{42,310}}, color={255,0,255}));
  connect(integerPassThrough.y, intEqu1.u1) annotation (Line(points={{-169,90},{
          -48,90},{-48,50},{-2,50}}, color={255,127,0}));
  connect(conInt1.y, intEqu1.u2) annotation (Line(points={{-8,30},{-8,36},{-2,36},
          {-2,42}}, color={255,127,0}));
  connect(conInt2.y, intEqu2.u2) annotation (Line(points={{-18,140},{-18,144},{-2,
          144},{-2,152}}, color={255,127,0}));
  connect(integerPassThrough.y, intEqu2.u1) annotation (Line(points={{-169,90},{
          -48,90},{-48,160},{-2,160}}, color={255,127,0}));
  connect(intEqu2.y, and2.u1)
    annotation (Line(points={{22,160},{38,160}}, color={255,0,255}));
  connect(heatRecoveryUnitController.yHP, and2.u2) annotation (Line(points={{49,
          -40.75},{64,-40.75},{64,40},{40,40},{40,104},{24,104},{24,140},{38,140},
          {38,152}}, color={255,0,255}));
  connect(intEqu.y, and1.u[1]) annotation (Line(points={{22,90},{36,90},{36,108},
          {28,108},{28,117.667},{38,117.667}},
                                             color={255,0,255}));
  connect(intEqu1.y, and3.u[1]) annotation (Line(points={{22,50},{50,50},{50,
          47.6667},{78,47.6667}},
                         color={255,0,255}));
  connect(heatRecoveryUnitController.yHP, and3.u[2]) annotation (Line(points={{49,
          -40.75},{64,-40.75},{64,50},{78,50}}, color={255,0,255}));
  connect(heatRecoveryUnitController.yHP, and1.u[2]) annotation (Line(points={{49,
          -40.75},{64,-40.75},{64,40},{40,40},{40,104},{36,104},{36,108},{28,108},
          {28,120},{38,120}},       color={255,0,255}));
  connect(bus_extEne.coolingPumpBus.y1_actual, and3.u[3]) annotation (Line(
      points={{260.1,-0.1},{68,-0.1},{68,52.3333},{78,52.3333}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(bus_extEne.heatingPumpBus.y1_actual, and1.u[3]) annotation (Line(
      points={{260.1,-0.1},{64,-0.1},{64,40},{38,40},{38,122.333}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(and2.y, mulOr.u[1]) annotation (Line(points={{62,160},{68,160},{68,
          176},{48,176},{48,292},{92,292},{92,307.667},{82,307.667}}, color={
          255,0,255}));
  connect(and1.y, mulOr.u[2]) annotation (Line(points={{62,120},{76,120},{76,
          160},{68,160},{68,176},{48,176},{48,292},{92,292},{92,310},{82,310}},
        color={255,0,255}));
  connect(and3.y, mulOr.u[3]) annotation (Line(points={{102,50},{112,50},{112,
          108},{76,108},{76,160},{68,160},{68,176},{48,176},{48,292},{92,292},{
          92,310},{82,310}}, color={255,0,255}));
  annotation (
    defaultComponentName="ctl", Documentation(info="<html>
<p>
This is an open loop controller providing control inputs
for the plant model
<a href=\"modelica://Buildings.Templates.Plants.HeatPumps.AirToWater\">
Buildings.Templates.Plants.HeatPumps.AirToWater</a>.
It is only used for testing purposes.
</p>
</html>"));
end OpenLoopWithHeatRecoveryUnitController;
