%Obtener sobre la base de datos con personas andando un clasificador, obteniendo para diferentes 
%muestras en tamaño la bondad del método. Las imágenes se caracterizarán usando el vector HOG.

%Se calculan las matrices de caracteristicas y las etiquetas para 400
%imagenes positivas y 50*1 imagenes negativas
[X_pos, y_pos, X_neg, y_neg] = calcularCaracteristicas(400,1);

%Se concatenan las matrices y las etiquetas
X=[X_pos;X_neg];
y=cat(2,y_pos,y_neg);

%Se toma el 80% como train
ntrain= round(0.8*length(y));
ntest = size(X,1)-ntrain;

%Se realiza una permutacion de los indices
idx = randperm(length(y)); 

%Se toman los datos para train
X_train= X(idx(1:ntrain),:);
y_train=y(idx(1:ntrain));

%Se toman los datos para test
X_test= X(idx(ntrain+1:length(y)),:);
y_test=y(idx(ntrain+1:length(y)));

%Se construye el modelo SVM
SVMModel = fitcsvm(X_train,y_train,'Standardize',true,'KernelFunction','RBF', 'KernelScale','auto');

%Se realiza la prediccion para los datos de train y test
y_pred_train=predict(SVMModel,X_train);
y_pred_test=predict(SVMModel,X_test);

%Se calculan las matrices de confusión
confusionmat(y_train,y_pred_train)
%39 5
%0 316

confusionmat(y_test,y_pred_test)
%0 6
%0 84

%Observamos que en los resultados de test, todas las imagenes se han
%clasificado como que hay un peatón, lo cual significa que el modelo
%realmente no ha aprendido a diferenciar ambas clases debido al desbalance
%presente en los datos: 400 imagenes positivas frente a 50 negativas.

%Para solventarlo se van a tomar el mismo número de imagenes positivas que
%negativas, tomando 8 subimagenes de cada imagen en la que no hay peatón de
%forma que se tengan también 400 imagenes negativas
[X_pos, y_pos, X_neg, y_neg] = calcularCaracteristicas(400,8);

X=[X_pos;X_neg];
y=cat(2,y_pos,y_neg);
ntrain= round(0.8*length(y));
ntest = size(X,1)-ntrain;
idx = randperm(length(y));
X_train= X(idx(1:ntrain),:);
y_train=y(idx(1:ntrain));
X_test= X(idx(ntrain+1:length(y)),:);
y_test=y(idx(ntrain+1:length(y)));


SVMModel = fitcsvm(X_train,y_train,'Standardize',true,'KernelFunction','RBF', 'KernelScale','auto');

y_pred_train=predict(SVMModel,X_train);
y_pred_test=predict(SVMModel,X_test);

confusionmat(y_train,y_pred_train)
%320 2
%0 318
confusionmat(y_test,y_pred_test)
%78 0
%13 69

%Ahora sí se ha conseguido que se aprenda para ambas clases, obteniendo un
%acierto final de 91.875%




%Probando ahora con tomar únicamente 50 imagenes positivas:
[X_pos, y_pos, X_neg, y_neg] = calcularCaracteristicas(50,1);


X=[X_pos;X_neg];
y=cat(2,y_pos,y_neg);
ntrain= round(0.8*length(y));
ntest = size(X,1)-ntrain;
idx = randperm(length(y));
X_train= X(idx(1:ntrain),:);
y_train=y(idx(1:ntrain));
X_test= X(idx(ntrain+1:length(y)),:);
y_test=y(idx(ntrain+1:length(y)));


SVMModel = fitcsvm(X_train,y_train,'Standardize',true,'KernelFunction','RBF', 'KernelScale','auto');

y_pred_train=predict(SVMModel,X_train);
y_pred_test=predict(SVMModel,X_test);

confusionmat(y_train,y_pred_train)
%38 0
%0 42
confusionmat(y_test,y_pred_test)
%10 2
%7 1

%No se consiguen tan buenos resultados, unicamente un 55% de acierto.

