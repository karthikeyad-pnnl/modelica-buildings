within Buildings.Extra.House.Rooms;

model WalledRoom "Model of single room with extended wall structure"
  extends
    .Extra.House.Rooms.Interfaces.PartialRoom;
  parameter .Modelica.SIunits.HeatCapacity C_wall=1e5
    "heat capacity in wall";

  .Modelica.Thermal.HeatTransfer.Components.HeatCapacitor
    airHeatCapacity(C=C_room) "Heat capacity in the room" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={10,10})));
  Components.Wall wall(
    G_wall=G_wall,
    Gc_wall=Gc_wall,
    C_wall=C_wall)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
equation
  connect(wallPort, wall.outside) annotation (Line(
      points={{-100,0},{-60,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(wall.inside, airHeatCapacity.port) annotation (Line(
      points={{-40,0},{10,0}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (Diagram(graphics), Icon(graphics={Rectangle(
                  extent={{-84,20},{-80,-100}},
                  lineColor={0,0,0},
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Forward,
                  lineThickness=0.5),Rectangle(
                  extent={{80,20},{84,-100}},
                  lineColor={0,0,0},
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Forward,
                  lineThickness=0.5)}));
end WalledRoom;
