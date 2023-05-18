within Buildings.Controls.OBC.ChilledBeams.Terminal;
block Controller
  "Controller for zone CAV terminal and chilled beam manifold control valve"

  parameter Real conSenOnThr(
    final unit="s",
    displayUnit="s",
    final quantity="Time")=60
    "Threshold time for condensation sensor signal before CAV damper is completely opened"
    annotation(Dialog(tab="Zone regulation parameters"));

  parameter Buildings.Controls.OBC.CDL.Types.SimpleController controllerTypeCoo=Buildings.Controls.OBC.CDL.Types.SimpleController.PI
    "Type of controller"
    annotation(Dialog(tab="Zone regulation parameters",
      group="Cooling control parameters"));

  parameter Real kCoo(
    final unit="1",
    displayUnit="1")=0.1
    "Gain for cooling control loop signal"
    annotation(Dialog(tab="Zone regulation parameters",
      group="Cooling control parameters"));

  parameter Real TiCoo=900
    "Time constant of integrator block for cooling control loop signal"
    annotation(Dialog(tab="Zone regulation parameters",
      group="Cooling control parameters"));

  parameter Real TdCoo(
    final unit="s",
    displayUnit="s",
    final quantity="Time")=0.1
    "Time constant of derivative block for cooling control loop signal"
    annotation(Dialog(tab="Zone regulation parameters",
      group="Cooling control parameters"));

  parameter Buildings.Controls.OBC.CDL.Types.SimpleController controllerTypeHea=Buildings.Controls.OBC.CDL.Types.SimpleController.PI
    "Type of controller"
    annotation(Dialog(tab="Zone regulation parameters",
      group="Heating control parameters"));

  parameter Real kHea(
    final unit="1",
    displayUnit="1")=0.1
    "Gain for heating control loop signal"
    annotation(Dialog(tab="Zone regulation parameters",
      group="Heating control parameters"));

  parameter Real TiHea=900
    "Time constant of integrator block for heating control loop signal"
    annotation(Dialog(tab="Zone regulation parameters",
      group="Heating control parameters"));

  parameter Real TdHea(
    final unit="s",
    displayUnit="s",
    final quantity="Time")=0.1
    "Time constant of derivative block for heating control loop signal"
    annotation(Dialog(tab="Zone regulation parameters",
      group="Heating control parameters"));

  parameter Buildings.Controls.OBC.CDL.Types.SimpleController controllerTypeDam=Buildings.Controls.OBC.CDL.Types.SimpleController.PI
    "Type of controller"
    annotation(Dialog(tab="Zone regulation parameters",
      group="Ventilation control parameters"));

  parameter Real kDam(
    final unit="1",
    displayUnit="1")=0.5
    "Gain of controller for damper control"
    annotation(Dialog(tab="Zone regulation parameters",
      group="Ventilation control parameters"));

  parameter Real TiDam=300
    "Time constant of integrator block for damper control"
    annotation(Dialog(tab="Zone regulation parameters",
      group="Ventilation control parameters"));

  parameter Real TdDam(
    final unit="s",
    displayUnit="s",
    final quantity="Time")=0.1
    "Time constant of derivative block for damper control"
    annotation(Dialog(tab="Zone regulation parameters",
      group="Ventilation control parameters"));

  parameter Real VDes_occ(
    final unit="m3/s",
    displayUnit="m3/s",
    final quantity="VolumeFlowRate")
    "Design air volume flow rate when zone is occupied"
    annotation(Dialog(tab="Zone setpoints", group="Ventilation setpoints"));

  parameter Real VDes_unoccSch(
    final unit="m3/s",
    displayUnit="m3/s",
    final quantity="VolumeFlowRate")
    "Design air volume flow rate when zone is unoccupied during scheduled unoccupancy"
    annotation(Dialog(tab="Zone setpoints", group="Ventilation setpoints"));

  parameter Real VDes_unoccUnsch(
    final unit="m3/s",
    displayUnit="m3/s",
    final quantity="VolumeFlowRate")
    "Design air volume flow rate when zone is unoccupied during scheduled occupancy"
    annotation(Dialog(tab="Zone setpoints", group="Ventilation setpoints"));

  parameter Real zonOccHeaSet(
    final unit="K",
    displayUnit="K",
    final quantity="ThermodynamicTemperature")=293.15
    "Zone heating setpoint when it is occupied"
    annotation(Dialog(tab="Zone setpoints", group="Temperature setpoints"));

  parameter Real zonUnoccHeaSet(
    final unit="K",
    displayUnit="K",
    final quantity="ThermodynamicTemperature")=290.15
    "Zone heating setpoint when it is unoccupied"
    annotation(Dialog(tab="Zone setpoints", group="Temperature setpoints"));

  parameter Real zonOccCooSet(
    final unit="K",
    displayUnit="K",
    final quantity="ThermodynamicTemperature")=296.15
    "Zone cooling setpoint when it is occupied"
    annotation(Dialog(tab="Zone setpoints", group="Temperature setpoints"));

  parameter Real zonUnoccCooSet(
    final unit="K",
    displayUnit="K",
    final quantity="ThermodynamicTemperature")=299.15
    "Zone cooling setpoint when it is unoccupied"
    annotation(Dialog(tab="Zone setpoints", group="Temperature setpoints"));

  parameter Real valPosLowCloReq(
    final unit="1",
    displayUnit="1") = 0.05
    "Lower limit for sending one request for chilled water supply"
    annotation(Dialog(tab="Request generation",
      group="Chilled water supply parameters"));

  parameter Real valPosLowOpeReq(
    final unit="1",
    displayUnit="1") = 0.1
    "Upper limit for sending one request for chilled water supply"
    annotation(Dialog(tab="Request generation",
      group="Chilled water supply parameters"));

  parameter Real valPosHigCloReq(
    final unit="1",
    displayUnit="1") = 0.45
    "Lower limit for sending two requests for chilled water supply"
    annotation(Dialog(tab="Request generation",
      group="Chilled water supply parameters"));

  parameter Real valPosHigOpeReq(
    final unit="1",
    displayUnit="1") = 0.5
    "Upper limit for sending two requests for chilled water supply"
    annotation(Dialog(tab="Request generation",
      group="Chilled water supply parameters"));

  parameter Real thrTimLowReq(
    final unit="s",
    displayUnit="s",
    final quantity="Duration") = 300
    "Threshold time for generating one chilled water supply request"
    annotation(Dialog(tab="Request generation",
      group="Chilled water supply parameters"));

  parameter Real thrTimHigReq(
    final unit="s",
    displayUnit="s",
    final quantity="Duration") = 60
    "Threshold time for generating two chilled water supply requests"
    annotation(Dialog(tab="Request generation",
      group="Chilled water supply parameters"));

  parameter Real valPosLowCloTemRes(
    final unit="1",
    displayUnit="1") = 0.45
    "Lower limit for sending one request for chilled water temperature reset"
    annotation(Dialog(tab="Request generation",
      group="Chilled water temperature reset parameters"));

  parameter Real valPosLowOpeTemRes(
    final unit="1",
    displayUnit="1") = 0.5
    "Upper limit for sending one request for chilled water temperature reset"
    annotation(Dialog(tab="Request generation",
      group="Chilled water temperature reset parameters"));

  parameter Real valPosHigCloTemRes(
    final unit="1",
    displayUnit="1") = 0.95
    "Lower limit for sending two requests for chilled water temperature reset"
    annotation(Dialog(tab="Request generation",
      group="Chilled water temperature reset parameters"));

  parameter Real valPosHigOpeTemRes(
    final unit="1",
    displayUnit="1") = 0.99
    "Upper limit for sending two requests for chilled water temperature reset"
    annotation(Dialog(tab="Request generation",
      group="Chilled water temperature reset parameters"));

  parameter Real thrTimLowTemRes(
    final unit="s",
    displayUnit="s",
    final quantity="Duration") = 300
    "Threshold time for generating one chilled water temperature reset request"
    annotation(Dialog(tab="Request generation",
      group="Chilled water temperature reset parameters"));

  parameter Real thrTimHigTemRes(
    final unit="s",
    displayUnit="s",
    final quantity="Duration") = 60
    "Threshold time for generating two chilled water temperature reset requests"
    annotation(Dialog(tab="Request generation",
      group="Chilled water temperature reset parameters"));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uDetOcc
    "Detected occupancy in zone"
    annotation (Placement(transformation(extent={{-128,66},{-100,94}}),
        iconTransformation(extent={{-128,66},{-100,94}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uConSen
    "Signal indicating condensation detected in zone"
    annotation (Placement(transformation(extent={{-128,-34},{-100,-6}}),
        iconTransformation(extent={{-128,-34},{-100,-6}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput TZon(
    final unit="K",
    displayUnit="K",
    final quantity="ThermodynamicTemperature")
    "Measured zone temperature"
    annotation (Placement(transformation(extent={{-128,-54},{-100,-26}}),
        iconTransformation(extent={{-128,-54},{-100,-26}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput VDis_flow(
    final unit="m3/s",
    displayUnit="m3/s",
    final quantity="VolumeFlowRate")
    "Measured discharge air flow rate from CAV terminal"
    annotation (Placement(transformation(extent={{-128,-74},{-100,-46}}),
        iconTransformation(extent={{-128,-74},{-100,-46}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput uChiVal(
    final unit="1",
    displayUnit="1")
    "Measured chilled beam manifold control valve position"
    annotation (Placement(transformation(extent={{-128,-94},{-100,-66}}),
        iconTransformation(extent={{-128,-94},{-100,-66}})));

  Buildings.Controls.OBC.CDL.Interfaces.IntegerOutput yChiWatSupReq
    "Chilled water supply requests"
    annotation (Placement(transformation(extent={{100,-54},{128,-26}}),
        iconTransformation(extent={{100,-54},{128,-26}})));

  Buildings.Controls.OBC.CDL.Interfaces.IntegerOutput TChiWatReq
    "Chilled water temperature reset requests"
    annotation (Placement(transformation(extent={{100,-94},{128,-66}}),
        iconTransformation(extent={{100,-94},{128,-66}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yReh
    "CAV terminal reheat signal"
    annotation (Placement(transformation(extent={{100,66},{128,94}}),
        iconTransformation(extent={{100,66},{128,94}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yDam
    "CAV terminal damper position signal"
    annotation (Placement(transformation(extent={{100,-14},{128,14}}),
        iconTransformation(extent={{100,-14},{128,14}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yChiVal
    "Chilled beam manifold control valve position signal"
    annotation (Placement(transformation(extent={{100,26},{128,54}}),
        iconTransformation(extent={{100,26},{128,54}})));

  Buildings.Controls.OBC.ChilledBeams.SetPoints.ZoneRegulation zonRegCon(
    final conSenOnThr=conSenOnThr,
    final controllerTypeCoo=controllerTypeCoo,
    final kCoo=kCoo,
    final TiCoo=TiCoo,
    final TdCoo=TdCoo,
    final controllerTypeHea=controllerTypeHea,
    final kHea=kHea,
    final TiHea=TiHea,
    final TdHea=TdHea,
    final controllerTypeDam=controllerTypeDam,
    final kDam=kDam,
    final TiDam=TiDam,
    final TdDam=TdDam,
    final VDes_occ=VDes_occ,
    final VDes_unoccSch=VDes_unoccSch,
    final VDes_unoccUnsch=VDes_unoccUnsch,
    final zonOccHeaSet=zonOccHeaSet,
    final zonUnoccHeaSet=zonUnoccHeaSet,
    final zonOccCooSet=zonOccCooSet,
    final zonUnoccCooSet=zonUnoccCooSet)
    "Zone temperature regulation controller"
    annotation (Placement(transformation(extent={{-10,16},{10,36}})));

  CDL.Interfaces.RealInput TZonHeaSet(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="K") "Zone heating setpoint temperature" annotation (Placement(
        transformation(extent={{-128,26},{-100,54}}), iconTransformation(extent=
           {{-128,26},{-100,54}})));
  CDL.Interfaces.RealInput TZonCooSet(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="K") "Zone cooling setpoint temperature" annotation (Placement(
        transformation(extent={{-128,6},{-100,34}}), iconTransformation(extent={
            {-128,6},{-100,34}})));
  CDL.Interfaces.BooleanInput uOcc "Define when occupancy is expected"
    annotation (Placement(transformation(extent={{-128,46},{-100,74}}),
        iconTransformation(extent={{-128,46},{-100,74}})));
protected
  Buildings.Controls.OBC.ChilledBeams.SetPoints.OperatingMode opeMod
    "Determine operating mode for zone"
    annotation (Placement(transformation(extent={{-80,70},{-60,90}})));

  Buildings.Controls.OBC.ChilledBeams.SetPoints.ChilledWaterSupplyReset chiWatSupRes(
    final valPosLowCloReq=valPosLowCloReq,
    final valPosLowOpeReq=valPosLowOpeReq,
    final valPosHigCloReq=valPosHigCloReq,
    final valPosHigOpeReq=valPosHigOpeReq,
    final thrTimLowReq=thrTimLowReq,
    final thrTimHigReq=thrTimHigReq,
    final valPosLowCloTemRes=valPosLowCloTemRes,
    final valPosLowOpeTemRes=valPosLowOpeTemRes,
    final valPosHigCloTemRes=valPosHigCloTemRes,
    final valPosHigOpeTemRes=valPosHigOpeTemRes,
    final thrTimLowTemRes=thrTimLowTemRes,
    final thrTimHigTemRes=thrTimHigTemRes)
    "Chilled water supply and temperature reset request generation"
    annotation (Placement(transformation(extent={{-10,-70},{10,-50}})));

equation
  connect(uDetOcc, opeMod.uDetOcc)
    annotation (Line(points={{-114,80},{-82,80}}, color={255,0,255}));
  connect(opeMod.yOpeMod, zonRegCon.uOpeMod) annotation (Line(points={{-58,80},{
          -50,80},{-50,18},{-12,18}}, color={255,127,0}));
  connect(uConSen, zonRegCon.uConSen) annotation (Line(points={{-114,-20},{-62,-20},
          {-62,24.6},{-12,24.6}},
                                color={255,0,255}));
  connect(TZon, zonRegCon.TZon) annotation (Line(points={{-114,-40},{-32,-40},{-32,
          31.2},{-12,31.2}},
                           color={0,0,127}));
  connect(VDis_flow, zonRegCon.VDis_flow) annotation (Line(points={{-114,-60},{-36,
          -60},{-36,21.2},{-12,21.2}}, color={0,0,127}));
  connect(zonRegCon.yReh, yReh) annotation (Line(points={{12,30},{60,30},{60,80},
          {114,80}}, color={0,0,127}));
  connect(zonRegCon.yChiVal, yChiVal)
    annotation (Line(points={{12,26},{66,26},{66,40},{114,40}},
                                              color={0,0,127}));
  connect(zonRegCon.yDam, yDam) annotation (Line(points={{12,22},{60,22},{60,0},
          {114,0}},        color={0,0,127}));
  connect(uChiVal, chiWatSupRes.uValPos) annotation (Line(points={{-114,-80},{-20,
          -80},{-20,-56},{-12,-56}}, color={0,0,127}));
  connect(uConSen, chiWatSupRes.uConSen) annotation (Line(points={{-114,-20},{-18,
          -20},{-18,-64},{-12,-64}},color={255,0,255}));
  connect(chiWatSupRes.yChiWatSupReq, yChiWatSupReq) annotation (Line(points={{12,-54},
          {80,-54},{80,-40},{114,-40}},      color={255,127,0}));
  connect(chiWatSupRes.TChiWatReq, TChiWatReq) annotation (Line(points={{12,-66},
          {80,-66},{80,-80},{114,-80}}, color={255,127,0}));
  connect(zonRegCon.TZonHeaSet, TZonHeaSet) annotation (Line(points={{-12,34.2},
          {-42,34.2},{-42,34},{-70,34},{-70,40},{-114,40}}, color={0,0,127}));
  connect(zonRegCon.TZonCooSet, TZonCooSet) annotation (Line(points={{-12,28},{-70,
          28},{-70,20},{-114,20}}, color={0,0,127}));
  connect(opeMod.uOcc, uOcc) annotation (Line(points={{-82,72},{-90,72},{-90,60},
          {-114,60}}, color={255,0,255}));
  annotation (defaultComponentName="terCon",
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Text(
          extent={{-120,160},{114,108}},
          textString="%name",
          lineColor={0,0,255}),
                 Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
        Text(
          extent={{-98,88},{-62,72}},
          textColor={255,0,255},
          pattern=LinePattern.Dash,
          textString="uDetOcc"),
        Text(
          extent={{-98,-12},{-62,-28}},
          textColor={255,0,255},
          pattern=LinePattern.Dash,
          textString="uConSen"),
        Text(
          extent={{-100,-36},{-76,-46}},
          textColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="TZon"),
        Text(
          extent={{-98,-52},{-62,-68}},
          textColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="VDis_flow"),
        Text(
          extent={{-98,-74},{-68,-86}},
          textColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="uChiVal"),
        Text(
          extent={{74,86},{100,76}},
          textColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="yReh"),
        Text(
          extent={{70,46},{98,34}},
          textColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="yChiVal"),
        Text(
          extent={{74,6},{98,-4}},
          textColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="yDam"),
        Text(
          extent={{42,-24},{98,-56}},
          textColor={255,127,0},
          pattern=LinePattern.Dash,
          textString="yChiWatSupReq"),
        Text(
          extent={{54,-70},{98,-90}},
          textColor={255,127,0},
          pattern=LinePattern.Dash,
          textString="TChiWatReq"),
        Text(
          extent={{-98,54},{-54,28}},
          textColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="TZonHeaSet"),
        Text(
          extent={{-98,32},{-54,6}},
          textColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="TZonCooSet"),
        Text(
          extent={{-100,66},{-72,56}},
          textColor={255,0,255},
          pattern=LinePattern.Dash,
          textString="uOcc")}),                        Diagram(
        coordinateSystem(preserveAspectRatio=false)),
  Documentation(info="<html>
<p>
Sequences for operating the zone CAV terminal box and the zone chilled beam manifold 
control valve.
</p>
<p>
This block generates signals for chilled water beam manifold control valve 
<code>yChiVal</code>, CAV terminal reheat signal <code>yReh</code> and CAV 
damper position signal <code>yDam</code>. It also generates the requests for 
chilled water supply <code>yChiWatSupReq</code> and chilled water supply temperature 
reset <code>TChiWatReq</code>. It consists of the following components:
<ol>
<li>
<a href=\"modelica://Buildings.Controls.OBC.ChilledBeams.SetPoints.OperatingMode\">
Buildings.Controls.OBC.ChilledBeams.SetPoints.OperatingMode</a>:
This block generates an operating mode type signal based on the detected zone 
occupancy <code>uDetOcc</code> and the zone occupancy schedule <code>schTab</code>.
</li>
<li>
<a href=\"modelica://Buildings.Controls.OBC.ChilledBeams.SetPoints.ZoneRegulation\">
Buildings.Controls.OBC.ChilledBeams.SetPoints.ZoneRegulation</a>:
This block generates the output signals <code>yChiVal</code>, <code>yReh</code>
and <code>yDam</code> to regulate the zone temperature within the heating and
cooling temperature setpoints.
</li>
<li>
<a href=\"modelica://Buildings.Controls.OBC.ChilledBeams.SetPoints.ChilledWaterSupplyReset\">
Buildings.Controls.OBC.ChilledBeams.SetPoints.ChilledWaterSupplyReset</a>:
This block generates the output signals <code>yChiWatSupReq</code>
and <code>TChiWatReq</code> which are provided to the chiller plant system 
supplying chilled water.
</li>
</ol>
</p>
</html>",
revisions="<html>
<ul>
<li>
June 16, 2021, by Karthik Devaprasad:<br/>
First implementation.
</li>
</ul>
</html>"));
end Controller;
