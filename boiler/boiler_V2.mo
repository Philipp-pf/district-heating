within ;
package boiler_V2
  model boiler_1
    //Source bitmap: https://pixabay.com/de/feuer-gelb-flamme-rot-brennen-30276/

  parameter Boolean limited_heat=false "Use limited heat flow of the boiler";
  parameter Modelica.SIunits.Power Qmax(start=1000, fixed=true)
      "maximal thermal flow of the boiler"
  annotation (Dialog(enable= limited_heat));

    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
      annotation (Placement(transformation(extent={{-4,-10},{16,10}})));
    Modelica.Blocks.Interfaces.RealInput nominal_heat
      "specification of the heat flow"
      annotation (Placement(transformation(extent={{-124,-20},{-84,20}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b thermal_heat_flow
      "thermal heat flow output"
      annotation (Placement(transformation(extent={{90,-10},{110,10}})));
    Modelica.Blocks.Continuous.Integrator heat_flow_counter(y_start=0, k=1)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,60})));
    Modelica.Blocks.Interfaces.RealOutput heat_flow_counter_output
      "integrated heat flow"                                                              annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,104})));
    Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={50,0})));
    Modelica.Blocks.Nonlinear.Limiter limiter(             uMin=0, uMax=Qmax)
      annotation (Placement(transformation(extent={{-72,24},{-52,44}})));
    Modelica.Blocks.Logical.Switch switch1
      annotation (Placement(transformation(extent={{-34,-10},{-14,10}})));
    Modelica.Blocks.Sources.BooleanConstant booleanConstant(k=limited_heat)
      annotation (Placement(transformation(extent={{-92,-68},{-72,-48}})));
  equation

  //if limited_heat=false then

    connect(prescribedHeatFlow.port, heatFlowSensor.port_a)
      annotation (Line(points={{16,0},{16,0},{40,0}}, color={191,0,0}));
    connect(thermal_heat_flow, heatFlowSensor.port_b)
      annotation (Line(points={{100,0},{80,0},{60,0}}, color={191,0,0}));
    connect(heat_flow_counter_output, heat_flow_counter.y)
      annotation (Line(points={{0,104},{0,71},{0,71}}, color={0,0,127}));
    connect(heatFlowSensor.Q_flow, heat_flow_counter.u) annotation (Line(points={{
            50,-10},{50,-22},{24,-22},{24,26},{0,26},{0,48}}, color={0,0,127}));
    connect(prescribedHeatFlow.Q_flow, switch1.y)
      annotation (Line(points={{-4,0},{-8,0},{-13,0}}, color={0,0,127}));
    connect(switch1.u2, booleanConstant.y) annotation (Line(points={{-36,0},{-46,0},
            {-56,0},{-56,-58},{-71,-58}},
                                        color={255,0,255}));
    connect(nominal_heat, limiter.u) annotation (Line(points={{-104,0},{-104,0},{-80,
            0},{-80,34},{-74,34}}, color={0,0,127}));
    connect(limiter.y, switch1.u1) annotation (Line(points={{-51,34},{-46,34},{-44,
            34},{-44,8},{-36,8}}, color={0,0,127}));
    connect(switch1.u3, nominal_heat)
      annotation (Line(points={{-36,-8},{-104,-8},{-104,0}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            lineThickness=0.5),
          Rectangle(
            extent={{-40,60},{40,-40}},
            lineColor={0,0,0},
            lineThickness=0.5),
          Text(
            extent={{-50,-96},{52,-48}},
            lineColor={0,0,0},
            lineThickness=0.5,
            textString="boiler"),
          Bitmap(extent={{-50,-38},{54,44}}, fileName="modelica://boiler_V2/fire-30276_960_720.png"),
          Text(
            extent={{-92,-12},{-48,-22}},
            lineColor={28,108,200},
            lineThickness=0.5,
            fontSize=16,
            textString="nominal heat"),
          Text(
            extent={{52,-12},{90,-22}},
            lineColor={238,46,47},
            lineThickness=0.5,
            textString="heat flow",
            fontSize=16),
          Text(
            extent={{-32,88},{36,78}},
            lineColor={0,0,0},
            lineThickness=0.5,
            fontSize=16,
            textString="heat flow counter")}),                     Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      Documentation(info="<html>
<p>This model of a boiler needs a real input for his nomial heat. </p>
<p>The output is a heat flow.</p>
<p>If the Boolean parameter limited_heat is false, the boiler has infinite heat flow. </p>
<p>If the Boolean parameter limited_heat is true, the boiler has a maximal heat flow. Higher nominal inputs are limited at maximal heat flow. </p>
<p>Additionally the model has a counter for the heat flow (integrator). </p>
<p>Version 1.1.0</p>
</html>"));
  end boiler_1;

  model boiler_1_test

    extends Modelica.Icons.Example;

    Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={10,-36})));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=273.15)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={82,-36})));
    Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResistor(R=0)
      annotation (Placement(transformation(extent={{32,-46},{52,-26}})));
    Modelica.Blocks.Math.Gain gain(k=-1)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=90,
          origin={10,0})));
    Modelica.Blocks.Math.Feedback feedback
      annotation (Placement(transformation(extent={{0,20},{20,40}})));
    Modelica.Blocks.Sources.Ramp ramp(
      duration=5,
      offset=0,
      startTime=1,
      height=20000)
      annotation (Placement(transformation(extent={{-78,-46},{-58,-26}})));
    boiler_1 boiler_1_1(limited_heat=true, Qmax(displayUnit="W") = 1000)
      annotation (Placement(transformation(extent={{-34,-46},{-14,-26}})));
  equation
    connect(heatFlowSensor.port_a, thermalResistor.port_a)
      annotation (Line(points={{20,-36},{26,-36},{32,-36}},
                                                      color={191,0,0}));
    connect(thermalResistor.port_b, fixedTemperature.port)
      annotation (Line(points={{52,-36},{62,-36},{72,-36}},
                                                      color={191,0,0}));
    connect(heatFlowSensor.Q_flow, gain.u)
      annotation (Line(points={{10,-26},{10,-26},{10,-12}}, color={0,0,127}));
    connect(gain.y, feedback.u2)
      annotation (Line(points={{10,11},{10,22}}, color={0,0,127}));
    connect(feedback.u1, ramp.y) annotation (Line(points={{2,30},{-48,30},{-48,
            -36},{-57,-36}}, color={0,0,127}));
    connect(heatFlowSensor.port_b, boiler_1_1.thermal_heat_flow)
      annotation (Line(points={{0,-36},{-14,-36}}, color={191,0,0}));
    connect(boiler_1_1.nominal_heat, ramp.y)
      annotation (Line(points={{-34.4,-36},{-57,-36}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      Documentation(info="<html>
<p>Test for boiler_1-model.</p>
<p>Most important thing is the comparison between the heat flow counter within the model boiler and the outer counter (heat flow sensor). </p>
<p>The gain is used for the right sign in the integrator. </p>
</html>"),
      experiment(StopTime=10),
      __Dymola_experimentSetupOutput);
  end boiler_1_test;

  model boiler_1_basic_peak
    //Source bitmap: https://pixabay.com/de/feuer-gelb-flamme-rot-brennen-30276/

  parameter Modelica.SIunits.Power Qbase "maximal basic load power";
  parameter Modelica.SIunits.Power Qpeak "maximal peak load power";

    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow base_boiler
      annotation (Placement(transformation(extent={{-6,-10},{14,10}})));
    Modelica.Blocks.Interfaces.RealInput nominal_heat
      "specification of the heat flow"
      annotation (Placement(transformation(extent={{-124,-20},{-84,20}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b thermal_heat_flow
      "thermal heat flow output"
      annotation (Placement(transformation(extent={{90,-10},{110,10}})));
    Modelica.Blocks.Continuous.Integrator heat_flow_counter(y_start=0, k=1)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,60})));
    Modelica.Blocks.Interfaces.RealOutput heat_flow_counter_output
      "integrated heat flow"                                                              annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,104})));
    Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={50,0})));
    Modelica.Blocks.Nonlinear.Limiter limiter(uMax=Qbase, uMin=0)
      annotation (Placement(transformation(extent={{-68,-10},{-48,10}})));
    Modelica.Blocks.Math.Feedback feedback annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-56,-40})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow peak_boiler
      annotation (Placement(transformation(extent={{-4,-50},{16,-30}})));
    Modelica.Blocks.Nonlinear.Limiter limiter1(uMax=Qpeak, uMin=0)
      annotation (Placement(transformation(extent={{-34,-50},{-14,-30}})));
  equation

    connect(base_boiler.port, heatFlowSensor.port_a)
      annotation (Line(points={{14,0},{14,0},{40,0}}, color={191,0,0}));
    connect(thermal_heat_flow, heatFlowSensor.port_b)
      annotation (Line(points={{100,0},{80,0},{60,0}}, color={191,0,0}));
    connect(heat_flow_counter_output, heat_flow_counter.y)
      annotation (Line(points={{0,104},{0,71},{0,71}}, color={0,0,127}));
    connect(heatFlowSensor.Q_flow, heat_flow_counter.u) annotation (Line(points={{
            50,-10},{50,-22},{24,-22},{24,26},{0,26},{0,48}}, color={0,0,127}));
    connect(limiter.u, nominal_heat)
      annotation (Line(points={{-70,0},{-70,0},{-104,0}}, color={0,0,127}));
    connect(base_boiler.Q_flow, limiter.y)
      annotation (Line(points={{-6,0},{-28,0},{-47,0}}, color={0,0,127}));
    connect(feedback.u1, nominal_heat) annotation (Line(points={{-64,-40},{-78,
            -40},{-78,0},{-104,0}}, color={0,0,127}));
    connect(feedback.u2, limiter.y) annotation (Line(points={{-56,-48},{-56,-56},
            {-40,-56},{-40,0},{-47,0}}, color={0,0,127}));
    connect(peak_boiler.port, heatFlowSensor.port_a) annotation (Line(points={{
            16,-40},{28,-40},{28,0},{40,0}}, color={191,0,0}));
    connect(limiter1.u, feedback.y)
      annotation (Line(points={{-36,-40},{-47,-40}}, color={0,0,127}));
    connect(peak_boiler.Q_flow, limiter1.y)
      annotation (Line(points={{-4,-40},{-13,-40}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            lineThickness=0.5),
          Rectangle(
            extent={{-40,16},{-2,-40}},
            lineColor={0,0,0},
            lineThickness=0.5),
          Text(
            extent={{-50,-96},{52,-48}},
            lineColor={0,0,0},
            lineThickness=0.5,
            textString="boiler"),
          Bitmap(extent={{-50,-36},{6,14}}, fileName="modelica://boiler_V2/fire-30276_960_720.png"),
          Text(
            extent={{-92,-12},{-48,-22}},
            lineColor={28,108,200},
            lineThickness=0.5,
            fontSize=16,
            textString="nominal heat"),
          Text(
            extent={{52,-12},{90,-22}},
            lineColor={238,46,47},
            lineThickness=0.5,
            textString="heat flow",
            fontSize=16),
          Text(
            extent={{-32,94},{36,84}},
            lineColor={0,0,0},
            lineThickness=0.5,
            fontSize=16,
            textString="heat flow counter"),
          Rectangle(
            extent={{4,16},{42,-40}},
            lineColor={0,0,0},
            lineThickness=0.5),
          Bitmap(extent={{-6,-36},{50,14}}, fileName="modelica://boiler_V2/fire-30276_960_720.png"),
          Line(
            points={{-44,84},{-44,36},{46,36}},
            color={0,0,0},
            thickness=0.5),
          Line(
            points={{-44,80},{-40,68},{-30,62},{-4,54},{18,50},{38,50},{38,36}},
            color={0,0,0},
            thickness=0.5),
          Line(
            points={{42,32},{46,36},{42,40}},
            color={0,0,0},
            thickness=0.5),
          Line(
            points={{-48,80},{-44,84},{-40,80}},
            color={0,0,0},
            thickness=0.5),
          Line(
            points={{-46,58},{42,58}},
            color={0,0,0},
            thickness=0.5,
            pattern=LinePattern.Dot),
          Text(
            extent={{-54,20},{48,68}},
            lineColor={0,0,0},
            lineThickness=0.5,
            fontSize=18,
            textString="basic"),
          Text(
            extent={{-54,46},{48,94}},
            lineColor={0,0,0},
            lineThickness=0.5,
            fontSize=18,
            textString="peak")}),                                  Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      Documentation(info="<html>
<p>This model of a boiler needs a real input for his nomial heat. </p>
<p>The output is a heat flow. </p>
<p>Additionally the model has a counter for the heat flow (integrator). </p>
<p>The real input &QUOT;nominal heat&QUOT; is divided into to parts: A basic load and a peak load. </p>
<p>The basic load boiler handles the base load. If the nominal heat rises above the maximal heat output of the base load boiler, the peak load boiler gets activated. </p>
<p>The maximal heat output is the sum of the maximal heat of base load and peak load boiler. </p>
<p><img src=\"modelica://boiler_V2/base_peak.png\"/></p>
<p><br>Version: 1.1.0</p>
</html>"));
  end boiler_1_basic_peak;

  model boiler_1_basic_peak_test

    extends Modelica.Icons.Example;

    Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={10,-36})));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=273.15)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={82,-36})));
    Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResistor(R=0)
      annotation (Placement(transformation(extent={{32,-46},{52,-26}})));
    boiler_1_basic_peak boiler_1_basic_peak1(Qbase=1500, Qpeak=400)
      annotation (Placement(transformation(extent={{-36,-46},{-16,-26}})));
    Modelica.Blocks.Sources.Ramp ramp(
      height=2000,
      duration=5,
      offset=0,
      startTime=1)
      annotation (Placement(transformation(extent={{-76,-46},{-56,-26}})));
    Modelica.Blocks.Math.Feedback feedback
      annotation (Placement(transformation(extent={{0,30},{20,50}})));
    Modelica.Blocks.Math.Gain gain(k=-1) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={10,0})));
  equation
    connect(heatFlowSensor.port_a, thermalResistor.port_a)
      annotation (Line(points={{20,-36},{26,-36},{32,-36}},
                                                      color={191,0,0}));
    connect(thermalResistor.port_b, fixedTemperature.port)
      annotation (Line(points={{52,-36},{62,-36},{72,-36}},
                                                      color={191,0,0}));
    connect(boiler_1_basic_peak1.thermal_heat_flow, heatFlowSensor.port_b)
      annotation (Line(points={{-16,-36},{-8,-36},{0,-36}}, color={191,0,0}));
    connect(ramp.y, boiler_1_basic_peak1.nominal_heat)
      annotation (Line(points={{-55,-36},{-36.4,-36}}, color={0,0,127}));
    connect(feedback.u1, boiler_1_basic_peak1.nominal_heat) annotation (Line(
          points={{2,40},{-48,40},{-48,-36},{-36.4,-36}}, color={0,0,127}));
    connect(heatFlowSensor.Q_flow, gain.u)
      annotation (Line(points={{10,-26},{10,-19},{10,-12}}, color={0,0,127}));
    connect(gain.y, feedback.u2)
      annotation (Line(points={{10,11},{10,11},{10,32}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      Documentation(info="<html>
<p>Test for boiler_1-model.</p>
<p>Most important thing is the comparison between the heat flow counter within the model boiler and the outer counter (heat flow sensor). </p>
<p>The gain is used for the right sign in the integrator. </p>
</html>"),
      experiment(StopTime=10),
      __Dymola_experimentSetupOutput);
  end boiler_1_basic_peak_test;
  annotation (uses(Modelica(version="3.2.1")));
end boiler_V2;
