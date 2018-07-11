
--SELECT USER
--FROM DUAL;
--==>> GAJA

--INDEX
--�� FUNCTION  ������� ��ȯ - ����
--�� PROCEDURE ����, ���ó������ - �ÿ�
--�� PROCEDURE ȸ��Ż��ó�� - ����
--�� TRIGGER   ȸ��Ż��ó��(�Ⱦ�) - ����
--�� PROCEDURE [��üȸ���˸�] ȸ������ -����
--�� PROCEDURE [��üȸ���˸�] ������ ���ǰ���
--�� PROCEDURE [��üȸ���˸�] �����ڰ� ���� �˸�
--�� PROCEDURE [ȣ��Ʈ�˸�] �� ���� �űԵ��
--�� PROCEDURE [ȣ��Ʈ�˸�] �� ���� �űԿ�����
--�� PROCEDURE [ȣ��Ʈ�˸�] �� ���� �������
--�� PROCEDURE [ȣ��Ʈ�˸�] �� ���� ���� ����
--�� PROCEDURE [ȣ��Ʈ�˸�] �� ���� ���� ����
--�� PROCEDURE [ȣ��Ʈ�˸�] �� ���� �ı� ����
--�� PROCEDURE [ȣ��Ʈ�˸�] �� ���� ����� ����
--�� PROCEDURE [�Խ�Ʈ�˸�] ���ҿ��� ����
--�� PROCEDURE [�Խ�Ʈ�˸�] �����ı� ����
--�� PROCEDURE [�Խ�Ʈ�˸�] ���ҹ��� ����

------------------------------------------------------------------------------------------------------------------
--                                      �� FUNCTION - ������� ��ȯ
------------------------------------------------------------------------------------------------------------------
-- ������� : (������/�̿�Ϸ�/���ڿϷ�/�Խ�Ʈ���/ȣ��Ʈ���/���������)
--�� ������� ��ȯ �Լ� ����(FN_BSTATE)
CREATE OR REPLACE FUNCTION FN_BSTATE (F_BCODE NUMBER) --�����ڵ�
RETURN VARCHAR2
IS
    --�ֿ亯������
    V_RESULT    VARCHAR2(15);
    V_HMEMCODE  NUMBER; --�ش���� ȣ��Ʈ�ڵ�
    V_GMEMCODE  NUMBER; --�ش���� �Խ�Ʈ�ڵ�
    V_BYMEMCODE NUMBER; --��ҽ�û ȸ���ڵ�
    V_CHECKOUT    DATE; -- üũ�ƿ���¥
    UCOUNT      NUMBER; -- �̿볻�� ���ڵ� ��
    CCOUNT      NUMBER; -- ��ҽ�û ���ڵ� ��
    BYMCOUNT    NUMBER; -- ȸ����� ���ڵ� ��
    BYACOUNT    NUMBER; -- ��������� ���ڵ� ��
    
