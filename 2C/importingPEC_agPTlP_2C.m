clear all
clc

exp1 = '1407';
exp2 = '1408';
exp3 = '1409';
exp4 = '1410';
exp5 = '1411';
exp6 = '1445';
exp7 = '1446';
exp8 = '1447';
exp9 = '1457';
exp10= '1458';

exp11= '1485';
exp12= '1486';
exp13= '1487';
exp14= '1488';
exp15= '1509';
exp16= '1510';
exp17= '1529';
exp18= '1537';   Qcexp181 = 1573.240; %Qdexp181 = []; tcexp216 = 4924.310; Icmxp216 = 1.0;  Icexp216 = 0.5;  Vmexp216 = 4.2;  Veexp216 = 4.2;  Vc0exp216 = 4.2;  Vd0exp216 = 4.2;  Tmexp216 = 25;
exp182='1540';   Qcexp182 = 1025.689; Qdexp182 = 1871.768; %tcexp216 = 4924.310; Icmxp216 = 1.0;  Icexp216 = 0.5;  Vmexp216 = 4.2;  Veexp216 = 4.2;  Vc0exp216 = 4.2;  Vd0exp216 = 4.2;  Tmexp216 = 25;
                 Qcexp18 = Qcexp181 + Qcexp182; Qdexp18 = Qdexp182; Idcexp18 = 2.9359; Vdcexp18 = 0.5043; Iddexp18 = 2.9363; Vddexp18 = 0.4088;
exp19= '1543';
exp20= '1551';   Qcexp201 = 1363.547; %Qdexp181 = []; tcexp216 = 4924.310; Icmxp216 = 1.0;  Icexp216 = 0.5;  Vmexp216 = 4.2;  Veexp216 = 4.2;  Vc0exp216 = 4.2;  Vd0exp216 = 4.2;  Tmexp216 = 25;
exp202='1556';   Qcexp202 =  992.593; Qdexp202 = 1785.118; %tcexp216 = 4924.310; Icmxp216 = 1.0;  Icexp216 = 0.5;  Vmexp216 = 4.2;  Veexp216 = 4.2;  Vc0exp216 = 4.2;  Vd0exp216 = 4.2;  Tmexp216 = 25;
                 Qcexp20 = Qcexp201 + Qcexp202; Qdexp20 = Qdexp202; Idcexp20 = 2.9361; Vdcexp20 = 0.6115; Iddexp20 = 2.9359; Vddexp20 = 0.2474;
                 
expM = [exp1; exp3; exp5; exp7; exp9;  exp11; exp13; exp15; exp17; exp19];
expP = [exp2; exp4; exp6; exp8; exp10; exp12; exp14; exp16;'0189';'0209'];
expN = [11; 11; 11; 11; 11; 11; 11; 11; 11; 11];
n_exp = 10;

ncyc_exp = 11 + 1;
vcyc = 1:2*ncyc_exp*n_exp;
Mcyc = reshape(vcyc,2*ncyc_exp,n_exp)';
% break

neven = 2:2:2*ncyc_exp-1;
nodd = 1:2:2*ncyc_exp-2;
fg0 = 60;
vV0 = [];
QQ = 0;     Q2C_3 = [];     R2C_3 = [];
xdata_2c = [];  ydata_2c = [];
Mcycv = [];     Tcm_av = [];    ts = 1;
Mcycv1 = [];    Vc0_av1 = [];
Mcycv2 = [];    Vd0_av2 = [];
dI = 2e-3;    dV = 2e-3;    
MdCpc=0;    MdCpd=0;    MdPc=0;    MdPd=0;    Mdtc=0;
c0 = 0;    g = 1;   
CycCapv = [];   CycTimv = [];   RPTCapv = [];   RPTTimv = [];
CycResv = [];   RPTResv = [];   CycCapChTv = [];
CycChTv = [];   CycChTTimv = [];
CycCapv_b = [];     CycChTv_b = [];
CycCapv_Q1 = [];    RPTCapv_Q1 = [];
CycCapv_Q2 = [];    RPTCapv_Q2 = [];
for j = 1:9;%9;%n_exp
%%
    count = str2double(expM(j,:));
    fname_a = sprintf('Test%d.csv',count);
    [Qc_a,Qd_a, Vdc_a,Vdd_a,Vdd2_a, tc_a,td_a, Icm_a,Ic_a,Id_a,Vcm_a,Vce_a,Vc0_a,Vd0_a,Tcm_a, Qci_a,tci_a] = importingPEC_ageing(fname_a, expN(j));
    Pc_a = Vdc_a * 5.87;    Pd_a = Vdd_a * 5.87/2;
    Pc_a2 = Vdc_a/(2*2.75); Pd_a2 = Vdd_a/2.75;     Pd2_a2 = Vdd2_a/2.75;
