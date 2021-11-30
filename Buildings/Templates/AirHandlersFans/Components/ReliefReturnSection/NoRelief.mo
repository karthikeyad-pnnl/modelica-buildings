within Buildings.Templates.AirHandlersFans.Components.ReliefReturnSection;
model NoRelief "No relief branch"
  extends
    Buildings.Templates.AirHandlersFans.Components.ReliefReturnSection.Interfaces.PartialReliefReturnSection(
    final typ=Buildings.Templates.AirHandlersFans.Types.ReliefReturnSection.NoRelief,
    final typDamRel=Buildings.Templates.Components.Types.Damper.None,
    final typFanRel=Buildings.Templates.Components.Types.Fan.None,
    final typFanRet=fanRet.typ,
    have_recHea=false);

  replaceable Buildings.Templates.Components.Fans.None fanRet
    constrainedby Buildings.Templates.Components.Fans.Interfaces.PartialFan(
      redeclare final package Medium = MediumAir,
      final m_flow_nominal=m_flow_nominal,
      final dp_nominal=dpFan_nominal,
      final have_senFlo=
        typCtrFanRet==Buildings.Templates.AirHandlersFans.Types.ControlFanReturn.Airflow,
      final text_flip=true)
    "Return fan"
    annotation (
    choices(
      choice(redeclare Buildings.Templates.Components.Fans.None fanRet
        "No fan"),
      choice(redeclare Buildings.Templates.Components.Fans.SingleVariable fanRet
        "Single fan - Variable speed"),
      choice(redeclare Buildings.Templates.Components.Fans.MultipleVariable fanRet
        "Multiple fans (identical) - Variable speed")),
    Dialog(group="Exhaust/relief/return section"),
    Placement(transformation(extent={{70,-10},{50,10}})));

  Buildings.Templates.Components.Sensors.DifferentialPressure pRet_rel(
    redeclare final package Medium = MediumAir,
    final have_sen=typCtrFanRet==Buildings.Templates.AirHandlersFans.Types.ControlFanReturn.Pressure,
    final m_flow_nominal=m_flow_nominal) "Return static pressure sensor"
    annotation (Placement(transformation(extent={{50,-50},{70,-30}})));

equation
  /* Control point connection - start */
  connect(fanRet.bus, bus.fanRet);
   connect(pRet_rel.y, bus.pRet_rel);
  /* Control point connection - end */
  connect(port_a, fanRet.port_a)
    annotation (Line(points={{180,0},{70,0}},  color={0,127,255}));
  connect(pRet_rel.port_b, port_bPre)
    annotation (Line(points={{70,-40},{80,-40},{80,-140}}, color={0,127,255}));
  connect(fanRet.port_b, port_bRet)
    annotation (Line(points={{50,0},{0,0},{0,-140}}, color={0,127,255}));
  connect(fanRet.port_b, pRet_rel.port_a) annotation (Line(points={{50,0},{40,0},
          {40,-40},{50,-40}}, color={0,127,255}));
  annotation (Icon(graphics={
              Line(
          points={{0,0},{180,0}},
          color={28,108,200},
          thickness=1),
              Line(
          points={{0,0},{0,-140}},
          color={28,108,200},
          thickness=1)}));
end NoRelief;