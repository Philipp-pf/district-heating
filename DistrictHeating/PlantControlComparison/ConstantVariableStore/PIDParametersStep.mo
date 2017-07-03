within DistrictHeating.PlantControlComparison.ConstantVariableStore;
model PIDParametersStep
  DistrictHeating.Components.Consumers.ConsumerTimeDependExt
    consumerTimeDependExt
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Thermal.FluidHeatFlow.Media.Water water
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  DistrictHeating.Components.Storage.StorageInfinite Store(
    der_T=0,
    C=137*water.rho*water.cp,
  G=1158,
  Tstart(displayUnit="degC") = 313.15,
  Tref=313.15)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
Modelica.Blocks.Sources.Constant ConstantOutsidetemperature(k=273.15 + 11.11)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-30})));
Modelica.Blocks.Sources.Step BoilerStep(
    startTime(displayUnit="h") = 7200,
    height=1966546,
    offset=33454)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
Modelica.Blocks.Sources.Step ConsumerStep(
    height=1900000,
    offset=0,
    startTime(displayUnit="h") = 7200) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,0})));
DistrictHeating.Components.Boiler.BoilerInFinite boilerInFinite(limited_heat=
      false, TimeFirstOrder=0.001)
  annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
Modelica.Blocks.Continuous.Derivative Slope(
    k=1,
    T=1,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    x_start=0) annotation (Placement(transformation(extent={{20,40},{40,60}})));
equation
connect(Store.heat_output, consumerTimeDependExt.heat_flow)
  annotation (Line(points={{10,0},{10,0},{40,0}}, color={191,0,0}));
  connect(Store.outside_temp, ConstantOutsidetemperature.y)
    annotation (Line(points={{0,-10.4},{0,-10.4},{0,-19}}, color={0,0,127}));
  connect(consumerTimeDependExt.positive_heat_flow, ConsumerStep.y) annotation (
     Line(points={{60.6,0},{79,0},{79,1.33227e-015}}, color={0,0,127}));
  connect(BoilerStep.y, boilerInFinite.nominal_heat)
    annotation (Line(points={{-79,0},{-60.4,0}}, color={0,0,127}));
connect(Store.heat_input, boilerInFinite.thermal_heat_flow)
  annotation (Line(points={{-10,0},{-26,0},{-40,0}}, color={191,0,0}));
  connect(Store.store_temp, Slope.u)
    annotation (Line(points={{0,10.4},{0,50},{18,50}}, color={0,0,127}));
annotation (
  Icon(coordinateSystem(preserveAspectRatio=false)),
  Diagram(coordinateSystem(preserveAspectRatio=false)),
  experiment(StopTime=5.2e+006, Interval=60),
  __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">This model uses an step to get the parameters for an PI-Control. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">The two parameter were determined by the Simulation diagramms. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Parameter ks is determined by the quotient of temperature difference in the storage and boiler heat difference. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Parameter Ts equals the time difference between start time of the ramp and the crossing of  the tangent for the store temperature at the beginning of the step and the end temperature. </span></p>
</html>"));
end PIDParametersStep;
