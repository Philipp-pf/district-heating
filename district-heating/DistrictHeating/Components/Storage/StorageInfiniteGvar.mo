within DistrictHeating.Components.Storage;
model StorageInfiniteGvar "Storage Model with infinite Energy Storage"

parameter Modelica.SIunits.HeatCapacity C(start=1)
    "Heat capacity of the storage (cp*m)";
  parameter Modelica.SIunits.Temperature Tstart(start=293.15, displayUnit="degC")
    "Starttemperature of the storage" annotation(Dialog(group="Initialization"));
  parameter Modelica.SIunits.Temperature Tref(start=293.15, displayUnit="degC")
    "Referencetemperature of the storage";
  parameter Modelica.SIunits.TemperatureSlope der_T(start=0)
    "Time derivative of temperature (= der(T))" annotation(Dialog(group="Initialization"));
    Modelica.SIunits.Temperature T_actual "current storage temperature";
    Modelica.SIunits.Heat Stored_Heat
    "Stored heat refered to Referencetemperature";
Modelica.SIunits.ThermalConductance G "Thermal conductance of the storage";
Modelica.SIunits.HeatFlowRate Qloss "Store Heat Flow Losses";

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
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature outside_temperature
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-68})));
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
  Modelica.Blocks.Interfaces.RealInput Thermal_conduct annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-60,-104})));
  Others.VariableThermalConductor variableThermalConductor annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-16})));
equation

T_actual=Store.T;
T_actual=store_temp;
Stored_Heat=Store.C*(T_actual-Tref);
G=Thermal_conduct;
Qloss=G*(T_actual-outside_temp);

  connect(heat_input, heat_output)
    annotation (Line(points={{-100,0},{0,0},{100,0}}, color={191,0,0}));
  connect(Store.port, heat_output)
    annotation (Line(points={{0,30},{0,0},{100,0}}, color={191,0,0}));
  connect(outside_temp, outside_temperature.T)
    annotation (Line(points={{0,-104},{0,-80}}, color={0,0,127}));
  connect(outside_temperature.port, Heat_Losses.port_b) annotation (Line(points=
         {{5.55112e-016,-58},{0,-58},{0,-52},{-1.77636e-015,-52}}, color={191,0,
          0}));
  connect(Heat_Losses.port_a, variableThermalConductor.port_a)
    annotation (Line(points={{0,-32},{0,-29},{0,-26}}, color={191,0,0}));
  connect(variableThermalConductor.port_b, heat_output)
    annotation (Line(points={{0,-6},{0,0},{100,0}}, color={191,0,0}));
  connect(variableThermalConductor.Thermal_conduct, Thermal_conduct)
    annotation (Line(points={{-10.4,-16},{-20,-16},{-60,-16},{-60,-104}}, color=
         {0,0,127}));
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
<p><img src=\"modelica://DistrictHeating/Resources/Images/G-Formula.png\"/></p>
<p>with Ai...partial area of the storage surface [m&sup2;]</p>
<p>        Ui...heat transition coefficient of the partial area [W/(m&sup2;*K)]</p>
<p>If thermal losses are not considered then G=0</p>
</html>"));
end StorageInfiniteGvar;
