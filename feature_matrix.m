function [featureMatrix] = feature_matrix(PQ,indices)
%feature_matrix is used to calculate features of interest for each
%power signal and store these into a matrix.

%The 'feature_matrix' function has two inputs and one output. The 
%first input is a file containing power quality events and the second input
%is the row indices, corresponding to the different power signals. The
%output is the feature matrix for these specified power signals.

n_features = 37;
maxind = max(indices);
featureMatrix = zeros(maxind, n_features);
%randIndicies = randperm(maxind);
t0 = tic();
for i = indices
    %index = randIndicies(i);
    [SMatrix] = gft_output(PQ,indices); %For timing GFT
    %event = PQ.samples(index,:); %For timing ST 
    %SMatrix = st(event, 0, 4000, 1, 1); %For timing ST
    
    absSMatrix = abs(SMatrix);       %Finds the absolute of the s transform matrix
    meanSMatrix = mean2(absSMatrix); %Finds the mean of the s transform matrix
    stdSMatrix = std2(absSMatrix);   %Finds the standard deviation of the s transform matrix
    sMatrixRows = size(absSMatrix,1);
    sMatrixCols = size(absSMatrix,2);
    energyF = sum(absSMatrix.^2, 2); %Calculates the frequency energy 
    energyT = sum(absSMatrix.^2, 1); %Calculates the time energy

    % Frequency vector
    minEnergyF  = min(energyF);
    maxEnergyF  = max(energyF);
    meanEnergyF = mean(energyF);
    stdEnergyF  = std(energyF);
    varEnergyF  = var(energyF);
    
    % Time vector
    minEnergyT  = min(energyT);
    maxEnergyT  = max(energyT);
    meanEnergyT = mean(energyT);
    stdEnergyT  = std(energyT);
    varEnergyT  = var(energyT);
    
    % Extra features
    kurtosis = (1/(sMatrixRows*sMatrixCols))*(sum(sum(((absSMatrix-meanSMatrix).^4)/(stdSMatrix^4))));
    skewness = (1/(sMatrixRows*sMatrixCols))*(sum(sum(((absSMatrix-meanSMatrix).^3)/(stdSMatrix^3))));
    maxAmplitude = max(max(absSMatrix));
    minAmplitude = min(min(absSMatrix));
    sumMaxMin = maxAmplitude + minAmplitude;
    minSTDTime = min(std(absSMatrix));
    maxSTDTime = max(std(absSMatrix));
    minVarTime = min(var(absSMatrix));
    maxVarTime = max(var(absSMatrix));
    minSTDFrequency = min(std(absSMatrix, 0, 2));
    maxSTDFrequency = max(std(absSMatrix, 0, 2));
    minVarFrequency = min(std(absSMatrix, 0, 2));
    maxVarFrequency = max(std(absSMatrix, 0, 2));
    maxRow1 = max(absSMatrix(1,:));
    minRow1 = min(absSMatrix(1,:));
    
    %Potential features
    Tmax = max(absSMatrix);
    Tmean = mean(absSMatrix);
    Tstd = std(absSMatrix);
    Fmin = min(absSMatrix,[],2)';
    Fmean = mean(absSMatrix,2)';
    Fstd = std(absSMatrix,0,2)';
    
    TmaxSumOfMaxMin = max(Tmax)+min(Tmax);
    RMSTmean = rms(Tmean);
    TstdSumOfMaxMin = max(Tstd)+min(Tstd);
    stdTstd = std(Tstd);
    meanFmin = mean(Fmin);
    stdFmin = std(Fmin);
    rmsFmin = rms(Fmin);
    stdFstd = std(Fstd);
    rmsFstd = rms(Fstd);
    thdFmean = sqrt(Fmean(100:50:end)*Fmean(100:50:end)')/max(Fmean);
    
    % Adds the features to the feature matrix in the column assigned to a given sample
    featureMatrix(index,:) = [minEnergyF, maxEnergyF, meanEnergyF, stdEnergyF, varEnergyF, ...
                          minEnergyT, maxEnergyT, meanEnergyT, stdEnergyT, varEnergyT, ...
                          meanSMatrix, kurtosis, skewness, maxAmplitude, minAmplitude, ...
                          minSTDTime, maxSTDTime, minSTDFrequency, maxSTDFrequency, ...
                          minVarTime, maxVarTime, minVarFrequency, maxVarFrequency, ...
                          maxRow1, minRow1, stdSMatrix, sumMaxMin, ...
                          TmaxSumOfMaxMin, RMSTmean, TstdSumOfMaxMin, stdTstd, meanFmin, ...
                          stdFmin, rmsFmin, stdFstd, rmsFstd, thdFmean];
end
% Remove empty rows
featureMatrix(~any(featureMatrix, 2), :) = [];
featureMatrix = (featureMatrix - min(featureMatrix))./(max(featureMatrix)-min(featureMatrix));
dt = toc(t0)