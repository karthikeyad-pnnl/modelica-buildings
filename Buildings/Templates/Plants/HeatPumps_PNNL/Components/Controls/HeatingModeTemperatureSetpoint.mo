within Buildings.Templates.Plants.HeatPumps_PNNL.Components.Controls;
block HeatingModeTemperatureSetpoint
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant TSetCooMin2(each k=1)
    "Dedicated primary HW pump speed signal"
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant TSetCooMax(each k=273.15 + 20)
            "Dedicated primary HW pump speed signal"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Buildings.Controls.OBC.CDL.Reals.PID conPID(Ti=1e6, reverseActing=false)
    annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant TSetCooMin(each k=273.15 + 7.66)
              "Dedicated primary HW pump speed signal"
    annotation (Placement(transformation(extent={{-80,90},{-60,110}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant TSetCooMin1(each k=0)
    "Dedicated primary HW pump speed signal"
    annotation (Placement(transformation(extent={{-30,90},{-10,110}})));
  Buildings.Controls.OBC.CDL.Reals.Switch swi
    annotation (Placement(transformation(extent={{70,-10},{90,10}})));
  Buildings.Controls.OBC.CDL.Integers.LessThreshold intLesThr
    annotation (Placement(transformation(extent={{0,-30},{20,-10}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant TSetHeaMax(each k=273.15 + 65)
            "Dedicated primary HW pump speed signal"
    annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
  Buildings.Controls.OBC.CDL.Reals.Line lin
    annotation (Placement(transformation(extent={{0,20},{20,40}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TSupHea annotation (Placement(
        transformation(extent={{-140,-20},{-100,20}}), iconTransformation(
          extent={{-140,-20},{-100,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput uOpeMod annotation (
      Placement(transformation(extent={{-140,20},{-100,60}}),
        iconTransformation(extent={{-140,20},{-100,60}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput TSetHP annotation (Placement(
        transformation(extent={{100,-20},{140,20}}), iconTransformation(extent={
            {100,-20},{140,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uSetHP annotation (Placement(
        transformation(extent={{-140,-60},{-100,-20}}), iconTransformation(
          extent={{-140,-60},{-100,-20}})));
equation
  connect(TSetCooMin2.y, lin.x2) annotation (Line(points={{-38,30},{-30,30},{-30,
          26},{-2,26}},                     color={0,0,127}));
  connect(TSetCooMax.y, lin.f2) annotation (Line(points={{-38,0},{-10,0},{-10,22},
          {-2,22}},       color={0,0,127}));
  connect(conPID.y, lin.u)
    annotation (Line(points={{-18,60},{-10,60},{-10,30},{-2,30}},
                                                  color={0,0,127}));
  connect(TSetHeaMax.y,conPID. u_s) annotation (Line(points={{-58,60},{-42,60}},
                                color={0,0,127}));
  connect(TSetCooMin.y, lin.f1) annotation (Line(points={{-58,100},{-36,100},{-36,
          84},{-8,84},{-8,34},{-2,34}},
                          color={0,0,127}));
  connect(TSetCooMin1.y, lin.x1) annotation (Line(points={{-8,100},{-2,100},{-2,
          38}},                             color={0,0,127}));
  connect(lin.y,swi. u1) annotation (Line(points={{22,30},{60,30},{60,8},{68,8}},
                                       color={0,0,127}));
  connect(intLesThr.y,swi. u2)
    annotation (Line(points={{22,-20},{40,-20},{40,0},{68,0}},
                                                 color={255,0,255}));
  connect(uOpeMod, intLesThr.u) annotation (Line(points={{-120,40},{-68,40},{-68,
          -20},{-2,-20}}, color={255,127,0}));
  connect(swi.y, TSetHP)
    annotation (Line(points={{92,0},{120,0}}, color={0,0,127}));
  connect(TSupHea, conPID.u_m) annotation (Line(points={{-120,0},{-66,0},{-66,46},
          {-36,46},{-36,42},{-30,42},{-30,48}}, color={0,0,127}));
  connect(uSetHP, swi.u3) annotation (Line(points={{-120,-40},{50,-40},{50,-8},{
          68,-8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),
                          Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-60},{100,120}})));
end HeatingModeTemperatureSetpoint;
