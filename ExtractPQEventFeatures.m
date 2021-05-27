% If I add a comment here, this should be in Asha's working branch only.
clear all;clc;close all

% Load PQ Events
load('PQ_JNL')


% Sample Events
events = PQ.samples;

% Time Vector
time = PQ.time;

% Target Labels 
labels = PQ.nLabels;

% Target Label Names - String
% Pure (Pure Sinusoid), DC (DC offset), Sag, Swl (Swell),
% Int (Interruption), Flk (Flicker), Osct (Oscillatory transient), 
% harm (Harmonics), Not (Notching), SagH (Sag with harmonics),
% SwlH (Swell with harmonics), FlkH (Flicker with harmonics), 
% SwlT (Swell with transient), SagT (Sag with transient), Spk (Spike?)
strng_label = PQ.sLabels;

% Sampling Frequency 
Fs = PQ.sampFq;

% The above code stores the PQ event information into variables
% Now create code to extract this information and store in a matrix 

% events - 3621x30001 double (there are 3621 PQ events)
% Fs - 25000
% labels - 3621x1
% PQ 1x1 struct
% strng_label - 3621x1 cell
% time - 1x30001


% define matrix of 3621 rows, and 1 column. Each row corresponds to a
% PQ event from the events variable and contains the absolute value of each
% PQ event.
maxIndicies = 3621;
nFeatures = 1;
featuresMatrix = zeros(maxIndicies,nFeatures);
currentEventMatrix = zeros(1,30001);

% The user will define i, which is the number of the row of the events
% matrix. Below the code is for event 1 only.

%for i = 1:30001
%     currentEventMatrix(1,i) = events(1,i);     
% end 

% Code to extract each event (/3621)
for i = 1:30001
    currentEventMatrix(1,i) = events(1,i);    
end


% The code we've written extracts a chosen signal from the events matrix 
% to a smaller 1 row matrix, containing only the one signal (chosen by
% varying i). 
% Now, we need to:
%               - define a few matricies, eg: frequency, mean, etc.
%               - Write another loop (outer loop)that goes interates
%                 through every row.
%               - use the already written loop to extract the 1 signal that
%                 you're currently looking at.
%               - Then extract the features and update the corresponding
%                 matrix. (EG extract mean and update mean matrix.)
%               - Then the outer loop will go to the next 

