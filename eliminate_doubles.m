% Eliminating doubles

clear
addpath('dataset')
load('graph_data_IID.mat')
% load('gene_interactions.mat')

couples = {};
reverse_couples = {};
total_length = size(symbol_a_list, 1);
for i=1:total_length
    fprintf('Analyzing gene \t %u/%u \n', i, total_length);
    s = strcat(string(symbol_a_list(i)), "<---->", string(symbol_b_list(i)));
    reverse_s = strcat(string(symbol_b_list(i)), "<---->", string(symbol_a_list(i)));
   if ~any(contains(couples, s))
%        REMOVE COMMENTS IF YOU WANT TO DELETE INTERACTIONS WITH ITSELF
%        if size(symbol_b_list(i), 1) == size(symbol_b_list(i), 1)
%            if symbol_b_list(i) ~= symbol_b_list(i)
       couples = [couples; s];
       reverse_couples = [reverse_couples; reverse_s];
%            end
%        end
   end
end

fprintf('Size of Couple  %u\n', size(couples, 1));

for i=1:size(reverse_couples, 1)
   if any(contains(couples, reverse_couples(i)))
      id = find(couples == reverse_couples(i));
      couples(id) = [];
   end
end
fprintf('Size of Couple AFTER %u\n', size(couples, 1));

couples = table(sort(couples), 'VariableNames', {'Interactions'});
writetable(couples, 'Biogrid Interaction Table New.xls');

% summarize = table({'BioGrid Human'...
% %     ; 'Integrated Interactions Database'...
%     }, size(gene_interactions, 1), size(complete_gene_list,1), size(couples, 1), 'VariableNames', {'Database', 'Genes_Found_in_DB', 'Proteins_Interacting', 'Interactions'});

% writetable(summarize, 'DB Summary New.xls');