BEGIN
    -- �̿볻�� ���ڵ� �� ���
    SELECT COUNT(*)
    INTO UCOUNT
    FROM TBL_USEDLIST
    WHERE BCODE=F_BCODE;
    
    -- üũ�ƿ���¥ ���
    SELECT CHECKOUTDATE
    INTO V_CHECKOUT
    FROM TBL_BOOKING
    WHERE BCODE=F_BCODE;
    
    -- ��ҽ�û ���ڵ� �� ���
    SELECT COUNT(*)
    INTO CCOUNT
    FROM TBL_CANCEL
    WHERE BCODE=F_BCODE;
    
    -- ȸ����� ���ڵ� �� ���
    SELECT COUNT(*)
    INTO BYMCOUNT
    FROM  TBL_BYMEMBER BM LEFT JOIN TBL_CANCEL C
      ON BM.CANCELCODE = C.CANCELCODE
    WHERE BCODE=F_BCODE;
    
    -- ȸ����� ���̵� �޾ƿ���
    SELECT HMEMCODE, GMEMCODE, BYMEMBERCODE
    INTO V_HMEMCODE, V_GMEMCODE, V_BYMEMCODE
    FROM VIEW_BOOKING
    WHERE BCODE=5;
    
    -- ��������� ���ڵ� �� ���
    SELECT COUNT(*)
    INTO BYACOUNT
    FROM TBL_BYADMIN BA LEFT JOIN TBL_CANCEL C
      ON BA.CANCELCODE = C.CANCELCODE
    WHERE C.BCODE = F_BCODE;
    
    -- COUNT ���� ���� ó������ ���ϱ�
    IF (UCOUNT=0 AND CCOUNT=0 AND V_CHECKOUT > SYSDATE) --�̿볻��, ��ҳ����� ���� ���
        THEN V_RESULT := '������';
    ELSIF ( UCOUNT=1 )       -- �̿볻���� ���� ��� �̿�Ϸ�
        THEN V_RESULT := '�̿�Ϸ�';
    ELSIF ( CCOUNT=1 AND BYMCOUNT=0 AND BYACOUNT=0 ) -- ��ҽ�û�� ������ ó���Ϸ����� ��
        THEN V_RESULT := '���ó����';
    ELSIF ( BYACOUNT=1 ) -- �����ڿ� ���� ����� ���
        THEN V_RESULT := '���������';
    ELSIF ( V_BYMEMCODE IS NOT NULL AND V_HMEMCODE = V_BYMEMCODE )
        THEN V_RESULT := 'ȣ��Ʈ���';
    ELSIF ( V_BYMEMCODE IS NOT NULL AND V_GMEMCODE = V_BYMEMCODE )
        THEN V_RESULT := '�Խ�Ʈ���';
    ELSIF ( UCOUNT=0 AND V_CHECKOUT <= SYSDATE )
        THEN V_RESULT := '���ڿϷ�';
        ELSE
            V_RESULT := '�����߻�';
        END IF;
    RETURN V_RESULT;

END;



------------------------------------------------------------------------------------------------------------------
--                                     �� PROCEDURE - ����, ���ó������
------------------------------------------------------------------------------------------------------------------

-- ���ҹ��� ��������� �� ���̺�
CREATE OR REPLACE VIEW VIEW_QSTDEL
AS
SELECT RQST.RQSTCODE"RQSTCODE", RQST.RCODE"RCODE", HRQST.RQSTCODE"HRQSTCODE"
FROM TBL_ROOMQUESTION RQST LEFT JOIN TBL_RQSTANSWER RQSTA
ON RQST.RQSTCODE = RQSTA.RQSTCODE LEFT JOIN TBL_HIDEROOMQUESTION HRQST
ON RQST.RQSTCODE = HRQST.RQSTCODE;

-- ������������� �� ���̺�
CREATE OR REPLACE VIEW VIEW_VERDEL
AS
SELECT REQVER.RCODE"RCODE", REQVER.REQVCODE"REQVCODE", VER.VCODE"VCODE", VERR.VRCODE"VRCODE"
FROM TBL_REQVERIFICATION REQVER LEFT JOIN TBL_VERIFICATION VER
ON REQVER.REQVCODE = VER.REQVCODE LEFT JOIN TBL_VERIFICATIONRESULT VERR
ON VER.VCODE =VERR.VCODE;

-- �ı���������� �� ���̺�   
CREATE OR REPLACE VIEW VIEW_REVDEL
AS
SELECT E.REVANSCODE"REVANSCODE", E.RCODE"RCODE", E.REVTITLE"REVTITLE", E.REVCONTENT"REVCONTENT", E.MEMCODE"MEMCODE", E.REGDATE"REGDATE"
     , E.HCODE"HCODE", (SELECT MEMETIQUETTE FROM TBL_MEMBER WHERE MEMCODE = E.MEMCODE)"GMEMETIQUETTE"
     , (SELECT MEMID FROM TBL_MEMBER WHERE MEMCODE = E.HCODE)"HID", E.HIDEREVCODE"HIDEREVCODE", E.REVANSDATE"REVANSDATE", E.REVANS"REVANS"
     , E.HIDECAUSE"HIDECAUSE", E.HIDEDATE"HIDEDATE", E.ADMINCODE"ADMINCODE", E.ADMINID"ADMINID"
     , E.ADMINNAME"ADMINNAME", E.REALCHECKINDATE"REALCHECKINDATE", E.REALCHECKOUTDATE"REALCHECKOUTDATE", E.ULISTREGDATE"ULISTREGDATE"
     , E.CHECKINDATE"CHECKINDATE", E.CHECKOUTDATE"CHECKOUTDATE"
     , (SELECT MEMID FROM TBL_MEMBER WHERE MEMCODE = E.MEMCODE)"GID", E.REVIMGCODE"REVIMGCODE", E.REVCODE"REVCODE", E.REVIMG"REVIMG"
