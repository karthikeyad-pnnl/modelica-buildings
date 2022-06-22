within Buildings.Examples.VAVReheat.BaseClasses;
model ShedFactor

  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yShe
    "Calculated shed factor for next timestep"
    annotation (Placement(transformation(extent={{100,-20},{140,20}}),
      iconTransformation(extent={{100,-20},{140,20}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput PGenPre
    "Predicted power generation" annotation (Placement(transformation(extent={{-140,
            20},{-100,60}}), iconTransformation(extent={{-140,20},{-100,60}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput PConPre
    "Predicted power consumption" annotation (Placement(transformation(extent={{
            -140,-60},{-100,-20}}), iconTransformation(extent={{-140,-60},{-100,
            -20}})));
  Buildings.Controls.OBC.CDL.Continuous.Subtract sub
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Buildings.Controls.OBC.CDL.Continuous.LessThreshold lesThr
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea(realTrue=-1)
    annotation (Placement(transformation(extent={{20,20},{40,40}})));
  Buildings.Controls.OBC.CDL.Continuous.Divide div
    annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
  Buildings.Controls.OBC.CDL.Continuous.Multiply mul
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Buildings.Controls.OBC.CDL.Continuous.AddParameter addPar(p=1e-6)
    annotation (Placement(transformation(extent={{-40,-46},{-20,-26}})));
equation
  connect(PGenPre, sub.u1) annotation (Line(points={{-120,40},{-50,40},{-50,6},{
          -42,6}}, color={0,0,127}));
  connect(PConPre, sub.u2) annotation (Line(points={{-120,-40},{-50,-40},{-50,-6},
          {-42,-6}}, color={0,0,127}));
  connect(sub.y, lesThr.u) annotation (Line(points={{-18,0},{-10,0},{-10,16},{-30,
          16},{-30,30},{-22,30}}, color={0,0,127}));
  connect(lesThr.y, booToRea.u)
    annotation (Line(points={{2,30},{18,30}}, color={255,0,255}));
  connect(sub.y, div.u1) annotation (Line(points={{-18,0},{-10,0},{-10,-24},{18,
          -24}}, color={0,0,127}));
  connect(mul.y, yShe)
    annotation (Line(points={{82,0},{120,0}}, color={0,0,127}));
  connect(div.y, mul.u2) annotation (Line(points={{42,-30},{50,-30},{50,-6},{58,
          -6}}, color={0,0,127}));
  connect(booToRea.y, mul.u1)
    annotation (Line(points={{42,30},{50,30},{50,6},{58,6}}, color={0,0,127}));
  connect(PConPre, addPar.u) annotation (Line(points={{-120,-40},{-50,-40},{-50,
          -36},{-42,-36}}, color={0,0,127}));
  connect(addPar.y, div.u2)
    annotation (Line(points={{-18,-36},{18,-36}}, color={0,0,127}));
  annotation (defaultComponentName="sheFac",
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
                                        Text(
        extent={{-100,140},{100,100}},
        textString="%name",
        textColor={0,0,255})}),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ShedFactor;
