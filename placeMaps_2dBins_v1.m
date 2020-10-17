
clear all
close all
clc

%% Overview and explanation

% This code is designed as a basis for taking single cell
% fluorescence timeseries data and x,y position data of the location of the
% animal at different time points within a behavioral arena, and to
% generate a place-map heatmap of where individual neurons are active
% within the 2-dimensional behavioral arena. This code was originally
% written to help a friend and colleague generate place maps of their
% epifluorescence imaging data within an open field arena.

% All code is original by Christian Pedersen

%% Create sample data.
numPoints = 5000;
x = -3 + 5 * rand(numPoints, 1);   % xpos
y = -2.5 + 5.5 * rand(numPoints, 1);  % ypos
F = 100 * rand(numPoints,1);   % Single Cell Fluorescence


% % Now construct the histogram
% xy = [x, y];
% subplot(1,2,1);
% hist3(xy, [37, 37]); % Plots bar chart.
% subplot(1,2,2);
% counts = hist3(xy, [37, 37]);
% imshow(counts, []); % Show as image
% colormap(hot(256));
% colorbar;
% axis on;

% Put the continuous values of x and y into 20 bins
discX = discretize(x,20);
discY = discretize(y,20);


% find mean for each quadrant
for n = 1:length(unique(discX))
    
    for k = 1:length(unique(discY))
    
        spatialBins(n,k) = mean(F(discX==n&discY==k));
    
    end  
    
end


%% Plot binned data, not smoothed

figure()
imagesc(spatialBins)



%% Plot smoothed binned data

[gridX,gridY] = meshgrid(1:size(spatialBins));

[interX,interY] = meshgrid(linspace(min(gridX,[],'all'),max(gridX,[],'all'),200));

interF = interp2(gridX,gridY,spatialBins,interX,interY);

figure()
imagesc(interF)
colorbar;
















