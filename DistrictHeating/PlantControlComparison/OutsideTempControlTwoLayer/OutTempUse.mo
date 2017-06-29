within DistrictHeating.PlantControlComparison.OutsideTempControlTwoLayer;
model OutTempUse
  parameter String fileNameTemperatureNew = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Outsidetemperature_original_changed.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));
  parameter String fileNameNetNew = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Net_original_changed.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));
    Real zero=0 "show minimal height of storage boarder";

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
    fileName=fileNameNetNew)                                    annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,0})));
  Modelica.Blocks.Sources.CombiTimeTable Outside_Temp_source(
    tableOnFile=true,
    tableName="Aussentemperatur",
    columns={2,3,4,5,6,7},
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    fileName=fileNameTemperatureNew)                            annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-50})));
  Components.Control.OutsideTempControl
                              outsideTempControlContinous(Table=table.DataTable)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={0,40})));
  Table table(DataTable(displayUnit="kW") = [0,2,11,20; 268,2600000,2800000,
      3400000; 270,2400000,2700000,3300000; 280,400000,1500000,2700000; 290,
      400000,900000,1500000; 300,400000,450000,500000; 310,400000,420000,450000])
    annotation (Placement(transformation(extent={{40,60},{60,80}})));
  DistrictHeating.Components.Storage.StorageTwoLayer storageTwoLayer(
    V=137,
    H=22,
    rho=water.rho,
    cp=water.cp,
    U=13,
    Hboard(fixed=true, start=15),
    D(start=2),
    Thigh=363.15,
    Tlow=313.15,
    Tref=313.15)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Components.Boiler.BoilerBasicPeak boilerBasicPeak(Qbase=4000000, Qpeak=
        1000000)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
equation
connect(consumerTimeDependExt.positive_heat_flow, Net_source.y[6])
  annotation (Line(points={{60.6,0},{70,0},{79,0}},        color={0,0,127}));
  connect(consumerTimeDependExt.heat_flow, storageTwoLayer.port_b)
    annotation (Line(points={{40,0},{26,0},{10,0}}, color={191,0,0}));
  connect(Outside_Temp_source.y[6], storageTwoLayer.u) annotation (Line(points=
          {{7.21645e-016,-39},{0,-39},{0,-11.4}}, color={0,0,127}));
  connect(storageTwoLayer.y, outsideTempControlContinous.u1)
    annotation (Line(points={{0,10.6},{0,29.6}}, color={0,0,127}));
  connect(storageTwoLayer.port_a, boilerBasicPeak.thermal_heat_flow)
    annotation (Line(points={{-10,0},{-26,0},{-40,0}}, color={191,0,0}));
  connect(outsideTempControlContinous.u, storageTwoLayer.u) annotation (Line(
        points={{11.2,40},{20,40},{20,-20},{0,-20},{0,-11.4}}, color={0,0,127}));
  connect(outsideTempControlContinous.y, boilerBasicPeak.nominal_heat)
    annotation (Line(points={{-10.8,40},{-70,40},{-70,0},{-60.4,0}}, color={0,0,
          127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StartTime=2e+006,
      StopTime=2.43132e+007,
      Interval=60),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p>This model shows how the outsidetemperature control object works. </p>
<p>The relation between outside temperature and boiler heat flow is given in object table. </p>
<p>Note: At the end of the simulation, storage gets overloaded and an error occurs. </p>
</html>"));
end OutTempUse;
