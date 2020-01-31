''' Python module that is used for the example
    Buildings.Fluid.Geothermal.Borefields.BaseClasses.GroundResponse.Validation.ResponsePython
'''
import os
import shutil

def doStep(dblInp, state):
    modelicaWorkingPath = os.getcwd()
    py_dir = os.path.join(modelicaWorkingPath,'Resources/Python-Sources')

    # Temporary folder used primarily for store TOUGH simulation result "SAVE".
    # The "SAVE" file is needed for the next invocation for generating initial
    # conditions for TOUGH simulation.
    # This temporary folder should be created in advance before calling this 
    # python script.
    tou_tmp = os.path.join(py_dir, 'toughTemp')
    
    # Heat flux between borehole wall and ground
    Q = dblInp[:10]
    # Initial borehole wall temperature at the start of modelica simulation
    T_start = [dblInp[i] for i in range(10,20)]
    # Current time when needs to call TOUGH. This is also the end time of TOUGH simulation.
    tim = dblInp[-1]

    # This is the first call of this python module. There is no state yet.
    if state == None:
        # Empty the TOUGH temporary folder
        empty_folder(tou_tmp)
        # Copy files in the folder 'TougFiles', which includes the initial temperature of
        # simulation domain, template files for TOUGH simulation, and utility programs
        copy_files(os.path.join(py_dir, 'ToughFiles'), tou_tmp)
        # Initialize the state
        state = {'tLast': tim, 'Q': Q, 'T': T_start}
        T = T_start

    else:
        # Use the python object
        tLast = state['tLast']
        # Find the TOUGH simulation step size
        dt = tim - tLast

        # JModelica invokes the model twice during an event, in which case
        # dt is zero, or close to zero.
        # We don't evaluate the equations as this can cause chattering and in some
        # cases JModelica does not converge during the event iteration.
        # This guard is fine because the component is sampled at discrete time steps.
        if dt > 1E-2:
            # Create a temporary working directory
            wor_dir = create_working_directory()
            # Copy files generated by previous call to working directory
            copy_files(tou_tmp, wor_dir)

            # Change current directory to working directory
            os.chdir(wor_dir)

            # Check if there is 'GENER'. If the file does not exist, it means this is 
            # the first call of TOUGH simulation. There is no 'SAVE' yet so cannot call
            # `writeincon` to generate input files for TOUGH simulation.
            if not os.path.exists('GENER'):
                # create initial 'GENER' file
                initialize_gener(state['Q'], 'GENER')
                # update existing 'INFILE'
                update_infile(tLast, tim, 'INFILE', 'newINFILE')

            # It's not the first call of TOUGH simulation. So there is 'SAVE' file from
            # previous TOUGH call and we can use `writeincon` to generate TOUGH input
            # files.
            else:
                # Delete old TOUGH input files
                if os.path.exists('GENER'):
                    os.remove('GENER')
                if os.path.exists('INCON'):
                    os.remove('INCON')
                if os.path.exists('newINFILE'):
                    os.remove('newINFILE')

                # Update `writeincon.inp` file. The `Q` is the measured heat flow from
                # each borehole segment to ground, from Modeica in previous call.
                # The `T` is the wall temperature of each borehole segment from
                # last TOUGH simulation
                update_writeincon('writeincon.inp', tLast, tim, state['T'], state['Q'])

                # Generate TOUGH input files
                os.system("./writeincon < writeincon.inp")
                if os.path.exists('INFILE'):
                    os.remove('INFILE')
                os.rename('newINFILE', 'INFILE')
            
            # Conduct one step TOUGH simulation
            os.system("/opt/esd-tough/tough3-serial/tough3-install/bin/tough3-eos1")

            # Extract borehole wall temperature
            os.system("./readsave < readsave.inp > out.txt")
            T = borehole_temperature('out.txt')

            # Update state
            state = {'tLast': tim, 'Q': Q, 'T': T}

            # Empty the 'toughTemp' folder
            empty_folder(tou_tmp)
            
            # Save files from temp directory to temp tough folder
            copy_files(wor_dir, tou_tmp)

            # Change back to original working directory
            os.chdir(modelicaWorkingPath)

            # Delete temporary working folder
            shutil.rmtree(wor_dir)

    return [T, state]


