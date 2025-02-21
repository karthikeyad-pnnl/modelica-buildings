within Buildings.Templates.AirHandlersFans.Interfaces;
expandable connector ZonalHVACBus
  "Control bus for zonal HVAC systems"
  extends Modelica.Icons.SignalBus;

  Buildings.Templates.Components.Interfaces.Bus fanSup
    "Supply fan points"
    annotation (HideResult=false);

  Buildings.Templates.Components.Interfaces.Bus coiHea
    "Heating coil (preheat or reheat position, only one coil allowed) points"
    annotation (HideResult=false);
  Buildings.Templates.Components.Interfaces.Bus coiCoo
    "Cooling coil points"
    annotation (HideResult=false);

  Buildings.Templates.Components.Interfaces.Bus damOut
    "OA damper points"
    annotation (HideResult=false);

  Buildings.Templates.Components.Interfaces.Bus damRel
    "Relief damper points"
    annotation (HideResult=false);
  Buildings.Templates.Components.Interfaces.Bus damRet
    "Return damper points"
    annotation (HideResult=false);

  Buildings.Templates.Components.Interfaces.Bus coiHeaReh
    "Reheat coil connections (specifically used for reheat in PTHP"
    annotation(HideResult=false);
  Real TZon;
  Real TDryBul;
  Real TAirSup;

  annotation (
    defaultComponentName="bus", Documentation(info="<html>
<p>
This expandable connector provides a standard interface for
all control signals required by an air handler controller.
</p>
</html>"));
end ZonalHVACBus;
