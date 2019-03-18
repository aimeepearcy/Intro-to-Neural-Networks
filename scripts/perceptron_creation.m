% A single neuron with an input vector with just two elements 
P = [0;0];
T = 0; 
net = perceptron;
net = configure(net,P,T);

% Bias = 0, weights = 1 and -0.8
net.b{1} = [0];
w = [1 -0.8];
net.IW{1,1} = w

% Input target pair
p = [1; 2];
t = [1];

% Compute output and error
a = net(p);
e = t - a;

% Use fn learnp to find and change the weights
dw = learnp(w,p,[],[],[],[],e,[],[],[],[],[]);

% New weights obtained
w = w + dw;

% Process of finding weights & biases can be repeated until there are no 
% errors. Perceptron learning rule guaranteed to converge in a finite
% number of steps for all problems that can be solved by the perceptron - 
% includes all classification problems that are linearly separable. 
