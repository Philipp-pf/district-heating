within DistrictHeating.Components.Control;
model MeanBoilerHeat
  "Control keeps boiler heat flow constant over defined time period"

  parameter Modelica.SIunits.Time TimeConstant
    "time over which the boiler heat flow keeps constant";
  parameter Modelica.SIunits.Temperature Tmax "max temperature of the store"                                   annotation (Dialog(group="Store"));
  parameter Real khigh1=1.3 "gain to fill store, high"    annotation (Dialog(group="Store"));
  parameter Modelica.SIunits.Temperature Thigh
    "upper temperature boarder of the store" annotation (Dialog(group="Store"));
  parameter Real khigh2=1.2 "gain to fill store, low"    annotation (Dialog(group="Store"));
  parameter Modelica.SIunits.Temperature Tlow
    "low temperature boarder of the store" annotation (Dialog(group="Store"));
  parameter Real klow2=1.1 "gain to unfill store, high"    annotation (Dialog(group="Store"));
  parameter Modelica.SIunits.Temperature Tmin "min temperature of the store"                                   annotation (Dialog(group="Store"));
  parameter Real klow1=1 "gain to unfill store, low"    annotation (Dialog(group="Store"));
  parameter Boolean preYstart= false
    "startvalue for hysteresis (if store temp is going to reach Tlow before Thigh then choose true)"
    annotation (Dialog(group="Initialization"));

  Modelica.SIunits.Temperature Tstore "actual temperature of the store";
  Modelica.SIunits.HeatFlowRate BoilerHeatFlow
    "boiler heat flow that is constant over TimeConstant";
  Real k
    "factor, which is multiplied with average used heat flwo to define boiler heat flow";

  Modelica.Blocks.Math.Mean meanHeat(
    f=1/TimeConstant,
    yGreaterOrEqualZero=true,
    x0=0)
    annotation (Placement(transformation(extent={{-60,-100},{-40,-80}})));
  Modelica.Blocks.Interfaces.RealInput u "consumer heat flow"
    annotation (Placement(transformation(extent={{-132,-20},{-92,20}})));
  Modelica.Blocks.Interfaces.RealOutput y "boiler heat flow"
    annotation (Placement(transformation(extent={{98,-10},{118,10}})));
  Modelica.Blocks.Interfaces.RealInput u1 "store temperature" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,104})));

  Modelica.Blocks.Logical.Hysteresis hysteresis(
    pre_y_start=preYstart,
    uLow=Tmin,
    uHigh=Tmax)            annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-10})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{40,-100},{60,-80}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis2(
    pre_y_start=false,
    uLow=Tlow,
    uHigh=Thigh)           annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={50,76})));
  Modelica.Blocks.Logical.Switch mainSwitch annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-50})));
  Modelica.Blocks.Logical.Switch switchlow annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={50,-10})));
  Modelica.Blocks.Logical.Switch switchup annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-50,-10})));
  Modelica.Blocks.Logical.Not not1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-30,60})));
  Modelica.Blocks.Sources.Constant high1(k=khigh1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-30,30})));
  Modelica.Blocks.Sources.Constant high2(k=khigh2) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-72,30})));
  Modelica.Blocks.Sources.Constant low2(k=klow2) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={30,30})));
  Modelica.Blocks.Sources.Constant low1(k=klow1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={70,30})));
