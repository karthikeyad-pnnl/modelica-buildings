within Buildings.Templates.AirHandlersFans.Validation.UserProject.AirHandlersFans;
model ZonalHVACPTHP
  "Configuration of packaged terminal heat pump using zonal HVAC tempelate"
  extends Buildings.Templates.AirHandlersFans.ZonalHVAC(
    redeclare Buildings.Templates.Components.Coils.DXHeatingSingleSpeed coiHeaPre,
    redeclare Buildings.Templates.Components.Coils.ElectricHeating coiHeaReh,
    redeclare Buildings.Templates.Components.Coils.EvaporatorVariableSpeed coiCoo);

equation
  connect(busWea, coiHeaReh.busWea) annotation (Line(
      points={{0,280},{0,100},{140,100},{140,-190},{136,-190}},
      color={255,204,51},
      thickness=0.5));
  connect(busWea, coiHeaPre.busWea) annotation (Line(
      points={{0,280},{0,-120},{16,-120},{16,-190}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  annotation (
    defaultComponentName="ahu", Documentation(info="<html>
<p><br>This is a configuration model with the same default options as <a href=\"modelica://Buildings.Templates.AirHandlersFans.VAVMultiZone\">Buildings.Templates.AirHandlersFans.VAVMultiZone</a> except for the following options.</p>
<table cellspacing=\"2\" cellpadding=\"0\" border=\"1\"><tr>
<td><p align=\"center\"><h4>Component</h4></p></td>
<td><p align=\"center\"><h4>Configuration</h4></p></td>
</tr>
<tr>
<td><p>Reheat coil</p></td>
<td><p>Single speed DX heating coil</p></td>
</tr>
</table>
</html>"));
end ZonalHVACPTHP;
