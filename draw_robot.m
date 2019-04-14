function draw_robot (xo, yo, theta, f_h)

%Robot's Size
w = 2;
h = 1;

%Defining the robot's four corners
x = [- w/2   w/2;
     -w/2   w/2;
     -w/2 -w/2;
    w/2  w/2;
    3*w 0];
y = [h/2 h/2;
    -h/2  -h/2;
    -h/2  h/2;
     h/2   -h/2;
     0 0];

%Setting the orientation of the robot
xrot = x.*cos(theta)- y.*sin(theta) + xo;
yrot = x.*sin(theta)+ y.*cos(theta) + yo;

% figure(f_h)
%Drawing Robot
line(xrot(1,:), yrot(1,:))
line(xrot(2,:), yrot(2,:))
line(xrot(3,:), yrot(3,:))
line(xrot(4,:), yrot(4,:))

%Drawing X_R 
arrow3([xrot(5,2) yrot(5,2)],[xrot(5,1) yrot(5,1)], 'l:', 0.5,1);



