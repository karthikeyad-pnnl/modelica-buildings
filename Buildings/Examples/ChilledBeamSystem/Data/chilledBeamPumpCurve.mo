within Buildings.Examples.ChilledBeamSystem.Data;
record chilledBeamPumpCurve "Pump data for chilled beam model"
  extends Fluid.Movers.Data.Generic(
    speed_rpm_nominal=2900,
    use_powerCharacteristic=true,
    power(V_flow={0,0.001514,0.003028}, P={0,200,400}),
    pressure(V_flow={0,0.001514,0.003028}, dp={60000,30000,0}),
    motorCooledByFluid=true);
  annotation (
defaultComponentPrefixes="parameter",
defaultComponentName="per",
Documentation(info="<html>
<p>Data from:<a href=\"http://productfinder.wilo.com/com/en/c0000002200012eb000020023/_0000001d000149e80001003a/product.html\"> http://productfinder.wilo.com/com/en/c0000002200012eb000020023/_0000001d000149e80001003a/product.html</a></p>
<p>See <a href=\"modelica://Buildings.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to6\">Buildings.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to6 </a>for more information about how the data is derived. </p>
</html>",   revisions="<html>
<ul>
<li>
June 01, 2017, by Iago Cupeiro:
<br/>
Changed data link to the English version
</li>
<li>
February 17, 2016, by Michael Wetter:<br/>
Updated parameter names for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/396\">#396</a>.
</li>
<li>
December 12, 2014, by Michael Wetter:<br/>
Added <code>defaultComponentPrefixes</code> and
<code>defaultComponentName</code> annotations.
</li>
<li>April 22, 2014
    by Filip Jorissen:<br/>
       Initial version
</li>
</ul>
</html>"));
end chilledBeamPumpCurve;
