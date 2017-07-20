within DistrictHeating.Components.Consumers;
model ConsumerTimeDependExt
  "time dependence of the heat consumptionparameter time_to_heat; "

    //symbols
    Modelica.SIunits.HeatFlowRate Q_consum=heat_demand
    "consumer heat flow rate";
Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heat_flow_consumer
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-36,0})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heat_flow "heat demand 
  of all households including net losses"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Blocks.Math.Gain gain(k=-1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={2,0})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heat_demand_sensor
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-72,0})));
  Modelica.Blocks.Interfaces.RealOutput heat_demand "positive heat demand"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-106,70})));
  Modelica.Blocks.Math.Gain invertor(k=-1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-72,38})));
  Modelica.Blocks.Interfaces.RealInput positive_heat_flow annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={106,0})));
equation
  connect(gain.y, heat_flow_consumer.Q_flow)
    annotation (Line(points={{-9,0},{-26,0}}, color={0,0,127}));
  connect(heat_demand_sensor.port_b, heat_flow)
    annotation (Line(points={{-82,0},{-91,0},{-100,0}}, color={191,0,0}));
  connect(heat_demand_sensor.port_a, heat_flow_consumer.port)
    annotation (Line(points={{-62,0},{-54,0},{-46,0}}, color={191,0,0}));
  connect(heat_demand_sensor.Q_flow, invertor.u)
    annotation (Line(points={{-72,10},{-72,18},{-72,26}}, color={0,0,127}));
  connect(invertor.y, heat_demand) annotation (Line(points={{-72,49},{-72,49},{-72,
          56},{-72,70},{-106,70}}, color={0,0,127}));
  connect(gain.u, positive_heat_flow)
    annotation (Line(points={{14,0},{106,0},{106,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Text(
          extent={{-98,-12},{-60,-24}},
          lineColor={238,46,47},
          lineThickness=0.5,
          textString="heat flow",
          fontSize=14),
        Text(
          extent={{-94,76},{-40,64}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fontSize=14,
          textString="heat demand"),
        Line(points={{-10,70}}, color={0,0,0}),
        Rectangle(
          extent={{-60,18},{60,-76}},
          lineColor={0,0,0}),
        Rectangle(
          extent={{-12,-76},{12,-38}},
          lineColor={0,0,0}),
        Rectangle(
          extent={{-50,-38},{-26,-58}},
          lineColor={0,0,0}),
        Rectangle(
          extent={{26,-38},{50,-58}},
          lineColor={0,0,0}),
        Rectangle(
          extent={{26,4},{50,-16}},
          lineColor={0,0,0}),
        Rectangle(
          extent={{-50,4},{-26,-16}},
          lineColor={0,0,0}),
        Rectangle(
          extent={{-12,4},{12,-16}},
          lineColor={0,0,0}),
        Line(
          points={{-60,18},{0,80},{60,18}},
          color={0,0,0}),
        Text(
          extent={{-70,-84},{72,-94}},
          lineColor={0,0,0},
          textString="time dependend"),
        Text(
          extent={{-58,-112},{60,-134}},
          lineColor={28,108,200},
          textString="%name")}),
                          Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This is the model of a consumer with time dependent heat consumtption. </p>
<p>The heat flow of the model is defined by a external source, for example TimeTable or CombiTimeTable.</p>
<p><img src=\"modelica://DistrictHeating/Resources/Images/heat_demand_time.png\"/></p>
</html>", revisions=""));
end ConsumerTimeDependExt;
