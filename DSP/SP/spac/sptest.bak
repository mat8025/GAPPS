      PROGRAM SPTEST
C-Latest date: 06/29/92
C-
C-**********************************************************************
C-                           SPTEST.FOR                                *
C-           SIGNAL PROCESSING ALGORITHMS SUBPROGRAM TESTS             *
C-                     Source code in Fortran-77                       *
C-**********************************************************************
C-
C-This program tests the subroutines and functions in SIGNAL PROCESSING
C- ALGORITHMS, Appendix A1.  In each test the message "passed" or
C- "failed" is printed after the name of the routine by the SPOUT
C- subroutine at the end of this program.
C-Each test checks for correct performance for a specific input, not for 
C- all inputs, so the test is a check rather than a guarantee that the 
C- routine is working correctly.
C-A performance factor, Q, is computed as a function of the subroutine
C- output and compared with its correct value in the "CALL SPOUT" 
C- statement.  For example, the correct value of Q in the test of the
C- SPFFTR subroutine is 8389.506.  A check sum of the data arrays in
C- this program is also computed, to assure that they remain intact.
C-If a test fails, check the listings of both the subroutine and this
C- program against those in Appendix A1 of SIGNAL PROCESSING ALGORITHMS.
C- If the listings agree, make sure your compiler meets the Fortran-77
C- standard.  Next, try printing the real value of Q for this test.
C- There may be a roundoff error.  If all else fails to yield a reason 
C- for the failure, call one of the authors at a reasonable hour.
C-
C-FIXED ARRAYS:
      REAL A(4,2),B(0:4,2),C(0:4),D(0:4),KA(0:3),NU(0:4),U(0:4,0:4),
     +     V(0:4),XF(0:9),XC(0:4),YC(0:4)
C-VARIABLE ARRAYS:
      REAL X(0:99),Y(0:99),AT(4),BT(0:4),CT(0:4),AT2(4,2),BT2(0:4,2),
     +     KAT(0:3),NUT(0:4),WK(0:17),WK2(0:4,2),WK3(0:4,0:4)
      COMPLEX CX(0:15),CY(0:8),CWK(0:15),SPCOMP,SPGAIN
C-DATA FOR FIXED ARRAYS:
      DATA A/-0.9,1.45,-0.576,0.5184, -1.18,0.81,2*0./,
     +     B/1.,2.,3.,4.,5., 1.,1.,3*0./,
     +     C/1.,-6.,22.,-46.,40./, D/1.,0.,5.,0.,4./
     +     KA/-.38,.85,-.15,.52/, NU/-3.15,-1.33,2.74,8.50,5.00/,
     +     U/9.,4.,-1.,-4.,0.,1.,8.,-2.,-5.,0.,2.,5.,7.,1.,0.,
     +       3.,6.,-3.,6.,0.,4*0.,1./,  V/29.,59.,4.,13.,1./,
     +     XF/15.,14.,12.,9.,7.,6.,4.,3.,2.,1./,
     +     XC/2.,4.,5.,6.,8./,    YC/1.,2.,3.,5.,2./
C-
C-FIXED DATA CHECK SUM:
      S1=XF(5)+XF(6)+XF(7)+XF(8)+XF(9)
      DO 11 K=0,4
       DO 10 I=0,4
        S1=S1+U(I,K)
        IF((I+1)/2.EQ.1 .AND. K.GE.1) S1=S1+A(K,I)
        IF((I+1)/2.EQ.1) S1=S1+B(K,I)
   10  CONTINUE
       S1=S1+C(K)+D(K)+NU(K)+XC(K)+YC(K)+V(K)
       IF(K.LE.3) S1=S1+KA(K)
   11 CONTINUE
C-
C-**********************************************************************
C-
C-TEST OF SPBFCT.
      Q=0
      DO 1190 I=5,7
       Q=Q+SPBFCT(I,I-2)
 1190 CONTINUE
      CALL SPOUT('SPBFCT ',INT(2940.000-Q))
