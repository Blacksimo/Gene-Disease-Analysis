clear
addpath('dataset')
load('graph_data.mat')

opts = detectImportOptions('dataset\BIOGRID-ORGANISM-3.5.180.tab2\BIOGRID-ORGANISM-Homo_sapiens-3.5.180.tab2.txt');
opts.SelectedVariableNames = {'EntrezGeneInteractorA', 'EntrezGeneInteractorB', 'OfficialSymbolInteractorA','OfficialSymbolInteractorB'};
biogrid_interactions = readtable('dataset\BIOGRID-ORGANISM-3.5.180.tab2\BIOGRID-ORGANISM-Homo_sapiens-3.5.180.tab2.txt', opts);

% api_call = 'http://rest.genenames.org/fetch/symbol/';
% opt = weboptions('Timeout', 60);

complete_gene_list_entrez_id = {};
skipped = 0;

for i=1:size(couples,1)
    fprintf('Analyzing interaction %6u/%6u \n', i, size(couples,1))
    temp_couple = split(couples.Interactions(i), '<---->');
%     gene_one = webread(strcat(api_call, temp_couple(1)), opt);
%     gene_two = webread(strcat(api_call, temp_couple(2)), opt);
    idx_A = find(biogrid_interactions.OfficialSymbolInteractorA == temp_couple(1));
    if ~isempty(idx_A)
        idx_A = idx_A(1,1);
        entrez_a = biogrid_interactions.EntrezGeneInteractorA;
        entrez_a = entrez_a(idx_A);
    else
        idx_A = find(biogrid_interactions.OfficialSymbolInteractorB == temp_couple(1));
        if ~isempty(idx_A)
            idx_A = idx_A(1,1);
            entrez_a = biogrid_interactions.EntrezGeneInteractorB;
            entrez_a = entrez_a(idx_A);
        else
            fprintf('Skipped \n')
            skipped = skipped + 1;
            continue
        end
    end
    idx_B = find(biogrid_interactions.OfficialSymbolInteractorA == temp_couple(2));
    if ~isempty(idx_B)
        idx_B = idx_B(1,1);
        entrez_b = biogrid_interactions.EntrezGeneInteractorA;
        entrez_b = entrez_b(idx_B);
    else
        idx_B = find(biogrid_interactions.OfficialSymbolInteractorB == temp_couple(2));
        if ~isempty(idx_B)
            idx_B = idx_B(1,1);
            entrez_b = biogrid_interactions.EntrezGeneInteractorB;
            entrez_b = entrez_b(idx_B);
        else
            fprintf('Skipped \n')
            skipped = skipped + 1;
            continue
        end
    end
    complete_gene_list_entrez_id = [complete_gene_list_entrez_id; strcat(string(entrez_a), ',', string(entrez_b))];
end