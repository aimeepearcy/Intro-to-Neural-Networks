tr = csvread('/Users/aimee/Documents/mnist_train.csv',1,0); % read mnist_train.csv 
sub = csvread('/Users/aimee/Documents/mnist_test.csv',1,0); % read mnist_test.csv

figure                                          % plot images
colormap(gray)                                  % set to grayscale
for i = 1:25                                    % preview first 25 samples
    subplot(5,5,i)                              % plot them in a 6x6 grid
    digit = reshape(tr(i, 2:end), [28,28])';    % row = 28 x 28 image
    imagesc(digit)                              % show the image
    title(num2str(tr(i,1)))                     % show the label
end 

n = size(tr,1);                             % number of samples in dataset
targets = tr(:,1);                          % 1st column is |label|
targets(targets == 0) = 10;                 % use '10' to represent '0'
targetsd = dummyvar(targets);               % convert label into dummy variable
inputs = tr(:,2:end);                       % the rest of columns are predictors

inputs = inputs';                           % transpose input
targets = targets';                         % transpose target
targetsd = targetsd';                       % transpose dummy variable

rng(1);                                     % initialize generator using a seed of 1 for reproducability
c = cvpartition(n,'Holdout',1/3);           % hold out 1/3 of the dataset

Xtrain = inputs(:, training(c));            % 2/3 of the input for training
Ytrain = targets(:, training(c));           % 2/3 of the target for training
Xtest = inputs(:, test(c));                 % 1/3 of the input for testing
Ytest = targets(:, test(c));                % 1/3 of the target for testing
Ytestd = targetsd(:, test(c));              % 1/3 of the dummy variable for testing