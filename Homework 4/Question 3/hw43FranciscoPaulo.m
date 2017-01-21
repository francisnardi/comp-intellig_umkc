% Homework 4.3
% Francisco Nardi and Paulo Silva

% Cleaning the screen and variables as usual
clear all;
close all;

% we need to define a value for alpha
a = [0:0.15:3];

% and for beta
b = [0:0.15:3];

% we calculate the function based on those values
result = (a .* b) ./ (((a + b) .^ 2) + (a + b + 1));

% and come up with the the 3d plot of the variables/result
figure(1)
plot3(a,b,result)