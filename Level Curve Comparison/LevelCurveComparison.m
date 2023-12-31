%---------------------------------------------------------------------------------------------------
% For Paper
% "Distributed Flocking Control with Ellipsoidal Level Surfaces"
% by P. Hastedt, A. Datar, K. Kocev, and H. Werner
% Copyright (c) Institute of Control Systems, Hamburg University of Technology. All rights reserved.
% Licensed under the GPLv3. See LICENSE in the project root for license information.
% Author(s): Philipp Hastedt
%---------------------------------------------------------------------------------------------------

clear; close all;

% Parameters
d1 = 4;
d2 = 6;
T1 = diag([1, 2]);
T2 = diag([1.5, 3]);

% Ellipse Definition
E1 = @(z1, z2) norm(T1*[z1;z2]) - d1;
E2 = @(z1, z2) norm(T2*[z1;z2]) - d2;

% Level Surface Comparison
[Z1,Z2] = meshgrid(-6:0.1:6,-3:0.1:3);

figure()
hold on;
contour(Z1,Z2,arrayfun(E2,Z1,Z2),[-1,0,1],'EdgeColor',[0.8500 0.3250 0.0980],'ShowText','On');
contour(Z1,Z2,arrayfun(E1,Z1,Z2),[-1,0,1],'EdgeColor','k','ShowText','On','LineStyle','--');
grid on;
xlabel('z_1')
ylabel('z_2')
title('Level Surface Comparison')