C-
C-**********************************************************************
C-
C-TEST OF SPBILN.
      CALL SPBILN(D,C,4,BT,AT,WK3,IE)
      Q=IE
      DO 710 K=0,4
       Q=Q-100.*((K+1)*BT(K)+(K+7)*AT(MAX(1,K)))
  710 CONTINUE
      CALL SPOUT('SPBILN ',INT(3354.546-Q))
C-
C-**********************************************************************
C-
C-TEST OF SPBSSL.
      CALL SPBSSL(4,1.3,4,X,Y,IE)
      Q=IE
      DO 760 I=0,4
       Q=Q+10.*X(I)+9.*Y(I)
  760 CONTINUE
      CALL SPOUT('SPBSSL ',INT(4131.385-Q))
C-
C-**********************************************************************
C-
C-TEST OF SPBWCF.
      CALL SPBWCF(4,2,4,BT,CT,IE)
      Q=IE
      DO 730 K=0,4
       Q=Q+100.*((K+1)*BT(K)+(K+7)*CT(K))
  730 CONTINUE
      CALL SPOUT('SPBWCF ',INT(3178.207-Q))
C-
C-**********************************************************************
C-
C-TEST OF SPCBII.
      CALL SPCBII(4,2,4,1.3,10.,BT,CT,IE)
      Q=IE
      DO 750 K=0,4
       Q=Q+10.*((K+1)*BT(K)+(K+7)*CT(K))
  750 CONTINUE
      CALL SPOUT('SPCBII ',INT(5225.933-Q))
C-
C-**********************************************************************
C-
C-TEST OF SPCFLT.
      DO 630 K=0,9
       X(K)=3*(K+1)
       WK(K)=K
  630 CONTINUE
      CALL SPCFLT(B(0,1),A(1,1),3,2,X,10,WK(0),WK(5),IE)
      Q=IE
      DO 631 K=0,9
       Q=Q-(K+1)*X(K)/2.
  631 CONTINUE
      CALL SPOUT('SPCFLT ',INT(8502.668-Q))
C-
C-**********************************************************************
C-
C-TEST OF SPCHBI.
      CALL SPCHBI(4,2,4,0.4,BT,CT,IE)
      Q=IE
      DO 740 K=0,4
       Q=Q+100.*((K+1)*BT(K)+(K+7)*CT(K))
  740 CONTINUE
      CALL SPOUT('SPCHBI ',INT(1786.760-Q))
C-
C-**********************************************************************
C-
C-TEST OF SPCHRP.
      DO 1450 K=0,8
       CX(K)=CMPLX(XF(K),XF(K+1))
 1450 CONTINUE
      CALL SPCHRP(CX,15,8,0.1,0.3,CWK,LX2,IE)
      Q=IE+LX2
      DO 1451 K=0,LX2
       Q=Q+10.*K*ABS(CX(K))
 1451 CONTINUE
      CALL SPOUT('SPCHRP ',INT(4609.930-Q))
C-
C-**********************************************************************
C-
C-TEST OF SPCOMP.
      CY(0)=SPCOMP(XF,8,.2)
      Q=100.*ABS(CY(0))
      CALL SPOUT('SPCOMP ',INT(1680.271-Q))
C-
C-**********************************************************************
C-
C-TEST OF SPCONV.
      DO 910 K=0,7
       Y(K)=MAX(0,4-K)
       X(K)=MAX(0,5-K)
  910 CONTINUE
      CALL SPCONV(X,Y,9,0,IE)
      Q=IE
      DO 911 K=0,7
       Q=Q+10.*K*X(K)
  911 CONTINUE
      CALL SPOUT('SPCONV ',INT(3500.000-Q))
C-
C-**********************************************************************
C-
C-TEST OF SPCORR.
      DO 920 K=0,7
       Y(K)=MAX(0,K-3)
       X(K)=MAX(0,6-K)
  920 CONTINUE
      CALL SPCORR(X,Y,9,1,6,IE)
      Q=IE
      DO 921 K=0,7
       Q=Q+10.*K*X(K)
  921 CONTINUE
      CALL SPOUT('SPCORR ',INT(9180.001-Q))
