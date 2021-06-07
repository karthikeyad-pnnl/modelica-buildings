within Buildings.Examples.BoilerPlant.StepTest;
block StepTestModel "Model to test step response of zone model"
  PlantModel.ZoneModel zoneModel(
    Q_flow_nominal=4359751.36,
    TRadSup_nominal=333.15,
    TRadRet_nominal=323.15,
    mRad_flow_nominal=96.323,
    V=126016.35,
    zonTheCap=6987976290)
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  PlantModel.ZoneModel_simplified zoneModel_simplified(
    Q_flow_nominal=4359751.36,
    TRadSup_nominal=333.15,
    TRadRet_nominal=323.15,
    mRad_flow_nominal=96.323,
    V=126016.35,
    zonTheCap=6987976290)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  BoundaryConditions.WeatherData.ReaderTMY3           weaDat(final filNam=
        ModelicaServices.ExternalReferences.loadResource(
        "modelica://Buildings/Resources/weatherdata/USA_NY_Buffalo-Greater.Buffalo.Intl.AP.725280_TMY3.mos"))
    "Weather data reader"
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
    tableOnFile=true,
    tableName="tab1",
    fileName=
        "C:/Users/deva713/OneDrive - PNNL/Documents/Git_repos/modelica-buildings/VM_script/inputTableTxt.txt",
    verboseRead=true,
    columns={2},
    timeScale=60) "Boiler thermal load from EnergyPlus simulation"
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));

  Modelica.Blocks.Sources.Constant const(k=98841.1979) "Constant plug load"
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  Controls.OBC.CDL.Continuous.Add add2
    annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
equation
  connect(weaDat.weaBus, zoneModel.weaBus) annotation (Line(
      points={{-40,70},{-20,70},{-20,47},{-7,47}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, zoneModel_simplified.weaBus) annotation (Line(
      points={{-40,70},{-20,70},{-20,7},{-7,7}},
      color={255,204,51},
      thickness=0.5));
  connect(const.y, add2.u1) annotation (Line(points={{-59,40},{-54,40},{-54,26},
          {-52,26}}, color={0,0,127}));
  connect(combiTimeTable.y[1], add2.u2) annotation (Line(points={{-59,0},{-54,0},
          {-54,14},{-52,14}}, color={0,0,127}));
  connect(add2.y, zoneModel.u) annotation (Line(points={{-28,20},{-16,20},{-16,
          40},{-12,40}}, color={0,0,127}));
  connect(add2.y, zoneModel_simplified.u) annotation (Line(points={{-28,20},{
          -16,20},{-16,0},{-12,0}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=14400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end StepTestModel;
