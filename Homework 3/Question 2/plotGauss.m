function x=plotGauss(mean,cov)

%Replicate the grid vectors to produce a full grid
[X,Y] = meshgrid(-5:0.1:5,-5:0.1:5);

%Calculating the first part, which is constant
common = (1/sqrt(2*pi))^2;

%Calculating the constant and the determinant of covariance matrix
common = common./sqrt(det(cov));

a = [X(:)-mean(1) Y(:)-mean(2)];

%Here it applies the formula of Gaussian
distr = common*exp(-0.5*diag(a*inv(cov)*a'));
distr = reshape(distr,size(X));

%It plots the countour as a figure
figure();hold off
contour(X,Y,distr);



