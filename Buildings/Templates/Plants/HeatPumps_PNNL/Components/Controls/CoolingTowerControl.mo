within Buildings.Templates.Plants.HeatPumps_PNNL.Components.Controls;
block CoolingTowerControl
  parameter Real TExtCooSupSet = 273.15+15;
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con(k=TExtCooSupSet)
    annotation (Placement(transformation(extent={{-120,20},{-100,40}})));
  Interface.CoolingTowerWHEBus bus annotation (Placement(transformation(extent=
            {{-20,-160},{20,-120}}), iconTransformation(extent={{-120,-20},{-80,
            20}})));
  Buildings.Controls.OBC.CDL.Reals.Switch swi
    annotation (Placement(transformation(extent={{80,0},{100,20}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con3(k=0)
    annotation (Placement(transformation(extent={{40,-20},{60,0}})));
  Modelica.Blocks.Routing.BooleanPassThrough booleanPassThrough
    annotation (Placement(transformation(extent={{-120,90},{-100,110}})));
  Modelica.Blocks.Routing.RealPassThrough realPassThrough
    annotation (Placement(transformation(extent={{-120,-20},{-100,0}})));
  Buildings.Controls.OBC.CDL.Reals.PID conPID1(
    k=0.1,
    Ti=1200,                                   reverseActing=false)
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Buildings.Controls.OBC.CDL.Logical.MultiAnd
                                         mulAnd(nin=3)
    annotation (Placement(transformation(extent={{40,80},{60,100}})));
  Buildings.Controls.OBC.CDL.Reals.Hysteresis hys(uLow=273.15 + 2, uHigh=273.15
         + 4)
    annotation (Placement(transformation(extent={{-80,120},{-60,140}})));
  Buildings.Controls.OBC.CDL.Reals.Hysteresis hys1(uLow=0.5, uHigh=0.9)
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  Buildings.Controls.OBC.CDL.Logical.Timer tim(t=300)
    annotation (Placement(transformation(extent={{-10,20},{10,40}})));
  Buildings.Controls.OBC.CDL.Reals.PID conPID2(
    k=0.2,
    Ti=600,
    reverseActing=true)
    annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con6(k=0.6)
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  Buildings.Controls.OBC.CDL.Logical.And and1
    annotation (Placement(transformation(extent={{80,110},{100,130}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con1(k=true)
    annotation (Placement(transformation(extent={{40,120},{60,140}})));
equation
  connect(swi.y, bus.heatExchBus.y) annotation (Line(points={{102,10},{110,10},{
          110,-110},{0.1,-110},{0.1,-139.9}},
                                          color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(swi.u3, con3.y)
    annotation (Line(points={{78,2},{70,2},{70,-10},{62,-10}},
                                                       color={0,0,127}));
  connect(booleanPassThrough.y, swi.u2) annotation (Line(points={{-99,100},{-88,
          100},{-88,90},{20,90},{20,10},{78,10}},
                                  color={255,0,255}));
  connect(bus.uEna, booleanPassThrough.u) annotation (Line(
      points={{0,-140},{0,-84},{-130,-84},{-130,100},{-122,100}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(realPassThrough.y, conPID1.u_m) annotation (Line(points={{-99,-10},{-70,
          -10},{-70,18}},                       color={0,0,127}));
  connect(con.y, conPID1.u_s) annotation (Line(points={{-98,30},{-82,30}},
                         color={0,0,127}));

  connect(mulAnd.y, bus.coolingTowerBus.y1) annotation (Line(points={{62,90},{120,
          90},{120,-52},{0.1,-52},{0.1,-139.9}},
        color={255,0,255}));
  connect(bus.TOut, hys.u) annotation (Line(
      points={{0,-140},{0,-86},{-132,-86},{-132,130},{-82,130}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(hys1.y, tim.u)
    annotation (Line(points={{-18,30},{-12,30}},
                                               color={255,0,255}));
  connect(con6.y, conPID2.u_m) annotation (Line(points={{-58,-40},{-30,-40},{-30,
          -22}},                                    color={0,0,127}));
  connect(conPID2.y, bus.coolingTowerBus.y) annotation (Line(points={{-18,-10},{
          0.1,-10},{0.1,-139.9}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(and1.y, bus.condenserPumpBus.y1) annotation (Line(points={{102,120},{
          134,120},{134,-112},{0.1,-112},{0.1,-139.9}},
                                   color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(hys.y, mulAnd.u[1]) annotation (Line(points={{-58,130},{-40,130},{-40,
          98},{38,98},{38,87.6667}},
                          color={255,0,255}));
  connect(tim.passed, mulAnd.u[2]) annotation (Line(points={{12,22},{38,22},{38,
          90}},                                      color={255,0,255}));
  connect(booleanPassThrough.y, mulAnd.u[3]) annotation (Line(points={{-99,100},
          {-88,100},{-88,90},{20,90},{20,92.3333},{38,92.3333}},   color={255,0,
          255}));
  connect(booleanPassThrough.y, and1.u2) annotation (Line(points={{-99,100},{-88,
          100},{-88,112},{78,112}},                                    color={
          255,0,255}));
  connect(conPID1.y, conPID2.u_s) annotation (Line(points={{-58,30},{-50,30},{-50,
          -10},{-42,-10}},
                        color={0,0,127}));
  connect(conPID1.y, hys1.u) annotation (Line(points={{-58,30},{-42,30}},
                                    color={0,0,127}));
  connect(conPID1.y, swi.u1) annotation (Line(points={{-58,30},{-50,30},{-50,18},
          {78,18}},  color={0,0,127}));
  connect(hys.y, bus.cooTowNotLoc) annotation (Line(points={{-58,130},{30,130},{
          30,-52},{0,-52},{0,-140}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(bus.coolingTowerOutputTemp, realPassThrough.u) annotation (Line(
      points={{0,-140},{0,-56},{-128,-56},{-128,-10},{-122,-10}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(con1.y, and1.u1) annotation (Line(points={{62,130},{72,130},{72,120},
          {78,120}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),                                  graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,140},{150,100}},
          textString="%name",
          textColor={0,0,255})}),           Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-140,-140},{140,140}})));
end CoolingTowerControl;
