within Buildings.Templates.Plants.HeatPumps_PNNL.Components.Controls;
block FreeCooling
  Buildings.Templates.Components.Interfaces.Bus bus_cooTow annotation (
      Placement(transformation(extent={{-120,20},{-80,60}}), iconTransformation(
          extent={{-120,30},{-80,70}})));
  Buildings.Templates.Components.Interfaces.Bus bus_conPum annotation (
      Placement(transformation(extent={{-120,-60},{-80,-20}}),
        iconTransformation(extent={{-120,-70},{-80,-30}})));
  Buildings.Templates.Components.Interfaces.Bus bus_fan annotation (Placement(
        transformation(extent={{80,20},{120,60}}), iconTransformation(extent={{80,30},
            {120,70}})));
  Buildings.Templates.Components.Interfaces.Bus bus_valve annotation (Placement(
        transformation(extent={{80,-60},{120,-20}}), iconTransformation(extent={{80,-70},
            {120,-30}})));
  Buildings.Controls.OBC.CDL.Logical.And and2
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Buildings.Controls.OBC.CDL.Logical.Not not1
    annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
  Buildings.Controls.OBC.CDL.Reals.Switch swi
    annotation (Placement(transformation(extent={{50,-50},{70,-30}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con(k=1)
    annotation (Placement(transformation(extent={{10,-50},{30,-30}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con1(k=1)
    annotation (Placement(transformation(extent={{10,-80},{30,-60}})));
equation
  connect(bus_conPum.y1_actual, and2.u2) annotation (Line(
      points={{-100,-40},{-20,-40},{-20,-8},{-12,-8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(not1.y, and2.u1) annotation (Line(points={{-38,20},{-18,20},{-18,0},{-12,
          0}}, color={255,0,255}));
  connect(bus_cooTow.y1_actual, not1.u) annotation (Line(
      points={{-100,40},{-68,40},{-68,20},{-62,20}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(and2.y, bus_fan.y1) annotation (Line(points={{12,0},{74,0},{74,40},{
          100,40}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(swi.y, bus_valve.y) annotation (Line(points={{72,-40},{100,-40}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(and2.y, swi.u2) annotation (Line(points={{12,0},{40,0},{40,-40},{48,
          -40}}, color={255,0,255}));
  connect(con.y, swi.u1) annotation (Line(points={{32,-40},{38,-40},{38,-32},{
          48,-32}}, color={0,0,127}));
  connect(con1.y, swi.u3) annotation (Line(points={{32,-70},{40,-70},{40,-48},{
          48,-48}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}), Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end FreeCooling;
