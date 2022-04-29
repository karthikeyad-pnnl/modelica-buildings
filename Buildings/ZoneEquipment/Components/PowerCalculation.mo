within Buildings.ZoneEquipment.Components;
block PowerCalculation
  Controls.OBC.CDL.Interfaces.RealInput TIn
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
  Controls.OBC.CDL.Interfaces.RealInput TOut
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Controls.OBC.CDL.Interfaces.RealInput V_flow
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
  Controls.OBC.CDL.Interfaces.RealOutput yP
    annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Controls.OBC.CDL.Continuous.Add add2(k2=-1)
    annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
  Controls.OBC.CDL.Continuous.Gain gai(k=1000)
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  Controls.OBC.CDL.Continuous.Product pro
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Controls.OBC.CDL.Continuous.Abs abs
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
equation
  connect(TOut, add2.u2) annotation (Line(points={{-120,0},{-70,0},{-70,14},{
          -62,14}}, color={0,0,127}));
  connect(TIn, add2.u1) annotation (Line(points={{-120,40},{-70,40},{-70,26},
          {-62,26}}, color={0,0,127}));
  connect(V_flow, gai.u)
    annotation (Line(points={{-120,-40},{-82,-40}}, color={0,0,127}));
  connect(add2.y, pro.u1) annotation (Line(points={{-38,20},{-20,20},{-20,6},
          {-12,6}}, color={0,0,127}));
  connect(gai.y, pro.u2) annotation (Line(points={{-58,-40},{-20,-40},{-20,-6},
          {-12,-6}}, color={0,0,127}));
  connect(pro.y, abs.u)
    annotation (Line(points={{12,0},{38,0}}, color={0,0,127}));
  connect(abs.y, yP)
    annotation (Line(points={{62,0},{120,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PowerCalculation;
