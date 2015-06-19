function [T] = prepareTestData()

%% Initialization
clear ; close all; clc

load 'test_set/001-full';
T(1,:) = wavedata(1,[1:1000]);

load 'test_set/002-full';
T(2,:) = wavedata(1,[1:1000]);

load 'test_set/003-full';
T(3,:) = wavedata(1,[1:1000]);

load 'test_set/004-full';
T(4,:) = wavedata(1,[1:1000]);

load 'test_set/005-full';
T(5,:) = wavedata(1,[1:1000]);

load 'test_set/006-full';
T(6,:) = wavedata(1,[1:1000]);

load 'test_set/007-full';
T(7,:) = wavedata(1,[1:1000]);

load 'test_set/008-full';
T(8,:) = wavedata(1,[1:1000]);
save 'test.mat' T
