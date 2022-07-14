within Buildings.Extra.PackageTerminalHeatPump.Experiments;

model ControllerChiller
  "Controller for single zone VAV system"
  extends .Modelica.Blocks.Icons.Block;

  parameter .Modelica.SIunits.Temperature TSupChi_nominal = TSupChi_nominal
    "Design value for chiller leaving water temperature";
  parameter Real minAirFlo(
    final min=0,
    final max=1,
    final unit="1") = 0.1
    "Minimum airflow fraction of system"
    annotation(Dialog(group="Setpoints"));
  parameter .Modelica.SIunits.DimensionlessRatio minOAFra = 0.4
    "Minimum outdoor air fraction of system"
    annotation(Dialog(group="Setpoints"));
  parameter .Modelica.SIunits.Temperature TSetSupAir = 286.15
    "Cooling supply air temperature setpoint"
    annotation(Dialog(group="Setpoints"));
  parameter .Buildings.Controls.OBC.CDL.Types.SimpleController controllerTypeHea=
    .Buildings.Controls.OBC.CDL.Types.SimpleController.PI
    "Type of controller"
    annotation(Dialog(group="Heating coil control"));
  parameter Real kHea(
    final unit="1/K")=4
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
    final unit="1/K")=1
    "Gain for cooling coil control signal"
    annotation(Dialog(group="Cooling coil control"));
  parameter Real TiCoo(
    final unit="s")=120
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
  parameter Real kFan(final unit="1/K")=4
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
  parameter Real kEco(final unit="1/K")=4
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
  .Buildings.Controls.OBC.CDL.Logical.Switch swi
    "Switch the outdoor air fraction to 0 when in unoccupied mode"
    annotation (Placement(transformation(extent={{0.0,20.0},{20.0,40.0}},rotation = 0.0,origin = {0.0,0.0})));
  .Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uOcc
    "Current occupancy period, true if it is in occupant period"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}}),
        iconTransformation(extent={{-140,-20},{-100,20}})));
  .Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con(k=0)
    "Zero outside air fraction"
    annotation (Placement(transformation(extent={{-28.116845178363413,-29.46861408630601},{-8.116845178363413,-9.468614086306012}},rotation = 0.0,origin = {0.0,0.0})));
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
    annotation (Placement(transformation(extent={{2.4642648480997984,-49.71100291944523},{22.4642648480998,-29.711002919445228}},rotation = 0.0,origin = {0.0,0.0})));
            .Buildings.Air.Systems.SingleZone.VAV.BaseClasses.ControllerEconomizer conEco2 annotation(Placement(transformation(extent = {{48.923550109570115,58.915481981581124},{68.92355010957012,78.91548198158112}},origin = {0.0,0.0},rotation = 0.0)));
    .Extra.PackageTerminalHeatPump.FinalizedModel.ControllerHeatingFan ConHeaFan annotation(Placement(transformation(extent = {{-64.79303542093388,81.23369035672675},{-44.793035420933876,101.23369035672675}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Controls.OBC.CDL.Interfaces.RealOutput TSetSupHP(final unit = "K",displayUnit = "degC") "Set point for heat pump leaving air temperature" annotation(Placement(transformation(extent = {{101.0627718273879,-96.81168451783634},{121.0627718273879,-76.81168451783634}},rotation = 0.0,origin = {0.0,0.0}),iconTransformation(extent = {{100,-100},{140,-60}})));
    .Buildings.Controls.OBC.CDL.Interfaces.IntegerOutput HPInpSig annotation(Placement(transformation(extent = {{101.64169359466459,-35.752861030510346},{121.80499434380357,-15.58956028137136}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Sources.Constant TSetSupAirConst(k = TSetSupAir) "Set point for supply air temperature" annotation(Placement(transformation(extent = {{-64.2597857859639,-30.05842258918169},{-44.2597857859639,-10.058422589181689}},rotation = 0.0,origin = {0.0,0.0})));
    .Buildings.Controls.OBC.CDL.Continuous.Greater heaOnTRoo(h = 1) annotation(Placement(transformation(extent = {{2.1615897045029655,-76.05654009668056},{22.161589704502966,-56.056540096680564}},origin = {0.0,0.0},rotation = 0.0)));
    .Extra.PackageTerminalHeatPump.FinalizedModel.ConHP conHP annotation(Placement(transformation(extent = {{59.01988246975503,-84.55871471578368},{79.01988246975503,-64.55871471578368}},origin = {0.0,0.0},rotation = 0.0)));
    .Extra.PackageTerminalHeatPump.FinalizedModel.ConCoolingSetting conCoolingSetting annotation(Placement(transformation(extent = {{-57.353632629218616,-103.68860760876565},{-37.353632629218616,-83.68860760876565}},origin = {0.0,0.0},rotation = 0.0)));

protected
  .Modelica.Blocks.Sources.Constant conMinOAFra(
    final k=minOAFra,y(fixed = false))
    "Minimum outside air fraction"
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));

equation
  connect(conMinOAFra.y, swi.u1) annotation (Line(points={{-39,50},{-30,50},{-30,38},{-2,38}}, color={0,0,127}));
  connect(uOcc, swi.u2) annotation (Line(points={{-120,0},{-14,0},{-14,30},{-2,30}},
          color={255,0,255}));
  connect(con.y, swi.u3) annotation (Line(points={{-6.116845178363413,-19.46861408630601},{-6.116845178363413,22},{-2,22}}, color={0,0,127}));
  connect(con.y, swiFan.u3) annotation (Line(points={{-6.116845178363413,-19.46861408630601},{-6.116845178363413,122},{68,122}}, color={0,0,127}));
  connect(swiFan.y, yFan) annotation (Line(points={{92,130},{96,130},{96,90},{
          110,90}}, color={0,0,127}));
  connect(swiFan.u2, orFan.y)   annotation (Line(points={{68,130},{64,130},{64,104},{62,104}},
          color={255,0,255}));
  connect(hysHea.y, orFan.u[1]) annotation (Line(points={{-8,130},{24,130},{24,
          108.667},{38,108.667}},
                        color={255,0,255}));
  connect(uOcc, orFan.u[2]) annotation (Line(points={{-120,0},{-14,0},{-14,104},
          {38,104}},    color={255,0,255}));
  connect(TRoo, chiOnTRoo.u1) annotation (Line(points={{-120,-80},{-79.84524505063335,-80},{-79.84524505063335,-39.71100291944523},{0.4642648480997984,-39.71100291944523}}, color={0,0,127}));
  connect(TSetRooCoo, chiOnTRoo.u2) annotation (Line(points={{-120,60},{-79.46861408630605,60},{-79.46861408630605,-47.71100291944523},{0.4642648480997984,-47.71100291944523}}, color={0,0,127}));

  connect(chiOnTRoo.y, orFan.u[3]) annotation (Line(points={{24.4642648480998,-39.71100291944523},{34.05842258918169,-39.71100291944523},{34.05842258918169,99.3333},{38,99.3333}}, color={255,0,255}));
            connect(conEco2.yOutAirFra,yOutAirFra) annotation(Line(points = {{69.92355010957012,68.91548198158112},{90.493160968479,68.91548198158112},{90.493160968479,20},{110,20}},color = {0,0,127}));
            connect(TMix,conEco2.TMix) annotation(Line(points = {{-120,30},{-30.192979894581562,30},{-30.192979894581562,73.91548198158112},{47.923550109570115,73.91548198158112}},color = {0,0,127}));
            connect(TRoo,conEco2.TRet) annotation(Line(points = {{-120,-80},{-79.61467055926028,-80},{-79.61467055926028,-48.1168451783634},{-30.192979894581523,-48.1168451783634},{-30.192979894581523,70.91548198158112},{47.923550109570115,70.91548198158112}},color = {0,0,127}));
            connect(swi.y,conEco2.minOAFra) annotation(Line(points = {{22,30},{29.115205637471817,30},{29.115205637471817,66.91548198158112},{47.923550109570115,66.91548198158112}},color = {0,0,127}));
            connect(TOut,conEco2.TOut) annotation(Line(points = {{-120,-40},{-30.192979894581526,-40},{-30.192979894581526,63.915481981581124},{47.923550109570115,63.915481981581124}},color = {0,0,127}));
            connect(chiOnTRoo.y,conEco2.cooSta) annotation(Line(points = {{24.4642648480998,-39.71100291944523},{33.802670867212186,-39.71100291944523},{33.802670867212186,60.915481981581124},{47.923550109570115,60.915481981581124}},color = {255,0,255}));
    connect(TSetSupAirConst.y,conEco2.TMixSet) annotation(Line(points = {{-43.2597857859639,-20.05842258918169},{-33.53666701253812,-20.05842258918169},{-33.53666701253812,76.91548198158112},{47.923550109570115,76.91548198158112}},color = {0,0,127}));
    connect(TSetRooHea,ConHeaFan.TSetRooHea) annotation(Line(points = {{-120,120},{-79.08048395442438,120},{-79.08048395442438,97.23369035672675},{-65.79303542093388,97.23369035672675}},color = {0,0,127}));
    connect(TSetRooCoo,ConHeaFan.TSetRooCoo) annotation(Line(points = {{-120,60},{-79.61186986811833,60},{-79.61186986811833,91.23369035672675},{-65.79303542093388,91.23369035672675}},color = {0,0,127}));
    connect(TRoo,ConHeaFan.TRoo) annotation(Line(points = {{-120,-80},{-79.61186986811833,-80},{-79.61186986811833,85.23369035672675},{-65.79303542093388,85.23369035672675}},color = {0,0,127}));
    connect(ConHeaFan.yFan,swiFan.u1) annotation(Line(points = {{-43.793035420933876,95.23369035672675},{5.780609501969522,95.23369035672675},{5.780609501969522,138},{68,138}},color = {0,0,127}));
    connect(ConHeaFan.HysInp,hysHea.u) annotation(Line(points = {{-43.78769038038324,87.32107392430382},{-37.78769038038324,87.32107392430382},{-37.78769038038324,130},{-32,130}},color = {0,0,127}));
    connect(TRoo,heaOnTRoo.u2) annotation(Line(points = {{-120,-80},{-20.03107501586676,-80},{-20.03107501586676,-74.05654009668056},{0.1615897045029655,-74.05654009668056}},color = {0,0,127}));
    connect(TSetRooHea,heaOnTRoo.u1) annotation(Line(points = {{-120,120},{-85.69142196190471,120},{-85.69142196190471,-66.05654009668056},{0.1615897045029655,-66.05654009668056}},color = {0,0,127}));
    connect(ConHeaFan.THeaSupSet,conHP.THeaSup) annotation(Line(points = {{-43.83405468444709,90.43319291075765},{50.97482521316863,90.43319291075765},{50.97482521316863,-67.74267959413177},{57.04225752389575,-67.74267959413177}},color = {0,0,127}));
    connect(chiOnTRoo.y,conHP.ConHeaCoo) annotation(Line(points = {{24.4642648480998,-39.71100291944523},{44.738655538702375,-39.71100291944523},{44.738655538702375,-71.9676637359931},{57.04225752389575,-71.9676637359931}},color = {255,0,255}));
    connect(heaOnTRoo.y,conHP.ConHeaSup) annotation(Line(points = {{24.161589704502966,-66.05654009668056},{38.23119663433317,-66.05654009668056},{38.23119663433317,-75.65939745218262},{57.08327678740896,-75.65939745218262}},color = {255,0,255}));
    connect(conEco2.yCoiSta,conHP.ConHP) annotation(Line(points = {{69.92355010957012,60.915481981581124},{83.7395838656127,60.915481981581124},{83.7395838656127,8.3082765258807},{40.919512116496875,8.3082765258807},{40.919512116496875,-79.76132380350428},{57.08327678740896,-79.76132380350428}},color = {255,0,255}));
    connect(conHP.yTSupHP,TSetSupHP) annotation(Line(points = {{81.03852667912753,-77.46424504676413},{96.05064925325772,-77.46424504676413},{96.05064925325772,-86.81168451783634},{111.0627718273879,-86.81168451783634}},color = {0,0,127}));
    connect(conHP.HPStatus,HPInpSig) annotation(Line(points = {{81.07954594264075,-70.7370858305966},{96.40144495593742,-70.7370858305966},{96.40144495593742,-25.671210655940854},{111.72334396923408,-25.671210655940854}},color = {255,127,0}));
    connect(TSetRooCoo,conCoolingSetting.TSetRooCoo) annotation(Line(points = {{-120,60},{-72.12989363563881,60},{-72.12989363563881,-87.69295775737808},{-59.3312575750779,-87.69295775737808}},color = {0,0,127}));
    connect(TRoo,conCoolingSetting.TRoo) annotation(Line(points = {{-120,-80},{-72.1093840038822,-80},{-72.1093840038822,-100.20383312890918},{-59.29023831156469,-100.20383312890918}},color = {0,0,127}));
    connect(conCoolingSetting.TCooSupSet,conHP.TCooSup) annotation(Line(points = {{-35.45804621038577,-93.5997317032813},{57.08327678740897,-93.5997317032813},{57.08327678740897,-83.494076783207}},color = {0,0,127}));
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
end ControllerChiller;
