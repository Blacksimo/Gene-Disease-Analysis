clear
addpath('dataset')
load('ppi_data.mat')
load('gene_interactions.mat')

couples_IID = {};
iid_var = {};
for i=1:size(ppi_data, 1)
    iid_var = [iid_var; {'IID'}];
    couples_IID= [couples_IID; strcat(ppi_data.symbol1(i,1), '<---->', ppi_data.symbol2(i,1))];
end

union_interactome = table(ppi_data.symbol1, ppi_data.symbol2, ppi_data.UniProt1, ppi_data.UniProt2, iid_var);

var_names = {'Gene_Symbol_A', 'Gene_Symbol_B', 'Uniprot_A', 'Uniprot_B', 'Database_Source'};
union_interactome.Properties.VariableNames = var_names;


load('graph_data.mat')
load('data_table.mat')


for i=1:size(couples,1)
    fprintf('Analyzing Gene: %6u/%6u \n', i, size(couples,1));
    couple = split(couples.Interactions(i), '<---->');
    %%% Se i due geni sono seed
    if ~(all(~ismember(gene_interactions.genes_found_in_db, couple(1))) && all(~ismember(gene_interactions.genes_found_in_db, couple(2))))
        %%% Se abbiamo A<---->B nella table sopra creata
        if any(ismember(couples_IID, couples.Interactions(i)))
            for j=1:size(union_interactome,1)
               if  union_interactome.Gene_Symbol_A(j) == couple(1) && union_interactome.Gene_Symbol_B(j) == couple(2)
                   union_interactome.Database_Source(j) = {'IID, BioGrid'};
               end
            end
        %%% Se abbiamo B<---->A nella table sopra creata
        elseif any(ismember(couples_IID, strcat(couple(2), '<---->', couple(1))))
            for j=1:size(union_interactome,1)
               if  union_interactome.Gene_Symbol_A(j) == couple(2) && union_interactome.Gene_Symbol_B(j) == couple(1)
                   union_interactome.Database_Source(j) = {'IID, BioGrid'};
               end
            end
        else
            Gene_Symbol_A = couple(1); 
            Gene_Symbol_B = couple(2);
%             for j=1:size(complete_data, 1)
%                if Gene_Symbol_A == complete_data.Gene_Symbol(j)
%                    Uniprot_A = complete_data.Uniprot_ID(j);
%                elseif Gene_Symbol_B == complete_data.Gene_Symbol(j)
%                    Uniprot_B = complete_data.Uniprot_ID(j);
%                else
%                end
%             end
%             for j=1:size(ppi_data_nonseed, 1)
%                if Gene_Symbol_A == ppi_data_nonseed.symbol1(j)
%                    Uniprot_A = ppi_data_nonseed.UniProt1(j);
%                elseif Gene_Symbol_B == ppi_data_nonseed.symbol1(j)
%                    Uniprot_B = ppi_data_nonseed.UniProt1(j);
%                else
%                end
%             end
            index = ppi_data_nonseed.symbol1 == Gene_Symbol_A;
            Uniprot_A = ppi_data_nonseed.UniProt1(index);
            if size(Uniprot_A, 1) == 0
               index = complete_data.Gene_Symbol == Gene_Symbol_A;
               Uniprot_A = complete_data.Uniprot_ID(index);
               if size(Uniprot_A, 1) == 0
                   continue
               end
            end
            Uniprot_A = Uniprot_A(1);
            index = ppi_data_nonseed.symbol1 == Gene_Symbol_B;
            Uniprot_B = ppi_data_nonseed.UniProt1(index);
            if size(Uniprot_B, 1) == 0
               index = complete_data.Gene_Symbol == Gene_Symbol_B;
               Uniprot_A = complete_data.Uniprot_ID(index);
               if size(Uniprot_B, 1) == 0
                   continue
               end 
            end
            Uniprot_B = Uniprot_B(1);
            
            Database_Source = {'Biogrid'};
            
            if Gene_Symbol_A == 'COX2' || Gene_Symbol_B == 'COX2' || Gene_Symbol_A == 'ND1' || Gene_Symbol_B == 'ND1'
                
                continue
                
            end

            union_interactome = [union_interactome; table(Gene_Symbol_A, Gene_Symbol_B, Uniprot_A, Uniprot_B, Database_Source)];

        end
        
%         couple_only_seed_A = {couple_only_seed_A; couple(1)};
%         couple_only_seed_B = {couple_only_seed_B; couple(2)};
%         if ismember( ,couples{i,1})
%             
%         end
    else
%         fprintf('banana');
    end
end