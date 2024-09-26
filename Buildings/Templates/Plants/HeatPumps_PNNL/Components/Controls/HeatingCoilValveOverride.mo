within Buildings.Templates.Plants.HeatPumps_PNNL.Components.Controls;
block HeatingCoilValveOverride
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TSupHea
    "Hot Water Supply Temperature"                                                       annotation (Placement(
        transformation(extent={{-140,-60},{-100,-20}}),
                                                     iconTransformation(extent={{-140,
            -40},{-100,0}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TRetHea
    "Outdoor air temperature" annotation (Placement(transformation(extent={{-140,
            20},{-100,60}}), iconTransformation(extent={{-140,40},{-100,80}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yHeaCoiValOve
    "Heating coil valve override signal" annotation (Placement(transformation(
          extent={{100,-40},{140,0}}), iconTransformation(extent={{100,20},{140,
            60}})));

  Buildings.Controls.OBC.CDL.Reals.GreaterThreshold greThr(t=273.15 + 70, h=5)
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  Buildings.Controls.OBC.CDL.Logical.And and2
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yHeaCoiVal annotation (
      Placement(transformation(extent={{100,0},{140,40}}), iconTransformation(
          extent={{100,-60},{140,-20}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uVen annotation (Placement(
        transformation(extent={{-140,-100},{-100,-60}}), iconTransformation(
          extent={{-140,-80},{-100,-40}})));
  Buildings.Controls.OBC.CDL.Logical.Or or2
    annotation (Placement(transformation(extent={{30,-40},{50,-20}})));
  Buildings.Controls.OBC.CDL.Reals.PID conPID(
    k=0.02,
    Ti=1e6,
    reverseActing=false)
    annotation (Placement(transformation(extent={{20,50},{40,70}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con(k=273.15 + 70)
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Buildings.Controls.OBC.CDL.Reals.Multiply mul
    annotation (Placement(transformation(extent={{70,-10},{90,10}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con1(k=false)
    annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uHeaPID
    "Hot Water Supply Temperature" annotation (Placement(transformation(extent=
            {{-140,-20},{-100,20}}), iconTransformation(extent={{-140,0},{-100,
            40}})));
  Buildings.Controls.OBC.CDL.Reals.LessThreshold lesThr1(t=0.075, h=0.025)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Buildings.Controls.OBC.CDL.Reals.LessThreshold lesThr2(t=273.15 + 20, h=2.5)
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  Buildings.Controls.OBC.CDL.Logical.Or or1
    annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
  Buildings.Controls.OBC.CDL.Reals.PID conPID1(
    controllerType=Buildings.Controls.OBC.CDL.Types.SimpleController.PID,
    k=0.02,
    Ti=1e6) annotation (Placement(transformation(extent={{-60,70},{-40,90}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con2(k=273.15 + 15)
    annotation (Placement(transformation(extent={{-90,70},{-70,90}})));
  Buildings.Controls.OBC.CDL.Reals.Max max1
    annotation (Placement(transformation(extent={{60,30},{80,50}})));
equation
  connect(TSupHea, greThr.u)
    annotation (Line(points={{-120,-40},{-82,-40}}, color={0,0,127}));
  connect(uVen, or2.u2) annotation (Line(points={{-120,-80},{20,-80},{20,-38},{
          28,-38}}, color={255,0,255}));
  connect(or2.y, yHeaCoiValOve) annotation (Line(points={{52,-30},{82,-30},{82,
          -20},{120,-20}}, color={255,0,255}));
  connect(TSupHea, conPID.u_m) annotation (Line(points={{-120,-40},{-88,-40},{
          -88,16},{-44,16},{-44,24},{30,24},{30,48}}, color={0,0,127}));
  connect(con.y, conPID.u_s)
    annotation (Line(points={{12,60},{18,60}}, color={0,0,127}));
  connect(yHeaCoiVal, mul.y) annotation (Line(points={{120,20},{94,20},{94,0},{
          92,0}}, color={0,0,127}));
  connect(booToRea.y, mul.u2)
    annotation (Line(points={{42,0},{60,0},{60,-6},{68,-6}}, color={0,0,127}));
  connect(and2.y, booToRea.u) annotation (Line(points={{-18,10},{10,10},{10,0},
          {18,0}}, color={255,0,255}));
  connect(and2.y, or2.u1) annotation (Line(points={{-18,10},{10,10},{10,-30},{
          28,-30}}, color={255,0,255}));
  connect(uHeaPID, lesThr1.u)
    annotation (Line(points={{-120,0},{-82,0}}, color={0,0,127}));
  connect(lesThr1.y, and2.u1) annotation (Line(points={{-58,0},{-50,0},{-50,10},
          {-42,10}}, color={255,0,255}));
  connect(TRetHea, lesThr2.u)
    annotation (Line(points={{-120,40},{-82,40}}, color={0,0,127}));
  connect(lesThr2.y, or1.u1)
    annotation (Line(points={{-58,40},{-42,40}}, color={255,0,255}));
  connect(greThr.y, or1.u2) annotation (Line(points={{-58,-40},{-52,-40},{-52,
          32},{-42,32}}, color={255,0,255}));
  connect(or1.y, and2.u2) annotation (Line(points={{-18,40},{-8,40},{-8,26},{
          -46,26},{-46,2},{-42,2}}, color={255,0,255}));
  connect(con2.y, conPID1.u_s)
    annotation (Line(points={{-68,80},{-62,80}}, color={0,0,127}));
  connect(TRetHea, conPID1.u_m) annotation (Line(points={{-120,40},{-88,40},{
          -88,62},{-50,62},{-50,68}}, color={0,0,127}));
  connect(max1.y, mul.u1) annotation (Line(points={{82,40},{88,40},{88,14},{62,
          14},{62,6},{68,6}}, color={0,0,127}));
  connect(conPID.y, max1.u2) annotation (Line(points={{42,60},{52,60},{52,34},{
          58,34}}, color={0,0,127}));
  connect(conPID1.y, max1.u1) annotation (Line(points={{-38,80},{48,80},{48,46},
          {58,46}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}),                                        graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-100,100},{100,100}},
          textString="%name",
          textColor={0,0,255})}),           Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}})));
end HeatingCoilValveOverride;
