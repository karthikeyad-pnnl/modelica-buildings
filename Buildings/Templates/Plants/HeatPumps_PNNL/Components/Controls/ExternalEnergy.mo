within Buildings.Templates.Plants.HeatPumps_PNNL.Components.Controls;
block ExternalEnergy
  parameter Real TExtCooSet=273.15+20;
  parameter Real TExtHeaSet=273.15+23;
  Interface.ExternalEnergyLoop bus annotation (Placement(transformation(extent=
            {{-20,120},{20,160}}), iconTransformation(extent={{-10,90},{10,110}})));
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
  CoolingTowerControl coolingTowerControl(TExtCooSupSet=TExtCooSet - 5)
    annotation (Placement(transformation(extent={{-100,86},{-120,106}})));
  Modelica.Blocks.Routing.IntegerPassThrough integerPassThrough
    annotation (Placement(transformation(extent={{-140,60},{-120,80}})));
  Buildings.Controls.OBC.CDL.Integers.Equal intEqu
    annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt(k=-2)
    annotation (Placement(transformation(extent={{-140,10},{-120,30}})));
  Buildings.Controls.OBC.CDL.Logical.MultiAnd mulAnd(
                                                   nin=4)
    annotation (Placement(transformation(extent={{-30,32},{-10,52}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt1(k=1)
    annotation (Placement(transformation(extent={{-140,-40},{-120,-20}})));
  Buildings.Controls.OBC.CDL.Integers.Equal intEqu1
    annotation (Placement(transformation(extent={{-110,-20},{-90,0}})));
  Buildings.Controls.OBC.CDL.Logical.Or      or2
    annotation (Placement(transformation(extent={{-30,-70},{-10,-50}})));
  Buildings.Controls.OBC.CDL.Logical.Not not2
    annotation (Placement(transformation(extent={{-68,14},{-48,34}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt2(k=3)
    annotation (Placement(transformation(extent={{-140,-100},{-120,-80}})));
  Buildings.Controls.OBC.CDL.Integers.Equal intEqu2
    annotation (Placement(transformation(extent={{-110,-80},{-90,-60}})));
  Buildings.Controls.OBC.CDL.Logical.Not not3
    annotation (Placement(transformation(extent={{-70,-100},{-50,-80}})));
  Buildings.Controls.OBC.CDL.Logical.And and2
    annotation (Placement(transformation(extent={{150,20},{170,40}})));
  Buildings.Controls.OBC.CDL.Logical.And and1
    annotation (Placement(transformation(extent={{150,-40},{170,-20}})));
  Buildings.Controls.OBC.CDL.Logical.And and3
    annotation (Placement(transformation(extent={{150,-70},{170,-50}})));
  Buildings.Controls.OBC.CDL.Logical.And and4
    annotation (Placement(transformation(extent={{150,-100},{170,-80}})));
  Buildings.Controls.OBC.CDL.Logical.And and5
    annotation (Placement(transformation(extent={{120,100},{140,120}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea
    annotation (Placement(transformation(extent={{-60,-160},{-40,-140}})));
  Buildings.Controls.OBC.CDL.Reals.Multiply mul
    annotation (Placement(transformation(extent={{-20,-170},{0,-150}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con(k=TExtCooSet)
    annotation (Placement(transformation(extent={{-100,-190},{-80,-170}})));
  Buildings.Controls.OBC.CDL.Reals.PID conPID1(
    k=0.1,
    Ti=1200,
    reverseActing=false)
    annotation (Placement(transformation(extent={{-60,-190},{-40,-170}})));
  Buildings.Controls.OBC.CDL.Logical.And and6
    annotation (Placement(transformation(extent={{14,20},{34,40}})));
  Buildings.Controls.OBC.CDL.Reals.PID conPID2(
    k=0.1,
    Ti=1200,
    reverseActing=true)
    annotation (Placement(transformation(extent={{60,-190},{80,-170}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea1
    annotation (Placement(transformation(extent={{60,-160},{80,-140}})));
  Buildings.Controls.OBC.CDL.Reals.Multiply mul1
    annotation (Placement(transformation(extent={{100,-170},{120,-150}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con1(k=TExtHeaSet)
    annotation (Placement(transformation(extent={{20,-190},{40,-170}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con2(k=TExtHeaSet + 12)
    annotation (Placement(transformation(extent={{-60,100},{-40,120}})));
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
  connect(coolingTowerControl.bus, bus.coolingTowerSystemBus) annotation (Line(
      points={{-100,96},{0.1,96},{0.1,140.1}},
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
  connect(intEqu.y, mulAnd.u[1]) annotation (Line(points={{-88,40},{-68,40},{-68,
          39.375},{-32,39.375}},                         color={255,0,255}));
  connect(conInt1.y, intEqu1.u2) annotation (Line(points={{-118,-30},{-114,-30},
          {-114,-18},{-112,-18}},
                           color={255,127,0}));
  connect(integerPassThrough.y, intEqu1.u1) annotation (Line(points={{-119,70},
          {-80,70},{-80,10},{-116,10},{-116,-10},{-112,-10}},           color={255,
          127,0}));
  connect(intEqu1.y, not2.u) annotation (Line(points={{-88,-10},{-74,-10},{-74,
          24},{-70,24}},
        color={255,0,255}));
  connect(not2.y, mulAnd.u[2]) annotation (Line(points={{-46,24},{-42,24},{-42,41.125},
          {-32,41.125}},                               color={255,0,255}));
  connect(conInt2.y, intEqu2.u2) annotation (Line(points={{-118,-90},{-114,-90},
          {-114,-78},{-112,-78}},
                           color={255,127,0}));
  connect(integerPassThrough.y, intEqu2.u1) annotation (Line(points={{-119,70},
          {-80,70},{-80,10},{-116,10},{-116,-10},{-146,-10},{-146,-70},{-112,
          -70}},                                                        color={255,
          127,0}));
  connect(intEqu2.y, not3.u) annotation (Line(points={{-88,-70},{-80,-70},{-80,
          -90},{-72,-90}},                                    color={255,0,255}));
  connect(not3.y, mulAnd.u[3]) annotation (Line(points={{-48,-90},{-42,-90},{-42,
          42.875},{-32,42.875}},                                 color={255,0,
          255}));
  connect(and2.y, bus.coolingInletValveBus.y1) annotation (Line(points={{172,30},
          {182,30},{182,66},{0.1,66},{0.1,140.1}},   color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(and1.y, bus.coolingOutletValveBus.y1) annotation (Line(points={{172,-30},
          {182,-30},{182,66},{0.1,66},{0.1,140.1}},        color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(and3.y, bus.wseInletValveBus.y1) annotation (Line(points={{172,-60},{182,
          -60},{182,66},{0.1,66},{0.1,140.1}},                        color={255,
          0,255}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(and4.y, bus.wseOutletValveBus.y1) annotation (Line(points={{172,-90},{
          182,-90},{182,66},{0.1,66},{0.1,140.1}},                    color={255,
          0,255}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(seqEveCoo.y1ValChiWatInlIso, and2.u1) annotation (Line(points={{62,-16},
          {80,-16},{80,30},{148,30}},
                                  color={255,0,255}));
  connect(seqEveCoo.y1ValChiWatInlIso, and3.u1) annotation (Line(points={{62,-16},
          {98,-16},{98,-60},{148,-60}},
                                      color={255,0,255}));
  connect(seqEveCoo.y1ValChiWatOutIso, and1.u1) annotation (Line(points={{62,-18},
          {96,-18},{96,-30},{148,-30}},color={255,0,255}));
  connect(seqEveCoo.y1ValChiWatOutIso, and4.u1) annotation (Line(points={{62,-18},
          {96,-18},{96,-30},{142,-30},{142,-66},{140,-66},{140,-90},{148,-90}},
                                       color={255,0,255}));
  connect(intEqu1.y, and3.u2) annotation (Line(points={{-88,-10},{-74,-10},{-74,
          -26},{-38,-26},{-38,-96},{90,-96},{90,-98},{146,-98},{146,-96},{148,-96},
          {148,-92},{150,-92},{150,-76},{142,-76},{142,-68},{148,-68}},
                              color={255,0,255}));
  connect(intEqu1.y, and4.u2) annotation (Line(points={{-88,-10},{-74,-10},{-74,
          -26},{-36,-26},{-36,-108},{148,-108},{148,-98}},
                                                color={255,0,255}));
  connect(intEqu2.y, and2.u2) annotation (Line(points={{-88,-70},{-80,-70},{-80,
          -38},{92,-38},{92,22},{148,22}},                              color={255,
          0,255}));
  connect(intEqu2.y, and1.u2) annotation (Line(points={{-88,-70},{-80,-70},{-80,
          -38},{148,-38}},                                      color={255,0,255}));
  connect(intEqu1.y, or2.u1) annotation (Line(points={{-88,-10},{-74,-10},{-74,-26},
          {-36,-26},{-36,-60},{-32,-60}},      color={255,0,255}));
  connect(intEqu2.y, or2.u2) annotation (Line(points={{-88,-70},{-80,-70},{-80,-38},
          {-40,-38},{-40,-68},{-32,-68}},
                                     color={255,0,255}));
  connect(bus.coolingTowerSystemBus.cooTowNotLoc, and5.u1) annotation (Line(
      points={{0.1,140.1},{0.1,110},{118,110}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(and5.y, bus.coolingPumpBus.y1) annotation (Line(points={{142,110},{148,
          110},{148,128},{0.1,128},{0.1,140.1}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(seqEveCoo.y1PumChiWatPri, and5.u2) annotation (Line(points={{62,-24},{
          100,-24},{100,102},{118,102}}, color={255,0,255}));
  connect(intEqu2.y, booToRea.u) annotation (Line(points={{-88,-70},{-80,-70},{-80,
          -150},{-62,-150}}, color={255,0,255}));
  connect(booToRea.y, mul.u1) annotation (Line(points={{-38,-150},{-32,-150},{-32,
          -154},{-22,-154}}, color={0,0,127}));

  connect(mul.y, bus.extCooModValveBus.y) annotation (Line(points={{2,-160},{
          8,-160},{8,2},{0.1,2},{0.1,140.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(con.y, conPID1.u_s)
    annotation (Line(points={{-78,-180},{-62,-180}}, color={0,0,127}));
  connect(conPID1.y, mul.u2) annotation (Line(points={{-38,-180},{-28,-180},{-28,
          -166},{-22,-166}}, color={0,0,127}));
  connect(bus.uPlaEna, mulAnd.u[4]) annotation (Line(
      points={{0,140},{0,58},{-40,58},{-40,44.625},{-32,44.625}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(or2.y, and6.u2)
    annotation (Line(points={{-8,-60},{12,-60},{12,22}}, color={255,0,255}));
  connect(and6.y, seqEveCoo.u1Coo) annotation (Line(points={{36,30},{42,30},{42,
          6},{34,6},{34,-6},{38,-6}}, color={255,0,255}));
  connect(bus.uPlaEna, and6.u1) annotation (Line(
      points={{0,140},{0,56},{6,56},{6,30},{12,30}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(con1.y, conPID2.u_s)
    annotation (Line(points={{42,-180},{58,-180}}, color={0,0,127}));
  connect(booToRea1.y, mul1.u1) annotation (Line(points={{82,-150},{88,-150},{88,
          -154},{98,-154}}, color={0,0,127}));
  connect(conPID2.y, mul1.u2) annotation (Line(points={{82,-180},{92,-180},{92,-166},
          {98,-166}}, color={0,0,127}));
  connect(intEqu.y, booToRea1.u) annotation (Line(points={{-88,40},{-76,40},{-76,
          -32},{20,-32},{20,-150},{58,-150}}, color={255,0,255}));
  connect(mul1.y, bus.extHeaModValveBus.y) annotation (Line(points={{122,-160},{
          128,-160},{128,70},{0.1,70},{0.1,140.1}},
                                               color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(con2.y, bus.heatPumpBus.TSet) annotation (Line(points={{-38,110},{0.1,
          110},{0.1,140.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(bus.THeaRet, conPID1.u_m) annotation (Line(
      points={{0,140},{0,-112},{14,-112},{14,-198},{-50,-198},{-50,-192}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(bus.TCooRet, conPID2.u_m) annotation (Line(
      points={{0,140},{0,-110},{18,-110},{18,-200},{70,-200},{70,-192}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(mul.y, bus.coolingPumpBus.y) annotation (Line(points={{2,-160},{8,-160},
          {8,2},{0.1,2},{0.1,140.1}},
                                color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(mul1.y, bus.heatingPumpBus.y) annotation (Line(points={{122,-160},{8,
          -160},{8,2},{0.1,2},{0.1,140.1}},
                                color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}),                                        graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,-100},{150,-140}},
          textString="%name",
          textColor={0,0,255})}),           Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-160,-200},{300,140}}), graphics={
        Rectangle(
          extent={{-154,82},{-6,-108}},
          lineColor={28,108,200},
          pattern=LinePattern.Dash),
        Rectangle(
          extent={{6,126},{76,-42}},
          lineColor={238,46,47},
          pattern=LinePattern.Dash),
        Rectangle(
          extent={{142,42},{190,-106}},
          lineColor={0,140,72},
          pattern=LinePattern.Dash),
        Text(
          extent={{-146,-108},{-8,-128}},
          textColor={28,108,200},
          textString="Identify components to enable based on
operation mode signal"),
        Text(
          extent={{14,-14},{86,-98}},
          textColor={238,46,47},
          textString="Safe staging of
cooling and heating
components"),
        Text(
          extent={{130,-78},{218,-176}},
          textColor={0,140,72},
          textString="Enable connection valves
from external energy loop
to central heat recovery")}));
end ExternalEnergy;