C-
C-**********************************************************************
C-
C-TEST OF SPCROS.
      DO 430 K=0,99
       X(K)=MOD(K+1,10)
       Y(K)=-MOD(K+1,14)
  430 CONTINUE
      CALL SPCROS(X,Y,CY,CWK,99,8,1,.75,NS,IE)
      Q=NS+IE
      DO 431 K=0,8
       Q=Q-10.*(REAL(CY(K))+3.*AIMAG(CY(K)))
  431 CONTINUE
      CALL SPOUT('SPCROS ',INT(4604.694-Q))
C-
C-**********************************************************************
C-
C-TEST OF SPDECI.
      DO 1010 K=0,9
       X(K)=(K+1)**2
 1010 CONTINUE
      CALL SPDECI(X,9,1.3,LX2,IE)
      Q=IE+LX2
      DO 1011 K=0,LX2
       Q=Q+K*X(K)
 1011 CONTINUE
      CALL SPOUT('SPDECI ',INT(1012.700-Q))
C-
C-**********************************************************************
C-
C-TEST OF SPDFTC.
      DO 330 K=0,7
       CX(K)=CMPLX(3.*K,5.*K)
  330 CONTINUE
      CALL SPDFTC(CX,CY,8,-1)
      Q=0.
      DO 331 K=0,7
       Q=Q+(K+1)**2*REAL(CY(K))-(K+3)*AIMAG(CY(K))
  331 CONTINUE
      CALL SPOUT('SPDFTC ',INT(2302.498-Q))
C-
C-**********************************************************************
C-
C-TEST OF SPDFTR.  PERFORM A TRANSFORM AND TEST A CHECKSUM (Q).
      CALL SPDFTR(XF,CY,8)
      Q=0.
      DO 311 K=0,4
       Q=Q+10.*((K+1)*REAL(CY(K))-(K+3)**2*AIMAG(CY(K)))
  311 CONTINUE
      CALL SPOUT('SPDFTR ',INT(7179.453-Q))
C-
C-**********************************************************************
C-
C-TEST OF SPDURB.
      CALL SPDURB(XF,3,BT,IE)
      Q=IE+100*(10*BT(0)+9*BT(1)+8*BT(2)+7*BT(3))
      CALL SPOUT('SPDURB ',INT(1067.500-Q))
C-
C-**********************************************************************
C-
C-TEST OF SPEXPN.
      DO 1250 K=0,4
       Y(K)=YC(K)
 1250 CONTINUE
      CALL SPEXPN(XC,Y,5,C0,C1,IE)
      Q=1000*C0+955*C1
      CALL SPOUT('SPEXPN ',INT(2181.754-Q))
C-
C-**********************************************************************
C-
C-TEST OF SPFBLT.
      DO 720 I=0,4
       X(I)=C(I)
       Y(I)=D(I)
  720 CONTINUE
      CALL SPFBLT(Y,X,4,2,.1,0.,BT,AT,WK3,IE)
      Q=IE
      DO 721 K=0,4
       Q=Q+10.*((K+1)*BT(K)+(K+7)*AT(MAX(1,K)))
  721 CONTINUE
      CALL SPOUT('SPFBLT ',INT(2778.627-Q))
C-
C-**********************************************************************
C-
C-TEST OF SPFFTC.
      DO 360 K=0,7
       CX(K)=CMPLX(2.**(-K),3.**(-K))
  360 CONTINUE
      CALL SPFFTC(CX,8,-1)
      Q=0.
      DO 361 K=0,7
       Q=Q+10.*((K+1)**2*REAL(CX(K))+(K+3)*AIMAG(CX(K)))
  361 CONTINUE
      CALL SPOUT('SPFFTC ',INT(2000.563-Q))
