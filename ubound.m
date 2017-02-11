% =========================================================================
% function info = ubound(MAP, v_s, v_e, B, P)
% =========================================================================
% This function evaluates the information achievable from a node v_s, given
% the budget restriction B and the path travelled to reach v_s.
% To do so, it creates a set of edges 'set' that includes all nodes in the
% path P and all nodes reacheable from v_s, yet respecting the budget B.
% Inputs:
%	MAP:    Map of the world
%	v_s:	Initial state
%	v_e:    Goal state
%	B:      Total path budget
%	P:      Parent path
% Outputs:
%	info:   Set information value
% Code: Gilberto Marcon
% Algorithm: Jonathan Binney and Gaurav S. Sukhatme.
% "Branch and Bound for Informative Path Planning".
% In IEEE International Conference on Robotics and Automation (ICRA), 2012. 
% =========================================================================
function info = ubound(MAP, v_s, v_e, B, P)

    % For all R nodes in the graph
    index = 1;  
    set = zeros(0,2);
    for i = 1:MAP.sideSize
        for j = 1:MAP.sideSize
            
            % Node R
            R = [i j];
            
            % Checking if R is in path
            in_path = 0;
            for k = P'
                if R == k'
                    in_path = 1;
                    break;
                end
            end

            % Adding node to the set 
            if ~in_path && sum(abs(R - v_s)) + sum(abs(v_e - R)) <= B
                set(index,:) = R;
                index = index + 1;
            end

        end
    end

    % Adding path to the set
    set = [set; P];

    % Evaluating set
    info = evaluatePath(set,MAP);

end
