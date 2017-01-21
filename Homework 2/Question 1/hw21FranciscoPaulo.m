% Homework 2.1
% Francisco Nardi e Paulo Silva
clear all;
close all;

dataset=importdata('datahw21.txt');
numberofdata=size(dataset,1);
figure('Name','Hammer Throw Men','NumberTitle','off')

% initialization of the variables we use for lambda values from the vector lam
lam = [0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1];
n=2;

% nmax gives the last order + 1 of the highest polynomin which is in this program 5
nmax=10;

% the vector minimeanpos is used to store  position of values for the which is the best value of
% lambda, the minimean vector stores the values of the best lambda for a given polynomin
minimeanpos=zeros(nmax-n,1);
minimean=zeros(nmax-n,1);
	
% vectormsev is used to store all the 
vectormsev=zeros(numberofdata,1);
vectormean=zeros(11,1);

% the for with the variable z is for generate all the polynomins(degree 1 to 5)
for z = n:nmax
   	% Xt is the matrix with all the variables of x in polynomin for example for 
   	% degree 4 : [ x1^0 x2^0 ... xn^0;...;x1^4 x2^4 ... xn^4]
   	Xt=[];
 
	for k = 0:z-1
 		% put all the values of x scaleted to correct the error of singular
		% matrices values by subtract the mean value and divide by the standard deviation
  		Xt = [Xt ;((dataset(1:numberofdata)-mean(dataset(1:numberofdata)))./std(dataset(1:numberofdata))).^k];
    
	end
	% we create a new matrices with the vectors of x values with transpose from Xt
	X=Xt';
	%the next for will generate models for the current model of polynomin
	for l = 1:length(lam)
  		lambda = lam(l);  
  		%the next for will use n cross validation training/validation with method LOOCV
		for i=1:numberofdata
    		testingset=zeros(numberofdata,2);
    		testingset=dataset(1:numberofdata,1:2);
    		testingset(i,:)=[];
    		Xtn=[];
    		for k = 0:z-1
    			Xtn = [Xtn ;((testingset(1:numberofdata-1)-mean(testingset(1:numberofdata-1)))./std(testingset(1:numberofdata-1))).^k];
    
			end
			Xn=Xtn';

			% we calculate the values of the parameters w in the vector w using the
			% formula : w = (X'X+N.lambda.I)^-1*X't
    		w = inv((Xtn*Xn + (numberofdata)*lambda*eye(size(Xn,2))))*(Xtn*testingset(1:numberofdata-1,2));
    		% vectormsev stores the values of all single value of Squared Loss
    		% Validation with the model with the training data and the validation
    		% data as x
     		vectormsev(i)=sum((dataset(i,2)-X(i,1:z)*w).^2);

		end

		% vectormean stores the mean value of the vectorsev giving the output of
		% LOOCV method
		vectormean(l)=mean(vectormsev);
		
	end

	% the vectors minimean and minimeanpos gives the minimum value of LOOCV of
	% given order of polynomin with the currespond value and position of lambda respectivetely
	[minimean(z-1),minimeanpos(z-1)]=min(vectormean);
		
	%we set the variable lambda with the minimum value of lambda from the given polynomin
	lambda = lam(minimeanpos(z-1));
		
	%lambdaminglobal stores the position of lambda with the minimum LOOCV for every order of polynomin
	lambdaminglobal(z-1)=minimeanpos(z-1);
    w = inv((Xt*X + numberofdata*lambda*eye(size(X,2))))*(Xt*dataset(1:numberofdata,2));
    
    %calculate w with the best model for the current order of polynomin
    figure(z-1);
    
    %create a new figure which has all the data and the polynomin model with best lambda
    hold off
    scatter(dataset(1:numberofdata,1),dataset(1:numberofdata,2));
    hold on
    plot(dataset(1:numberofdata,1),X*w);  
    ti = sprintf('$\\lambda = %g$ order of polynomin = %d',lambda,z-1);
    title(ti,'interpreter','latex','fontsize',20)

end

%minimeanglobalval has the minimum LOOCV of the best model gave by the
%minimeanglobalpos which gives the order of polynomin
[minimeanglobalval,minimeanglobalpos]=min(minimean);
Xt=[];
for k = 0:minimeanglobalpos-1
  	%regenerate Xt matrix with the best model  
 	Xt = [Xt ;((dataset(1:numberofdata)-dataset(1,1))./(4)).^k];
    
end
X=Xt';

%recalculate the lambda with the best lambda from the best model
lambda=lam(lambdaminglobal(minimeanglobalpos));

%recalculate w for the best model
w = inv((Xt*X + numberofdata*lambda*eye(size(X,2))))*(Xt*dataset(1:numberofdata,2));
averageloss=sum((dataset(1:numberofdata,2)-X*w).^2)/numberofdata;

%averageloss correspond the MSE for all the test set(all data)
hold off
ti = sprintf('Best Model!polynomin order= %d , average loss : %d',minimeanglobalpos,averageloss);

%retitle the best model    
figH= figure(minimeanglobalpos);
set(figH,'Name',ti,'NumberTitle','off')
hold on