C-
C-**********************************************************************
C-
C-TEST OF SPFFTR.
      DO 340 K=0,7
       X(K)=2.**(-K)
  340 CONTINUE
      CALL SPFFTR(X,8)
      Q=0.
      DO 341 K=0,9
       Q=Q+100.*(K+1)**2*X(K)
  341 CONTINUE
      CALL SPOUT('SPFFTR ',INT(8389.506-Q))
C-
C-**********************************************************************
C-
C-TEST OF SPFILT.
      DO 610 K=0,9
       X(K)=3*(K+1)
       WK(K)=K
  610 CONTINUE
      CALL SPFILT(B(0,1),A(1,1),3,4,X,10,WK(0),WK(5),IE)
      Q=IE
      DO 611 K=0,9
       Q=Q+(K+1)*X(K)
  611 CONTINUE
      CALL SPOUT('SPFILT ',INT(7141.861-Q))
C-
C-**********************************************************************
C-
C-TEST OF SPFIRD.
      CALL SPFIRD(4,3,.3,.4,1,BT,IE)
      Q=IE
      DO 820 K=0,4
       Q=Q-10000.*BT(K)
  820 CONTINUE
      CALL SPOUT('SPFIRD ',INT(1468.984-Q))
C-
C-**********************************************************************
C-
C-TEST OF SPFIRL.
      CALL SPFIRL(4,.4,1,BT,IE)
      Q=IE
      DO 810 K=0,4
       Q=Q+10000.*BT(K)
  810 CONTINUE
      CALL SPOUT('SPFIRL ',INT(8714.650-Q))
C-
C-**********************************************************************
C-
C-TEST OF SPFLTR.
      DO 620 K=0,9
       WK(K)=K
  620 CONTINUE
      CALL SPFLTR(B(0,1),A(1,1),3,4,XF,10,Y,WK(0),WK(5),IE)
      Q=IE
      DO 621 K=0,9
       Q=Q+(K+1)*Y(K)/2.
  621 CONTINUE
      CALL SPOUT('SPFLTR ',INT(1172.911-Q))
C-
C-**********************************************************************
C-
C-TEST OF SPGAIN.
      CY(0)=SPGAIN(B(0,1),A(1,1),2,3,0.2)
      Q=1000.*(REAL(CY(0))+AIMAG(CY(0)))
      CALL SPOUT('SPGAIN ',INT(7923.157-Q))
C-
C-**********************************************************************
C-
C-TEST OF SPHILB.
      CALL SPHILB(X,31)
      Q=0.
      DO 1440 K=0,31
       Q=Q+1000.*K*X(K)
 1440 CONTINUE
      CALL SPOUT('SPHILB ',INT(5207.549-Q))
C-
C-**********************************************************************
C-
C-TEST OF SPIDTR.
      DO 320 K=0,4
       CY(K)=CMPLX(3.*K,5.*K)
  320 CONTINUE
      CALL SPIDTR(CY,X,8)
      Q=0.
      DO 321 K=0,7
       Q=Q+10.*(K+1)**2*X(K)
  321 CONTINUE
      CALL SPOUT('SPIDTR ',INT(7349.793-Q))
C-
C-**********************************************************************
C-
C-TEST OF SPIFTR.
      DO 350 K=0,9
       X(K)=2.**(-K)
  350 CONTINUE
      CALL SPIFTR(X,8)
      Q=0.
      DO 351 K=0,7
       Q=Q+10.*(K+1)**2*X(K)
  351 CONTINUE
      CALL SPOUT('SPIFTR ',INT(2369.153-Q))
C-
C-**********************************************************************
C-
C-TEST OF SPIIRD.
      CALL SPIIRD(2,3,2,4,.1,.2,.3,.4,20.,BT2,AT2,IE)
      Q=IE
      DO 770 K=0,4
       Q=Q+1000.*(AT2(MAX(K,1),1)+AT2(MAX(K,1),2)+BT2(K,1)+BT2(K,2))
  770 CONTINUE
      CALL SPOUT('SPIIRD ',INT(1026.385-Q))
