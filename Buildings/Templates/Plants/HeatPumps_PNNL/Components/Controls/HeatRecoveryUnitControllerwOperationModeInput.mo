within Buildings.Templates.Plants.HeatPumps_PNNL.Components.Controls;
block HeatRecoveryUnitControllerwOperationModeInput
  Buildings.Templates.Plants.Controls.StagingRotation.EventSequencing seqEve(
    have_heaWat=true,
    have_chiWat=false,
    have_valInlIso=true,
    have_valOutIso=false,
    have_pumHeaWatPri=true,
    have_pumHeaWatSec=false)
    annotation (Placement(transformation(extent={{74,20},{94,48}})));
  Buildings.Controls.OBC.CDL.Logical.Or or1
    annotation (Placement(transformation(extent={{40,-20},{60,0}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant TSet(k=273.15 + 7.22)
    annotation (Placement(transformation(extent={{120,-170},{140,-150}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yHP
    "Heat pump enable signal" annotation (Placement(transformation(extent={{160,
            40},{200,80}}), iconTransformation(extent={{100,80},{140,120}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uHeaPumPro "Hot Water Pump Enable Signal" annotation (
      Placement(transformation(extent={{-140,-20},{-100,20}}),
        iconTransformation(extent={{-140,60},{-100,100}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uCooPumPro "Chilled Water Pump Enable Signal" annotation (
      Placement(transformation(extent={{-140,-60},{-100,-20}}),
        iconTransformation(extent={{-140,20},{-100,60}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yVal "Valve signal" annotation (
      Placement(transformation(extent={{160,0},{200,40}}), iconTransformation(
          extent={{100,40},{140,80}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yPum "Pump enable sigal" annotation (
      Placement(transformation(extent={{160,-40},{200,0}}), iconTransformation(
          extent={{100,0},{140,40}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput TSetHP
    "Heat Pump Setpoint Temperature" annotation (Placement(transformation(
          extent={{160,-180},{200,-140}}), iconTransformation(extent={{100,-120},
            {140,-80}})));
  Buildings.Templates.Plants.Controls.Pumps.Primary.EnableLeadHeadered enaLea(
    typCon=Buildings.Templates.Plants.Controls.Types.EquipmentConnection.Parallel,
    typValIso=Buildings.Templates.Plants.Controls.Types.Actuator.TwoPosition,
    nValIso=1)
    annotation (Placement(transformation(extent={{112,10},{132,30}})));

  Buildings.Templates.Plants.Controls.Pumps.Generic.ControlDifferentialPressure
    ctlDpHea(
    have_senDpRemWir=true,
    nPum=1,
    nSenDpRem=1)
    annotation (Placement(transformation(extent={{120,-50},{140,-30}})));
  Buildings.Templates.Plants.Controls.Pumps.Generic.ControlDifferentialPressure
    ctlDpCoo(
    have_senDpRemWir=true,
    nPum=1,
    nSenDpRem=1)
    annotation (Placement(transformation(extent={{120,-90},{140,-70}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yPumSpeHea annotation (
      Placement(transformation(extent={{160,-70},{200,-30}}),
        iconTransformation(extent={{100,-40},{140,0}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yPumSpeCoo annotation (
      Placement(transformation(extent={{160,-100},{200,-60}}),
        iconTransformation(extent={{100,-80},{140,-40}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uDpHea annotation (Placement(
        transformation(extent={{-140,-90},{-100,-50}}),   iconTransformation(
          extent={{-140,-20},{-100,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uDpCoo annotation (Placement(
        transformation(extent={{-140,-152},{-100,-112}}), iconTransformation(
          extent={{-140,-100},{-100,-60}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput uOpeMod annotation (
      Placement(transformation(extent={{-140,40},{-100,80}}),
        iconTransformation(extent={{-140,100},{-100,140}})));
  Buildings.Controls.OBC.CDL.Integers.GreaterThreshold intGreThr
    annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
  Buildings.Controls.OBC.CDL.Integers.LessThreshold intLesThr
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Buildings.Controls.OBC.CDL.Logical.Or or2
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uDpHeaSet annotation (
      Placement(transformation(extent={{-140,-120},{-100,-80}}),
        iconTransformation(extent={{-140,-60},{-100,-20}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uDpCooSet annotation (
      Placement(transformation(extent={{-140,-180},{-100,-140}}),
        iconTransformation(extent={{-140,-140},{-100,-100}})));
equation
  connect(or1.y, seqEve.u1PumHeaWatPri_actual)
    annotation (Line(points={{62,-10},{72,-10},{72,34}}, color={255,0,255}));
  connect(uHeaPumPro, or1.u1) annotation (Line(points={{-120,0},{0,0},{0,-10},{
          38,-10}},       color={255,0,255}));
  connect(uCooPumPro, or1.u2) annotation (Line(points={{-120,-40},{30,-40},{30,
          -18},{38,-18}},    color={255,0,255}));
  connect(seqEve.y1, yHP) annotation (Line(points={{96,46},{158,46},{158,60},{180,
          60}}, color={255,0,255}));
  connect(seqEve.y1ValHeaWatInlIso, yVal) annotation (Line(points={{96,36},{158,
          36},{158,20},{180,20}},color={255,0,255}));
  connect(TSet.y, TSetHP)
    annotation (Line(points={{142,-160},{180,-160}}, color={0,0,127}));
  connect(seqEve.y1ValHeaWatInlIso, enaLea.u1ValIso[1]) annotation (Line(points=
         {{96,36},{104,36},{104,20},{110,20}}, color={255,0,255}));
  connect(enaLea.y1, yPum) annotation (Line(points={{134,20},{154,20},{154,-20},
          {180,-20}}, color={255,0,255}));
  connect(ctlDpHea.y, yPumSpeHea) annotation (Line(points={{141.8,-40},{154,-40},
          {154,-50},{180,-50}}, color={0,0,127}));
  connect(ctlDpCoo.y, yPumSpeCoo)
    annotation (Line(points={{141.8,-80},{180,-80}}, color={0,0,127}));
  connect(uHeaPumPro, ctlDpHea.y1_actual[1]) annotation (Line(points={{-120,0},
          {0,0},{0,-32},{118,-32}},     color={255,0,255}));
  connect(uCooPumPro, ctlDpCoo.y1_actual[1]) annotation (Line(points={{-120,-40},
          {0,-40},{0,-72},{118,-72}},    color={255,0,255}));
  connect(uDpHea, ctlDpHea.dpRem[1]) annotation (Line(points={{-120,-70},{40,
          -70},{40,-40},{118,-40}},
                               color={0,0,127}));
  connect(uDpCoo, ctlDpCoo.dpRem[1]) annotation (Line(points={{-120,-132},{104,
          -132},{104,-80},{118,-80}},
                                color={0,0,127}));
  connect(uOpeMod, intGreThr.u)
    annotation (Line(points={{-120,60},{-62,60}}, color={255,127,0}));
  connect(uOpeMod, intLesThr.u) annotation (Line(points={{-120,60},{-68,60},{
          -68,30},{-62,30}}, color={255,127,0}));
  connect(intGreThr.y, or2.u1) annotation (Line(points={{-38,60},{-28,60},{-28,
          50},{-22,50}}, color={255,0,255}));
  connect(intLesThr.y, or2.u2) annotation (Line(points={{-38,30},{-30,30},{-30,
          42},{-22,42}}, color={255,0,255}));
  connect(or2.y, seqEve.u1Hea) annotation (Line(points={{2,50},{64,50},{64,46},
          {72,46}}, color={255,0,255}));
  connect(uDpHeaSet, ctlDpHea.dpRemSet[1]) annotation (Line(points={{-120,-100},
          {42,-100},{42,-36},{118,-36}}, color={0,0,127}));
  connect(uDpCooSet, ctlDpCoo.dpRemSet[1]) annotation (Line(points={{-120,-160},
          {0,-160},{0,-76},{118,-76}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-160},
            {100,160}}),                                        graphics={
          Rectangle(
          extent={{-100,160},{100,-160}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,200},{150,160}},
          textString="%name",
          textColor={0,0,255})}),           Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-180},{160,100}})));
end HeatRecoveryUnitControllerwOperationModeInput;
