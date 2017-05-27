within DistrictHeating.Examples;
model DistrictHeatWithoutStore
  extends Modelica.Icons.Example;
  Components.Consumers.ConsumerTimeDepend consumerTimeDepend(time_heat=[0,0;
        3,2000; 4,1700; 6,1500; 7,1300; 10,0], tstart=0)
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-22})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=
       273.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-56})));
  Components.Boiler.BoilerBasicPeak boilerBasicPeak(Qbase=1500, Qpeak=500)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
equation
  connect(heatFlowSensor.port_a, fixedTemperature.port)
    annotation (Line(points={{0,-32},{0,-40},{0,-46},{4.44089e-016,-46}},
                                               color={191,0,0}));
  connect(boilerBasicPeak.thermal_heat_flow, consumerTimeDepend.heat_flow)
    annotation (Line(points={{-20,0},{0,0},{20,0}}, color={191,0,0}));
  connect(heatFlowSensor.port_b, consumerTimeDepend.heat_flow) annotation (
      Line(points={{6.66134e-016,-12},{6.66134e-016,0},{20,0}}, color={191,
          0,0}));
  connect(consumerTimeDepend.heat_demand, boilerBasicPeak.nominal_heat)
    annotation (Line(points={{19.4,7},{-8,7},{-8,14},{-8,16},{-54,16},{-54,
          0},{-40.4,0}}, color={0,0,127}));
  annotation (experiment(StopTime=10), __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">The consumer defines a heat demand, which is produced by the boiler. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">During times with low heat flow, only the basic load boiler is in use. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">During times with high heat flow, the basic and the peak load boiler are in use. </span></p>
</html>"));
end DistrictHeatWithoutStore;
