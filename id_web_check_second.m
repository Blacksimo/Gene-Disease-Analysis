clear
addpath('dataset')
load('cleaned_data.mat');
% api_call = 'http://rest.genenames.org/fetch/symbol/';
api_call = 'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esummary.fcgi?db=gene&retmode=json&id=';

for i=1:size(geneId,1)
    fprintf('Analying Gene %i/%i ', i, size(geneId,1));
    data = webread(strcat(api_call, string(geneId(i, :))));
    results = struct2cell(data.result);
    results = results{2,1};
%     if data.response.numFound ~= 1
%         fprintf('Error found in checking the gene symbol: %s\n', geneSymbol(i,:));
%         fprintf('Number of gene found: %i\n', data.response.numFound);
%         fprintf('Index in geneSymbol array: %i\n', i);
%     else 
%         fprintf('Gene ID analyzed: %i\n', geneId(i,:));
%         fprintf('Gene ID found: %s\n', data.response.docs.hgnc_id);
%     end
    if ~contains(geneSymbol(i,:), results.name)
        fprintf('\n');
        fprintf('Gene Symbol analyzed: %s\n', geneSymbol(i,:));
        fprintf('Gene Symbol found: %s\n', results.name);
    else
        fprintf('Ok \n');
    end

    
end
% data = webread('http://rest.genenames.org/fetch/symbol/ACOX1');
% data_fake = webread('http://rest.genenames.org/fetch/symbol/pippo');