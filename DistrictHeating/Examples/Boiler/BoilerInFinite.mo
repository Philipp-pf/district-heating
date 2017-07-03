within DistrictHeating.Examples.Boiler;
model BoilerInFinite

  extends Modelica.Icons.Example;

  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={2,0})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=273.15)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={40,0})));
  Modelica.Blocks.Math.Feedback feedback
    annotation (Placement(transformation(extent={{10,58},{30,78}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=2000,
    duration=2,
    offset=0,
    startTime=1)
    annotation (Placement(transformation(extent={{-84,-10},{-64,10}})));
  Components.Boiler.BoilerInFinite boilerInFinite(limited_heat=true,
    Qmax=1000,
    TimeFirstOrder=0.001)
    annotation (Placement(transformation(extent={{-44,-10},{-24,10}})));
equation
  connect(heatFlowSensor.Q_flow, feedback.u2) annotation (Line(points={{2,-10},
          {2,-10},{2,-16},{2,-18},{20,-18},{20,60}}, color={0,0,127}));
  connect(ramp.y, boilerInFinite.nominal_heat) annotation (Line(points={{
          -63,0},{-54,0},{-44.4,0}}, color={0,0,127}));
  connect(heatFlowSensor.port_a, boilerInFinite.thermal_heat_flow)
    annotation (Line(points={{-8,0},{-24,0}}, color={191,0,0}));
  connect(feedback.u1, boilerInFinite.nominal_heat) annotation (Line(
        points={{12,68},{-54,68},{-54,0},{-44.4,0}},color={0,0,127}));
  connect(heatFlowSensor.port_b, fixedTemperature.port)
    annotation (Line(points={{12,0},{21,0},{30,0}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=5),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p>This example shows that the Real input of the Model is directly converted into a heat flow output.</p>
<p>With the limited heat flow the Real input rises above the limit but the heat flow output stays at its maximum.</p>
</html>"));
end BoilerInFinite;
