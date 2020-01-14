clear
addpath('dataset')
load('ppi_data.mat')
load('gene_interactions.mat')

% interactions_only_genes = table();
counter = 1;
couples_IID = {};

for i=1:size(ppi_data,1)
    if any(ismember(gene_interactions.genes_found_in_db, ppi_data.symbol1(i,1))) && any(ismember(gene_interactions.genes_found_in_db, ppi_data.symbol2(i,1)))
        if counter == 1
            interactions_only_genes = table(ppi_data.symbol1(i,1), ppi_data.symbol2(i,1), ppi_data.UniProt1(i,1), ppi_data.UniProt2(i,1), {'IID'});
            couples_IID= [couples_IID; strcat(ppi_data.symbol1(i,1), '<---->', ppi_data.symbol2(i,1))];
            counter = counter +1;
        else
            interactions_only_genes = [interactions_only_genes; table(ppi_data.symbol1(i,1), ppi_data.symbol2(i,1), ppi_data.UniProt1(i,1), ppi_data.UniProt2(i,1), {'IID'})];
            couples_IID= [couples_IID; strcat(ppi_data.symbol1(i,1), '<---->', ppi_data.symbol2(i,1))];
            counter = counter +1;
        end
        
    end
end

var_names = {'Gene_Symbol_A', 'Gene_Symbol_B', 'Uniprot_A', 'Uniprot_B', 'Database_Source'};
interactions_only_genes.Properties.VariableNames = var_names;

load('graph_data.mat')
load('data_table.mat')


for i=1:size(couples,1)
    fprintf('Analyzing Gene: %6u/%6u \n', i, size(couples,1));
    couple = split(couples.Interactions(i), '<---->');
    %%% Se i due geni sono seed
    if any(ismember(gene_interactions.genes_found_in_db, couple(1))) && any(ismember(gene_interactions.genes_found_in_db, couple(2)))
        %%% Se abbiamo A<---->B nella table sopra creata
        if any(ismember(couples_IID, couples.Interactions(i)))
            for j=1:size(interactions_only_genes,1)
               if  interactions_only_genes.Gene_Symbol_A(j) == couple(1) && interactions_only_genes.Gene_Symbol_B(j) == couple(2)
                   interactions_only_genes.Database_Source(j) = {'IID, BioGrid'};
               end
            end
        %%% Se abbiamo B<---->A nella table sopra creata
        elseif any(ismember(couples_IID, strcat(couple(2), '<---->', couple(1))))
            for j=1:size(interactions_only_genes,1)
               if  interactions_only_genes.Gene_Symbol_A(j) == couple(2) && interactions_only_genes.Gene_Symbol_B(j) == couple(1)
                   interactions_only_genes.Database_Source(j) = {'IID, BioGrid'};
               end
            end
        else
            Gene_Symbol_A = couple(1); 
            Gene_Symbol_B = couple(2);
            for j=1:size(complete_data, 1)
               if Gene_Symbol_A == complete_data.Gene_Symbol(j)
                   Uniprot_A = complete_data.Uniprot_ID(j);
               elseif Gene_Symbol_B == complete_data.Gene_Symbol(j)
                   Uniprot_B = complete_data.Uniprot_ID(j);
               else
               end
            end
            Database_Source = {'Biogrid'};
            
            if Gene_Symbol_A == 'COX2' || Gene_Symbol_B == 'COX2' || Gene_Symbol_A == 'ND1' || Gene_Symbol_B == 'ND1'
                
                continue
                
            end

            interactions_only_genes = [interactions_only_genes; table(Gene_Symbol_A, Gene_Symbol_B, Uniprot_A, Uniprot_B, Database_Source)];

        end
        
%         couple_only_seed_A = {couple_only_seed_A; couple(1)};
%         couple_only_seed_B = {couple_only_seed_B; couple(2)};
%         if ismember( ,couples{i,1})
%             
%         end
    end
end