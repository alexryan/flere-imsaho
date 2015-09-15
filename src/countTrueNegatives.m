function numberOfTrueNegatives = countTrueNegatives(predictions, actuals, positiveLabel)
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % This function inputs 2 vectors of labels of the same length
  % predictions and actuals
  % and compares them element by element to count the number of true negatives.
  %
  % A "true negative" occurs when a "predicted negative" matches an "actual negative"
  % A negative is any label that is not positive.
  %
  % For example
  % If the set of all possible labels is {1, 2}
  % And the "positive label" is defined to be 2.
  % Then the set of negative labels is {1}
  % The number of "true negatives" is equal to
  % The number of negatives in the prediction vector
  % Which have a corresponding negative in the actuals vector.
  %
  % The "positiveLabel" parameter identifies which label is considered to be positive.
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  numberOfTrueNegatives = 0;
  
  indicesOfPositivePredictions = find(predictions!=positiveLabel);

  %disp(size(pos));
  
  for element = indicesOfPositivePredictions'
    if (actuals(element) != positiveLabel)
      numberOfTrueNegatives = numberOfTrueNegatives + 1;
    end
  end

end