%     break
%     Qc_a_tot = [];
%     Qd_a_tot = [];

%%
%     %original Cap
    figure(fg0)
    plot(Mcyc(j,nodd(2:ts:end)), (c0+g*Qc_a(2:ts:end))/1e3,'sr','MarkerFaceColor','r','markersize',6);hold on;axis tight;
        plot(Mcyc(j,nodd(2:ts:end)), (c0+g*Qci_a(2:ts:end))/1e3,'sr','MarkerFaceColor','r','MarkerEdgeColor','w','markersize',6);hold on;axis tight;
      dCpc=dI*tc_a(2:ts:end);  plot(Mcyc(j,nodd(2:ts:end)), (c0+g*Qc_a(2:ts:end)+dCpc)/1e3,'+b','markersize',4);hold on;axis tight;
                               plot(Mcyc(j,nodd(2:ts:end)), (c0+g*Qc_a(2:ts:end)-dCpc)/1e3,'+b','markersize',4);hold on;axis tight;
      MdCpc=max([MdCpc,dCpc]);
    plot(Mcyc(j,neven(2:ts:end)),(c0+g*Qd_a(2:ts:end))/1e3,'sg','MarkerFaceColor','g','markersize',6);hold on;axis tight;%title('Capacity fade')
      dCpd=dI*td_a(2:ts:end);  plot(Mcyc(j,neven(2:ts:end)), (c0+g*Qd_a(2:ts:end)+dCpd)/1e3,'+b','markersize',4);hold on;axis tight;
                               plot(Mcyc(j,neven(2:ts:end)), (c0+g*Qd_a(2:ts:end)-dCpd)/1e3,'+b','markersize',4);hold on;axis tight;
      MdCpd=max([MdCpd,dCpd]);
      CycCap1 = [Qc_a(2:ts:end); Qd_a(2:ts:end)]/1e3;  CycCap2 = CycCap1(:)';  CycCapv = [CycCapv CycCap2];  CycTimv = [CycTimv Mcyc(j,1+2:end-2)];
      CycCapv_b = [CycCapv_b Qci_a(2:ts:end)/1e3];

    figure(fg0+1)
    plot(Mcyc(j,nodd(2:ts:end)), Pc_a2(2:ts:end),'sr','MarkerFaceColor','r','markersize',6);hold on;axis tight;
      dPc=(2*dV./Vdc_a(2:ts:end)+2*dI/(2*2.75)).*Pc_a2(2:ts:end);  plot(Mcyc(j,nodd(2:ts:end)), Pc_a2(2:ts:end)+dPc,'+b','markersize',4);hold on;axis tight;
                                                                   plot(Mcyc(j,nodd(2:ts:end)), Pc_a2(2:ts:end)-dPc,'+b','markersize',4);hold on;axis tight;
    MdPc=max([MdPc,dPc]);
    plot(Mcyc(j,neven(2:ts:end)),Pd_a2(2:ts:end),'sg','MarkerFaceColor','g','markersize',6);hold on;axis tight;%title('Power fade')
      dPd=(2*dV./Vdd_a(2:ts:end)+2*dI/2.75).*Pd_a2(2:ts:end);  plot(Mcyc(j,neven(2:ts:end)), Pd_a2(2:ts:end)+dPd,'+b','markersize',4);hold on;axis tight;
                                                               plot(Mcyc(j,neven(2:ts:end)), Pd_a2(2:ts:end)-dPd,'+b','markersize',4);hold on;axis tight;
    MdPd=max([MdPd,dPd]);
    CycRes1 = [Pc_a2(2:ts:end); Pd_a2(2:ts:end)];  CycRes2 = CycRes1(:)';  CycResv = [CycResv CycRes2];
