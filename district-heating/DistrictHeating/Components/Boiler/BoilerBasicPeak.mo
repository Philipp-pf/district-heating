within DistrictHeating.Components.Boiler;
model BoilerBasicPeak "Boiler which divides into basic and peak load"
  //Source bitmap: https://pixabay.com/de/feuer-gelb-flamme-rot-brennen-30276/

parameter Modelica.SIunits.HeatFlowRate Qbase "maximal basic load power";
parameter Modelica.SIunits.HeatFlowRate Qpeak "maximal peak load power";
Modelica.SIunits.HeatFlowRate HeatFlowBase;
Modelica.SIunits.HeatFlowRate HeatFlowPeak;
Modelica.SIunits.HeatFlowRate HeatFlow;
Modelica.SIunits.Heat HeatBase;
Modelica.SIunits.Heat HeatPeak;
Modelica.SIunits.Heat Heat;
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow base_boiler
    annotation (Placement(transformation(extent={{-6,-10},{14,10}})));
  Modelica.Blocks.Interfaces.RealInput nominal_heat
    "specification of the heat flow"
    annotation (Placement(transformation(extent={{-124,-20},{-84,20}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b thermal_heat_flow
    "thermal heat flow output"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Continuous.Integrator heat_flow_counter_base(y_start=0, k=1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={34,-62})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={34,0})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=Qbase, uMin=0)
    annotation (Placement(transformation(extent={{-68,-10},{-48,10}})));
  Modelica.Blocks.Math.Feedback feedback annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-56,-32})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow peak_boiler
    annotation (Placement(transformation(extent={{-2,-42},{18,-22}})));
  Modelica.Blocks.Nonlinear.Limiter limiter1(uMax=Qpeak, uMin=0)
    annotation (Placement(transformation(extent={{-34,-42},{-14,-22}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor1
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={66,-32})));
  Modelica.Blocks.Continuous.Integrator heat_flow_counter_peak(y_start=0, k=1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={66,-62})));
equation

HeatFlowBase=heatFlowSensor.Q_flow;
HeatFlowPeak=heatFlowSensor1.Q_flow;
HeatFlow=HeatFlowBase+HeatFlowPeak;
HeatBase=heat_flow_counter_base.y;
HeatPeak=heat_flow_counter_peak.y;
Heat=HeatBase+HeatPeak;
  connect(base_boiler.port, heatFlowSensor.port_a)
    annotation (Line(points={{14,0},{14,0},{24,0}}, color={191,0,0}));
  connect(thermal_heat_flow, heatFlowSensor.port_b)
    annotation (Line(points={{100,0},{44,0}},        color={191,0,0}));
  connect(limiter.u, nominal_heat)
    annotation (Line(points={{-70,0},{-70,0},{-104,0}}, color={0,0,127}));
  connect(base_boiler.Q_flow, limiter.y)
    annotation (Line(points={{-6,0},{-28,0},{-47,0}}, color={0,0,127}));
  connect(feedback.u1, nominal_heat) annotation (Line(points={{-64,-32},{
          -78,-32},{-78,0},{-104,0}},
                                  color={0,0,127}));
  connect(feedback.u2, limiter.y) annotation (Line(points={{-56,-40},{-56,
          -56},{-42,-56},{-42,0},{-47,0}},
                                      color={0,0,127}));
  connect(limiter1.u, feedback.y)
    annotation (Line(points={{-36,-32},{-42,-32},{-47,-32}},
                                                   color={0,0,127}));
  connect(peak_boiler.Q_flow, limiter1.y)
    annotation (Line(points={{-2,-32},{-8,-32},{-13,-32}},
                                                  color={0,0,127}));
  connect(peak_boiler.port, heatFlowSensor1.port_a)
    annotation (Line(points={{18,-32},{56,-32}},          color={191,0,0}));
  connect(heatFlowSensor1.port_b, heatFlowSensor.port_b) annotation (Line(
        points={{76,-32},{90,-32},{90,0},{44,0}}, color={191,0,0}));
  connect(heat_flow_counter_peak.u, heatFlowSensor1.Q_flow)
    annotation (Line(points={{66,-50},{66,-46},{66,-42}},
                                                 color={0,0,127}));
  connect(heat_flow_counter_base.u, heatFlowSensor.Q_flow)
    annotation (Line(points={{34,-50},{34,-50},{34,-10}}, color={0,0,127}));
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
        Bitmap(extent={{-48,-36},{8,14}}, fileName=
              "modelica://DistrictHeating/Resources/Images/fire-30276_960_720.png"),
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
        Bitmap(extent={{-4,-36},{52,14}}, fileName=
              "modelica://DistrictHeating/Resources/Images/fire-30276_960_720.png"),
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
          textString="peak"),
        Text(
          extent={{-82,-106},{88,-138}},
          lineColor={28,108,200},
          textString="%name")}),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This model of a boiler needs a real input for his nomial heat. </p>
<p>The output is a heat flow. </p>
<p>Additionally the model has a counter for the heat flow (integrator). </p>
<p>The real input &QUOT;nominal heat&QUOT; is divided into to parts: A basic load and a peak load. </p>
<p>The basic load boiler handles the base load. If the nominal heat rises above the maximal heat output of the base load boiler, the peak load boiler gets activated. </p>
<p>The maximal heat output is the sum of the maximal heat of base load and peak load boiler. </p>
<p><img src=\"modelica://DistrictHeating/Resources/Images/base_peak.png\"/></p>
</html>"));
end BoilerBasicPeak;
