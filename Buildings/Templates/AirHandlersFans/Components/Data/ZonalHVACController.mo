within Buildings.Templates.AirHandlersFans.Components.Data;
record ZonalHVACController
  "Record for zonal HVAC system controller"

  extends Buildings.Templates.AirHandlersFans.Components.Data.PartialController(
    final typFanRel=false,
    final typFanRet=false);

  parameter Real minFanSpe(
    final unit="1",
    displayUnit="1",
    final min=0)
    "Minimum allowed fan speed"
    annotation(Dialog(group="Fan parameters",
      enable= not has_mulFan_new));

  parameter Modelica.Units.SI.Time tFanEnaDel = 30
    "Time period for delay between switching from deadband mode to heating/cooling mode"
    annotation(Dialog(group="Fan parameters"));

  parameter Modelica.Units.SI.Time tFanEna = 300
    "Minimum duration for which fan is enabled"
    annotation(Dialog(group="Fan parameters"));

  parameter Integer nSpe(
    final min=2) = 2
    "Number of fan speeds"
    annotation(Dialog(group="Fan parameters",
      enable=has_mulFan_new));

  parameter Real fanSpe[nSpe](
    final min=fill(0, nSpe),
    final max=fill(1, nSpe),
    final unit=fill("1", nSpe),
    displayUnit=fill("1", nSpe)) = {0,1}
    "Fan speed values"
    annotation(Dialog(group="Fan parameters",
      enable=has_mulFan_new));

  parameter Modelica.Units.SI.Time tSpe=180
    "Minimum amount of time for which calculated speed exceeds preset value for 
    speed to be changed"
    annotation(Dialog(group="Fan parameters",
      enable=has_mulFan_new));

  parameter Modelica.Units.SI.TemperatureDifference dTHys = 0.2
    "Temperature difference used for enabling cooling and heating mode"
    annotation(Dialog(tab="Advanced"));

  parameter Buildings.Controls.OBC.CDL.Types.SimpleController controllerTypeCoo=Buildings.Controls.OBC.CDL.Types.SimpleController.PI
    "Type of cooling loop controller"
    annotation (Dialog(group="Cooling mode control"));

  parameter Real kCoo(
    final unit="1",
    displayUnit="1",
    final min=0)=1
    "Gain of cooling loop controller"
    annotation(Dialog(group="Cooling mode control"));

  parameter Modelica.Units.SI.Time TiCoo=0.5
    "Time constant of cooling loop integrator block"
    annotation(Dialog(group="Cooling mode control",
      enable = controllerTypeCoo == Buildings.Controls.OBC.CDL.Types.SimpleController.PI or
      controllerTypeCoo == Buildings.Controls.OBC.CDL.Types.SimpleController.PID));

  parameter Modelica.Units.SI.Time TdCoo=0.1
    "Time constant of cooling loop derivative block"
    annotation(Dialog(group="Cooling mode control",
      enable = controllerTypeCoo == Buildings.Controls.OBC.CDL.Types.SimpleController.PD or
      controllerTypeCoo == Buildings.Controls.OBC.CDL.Types.SimpleController.PID));

  parameter Real TSupDew(
    final unit="K",
    displayUnit="K",
    final quantity="ThermodynamicTemperature")=273.15 + 12
    "Supply air temperature limit under which condensation will be caused"
    annotation(Dialog(tab="Advanced"));

  parameter Buildings.Controls.OBC.CDL.Types.SimpleController controllerTypeHea=Buildings.Controls.OBC.CDL.Types.SimpleController.PI
    "Type of heating loop controller"
    annotation (Dialog(group="Heating mode control"));

  parameter Real kHea(
    final unit="1",
    displayUnit="1",
    final min=0)=1
    "Gain of heating loop controller"
    annotation(Dialog(group="Heating mode control"));

  parameter Modelica.Units.SI.Time TiHea=0.5
    "Time constant of heating loop integrator block"
    annotation(Dialog(group="Heating mode control",
      enable = controllerTypeHea == Buildings.Controls.OBC.CDL.Types.SimpleController.PI or
      controllerTypeHea == Buildings.Controls.OBC.CDL.Types.SimpleController.PID));

  parameter Modelica.Units.SI.Time TdHea=0.1
    "Time constant of heating loop derivative block"
    annotation(Dialog(group="Heating mode control",
      enable = controllerTypeHea == Buildings.Controls.OBC.CDL.Types.SimpleController.PD or
      controllerTypeHea == Buildings.Controls.OBC.CDL.Types.SimpleController.PID));

  parameter Modelica.Blocks.Types.SimpleController controllerTypeSupHea=Modelica.Blocks.Types.SimpleController.PI
    "Type of supplementary heating controller"
    annotation (Dialog(group="Supplementary heating control"));

  parameter Real kSupHea(
    final unit="1",
    displayUnit="1",
    final min=0)=1
    "Gain of supplementary heating controller"
    annotation (Dialog(group="Supplementary heating control"));

  parameter Modelica.Units.SI.Time TiSupHea=120
    "Time constant of Integrator block for supplementary heating"
    annotation (Dialog(group="Supplementary heating control"));

  parameter Modelica.Units.SI.Time TdSupHea=0.1
    "Time constant of Derivative block for supplementary heating"
    annotation (Dialog(group="Supplementary heating control"));

  parameter Real TLocOut(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")=273.15-8
    "Minimum outdoor dry-bulb temperature for compressor operation";

  parameter Real dTHeaSet(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")=-2
    "Constant value to reduce heating setpoint for supplementary heating"
    annotation(Dialog(group="Setpoint adjustment"));

  parameter Boolean has_mulFan_new = has_mulFan
    "Does the zone equipment have multiple speed fan?"
    annotation(Dialog(enable=false, tab="Non-configurable"));

  annotation (Documentation(info="<html>
<p>
This record provides the set of sizing and operating parameters for
multiple-zone VAV controllers within
<a href=\"modelica://Buildings.Templates.AirHandlersFans.Components.Controls\">
Buildings.Templates.AirHandlersFans.Components.Controls</a>.
</p>
</html>"));
end ZonalHVACController;
