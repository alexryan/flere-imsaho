function numberOfFalsePositives = countFalsePositives(predictions, actuals, positiveLabel)
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % This function inputs 2 vectors of labels of the same length
  % predictions and actuals
  % and compares them element by element to count the number of "false positives".
  %
  % A "false positive" occurs when a "predicted positive" matches an "actual negative"
  % 
  % For example
  % If the set of all possible labels is {1, 2}
  % And the "positive label" is defined to be 2.
  % Then the number of false positives is equal to
  % The number of positives in the predictions vector
  % Which have a corresponding negative in the actuals vector.
  %
  % The "positiveLabel" parameter identifies which label is considered to be positive.
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  numberOfFalsePositives = 0;
  positives = find(predictions==positiveLabel);
  numberOfPositives = size(positives,1);
  numberOfTruePositives = countTruePositives(predictions, actuals, positiveLabel);
  numberOfFalsePositives = numberOfPositives - numberOfTruePositives;

end