''' Empty a folder
'''
def empty_folder(folder):
    # empty the 'toughTemp' folder
    touTmpFil = os.listdir(folder)
    for f in touTmpFil:
        os.remove(os.path.join(folder, f))

''' Create working directory
'''
def create_working_directory():
    import tempfile
    import getpass
    worDir = tempfile.mkdtemp(prefix='tmp-tough-modelica-' + getpass.getuser())
    return worDir

''' Copy files from source directory to destination directory
'''
def copy_files(src, dest):
    srcFiles = os.listdir(src)
    for fil in srcFiles:
        fileName = os.path.join(src, fil)
        if os.path.isfile(fileName):
            shutil.copy(fileName, dest)

''' Create initial `GENER` file for the 1st call of TOUGH
'''
def initialize_gener(Q, fileName):
    with open(fileName, 'w') as f:
        f.write("GENER" + os.linesep)
        f.write("  7 1sou 1                         HEAT  %10.3e" % Q[0] + os.linesep)
        f.write("  8 1sou 2                         HEAT  %10.3e" % Q[1] + os.linesep)
        f.write("  9 1sou 3                         HEAT  %10.3e" % Q[2] + os.linesep)
        f.write(" 10 1sou 4                         HEAT  %10.3e" % Q[3] + os.linesep)
        f.write(" 11 1sou 5                         HEAT  %10.3e" % Q[4] + os.linesep)
        f.write(" 12 1sou 6                         HEAT  %10.3e" % Q[5] + os.linesep)
        f.write(" 13 1sou 7                         HEAT  %10.3e" % Q[6] + os.linesep)
        f.write(" 14 1sou 8                         HEAT  %10.3e" % Q[7] + os.linesep)
        f.write(" 15 1sou 9                         HEAT  %10.3e" % Q[8] + os.linesep)
        f.write(" 16 1sou 10                        HEAT  %10.3e" % Q[9] + os.linesep)
        f.write("+++" + os.linesep)
        f.write("         1         2         3         4         5         6         7         8" + os.linesep)
        f.write("         9        10")

''' Update the `INFILE` file for the first TOUGH call
'''
def update_infile(preTim, curTim, infile, outfile):
    fin = open(infile)
    fout = open(outfile, 'wt')
    count = 0
    for line in fin:
        count += 1
        if count == 18:
            endStr=line[20:]
            staStr='%10.1f%10.1f' % (preTim, curTim)
            fout.write(staStr + endStr)
        else:
            fout.write(line)
    fin.close()
    fout.close()
    os.remove(infile)
    os.rename(outfile, infile)

''' Update the `writeincon.inp` file with the current time and state values that are
    seem as initial values of current TOUGH simulation
'''
def update_writeincon(infile, preTim, curTim, boreholeTem, heatFlux):
    fin = open(infile)
    fout = open('temp', 'wt')
    count = 0
    for line in fin:
        count += 1
        # assign initial time
        if count == 6:
            tempStr = '% 10.1f' % preTim
            fout.write(tempStr.strip() + os.linesep)
        # assign final time
        elif count ==  8:
            tempStr = '% 10.1f' % curTim
            fout.write(tempStr.strip() + os.linesep)
        # assign borehole wall temperature to each segment
        elif (count >= 10 and count <= 19):
            tempStr = '% 10.3f' % (boreholeTem[count-10] - 273.15)
            fout.write(tempStr.strip() + os.linesep)
        # assign heat flux to each segment
        elif (count >= 21 and count <= 30):
            tempStr = '% 10.3f' % heatFlux[count-21]
            fout.write(tempStr.strip() + os.linesep)
        else:
            fout.write(line)
    fin.close()
    fout.close()
    os.remove(infile)
    os.rename('temp', infile)

''' Extract the borehole temperature from TOUGH simulation results
'''
def borehole_temperature(outFile):
    data = []
    fin = open(outFile)
    count = 0
    for line in fin:
        count += 1
        if count <= 10:
            data.append(float(line.strip())+273.15)
    return data
