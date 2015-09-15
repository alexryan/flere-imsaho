function numberOfFalseNegatives = countFalseNegatives(predictions, actuals, positiveLabel)
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % This function inputs 2 vectors of labels of the same length
  % predictions and actuals
  % and compares them element by element to count the number of "false negatives".
  %
  % A "false negative" occurs when a "predicted negative" matches an "actual positive"
  % 
  % For example
  % If the set of all possible labels is {1, 2}
  % And the "positive label" is defined to be 2.
  % Then the number of false negatives is equal to
  % The number of negatives in the predictions vector
  % Which have a corresponding positive in the actuals vector.
  %
  % The "positiveLabel" parameter identifies which label is considered to be positive.
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  numberOfFalseNegatives = 0;
  negatives = find(predictions!=positiveLabel);
  numberOfNegatives = size(negatives,1);
  numberOfTrueNegatives = countTrueNegatives(predictions, actuals, positiveLabel);
  numberOfFalseNegatives = numberOfNegatives - numberOfTrueNegatives;

end
