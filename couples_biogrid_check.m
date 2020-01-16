clear
addpath('dataset')
load('biogrid_complete_data.mat')
load('graph_data.mat')

couples_in_list = 0;
couples_not_in_list = 0;
total_length = size(biogrid_complete_data,1);
new_couples = {};

for i=1:total_length
    fprintf('Analyzing gene %6u/%6u \n', i, total_length)
    symbol_a = biogrid_complete_data.OfficialSymbolInteractorA(i);
    symbol_b = biogrid_complete_data.OfficialSymbolInteractorB(i);
    if any(ismember(complete_gene_list, symbol_a)) && any(ismember(complete_gene_list, symbol_b))
        temp_couple =  strcat(symbol_a, '<---->', symbol_b);
        temp_reverse_couple =  strcat(symbol_b, '<---->', symbol_a);
        if any(ismember(couples.Interactions, temp_couple)) || any(ismember(couples.Interactions, temp_reverse_couple))
%             fprintf('Couple already in list \n');
            couples_in_list = couples_in_list + 1;
        else
            couples_not_in_list = couples_not_in_list + 1;
            new_couples = [new_couples; temp_couple];
        end
    end
end