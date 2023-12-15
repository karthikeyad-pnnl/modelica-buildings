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
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end controlTrial;
