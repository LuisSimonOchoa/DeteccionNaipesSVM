function [trainedClassifier, validationAccuracy] = trainClassifierSVM(datasetTable)
% Extraer predictores y respuestas
predictorNames = {'mu1', 'mu2', 'mu3', 'mu4', 'mu5', 'mu6', 'mu7', 'area', 'excentricidad','filledarea','circularidad','perimetro','dEquiv'};
predictors = datasetTable(:,predictorNames);
predictors = table2array(varfun(@double, predictors));
response = datasetTable.name;

%ENTRENAMIENTO
%Por default itera 1e6 veces
%Se define la funcion de kernel
%fitcecoc es para la clasificacion muliticlase y se define el método one vs one
template = templateSVM('KernelFunction', 'polynomial', 'KernelScale', 'auto', 'BoxConstraint', 1, 'Standardize', 1);
trainedClassifier = fitcecoc(predictors, response, 'Learners', template, 'Coding', 'onevsone', 'PredictorNames', {'mu1', 'mu2' 'mu3' 'mu4' 'mu5' 'mu6' 'mu7' 'area' 'excentricidad' 'filledarea' 'circularidad' 'perimetro' 'dEquiv'}, 'ResponseName', 'name', 'ClassNames', {'CINCO' 'CORAZON' 'CUATRO' 'DIAMANTE' 'DIEZ' 'DOS' 'ESPADA' 'NUEVE' 'OCHO' 'SEIS' 'SIETE' 'TREBOL' 'TRES' 'UNO' 'J' 'Q' 'K'});

% Validación cruzada
partitionedModel = crossval(trainedClassifier, 'KFold', 5);

% Calcula la precisión de la validación
validationAccuracy = 1 - kfoldLoss(partitionedModel, 'LossFun', 'ClassifError');
