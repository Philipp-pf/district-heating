within DistrictHeating.Examples.Others;
model JouleToDegreeCelsius "Unit Conversion from Joule to Kelvin"
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Ramp ramp(
    height=100,
    duration=5,
    startTime=2,
    offset=0.1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-14,0})));
  Components.Others.JouleToDegreeCelsius jouleToDegreeCelsius(C=1, Tref=273.15)
    annotation (Placement(transformation(extent={{6,-10},{26,10}})));
equation
  connect(ramp.y, jouleToDegreeCelsius.u)
    annotation (Line(points={{-3,0},{-3,0},{4,0}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=10),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p>This model checks, if the conversion component works correct. </p>
<p>With a heat capacity of 1 J/K, each J at the input causes 1 K Temperature change. </p>
<p>A ramp of 100 J causes 100 K temperaturedifference.</p>
</html>"));
end JouleToDegreeCelsius;
