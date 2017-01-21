% Homework 4.1
% Francisco Nardi and Paulo Silva

% Cleaning the screen and variables as usual
clear all;
close all;

%it determines the range used
range = [0:0.1:1];
 
%we want to exhibit five figures which keep the same
%ratio of their parameters but with increasing magnitudes.
for i = 1:5
    
    %in order to keep the same ratio, the variables
    %need to keep the same proportion
    a = i * 10;
    b = i * 10;
    
    %here we calculate the first part of the equation, using gamma function
    part1 = ((gamma(a + b))/(gamma(a) * gamma(b))); 
    
    %this is the second part
    part2 = (range .^ (a - 1)) .* ((1 - range) .^ (b - 1));

    %that is the result, 
    %part1 multiplied by part2
    result = part1 * part2;
    figure(1)
    
    %here we plot the beta density in figure 1
    plot(range, result)
    hold on
end

