function hw51(ss,X,s0,u0,t,pred,x)

% referenced function from the book
sw = inv((1/ss)*X'*X + inv(s0));
uw = sw*((1/ss)*X'*t + inv(s0)*u0);
 
% the new x, given the year which we want to make a prediction
xnew = [1; pred];

% predicted winning time
u = xnew' * uw;

% variance
sig2 = ss + xnew' * sw * xnew;

% standard deviation
sig = sqrt(sig2);
 
% plotting of the gauss distribution
figure();
plot(x,normpdf(x,u,sig));

    
xlabel('Winning time');
ylabel('Chance');

fprintf('Predicted winning time: %g\n',u);
fprintf('New variance: %g\n\n', sig2);