FROM
(
SELECT RVA.REVANSCODE"REVANSCODE", RMC.RCODE"RCODE", RV.REVTITLE"REVTITLE", RV.REVCONTENT"REVCONTENT", BK.MEMCODE"MEMCODE", RV.REGDATE"REGDATE", RMC.MEMCODE"HCODE"
     , HRV.HIDEREVCODE"HIDEREVCODE", RVA.REVANSDATE"REVANSDATE", RVA.REVANS"REVANS", HRV.HIDECAUSE"HIDECAUSE", HRV.HIDEDATE"HIDEDATE", AD.ADMINCODE"ADMINCODE", AD.ADMINID"ADMINID"
     , AD.ADMINNAME"ADMINNAME", UL.REALCHECKINDATE"REALCHECKINDATE", UL.REALCHECKOUTDATE"REALCHECKOUTDATE", UL.ULISTREGDATE"ULISTREGDATE"
     , BK.CHECKINDATE"CHECKINDATE", BK.CHECKOUTDATE"CHECKOUTDATE", RVIMG.REVIMGCODE"REVIMGCODE", RV.REVCODE"REVCODE", RVIMG.REVIMG"REVIMG"
FROM TBL_REVIEW RV LEFT JOIN TBL_REVIEWANSWER RVA
  ON RV.REVCODE = RVA.REVCODE LEFT JOIN TBL_HIDEREVIEW HRV
  ON RV.REVCODE = HRV.REVCODE LEFT JOIN TBL_ADMIN AD
  ON HRV.ADMINCODE = AD.ADMINCODE LEFT JOIN TBL_USEDLIST UL
  ON RV.ULISTCODE = UL.ULISTCODE LEFT JOIN TBL_BOOKING BK
  ON UL.BCODE = BK.BCODE LEFT JOIN TBL_BOOKABLEDATE BAD
  ON BK.BADATECODE = BAD.BADATECODE LEFT JOIN TBL_ROOMCODE RMC
  ON BAD.RCODE = RMC.RCODE LEFT JOIN TBL_MEMBERCODE MEMC
  ON RMC.MEMCODE = MEMC.MEMCODE LEFT JOIN TBL_MEMBER MEM
  ON MEMC.MEMCODE = MEM.MEMCODE LEFT JOIN TBL_REVIEWIMAGE RVIMG
  ON RV.REVCODE = RVIMG.REVCODE
) E;



CREATE OR REPLACE PROCEDURE PROC_DELROOM (P_RCODE IN TBL_ROOMCODE.RCODE%TYPE) 
IS
    V_TEMP        NUMBER; 
    V_NUM1         NUMBER   :=1; --���ҹ��Ǵ�� ���� ����
    V_NUM2         NUMBER   :=1; --���ҹ��Ǽ������
    V_NUM3         NUMBER   :=1; --����ó������ ����
    V_NUM4         NUMBER   :=1; --  �����̷� ����
    V_NUM5         NUMBER   :=1; -- �ı� �̹������� ����
    V_NUM6         NUMBER   :=1; -- �����ı�����
    V_NUM7         NUMBER   :=1; --�ı�亯 ����
    V_NUM8         NUMBER   :=1; -- �ı� ����
