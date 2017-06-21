within DistrictHeating.Components.Control;
model MeanBoilerHeatTwoLayer
  "Control keeps boiler heat flow constant over defined time period"

  parameter Modelica.SIunits.Time TimeConstant
    "time over which the boiler heat flow keeps constant";
  parameter Modelica.SIunits.Height Hhighload1
    "highest store load (lowest value of boarder height)"      annotation (Dialog(group="Store"));
  parameter Real khigh1=1.3 "gain to fill store, high"    annotation (Dialog(group="Store"));
  parameter Modelica.SIunits.Height Hhighload2
    "high store load (low value of boarder height)"                                          annotation (Dialog(group="Store"));
  parameter Real khigh2=1.2 "gain to fill store, low"    annotation (Dialog(group="Store"));
  parameter Modelica.SIunits.Height Hlowload2
    "low store load (high value of boarder height)"                                        annotation (Dialog(group="Store"));
  parameter Real klow2=1.1 "gain to unfill store, high"    annotation (Dialog(group="Store"));
  parameter Modelica.SIunits.Height Hlowload1
    "lowest store load (highest value of boarder height)"                                         annotation (Dialog(group="Store"));
  parameter Real klow1=1 "gain to unfill store, low"    annotation (Dialog(group="Store"));
  parameter Boolean preYstart= false
    "startvalue for hysteresis (if store temp is going to reach Tlow before Thigh then choose true)"
    annotation (Dialog(group="Initialization"));

  Modelica.SIunits.Height Hstore "actual boarderheight of the store";
  Modelica.SIunits.HeatFlowRate BoilerHeatFlow
    "boiler heat flow that is constant over TimeConstant";
  Real k
    "factor, which is multiplied with average used heat flwo to define boiler heat flow";

  Modelica.Blocks.Math.Mean meanHeat(
    f=1/TimeConstant,
    yGreaterOrEqualZero=true,
    x0=0)
    annotation (Placement(transformation(extent={{-60,-86},{-40,-66}})));
  Modelica.Blocks.Interfaces.RealInput u "consumer heat flow"
    annotation (Placement(transformation(extent={{-132,-20},{-92,20}})));
  Modelica.Blocks.Interfaces.RealOutput y "boiler heat flow"
    annotation (Placement(transformation(extent={{98,-10},{118,10}})));
  Modelica.Blocks.Interfaces.RealInput u1 "store boarderheight"
                                                              annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,104})));

  Modelica.Blocks.Logical.Hysteresis hysteresis(
    pre_y_start=preYstart,
    uLow=Hhighload1,
    uHigh=Hlowload1)       annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-10})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{40,-80},{60,-60}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis2(
    pre_y_start=false,
    uLow=Hhighload2,
    uHigh=Hlowload2)       annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={50,60})));
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
  Modelica.Blocks.Sources.Constant high1(k=khigh1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={70,30})));
  Modelica.Blocks.Sources.Constant high2(k=khigh2) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={30,30})));
  Modelica.Blocks.Sources.Constant low2(k=klow2) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-30,30})));
  Modelica.Blocks.Sources.Constant low1(k=klow1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-70,30})));
equation
  u1 = Hstore;
  BoilerHeatFlow = y;
  k=product.u1;

  connect(u, meanHeat.u) annotation (Line(points={{-112,0},{-78,0},{-78,-76},{-62,
          -76}},color={0,0,127}));
  connect(hysteresis.u, u1)
    annotation (Line(points={{2.22045e-015,2},{2.22045e-015,92},{0,92},{0,104}},
                                              color={0,0,127}));
  connect(product.y, y)
    annotation (Line(points={{61,-70},{76,-70},{76,0},{108,0}},
                                              color={0,0,127}));
  connect(switchup.y, mainSwitch.u3) annotation (Line(points={{-50,-21},{-50,-30},
          {-8,-30},{-8,-38}}, color={0,0,127}));
  connect(switchlow.y, mainSwitch.u1) annotation (Line(points={{50,-21},{50,-30},
          {8,-30},{8,-38}}, color={0,0,127}));
  connect(product.u1, mainSwitch.y) annotation (Line(points={{38,-64},{38,-64},{
          0,-64},{0,-61}}, color={0,0,127}));
  connect(meanHeat.y, product.u2) annotation (Line(points={{-39,-76},{-39,-76},{
          38,-76}},                 color={0,0,127}));
  connect(hysteresis.y, mainSwitch.u2)
    annotation (Line(points={{0,-21},{0,-21},{0,-38}}, color={255,0,255}));
  connect(hysteresis2.y, switchlow.u2)
    annotation (Line(points={{50,49},{50,49},{50,2}},   color={255,0,255}));
  connect(switchup.u2, switchlow.u2) annotation (Line(points={{-50,2},{-50,10},{
          -50,10},{-50,16},{50,16},{50,2}},
                          color={255,0,255}));
  connect(hysteresis2.u, u1) annotation (Line(points={{50,72},{50,76},{0,76},{0,
          92},{0,104}}, color={0,0,127}));
  connect(high1.y, switchlow.u1) annotation (Line(points={{70,19},{70,10.5},{58,
          10.5},{58,2}}, color={0,0,127}));
  connect(low1.y, switchup.u3) annotation (Line(points={{-70,19},{-70,12},{-58,
          12},{-58,2}}, color={0,0,127}));
  connect(low2.y, switchup.u1) annotation (Line(points={{-30,19},{-30,10},{-42,
          10},{-42,2}}, color={0,0,127}));
  connect(high2.y, switchlow.u3) annotation (Line(points={{30,19},{30,12},{42,
          12},{42,2}}, color={0,0,127}));
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
<p>Dependent to the boarder height a gain is used to multiply with the average consumer heat flow. This calcluated heat flow is the output which defines the boiler heat flow. </p>
<p>Gain is chosen as follows: </p>
<p>If the stored heat (boarder height) is between the two boarders Hhighload2 and Hlowload2 then the gain khigh1 is used. This gain should be chosen so that the store gets loaded. If the boarder height reaches Hhighload2, the gain decreases to khigh2. If the boarder height reaches Hhighload1, gain further decreases (klow1). Klow1 should be chosen so that the storage unloads. If the boarder height reaches Hlowload2, gain is raised to klow2. If the temperature reaches Hlowloa1 then gain is raised to khigh1 again. </p>
<p>Maximal boarder height means that the store is completely unloaded. Minimal boarder height means that the store is completeley loaded.</p>
<p><br>The following diagramm shows the description. The upper picture shows the boarder height and the limits. The lower picture shows the gain. </p>
<p><br><img src=\"modelica://DistrictHeating/Resources/Images/Gain2.png\"/></p>
<p><br><span style=\"font-family: MS Shell Dlg 2;\">The gain factors should be chosen: khigh1&GT;khigh2&GT;klow2&GT;klow1.</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Height values are: Hhighload1&LT;Hhighload2&LT;Hlowload2&LT;Hlowload1,</span></p>
<p><br><span style=\"font-family: MS Shell Dlg 2;\">To avoid oscillation, two hysteresis object are used to define gain k. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">If gain k keeps constant over TimeConstant, the resulting boiler heat flow also keeps constant over the whole TimeConstant. If gain k changes during TimeConstant, also the resulting boiler heat flow changes. </span></p>
</html>"));
end MeanBoilerHeatTwoLayer;
