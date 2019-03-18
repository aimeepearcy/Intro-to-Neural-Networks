% a simple script to explore how well an MLP can approximate an arbitrary
% function. Uses data with one input (set of X values) and one output
% (set of corresponding Y values). 
% Xfit and Yfit are a set of observations. X2fit and Y2fit is a second set
% of data used to check how well MLP fits data. 

% mlp_script to determine effect of adding more neruons.

testX = linspace(-10,10);

% matrices to hold results
OutTrainList = [];
OutTestList = [];

% for each size of network
for num = [1 3 5 10 15 20 25]
    % create the network
    net = feedforwardnet(num);
    % train the network
    net = train(net, Xfit, Yfit);

    % simulate the network - i.e. calculate the outputs given the training
    % inputs. Capture those results. 
    output_train = sim(net, Xfit);
    OutTrainList = [ OutTrainList; output_train ];
    % simulate the network - i.e. calculate the outputs given the X2fit
    % inputs. Capture those results too.
    output_test = sim(net, X2fit);
    OutTestList = [ OutTestList; output_test];
end 

% plot the curves reconstructing the training data
figure, plot(Xfit', OutTrainList');

% Compare the results from the test inputs with the expected values and
% calculate the MSE for each network.
Ymat = repmat(Y2fit, 7, 1);
errors = Ymat - OutTestList;

% need to iterate here because MSE expects a single set of errors
for i = [1:7]
    E(i) = mse(errors(i,:));
end

% plot the MSE against network size
figure, plot([1 3 5 10 15 20 25], E)
