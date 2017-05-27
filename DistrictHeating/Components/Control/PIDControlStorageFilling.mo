within DistrictHeating.Components.Control;
block PIDControlStorageFilling "PID controller for storage filling"
  import Modelica.Blocks.Types.InitPID;
  import Modelica.Blocks.Types.Init;
  extends Modelica.Blocks.Interfaces.SISO;

  parameter Real k(unit="1")=1 "Gain";
  parameter Modelica.SIunits.Time Ti(min=Modelica.Constants.small, start=0.5)
    "Time Constant of Integrator";
  parameter Modelica.SIunits.Time Td(min=0, start=0.1)
    "Time Constant of Derivative block";
  parameter Real Nd(min=Modelica.Constants.small) = 10
    "The higher Nd, the more ideal the derivative block";
 parameter Boolean useExternVariable = false
    "=true, if control target of the storage fill is an extern variable"  annotation (choices(checkBox=true),Dialog(group="Store Fill"));
 parameter Real Target_Store_Fill
    "Storage load that should be reached if extern variable is disabled"                               annotation (Dialog(enable= not useExternVariable,group="Store Fill"));
 parameter Modelica.SIunits.Time DelayTime=0
    "Delay time of extern input signal"    annotation (Dialog(enable= useExternVariable,group="Store Fill"));
  parameter Modelica.Blocks.Types.InitPID initType= Modelica.Blocks.Types.InitPID.DoNotUse_InitialIntegratorState
    "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)"
                                     annotation(Evaluate=true,
      Dialog(group="Initialization"));
  parameter Real xi_start=0
    "Initial or guess value value for integrator output (= integrator state)"
    annotation (Dialog(group="Initialization"));
  parameter Real xd_start=0
    "Initial or guess value for state of derivative block"
    annotation (Dialog(group="Initialization"));
  parameter Real y_start=0 "Initial value of output"
    annotation(Dialog(enable=initType == InitPID.InitialOutput, group=
          "Initialization"));
  constant Modelica.SIunits.Time unitTime=1 annotation (HideResult=true);

  Modelica.Blocks.Math.Gain P(k=1) "Proportional part of PID controller"
    annotation (Placement(transformation(extent={{0,60},{20,80}},    rotation=0)));
  Modelica.Blocks.Continuous.Integrator I(
    k=unitTime/Ti,
    y_start=xi_start,
    initType=if initType == InitPID.SteadyState then Init.SteadyState else if
        initType == InitPID.InitialState or initType == InitPID.DoNotUse_InitialIntegratorState
         then Init.InitialState else Init.NoInit)
    "Integral part of PID controller" annotation (Placement(transformation(
          extent={{0,-10},{20,10}},   rotation=0)));
  Modelica.Blocks.Continuous.Derivative D(
    k=Td/unitTime,
    T=max([Td/Nd,100*Modelica.Constants.eps]),
    x_start=xd_start,
    initType=if initType == InitPID.SteadyState or initType == InitPID.InitialOutput
         then Init.SteadyState else if initType == InitPID.InitialState then
        Init.InitialState else Init.NoInit) "Derivative part of PID controller"
    annotation (Placement(transformation(extent={{0,-80},{20,-60}},    rotation=
           0)));
  Modelica.Blocks.Math.Gain Gain(k=k) "Gain of PID controller" annotation (
      Placement(transformation(extent={{72,-10},{92,10}}, rotation=0)));
  Modelica.Blocks.Math.Add3 Add annotation (Placement(transformation(extent={{40,
            -10},{60,10}}, rotation=0)));
  Modelica.Blocks.Math.Feedback feedback annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-60,0})));
  Modelica.Blocks.Interfaces.RealInput u1 if   useExternVariable
    "store filling target"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120}),iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
  Modelica.Blocks.Nonlinear.FixedDelay fixedDelay(delayTime=DelayTime)
                                                               annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-50,-76})));
initial equation
  if initType==InitPID.InitialOutput then
     y = y_start;
  end if;

equation

 if useExternVariable then
   feedback.u1=fixedDelay.u;
 else
   feedback.u1=Target_Store_Fill;
 end if;

if not useExternVariable then
  fixedDelay.u=0;
