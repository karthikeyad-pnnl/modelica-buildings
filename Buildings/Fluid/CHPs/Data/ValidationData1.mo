within Buildings.Fluid.CHPs.Data;
record ValidationData1 "Validation data set 1"
  extends Buildings.Fluid.CHPs.Data.Generic(
    coeEtaQ={0.66,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    coeEtaE={0.27,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    coolingWaterControl=true,
    coeMasWat={0.4,0,0,0,0,0},
    coeMasAir={0,2,-10000},
    UAhx=741,
    UAlos=13.7,
    MCeng=63605.6,
    MCcw=1000.7,
    warmUpByTimeDelay=true,
    timeDelayStart=60,
    coolDownOptional=true,
    timeDelayCool=60,
    PEleMax=5500,
    PEleMin=0,
    mWatMin=0.1,
    TWatMax=273.15 + 80,
    dPEleLim=true,
    dmFueLim=true,
    dPEleMax=200,
    dmFueMax=2,
    PStaBy=100,
    PCooDow=200,
    LHVFue=47.614e6);
  annotation (
  defaultComponentPrefixes = "parameter",
  defaultComponentName = "per",
  Documentation(preferredView="info",
  info="<html>
<p>
This is the record of parameters for CHP models derived from the parameters of 
EnergyPlus example <code>MicroCogeneration</code>, with following changes:
</p>
<ul>
<li>
changed the condition of the warm-up mode, from depending on the delay time to
engine temperature.
</li>
<li>
changed the minimum cooling water flow rate <code>mWatMin</code> from 0 to 0.1 kg/s.
</li>
<li>
limited the maximum net electrical power rate of change <code>dPEleMax</code> and 
the maximum fuel flow rate of change <code>dmFueMax</code>, by reducing from 1e+9 to
200 and from 1e+9 to 2 respectively.
</li>
<li>
changed electric power consumptions during standby <code>PStaBy</code> and cool-down
<code>PCooDow</code> mode from 0 W to 100 W and 200 W respectively.
</li>
</ul>
</html>",revisions="<html>
<ul>
<li>
March 08, 2019, by Tea Zakula:<br/>
First implementation.
</li>
</ul>
</html>"));
end ValidationData1;