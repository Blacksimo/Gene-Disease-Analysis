clear
addpath('dataset')
load('cleaned_cured_data.mat');
% symbol_max_length = 8;
api_key = '49a2e0ca3aa9d99df092f2d0cbf92b8d';
api_call = 'http://rest.genenames.org/fetch/symbol/';
api_call_description = 'http://www.ebi.ac.uk/proteins/api/proteins/';
% api_call = 'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esummary.fcgi?db=gene&retmode=json&id=';
error_name = [];
error_index = [];
error_id = [];
to_check = [];
uniprot_ids = {};
protein_name = {};
geneSymbol_new = {};
description = {};
fprintf('-------------------------------------------------------\n');
for i=1:size(geneSymbol,1)
    geneSymbol_new = [geneSymbol_new; {strip(geneSymbol(i, :))}];
    fprintf('Analying Gene %8s %3i/%3i \t', strip(geneSymbol(i,:)),  i, size(geneSymbol,1));
    data = webread(strcat(api_call, string(geneSymbol(i, :))));
%     results = struct2cell(data.result);
%     results = results{2,1};
    if data.response.numFound ~= 1
%         fprintf('Error found in checking the gene symbol: %s\n', geneSymbol(i,:));
%         fprintf('Number of gene found: %i\n', data.response.numFound);
%         fprintf('Index in geneSymbol array: %i\n', i);
        fprintf('Error \n');
        fprintf('-------------------------------------------------------\n');
        error_id = [error_id geneId(i,:)];        
        error_index = [error_index i];
        uniprot_ids = [uniprot_ids; {'null'}];
        protein_name = [protein_name; {'null'}];
        description = [description; {'null'}];
    else 
        if ~contains(data.response.docs.status, 'Approved') && str2num(data.response.docs.date_modified(1:4))<2010
            to_check = [to_check geneSymbol(i, :)];
        end
        fprintf('\n Status: \t %s \n Last Date: \t %s \n', data.response.docs.status, data.response.docs.date_modified(1:4));
        fprintf('-------------------------------------------------------\n');
        uniprot_ids = [uniprot_ids; data.response.docs.uniprot_ids{1}];
        protein_name = [protein_name; data.response.docs.name];
        data = webread(strcat(api_call_description, data.response.docs.uniprot_ids{1}));
        if isfield(data.comments{1,1}, 'text')
            description = [description; data.comments{1,1}.text.value];
        else 
            description = [description; {'null'}];
        end
%         fprintf('Ok \n');
%         fprintf('Gene ID analyzed: %i\n', geneId(i,:));
%         fprintf('Gene ID found: %s\n', data.response.docs.hgnc_id);
    end
%     if ~contains(geneSymbol(i,:), results.name)
%         fprintf('\n');
%         fprintf('Gene Symbol analyzed: %s\n', geneSymbol(i,:));
%         fprintf('Gene Symbol found: %s\n', results.name);
%     else
%         fprintf('Ok \n');
%     end

    
end
error_name = geneSymbol(error_index, :);
if size(to_check, 1) == 0
    fprintf('Every Gene is Approved and More recent than 2010\n');
    names = {'Gene_Symbol', 'Gene_ID', 'Uniprot_ID', 'Protein_Name', 'Description'};
    complete_data = table(geneSymbol_new, geneId, uniprot_ids, protein_name, ...
        description,'VariableNames', names);
else
    fprintf('Some gene needs to be checked (not approved or not up-to-date)\n');
end
% data = webread('http://rest.genenames.org/fetch/symbol/ACOX1');
% data_fake = webread('http://rest.genenames.org/fetch/symbol/pippo');
a = webread('http://www.ebi.ac.uk/proteins/api/proteins/Q15067');

writetable(complete_data, 'data_table.xls'); 


