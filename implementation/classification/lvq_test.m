clear;
dataSets = {'seg_run4t'};
dataPath = '/home/jelle/RUG/HR/data/';
resultsPath = '/home/jelle/RUG/HR/results/';
impPath = '/home/jelle/RUG/HR/implementation/classification/';
addpath(genpath(impPath));
preproc = {'naive'};

gmlvqParams = fn_exp_paramGenerator(struct(...
    'PrototypesPerClass',1, ...
    'regularization',0, ...
    'initialMatrix',[], ...
    'nb_epochs', 100 ...
    ),...
    struct()...
);

runs = 1;

gmlvq_expermiments = fn_exp_generator('gmlvq',dataSets,dataPath,preproc,runs, {gmlvqParams});

results = fn_exp_runner(gmlvq_expermiments);
%fn_exp_save_results(results, resultsPath);

