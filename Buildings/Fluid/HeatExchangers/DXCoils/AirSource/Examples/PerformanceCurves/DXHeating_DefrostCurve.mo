within Buildings.Fluid.HeatExchangers.DXCoils.AirSource.Examples.PerformanceCurves;
record DXHeating_DefrostCurve "Defrost curve DX heating coil"
  extends
    Buildings.Fluid.HeatExchangers.DXCoils.AirSource.Data.Generic.BaseClasses.Defrost(
    defEIRFunT={0.9135970355,0.0127860478,0.0000527533,-0.0005917719,0.000136017,
        -0.0000894155});

  annotation (defaultComponentName="per", Documentation(info="<html>
<p>
This record declares performance curves for the heating capacity and the EIR for use in
<a href=\"Buildings.Fluid.HeatExchangers.DXCoils.AirSource.Examples.SingleSpeedDXHeating\">
Buildings.Fluid.HeatExchangers.DXCoils.AirSource.Examples.SingleSpeedDXHeating</a>.
It has been obtained from the EnergyPlus 9.6 example file
<code>PackagedTerminalHeatPump.idf</code>.
</p>
</html>",
revisions="<html>
<ul>
<li>
March 08, 2023 by Xing Lu and Karthik Devaprasad:<br/>
First implementation.
</li>
</ul>
</html>"),
    Icon(graphics={
        Text(
          extent={{-95,53},{-12,-2}},
          textColor={0,0,255},
          textString="capFunT"),
        Text(
          extent={{7,55},{90,0}},
          textColor={0,0,255},
          textString="%capFunT"),
        Text(
          extent={{-105,-9},{-48,-48}},
          textColor={0,0,255},
          textString="capFunFF"),
        Text(
          extent={{2,-16},{94,-38}},
          textColor={0,0,255},
          textString="%capFunFF"),
        Text(
          extent={{-95,-49},{-12,-104}},
          textColor={0,0,255},
          textString="EIRFunT"),
        Text(
          extent={{7,-53},{84,-94}},
          textColor={0,0,255},
          textString="%EIRFunT")}));
end DXHeating_DefrostCurve;
