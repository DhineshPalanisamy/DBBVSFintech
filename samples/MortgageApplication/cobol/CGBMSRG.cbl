       IDENTIFICATION DIVISION.
       PROGRAM-ID. CGBMSRG.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
	          COPY DFHAID.
	          COPY CBSMAP.
	      01 WS-COMMAREA PIC X(100).
        01 WS-ACCOUNT-NO-T PIC S9(18).
        01 WS-ACCOUNT-NAME PIC X(50).
        01 WS-PRINT PIC X(21) VALUE 'IS ALREADY REGISTERED'.
        01 WS-ACCOUNT-NAME1 PIC X(50).
        01 WS-PRINT1 PIC X(23) VALUE 'REGISTERED SUCCESSF'.
        01 WS-ACCOUNT-STATUS  PIC X(10).
        01 WS-MESSAGE PIC X(100).
        01 WS-MESSAGE1 PIC X(100).
        77 WS-ABS-DATE    PIC S9(10) COMP-3.
        01 WS-DATE.
           05 WS-MONTH   PIC 99.
           05 FILLER     PIC X(01).
           05 WS-DAY     PIC 99.
           05 FILLER     PIC X(01).
           05 WS-YEAR    PIC 99.
        01 WS-TIME.
           05 WS-HOUR    PIC 99.
           05 FILLER     PIC X(01).
           05 WS-MIN     PIC 99.
           05 FILLER     PIC X(01).
           05 WS-SEC     PIC 99.
           EXEC SQL
           INCLUDE CBSMST
           END-EXEC.
           EXEC SQL
           INCLUDE SQLCA
           END-EXEC.
       LINKAGE SECTION.
        01 DFHCOMMAREA PIC X(100).
	      PROCEDURE DIVISION.
	      MAIN-PARA.
	           PERFORM EIB-PARA THRU EIB-EXIT.
			   *     MOVE LOW-VALUES TO DCLCBS-ACCT-MSTR-DTL.
			         STOP RUN.
	      EIB-PARA.
	          IF EIBCALEN = 0
		            PERFORM INIT-PARA THRU INIT-EXIT
           ELSE
             MOVE DFHCOMMAREA TO WS-COMMAREA
             EVALUATE WS-COMMAREA
             WHEN 'CREG'
                PERFORM KEY-VALID THRU KEY-VALID-EXIT
             WHEN OTHER
                MOVE LOW-VALUES TO MAPPGMO
                MOVE 'EXIT' TO MSGO
             END-EVALUATE
           END-IF.
       EIB-EXIT.
           EXIT.
       INIT-PARA.
           MOVE LOW-VALUES TO MAPPGMO
           PERFORM DATE-TIME THRU DATE-TIME-EXIT
           MOVE WS-DATE TO CDATEO
           MOVE WS-TIME TO CTIMEO
           PERFORM SEND-MAP THRU SEND-MAP-EXIT
           MOVE 'CREG' TO WS-COMMAREA
           PERFORM RETURN-CICS THRU RETURN-CICS-EXIT.
       INIT-EXIT.
           EXIT.
       DATE-TIME.
             EXEC CICS ASKTIME ABSTIME(WS-ABS-DATE)
             END-EXEC.
             EXEC CICS FORMATTIME ABSTIME(WS-ABS-DATE)
             DDMMYY(WS-DATE)
             DATESEP('-')
             TIME(WS-TIME)
             TIMESEP(':')
             END-EXEC.
       DATE-TIME-EXIT.
             EXIT.
       SEND-MAP.
             EXEC CICS
             SEND MAP('MAPPGM') MAPSET('CBSMAP')
             FROM(MAPPGMO)
             ERASE
      *      FREEKB
      *      RESP(WS-CICS-RESP)
             END-EXEC.
      *      PERFORM CICS-RESP THRU CICS-RESP-EXIT.
       SEND-MAP-EXIT.
             EXIT.
       RETURN-CICS.
             EXEC CICS
             RETURN TRANSID('ZC66')
             COMMAREA(WS-COMMAREA)
             END-EXEC.
       RETURN-CICS-EXIT.
             EXIT.
       KEY-VALID.
             EVALUATE EIBAID
             WHEN DFHENTER
               MOVE LOW-VALUES TO MAPPGMO
               PERFORM RECEIVE-PARA THRU RECEIVE-PARA-EXIT
               PERFORM VALIDATION-PARA THRU VALIDATION-EXIT
               PERFORM PROCESS-PARA THRU PROCESS-PARA-EXIT
               PERFORM DATE-TIME THRU DATE-TIME-EXIT
               MOVE WS-DATE TO CDATEO
               MOVE WS-TIME TO CTIMEO
               PERFORM SEND-MAP THRU SEND-MAP-EXIT
               PERFORM RETURN-CICS THRU RETURN-CICS-EXIT
             WHEN DFHPF3
               EXEC CICS
                    SEND CONTROL FREEKB ERASE
               END-EXEC
               EXEC CICS
                    RETURN
               END-EXEC
             WHEN OTHER
                MOVE LOW-VALUES TO MAPPGMO
                MOVE 'INVALID OPTION' TO MSGO
                PERFORM SEND-ERROR-MSG THRU SEND-ERROR-EXIT
             END-EVALUATE.
       KEY-VALID-EXIT.
             EXIT.
       RECEIVE-PARA.
             EXEC CICS
             RECEIVE MAP('MAPPGM') MAPSET('CBSMAP')
             INTO (MAPPGMI)
             END-EXEC.
       RECEIVE-PARA-EXIT.
             EXIT.
       SEND-ERROR-MSG.
             PERFORM DATE-TIME THRU DATE-TIME-EXIT
             MOVE WS-DATE TO CDATEO
             MOVE WS-TIME TO CTIMEO
             PERFORM SEND-MAP THRU SEND-MAP-EXIT
             PERFORM RETURN-CICS THRU RETURN-CICS-EXIT.
       SEND-ERROR-EXIT.
            EXIT.
       VALIDATION-PARA.
	            PERFORM ACCT-NUMER.
	      VALIDATION-EXIT.
	           EXIT.
	      ACCT-NUMER.
	           IF ACCTI EQUAL TO LOW-VALUES OR
			            ACCTI EQUAL TO SPACES
            MOVE LOW-VALUES TO MAPPGMO
            MOVE 'ACCOUNT SHOULD NOT BE BLANK' TO MSGO
            PERFORM SEND-ERROR-MSG THRU SEND-ERROR-EXIT
            END-IF.
            IF ACCTI IS ALPHABETIC
             MOVE LOW-VALUES TO MAPPGMO
             MOVE 'ACCOUNT SHOULD NOT BE ALPHABETIC' TO MSGO
             PERFORM SEND-ERROR-MSG THRU SEND-ERROR-EXIT
            END-IF.
            EXIT.
       PROCESS-PARA.
	            MOVE ACCTI TO WS-ACCOUNT-NO-T.
      *    MOVE SPACE TO CUSTOMER-NAME.
      *      COMPUTE IDI = 0.
             MOVE LOW-VALUES TO IDI
             COMPUTE H1-ACCOUNT-NUMBER = WS-ACCOUNT-NO-T
             DISPLAY "ACCT NO. FROM INPUT" H1-ACCOUNT-NUMBER
             EXEC SQL
		              SELECT * INTO :DCLCBS-ACCT-MSTR-DTL
		              FROM CBS_ACCT_MSTR_DTL
		              WHERE ACCOUNT_NUMBER=:H1-ACCOUNT-NUMBER
		           END-EXEC
		           MOVE LOW-VALUES TO WS-MESSAGE
             MOVE H1-ACCOUNT-NAME TO WS-ACCOUNT-NAME
           STRING WS-ACCOUNT-NAME DELIMITED BY SPACE
                  ' ' DELIMITED BY SIZE
                  WS-PRINT DELIMITED BY SIZE
            INTO WS-MESSAGE
           MOVE LOW-VALUES TO WS-MESSAGE1
           MOVE H1-ACCOUNT-NAME TO WS-ACCOUNT-NAME1
           STRING WS-ACCOUNT-NAME1 DELIMITED BY SPACE
                  ' ' DELIMITED BY SIZE
                  WS-PRINT1 DELIMITED BY SIZE
            INTO WS-MESSAGE1
           DISPLAY "MESS" WS-MESSAGE
           DISPLAY "NAME" WS-ACCOUNT-NAME
           DISPLAY "SQLCODE:" SQLCODE
           EVALUATE SQLCODE
            WHEN 0
             DISPLAY H1-ACCOUNT-NUMBER
             DISPLAY H1-UPD-USERID
             DISPLAY H1-ACCOUNT-STATUS
             DISPLAY H1-CUSTOMER-ID
             DISPLAY H1-PRODUCT-CODE
             DISPLAY 'ACCOUNT IS AVAILABLE'
             MOVE "FETCH SUCCESS" TO MSGO
             MOVE H1-ACCOUNT-NAME TO NAMEO
      *      COMPUTE IDO = H1-CUSTOMER-ID
             MOVE H1-CUSTOMER-ID TO IDO
      *      PERFORM ACCT-STATUS THRU ACCT-STATUS-EXIT
             DISPLAY 'MESSAGES:'
            WHEN 100
             MOVE "ACCOUNT DOES NOT EXITS" TO MSGO
             DISPLAY "MESSAGES:" WS-MESSAGE
      *      EXEC CICS RETURN END-EXEC
            WHEN OTHER
             DISPLAY "SQLCODE1:" SQLCODE
             MOVE "SQL ERROR" TO MSGO
             DISPLAY "MESSAGES:" MSGO
      *      EXEC CICS RETURN END-EXEC
           END-EVALUATE.
        PROCESS-PARA-EXIT.
           EXIT.
        ACCT-STATUS.
           EXEC SQL
           SELECT
           ACCOUNT_STATUS
           INTO
           :H1-ACCOUNT-STATUS
           FROM CBS_ACCT_MSTR_DTL
           WHERE ACCOUNT_NUMBER=:H1-ACCOUNT-NUMBER
           END-EXEC.
           EVALUATE SQLCODE
            WHEN 0
             DISPLAY H1-ACCOUNT-STATUS(1:6)
             MOVE H1-ACCOUNT-STATUS TO WS-ACCOUNT-STATUS
             DISPLAY WS-ACCOUNT-STATUS
             DISPLAY 'ACCOUNT STATUS IS FETCHED'
             MOVE "FETCH DO" TO MSGO
             DISPLAY "MESSAGES:" MSGO
             PERFORM CHECK-ACCT-STATUS THRU CHECK-ACCT-STATUS-EXIT
            WHEN 100
             MOVE "NO RECORD FOUND" TO MSGO
             DISPLAY "MESSAGES:" MSGO
             EXEC CICS RETURN END-EXEC
            WHEN OTHER
             DISPLAY "SQLCODE2:" SQLCODE
             MOVE "SQL ERROR" TO MSGO
             DISPLAY "MESSAGES:" MSGO
             EXEC CICS RETURN END-EXEC
           END-EVALUATE.
        ACCT-STATUS-EXIT.
           EXIT.
        CHECK-ACCT-STATUS.
               DISPLAY 'CHECK STATUS PARA'
           EVALUATE WS-ACCOUNT-STATUS
              WHEN 'ACTIVE    '
               DISPLAY 'ALREADY REGISTERED'
               MOVE WS-MESSAGE TO MSGO
               EXEC CICS RETURN END-EXEC
              WHEN 'INACTIVE  '
               MOVE 'REGISTRATION STARTING' TO MSGO
               PERFORM REG-ACCT-STATS THRU REG-ACCT-STATS-EXIT
              WHEN 'OTHER'
               DISPLAY 'NOT Y OR N'
               MOVE 'PLEASE CONTACT BANK' TO MSGO
               EXEC CICS RETURN END-EXEC
           END-EVALUATE.
        CHECK-ACCT-STATUS-EXIT.
            EXIT.
        REG-ACCT-STATS.
           DISPLAY 'REGISTER PARA'
           EXEC SQL UPDATE CBS_ACCT_MSTR_DTL
            SET ACCOUNT_STATUS ='ACTIVE    ',
                UPD_USERID ='NAGARAJPK '
            WHERE ACCOUNT_NUMBER = :H1-ACCOUNT-NUMBER
           END-EXEC.
           DISPLAY SQLCODE
            MOVE WS-MESSAGE1 TO MSGO.
      **    MOVE "CUSTOMER REGISTERED SUCESSFULLY" TO MESSAGES.
        REG-ACCT-STATS-EXIT.
            EXIT.