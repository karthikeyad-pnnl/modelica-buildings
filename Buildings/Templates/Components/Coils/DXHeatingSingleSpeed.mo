within Buildings.Templates.Components.Coils;
model DXHeatingSingleSpeed "Single speed DX heating coil"
  extends Buildings.Templates.Components.Interfaces.PartialCoil(
    redeclare Buildings.Templates.Components.Data.HeatingCoil dat,
    final typ=Buildings.Templates.Components.Types.Coil.DXHeatingSingleSpeed,
    final typVal=Buildings.Templates.Components.Types.Valve.None);

  parameter Boolean have_dryCon = true
    "Set to true for air-cooled condenser, false for evaporative condenser";

  final parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal=
    dat.Q_flow_nominal
    "Nominal heat flow rate";

  Buildings.Fluid.DXSystems.Heating.AirSource.SingleSpeed hex(
    redeclare final package Medium = MediumAir,
    final datCoi=dat.datCoi,
    final dp_nominal=dpAir_nominal,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
    "Heat exchanger"
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));

  Modelica.Blocks.Routing.RealPassThrough TDry if have_dryCon
    annotation (Placement(transformation(extent={{-50,14},{-30,34}})));
  Modelica.Blocks.Routing.RealPassThrough phi if have_dryCon
    annotation (Placement(transformation(extent={{-50,-30},{-30,-10}})));

initial equation
  assert(mAir_flow_nominal<=dat.datCoi.sta[dat.datCoi.nSta].nomVal.m_flow_nominal,
    "In "+ getInstanceName() + ": "+
    "The coil design airflow ("+String(mAir_flow_nominal)+
    ") exceeds the maximum airflow provided in the performance data record ("+
    String(dat.datCoi.sta[dat.datCoi.nSta].nomVal.m_flow_nominal)+").",
    level=AssertionLevel.warning);
  assert(abs(Q_flow_nominal)<=abs(dat.datCoi.sta[dat.datCoi.nSta].nomVal.Q_flow_nominal),
    "In "+ getInstanceName() + ": "+
    "The coil design capacity ("+String(Q_flow_nominal)+
    ") exceeds the maximum capacity provided in the performance data record ("+
    String(dat.datCoi.sta[dat.datCoi.nSta].nomVal.Q_flow_nominal)+").",
    level=AssertionLevel.warning);

equation
  connect(port_a, hex.port_a)
    annotation (Line(points={{-100,0},{20,0}},  color={0,127,255}));
  connect(hex.port_b, port_b)
    annotation (Line(points={{40,0},{100,0}}, color={0,127,255}));
  connect(busWea.TDryBul, TDry.u) annotation (Line(
      points={{-60,100},{-60,24},{-52,24}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(TDry.y, hex.TOut) annotation (Line(points={{-29,24},{-20,24},{-20,-4},
          {19,-4}}, color={0,0,127}));
  connect(bus.y1, hex.on) annotation (Line(
      points={{0,100},{0,8},{19,8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(busWea.relHum, phi.u) annotation (Line(
      points={{-60,100},{-60,-20},{-52,-20}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(phi.y, hex.phi) annotation (Line(points={{-29,-20},{-20,-20},{-20,-8},
          {19,-8}}, color={0,0,127}));
  annotation (
    Diagram(
        coordinateSystem(preserveAspectRatio=false)), Documentation(info="<html>
<p>
This is a model for a direct expansion cooling coil with a
multi-stage compressor.
The compressor stage is selected with the control
signal <code>y</code> (integer between <code>0</code> and the number
of stages).
</p>
</html>"));
end DXHeatingSingleSpeed;
