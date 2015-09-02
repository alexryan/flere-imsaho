function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%


% implement the feedforward computation

% let h be a 5000x10 matrix that contains the predictions for all 10 classes
% for each of the 5000 training examples

h     = zeros(m,num_labels);
ybin  = zeros(m,num_labels);

% convert the labels to vectors of zeros and ones
for t=1:m
  ybin(t,y(t)) = 1;
  %if (t<3)
  %  fprintf("y: t=%d\n", t);
  %  display(ybin(t,:));
  %end
end
%

% forward propagation: populate h

% Non-vectorized
%for t=1:m
%  a1 = [1 X(1,:)]'; %401x1
%  z2 = Theta1*a1; %25x401 * 401x1 => 25x1
%  a2 = sigmoid(z2);
%  a2 = [1; a2];
%  z3 = Theta2*a2; %10x26 * 26x1 => 10x1
%  a3 = sigmoid(z3);
%  probs(t,:) = a3';
%end

% vectorized; optimized for understandability
a1 = [ones(m,1) X];   % 5000x401
z2 = Theta1*a1';      % 25x401 * 401x5000 => 25x5000
a2 = sigmoid(z2);     % a2 => 25x5000
a2 = [ones(1,m); a2]; % a2 => 26*5000
z3 = Theta2*a2;       % 10x26 * 26x5000 => 10x5000
a3 = sigmoid(z3);     % a3 => 10x5000
h = a3';              % h  => 5000x10

% vectorized; optimized for computation
%X  = [ones(m,1) X];         % 5000x401
%a2 = sigmoid(Theta1 * X');  % 25x401 * 401x5000 => 25x5000
%a2 = [ones(m,1) a2'];       % a2 => [5000x1 25x5000'] = [5000x1 5000x25] = 5000x26
%h  = sigmoid(Theta2 * a2'); % h  => 10x26 * 26x5000 => 10x5000
%h  = h';                    % h  => 5000x10


% check that h is being populated correctly
%for t=1:m
%  if (t<3)
%    fprintf("h: t=%d\n", t);
%    display(h(t,:));
%  end
%end

% non-vectorized implementation of the cost function
% i.e. use for loops

%sum = 0;
%for t=1:m
%  for k=1:num_labels
%    %cost = -ybin(t,k)*log(h(t,k)) - (1-ybin(t,k))*(1-log(h(t,k)));
%    term1 = ybin(t,k)*log(h(t,k));
%    term2 = (1-ybin(t,k))*(1-log(h(t,k)));
%    cost = -term1 - term2;
%    
%    sum = sum + cost;
%
%    if t<3
%      fprintf("t=%d, k=%d, term1=%f, term2=%f, cost=%f, sum=%f\n", t, k, term1, term2, cost, sum);
%    end
%    
%  end
%end
%
%J = (1/m)*sum;
%

% vectorized implementation of the cost function
% h:    10x5000 matrix of predictins
% ybin: 10x5000 matrix of actuals
% we need to compare all 50,000 of these and add up the cost for each
% we do this via a cell-by-cell cost calculation to produce a single 10x5000 matrix
% which contains all the individual costs
% then we just sum up all of these values

J = (1/m)* sum( sum( (-ybin).*log(h) - (1-ybin).*(log(1-h)) ) );

%term1 = -ybin.*log(h);
%term2 = (1-ybin).*(1-log(h));

% term
%for t=1:3
%  fprintf("term1: row=%d\n", t);
%  display(term1(1,:));
%  fprintf("term2: row=%d\n", t);
%  display(term2(1,:));
%end


% Adding regularization to the cost
% All we're doing here is summing up the squares of the weights
% in each of the individual matrices
% adding them
% and multiplying by lamda/(2*m)
% Remember to ignore the weights for all the bias values.

regTerm = lambda/(2*m) * ( sum(sum(Theta1(:,2:end).^2)) + sum(sum(Theta2(:,2:end).^2)) ); 
%fprintf("regularization term = %f\n", regTerm);

J = J + regTerm;


% backprop to calculate the gradients

%Theta1 = randInitializeWeights(400, 25);
%Theta2 = randInitializeWeights(25,10);

%Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
%Theta2 = randInitializeWeights(hidden_layer_size,num_labels);

big_delta_1 = zeros(size(Theta1,1), size(Theta1,2));
big_delta_2 = zeros(size(Theta2,1), size(Theta2,2));

y_mat = eye(num_labels)(y,:);

for t=1:m
  % STEP 1;
  a1 = [1 X(t,:)]';
  z2 = Theta1*a1;   %25x401 * 401x1 => 25x1
  a2 = sigmoid(z2);
  a2 = [1; a2];     % a2: 26x1
  z3 = Theta2*a2;   % z3: 10x26 * 26x1 => 10x1
  a3 = sigmoid(z3);
  
  % STEP 2: Calculate delta for the output layer
  
  %yt = ybin(t,:)';  
  %delta_3 = a3 - yt; % 10x1 - 10x1 => 10x1
  delta_3 = a3 - y_mat(t,:)'; % 10x1 - 10x1 => 10x1
  
%  if (t<3)
%    fprintf("t=%d, y:\n", t);
%    display(yt');
%    fprintf("t=%d, h:\n", t);
%    display(h');
%    fprintf("t=%d, delta_3 = y - h:\n", t);
%    display(delta_3');
%  end
  
  % STEP 3: Calculate delta for the 2nd layer

  % Method #1: Compute, then snip
  z2 = [1 ; z2];
  delta_2 = (Theta2' * delta_3) .* sigmoidGradient(z2);  % 26x10 * 10x1 .* 25x1
  delta_2 = delta_2(2:end);                              % 26x1 => 25x1

  % Method #2: Snip then compute
  %delta_2 = (Theta2(:,2:end)' * delta_3) .* sigmoidGradient(z2); % 25x10 * 10x1 .* 25x1
  
%  if (t<3)
%    fprintf("t=%d, delta_2:\n", t);
%    display(delta_2');
%  end

  % STEP 4: Accumulate the gradient
  % I think the dimensions of big_delta_n are supposed to match Thetan
  % Theta1: 25x401
  % Theta2: 10x26
  big_delta_1 = big_delta_1 + (delta_2 * a1'); % 25x401 + 25x1 * 1x401 = 25x401;  
  big_delta_2 = big_delta_2 + (delta_3 * a2'); % 10x26 + 10x1 * 1x26 = 10x26;  

end

% STEP 5: Compute the unregularized gradients
Theta1_grad = (1/m) .* big_delta_1;
Theta2_grad = (1/m) .* big_delta_2;

% Regularize the gradients
% Chop of the first column of Theta and regularize the rest

Theta1_grad(:,2:end) = Theta1_grad(:, 2:end) + ((lambda/m) .* Theta1(:,2:end));
Theta2_grad(:,2:end) = Theta2_grad(:, 2:end) + ((lambda/m) .* Theta2(:,2:end));


% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
