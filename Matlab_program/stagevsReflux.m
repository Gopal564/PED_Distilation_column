warning off;
% Using McCabe Thiele Method

% Given Variable
x_f = 0.205663189;
x_d = 0.9;
x_w = 0.05;
q = 1;
alpha = 2.392509367;
efficiency = 0.7;
options = optimset('display' , 'off');

% plotting the 45 degree line for the equilibrium plot
%plot([0 1], [0 1],'k');
%grid on;
%hold on;
xlabel('Reflux Ratio');ylabel('Stages');

% The equilibrium curve and plotting it
y_eq = @(x) alpha * x / (1 - (1 - alpha) * x);
x_eq = @(y) y / (alpha + (1 - alpha) * y);
%fplot(y_eq, [0 1],'r',LineWidth=0.20);
%set(gca, 'xlim', [0 1]);
%set(gca, 'ylim', [0 1]);

% feed line or q line
q_slope = q / (q - 1);
q_intersept = -x_f / (q - 1);
q_eqn = @(x) q_slope * x + q_intersept;
if q > 1
    %fplot(q_eqn,[x_f y_eq(x_f)])
elseif q == 1
    %plot([x_f x_f],[x_f y_eq(x_f)],'b')
elseif q == 0
    %plot([x_eq(x_f) x_f],[x_f x_f],'b')
elseif q > 0 && q < 1
    %x_lim = fsolve(@(x) q_eqn(x) - y_eq(x),x_f,options);
    %fplot(q_eqn,[x_lim x_f])
end


% R_min and R calculation
if q == 1
    x_pinch = x_f;
else
    x_pinch = fsolve(@(x) q_eqn(x) - y_eq(x),x_f,options);
end
y_pinch = y_eq(x_pinch);

R_min_slope = (x_d - y_pinch)/(x_d - x_pinch);
R_min_intersept = x_d * (1 - R_min_slope);
R_min = x_d / R_min_intersept - 1;

Actual_Stages = zeros(1,size(1.05: 0.05 : 2.0,2));
Ideal_Stages = zeros(1,size(1.05: 0.05 : 2.0,2));
Rect_Stages = zeros(1,size(1.05: 0.05 : 2.0,2));
Strip_Stages = zeros(1,size(1.05: 0.05 : 2.0,2));
Ac_Rect_Stages = zeros(1,size(1.05: 0.05 : 2.0,2));
Ac_Strip_Stages = zeros(1,size(1.05: 0.05 : 2.0,2));
i = 1;
for Ratio = 1.05:0.05:2.0

    R_pinch_line = @(x) R_min/(R_min+1) * x + x_d / (R_min + 1);
    %fplot(R_pinch_line, [0 x_d])
    R = Ratio*R_min;
    % Rectifying Section operating line
    Rec_op_line = @(x) R/(R+1) * x + x_d / (R + 1);
    
    % Stripping Section operating line
    % Finding the intersection of the q and rec_op_line
    if q == 1
        x_intr_point = x_f;
    else
        x_intr_point = fsolve(@(x) Rec_op_line(x) - q_eqn(x), x_f, options);
    end
    y_intr_point = Rec_op_line(x_intr_point);
    % plotting the Rectifying Section operating line and stripping section operating line
    %plot([x_d x_intr_point], [x_d y_intr_point]);
    %plot([x_intr_point x_w], [y_intr_point x_w]);
    
    % Rectifying Section Stages
    x_re_stage_hor_1 = x_d;
    y_re_stage_hor_1 = x_d;
    rectifying_counter = 0;
    while x_re_stage_hor_1 > x_intr_point
        
        y_re_stage_hor_2 = y_re_stage_hor_1;
        x_re_stage_hor_2 = x_eq(y_re_stage_hor_2);
        x_re_stage_ver = x_re_stage_hor_2;
        y_re_stage_ver = Rec_op_line(x_re_stage_ver);
    
        % Plotting the stage
        %plot([x_re_stage_hor_1, x_re_stage_hor_2], [y_re_stage_hor_1 y_re_stage_hor_2],'m');
        %plot([x_re_stage_hor_2, x_re_stage_ver], [y_re_stage_hor_2 y_re_stage_ver],'m');
        
        re_stage_x = x_re_stage_hor_1;
        x_re_stage_hor_1 = x_re_stage_ver;
        y_re_stage_hor_1 = y_re_stage_ver;
        
        rectifying_counter =rectifying_counter + 1;
    end
    
    rectifying_stages = rectifying_counter - ...
        (x_re_stage_hor_2 - x_intr_point)/(x_re_stage_hor_2 - re_stage_x);
    
    Rect_Stages(i) = Rect_Stages(i) + ceil(rectifying_stages); 
    % Stripping Section Stages
    
    % stripping section equation
    strp_slope = (x_w - y_intr_point)/(x_w - x_intr_point);
    strp_intrcpt = x_w - strp_slope * x_w;
    strp_eq_x = @(y) (y - strp_intrcpt)/strp_slope;
    
    str_stage_x_ver_1 = x_w;
    str_stage_y_ver_1 = x_w;
    str_counter = 0;
    
    while str_stage_y_ver_1 < y_intr_point
    
        str_stage_x_ver_2 = str_stage_x_ver_1;
        str_stage_y_ver_2 = y_eq(str_stage_x_ver_2);
        str_stage_y_hor = str_stage_y_ver_2;
        str_stage_x_hor = strp_eq_x(str_stage_y_hor);
        
        % Plotting the stage
        %plot([str_stage_x_ver_1 str_stage_x_ver_2], [str_stage_y_ver_1 str_stage_y_ver_2],Color=[1 .2 0]);
        %plot([str_stage_x_ver_2 str_stage_x_hor], [str_stage_y_ver_2 str_stage_y_hor],Color=[1 .2 0]);
        
        str_stage_y = str_stage_y_ver_1;
        str_stage_x_ver_1 = str_stage_x_hor;
        str_stage_y_ver_1 = str_stage_y_hor;
    
        str_counter = str_counter + 1;
    
    end
    
    stripping_stages = str_counter - ...
        (y_re_stage_hor_2-y_intr_point)/(y_re_stage_hor_2 - str_stage_y);
    
    Strip_Stages(i) = Strip_Stages(i) + ceil(stripping_stages);
    Ideal_Stages(i) = Ideal_Stages(i) + ceil(stripping_stages+rectifying_stages)+1;
    no_act_stages_re = ceil(rectifying_stages/efficiency);
    Ac_Rect_Stages(i) = Ac_Rect_Stages(i) + no_act_stages_re;
    no_act_stages_str = ceil(stripping_stages/efficiency);
    Ac_Strip_Stages(i) = Ac_Strip_Stages(i) + no_act_stages_str;
    %fprintf("\n The Number of Theoretical Stages in the distillation column is %4.2f.\n",rectifying_stages+stripping_stages);
    %fprintf("\n The Number of Actual Stages in the distillation column is %2.0f.\n",no_act_stages_str+no_act_stages_re);
    
    
    Actual_Stages(i) = Actual_Stages(i) + (no_act_stages_str+no_act_stages_re+1); 
    i = i + 1;

end
rat = 1.05:0.05:2.0;
plot(rat, Actual_Stages);
set(gca, 'xlim', [1.0 2.1]);
set(gca, 'ylim', [13 32]);
ylabel("Number of Stages");xlabel("R/R_m");
set(gca,'FontSize',15);
plot_data = [rat;Rect_Stages; Strip_Stages; Ideal_Stages;Ac_Rect_Stages; Ac_Strip_Stages;Actual_Stages]';


