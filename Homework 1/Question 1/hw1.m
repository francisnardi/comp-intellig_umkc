%1 In this algorithm, we will use the own dataset for both
%1 training and validation
%1 We are using the data obtained at 
%1 http://www.databaseolympics.com/sport/sportevent.htm?sp=ATH&enum=200,
%1 which is related to the winning times in Olympics envolving 
%1 the 400m Hurdles Men

%2 In order to build this algorithm, we studied another types of 
%2 MatLab algorithms throught the internet, especially those ones
%2 referenced on the book, which can be accessed throught
%2 http://www.dcs.gla.ac.uk/~srogers/firstcourseml/matlab/chapter1/



%First, we need to clear the screen and erase the variables
%perhaps already stored in order to start running our program
clear all;
close all;


%The txt file 400mHurdlesMen will provide us with the dataset needed to
%test and validate our model
filename = '400mHurdlesMen.txt';
data = importdata (filename);

%The element 'a' will be a matrix of one column and 24 lines representing
%the years
%The element 'b' will be a matrix of one column and 24 lines representing
%the winning times
a = data (: , 1);
b = data (: , 2);

%The element 'valid' will be a matrix of one column and 24 lines 
%which has all the indices of the matrix with the original dataset where
%the year is greater than 1960 
% 12 ocurrences
valid = find (a > 1960);

%The element 'vala' will be a matrix of one column and 24 lines 
%representing the years used in the validation set
%The element 'valb' will be a matrix of one column and 24 lines 
%representing the winning times used in the validation set
% 12 ocurrences
vala = a (valid: end);
valb = b (valid: end);

%The values that will be used in the validation set 
%through the element 'vala' will be removed from the element 'a', 
%which will be used in the training set
%The values that will be used in the validation set 
%through the element 'valb' will be removed from the element 'b', 
%which will be used in the training set
a (valid:end) = [];
b (valid:end) = [];


%'pwr' will be the vector which holds the powers of the polynomial
%functions that will be candidates to best model
pwr = [1 2 3];

%Commands to plot both markers 
%magenta for training points
%and black for validation points
figure (1); hold off
plot (a, b, 'mo', 'markersize', 3);
hold all
plot(vala, valb, 'ko', 'markersize', 3);

%http://www.dcs.gla.ac.uk/~srogers/firstcourseml/matlab/chapter1/
%olympval.html
%Define the interval in which 'a' will be plotted and its accuracy
plota = [min(a):0.01:max(vala)]';

%This loop will execute three times, one for each power 
for i = 1:length(pwr)
    %Initializing the matrices
    A = [];
    plotA = [];
    TrnT = [];
    valA = [];
   
    
    %Raises the value of each element to the power of k
    %valA will be used to find the validation loss, because it covers
    %the interval of vala
    %TrnT will be used to find the training loss, because it covers
    %the interval of a    
    for k = 0:pwr(i)
        A = [A a.^k];
        valA = [valA vala.^k];
        TrnT = [TrnT a.^k];
        plotA = [plotA plota.^k];
    end
 
    %Find w according to its equation w = (Xtransp*X)^-1 * Xtransp * t
    w = inv(A'*A)*A'*b;
    plot(plota,plotA*w,'linewidth',2);
 
    %It finds the validation loss according to least squares
    val_loss(i) = mean((valA*w - valb).^2);
    
    %It find the training loss according to least squares
    trn_loss(i) = mean((TrnT*w - valb).^2);
end

%Limit the values in the axis y between 40 and 60
ylim([40 60]);
legend('Training','Validation','1st order/Linear','2nd order','3rd order');
 

for i = 1:length(pwr)
 fprintf('\n Model order: %g, Training loss: %g, Validation loss: %g',...
        pwr(i),trn_loss(i), val_loss(i));
end
