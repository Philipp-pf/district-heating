within DistrictHeating.PlantControlComparison.ConstantBoilerHeatFlow;
model ConstantBoilerHeatFlow
  parameter String fileNameTemperature=Modelica.Utilities.Files.loadResource(
      "modelica://DistrictHeating/Resources/Data/Outsidetemperature_original.txt")
    "File on which data is present" annotation (Dialog(loadSelector(filter=
            "Text files (*.txt)", caption=
            "Open text file to read parameters of the form \"name = value\"")));
  parameter String fileNameNetNew=Modelica.Utilities.Files.loadResource(
      "modelica://DistrictHeating/Resources/Data/Net_original_changed.txt")
    "File on which data is present" annotation (Dialog(loadSelector(filter=
            "Text files (*.txt)", caption=
            "Open text file to read parameters of the form \"name = value\"")));

  DistrictHeating.Components.Consumers.ConsumerTimeDependExt
    consumerTimeDependExt
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Thermal.FluidHeatFlow.Media.Water water
    annotation (Placement(transformation(extent={{60,-60},{80,-40}})));
  DistrictHeating.Components.Storage.StorageInfinite Store(
    der_T=0,
    G=1158,
    Tstart(displayUnit="degC") = 323.15,
    C=137*water.cp*water.rho,
    Tref=323.15)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.CombiTimeTable Net_source(
    tableOnFile=true,
    tableName="Netzleistung",
    columns={2,3,4,5,6,7},
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    fileName=fileNameNetNew)
                          annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,0})));
  Modelica.Blocks.Sources.CombiTimeTable Outside_Temp_source(
    tableOnFile=true,
    tableName="Aussentemperatur",
    columns={2,3,4,5,6,7},
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    fileName=fileNameTemperature) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-30})));
  DistrictHeating.Components.Boiler.BoilerBasicPeak boilerBasicPeak(Qbase(
        displayUnit="kW") = 2200000, Qpeak(displayUnit="kW") = 800000,
    TimeFirstOrderBase=0.001,
    TimeFirstOrderPeak=0.001,
    PartLoadBase=0,
    PartLoadPeak=0)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Components.Control.MeanBoilerHeat
                                  meanBoilerHeat(
    preYstart=true,
    TimeConstant(displayUnit="h") = twentyFourHrs.TimeConstant,
    Tmax=363.15,
    khigh1=twentyFourHrs.khigh1,
    Thigh=353.15,
    khigh2=twentyFourHrs.khigh2,
    Tlow=323.15,
    klow2=twentyFourHrs.klow2,
    Tmin=313.15,
    klow1=twentyFourHrs.klow1)
                 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={0,50})));
  FourHrs fourHrs
    annotation (Placement(transformation(extent={{-80,80},{-60,100}})));
  EightHrs eightHrs
    annotation (Placement(transformation(extent={{-40,80},{-20,100}})));
  TwelveHrs twelveHrs
    annotation (Placement(transformation(extent={{0,80},{20,100}})));
  TwentyFourHrs twentyFourHrs
    annotation (Placement(transformation(extent={{40,80},{60,100}})));
equation
  connect(Store.outside_temp, Outside_Temp_source.y[6])
    annotation (Line(points={{0,-10.4},{0,-19}}, color={0,0,127}));
  connect(Store.heat_output, consumerTimeDependExt.heat_flow)
    annotation (Line(points={{10,0},{26,0},{40,0}}, color={191,0,0}));
  connect(Store.heat_input, boilerBasicPeak.thermal_heat_flow)
    annotation (Line(points={{-10,0},{-10,0},{-40,0}}, color={191,0,0}));
  connect(consumerTimeDependExt.positive_heat_flow, Net_source.y[6])
    annotation (Line(points={{60.6,0},{70,0},{79,0}},        color={0,0,127}));
  connect(consumerTimeDependExt.heat_demand, meanBoilerHeat.u) annotation (Line(
        points={{39.4,7},{26,7},{26,50},{11.2,50}}, color={0,0,127}));
  connect(Store.store_temp, meanBoilerHeat.u1)
    annotation (Line(points={{0,10.4},{0,39.6}}, color={0,0,127}));
  connect(meanBoilerHeat.y, boilerBasicPeak.nominal_heat) annotation (Line(
        points={{-10.8,50},{-80,50},{-80,0},{-60.4,0}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=2.4886e+007, Interval=60),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p>This Model shows the use of the PI/ PID-Control unit. </p>
<p>For switching between both Control units change the parameter names in PID-object to choose between PI and PID Record.</p>
<p>In the given arrangement a (intern) constant store temperature target is given. </p>
<p>For an (extern) variable temperature change the Boolean parameter in PID and give an signal input for the temperature (In this model an extern StoreTemp object is shown, but it is not in use.)</p>
</html>"));
end ConstantBoilerHeatFlow;
