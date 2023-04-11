within Buildings.Fluid.ZoneEquipment.BaseClasses1;
model ModularController
  extends Buildings.Fluid.ZoneEquipment.BaseClasses1.ControllerInterfaces;

  parameter Buildings.Controls.OBC.CDL.Types.SimpleController controllerTypeCoo=Buildings.Controls.OBC.CDL.Types.SimpleController.PI
    "Type of cooling loop controller"
    annotation (Dialog(group="Cooling mode control"));

  parameter Real kCoo(
    final unit="1",
    displayUnit="1",
    final min=0)=1
    "Gain of cooling loop controller"
    annotation(Dialog(group="Cooling mode control"));

  parameter Modelica.Units.SI.Time TiCoo=0.5
    "Time constant of cooling loop integrator block"
    annotation(Dialog(group="Cooling mode control",
      enable = controllerTypeCoo == Buildings.Controls.OBC.CDL.Types.SimpleController.PI or
      controllerTypeCoo == Buildings.Controls.OBC.CDL.Types.SimpleController.PID));

  parameter Modelica.Units.SI.Time TdCoo=0.1
    "Time constant of cooling loop derivative block"
    annotation(Dialog(group="Cooling mode control",
      enable = controllerTypeCoo == Buildings.Controls.OBC.CDL.Types.SimpleController.PD or
      controllerTypeCoo == Buildings.Controls.OBC.CDL.Types.SimpleController.PID));

  parameter Buildings.Controls.OBC.CDL.Types.SimpleController controllerTypeHea=Buildings.Controls.OBC.CDL.Types.SimpleController.PI
    "Type of cooling loop controller"
    annotation (Dialog(group="Heating mode control"));

  parameter Real kHea(
    final unit="1",
    displayUnit="1",
    final min=0)=1
    "Gain of cooling loop controller"
    annotation(Dialog(group="Heating mode control"));

  parameter Modelica.Units.SI.Time TiHea=0.5
    "Time constant of cooling loop integrator block"
    annotation(Dialog(group="Heating mode control",
      enable = controllerTypeHea == Buildings.Controls.OBC.CDL.Types.SimpleController.PI or
      controllerTypeHea == Buildings.Controls.OBC.CDL.Types.SimpleController.PID));

  parameter Modelica.Units.SI.Time TdHea=0.1
    "Time constant of cooling loop derivative block"
    annotation(Dialog(group="Heating mode control",
      enable = controllerTypeHea == Buildings.Controls.OBC.CDL.Types.SimpleController.PD or
      controllerTypeHea == Buildings.Controls.OBC.CDL.Types.SimpleController.PID));

  VariableFan conVarFanConWat(has_hea=has_hea, has_coo=has_coo,
    controllerTypeCoo=controllerTypeCoo,
    kCoo=kCoo,
    TiCoo=TiCoo,
    TdCoo=TdCoo,
    controllerTypeHea=controllerTypeHea,
    kHea=kHea,
    TiHea=TiHea,
    TdHea=TdHea)
    annotation (Placement(transformation(extent={{16,-74},{44,-46}})));
  CyclingFan conFanCyc
    annotation (Placement(transformation(extent={{16,-34},{44,-6}})));
  MultispeedFan conMulSpeFanConWat(has_hea=has_hea, has_coo=has_coo,
    controllerTypeCoo=controllerTypeCoo,
    kCoo=kCoo,
    TiCoo=TiCoo,
    TdCoo=TdCoo,
    controllerTypeHea=controllerTypeHea,
    kHea=kHea,
    TiHea=TiHea,
    TdHea=TdHea)
    annotation (Placement(transformation(extent={{16,-134},{44,-106}})));
  HeatingCooling conCooMod(
    controllerType=controllerTypeCoo,
    k=kCoo,
    Ti=TiCoo,
    Td=TdCoo) if              has_coo "Cooling mode controller"
    annotation (Placement(transformation(extent={{-84,106},{-56,134}})));
  HeatingCooling conHeaMod(
    controllerType=controllerTypeHea,
    k=kHea,
    Ti=TiHea,
    Td=TdHea,
    conMod=true) if           has_hea "Heating mode controller"
    annotation (Placement(transformation(extent={{-84,66},{-56,94}})));
  Controls.OBC.CDL.Logical.Or orFanEna
    "Enable fan when system enters heating mode or cooling mode"
    annotation (Placement(transformation(extent={{-28,30},{-8,50}})));
  Controls.OBC.CDL.Logical.Sources.Constant conCoo(k=false) if not has_coo
    "Constant false signal if cooling mode is not available"
    annotation (Placement(transformation(extent={{-90,30},{-70,50}})));
  Controls.OBC.CDL.Logical.Sources.Constant conHea(k=false) if not has_hea
    "Constant false signal if heating mode is not available"
    annotation (Placement(transformation(extent={{-90,0},{-70,20}})));
