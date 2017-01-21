% Homework 5.1
% Francisco Nardi and Paulo Silva

% Cleaning the screen and variables as usual
clear all;
close all;

% Here we load the data from the file
% Olympic Women 100m
dataset=importdata('100mWomen.txt');

% x will be the years
% t will be the winning times
x = dataset(:,1);
t = dataset(:,2);

% xdata will be used to calculate the prediction
xdata = x;

% here the events become a sequence starting in 0
% until "the last year", with pace of four years [0 4 8 ...]
x = x - x(1);

% here we divide the sequence by four, turning it into a sequence
% [1 2 3 ...], which mean as well that the graph can be better exhibited
x = x./4;

X = [x.^0 x.^1];

% the questions asks for the prediction for the year of 2016
pred = 2016;

% based on the previous idea, we rescale the year which is going
% to have the winning time predicted
pred = pred - xdata(1);
pred = pred./4;


% here are the parameters used in the calculation of the predicted time
% by changing them, we perceive possible changes in the results of
% the function

% considering w's independents, we need to set u as 0 and 0
u0 = [0;0];

% considering previous observations, we noticed a greater w0 values
% comparing to w1 values in the covariance matrix
s0 = [100 0;0 5];

% ss will affect our posterior
ss = 0.05;

% s is the standard deviation, root square of the variance
s = sqrt(ss);

hw51(ss,X,s0,u0,t,pred,x);

fprintf('Let us change the prior for 100 and 100\n');
hw51(ss,X,s0,[100;100],t,pred,x);
fprintf('1-We realized just a tiny difference in the pred. win. time\n\n');

fprintf('Let us change the covariance matriz for 200 and 200\n');
hw51(ss,X,[200 0; 0 200],u0,t,pred,x);
fprintf('2-Again, just a tiny difference\n\n');

fprintf('Now, let us change the variance for 4\n');
hw51(4,X,s0,u0,t,pred,x);
fprintf('3-We finally observed relevant changes (shape and time).\n\n');