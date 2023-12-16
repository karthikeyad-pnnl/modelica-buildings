within Buildings.Fluid.Storage.Ice.Validation;
model controlTrial
  extends Modelica.Icons.Example;


  Buildings.Utilities.IO.Python_3_8.Real_Real pyt(
    samplePeriod=60,
    moduleName=simulation_classes,
    functionName=test_Modelica_python,
    nDblWri=1,
    nDblRea=1,
    passPythonObject=true)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Buildings.Utilities.Time.ModelTime modTim
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
equation
  connect(modTim.y, pyt.uR[1])
    annotation (Line(points={{-59,0},{-12,0}}, color={0,0,127}));
  annotation (
  experiment(Tolerance=1e-6, StopTime=86400),
  __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Fluid/Storage/Ice/Validation/controlTrial.mos"
        "Simulate and plot"),
  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end controlTrial;
