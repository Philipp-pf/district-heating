within DistrictHeating.PlantControlComparison.OutsideTempControlTwoLayer;
model Table
  parameter Modelica.SIunits.HeatFlowRate DataTable[:,:]
    "Contains Data Table for temperature control, first column: outside temp, first row: storeload";

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
<p>Use this table to fill in data of temperature and heat flow.</p>
</html>"));
end Table;