end if;

  connect(P.y, Add.u1) annotation (Line(points={{21,70},{30,70},{30,8},{38,8}},
        color={0,0,127}));
  connect(I.y, Add.u2)
    annotation (Line(points={{21,0},{21,0},{38,0}},
                                              color={0,0,127}));
  connect(D.y, Add.u3) annotation (Line(points={{21,-70},{21,-70},{30,-70},{30,-8},
          {38,-8}},
                color={0,0,127}));
  connect(Add.y, Gain.u)
    annotation (Line(points={{61,0},{70,0}}, color={0,0,127}));
  connect(Gain.y, y)
    annotation (Line(points={{93,0},{110,0}}, color={0,0,127}));
  connect(feedback.y, I.u)
    annotation (Line(points={{-51,0},{-51,0},{-2,0}},   color={0,0,127}));
  connect(P.u, I.u) annotation (Line(points={{-2,70},{-20,70},{-20,0},{-2,0}},
        color={0,0,127}));
  connect(D.u, I.u) annotation (Line(points={{-2,-70},{-20,-70},{-20,0},{-2,0}},
        color={0,0,127}));
  connect(feedback.u2, u) annotation (Line(points={{-60,-8},{-60,-20},{-80,-20},
          {-80,0},{-120,0}}, color={0,0,127}));
  connect(fixedDelay.u, u1) annotation (Line(points={{-38,-76},{-34,-76},{-28,-76},
          {-28,-90},{0,-90},{0,-120}}, color={0,0,127}));
  annotation (defaultComponentName="PID",
    Icon(
        coordinateSystem(preserveAspectRatio=true,
            extent={{-100.0,-100.0},{100.0,100.0}},
            initialScale=0.1),
            graphics={
        Line(visible=true,
            points={{-80.0,78.0},{-80.0,-90.0}},
            color={192,192,192}),
      Polygon(visible=true,
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid,
          points={{-80.0,90.0},{-88.0,68.0},{-72.0,68.0},{-80.0,90.0}}),
      Line(visible=true,
          points={{-90.0,-80.0},{82.0,-80.0}},
          color={192,192,192}),
      Polygon(visible=true,
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid,
          points={{90.0,-80.0},{68.0,-72.0},{68.0,-88.0},{90.0,-80.0}}),
      Text(
          lineColor={192,192,192},
          extent={{-52,8},{48,48}},
          textString="control"),
      Text(
          lineColor={192,192,192},
          extent={{-52,42},{48,82}},
          textString="store"),
        Line(points={{-80,-80},{-58,-40},{-36,-26},{-10,-22},{14,-32},{44,-30},{
              56,-24},{68,-30}}, color={0,0,255})}),
    Documentation(info="<html>
<p><span style=\"font-family: Arial;\">This controller is used to control the storage loading. Therefore there are two possibilities. One possibility is to use an intern target for the storage loading (Target_Store_Fill) as parameter. The other possibility is to activate an Real Input, which allows an extern variable target for the storage loading. The extern storage target allows also an delay time. </span></p>
<p><span style=\"font-family: Arial;\">It doesn&apos;t matter, whether the controller input unit is temperature or heat, as long as the parameter Target_Store_Fill or the extern target have the same unit. </span></p>
<p><br><span style=\"font-family: Arial;\">The rest of the object comes from Modelica.Blocks.Continuous.PID. Description therefore:</span></p>
<p><br><span style=\"font-family: Arial,sans-serif;\">This is the text-book version of a PID-controller. For a more practically useful PID-controller, use block LimPID. </span></p>
<p><span style=\"font-family: Arial,sans-serif;\">The PID block can be initialized in different ways controlled by parameter <b>initType</b>. The possible values of initType are defined in <a href=\"modelica://Modelica.Blocks.Types.InitPID\">Modelica.Blocks.Types.InitPID</a>. This type is identical to <a href=\"modelica://Modelica.Blocks.Types.Init\">Types.Init</a>, with the only exception that the additional option <b>DoNotUse_InitialIntegratorState</b> is added for backward compatibility reasons (= integrator is initialized with InitialState whereas differential part is initialized with NoInit which was the initialization in version 2.2 of the Modelica standard library). </span></p>
<p><span style=\"font-family: Arial,sans-serif;\">Based on the setting of initType, the integrator (I) and derivative (D) blocks inside the PID controller are initialized according to the following table: </span></p>
<p><img src=\"modelica://DistrictHeating/Resources/Images/PID_Table.png\"/></p><p><span style=\"font-family: Arial,sans-serif;\">In many cases, the most useful initial condition is <b>SteadyState</b> because initial transients are then no longer present. If initType = InitPID.SteadyState, then in some cases difficulties might occur. The reason is the equation of the integrator: </span></p>
<p><span style=\"font-family: Arial,sans-serif;\">der</span><span style=\"font-family: Courier New,monospace;\">(y) = k*u;</span><code> </code></p>
<p><span style=\"font-family: Arial,sans-serif;\">The steady state equation &QUOT;der(x)=0&QUOT; leads to the condition that the input u to the integrator is zero. If the input u is already (directly or indirectly) defined by another initial condition, then the initialization problem is <b>singular</b> (has none or infinitely many solutions). This situation occurs often for mechanical systems, where, e.g., u = desiredSpeed - measuredSpeed and since speed is both a state and a derivative, it is natural to initialize it with zero. As sketched this is, however, not possible. The solution is to not initialize u or the variable that is used to compute u by an algebraic equation. </span></p>
</html>"));
end PIDControlStorageFilling;
