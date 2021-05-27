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


% define matrix of 3621 rows, and x columns. Each row corresponds to a
% PQ event from the events variable. Each column corresponds to one
% features (such as mean, or median). The number of columns will change as
% we decide which features we want to use, but for now we've set it to 1.

maxIndicies = 3621;
nFeatures = 1;
featuresMatrix = zeros(maxIndicies,nFeatures);
currentEventMatrix = zeros(1,30001);

% The user will define i, which is the number of the row of the events
% matrix. By choosing i, they will choose which event they are running.
% Below the code is for event 1 only.

% Code to extract each event, into a single vector (i/3621)
for i = 1:30001
    currentEventMatrix(1,i) = events(1,i);    
end


%% Code to loop through and extract features.

% Define a few matricies, eg: frequency, mean, etc.
frequency = zeros(3621,1); % each row is a PQ event.
mean = zeros(3621,1);

for i = 1:3621 % cycle through events
    currentEvent = zeros(1,30001);
    
    % cycle through all the samples of the current event and put them in
    % their own matrix called current Event.
    
    for j = 1:30001 
    currentEvent(1,j) = events(1,j);   
    end
    % Below is a placeholder. Basically we can do any operation on the
    % currentEvent matrix (which is a vector of 1 PQ event. We could use a
    % function like "Frequency-->) and send it to another file to do the
    % calculation.
    currentEventValue = abs(currentEvent);
    
    % Update the corresponding matrix defined above (eg. frequency). Since
    % each row of frequency corresponds to the ith event, we use i. (eg for
    % the first event, i = 1). Later on we could possibly re-write so this
    % function takes an input of a matrix name (ie mean, or frequency) so
    % we can just create that vector and reuse this function for all the
    % vectors...
    frequency(i,1) = currentEventValue;
    
end



%% The code we've written extracts a chosen signal from the events matrix 
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

