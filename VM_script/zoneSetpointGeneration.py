import csv

setpoint = []
for minute in range(1, 525600 + 1):
# for minute in range(1, 180 + 1):
    hour = int((minute % (60 * 24)) / 60)
    if hour < 4:
        reqd_setpoint = [15.6]
    elif hour >= 4 and hour < 5:
        reqd_setpoint = [17.8]
    elif hour >= 5 and hour < 6:
        reqd_setpoint = [20]
    elif hour >= 6 and hour < 22:
        reqd_setpoint = [21]
    elif hour >= 22 and hour < 24:
        reqd_setpoint = [15.6]
    
    setpoint.append(reqd_setpoint)

# print(setpoint)
csv_file = open('./setpoint_file.csv', 'w', newline = '')
csv_writer = csv.writer(csv_file)
csv_writer.writerows(setpoint)
csv_file.close()
