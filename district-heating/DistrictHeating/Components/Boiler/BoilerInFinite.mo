within DistrictHeating.Components.Boiler;
model BoilerInFinite
  "Heat source which can choose finite or infinite heat flow"
  //Source bitmap: https://pixabay.com/de/feuer-gelb-flamme-rot-brennen-30276/

parameter Boolean limited_heat=false "Use limited heat flow of the boiler";
parameter Modelica.SIunits.HeatFlowRate Qmax(start=1000, fixed=true)
    "maximal thermal heat flow rate of the boiler"
annotation (Dialog(enable= limited_heat));
Modelica.SIunits.HeatFlowRate HeatFlowRate;
Modelica.SIunits.Heat Heat;
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{-4,-10},{16,10}})));
  Modelica.Blocks.Interfaces.RealInput nominal_heat
    "specification of the heat flow"
    annotation (Placement(transformation(extent={{-124,-20},{-84,20}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b thermal_heat_flow
    "thermal heat flow output"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Continuous.Integrator heat_counter(y_start=0, k=1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={50,-36})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={50,0})));
  Modelica.Blocks.Nonlinear.Limiter limiter(             uMin=0, uMax=Qmax)
    annotation (Placement(transformation(extent={{-72,34},{-52,54}})));
  Modelica.Blocks.Logical.Switch switch
    annotation (Placement(transformation(extent={{-34,-10},{-14,10}})));
  Modelica.Blocks.Sources.BooleanConstant limitedHeat(k=limited_heat)
    annotation (Placement(transformation(extent={{-72,-10},{-52,10}})));
equation

  HeatFlowRate=heatFlowSensor.Q_flow;
Heat=heat_counter.y;

  connect(prescribedHeatFlow.port, heatFlowSensor.port_a)
    annotation (Line(points={{16,0},{16,0},{40,0}}, color={191,0,0}));
  connect(thermal_heat_flow, heatFlowSensor.port_b)
    annotation (Line(points={{100,0},{80,0},{60,0}}, color={191,0,0}));
  connect(prescribedHeatFlow.Q_flow, switch.y)
    annotation (Line(points={{-4,0},{-8,0},{-13,0}}, color={0,0,127}));
  connect(nominal_heat, limiter.u) annotation (Line(points={{-104,0},{-104,0},{-80,
          0},{-80,44},{-74,44}}, color={0,0,127}));
  connect(heatFlowSensor.Q_flow, heat_counter.u)
    annotation (Line(points={{50,-10},{50,-24},{50,-24}}, color={0,0,127}));
  connect(limiter.y, switch.u1) annotation (Line(points={{-51,44},{-46,44},{-46,
          8},{-36,8}}, color={0,0,127}));
  connect(switch.u2, limitedHeat.y)
    annotation (Line(points={{-36,0},{-44,0},{-51,0}}, color={255,0,255}));
  connect(switch.u3, limiter.u) annotation (Line(points={{-36,-8},{-46,-8},{-46,
          -24},{-80,-24},{-80,44},{-74,44}}, color={0,0,127}));
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
        Bitmap(extent={{-50,-38},{54,44}}, fileName=
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
          extent={{-32,88},{36,78}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fontSize=16,
          textString="heat flow counter"),
        Text(
          extent={{-94,-108},{106,-142}},
          lineColor={28,108,200},
          textString="%name")}),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This model of a boiler needs a real input for his nomial heat. </p>
<p>The output is a heat flow.</p>
<p>If the Boolean parameter limited_heat is false, the boiler has infinite heat flow. </p>
<p>If the Boolean parameter limited_heat is true, the boiler has a maximal heat flow. Higher nominal inputs are limited at maximal heat flow. </p>
<p>Additionally the model has a counter for the heat flow (integrator). </p>
</html>"));
end BoilerInFinite;
