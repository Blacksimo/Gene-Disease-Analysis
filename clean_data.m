clear
addpath('dataset')
tdfread('dataset\curated_gene_disease_associations.tsv')
desease_pathology_code = 'C0011853';
id_list = [];
% counter = 0;
for i=1:size(diseaseId, 1)
   if (contains(diseaseId(i,:), desease_pathology_code)) == 1
%       disp('found'); 
%       counter = counter + 1;
      id_list = [id_list; i];
   end
end
diseaseClass = diseaseClass(id_list, :);
diseaseName = diseaseName(id_list, :);
diseaseId = diseaseId(id_list, :);
diseaseSemanticType = diseaseSemanticType(id_list, :);
diseaseType = diseaseType(id_list, :);
DPI = DPI(id_list, :);
DSI = DSI(id_list, :);
EI = EI(id_list, :);
geneId = geneId(id_list, :);
geneSymbol = geneSymbol(id_list, :);
NofPmids = NofPmids(id_list, :);
NofSnps = NofSnps(id_list, :);
% pmid = pmid(id_list, :);
score = score(id_list, :);
source = source(id_list, :);
YearFinal = YearFinal(id_list, :);
YearInitial = YearInitial(id_list, :);
