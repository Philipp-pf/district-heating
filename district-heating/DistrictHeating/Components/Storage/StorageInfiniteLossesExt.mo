within DistrictHeating.Components.Storage;
model StorageInfiniteLossesExt "Storage Model with infinite Energy Storage"

  parameter Modelica.SIunits.HeatCapacity C(start=1)
    "Heat capacity of the storage (cp*m)";
  parameter Modelica.SIunits.ThermalConductance G
    "Average Thermal conductance of the storage" annotation(Dialog(group="Only for calculation, no influence to the model"));
  parameter Modelica.SIunits.TemperatureSlope der_T(start=0)
    "Time derivative of temperature (= der(T))" annotation(Dialog(group="Initialization"));
  parameter Modelica.SIunits.Temperature Tstart(start=293.15, displayUnit="degC")
    "Starttemperature of the storage" annotation(Dialog(group="Initialization"));
  parameter Modelica.SIunits.Temperature Tref(start=293.15, displayUnit="degC")
    "Referencetemperature of the storage";
    Modelica.SIunits.Temperature T_actual "current storage temperature";
    Modelica.SIunits.Heat Stored_Heat
    "Stored heat refered to Referencetemperature";
    Modelica.SIunits.HeatFlowRate Q "Store Losses by average G";
    Modelica.SIunits.ThermalConductance Gvar
    "Thermal conductance of the storage (calculated)";

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heat_input
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heat_output
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor Store(C=C,
    der_T(start=der_T),
    T(start=Tstart, fixed=true))
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  Modelica.Blocks.Interfaces.RealInput outside_temp annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-104})));
  Modelica.Blocks.Interfaces.RealOutput store_temp annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,104})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
    prescribedHeatFlow annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-30})));
  Modelica.Blocks.Interfaces.RealInput Store_losses annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-66,-104})));
  Modelica.Blocks.Math.Gain gain(k=-1)
    annotation (Placement(transformation(extent={{-46,-72},{-26,-52}})));
equation

T_actual=Store.T;
T_actual=store_temp;
Stored_Heat=Store.C*(T_actual-Tref);
Q=G*(T_actual-outside_temp);
Gvar= prescribedHeatFlow.port.Q_flow/(T_actual-outside_temp);

  connect(heat_input, heat_output)
    annotation (Line(points={{-100,0},{0,0},{100,0}}, color={191,0,0}));
  connect(Store.port, heat_output)
    annotation (Line(points={{0,30},{0,0},{100,0}}, color={191,0,0}));
  connect(prescribedHeatFlow.port, heat_output)
    annotation (Line(points={{0,-20},{0,0},{100,0}}, color={191,0,0}));
  connect(gain.y, prescribedHeatFlow.Q_flow) annotation (Line(points={{
          -25,-62},{0,-62},{0,-40}}, color={0,0,127}));
  connect(gain.u, Store_losses) annotation (Line(points={{-48,-62},{-66,
          -62},{-66,-104}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,0}),
        Rectangle(
          extent={{-100,100},{100,0}},
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,0},{100,-100}},
          lineColor={0,0,0},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-74,10},{74,-10}},
          lineColor={0,0,0},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="Storage

infinite"),
        Text(
          extent={{-62,130},{66,106}},
          lineColor={28,108,200},
          textString="%name")}),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This storage model has infinite energy storage capacitiy. </p>
<p>Thermal storage losses are considered by Real Input. </p>
<p>If thermal losses are not considered then the Real Input has to equal to zero. </p>
</html>"));
end StorageInfiniteLossesExt;
