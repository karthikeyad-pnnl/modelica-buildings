#ifndef fmumodelica202309252128147594_H
#define fmumodelica202309252128147594_H
static double previous_time_fmumodelica202309252128147594 = -1;
static int n_real_param_value_refs_fmumodelica202309252128147594 = 2;
static const unsigned int real_param_value_refs_fmumodelica202309252128147594[2] = {0, 1};
static int n_real_variables_value_refs_fmumodelica202309252128147594 = 2;
static const unsigned int real_variables_value_refs_fmumodelica202309252128147594[2] = {48, 47};

#include "fmu_wrapper.h"
#include "ModelicaUtilities.h"

void *initialize_wrapper_fmumodelica202309252128147594(const char *instance_name,
                   const char *identifier,
                   const char *ext_lib_path,
                   const char *GUID)
{
    return initialize_wrapper(instance_name, identifier,
           ext_lib_path, GUID, &ModelicaError);
}
        
void fmi2_get_boolean_cparameters_fmumodelica202309252128147594(void *fmu_wr, int *output_values, int set_size) {
}

void fmi2_get_integer_cparameters_fmumodelica202309252128147594(void *fmu_wr, int *output_values, int set_size) {
}

void fmi2_get_real_cparameters_fmumodelica202309252128147594(void *fmu_wr, double *output_values, int set_size) {
}

void fmi2_get_string_cparameters_fmumodelica202309252128147594(void *fmu_wr, char **output_values, int set_size) {
}

void fmi2_set_boolean_parameters_fmumodelica202309252128147594(void *fmu_wr, int *input_values) {
}
void fmi2_set_integer_parameters_fmumodelica202309252128147594(void *fmu_wr, int *input_values) {
}
void fmi2_set_real_parameters_fmumodelica202309252128147594(void *fmu_wr, double *input_values) {
    wrapper_set_real(fmu_wr,
                     real_param_value_refs_fmumodelica202309252128147594,
                     n_real_param_value_refs_fmumodelica202309252128147594,
                     input_values,
                     &ModelicaError);
}
void fmi2_set_string_parameters_fmumodelica202309252128147594(void *fmu_wr, char **input_values) {
}

void fmi2_get_boolean_variables_fmumodelica202309252128147594(void *fmu_wr, int *output_values, int set_size) {
}

void fmi2_get_integer_variables_fmumodelica202309252128147594(void *fmu_wr, int *output_values, int set_size) {
}

void fmi2_get_real_variables_fmumodelica202309252128147594(void *fmu_wr, double *output_values, int set_size) {
    if (n_real_variables_value_refs_fmumodelica202309252128147594 != set_size)  {
        ModelicaError("Sizes in FMI functions are not correct for variables of type Real\n");
    }
    wrapper_get_real(fmu_wr,
                     real_variables_value_refs_fmumodelica202309252128147594,
                     n_real_variables_value_refs_fmumodelica202309252128147594,
                     output_values,
                     &ModelicaError);
}

void fmi2_get_string_variables_fmumodelica202309252128147594(void *fmu_wr, char **output_values, int set_size) {
}

void fmi2_set_boolean_inputs_fmumodelica202309252128147594(void *fmu_wr, int *input_values) {
}

void fmi2_set_integer_inputs_fmumodelica202309252128147594(void *fmu_wr, int *input_values) {
}

void fmi2_set_real_inputs_fmumodelica202309252128147594(void *fmu_wr, double *input_values) {
}

void fmi2_set_string_inputs_fmumodelica202309252128147594(void *fmu_wr, char **input_values) {
}

void fmi2_setup_experiment_fmumodelica202309252128147594(void *fmu_wr,
                                int tolerance_defined,
                                double tolerance,
                                double start_time,
                                int stop_time_defined,
                                double stop_time)
{
    /* Set previous_time_fmumodelica202309252128147594 to any time before start_time to account for logic in fmi2_do_step. */
    previous_time_fmumodelica202309252128147594 = start_time - 1.0;
    wrapper_setup_experiment(fmu_wr,
                             tolerance_defined,
                             tolerance,
                             start_time,
                             stop_time_defined,
                             stop_time,
                             &ModelicaError);
}
        
void fmi2_enter_initialization_mode_fmumodelica202309252128147594(void *fmu_wr)
{
    wrapper_enter_initialization_mode(fmu_wr, &ModelicaError);
}
        
void fmi2_exit_initialization_mode_fmumodelica202309252128147594(void *fmu_wr)
{
    wrapper_exit_initialization_mode(fmu_wr, &ModelicaError);
}
        
void fmi2_do_step_fmumodelica202309252128147594(void *fmu_wr,
                        double current_time,
                        double step_size,
                        int no_prior_fmu_state)
{
    /* Make sure we only take a step when time has advanced from the most recent time */
    if (current_time > previous_time_fmumodelica202309252128147594) {
        previous_time_fmumodelica202309252128147594 = current_time;
        wrapper_do_step(fmu_wr,
                        current_time,
                        step_size,
                        no_prior_fmu_state,
                        &ModelicaError);
    }
}
        
void fmi2_set_real_input_der_fmumodelica202309252128147594(void *fmu_wr,
                                          const int *value_refs,
                                          size_t n_values,
                                          int *order,
                                          double *input_values)
{
    wrapper_set_real_input_der(fmu_wr,
                               value_refs,
                               n_values,
                               order,
                               input_values,
                               &ModelicaError);
}
        #endif /*fmumodelica202309252128147594_H */