C-
C-**********************************************************************
C-
C-TEST OF SPLEVS.
      CALL SPLEVS(XF,XF(1),3,BT,WK,IE)
      Q=IE+100*(10*BT(0)+9*BT(1)+8*BT(2)+7*BT(3))
      CALL SPOUT('SPLEVS ',INT(1067.500-Q))
C-
C-**********************************************************************
C-
C-TEST OF SPLFIT.
      CALL SPLFIT(XC,YC,5,C0,C1,IE)
      Q=1000*C0+955*C1
      CALL SPOUT('SPLFIT ',INT(1350.500-Q))
C-
C-**********************************************************************
C-
C-TEST OF SPLFLT.
      DO 650 K=0,9
       X(K)=3*(K+1)
       WK(K)=K
  650 CONTINUE
      CALL SPLFLT(KA,NU,4,X,10,WK(0),IE)
      Q=IE
      DO 651 K=0,9
       Q=Q+100.*(K+1)*X(K)/100.
  651 CONTINUE
      CALL SPOUT('SPLFLT ',INT(9582.598-Q))
C-
C-**********************************************************************
C-
C-TEST OF SPLINT.
      DO 1020 K=0,9
       X(K)=(K+1)**2
 1020 CONTINUE
      CALL SPLINT(X,99,9,0.25,LX2,IE)
      Q=IE+LX2
      DO 1021 K=0,LX2
       Q=Q+0.1*K*X(K)
 1021 CONTINUE
      CALL SPOUT('SPLINT ',INT(3695.250-Q))
C-
C-**********************************************************************
C-
C-TEST OF SPLMTS.
      CALL SPLMTS(XF,10,X1,I1,X2,I2)
      Q=1000*X1+100*X2+100*(I1+I2)
      CALL SPOUT('SPLMTS ',INT(3400.000-Q))
C-
C-**********************************************************************
C-
C-TEST OF SPLSMT.
      CALL SPLSMT(9,4,WK3)
      DO 1181 I=0,4
       Q=100*(9*WK3(I,0)-8*WK3(I,1)+7*WK3(I,2)-6*WK3(I,3)+WK3(I,4))
 1181 CONTINUE
      CALL SPOUT('SPLSMT ',INT(4279.167-Q))
C-
C-**********************************************************************
C-
C-TEST OF SPLTCF
      CALL SPLTCF(B,A,4,KAT,NUT,WK2,IE)
      Q=IE+10.*NUT(4)
      DO 661 K=0,3
       Q=Q+10.*((K+1)*KAT(K)+(K+10)*NUT(K))
  661 CONTINUE
      CALL SPOUT('SPLTCF ',INT(1051.609-Q))
C-
C-**********************************************************************
C-
C-TEST OF SPMASK.
      DO 1420 K=0,9
       X(K)=XF(K)
 1420 CONTINUE
      CALL SPMASK(X,9,6,TSV,IE)
      Q=IE+100.*TSV
      DO 1421 K=0,9
       Q=Q+10.*K*X(K)
 1421 CONTINUE
      CALL SPOUT('SPMASK ',INT(1278.456-Q))
C-
C-**********************************************************************
C-
C-TEST OF SPMEAN.
      Q=10*SPMEAN(XF,10)
      CALL SPOUT('SPMEAN ',INT(73.-Q))
C-
C-**********************************************************************
C-
C-TEST OF SPNLMS.
      DO 1210 I=0,8
       X(I)=XF(I)
       Y(I)=XF(I+1)
       IF(I.LE.4) BT(I)=I
       IF(I.LE.4) WK(I)=-I
 1210 CONTINUE
      SIG=100.
      CALL SPNLMS(X,9,Y,BT,4,0.1,SIG,0.05,WK,IE)
      Q=IE+100*(10*BT(0)+9*BT(1)+8*BT(2)+7*BT(3)+6*BT(4))+X(5)
      CALL SPOUT('SPNLMS ',INT(2009.807-Q))
