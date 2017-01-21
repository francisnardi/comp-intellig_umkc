% Homework 4.4
% Francisco Nardi and Paulo Silva

% Cleaning the screen and variables as usual
clear all;
close all;

% no prior knowledge
alp = 1;
bet = 1;

% we just have a big difference in the first tosses,
% since we don't know what to expect
yn = 0;
N = 1;
fprintf('for yn = %g N = %g\n',yn,N);
calculatePAndExp(alp,bet,yn,N);

% we just have a big difference in the first tosses,
% since we don't know what to expect
yn = 1;
N = 2;
fprintf('for yn = %g N = %g\n',yn,N);
calculatePAndExp(alp,bet,yn,N);

% we just have a big difference in the first tosses,
% since we don't know what to expect
yn = 2;
N = 2;
fprintf('for yn = %g N = %g\n',yn,N);
calculatePAndExp(alp,bet,yn,N);