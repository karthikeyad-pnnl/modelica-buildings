within Buildings.Templates.Plants.HeatPumps_PNNL.Components.Controls;
block ExternalEnergy
  Interface.ExternalEnergyLoop bus annotation (Placement(transformation(extent={{-20,120},
            {20,160}}),          iconTransformation(extent={{-10,90},{10,110}})));
  Buildings.Templates.Plants.Controls.StagingRotation.EventSequencing seqEveHea(
    have_heaWat=true,
    have_chiWat=false,
    have_valInlIso=true,
    have_valOutIso=true,
    have_pumHeaWatPri=true,
    have_pumHeaWatSec=false)
    annotation (Placement(transformation(extent={{40,72},{60,100}})));
  Buildings.Templates.Plants.Controls.StagingRotation.EventSequencing seqEveCoo(
    have_heaWat=false,
    have_chiWat=true,
    have_valInlIso=true,
    have_valOutIso=true,
    have_pumHeaWatPri=true,
    have_pumChiWatPri=true,
    have_pumHeaWatSec=false,
    have_pumChiWatSec=false)
    annotation (Placement(transformation(extent={{40,-28},{60,0}})));
  CoolingTowerControl_v2
                      coolingTowerControl_v2_1
    annotation (Placement(transformation(extent={{-102,80},{-122,100}})));
  Modelica.Blocks.Routing.IntegerPassThrough integerPassThrough
    annotation (Placement(transformation(extent={{-140,60},{-120,80}})));
  Buildings.Controls.OBC.CDL.Integers.Equal intEqu
    annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt(k=-2)
    annotation (Placement(transformation(extent={{-140,10},{-120,30}})));
  Buildings.Controls.OBC.CDL.Logical.MultiAnd mulAnd(
                                                   nin=3)
    annotation (Placement(transformation(extent={{-30,32},{-10,52}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt1(k=1)
    annotation (Placement(transformation(extent={{-140,-40},{-120,-20}})));
  Buildings.Controls.OBC.CDL.Integers.Equal intEqu1
    annotation (Placement(transformation(extent={{-110,-20},{-90,0}})));
  Buildings.Controls.OBC.CDL.Logical.Or      or2
    annotation (Placement(transformation(extent={{-30,-30},{-10,-10}})));
  Buildings.Controls.OBC.CDL.Logical.Not not2
    annotation (Placement(transformation(extent={{-68,14},{-48,34}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt2(k=3)
    annotation (Placement(transformation(extent={{-140,-100},{-120,-80}})));
  Buildings.Controls.OBC.CDL.Integers.Equal intEqu2
    annotation (Placement(transformation(extent={{-110,-80},{-90,-60}})));
  Buildings.Controls.OBC.CDL.Logical.Not not3
    annotation (Placement(transformation(extent={{-70,-100},{-50,-80}})));
  Buildings.Controls.OBC.CDL.Logical.And and2
    annotation (Placement(transformation(extent={{100,20},{120,40}})));
  Buildings.Controls.OBC.CDL.Logical.And and1
    annotation (Placement(transformation(extent={{100,-40},{120,-20}})));
  Buildings.Controls.OBC.CDL.Logical.And and3
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
  Buildings.Controls.OBC.CDL.Logical.And and4
    annotation (Placement(transformation(extent={{100,-100},{120,-80}})));
  ASHPControl_v2
              aSHPControl_v2_1
    annotation (Placement(transformation(extent={{-80,100},{-60,120}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gai(k=-1)
    annotation (Placement(transformation(extent={{-50,60},{-30,80}})));
  Buildings.Controls.OBC.CDL.Reals.AddParameter addPar(p=1)
    annotation (Placement(transformation(extent={{20,50},{40,70}})));
equation
  connect(bus.heatingPumpBus.y1_actual, seqEveHea.u1PumHeaWatPri_actual)
    annotation (Line(
      points={{0.1,140.1},{0.1,94},{30,94},{30,86},{38,86}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(bus.coolingPumpBus.y1_actual, seqEveCoo.u1PumChiWatPri_actual)
    annotation (Line(
      points={{0.1,140.1},{0.1,4},{32,4},{32,-16},{38,-16}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(coolingTowerControl_v2_1.bus, bus.coolingTowerSystemBus) annotation (
      Line(
      points={{-104.857,90},{0.1,90},{0.1,140.1}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(seqEveHea.y1, bus.heatPumpBus.y1) annotation (Line(points={{62,98},{
          62,110},{0.1,110},{0.1,140.1}},color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(seqEveCoo.y1, bus.coolingTowerSystemBus.uEna) annotation (Line(points={{62,-2},
          {62,16},{0.1,16},{0.1,140.1}},                        color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(seqEveHea.y1PumHeaWatPri, bus.heatingPumpBus.y1) annotation (Line(
        points={{62,78},{66,78},{66,116},{26,116},{26,114},{0.1,114},{0.1,140.1}},
                                                               color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(seqEveCoo.y1PumChiWatPri, bus.coolingPumpBus.y1) annotation (Line(
        points={{62,-24},{84,-24},{84,46},{0.1,46},{0.1,140.1}}, color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(seqEveHea.y1ValHeaWatInlIso, bus.heatingInletValveBus.y1)
    annotation (Line(points={{62,88},{70,88},{70,120},{24,120},{24,116},{0.1,
          116},{0.1,140.1}},
        color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(seqEveHea.y1ValHeaWatOutIso, bus.heatingOutletValveBus.y1)
    annotation (Line(points={{62,86},{66,86},{66,90},{68,90},{68,118},{0.1,118},
          {0.1,140.1}},
        color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(bus.uOpeMod, integerPassThrough.u) annotation (Line(
      points={{0,140},{0,128},{-146,128},{-146,70},{-142,70}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(integerPassThrough.y, intEqu.u1) annotation (Line(points={{-119,70},{
          -114,70},{-114,40},{-112,40}},            color={255,127,0}));
  connect(conInt.y, intEqu.u2) annotation (Line(points={{-118,20},{-114,20},{
          -114,32},{-112,32}},
                     color={255,127,0}));
  connect(mulAnd.y, seqEveHea.u1Hea) annotation (Line(points={{-8,42},{2,42},{2,
          98},{38,98}},    color={255,0,255}));
  connect(intEqu.y, mulAnd.u[1]) annotation (Line(points={{-88,40},{-68,40},{
          -68,39.6667},{-32,39.6667}},                   color={255,0,255}));
  connect(conInt1.y, intEqu1.u2) annotation (Line(points={{-118,-30},{-114,-30},
          {-114,-18},{-112,-18}},
                           color={255,127,0}));
  connect(integerPassThrough.y, intEqu1.u1) annotation (Line(points={{-119,70},
          {-80,70},{-80,10},{-116,10},{-116,-10},{-112,-10}},           color={255,
          127,0}));
  connect(or2.y, seqEveCoo.u1Coo) annotation (Line(points={{-8,-20},{30,-20},{
          30,-6},{38,-6}}, color={255,0,255}));
  connect(intEqu1.y, not2.u) annotation (Line(points={{-88,-10},{-74,-10},{-74,
          24},{-70,24}},
        color={255,0,255}));
  connect(not2.y, mulAnd.u[2]) annotation (Line(points={{-46,24},{-42,24},{-42,
          42},{-32,42}},                               color={255,0,255}));
  connect(conInt2.y, intEqu2.u2) annotation (Line(points={{-118,-90},{-114,-90},
          {-114,-78},{-112,-78}},
                           color={255,127,0}));
  connect(integerPassThrough.y, intEqu2.u1) annotation (Line(points={{-119,70},
          {-80,70},{-80,10},{-116,10},{-116,-10},{-146,-10},{-146,-70},{-112,
          -70}},                                                        color={255,
          127,0}));
  connect(intEqu2.y, not3.u) annotation (Line(points={{-88,-70},{-80,-70},{-80,
          -90},{-72,-90}},                                    color={255,0,255}));
  connect(not3.y, mulAnd.u[3]) annotation (Line(points={{-48,-90},{-42,-90},{
          -42,44.3333},{-32,44.3333}},                           color={255,0,
          255}));
  connect(and2.y, bus.coolingInletValveBus.y1) annotation (Line(points={{122,30},
          {128,30},{128,130},{0.1,130},{0.1,140.1}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(and1.y, bus.coolingOutletValveBus.y1) annotation (Line(points={{122,
          -30},{132,-30},{132,134},{0.1,134},{0.1,140.1}}, color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(and3.y, bus.wseInletValveBus.y1) annotation (Line(points={{122,-60},{
          136,-60},{136,136},{0.1,136},{0.1,140.1}},                  color={255,
          0,255}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(and4.y, bus.wseOutletValveBus.y1) annotation (Line(points={{122,-90},
          {140,-90},{140,138},{0.1,138},{0.1,140.1}},                 color={255,
          0,255}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(seqEveCoo.y1ValChiWatInlIso, and2.u1) annotation (Line(points={{62,-16},
          {80,-16},{80,30},{98,30}},
                                  color={255,0,255}));
  connect(seqEveCoo.y1ValChiWatInlIso, and3.u1) annotation (Line(points={{62,-16},
          {80,-16},{80,-60},{98,-60}},color={255,0,255}));
  connect(seqEveCoo.y1ValChiWatOutIso, and1.u1) annotation (Line(points={{62,-18},
          {96,-18},{96,-30},{98,-30}}, color={255,0,255}));
  connect(seqEveCoo.y1ValChiWatOutIso, and4.u1) annotation (Line(points={{62,-18},
          {96,-18},{96,-90},{98,-90}}, color={255,0,255}));
  connect(intEqu1.y, and3.u2) annotation (Line(points={{-88,-10},{-74,-10},{-74,
          -26},{-38,-26},{-38,-68},{98,-68}},
                              color={255,0,255}));
  connect(intEqu1.y, and4.u2) annotation (Line(points={{-88,-10},{-74,-10},{-74,
          -26},{-38,-26},{-38,-96},{90,-96},{90,-98},{98,-98}},
                                                color={255,0,255}));
  connect(intEqu2.y, and2.u2) annotation (Line(points={{-88,-70},{-80,-70},{-80,
          -38},{92,-38},{92,22},{98,22}},                               color={255,
          0,255}));
  connect(intEqu2.y, and1.u2) annotation (Line(points={{-88,-70},{-80,-70},{-80,
          -38},{98,-38}},                                       color={255,0,255}));
  connect(bus.TCooRet, aSHPControl_v2_1.TRetCoo) annotation (Line(
      points={{0,140},{0,94},{-88,94},{-88,112},{-82,112}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(aSHPControl_v2_1.TSet, bus.heatPumpBus.TSet) annotation (Line(points=
          {{-58,112},{0.1,112},{0.1,140.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(intEqu1.y, or2.u1) annotation (Line(points={{-88,-10},{-74,-10},{-74,
          -26},{-38,-26},{-38,-20},{-32,-20}}, color={255,0,255}));
  connect(intEqu2.y, or2.u2) annotation (Line(points={{-88,-70},{-80,-70},{-80,
          -38},{-32,-38},{-32,-28}}, color={255,0,255}));
  connect(bus.coolingTowerSystemBus.TOut, aSHPControl_v2_1.TOut) annotation (
      Line(
      points={{0.1,140.1},{0.1,92},{-90,92},{-90,108},{-82,108}},
      color={255,204,51},
      thickness=0.5));
  connect(aSHPControl_v2_1.yCooHeaExc, bus.extEneLooCooExc.y) annotation (Line(
        points={{-58,108},{0.1,108},{0.1,140.1}}, color={0,0,127}));
  connect(aSHPControl_v2_1.yCooHeaExc, gai.u) annotation (Line(points={{-58,108},
          {-52,108},{-52,84},{-58,84},{-58,70},{-52,70}}, color={0,0,127}));
  connect(gai.y, addPar.u) annotation (Line(points={{-28,70},{10,70},{10,60},{18,
          60}}, color={0,0,127}));
  connect(addPar.y, bus.extEneLooCooExcByp.y) annotation (Line(points={{42,60},
          {48,60},{48,40},{0.1,40},{0.1,140.1}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),                                  graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,-100},{150,-140}},
          textString="%name",
          textColor={0,0,255})}),           Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-160,-140},{160,140}}), graphics={
        Rectangle(
          extent={{-154,82},{-6,-108}},
          lineColor={28,108,200},
          pattern=LinePattern.Dash),
        Rectangle(
          extent={{6,126},{76,-42}},
          lineColor={238,46,47},
          pattern=LinePattern.Dash),
        Rectangle(
          extent={{82,54},{130,-106}},
          lineColor={0,140,72},
          pattern=LinePattern.Dash),
        Text(
          extent={{-146,-108},{-8,-128}},
          textColor={28,108,200},
          textString="Identify components to enable based on
operation mode signal"),
        Text(
          extent={{4,-12},{76,-96}},
          textColor={238,46,47},
          textString="Safe staging of
cooling and heating
components"),
        Text(
          extent={{66,-70},{154,-168}},
          textColor={0,140,72},
          textString="Enable connection valves
from external energy loop
to central heat recovery")}));
end ExternalEnergy;
