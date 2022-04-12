within Buildings.Controls.OBC.ASHRAE.FanCoilUnit.ClosedLoopValidation;
model FCU "Closed loop validation model for FCU controls"
  extends Modelica.Icons.Example;
  replaceable package MediumA = Buildings.Media.Air
    constrainedby Modelica.Media.Interfaces.PartialCondensingGases "Medium model for air";
  replaceable package MediumW = Buildings.Media.Water "Medium model for water";
  inner Buildings.ThermalZones.EnergyPlus.Building building(
    idfName=Modelica.Utilities.Files.loadResource(
      "./Buildings/Resources/Data/Controls/OBC/ASHRAE/FanCoilUnit/ClosedLoopValidation/FanCoilAutoSize.idf"),
    epwName=Modelica.Utilities.Files.loadResource(
      "./Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.epw"),
    weaName=Modelica.Utilities.Files.loadResource(
      "./Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos"),
    usePrecompiledFMU=false,
    computeWetBulbTemperature=false)
    "Building model"
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  parameter Modelica.Units.SI.Volume VRoo=453.1 "Room volume";
  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=VRoo*1.2*0.3/3600
    "Nominal mass flow rate";
  Buildings.ThermalZones.EnergyPlus.ThermalZone zon(
    zoneName="NORTH ZONE",
    redeclare package Medium = MediumA,
    nPorts=2)
    "Thermal zone"
    annotation (Placement(transformation(extent={{50,50},{90,90}})));
  Modelica.Blocks.Sources.Constant qIntGai[3](
    each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{10,70},{30,90}})));

  Buildings.Controls.OBC.ASHRAE.FanCoilUnit.ClosedLoopValidation.trialComponent
                     triCom(
    has_economizer=false,
    has_coolingCoil=true,
    has_coolingCoilCCW=true,
    has_heatingCoil=true,
    has_heatingCoilHHW=true,
    mAir_flow_nominal=0.47*1.225,
    mHHW_flow_nominal=0.000196*1000,
    mCCW_flow_nominal=0.000242*1000,
    redeclare package MediumA = MediumA,
    redeclare package MediumW = MediumW)
    annotation (Placement(transformation(extent={{14,-14},{58,30}})));
  Fluid.Sources.Boundary_pT sinCoo(
    redeclare package Medium = MediumW,
    p=300000,
    T=279.15,
    nPorts=3) "Sink for cooling coil" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={48,-50})));
  Fluid.Sources.Boundary_pT souHea(
    redeclare package Medium = MediumW,
    p(displayUnit="Pa") = 300000 + 6000,
    T=318.15,
    nPorts=3) "Source for heating coil" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={18,-50})));
  Fluid.Sources.Boundary_pT sinHea(
    redeclare package Medium = MediumW,
    p=300000,
    T=318.15,
    nPorts=3) "Sink for heating coil" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-12,-50})));
  Fluid.Sources.Boundary_pT souCoo(
    redeclare package Medium = MediumW,
    p(displayUnit="Pa") = 300000 + 6000,
    T=279.15,
    nPorts=3) "Source for cooling coil loop" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={78,-50})));
  Controller conFCU[3](
    have_coolingCoil=true,
    have_heatingCoil=true,
    have_winSen=false,
    have_occSen=false,
    controllerTypeCoo=Buildings.Controls.OBC.CDL.Types.SimpleController.PI,
    TiCoo=1200,
    controllerTypeHea=Buildings.Controls.OBC.CDL.Types.SimpleController.PI,
    kHea=0.05,
    TiHea=1200,
    controllerTypeCooCoi=Buildings.Controls.OBC.CDL.Types.SimpleController.PI,
    kCooCoi=0.05,
    TiCooCoi=1200,
    controllerTypeHeaCoi=Buildings.Controls.OBC.CDL.Types.SimpleController.PI,
    kHeaCoi=0.01,
    TiHeaCoi=1200,
    TSupSetMax=308.15,
    TSupSetMin=285.15,
    heaSpeMax=1,
    heaSpeMin=0.2,
    cooSpeMin=0.2,
    deaHysLim=0.02)
    annotation (Placement(transformation(extent={{-90,-4},{-50,40}})));
  CDL.Continuous.Multiply mul[3]
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  CDL.Conversions.BooleanToReal booToRea[3]
    annotation (Placement(transformation(extent={{-40,36},{-20,56}})));
  SetPoints.OccupancySchedule occSch(occupancy=3600*{8,18})
    "Occupancy schedule"
    annotation (Placement(transformation(extent={{-210,40},{-190,60}})));
  CDL.Continuous.Sources.Constant con[3](k=300) "Warm-up time"
    annotation (Placement(transformation(extent={{-140,40},{-120,60}})));
  CDL.Integers.Sources.Constant conInt[3](k=0)
    annotation (Placement(transformation(extent={{-150,0},{-130,20}})));
  ThermalZones.EnergyPlus.ThermalZone           zon1(
    zoneName="EAST ZONE",
    redeclare package Medium = MediumA,
    nPorts=2)
    "Thermal zone"
    annotation (Placement(transformation(extent={{140,50},{180,90}})));
  ThermalZones.EnergyPlus.ThermalZone           zon2(
    zoneName="West Zone",
    redeclare package Medium = MediumA,
    nPorts=2)
    "Thermal zone"
    annotation (Placement(transformation(extent={{220,50},{260,90}})));
  trialComponent     triCom1(
    has_economizer=false,
    has_coolingCoil=true,
    has_coolingCoilCCW=true,
    has_heatingCoil=true,
    has_heatingCoilHHW=true,
    mAir_flow_nominal=0.47*1.225,
    mHHW_flow_nominal=0.000196*1000,
    mCCW_flow_nominal=0.000242*1000,
    redeclare package MediumA = MediumA,
    redeclare package MediumW = MediumW)
    annotation (Placement(transformation(extent={{140,-22},{184,22}})));
  trialComponent     triCom2(
    has_economizer=false,
    has_coolingCoil=true,
    has_coolingCoilCCW=true,
    has_heatingCoil=true,
    has_heatingCoilHHW=true,
    mAir_flow_nominal=0.47*1.225,
    mHHW_flow_nominal=0.000196*1000,
    mCCW_flow_nominal=0.000242*1000,
    redeclare package MediumA = MediumA,
    redeclare package MediumW = MediumW)
    annotation (Placement(transformation(extent={{220,-22},{264,22}})));
  CDL.Routing.RealScalarReplicator reaScaRep(nout=3)
    annotation (Placement(transformation(extent={{-180,60},{-160,80}})));
  CDL.Routing.BooleanScalarReplicator booScaRep(nout=3)
    annotation (Placement(transformation(extent={{-180,20},{-160,40}})));
  CDL.Logical.Pre pre[3] "Logical pre block"
    annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
