within Buildings.Examples.VAVReheat.BaseClasses;
model DemandLimitLevelGeneration

  Buildings.Controls.OBC.CDL.Interfaces.RealInput uShe "Shedding factor"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}}),
        iconTransformation(extent={{-140,-20},{-100,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerOutput yDemLimLev
    "Demand limit level signal" annotation (Placement(transformation(extent={{100,
            -20},{140,20}}), iconTransformation(extent={{100,-20},{140,20}})));
  Buildings.Controls.OBC.CDL.Integers.Switch intSwi
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Buildings.Controls.OBC.CDL.Integers.Switch intSwi1
    annotation (Placement(transformation(extent={{30,-40},{50,-20}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt(k=1)
    annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt1(k=2)
    annotation (Placement(transformation(extent={{0,-20},{20,0}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt2(k=3)
    annotation (Placement(transformation(extent={{30,10},{50,30}})));
  Buildings.Controls.OBC.CDL.Continuous.Hysteresis hys(uLow=0.45, uHigh=0.5)
    annotation (Placement(transformation(extent={{-70,70},{-50,90}})));
  Buildings.Controls.OBC.CDL.Continuous.Hysteresis hys1(uLow=0.2, uHigh=0.25)
    annotation (Placement(transformation(extent={{-70,40},{-50,60}})));
  Buildings.Controls.OBC.CDL.Continuous.Hysteresis hys2(uLow=0.05, uHigh=0.1)
    annotation (Placement(transformation(extent={{-70,10},{-50,30}})));
  Buildings.Controls.OBC.CDL.Logical.Latch lat[3]
    annotation (Placement(transformation(extent={{20,70},{40,90}})));
  Buildings.Controls.OBC.CDL.Logical.Timer tim[3](t=300)
    annotation (Placement(transformation(extent={{-20,70},{0,90}})));
  Buildings.Controls.OBC.CDL.Logical.Timer tim1[3](t=900)
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  Buildings.Controls.OBC.CDL.Integers.Switch intSwi2
    annotation (Placement(transformation(extent={{0,-70},{20,-50}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt3(k=0)
    annotation (Placement(transformation(extent={{-40,-90},{-20,-70}})));
  Buildings.Controls.OBC.CDL.Logical.Not not1[3]
    annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
equation
  connect(intSwi1.y, intSwi.u3) annotation (Line(points={{52,-30},{54,-30},{54,-8},
          {58,-8}}, color={255,127,0}));
  connect(conInt1.y, intSwi1.u1) annotation (Line(points={{22,-10},{26,-10},{26,
          -22},{28,-22}}, color={255,127,0}));
  connect(conInt2.y, intSwi.u1) annotation (Line(points={{52,20},{54,20},{54,8},
          {58,8}}, color={255,127,0}));
  connect(intSwi.y, yDemLimLev)
    annotation (Line(points={{82,0},{120,0}}, color={255,127,0}));
  connect(uShe, hys.u) annotation (Line(points={{-120,0},{-80,0},{-80,80},{-72,80}},
        color={0,0,127}));
  connect(uShe, hys1.u) annotation (Line(points={{-120,0},{-80,0},{-80,50},{-72,
          50}}, color={0,0,127}));
  connect(uShe, hys2.u) annotation (Line(points={{-120,0},{-80,0},{-80,20},{-72,
          20}}, color={0,0,127}));
  connect(intSwi2.y, intSwi1.u3) annotation (Line(points={{22,-60},{26,-60},{26,
          -38},{28,-38}}, color={255,127,0}));
  connect(conInt.y, intSwi2.u1) annotation (Line(points={{-18,-40},{-10,-40},{-10,
          -52},{-2,-52}}, color={255,127,0}));
  connect(conInt3.y, intSwi2.u3) annotation (Line(points={{-18,-80},{-10,-80},{-10,
          -68},{-2,-68}}, color={255,127,0}));
  connect(tim.passed, lat.u) annotation (Line(points={{2,72},{10,72},{10,80},{18,
          80}}, color={255,0,255}));
  connect(tim1.passed, lat.clr) annotation (Line(points={{2,42},{14,42},{14,74},
          {18,74}}, color={255,0,255}));
  connect(lat[1].y, intSwi2.u2) annotation (Line(points={{42,80},{50,80},{50,40},
          {20,40},{20,20},{-6,20},{-6,-60},{-2,-60}}, color={255,0,255}));
  connect(lat[2].y, intSwi1.u2) annotation (Line(points={{42,80},{50,80},{50,40},
          {24,40},{24,-30},{28,-30}}, color={255,0,255}));
  connect(lat[3].y, intSwi.u2) annotation (Line(points={{42,80},{50,80},{50,40},
          {56,40},{56,0},{58,0}}, color={255,0,255}));
  connect(hys2.y, tim[1].u) annotation (Line(points={{-48,20},{-34,20},{-34,80},
          {-22,80}}, color={255,0,255}));
  connect(hys1.y, tim[2].u) annotation (Line(points={{-48,50},{-34,50},{-34,80},
          {-22,80}}, color={255,0,255}));
  connect(hys.y, tim[3].u)
    annotation (Line(points={{-48,80},{-22,80}}, color={255,0,255}));
  connect(hys2.y, not1[1].u) annotation (Line(points={{-48,20},{-44,20},{-44,
          -10},{-42,-10}}, color={255,0,255}));
  connect(hys1.y, not1[2].u) annotation (Line(points={{-48,50},{-44,50},{-44,
          -10},{-42,-10}}, color={255,0,255}));
  connect(hys.y, not1[3].u) annotation (Line(points={{-48,80},{-44,80},{-44,-10},
          {-42,-10}}, color={255,0,255}));
  connect(not1.y, tim1.u) annotation (Line(points={{-18,-10},{-12,-10},{-12,20},
          {-28,20},{-28,50},{-22,50}}, color={255,0,255}));
  annotation (defaultComponentName="demLimLevGen",
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
end DemandLimitLevelGeneration;
