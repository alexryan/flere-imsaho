function [X_norm, mu, sigma] = featureNormalize(X)
%FEATURENORMALIZE Normalizes the features in X 
%   FEATURENORMALIZE(X) returns a normalized version of X where
%   the mean value of each feature is 0 and the standard deviation
%   is 1. This is often a good preprocessing step to do when
%   working with learning algorithms.

X_norm = X;

# For music files, this can be simplified
% We're using signed 16-bit numbers for each sample.
% That means the numbers will vary between -2^15 and +2^15

columnCount = columns(X);
for i = 1:columnCount
  X_norm(:,i) = (X_norm(:,i) / (2^15));
end

end

