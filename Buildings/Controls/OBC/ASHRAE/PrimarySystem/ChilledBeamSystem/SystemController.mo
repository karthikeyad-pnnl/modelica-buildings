within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChilledBeamSystem;
block SystemController "Main chilled beam system controller"
  SecondaryPumps.Controller secPumCon(nSen=1)
    annotation (Placement(transformation(extent={{0,20},{20,40}})));
  SetPoints.ChilledWaterStaticPressureSetpointReset chiWatStaPreSetRes
    annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
  SetPoints.BypassValvePosition bypValPos
    annotation (Placement(transformation(extent={{40,60},{60,80}})));
  CDL.Interfaces.BooleanInput uPumSta[nPum] "Pump status from plant"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  CDL.Integers.Sources.Constant conInt[nPum](k=pumStaOrd)
    "Constant integer source"
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  CDL.Interfaces.RealInput dPChiWatLoo
    "Measured chilled water loop differential pressure"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
  CDL.Interfaces.RealInput uValPos[nVal]
    "Measured chilled beam manifold control valve position"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
equation
  connect(chiWatStaPreSetRes.yStaPreSetPoi, secPumCon.dpChiWatSet) annotation (
      Line(points={{-18,-10},{-10,-10},{-10,22},{-2,22}}, color={0,0,127}));
  connect(uPumSta, bypValPos.uPumSta) annotation (Line(points={{-120,80},{20,80},
          {20,75},{38,75}}, color={255,0,255}));
  connect(uPumSta, secPumCon.uChiWatPum) annotation (Line(points={{-120,80},{
          -50,80},{-50,34},{-2,34}}, color={255,0,255}));
  connect(uPumSta, chiWatStaPreSetRes.uPumSta) annotation (Line(points={{-120,
          80},{-50,80},{-50,-5},{-42,-5}}, color={255,0,255}));
  connect(conInt.y, secPumCon.uPumLeaLag) annotation (Line(points={{-58,30},{
          -40,30},{-40,38},{-2,38}}, color={255,127,0}));
  connect(secPumCon.yPumSpe, bypValPos.uPumSpe) annotation (Line(points={{22,28},
          {30,28},{30,70},{38,70}}, color={0,0,127}));
  connect(dPChiWatLoo, bypValPos.dpChiWatLoo) annotation (Line(points={{-120,40},
          {-90,40},{-90,65},{38,65}}, color={0,0,127}));
  connect(dPChiWatLoo, secPumCon.dpChiWat_remote[1]) annotation (Line(points={{
          -120,40},{-90,40},{-90,50},{-10,50},{-10,26},{-2,26}}, color={0,0,127}));
  connect(uValPos, secPumCon.uValPos) annotation (Line(points={{-120,0},{-60,0},
          {-60,10},{-30,10},{-30,30},{-2,30}}, color={0,0,127}));
  connect(uValPos, chiWatStaPreSetRes.uValPos) annotation (Line(points={{-120,0},
          {-60,0},{-60,-15},{-42,-15}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SystemController;
