import json
import requests


ENRICHR_URL = 'http://amp.pharm.mssm.edu/Enrichr/addList'
genes_str = '\n'.join([
    'ACOX1', 'ADRA1A', 'ADRB3', 'AGT', 'FAS', 'STS', 'ATF3', 'ATP2A2', 
    'ATP2A3', 'BAX', 'BCL2', 'BCL2L1', 'BDKRB1', 'CASP3', 'CAT', 'CAV1', 
    'CAV3', 'CD68', 'CHRM2', 'CPT1A', 'CPT1B', 'CYBA', 'CYBB', 'CYP1A1', 
    'ACE', 'NQO1', 'EDN1', 'ESRRA', 'ACSL1', 'FOXO3', 'GCK', 'GPD2', 'GPX1', 
    'GSR', 'HK1', 'HMOX1', 'HSD11B1', 'IAPP', 'ICAM1', 'ID1', 'IFNG', 'IGF1', 
    'IL1B', 'IL6', 'INSR', 'PDX1', 'IRS1', 'KCNJ11', 'LEP', 'LEPR', 'MAP3K5', 
    'MFGE8', 'MMP2', 'MMP9', 'MPO', 'COX2', 'ND1', 'NEUROD1', 'NKX6-1', 'NOS2', 
    'NOS3', 'SERPINE1', 'PAX6', 'PCK1', 'PCSK2', 'PDK4', 'PFKM', 'PKLR', 'PPARA', 
    'PPARG', 'PRKCA', 'PRKCD', 'PRKCE', 'PTGS2', 'RELA', 'REN', 'S100A6', 'CCL20', 
    'CX3CL1', 'SLC2A2', 'SLC2A4', 'SLC9A1', 'SLC9A3', 'SNAP25', 'SOD1', 'SOD2', 
    'SREBF1', 'TGFB1', 'TIMP1', 'TIMP2', 'TNF', 'TNFRSF1A', 'TP53', 'UCP2', 'VEGFA', 
    'YWHAH', 'AOC3', 'IRS2', 'S1PR4', 'AIFM1', 'S1PR2', 'PPARGC1A', 'SIRT1', 'FGF21', 
    'S1PR5', 'GPAM', 'ACOT1', 'NCF1', 'S1PR5', 'GPAM', 'ACOT1', 'NCF1'
])
description = 'Example gene list'
payload = {
    'list': (None, genes_str),
    'description': (None, description)
}

response = requests.post(ENRICHR_URL, files=payload)
if not response.ok:
    raise Exception('Error analyzing gene list')

data = json.loads(response.text)
print(data)