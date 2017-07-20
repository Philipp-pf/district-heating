within DistrictHeating.Components.Consumers;
model ConsumerTempDepend
  "linear dependence of the heat consumption by outside temperature"

    parameter Real temp[:,2]
    "temperature to heat (left column outside temperature in °C, right column heat flow in W";
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
  Modelica.Blocks.Interfaces.RealInput outside_temperature
    "outside temperature in the area"                                                        annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={106,0})));
  Modelica.Blocks.Tables.CombiTable1D temperature_to_heat(
    tableOnFile=false,
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    table=temp)                     annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={46,0})));
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
  connect(temperature_to_heat.u[1], outside_temperature) annotation (Line(
        points={{58,0},{62,0},{106,0},{106,0}}, color={0,0,127}));
  connect(gain.u, temperature_to_heat.y[1])
    annotation (Line(points={{14,0},{35,0},{35,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5),
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
          extent={{-98,-12},{-60,-24}},
          lineColor={238,46,47},
          lineThickness=0.5,
          textString="heat flow",
          fontSize=14),
        Text(
          extent={{60,-12},{98,-24}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fontSize=14,
          textString="outside temperature"),
        Text(
          extent={{-94,76},{-40,64}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fontSize=14,
          textString="heat demand"),
        Text(
          extent={{-68,-84},{74,-94}},
          lineColor={0,0,0},
          textString="temperature dependend"),
        Text(
          extent={{-58,-108},{60,-134}},
          lineColor={28,108,200},
          textString="%name")}),
                          Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This is the model of a consumer with temperature dependence. </p>
<p>The heat demand is a linear function of the outside temperature. </p>
<p>The parameter Qlow is the heat demand at the temperature tlow.</p>
<p><span style=\"font-family: MS Shell Dlg 2;\">The parameter Qhigh is the heat demand at the temperature thigh.</span></p>
<p><img src=\"modelica://DistrictHeating/Resources/Images/heat_demand_temperature.png\"/></p>
</html>"));
end ConsumerTempDepend;
