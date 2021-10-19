within Buildings.Templates.AHUs.Controls;
block OpenLoop "Open loop controller (output signals only)"
  extends Buildings.Templates.AHUs.BaseClasses.Controls.PartialSingleDuct(
    final typ=Types.Controller.OpenLoop);

  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant yDamOut(k=1)
 if secOutRel.typDamOut==Templates.Types.Damper.Modulated
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-180,170})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant yDamOut1(k=true)
 if secOutRel.typDamOut==Templates.Types.Damper.TwoPosition
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-170,144})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant yDamOutMin(k=1)
 if secOutRel.typDamOutMin==Templates.Types.Damper.Modulated
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-150,170})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant yDamOutMin1(k=true)
 if secOutRel.typDamOutMin==Templates.Types.Damper.TwoPosition
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-140,144})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant yDamRet(k=1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-120,170})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant yDamRel(k=1)
 if secOutRel.typDamRel==Templates.Types.Damper.Modulated
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-90,170})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant yDamRel1(k=true)
 if secOutRel.typDamRel==Templates.Types.Damper.TwoPosition
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-60,170})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant yCoiCoo(k=1)
  if coiCoo.typ == Templates.Types.Coil.WaterBased or
     coiCoo.typHex == Templates.Types.HeatExchanger.DXVariableSpeed
     annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-60,110})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant yCoiCooSta(k=1)
 if coiCoo.typHex == Templates.Types.HeatExchanger.DXMultiStage
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-20,110})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant ySpeFanSup(k=1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={60,70})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant yFanSup(k=true)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={100,70})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant yCoiHea(k=1)
 if coiHea.typ == Templates.Types.Coil.WaterBased or
    coiHea.typHex == Templates.Types.HeatExchanger.DXVariableSpeed
    annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={20,110})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant ySpeFanRet(k=1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={140,70})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant yFanRet(k=true)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={180,70})));

equation
    // Non graphical connections - START
  connect(yDamOutMin.y,busAHU.out.yDamOutMin);
  connect(yDamOutMin1.y,busAHU.out.yDamOutMin);
  connect(yDamRel.y,busAHU.out.yDamRel);
  connect(yDamRel1.y,busAHU.out.yDamRel);
  connect(yCoiCoo.y, busAHU.out.yCoiCoo);
  connect(yCoiHea.y, busAHU.out.yCoiHea);
  connect(yFanSup.y,busAHU.out.yFanSup);
  connect(ySpeFanSup.y,busAHU.out.ySpeFanSup);
  connect(ySpeFanRet.y, busAHU.out.ySpeFanRet);
  connect(yFanRet.y, busAHU.out.yFanRet);

  connect(yCoiCooSta.y,busAHU.out.yCoiCoo);

  connect(yDamOut.y,busAHU.out.yDamOut);
  connect(yDamOut1.y,busAHU.out.yDamOut);

  connect(yDamRet.y,busAHU.out.yDamRet);

  annotation (
  defaultComponentName="conAHU",
  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end OpenLoop;
