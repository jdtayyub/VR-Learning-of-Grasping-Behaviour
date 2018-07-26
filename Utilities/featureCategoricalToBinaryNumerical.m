function [ ef ] = featureCategoricalToBinaryNumerical( f,r )
%FEATURECATEGORICALTOBINARYNUMERICAL takes in input features as a set of
%categorical feautres with category ranges and converts the feature set to
%a nuerical feature using one-hot encoding , feature space f and list r of
%categories as labels, return ef encoded features . map is the target
%cateogry assingment, for example one type of feature might be encoded with
%categories 1 2 3 whereas a different feature space might require an
%encoding with categories 5 6 7. Map is used to define the target location
%in the encoding
ef = [];
for i = 1 : size(f,2) % iterate through features
    col = f(:,i);
    newspace = zeros(length(col),length(r));
    for j = 1 : length(col)
       newspace(j,col(j)) = 1;
    end
    ef = [ef newspace];
end


end

