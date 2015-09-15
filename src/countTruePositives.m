function numberOfTruePositives = countTruePositives(predictions, actuals, positiveLabel)
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % This function inputs 2 vectors of labels of the same length
  % predictions and actuals
  % and compares them element by element to count the number of "true positives".
  %
  % A "true positive" occurs when a "predicted positive" matches an "actual positive"
  % 
  % For example
  % If the set of all possible labels is {1, 2}
  % And the "positive label" is defined to be 2.
  % Then the number of true positives is equal to
  % The number of positives in the predictions vector
  % Which have a corresponding positive in the actuals vector.
  %
  % The "positiveLabel" parameter identifies which label is considered to be positive.
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  numberOfTruePositives = 0;
  
  indicesOfPositivePredictions = find(predictions==positiveLabel);

  %disp(size(pos));
  
  for element = indicesOfPositivePredictions'
    if (actuals(element) == positiveLabel)
      numberOfTruePositives = numberOfTruePositives + 1;
    end
  end

end