equation
  u1 = Tstore;
  BoilerHeatFlow = y;
  k=product.u1;

  connect(u, meanHeat.u) annotation (Line(points={{-112,0},{-78,0},{-78,-90},{-62,
          -90}},color={0,0,127}));
  connect(hysteresis.u, u1)
    annotation (Line(points={{2.22045e-015,2},{2.22045e-015,92},{0,92},{0,104}},
                                              color={0,0,127}));
  connect(product.y, y)
    annotation (Line(points={{61,-90},{76,-90},{76,0},{108,0}},
                                              color={0,0,127}));
  connect(switchup.y, mainSwitch.u3) annotation (Line(points={{-50,-21},{-50,-30},
          {-8,-30},{-8,-38}}, color={0,0,127}));
  connect(switchlow.y, mainSwitch.u1) annotation (Line(points={{50,-21},{50,-30},
          {8,-30},{8,-38}}, color={0,0,127}));
  connect(hysteresis.y, mainSwitch.u2)
    annotation (Line(points={{0,-21},{0,-38}}, color={255,0,255}));
  connect(hysteresis2.y, switchlow.u2)
    annotation (Line(points={{50,65},{50,2}}, color={255,0,255}));
  connect(switchup.u2, not1.y)
    annotation (Line(points={{-50,2},{-50,60},{-41,60}}, color={255,0,255}));
  connect(not1.u, switchlow.u2) annotation (Line(points={{-18,60},{-18,60},{50,60},
          {50,2}}, color={255,0,255}));
  connect(product.u1, mainSwitch.y) annotation (Line(points={{38,-84},{38,-76},{
          0,-76},{0,-61}}, color={0,0,127}));
  connect(meanHeat.y, product.u2) annotation (Line(points={{-39,-90},{-26,-90},{
          0,-90},{0,-96},{38,-96}}, color={0,0,127}));
  connect(switchlow.u1, low1.y) annotation (Line(points={{58,2},{58,10},{70,10},
          {70,19}}, color={0,0,127}));
  connect(low2.y, switchlow.u3) annotation (Line(points={{30,19},{30,19},{30,10},
          {42,10},{42,2}}, color={0,0,127}));
  connect(switchup.u1,high1. y) annotation (Line(points={{-42,2},{-42,8},{-30,8},
          {-30,19}}, color={0,0,127}));
  connect(switchup.u3, high2.y) annotation (Line(points={{-58,2},{-58,8},{-72,8},
          {-72,19}}, color={0,0,127}));
  connect(hysteresis2.u, u1) annotation (Line(points={{50,88},{50,96},{24,96},{24,
          74},{0,74},{2.22045e-015,92},{0,92},{0,104}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          visible=true,
          points={{-80,78},{-80,-90}},
          color={192,192,192}),
        Polygon(
          visible=true,
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid,
          points={{-80,90},{-88,68},{-72,68},{-80,90}}),
        Line(
          visible=true,
          points={{-90,-80},{82,-80}},
          color={192,192,192}),
        Polygon(
          visible=true,
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid,
          points={{90,-80},{68,-72},{68,-88},{90,-80}}),
        Text(
          lineColor={192,192,192},
          extent={{-52,8},{48,48}},
          textString="control"),
        Text(
          lineColor={192,192,192},
          extent={{-52,42},{48,82}},
          textString="boiler"),
        Line(points={{-80,-80},{-58,-40},{-36,-26},{-10,-22},{14,-32},{44,-30},
              {56,-24},{68,-30}},color={0,0,255}),
        Line(points={{-80,-80},{-66,-80},{-66,-62},{-54,-62},{-54,-48},{-42,-48},
              {-42,-36},{-28,-36},{-28,-30},{-14,-30},{-14,-24},{-2,-24},{-2,-30},
              {8,-30},{8,-38},{18,-38},{18,-34},{30,-34},{30,-32},{40,-32},{40,
              -28},{48,-28},{48,-22},{58,-22},{58,-18},{64,-18},{64,-24},{72,-24}},
            color={255,0,0}),
        Text(
          extent={{-92,-102},{88,-140}},
          lineColor={28,108,200},
          textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=
            false)),
    Documentation(info="<html>
<p>This control object calculates the average consumer heat flow of a defined time (parameter TimeConstant).</p>
<p>Dependent to the store temperature a gain is used to multiply with the average consumer heat flow. This calcluated heat flow is the output which defines the boiler heat flow. </p>
<p>Gain is chosen as follows: </p>
<p>If the stored heat (store temperature) is between the two boarders Thigh and Tlow then the gain khigh1 is used. This gain should be chosen so that the store gets loaded. If the store temperature reaches the temperature Thigh, the gain decreases to khigh2. If the storage temperature reaches the temperature Tmax, gain further decreases (klow1). Klow1 should be chosen so that the storage temperature decreases. If the temperature gets lower than Tlow, gain is raised to klow2. If the temperature reaches Tmin then gain is raised to khigh2 again. </p>
<p>The following diagramm shows the description. The upper picture shows the store temperature and the temperature limits. The lower picture the gain. </p>
<p><img src=\"modelica://DistrictHeating/Resources/Images/Gain.png\"/></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">The gain factors should be chosen: khigh1&GT;khigh2&GT;klow2&GT;klow1.</span></p>
<p><br><span style=\"font-family: MS Shell Dlg 2;\">To avoid oscillation, two hysteresis object are used to define gain k. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">If gain k keeps constant over TimeConstant, the boiler heat flow also keeps constant over the whole TimeConstant. If gain k changes during TimeConstant, also the boiler heat flow changes. </span></p>
</html>"));
end MeanBoilerHeat;
