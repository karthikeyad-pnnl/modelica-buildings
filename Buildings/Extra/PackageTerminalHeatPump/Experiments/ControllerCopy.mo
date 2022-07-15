within Buildings.Extra.PackageTerminalHeatPump.Experiments;
model ControllerCopy
  "Controller for single zone VAV system"
  extends .Modelica.Blocks.Icons.Block;

  parameter .Modelica.SIunits.Temperature TSupChi_nominal
    "Design value for chiller leaving water temperature";
  parameter Real minAirFlo(
    final min=0,
    final max=1,
    final unit="1")
    "Minimum airflow fraction of system"
    annotation(Dialog(group="Setpoints"));
  parameter .Modelica.SIunits.DimensionlessRatio minOAFra
    "Minimum outdoor air fraction of system"
    annotation(Dialog(group="Setpoints"));
  parameter .Modelica.SIunits.Temperature TSetSupAir
    "Cooling supply air temperature setpoint"
    annotation(Dialog(group="Setpoints"));
  parameter .Buildings.Controls.OBC.CDL.Types.SimpleController controllerTypeHea=
    .Buildings.Controls.OBC.CDL.Types.SimpleController.PI
    "Type of controller"
    annotation(Dialog(group="Heating coil control"));
  parameter Real kHea(
    final unit="1/K")=0.1
    "Gain for heating coil control signal"
    annotation(Dialog(group="Heating coil control"));
  parameter Real TiHea(
    final unit="s",
    final quantity="Time")=900
    "Time constant of integrator block for heating coil control signal"
    annotation(Dialog(group="Heating coil control",
    enable=controllerTypeHea == .Buildings.Controls.OBC.CDL.Types.SimpleController.PI
        or controllerTypeHea == .Buildings.Controls.OBC.CDL.Types.SimpleController.PID));
  parameter Real TdHea(
    final unit="s",
    final quantity="Time")=0.1
    "Time constant of derivative block for heating coil control signal"
    annotation (Dialog(group="Heating coil control",
      enable=controllerTypeHea == .Buildings.Controls.OBC.CDL.Types.SimpleController.PD
          or controllerTypeHea == .Buildings.Controls.OBC.CDL.Types.SimpleController.PID));
  parameter .Buildings.Controls.OBC.CDL.Types.SimpleController controllerTypeCoo=
    .Buildings.Controls.OBC.CDL.Types.SimpleController.PI
    "Type of controller"
    annotation(Dialog(group="Cooling coil control"));
  parameter Real kCoo(
    final unit="1/K")=0.1
    "Gain for cooling coil control signal"
    annotation(Dialog(group="Cooling coil control"));
  parameter Real TiCoo(
    final unit="s")=900
    "Time constant of integrator block for cooling coil control signal"
    annotation(Dialog(group="Cooling coil control",
    enable=controllerTypeCoo == .Buildings.Controls.OBC.CDL.Types.SimpleController.PI
        or controllerTypeCoo == .Buildings.Controls.OBC.CDL.Types.SimpleController.PID));
  parameter Real TdCoo(
    final unit="s")=0.1
    "Time constant of derivative block for cooling coil control signal"
    annotation (Dialog(group="Cooling coil control",
    enable=controllerTypeCoo == .Buildings.Controls.OBC.CDL.Types.SimpleController.PD
        or controllerTypeCoo == .Buildings.Controls.OBC.CDL.Types.SimpleController.PID));
  parameter .Buildings.Controls.OBC.CDL.Types.SimpleController controllerTypeFan=
    .Buildings.Controls.OBC.CDL.Types.SimpleController.PI
    "Type of controller"
    annotation(Dialog(group="Fan control"));
  parameter Real kFan(final unit="1/K")=0.1
    "Gain for fan signal"
    annotation(Dialog(group="Fan control"));
  parameter Real TiFan(
    final unit="s",
    final quantity="Time")=900
    "Time constant of integrator block for fan signal"
    annotation(Dialog(group="Fan control",
    enable=controllerTypeFan == .Buildings.Controls.OBC.CDL.Types.SimpleController.PI
        or controllerTypeFan == .Buildings.Controls.OBC.CDL.Types.SimpleController.PID));
  parameter Real TdFan(
    final unit="s",
    final quantity="Time")=0.1
    "Time constant of derivative block for fan signal"
    annotation (Dialog(group="Fan control",
    enable=controllerTypeFan == .Buildings.Controls.OBC.CDL.Types.SimpleController.PD
        or controllerTypeFan == .Buildings.Controls.OBC.CDL.Types.SimpleController.PID));
  parameter .Buildings.Controls.OBC.CDL.Types.SimpleController controllerTypeEco=
    .Buildings.Controls.OBC.CDL.Types.SimpleController.PI
    "Type of controller"
    annotation(Dialog(group="Economizer control"));
  parameter Real kEco(final unit="1/K")=0.1
    "Gain for economizer control signal"
    annotation(Dialog(group="Economizer control"));
  parameter Real TiEco=300
    "Time constant of integrator block for economizer control signal"
    annotation(Dialog(group="Economizer control",
    enable=controllerTypeEco == .Buildings.Controls.OBC.CDL.Types.SimpleController.PI
        or controllerTypeEco == .Buildings.Controls.OBC.CDL.Types.SimpleController.PID));
  parameter Real TdEco(
    final unit="s",
    final quantity="Time")=0.1
    "Time constant of derivative block for economizer control signal"
    annotation (Dialog(group="Economizer control",
      enable=controllerTypeEco == .Buildings.Controls.OBC.CDL.Types.SimpleController.PD
          or controllerTypeEco == .Buildings.Controls.OBC.CDL.Types.SimpleController.PID));

  .Buildings.Controls.OBC.CDL.Interfaces.RealInput TSetRooCoo(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "Zone cooling setpoint temperature"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}}),
        iconTransformation(extent={{-140,10},{-100,50}})));
  .Buildings.Controls.OBC.CDL.Interfaces.RealInput TSetRooHea(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "Zone heating setpoint temperature"
    annotation (Placement(transformation(extent={{-140,100},{-100,140}}),
        iconTransformation(extent={{-140,40},{-100,80}})));
  .Buildings.Controls.OBC.CDL.Interfaces.RealInput TRoo(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "Zone temperature measurement"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},origin={-120,-80}),
        iconTransformation(extent={{-20,-20},{20,20}},origin={-120,-60})));
  .Buildings.Controls.OBC.CDL.Interfaces.RealInput TMix(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "Measured mixed air temperature"
    annotation (Placement(transformation(extent={{-140.0,10.0},{-100.0,50.0}},rotation = 0.0,origin = {0.0,0.0}),
        iconTransformation(extent={{-140,70},{-100,110}})));
  .Buildings.Controls.OBC.CDL.Interfaces.RealInput TOut(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "Measured outside air temperature"
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}}),
        iconTransformation(extent={{-140,-50},{-100,-10}})));
  .Buildings.Controls.OBC.CDL.Interfaces.RealOutput yFan(
    final unit="1") "Control signal for fan"
    annotation (Placement(transformation(extent={{100,80},{120,100}}),
        iconTransformation(extent={{100,60},{140,100}})));
  .Buildings.Controls.OBC.CDL.Interfaces.RealOutput yOutAirFra(
    final unit="1")
    "Control signal for outside air fraction"
    annotation (Placement(transformation(extent={{100,10},{120,30}}),
        iconTransformation(extent={{100,0},{140,40}})));
  .Buildings.Controls.OBC.CDL.Interfaces.RealOutput TSetSupHP(
    final unit="K",
    displayUnit="degC")
    "Set point for heat pump leaving air temperature"
    annotation (Placement(transformation(extent={{100,-100},{120,-80}}),
        iconTransformation(extent={{100,-100},{140,-60}})));

  .Buildings.Air.Systems.SingleZone.VAV.BaseClasses.ControllerHeatingFan conSup(
    final controllerTypeHea=controllerTypeHea,
    final kHea=kHea,
    final TiHea=TiHea,
    final TdHea=TdHea,
    final controllerTypeFan=controllerTypeFan,
    final kFan=kFan,
    final TiFan=TiFan,
    final TdFan=TdFan,
    final minAirFlo = minAirFlo)
    "Heating coil and fan controller"
    annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
  .Buildings.Controls.OBC.CDL.Logical.Switch swi
    "Switch the outdoor air fraction to 0 when in unoccupied mode"
    annotation (Placement(transformation(extent={{0,20},{20,40}})));
  .Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uOcc
    "Current occupancy period, true if it is in occupant period"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}}),
        iconTransformation(extent={{-140,-20},{-100,20}})));
  .Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con(k=0)
    "Zero outside air fraction"
    annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
  .Buildings.Controls.OBC.CDL.Logical.Switch swiFan "Switch fan on"
    annotation (Placement(transformation(extent={{70,120},{90,140}})));
  .Buildings.Controls.OBC.CDL.Continuous.Hysteresis hysHea(
    final uLow=0.01,
    final uHigh=0.05)
    "Hysteresis for heating"
    annotation (Placement(transformation(extent={{-30,120},{-10,140}})));
  .Buildings.Controls.OBC.CDL.Logical.MultiOr orFan(nu=3)
    "Switch fan on if heating, cooling, or occupied"
    annotation (Placement(transformation(extent={{40,94},{60,114}})));
  .Buildings.Controls.OBC.CDL.Continuous.Greater chiOnTRoo(h=1)
    "Chiller on signal based on room temperature"
    annotation (Placement(transformation(extent={{3.5270366754876967,-65.65258033026355},{23.527036675487697,-45.65258033026355}},rotation = 0.0,origin = {0.0,0.0})));
    .Buildings.Air.Systems.SingleZone.VAV.BaseClasses.ControllerEconomizer conEco2 annotation(Placement(transformation(extent = {{48.923550109570115,58.915481981581124},{68.92355010957012,78.91548198158112}},origin = {0.0,0.0},rotation = 0.0)));

