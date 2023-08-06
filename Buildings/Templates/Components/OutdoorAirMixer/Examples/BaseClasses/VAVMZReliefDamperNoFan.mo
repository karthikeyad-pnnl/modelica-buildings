within Buildings.Templates.Components.OutdoorAirMixer.Examples.BaseClasses;
model VAVMZReliefDamperNoFan "Configuration of multiple-zone VAV"
  extends
    Buildings.Templates.Components.OutdoorAirMixer.Examples.BaseClasses.VAVMultiZone(
      redeclare replaceable
      Buildings.Templates.Components.OutdoorAirMixer.Examples.BaseClasses.OpenLoop
      ctl "Open loop controller", nZon=2);

  annotation (
    defaultComponentName="ahu", Documentation(info="<html>
<p>
This is a configuration model with the same default options as
<a href=\"modelica://Buildings.Templates.AirHandlersFans.VAVMultiZone\">
Buildings.Templates.AirHandlersFans.VAVMultiZone</a>
except for the following options.<br/>
</p>
<table summary=\"summary\" border=\"1\">
<tr><th>Component</th><th>Configuration</th></tr>
<tr><td>Outdoor air section</td><td>No economizer</td></tr>
<tr><td>Relief/return air section</td><td>No economizer</td></tr>
</table>
</html>"));
end VAVMZReliefDamperNoFan;