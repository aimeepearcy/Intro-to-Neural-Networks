% rbf_spread - pbserve the effects of changing the spread
% load data files
load Xfit
load Yfit
load X2fit
load Y2fit 

% set params
num = 20;
error_target = 0.0;
disp_n = 1;

% matrices to hold results
OutTrainList = [];
OutTestList = [];

% for each size of spread
for spread = [0.1 0.2 0.3 0.4 0.5 1.0 1.5 2.0 2.5]
    % create the network - this will display the MSE during training
    rb = newrb(Xfit, Yfit, error_target, spread, num, disp_n);
    % simulate the network - i.e. calculate the outputs given the training
    % inputs. Capture those results.
    output_train = sim(rb, Xfit);
    OutTrainList = [ OutTrainList; output_train ];
    % simulate the network - i.e. calculate the outputs given the test
    % inputs. Capture those results. 
    output_test = sim(rb, X2fit);
    OutTestList = [ OutTestList; output_test ];
end 

% plot the curves resconstructing the training data
figure, plot(Xfit', OutTrainList');

% compare the results from the test inputs with the expected
% values and calculate the MSE for each network. 
Ymat = repmat(Y2fit,9,1);
errors = Ymat - OutTestList;

% you need to iterate here because MSE expects just one set of errors.
for i = [1:9]
    E(i) = mse(errors(i,:));
end 

% plot the MSE against network size
figure, plot([0.1 0.2 0.3 0.4 0.5 1.0 1.5 2.0 2.5], E)