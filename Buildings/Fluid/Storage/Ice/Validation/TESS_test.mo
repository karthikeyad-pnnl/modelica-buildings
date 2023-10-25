within Buildings.Fluid.Storage.Ice.Validation;
model TESS_test
  extends Modelica.Icons.Example;

  parameter Modelica.Units.SI.Mass SOC_start=0
    "Start value of ice mass in the tank";

  TESS tESS(
    redeclare package MediumCHW =
        Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15 + 10,
          X_a=0.25),
    SOC_start=SOC_start,
    perIceTan=perIceTan,
    datChi=datChi)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Controls.OBC.CDL.Continuous.Sources.Constant con(k=273.15 + 5.55)
    annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
  Controls.OBC.CDL.Continuous.Sources.Sin sin(amplitude=550000, freqHz=1/(40*
        3600))
    annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  Modelica.Blocks.Sources.RealExpression TRet(y=if not sin.y <= 0 then tESS.controlledTank_uQReq.T
         else 273.15 + 7)
    "Inlet temperature into tank"
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  parameter Data.Tank.Generic perIceTan(
    mIce_max=4400*1000*3600/perIceTan.Hf,
    coeCha={1.76953858E-04,0,0,0,0,0},
    dtCha=10,
    coeDisCha={5.54E-05,-1.45679E-04,9.28E-05,1.126122E-03,-1.1012E-03,
        3.00544E-04},
    dtDisCha=10) "Tank performance data"
    annotation (Placement(transformation(extent={{60,60},{80,80}})));

  parameter
    Chillers.Data.ElectricReformulatedEIR.ReformEIRChiller_McQuay_WSC_471kW_5_89COP_Vanes
    datChi annotation (Placement(transformation(extent={{20,60},{40,80}})));
equation
  connect(con.y, tESS.TOut) annotation (Line(points={{-58,20},{-40,20},{-40,6},{
          -12,6}}, color={0,0,127}));
  connect(sin.y, tESS.uQReq) annotation (Line(points={{-58,-10},{-40,-10},{-40,0},
          {-12,0}}, color={0,0,127}));
  connect(TRet.y, tESS.TRet) annotation (Line(points={{-59,-40},{-40,-40},{-40,-20},
          {-20,-20},{-20,-6},{-12,-6}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=172800,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end TESS_test;
