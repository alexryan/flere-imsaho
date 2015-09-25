function [p p1 p2] = predict(Theta1, Theta2, X)
%PREDICT Predict the label of an input given a trained neural network
%   p = PREDICT(Theta1, Theta2, X) outputs the predicted label of X given the
%   trained weights of a neural network (Theta1, Theta2)
%   p1 = probability of class 1
%   p2 = probability of class 2

% Useful values
m = size(X, 1);
num_labels = size(Theta2, 1);

% You need to return the following variables correctly 
p = zeros(size(X, 1), 1);

h1 = sigmoid([ones(m, 1) X] * Theta1');
h2 = sigmoid([ones(m, 1) h1] * Theta2');
[dummy, p] = max(h2, [], 2);

%disp(h1);
%disp(h2);

p1 = h2(:,1);
p2 = h2(:,2);

%maxClass1Prob = max(h2(:,1));
%maxClass2Prob = max(h2(:,2));
%minClass1Prob = min(h2(:,1));
%minClass2Prob = min(h2(:,2));

%printf("class 1: min and max probabilities: %f %f\n", minClass1Prob, maxClass1Prob);
%printf("class 2: min and max probabilities: %f %f\n", minClass2Prob, maxClass2Prob);

%How many predicitons for class 1 have a probability > threshold

%threshold = 0.3;
%indices = find(h2(:,1)>threshold);
%count = size(indices,1);
%printf("with threshold = %f, number of class 1 = %d\n", threshold, count);

%threshold = 0.25;
%indices = find(h2(:,1)>threshold);
%count = size(indices,1);
%printf("with threshold = %f, number of class 1 = %d\n", threshold, count);

%threshold = 0.2;
%indices = find(h2(:,1)>threshold);
%count = size(indices,1);
%printf("with threshold = %f, number of class 1 = %d\n", threshold, count);

%threshold = 0.15;
%indices = find(h2(:,1)>threshold);
%count = size(indices,1);
%printf("with threshold = %f, number of class 1 = %d\n", threshold, count);

%threshold = 0.175;
%indices = find(h2(:,1)>threshold);
%count = size(indices,1);
%printf("with threshold = %f, number of class 1 = %d\n", threshold, count);

%threshold = 0.180;
%indices = find(h2(:,1)>threshold);
%count = size(indices,1);
%printf("with threshold = %f, number of class 1 = %d\n", threshold, count);

%threshold = 0.185;
%indices = find(h2(:,1)>threshold);
%count = size(indices,1);
%printf("with threshold = %f, number of class 1 = %d\n", threshold, count);

%threshold = 0.190;
%indices = find(h2(:,1)>threshold);
%count = size(indices,1);
%printf("with threshold = %f, number of class 1 = %d\n", threshold, count);

%threshold = 0.195;
%indices = find(h2(:,1)>threshold);
%count = size(indices,1);
%printf("with threshold = %f, number of class 1 = %d\n", threshold, count);

%threshold = 0.1975;
%indices = find(h2(:,1)>threshold);
%count = size(indices,1);
%printf("with threshold = %f, number of class 1 = %d\n", threshold, count);

%threshold = 0.196;
%indices = find(h2(:,1)>threshold);
%count = size(indices,1);
%printf("with threshold = %f, number of class 1 = %d\n", threshold, count);

%threshold = 0.1965;
%indices = find(h2(:,1)>threshold);
%count = size(indices,1);
%printf("with threshold = %f, number of class 1 = %d\n", threshold, count);

%threshold = 0.19625;
%indices = find(h2(:,1)>threshold);
%count = size(indices,1);
%printf("with threshold = %f, number of class 1 = %d\n", threshold, count);

%printf("the indices of the examples passing the threshold:\n");
%disp(indices');

end
