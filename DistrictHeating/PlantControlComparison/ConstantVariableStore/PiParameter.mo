within DistrictHeating.PlantControlComparison.ConstantVariableStore;
record PiParameter "calculated parameters for Step-Answer"
  extends Modelica.Icons.Record;
 parameter Real k=33638 "Gain";
  parameter Modelica.SIunits.Time Ti=492052 "Integration Time";
  parameter Modelica.SIunits.Time Td=Modelica.Constants.eps "Derivative Time";
  parameter Real Nd=Modelica.Constants.eps;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Contains parameter for PI-Control. </p>
<p>Parameter are determined in Model PIDParametersStep. </p>
</html>"));
end PiParameter;