equation
  connect(fanOpeMod, conFanCyc.fanOpeMod) annotation (Line(points={{-160,-80},{
          -40,-80},{-40,-28.4},{13.2,-28.4}},
                                         color={255,0,255}));
  connect(fanOpeMod, conMulSpeFanConWat.fanOpeMod) annotation (Line(points={{-160,
          -80},{-40,-80},{-40,-132},{14,-132}},   color={255,0,255}));
  connect(uAva, conFanCyc.uAva) annotation (Line(points={{-160,-40},{-60,-40},{
          -60,-22.8},{13.2,-22.8}},
                          color={255,0,255}));
  connect(uAva, conVarFanConWat.uAva) annotation (Line(points={{-160,-40},{-60,
          -40},{-60,-72},{14,-72}},
                               color={255,0,255}));
  connect(uAva, conMulSpeFanConWat.uAva) annotation (Line(points={{-160,-40},{
          -60,-40},{-60,-126},{14,-126}},
                                      color={255,0,255}));
  connect(conFanCyc.yFanSpe, yFanSpe) annotation (Line(points={{46.8,-17.2},{
          100,-17.2},{100,-60},{160,-60}},
                                color={0,0,127}));
  connect(conVarFanConWat.yFanSpe, yFanSpe) annotation (Line(points={{46,-56},{100,
          -56},{100,-60},{160,-60}}, color={0,0,127}));
  connect(conMulSpeFanConWat.yFanSpe, yFanSpe) annotation (Line(points={{46,-116},
          {100,-116},{100,-60},{160,-60}}, color={0,0,127}));
  connect(conFanCyc.yFan, yFan) annotation (Line(points={{46.8,-22.8},{120,
          -22.8},{120,-100},{160,-100}},
                             color={255,0,255}));
  connect(conVarFanConWat.yFan, yFan) annotation (Line(points={{46,-64},{120,-64},
          {120,-100},{160,-100}}, color={255,0,255}));
  connect(conMulSpeFanConWat.yFan, yFan) annotation (Line(points={{46,-124},{120,
          -124},{120,-100},{160,-100}}, color={255,0,255}));
  connect(TZon, conVarFanConWat.TZon) annotation (Line(points={{-160,80},{-100,
          80},{-100,-48},{14,-48}},
                                color={0,0,127}));
  connect(TZon, conMulSpeFanConWat.TZon) annotation (Line(points={{-160,80},{
          -100,80},{-100,-108},{14,-108}},
                                      color={0,0,127}));
  connect(TCooSet, conVarFanConWat.TCooSet) annotation (Line(points={{-160,40},
          {-110,40},{-110,-56},{14,-56}},color={0,0,127}));
  connect(TCooSet, conMulSpeFanConWat.TCooSet) annotation (Line(points={{-160,40},
          {-110,40},{-110,-114},{14,-114}}, color={0,0,127}));
  connect(THeaSet, conVarFanConWat.THeaSet) annotation (Line(points={{-160,0},{
          -120,0},{-120,-64},{14,-64}},    color={0,0,127}));
  connect(THeaSet, conMulSpeFanConWat.THeaSet) annotation (Line(points={{-160,0},
          {-120,0},{-120,-120},{14,-120}},   color={0,0,127}));
  connect(uFan, conCooMod.uFan) annotation (Line(points={{-160,120},{-130,120},
          {-130,128.4},{-86.8,128.4}},
                                color={255,0,255}));
  connect(uFan, conHeaMod.uFan) annotation (Line(points={{-160,120},{-130,120},
          {-130,88.4},{-86.8,88.4}},
                              color={255,0,255}));
  connect(TZon, conCooMod.TZon) annotation (Line(points={{-160,80},{-100,80},{
          -100,122.8},{-86.8,122.8}},
                           color={0,0,127}));
  connect(TZon, conHeaMod.TZon) annotation (Line(points={{-160,80},{-100,80},{
          -100,82.8},{-86.8,82.8}},
                         color={0,0,127}));
  connect(TCooSet, conCooMod.TZonSet) annotation (Line(points={{-160,40},{-110,
          40},{-110,117.2},{-86.8,117.2}},
                                 color={0,0,127}));
  connect(THeaSet, conHeaMod.TZonSet) annotation (Line(points={{-160,0},{-120,0},
          {-120,77.2},{-86.8,77.2}},color={0,0,127}));
  connect(uFan, conFanCyc.uFan) annotation (Line(points={{-160,120},{-130,120},
          {-130,-11.6},{13.2,-11.6}},
                             color={255,0,255}));
  connect(conCooMod.yEna, yCooEna) annotation (Line(points={{-53.2,120},{120,
          120},{120,100},{160,100}},
                                color={255,0,255}));
  connect(conHeaMod.yEna, yHeaEna) annotation (Line(points={{-53.2,80},{120,80},
          {120,60},{160,60}},
                         color={255,0,255}));
  connect(conCooMod.yCoi, yCoo) annotation (Line(points={{-53.2,125.6},{130,
          125.6},{130,20},{160,20}}, color={0,0,127}));
  connect(conHeaMod.yCoi, yHea) annotation (Line(points={{-53.2,85.6},{110,85.6},
          {110,-20},{160,-20}}, color={0,0,127}));
  connect(conCooMod.yMod, orFanEna.u1) annotation (Line(points={{-53.2,114.4},{
          -40,114.4},{-40,40},{-30,40}},
                              color={255,0,255}));
  connect(conHeaMod.yMod, orFanEna.u2) annotation (Line(points={{-53.2,74.4},{
          -48,74.4},{-48,32},{-30,32}},
                              color={255,0,255}));
  connect(orFanEna.y, conFanCyc.heaCooOpe) annotation (Line(points={{-6,40},{0,
          40},{0,-17.2},{13.2,-17.2}},
                             color={255,0,255}));
  connect(conCoo.y, orFanEna.u1)
    annotation (Line(points={{-68,40},{-30,40}}, color={255,0,255}));
  connect(conHea.y, orFanEna.u2) annotation (Line(points={{-68,10},{-48,10},{-48,
          32},{-30,32}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ModularController;
