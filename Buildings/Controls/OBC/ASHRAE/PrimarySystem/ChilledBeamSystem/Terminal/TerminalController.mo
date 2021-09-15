within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChilledBeamSystem.Terminal;
block TerminalController "Terminal controller"

  parameter Integer nSchRow=4
    "Number of rows in schedule table";

  parameter Real schTab[nSchRow,2]=[0,1; 6,1; 18,1; 24,1]
    "Table defining schedule for enabling plant";

  parameter Real conSenOnThr(
    final unit="s",
    displayUnit="s",
    final quantity="Time")=60
    "Threshold time for condensation sensor signal before CAV damper is completely opened"
    annotation(Dialog(tab="Zone regulation parameters"));

  parameter CDL.Types.SimpleController controllerTypeCoo=Buildings.Controls.OBC.CDL.Types.SimpleController.PI
    "Type of controller"
    annotation(Dialog(tab="Zone regulation parameters", group="Cooling control parameters"));
  parameter Real kCoo(
    final unit="1",
    displayUnit="1")=0.1
    "Gain for cooling control loop signal"
    annotation(Dialog(tab="Zone regulation parameters", group="Cooling control parameters"));
  parameter Real TiCoo=900
    "Time constant of integrator block for cooling control loop signal"
    annotation(Dialog(tab="Zone regulation parameters", group="Cooling control parameters"));
  parameter Real TdCoo(
    final unit="s",
    displayUnit="s",
    final quantity="Time")=0.1
    "Time constant of derivative block for cooling control loop signal"
    annotation(Dialog(tab="Zone regulation parameters", group="Cooling control parameters"));

  parameter CDL.Types.SimpleController controllerTypeHea=Buildings.Controls.OBC.CDL.Types.SimpleController.PI
    "Type of controller"
    annotation(Dialog(tab="Zone regulation parameters", group="Heating control parameters"));
  parameter Real kHea(
    final unit="1",
    displayUnit="1")=0.1 "Gain for heating control loop signal"
    annotation(Dialog(tab="Zone regulation parameters", group="Heating control parameters"));
  parameter Real TiHea=900
    "Time constant of integrator block for heating control loop signal"
    annotation(Dialog(tab="Zone regulation parameters", group="Heating control parameters"));
  parameter Real TdHea(
    final unit="s",
    displayUnit="s",
    final quantity="Time")=0.1
    "Time constant of derivative block for heating control loop signal"
    annotation(Dialog(tab="Zone regulation parameters", group="Heating control parameters"));

  parameter CDL.Types.SimpleController controllerTypeDam=Buildings.Controls.OBC.CDL.Types.SimpleController.PI
    "Type of controller"
    annotation(Dialog(tab="Zone regulation parameters", group="Ventilation control parameters"));
  parameter Real kDam(
    final unit="1",
    displayUnit="1")=0.5 "Gain of controller for damper control"
    annotation(Dialog(tab="Zone regulation parameters", group="Ventilation control parameters"));
  parameter Real TiDam=300
    "Time constant of integrator block for damper control"
    annotation(Dialog(tab="Zone regulation parameters", group="Ventilation control parameters"));
  parameter Real TdDam(
    final unit="s",
    displayUnit="s",
    final quantity="Time")=0.1
    "Time constant of derivative block for damper control"
    annotation(Dialog(tab="Zone regulation parameters", group="Ventilation control parameters"));

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
    annotation(Dialog(tab="Request generation", group="Chilled water supply parameters"));

  parameter Real valPosLowOpeReq(
    final unit="1",
    displayUnit="1") = 0.1
    "Upper limit for sending one request for chilled water supply"
    annotation(Dialog(tab="Request generation", group="Chilled water supply parameters"));

  parameter Real valPosHigCloReq(
    final unit="1",
    displayUnit="1") = 0.45
    "Lower limit for sending two requests for chilled water supply"
    annotation(Dialog(tab="Request generation", group="Chilled water supply parameters"));

  parameter Real valPosHigOpeReq(
    final unit="1",
    displayUnit="1") = 0.5
    "Upper limit for sending two requests for chilled water supply"
    annotation(Dialog(tab="Request generation", group="Chilled water supply parameters"));

  parameter Real thrTimLowReq(
    final unit="s",
    displayUnit="s",
    final quantity="Duration") = 300
    "Threshold time for generating one chilled water supply request"
    annotation(Dialog(tab="Request generation", group="Chilled water supply parameters"));

  parameter Real thrTimHigReq(
    final unit="s",
    displayUnit="s",
    final quantity="Duration") = 60
    "Threshold time for generating two chilled water supply requests"
    annotation(Dialog(tab="Request generation", group="Chilled water supply parameters"));

  parameter Real valPosLowCloTemRes(
    final unit="1",
    displayUnit="1") = 0.45
    "Lower limit for sending one request for chilled water temperature reset"
    annotation(Dialog(tab="Request generation", group="Chilled water temperature reset parameters"));

  parameter Real valPosLowOpeTemRes(
    final unit="1",
    displayUnit="1") = 0.5
    "Upper limit for sending one request for chilled water temperature reset"
    annotation(Dialog(tab="Request generation", group="Chilled water temperature reset parameters"));

  parameter Real valPosHigCloTemRes(
    final unit="1",
    displayUnit="1") = 0.95
    "Lower limit for sending two requests for chilled water temperature reset"
    annotation(Dialog(tab="Request generation", group="Chilled water temperature reset parameters"));

  parameter Real valPosHigOpeTemRes(
    final unit="1",
    displayUnit="1") = 0.99
    "Upper limit for sending two requests for chilled water temperature reset"
    annotation(Dialog(tab="Request generation", group="Chilled water temperature reset parameters"));

  parameter Real thrTimLowTemRes(
    final unit="s",
    displayUnit="s",
    final quantity="Duration") = 300
    "Threshold time for generating one chilled water temperature reset request"
    annotation(Dialog(tab="Request generation", group="Chilled water temperature reset parameters"));

  parameter Real thrTimHigTemRes(
    final unit="s",
    displayUnit="s",
    final quantity="Duration") = 60
    "Threshold time for generating two chilled water temperature reset requests"
    annotation(Dialog(tab="Request generation", group="Chilled water temperature reset parameters"));

  CDL.Interfaces.BooleanInput uDetOcc "Detected occupancy in zone"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  CDL.Interfaces.BooleanInput uConSen
    "Signal indicating condensation detected in zone"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));

  CDL.Interfaces.RealInput TZon(
    final unit="K",
    displayUnit="K",
    final quantity="ThermodynamicTemperature")
    "Measured zone temperature"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));

  CDL.Interfaces.RealInput VDis_flow(
    final unit="m3/s",
    displayUnit="m3/s",
    final quantity="VolumeFlowRate")
    "Measured discharge air flow rate from CAV terminal"
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));

  CDL.Interfaces.RealInput uChiVal(
    final unit="1",
    displayUnit="1")
    "Measured chilled beam manifold control valve position"
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));

  CDL.Interfaces.IntegerOutput yChiWatSupReq "Chilled water supply requests"
    annotation (Placement(transformation(extent={{100,-60},{140,-20}})));
  CDL.Interfaces.IntegerOutput TChiWatReq
    "Chilled water temperature reset requests"
    annotation (Placement(transformation(extent={{100,-100},{140,-60}})));

  CDL.Interfaces.RealOutput yReh "CAV terminal reheat signal"
    annotation (Placement(transformation(extent={{100,60},{140,100}})));
  CDL.Interfaces.RealOutput yDam "CAV terminal damper position signal"
    annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  CDL.Interfaces.RealOutput yChiVal
    "Chilled beam manifold control valve position signal"
    annotation (Placement(transformation(extent={{100,20},{140,60}})));
  SetPoints.OperatingMode opeMod(final nSchRow=nSchRow, final schTab=schTab)
    "Determine operating mode for zone"
    annotation (Placement(transformation(extent={{-80,70},{-60,90}})));

  SetPoints.ZoneRegulation zonRegCon(
    conSenOnThr=conSenOnThr,
    controllerTypeCoo=controllerTypeCoo,
    kCoo=kCoo,
    TiCoo=TiCoo,
    TdCoo=TdCoo,
    controllerTypeHea=controllerTypeHea,
    kHea=kHea,
    TiHea=TiHea,
    TdHea=TdHea,
    controllerTypeDam=controllerTypeDam,
    kDam=kDam,
    TiDam=TiDam,
    TdDam=TdDam,
    VDes_occ=VDes_occ,
    VDes_unoccSch=VDes_unoccSch,
    VDes_unoccUnsch=VDes_unoccUnsch,
    zonOccHeaSet=zonOccHeaSet,
    zonUnoccHeaSet=zonUnoccHeaSet,
    zonOccCooSet=zonOccCooSet,
    zonUnoccCooSet=zonUnoccCooSet)
    annotation (Placement(transformation(extent={{-10,20},{10,40}})));

  SetPoints.ChilledWaterSupplyReset chiWatSupRes(
    valPosLowCloReq=valPosLowCloReq,
    valPosLowOpeReq=valPosLowOpeReq,
    valPosHigCloReq=valPosHigCloReq,
    valPosHigOpeReq=valPosHigOpeReq,
    thrTimLowReq=thrTimLowReq,
    thrTimHigReq=thrTimHigReq,
    valPosLowCloTemRes=valPosLowCloTemRes,
    valPosLowOpeTemRes=valPosLowOpeTemRes,
    valPosHigCloTemRes=valPosHigCloTemRes,
    valPosHigOpeTemRes=valPosHigOpeTemRes,
    thrTimLowTemRes=thrTimLowTemRes,
    thrTimHigTemRes=thrTimHigTemRes)
    annotation (Placement(transformation(extent={{-10,-70},{10,-50}})));

