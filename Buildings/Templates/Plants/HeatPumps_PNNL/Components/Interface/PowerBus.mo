within Buildings.Templates.Plants.HeatPumps_PNNL.Components.Interface;
expandable connector PowerBus
  "Power bus"
  extends Modelica.Icons.SignalBus;
  Buildings.Templates.Components.Interfaces.Bus coolingPumpBus;
  Buildings.Templates.Components.Interfaces.Bus heatingPumpBus;
  Buildings.Templates.Components.Interfaces.Bus heatPumpBus;
  Buildings.Templates.Components.Interfaces.Bus coolingTowerBus;
  Buildings.Templates.Components.Interfaces.Bus condenserPumpBus;
  Buildings.Templates.Components.Interfaces.Bus extLoopCoolingPumpBus;
  Buildings.Templates.Components.Interfaces.Bus extLoopHeatingPumpBus;
  Buildings.Templates.Components.Interfaces.Bus ashpBus;
  annotation (
    defaultComponentName="bus", Documentation(info="<html>
<p>
This expandable connector provides a standard interface for
all control signals of the component models.
</p>
</html>"));
end PowerBus;
