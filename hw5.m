clear all
close all

XMIN = -10;
XMAX = 10;
YMIN = -10;
YMAX = 10;

% 
% figure(2)
% axis([XMIN XMAX YMIN YMAX])
% arrow3([1 2],[3 5]);


x = 0; y=0; theta=0;
% f_h = figure(1);
% plot(x,y, 'r*')
% hold on
% axis([XMIN XMAX YMIN YMAX])


%Goal Coordinates
xg=5;  %Desired goal location in XI
yg=5;  %Desired goal location in YI

d_t = 0.01;  %Time step for the c-l feedback loop in seconds

%Control Parameters
%%% THESE ARE WHAT I CHANGE FOR PART 1

% Store all parameters into a container
cps = containers.Map;
            %kr ka  kb
cps('1a') = [5  25  -25];
cps('1b') = [5  7  -1.25];
cps('1c') = [5  40  -10];

% Load parameters depending on the problem
prompt = "Which problem? (EX: '1a', '2b', ...)\n";
%problem = input(prompt)
problem='1c'
params = cps(problem);

% Assign gain parameters
k_rho = params(1); %Control parameter for the distance to the goal position regarding robot velocity
k_alpha = params(2);  %Control parameter robot's oreintation with respect to the rho line, determines w
k_beta = params(3);   %Control parameter for the goal orientation, determines w and beta

d_x = xg - x;  %Desired displacement in XI until the goal
d_y = yg - y;  %Desired displacement in YI until the goal
% 
f_h = figure(1);
plot(x,y, 'r*')
hold on
axis([XMIN XMAX YMIN YMAX]);
grid on
ax = gca(f_h);

counter = 0;

while((abs(xg-x)+ abs(yg-y))>0.01 )
m = mod(counter, 10)

if (counter <40 || m == 0)
    plot(x,y, 'r*')
    draw_robot(x, y, theta, f_h);
    pause(.1)
    f_h = figure(1)
    axis([XMIN XMAX YMIN YMAX]);
end

counter = counter +1;

%Calculation of system parameters
rho =sqrt(d_x^2+d_y^2);
alpha = -theta + atan2(d_y, d_x);
beta = -theta - alpha ;


%Control Law
v=k_rho*rho;
w = k_alpha*alpha+k_beta*beta;

%Differential change in system parameters in differential time, d_t
d_rho= -v*cos(alpha)*d_t;
d_alpha = ((v/rho)*sin(alpha) - w)*d_t;
d_beta = -(v/rho)*sin(alpha)*d_t;


%New valuaes of the system parameters after differential motion
rho = rho + d_rho;
alpha = alpha + d_alpha;
beta = beta + d_beta;

%Calculation of Robot's position and orientation after the differential
%mostion
d_s = v*d_t;
d_theta = w*d_t;
theta = theta + d_theta;

x = x + d_s*cos(theta);
y = y + d_s*sin(theta);

%Displaying the new location and orentation of the robot
[x y theta*180/3.14]

%Calculation of new distances to the goal after the differential motion in
%d_t
d_x = xg - x;
d_y = yg - y;

end