within Buildings.Extra.House.Rooms.Interfaces;

partial model PartialRoom "Partial room model"
  parameter .Modelica.SIunits.Volume V_room=4*3.7*5 "volume of room";
  parameter .Modelica.SIunits.ThermalConductance G_wall=375
    "thermal conductance in wall";
  parameter .Modelica.SIunits.HeatCapacity C_room=1410*V_room
    "heat capacity of room";
  parameter .Modelica.SIunits.ThermalConductance Gc_wall=176
    "convective thermal conductance wall/air in room";

  .Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a wallPort
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}),
        iconTransformation(extent={{-112,-10},{-92,10}})));
  annotation (Icon(graphics={Polygon(
                    points={{-100,20},{0,100},{100,20},{-100,20}},
                    lineColor={0,0,0},
                    smooth=Smooth.None,
                    fillColor={0,0,0},
                    fillPattern=FillPattern.CrossDiag),Rectangle(
                    extent={{-80,20},{80,-100}},
                    lineColor={0,0,0},
                    lineThickness=1,
                    fillColor={255,255,255},
                    fillPattern=FillPattern.Solid),Rectangle(
                    extent={{-40,-20},{0,-100}},
                    lineColor={0,0,0},
                    lineThickness=1,
                    fillColor={0,0,0},
                    fillPattern=FillPattern.CrossDiag)}));
end PartialRoom;
