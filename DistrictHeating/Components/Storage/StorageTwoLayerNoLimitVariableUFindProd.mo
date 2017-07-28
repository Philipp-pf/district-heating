within DistrictHeating.Components.Storage;
model StorageTwoLayerNoLimitVariableUFindProd

    parameter Modelica.SIunits.Volume V "Storage Volume";
    parameter Modelica.SIunits.Height H "Storage Height";
    parameter Modelica.SIunits.Temperature Thigh
    "Temperature of the upper Storage Part" annotation(Dialog(group="Temperatures"));
    parameter Modelica.SIunits.Temperature Tlow
    "Temperature of the lower Storage Part" annotation(Dialog(group="Temperatures"));
    parameter Modelica.SIunits.Temperature Tref
    "Reference Temperature of the Storage" annotation(Dialog(group="Temperatures"));
    parameter Modelica.SIunits.Density rho=995.6
    "Density of the storage medium"                                              annotation(Dialog(group="Medium"));
    parameter Modelica.SIunits.SpecificHeatCapacity cp=4177
    "specific heat capacity of the storage medium" annotation(Dialog(group="Medium"));
   Modelica.SIunits.CoefficientOfHeatTransfer  U "U-Value of the Storage";

   constant Real pi=Modelica.Constants.pi;

   Modelica.SIunits.Volume Vhigh "Volume of the upper Storage Part";
   Modelica.SIunits.Volume Vlow "Volume of the lower Storage Part";
   Modelica.SIunits.Diameter D( start=2)
    "Storage Diameter (aproximative value)";
   Modelica.SIunits.Height Hboard( start=15)
    "Height of the boarder between hot and cold layer from ground (Hstart=0: Store fully loaded, Hstart=H: Store 'empty')";
   Modelica.SIunits.Heat Q
    "Stored heat in reference to the  reference temperature";
   Modelica.SIunits.HeatFlowRate Qload "Heat flow that loads up the storage";
   Modelica.SIunits.HeatFlowRate Qunload "Heat flow that unloads the storage";
   Modelica.SIunits.HeatFlowRate Qloss "Store Losses";
   Modelica.SIunits.Temperature Tout "Outside Temperature";
    //symbols
    Modelica.SIunits.Heat Q_store=cp*rho*(Vhigh*(Thigh-Tref)+Vlow*(Tlow-Tref))
    "stored heat refering to reference temperature";
    Modelica.SIunits.Heat Qmax_store=V*cp*rho*(Thigh-Tref)
    "maximal stored heat refering to reference temperature";
    Modelica.SIunits.Heat Qmin_store=V*cp*rho*(Tlow-Tref)
    "minimal stored heat refering to reference temperature";
    Modelica.SIunits.Heat HeatStoreOnlyHot "stored heat only hot layer";

Modelica.SIunits.HeatFlowRate ResultPower;

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealInput u "Outsidetemperature" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-114})));

  Modelica.Blocks.Interfaces.RealInput u1 "U-Value"           annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-106,-70})));
  Modelica.Blocks.Interfaces.RealInput u2 "Store energy"      annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,106})));
equation
  V=H*(D*D*pi)/4 "calculation for Store Diameter";
  Vhigh+Vlow=V "Sum of store volume";
  Vlow=Hboard*(D*D*pi)/4 "Store volume of low temperature";
  Q=cp*rho*(Vhigh*(Thigh-Tref)+Vlow*(Tlow-Tref))
    "Stored Heat reffered to referencetemperature";
  Qloss= U*((D*pi*Hboard)*(Tlow-Tout)+((D*D*pi)/4+D*pi*(H-Hboard))*(Thigh-Tout))
    "Store losses (D*D*pi)/4+";
  Qunload=-port_b.Q_flow "unloading heat flow";
  der(Q)=Qload-Qunload-Qloss "first thermodynamic law";
  port_b.T=Thigh "temperature of ports";

  u=Tout "Input outside temperature";

  assert(
    0 <= Hboard,
    "Storage is out of upper limit (overloaded)",
    AssertionLevel.warning);
  assert(
    H >= Hboard,
    "Storage is out of lower limit (underloaded)",
    AssertionLevel.warning);

HeatStoreOnlyHot=Vhigh*cp*rho*(Thigh-Tref);
U=u1;
u2=Q;
ResultPower=Qload-Qunload-Qloss;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-60,80},{60,-20}},
          lineColor={255,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,-20},{60,-80}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,0}),
        Rectangle(extent={{-60,80},{60,-80}}, lineColor={0,0,0}),
        Text(
          extent={{-88,140},{88,98}},
          lineColor={0,0,0},
          textString="%name"),
        Text(
          extent={{-46,62},{48,-66}},
          lineColor={0,0,0},
          textString="2")}),                                     Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This storage model has two layers. Between the two layers there is a &QUOT;boarder layer&QUOT;. The upper part of the storage (above the boarder has high temperature. The lower part of the storage has lower temperature. To get a two layer store in real, it is neccessary that the storage height is much higher than the diameter (H&GT;&GT;D). </p>
<p>The model assumes, that the boarder layer has a thickness of zero. </p>
<p>The temperatures of the upper and lower layer are constant. Store losses don&apos;t cause a temperature decrease in the layer, they cause an increase of the boarder height (higher boarder height means lower stored heat). </p>
<p>This model has no limits in physical boarder height. For true simulation results it is neccessary that the boarder height always stays within the physical boarders of the storage (0&LT;=Hboard&LT;=H).</p>
</html>"));
end StorageTwoLayerNoLimitVariableUFindProd;
