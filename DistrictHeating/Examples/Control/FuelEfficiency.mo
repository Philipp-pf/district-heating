within DistrictHeating.Examples.Control;
model FuelEfficiency
  extends Modelica.Icons.Example;

Real CalculatedEfficiency
    "calculated efficiency as qoutient of actual heat divided by fuel heat";

  DistrictHeating.Components.Control.FuelEfficiency fuelEfficiency(
      EfficiencyTable=[0,0.3; 1000,0.5; 2000,0.7; 3000,0.85; 4000,0.8])
    annotation (Placement(transformation(extent={{12,-40},{32,-20}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=4000,
    duration=5,
    offset=0,
    startTime=0)
    annotation (Placement(transformation(extent={{-68,10},{-48,30}})));
  DistrictHeating.Components.Boiler.BoilerInFinite boilerInFinite(
      limited_heat=false, Qmax=1000)
    annotation (Placement(transformation(extent={{-36,10},{-16,30}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor
    annotation (Placement(transformation(extent={{-10,10},{10,30}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=
        273.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={32,20})));
equation

  if time<=0 then
    CalculatedEfficiency=0;
  else
    CalculatedEfficiency=fuelEfficiency.u/fuelEfficiency.y;
  end if;

  connect(ramp.y, boilerInFinite.nominal_heat)
    annotation (Line(points={{-47,20},{-36.4,20}}, color={0,0,127}));
  connect(boilerInFinite.thermal_heat_flow, heatFlowSensor.port_a)
    annotation (Line(points={{-16,20},{-14,20},{-10,20}}, color={191,0,0}));
  connect(heatFlowSensor.port_b, fixedTemperature.port)
    annotation (Line(points={{10,20},{16,20},{22,20}}, color={191,0,0}));
  connect(heatFlowSensor.Q_flow, fuelEfficiency.u) annotation (Line(points={{
          0,10},{0,10},{0,-10},{0,-30},{10,-30}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=5),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p>In this example the needed fuel heat flow is determined. </p>
</html>"));
end FuelEfficiency;
