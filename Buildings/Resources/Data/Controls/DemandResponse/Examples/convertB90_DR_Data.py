#!/usr/bin/env python
#######################################################
# Script that converts the output data B90_DR_Data.csv
# to a format that can be read by the Modelica
# data reader.
#
# MWetter@lbl.gov                            2014-05-21
#######################################################

def convertData():
    import csv
    import datetime
    with open('./B90_DR_Data.csv', 'rt', encoding="utf-8") as csvfile:
        rea = csv.reader(csvfile, delimiter=',')
        next(rea, None) # Skip header
        i = 1
        lines= list()
        for row in rea:
            try:
                lines.append("%.0f, %.3f, %.1f, %s, %.1f\n" % (i*900, (float(row[1]) + 273.15), (1000.*float(row[2])), row[3], (1000.*float(row[4]))))
                previousRow = row
            except ValueError:
                # Reached the last line, which has again a text
                # At t=0, we used the power of the last interval in the previous year
                l = "%.0f, %.3f, %.1f, %s, %.1f\n" % (0, (float(previousRow[1]) + 273.15), (1000.*float(previousRow[2])), previousRow[3], (1000.*float(previousRow[4])))
                lines.insert(0, l)
                pass
            i = i + 1

    filOut = open('B90_DR_Data.mos', 'w')
    filOut.write("""#1
# The rows in this file are as follows:
#1  - time in seconds
#2  - outdoor dry bulb temperature in Kelvin
#3  - electrical power consumed in Watts
#4  - demand response signal (0 no demand response, 1 demand response)
#5  - Power generated at next timestep
double b90(%s, 5)
""" % len(lines))
    filOut.writelines(lines)
    filOut.close()

if __name__ == "__main__":
    convertData()
