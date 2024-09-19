within Buildings.Templates.Plants.HeatPumps_PNNL.Components.Controls;
block HeatingCoilValveOverride
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TSupHea "Hot Water Supply Temperature" annotation (Placement(
        transformation(extent={{-140,-60},{-100,-20}}),
                                                     iconTransformation(extent={{-140,
            -60},{-100,-20}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TOut
    "Outdoor air temperature" annotation (Placement(transformation(extent={{
            -140,20},{-100,60}}), iconTransformation(extent={{-140,20},{-100,60}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yHeaCoiValOve
    "Heating coil valve override signal" annotation (Placement(transformation(
          extent={{100,-40},{140,0}}), iconTransformation(extent={{100,20},{140,
            60}})));

  Buildings.Controls.OBC.CDL.Reals.GreaterThreshold greThr(t=273.15 + 75)
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  Buildings.Controls.OBC.CDL.Reals.LessThreshold lesThr(t=273.15 + 5)
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  Buildings.Controls.OBC.CDL.Logical.And and2
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  Buildings.Controls.OBC.CDL.Logical.Timer tim(t=300)
    annotation (Placement(transformation(extent={{0,0},{20,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yHeaCoiVal annotation (
      Placement(transformation(extent={{100,0},{140,40}}), iconTransformation(
          extent={{100,-60},{140,-20}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea
    annotation (Placement(transformation(extent={{60,10},{80,30}})));
equation
  connect(TSupHea, greThr.u)
    annotation (Line(points={{-120,-40},{-82,-40}}, color={0,0,127}));
  connect(TOut, lesThr.u)
    annotation (Line(points={{-120,40},{-82,40}}, color={0,0,127}));
  connect(greThr.y, and2.u2) annotation (Line(points={{-58,-40},{-50,-40},{-50,
          2},{-42,2}}, color={255,0,255}));
  connect(lesThr.y, and2.u1) annotation (Line(points={{-58,40},{-50,40},{-50,10},
          {-42,10}}, color={255,0,255}));
  connect(and2.y, tim.u)
    annotation (Line(points={{-18,10},{-2,10}}, color={255,0,255}));
  connect(tim.passed, yHeaCoiValOve) annotation (Line(points={{22,2},{80,2},{80,
          -20},{120,-20}}, color={255,0,255}));
  connect(tim.passed, booToRea.u) annotation (Line(points={{22,2},{40,2},{40,20},
          {58,20}}, color={255,0,255}));
  connect(booToRea.y, yHeaCoiVal)
    annotation (Line(points={{82,20},{120,20}}, color={0,0,127}));
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
