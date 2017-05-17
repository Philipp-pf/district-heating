within DistrictHeating.Examples.Consumers;
model ConsumerTimeDependExt
  extends Modelica.Icons.Example;
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=273.15)
    annotation (Placement(transformation(extent={{-46,-10},{-26,10}})));
  DistrictHeating.Components.Consumers.ConsumerTimeDependExt
    consumerTimeDependExt
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
    tableOnFile=true,
    tableName="Strohleistung",
    columns={2,3,4,5,6,7},
    fileName="C:/Users/Philipp/Desktop/Masterthese/Dymola/District_Heating/Resources/Data/Straw_Example2.txt")
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={36,0})));
equation
  connect(fixedTemperature.port, consumerTimeDependExt.heat_flow)
    annotation (Line(points={{-26,0},{-10,0}}, color={191,0,0}));
  connect(consumerTimeDependExt.positive_heat_flow, combiTimeTable.y[6])
    annotation (Line(points={{10.6,0},{25,0},{25,0}}, color={0,0,127}));
  annotation (experiment(StopTime=10),
      __Dymola_experimentSetupOutput);
end ConsumerTimeDependExt;
