within Buildings.Fluid.Storage.Ice.Validation;
model cosim_mockup
  extends Modelica.Icons.Example;

  TESS_W_interfaces tESS_W_interfaces(SOC_start=0.1, tESS(con1(k=273.15 - 5)))
    annotation (Placement(transformation(extent={{-10,0},{10,20}})));
  Modelica.Blocks.Sources.CombiTimeTable datRea(
    final fileName=ModelicaServices.ExternalReferences.loadResource("./Buildings/Resources/Data/Fluid/Storage/Ice/Validation/cosim_mockup/mat_file_data.dat"),
    final tableOnFile=true,
    final columns=2:6,
    final tableName="EnergyPlus",
    final smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments)
    "Reader for EnergyPlus example results"
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));

  Controls.OBC.CDL.Continuous.MultiplyByParameter gai(k=-1)
    annotation (Placement(transformation(extent={{-20,30},{0,50}})));
  Modelica.Blocks.Math.UnitConversions.From_degC from_degC
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  Modelica.Blocks.Math.UnitConversions.From_degC from_degC1
    annotation (Placement(transformation(extent={{-20,-70},{0,-50}})));
equation
  connect(datRea.y[2], tESS_W_interfaces.mCHW_flow) annotation (Line(points={{-59,
          40},{-36,40},{-36,0},{-12,0}}, color={0,0,127}));
  connect(gai.y, tESS_W_interfaces.uQReq) annotation (Line(points={{2,40},{10,
          40},{10,28},{-46,28},{-46,12},{-12,12}}, color={0,0,127}));
  connect(datRea.y[1], from_degC.u) annotation (Line(points={{-59,40},{-36,40},
          {-36,-30},{-22,-30}}, color={0,0,127}));
  connect(from_degC.y, tESS_W_interfaces.TOut) annotation (Line(points={{1,-30},
          {10,-30},{10,-6},{-28,-6},{-28,18},{-12,18}}, color={0,0,127}));
  connect(datRea.y[4], from_degC1.u) annotation (Line(points={{-59,40},{-36,40},
          {-36,-60},{-22,-60}}, color={0,0,127}));
  connect(from_degC1.y, tESS_W_interfaces.TRet) annotation (Line(points={{1,-60},
          {22,-60},{22,-12},{-20,-12},{-20,6},{-12,6}}, color={0,0,127}));
  connect(datRea.y[5], gai.u)
    annotation (Line(points={{-59,40},{-22,40}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=172800,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end cosim_mockup;
