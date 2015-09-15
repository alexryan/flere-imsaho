ones = 0;
twos = 0;
for i = 1: length(pred1)
 ones = ones + sum(1==pred1(i));
 twos = twos + sum(2==pred1(i));
 end

