within Buildings.Extra.House.Rooms;

model Room "Model of single room"
  extends
    .Extra.House.Rooms.Interfaces.PartialRoom;

  .Modelica.Thermal.HeatTransfer.Components.HeatCapacitor
    airHeatCapacity(C=C_room) "Heat capacity of the air in the room"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={10,10})));
  Components.SimpleWall wall(G_wall=G_wall,Gc_wall=Gc_wall)
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
  annotation (
    uses(Modelica(version="3.1")),
    Diagram(graphics),
    Icon(graphics));
end Room;
