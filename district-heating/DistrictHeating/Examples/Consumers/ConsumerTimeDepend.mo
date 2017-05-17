within DistrictHeating.Examples.Consumers;
model ConsumerTimeDepend
  extends Modelica.Icons.Example;
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{-38,-10},{-18,10}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-28})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={0,-64})));
  Components.Consumers.ConsumerTimeDepend consumerTimeDepend(time_heat=[0,
        0; 1,0; 3,2000; 4,1500; 5,1700; 7,1300; 10,0], tstart=0)
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
equation
  connect(heatCapacitor.port,heatFlowSensor. port_b) annotation (Line(points={{0,-54},
          {0,-46},{0,-38}},                color={191,0,0}));
  connect(heatFlowSensor.port_a,prescribedHeatFlow. port)
    annotation (Line(points={{0,-18},{0,0},{-18,0}},     color={191,0,0}));
  connect(consumerTimeDepend.heat_flow, prescribedHeatFlow.port)
    annotation (Line(points={{20,0},{-18,0}}, color={191,0,0}));
  connect(prescribedHeatFlow.Q_flow, consumerTimeDepend.heat_demand)
    annotation (Line(points={{-38,0},{-52,0},{-52,16},{-8,16},{-8,7},{
          19.4,7}}, color={0,0,127}));
  annotation (Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">This example shows the use of the time dependend consumer. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">With the intern definded time table the heat demand is given.</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">With the Real output of the model the heat flow demand is used to produce the needed heat flow. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">The heat flow sensor shows that the real output and the heat flow are equal (except the unit).</span></p>
</html>"));
end ConsumerTimeDepend;
