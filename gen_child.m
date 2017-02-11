% =========================================================================
% function [path,info] = gen_child(MAP, START, END, BUDGET, CUT, path)
% =========================================================================
% Inputs:
%	MAP:    Map of the world
%	START:  Initial state
%	END:    Goal state
%	BUDGET: Total path budget
%	CUT:    Limit position to preserve from parent
%	path:   Parent path
% Outputs:
%	path:   Child path
%	info:   Child path information value (fitness value)
% Author Gilberto Marcon
% =========================================================================
function [path,info] = gen_child(MAP, START, END, BUDGET, CUT, path)

    % Initializing the path with the start
    path(1,:) = START;
    
    % Mutation loop
    for i = CUT:BUDGET

        % Defining the valid action set
        action_set = gen_action_set(END, BUDGET, path(i,:), i);
        
        % Random action choice
        action_choice = randi(size(action_set,1));
        next_action = action_set(action_choice,:);
        
        % State transition by aplying next action
        path(i+1,:) = path(i,:) + next_action;

    end
    
    % Evaluating results
    info = evaluatePath(path,MAP);

end
