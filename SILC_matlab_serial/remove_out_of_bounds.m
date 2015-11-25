function [x]=remove_out_of_bounds(X,min,max)
    x=X(all([X>min;X<=max]));