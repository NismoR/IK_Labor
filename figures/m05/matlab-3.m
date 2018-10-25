trndata=[Xin Xout];
initfis=fismat;
epoch=teach_num;
[fis2 error]=anfis(trndata,initfis,epoch);
db=1:1:teach_num;
