       01  MAPPGMI.
           02  FILLER PIC X(12).
           02  ACCTL    COMP  PIC  S9(4).
           02  ACCTF    PICTURE X.
           02  FILLER REDEFINES ACCTF.
             03 ACCTA    PICTURE X.
           02  FILLER   PICTURE X(2).
           02  ACCTI  PIC X(12).
           02  NAMEL    COMP  PIC  S9(4).
           02  NAMEF    PICTURE X.
           02  FILLER REDEFINES NAMEF.
             03 NAMEA    PICTURE X.
           02  FILLER   PICTURE X(2).
           02  NAMEI  PIC X(20).
           02  IDL    COMP  PIC  S9(4).
           02  IDF    PICTURE X.
           02  FILLER REDEFINES IDF.
             03 IDA    PICTURE X.
           02  FILLER   PICTURE X(2).
           02  IDI  PIC X(7).
           02  CDATEL    COMP  PIC  S9(4).
           02  CDATEF    PICTURE X.
           02  FILLER REDEFINES CDATEF.
             03 CDATEA    PICTURE X.
           02  FILLER   PICTURE X(2).
           02  CDATEI  PIC X(10).
           02  CTIMEL    COMP  PIC  S9(4).
           02  CTIMEF    PICTURE X.
           02  FILLER REDEFINES CTIMEF.
             03 CTIMEA    PICTURE X.
           02  FILLER   PICTURE X(2).
           02  CTIMEI  PIC X(10).
           02  MSGL    COMP  PIC  S9(4).
           02  MSGF    PICTURE X.
           02  FILLER REDEFINES MSGF.
             03 MSGA    PICTURE X.
           02  FILLER   PICTURE X(2).
           02  MSGI  PIC X(45).
       01  MAPPGMO REDEFINES MAPPGMI.
           02  FILLER PIC X(12).
           02  FILLER PICTURE X(3).
           02  ACCTC    PICTURE X.
           02  ACCTH    PICTURE X.
           02  ACCTO  PIC X(12).
           02  FILLER PICTURE X(3).
           02  NAMEC    PICTURE X.
           02  NAMEH    PICTURE X.
           02  NAMEO  PIC X(20).
           02  FILLER PICTURE X(3).
           02  IDC    PICTURE X.
           02  IDH    PICTURE X.
           02  IDO  PIC X(7).
           02  FILLER PICTURE X(3).
           02  CDATEC    PICTURE X.
           02  CDATEH    PICTURE X.
           02  CDATEO  PIC X(10).
           02  FILLER PICTURE X(3).
           02  CTIMEC    PICTURE X.
           02  CTIMEH    PICTURE X.
           02  CTIMEO  PIC X(10).
           02  FILLER PICTURE X(3).
           02  MSGC    PICTURE X.
           02  MSGH    PICTURE X.
           02  MSGO  PIC X(45).