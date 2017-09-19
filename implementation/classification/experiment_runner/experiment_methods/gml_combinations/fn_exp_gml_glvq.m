function [ results ] = fn_exp_gml_glvq( dataset, gmlParams, glvqParams)

gmlResults = fn_exp_gml(dataset,gmlParams);

W = gmlResults.W;

glvqParams.initialMatrix = W; %todo ask Biehl if this should be WW'

glvqResults = fn_exp_glvq(dataset, glvqParams);

results = struct('gml',gmlResults, 'glvq', glvqResults);

end
