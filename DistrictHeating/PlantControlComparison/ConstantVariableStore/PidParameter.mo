within DistrictHeating.PlantControlComparison.ConstantVariableStore;
record PidParameter "PID Parameter calculated by Chien/Hornes/Reswick"
  extends Modelica.Icons.Record;
 parameter Real k=387107 "Gain";
  parameter Modelica.SIunits.Time Ti=723977 "Integration Time";
  parameter Modelica.SIunits.Time Td=252051 "Derivative Time";
  parameter Real Nd=10;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p><span style=\"font-family: Arial,sans-serif;\">Contains parameter for PID-Control. </span></p>
<p><span style=\"font-family: Arial,sans-serif;\">Parameter are determined in Model PIDParametersRamp. </span></p>
</html>"));
end PidParameter;
