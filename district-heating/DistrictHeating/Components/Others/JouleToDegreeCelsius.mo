within DistrictHeating.Components.Others;
model JouleToDegreeCelsius

  extends Modelica.Blocks.Interfaces.SISO;
  parameter Modelica.SIunits.HeatCapacity C
    "Heat Capacity which refers to the energy content";
  parameter Modelica.SIunits.Temperature Tref
    "Reference Temperature which refers to the energy content";

equation
u=C*(y-Tref);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(
          points={{-80,0},{76,0}},
          color={255,0,0},
          thickness=0.5),
        Line(
          points={{76,0},{16,-60},{16,60},{76,0}},
          color={255,0,0},
          thickness=0.5),
        Text(
          extent={{-72,30},{14,-30}},
          lineColor={28,108,200},
          textString="J
"),     Text(
          extent={{-74,-30},{4,-80}},
          lineColor={28,108,200},
          textString="°C
")}),                                                            Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Unit conversion from Heat (Joule) to Temperature (Kelvin). </p>
</html>"));
end JouleToDegreeCelsius;
