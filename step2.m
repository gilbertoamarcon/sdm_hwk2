clear all;
close all;
clc;

% Loading maps
load('newMaps.mat');

% Global parameters
MAP     = mapTestBig;
START	= [ 1  1];
END     = [MAP.sideSize MAP.sideSize];
BUDGET  = 30;
NUM_IT  = 10000;

% History keeping buffer
hist = zeros(NUM_IT,1);

% Keeping start time
timerVal = tic;

% Generating root parent
[parent,p_info] = gen_child(MAP, START, END, BUDGET, 1);

% Genetic algorithm loop
for i = 1:NUM_IT
    
    % Generate child
    cut = randi(BUDGET);
    [child,c_info] = gen_child(MAP, START, END, BUDGET, cut, parent);
    
    % If better than parent, substitute parent
    if c_info > p_info
        p_info = c_info;
        parent = child;
    end
    
    % Keeping hist
    hist(i) = p_info;

end

% Keeping stop time
runtime = toc(timerVal)

% Plotting map
plotPath(parent,MAP,'');

% Plotting history
figure;
plot(hist);
xlabel('Generation');
ylabel('Information value');

% Showing results
[info,cost] = evaluatePath(parent,MAP)
