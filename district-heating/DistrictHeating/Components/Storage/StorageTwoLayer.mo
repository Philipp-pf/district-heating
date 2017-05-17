within DistrictHeating.Components.Storage;
model StorageTwoLayer "Storage Model with infinite Energy Storage"

   parameter Modelica.SIunits.Volume V(start=137) "Net-Volume of the store";
   parameter Modelica.SIunits.Height H(start=22) "Net-Height of the store";
   parameter Modelica.SIunits.Temperature Tref(start=293.15, displayUnit="degC")
    "Referencetemperature of the storage";
   parameter Modelica.SIunits.Temperature Tup(start=363.15, displayUnit="degC")
    "Temperature in the upper part of the store" annotation(Dialog(group="Storage losses"));
   parameter Modelica.SIunits.Temperature Tdown(start=313.15, displayUnit="degC")
    "Temperature in the lower part of the store" annotation(Dialog(group="Storage losses"));
   parameter Modelica.SIunits.CoefficientOfHeatTransfer U( start=0.2)
    "U-Value of the Storage Wall" annotation(Dialog(group="Storage losses"));
   parameter Modelica.SIunits.Temperature Tstart(start=293.15, displayUnit="degC")
    "Starttemperature of the storage" annotation(Dialog(group="Initialization"));
   parameter Modelica.SIunits.TemperatureSlope der_T( start=0)
    "Time derivative of temperature (= der(T))" annotation(Dialog(group="Initialization"));
   parameter Modelica.SIunits.Density Rho=995.6 "Desity of the Store Fluid";
   parameter Modelica.SIunits.SpecificHeatCapacity Cp=4177
    "Specific Heat Capacity of the Store Fluid";

   Modelica.SIunits.Temperature T_actual "current storage temperature";
   Modelica.SIunits.Heat Stored_Heat
    "Stored heat refered to Referencetemperature";
   Modelica.SIunits.ThermalConductance G "Thermal conductance of the storage";
   Modelica.SIunits.Height Hboard
    "Height of the border between hot and cold parts of the store";
   Modelica.SIunits.Area Adown "Surface of the cold part of the store";
   Modelica.SIunits.Area Aup "Surface of the hot part of the store";
   Modelica.SIunits.Diameter D "Net-Diameter of the store";
   Modelica.SIunits.Temperature Tout=outside_temp
    "Outside Temperature from extern";

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heat_input
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heat_output
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor Store(
    T(start=Tstart, fixed=true),
    der_T(start=der_T),
    C=V*Rho*Cp)
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

  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature outside_temperature
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-68})));
  Others.VariableThermalConductor                           coat_losses
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-14})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor Heat_Losses annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-42})));

equation
T_actual=Store.T;
T_actual=store_temp;
Stored_Heat=Store.C*(T_actual-Tref);

D=sqrt((4*V)/(Modelica.Constants.pi*H));
H*(T_actual-Tref)=Hboard*(Tdown-Tref)+(H-Hboard)*(Tup-Tref);
Adown=D*D*Modelica.Constants.pi/4+D*Modelica.Constants.pi*Hboard;
Aup=D*D*Modelica.Constants.pi/4+D*Modelica.Constants.pi*(H-Hboard);
G=(U/(T_actual-Tout))*(Aup*(Tup-Tout)+Adown*(Tdown-Tout));
G=coat_losses.Thermal_conduct;

connect(heat_input, heat_output)
    annotation (Line(points={{-100,0},{0,0},{100,0}}, color={191,0,0}));

  connect(Store.port, heat_output)
    annotation (Line(points={{0,30},{0,0},{100,0}}, color={191,0,0}));
  connect(coat_losses.port_a,Heat_Losses. port_a) annotation (Line(points={{0,-24},
          {0,-24},{0,-32}},                         color={191,0,0}));
  connect(outside_temperature.port,Heat_Losses. port_b) annotation (Line(points={{0,-58},
          {0,-58},{0,-52}},                                        color={191,0,
          0}));
  connect(outside_temperature.T, outside_temp) annotation (Line(points={{-6.66134e-016,
          -80},{0,-80},{0,-104}}, color={0,0,127}));
  connect(coat_losses.port_b, heat_output)
    annotation (Line(points={{0,-4},{0,0},{100,0}}, color={191,0,0}));
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
          textString="Two Layer

Storage"),
        Text(
          extent={{-62,130},{66,106}},
          lineColor={28,108,200},
          textString="%name")}),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This storage model has finite energy storage capacitiy, given by the volume of the storage. </p>
<p>Thermal storage losses are considered by using the thermal U-value of the storage wall. </p>
<p>The model has two water layers (these physically don&apos;t exist, only by equations), a high temperature layer (Tup) at the top and a low temperature layer (Tdown) at the bottom. Between these two layers there is a boarder. </p>
<p>Dependent to the store temperature, the boarder rises or falls. With the boarder height the thermal conductance of the store wall is calculated, so that the heat flow loss of the single heat capacity equals to the two layer storage model. </p>
</html>"));
end StorageTwoLayer;
