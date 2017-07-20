within DistrictHeating.Examples.Boiler;
model BoilerInFinite

  extends Modelica.Icons.Example;

  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={0,0})));
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
    TimeFirstOrder=0.001,
    PartLoad=0.2)
    annotation (Placement(transformation(extent={{-44,-10},{-24,10}})));
equation
  connect(ramp.y, boilerInFinite.nominal_heat) annotation (Line(points={{
          -63,0},{-54,0},{-44.4,0}}, color={0,0,127}));
  connect(heatFlowSensor.port_a, boilerInFinite.thermal_heat_flow)
    annotation (Line(points={{-10,0},{-24,0}},color={191,0,0}));
  connect(feedback.u1, boilerInFinite.nominal_heat) annotation (Line(
        points={{12,68},{-54,68},{-54,0},{-44.4,0}},color={0,0,127}));
  connect(heatFlowSensor.port_b, fixedTemperature.port)
    annotation (Line(points={{10,0},{10,0},{30,0}}, color={191,0,0}));
  connect(heatFlowSensor.Q_flow, feedback.u2) annotation (Line(points={{0,-10},
          {0,-20},{20,-20},{20,60}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=5),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p>This example shows that the Real input of the Model is directly converted into a heat flow output.</p>
<p>At beginning nominal heat flow, the boiler heat flow rises to minimal heat flow of the boiler. If the nominal heat flow gets higher than the minimal heat flow, the output heat flow equals with the nominal heat flow. After reaching the upper limit of the boiler heat flow, the output heat flow keeps constant. </p>
</html>"));
end BoilerInFinite;
