%Homework 2.2
%Francico Nardi and Paulo

%First, we need to clear the screen and erase the variables
%perhaps already stored in order to start running our program
clear all;
close all;

%Here we load the data
filename1 = '4x100mRelayMen.txt';
data1 = importdata (filename1);

filename2 = '4x100mRelayWomen.txt';
data2 = importdata (filename2);

filename3 = '100mMen.txt';
data3 = importdata (filename3);

filename4 = '100mWomen.txt';
data4 = importdata (filename4);

filename5 = '400mHurdlesMen.txt';
data5 = importdata (filename5);

filename6 = '400mHurdlesWomen.txt';
data6 = importdata (filename6);

%We put each best time in a different vector, since there are
%different years that something was disputed
a = data1 (: , 2);
b = data2 (: , 2);
c = data3 (: , 2);
d = data4 (: , 2);
e = data5 (: , 2);
f = data6 (: , 2);

%We take the zscore of each modality per sex
za = zscore(a);
zb = zscore(b);
zc = zscore(c);
zd = zscore(d);
ze = zscore(e);
zf = zscore(f);

%We take the minimum values of each modality
ma = min(za);
mb = min(zb);
mc = min(zc);
md = min(zd);
me = min(ze);
mf = min(zf);

%Counters used in order to know which gender has more noteworthy records
countmale = 0;
countfemale = 0;

%
if (ma < mb)
    countmale = countmale +1;
    disp('On modality 4x100m Relay -> Men`s record was better');
elseif (ma > mb)
    countfemale = countfemale + 1;
    disp('On modality 4x100m Relay -> Women`s record was better');
else
    disp('On modality 4x100m Relay -> Record had the same value');
end

if (mc < md)
    countmale = countmale +1;
    disp('On modality 100m -> Men`s record was better');
elseif (mc > md)
    countfemale = countfemale + 1;
    disp('On modality 100m -> Women`s record was better');
else
    disp('On modality 100m -> Record had the same value');
end

if (me < mf)
    countmale = countmale +1;
    disp('On modality 400m Hurdles -> Men`s record was better');
elseif (me > mf)
    countfemale = countfemale + 1;
    disp('On modality 400m Hurdles -> Women`s record was better');
else
    disp('On modality 400m Hurdles -> Record had the same value');
end

fprintf ('\ntherefore,');
if (countmale > countfemale)
    fprintf('\n Men`s records were more noteworthy than women`s');
elseif (countmale < countfemale)
    fprintf('\n Women`s records were more noteworthy than men`s');
else
    fprintf('\n Men`s and women`s quantity of noteworthy records were the same');
end