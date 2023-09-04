%---------------------------------------------------------------------------------------------------
% For Paper
% "Distributed Flocking Control with Ellipsoidal Level Surfaces"
% by P. Hastedt, A. Datar, K. Kocev, and H. Werner
% Copyright (c) Institute of Control Systems, Hamburg University of Technology. All rights reserved.
% Licensed under the GPLv3. See LICENSE in the project root for license information.
% Author(s): Philipp Hastedt
%---------------------------------------------------------------------------------------------------

function [Jq,Jp] = calculatePerformanceIndices(data, cfg, rc, d, plotResults, varargin)
agentCount = length(data.data.position(1,1,:));
Jq = zeros(1,length(data.t));
Jp = zeros(1,length(data.t));
[~, T_normalized, normalizationFactor] = calculateEllipsoidalTransformation(cfg.ellipseAxes,cfg.ellipseRotation);
parfor t = 1:length(data.t)
    position = data.data.position;
    velocity = data.data.velocity;

    % calculate position performance index
    countQ = 0;
    for i  = 1:agentCount
        for j = 1:agentCount
            qij = norm(T_normalized*(position(t,:,i)-position(t,:,j))');
            if (qij<=rc*normalizationFactor) && (i~=j)
                Jq(t) = Jq(t)+(qij-d*normalizationFactor)^2;
                countQ = countQ+1;
            end
        end
    end
    if countQ ~=0
        Jq(t) = Jq(t)/countQ;
    end
    % calculate velocity performance index
    for i = 1:agentCount
        p_mean = sum(squeeze(velocity(t,:,:)),2)/agentCount;
        Jp(t) = Jp(t) + norm(velocity(t,:,i)-p_mean')^2/agentCount;
    end
end
if plotResults
    figure()
    subplot(1,2,1)
    plot(data.t, Jq);
    xlabel('time');
    ylabel('J_q');
    title('Position Irregularity');
    grid on;
    subplot(1,2,2)
    plot(data.t, Jp);
    xlabel('time');
    ylabel('J_p');
    title('Velocity Mismatch');
    grid on;
    set(gca, 'XLim', [0 data.t(end-1)]);
end

end