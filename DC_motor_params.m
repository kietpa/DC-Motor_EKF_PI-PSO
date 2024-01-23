% Parameters
Ts = 10^-5; % [s] sampling time


% DC motor model
Va = 240; % [V] arm voltage
Vf = 300; % [V] arm field
Ra = 2.581; % [Ohm] arm resistance
La = 0.028; % [H] arm inductance
Laf = 0.9483; % [H] 
J = 0.02215; % [kg/m^2] inertia
D = 0.002953; % [Nms] damping coeff
Tf = 0.5161; % [Nm]
K = 1.79; % [Nm/A]


% Load Parameters
m = 5; % [kg] mass
l = 0.05; % [m] armature length
g = 9.81; % [m/s^2] gravity


% A = [0.0852 51.6595; 63.9286 92.1786];
Ad = [1 0.0005; 0.0006 0.9991];

















