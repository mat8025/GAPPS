C-*********************************************************************
C-                             SPPLOT                                 *
C-       Plot File Routines for SIGNAL PROCESSING ALGORITHMS.         *
C-*********************************************************************
C-
C-LATEST DATE:  06/05/91.
C-
      SUBROUTINE PFILE1(X,Y,N,NP,NAME)
C-LATEST DATE: 06/05/91
C-CREATES THE XY PLOT FILE "NAME.DAT" FOR SUBSEQUENT PLOTTING.
C-INPUTS:  X(0:N-1)    = ABSCISSA VALUES X(0) THRU X(N-1).
C-         Y(0:N-1,NP) = ORDINATE VALUES Y(0) THRU Y(N-1) FOR NP CURVES.
C-         N           = NUMBER OF (X,Y) POINTS ON EACH CURVE.
C-         NP          = NUMBER OF SEPARATE CURVES, FROM 1 THRU 6.
C-         NAME        = NAME OF FILE -- 6 CHARACTERS.
C-THE KTH RECORD OF THE "NAME.DAT" FILE HAS FORMAT (NP+1)2E15.7, AND
C-CONTENTS X(K),Y(K,1),Y(K,2),...,Y(K,NP).  THUS, WITH NP=1, THE FILE 
C-HAS JUST ONE (X,Y) PAIR PER RECORD.
C-
      REAL X(0:N-1),Y(0:N-1,NP)
      CHARACTER NAME*6,FULNAM*10
      DATA FULNAM/'      .DAT'/
      FULNAM(1:6)=NAME
      OPEN(UNIT=1,FILE=FULNAM,STATUS='NEW')
      WRITE(1,'(2I6)') N,NP
      DO 1 K=0,N-1
    1  WRITE(1,'(7E15.7)') X(K),(Y(K,I),I=1,NP)
      CLOSE(1)
      RETURN
      END
C-
      SUBROUTINE PFILE2(X0,DX,Y,N,NP,NAME)
C-LATEST DATE: 06/05/91
C-CREATES THE XY PLOT FILE "NAME.DAT" FOR SUBSEQUENT PLOTTING.
C-INPUTS:  X0          = STARTING ABSCISSA VALUE, X(0)
C-         DX          = X INCREMENT, X(K)-X(K-1)
C-         Y(0:N-1,NP) = ORDINATE VALUES Y(0) THRU Y(N-1) FOR NP CURVES.
C-         N           = NUMBER OF (X,Y) POINTS ON EACH CURVE.
C-         NP          = NUMBER OF SEPARATE CURVES, FROM 1 THRU 6.
C-         NAME        = NAME OF FILE -- 6 CHARACTERS.
C-THE KTH RECORD OF THE "NAME.DAT" FILE HAS FORMAT (NP+1)2E15.7, AND
C-CONTENTS X(K),Y(K,1),Y(K,2),...,Y(K,NP).  THUS, WITH NP=1, THE FILE 
C-HAS JUST ONE (X,Y) PAIR PER RECORD.
C-
      REAL Y(0:N-1,NP)
      CHARACTER NAME*6,FULNAM*10
      DATA FULNAM/'      .DAT'/
      FULNAM(1:6)=NAME
      OPEN(UNIT=1,FILE=FULNAM,STATUS='NEW')
      WRITE(1,'(2I6)') N,NP
      DO 1 K=0,N-1
    1  WRITE(1,'(7E15.7)') X0+K*DX,(Y(K,I),I=1,NP)
      CLOSE(1)
      RETURN
      END
