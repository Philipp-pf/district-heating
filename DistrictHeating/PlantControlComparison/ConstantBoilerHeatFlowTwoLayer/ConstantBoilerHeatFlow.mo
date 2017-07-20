within DistrictHeating.PlantControlComparison.ConstantBoilerHeatFlowTwoLayer;
model ConstantBoilerHeatFlow
  parameter String fileNameTemperatureNew=Modelica.Utilities.Files.loadResource(
      "modelica://DistrictHeating/Resources/Data/Outsidetemperature_original_changed.txt")
    "File on which data is present" annotation (Dialog(loadSelector(filter=
            "Text files (*.txt)", caption=
            "Open text file to read parameters of the form \"name = value\"")));
  parameter String fileNameNetNew=Modelica.Utilities.Files.loadResource(
      "modelica://DistrictHeating/Resources/Data/Net_original_changed.txt")
    "File on which data is present" annotation (Dialog(loadSelector(filter=
            "Text files (*.txt)", caption=
            "Open text file to read parameters of the form \"name = value\"")));

Boolean Overload "if store is full";
Boolean Underload "if store is empty";
Real zero=0 "Zero-line";

  DistrictHeating.Components.Consumers.ConsumerTimeDependExt
    consumerTimeDependExt
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Thermal.FluidHeatFlow.Media.Water water
    annotation (Placement(transformation(extent={{60,-60},{80,-40}})));
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
    fileName=fileNameTemperatureNew)
                                  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-30})));
  DistrictHeating.Components.Boiler.BoilerBasicPeak boilerBasicPeak(Qbase(
        displayUnit="kW") = 2200000, Qpeak(displayUnit="kW") = 1500000,
    TimeFirstOrderBase=0.001,
    TimeFirstOrderPeak=0.001,
    PartLoadBase=0,
    PartLoadPeak=0)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Components.Control.MeanBoilerHeatTwoLayer
                         meanBoilerHeat(
    preYstart=true,
    TimeConstant(displayUnit="h") = fourHrs.TimeConstant,
    Hhighload1=fourHrs.Hhighload1,
    khigh1=fourHrs.khigh1,
    Hhighload2=fourHrs.Hhighload2,
    khigh2=fourHrs.khigh2,
    Hlowload2=fourHrs.Hlowload2,
    klow2=fourHrs.klow2,
    Hlowload1=fourHrs.Hlowload1,
    klow1=fourHrs.klow1,
    QStart=fourHrs.QStart,
    TStart=fourHrs.TStart)
                  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={0,50})));
  Components.Storage.StorageTwoLayer                 storageTwoLayer(
    V=137,
    H=22,
    rho=water.rho,
    cp=water.cp,
    U=13,
    Thigh=363.15,
    Tlow=313.15,
    Tref=313.15,
    Hboard(start=5.0, fixed=true))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  FourHrs fourHrs
    annotation (Placement(transformation(extent={{-80,80},{-60,100}})));
  EightHrs eightHrs
    annotation (Placement(transformation(extent={{-40,80},{-20,100}})));
  TwelveHrs twelveHrs
    annotation (Placement(transformation(extent={{0,80},{20,100}})));
  TwentyFourHrs twentyFourHrs
    annotation (Placement(transformation(extent={{40,80},{60,100}})));
equation
  if storageTwoLayer.Hboard<0 then
    Overload=true;
  else
    Overload=false;
  end if;
  if storageTwoLayer.Hboard>storageTwoLayer.H then
    Underload=true;
  else
    Underload=false;
  end if;
  connect(consumerTimeDependExt.positive_heat_flow, Net_source.y[6])
    annotation (Line(points={{60.6,0},{70,0},{79,0}},        color={0,0,127}));
  connect(consumerTimeDependExt.heat_demand, meanBoilerHeat.u) annotation (Line(
        points={{39.4,7},{26,7},{26,50},{11.2,50}}, color={0,0,127}));
  connect(meanBoilerHeat.y, boilerBasicPeak.nominal_heat) annotation (Line(
        points={{-10.8,50},{-80,50},{-80,0},{-60.4,0}}, color={0,0,127}));
  connect(boilerBasicPeak.thermal_heat_flow, storageTwoLayer.port_a)
    annotation (Line(points={{-40,0},{-26,0},{-10,0}}, color={191,0,0}));
  connect(consumerTimeDependExt.heat_flow, storageTwoLayer.port_b)
    annotation (Line(points={{40,0},{26,0},{10,0}}, color={191,0,0}));
  connect(meanBoilerHeat.u1, storageTwoLayer.y) annotation (Line(points={{
          -1.33227e-015,39.6},{0,39.6},{0,10.6}},
                                    color={0,0,127}));
  connect(Outside_Temp_source.y[6], storageTwoLayer.u) annotation (Line(points={
          {7.21645e-016,-19},{0,-19},{0,-11.4}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StartTime=2e+006,
      StopTime=2.4886e+007,
      Interval=60),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p>This Model shows the use of the constant boiler heat flow control unit. </p>
<p>Time constants of 4, 8, 12 and 24 hours are available. </p>
<p>Choose the time constant you need by filling in the name of the record in meanBoilerHeat object.</p>
<p><br>Note: at the end of the simulation, the storage goes out of limits of storage. So an error occurs. </p>
</html>"));
end ConstantBoilerHeatFlow;
