within DistrictHeating.Examples.Others;
model ReverseFirstOrder "Test of first order"

extends Modelica.Icons.Example;
  parameter String fileNameStrawNew = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Straw_original_changed.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));

  Components.Others.ReverseFirstOrder
                    reverseFirstOrder(
    k=1,
    u_start=0,
    yMin=0,
    yMax=5645614,
    T=60) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,-42})));
  Modelica.Blocks.Sources.CombiTimeTable Straw_source(
    tableOnFile=true,
    columns={2,3,4,5,6,7},
    tableName="Strohleistung",
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    fileName=fileNameStrawNew)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-78,0})));
  DistrictHeating.Components.Boiler.BoilerInFinite Straw(limited_heat=false,
    Qmax=2300000,
    TimeFirstOrder=0.001,
    PartLoad=0)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor Produced_heat
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-20,0})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=273.15)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={30,0})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(
    k=1,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    T=60) annotation (Placement(transformation(extent={{0,-80},{20,-60}})));
equation
  connect(Straw.thermal_heat_flow, Produced_heat.port_a)
    annotation (Line(points={{-40,0},{-36,0},{-30,0}}, color={191,0,0}));
  connect(Straw.nominal_heat, Straw_source.y[6])
    annotation (Line(points={{-60.4,0},{-67,0}},         color={0,0,127}));
  connect(Produced_heat.port_b, fixedTemperature.port)
    annotation (Line(points={{-10,0},{6,0},{20,0}}, color={191,0,0}));
  connect(Produced_heat.Q_flow, reverseFirstOrder.u)
    annotation (Line(points={{-20,-10},{-20,-10},{-20,-30}}, color={0,0,127}));
  connect(firstOrder.u, reverseFirstOrder.y) annotation (Line(points={{-2,-70},
          {-2,-70},{-20,-70},{-20,-53}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StartTime=2e+006,
      StopTime=2.5e+007,
      Interval=60),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p>Test of reverse first order. </p>
<p>Input of reverse first order and output of first order are equal.</p>
</html>"));
end ReverseFirstOrder;
