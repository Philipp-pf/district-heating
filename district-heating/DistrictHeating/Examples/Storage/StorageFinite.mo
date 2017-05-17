within DistrictHeating.Examples.Storage;
model StorageFinite
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Cosine cosine(
    freqHz=0.1,
    startTime=0,
    amplitude=5,
    phase=3.1415926535898,
    offset=273.15)         annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-44})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{-42,-10},{-22,10}})));
  Components.Storage.StorageFinite storageFinite(
    C=10,
    G=0.1,
    der_T=0,
    T_min=313.15,
    T_max=373.15,
    T_ref=313.15,
    Tstart=323.15)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.TimeTable Boiler(
    table=[0,0; 1,0; 2,500; 3,1500; 4,2000; 5,1000; 6,500; 7,500; 8,500;
        9,200; 10,0],
    offset=0,
    startTime=0)
    annotation (Placement(transformation(extent={{-82,-10},{-62,10}})));
  Modelica.Blocks.Sources.TimeTable Consumer(
    offset=0,
    startTime=0,
    table=[0,0; 1,0; 2,200; 3,500; 4,500; 5,500; 6,1500; 7,2000; 8,2000;
        9,1500; 10,1500]) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={58,32})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(
      T=273.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={58,0})));
  Modelica.Blocks.Math.Gain gain(k=-1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={28,32})));
equation
  connect(prescribedHeatFlow.Q_flow, Boiler.y)
    annotation (Line(points={{-42,0},{-61,0}}, color={0,0,127}));
  connect(prescribedHeatFlow.port, storageFinite.heat_input)
    annotation (Line(points={{-22,0},{-16,0},{-10,0}}, color={191,0,0}));
  connect(storageFinite.heat_output, fixedTemperature.port) annotation (
      Line(points={{10,0},{48,0},{48,1.33227e-015}}, color={191,0,0}));
  connect(cosine.y, storageFinite.outside_temp) annotation (Line(points={
          {0,-33},{0,-33},{0,-10.4}}, color={0,0,127}));
  connect(Consumer.y, gain.u)
    annotation (Line(points={{47,32},{40,32}}, color={0,0,127}));
  connect(gain.y, storageFinite.demand) annotation (Line(points={{17,32},
          {14,32},{14,6},{10.4,6}}, color={0,0,127}));
  annotation (Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">The storage is loaded and unloaded by two time tabels.</span></p>
<p>During the simulation the storage gets fully loaded and fully unloaded.</p>
</html>"),
    experiment(StopTime=10),
    __Dymola_experimentSetupOutput);
end StorageFinite;
