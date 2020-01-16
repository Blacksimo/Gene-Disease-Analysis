clear
addpath('dataset')
load('putative_disease_modules.mat')
load('data_table.mat')

api_call = 'http://rest.genenames.org/fetch/symbol/';
putative_disease_modules_table = table();
pvalue_passed = [pvalue_passed_I; pvalue_passed_U];
test_passed_clusters = [test_passed_clusters_I'; test_passed_clusters_U];
opt = weboptions('Timeout', 60);

for i=1:size(pvalue_passed,1)
    fprintf('Analyzing module %1u/%1u \n', i, size(pvalue_passed,1))
    n_seed_in_module = 0;
    seed_gene_in_module = {};
    seed_gene_id = {};
    non_seed_gene_in_module = {};
    non_seed_gene_id = {};
    for j=1:size(test_passed_clusters{i,1}.Nodes,1)
        fprintf('Analyzing gene %6u/%6u \n', j, size(test_passed_clusters{i,1}.Nodes,1))
        if any(ismember(complete_data.Gene_Symbol, test_passed_clusters{i,1}.Nodes.Name(j)))
            n_seed_in_module = n_seed_in_module + 1;
            seed_gene_in_module = [seed_gene_in_module; test_passed_clusters{i,1}.Nodes.Name(j)];
            data = webread(strcat(api_call, string(test_passed_clusters{i,1}.Nodes.Name(j))), opt);
            if ~isempty(data.response.docs)
                seed_gene_id = [seed_gene_id; data.response.docs.entrez_id];
            else
                seed_gene_id = [seed_gene_id; {'not found'}];
            end
        else
%             n_seed_in_module = n_seed_in_module + 1;
            non_seed_gene_in_module = [non_seed_gene_in_module; test_passed_clusters{i,1}.Nodes.Name(j)];
            data = webread(strcat(api_call, string(test_passed_clusters{i,1}.Nodes.Name(j))), opt);
            if ~isempty(data.response.docs)
                non_seed_gene_id = [non_seed_gene_id; data.response.docs.entrez_id];
            else
                non_seed_gene_id = [non_seed_gene_id; {'not found'}];
            end
        end
    end
    if i==1
        putative_disease_modules_table = table({'MCL'}, i, n_seed_in_module, size(test_passed_clusters{i,1}.Nodes.Name,1), {seed_gene_in_module}, {seed_gene_id}, {non_seed_gene_in_module}, {non_seed_gene_id}, pvalue_passed(i));
    else
        putative_disease_modules_table = [putative_disease_modules_table; table({'MCL'}, i, n_seed_in_module, size(test_passed_clusters{i,1}.Nodes.Name,1), {seed_gene_in_module}, {seed_gene_id}, {non_seed_gene_in_module}, {non_seed_gene_id}, pvalue_passed(i))];
    end
end

putative_disease_modules_table.Properties.VariableNames = {'Algorithm', 'Module_ID', 'n_Seed_Genes_in_Module', 'n_Genes_in_Module', 'Seed_Genes_Symbol_in_Module', 'Seed_Genes_ID_in_Module', 'Non_Seed_Genes_Symbol_in_Module', 'Non_Seed_Genes_ID_in_Module', 'Pvalue_of_Module'};

