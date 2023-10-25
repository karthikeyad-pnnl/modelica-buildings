within Buildings;
package Buildings_bouncing_ball
model Buildings_bouncing_ball
  FmuWrapper obj = FmuWrapper(
    Modelica.Utilities.Files.loadResource("modelica://Buildings/Resources/fmus/bouncing_ball_202309252128147594")
  ) annotation(__Modelon(internal(LoadDirectories=true)));

  parameter Real e = 0.8 "Coefficient of restitution";
  Real h(unit = "m") "Height";
  parameter Real h0(unit = "m") = 1.0 "Initial height";
  Real v(start = 0.0, unit = "m/s") "Velocity";

  parameter Real fmi_tolerance = 1e-06 "CS FMU built-in solver tolerance" annotation(Dialog(tab="FMI parameters"), __Modelon(internal(propagated_parameter="tolerance")));
  parameter Modelica.Units.SI.Time fmi_step_size = 0.0 "CS FMU built-in solver step length and the interval at which data will be interchanged. Default 0.0 means the step length will be calculated automatically based on start and stop times of the outer FMU" annotation(Dialog(tab="FMI parameters"), __Modelon(internal(propagated_parameter="step_size")));

protected
  parameter Modelica.Units.SI.Time fmi_start_time = 0.0 "CS FMU start time which will be automatically overwritten when compiled with Optimica Compiler Toolkit" annotation(Dialog(tab="FMI parameters"), __Modelon(internal(propagated_parameter="start_time")));
  parameter Modelica.Units.SI.Time fmi_stop_time = 1.0 "CS FMU stop time which will be automatically overwritten when compiled with Optimica Compiler Toolkit" annotation(Dialog(tab="FMI parameters"), __Modelon(internal(propagated_parameter="stop_time")));
  parameter Boolean fmi_true_token(fixed = false) "Internal parameter";
  Real real_variables[2] "Internal variable";

  class FmuWrapper
    extends ExternalObject;
  
      impure function constructor
        input String ext_lib_path;
        constant String instance_name = "buildings_bouncing_balla93039d18ecbf0a2654517d3a6ffeb98";
        constant String identifier = "Buildings_bouncing_ball";
        constant String GUID = "a93039d18ecbf0a2654517d3a6ffeb98";
        output FmuWrapper obj;
        external "C" obj = initialize_wrapper_fmumodelica202309252128147594(instance_name, identifier, ext_lib_path, GUID)
        annotation (
        Include="#include \"fmumodelica202309252128147594.h\"",
        IncludeDirectory="modelica://Buildings/Resources/Include",
        Library="fmu_wrapper",
        LibraryDirectory="modelica://Buildings/Resources/fmus/bouncing_ball_202309252128147594/binaries");
      end constructor;
  
      impure function destructor
        input FmuWrapper obj;
        external "C" free_wrapper(obj) annotation (
          Include="#include \"fmu_wrapper.h\"",
          IncludeDirectory="modelica://Buildings/Resources/Include",
          Library="fmu_wrapper",
          LibraryDirectory="modelica://Buildings/Resources/fmus/bouncing_ball_202309252128147594/binaries");
      end destructor;
  
  end FmuWrapper;

  impure function fmi2GetBooleanVariables
    input FmuWrapper fmu_wrapper;
    output Boolean output_values[0];
    external "C" fmi2_get_boolean_variables_fmumodelica202309252128147594(fmu_wrapper, output_values, 0)
    annotation (
    Include="#include \"fmumodelica202309252128147594.h\"",
    IncludeDirectory="modelica://Buildings/Resources/Include",
    Library="fmu_wrapper",
    LibraryDirectory="modelica://Buildings/Resources/fmus/bouncing_ball_202309252128147594/binaries");
  end fmi2GetBooleanVariables;
  
  impure function fmi2GetIntegerVariables
    input FmuWrapper fmu_wrapper;
    output Integer output_values[0];
    external "C" fmi2_get_integer_variables_fmumodelica202309252128147594(fmu_wrapper, output_values, 0)
    annotation (
    Include="#include \"fmumodelica202309252128147594.h\"",
    IncludeDirectory="modelica://Buildings/Resources/Include",
    Library="fmu_wrapper",
    LibraryDirectory="modelica://Buildings/Resources/fmus/bouncing_ball_202309252128147594/binaries");
  end fmi2GetIntegerVariables;
  
  impure function fmi2GetRealVariables
    input FmuWrapper fmu_wrapper;
    output Real output_values[2];
    external "C" fmi2_get_real_variables_fmumodelica202309252128147594(fmu_wrapper, output_values, 2)
    annotation (
    Include="#include \"fmumodelica202309252128147594.h\"",
    IncludeDirectory="modelica://Buildings/Resources/Include",
    Library="fmu_wrapper",
    LibraryDirectory="modelica://Buildings/Resources/fmus/bouncing_ball_202309252128147594/binaries");
  end fmi2GetRealVariables;
  
  impure function fmi2GetStringVariables
    input FmuWrapper fmu_wrapper;
    output String output_values[0];
    external "C" fmi2_get_string_variables_fmumodelica202309252128147594(fmu_wrapper, output_values, 0)
    annotation (
    Include="#include \"fmumodelica202309252128147594.h\"",
    IncludeDirectory="modelica://Buildings/Resources/Include",
    Library="fmu_wrapper",
    LibraryDirectory="modelica://Buildings/Resources/fmus/bouncing_ball_202309252128147594/binaries");
  end fmi2GetStringVariables;
  
  impure function fmi2GetBooleanCalculatedParameters
    input FmuWrapper fmu_wrapper;
    output Boolean output_values[0];
    external "C" fmi2_get_boolean_cparameters_fmumodelica202309252128147594(fmu_wrapper, output_values, 0)
    annotation (
    Include="#include \"fmumodelica202309252128147594.h\"",
    IncludeDirectory="modelica://Buildings/Resources/Include",
    Library="fmu_wrapper",
    LibraryDirectory="modelica://Buildings/Resources/fmus/bouncing_ball_202309252128147594/binaries");
  end fmi2GetBooleanCalculatedParameters;
  
  impure function fmi2GetIntegerCalculatedParameters
    input FmuWrapper fmu_wrapper;
    output Integer output_values[0];
    external "C" fmi2_get_integer_cparameters_fmumodelica202309252128147594(fmu_wrapper, output_values, 0)
    annotation (
    Include="#include \"fmumodelica202309252128147594.h\"",
    IncludeDirectory="modelica://Buildings/Resources/Include",
    Library="fmu_wrapper",
    LibraryDirectory="modelica://Buildings/Resources/fmus/bouncing_ball_202309252128147594/binaries");
  end fmi2GetIntegerCalculatedParameters;
  
  impure function fmi2GetRealCalculatedParameters
    input FmuWrapper fmu_wrapper;
    output Real output_values[0];
    external "C" fmi2_get_real_cparameters_fmumodelica202309252128147594(fmu_wrapper, output_values, 0)
    annotation (
    Include="#include \"fmumodelica202309252128147594.h\"",
    IncludeDirectory="modelica://Buildings/Resources/Include",
    Library="fmu_wrapper",
    LibraryDirectory="modelica://Buildings/Resources/fmus/bouncing_ball_202309252128147594/binaries");
  end fmi2GetRealCalculatedParameters;
  
  impure function fmi2GetStringCalculatedParameters
    input FmuWrapper fmu_wrapper;
    input Boolean dummy;
    output String output_values[0];
    external "C" fmi2_get_string_cparameters_fmumodelica202309252128147594(fmu_wrapper, output_values, 0)
    annotation (
    Include="#include \"fmumodelica202309252128147594.h\"",
    IncludeDirectory="modelica://Buildings/Resources/Include",
    Library="fmu_wrapper",
    LibraryDirectory="modelica://Buildings/Resources/fmus/bouncing_ball_202309252128147594/binaries");
  end fmi2GetStringCalculatedParameters;
  
  impure function fmi2SetBooleanInputs
    input FmuWrapper fmu_wrapper;
    input Boolean input_values[:];
    external "C" fmi2_set_boolean_inputs_fmumodelica202309252128147594(fmu_wrapper, input_values)
    annotation (
      Include="#include \"fmumodelica202309252128147594.h\"",
      IncludeDirectory="modelica://Buildings/Resources/Include",
      Library="fmu_wrapper",
      LibraryDirectory="modelica://Buildings/Resources/fmus/bouncing_ball_202309252128147594/binaries");
  end fmi2SetBooleanInputs;
  
  impure function fmi2SetIntegerInputs
    input FmuWrapper fmu_wrapper;
    input Integer input_values[:];
    external "C" fmi2_set_integer_inputs_fmumodelica202309252128147594(fmu_wrapper, input_values)
    annotation (
      Include="#include \"fmumodelica202309252128147594.h\"",
      IncludeDirectory="modelica://Buildings/Resources/Include",
      Library="fmu_wrapper",
      LibraryDirectory="modelica://Buildings/Resources/fmus/bouncing_ball_202309252128147594/binaries");
  end fmi2SetIntegerInputs;
  
  impure function fmi2SetRealInputs
    input FmuWrapper fmu_wrapper;
    input Real input_values[:];
    external "C" fmi2_set_real_inputs_fmumodelica202309252128147594(fmu_wrapper, input_values)
    annotation (
      Include="#include \"fmumodelica202309252128147594.h\"",
      IncludeDirectory="modelica://Buildings/Resources/Include",
      Library="fmu_wrapper",
      LibraryDirectory="modelica://Buildings/Resources/fmus/bouncing_ball_202309252128147594/binaries");
  end fmi2SetRealInputs;
  
  impure function fmi2SetStringInputs
    input FmuWrapper fmu_wrapper;
    input String input_values[:];
    external "C" fmi2_set_string_inputs_fmumodelica202309252128147594(fmu_wrapper, input_values)
    annotation (
      Include="#include \"fmumodelica202309252128147594.h\"",
      IncludeDirectory="modelica://Buildings/Resources/Include",
      Library="fmu_wrapper",
      LibraryDirectory="modelica://Buildings/Resources/fmus/bouncing_ball_202309252128147594/binaries");
  end fmi2SetStringInputs;
  
  impure function fmi2SetBooleanParameters
    input FmuWrapper fmu_wrapper;
    input Boolean input_values[:];
    external "C" fmi2_set_boolean_parameters_fmumodelica202309252128147594(fmu_wrapper, input_values)
    annotation (
      Include="#include \"fmumodelica202309252128147594.h\"",
      IncludeDirectory="modelica://Buildings/Resources/Include",
      Library="fmu_wrapper",
      LibraryDirectory="modelica://Buildings/Resources/fmus/bouncing_ball_202309252128147594/binaries");
  end fmi2SetBooleanParameters;
  
  impure function fmi2SetIntegerParameters
    input FmuWrapper fmu_wrapper;
    input Integer input_values[:];
    external "C" fmi2_set_integer_parameters_fmumodelica202309252128147594(fmu_wrapper, input_values)
    annotation (
      Include="#include \"fmumodelica202309252128147594.h\"",
      IncludeDirectory="modelica://Buildings/Resources/Include",
      Library="fmu_wrapper",
      LibraryDirectory="modelica://Buildings/Resources/fmus/bouncing_ball_202309252128147594/binaries");
  end fmi2SetIntegerParameters;
  
  impure function fmi2SetRealParameters
    input FmuWrapper fmu_wrapper;
    input Real input_values[:];
    external "C" fmi2_set_real_parameters_fmumodelica202309252128147594(fmu_wrapper, input_values)
    annotation (
      Include="#include \"fmumodelica202309252128147594.h\"",
      IncludeDirectory="modelica://Buildings/Resources/Include",
      Library="fmu_wrapper",
      LibraryDirectory="modelica://Buildings/Resources/fmus/bouncing_ball_202309252128147594/binaries");
  end fmi2SetRealParameters;
  
  impure function fmi2SetStringParameters
    input FmuWrapper fmu_wrapper;
    input String input_values[:];
    external "C" fmi2_set_string_parameters_fmumodelica202309252128147594(fmu_wrapper, input_values)
    annotation (
      Include="#include \"fmumodelica202309252128147594.h\"",
      IncludeDirectory="modelica://Buildings/Resources/Include",
      Library="fmu_wrapper",
      LibraryDirectory="modelica://Buildings/Resources/fmus/bouncing_ball_202309252128147594/binaries");
  end fmi2SetStringParameters;
  
  impure function fmi2SetupExperiment
    input FmuWrapper fmu_wrapper;
    input Boolean tolerance_defined = true;
    input Real tolerance = 1e-6;
    input Real start_time = 0.0;
    input Boolean stop_time_defined = false;
    input Real stop_time = 1.0;
    external "C" fmi2_setup_experiment_fmumodelica202309252128147594(
      fmu_wrapper,
      tolerance_defined, tolerance,
      start_time,
      stop_time_defined, stop_time)
    annotation (
      Include="#include \"fmumodelica202309252128147594.h\"",
      IncludeDirectory="modelica://Buildings/Resources/Include",
      Library="fmu_wrapper",
      LibraryDirectory="modelica://Buildings/Resources/fmus/bouncing_ball_202309252128147594/binaries");
  end fmi2SetupExperiment;
  
  impure function fmi2EnterInitializationMode
    input FmuWrapper fmu_wrapper;
    external "C" fmi2_enter_initialization_mode_fmumodelica202309252128147594(fmu_wrapper)
    annotation (
      Include="#include \"fmumodelica202309252128147594.h\"",
      IncludeDirectory="modelica://Buildings/Resources/Include",
      Library="fmu_wrapper",
      LibraryDirectory="modelica://Buildings/Resources/fmus/bouncing_ball_202309252128147594/binaries");
  end fmi2EnterInitializationMode;
  
  impure function fmi2ExitInitializationMode
    input FmuWrapper fmu_wrapper;
    external "C" fmi2_exit_initialization_mode_fmumodelica202309252128147594(fmu_wrapper)
    annotation (
      Include="#include \"fmumodelica202309252128147594.h\"",
      IncludeDirectory="modelica://Buildings/Resources/Include",
      Library="fmu_wrapper",
      LibraryDirectory="modelica://Buildings/Resources/fmus/bouncing_ball_202309252128147594/binaries");
  end fmi2ExitInitializationMode;
  
  impure function fmi2DoStep
    input FmuWrapper fmu_wrapper;
    input Real current_time;
    input Real step_size;
    input Boolean no_prior_fmu_state;
    external "C" fmi2_do_step_fmumodelica202309252128147594(
      fmu_wrapper, current_time, step_size, no_prior_fmu_state
    )
    annotation (
      Include="#include \"fmumodelica202309252128147594.h\"",
      IncludeDirectory="modelica://Buildings/Resources/Include",
      Library="fmu_wrapper",
      LibraryDirectory="modelica://Buildings/Resources/fmus/bouncing_ball_202309252128147594/binaries");
  end fmi2DoStep;
  
  impure function fmi2SetRealInputDerivatives
    input FmuWrapper fmu_wrapper;
    input Integer value_refs[:];
    input Integer order[size(value_refs, 1)];
    input Real input_values[size(value_refs, 1)];
    external "C" fmi2_set_real_input_der_fmumodelica202309252128147594(
      fmu_wrapper, value_refs, size(value_refs, 1), order, input_values
    )
    annotation (
      Include="#include \"fmumodelica202309252128147594.h\"",
      IncludeDirectory="modelica://Buildings/Resources/Include",
      Library="fmu_wrapper",
      LibraryDirectory="modelica://Buildings/Resources/fmus/bouncing_ball_202309252128147594/binaries");
  end fmi2SetRealInputDerivatives;
