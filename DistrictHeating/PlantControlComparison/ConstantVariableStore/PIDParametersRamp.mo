within DistrictHeating.PlantControlComparison.ConstantVariableStore;
model PIDParametersRamp
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
Modelica.Blocks.Sources.Constant AverageOutsideTemperature(k=273.15 + 11.11)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-30})));
Modelica.Blocks.Sources.Ramp BoilerRamp(
    startTime(displayUnit="h") = 7200,
    duration(displayUnit="h") = 86400,
    height=1966546,
    offset=33454)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
Modelica.Blocks.Sources.Ramp ConsumerRamp(
    height=1900000,
    offset=0,
    startTime(displayUnit="h") = 7200,
    duration(displayUnit="h") = 86400) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,0})));
DistrictHeating.Components.Boiler.BoilerInFinite boilerInFinite(limited_heat=
      false, TimeFirstOrder=0.001,
    PartLoad=0)
  annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
Modelica.Blocks.Continuous.Derivative Slope(
    k=1,
    T=1,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    x_start=0) annotation (Placement(transformation(extent={{20,40},{40,60}})));
Modelica.Blocks.Continuous.Derivative curvature(
    k=1,
    T=1,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    x_start=0) annotation (Placement(transformation(extent={{60,40},{80,60}})));
equation
connect(Store.heat_output, consumerTimeDependExt.heat_flow)
  annotation (Line(points={{10,0},{26,0},{40,0}}, color={191,0,0}));
  connect(Store.outside_temp, AverageOutsideTemperature.y)
    annotation (Line(points={{0,-10.4},{0,-10.4},{0,-19}}, color={0,0,127}));
  connect(consumerTimeDependExt.positive_heat_flow, ConsumerRamp.y) annotation (
     Line(points={{60.6,0},{79,0},{79,1.33227e-015}}, color={0,0,127}));
  connect(BoilerRamp.y, boilerInFinite.nominal_heat)
    annotation (Line(points={{-79,0},{-60.4,0}}, color={0,0,127}));
connect(Store.heat_input, boilerInFinite.thermal_heat_flow)
  annotation (Line(points={{-10,0},{-40,0}}, color={191,0,0}));
  connect(Store.store_temp, Slope.u)
    annotation (Line(points={{0,10.4},{0,50},{18,50}}, color={0,0,127}));
  connect(Slope.y, curvature.u)
    annotation (Line(points={{41,50},{50,50},{58,50}}, color={0,0,127}));
annotation (
  Icon(coordinateSystem(preserveAspectRatio=false)),
  Diagram(coordinateSystem(preserveAspectRatio=false)),
  experiment(StopTime=5.2e+006, Interval=60),
  __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p>This model uses an ramp to get the parameters for an PID-Control. </p>
<p>This three parameters are determined by the method of Chien/Hornes/Reswick. </p>
<p>The following diagramme shows exemplary the temperature graph of the storage. </p>
<p><img src=\"modelica://DistrictHeating/Resources/Images/320px-Tutg.svg.png\"/></p>
<p>(source: https://de.wikipedia.org/wiki/Systemidentifikation#/media/File:Tutg.svg)</p>
<p>Parameter Tu and Tg are shown in the diagramm. Parameter three (ks) is determined by the quotient of temperature difference in the storage and boiler heat difference. </p>
</html>"));
end PIDParametersRamp;
