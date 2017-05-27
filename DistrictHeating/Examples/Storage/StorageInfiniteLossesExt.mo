within DistrictHeating.Examples.Storage;
model StorageInfiniteLossesExt
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
  Components.Storage.StorageInfiniteLossesExt storageInfiniteLossesExt(
    C=1,
    der_T=0,
    G=0.0682344,
    Tstart=293.15,
    Tref=293.15)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Constant Source(k=500)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Blocks.Sources.Constant Sink(k=-480) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={70,0})));
  Modelica.Blocks.Sources.Constant Losses(k=20) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-36,-44})));
equation
  connect(prescribedHeatFlow.port, storageInfiniteLossesExt.heat_input)
    annotation (Line(points={{-22,0},{-16,0},{-10,0}}, color={191,0,0}));
  connect(prescribedHeatFlow1.port, storageInfiniteLossesExt.heat_output)
    annotation (Line(points={{30,1.22125e-015},{20,1.22125e-015},{20,0},{
          10,0}}, color={191,0,0}));
  connect(cosine.y, storageInfiniteLossesExt.outside_temp) annotation (
      Line(points={{7.21645e-016,-33},{0,-33},{0,-10.4}}, color={0,0,127}));
  connect(prescribedHeatFlow.Q_flow, Source.y)
    annotation (Line(points={{-42,0},{-50,0},{-59,0}}, color={0,0,127}));
  connect(prescribedHeatFlow1.Q_flow, Sink.y) annotation (Line(points={{
          50,-1.11022e-015},{54,-1.11022e-015},{54,0},{59,0}}, color={0,0,
          127}));
  connect(storageInfiniteLossesExt.Store_losses, Losses.y) annotation (
      Line(points={{-6.6,-10.4},{-6.6,-14},{-36,-14},{-36,-33}}, color={0,
          0,127}));
  annotation (Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">The storage is loaded with 500W and unloaded with 480W. The store losses are 20W. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">The sum of the used heat flow and the store losses are equal to the loading heat flow. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">So the store temperature stays constant. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">The parameter G of the storage is set to the arithmetic mean of the variable gvar from the simulation. So, over time the average store losses equal to aproximately 20W.</span></p>
</html>"),
    experiment(StopTime=10, __Dymola_NumberOfIntervals=5000),
    __Dymola_experimentSetupOutput);
end StorageInfiniteLossesExt;