C-
C-**********************************************************************
C-
C-TEST OF SPNORM.
      DO 1110 K=0,9
       X(K)=(K+1)**2/100.
       Y(K)=COS(K/3.)
 1110 CONTINUE
      CALL SPNORM(X,Y,10,4,WK3,WK,IE)
      Q=IE
      DO 1111 I=0,4
       DO 1111 J=0,4
        Q=Q-100*I*J*(WK3(I,J)+WK(I))
 1111 CONTINUE
      CALL SPOUT('SPNORM ',INT(2971.514-Q))
C-
C-**********************************************************************
C-
C-TEST OF SPORTH.
      DO 1131 K=0,9
       Y(K)=(K+1)**2.5/10.
 1131 CONTINUE
      CALL SPORTH(Y,10,4,BT,WK3,IE)
      Q=IE+1000*(10*BT(0)+9*BT(1)+8*BT(2)+7*BT(3)+6*BT(4))
      CALL SPOUT('SPORTH ',INT(7143.835-Q))
C-
C-**********************************************************************
C-
C-TEST OF SPPFLT.
      DO 640 K=10,27
       Y(K)=K
  640 CONTINUE
      CALL SPPFLT(B(0,1),A(1,1),4,2,XF,10,Y(0),Y(10),Y(20),IE)
      Q=IE
      DO 641 K=0,9
       Q=Q+(K+1)*Y(K)
  641 CONTINUE
      CALL SPOUT('SPPFLT ',INT(4361.801-Q))
C-
C-**********************************************************************
C-
C-TEST OF SPPOLY.
      CALL SPPOLY(0.6,XF,10,4,BT,WK,WK3,IE)
      Q=IE+10*(10*BT(0)+9*BT(1)+8*BT(2)+7*BT(3)+6*BT(4))
      CALL SPOUT('SPPOLY ',INT(1287.019-Q))
C-
C-**********************************************************************
C-
C-TEST OF SPPOWR.
      DO 410 K=0,99
       X(K)=MOD(K+1,10)
  410 CONTINUE
      CALL SPPOWR(X,Y,WK,99,8,1,.75,NS,IE)
      Q=NS+IE
      DO 411 K=0,8
       Q=Q+10.*Y(K)
  411 CONTINUE
      CALL SPOUT('SPPOWR ',INT(3966.887-Q))
C-
C-**********************************************************************
C-
C-TEST OF SPPWRC.
      DO 1260 K=0,4
       X(K)=XC(K)
       Y(K)=YC(K)
 1260 CONTINUE
      CALL SPPWRC(X,Y,5,C0,C1,IE)
      Q=1000*C0+955*C1
      CALL SPOUT('SPPWRC ',INT(1441.503-Q))
C-
C-**********************************************************************
C-
C-TEST OF SPRAND.
      ISEED=12345
      Q=0.
      DO 421 K=0,99
       Q=Q+100.*SPRAND(ISEED)
  421 CONTINUE
      CALL SPOUT('SPRAND ',INT(4690.126-Q))
C-
C-**********************************************************************
C-
C-TEST OF SPRESP.
      CALL SPRESP(XF,Y,3,9,B(0,1),A(1,1),2,3)
      Q=XF(1)
      DO 521 K=0,9
       Q=Q+(K+1)*Y(K)
  521 CONTINUE
      CALL SPOUT('SPRESP ',INT(2826.438-Q))
C-
C-**********************************************************************
C-
C-TEST OF SPRFTM.
      DO 1280 K=0,29
       X(K)=MIN(1.,K/15.)*MIN(1,INT((K/3.)))
 1280 CONTINUE
      CALL SPRFTM(1,X,30,T0,T10,T90,T100,IE)
      Q=100*(5*T0+4*T10+3*T90+2*T100)
      CALL SPOUT('SPRFTM ',INT(9050.000-Q))
