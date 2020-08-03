/*
 * Modelica external function to communicate with EnergyPlus.
 *
 * Michael Wetter, LBNL                  2/9/2019
 */
#ifndef Buildings_EnergyPlusUtil_h
#define Buildings_EnergyPlusUtil_h

#include "EnergyPlusTypes.h"
#include "BuildingInstantiate.h"

#include <stdio.h>
#ifdef _MSC_VER
#include <windows.h>
#define R_OK 4
#define W_OK 2
#define X_OK 1
#define F_OK 0
#else
#include <unistd.h>
#include <execinfo.h>
#endif

#ifdef __linux__
#include <execinfo.h>
#endif

#include <sys/types.h> /* To create directory */
#include <sys/stat.h>  /* To create directory */
/* #include <unistd.h> */   /* To use stat to check for directory */
#include <errno.h>

#include "fmilib.h"
#include "FMI2/fmi2FunctionTypes.h"

#define SPAWN_LOGGER_BUFFER_LENGTH 1000

void writeFormatLog(const char *fmt, ...);

void writeLog(const char* msg);

void mallocSpawnReals(const size_t n, spawnReals** r);

void mallocString(size_t nChar, const char *error_message, char** str);

void setVariables(FMUBuilding* bui, const char* modelicaInstanceName, const spawnReals* ptrReals);

void getVariables(FMUBuilding* bui, const char* modelicaInstanceName, spawnReals* ptrReals);

double do_event_iteration(FMUBuilding* bui, const char* modelicaInstanceName);

void saveAppend(char* *buffer, const char *toAdd, size_t *bufLen);

void saveAppendJSONElements(char* *buffer, const char* values[], size_t n, size_t* bufLen);

void checkAndSetVerbosity(const int verbosity);

void setFMUMode(FMUBuilding* bui, FMUMode mode);

void getSimulationFMUName(const char* modelicaNameBuilding, const char* tmpDir, char** fmuAbsPat);

char* getFileNameWithoutExtension(const char* idfName);

void getSimulationTemporaryDirectory(const char* modelicaNameBuilding, char** dirNam);

void buildVariableName(
  const char* modelicaInstanceName,
  const char* firstPart,
  const char* secondPart,
  char* *ptrFullName);

void buildVariableNames(
  const char* firstPart,
  const char** secondParts,
  const size_t nVar,
  char** *ptrVarNames,
  char** *ptrFullNames);
void getSimulationTemporaryDirectory(const char* idfName, char** dirNam);

void loadFMU_setupExperiment_enterInitializationMode(FMUBuilding* bui, double startTime);

void advanceTime_completeIntegratorStep_enterEventMode(FMUBuilding* bui, const char* modelicaInstanceName, double time);

#endif