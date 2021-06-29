within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChilledBeamSystem.SetPoints;
block OperatingMode
  "Block with sequences for picking system operating mode"

  parameter Integer modInt[3] = {0,0,0}
    "";

  parameter Real schTab[nSchRow,2] = [0,1; 6,1; 18,1; 24,1]
    "Table defining schedule for enabling plant";

  CDL.Interfaces.BooleanInput uDetOcc[2] "Detected occupancy" annotation (
      Placement(transformation(extent={{-140,30},{-100,70}}),
        iconTransformation(extent={{-188,52},{-148,92}})));
  CDL.Continuous.Sources.TimeTable                        enaSch(
    final table=schTab,
    final smoothness=Buildings.Controls.OBC.CDL.Types.Smoothness.ConstantSegments,
    final timeScale=3600) "Table defining when occupancy is expected"
    annotation (Placement(transformation(extent={{-90,0},{-70,20}})));

  CDL.Logical.IntegerSwitch intSwi "Integer switch"
    annotation (Placement(transformation(extent={{20,50},{40,70}})));
  CDL.Interfaces.BooleanOutput y annotation (Placement(transformation(extent={{100,
            -70},{140,-30}}), iconTransformation(extent={{-192,14},{-152,54}})));
  CDL.Interfaces.BooleanOutput y1 annotation (Placement(transformation(extent={{
            100,30},{140,70}}), iconTransformation(extent={{-192,22},{-152,62}})));
  CDL.Integers.Sources.Constant conInt(k=Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChilledBeamSystem.Types.OperationModeTypes.occupied)
    "Constant integer for occupied mode"
    annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
  CDL.Logical.IntegerSwitch intSwi1 "Integer switch"
    annotation (Placement(transformation(extent={{-20,0},{0,20}})));
  CDL.Integers.Sources.Constant conInt1(k=Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChilledBeamSystem.Types.OperationModeTypes.unoccupiedScheduled)
    "Constant integer for unoccupiedScheduled mode"
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  CDL.Integers.Sources.Constant conInt2(k=Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChilledBeamSystem.Types.OperationModeTypes.unoccupiedUnscheduled)
    "Constant integer for unoccupiedUnscheduled mode"
    annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
  CDL.Logical.MultiOr mulOr(nu=2) "Multi Or"
    annotation (Placement(transformation(extent={{-20,50},{0,70}})));
  CDL.Integers.Equal intEqu[3] "Check which mode is currently active"
    annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
  CDL.Integers.Sources.Constant conInt3[3](k=modInt)
    "Constant integer source with operation mode enumeration"
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
  CDL.Routing.IntegerReplicator intRep(nout=3) "Integer replicator"
    annotation (Placement(transformation(extent={{50,50},{70,70}})));
protected
  CDL.Continuous.GreaterThreshold                        greThr(final t=0.5)
    "Convert Real signal to Boolean"
    annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
equation
  connect(enaSch.y[1],greThr. u)
    annotation (Line(points={{-68,10},{-62,10}},       color={0,0,127}));
  connect(conInt.y, intSwi.u1) annotation (Line(points={{-58,80},{10,80},{10,68},
          {18,68}}, color={255,127,0}));
  connect(conInt1.y, intSwi1.u1) annotation (Line(points={{-38,40},{-30,40},{-30,
          18},{-22,18}}, color={255,127,0}));
  connect(conInt2.y, intSwi1.u3) annotation (Line(points={{-38,-20},{-30,-20},{-30,
          2},{-22,2}}, color={255,127,0}));
  connect(greThr.y, intSwi1.u2)
    annotation (Line(points={{-38,10},{-22,10}}, color={255,0,255}));
  connect(intSwi1.y, intSwi.u3) annotation (Line(points={{2,10},{10,10},{10,52},
          {18,52}}, color={255,127,0}));
  connect(uDetOcc, mulOr.u[1:2]) annotation (Line(points={{-120,50},{-80,50},{-80,
          56.5},{-22,56.5}}, color={255,0,255}));
  connect(mulOr.y, intSwi.u2)
    annotation (Line(points={{2,60},{18,60}}, color={255,0,255}));
  connect(intSwi.y, intRep.u)
    annotation (Line(points={{42,60},{48,60}}, color={255,127,0}));
  connect(intRep.y, intEqu.u1) annotation (Line(points={{72,60},{80,60},{80,-30},
          {-30,-30},{-30,-50},{-22,-50}}, color={255,127,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end OperatingMode;
