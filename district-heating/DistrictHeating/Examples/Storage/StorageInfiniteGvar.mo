within DistrictHeating.Examples.Storage;
model StorageInfiniteGvar
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Cosine cosine(
    freqHz=0.1,
    startTime=0,
    offset=0,
    amplitude=5,
    phase=3.1415926535898) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-44})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{-42,-10},{-22,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
    prescribedHeatFlow1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={40,0})));
  Modelica.Blocks.Sources.Constant Source(k=500)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Blocks.Sources.Constant Sink(k=-470) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={70,0})));
  Modelica.Blocks.Sources.Constant Losses(k=0.1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-36,-44})));
  Components.Storage.StorageInfiniteGvar storageInfiniteGvar(
    C=1,
    der_T=0,
    Tstart=293.15,
    Tref=293.15)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(prescribedHeatFlow.Q_flow, Source.y)
    annotation (Line(points={{-42,0},{-50,0},{-59,0}}, color={0,0,127}));
  connect(prescribedHeatFlow1.Q_flow, Sink.y) annotation (Line(points={{
          50,-1.11022e-015},{54,-1.11022e-015},{54,0},{59,0}}, color={0,0,
          127}));
  connect(prescribedHeatFlow.port, storageInfiniteGvar.heat_input)
    annotation (Line(points={{-22,0},{-16,0},{-10,0}}, color={191,0,0}));
  connect(prescribedHeatFlow1.port, storageInfiniteGvar.heat_output)
    annotation (Line(points={{30,1.22125e-015},{20,1.22125e-015},{20,0},{
          10,0}}, color={191,0,0}));
  connect(cosine.y, storageInfiniteGvar.outside_temp) annotation (Line(
        points={{7.21645e-016,-33},{0,-33},{0,-10.4}}, color={0,0,127}));
  connect(Losses.y, storageInfiniteGvar.Thermal_conduct) annotation (Line(
        points={{-36,-33},{-36,-24},{-6,-24},{-6,-10.4}}, color={0,0,127}));
  annotation (Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">The storage is loaded with 500W and unloaded with 780W. The store losses are calculated by extern thermal conductivity. </span></p>
<p>This model is used for calibration model. In real, this model can`t be used because normally the thermal conductivity of the storage is constant. </p>
</html>"),
    experiment(StopTime=10, __Dymola_NumberOfIntervals=5000),
    __Dymola_experimentSetupOutput);
end StorageInfiniteGvar;
