within Buildings.Fluid.CHPs.OrganicRankine.Data.WorkingFluids;
record R245fa "Data record for R245fa"
  extends Generic(
    T = {
         263.15       ,280.245555556,297.341111111,314.436666667,
         331.532222222,348.627777778,365.723333333,382.818888889,
         399.914444444,417.01       },
    p = {
           33074.455269577,  72887.366701788, 144193.124203996,
          261432.955364019, 441494.101343335, 703414.198474153,
         1068359.342462996,1560145.848431753,2206880.485192474,
         3045794.17123294 },
    rhoLiq = {
         1428.970464918,1385.766605559,1340.65562986 ,1293.01283556 ,
         1241.96829885 ,1186.239888383,1123.767592805,1050.81390283 ,
          959.216593671, 822.828460561},
    dTRef = 30,
    sSatLiq = {
          956.193112483,1035.364417516,1111.944630847,1186.435838862,
         1259.293596381,1330.986299328,1402.082979051,1473.433817707,
         1546.692369155,1626.938235226},
    sSatVap = {
         1753.339480749,1752.701557681,1756.61081491 ,1763.705762957,
         1772.828904987,1782.876329527,1792.610957024,1800.320573857,
         1802.878905152,1791.348871671},
    sRef = {
         1843.301914471,1841.682942619,1845.068883248,1852.125571196,
         1861.778475563,1873.119878874,1885.336511854,1897.653409147,
         1909.296310246,1919.468376844},
    hSatLiq = {
         188217.135523087,209752.050428183,231916.973241534,
         254789.508127216,278461.658759156,303057.594061445,
         328767.54169158 ,355926.037457738,385245.530754186,
         418981.075267556},
    hSatVap = {
         397986.202332377,410782.595794416,423602.732706635,
         436304.338826503,448715.160811117,460599.011089822,
         471592.735555778,481064.462239284,487698.226971601,
         487541.954771701},
    hRef = {
         422999.193929367,437043.348637611,451220.086433009,
         465419.510903738,479522.71650364 ,493393.292575899,
         506866.898229809,519740.667011956,531767.47525367 ,
         542662.050436945});
  annotation (
  defaultComponentPrefixes = "parameter",
  defaultComponentName = "pro",
  Documentation(info="<html>
<p>
Record containing properties of R245fa.
Its name in CoolProp is \"R245fa\".
A figure in the documentation of
<a href=\"Modelica://Buildings.Fluid.CHPs.OrganicRankine.Cycle\">
Buildings.Fluid.CHPs.OrganicRankine.Cycle</a>
shows which lines these arrays represent.
</p>
</html>"));
end R245fa;