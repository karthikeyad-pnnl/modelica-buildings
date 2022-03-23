within Buildings;
model test1
  parameter Boolean a=false;

  Modelica.Blocks.Sources.Constant const if a annotation (Placement(transformation(extent={{-46,32},{-26,52}})));
  Modelica.Blocks.Sources.Ramp ramp(duration=20) if
                                       not
                                          (a) annotation (Placement(transformation(extent={{-46,-20},{-26,0}})));
  Modelica.Blocks.Interfaces.RealOutput y
                                         annotation (Placement(transformation(extent={{100,-20},{140,20}})));
equation
  if a then
  connect(const.y,y);
  else
  connect(ramp.y,y);
  end if;

  annotation (uses(Modelica(version="4.0.0")));
end test1;
