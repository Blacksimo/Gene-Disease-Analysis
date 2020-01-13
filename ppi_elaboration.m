% clear
addpath('dataset')
load('data_table.mat');
ppi_data = readtable('PPIs-seed.txt');

concatenate = unique([ppi_data.symbol1; ppi_data.symbol2]);
new_concatenate = {};
counter = 1;
for i=1:size(concatenate,1)
    if ~ismember(complete_data{:,1}, concatenate{i,1})
        new_concatenate{counter,1} = concatenate{i,1};
        counter = counter +1;
    end
end