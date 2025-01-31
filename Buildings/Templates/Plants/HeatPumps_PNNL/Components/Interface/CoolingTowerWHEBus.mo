within Buildings.Templates.Plants.HeatPumps_PNNL.Components.Interface;
expandable connector CoolingTowerWHEBus "Control bus"
  extends Modelica.Icons.SignalBus;
  Buildings.Templates.Components.Interfaces.Bus coolingTowerBus;
  Buildings.Templates.Components.Interfaces.Bus condenserPumpBus;
  Buildings.Templates.Components.Interfaces.Bus tempControlValveBus;
  Buildings.Templates.Components.Interfaces.Bus heatExchBus;
  annotation (
    defaultComponentName="bus", Documentation(info="<html>
<p>
This expandable connector provides a standard interface for
all control signals of the component models.
</p>
</html>"));
end CoolingTowerWHEBus;
