within DistrictHeating.Examples.Others;
model VariableThermalConductor
  "Thermal conductor which has an input of thermal conductance"
  extends Modelica.Icons.Example;
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow(
      Q_flow=100)
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  DistrictHeating.Components.Others.VariableThermalConductor
    variableThermalConductor
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(
      T=273.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={42,0})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=100,
    duration=5,
    startTime=2,
    offset=0.1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,38})));
equation
  connect(fixedHeatFlow.port, variableThermalConductor.port_a)
    annotation (Line(points={{-30,0},{-20,0},{-10,0}}, color={191,0,0}));
  connect(variableThermalConductor.port_b, fixedTemperature.port)
    annotation (Line(points={{10,0},{22,0},{32,0}}, color={191,0,0}));
  connect(variableThermalConductor.Thermal_conduct, ramp.y) annotation (
      Line(points={{0,10.4},{0,10.4},{0,27},{-1.9984e-015,27}}, color={0,
          0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=10),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p>Shows, if the variable thermal conductor works correct.</p>
</html>"));
end VariableThermalConductor;
