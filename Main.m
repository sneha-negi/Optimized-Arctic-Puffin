%Developed in MATLAB R2022b
% Source codes 
% _____________________________________________________
clear  
clc
close all
clear  
clc
close all

N = 30; % Number of search agents
T = 50000; % Maximum number of function evaluations per run
F_name = 'F10'; % Name of the test function
Num_runs = 30; % Number of runs to calculate the mean

% Load details of the selected benchmark function
[lb, ub, D, fobj] = CEC2017(F_name);

Best_Fitness_AllRuns = zeros(Num_runs, 1);
Best_Pos_AllRuns = zeros(Num_runs, D);

for run = 1:Num_runs
    [Best_Fitness, Best_Pos, ~] = APO(N, T, lb, ub, D, fobj);
    
    Best_Fitness_AllRuns(run) = Best_Fitness;
    Best_Pos_AllRuns(run, :) = Best_Pos;
    
    disp(['Run ', num2str(run), ' - Best Fitness: ', num2str(Best_Fitness)]);
    disp(['Run ', num2str(run), ' - Best Position: ', num2str(Best_Pos)]);
end

Mean_Best_Fitness = mean(Best_Fitness_AllRuns);
Mean_Best_Pos = mean(Best_Pos_AllRuns, 1); 

% Display the mean calculation results
disp(' ');
disp(['The mean best fitness over ', num2str(Num_runs), ' runs is: ', num2str(Mean_Best_Fitness)]);
disp(['The mean best position over ', num2str(Num_runs), ' runs is: ', num2str(Mean_Best_Pos)]);
