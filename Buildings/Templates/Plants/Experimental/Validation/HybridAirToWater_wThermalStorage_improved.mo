within Buildings.Templates.Plants.Experimental.Validation;
model HybridAirToWater_wThermalStorage_improved
  extends Buildings.Templates.Plants.Experimental.Validation.HybridAirToWater_wThermalStorage(
                                                                                              break
      primaryWarmup,
      redeclare BestInClass.ExperimentsFY26Q4.Controls.TankCharging_improved tankCharging,
    break or2,
    break connect(ctlDpSecHea.y, busPumSecHea.y),
    break connect(senVolFlo.V_flow, tankCharging.VTan_flow),
    break connect(conPID.y, reaScaRep.u));
  Buildings.Controls.OBC.CDL.Reals.Multiply mul
    annotation (Placement(transformation(extent={{-40,-250},{-20,-230}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea(realTrue=0,
      realFalse=1)
    annotation (Placement(transformation(extent={{-100,-260},{-80,-240}})));
equation
  connect(busPla.y1PlaEnaHea, staPumSecHea.u1Pla) annotation (Line(
      points={{-180,0},{-180,-28},{-192,-28},{-192,-88},{-176,-88},{-176,-142},
          {-42,-142}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(booToRea.y, mul.u2) annotation (Line(points={{-78,-250},{-52,-250},{
          -52,-246},{-42,-246}}, color={0,0,127}));
  connect(tankCharging.yPumHeaPriOve, booToRea.u) annotation (Line(points={{242,
          -168},{248,-168},{248,-368},{-112,-368},{-112,-250},{-102,-250}},
        color={255,0,255}));
  connect(ctlDpSecHea.y, busPumSecHea.y) annotation (Line(points={{-18,-190},{
          -12,-190},{-12,-180},{40,-180}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(conPID.y, mul.u1) annotation (Line(points={{162,-160},{172,-160},{172,
          -236},{168,-236},{168,-248},{-8,-248},{-8,-224},{-52,-224},{-52,-234},
          {-42,-234}}, color={0,0,127}));
  connect(mul.y, reaScaRep.u) annotation (Line(points={{-18,-240},{88,-240},{88,
          -184},{128,-184},{128,-168},{132,-168},{132,-144},{178,-144},{178,
          -160}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end HybridAirToWater_wThermalStorage_improved;
