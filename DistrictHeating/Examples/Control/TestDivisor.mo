within DistrictHeating.Examples.Control;
model TestDivisor "shows work of HeatFlowDivisor"
  extends Modelica.Icons.Example;

  parameter String fileNameNetNew=Modelica.Utilities.Files.loadResource(
      "modelica://DistrictHeating/Resources/Data/Net_original_changed.txt")
    "File on which data is present";

  Components.Control.HeatFlowDivisor heatFlowDivisor(
    WaitingTime(displayUnit="h") = 43200,
    ActivateBaseBoiler=1000000,
    ActivateBothBoiler=2500000,
    DeactivateBothBoiler=2400000,
    DeactivateBaseBoiler=700000,
    BaseHeatFlowBoth=1500000,
    MaxBaseLoad=2600000,
    MaxPeakLoad=500000)
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
        origin={80,0})));
  Modelica.Blocks.Sources.Constant const(k=3000000)
    annotation (Placement(transformation(extent={{-60,-4},{-40,16}})));
equation
  connect(Net_source.y[6], heatFlowDivisor.u2) annotation (Line(points={{69,0},
          {50,0},{50,-30},{-28,-30},{-28,-6},{-12,-6}}, color={0,0,127}));
  connect(heatFlowDivisor.u1, const.y)
    annotation (Line(points={{-12,6},{-26,6},{-39,6}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=2.5e+007, Interval=60),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p>This example shows how to use the object HeatFlowDivisor. </p>
</html>"));
end TestDivisor;
