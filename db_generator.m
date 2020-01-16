clear
addpath('dataset')
load('data_table.mat')
% Interactions for human 'gene' and interactions between all interactors of 'gene':
% TaxID corresponds to homo sapiens
api_interaction = 'https://webservice.thebiogrid.org/interactions/?searchNames=true&taxId=9606&includeInteractors=true&includeInteractorInteractions=true&accesskey=49a2e0ca3aa9d99df092f2d0cbf92b8d&format=json&geneList=';
fprintf('-------------------------------------------------------\n');
genes_found_in_db = [];
interactions_per_gene = [];
gene_list = {};
symbol_a_list = {};
symbol_b_list = {};
options = weboptions("Timeout", 60);

for i=1:size(complete_data, 1)
    symbol = complete_data.Gene_Symbol(i,:);
    fprintf('Analyzing Gene: %s \t %u/%u \n', string(symbol), i, size(complete_data,1));
    data = webread(strcat(api_interaction, string(symbol)), options);
    if ~isempty(data)
        
        data = struct2cell(data);
        fprintf('Found %u Interactions with the Gene \n', size(data,1));
        genes_found_in_db = [genes_found_in_db; symbol];
        interactions_per_gene = [interactions_per_gene; size(data,1)];
        
        for j=1:size(data,1)
            symbol_a_list = [symbol_a_list;  upper(data{j,1}.OFFICIAL_SYMBOL_A)];
            symbol_b_list = [symbol_b_list;  upper(data{j,1}.OFFICIAL_SYMBOL_B)];   
        end
        fprintf('-------------------------------------------------------\n');
    else
        fprintf('Found no data \n');
        fprintf('-------------------------------------------------------\n');
    end
    graph_data = graph(symbol_a_list, symbol_b_list);
    complete_gene_list = table2cell(graph_data.Nodes);
end

gene_interactions = table(genes_found_in_db, interactions_per_gene);

plot(graph_data, 'Layout', 'force');

opts = detectImportOptions('dataset\BIOGRID-ORGANISM-3.5.180.tab2\BIOGRID-ORGANISM-Homo_sapiens-3.5.180.tab2.txt');

