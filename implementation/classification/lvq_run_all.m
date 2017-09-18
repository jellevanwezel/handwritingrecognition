%Improvised LVQ script

clear;
dataSets = {'seg_run4t'};
dataPath = '/home/jelle/RUG/HR/data/';
resultsPath = '/home/jelle/RUG/HR/results/';
impPath = '/home/jelle/RUG/HR/implementation/classification/';
addpath(genpath(impPath));
preproc = {'naive','normalized','normalized_var'};

glvqParams = fn_exp_paramGenerator(struct(...
        'PrototypesPerClass',1, ...
        'regularization',0, ...
        'nb_epochs', 8000 ...
    ),...
    struct(...
));

gmlvqParams = fn_exp_paramGenerator(struct(...
    'PrototypesPerClass',1, ...
    'regularization',0, ...
    'initialMatrix',[], ...
    'nb_epochs', 8000 ...
    ),...
    struct()...
);

grlvqParams = fn_exp_paramGenerator(struct(...
        'PrototypesPerClass',1, ...
        'regularization',0, ...
        'nb_epochs', 8000, ...
        'initialRelevances', [], ...
        'Display', 'off'...
    ),...
    struct(...
));

lgmlvqParams = fn_exp_paramGenerator(struct(...
        'PrototypesPerClass',1, ...
        'regularization',0, ...
        'nb_epochs', 8000, ...
        'initialMatrices', [], ...
        'Display', 'off'...
    ),...
    struct(...
));


runs = 10;

glvq_expermiments = fn_exp_generator('glvq',dataSets,dataPath,preproc,runs, {glvqParams});
gmlvq_expermiments = fn_exp_generator('gmlvq',dataSets,dataPath,preproc,runs, {gmlvqParams});
grlvq_expermiments = fn_exp_generator('grlvq',dataSets,dataPath,preproc,runs, {grlvqParams});
lgmlvq_expermiments = fn_exp_generator('lgmlvq',dataSets,dataPath,preproc,runs, {lgmlvqParams});

experiments = [glvq_expermiments,gmlvq_expermiments,grlvq_expermiments,lgmlvq_expermiments];

results = fn_exp_runner(experiments);
fn_exp_save_results(results, resultsPath);

