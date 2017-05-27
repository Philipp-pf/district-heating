within DistrictHeating.Calibration;
model From_Scalar_To_Heat

Modelica.SIunits.Heat Unit_Heat=1 "Unit Conversion";
Modelica.SIunits.Heat Store_Heat_real "Stored heat in real Storage";

  Modelica.Blocks.Interfaces.RealInput u
    annotation (Placement(transformation(extent={{-126,-20},{-86,20}})));
  Modelica.Blocks.Interfaces.RealOutput y
    annotation (Placement(transformation(extent={{94,-10},{114,10}})));

equation
u*Unit_Heat=Store_Heat_real;
Store_Heat_real=y;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(extent={{-100,100},{100,-100}}, lineColor={28,108,200}),
        Line(
          points={{-76,0},{80,0}},
          color={255,0,0},
          thickness=0.5),
        Line(
          points={{80,0},{20,-60},{20,60},{80,0}},
          color={255,0,0},
          thickness=0.5),
        Text(
          extent={{-76,130},{74,106}},
          lineColor={28,108,200},
          textString="%name"),
        Text(
          extent={{-84,84},{16,8}},
          lineColor={28,108,200},
          textString="J")}),                                     Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Converts a Real Input signal into a Real Output Signal with unit Joule.</p>
</html>"));
end From_Scalar_To_Heat;
