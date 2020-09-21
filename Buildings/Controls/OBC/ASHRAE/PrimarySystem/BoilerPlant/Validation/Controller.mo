within Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Validation;
model Controller "Validation model for boiler plant control sequence"

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Controller controller(primaryOnly=true,
    nBoi=2,
    boiTyp={Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Types.BoilerTypes.condensingBoiler,
        Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Types.BoilerTypes.condensingBoiler},
    nSta=3,
    staMat=[1,0; 0,1; 1,1],
    iniSta=1,
    boiDesCap={15000*0.8,15000*0.8},
    boiFirMin={0.2,0.3},
    minFloSet={0.2*0.0003,0.3*0.0003},
    maxFloSet={0.0003,0.0003},
    bypSetRat=0.0001,
    nPumPri=2,
    isHeadered=true,
    TMinSupNonConBoi = 333.2,
    variablePrimary=true,
    nSen_remoteDp=1,
    nPum_nominal=2,
    minPumSpe=0.1,
    maxPumSpe=1,
    VHotWat_flow_nominal=0.0006,
    boiDesFlo={0.0003,0.0003},
    speedControlType_priPum=Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Types.PrimaryPumpSpeedControlTypes.remoteDP,
    minPriPumSpeSta={0,0,0})
    annotation (Placement(transformation(extent={{0,-20},{42,20}})));
  CDL.Integers.Sources.Constant conInt(k=4)
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  CDL.Continuous.Sources.Constant con(k=290)
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  CDL.Continuous.Sources.Constant con1(k=350)
    annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
  CDL.Continuous.Sources.Constant con2(k=340)
    annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
  CDL.Continuous.Sources.Constant con3(k=0.0006)
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
  CDL.Continuous.Sources.Constant con4[1](k=34000)
    annotation (Placement(transformation(extent={{-60,-90},{-40,-70}})));
equation
  connect(conInt.y, controller.supResReq) annotation (Line(points={{-38,70},{-20,
          70},{-20,10},{-2,10}}, color={255,127,0}));
  connect(con.y, controller.TOut) annotation (Line(points={{-38,40},{-26,40},{-26,
          6},{-2,6}}, color={0,0,127}));
  connect(con1.y, controller.TSup) annotation (Line(points={{-38,10},{-32,10},{-32,
          2},{-2,2}}, color={0,0,127}));
  connect(con2.y, controller.TRet) annotation (Line(points={{-38,-20},{-32,-20},
          {-32,-2},{-2,-2}}, color={0,0,127}));
  connect(con3.y, controller.VHotWat_flow) annotation (Line(points={{-38,-50},{-26,
          -50},{-26,-6},{-2,-6}}, color={0,0,127}));
  connect(con4.y, controller.dpHotWat_remote) annotation (Line(points={{-38,-80},
          {-20,-80},{-20,-10},{-2,-10}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false),
      graphics={Ellipse(
                  lineColor = {75,138,73},
                  fillColor={255,255,255},
                  fillPattern = FillPattern.Solid,
                  extent={{-100,-100},{100,100}}),
                Polygon(
                  lineColor = {0,0,255},
                  fillColor = {75,138,73},
                  pattern = LinePattern.None,
                  fillPattern = FillPattern.Solid,
                  points={{-36,60},{64,0},{-36,-60},{-36,60}})}),
    Diagram(coordinateSystem(
      preserveAspectRatio=false)),
    experiment(
      StopTime=3600,
      __Dymola_NumberOfIntervals=100,
      Tolerance=1e-06,
      __Dymola_Algorithm="Cvode"),
      __Dymola_Commands(file="./Resources/Scripts/Dymola/Controls/OBC/ASHRAE/PrimarySystem/BoilerPlant/Generic/Validation/PlantEnable.mos"
        "Simulate and plot"),
    Documentation(info="<html>
      <p>
      This example validates
      <a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Generic.PlantEnable\">
      Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Generic.PlantEnable</a>.
      </p>
      </html>", revisions="<html>
      <ul>
      <li>
      May 7, 2020, by Karthik Devaprasad:<br/>
      First implementation.
      </li>
      </ul>
      </html>"));
end Controller;
