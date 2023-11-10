within Buildings.Fluid.Storage.Ice.Validation;
model TESS_test_v2
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
  Controls.OBC.CDL.Continuous.Sources.Constant con(k=273.15 + 15)
    annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
  Controls.OBC.CDL.Continuous.Sources.Sin sin(amplitude=200000, freqHz=1/(40*
        3600))
    annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  Modelica.Blocks.Sources.RealExpression TRet(y=if not sin.y <= 0 then tESS.controlledTank_uQReq.T
         else 273.15 + 12) "Inlet temperature into tank"
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
  Modelica.Blocks.Sources.RealExpression mCHW(y=if sin.y <= 0 then datChi.mEva_flow_nominal
         else 0)
    "Inlet temperature into tank"
    annotation (Placement(transformation(extent={{-80,-70},{-60,-50}})));
  Controls.OBC.CDL.Continuous.Sources.Constant con1(k=1000000)
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  TESS_W_interfaces tESS_W_interfaces
    annotation (Placement(transformation(extent={{-8,-80},{12,-60}})));
  Controls.OBC.CDL.Continuous.Sources.Constant con2(k=273.15 + 12)
    annotation (Placement(transformation(extent={{-80,-92},{-60,-72}})));
  Controls.OBC.CDL.Continuous.Sources.Constant con3(k=0)
    annotation (Placement(transformation(extent={{-52,-112},{-32,-92}})));
  Controls.OBC.CDL.Continuous.Sources.Constant con4(k=78149)
    annotation (Placement(transformation(extent={{-58,-76},{-38,-56}})));
equation
  connect(con.y, tESS.TOut) annotation (Line(points={{-58,20},{-40,20},{-40,8},
          {-12,8}},color={0,0,127}));
  connect(TRet.y, tESS.TRet) annotation (Line(points={{-59,-40},{-30,-40},{-30,
          -4},{-12,-4}},                color={0,0,127}));
  connect(mCHW.y, tESS.mCHW_flow) annotation (Line(points={{-59,-60},{-20,-60},
          {-20,-10},{-12,-10}}, color={0,0,127}));
  connect(con.y, tESS_W_interfaces.TOut) annotation (Line(points={{-58,20},{-40,
          20},{-40,-62},{-10,-62}}, color={0,0,127}));
  connect(sin.y, tESS.uQReq) annotation (Line(points={{-58,-10},{-34,-10},{-34,
          2},{-12,2}}, color={0,0,127}));
  connect(con2.y, tESS_W_interfaces.TRet) annotation (Line(points={{-58,-82},{
          -36,-82},{-36,-74},{-10,-74}}, color={0,0,127}));
  connect(con3.y, tESS_W_interfaces.mCHW_flow) annotation (Line(points={{-30,
          -102},{-20,-102},{-20,-80},{-10,-80}}, color={0,0,127}));
  connect(con4.y, tESS_W_interfaces.uQReq) annotation (Line(points={{-36,-66},{
          -22,-66},{-22,-68},{-10,-68}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=172800,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end TESS_test_v2;
