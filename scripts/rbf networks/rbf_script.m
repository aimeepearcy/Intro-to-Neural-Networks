% rbf_script
% load data files
load Xfit
load Yfit
load X2fit
load Y2fit 

% set params
spread = 1.0;
error_target = 0.0;
disp_n = 1;

% matrices to hold results
OutTrainList = [];
OutTestList = [];

% for each size of network
for num = [ 1 2 3 4 5 10 15 20 25]
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
figure, plot([1 2 3 4 5 10 15 20 25], E)