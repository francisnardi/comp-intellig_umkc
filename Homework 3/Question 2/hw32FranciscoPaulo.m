% Homework 3.2
% Francisco Nardi e Paulo Silva

%As usual, it is need to clean the screen and variables
clear all;
close all;

%Here we will fill the values of mu and sigma according to the draw we want

%Independent random variables with unequal variance
mu1 = [1;1];
sigma1 = [1 0;0 1];

%Here we call the function plotGauss
plotGauss(mu1,sigma1);

%Dependent random variables with same variance
mu2 = [1;2];
sigma2 = [1 0.8;0.8 2];

%Here we call the function plotGauss
plotGauss(mu2,sigma2);

%The contour plot looks almost like a straight line and is parallel
% to the x axis
mu3 = [1;1];
sigma3 = [1.7 0; 0 0.0001];

%Here we call the function plotGauss
plotGauss(mu3,sigma3);

%The contour plot looks almost like a straight line but is
% not parallel to either axis
mu4 = [1;2];
sigma4 = [1.07 0.8;0.8 0.61];

%Here we call the function plotGauss
plotGauss(mu4,sigma4);