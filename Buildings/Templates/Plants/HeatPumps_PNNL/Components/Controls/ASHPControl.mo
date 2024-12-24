within Buildings.Templates.Plants.HeatPumps_PNNL.Components.Controls;
block ASHPControl
  Buildings.Controls.OBC.CDL.Reals.PID conPID1(reverseActing=true)
    annotation (Placement(transformation(extent={{-30,10},{-10,30}})));
  Buildings.Controls.OBC.CDL.Reals.Line lin
    annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con(k=273.15 + 20)
    annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con5(k=0)
    annotation (Placement(transformation(extent={{0,50},{20,70}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con4(k=1)
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
  Buildings.Controls.OBC.CDL.Reals.AddParameter addPar(p=10)
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TRetCoo annotation (Placement(
        transformation(extent={{-140,-20},{-100,20}}), iconTransformation(
          extent={{-140,-20},{-100,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput TSet annotation (Placement(
        transformation(extent={{100,-20},{140,20}}), iconTransformation(extent=
            {{100,-20},{140,20}})));
equation
  connect(con.y,conPID1. u_s) annotation (Line(points={{-58,20},{-32,20}},
                               color={0,0,127}));
  connect(conPID1.y,lin. u)
    annotation (Line(points={{-8,20},{34,20},{34,0},{48,0}},color={0,0,127}));
  connect(con4.y,lin. x2) annotation (Line(points={{22,-50},{30,-50},{30,-4},{
          48,-4}},                             color={0,0,127}));
  connect(con5.y,lin. x1) annotation (Line(points={{22,60},{40,60},{40,8},{48,8}},
                 color={0,0,127}));
  connect(con.y,lin. f1) annotation (Line(points={{-58,20},{-38,20},{-38,40},{
          38,40},{38,4},{48,4}},
                           color={0,0,127}));
  connect(con.y,addPar. u) annotation (Line(points={{-58,20},{-48,20},{-48,-30},
          {-42,-30}},                                   color={0,0,127}));
  connect(addPar.y,lin. f2) annotation (Line(points={{-18,-30},{40,-30},{40,-8},
          {48,-8}},                                      color={0,0,127}));
  connect(TRetCoo, conPID1.u_m)
    annotation (Line(points={{-120,0},{-20,0},{-20,8}}, color={0,0,127}));
  connect(lin.y, TSet)
    annotation (Line(points={{72,0},{120,0}}, color={0,0,127}));
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
end ASHPControl;
