within DistrictHeating.Examples.Consumers;
model ConsumerTempDepend
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Cosine cosine(
    amplitude=10,
    freqHz=0.1,
    offset=-5,
    startTime=0,
    phase=3.1415926535898) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={48,0})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{-62,-10},{-42,10}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-24,-28})));
  Components.Consumers.ConsumerTempDepend consumerTempDepend(
       temp=[-10,2000; 15,500])
    annotation (Placement(transformation(extent={{-4,-10},{16,10}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(
      T=273.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-24,-68})));
equation
  connect(heatFlowSensor.port_a,prescribedHeatFlow. port)
    annotation (Line(points={{-24,-18},{-24,0},{-42,0}}, color={191,0,0}));
  connect(cosine.y, consumerTempDepend.outside_temperature)
    annotation (Line(points={{37,0},{16.6,0}}, color={0,0,127}));
  connect(consumerTempDepend.heat_flow, prescribedHeatFlow.port)
    annotation (Line(points={{-4,0},{-42,0}}, color={191,0,0}));
  connect(prescribedHeatFlow.Q_flow, consumerTempDepend.heat_demand)
    annotation (Line(points={{-62,0},{-68,0},{-74,0},{-74,18},{-34,18},{
          -34,7},{-4.6,7}}, color={0,0,127}));
  connect(fixedTemperature.port, heatFlowSensor.port_b) annotation (Line(
        points={{-24,-58},{-24,-48},{-24,-38}}, color={191,0,0}));
  annotation (experiment(StopTime=10), __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p>This example shows the use of the temperature dependend consumer. </p>
<p>With the sinusoidal temperature trend a heat demand (heat flow) is generated. </p>
<p>With the Real output of the model the heat flow demand is used to produce the needed heat flow. </p>
<p>The heat flow sensor shows that the real output and the heat flow are equal (except the unit).</p>
</html>"));
end ConsumerTempDepend;