equation
  connect(uDetOcc, opeMod.uDetOcc)
    annotation (Line(points={{-120,80},{-82,80}}, color={255,0,255}));
  connect(opeMod.yOpeMod, zonRegCon.uOpeMod) annotation (Line(points={{-58,80},{
          -50,80},{-50,24},{-12,24}}, color={255,127,0}));
  connect(uConSen, zonRegCon.uConSen) annotation (Line(points={{-120,40},{-60,40},
          {-60,32},{-12,32}},   color={255,0,255}));
  connect(TZon, zonRegCon.TZon) annotation (Line(points={{-120,0},{-40,0},{-40,36},
          {-12,36}},       color={0,0,127}));
  connect(VDis_flow, zonRegCon.VDis_flow) annotation (Line(points={{-120,-40},{-30,
          -40},{-30,28},{-12,28}},     color={0,0,127}));
  connect(zonRegCon.yReh, yReh) annotation (Line(points={{12,34},{60,34},{60,80},
          {120,80}}, color={0,0,127}));
  connect(zonRegCon.yChiVal, yChiVal)
    annotation (Line(points={{12,30},{66,30},{66,40},{120,40}},
                                              color={0,0,127}));
  connect(zonRegCon.yDam, yDam) annotation (Line(points={{12,26},{60,26},{60,0},
          {120,0}},        color={0,0,127}));
  connect(uChiVal, chiWatSupRes.uValPos) annotation (Line(points={{-120,-80},{-20,
          -80},{-20,-56},{-12,-56}}, color={0,0,127}));
  connect(uConSen, chiWatSupRes.uConSen) annotation (Line(points={{-120,40},{-60,
          40},{-60,-64},{-12,-64}}, color={255,0,255}));
  connect(chiWatSupRes.yChiWatSupReq, yChiWatSupReq) annotation (Line(points={{12,
          -54},{80,-54},{80,-40},{120,-40}}, color={255,127,0}));
  connect(chiWatSupRes.TChiWatReq, TChiWatReq) annotation (Line(points={{12,-66},
          {80,-66},{80,-80},{120,-80}}, color={255,127,0}));
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
        fillPattern=FillPattern.Solid)}),              Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TerminalController;
