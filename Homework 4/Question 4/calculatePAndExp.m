function calculatePAndExp(alp,bet,yn,N)

% using formulas to define sigma and gamma
sig = alp + yn;
gam =  bet + N - yn;

summation = 0;

% using the formula of r

r = (sig)/(sig + gam);

% applying the binomial probability density function
for i = 7:10
    %result of summation for p
    summation = summation + binopdf(i,10,r);
end

% result of p
p = 1 - summation;


% new tosses
Nnew =  10;
summation = 0;

for ynew = 7:10
    % sharing the equation in order to better organization
    first = (factorial(Nnew)/(factorial(ynew)*factorial(Nnew - ynew)));
    second = gamma(sig+gam)/(gamma(sig)*gamma(gam));
    third = (gamma(sig+ynew)*gamma(gam+Nnew-ynew))/gamma(sig+gam+Nnew);
    
    %result of summation for exp
    summation = summation + (first * second * third);
    
end

exp = 1 - summation;

difference = abs(p-exp);

fprintf('r: %g\np: %g\nexp: %g\ndifference:%g\n\n',r,p,exp,difference);