equation
  connect(zon.qGai_flow,qIntGai.y)
    annotation (Line(points={{48,80},{31,80}}, color={0,0,127}));
  connect(sinHea.ports[1],triCom. port_HHW_outlet) annotation (Line(points={{
          -14.6667,-40},{-14.6667,-32},{28,-32},{28,-14}},
                                               color={0,127,255}));
  connect(souHea.ports[1],triCom. port_HHW_inlet) annotation (Line(points={{15.3333,
          -40},{15.3333,-34},{32,-34},{32,-14}},
                                             color={0,127,255}));
  connect(sinCoo.ports[1],triCom. port_CCW_outlet) annotation (Line(points={{45.3333,
          -40},{45.3333,-36},{40,-36},{40,-14}},
                                          color={0,127,255}));
  connect(triCom.port_supply, zon.ports[1]) annotation (Line(points={{58,4.61538},
          {68,4.61538},{68,50.9}}, color={0,127,255}));
  connect(triCom.port_return, zon.ports[2]) annotation (Line(points={{58,
          11.3846},{72,11.3846},{72,50.9}},
                                   color={0,127,255}));
  connect(souCoo.ports[1], triCom1.port_CCW_inlet) annotation (Line(points={{75.3333,
          -40},{170,-40},{170,-22}},         color={0,127,255}));
  connect(souCoo.ports[2], triCom2.port_CCW_inlet) annotation (Line(points={{78,
          -40},{250,-40},{250,-22}}, color={0,127,255}));
  connect(sinCoo.ports[2], triCom1.port_CCW_outlet) annotation (Line(points={{
          48,-40},{48,-36},{166,-36},{166,-22}}, color={0,127,255}));
  connect(sinCoo.ports[3], triCom2.port_CCW_outlet) annotation (Line(points={{50.6667,
          -40},{50,-40},{50,-36},{246,-36},{246,-22}},         color={0,127,255}));
  connect(souHea.ports[2], triCom1.port_HHW_inlet) annotation (Line(points={{18,
          -40},{18,-34},{158,-34},{158,-22}}, color={0,127,255}));
  connect(souHea.ports[3], triCom2.port_HHW_inlet) annotation (Line(points={{20.6667,
          -40},{20.6667,-34},{238,-34},{238,-22}},         color={0,127,255}));
  connect(souCoo.ports[3], triCom.port_CCW_inlet) annotation (Line(points={{80.6667,
          -40},{80.6667,-38},{56,-38},{56,-24},{44,-24},{44,-14}},
        color={0,127,255}));
  connect(sinHea.ports[2], triCom1.port_HHW_outlet) annotation (Line(points={{
          -12,-40},{-12,-32},{154,-32},{154,-22}}, color={0,127,255}));
  connect(sinHea.ports[3], triCom2.port_HHW_outlet) annotation (Line(points={{
          -9.33333,-40},{-9.33333,-32},{234,-32},{234,-22}}, color={0,127,255}));
  connect(triCom1.port_return, zon1.ports[1]) annotation (Line(points={{184,
          3.38462},{192,3.38462},{192,40},{158,40},{158,50.9}},
        color={0,127,255}));
  connect(triCom1.port_supply, zon1.ports[2]) annotation (Line(points={{184,
          -3.38462},{198,-3.38462},{198,40},{162,40},{162,50.9}},
                  color={0,127,255}));
  connect(triCom2.port_return, zon2.ports[1]) annotation (Line(points={{264,
          3.38462},{274,3.38462},{274,4},{280,4},{280,40},{238,40},{238,50.9}},
        color={0,127,255}));
  connect(triCom2.port_supply, zon2.ports[2]) annotation (Line(points={{264,
          -3.38462},{280,-3.38462},{280,-4},{290,-4},{290,40},{242,40},{242,
          50.9}}, color={0,127,255}));
  connect(zon1.TAir, conFCU[2].TZon) annotation (Line(points={{181,88},{190,88},
          {190,96},{-100,96},{-100,26},{-92,26}}, color={0,0,127}));
  connect(zon.TAir, conFCU[1].TZon) annotation (Line(points={{91,88},{100,88},{
          100,96},{-100,96},{-100,26},{-92,26}}, color={0,0,127}));
  connect(zon2.TAir, conFCU[3].TZon) annotation (Line(points={{261,88},{274,88},
          {274,96},{-100,96},{-100,26},{-92,26}}, color={0,0,127}));
  connect(qIntGai.y, zon1.qGai_flow) annotation (Line(points={{31,80},{40,80},{
          40,92},{130,92},{130,80},{138,80}}, color={0,0,127}));
  connect(qIntGai.y, zon2.qGai_flow) annotation (Line(points={{31,80},{40,80},{
          40,92},{212,92},{212,80},{218,80}}, color={0,0,127}));
  connect(booToRea.y, mul.u1)
    annotation (Line(points={{-18,46},{-12,46}}, color={0,0,127}));
  connect(conFCU.yFan, booToRea.u) annotation (Line(points={{-48,30},{-44,30},{
          -44,46},{-42,46}}, color={255,0,255}));
  connect(conFCU.yFanSpe, mul.u2) annotation (Line(points={{-48,26},{-16,26},{
          -16,34},{-12,34}}, color={0,0,127}));
  connect(mul[1].y, triCom.uFan)
    annotation (Line(points={{12,40},{36,40},{36,31.6923}}, color={0,0,127}));
  connect(mul[2].y, triCom1.uFan) annotation (Line(points={{12,40},{162,40},{
          162,23.6923}}, color={0,0,127}));
  connect(mul[3].y, triCom2.uFan) annotation (Line(points={{12,40},{242,40},{
          242,23.6923}}, color={0,0,127}));
  connect(conInt.y, conFCU.uCooDemLimLev) annotation (Line(points={{-128,10},{
          -110,10},{-110,18},{-92,18}}, color={255,127,0}));
  connect(conInt.y, conFCU.uHeaDemLimLev) annotation (Line(points={{-128,10},{
          -110,10},{-110,14},{-92,14}}, color={255,127,0}));
  connect(triCom.TDisAir, conFCU[1].TSup) annotation (Line(points={{60,18.1538},
          {98,18.1538},{98,-64},{-100,-64},{-100,10},{-92,10}}, color={0,0,127}));
  connect(triCom1.TDisAir, conFCU[2].TSup) annotation (Line(points={{186,
          10.1538},{196,10.1538},{196,-64},{-100,-64},{-100,10},{-92,10}},
        color={0,0,127}));
  connect(triCom2.TDisAir, conFCU[3].TSup) annotation (Line(points={{266,
          10.1538},{272,10.1538},{272,-64},{-100,-64},{-100,10},{-92,10}},
        color={0,0,127}));
  connect(con.y, conFCU.warUpTim) annotation (Line(points={{-118,50},{-96,50},{
          -96,38},{-92,38}}, color={0,0,127}));
  connect(con.y, conFCU.cooDowTim) annotation (Line(points={{-118,50},{-96,50},
          {-96,34},{-92,34}}, color={0,0,127}));
  connect(occSch.tNexOcc, reaScaRep.u) annotation (Line(points={{-189,56},{-186,
          56},{-186,70},{-182,70}}, color={0,0,127}));
  connect(reaScaRep.y, conFCU.tNexOcc) annotation (Line(points={{-158,70},{-108,
          70},{-108,30},{-92,30}}, color={0,0,127}));
  connect(occSch.occupied, booScaRep.u) annotation (Line(points={{-189,44},{
          -186,44},{-186,30},{-182,30}}, color={255,0,255}));
  connect(booScaRep.y, conFCU.uOcc) annotation (Line(points={{-158,30},{-114,30},
          {-114,22},{-92,22}},                     color={255,0,255}));
  connect(conFCU.yFan, pre.u) annotation (Line(points={{-48,30},{-44,30},{-44,
          -10},{-42,-10}}, color={255,0,255}));
  connect(pre.y, conFCU.uFan) annotation (Line(points={{-18,-10},{-12,-10},{-12,
          -28},{-96,-28},{-96,6},{-92,6}}, color={255,0,255}));
  connect(conFCU[1].yHeaCoi, triCom.uHea) annotation (Line(points={{-48,14},{12,
          14},{12,38},{24,38},{24,31.6923}}, color={0,0,127}));
  connect(conFCU[2].yHeaCoi, triCom1.uHea) annotation (Line(points={{-48,14},{
          12,14},{12,38},{150,38},{150,23.6923}}, color={0,0,127}));
  connect(conFCU[3].yHeaCoi, triCom2.uHea) annotation (Line(points={{-48,14},{
          12,14},{12,38},{230,38},{230,23.6923}}, color={0,0,127}));
  connect(conFCU[1].yCooCoi, triCom.uCoo) annotation (Line(points={{-48,10},{0,
          10},{0,-20},{110,-20},{110,36},{48,36},{48,31.6923}}, color={0,0,127}));
  connect(conFCU[2].yCooCoi, triCom1.uCoo) annotation (Line(points={{-48,10},{0,
          10},{0,-20},{110,-20},{110,36},{174,36},{174,23.6923}}, color={0,0,
          127}));
  connect(conFCU[3].yCooCoi, triCom2.uCoo) annotation (Line(points={{-48,10},{0,
          10},{0,-20},{110,-20},{110,36},{254,36},{254,23.6923}}, color={0,0,
          127}));
  annotation (
    Documentation(
      info="<html>
<p>
This example models the living room as an unconditioned zone in Modelica.
The living room is connected to a fresh air supply and exhaust.
The heat balance of the air of the other two thermal zones, i.e.,
the attic and the garage, are modeled in EnergyPlus.
</p>
</html>",
      revisions="<html>
<ul>
<li>
March 1, 2018, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"),
    __Dymola_Commands(
      file="modelica://Buildings/Resources/Scripts/Dymola/Controls/OBC/ASHRAE/FanCoilUnit/ClosedLoopValidation/FCU.mos" "Simulate and plot"),
    experiment(
      StopTime=432000,
      Tolerance=1e-06),
    Diagram(coordinateSystem(extent={{-220,-100},{340,100}})),
    Icon(coordinateSystem(extent={{-220,-100},{340,100}})));
end FCU;