https://webservice.thebiogrid.org/interactions/?searchNames=true&taxId=9606&accesskey=49a2e0ca3aa9d99df092f2d0cbf92b8d&format=json&geneList=A2M|AAR2|AARS|AASDHPPT|AATF|ABAT|ABCA1|ABCA2|ABCB6|ABCB7|ABCB8|ABCC1|ABCC8|ABCE1|ABCF2|ABHD11|ABL1|ABL2|ABLIM1|ACAA1|ACACA|ACAD10|ACAD11|ACAD9|ACADVL|ACAT1|ACBD7|ACE|ACE2|ACIN1|ACO2|ACOT1|ACOT2|ACOT7|ACOT8|ACOX1|ACOX3|ACP1|ACP2|ACSL1|ACTA1|ACTA2|ACTB|ACTBL2|ACTC1|ACTG1|ACTL6A|ACTN1|ACTN2|ACTN4|ACTR1B|ACTR2|ACTR3|ACVRL1|ACY1|ADAM17|ADAM33|ADAM9|ADAMTS1|ADAMTSL1|ADAP1|ADCY5|ADCY6|ADD1|ADD3|ADH5|ADK|ADRA1A|ADRA1B|ADRB2|ADRB3|ADRBK1|ADRM1|ADSL|ADSS|AES|AFAP1|AFF1|AFG3L2|AGBL2|AGL|AGO1|AGO2|AGPS|AGR2|AGR3|AGT|AGTR1|AHCY|AHCYL1|AHNAK|AHR|AHSA1|AHSG|AIFM1|AIMP2|AIP|AIPL1|AK2|AKAP1|AKAP12|AKAP13|AKAP5|AKAP8L|AKIP1|AKIRIN2|AKR1A1|AKR1B1|AKR1B10|AKR1B15|AKR1C2|AKR1D1|AKT1|AKT3|ALB|ALDH16A1|ALDH18A1|ALDH1A1|ALDH1B1|ALDH1L2|ALDH2|ALDH3A1|ALDH3B1|ALDH4A1|ALDH5A1|ALDH7A1|ALDOA|ALDOC|ALG9|ALK|ALOX12|ALOX15B|ALOX5|ALYREF|AMBRA1|AMFR|AMY1C|AMZ1|ANAPC4|ANG|ANGPTL4|ANKRD13A|ANKRD13C|ANKRD2|ANP32A|ANP32B|ANXA1|ANXA11|ANXA2|ANXA2P2|ANXA3|ANXA6|AOC2|AOC3|AP1G1|AP1M1|AP1S2|AP2B1|AP2M1|AP2S1|AP3D1|AP3S1|AP4S1|AP5M1|APAF1|APBA2|APCDD1|APEH|APEX1|APEX2|API5|APLNR|APOA5|APOB|APOBEC3G|APOE|APOH|APOL2|APOOL|APP|APPBP2|APPL1|APPL2|APRT|APTX|AQP3|AR|ARAF|AREG|ARF3|ARF4|ARF5|ARFGAP1|ARFGEF2|ARFIP1|ARFIP2|ARHGAP29|ARHGDIA|ARHGEF17|ARHGEF2|ARHGEF6|ARHGEF7|ARID1A|ARID3A|ARID4B|ARIH1|ARIH2|ARL3|ARL6IP5|ARL6IP6|ARMC8|ARNT|ARNTL|ARPC2|ARPC5|ARRB1|ARRB2|ARRDC3|ART3|ARVCF|ASB1|ASB12|ASB14|ASB17|ASB5|ASCC1|ASF1A|ASH2L|ASIC4|ASL|ASNS|ASPDH|ASPH|ASPM|ASPSCR1|ASS1|ATAD3A|ATAD3B|ATAD5|ATF2|ATF3|ATF4|ATF6|ATG101|ATG12|ATG16L1|ATG4D|ATG5|ATG7|ATIC|ATM|ATMIN|ATOH1|ATOX1|ATP11C|ATP1A1|ATP1A3|ATP1B1|ATP2A1|ATP2A2|ATP2A3|ATP2B2|ATP2B3|ATP4A|ATP5A1|ATP5B|ATP5C1|ATP5E|ATP5F1|ATP5H|ATP5J|ATP5L|ATP5O|ATP6AP2|ATP6V0A4|ATP6V0B|ATP6V0D1|ATP6V1A|ATP6V1B1|ATP6V1C1|ATP6V1E1|ATPAF1|ATPIF1|ATR|ATRX|ATXN1|ATXN1L|ATXN3|ATXN7L3|AURKA|AURKAIP1|AURKB|AVEN|AVPR1A|AVPR1B|AXIN1|AZI2|B4GALT1|B4GALT5|B4GALT7|BACE1|BACH1|BAD|BAG1|BAG2|BAG3|BAG4|BAG5|BAG6|BAIAP2L1|BAK1|BANF1|BANP|BAP1|BARD1|BASP1|BATF|BATF2|BATF3|BAX|BBC3|BCAN|BCAP31|BCAR3|BCAS2|BCAS3|BCAT2|BCCIP|BCKDK|BCL10|BCL11A|BCL2|BCL2A1|BCL2L1|BCL2L10|BCL2L11|BCL2L12|BCL2L13|BCL2L14|BCL2L15|BCL2L2|BCL6|BCR|BCS1L|BDH1|BDKRB2|BDP1|BECN1|BET1|BFAR|BGN|BHLHE40|BHLHE41|BICD1|BICD2|BID|BIK|BIRC2|BIRC3|BIRC5|BIRC6|BIRC7|BLID|BLK|BLM|BLNK|BLVRA|BMF|BMI1|BMPR1A|BMPR2|BMX|BNIP1|BNIP2|BNIP3|BNIP3L|BNIPL|BOC|BPLF1|BRAF|BRCA1|BRCA2|BRCC3|BRD1|BRD2|BRD4|BRD7|BRD8|BRE|BRF1|BRF2|BRINP1|BRIP1|BRMS1|BSG|BTBD2|BTG2|BTK|BTN2A1|BTNL3|BTNL8|BTRC|BUB1|BUD13|BUD31|BZW2|C10ORF2|C10ORF90|C11ORF49|C11ORF54|C12ORF73|C12ORF74|C14ORF1|C14ORF166|C15ORF48|C17ORF75|C18ORF21|C19ORF52|C1ORF112|C1ORF86|C1QB|C1QBP|C1R|C20ORF24|C21ORF2|C2CD5|C2ORF57|C3ORF17|C4ORF27|C4ORF48|C5AR2|C6ORF211|C7ORF60|C8G|CA2|CAB39|CABLES1|CABLES2|CACNA1C|CACNB3|CACYBP|CAD|CALM1|CALM2|CALM3|CALMODULIN|CALU|CAMK2A|CAMK2G|CAND1|CANX|CAP1|CAPN1|CAPN2|CAPNS1|CAPZA1|CAPZA2|CAPZB|CARD11|CARM1|CASK|CASP1|CASP10|CASP2|CASP3|CASP6|CASP7|CASP8|CASP8AP2|CASP9|CASR|CAT|CAV1|CAV2|CAV3|CBFA2T3|CBFB|CBL|CBLB|CBLC|CBWD1|CBX4|CBY1|CC2D2A|CCAR1|CCAR2|CCDC106|CCDC107|CCDC113|CCDC155|CCDC24|CCDC33|CCDC53|CCDC58|CCDC8|CCDC88A|CCDC9|CCL18|CCL20|CCL5|CCL7|CCNA2|CCNB1|CCND1|CCND2|CCND3|CCNG1|CCNH|CCNL2|CCR6|CCS|CCS1|CCT2|CCT3|CCT4|CCT5|CCT6A|CCT7|CCT8|CD276|CD2AP|CD2BP2|CD36|CD44|CD53|CD63|CD68|CD9|CD97|CDC10|CDC14A|CDC14B|CDC20|CDC20B|CDC25A|CDC25B|CDC25C|CDC27|CDC34|CDC37|CDC42|CDC42SE2|CDC5L|CDC6|CDC73|CDCA3|CDCA7|CDCA8|CDCP1|CDH1|CDH5|CDH7|CDIPT|CDK1|CDK12|CDK15|CDK16|CDK2|CDK3|CDK4|CDK5|CDK6|CDK7|CDK8|CDK9|CDKL1|CDKN1A|CDKN1C|CDKN2A|CDKN2B|CDKN2C|CDT1|CDX2|CDYL|CEBPA|CEBPB|CEBPD|CEBPE|CEBPG|CEBPZ|CED-4|CED-9|CELF2|CELSR2|CENPA|CENPE|CENPJ|CENPT|CENPV|CEP128|CEP135|CEP152|CEP162|CEP164|CEP170|CEP19|CEP290|CEP350|CEP44|CEP55|CEP78|CEP89|CEP95|CERKL|CETP|CFL1|CFL2|CFLAR|CFTR|CGN|CGRRF1|CHCHD2|CHCHD3|CHCHD4|CHCHD7|CHD1L|CHD3|CHD8|CHD9|CHEK1|CHEK2|CHFR|CHMP4B|CHP1|CHP2|CHRM2|CHRM3|CHRNA4|CHRNA9|CHUK|CIB1|CIDEA|CIITA|CISD2|CKAP4|CKAP5|CKB|CKM|CLDN17|CLEC3A|CLEC4G|CLIC1|CLIC4|CLIP3|CLK3|CLN3|CLN5|CLNS1A|CLOCK|CLPB|CLPP|CLPX|CLTA|CLTC|CLU|CMA1|CMC4|CMTM5|CMYA5|CNDP2|CNGA3|CNNM3|CNTRL|COA3|COA6|COA7|COG6|COL12A1|COL14A1|COL18A1|COL1A1|COL2A1|COL4A1|COL4A2|COL4A6|COL5A1|COL6A1|COL6A2|COLEC10|COLEC12|COMMD1|COMMD10|COMMD2|COMMD4|COMMD5|COMMD6|COMMD7|COMMD8|COPA|COPB1|COPB2|COPG1|COPRS|COPS2|COPS3|COPS4|COPS5|COPS6|COPS7A|COQ9|CORO1C|COX1|COX14|COX15|COX16|COX17|COX19|COX2|COX20|COX4I1|COX5A|COX5B|COX6B1|COX6C|CPD|CPLX1|CPNE7|CPOX|CPPED1|CPS1|CPSF1|CPSF7|CPT1A|CPT1B|CRADD|CREB1|CREB3|CREB3L3|CREBBP|CRIP1|CRK|CRMP1|CRNKL1|CRNN|CROT|CRTC2|CRY1|CRYAA|CRYAB|CRYZ|CSF1R|CSF3R|CSK|CSN3|CSNK1A1|CSNK1A1L|CSNK1D|CSNK1E|CSNK1G1|CSNK1G3|CSNK2A1|CSNK2A2|CSNK2B|CST2|CST4|CST6|CST7|CSTF1|CSTF2|CSTF3|CTBP1|CTCF|CTDNEP1|CTDP1|CTGF|CTH|CTNNB1|CTNNBL1|CTNND1|CTSB|CTSD|CTTN|CTU2|CUL1|CUL2|CUL3|CUL4A|CUL4B|CUL5|CUL7|CUL9|CUTA|CWC15|CX3CL1|CX3CR1|CXADR|CXCL5|CXCL6|CXCL8|CXCR4|CXXC1|CYB5R3|CYBA|CYBB|CYC1|CYCS|CYFIP1|CYFIP2|CYLD|CYP11B2|CYP1A1|CYP2S1|CYP3A4|CYP4B1|CYP4F12|DAB2|DAB2IP|DACH1|DAD1|DAF-12|DAG1|DAP3|DAPK1|DAPK3|DARS|DARS2|DAXX|DAZAP1|DBI|DBN1|DBNL|DBP|DCAF11|DCAF15|DCAF7|DCC|DCD|DCLRE1A|DCLRE1C|DCN|DCP1A|DCP2|DCPS|DCTN1|DCTN2|DDB1|DDC|DDIT3|DDOST|DDX1|DDX17|DDX18|DDX19B|DDX20|DDX21|DDX39A|DDX39B|DDX3X|DDX5|DDX52|DDX58|DECR1|DECR2|DEFA1|DERL1|DES|DFFA|DGKZ|DGUOK|DHDDS|DHFR|DHPS|DHRS4|DHRS7|DHTKD1|DHX16|DHX36|DHX40|DHX9|DIABLO|DIAP1|DIAPH3|DICER1|DIRAS3|DIS3|DIS3L2|DISC1|DLC1|DLD|DLEU1|DLG4|DLST|DMD|DMWD|DNAAF2|DNAJA1|DNAJA2|DNAJA3|DNAJB1|DNAJB6|DNAJC11|DNAJC12|DNAJC5|DNAJC7|DNASE1L2|DNM1L|DNMT1|DNMT3B|DNMT3L|DNTTIP2|DOCK7|DOK1|DOK5|DOLK|DOT1L|DPF1|DPF2|DPF3|DPH1|DRD3|DROSHA|DSK2|DSP|DSTN|DTD1|DTL|DUPD1|DUSP11|DUSP14|DUSP18|DUSP19|DUSP3|DUT|DVL1|DVL2|DYNC1H1|DYNLL1|DYNLT1|DYRK1A|DYSF|E2F1|E4F1|E6|EAF2|EBNA1BP2|ECD|ECE1|ECH1|ECI1|ECI2|ECSIT|ECT2|EDA|EDA2R|EDF1|EDN1|EDNRA|EDNRB|EDRF1|EEA1|EED|EEF1A1|EEF1A2|EEF1B2|EEF1D|EEF1G|EEF2|EFEMP1|EFEMP2|EFTUD2|EGF|EGFR|EGLN2|EGLN3|EGR1|EHD1|EHD2|EHHADH|EHMT1|EHMT2|EIF1AX|EIF2A|EIF2AK2|EIF2B5|EIF2S1|EIF2S2|EIF3A|EIF3B|EIF3C|EIF3CL|EIF3D|EIF3E|EIF3F|EIF3G|EIF3H|EIF3I|EIF3J|EIF3K|EIF3L|EIF3M|EIF4A3|EIF4E2|EIF4EBP1|EIF4G2|EIF4H|EIF5|EIF5A|EIF5B|EIF6|ELAC2|ELAVL1|ELAVL3|ELF3|ELL|ELL3|ELMO1|ELMSAN1|EMD|EMG1|EML3|EN1|ENDOD1|ENDOG|ENG|ENO1|ENO2|ENO3|ENPP1|ENTPD4|ENV|EP300|EP400|EPAS1|EPB41L2|EPB41L3|EPDR1|EPHA2|EPHA3|EPHB2|EPHX2|EPN1|EPOR|EPPK1|EPRS|EPS15|ERAL1|ERBB2|ERBB2IP|ERBB3|ERBB4|ERCC2|ERCC3|ERCC6|ERCC8|ERF|ERH|ERLIN1|ERLIN2|ERMP1|ERN1|ERP44|ESR1|ESR2|ESRRA|ESRRB|ESRRG|ESYT2|ETF1|ETFA|ETFB|ETHE1|ETS1|ETS2|ETV1|EVA1C|EVC2|EWSR1|EXO1|EXOC6|EXOSC1|EXOSC2|EXOSC4|EXOSC6|EXOSC7|EXOSC8|EXTL2|EZH2|EZR|F1L|F2|F2R|FABP1|FABP3|FABP5|FABP7|FADD|FAF1|FAF2|FAHD1|FAHD2A|FAIM2|FAM118B|FAM127A|FAM134A|FAM136A|FAM173A|FAM175B|FAM189A2|FAM192A|FAM19A3|FAM19A4|FAM60A|FAM63B|FAM69A|FAM83G|FAM91A1|FAM98A|FAM9B|FANCD2|FAP|FAR1|FAS|FASLG|FASN|FAT1|FAU|FBF1|FBL|FBP1|FBXL13|FBXO11|FBXO21|FBXO22|FBXO25|FBXO4|FBXO42|FBXO45|FBXO6|FBXO7|FBXW11|FBXW4|FBXW7|FBXW8|FCGR2B|FCGR3A|FCN1|FDXR|FECH|FEM1B|FEN1|FERMT2|FGD4|FGF10|FGF11|FGF21|FGFR1|FGFR1OP|FGFR1OP2|FGFR2|FGFR3|FGFR4|FGG|FH|FHIT|FHL2|FHL3|FHOD1|FIS1|FKBP10|FKBP11|FKBP14|FKBP1A|FKBP1B|FKBP3|FKBP4|FKBP7|FKBP8|FKBP9|FLG|FLI1|FLII|FLNA|FLOT1|FLOT2|FLT1|FLT3|FLT4|FLYWCH2|FMOD|FN1|FN3K|FNDC4|FNDC5|FNTA|FOLR1|FOPNL|FOS|FOSL1|FOXA3|FOXF1|FOXG1|FOXK1|FOXK2|FOXL2|FOXM1|FOXO1|FOXO3|FOXO3B|FOXO4|FOXO6|FOXP1|FOXP3|FOXS1|FREM2|FRMD1|FRMD5|FRMD6|FRS2|FRYL|FSCN1|FTH1|FTSJ3|FUBP1|FUBP3|FUS|FUT1|FUT8|FXR1|FXR2|FXYD6|FYCO1|FYN|FZR1|G3BP1|G3BP2|G6PD|GAA|GABARAPL1|GABRA1|GABRA6|GABRB3|GABRG2|GAD1|GAD2|GADD45A|GADD45B|GADD45G|GAG-POL|GAL11|GALNT6|GALNT7|GAN|GANAB|GAP43|GAPDH|GART|GATA1|GATA4|GBAS|GBF1|GBP2|GCDH|GCK|GCKR|GCLM|GCN1L1|GDI1|GDPD5|GEMIN2|GEMIN5|GFER|GFI1|GFPT1|GIGYF2|GIMAP5|GINS2|GIT1|GIT2|GJA1|GJB1|GJB2|GK|GKAP1|GLB1L2|GLG1|GLI1|GLI3|GLIPR2|GLIS1|GLIS2|GLO1|GLOD4|GLP1R|GLRX|GLS|GLTSCR2|GLUD1|GMIP|GMNN|GMPS|GNA12|GNA13|GNAI1|GNAI3|GNAQ|GNAS|GNB1|GNB2|GNB2L1|GNB4|GNG12|GNL3|GNL3L|GNPAT|GNPDA2|GOLGA2|GOLGA5|GOLT1B|GOPC|GORASP1|GOSR1|GOT1|GP1BB|GP6|GPAM|GPC1|GPC4|GPC6|GPD1L|GPD2|GPHN|GPN3|GPR21|GPR50|GPRASP1|GPRC5B|GPRC5C|GPS1|GPS2|GPT2|GPX1|GPX4|GRB10|GRB14|GRB2|GRB7|GREB1|GRHPR|GRIN1|GRIN2B|GRIP1|GRIPAP1|GRK1|GRK5|GRK6|GRM5|GRM7|GRN|GRPEL1|GRSF1|GRWD1|GSDMB|GSH1|GSK3A|GSK3B|GSN|GSR|GSS|GSTA1|GSTK1|GSTM1|GSTM4|GSTP1|GSTZ1|GTF2A1|GTF2B|GTF2H1|GTF2H4|GTF2I|GTF3C3|GTF3C4|GTPBP4|GTSE1|GUCY1A3|GUCY1B3|GUF1|GYPB|GYS2|GZMB|H1F0|H1FX|H2AFX|H2AFY|H2BFS|H3F3A|H3F3B|HABP4|HACL1|HADHB|HAGH|HAL|HAND1|HAND2|HAP1|HAUS1|HAX1|HCCS|HCFC1|HCLS1|HCVGP1|HDAC1|HDAC10|HDAC11|HDAC2|HDAC3|HDAC4|HDAC5|HDAC6|HDAC7|HDAC8|HDAC9|HDLBP|HEATR1|HEATR6|HEBP1|HECTD1|HECW1|HECW2|HELZ2|HERC1|HERC2|HERC3|HERC5|HES1|HEXA|HEXB|HEXIM1|HEY2|HGF|HGS|HHV8GK18_GP81|HIBADH|HIBCH|HIC1|HIF1A|HIF1AN|HIGD2A|HINT1|HIPK1|HIPK2|HIPK3|HIST1H1A|HIST1H1B|HIST1H1C|HIST1H1D|HIST1H1E|HIST1H1T|HIST1H2AB|HIST1H2AE|HIST1H2AH|HIST1H2BA|HIST1H2BB|HIST1H2BC|HIST1H2BD|HIST1H2BE|HIST1H2BH|HIST1H2BJ|HIST1H2BK|HIST1H2BL|HIST1H2BM|HIST1H2BN|HIST1H2BO|HIST1H3A|HIST1H3E|HIST2H2AB|HIST2H2AC|HIST2H2BF|HIST2H3C|HIST3H3|HIV2GP3|HIV2GP4|HIVEP1|HK1|HK2|HK3|HKDC1|HLA-A|HLA-B|HLA-C|HMGA1|HMGA2|HMGB1|HMGB3|HMGCL|HMGN1|HMGN2|HMOX1|HMX1|HNF1A|HNF1B|HNF4A|HNRNPA0|HNRNPA1|HNRNPA1L2|HNRNPA2B1|HNRNPA3|HNRNPAB|HNRNPC|HNRNPD|HNRNPF|HNRNPH1|HNRNPK|HNRNPL|HNRNPM|HNRNPU|HOMER3|HOOK1|HOOK3|HOXA1|HOXA9|HOXB1|HOXB5|HOXB9|HOXC6|HPCAL1|HPCAL4|HR|HRAS|HRG|HRH1|HRK|HRNR|HRSP12|HS6ST2|HSC82|HSD11B1|HSD17B10|HSD17B4|HSD3B7|HSDL2|HSF1|HSP82|HSP90AA1|HSP90AB1|HSP90AB2P|HSP90B1|HSP90B3P|HSPA12A|HSPA13|HSPA1A|HSPA1B|HSPA1L|HSPA2|HSPA4|HSPA4L|HSPA5|HSPA6|HSPA8|HSPA9|HSPB1|HSPB2|HSPD1|HSPE1|HSPH1|HTR2C|HTR3E|HTRA1|HTRA2|HTT|HUWE1|HYOU1|HYPK|IAPP|IARS2|IBTK|ICAM1|ICE2|ICOS|ICT1|ID1|ID2|ID3|IDE|IDH1|IDH3A|IDH3B|IFI16|IFNG|IFNGR1|IFNGR2|IGF1|IGF1R|IGF2BP1|IGF2BP3|IGFALS|IGFBP1|IGFBP2|IGFBP3|IGFBP4|IGFBP5|IGFBP7|IGHA2|IGSF1|IGSF21|IKBKB|IKBKE|IKBKG|IKZF3|IL17RB|IL17RC|IL1A|IL1B|IL1R1|IL1RN|IL2RA|IL32|IL4R|IL6|IL6R|IL6ST|ILF2|ILF3|ILK|IMMT|IMPDH1|IMPDH2|ING1|ING2|ING4|ING5|INPP1|INPP5D|INPPL1|INSIG1|INSIG2|INSL5|INSR|INSRR|INTS2|INTS5|IPO13|IPPK|IQCB1|IQCF1|IQGAP1|IQGAP2|IRAK1|IRF2|IRF7|IRF8|IRF9|IRS1|IRS2|IRS4|ISG15|ISL1|ISOC1|ITCH|ITGA1|ITGA4|ITGA5|ITGAL|ITGAM|ITGAV|ITGB1|ITGB2|ITGB3|ITGB3BP|ITGB5|ITGB7|ITIH2|ITLN1|ITM2B|ITPR1|ITPR3|ITSN1|ITSN2|JAG2|JAK1|JAK2|JAK3|JAZF1|JMJD1C|JPH1|JPH2|JSRP1|JUN|JUNB|JUND|JUP|KANK1|KANK2|KARS|KAT2A|KAT2B|KAT5|KAT6A|KAT7|KAT8|KBTBD7|KCMF1|KCNA10|KCNA3|KCNA4|KCNA5|KCNAB2|KCNB1|KCNH2|KCNJ11|KCNJ2|KCNJ8|KCNK1|KCNMA1|KCNN3|KCNS3|KCTD13|KCTD15|KCTD17|KCTD5|KDM1A|KDM2A|KDM4C|KDM4D|KDM6A|KDR|KEAP1|KHDRBS1|KHDRBS2|KHNYN|KHSRP|KIAA0087|KIAA0930|KIAA1191|KIAA1244|KIAA1429|KIAA1598|KIAA1841|KIDINS220|KIF11|KIF14|KIF1A|KIF1B|KIF23|KIF2A|KIF2C|KIF4A|KIF5A|KIF5B|KIT|KLC2|KLC3|KLF13|KLF4|KLF5|KLF9|KLHL15|KLHL41|KLK5|KLK7|KLK8|KLK9|KMT2A|KMT2E|KPNA1|KPNA2|KPNA3|KPNA4|KPNA6|KPNB1|KRAS|KRIT1|KRT1|KRT10|KRT18|KRT19|KRT2|KRT31|KRT5|KRT7|KRT79|KRT8|KRT81|KRT86|KRT9|KRTAP10-3|KRTAP10-7|KSR1|KTN1|KYNU|L3MBTL1|LACRT|LACTB|LACTB2|LAMA3|LAMA4|LAMB1|LAMC1|LAMP1|LAMP2|LAMTOR5|LANCL1|LAPTM5|LARP1|LARP7|LARS|LARS2|LATS1|LATS2|LCA5|LCK|LCMT1|LCN2|LCP1|LDHA|LDHAL6A|LDHAL6B|LDHB|LDHC|LEP|LEPR|LETM1|LGALS1|LGALS3|LGALS3BP|LGALS7|LGMN|LGR4|LHX2|LIG3|LIG4|LIMA1|LIMCH1|LINC01194|LINC01587|LITAF|LMAN1|LMAN2L|LMBR1|LMNA|LMNB1|LMNB2|LMO2|LMO4|LNPEP|LNX1|LNX2|LOC101930400|LOC613037|LONP2|LPAR1|LPAR4|LPAR6|LPCAT1|LPIN1|LPP|LRIF1|LRP1|LRP6|LRPAP1|LRPPRC|LRRC27|LRRC32|LRRC47|LRRC49|LRRC59|LRRC8A|LRRC8B|LRRCC1|LRRFIP2|LRRK2|LRRTM1|LSM12|LSM14B|LSM3|LSM7|LTA|LTA4H|LTB|LTB4R|LTBP1|LTC4S|LYN|LYPD3|LYPD6|LYSMD2|LYST|LYVE1|LYZ|LYZL1|M6PR|MACF1|MACROD1|MAD2L1|MAD2L1BP|MAD2L2|MADD|MAFA|MAFB|MAFF|MAFG|MAFK|MAGEA11|MAGEA2|MAGEB18|MAGED1|MAGED2|MAGEH1|MAGI1|MAGT1|MALL|MALT1|MAML1|MANBAL|MANEA|MAP1B|MAP1LC3A|MAP1LC3B|MAP1S|MAP2K1|MAP2K2|MAP2K3|MAP2K4|MAP2K5|MAP2K6|MAP2K7|MAP3K1|MAP3K10|MAP3K14|MAP3K5|MAP3K6|MAP3K7|MAP3K8|MAP4K1|MAP4K4|MAP7D3|MAPK1|MAPK10|MAPK12|MAPK14|MAPK3|MAPK6|MAPK7|MAPK8|MAPK8IP2|MAPK8IP3|MAPK9|MAPKAP1|MAPKAPK2|MAPKAPK5|MAPT|MARCH1|MARCH5|MARCH9|MARCKS|MARCKSL1|MARK1|MARK2|MARK3|MARK4|MASP2|MAST1|MAT2A|MAVS|MAX|MBD4|MBNL2|MBOAT1|MBOAT7|MBP|MCF2L2|MCFD2|MCL1|MCM10|MCM2|MCM3|MCM4|MCM5|MCM6|MCM7|MCOLN3|MCRS1|MCTS1|MDC1|MDFI|MDH1|MDH2|MDM2|MDM4|MDN1|MECOM|MECP2|MECR|MED1|MED12|MED13|MED14|MED15|MED16|MED17|MED20|MED21|MED22|MED23|MED24|MED25|MED26|MED6|MED7|MED8|MEF2A|MEF2C|MELK|MEN1|MEOX2|MEPCE|MET|METTL13|METTL14|METTL23|MEX3B|MEX3C|MEX3D|MFGE8|MFHAS1|MFN1|MFSD5|MGAM|MGMT|MGST3|MIB2|MICU1|MICU2|MID1|MIDN|MIF|MIF4GD|MIG1|MINPP1|MIS12|MIS18A|MIS18BP1|MITF|MKNK1|MKRN1|MKRN2|MKS1|MLC1|MLF2|MLH1|MLLT1|MLLT3|MLLT4|MME|MMGT1|MMP1|MMP10|MMP14|MMP2|MMP3|MMP9|MNAT1|MOAP1|MOB1A|MOB1B|MOB4|MOCS3|MOGS|MOK|MOV10|MPHOSPH6|MPHOSPH8|MPI|MPO|MPP1|MPRIP|MPZL2|MRAS|MRE11A|MRM1|MRPL1|MRPL12|MRPL18|MRPL38|MRPL39|MRPS14|MRPS18B|MRPS22|MRPS23|MRPS24|MRPS26|MRPS27|MRPS28|MRPS31|MSH2|MSH6|MSI2|MSL2|MSN|MST1R|MSX2|MTA1|MTA2|MTA3|MTCH2|MTDH|MTFR2|MTHFD1|MTHFD1L|MTHFSD|MTIF2|MTMR11|MTMR4|MTNR1A|MTNR1B|MTOR|MTPN|MTX2|MTX3|MUC1|MUC3A|MUC7|MUT|MVD|MVP|MX1|MYBBP1A|MYBPC1|MYBPC3|MYC|MYCBP2|MYCN|MYEF2|MYF5|MYH10|MYH11|MYH14|MYH3|MYH9|MYL12A|MYL6|MYL6B|MYL9|MYLK|MYLK2|MYO1B|MYO1C|MYO1D|MYO1E|MYO5A|MYO5B|MYO6|MYOC|MYOD1|MYOT|MZT2B|NAA15|NAA50|NABP2|NACA|NACC1|NAGK|NAMPT|NANOG|NAP1L1|NAP1L4|NAPA|NARS2|NAT1|NAT10|NBN|NCCRP1|NCF1|NCF2|NCF4|NCK2|NCL|NCLN|NCOA1|NCOA2|NCOA3|NCOA4|NCOA6|NCOR1|NCOR2|NCR3LG1|NCS1|NCSTN|ND1|ND5|NDN|NDRG1|NDUFA11|NDUFA12|NDUFA13|NDUFA2|NDUFA3|NDUFA4|NDUFA4L2|NDUFA5|NDUFA8|NDUFA9|NDUFAF1|NDUFAF4|NDUFB10|NDUFB11|NDUFB2|NDUFS1|NDUFS2|NDUFS3|NDUFS4|NDUFS5|NDUFS6|NDUFS7|NDUFS8|NDUFV1|NDUFV2|NEDD1|NEDD4|NEDD4L|NEK1|NEK2|NEK7|NELFCD|NEO1|NETO2|NEU3|NEUROD1|NEUROG2|NF1|NF2|NFATC1|NFATC2|NFE2L2|NFE2L3|NFIC|NFKB1|NFKB2|NFKBIA|NFKBIB|NFKBIE|NFKBIL1|NFRKB|NFS1|NFYA|NFYB|NGEF|NGFR|NHLRC3|NHS|NIN|NINL|NISCH|NKD2|NKIRAS2|NKRF|NKX2-1|NKX2-5|NKX6-1|NLGN3|NLK|NME1|NME1-NME2|NME2|NME2P1|NME4|NMI|NMNAT1|NMT1|NMT2|NOC2L|NOC4L|NOL12|NOL3|NOP10|NOP14|NOP2|NOP58|NOS1AP|NOS2|NOS3|NOSIP|NOSTRIN|NOTCH1|NOTCH2|NOTCH4|NOV|NOX1|NOXA1|NPDC1|NPHP1|NPM1|NPRL3|NPTX1|NPY2R|NPY4R|NQO1|NR0B1|NR0B2|NR1H2|NR1H3|NR1H4|NR1I2|NR1I3|NR2C2|NR2E3|NR2F2|NR3C1|NR3C2|NR4A1|NR4A2|NR5A2|NRAS|NRBF2|NRF1|NRG1|NRIP1|NRP1|NRP2|NRROS|NSD1|NSDHL|NSF|NSFL1C|NSMAF|NSUN2|NSUN4|NT5C1A|NT5DC1|NT5E|NT5M|NTPCR|NTRK1|NUAK1|NUB1|NUCB1|NUDC|NUDCD2|NUDT12|NUDT13|NUDT19|NUDT21|NUFIP1|NUFIP2|NUMB|NUP107|NUP214|NUP35|NUP62|NUP88|NUP93|NUP98|NUTF2|NXF1|OARD1|OAT|OCIAD1|OCLN|OFD1|OGG1|OGT|OIP5|OMA1|OPA1|OPTN|ORC3|ORC4|ORM1|OSBPL10|OSBPL5|OSBPL9|OTUB1|OTUD1|OTUD5|OTUD7B|OTULIN|OXCT1|OXSR1|OXT|OYE2|P2RY12|P2RY6|P2RY8|P3H1|P3H4|P4HB|PABPC1|PABPC3|PABPC4|PADI4|PAFAH1B1|PAFAH1B3|PAG1|PAICS|PAK1|PAK2|PAK4|PALLD|PALM3|PAN2|PAPOLA|PAQR3|PARD3|PARD6A|PARD6B|PARD6G|PARG|PARK2|PARK7|PARP1|PARP4|PARP6|PASK|PATZ1|PAWR|PAX6|PAXIP1|PBK|PBRM1|PBX1|PCBP1|PCBP2|PCDH7|PCDHA12|PCDHA3|PCDHA4|PCDHAC2|PCDHB11|PCDHB16|PCDHB5|PCDHGA5|PCDHGB1|PCDHGB4|PCIF1|PCK1|PCK2|PCMT1|PCNA|PCNT|PCSK5|PCYT2|PDCD10|PDCD5|PDCD6|PDCD6IP|PDGFRA|PDGFRB|PDHA1|PDHX|PDIA2|PDIA3|PDIA4|PDIA6|PDK1|PDK2|PDK3|PDK4|PDLIM2|PDLIM5|PDLIM7|PDP1|PDP2|PDPK1|PDS5A|PDX1|PDXDC1|PDXK|PDZK1|PEBP1|PECR|PELI1|PELO|PELP1|PEPD|PES1|PEX1|PEX14|PEX5|PFDN2|PFKFB1|PFKFB2|PFKFB3|PFKL|PFKM|PFKP|PFN1|PGAM1|PGAM5|PGD|PGF|PGK1|PGM1|PGM5|PGR|PHAX|PHB|PHB2|PHC3|PHF1|PHF10|PHF20|PHF21A|PHGDH|PHKA1|PHKA2|PHKB|PHKG2|PHLDB3|PHYH|PI4K2A|PIAS1|PIAS2|PIAS3|PIAS4|PICALM|PICK1|PIDD1|PIGO|PIGR|PIH1D1|PIK3C2B|PIK3CA|PIK3CB|PIK3CD|PIK3CG|PIK3R1|PIK3R2|PIK3R3|PIM1|PIN1|PINK1|PIP4K2B|PIP4K2C|PIP5K1A|PIR|PITPNA|PITPNB|PIWIL1|PIWIL4|PJA1|PKLR|PKM|PKN1|PKN2|PKNOX1|PLA2G10|PLA2G4A|PLA2G4B|PLAA|PLAGL1|PLAT|PLAU|PLB1|PLCG1|PLCG2|PLD1|PLD2|PLD3|PLEC|PLEKHA2|PLEKHG5|PLG|PLIN3|PLK1|PLK3|PLN|PLS3|PLSCR3|PLXNA2|PMAIP1|PMEL|PML|PMP2|PMPCA|PMS2|PNKP|PNMA1|PNMT|PNP|PNPLA6|PNPLA8|POF1B|POLA1|POLD1|POLD3|POLDIP2|POLDIP3|POLI|POLR1C|POLR2A|POLR2E|POLR3D|POMC|POMK|PON2|POP1|POT1|POTEE|POTEJ|POU1F1|POU2F1|PPA1|PPA2|PPARA|PPARD|PPARG|PPARGC1A|PPARGC1B|PPEF1|PPEF2|PPFIBP1|PPHLN1|PPIA|PPIAL4B|PPIB|PPID|PPIF|PPIL3|PPM1A|PPM1B|PPM1D|PPM1F|PPM1H|PPM1J|PPP1CA|PPP1CB|PPP1CC|PPP1R12A|PPP1R12C|PPP1R13L|PPP1R14A|PPP1R8|PPP2CA|PPP2CB|PPP2R1A|PPP2R1B|PPP2R4|PPP2R5A|PPP2R5C|PPP3CA|PPP3CC|PPP4C|PPP5C|PPP6C|PPP6R3|PPRC1|PPT1|PPTC7|PPWD1|PRAM1|PRCC|PRDM16|PRDM2|PRDX1|PRDX2|PRDX3|PRDX4|PRDX5|PRDX6|PRELID1|PRICKLE3|PRKAA1|PRKAA2|PRKAB1|PRKAB2|PRKACA|PRKAG1|PRKAR1A|PRKCA|PRKCB|PRKCD|PRKCE|PRKCG|PRKCH|PRKCI|PRKCQ|PRKCSH|PRKCZ|PRKD1|PRKD2|PRKDC|PRKRIR|PRMT1|PRMT3|PRMT5|PRMT8|PROCR|PROSC|PROX1|PRPF4B|PRPF6|PRPF8|PRPH|PRPS1|PRR12|PRRC1|PRRC2A|PRRG4|PRRT2|PRSS23|PRSS50|PSAP|PSEN1|PSEN2|PSMA1|PSMA2|PSMA3|PSMA4|PSMA5|PSMA6|PSMA7|PSMB1|PSMB2|PSMB3|PSMB4|PSMB5|PSMB6|PSMB7|PSMC1|PSMC2|PSMC3|PSMC3IP|PSMC4|PSMC5|PSMC6|PSMD1|PSMD10|PSMD11|PSMD12|PSMD13|PSMD14|PSMD2|PSMD3|PSMD4|PSMD5|PSMD6|PSMD7|PSMD8|PSMD9|PSME1|PSME2|PSME3|PSMF1|PSMG1|PTBP1|PTCD3|PTCH1|PTEN|PTER|PTGER1|PTGER3|PTGES3|PTGIR|PTGIS|PTGS1|PTGS2|PTK2|PTK2B|PTMA|PTMS|PTN|PTOV1|PTP4A3|PTPDC1|PTPLA|PTPLAD1|PTPMT1|PTPN1|PTPN11|PTPN12|PTPN14|PTPN18|PTPN23|PTPN3|PTPN4|PTPN6|PTPRB|PTPRD|PTPRF|PTPRJ|PTPRK|PTPRN|PTPRR|PTPRS|PTPRT|PTPRU|PTPRZ1|PTRF|PTRH2|PTTG1|PTTG1IP|PURA|PUS7|PVALB|PVR|PXN|PYCR1|PYCR2|PYGB|PZP|QARS|QDPR|QKI|QPCTL|RAB18|RAB1A|RAB1B|RAB21|RAB2A|RAB30|RAB4A|RAB5A|RAB5C|RAB6B|RAB7A|RAB9A|RABGEF1|RAC1|RAC2|RAD17|RAD18|RAD21|RAD23A|RAD50|RAD51|RAD54L2|RAD9A|RAE1|RAF1|RAI14|RALBP1|RALGDS|RAN|RANBP10|RANBP2|RANBP3|RANBP9|RANGAP1|RAP1A|RARA|RARS|RASA1|RASGRP3|RASSF1|RASSF2|RASSF8|RAVER1|RAX|RB1|RB1CC1|RBBP4|RBBP5|RBBP6|RBBP7|RBCK1|RBFA|RBL1|RBM12|RBM25|RBM26|RBM3|RBM39|RBM4|RBM5|RBM7|RBM8A|RBP1|RBPJ|RBPMS|RBX1|RC3H1|RC3H2|RCC1|RCC2|RCHY1|RCN1|RCN2|RCVRN|RECK|RECQL|RECQL4|RECQL5|REEP1|REEP2|REEP4|REEP6|REL|RELA|RELB|REM1|REN|REST|REV|REV1|RFC1|RFC3|RFC4|RFFL|RFK|RFWD2|RFWD3|RFX5|RGN|RGS2|RHEB|RHOA|RHOBTB3|RHOC|RHOG|RHOT2|RIC3|RICTOR|RIMS1|RIMS2|RIN1|RING1|RIOK2|RIPK1|RIPK2|RIPK3|RIPK4|RL2|RMDN1|RMDN3|RMND5A|RNASE1|RNASEL|RNF123|RNF125|RNF126|RNF128|RNF138|RNF144B|RNF183|RNF19A|RNF2|RNF20|RNF25|RNF31|RNF32|RNF34|RNF38|RNF4|RNF41|RNF43|RNF8|ROBO4|ROCK1|RPA1|RPA2|RPA3|RPE|RPGRIP1L|RPH3A|RPL10|RPL10A|RPL10L|RPL11|RPL12|RPL13|RPL13A|RPL14|RPL15|RPL17|RPL18|RPL19|RPL22|RPL23|RPL23A|RPL24|RPL26|RPL26L1|RPL27|RPL27A|RPL28|RPL3|RPL30|RPL31|RPL34|RPL35|RPL35A|RPL36|RPL36A|RPL37A|RPL38|RPL39|RPL4|RPL5|RPL6|RPL7|RPL7A|RPL8|RPL9|RPLP0|RPLP1|RPLP2|RPN1|RPRD1A|RPS10|RPS10P5|RPS11|RPS12|RPS13|RPS14|RPS15|RPS15A|RPS16|RPS17|RPS18|RPS19|RPS19BP1|RPS2|RPS20|RPS23|RPS24|RPS25|RPS26|RPS26P11|RPS27|RPS27A|RPS27L|RPS28|RPS29|RPS3|RPS3A|RPS4X|RPS4Y1|RPS5|RPS6|RPS6KA1|RPS6KA2|RPS6KA3|RPS6KA5|RPS6KA6|RPS6KB1|RPS6KB2|RPS7|RPS8|RPS9|RPTOR|RRAD|RRAS|RRM2|RRM2B|RRP12|RRP1B|RRP8|RRP9|RSC1A1|RSL1D1|RTN1|RTN3|RTN4|RUFY1|RUNX2|RUNX3|RUSC2|RUVBL1|RUVBL2|RXRA|RXRB|RXRG|RYBP|RYK|RYR1|RYR3|S100A1|S100A10|S100A11|S100A4|S100A6|S100A8|S100A9|S100B|S1PR1|S1PR2|S1PR4|S1PR5|SAAL1|SACM1L|SAE1|SAFB|SAFB2|SAMD4A|SAMM50|SAMSN1|SAP18|SARM1|SARS|SART1|SART3|SAT1|SATB1|SAV1|SBDS|SCAI|SCAMP1|SCAP|SCARA3|SCGB1D1|SCGB3A1|SCLT1|SCML2|SCN5A|SCNM1|SCO1|SCO2|SCP2|SCRIB|SCYL2|SDC2|SDF2L1|SDHA|SDHB|SEC13|SEC16A|SEC23A|SEC24A|SEC31A|SEC61A1|SELENBP1|SELK|SELL|SEMA4C|SEMA7A|SENP1|SENP3|SEPT4|SEPT7|SERBP1|SERPINB12|SERPINB3|SERPINB4|SERPINB5|SERPINB8|SERPINB9|SERPINE1|SERPINH1|SESN2|SET|SETD1A|SETD2|SETD6|SETD7|SETD8|SETDB1|SF1|SF3A1|SF3B1|SF3B2|SF3B3|SFN|SFPQ|SFRP4|SFXN1|SFXN5|SGK3|SGPL1|SGTA|SGTB|SH2B1|SH2B2|SH2D1A|SH3BGRL|SH3GL2|SH3GL3|SH3GLB1|SH3KBP1|SHARPIN|SHC1|SHCBP1|SHMT2|SIAH1|SIDT2|SIK2|SIK3|SIKE1|SIN3A|SIN3B|SIRPA|SIRT1|SIRT2|SIRT3|SIRT5|SIRT6|SIRT7|SIVA1|SIX3|SIZ1|SKI|SKP1|SKP2|SLC16A5|SLC16A8|SLC17A2|SLC1A1|SLC20A1|SLC20A2|SLC22A9|SLC25A1|SLC25A11|SLC25A12|SLC25A13|SLC25A23|SLC25A25|SLC25A3|SLC25A4|SLC25A41|SLC25A5|SLC2A12|SLC2A2|SLC2A4|SLC30A1|SLC33A1|SLC35A1|SLC35G2|SLC37A3|SLC39A1|SLC39A4|SLC39A8|SLC3A2|SLC4A8|SLC5A8|SLC6A15|SLC7A5|SLC8A1|SLC8A3|SLC9A1|SLC9A3|SLC9A3R1|SLC9A3R2|SLCO6A1|SLMAP|SLN|SMAD1|SMAD2|SMAD3|SMAD4|SMAD5|SMAD7|SMAP2|SMARCA2|SMARCA4|SMARCA5|SMARCB1|SMARCC1|SMARCD1|SMARCD2|SMARCD3|SMC1A|SMC3|SMC4|SMEK1|SMEK2|SMG5|SMIM12|SMN1|SMPD3|SMTNL2|SMU1|SMURF1|SMURF2|SMYD2|SNAI1|SNAI2|SNAP25|SNAP29|SNAPIN|SNCA|SNCAIP|SNCG|SND1|SNIP1|SNRNP200|SNRNP70|SNRPA1|SNRPB|SNRPD1|SNRPD2|SNRPD3|SNRPE|SNRPN|SNW1|SNX1|SNX17|SNX2|SNX27|SNX3|SNX4|SNX5|SNX6|SOAT1|SOCS1|SOCS3|SOCS5|SOCS6|SOD1|SOD2|SORBS1|SORD|SORL1|SOS1|SOST|SOX2|SOX4|SOX9|SP1|SP3|SPAG1|SPARC|SPAST|SPATA13|SPATA2|SPATA31A3|SPATA5|SPATA5L1|SPDL1|SPG20|SPHK1|SPIN1|SPINT2|SPNS1|SPP1|SPR|SPRTN|SPRY2|SPRYD3|SPSB1|SPSB2|SPSB4|SPTAN1|SPTBN1|SQRDL|SQSTM1|SRA1|SRC|SRCIN1|SREBF1|SREBF2|SRF|SRI|SRP14|SRP19|SRP72|SRPK1|SRPK2|SRPRB|SRRM1|SRRM2|SRSF1|SRSF2|SRSF3|SRSF4|SRSF5|SRSF6|SRSF7|SRSF8|SS18L1|SSB|SSBP1|SSH1|SSH3|SSR1|SSR4|SSTR5|SSX2IP|ST13|ST14|STAC3|STAM2|STAMBP|STARD7|STAT1|STAT3|STAT5A|STAT5B|STAT6|STAU1|STC2|STIM1|STIM2|STIP1|STK11|STK3|STK4|STMN1|STOM|STOML2|STRAP|STRIP1|STRN|STRN3|STRN4|STS|STUB1|STX11|STX12|STX1A|STX2|STX3|STX4|STX5|STX7|STXBP1|STXBP2|STYX|SUB1|SUGT1|SUI2|SULT1E1|SUMF1|SUMO1|SUMO2|SUMO3|SUN2|SUPT16H|SUPT3H|SUPT6H|SUPT7L|SURF6|SUV39H1|SUZ12|SVIL|SYAP1|SYK|SYN1|SYNCRIP|SYNE2|SYP|SYT1|SYT12|SYT3|SYTL1|SYVN1|TAB1|TAB2|TAB3|TACO1|TACR1|TADA1|TADA2A|TADA2B|TADA3|TAE1|TAF1|TAF10|TAF11|TAF15|TAF1A|TAF1B|TAF1C|TAF2|TAF4B|TAF5|TAF5L|TAF6|TAF9|TAGLN|TAGLN2|TAMM41|TANGO2|TANK|TAPT1|TAS2R7|TAT|TBC1D15|TBC1D19|TBC1D22B|TBC1D24|TBC1D2B|TBC1D7|TBC1D9|TBCA|TBCB|TBCCD1|TBCE|TBK1|TBKBP1|TBL1X|TBL2|TBP|TBPL1|TBXA2R|TCAP|TCEA1|TCEAL1|TCEAL4|TCEB1|TCEB2|TCF12|TCF3|TCF4|TCF7L1|TCOF1|TCP1|TCTN2|TCTN3|TDG|TDRKH|TEAD1|TEAD2|TEAD4|TECR|TEK|TENC1|TEP1|TERF1|TERT|TES|TESC|TESPA1|TEX264|TF|TFAP2A|TFAP2C|TFAP4|TFB1M|TFDP1|TFRC|TGFB1|TGFB1I1|TGFB2|TGFB3|TGFBR1|TGFBR2|TGFBR3|TGM2|TGOLN2|THADA|THAP1|THAP11|THAP4|THAP8|THBS1|THBS2|THOC5|THOC6|THRAP3|THRB|THRSP|TIAL1|TIAM1|TIMM10|TIMM13|TIMM44|TIMM50|TIMM8A|TIMM8B|TIMMDC1|TIMP1|TIMP2|TIMP3|TIMP4|TK1|TKT|TKTL2|TLE1|TLN1|TLR4|TLR9|TLX2|TM2D3|TM9SF4|TMBIM6|TMED10|TMED2|TMED6|TMED9|TMEM126B|TMEM17|TMEM173|TMEM184A|TMEM184B|TMEM185A|TMEM189|TMEM189-UBE2V1|TMEM206|TMEM214|TMEM216|TMEM259|TMEM263|TMEM41B|TMEM63B|TMOD3|TMPO|TMSB4X|TMX1|TMX2|TMX4|TNF|TNFAIP2|TNFAIP3|TNFRSF10B|TNFRSF1A|TNFRSF1B|TNFSF10|TNFSF11|TNFSF13|TNFSF13B|TNFSF9|TNIP1|TNIP2|TNK1|TNK2|TNNI2|TNP1|TNP2|TNPO2|TNPO3|TNRC6B|TOLLIP|TOM1L1|TOM1L2|TOMM20|TOMM22|TOMM40|TOMM70A|TONSL|TOP1|TOP2A|TOP2B|TOPBP1|TOPORS|TOR1A|TOR1AIP1|TOR1AIP2|TP53|TP53AIP1|TP53BP1|TP53BP2|TP53INP1|TP53RK|TP63|TP73|TPCN1|TPD52|TPD52L2|TPI1|TPM1|TPM2|TPM3|TPM4|TPP2|TPR|TPT1|TPTE|TRA|TRADD|TRAF1|TRAF2|TRAF3|TRAF4|TRAF5|TRAF6|TRAP1|TRAPPC10|TRAPPC11|TRAPPC13|TREML2|TRIAP1|TRIB3|TRIM13|TRIM14|TRIM21|TRIM24|TRIM25|TRIM27|TRIM28|TRIM32|TRIM39|TRIM41|TRIM63|TRIM72|TRIM8|TRIM9|TRIP13|TRIP4|TRMT10C|TRMT11|TRMT61B|TRO|TRPC1|TRPC4|TRPC4AP|TRPC5|TRPC6|TRPM8|TRPV6|TRRAP|TRUB1|TSC2|TSC22D1|TSC22D3|TSC22D4|TSFM|TSG101|TSPAN17|TSPO|TSPY1|TSPYL1|TST|TTC19|TTC28|TTI1|TTK|TTLL5|TTN|TTYH3|TUBA1A|TUBA1B|TUBA1C|TUBA3E|TUBA4A|TUBA8|TUBB|TUBB2A|TUBB2B|TUBB3|TUBB4A|TUBB4B|TUBB5|TUBB6|TUBB7P|TUBB8|TUBE1|TUBG1|TUBGCP2|TUBGCP4|TUFM|TULP3|TUT1|TWF1|TWF2|TWIST1|TWIST2|TXLNA|TXN|TXN2|TXNDC11|TXNIP|TXNL4A|TYK2|TYSND1|U2AF1|U2AF2|U2SURP|UBA1|UBA5|UBASH3A|UBB|UBC|UBD|UBE2A|UBE2B|UBE2C|UBE2D1|UBE2D2|UBE2D3|UBE2E1|UBE2H|UBE2I|UBE2K|UBE2L3|UBE2M|UBE2N|UBE2R2|UBE2V1|UBE2V2|UBE3A|UBE4B|UBFD1|UBIAD1|UBL4A|UBQLN1|UBQLN2|UBQLN4|UBR1|UBR2|UBR4|UBR5|UBTD1|UBTF|UBXN1|UBXN6|UCHL1|UCHL3|UCHL5|UCP2|UFC1|UFD1L|UFL1|UFM1|UFSP2|UGDH|UGP2|UGT8|UHRF1|UHRF2|UIMC1|UL46|ULP1|UMPS|UNC13B|UNC5CL|UNK|UPF2|UPK1A|UQCRB|UQCRC1|UQCRC2|UQCRH|UQCRQ|USF1|USF2|USO1|USP1|USP10|USP11|USP12|USP14|USP15|USP18|USP2|USP21|USP22|USP28|USP29|USP3|USP30|USP31|USP36|USP37|USP39|USP4|USP42|USP43|USP46|USP48|USP49|USP53|USP7|USP9X|USP9Y|USPL1|UTP14A|UTP15|UTP20|UTP6|UVSSA|VAC14|VAMP2|VAMP7|VANGL1|VANGL2|VAPA|VASN|VASP|VAT1|VAV1|VAV2|VAV3|VCAN|VCL|VCP|VDAC1|VDAC2|VDAC3|VDR|VEGFA|VEGFB|VHL|VIF|VIM|VIMP|VNN2|VPR|VPRBP|VPS29|VPS35|VPS4B|VRK1|VRK2|VSIG1|VSIG4|VSX2|VTN|VWA3B|VWA8|VWA9|WAS|WDFY1|WDFY2|WDFY3|WDR11|WDR20|WDR26|WDR33|WDR36|WDR48|WDR5|WDR61|WDR62|WDR70|WDR73|WDR77|WDR82|WHSC1|WHSC1L1|WISP2|WNK1|WRAP73|WRB|WRN|WRNIP1|WT1|WWC1|WWC2|WWC3|WWOX|WWP1|WWTR1|XIAP|XPC|XPO1|XPO6|XPR1|XRCC1|XRCC3|XRCC5|XRCC6|XRN1|YAF2|YAP1|YBX1|YBX2|YBX3|YEATS2|YEATS4|YES1|YIPF3|YIPF5|YME1L1|YOD1|YTHDF1|YWHAB|YWHAE|YWHAG|YWHAH|YWHAQ|YWHAZ|YY1|ZADH2|ZAN|ZBTB16|ZBTB17|ZBTB2|ZBTB20|ZBTB24|ZBTB3|ZBTB33|ZBTB38|ZBTB5|ZBTB7A|ZBTB7B|ZBTB7C|ZBTB8A|ZBTB9|ZC3H11A|ZC3H12A|ZC3H13|ZC3H14|ZC3H7A|ZC3HAV1|ZCCHC10|ZCCHC8|ZDHHC18|ZDHHC23|ZDHHC6|ZEB1|ZFP14|ZFP36|ZFP36L2|ZFP91|ZFYVE1|ZG16B|ZHX1|ZMIZ1|ZMIZ2|ZMPSTE24|ZMYM6|ZMYND11|ZNF101|ZNF131|ZNF148|ZNF212|ZNF219|ZNF24|ZNF263|ZNF346|ZNF354C|ZNF420|ZNF462|ZNF496|ZNF503|ZNF550|ZNF598|ZNF606|ZNF668|ZNF669|ZNF675|ZNF707|ZNF746|ZNF785|ZNF839|ZNF865|ZNHIT3|ZNHIT6|ZSCAN1|ZSCAN20|ZSWIM8|ZUFSP|ZWINT|ZYX


% From IID Database:
% 8 query IDs had no PPIs:
% CPT1B, PDX1, COX2, ND1, SLC2A4, SLC9A3, ACOT1, NCF1
% 7,445 entries
% a = readtable('PPIs.txt');
