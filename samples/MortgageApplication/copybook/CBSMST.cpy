      ******************************************************************
      * DCLGEN TABLE(COREBK.CBS_ACCT_MSTR_DTL)                         *
      *        LIBRARY(IBMUSER.DCLGEN.CASE(CBSMST))                    *
      *        LANGUAGE(COBOL)                                         *
      *        NAMES(H1-)                                              *
      *        QUOTE                                                   *
      *        LABEL(YES)                                              *
      *        COLSUFFIX(YES)                                          *
      *        INDVAR(YES)                                             *
      * ... IS THE DCLGEN COMMAND THAT MADE THE FOLLOWING STATEMENTS   *
      ******************************************************************
           EXEC SQL DECLARE COREBK.CBS_ACCT_MSTR_DTL TABLE
           ( ACCOUNT_NUMBER                 BIGINT NOT NULL,
             BASE_BRANCH                    CHAR(20) NOT NULL,
             ACCOUNT_NAME                   CHAR(50) NOT NULL,
             PRODUCT_CODE                   CHAR(5) NOT NULL,
             CUSTOMER_ID                    INTEGER NOT NULL,
             ACCOUNT_STATUS                 CHAR(10) NOT NULL,
             PAYMENT_LIMIT                  INTEGER NOT NULL,
             CURRENCY                       CHAR(3) NOT NULL,
             COMPLIANCE_STATUS              CHAR(5) NOT NULL,
             LAST_ACTIVITY_DATE             DATE NOT NULL,
             UPD_USERID                     CHAR(10) NOT NULL,
             UPD_TIMESTAMP                  TIMESTAMP NOT NULL
           ) END-EXEC.
      ******************************************************************
      * COBOL DECLARATION FOR TABLE COREBK.CBS_ACCT_MSTR_DTL           *
      ******************************************************************
       01  DCLCBS-ACCT-MSTR-DTL.
      *    *************************************************************
      *                       ACCOUNT_NUMBER
           10 H1-ACCOUNT-NUMBER    PIC S9(18) USAGE COMP.
      *    *************************************************************
      *                       BASE_BRANCH
           10 H1-BASE-BRANCH       PIC X(20).
      *    *************************************************************
      *                       ACCOUNT_NAME
           10 H1-ACCOUNT-NAME      PIC X(50).
      *    *************************************************************
      *                       PRODUCT_CODE
           10 H1-PRODUCT-CODE      PIC X(5).
      *    *************************************************************
      *                       CUSTOMER_ID
           10 H1-CUSTOMER-ID       PIC S9(9) USAGE COMP.
      *    *************************************************************
      *                       ACCOUNT_STATUS
           10 H1-ACCOUNT-STATUS    PIC X(10).
      *    *************************************************************
      *                       PAYMENT_LIMIT
           10 H1-PAYMENT-LIMIT     PIC S9(9) USAGE COMP.
      *    *************************************************************
      *                       CURRENCY
           10 H1-CURRENCY          PIC X(3).
      *    *************************************************************
      *                       COMPLIANCE_STATUS
           10 H1-COMPLIANCE-STATUS
              PIC X(5).
      *    *************************************************************
      *                       LAST_ACTIVITY_DATE
           10 H1-LAST-ACTIVITY-DATE
              PIC X(10).
      *    *************************************************************
      *                       UPD_USERID
           10 H1-UPD-USERID        PIC X(10).
      *    *************************************************************
      *                       UPD_TIMESTAMP
           10 H1-UPD-TIMESTAMP     PIC X(26).
      ******************************************************************
      * INDICATOR VARIABLE STRUCTURE                                   *
      ******************************************************************
       01  ICBS-ACCT-MSTR-DTL.
           10 INDSTRUC           PIC S9(4) USAGE COMP OCCURS 12 TIMES.
      ******************************************************************
      * THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 12      *
      ******************************************************************