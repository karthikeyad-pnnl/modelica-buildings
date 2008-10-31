model Buoyancy "Model to reduce the numerical dissipation in a tank" 
  extends Buildings.BaseClasses.BaseIcon;
  replaceable package Medium = 
    Modelica.Media.Interfaces.PartialMedium "Medium model"  annotation (
      choicesAllMatching = true);
  annotation (Documentation(info="<html>
<p>
This model outputs a heat flow rate that can be added to fluid volumes
in order to emulate buoyancy during a temperature inversion.
For simplicity, this model does not compute a buoyancy induced mass flow rate,
but rather a heat flow that has the same magnitude as the enthalpy flow
associated with the buoyancy induced mass flow rate.
</p>
</html>", revisions="<html>
<ul>
<li>
October 28, 2008 by Michael Wetter:<br>
First implementation.
</li>
</ul>
</html>"),
Icon(Rectangle(extent=[-100,100; 100,-100], style(
          color=0,
          rgbcolor={0,0,0},
          fillColor=7,
          rgbfillColor={255,255,255})),
      Rectangle(extent=[-44,68; 36,28],  style(
          pattern=0,
          fillColor=74,
          rgbfillColor={0,0,127})),
      Rectangle(extent=[-42,-26; 38,-66],
                                        style(
          color=1,
          rgbcolor={255,0,0},
          fillColor=1,
          rgbfillColor={255,0,0})),
      Rectangle(extent=[26,10; 32,-22], style(
          pattern=0,
          fillColor=1,
          rgbfillColor={255,0,0})),
      Polygon(points=[28,22; 22,10; 36,10; 36,10; 28,22], style(
          pattern=0,
          fillColor=1,
          rgbfillColor={255,0,0},
          fillPattern=1)),
      Rectangle(extent=[-32,22; -26,-10], style(
          pattern=0,
          fillColor=74,
          rgbfillColor={0,0,127})),
      Polygon(points=[-28,-18; -36,-6; -22,-6; -22,-6; -28,-18], style(
          pattern=0,
          fillColor=74,
          rgbfillColor={0,0,127},
          fillPattern=1))),
    Diagram);
  parameter Modelica.SIunits.Volume V "Volume";
  parameter Integer nSeg(min=2) = 2 "Number of volume segments";
  parameter Modelica.SIunits.Time tau(min=0) "Time constant for mixing";
  
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a[nSeg] heatPort 
    "Heat input into the volumes" 
    annotation (extent=[90,-10; 110,10]);
  
  Modelica.SIunits.HeatFlowRate[nSeg-1] Q_flow 
    "Heat flow rate from segment i+1 to i";
protected 
   parameter Medium.ThermodynamicState sta0 = Medium.setState_pTX(T=Medium.T_default,
         p=Medium.p_default, X=Medium.X_default[1:Medium.nXi]);
   parameter Modelica.SIunits.Density rho0=Medium.density(sta0) 
    "Density, used to compute fluid mass";
   parameter Modelica.SIunits.SpecificHeatCapacity cp0=Medium.specificHeatCapacityCp(sta0) 
    "Specific heat capacity";
   parameter Real k(unit="W/K") = V*rho0*cp0/tau/nSeg 
    "Proportionality constant, since we use dT instead of dH";
equation 
  for i in 1:nSeg-1 loop
    Q_flow[i] = k*max(heatPort[i+1].T-heatPort[i].T, 0);
  end for;
  
  heatPort[1].Q_flow = -Q_flow[1];
  for i in 2:nSeg-1 loop
       heatPort[i].Q_flow = -Q_flow[i]+Q_flow[i-1];
  end for;
  heatPort[nSeg].Q_flow = Q_flow[nSeg-1];
end Buoyancy;