protected
  .Modelica.Blocks.Sources.Constant TSetSupHPConst(
    final k=TSupChi_nominal)
    "Set point for heat pump temperature"
    annotation (Placement(transformation(extent={{60,-100},{80,-80}})));
  .Modelica.Blocks.Sources.Constant conMinOAFra(
    final k=minOAFra)
    "Minimum outside air fraction"
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));

equation
  connect(conSup.TRoo, TRoo) annotation (Line(points={{-61,84},{-74,84},{-74,
          -80},{-120,-80}}, color={0,0,127}));
  connect(conMinOAFra.y, swi.u1) annotation (Line(points={{-39,50},{-30,50},{-30,
          38},{-2,38}}, color={0,0,127}));
  connect(uOcc, swi.u2) annotation (Line(points={{-120,0},{-14,0},{-14,30},{-2,30}},
          color={255,0,255}));
  connect(con.y, swi.u3) annotation (Line(points={{-38,-20},{-6.619019797466451,-20},{-6.619019797466451,22},{-2,22}}, color={0,0,127}));
  connect(con.y, swiFan.u3) annotation (Line(points={{-38,-20},{-6.61901979746645,-20},{-6.61901979746645,122},{68,122}}, color={0,0,127}));
  connect(conSup.yFan, swiFan.u1) annotation (Line(points={{-39,94},{18,94},{18,
          138},{68,138}}, color={0,0,127}));
  connect(swiFan.y, yFan) annotation (Line(points={{92,130},{96,130},{96,90},{
          110,90}}, color={0,0,127}));
  connect(conSup.yHea, hysHea.u) annotation (Line(points={{-39,86},{-34,86},{
          -34,130},{-32,130}}, color={0,0,127}));
  connect(swiFan.u2, orFan.y)   annotation (Line(points={{68,130},{64,130},{64,104},{62,104}},
          color={255,0,255}));
  connect(hysHea.y, orFan.u[1]) annotation (Line(points={{-8,130},{24,130},{24,
          108.667},{38,108.667}},
                        color={255,0,255}));
  connect(uOcc, orFan.u[2]) annotation (Line(points={{-120,0},{-14,0},{-14,104},
          {38,104}},    color={255,0,255}));
  connect(TRoo, chiOnTRoo.u1) annotation (Line(points={{-120,-80},{-74,-80},{-74,-55.65258033026355},{1.5270366754876967,-55.65258033026355}}, color={0,0,127}));
  connect(TSetRooCoo, chiOnTRoo.u2) annotation (Line(points={{-120,60},{-80,60},{-80,-63.65258033026355},{1.5270366754876967,-63.65258033026355}}, color={0,0,127}));
  connect(TSetRooCoo, conSup.TSetRooCoo) annotation (Line(points={{-120,60},{-80,
          60},{-80,90},{-61,90}}, color={0,0,127}));
  connect(TSetRooHea, conSup.TSetRooHea) annotation (Line(points={{-120,120},{-80,
          120},{-80,96},{-61,96}}, color={0,0,127}));

  connect(chiOnTRoo.y, orFan.u[3]) annotation (Line(points={{25.527036675487697,-55.65258033026355},{34.05842258918169,-55.65258033026355},{34.05842258918169,99.3333},{38,99.3333}}, color={255,0,255}));
    connect(TSetSupHPConst.y,TSetSupHP) annotation(Line(points = {{81,-90},{110,-90}},color = {0,0,127}));
    connect(conEco2.yOutAirFra,yOutAirFra) annotation(Line(points = {{69.92355010957012,68.91548198158112},{90.493160968479,68.91548198158112},{90.493160968479,20},{110,20}},color = {0,0,127}));
    connect(TMix,conEco2.TMix) annotation(Line(points = {{-120,30},{-30.192979894581562,30},{-30.192979894581562,73.91548198158112},{47.923550109570115,73.91548198158112}},color = {0,0,127}));
    connect(TRoo,conEco2.TRet) annotation(Line(points = {{-120,-80},{-30.192979894581523,-80},{-30.192979894581523,70.91548198158112},{47.923550109570115,70.91548198158112}},color = {0,0,127}));
    connect(swi.y,conEco2.minOAFra) annotation(Line(points = {{22,30},{29.64791591784566,30},{29.64791591784566,66.91548198158112},{47.923550109570115,66.91548198158112}},color = {0,0,127}));
    connect(TOut,conEco2.TOut) annotation(Line(points = {{-120,-40},{-30.192979894581526,-40},{-30.192979894581526,63.915481981581124},{47.923550109570115,63.915481981581124}},color = {0,0,127}));
    connect(chiOnTRoo.y,conEco2.cooSta) annotation(Line(points = {{25.527036675487697,-55.65258033026355},{33.802670867212186,-55.65258033026355},{33.802670867212186,60.915481981581124},{47.923550109570115,60.915481981581124}},color = {255,0,255}));
  annotation (
  defaultComponentName="conChiDXHeaEco",
  Icon(graphics={Line(points={{-100,-100},{0,2},{-100,100}}, color=
              {0,0,0})}), Documentation(info="<html>
<p>
This is a controller for the single-zone VAV system with an economizer, a 
heating coil and a cooling coil.
</p>
</html>", revisions="<html>
<ul>
<li>
November 20, 2020, by David Blum:<br/>
Turn fan on when setup cooling required.
This is for <a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2265\">issue 2265</a>.
</li>
<li>
July 21, 2020, by Kun Zhang:<br/>
Exposed PID control parameters to allow users to tune for their specific systems.
</li>
<li>
June 21, 2017, by Michael Wetter:<br/>
Refactored implementation.
</li>
<li>
June 1, 2017, by David Blum:<br/>
First implementation.
</li>
</ul>
</html>"),
    Diagram(coordinateSystem(extent={{-100,-120},{100,140}})));
end ControllerCopy;