BEGIN    

    --���ǻ��� ���� ����
    DELETE
    FROM TBL_ROOMCONVENIENCE
    WHERE RCODE = P_RCODE;
   
    
    --���ѻ��� ���� ����
    DELETE 
    FROM TBL_ROOMCONSTRAINT
    WHERE RCODE = P_RCODE;
    
    
    --�򳻿� ���� ����
    DELETE
    FROM TBL_LIKE
    WHERE RCODE = P_RCODE;
    
    --���ҹ��Ǵ�� ���� ����
    SELECT MAX(RQSTCODE) INTO V_TEMP
    FROM TBL_ROOMQUESTION;
    
    
    LOOP
        DELETE
        FROM TBL_RQSTANSWER
        WHERE RQSTCODE = (SELECT RQSTCODE
                          FROM VIEW_QSTDEL
                          WHERE RCODE = P_RCODE AND RQSTCODE=V_NUM1);
        EXIT WHEN V_NUM1 >= V_TEMP;
        V_NUM1 := V_NUM1 +1; 
    END LOOP;
    
    --���ҹ��Ǽ������
    SELECT MAX(RQSTCODE) INTO V_TEMP 
    FROM TBL_ROOMQUESTION;
    
    
    LOOP
        DELETE
        FROM TBL_HIDEROOMQUESTION
        WHERE RQSTCODE = (SELECT HRQSTCODE
                          FROM VIEW_QSTDEL
                          WHERE RCODE =P_RCODE AND RQSTCODE=V_NUM2);
        --RCODE�� RQSTCODE�� ?�� ���� ���� ��
        EXIT WHEN V_NUM2 >= V_TEMP;
        V_NUM2 := V_NUM2 +1; 
    END LOOP;
    
    --���ҹ��ǻ�������
    DELETE
    FROM TBL_ROOMQUESTION
    WHERE RCODE = P_RCODE;
    
    --����ó������ ����
    SELECT MAX(VRCODE) INTO V_TEMP
    FROM TBL_VERIFICATIONRESULT;
    
    LOOP
        DELETE
        FROM TBL_VERIFICATIONRESULT
        WHERE VCODE = ( SELECT VCODE
                        FROM VIEW_VERDEL
                        WHERE RCODE = P_RCODE AND VRCODE =V_NUM3 
                      );
        EXIT WHEN V_NUM3 >= V_TEMP;
        V_NUM3 := V_NUM3 +1;
    END LOOP;
    
    
    --  �����̷� ����
    SELECT MAX(VCODE) INTO V_TEMP
    FROM TBL_VERIFICATION;
    
    LOOP
        DELETE
        FROM TBL_VERIFICATION
        WHERE REQVCODE = ( SELECT REQVCODE
                           FROM VIEW_VERDEL
                           WHERE RCODE = P_RCODE AND VCODE = V_NUM4 
                         );
        EXIT WHEN V_NUM4 >= V_TEMP;                  
        V_NUM4 := V_NUM4 +1;
    END LOOP;
    
    
    -- ������û ����
    DELETE
    FROM TBL_REQVERIFICATION
    WHERE RCODE = P_RCODE;
   
    -- �ı� �̹������� ����
    SELECT MAX(REVIMGCODE) INTO V_TEMP
    FROM TBL_REVIEWIMAGE;
    
    LOOP
        DELETE
        FROM TBL_REVIEWIMAGE
        WHERE REVCODE = ( SELECT REVCODE
                         FROM VIEW_REVDEL
                         WHERE RCODE =P_RCODE AND REVIMGCODE =V_NUM5
                       );
                       
        EXIT WHEN V_NUM5 >= V_TEMP;
        V_NUM5 := V_NUM5 +1;

    END LOOP;        
    
    -- �����ı�����
    SELECT MAX(HIDEREVCODE) INTO V_TEMP
    FROM TBL_HIDEREVIEW;
    
    LOOP
        DELETE
        FROM TBL_HIDEREVIEW
        WHERE REVCODE = ( SELECT REVCODE
                          FROM VIEW_REVDEL
                          WHERE RCODE =P_RCODE AND HIDEREVCODE = V_NUM6
                        );
        EXIT WHEN V_NUM6 >= V_TEMP;
        V_NUM6 := V_NUM6 +1;                
    END LOOP;
    
    --�ı�亯 ����
    SELECT MAX(REVANSCODE) INTO V_TEMP
    FROM TBL_REVIEWANSWER;
    
    LOOP
        DELETE
        FROM TBL_REVIEWANSWER
        WHERE REVCODE = ( SELECT REVCODE
                          FROM VIEW_REVDEL
                          WHERE RCODE =P_RCODE AND REVANSCODE = V_NUM7
                        );
        EXIT WHEN V_NUM7 >= V_TEMP;
        V_NUM7 := V_NUM7 +1;  

    END LOOP;
    -- �ı� ����
    SELECT MAX(REVCODE) INTO V_TEMP
    FROM TBL_REVIEW;
    
     LOOP
        DELETE
        FROM TBL_REVIEW
        WHERE REVCODE = ( SELECT REVCODE
                          FROM VIEW_REVDEL
                          WHERE RCODE =P_RCODE AND REVCODE = V_NUM8
                        );
        EXIT WHEN V_NUM8 >= V_TEMP;
        V_NUM8 := V_NUM8 +1;  
     END LOOP;  
     
    --���һ��� ����
    DELETE
    FROM TBL_ROOM
    WHERE RCODE = P_RCODE;
    
    -- Ŀ��
    COMMIT;
 