xdata_2c = [xdata_2c Mcyc(j,nodd(2:end))];
ydata_2c = [ydata_2c tc_a(2:end)];

    figure(fg0+2)
    plot(Mcyc(j,nodd(2:ts:end)),tc_a(2:ts:end)/3600,'sr','MarkerFaceColor','r','markersize',6);hold on;axis tight;%title('Charge time')
    dtc=1;  plot(Mcyc(j,nodd(2:ts:end)), (tc_a(2:ts:end)+dtc)/3600,'+b','markersize',4);hold on;axis tight;
            plot(Mcyc(j,nodd(2:ts:end)), (tc_a(2:ts:end)-dtc)/3600,'+b','markersize',4);hold on;axis tight;
        plot(Mcyc(j,nodd(2:ts:end)),tci_a(2:ts:end)/3600,'sr','MarkerFaceColor','r','MarkerEdgeColor','w','markersize',6);hold on;axis tight;%title('Charge time')
    Mdtc=max([Mdtc,dtc]);
    CycChT1 = tc_a(2:ts:end)/3600;  CycChT2 = CycChT1(:)';  CycChTv = [CycChTv CycChT2];  CycChTTimv = [CycChTTimv Mcyc(j,nodd(1+1:ts:end))];
    CycChTv_b = [CycChTv_b tci_a(2:ts:end)/3600];
    
    figure(fg0+3)
    plot(Mcyc(j,nodd(2:ts:end)),Icm_a(2:ts:end),'sr','MarkerFaceColor','r','markersize',6);hold on;axis tight;%title('Average I')
    plot(Mcyc(j,nodd(2:ts:end)),Ic_a(2:ts:end),'sr','linewidth',2,'markersize',6);hold on;axis tight;%title('Average I')
    
    figure(fg0+4)
    plot(Mcyc(j,nodd(2:ts:end)),Vcm_a(2:ts:end),'sr','linewidth',2,'markersize',6);hold on;axis tight;%title('Max/End V')
    plot(Mcyc(j,nodd(2:ts:end)),Vce_a(2:ts:end),'sr','MarkerFaceColor','r','markersize',6);hold on;axis tight
    
    figure(fg0+5)
    plot(Mcyc(j,nodd(2:ts:end)),Tcm_a(2:ts:end),'sr','MarkerFaceColor','r','markersize',6);hold on;axis tight;%title('Max T')
    Mcycv = [Mcycv Mcyc(j,nodd(2:ts:end))];    Tcm_av = [Tcm_av Tcm_a(2:ts:end)];
    
    figure(fg0+6)
    plot(Mcyc(j,nodd(1:ts:end)),Vc0_a(1:ts:end),'sr','MarkerFaceColor','r','markersize',6);hold on;axis tight;%title('Max/End V')
    plot(Mcyc(j,nodd(1:ts:end)),Vd0_a(1:ts:end),'sr','linewidth',2,'markersize',6);hold on;axis tight
    Mcycv1 = [Mcycv1 Mcyc(j,nodd(1:ts:end))];      Vc0_av1 = [Vc0_av1 Vc0_a(1:ts:end)];
    Mcycv2 = [Mcycv2 Mcyc(j,nodd(1:ts:end))];      Vd0_av2 = [Vd0_av2 Vd0_a(1:ts:end)];
    
    figure(fg0+7)
    plot(Mcyc(j,nodd(2:end)),(Qc_a(2:end)/1e3)./(tc_a(2:end)/3600),'sr','MarkerFaceColor','r','markersize',6);hold on;axis tight;%title('Charge time')
    Qx = [Qc_a'/1e3 Qd_a'/1e3]; Qy = Qx';   Qz=Qy(:);   QQ=QQ(end)+cumsum(Qz);
    CycCapChT1 = (Qc_a(2:end)/1e3)./(tc_a(2:end)/3600);  CycCapChT2 = CycCapChT1(:)';  CycCapChTv = [CycCapChTv CycCapChT2];
    
    figure(fg0+8)
    plot(QQ(1:2:length(QQ)),Qc_a/1e3,'sr','MarkerFaceColor','r','markersize',6);hold on;axis tight;
    plot(QQ(2:2:length(QQ)),Qd_a/1e3,'sg','MarkerFaceColor','g','markersize',6);hold on;axis tight;%title('Capacity fade')
        CycCap1_Q1 = [Qc_a; Qd_a]/1e3;  CycCap2_Q1 = CycCap1_Q1(:)';  CycCapv_Q1 = [CycCapv_Q1 CycCap2_Q1];
        CycCapv_Q2 = [CycCapv_Q2 QQ'];
    vV0 = [vV0 [Vc0_a(1:end); Vd0_a(1:end)]];
%%
    if j<=8
    count = str2double(expP(j,:));
    fname_p = sprintf('Test%d.csv',count);
    [Qc_p,Qd_p, Idc_p,Vdc_p,Idd_p,Vdd_p, tc_p,td_p] = importingPEC_PT(fname_p);
    elseif j==9   %SPECIAL CUZ THE THERMAL PROBLEMS STARTED HERE.
        Qc_p = Qcexp18;        Qd_p = [0, Qdexp18];
        Idc_p = Idcexp18;      Idd_p = [0, Iddexp18];
        Vdc_p = Vdcexp18;      Vdd_p = [0, Vddexp18];
    elseif j==10   %SPECIAL CUZ THE THERMAL PROBLEMS STARTED HERE.
        Qc_p = Qcexp20;        Qd_p = [0, Qdexp20];
        Idc_p = Idcexp20;      Idd_p = [0, Iddexp20];
        Vdc_p = Vdcexp20;      Vdd_p = [0, Vddexp20];
    end
%%
%     %original Cap
    figure(fg0)
    plot(Mcyc(j,end-1),(c0+g*Qc_p)   /1e3,'sr','linewidth',2,'markersize',12);hold on;axis tight;
      dCpc_p=dI*tc_p;  plot(Mcyc(j,end-1), (c0+g*Qc_p+dCpc_p)/1e3,'+b','markersize',4);hold on;axis tight;
                       plot(Mcyc(j,end-1), (c0+g*Qc_p-dCpc_p)/1e3,'+b','markersize',4);hold on;axis tight;
      MdCpc=max([MdCpc,dCpc_p]);
    plot(Mcyc(j,end),  (c0+g*Qd_p(2))/1e3,'sg','linewidth',2,'markersize',12);hold on;axis tight;
      dCpd_p=dI*td_p(2);  plot(Mcyc(j,end), (c0+g*Qd_p(2)+dCpd_p)/1e3,'+b','markersize',4);hold on;axis tight;
                          plot(Mcyc(j,end), (c0+g*Qd_p(2)-dCpd_p)/1e3,'+b','markersize',4);hold on;axis tight;
      MdCpd=max([MdCpd,dCpd_p]);
    Q2C_1 = [Qc_p; Qd_p(2)];   Q2C_2 = Q2C_1(:)';   Q2C_3 = [Q2C_3 Q2C_2];
    RPTCap1 = [Qc_p; Qd_p(2)]/1e3;  RPTCap2 = RPTCap1(:)';  RPTCapv = [RPTCapv RPTCap2];  RPTTimv = [RPTTimv Mcyc(j,end-1:end)];
    
    figure(fg0+1)
    plot(Mcyc(j,end-1),Vdc_p/Idc_p,'sr','linewidth',2,'markersize',12);hold on;axis tight;
    dPc_p=(2*dV./Vdc_p+2*dI/Idc_p).*Vdc_p/Idc_p;  plot(Mcyc(j,end-1), Vdc_p/Idc_p+dPc_p,'+b','markersize',4);hold on;axis tight;
                                                  plot(Mcyc(j,end-1), Vdc_p/Idc_p-dPc_p,'+b','markersize',4);hold on;axis tight;
    MdPc=max([MdPc,dPc_p]);
    plot(Mcyc(j,end),  Vdd_p(2)/Idd_p(2),'sg','linewidth',2,'markersize',12);hold on;axis tight;%title('Power fade')
    dPd_p=(2*dV./Vdd_p(2)+2*dI/Idd_p(2)).*Vdd_p(2)/Idd_p(2);  plot(Mcyc(j,end), Vdd_p(2)/Idd_p(2)+dPd_p,'+b','markersize',4);hold on;axis tight;
                                                              plot(Mcyc(j,end), Vdd_p(2)/Idd_p(2)-dPd_p,'+b','markersize',4);hold on;axis tight;
    MdPd=max([MdPd,dPd_p]);
    R2C_1 = [Vdc_p/Idc_p; Vdd_p(2)/Idd_p(2)];   R2C_2 = R2C_1(:)';   R2C_3 = [R2C_3 R2C_2];
    RPTRes1 = [Vdc_p/Idc_p; Vdd_p(2)/Idd_p(2)];  RPTRes2 = RPTRes1(:)';  RPTResv = [RPTResv RPTRes2];
        Qx = [Qc_p'/1e3 Qd_p(2)'/1e3]; Qy = Qx';   Qz=Qy(:);   QQ=QQ(end)+cumsum(Qz);
    
    figure(fg0+8)
    plot(QQ(1:2:length(QQ)),Qc_p/1e3,'sr','linewidth',2,'markersize',12);hold on;axis tight;
    plot(QQ(2:2:length(QQ)),Qd_p(2)/1e3,'sg','linewidth',2,'markersize',12);hold on;axis tight;%title('Capacity fade')
        RPTCap1_Q1 = [Qc_p; Qd_p(2)]/1e3;  RPTCap2_Q1 = RPTCap1_Q1(:)';  RPTCapv_Q1 = [RPTCapv_Q1 RPTCap2_Q1];
        RPTCapv_Q2 = [RPTCapv_Q2 QQ'];
end
num2str([MdCpc    MdCpd    MdPc    MdPd    Mdtc],'%2.5e\t')

figure(19)
plot(0,0);hold on;axis tight;%title('Max T')
set(gca,'xtick',[]);set(gca,'xticklabel',[]);set(gca,'yticklabel',[])
ax2 = axes('YAxisLocation','right','Color','w','XColor','k','YColor','k');
line(Mcycv,Tcm_av,'linestyle','none','marker','s','color','r','MarkerFaceColor','r','markersize',6,'Parent',ax2);
box on;hold on;axis tight;

figure(20)
plot(0,0);hold on;axis tight;%title('Max T')
set(gca,'xtick',[]);set(gca,'xticklabel',[]);set(gca,'yticklabel',[])
ax2 = axes('YAxisLocation','right','Color','w','XColor','k','YColor','k');
line(Mcycv1,Vc0_av1,'linestyle','none','marker','s','color','r','MarkerFaceColor','r','markersize',6,'Parent',ax2);hold on;axis tight;
line(Mcycv2,Vd0_av2,'linestyle','none','marker','s','color','r','linewidth',2,'markersize',6,'Parent',ax2);hold on;axis tight;
box on;hold on;axis tight;

save QR_2C_e.mat Q2C_3 R2C_3

%%
results2C.xdata.cyc = CycTimv;
results2C.xdata.rpt = RPTTimv;
results2C.xdata.chg = CycChTTimv;
results2C.ydata.capacity_cyc = CycCapv;
results2C.ydata.capacity_cycb = CycCapv_b;
results2C.ydata.capacity_rpt = RPTCapv;
results2C.ydata.resistance_cyc = CycResv;
results2C.ydata.resistance_rpt = RPTResv;
results2C.ydata.chgtime = CycChTv;
results2C.ydata.chgtimeb = CycChTv_b;
results2C.ydata.capacity_chgtime = CycCapChTv;

results2C.ydata.capacity_cyc_thput = CycCapv_Q1;
results2C.ydata.capacity_rpt_thput = RPTCapv_Q1;
results2C.xdata.cyc_thput = CycCapv_Q2;
results2C.xdata.rpt_thput = RPTCapv_Q2;
save data2C_e.mat results2C
