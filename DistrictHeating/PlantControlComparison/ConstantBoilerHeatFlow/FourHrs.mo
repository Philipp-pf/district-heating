within DistrictHeating.PlantControlComparison.ConstantBoilerHeatFlow;
record FourHrs "Parameters for 4 hours constant boiler heat flow"

parameter Modelica.SIunits.Time TimeConstant=14400
    "time over which the boiler heat flow keeps constant";
 parameter Real khigh1=1.2 "gain to fill store, high";
 parameter Real khigh2=1.02 "gain to fill store, low";
 parameter Real klow2=1.02 "gain to unfill store, high";
parameter Real klow1=1 "gain to unfill store, low";

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Text(
          lineColor={0,0,255},
          extent={{-150,60},{150,100}},
          textString="%name"),
        Rectangle(
          origin={0,-25},
          lineColor={64,64,64},
          fillColor={255,215,136},
          fillPattern=FillPattern.Solid,
          extent={{-100.0,-75.0},{100.0,75.0}},
          radius=25.0),
        Line(
          points={{-100,0},{100,0}},
          color={64,64,64}),
        Line(
          origin={0,-50},
          points={{-100.0,0.0},{100.0,0.0}},
          color={64,64,64}),
        Line(
          origin={0,-25},
          points={{0.0,75.0},{0.0,-75.0}},
          color={64,64,64})}),                                   Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end FourHrs;
