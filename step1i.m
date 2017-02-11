clear all;
close all;
clc;

% Loading maps
load('newMaps.mat');

% Global parameters
MAP     = mapTest2;
START	= [ 1  1];
END     = [MAP.sideSize MAP.sideSize];
BUDGET  = 2*(MAP.sideSize-1);

path(1,:) = START;
for i = 1:BUDGET

    % Defining the valid action set
    action_set = gen_action_set(END, BUDGET, path(i,:), i);

    % ======================================
    % Adding best-valued action to path
    % ======================================
    max_pos = zeros(1,2);
    max_val = -1e10;
    for j = 1:size(action_set,1)
        pos = path(i,:) + action_set(j,:);
        val = findInformation(pos,MAP);
        if val > max_val
            max_val = val;
            max_pos = pos;
        end
    end
    path(i+1,:) = max_pos;

end

% Plotting map
plotPath(path,MAP,'Greedy: Map 1, Budget 6');

% Showing results
[info,cost] = evaluatePath(path,MAP)
