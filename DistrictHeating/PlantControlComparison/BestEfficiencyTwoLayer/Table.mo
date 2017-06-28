within DistrictHeating.PlantControlComparison.BestEfficiencyTwoLayer;
model Table
  parameter Modelica.SIunits.HeatFlowRate DataTable[:,2]
    "Contains Data Table for efficiency control, first column: boiler heat flow, second column: boiler efficiency";

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,0}),
        Rectangle(extent={{-60,80},{0,60}}, lineColor={0,0,0}),
        Rectangle(extent={{-60,60},{0,40}}, lineColor={0,0,0}),
        Rectangle(extent={{0,80},{60,60}}, lineColor={0,0,0}),
        Rectangle(extent={{0,60},{60,40}}, lineColor={0,0,0}),
        Rectangle(extent={{-60,40},{0,20}}, lineColor={0,0,0}),
        Rectangle(extent={{-60,20},{0,0}}, lineColor={0,0,0}),
        Rectangle(extent={{0,40},{60,20}}, lineColor={0,0,0}),
        Rectangle(extent={{0,20},{60,0}}, lineColor={0,0,0}),
        Rectangle(extent={{-60,0},{0,-20}}, lineColor={0,0,0}),
        Rectangle(extent={{-60,-20},{0,-40}}, lineColor={0,0,0}),
        Rectangle(extent={{0,0},{60,-20}}, lineColor={0,0,0}),
        Rectangle(extent={{0,-20},{60,-40}}, lineColor={0,0,0}),
        Rectangle(extent={{-60,-40},{0,-60}}, lineColor={0,0,0}),
        Rectangle(extent={{-60,-60},{0,-80}}, lineColor={0,0,0}),
        Rectangle(extent={{0,-40},{60,-60}}, lineColor={0,0,0}),
        Rectangle(extent={{0,-60},{60,-80}}, lineColor={0,0,0}),
        Text(
          extent={{-58,-110},{68,-136}},
          lineColor={0,0,0},
          textString="%name")}),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Use this table to fill in data of boiler heat flow and boiler efficiency.</p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Give attention to prefixes of SI units. If using &QUOT;Kilo&QUOT;  for heat flow for instance, you have to fill in &QUOT;Kilo&QUOT; for efficiency.</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Example: If using 100,000 W then efficiency is 0.7.</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">If using 100 kW then efficiency is 0.0007.</span></p>
</html>"));
end Table;
