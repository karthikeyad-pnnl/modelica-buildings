within Buildings.Fluid.Storage.Ice.Validation;
model TESS_W_interfaces

  parameter .Modelica.Units.SI.Mass SOC_start=0
    "Start value of ice mass in the tank";

  .Buildings.Fluid.Storage.Ice.Validation.TESS tESS(
    redeclare package MediumCHW =
        .Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15 + 10,
          X_a=0.25),
    SOC_start=SOC_start,
    perIceTan=perIceTan,
    datChi=datChi,
    greThr(h=0.5))
    annotation (Placement(transformation(extent={{-10.0,-10.0},{10.0,10.0}},rotation = 0.0,origin = {0.0,0.0})));
  parameter .Buildings.Fluid.Storage.Ice.Data.Tank.Generic perIceTan(
    mIce_max=4400*1000*3600/perIceTan.Hf,
    coeCha={1.76953858E-04,0,0,0,0,0},
    dtCha=10,
    coeDisCha={5.54E-05,-1.45679E-04,9.28E-05,1.126122E-03,-1.1012E-03,
        3.00544E-04},
    dtDisCha=10) "Tank performance data"
    annotation (Placement(transformation(extent={{60,60},{80,80}})));

  parameter
    .Buildings.Fluid.Chillers.Data.ElectricReformulatedEIR.ReformEIRChiller_McQuay_WSC_471kW_5_89COP_Vanes
    datChi(
    QEva_flow_nominal=-300000,
    COP_nominal=5.33,
    mEva_flow_nominal=0.03369*1000,
    TEvaLvg_nominal=271.15,
    TEvaLvgMin=273.15 - 5)
           annotation (Placement(transformation(extent={{20,60},{40,80}})));
    .Modelica.Blocks.Interfaces.RealInput uQReq(displayUnit = "W",unit = "W") "Required charge/discharge rate" annotation(Placement(transformation(extent = {{-98.0,-25.5},{-58.0,14.5}},rotation = 0.0,origin = {0.0,0.0}),iconTransformation(extent = {{-140,0},{-100,40}})));
    .Modelica.Blocks.Interfaces.RealInput TOut(displayUnit = "degC",unit = "K") "Prescribed outdoor air temperature" annotation(Placement(transformation(extent = {{-98.0,54.5},{-58.0,94.5}},rotation = 0.0,origin = {0.0,0.0}),iconTransformation(extent = {{-140,60},{-100,100}})));
    .Modelica.Blocks.Interfaces.RealInput TRet(displayUnit = "degC",unit = "K") "Chilled water supply temperature from chiller" annotation(Placement(transformation(extent = {{-98.0,-72.0},{-58.0,-32.0}},rotation = 0.0,origin = {0.0,0.0}),iconTransformation(extent = {{-140,-60},{-100,-20}})));
    .Modelica.Blocks.Interfaces.RealInput mCHW_flow(quantity = "MassFlowRate",displayUnit = "kg/s",unit = "kg/s") "Measured chiled water flowrate" annotation(Placement(transformation(extent = {{-98.0,-105.5},{-58.0,-65.5}},rotation = 0.0,origin = {0.0,0.0}),iconTransformation(extent = {{-140,-120},{-100,-80}})));
    .Modelica.Blocks.Interfaces.RealOutput Q_flow(unit = "W") "Heat flow rate, positive during charging, negative when melting the ice" annotation(Placement(transformation(extent = {{40.0,-32.0},{60.0,-12.0}},rotation = 0.0,origin = {0.0,0.0}),iconTransformation(extent = {{100,-30},{120,-10}})));
    .Modelica.Blocks.Interfaces.RealOutput SOC(unit = "1") "state of charge" annotation(Placement(transformation(extent = {{40.0,8.0},{60.0,28.0}},rotation = 0.0,origin = {0.0,0.0}),iconTransformation(extent = {{100,10},{120,30}})));
equation
    connect(TOut,tESS.TOut) annotation(Line(points = {{-78,74.5},{-78,41.25},{-12,41.25},{-12,8}},color = {0,0,127}));
    connect(uQReq,tESS.uQReq) annotation(Line(points = {{-78,-5.5},{-45,-5.5},{-45,2},{-12,2}},color = {0,0,127}));
    connect(TRet,tESS.TRet) annotation(Line(points = {{-78,-52},{-34,-52},{-34,-4},{-12,-4}},color = {0,0,127}));
    connect(mCHW_flow,tESS.mCHW_flow) annotation(Line(points = {{-78,-85.5},{-12,-85.5},{-12,-10}},color = {0,0,127}));
    connect(tESS.SOC,SOC) annotation(Line(points = {{11,2},{30.5,2},{30.5,18},{50,18}},color = {0,0,127}));
    connect(tESS.Q_flow,Q_flow) annotation(Line(points = {{11,-2},{30.5,-2},{30.5,-22},{50,-22}},color = {0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=172800,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end TESS_W_interfaces;
