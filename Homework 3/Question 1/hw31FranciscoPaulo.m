% Homework 3.1
% Francisco Nardi and Paulo Silva

% Cleaning the screen and variables as usual
clear all;
close all;

% Loading the files
filename = '400mHurdlesMen.txt';
data = importdata (filename);

% x receives the years, while t receives the winning times
x = data (: , 1);
t = data (: , 2);

% valid looks for x greater than 1986, which are N = 6
valid = find (x > 1986);
N = 6;

% valx has these x
% valt the related t
valx = x (valid: end);
valt = t (valid: end);

% it erases values of valx and valt from x and t, resp.
x (valid:end) = [];
t (valid:end) = [];

% the noise is set as 2
noise_var = 2;

% t2 will keep the original values t
t2 = t;

% adding noise to t
t = t + randn(size(x)).*sqrt(noise_var);

% It increases as the events happen,
% with space of 4 years
testx = [min(x):4:max(valx)]';

% The points marked with 'x' are the true values of the dataset
% The points marked with '*' are the predicted values
figure(1);
hold off
plot(x, t2,'x',valx, valt,'*');
xlabel('x');
ylabel('t');


% It draws the model
orders = [2:2];
for i = 1:length(orders)
    X = [];
    testX = [];
    for k = 0:orders(i)
        X = [X x.^k];
        testX = [testX testx.^k];
    end
    
    % It finds the w and covariance for the noisy function
    w = inv(X'*X)*X'*t;
    ss = (1/N)*(t'*t - t'*X*w);
    % It finds the mean and variance for the noisy function
    testmean = testX*w;
    testvar = ss * diag(testX*inv(X'*X)*testX');
    
    figure(1);
    hold on
    plot(x,t,'o');
    xlabel('x');
    ylabel('t');
    hold on
    errorbar(testx,testmean,testvar,'r')
    
    ti = sprintf('Quadratic order');
    title(ti);
    
    % loss returns the mean error for the noisy function
    loss = mean((testmean - testvar))/6;
    fprintf('\n\nThe mean loss for a noisy is %g\n\n', loss);
    
    % It finds the w and covariance for the noiseless function
    w2 = inv(X'*X)*X'*t2;
    ss2 = (1/N)*(t2'*t2 - t2'*X*w2);
    % It finds the mean and variance for the noiseless function
    testmean2 = testX*w2;
    testvar2 = ss2 * diag(testX*inv(X'*X)*testX');
    
    % loss returns the mean error for the noiseless function
    loss2 = mean((testmean2 - testvar2))/6;
    fprintf('\n\nThe mean loss for a noiseless is %g\n\n', loss2);
    
end