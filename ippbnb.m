% =========================================================================
% function [P_m,m_m] = ippbnb(MAP, v_s, v_e, B, P, P_m, m_m)
% =========================================================================
% This function finds the most informative path from v_s to v_e
% Inputs:
% MAP:    Map of the world
% v_s: Initial state
% v_e:    Goal state
% B:      Total path budget
% P:      Parent path
% P_m:   Best path
% m_m:    Best path informative value
% Outputs:
% P_m:   Best path
% m_m:   Best path's informative value
% Code: Gilberto Marcon
% Algorithm: Jonathan Binney and Gaurav S. Sukhatme.
% "Branch and Bound for Informative Path Planning".
% In IEEE International Conference on Robotics and Automation (ICRA), 2012.
% =========================================================================
function [P_m,m_m] = ippbnb(MAP, v_s, v_e, B, P, P_m, m_m)
    
    is_leaf = 1;

    % Displacement actions
    NOOP    = [ 0  0];
    X_PLUS  = [ 1  0];
    X_MINUS = [-1  0];
    Y_PLUS  = [ 0  1];
    Y_MINUS = [ 0 -1];
        
    % Edges leaving v_s
    edges = v_s+NOOP;
    if v_s(1) < v_e(1)
        edges = [edges; v_s+X_PLUS];
    end
    if v_s(2) < v_e(1)
        edges = [edges; v_s+Y_PLUS];
    end
    if v_s(1) > 1
        edges = [edges; v_s+X_MINUS];
    end
    if v_s(2) > 1
        edges = [edges; v_s+Y_MINUS];
    end

    % For each edge leaving v_s do
    for edge = edges'
        P_new = [P; edge'];
        v_new = edge';
        B_new = B - 1;
        if sum(abs(v_new-v_e)) <= B_new
            is_leaf = 0;
            if ubound(MAP, v_new, v_e, B_new, P_new) > m_m
                [P_m,m_m] = ...
                    ippbnb(MAP, v_new, v_e, B_new, P_new, P_m, m_m);
            end            
        end
    end
    
    if is_leaf == 1
        m = evaluatePath(P,MAP);
        if m > m_m
            P_m = P;
            m_m = m;
        end 
    end 
    
end
