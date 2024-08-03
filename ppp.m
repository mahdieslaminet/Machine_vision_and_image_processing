% Add the necessary paths for the toolbox
addpath(genpath('C:Program FilesMATLABR2023btoolboximager'));

% Open the image file
uiopen('E:\dataset\Cancer Images\Cancer_1.png', 1);

% Read the image
I0 = imread('E:\dataset\Cancer Images\Cancer_1.png');

% Display the original image
figure;
imshow(I0);
title('Original Image');

% Convert the RGB image to grayscale
Ig = rgb2gray(I0);

% Display the grayscale image
figure;
imshow(Ig);
title('Grayscale Image');

% Apply Gaussian filtering to the grayscale image
IG = imgaussfilt(Ig, 3);

% Display the Gaussian filtered image
figure;
imshow(IG);
title('Gaussian Filtered Image');

% Apply Sobel filtering to find edges in the image
IE = edge(IG, 'Sobel');

% Display the edge-detected image
figure;
imshow(IE);
title('Edge-Detected Image');

% Get the size of the edge-detected image
[rows, cols] = size(IE);

% Calculate the center of the image
Ct = [round(rows/2), round(cols/2)];

% Plot the center point (this plot will not be very informative)
figure;
plot(Ct(2), Ct(1), 'ro'); % plot the center as a red dot
title('Center Point');
axis([0 cols 0 rows]);
set(gca, 'YDir', 'reverse');

% Find the boundaries of the edges
leftBoundary = find(IE(:, 1) == 1, 1, 'first');
rightBoundary = find(IE(:, end) == 1, 1, 'first');
topBoundary = find(IE(end, :) == 1, 1, 'first');

% Compute the horizontal profile and find the point with maximum edges
Hpp = sum(IE, 2);
[~, idx] = max(Hpp);
firstPoint = idx;

% Find the bottom boundary points
bottomBoundary = find(IE(:, end) == 1);
secondPoint = bottomBoundary(1);
thirdPoint = bottomBoundary(round(length(bottomBoundary)/2));
fourthPoint = bottomBoundary(end);

% Store the segmented ROI (assuming you meant to store coordinates)
IS = [firstPoint, secondPoint, thirdPoint, fourthPoint];

% Display the segmented points on the edge-detected image
figure;
imshow(IE); hold on;
plot([1, cols], [topBoundary, topBoundary], 'r', 'LineWidth', 2);
plot([1, cols], [bottomBoundary, bottomBoundary], 'b', 'LineWidth', 2);
title('Segmented Points');
hold off;