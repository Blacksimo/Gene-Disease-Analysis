clear
addpath('dataset')
load('interactions_summary_IID.mat')
load('gene_interactions.mat')

couple_only_seed_A = {};
couple_only_seed_B = {}; 

for i=1:size(couples,1)
    couple = split(couples{i,1}, '<---->');
    if ismember(gene_interactions.genes_found_in_db, couple(1)) && ismember(gene_interactions.genes_found_in_db, couple(2))
        couple_only_seed_A = {couple_only_seed_A; couple(1)};
        couple_only_seed_B = {couple_only_seed_B; couple(2)};
        if ismember( ,couples{i,1})
            
        
    end
end