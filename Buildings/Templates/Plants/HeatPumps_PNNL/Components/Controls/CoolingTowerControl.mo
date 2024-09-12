within Buildings.Templates.Plants.HeatPumps_PNNL.Components.Controls;
block CoolingTowerControl
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con(k=273.15 + 20)
    annotation (Placement(transformation(extent={{-90,-40},{-70,-20}})));
  Interface.CoolingTowerWHEBus bus annotation (Placement(transformation(extent={{-20,
            -160},{20,-120}}),     iconTransformation(extent={{-120,-20},{-80,
            20}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con1(k=true)
    annotation (Placement(transformation(extent={{-120,100},{-100,120}})));
  Buildings.Controls.OBC.CDL.Reals.PID conPID(reverseActing=false)
    annotation (Placement(transformation(extent={{20,-22},{40,-2}})));
  Buildings.Controls.OBC.CDL.Logical.Switch logSwi
    annotation (Placement(transformation(extent={{-80,80},{-60,100}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con2(k=false)
    annotation (Placement(transformation(extent={{-120,60},{-100,80}})));
  Buildings.Controls.OBC.CDL.Reals.Switch swi
    annotation (Placement(transformation(extent={{80,-30},{100,-10}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con3(k=0)
    annotation (Placement(transformation(extent={{40,-60},{60,-40}})));
  Modelica.Blocks.Routing.BooleanPassThrough booleanPassThrough
    annotation (Placement(transformation(extent={{-120,30},{-100,50}})));
  Modelica.Blocks.Routing.RealPassThrough realPassThrough
    annotation (Placement(transformation(extent={{-120,-20},{-100,0}})));
  Buildings.Controls.OBC.CDL.Reals.PID conPID1(
    k=0.2,
    Ti=600,                                    reverseActing=false)
    annotation (Placement(transformation(extent={{-50,0},{-30,20}})));
  Buildings.Controls.OBC.CDL.Reals.Line lin
    annotation (Placement(transformation(extent={{-12,-22},{8,-2}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con4(k=1)
    annotation (Placement(transformation(extent={{-50,-40},{-30,-20}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con5(k=0)
    annotation (Placement(transformation(extent={{-50,30},{-30,50}})));
  Buildings.Controls.OBC.CDL.Reals.AddParameter addPar(p=-5)
    annotation (Placement(transformation(extent={{-50,-70},{-30,-50}})));
  Buildings.Controls.OBC.CDL.Logical.MultiAnd
                                         mulAnd(nin=3)
    annotation (Placement(transformation(extent={{-28,80},{-8,100}})));
  Buildings.Controls.OBC.CDL.Reals.Hysteresis hys(uLow=273.15 + 5, uHigh=273.15
         + 7.5)
    annotation (Placement(transformation(extent={{-80,120},{-60,140}})));
  Buildings.Controls.OBC.CDL.Reals.Hysteresis hys1(uLow=0.6, uHigh=0.8)
    annotation (Placement(transformation(extent={{60,70},{80,90}})));
  Buildings.Controls.OBC.CDL.Logical.Timer tim(t=300)
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  Buildings.Controls.OBC.CDL.Reals.PID conPID2(
    k=0.2,
    Ti=600,
    reverseActing=true)
    annotation (Placement(transformation(extent={{80,30},{100,50}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con6(k=0.5)
    annotation (Placement(transformation(extent={{60,0},{80,20}})));
  Buildings.Controls.OBC.CDL.Logical.And and1
    annotation (Placement(transformation(extent={{80,110},{100,130}})));
equation
  connect(bus.coolingTowerOutputTemp, conPID.u_m) annotation (Line(
      points={{0,-140},{0,-40},{30,-40},{30,-24}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(con1.y, logSwi.u1) annotation (Line(points={{-98,110},{-90,110},{-90,
          98},{-82,98}},
                    color={255,0,255}));
  connect(con2.y, logSwi.u3)
    annotation (Line(points={{-98,70},{-90,70},{-90,82},{-82,82}},
                                                        color={255,0,255}));
  connect(swi.y, bus.heatExchBus.y) annotation (Line(points={{102,-20},{130,-20},
          {130,-118},{24,-118},{24,-116},{0.1,-116},{0.1,-139.9}},
                                          color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(conPID.y, swi.u1) annotation (Line(points={{42,-12},{78,-12}},
                            color={0,0,127}));
  connect(swi.u3, con3.y)
    annotation (Line(points={{78,-28},{70,-28},{70,-50},{62,-50}},
                                                       color={0,0,127}));
  connect(booleanPassThrough.y, swi.u2) annotation (Line(points={{-99,40},{-92,
          40},{-92,60},{44,60},{44,-20},{78,-20}},
                                  color={255,0,255}));
  connect(bus.uEna, booleanPassThrough.u) annotation (Line(
      points={{0,-140},{0,-84},{-130,-84},{-130,40},{-122,40}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(realPassThrough.y, conPID1.u_m) annotation (Line(points={{-99,-10},{
          -40,-10},{-40,-2}},                   color={0,0,127}));
  connect(con.y, conPID1.u_s) annotation (Line(points={{-68,-30},{-58,-30},{-58,
          10},{-52,10}}, color={0,0,127}));
  connect(lin.y, conPID.u_s)
    annotation (Line(points={{10,-12},{18,-12}},           color={0,0,127}));
  connect(conPID1.y, lin.u)
    annotation (Line(points={{-28,10},{-20,10},{-20,-12},{-14,-12}},
                                                          color={0,0,127}));
  connect(con4.y, lin.x2) annotation (Line(points={{-28,-30},{-20,-30},{-20,-16},
          {-14,-16}},
                    color={0,0,127}));
  connect(con5.y, lin.x1)
    annotation (Line(points={{-28,40},{-14,40},{-14,-4}}, color={0,0,127}));
  connect(con.y, lin.f1) annotation (Line(points={{-68,-30},{-58,-30},{-58,-8},
          {-14,-8}},                                             color={0,0,127}));
  connect(addPar.y, lin.f2)
    annotation (Line(points={{-28,-60},{-14,-60},{-14,-20}},color={0,0,127}));
  connect(con.y, addPar.u) annotation (Line(points={{-68,-30},{-58,-30},{-58,
          -60},{-52,-60}},
        color={0,0,127}));
  connect(bus.TRetHea, realPassThrough.u) annotation (Line(
      points={{0,-140},{0,-82},{-128,-82},{-128,-10},{-122,-10}},
      color={255,204,51},
      thickness=0.5));

  connect(booleanPassThrough.y, logSwi.u2) annotation (Line(points={{-99,40},{
          -92,40},{-92,90},{-82,90}},
                                color={255,0,255}));
  connect(mulAnd.y, bus.coolingTowerBus.y1) annotation (Line(points={{-6,90},{
          14,90},{14,-92},{0.1,-92},{0.1,-139.9}},
        color={255,0,255}));
  connect(bus.TOut, hys.u) annotation (Line(
      points={{0,-140},{0,-86},{-132,-86},{-132,130},{-82,130}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(conPID.y, hys1.u) annotation (Line(points={{42,-12},{50,-12},{50,80},
          {58,80}},                     color={0,0,127}));
  connect(hys1.y, tim.u)
    annotation (Line(points={{82,80},{98,80}}, color={255,0,255}));
  connect(conPID.y, conPID2.u_s) annotation (Line(points={{42,-12},{50,-12},{50,
          52},{70,52},{70,40},{78,40}},
                            color={0,0,127}));
  connect(con6.y, conPID2.u_m) annotation (Line(points={{82,10},{90,10},{90,28}},
                                                    color={0,0,127}));
  connect(conPID2.y, bus.coolingTowerBus.y) annotation (Line(points={{102,40},{
          112,40},{112,-110},{0.1,-110},{0.1,-139.9}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(logSwi.y, and1.u2) annotation (Line(points={{-58,90},{-50,90},{-50,
          112},{78,112}},                            color={255,0,255}));
  connect(hys.y, and1.u1) annotation (Line(points={{-58,130},{70,130},{70,120},
          {78,120}},
        color={255,0,255}));
  connect(and1.y, bus.condenserPumpBus.y1) annotation (Line(points={{102,120},{
          134,120},{134,-112},{0.1,-112},{0.1,-139.9}},
                                   color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(hys.y, mulAnd.u[1]) annotation (Line(points={{-58,130},{-40,130},{-40,
          87.6667},{-30,87.6667}},
                          color={255,0,255}));
  connect(tim.passed, mulAnd.u[2]) annotation (Line(points={{122,72},{122,58},{
          -34,58},{-34,90},{-30,90}},                color={255,0,255}));
  connect(logSwi.y, mulAnd.u[3]) annotation (Line(points={{-58,90},{-44,90},{
          -44,92.3333},{-30,92.3333}},                 color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,
            -140},{140,140}}),                                  graphics={
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
