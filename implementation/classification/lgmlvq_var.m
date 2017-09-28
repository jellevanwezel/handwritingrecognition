%Improvised LVQ script

clear;
dataSets = {'sobel_seg','prewit_seg','sobel_base','prewit_base'};
dataPath = '/home/jelle/RUG/HR/data/';
resultsPath = '/home/jelle/RUG/HR/results/';
impPath = '/home/jelle/RUG/HR/implementation/classification/';
addpath(genpath(impPath));
preproc = {'normalized_var'};

lgmlvqParams = fn_exp_paramGenerator(struct(...
        'PrototypesPerClass',1, ...
        'regularization',0, ...
        'MaxIter', 8000, ...
        'initialMatrices', [], ...
        'Display', 'off'...
    ),...
    struct(...
));


runs = 10;

lgmlvq_expermiments = fn_exp_generator('lgmlvq',dataSets,dataPath,preproc, 0.1, runs, {lgmlvqParams});

experiments = lgmlvq_expermiments;

results = fn_exp_runner(experiments);
fn_exp_save_results(results, resultsPath);

