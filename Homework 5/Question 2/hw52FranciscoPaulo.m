% Homework 5.2
% Francisco Nardi and Paulo Silva

% Cleaning the screen and variables as usual
clear all;
close all;

% Here we load the data from the file
% Ostrich
dataset = importdata('Ostrich.txt');

x = dataset(:,1);
y = dataset(:,2);
N = length(x);

noise_var = 10;

% function which describes the behavior the data
t = 5*x + 53.6*x.^2 - 25.7*x.^3 + 7*x.^4;

% adding noise to the function
t = t + randn(size(x)).*sqrt(noise_var);

% plotting the graph
plot(x,t,'k.','markersize',10);
xlabel('x');
ylabel('t');

% many models for diverse orders
orders = [0:8];
testx = [0:0.01:11]';

X = [];
testX = [];
for i = 1:length(orders)
    
    si0 = eye(orders(i)+1);
    mu0 = repmat(0,orders(i)+1,1);
    X = [X x.^orders(i)];
    testX = [testX testx.^orders(i)];
    siw = inv((1/noise_var)*X'*X + inv(si0));
    muw = siw*((1/noise_var)*X'*t + inv(si0)*mu0);

    figure();hold off;
    plot(x,t,'k.','markersize',10);
    xlabel('x');
    ylabel('t');
    hold on
    plot(testx,testX*muw,'r');
    ti = sprintf('Model order %g',orders(i));
    title(ti);
    
    % Marginal likelihood
    margcov = noise_var*eye(N) + X*si0*X';
    margmu = X*mu0;
    D = length(margmu);
    log_marg(i) = -(D/2)*log(2*pi) - 0.5*log(det(margcov));
    log_marg(i) = log_marg(i) - 0.5*(t-margmu)'*inv(margcov)*(t-margmu);
    
end


% plotting them
figure(); hold off
bar(orders,exp(log_marg));
xlabel('Model Order');
ylabel('Marginal likelihood');