initial algorithm
  fmi2SetRealParameters(obj, {e, h0});
  fmi_true_token := true;
  fmi2SetupExperiment(obj, true, fmi_tolerance, fmi_start_time, false, fmi_stop_time);
  fmi2EnterInitializationMode(obj);
  fmi2ExitInitializationMode(obj);

algorithm
  .assert(fmi_step_size > 0.0, "Invalid step size, must be larger than 0.0");
  when .sample(fmi_start_time, fmi_step_size) then
    if time >= fmi_start_time + fmi_step_size then
      fmi2DoStep(obj, time - fmi_step_size, fmi_step_size, fmi_true_token);
    end if;
  real_variables := fmi2GetRealVariables(obj);
  end when;
  when time > fmi_stop_time then
    .assert(false, "Continuing simulation from time " + String(time) + " using step size " + String(fmi_step_size) + ". Please verify that this is suitable.",
           AssertionLevel.warning);
  end when;

initial equation


equation
  v = real_variables[1];
  h = real_variables[2];

  annotation(__Modelon(FMU_IMPORT_VERSION="0.1.0"),
  Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100, -100}, {100, 100}}),
       graphics={Rectangle(origin = {0, 0}, extent = {{-100, 100}, {100, -100}}, fillPattern = FillPattern.Solid, fillColor = {255, 255, 255}),
                 Bitmap(extent={{-90, -100}, {90, 100}}, fileName = "modelica://Buildings/Resources/Icons/fmumodelica/Buildings_bouncing_ball20230925212814.png"),
                 Text(textString="%name", lineColor = {61, 61, 61}, origin={0, -135}, extent={{0, 25}, {0, -25}})}),
Documentation(info="<html>
<h4>ModelDescription Attributes</h4>
<li>fmiVersion = 2.0</li>
<li>modelName = Buildings.bouncing_ball</li>
<li>generationTool = Optimica Compiler Toolkit</li>
<li>generationDateAndTime = 2023-09-25, 21:28:14</li>
</ul>
</html>"));


end Buildings_bouncing_ball;
end Buildings_bouncing_ball;