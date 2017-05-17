within ;
package boiler_V1
  model boiler_1

  //Source bitmap: https://pixabay.com/de/feuer-gelb-flamme-rot-brennen-30276/

    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
      annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
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
  equation

    connect(nominal_heat, prescribedHeatFlow.Q_flow)
      annotation (Line(points={{-104,0},{-104,0},{-8,0}}, color={0,0,127}));
    connect(prescribedHeatFlow.port, heatFlowSensor.port_a)
      annotation (Line(points={{12,0},{26,0},{40,0}}, color={191,0,0}));
    connect(thermal_heat_flow, heatFlowSensor.port_b)
      annotation (Line(points={{100,0},{80,0},{60,0}}, color={191,0,0}));
    connect(heat_flow_counter_output, heat_flow_counter.y)
      annotation (Line(points={{0,104},{0,71},{0,71}}, color={0,0,127}));
    connect(heatFlowSensor.Q_flow, heat_flow_counter.u) annotation (Line(points={{
            50,-10},{50,-22},{24,-22},{24,26},{0,26},{0,48}}, color={0,0,127}));
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
          Bitmap(extent={{-50,-38},{54,44}}, fileName="modelica://boiler/fire-30276_960_720.png"),
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
<p>The output is a heat flow. </p>
<p>Additionally the model has a counter for the heat flow (integrator). </p>
<p><br>Version: 1.0.0</p>
</html>"));
  end boiler_1;

  model boiler_1_test

    extends Modelica.Icons.Example;

    boiler_1 boiler_1_1
      annotation (Placement(transformation(extent={{-36,-46},{-16,-26}})));
    Modelica.Blocks.Sources.Step step(
      height=2000,
      offset=0,
      startTime=5)
      annotation (Placement(transformation(extent={{-90,-46},{-70,-26}})));
    Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={10,-36})));
    Modelica.Blocks.Continuous.Integrator integrator
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=90,
          origin={10,36})));
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
      annotation (Placement(transformation(extent={{0,60},{20,80}})));
  equation
    connect(boiler_1_1.nominal_heat, step.y)
      annotation (Line(points={{-36.4,-36},{-48,-36},{-56,-36},{-69,-36}},
                                                   color={0,0,127}));
    connect(boiler_1_1.thermal_heat_flow, heatFlowSensor.port_b) annotation (Line(
          points={{-16,-36},{0,-36}},              color={191,0,0}));
    connect(heatFlowSensor.port_a, thermalResistor.port_a)
      annotation (Line(points={{20,-36},{26,-36},{32,-36}},
                                                      color={191,0,0}));
    connect(thermalResistor.port_b, fixedTemperature.port)
      annotation (Line(points={{52,-36},{62,-36},{72,-36}},
                                                      color={191,0,0}));
    connect(heatFlowSensor.Q_flow, gain.u)
      annotation (Line(points={{10,-26},{10,-26},{10,-12}}, color={0,0,127}));
    connect(gain.y, integrator.u)
      annotation (Line(points={{10,11},{10,11},{10,24}}, color={0,0,127}));
    connect(integrator.y, feedback.u2)
      annotation (Line(points={{10,47},{10,62},{10,62}}, color={0,0,127}));
    connect(boiler_1_1.heat_flow_counter_output, feedback.u1)
      annotation (Line(points={{-26,-25.6},{-26,70},{2,70}}, color={0,0,127}));
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

  model boiler_2_1

  parameter Modelica.SIunits.Temperature TReturn=40 "water return temperature";
  parameter Modelica.SIunits.Mass mWater=3
      "water mass in pipes, boilers and houses";

    Modelica.Thermal.FluidHeatFlow.Components.HeatedPipe heatedPipe(
      frictionLoss=0,
      h_g=0,
      V_flowLaminar=0.1,
      V_flowNominal=1,
      medium=water,
      m=mWater,
      T0=TReturn,
      dpLaminar=10000,
      dpNominal=100000)
             annotation (Placement(transformation(extent={{0,50},{20,70}})));
    Modelica.Thermal.FluidHeatFlow.Sources.VolumeFlow volumeFlow(
        useVolumeFlowInput=true,
        constantVolumeFlow( start=10E-5),
      medium=water,
      T0=TReturn,
      m=10e-10)                                                  annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-32,-42})));
    Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a forward_flow(medium=
          water)
      annotation (Placement(transformation(extent={{90,50},{110,70}})));
    Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b return_flow(medium=water)
      annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
      annotation (Placement(transformation(extent={{-22,-10},{-2,10}})));
    Modelica.Blocks.Interfaces.RealInput nominal_heat
      annotation (Placement(transformation(extent={{-126,-20},{-86,20}})));
    Modelica.Blocks.Math.Gain gain(k=1/(995.6*4177*40))
      annotation (Placement(transformation(extent={{-72,-52},{-52,-32}})));
    Modelica.Blocks.Routing.RealPassThrough realPassThrough
      annotation (Placement(transformation(extent={{-62,-10},{-42,10}})));
    Modelica.Thermal.FluidHeatFlow.Media.Water water
      annotation (Placement(transformation(extent={{50,-8},{70,12}})));
  equation
    connect(volumeFlow.flowPort_b, heatedPipe.flowPort_a) annotation (Line(points={{-32,-32},
            {-32,-32},{-32,16},{-32,60},{0,60}},           color={255,0,0}));
    connect(heatedPipe.flowPort_b, forward_flow)
      annotation (Line(points={{20,60},{60,60},{100,60}}, color={255,0,0}));
    connect(prescribedHeatFlow.port, heatedPipe.heatPort)
      annotation (Line(points={{-2,0},{-2,0},{10,0},{10,50}},  color={191,0,0}));
    connect(volumeFlow.volumeFlow, gain.y)
      annotation (Line(points={{-42,-42},{-51,-42}}, color={0,0,127}));
    connect(realPassThrough.u, nominal_heat)
      annotation (Line(points={{-64,0},{-92,0},{-106,0}},  color={0,0,127}));
    connect(realPassThrough.y, prescribedHeatFlow.Q_flow)
      annotation (Line(points={{-41,0},{-41,0},{-22,0}}, color={0,0,127}));
    connect(gain.u, nominal_heat) annotation (Line(points={{-74,-42},{-80,-42},
            {-80,0},{-106,0}}, color={0,0,127}));
    connect(return_flow, volumeFlow.flowPort_a) annotation (Line(points={{100,-60},
            {80,-60},{-32,-60},{-32,-52}}, color={255,0,0}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={28,108,200},
            lineThickness=0.5), Text(
            extent={{-66,22},{66,-24}},
            lineColor={28,108,200},
            lineThickness=0.5,
            fontSize=48,
            textString="boiler 2_1")}),                            Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end boiler_2_1;

  model boiler_2_1_test

    extends Modelica.Icons.Example;

    Modelica.Blocks.Sources.Step step(
      height=2000,
      offset=0,
      startTime=5)
      annotation (Placement(transformation(extent={{-90,-46},{-70,-26}})));
    Modelica.Thermal.FluidHeatFlow.Sources.Ambient Forward(medium=
          water,
      constantAmbientPressure=100000,
      constantAmbientTemperature=313.15)
      annotation (Placement(transformation(extent={{74,-20},{94,0}})));
    Modelica.Thermal.FluidHeatFlow.Sources.Ambient Return(
      usePressureInput=false,
      medium=water,
      constantAmbientPressure=100000,
      constantAmbientTemperature=313.15)
      annotation (Placement(transformation(extent={{72,-70},{92,-50}})));
    boiler_2_1 boiler_2_1_1(mWater=3, TReturn=313.15)
      annotation (Placement(transformation(extent={{-46,-46},{-26,-26}})));
    Modelica.Blocks.Continuous.Integrator integrator
      annotation (Placement(transformation(extent={{-46,68},{-26,88}})));
    Modelica.Thermal.FluidHeatFlow.Sensors.RelTemperatureSensor
      relTemperatureSensor(medium=water)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={16,-36})));
    Modelica.Thermal.FluidHeatFlow.Sensors.MassFlowSensor massFlowSensor(medium=
          water)
      annotation (Placement(transformation(extent={{36,-20},{56,0}})));
    Modelica.Thermal.FluidHeatFlow.Media.Water water
      annotation (Placement(transformation(extent={{54,-40},{74,-20}})));
    Modelica.Blocks.Math.Product product annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,22})));
    Modelica.Blocks.Math.Gain gain(k=water.cp) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={28,40})));
    Modelica.Blocks.Math.Feedback feedback
      annotation (Placement(transformation(extent={{74,68},{94,88}})));
    Modelica.Blocks.Continuous.Integrator integrator1
      annotation (Placement(transformation(extent={{48,30},{68,50}})));
  equation
    connect(boiler_2_1_1.nominal_heat, step.y)
      annotation (Line(points={{-46.6,-36},{-54,-36},{-60,-36},{-69,-36}},
                                                       color={0,0,127}));
    connect(boiler_2_1_1.return_flow, Return.flowPort) annotation (Line(points={{-26,-42},
            {2,-42},{2,-60},{72,-60}},      color={255,0,0}));
    connect(integrator.u, step.y) annotation (Line(points={{-48,78},{-58,78},{
            -58,-36},{-69,-36}},
                             color={0,0,127}));
    connect(Forward.flowPort, massFlowSensor.flowPort_b)
      annotation (Line(points={{74,-10},{65,-10},{56,-10}}, color={255,0,0}));
    connect(boiler_2_1_1.forward_flow, massFlowSensor.flowPort_a) annotation (
        Line(points={{-26,-30},{-14,-30},{2,-30},{2,-10},{36,-10}}, color={255,0,0}));
    connect(relTemperatureSensor.flowPort_b, Return.flowPort)
      annotation (Line(points={{16,-46},{16,-60},{72,-60}}, color={255,0,0}));
    connect(relTemperatureSensor.flowPort_a, massFlowSensor.flowPort_a)
      annotation (Line(points={{16,-26},{16,-10},{36,-10}}, color={255,0,0}));
    connect(massFlowSensor.y, product.u2) annotation (Line(points={{46,-21},{46,
            -21},{46,-26},{24,-26},{24,2},{6,2},{6,10}}, color={0,0,127}));
    connect(relTemperatureSensor.y, product.u1)
      annotation (Line(points={{5,-36},{-6,-36},{-6,10}}, color={0,0,127}));
    connect(feedback.u1, integrator.y)
      annotation (Line(points={{76,78},{12,78},{-25,78}}, color={0,0,127}));
    connect(gain.y, integrator1.u)
      annotation (Line(points={{39,40},{42,40},{46,40}}, color={0,0,127}));
    connect(product.y, gain.u) annotation (Line(points={{0,33},{0,33},{0,40},{
            16,40}}, color={0,0,127}));
    connect(integrator1.y, feedback.u2)
      annotation (Line(points={{69,40},{84,40},{84,70}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      Documentation(info="<html>
<p>Test for boiler_1-model.</p>
<p>Most important thing is the comparison between the heat flow counter within the model boiler and the outer counter (heat flow sensor). </p>
<p>The gain is used for the right sign in the integrator. </p>
</html>"),
      experiment(StopTime=10),
      __Dymola_experimentSetupOutput);
  end boiler_2_1_test;

  model boiler_2_2

    Modelica.Thermal.FluidHeatFlow.Components.HeatedPipe heatedPipe(
      V_flowLaminar=0.1,
      V_flowNominal=1,
      frictionLoss=0,
      h_g=0,
      m=1,
      dpLaminar=10000,
      dpNominal=100000)
             annotation (Placement(transformation(extent={{0,50},{20,70}})));
    Modelica.Thermal.FluidHeatFlow.Sources.VolumeFlow volumeFlow(
        constantVolumeFlow=1, useVolumeFlowInput=true,
      medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
      m=1)                                                   annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-32,-42})));
    Modelica.Thermal.FluidHeatFlow.Components.IsolatedPipe isolatedPipe(
      V_flowLaminar=0.1,
      V_flowNominal=1,
      frictionLoss=0,
      h_g=0,
      m=1,
      dpLaminar=10000,
      dpNominal=100000)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={10,-60})));
    Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a forward_flow
      annotation (Placement(transformation(extent={{90,50},{110,70}})));
    Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b return_flow
      annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
      annotation (Placement(transformation(extent={{-22,-10},{-2,10}})));
    Modelica.Blocks.Interfaces.RealInput nominal_heat
      annotation (Placement(transformation(extent={{-126,-20},{-86,20}})));
    Modelica.Blocks.Continuous.Integrator integrator annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-50,36})));
    Modelica.Blocks.Continuous.Der der1 annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-80,36})));
    Modelica.Blocks.Math.Gain gain(k=1/(995.6*4177*40))
                                   annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-80,-26})));
  equation
    connect(volumeFlow.flowPort_b, heatedPipe.flowPort_a) annotation (Line(points={{-32,-32},
            {-32,-32},{-32,16},{-32,60},{0,60}},           color={255,0,0}));
    connect(heatedPipe.flowPort_b, forward_flow)
      annotation (Line(points={{20,60},{60,60},{100,60}}, color={255,0,0}));
    connect(isolatedPipe.flowPort_b, volumeFlow.flowPort_a) annotation (Line(
          points={{0,-60},{-18,-60},{-32,-60},{-32,-52}}, color={255,0,0}));
    connect(return_flow, isolatedPipe.flowPort_a)
      annotation (Line(points={{100,-60},{60,-60},{20,-60}}, color={255,0,0}));
    connect(prescribedHeatFlow.port, heatedPipe.heatPort)
      annotation (Line(points={{-2,0},{-2,0},{10,0},{10,50}},  color={191,0,0}));
    connect(prescribedHeatFlow.Q_flow, nominal_heat)
      annotation (Line(points={{-22,0},{-106,0}}, color={0,0,127}));
    connect(integrator.u, nominal_heat)
      annotation (Line(points={{-50,24},{-50,0},{-106,0}}, color={0,0,127}));
    connect(volumeFlow.volumeFlow, gain.y) annotation (Line(points={{-42,-42},{-60,
            -42},{-80,-42},{-80,-37}}, color={0,0,127}));
    connect(gain.u, der1.y)
      annotation (Line(points={{-80,-14},{-80,25}},          color={0,0,127}));
    connect(der1.u, integrator.y) annotation (Line(points={{-80,48},{-80,56},{-50,
            56},{-50,47}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={28,108,200},
            lineThickness=0.5), Text(
            extent={{-76,20},{74,-20}},
            lineColor={28,108,200},
            lineThickness=0.5,
            fontSize=48,
            textString="boiler 2_2")}),                            Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end boiler_2_2;

  model boiler_2_3

   parameter Modelica.SIunits.Temperature TAmb(displayUnit="degC")=293.15
      "Ambient temperature";
   parameter Modelica.SIunits.Power convP(displayUnit="W")=1
      "Unit conversion factor Power";
   parameter Modelica.SIunits.VolumeFlowRate convV(displayUnit="m^3/s")=1
      "Unit conversion factor Volume";

    Modelica.Thermal.FluidHeatFlow.Components.HeatedPipe heatedPipe(
      m=0,
      V_flowLaminar=0.1,
      dpLaminar=10000,
      V_flowNominal=1,
      dpNominal=100000,
      frictionLoss=0,
      h_g=0) annotation (Placement(transformation(extent={{0,50},{20,70}})));
    Modelica.Thermal.FluidHeatFlow.Sources.VolumeFlow volumeFlow(
        constantVolumeFlow=1, useVolumeFlowInput=false)      annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-32,-42})));
    Modelica.Thermal.FluidHeatFlow.Components.IsolatedPipe isolatedPipe(
      m=0,
      V_flowLaminar=0.1,
      dpLaminar=10000,
      V_flowNominal=1,
      dpNominal=100000,
      frictionLoss=0,
      h_g=0)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={10,-60})));
    Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a forward_flow
      annotation (Placement(transformation(extent={{90,50},{110,70}})));
    Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b return_flow
      annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow(T_ref=
          TAmb)
      annotation (Placement(transformation(extent={{-22,-10},{-2,10}})));
    Modelica.Blocks.Interfaces.RealInput nominal_heat
      annotation (Placement(transformation(extent={{-126,-20},{-86,20}})));
  equation
    connect(volumeFlow.flowPort_b, heatedPipe.flowPort_a) annotation (Line(points={{-32,-32},
            {-32,-32},{-32,16},{-32,60},{0,60}},           color={255,0,0}));
    connect(heatedPipe.flowPort_b, forward_flow)
      annotation (Line(points={{20,60},{60,60},{100,60}}, color={255,0,0}));
    connect(isolatedPipe.flowPort_b, volumeFlow.flowPort_a) annotation (Line(
          points={{0,-60},{-18,-60},{-32,-60},{-32,-52}}, color={255,0,0}));
    connect(return_flow, isolatedPipe.flowPort_a)
      annotation (Line(points={{100,-60},{60,-60},{20,-60}}, color={255,0,0}));
    connect(prescribedHeatFlow.port, heatedPipe.heatPort)
      annotation (Line(points={{-2,0},{-2,0},{10,0},{10,50}},  color={191,0,0}));
    connect(prescribedHeatFlow.Q_flow, nominal_heat)
      annotation (Line(points={{-22,0},{-106,0}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end boiler_2_3;
  annotation (uses(Modelica(version="3.2.1")));
end boiler_V1;
