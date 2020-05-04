within Buildings.Examples.Tutorial.CDL.Controls;
block ReturnTemperatureController
  parameter Real TRetSetPoi( final unit = "K", displayUnit = "degC", start = 273.15 + 60)
  "Set-point for return water temperature";
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TRet( final unit = "K", displayUnit="degC")
    "Measured return water temperature"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yVal( final unit = "1")
    "Control signal for return valve position"
    annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant retWatTemSetPoi(k=
        TRetSetPoi) "Set-point for return water temperature"
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Buildings.Controls.OBC.CDL.Continuous.LimPID conPID(
    controllerType=Buildings.Controls.OBC.CDL.Types.SimpleController.PI,
    Ti(displayUnit="min") = 300,
    yMax=1,
    yMin=0,
    reverseAction=true)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(retWatTemSetPoi.y, conPID.u_s) annotation (Line(points={{-38,30},{-24,
          30},{-24,0},{-12,0}}, color={0,0,127}));
  connect(conPID.u_m, TRet) annotation (Line(points={{0,-12},{0,-20},{-40,-20},
          {-40,0},{-120,0}}, color={0,0,127}));
  connect(conPID.y, yVal)
    annotation (Line(points={{12,0},{120,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ReturnTemperatureController;
