within Buildings.Templates.Components.Data;
record Coil "Record for coil model"
  extends Modelica.Icons.Record;

  parameter Buildings.Templates.Components.Types.Coil typ
    "Equipment type"
    annotation (Dialog(group="Configuration", enable=false), Evaluate=true);
  parameter Buildings.Templates.Components.Types.Valve typVal
    "Type of valve"
    annotation (Dialog(group="Configuration", enable=false), Evaluate=true);
  parameter Boolean have_sou
    "Set to true for fluid ports on the source side"
    annotation (Dialog(group="Configuration"), Evaluate=true);

  annotation (Documentation(info="<html>
<p>
This record provides the set of sizing and operating parameters for
the classes within
<a href=\"modelica://Buildings.Templates.Components.Coils\">
Buildings.Templates.Components.Coils</a>.
</p>
</html>"));
end Coil;
