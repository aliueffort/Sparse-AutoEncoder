
clc;clear;close all;

%%======================================================================
%% STEP 0: Here we provide the relevant parameters values that will
visibleSize = 8*8;    % number of input units 
hiddenSize  = 25;     % number of hidden units 
sparsityParam = 0.01; % desired average activation of the hidden units.
                      % (This was denoted by the Greek alphabet rho, which looks like a lower-case "p",
		              %  in the lecture notes). 
lambda = 0.0001;      % weight decay parameter       
beta = 3;             % weight of sparsity penalty term       

%%======================================================================
%% STEP 1: Implement sampleIMAGES
patchsize  = 8;  
numpatches = 10000;
patches = sampleIMAGES(patchsize,numpatches);
figure('name','Initial Patches');display_network(patches(:,randi(size(patches,2),200,1)),8);


%%======================================================================
%% STEP 4: After verifying that your implementation of
%  sparseAutoencoderCost is correct, You can start training your sparse
%  autoencoder with minFunc (L-BFGS).

%  Randomly initialize the parameters
theta = initializeParameters(hiddenSize, visibleSize);

%  Use minFunc to minimize the function
addpath minFunc/
options.Method = 'lbfgs'; % Here, we use L-BFGS to optimize our cost
                          % function. Generally, for minFunc to work, you
                          % need a function pointer with two outputs: the
                          % function value and the gradient. In our problem,
                          % sparseAutoencoderCost.m satisfies this.
options.maxIter = 400;	  % Maximum number of iterations of L-BFGS to run 
options.display = 'on';


[opttheta, cost] = minFunc( @(p) sparseAutoencoderCost(p, ...
                                   visibleSize, hiddenSize, ...
                                   lambda, sparsityParam, ...
                                   beta, patches), ...
                              theta, options);

%%======================================================================
%% STEP 5: Visualization 
W1 = reshape(opttheta(1:hiddenSize*visibleSize), hiddenSize, visibleSize);
figure;display_network(W1', 12); 
save('W1.mat','W1');


%% STEP 6: 显示前3个图像块的稀疏表示特征

%% ---------- YOUR CODE HERE --------------------------------------
HIDDENVALUE = sigmoid(W1*patches);
%% ---------- YOUR CODE HERE --------------------------------------
figure;
subplot(3,1,1);bar(HIDDENVALUE(:,1));
subplot(3,1,2);bar(HIDDENVALUE(:,2));
subplot(3,1,3);bar(HIDDENVALUE(:,3));


function sigm = sigmoid(x)
  
    sigm = 1 ./ (1 + exp(-x));
end





