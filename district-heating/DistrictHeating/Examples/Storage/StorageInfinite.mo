within DistrictHeating.Examples.Storage;
model StorageInfinite
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
  Modelica.Blocks.Sources.Ramp ramp(
    height=500,
    duration=2,
    offset=0,
    startTime=2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,66})));
  Modelica.Blocks.Math.Gain gain(k=-1)
    annotation (Placement(transformation(extent={{26,20},{46,40}})));
  Components.Storage.StorageInfinite storageInfinite(
    C=1,
    G=0.1,
    der_T=0,
    Tstart=313.15)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(prescribedHeatFlow.Q_flow,ramp. y) annotation (Line(points={{-42,0},
          {-54,0},{-62,0},{-62,30},{0,30},{0,55}}, color={0,0,127}));
  connect(prescribedHeatFlow1.Q_flow,gain. y) annotation (Line(points={{50,0},{
          60,0},{72,0},{72,30},{47,30}},  color={0,0,127}));
  connect(gain.u,ramp. y) annotation (Line(points={{24,30},{0,30},{0,55}},
                             color={0,0,127}));
  connect(prescribedHeatFlow.port, storageInfinite.heat_input)
    annotation (Line(points={{-22,0},{-16,0},{-10,0}}, color={191,0,0}));
  connect(prescribedHeatFlow1.port, storageInfinite.heat_output)
    annotation (Line(points={{30,1.22125e-015},{20,1.22125e-015},{20,0},{
          10,0}}, color={191,0,0}));
  connect(cosine.y, storageInfinite.outside_temp)
    annotation (Line(points={{0,-33},{0,-10.4}}, color={0,0,127}));
  annotation (Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">The storage is loaded and unloaded in the same amount. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Through the thermal losses of the storage the temperature in the storage decreases. </span></p>
</html>"));
end StorageInfinite;
