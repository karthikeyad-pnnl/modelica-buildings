within Buildings.Fluid.ZoneEquipment.UnitHeater.Examples;
model SingleZone
  "Example model for a system with single-zone serviced by unit heater with constant fan, variable heating control"

  extends Modelica.Icons.Example;

  extends Buildings.Fluid.ZoneEquipment.BaseClasses.ExampleTestbed(
    redeclare Buildings.Fluid.ZoneEquipment.UnitHeater.Controls.ConstantFanVariableHeating
      conZonHVACSys(
      final controllerTypeHea=Buildings.Controls.OBC.CDL.Types.SimpleController.P,
      final kHea=0.5,
      final minFanSpe=0.15,
      final tFanEnaDel=60,
      final tFanEna=600,
      final dTHys=0.5),
    redeclare Buildings.Fluid.ZoneEquipment.UnitHeater.UnitHeater zonHVACSys(
      final heaCoiTyp=Buildings.Fluid.ZoneEquipment.BaseClasses.Types.HeaSou.ele,
      final dpAir_nominal(displayUnit="Pa") = 100,
      final mAirOut_flow_nominal=FCUSizing.mAirOut_flow_nominal,
      redeclare package MediumA = MediumA,
      redeclare package MediumCHW = MediumW,
      redeclare package MediumHW = MediumW,
      final mAir_flow_nominal=FCUSizing.mAir_flow_nominal,
      final QHeaCoi_flow_nominal=13866,
      final mHotWat_flow_nominal=FCUSizing.mHotWat_flow_nominal,
      final UAHeaCoi_nominal=FCUSizing.UAHeaCoi_nominal,
      final mChiWat_flow_nominal=FCUSizing.mChiWat_flow_nominal,
      final UACooCoi_nominal=FCUSizing.UACooCoiTot_nominal,
      redeclare Buildings.Fluid.ZoneEquipment.UnitHeater.Examples.Data.FanData
        fanPer),
    building(
      final idfName=Modelica.Utilities.Files.loadResource(
          "./Buildings/Resources/Data/Fluid/ZoneEquipment/UnitHeater/UnitHeaterAuto.idf"),
      final epwName=Modelica.Utilities.Files.loadResource("./Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.epw"),
      final weaName=Modelica.Utilities.Files.loadResource("./Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos")),
    zon(final zoneName="West Zone", final nPorts=2));

  replaceable package MediumA = Buildings.Media.Air
    constrainedby Modelica.Media.Interfaces.PartialCondensingGases
    "Medium model for air";

  replaceable package MediumW = Buildings.Media.Water
    "Medium model for water";

  Buildings.Fluid.ZoneEquipment.UnitHeater.Examples.Data.SizingData FCUSizing
    "Sizing parameters for fan coil unit"
    annotation (Placement(transformation(extent={{-140,-120},{-120,-100}})));

equation

  connect(conZonHVACSys.yHea, zonHVACSys.uHea) annotation (Line(points={{-16,10},
          {60,10},{60,-17.8},{68,-17.8}}, color={0,0,127}));
  connect(con.y, zonHVACSys.uEco) annotation (Line(points={{-28,50},{60,50},{60,
          18},{68,18}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false,
      extent={{-100,-100},{100,100}})),
    Diagram(coordinateSystem(preserveAspectRatio=false,
      extent={{-160,-160},{160,160}})),
    experiment(
      StopTime=86400,
      Interval=60,
      Tolerance=1e-06),
    __Dymola_Commands(file= "modelica://Buildings/Resources/Scripts/Dymola/Fluid/ZoneEquipment/UnitHeater/Example/SingleZone.mos"
      "Simulate and plot"),
    Documentation(info="<html>
      <p>
      This is an example model for the fan coil unit system model 
      demonstrating use-case with a variable fan, constant pump flowrate controller. 
      It consists of:
      <ul>
      <li>
      an instance of the fan coil unit system model <code>fanCoiUni</code>.
      </li>
      <li>
      thermal zone model <code>zon</code> of class <a href=\"modelica://Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone\">
      Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone</a>.
      </li>
      <li>
      ideal media sources <code>souCoo</code> and <code>souHea</code> for simulating 
      the supply of chilled water and heating hot-water respectively.
      </li>
      <li>
      fan coil unit controller <code>conVarFanConWat</code> of class <a href=\"modelica://Buildings.Fluid.ZoneEquipment.FanCoilUnit.Controls.VariableFanConstantWaterFlowrate\">
      Buildings.Fluid.ZoneEquipment.FanCoilUnit.Controls.VariableFanConstantWaterFlowrate</a>.
      </li>
      <li>
      occupancy schedule controller <code>occSch</code>.
      </li>
      <li>
      zone temperature setpoint controller <code>TZonSet</code>.
      </li>
      </ul>
      </p>
      <p>
      The simulation model provides a closed-loop example of <code>fanCoiUni</code> that
      is operated by <code>conVarFanConWat</code> and regulates the zone temperature 
      in <code>zon</code> at the setpoint generated by <code>TZonSet</code>.
      <br>
      The plots shopw the zone temperature regulation, controller outputs and the 
      fan coil unit response.
      </p>
      </html>", revisions="<html>
      <ul>
      <li>
      August 03, 2022 by Karthik Devaprasad:<br/>
      First implementation.
      </li>
      </ul>
      </html>"));
end SingleZone;