END;

EXECUTE PROC_DELROOM(3);

ROLLBACK;
------------------------------------------------------------------------------------------------------------------
--                                        �� PROCEDURE - ȸ��Ż��ó��
------------------------------------------------------------------------------------------------------------------
--DROP PROCEDURE PRO_LEAVEMEMBER;
--DROP PROCEDURE P_LEAVEMEMBER;

--�� ȸ��Ż�� PROCEDURE (PROC_LEAVEMEMBER)
CREATE OR REPLACE PROCEDURE PROC_LEAVEMEMBER (P_MEMCODE IN TBL_MEMBER.MEMCODE%TYPE) --Ż���û�� ȸ���ڵ�
IS
    --Ż���û�� ȸ���� ���� ���ڵ� ����
    V_MEMCODE       TBL_MEMBER.MEMCODE%TYPE;
    V_MEMID         TBL_MEMBER.MEMID%TYPE;
    V_MEMPW         TBL_MEMBER.MEMPW%TYPE;
    V_MEMNAME       TBL_MEMBER.MEMNAME%TYPE;
    V_MEMSSN        TBL_MEMBER.MEMSSN%TYPE;
    V_MEMTEL        TBL_MEMBER.MEMTEL%TYPE;
    V_MEMEMAIL      TBL_MEMBER.MEMEMAIL%TYPE;
    V_MEMETIQUETTE  TBL_MEMBER.MEMETIQUETTE%TYPE;
    V_MEMPROFILE    TBL_MEMBER.MEMPROFILE%TYPE;
    V_MEMJOINDATE   TBL_MEMBER.MEMJOINDATE%TYPE;

BEGIN
    --���� ȸ�� ���̺� ���� ������ ���
    SELECT MEMCODE, MEMID, MEMPW, MEMNAME, MEMSSN, MEMTEL, MEMEMAIL
         , MEMETIQUETTE, MEMPROFILE, MEMJOINDATE
    INTO V_MEMCODE, V_MEMID, V_MEMPW, V_MEMNAME, V_MEMSSN, V_MEMTEL, V_MEMEMAIL
         , V_MEMETIQUETTE, V_MEMPROFILE, V_MEMJOINDATE
    FROM TBL_MEMBER
    WHERE MEMCODE=P_MEMCODE;

    --Ż�� ȸ�� ���̺� �Է� ����
    INSERT INTO TBL_LEAVEMEMBER(LMEMCODE, MEMCODE, LMEMID, LMEMPW, LMEMNAME, LMEMSSN, LMEMTEL
           , LMEMEMAIL, LMEMETIQUETTE, LMEMPROFILE, LMEMJOINDATE, LDATE)
    VALUES(SEQLEAVEMEMBER.NEXTVAL, V_MEMCODE, V_MEMID, V_MEMPW, V_MEMNAME, V_MEMSSN, V_MEMTEL
           , V_MEMEMAIL, V_MEMETIQUETTE, V_MEMPROFILE, V_MEMJOINDATE, SYSDATE);

    --���� ����
    DELETE
    FROM TBL_MEMBER
    WHERE MEMCODE = P_MEMCODE;
    
    --Ŀ��
    COMMIT;
END;
--�� ȸ�� Ż�� ó�� ������ ���¹�
--EXECUTE FN_LEAVEMEMBER(7);

