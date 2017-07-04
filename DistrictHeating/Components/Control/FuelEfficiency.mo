within DistrictHeating.Components.Control;
model FuelEfficiency "defines fuel heat flow"

        parameter Modelica.SIunits.HeatFlowRate AllowedGap
    "Allowed Difference of actual boiler heat flow and target boiler heat flow that dont reduces efficiency";
    parameter Real etaMin( min=0.001,max=1) "minimal efficiency of the boiler";
    parameter Boolean useExternalFile=false "=true, if external file is used" annotation(Dialog(group="External efficiency file"));
 parameter Real EfficiencyTable[:,2]
    "Dependency between heat flow and fuel efficiency" annotation (Dialog(group="External efficiency file", enable= not useExternalFile));
parameter String fileName="fileName" "File on which data is present"                                        annotation(Dialog(group="External efficiency file", enable= useExternalFile,loadSelector(filter = "Text files (*.txt)", caption = "Choose Text File with Consumer Heat Demand")));
  parameter String tableName="tableName" "Table Name in the file" annotation (Dialog(group="External efficiency file", enable= useExternalFile));

  Real Efficiency=max1.y "Efficiency";
   Modelica.SIunits.HeatFlowRate ActualBoilerHeatFlow=u
    "Useful heat flow which the boiler produced";
   Modelica.SIunits.HeatFlowRate TargetBoilerHeatFlow=u1
    "^target heat flow of the boiler";
    Modelica.SIunits.HeatFlowRate FuelHeatFlow=y
    "Fuel Heat flow which is needed to produce the boiler heat";
    Modelica.SIunits.Heat FuelHeat=integrator.y "Used fuel heat (integrated)";

  Modelica.Blocks.Continuous.Integrator integrator(
    k=1,
    initType=Modelica.Blocks.Types.Init.InitialState,
    y_start=0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={78,-80})));
  Modelica.Blocks.Math.Division division
    annotation (Placement(transformation(extent={{68,-10},{88,10}})));
  Modelica.Blocks.Logical.Switch switch
    annotation (Placement(transformation(extent={{0,52},{20,72}})));
  Modelica.Blocks.Interfaces.RealInput
            u1 "boiler target heat flow"       annotation (Placement(
        transformation(extent={{-140,-80},{-100,-40}},rotation=0)));
  Modelica.Blocks.Interfaces.RealInput u "actual boiler heat flow" annotation (
      Placement(transformation(extent={{-140,40},{-100,80}}, rotation=0)));
  Modelica.Blocks.Math.Feedback feedback
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  Modelica.Blocks.Interfaces.RealOutput y "Fuel heat flow"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Tables.CombiTable1Ds combiTable1Ds(
    table=EfficiencyTable,
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    tableOnFile=useExternalFile,
    tableName=tableName,
    fileName=fileName)
    annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
  Modelica.Blocks.Math.Abs abs1
    annotation (Placement(transformation(extent={{-62,-10},{-42,10}})));
  Modelica.Blocks.Logical.LessEqualThreshold lessEqualThreshold(threshold=
        AllowedGap)
    annotation (Placement(transformation(extent={{-32,-10},{-12,10}})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{-32,44},{-12,64}})));
  Modelica.Blocks.Math.Max max1
    annotation (Placement(transformation(extent={{32,-16},{52,4}})));
  Modelica.Blocks.Sources.Constant const(k=etaMin)
    annotation (Placement(transformation(extent={{0,-22},{20,-2}})));
equation
  if ActualBoilerHeatFlow>=TargetBoilerHeatFlow then
    product.u2=TargetBoilerHeatFlow/ActualBoilerHeatFlow;
  elseif ActualBoilerHeatFlow<TargetBoilerHeatFlow then
    product.u2=ActualBoilerHeatFlow/TargetBoilerHeatFlow;
else
product.u2=0;
  end if;

  connect(switch.u2, lessEqualThreshold.y)
    annotation (Line(points={{-2,62},{-8,62},{-8,0},{-11,0}},
                                                  color={255,0,255}));
  connect(u, combiTable1Ds.u) annotation (Line(points={{-120,60},{-92,60},{-82,
          60}},      color={0,0,127}));
  connect(abs1.u, feedback.y)
    annotation (Line(points={{-64,0},{-64,0},{-71,0}},    color={0,0,127}));
  connect(u1, feedback.u2)
    annotation (Line(points={{-120,-60},{-80,-60},{-80,-8}}, color={0,0,127}));
  connect(feedback.u1, combiTable1Ds.u) annotation (Line(points={{-88,0},{-94,0},
          {-94,60},{-82,60}}, color={0,0,127}));
  connect(integrator.u, division.y)
    annotation (Line(points={{90,-80},{96,-80},{96,0},{89,0}},
                                                             color={0,0,127}));
  connect(y, division.y)
    annotation (Line(points={{110,0},{89,0}}, color={0,0,127}));
  connect(division.u1, combiTable1Ds.u) annotation (Line(points={{66,6},{58,6},
          {58,92},{-94,92},{-94,60},{-82,60}},color={0,0,127}));
  connect(switch.y, max1.u1)
    annotation (Line(points={{21,62},{26,62},{26,0},{30,0}}, color={0,0,127}));
  connect(division.u2, max1.y)
    annotation (Line(points={{66,-6},{60,-6},{53,-6}}, color={0,0,127}));
  connect(max1.u2, const.y)
    annotation (Line(points={{30,-12},{21,-12}}, color={0,0,127}));
  connect(abs1.y, lessEqualThreshold.u)
    annotation (Line(points={{-41,0},{-41,0},{-34,0}}, color={0,0,127}));
  connect(switch.u3, product.y)
    annotation (Line(points={{-2,54},{-11,54}}, color={0,0,127}));
  connect(product.u1, combiTable1Ds.y[1])
    annotation (Line(points={{-34,60},{-59,60}},          color={0,0,127}));
  connect(switch.u1, combiTable1Ds.y[1]) annotation (Line(points={{-2,70},{-48,
          70},{-48,60},{-59,60}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-72,76},{-72,-64},{78,-64}}, color={28,108,200}),
        Line(points={{-72,76},{-76,68}}, color={28,108,200}),
        Line(points={{-72,76},{-68,68}}, color={28,108,200}),
        Line(points={{78,-64},{70,-60}}, color={28,108,200}),
        Line(points={{78,-64},{70,-68}}, color={28,108,200}),
        Line(points={{-62,-40},{-58,-32},{-54,-24},{-46,-14},{-32,-2},{-16,8},{6,
              16},{10,16},{24,18},{40,18},{48,14},{58,6},{64,-2}}, color={28,108,
              200}),
        Line(points={{22,-64},{22,18},{-72,18}}, color={28,108,200})}),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This object turns the actual heat flow of a boiler into the needed fuel heat flow dependent to the efficiency of the boiler.</p>
<p>The table defines the heat flow efficiency (right column) dependent of the actual heat flow (left column). </p>
<p>In times where input heat flow is not constant the boiler efficiency is reduced by factor target boiler heat flow/ actual boiler heat flow or actual boiler heat flow/target boiler heat flow dependent to which of the both is smaller than one.</p>
<p>Fuel Heat Flow=Actual Heat Flow/Efficiency.</p>
</html>"),
    experiment(StopTime=50),
    __Dymola_experimentSetupOutput);
end FuelEfficiency;
