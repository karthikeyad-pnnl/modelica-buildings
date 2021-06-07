within Buildings.Examples.BoilerPlant.StepTest;
block TimeTable_trial "Model to test step response of zone model"
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
    tableOnFile=true,
    tableName="tab1",
    fileName=
        "C:/Users/deva713/OneDrive - PNNL/Documents/Git_repos/modelica-buildings/VM_script/inputTableTxt.txt",
    verboseRead=true,
    columns={2},
    timeScale=60) "Boiler thermal load from EnergyPlus simulation"
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=864000,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end TimeTable_trial;
