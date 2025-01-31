within Buildings.Templates.Plants.HeatPumps_PNNL.Components.Interface;
expandable connector HeatRecoveryUnit "Control bus"
  extends Modelica.Icons.SignalBus;
  Buildings.Templates.Plants.HeatPumps.Interfaces.Bus plantControlBus;
  Buildings.Templates.Components.Interfaces.Bus coolingPumpBus;
  Buildings.Templates.Components.Interfaces.Bus heatingPumpBus;
  annotation (
    defaultComponentName="bus", Documentation(info="<html>
<p>
This expandable connector provides a standard interface for
all control signals of the component models.
</p>
</html>"));
end HeatRecoveryUnit;
