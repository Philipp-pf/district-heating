within DistrictHeating.PlantControlComparison.ConstantBoilerHeatFlowTwoLayer;
record TwelveHrs "Parameters for 12 hours constant boiler heat flow"

parameter Modelica.SIunits.Time TimeConstant=43200
    "time over which the boiler heat flow keeps constant";
parameter Modelica.SIunits.Height Hhighload1=3.5
    "highest store load (lowest value of boarder height)";
parameter Real khigh1=1.39 "gain to fill store, high";
parameter Modelica.SIunits.Height Hhighload2=8
    "high store load (low value of boarder height)";
parameter Real khigh2=1.25 "gain to fill store, low";
parameter Modelica.SIunits.Height Hlowload2= 13
    "low store load (high value of boarder height)";
parameter Real klow2=1.2 "gain to unfill store, high";
parameter Modelica.SIunits.Height Hlowload1= 18.5
    "lowest store load (highest value of boarder height)";
parameter Real klow1=01 "gain to unfill store, low";
parameter Modelica.SIunits.HeatFlowRate QStart=100000
    "heat flow rate at beginning of simulation until second time period (storage losses)";
parameter Modelica.SIunits.Time TStart= 2043200
    "Time until QStart is used, aftwards controlled by mean consumer heat flow";
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
end TwelveHrs;
