within Buildings.Templates.Plants.HeatPumps_PNNL.Components.Data;
record CoolingTowerWHE
  extends Modelica.Icons.Record;
  parameter Real CoolingCapacity_nominal;
  final parameter Real mAir_flow_nominal=CoolingCapacity_nominal/((40.14-21)*1000);
  final parameter Real mWatOxy_flow_nominal=CoolingCapacity_nominal/(4200*(50-21));
  final parameter Real mWatCon_flow_nominal=CoolingCapacity_nominal/(4200*(50-21));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CoolingTowerWHE;
