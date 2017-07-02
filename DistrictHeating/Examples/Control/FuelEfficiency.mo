within DistrictHeating.Examples.Control;
model FuelEfficiency "shows work of efficiency component"
  extends Modelica.Icons.Example;
  parameter String fileNameEff = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Efficiency.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));
  Modelica.Blocks.Sources.Ramp ramp(
    duration=5,
    startTime=10,
    height=-500000,
    offset=1500000)
    annotation (Placement(transformation(extent={{-66,24},{-46,44}})));
  Components.Control.FuelEfficiency
                            fuelEfficiency(
    EfficiencyTable=effTable.DataTable,
    etaMin=0.1,
    AllowedGap=1000,
    useExternalFile=true,
    fileName=fileNameEff,
    tableName="Efficiency")
    annotation (Placement(transformation(extent={{22,-10},{42,10}})));
  DistrictHeating.PlantControlComparison.BestEfficiencyTwoLayer.Table
        effTable(DataTable(displayUnit="W") = [Modelica.Constants.eps,Modelica.Constants.eps; 500000,0.12;
        1000000,0.25; 2000000,0.45; 3000000,0.7; 3200000,0.75; 3400000,0.8; 3600000,
        0.81; 3800000,0.75; 4000000,0.7; 4200000,0.65])
    annotation (Placement(transformation(extent={{50,70},{70,90}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(
    k=1,
    initType=Modelica.Blocks.Types.Init.InitialState,
    y_start=0,
    T=1) annotation (Placement(transformation(extent={{-32,4},{-12,24}})));
equation
  connect(ramp.y, firstOrder.u) annotation (Line(points={{-45,34},{-40,34},{-40,
          14},{-34,14}},
                       color={0,0,127}));
  connect(fuelEfficiency.u1, firstOrder.u) annotation (Line(points={{20,-6},{-40,
          -6},{-40,14},{-34,14}},
                                color={0,0,127}));
  connect(fuelEfficiency.u, firstOrder.y) annotation (Line(points={{20,6},{14,6},
          {2,6},{2,14},{-11,14}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This example shows, how the efficiency object works. </p>
</html>"));
end FuelEfficiency;
