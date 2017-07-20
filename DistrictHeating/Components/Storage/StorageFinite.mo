within DistrictHeating.Components.Storage;
model StorageFinite

//Durchdenken: wie max. Kapazität festlegen;

parameter Modelica.SIunits.HeatCapacity C "Heat capacity of the storage (cp*m)";
parameter Modelica.SIunits.ThermalConductance G
    "Constant thermal conductance of the storage (G=A*U)" annotation(Dialog(group="Storage losses"));
  parameter Modelica.SIunits.Temperature T_min( start=313.15, displayUnit="degC")
    "minimum allowed temperature of the storage" annotation(Dialog(group="Temperatures"));
  parameter Modelica.SIunits.Temperature T_max(start=383.15, displayUnit="degC")
    "maximum allowed temperature of the storage" annotation(Dialog(group="Temperatures"));
  parameter Modelica.SIunits.Temperature T_ref( start=273.15, displayUnit="degC")
    "Referencetemperature of the storage" annotation(Dialog(group="Temperatures"));
  parameter Modelica.SIunits.Temperature Tstart(start=293.15, displayUnit="degC")
    "Starttemperature of the storage" annotation(Dialog(group="Initialization"));
  parameter Modelica.SIunits.TemperatureSlope der_T(start=0)
    "Time derivative of temperature (= der(T))" annotation(Dialog(group="Initialization"));
      Real fill_level "fill level of the storage";
    Modelica.SIunits.Temperature T_act( displayUnit="degC")
    "actual storage temp";
    Modelica.SIunits.Heat Stored_Energy
    "Stored Heat (revered to Reference Temperature)";
    Boolean Store_filled "true, if store is filled";
    Boolean Store_empty "true, if store is empty";
    Modelica.SIunits.HeatFlowRate Store_un_load
    "Heat Flow Difference between load Heat and unload Heat";
    //symbols
    Modelica.SIunits.Heat Q_store=Stored_Energy
    "stored heat refering to reference temperature";
    Modelica.SIunits.Heat Qmax_store=Store.C*(T_max-T_ref)
    "maximal stored heat refering to reference temperature";
    Modelica.SIunits.Heat Qmin_store=Store.C*(T_min-T_ref)
    "minimal stored heat refering to reference temperature";

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heat_input
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heat_output
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor Store(C=C,
    der_T(start=der_T),
    T(start=Tstart, fixed=true))
    annotation (Placement(transformation(extent={{-10,38},{10,58}})));
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
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor storein annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-82,18})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow storeheatin
    annotation (Placement(transformation(extent={{-42,-10},{-22,10}})));
  Modelica.Blocks.Interfaces.RealOutput fill annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,106})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow storeheatout
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={22,0})));

  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature ambient(T=273.15)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-82,74})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow storeout
    annotation (Placement(transformation(extent={{66,-24},{86,-4}})));
  Modelica.Blocks.Interfaces.RealInput demand annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={104,60})));
  Modelica.Blocks.Math.Gain sign2(k=-1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={58,4})));
  Modelica.Blocks.Logical.Switch switch_empty annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={42,40})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor storage_losses
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-44})));
  Modelica.Blocks.Math.Feedback max_heat_out
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-66,42})));
  Modelica.Blocks.Math.Gain sign1(
                                 k=-1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-36,54})));
  Modelica.Blocks.Logical.Switch switch_filled annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,-14})));
  Modelica.Blocks.Math.Add max_heat_in(k1=1, k2=1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={64,-46})));
  Modelica.Blocks.Math.Feedback surplus_heat_flow
    annotation (Placement(transformation(extent={{-58,4},{-38,24}})));
  Modelica.Blocks.Nonlinear.VariableLimiter unload_limiter annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={4,76})));
  Modelica.Blocks.Sources.Constant empty_zero(k=0) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-36,84})));
  Modelica.Blocks.Nonlinear.VariableLimiter load_limiter annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={50,-82})));
  Modelica.Blocks.Sources.Constant filled_zero(k=0) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={34,-46})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor Store_temp
    annotation (Placement(transformation(extent={{4,10},{24,30}})));
  Modelica.Blocks.Sources.Constant Tmin(k=T_min)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={86,82})));
  Modelica.Blocks.Logical.Less less
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={56,82})));
  Modelica.Blocks.Logical.Greater greater
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,-52})));
  Modelica.Blocks.Sources.Constant Tmax(k=T_max) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,-84})));