C-
C-**********************************************************************
C-
C-TEST OF SPSOLV.
      DO 1121 I=0,4
       WK(I)=V(I)
       DO 1120 J=0,4
        WK3(I,J)=U(I,J)
 1120  CONTINUE
 1121 CONTINUE
      CALL SPSOLV(WK3,WK,4,BT,IE)
      Q=IE+1000*BT(0)+100*BT(1)+10*BT(2)+BT(3)
      CALL SPOUT('SPSOLV ',INT(1234.000-Q))
C-
C-**********************************************************************
C-
C-TEST OF SPSTRL.
      CALL SPSTRL(4,WK3)
      DO 1171 I=0,4
       Q=9*WK3(I,0)-8*WK3(I,1)+7*WK3(I,2)-6*WK3(I,3)+WK3(I,4)
 1171 CONTINUE
      CALL SPOUT('SPSTRL ',INT(162.0000-Q))
C-
C-**********************************************************************
C-
C-TEST OF SPUNWR.
      DO 1430 K=0,7
       X(K)=(K-4)**2
 1430 CONTINUE
      CALL SPUNWR(X,7,1)
      Q=10.*(X(0)+2*X(2)+3*X(4)+4*X(6)+5*X(7))
      CALL SPOUT('SPUNWR ',INT(2295.133-Q))
C-
C-**********************************************************************
C-
C-TEST OF SPVARI.
      Q=100*SPVARI(XF,10)
      CALL SPOUT('SPVARI ',INT(2534.444-Q))
C-
C-**********************************************************************
C-
C-TEST OF SPWLSH.
      Q=0.
      DO 1460 K=0,255
       Q=Q-0.1*K*K*SPWLSH(4,K/16,MOD(K,16))
 1460 CONTINUE
      CALL SPOUT('SPWLSH ',INT(1254.402-Q))
C-
C-**********************************************************************
C-
C-TEST OF SPWNDO.
      Q=0.
      DO 1410 I=1,6
       Q=Q+1000.*SPWNDO(I,64,23)
 1410 CONTINUE
      CALL SPOUT('SPWNDO ',INT(5146.273-Q))
C-
C-**********************************************************************
C-
C-TEST OF SPXEXP.
      DO 1270 K=0,4
       X(K)=XC(K)
       Y(K)=YC(K)
 1270 CONTINUE
      CALL SPXEXP(X,Y,5,C0,C1,IE)
      Q=-10000*C0+955*C1
      CALL SPOUT('SPXEXP ',INT(1491.007-Q))
C-
C-**********************************************************************
C-
C-TEST OF SPZINT.
      DO 1030 K=0,9
       X(K)=(K+1)**2
 1030 CONTINUE
      CALL SPZINT(X,99,9,1./4.,LX2,IE)
      Q=IE+LX2
      DO 1031 K=0,LX2
       Q=Q+0.1*K*X(K)
 1031 CONTINUE
      CALL SPOUT('SPZINT ',INT(3775.586-Q))
C-
C-**********************************************************************
C-
C-FIXED DATA CHECK SUM:
      S2=XF(5)+XF(6)+XF(7)+XF(8)+XF(9)
      DO 21 K=0,4
       DO 20 I=0,4
        S2=S2+U(I,K)
        IF((I+1)/2.EQ.1 .AND. K.GE.1) S2=S2+A(K,I)
        IF((I+1)/2.EQ.1) S2=S2+B(K,I)
   20  CONTINUE
       S2=S2+C(K)+D(K)+NU(K)+XC(K)+YC(K)+V(K)
       IF(K.LE.3) S2=S2+KA(K)
   21 CONTINUE
      CALL SPOUT('CHEKSUM',INT(100.*(S2-S1)))
      END
C-
      SUBROUTINE SPOUT(NAME,I)
      CHARACTER NAME*7
      IF(I.EQ.0) PRINT '(1X,A7,'' PASSED.'')', NAME
      IF(I.NE.0) PRINT '(1X,A7,'' FAILED. !!!'')', NAME
      RETURN
      END
