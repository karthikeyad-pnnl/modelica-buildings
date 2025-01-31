within Buildings.Templates.Plants.HeatPumps_PNNL.Components.Interface;
expandable connector ExternalEnergyLoop "Control bus"
  extends Modelica.Icons.SignalBus;
  Buildings.Templates.Plants.HeatPumps_PNNL.Components.Interface.CoolingTowerWHEBus
    coolingTowerSystemBus;
  Buildings.Templates.Components.Interfaces.Bus coolingPumpBus;
  Buildings.Templates.Components.Interfaces.Bus heatingPumpBus;
  Buildings.Templates.Components.Interfaces.Bus heatingInletValveBus;
  Buildings.Templates.Components.Interfaces.Bus heatingOutletValveBus;
  Buildings.Templates.Components.Interfaces.Bus coolingInletValveBus;
  Buildings.Templates.Components.Interfaces.Bus coolingOutletValveBus;
  Buildings.Templates.Components.Interfaces.Bus heatPumpBus;
  Buildings.Templates.Components.Interfaces.Bus wseInletValveBus;
  Buildings.Templates.Components.Interfaces.Bus wseOutletValveBus;
  Buildings.Templates.Components.Interfaces.Bus extCooModValveBus;
  Buildings.Templates.Components.Interfaces.Bus extHeaModValveBus;
  annotation (
    defaultComponentName="bus", Documentation(info="<html>
<p>
This expandable connector provides a standard interface for
all control signals of the component models.
</p>
</html>"));
end ExternalEnergyLoop;