equation

fill_level=fill;
fill=(T_act-T_min)/(T_max-T_min);
Store.T=T_act;
Stored_Energy=Store.C*(T_act-T_ref);
Store_empty=less.y;
Store_filled=greater.y;

-Store_un_load=storeheatin.port.Q_flow+storeheatout.port.Q_flow+storage_losses.Q_flow;
  connect(Store.port, coat_losses.port_b) annotation (Line(points={{0,38},{6.66134e-016,
          38},{6.66134e-016,-4}},               color={191,0,0}));
  connect(storeheatin.port, coat_losses.port_b) annotation (Line(points={{-22,0},
          {6.66134e-016,0},{6.66134e-016,-4}},     color={191,0,0}));
  connect(storeheatout.port, coat_losses.port_b) annotation (Line(points={{12,1.33227e-015},
          {6.66134e-016,1.33227e-015},{6.66134e-016,-4}},
        color={191,0,0}));
  connect(outside_temp, outside_temperature.T) annotation (Line(points={{0,-104},
          {0,-90},{0,-80},{-6.66134e-016,-80}}, color={0,0,127}));
  connect(storein.port_b, ambient.port)
    annotation (Line(points={{-82,28},{-82,64}},          color={191,0,0}));
  connect(heat_output, storeout.port)
    annotation (Line(points={{100,0},{86,0},{86,-14}},
                                                     color={191,0,0}));
  connect(switch_empty.u1, demand) annotation (Line(points={{50,52},{50,60},{80,
          60},{104,60}},         color={0,0,127}));
  connect(switch_empty.y, sign2.u) annotation (Line(points={{42,29},{42,22},{58,
          22},{58,16}}, color={0,0,127}));
  connect(coat_losses.port_a, storage_losses.port_a) annotation (Line(
        points={{-5.55112e-016,-24},{0,-24},{0,-34}}, color={191,0,0}));
  connect(outside_temperature.port, storage_losses.port_b) annotation (Line(
        points={{5.55112e-016,-58},{0,-58},{0,-54}}, color={191,0,0}));
  connect(storein.Q_flow, max_heat_out.u1) annotation (Line(points={{-72,18},{-66,
          18},{-66,34}},          color={0,0,127}));
  connect(switch_filled.y, storeheatin.Q_flow)
    annotation (Line(points={{-60,-3},{-60,0},{-42,0}},  color={0,0,127}));
  connect(switch_filled.u1, max_heat_out.u1) annotation (Line(points={{-68,-26},
          {-68,-32},{-78,-32},{-78,6},{-66,6},{-66,34}},            color={0,0,127}));
  connect(surplus_heat_flow.u1, max_heat_out.u1) annotation (Line(points={{-56,14},
          {-66,14},{-66,34}},                  color={0,0,127}));
  connect(surplus_heat_flow.u2, storeheatin.Q_flow)
    annotation (Line(points={{-48,6},{-48,0},{-42,0}},  color={0,0,127}));
  connect(storein.port_a, heat_input) annotation (Line(points={{-82,8},{-82,0},{
          -100,0}},         color={191,0,0}));
  connect(storeheatout.Q_flow, sign2.u) annotation (Line(points={{32,-1.33227e-015},
          {42,-1.33227e-015},{42,22},{58,22},{58,16}},
        color={0,0,127}));
  connect(storeout.Q_flow, sign2.y) annotation (Line(points={{66,-14},{58,
          -14},{58,-7}}, color={0,0,127}));
  connect(greater.y, switch_filled.u2) annotation (Line(points={{-60,-41},{-60,-41},
          {-60,-26}}, color={255,0,255}));
  connect(max_heat_out.u2, storage_losses.Q_flow) annotation (Line(points={{-58,
          42},{-54,42},{-54,26},{-18,26},{-18,-44},{-10,-44}}, color={0,0,127}));
  connect(max_heat_out.y, sign1.u)
    annotation (Line(points={{-66,51},{-66,54},{-48,54}}, color={0,0,127}));
  connect(unload_limiter.limit1, empty_zero.y)
    annotation (Line(points={{-8,84},{-14,84},{-25,84}}, color={0,0,127}));
  connect(unload_limiter.limit2, sign1.y) annotation (Line(points={{-8,68},{-12,
          68},{-12,54},{-25,54}}, color={0,0,127}));
  connect(unload_limiter.u, demand) annotation (Line(points={{-8,76},{-20,76},{-20,
          60},{104,60}}, color={0,0,127}));
  connect(switch_empty.u3, unload_limiter.y)
    annotation (Line(points={{34,52},{34,76},{15,76}}, color={0,0,127}));
  connect(switch_empty.u2, less.y) annotation (Line(points={{42,52},{42,52},{42,
          66},{42,82},{45,82}}, color={255,0,255}));
  connect(less.u1, Tmin.y)
    annotation (Line(points={{68,82},{75,82}}, color={0,0,127}));
  connect(Store_temp.port, coat_losses.port_b) annotation (Line(points={{4,20},{
          0,20},{0,-4},{5.55112e-016,-4}}, color={191,0,0}));
  connect(Store_temp.T, less.u2) annotation (Line(points={{24,20},{28,20},{28,96},
          {72,96},{72,90},{68,90}}, color={0,0,127}));
  connect(max_heat_in.u2, storage_losses.Q_flow) annotation (Line(points={{58,-34},
          {58,-26},{-18,-26},{-18,-44},{-10,-44}}, color={0,0,127}));
  connect(max_heat_in.u1, sign2.y) annotation (Line(points={{70,-34},{70,-22},{58,
          -22},{58,-7}}, color={0,0,127}));
  connect(load_limiter.limit1, max_heat_in.y) annotation (Line(points={{58,-70},
          {58,-66},{64,-66},{64,-57}}, color={0,0,127}));
  connect(load_limiter.limit2, filled_zero.y) annotation (Line(points={{42,-70},
          {42,-66},{34,-66},{34,-57}}, color={0,0,127}));
  connect(load_limiter.u, max_heat_out.u1) annotation (Line(points={{50,-70},{50,
          -32},{-78,-32},{-78,6},{-66,6},{-66,34}}, color={0,0,127}));
  connect(Tmax.y, greater.u1)
    annotation (Line(points={{-60,-73},{-60,-64}}, color={0,0,127}));
  connect(load_limiter.y, switch_filled.u3) annotation (Line(points={{50,-93},{50,
          -96},{22,-96},{22,-84},{-26,-84},{-26,-36},{-52,-36},{-52,-26}},
        color={0,0,127}));
  connect(greater.u2, less.u2) annotation (Line(points={{-52,-64},{-52,-68},{-32,
          -68},{-32,34},{28,34},{28,96},{72,96},{72,90},{68,90}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-50,74},{50,0}},
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,0}),
        Rectangle(
          extent={{-50,0},{50,-74}},
          lineColor={0,0,0},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-72,8},{76,-12}},
          lineColor={0,0,0},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="Storage

finite")}),                                                      Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">This storage model has finite energy storage capacitiy. </span></p>
<p><br><span style=\"font-family: MS Shell Dlg 2;\">The upper and lower limit of the storage is definded by temperature limits. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">The fill level of the storage is between 0 (empty) and 1 (filled).</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">If the fill level is higher than 0 and lower than 1 the heat flow input and the heat flow output are infinite.</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">If the storage is empty, the output heat flow ist limited to the input heat flow reduced with the lossed heat flow .</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">If the storage is filled, the input heat flow is limited to the output heat flow and additionaly the lossed heat flow. </span></p>
<p><br><span style=\"font-family: MS Shell Dlg 2;\">The stored heat is calculated by the heat capacity multiplied by the temperature difference between the storage temperature and the reference temperature.</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Thermal storage losses are considered by using the thermal conductance G. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">The conductance G is calculated by:</span></p>
<p><span style=\"font-family: Arial,sans-serif;\">G=Sum(Ui*Ai)</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">with Ai...partial area of the storage surface [m&sup2;]</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Ui...heat transition coefficient of the partial area [W/(m&sup2;*K)]</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">If thermal losses are not considered then G=0</span></p>
</html>"));
end StorageFinite;
