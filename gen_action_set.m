% =========================================================================
% function action_set = gen_action_set(END, BUDGET, state, i)
% =========================================================================
% Inputs:
%	END:    Goal state
%	BUDGET: Total path budget
%	state:  Current state
%	i:      Current iteration
% Outputs:
%	action_set:    Set of valid actions
%   Valid actions respect the world boundaries and budget constraints.
% Author Gilberto Marcon
% =========================================================================
function action_set = gen_action_set(END, BUDGET, state, i)

    % Displacement actions
    NOOP    = [ 0  0];
    X_PLUS  = [ 1  0];
    X_MINUS = [-1  0];
    Y_PLUS  = [ 0  1];
    Y_MINUS = [ 0 -1];
        
    % Empty action set
    action_set = zeros(0,2);

    % Manhattan distance from current state to the goal
    d = sum(abs(state(:)-END(:)));

    % Actions toward the goal
    if state(1) < END(1)
        action_set = [action_set; X_PLUS];
    end
    if state(2) < END(1)
        action_set = [action_set; Y_PLUS];
    end

    % Noop action
    if d+i <= BUDGET
        action_set = [action_set; NOOP];
    end

    % Actions away from the goal
    if d+i < BUDGET
        if state(1) > 1
            action_set = [action_set; X_MINUS];
        end
        if state(2) > 1
            action_set = [action_set; Y_MINUS];
        end
    end

end
