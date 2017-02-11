clear all;
close all;
clc;

% Loading maps
load('newMaps.mat');

% Global parameters
MAP	= mapTest2;
v_s	= [ 1  1];
v_e	= [MAP.sideSize MAP.sideSize];
B	= 12;

% IPP-BNB
start_time = tic;
[P,info] = ippbnb(MAP, v_s, v_e, B, v_s, v_s, 0)
toc(start_time)

% Plotting map
% plotPath(P,MAP,'');