within Buildings.Examples.JointStudyModel;
model Guideline36_BoilerPlant_RP1711ControlsPITuning
  "Variable air volume flow system with terminal reheat and five thermal zones"
  extends Modelica.Icons.Example;
  package MediumA = Buildings.Media.Air "Medium model for air";
  package MediumW = Buildings.Media.Water "Medium model for water";

  parameter Modelica.SIunits.MassFlowRate mRad_flow_nominal=30
    "Radiator nominal mass flow rate"
    annotation(dialog(group="Radiator parameters"));

  parameter Real boiDesCap = 1000000;

  parameter Real boiCapRat = 2/4.3;

  parameter Modelica.SIunits.PressureDifference dpValve_nominal_value=6000
    "Nominal pressure drop of fully open valve, used if CvData=Buildings.Fluid.Types.CvTypes.OpPoint";
  parameter Modelica.SIunits.PressureDifference dpFixed_nominal_value=1000
    "Pressure drop of pipe and other resistances that are in series";

  parameter Modelica.SIunits.Area AFloCor=guideline36_modified.flo.cor.AFlo "Floor area corridor";
  parameter Modelica.SIunits.Area AFloSou=guideline36_modified.flo.sou.AFlo "Floor area south";
  parameter Modelica.SIunits.Area AFloNor=guideline36_modified.flo.nor.AFlo "Floor area north";
  parameter Modelica.SIunits.Area AFloEas=guideline36_modified.flo.eas.AFlo "Floor area east";
  parameter Modelica.SIunits.Area AFloWes=guideline36_modified.flo.wes.AFlo "Floor area west";

  parameter Modelica.SIunits.Volume VRooCor=AFloCor*guideline36_modified.flo.hRoo
    "Room volume corridor";
  parameter Modelica.SIunits.Volume VRooSou=AFloSou*guideline36_modified.flo.hRoo
    "Room volume south";
  parameter Modelica.SIunits.Volume VRooNor=AFloNor*guideline36_modified.flo.hRoo
    "Room volume north";
  parameter Modelica.SIunits.Volume VRooEas=AFloEas*guideline36_modified.flo.hRoo "Room volume east";
  parameter Modelica.SIunits.Volume VRooWes=AFloWes*guideline36_modified.flo.hRoo "Room volume west";

  constant Real conv=1.2/3600 "Conversion factor for nominal mass flow rate";
  parameter Modelica.SIunits.MassFlowRate mCor_flow_nominal=6*VRooCor*conv
    "Design mass flow rate core";
  parameter Modelica.SIunits.MassFlowRate mSou_flow_nominal=6*VRooSou*conv
    "Design mass flow rate perimeter 1";
  parameter Modelica.SIunits.MassFlowRate mEas_flow_nominal=9*VRooEas*conv
    "Design mass flow rate perimeter 2";
  parameter Modelica.SIunits.MassFlowRate mNor_flow_nominal=6*VRooNor*conv
    "Design mass flow rate perimeter 3";
  parameter Modelica.SIunits.MassFlowRate mWes_flow_nominal=7*VRooWes*conv
    "Design mass flow rate perimeter 4";
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal=0.7*(mCor_flow_nominal
       + mSou_flow_nominal + mEas_flow_nominal + mNor_flow_nominal +
      mWes_flow_nominal) "Nominal mass flow rate";

  Submodels.Guideline36_modified guideline36_modified
    annotation (Placement(transformation(extent={{20,30},{40,50}})));

  Fluid.Sources.MassFlowSource_T           souHea(
    redeclare package Medium = MediumW,
    T=343.15,
    use_m_flow_in=true,
    nPorts=1)           "Source for heating coil" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={50,-10})));
public
  Controls.OBC.CDL.Continuous.Gain           gaiHeaCoi(k=m_flow_nominal*1000*40
        /4200/10) "Gain for heating coil mass flow rate"
    annotation (Placement(transformation(extent={{0,-50},{20,-30}})));
  Fluid.Sources.Boundary_pT           sinHea(
    redeclare package Medium = MediumW,
    p=300000,
    T=318.15,
    nPorts=1) "Sink for heating coil" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={10,-10})));
public
  Controls.OBC.CDL.Continuous.Gain           gaiHeaCoi1(k=100)
                  "Gain for heating coil mass flow rate"
    annotation (Placement(transformation(extent={{0,-80},{20,-60}})));
equation
  connect(souHea.ports[1], guideline36_modified.port_a) annotation (Line(points=
         {{50,0},{50,10},{32,10},{32,30}}, color={0,127,255}));
  connect(sinHea.ports[1], guideline36_modified.port_b) annotation (Line(points=
         {{10,0},{10,10},{28,10},{28,30}}, color={0,127,255}));
  connect(guideline36_modified.yHeaCoiSig, gaiHeaCoi.u) annotation (Line(points=
         {{42,42},{50,42},{50,60},{-20,60},{-20,-40},{-2,-40}}, color={0,0,127}));
  connect(gaiHeaCoi.y, souHea.m_flow_in)
    annotation (Line(points={{22,-40},{42,-40},{42,-22}}, color={0,0,127}));
  connect(guideline36_modified.yHeaCoiSig, gaiHeaCoi1.u) annotation (Line(
        points={{42,42},{50,42},{50,60},{-20,60},{-20,-70},{-2,-70}}, color={0,
          0,127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-100,-100},{100,
            100}})),
    __Dymola_Commands(file=
          "modelica://Buildings/Resources/Scripts/Dymola/Examples/VAVReheat/Guideline36.mos"
        "Simulate and plot"),
    experiment(
      StartTime=86400,
      StopTime=192800,
      Interval=60,
      __Dymola_Algorithm="Cvode"),
    Icon(coordinateSystem(extent={{-100,-120},{100,100}})));
end Guideline36_BoilerPlant_RP1711ControlsPITuning;
