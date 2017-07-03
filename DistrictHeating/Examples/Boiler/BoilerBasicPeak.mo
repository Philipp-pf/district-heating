within DistrictHeating.Examples.Boiler;
model BoilerBasicPeak

  extends Modelica.Icons.Example;

  Components.Boiler.BoilerBasicPeak boilerInFinite(
    Qbase=1000,
    Qpeak=500,
    TimeFirstOrderBase=0.001,
    TimeFirstOrderPeak=0.001)
    annotation (Placement(transformation(extent={{-36,-10},{-16,10}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={2,0})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=273.15)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={66,0})));
  Modelica.Blocks.Math.Feedback feedback
    annotation (Placement(transformation(extent={{6,58},{26,78}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=2000,
    duration=2,
    offset=0,
    startTime=1)
    annotation (Placement(transformation(extent={{-84,-10},{-64,10}})));
equation
  connect(ramp.y, boilerInFinite.nominal_heat)
    annotation (Line(points={{-63,0},{-50,0},{-36.4,0}},
                                                 color={0,0,127}));
  connect(boilerInFinite.thermal_heat_flow, heatFlowSensor.port_a)
    annotation (Line(points={{-16,0},{-16,0},{-8,0}}, color={191,0,0}));
  connect(heatFlowSensor.Q_flow, feedback.u2) annotation (Line(points={{2,-10},
          {2,-10},{2,-18},{2,-20},{16,-20},{16,60}}, color={0,0,127}));
  connect(feedback.u1, boilerInFinite.nominal_heat) annotation (Line(
        points={{8,68},{-50,68},{-50,0},{-36.4,0}}, color={0,0,127}));
  connect(heatFlowSensor.port_b, fixedTemperature.port)
    annotation (Line(points={{12,0},{34,0},{56,0}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=5),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">This example shows that the Real input of the Model is directly converted into a heat flow output.</span></p>
<p>With Real inputs lower than the maximum heat flow of the basic load boiler only this boiler is in use.</p>
<p>With Real inputs higher than the maximum heat flow of the basic load boiler additionaly the peak load boiler is in use. </p>
<p>With Real inputs higher than the sum of the maximum heat flow of basic and peak load boiler the heat output stays at its maximum.</p>
</html>"));
end BoilerBasicPeak;
