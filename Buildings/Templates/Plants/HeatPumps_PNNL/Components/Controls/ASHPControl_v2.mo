within Buildings.Templates.Plants.HeatPumps_PNNL.Components.Controls;
block ASHPControl_v2
  Buildings.Controls.OBC.CDL.Reals.PID conPID1
    annotation (Placement(transformation(extent={{-10,-90},{10,-70}})));
  Buildings.Controls.OBC.CDL.Reals.Line lin
    annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con(k=273.15 + 20)
    annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con5(k=0)
    annotation (Placement(transformation(extent={{0,50},{20,70}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con4(k=1)
    annotation (Placement(transformation(extent={{0,-30},{20,-10}})));
  Buildings.Controls.OBC.CDL.Reals.AddParameter addPar(p=20)
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TRetCoo annotation (Placement(
        transformation(extent={{-140,-20},{-100,20}}), iconTransformation(
          extent={{-140,0},{-100,40}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput TSet annotation (Placement(
        transformation(extent={{100,-20},{140,20}}), iconTransformation(extent={{100,0},
            {140,40}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TOut annotation (Placement(
        transformation(extent={{-140,-60},{-100,-20}}), iconTransformation(
          extent={{-140,-40},{-100,0}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yCooHeaExc annotation (
      Placement(transformation(extent={{100,-60},{140,-20}}),
        iconTransformation(extent={{100,-40},{140,0}})));
  Buildings.Controls.OBC.CDL.Reals.AddParameter addPar1(p=20)
    annotation (Placement(transformation(extent={{0,0},{20,20}})));
  Buildings.Controls.OBC.CDL.Reals.PID conPID2(reverseActing=false)
    annotation (Placement(transformation(extent={{50,-70},{70,-50}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con1(k=0.9)
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
equation
  connect(con4.y,lin. x2) annotation (Line(points={{22,-20},{34,-20},{34,-4},{
          48,-4}},                             color={0,0,127}));
  connect(con5.y,lin. x1) annotation (Line(points={{22,60},{40,60},{40,8},{48,8}},
                 color={0,0,127}));
  connect(con.y,lin. f1) annotation (Line(points={{-58,20},{-38,20},{-38,40},{
          38,40},{38,4},{48,4}},
                           color={0,0,127}));
  connect(TRetCoo, conPID1.u_m)
    annotation (Line(points={{-120,0},{-44,0},{-44,-88},{0,-88},{0,-92}},
                                                        color={0,0,127}));
  connect(lin.y, TSet)
    annotation (Line(points={{72,0},{120,0}}, color={0,0,127}));
  connect(TOut, addPar.u)
    annotation (Line(points={{-120,-40},{-82,-40}}, color={0,0,127}));
  connect(addPar.y, conPID1.u_s) annotation (Line(points={{-58,-40},{-18,-40},{
          -18,-80},{-12,-80}}, color={0,0,127}));
  connect(con.y, addPar1.u) annotation (Line(points={{-58,20},{-10,20},{-10,10},
          {-2,10}}, color={0,0,127}));
  connect(addPar1.y, lin.f2) annotation (Line(points={{22,10},{32,10},{32,-8},{
          48,-8}}, color={0,0,127}));
  connect(conPID1.y, yCooHeaExc) annotation (Line(points={{12,-80},{34,-80},{34,
          -40},{120,-40}}, color={0,0,127}));
  connect(conPID1.y, conPID2.u_m) annotation (Line(points={{12,-80},{46,-80},{
          46,-78},{60,-78},{60,-72}}, color={0,0,127}));
  connect(con1.y, conPID2.u_s) annotation (Line(points={{22,-50},{40,-50},{40,
          -60},{48,-60}}, color={0,0,127}));
  connect(conPID2.y, lin.u) annotation (Line(points={{72,-60},{78,-60},{78,-16},
          {42,-16},{42,0},{48,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,140},{150,100}},
          textString="%name",
          textColor={0,0,255})}), Diagram(coordinateSystem(preserveAspectRatio=
            false)));
end ASHPControl_v2;
