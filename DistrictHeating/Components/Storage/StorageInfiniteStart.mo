within DistrictHeating.Components.Storage;
model StorageInfiniteStart "Storage Model with infinite Energy Storage"

parameter Modelica.SIunits.HeatCapacity C(start=1)
    "Heat capacity of the storage (cp*m)";
parameter Modelica.SIunits.ThermalConductance G( start=0)
    "Constant thermal conductance of the storage (G=A*U)" annotation(Dialog(group="Storage losses"));
  parameter Modelica.SIunits.Temperature Tref(start=293.15, displayUnit="degC")
    "Referencetemperature of the storage";
  parameter Modelica.SIunits.TemperatureSlope der_T(start=0)
    "Time derivative of temperature (= der(T))" annotation(Dialog(group="Initialization"));
    Modelica.SIunits.Temperature T_actual "current storage temperature";
    Modelica.SIunits.Heat Stored_Heat
    "Stored heat refered to Referencetemperature";
    //symbols
    Modelica.SIunits.Heat Q_store=Stored_Heat
    "stored heat refering to reference temperature";

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heat_input
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heat_output
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor Store(C=C,
    der_T(start=der_T),
    T(fixed=false))
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  Modelica.Blocks.Interfaces.RealInput outside_temp annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-104})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature outside_temperature
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-68})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor coat_losses(G=G)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-14})));
  Modelica.Blocks.Interfaces.RealOutput store_temp annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,104})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor Heat_Losses annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-42})));
equation

T_actual=Store.T;
T_actual=store_temp;
Stored_Heat=Store.C*(T_actual-Tref);
  connect(heat_input, heat_output)
    annotation (Line(points={{-100,0},{0,0},{100,0}}, color={191,0,0}));
  connect(Store.port, heat_output)
    annotation (Line(points={{0,30},{0,0},{100,0}}, color={191,0,0}));
  connect(outside_temp, outside_temperature.T)
    annotation (Line(points={{0,-104},{0,-80}}, color={0,0,127}));
  connect(coat_losses.port_b, heat_output)
    annotation (Line(points={{0,-4},{0,0},{100,0}},  color={191,0,0}));
  connect(coat_losses.port_a, Heat_Losses.port_a) annotation (Line(points={{-5.55112e-016,
          -24},{0,-24},{0,-32},{1.77636e-015,-32}}, color={191,0,0}));
  connect(outside_temperature.port, Heat_Losses.port_b) annotation (Line(points=
         {{5.55112e-016,-58},{0,-58},{0,-52},{-1.77636e-015,-52}}, color={191,0,
          0}));
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
<p>Thermal storage losses are considered by using the thermal conductance G. </p>
<p>The conductance G is calculated by:</p>
<p>G=Sum(Ui*Ai)</p>
<p>with Ai...partial area of the storage surface [m&sup2;]</p>
<p>Ui...heat transition coefficient of the partial area [W/(m&sup2;*K)]</p>
<p>If thermal losses are not considered then G=0</p>
<p>This model has no start temperature of the storage.</p>
</html>"));
end StorageInfiniteStart;
