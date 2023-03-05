within Buildings.Controls.OBC.CDL.CompositeBlocks.Validation;
model Proof
  Buildings.Controls.OBC.CDL.CompositeBlocks.Proof proof(
    meaDis=0.05,
    meaEna=0.10,
    mea_nominal=1,
    tau=30,
    tAla=45) annotation (Placement(transformation(extent={{40,40},{60,60}})));
  Logical.Sources.Pulse booPul(
    width=0.2,
    period=60,
    shift=0) annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  Conversions.BooleanToReal booToRea
    annotation (Placement(transformation(extent={{-10,60},{10,80}})));
  Buildings.Controls.OBC.CDL.CompositeBlocks.Proof proof1(
    meaDis=0.05,
    meaEna=0.10,
    mea_nominal=1,
    tau=30,
    tAla=45) annotation (Placement(transformation(extent={{40,-60},{60,-40}})));
  Conversions.BooleanToReal booToRea1(realTrue=0, realFalse=1)
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  Logical.Not not1
    annotation (Placement(transformation(extent={{-50,40},{-30,60}})));
equation
  connect(booToRea.y, proof.uMea) annotation (Line(points={{12,70},{20,70},{20,
          54},{38,54}}, color={0,0,127}));
  connect(booToRea1.y, proof1.uMea) annotation (Line(points={{12,-30},{20,-30},
          {20,-46},{38,-46}}, color={0,0,127}));
  connect(booPul.y, not1.u)
    annotation (Line(points={{-58,50},{-52,50}}, color={255,0,255}));
  connect(not1.y, booToRea.u) annotation (Line(points={{-28,50},{-20,50},{-20,
          70},{-12,70}}, color={255,0,255}));
  connect(not1.y, proof.uDes) annotation (Line(points={{-28,50},{-20,50},{-20,
          46},{38,46}}, color={255,0,255}));
  connect(not1.y, booToRea1.u) annotation (Line(points={{-28,50},{-20,50},{-20,
          -30},{-12,-30}}, color={255,0,255}));
  connect(not1.y, proof1.uDes) annotation (Line(points={{-28,50},{-20,50},{-20,
          -54},{38,-54}}, color={255,0,255}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Ellipse(
          lineColor={75,138,73},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          extent={{-100,-100},{100,100}}),
        Polygon(
          lineColor={0,0,255},
          fillColor={75,138,73},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{-36,60},{64,0},{-36,-60},{-36,60}})}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=60, __Dymola_Algorithm="Dassl"));
end Proof;
