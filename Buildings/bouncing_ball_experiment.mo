within Buildings;
model bouncing_ball_experiment
    .Buildings.bouncing_ball bouncing_ball(h0 = 1.0) annotation(Placement(transformation(extent = {{12,6},{32,26}},origin = {0,0},rotation = 0)));
    .Buildings.Buildings_bouncing_ball.Buildings_bouncing_ball buildings_bouncing_ball annotation(Placement(transformation(extent = {{14,-36},{34,-16}},origin = {0,0},rotation = 0)));
    annotation(Icon(coordinateSystem(preserveAspectRatio = false,extent = {{-100.0,-100.0},{100.0,100.0}}),graphics = {Rectangle(lineColor={0,0,0},fillColor={230,230,230},fillPattern=FillPattern.Solid,extent={{-100.0,-100.0},{100.0,100.0}}),Text(lineColor={0,0,255},extent={{-150,150},{150,110}},textString="%name")}));
end bouncing_ball_experiment;
