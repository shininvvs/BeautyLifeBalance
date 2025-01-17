-- 테이블 및 제약조건 삭제
DROP TABLE TB_MEMBER CASCADE CONSTRAINTS;
DROP TABLE TB_DELIVERY CASCADE CONSTRAINTS;
DROP TABLE TB_GRADE CASCADE CONSTRAINTS;
DROP TABLE TB_NOTICE CASCADE CONSTRAINTS;
DROP TABLE TB_INQUIRY_REPLY CASCADE CONSTRAINTS;
DROP TABLE TB_INQUIRY CASCADE CONSTRAINTS;
DROP TABLE TB_FAQ CASCADE CONSTRAINTS;
DROP TABLE TB_NOTIFICATION CASCADE CONSTRAINTS;
DROP TABLE TB_PRODUCT CASCADE CONSTRAINTS;
DROP TABLE TB_ORDER CASCADE CONSTRAINTS;
DROP TABLE TB_OPTION CASCADE CONSTRAINTS;
DROP TABLE TB_STOCK CASCADE CONSTRAINTS;
DROP TABLE TB_PRODUCT_ORDER CASCADE CONSTRAINTS;
DROP TABLE TB_REVIEW CASCADE CONSTRAINTS;
DROP TABLE TB_WISH CASCADE CONSTRAINTS;
DROP TABLE TB_PRODUCT_ATTACHMENT CASCADE CONSTRAINTS;
DROP TABLE TB_POINT CASCADE CONSTRAINTS;
DROP TABLE TB_CART CASCADE CONSTRAINTS;
DROP TABLE TB_NOTICE_ATTACHMENT CASCADE CONSTRAINTS;
DROP TABLE TB_INQUIRY_ATTACHMENT CASCADE CONSTRAINTS;
DROP TABLE TB_REVIEW_ATTACHMENT CASCADE CONSTRAINTS;
DROP TABLE TB_CERT_EMAIL CASCADE CONSTRAINTS;
DROP TABLE TB_PRODUCT_BANNER CASCADE CONSTRAINTS;

-- 시퀀스 삭제 구문
DROP SEQUENCE SEQ_PROD_NO;
DROP SEQUENCE SEQ_INQUIRY_NO;
DROP SEQUENCE SEQ_INQUIRY_REPLY_NO;
DROP SEQUENCE SEQ_FAQ_NO;
DROP SEQUENCE SEQ_NOTIFICATION_NO;
DROP SEQUENCE SEQ_ORDER_NO;
DROP SEQUENCE SEQ_OPT_NO;
DROP SEQUENCE SEQ_STOCK_NO;
DROP SEQUENCE SEQ_REV_NO;
DROP SEQUENCE SEQ_PROD_ATT_NO;
DROP SEQUENCE SEQ_POINT_NO;
DROP SEQUENCE SEQ_CART_NO;
DROP SEQUENCE SEQ_NOTICE_ATT_NO;
DROP SEQUENCE SEQ_INQUIRY_ATT_NO;
DROP SEQUENCE SEQ_DELI_CODE;
DROP SEQUENCE SEQ_REV_ATT_NO;
DROP SEQUENCE SEQ_SERIAL_NO;
DROP SEQUENCE SEQ_NOTICE_NO;
DROP SEQUENCE SEQ_PROD_BANNER_NO;

-- 시퀀스 생성 구문
CREATE SEQUENCE SEQ_PROD_NO;
CREATE SEQUENCE SEQ_INQUIRY_NO;
CREATE SEQUENCE SEQ_INQUIRY_REPLY_NO;
CREATE SEQUENCE SEQ_FAQ_NO;
CREATE SEQUENCE SEQ_NOTIFICATION_NO;
CREATE SEQUENCE SEQ_ORDER_NO;
CREATE SEQUENCE SEQ_OPT_NO;
CREATE SEQUENCE SEQ_STOCK_NO;
CREATE SEQUENCE SEQ_REV_NO;
CREATE SEQUENCE SEQ_PROD_ATT_NO;
CREATE SEQUENCE SEQ_POINT_NO;
CREATE SEQUENCE SEQ_CART_NO;
CREATE SEQUENCE SEQ_NOTICE_ATT_NO;
CREATE SEQUENCE SEQ_INQUIRY_ATT_NO;
CREATE SEQUENCE SEQ_DELI_CODE;
CREATE SEQUENCE SEQ_REV_ATT_NO;
CREATE SEQUENCE SEQ_SERIAL_NO;
CREATE SEQUENCE SEQ_NOTICE_NO;
CREATE SEQUENCE SEQ_PROD_BANNER_NO;

-- TB_CERT_EMAIL 테이블 생성
CREATE TABLE TB_CERT_EMAIL (
    CERT_EMAIL VARCHAR2(100) NOT NULL,
    CERT_KEY VARCHAR2(10) NOT NULL,
    CERT_DATE DATE DEFAULT SYSDATE NOT NULL
);

COMMENT ON COLUMN TB_CERT_EMAIL.CERT_EMAIL IS '인증 이메일 주소';
COMMENT ON COLUMN TB_CERT_EMAIL.CERT_KEY IS '이메일 인증 키';
COMMENT ON COLUMN TB_CERT_EMAIL.CERT_DATE IS '인증 요청 날짜';

-- TB_GRADE 테이블 생성
CREATE TABLE TB_GRADE (
    GRADE_NAME VARCHAR2(20) DEFAULT 'BABY' NOT NULL,
    MIN_POINT NUMBER DEFAULT 0 NOT NULL,
    MAX_POINT NUMBER DEFAULT 0 NOT NULL,
    CONSTRAINT PK_TB_GRADE PRIMARY KEY (GRADE_NAME)
);

COMMENT ON COLUMN TB_GRADE.GRADE_NAME IS '회원 등급 이름';
COMMENT ON COLUMN TB_GRADE.MIN_POINT IS '최소 포인트';
COMMENT ON COLUMN TB_GRADE.MAX_POINT IS '최대 포인트';

-- TB_MEMBER 테이블 생성 (부모 테이블)
CREATE TABLE TB_MEMBER (
    MEMBER_ID VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(20) NOT NULL,
    MEMBER_PWD VARCHAR2(150) ,
    PHONE CHAR(11),
    EMAIL VARCHAR2(30),
    BIRTHDATE DATE ,
    CREATE_DATE DATE DEFAULT SYSDATE NOT NULL,
    DELETE_DATE DATE,
    STATUS CHAR(1) DEFAULT 'Y' NOT NULL,
    TOTAL_POINTS NUMBER DEFAULT 0,
    CURRENT_POINTS NUMBER DEFAULT 0,
    GRADE_NAME VARCHAR2(20) DEFAULT 'BABY' NOT NULL,
    SNS_ID VARCHAR2(20) ,
    LOGIN_TYPE VARCHAR2(20) DEFAULT 'normal', 
    CONSTRAINT PK_MEMBER PRIMARY KEY (MEMBER_ID),
    CONSTRAINT FK_GRADE_TO_MEMBER FOREIGN KEY (GRADE_NAME) REFERENCES TB_GRADE (GRADE_NAME)
);

COMMENT ON COLUMN TB_MEMBER.MEMBER_ID IS '회원아이디';
COMMENT ON COLUMN TB_MEMBER.MEMBER_NAME IS '회원의 이름';
COMMENT ON COLUMN TB_MEMBER.MEMBER_PWD IS '회원의 비밀번호';
COMMENT ON COLUMN TB_MEMBER.PHONE IS '회원의 전화번호';
COMMENT ON COLUMN TB_MEMBER.EMAIL IS '회원의 이메일';
COMMENT ON COLUMN TB_MEMBER.BIRTHDATE IS '회원의 생년월일';
COMMENT ON COLUMN TB_MEMBER.CREATE_DATE IS '회원가입일';
COMMENT ON COLUMN TB_MEMBER.DELETE_DATE IS '회원탈퇴일자';
COMMENT ON COLUMN TB_MEMBER.STATUS IS '회원 상태 (가입/탈퇴 여부)';
COMMENT ON COLUMN TB_MEMBER.TOTAL_POINTS IS '총 적립 포인트';
COMMENT ON COLUMN TB_MEMBER.CURRENT_POINTS IS '현재 보유 포인트';
COMMENT ON COLUMN TB_MEMBER.GRADE_NAME IS '회원 등급';

-- TB_PRODUCT 테이블 생성 (부모 테이블)
CREATE TABLE TB_PRODUCT (
    PROD_NO NUMBER NOT NULL,
    CATEGORY_NAME VARCHAR2(60) NOT NULL,
    SUBCATEGORY_NAME VARCHAR2(60) NOT NULL,
    PROD_NAME VARCHAR2(300) NOT NULL,
    PROD_CONTENT VARCHAR2(3900) NOT NULL,
    PROD_PRICE NUMBER DEFAULT 0 NOT NULL,
    PROD_ORIGIN VARCHAR2(1500),
    PROD_CAUTION VARCHAR2(1500),
    PROD_COUNT NUMBER DEFAULT 0 NOT NULL,
    PROD_ENROLL_DATE DATE DEFAULT SYSDATE NOT NULL,
    PROD_STATUS CHAR(1) DEFAULT 'Y' NOT NULL,
    CONSTRAINT PK_PRODUCT PRIMARY KEY (PROD_NO)
);

COMMENT ON COLUMN TB_PRODUCT.PROD_NO IS '상품번호';
COMMENT ON COLUMN TB_PRODUCT.CATEGORY_NAME IS '카테고리명';
COMMENT ON COLUMN TB_PRODUCT.SUBCATEGORY_NAME IS '서브카테고리명';
COMMENT ON COLUMN TB_PRODUCT.PROD_NAME IS '상품명';
COMMENT ON COLUMN TB_PRODUCT.PROD_CONTENT IS '상품설명';
COMMENT ON COLUMN TB_PRODUCT.PROD_PRICE IS '상품원가';
COMMENT ON COLUMN TB_PRODUCT.PROD_ORIGIN IS '주요성분';
COMMENT ON COLUMN TB_PRODUCT.PROD_CAUTION IS '주의사항';
COMMENT ON COLUMN TB_PRODUCT.PROD_COUNT IS '조회수';
COMMENT ON COLUMN TB_PRODUCT.PROD_ENROLL_DATE IS '상품등록일';
COMMENT ON COLUMN TB_PRODUCT.PROD_STATUS IS '판매여부';

-- TB_INQUIRY 테이블 생성 (부모 테이블)
CREATE TABLE TB_INQUIRY (
    INQUIRY_NO NUMBER NOT NULL,
    INQUIRY_CONTENT VARCHAR2(3000),
    INQUIRY_TYPE VARCHAR2(20),
    INQUIRY_CREATE_DATE DATE DEFAULT SYSDATE NOT NULL,
    INQUIRY_ANSWERED_YN CHAR(1) DEFAULT 'N' NOT NULL,
    INQUIRY_STATUS CHAR(1) DEFAULT 'Y' NOT NULL,
    MEMBER_ID VARCHAR2(20) NOT NULL,
    PROD_NO NUMBER,
    CONSTRAINT PK_INQUIRY PRIMARY KEY (INQUIRY_NO),
    CONSTRAINT FK_MEMBER_TO_INQUIRY FOREIGN KEY (MEMBER_ID) REFERENCES TB_MEMBER (MEMBER_ID),
    CONSTRAINT FK_PRODUCT_TO_INQUIRY FOREIGN KEY (PROD_NO) REFERENCES TB_PRODUCT (PROD_NO)
);

COMMENT ON COLUMN TB_INQUIRY.INQUIRY_NO IS '문의글 번호';
COMMENT ON COLUMN TB_INQUIRY.INQUIRY_CONTENT IS '문의 내용';
COMMENT ON COLUMN TB_INQUIRY.INQUIRY_TYPE IS '문의 유형';
COMMENT ON COLUMN TB_INQUIRY.INQUIRY_CREATE_DATE IS '문의 작성일';
COMMENT ON COLUMN TB_INQUIRY.INQUIRY_ANSWERED_YN IS '답변 완료 여부';
COMMENT ON COLUMN TB_INQUIRY.INQUIRY_STATUS IS '문의 상태값';
COMMENT ON COLUMN TB_INQUIRY.MEMBER_ID IS '회원 아이디';
COMMENT ON COLUMN TB_INQUIRY.PROD_NO IS '상품 번호';

-- TB_INQUIRY_REPLY 테이블 생성 (자식 테이블)
CREATE TABLE TB_INQUIRY_REPLY (
    INQUIRY_REPLY_NO NUMBER NOT NULL,
    INQUIRY_REPLY_CONTENT VARCHAR2(2000) NOT NULL,
    INQUIRY_REPLY_CREATE_DATE DATE DEFAULT SYSDATE NOT NULL,
    INQUIRY_REPLY_YN CHAR(1) DEFAULT 'N' NOT NULL,
    INQUIRY_REPLY_STATUS CHAR(1) DEFAULT 'Y' NOT NULL,
    INQUIRY_NO NUMBER NOT NULL,
    MEMBER_ID VARCHAR2(20) NOT NULL,
    CONSTRAINT PK_INQUIRY_REPLY PRIMARY KEY (INQUIRY_REPLY_NO),
    CONSTRAINT FK_INQUIRY_TO_INQUIRY_REPLY FOREIGN KEY (INQUIRY_NO) REFERENCES TB_INQUIRY (INQUIRY_NO),
    CONSTRAINT FK_MEMBER_TO_INQUIRY_REPLY FOREIGN KEY (MEMBER_ID) REFERENCES TB_MEMBER (MEMBER_ID)
);

COMMENT ON COLUMN TB_INQUIRY_REPLY.INQUIRY_REPLY_NO IS '문의 댓글 번호';
COMMENT ON COLUMN TB_INQUIRY_REPLY.INQUIRY_REPLY_CONTENT IS '문의 댓글 내용';
COMMENT ON COLUMN TB_INQUIRY_REPLY.INQUIRY_REPLY_CREATE_DATE IS '문의 댓글 작성일';
COMMENT ON COLUMN TB_INQUIRY_REPLY.INQUIRY_REPLY_YN IS '답변 여부 (Y/N)';
COMMENT ON COLUMN TB_INQUIRY_REPLY.INQUIRY_REPLY_STATUS IS '댓글 상태값';
COMMENT ON COLUMN TB_INQUIRY_REPLY.INQUIRY_NO IS '문의글 번호';
COMMENT ON COLUMN TB_INQUIRY_REPLY.MEMBER_ID IS '회원 아이디';

-- TB_DELIVERY 테이블 생성 (자식 테이블)
CREATE TABLE TB_DELIVERY (
    DELI_CODE NUMBER NOT NULL,
    DELI_NICKNAME VARCHAR2(30), 
    DELI_NAME VARCHAR2(20) NOT NULL,
    DELI_PHONE CHAR(11) NOT NULL,
    DELI_ADDRESS VARCHAR2(300) NOT NULL,
    DELI_DEFAULT CHAR(1) DEFAULT 'Y' NOT NULL,
    DELI_COMMENT VARCHAR2(300),
    POSTCODE VARCHAR2(10) NOT NULL,
    DETAIL_ADDRESS VARCHAR2(255),
    HOME_ADDRESS_YN CHAR(1) DEFAULT 'Y',
    MEMBER_ID VARCHAR2(20) NOT NULL,
    CONSTRAINT PK_DELIVERY PRIMARY KEY (DELI_CODE),
    CONSTRAINT FK_MEMBER_TO_DELIVERY FOREIGN KEY (MEMBER_ID) REFERENCES TB_MEMBER (MEMBER_ID)
);

COMMENT ON COLUMN TB_DELIVERY.DELI_CODE IS '배송 코드';
COMMENT ON COLUMN TB_DELIVERY.DELI_NAME IS '받는 사람 이름';
COMMENT ON COLUMN TB_DELIVERY.DELI_PHONE IS '받는 사람 연락처';
COMMENT ON COLUMN TB_DELIVERY.DELI_ADDRESS IS '배송지 주소';
COMMENT ON COLUMN TB_DELIVERY.DELI_DEFAULT IS '기본 배송지 여부';
COMMENT ON COLUMN TB_DELIVERY.DELI_COMMENT IS '배송 요청사항';
COMMENT ON COLUMN TB_DELIVERY.POSTCODE IS '우편번호';
COMMENT ON COLUMN TB_DELIVERY.DETAIL_ADDRESS IS '상세주소';
COMMENT ON COLUMN TB_DELIVERY.MEMBER_ID IS '회원 아이디';
COMMENT ON COLUMN  TB_DELIVERY.DELI_NICKNAME IS '배송지명';
COMMENT ON COLUMN  TB_DELIVERY.HOME_ADDRESS_YN  IS '집주소여부';

-- TB_FAQ 테이블 생성
CREATE TABLE TB_FAQ (
    FAQ_NO NUMBER NOT NULL,
    FAQ_TITLE VARCHAR2(250) NOT NULL,
    FAQ_CONTENT VARCHAR2(2500) NOT NULL,
    FAQ_TYPE VARCHAR2(200) NOT NULL,
    FAQ_STATUS CHAR(1) DEFAULT 'Y' NOT NULL,
    CONSTRAINT PK_TB_FAQ PRIMARY KEY (FAQ_NO)
);

COMMENT ON COLUMN TB_FAQ.FAQ_NO IS 'FAQ 번호';
COMMENT ON COLUMN TB_FAQ.FAQ_TITLE IS 'FAQ 제목';
COMMENT ON COLUMN TB_FAQ.FAQ_CONTENT IS 'FAQ 내용';
COMMENT ON COLUMN TB_FAQ.FAQ_TYPE IS 'FAQ 유형';
COMMENT ON COLUMN TB_FAQ.FAQ_STATUS IS 'FAQ 상태값';

-- TB_NOTIFICATION 테이블 생성
CREATE TABLE TB_NOTIFICATION (
    NOTIFICATION_NO NUMBER NOT NULL,
    NOTIFICATION_CONTENT VARCHAR2(300) NOT NULL,
    NOTIFICATION_TYPE VARCHAR2(200) NOT NULL,
    READ_YN CHAR(1) DEFAULT 'N' NOT NULL,
    DELETE_YN CHAR(1) DEFAULT 'N' NOT NULL,
    CREATE_AT DATE DEFAULT SYSDATE NOT NULL,
    MEMBER_ID VARCHAR2(20) NOT NULL,
    CONSTRAINT PK_NOTIFICATION PRIMARY KEY (NOTIFICATION_NO),
    CONSTRAINT FK_MEMBER_TO_NOTIFICATION FOREIGN KEY (MEMBER_ID) REFERENCES TB_MEMBER (MEMBER_ID)
);

COMMENT ON COLUMN TB_NOTIFICATION.NOTIFICATION_NO IS '알림 번호';
COMMENT ON COLUMN TB_NOTIFICATION.NOTIFICATION_CONTENT IS '알림 내용';
COMMENT ON COLUMN TB_NOTIFICATION.NOTIFICATION_TYPE IS '알림 유형';
COMMENT ON COLUMN TB_NOTIFICATION.READ_YN IS '읽음 여부 (Y/N)';
COMMENT ON COLUMN TB_NOTIFICATION.DELETE_YN IS '삭제 여부 (Y/N)';
COMMENT ON COLUMN TB_NOTIFICATION.CREATE_AT IS '알림 생성일';
COMMENT ON COLUMN TB_NOTIFICATION.MEMBER_ID IS '회원 아이디';

-- TB_ORDER 테이블 생성
CREATE TABLE TB_ORDER (
    ORDER_NO VARCHAR2(30) NOT NULL,
    RCVR_NAME VARCHAR2(20) NOT NULL,
    RCVR_PHONE CHAR(11) NOT NULL,
    RCVR_ADDRESS VARCHAR2(225) NOT NULL,
    DLVR_REQ_MESSAGE VARCHAR2(255),
    DLVR_STATUS VARCHAR2(20) DEFAULT '배송대기' NOT NULL,
    DLVR_FEE NUMBER DEFAULT 0 NOT NULL,
    DLVR_COMPANY VARCHAR2(30) NOT NULL,
    DISPATCH_DATE DATE,
    COMPLETE_DATE DATE,
    ORDER_TOTAL_AMT NUMBER DEFAULT 0 NOT NULL,
    PAYMENT_CODE VARCHAR2(30),
    PAYMENT_METHOD VARCHAR2(30) NOT NULL,
    ORDER_DATE DATE DEFAULT SYSDATE NOT NULL,
    REFUND_DATE DATE,
    REFUND_REASON VARCHAR2(225),
    MEMBER_ID VARCHAR2(20) NOT NULL,
    CONSTRAINT PK_ORDER PRIMARY KEY (ORDER_NO),
    CONSTRAINT FK_MEMBER_TO_ORDER FOREIGN KEY (MEMBER_ID) REFERENCES TB_MEMBER (MEMBER_ID)
);

COMMENT ON COLUMN TB_ORDER.ORDER_NO IS '주문 번호';
COMMENT ON COLUMN TB_ORDER.RCVR_NAME IS '수령인 이름';
COMMENT ON COLUMN TB_ORDER.RCVR_PHONE IS '수령인 연락처';
COMMENT ON COLUMN TB_ORDER.RCVR_ADDRESS IS '수령인 주소';
COMMENT ON COLUMN TB_ORDER.DLVR_REQ_MESSAGE IS '배송 요청 메시지';
COMMENT ON COLUMN TB_ORDER.DLVR_STATUS IS '배송 상태';
COMMENT ON COLUMN TB_ORDER.DLVR_FEE IS '배송비';
COMMENT ON COLUMN TB_ORDER.DLVR_COMPANY IS '배송 업체';
COMMENT ON COLUMN TB_ORDER.DISPATCH_DATE IS '출고일';
COMMENT ON COLUMN TB_ORDER.COMPLETE_DATE IS '배송 완료일';
COMMENT ON COLUMN TB_ORDER.ORDER_TOTAL_AMT IS '총 주문 금액';
COMMENT ON COLUMN TB_ORDER.PAYMENT_CODE IS '결제 코드';
COMMENT ON COLUMN TB_ORDER.PAYMENT_METHOD IS '결제 방법';
COMMENT ON COLUMN TB_ORDER.ORDER_DATE IS '주문일';
COMMENT ON COLUMN TB_ORDER.REFUND_DATE IS '환불일';
COMMENT ON COLUMN TB_ORDER.REFUND_REASON IS '환불 사유';
COMMENT ON COLUMN TB_ORDER.MEMBER_ID IS '회원 아이디';

-- TB_OPTION 테이블 생성
CREATE TABLE TB_OPTION (
    OPT_NO NUMBER NOT NULL,
    OPT_NAME VARCHAR2(90) NOT NULL,
    OPT_VALUE VARCHAR2(90),
    OPT_ADD_PRICE NUMBER DEFAULT 0,
    REMAIN_QTY NUMBER DEFAULT 0 NOT NULL,
    PROD_NO NUMBER NOT NULL,
    CONSTRAINT PK_OPTION PRIMARY KEY (OPT_NO),
    CONSTRAINT FK_PRODUCT_TO_OPTION FOREIGN KEY (PROD_NO) REFERENCES TB_PRODUCT (PROD_NO)
);

COMMENT ON COLUMN TB_OPTION.OPT_NO IS '옵션 번호';
COMMENT ON COLUMN TB_OPTION.OPT_NAME IS '옵션 이름';
COMMENT ON COLUMN TB_OPTION.OPT_VALUE IS '옵션 값';
COMMENT ON COLUMN TB_OPTION.OPT_ADD_PRICE IS '옵션 추가 금액';
COMMENT ON COLUMN TB_OPTION.REMAIN_QTY IS '재고 수량';
COMMENT ON COLUMN TB_OPTION.PROD_NO IS '상품 번호';

-- TB_STOCK 테이블 생성
CREATE TABLE TB_STOCK (
    STOCK_NO NUMBER NOT NULL,
    STOCK_QTY NUMBER NOT NULL,
    STOCK_DATE DATE DEFAULT SYSDATE NOT NULL,
    OPT_NO NUMBER NOT NULL,
    PROD_NO NUMBER NOT NULL,
    CONSTRAINT PK_STOCK PRIMARY KEY (STOCK_NO),
    CONSTRAINT FK_OPTION_TO_STOCK FOREIGN KEY (OPT_NO) REFERENCES TB_OPTION (OPT_NO),
    CONSTRAINT FK_PRODUCT_TO_STOCK FOREIGN KEY (PROD_NO) REFERENCES TB_PRODUCT (PROD_NO)
);

COMMENT ON COLUMN TB_STOCK.STOCK_NO IS '입고 번호';
COMMENT ON COLUMN TB_STOCK.STOCK_QTY IS '입고 수량';
COMMENT ON COLUMN TB_STOCK.STOCK_DATE IS '입고 날짜';
COMMENT ON COLUMN TB_STOCK.OPT_NO IS '옵션 번호';
COMMENT ON COLUMN TB_STOCK.PROD_NO IS '상품 번호';

-- TB_PRODUCT_ORDER 테이블 생성
CREATE TABLE TB_PRODUCT_ORDER (
    SERIAL_NO VARCHAR2(30) NOT NULL,
    ORDER_QTY NUMBER DEFAULT 1,
    TOTAL_AMT NUMBER DEFAULT 0,
    ORDER_NO VARCHAR2(30) NOT NULL,
    OPT_NO NUMBER NOT NULL,
    CONSTRAINT PK_PRODUCT_ORDER PRIMARY KEY (SERIAL_NO),
    CONSTRAINT FK_ORDER_TO_PRODUCT_ORDER FOREIGN KEY (ORDER_NO) REFERENCES TB_ORDER (ORDER_NO),
    CONSTRAINT FK_OPTION_TO_PRODUCT_ORDER FOREIGN KEY (OPT_NO) REFERENCES TB_OPTION (OPT_NO)
);

COMMENT ON COLUMN TB_PRODUCT_ORDER.SERIAL_NO IS '주문 상세 번호';
COMMENT ON COLUMN TB_PRODUCT_ORDER.ORDER_QTY IS '주문 수량';
COMMENT ON COLUMN TB_PRODUCT_ORDER.TOTAL_AMT IS '총 금액';
COMMENT ON COLUMN TB_PRODUCT_ORDER.ORDER_NO IS '주문 번호';
COMMENT ON COLUMN TB_PRODUCT_ORDER.OPT_NO IS '옵션 번호';

-- TB_REVIEW 테이블 생성
CREATE TABLE TB_REVIEW (
    REV_NO NUMBER NOT NULL,
    REV_CONTENT VARCHAR2(1500) NOT NULL,
    REV_ENROLL_DATE DATE DEFAULT SYSDATE NOT NULL,
    REV_RATING NUMBER DEFAULT 0,
    REV_STATUS CHAR(1) DEFAULT 'Y' NOT NULL,
    SERIAL_NO VARCHAR2(30) NOT NULL,                   -- 주문 상세 번호 (TB_PRODUCT_ORDER)
    MEMBER_ID VARCHAR2(20) NOT NULL,
    CONSTRAINT PK_REVIEW PRIMARY KEY (REV_NO),
    CONSTRAINT FK_SERIAL_TO_REVIEW FOREIGN KEY (SERIAL_NO) REFERENCES TB_PRODUCT_ORDER (SERIAL_NO),       -- FOREIGN KEY: TB_PRODUCT_ORDER 참조
    CONSTRAINT FK_MEMBER_TO_REVIEW FOREIGN KEY (MEMBER_ID) REFERENCES TB_MEMBER (MEMBER_ID)
);

COMMENT ON COLUMN TB_REVIEW.REV_NO IS '리뷰 번호';
COMMENT ON COLUMN TB_REVIEW.REV_CONTENT IS '리뷰 내용';
COMMENT ON COLUMN TB_REVIEW.REV_ENROLL_DATE IS '리뷰 등록일';
COMMENT ON COLUMN TB_REVIEW.REV_RATING IS '리뷰 평점';
COMMENT ON COLUMN TB_REVIEW.REV_STATUS IS '리뷰 상태값';
COMMENT ON COLUMN TB_REVIEW.SERIAL_NO IS '주문 상세 번호';
COMMENT ON COLUMN TB_REVIEW.MEMBER_ID IS '회원 아이디';

-- TB_WISH 테이블 생성
CREATE TABLE TB_WISH (
    MEMBER_ID VARCHAR2(20) NOT NULL,
    PROD_NO NUMBER NOT NULL,
    CONSTRAINT PK_WISH PRIMARY KEY (MEMBER_ID, PROD_NO),
    CONSTRAINT FK_MEMBER_TO_WISH FOREIGN KEY (MEMBER_ID) REFERENCES TB_MEMBER (MEMBER_ID) ON DELETE CASCADE,
    CONSTRAINT FK_PRODUCT_TO_WISH FOREIGN KEY (PROD_NO) REFERENCES TB_PRODUCT (PROD_NO) ON DELETE CASCADE
);

COMMENT ON COLUMN TB_WISH.MEMBER_ID IS '회원 아이디';
COMMENT ON COLUMN TB_WISH.PROD_NO IS '상품 번호';

-- TB_PRODUCT_ATTACHMENT 테이블 생성
CREATE TABLE TB_PRODUCT_ATTACHMENT (
    PROD_ATT_NO NUMBER NOT NULL,
    ORIG_FILE_NAME VARCHAR2(255) NOT NULL,
    SAVE_FILE_NAME VARCHAR2(255) NOT NULL,
    SAVE_PATH VARCHAR2(60) NOT NULL,
    THUMB_PATH VARCHAR2(60),
    PROD_ATT_STATUS CHAR(1) DEFAULT 'Y' NOT NULL,
    PROD_NO NUMBER NOT NULL,
    CONSTRAINT PK_PRODUCT_ATTACHMENT PRIMARY KEY (PROD_ATT_NO),
    CONSTRAINT FK_PRODUCT_TO_PRODUCT_ATT FOREIGN KEY (PROD_NO) REFERENCES TB_PRODUCT (PROD_NO)
);

COMMENT ON COLUMN TB_PRODUCT_ATTACHMENT.PROD_ATT_NO IS '첨부 파일 번호';
COMMENT ON COLUMN TB_PRODUCT_ATTACHMENT.ORIG_FILE_NAME IS '원본 파일명';
COMMENT ON COLUMN TB_PRODUCT_ATTACHMENT.SAVE_FILE_NAME IS '저장 파일명';
COMMENT ON COLUMN TB_PRODUCT_ATTACHMENT.SAVE_PATH IS '저장 경로';
COMMENT ON COLUMN TB_PRODUCT_ATTACHMENT.THUMB_PATH IS '썸네일 경로';
COMMENT ON COLUMN TB_PRODUCT_ATTACHMENT.PROD_ATT_STATUS IS '첨부 파일 상태값';
COMMENT ON COLUMN TB_PRODUCT_ATTACHMENT.PROD_NO IS '상품 번호';

-- TB_POINT 테이블 생성
CREATE TABLE TB_POINT (
    POINT_NO NUMBER DEFAULT 1 NOT NULL,
    POINT_AMT NUMBER DEFAULT 0 NOT NULL,
    POINT_REASON VARCHAR2(225) NOT NULL,
    POINT_DATE DATE DEFAULT SYSDATE,
    MEMBER_ID VARCHAR2(20) NOT NULL,
    CONSTRAINT PK_POINT PRIMARY KEY (POINT_NO),
    CONSTRAINT FK_MEMBER_TO_POINT FOREIGN KEY (MEMBER_ID) REFERENCES TB_MEMBER (MEMBER_ID)
);

COMMENT ON COLUMN TB_POINT.POINT_NO IS '포인트 번호';
COMMENT ON COLUMN TB_POINT.POINT_AMT IS '포인트 금액';
COMMENT ON COLUMN TB_POINT.POINT_REASON IS '포인트 적립/사용 사유';
COMMENT ON COLUMN TB_POINT.POINT_DATE IS '포인트 날짜';
COMMENT ON COLUMN TB_POINT.MEMBER_ID IS '회원 아이디';

-- TB_CART 테이블 생성
CREATE TABLE TB_CART (
    CART_NO NUMBER NOT NULL,
    MEMBER_ID VARCHAR2(20) NOT NULL,
    PROD_NO NUMBER NOT NULL,
    OPT_NO NUMBER NOT NULL,
    CART_QTY NUMBER DEFAULT 1 NOT NULL,
    CONSTRAINT PK_CART PRIMARY KEY (CART_NO),
    CONSTRAINT FK_MEMBER_TO_CART FOREIGN KEY (MEMBER_ID) REFERENCES TB_MEMBER (MEMBER_ID),
    CONSTRAINT FK_PRODUCT_TO_CART FOREIGN KEY (PROD_NO) REFERENCES TB_PRODUCT (PROD_NO),
    CONSTRAINT FK_OPTION_TO_CART FOREIGN KEY (OPT_NO) REFERENCES TB_OPTION (OPT_NO)
);

COMMENT ON COLUMN TB_CART.CART_NO IS '장바구니 번호';
COMMENT ON COLUMN TB_CART.MEMBER_ID IS '회원 아이디';
COMMENT ON COLUMN TB_CART.PROD_NO IS '상품 번호';
COMMENT ON COLUMN TB_CART.OPT_NO IS '옵션 번호';
COMMENT ON COLUMN TB_CART.CART_QTY IS '장바구니 수량';

-- TB_NOTICE 테이블 생성
CREATE TABLE TB_NOTICE (
    NOTICE_NO NUMBER NOT NULL,
    NOTICE_TITLE VARCHAR2(150) NOT NULL,
    NOTICE_CONTENT VARCHAR2(4000) NOT NULL,
    NOTICE_REG_DATE DATE DEFAULT SYSDATE NOT NULL,
    NOTICE_PINNED_YN CHAR(1) DEFAULT 'N' NOT NULL,
    NOTICE_STATUS CHAR(1) DEFAULT 'Y' NOT NULL,
    CONSTRAINT PK_NOTICE PRIMARY KEY (NOTICE_NO)
);

COMMENT ON COLUMN TB_NOTICE.NOTICE_NO IS '공지사항 번호';
COMMENT ON COLUMN TB_NOTICE.NOTICE_TITLE IS '공지사항 제목';
COMMENT ON COLUMN TB_NOTICE.NOTICE_CONTENT IS '공지사항 내용';
COMMENT ON COLUMN TB_NOTICE.NOTICE_REG_DATE IS '공지사항 작성일';
COMMENT ON COLUMN TB_NOTICE.NOTICE_PINNED_YN IS '공지 상단 고정 여부';
COMMENT ON COLUMN TB_NOTICE.NOTICE_STATUS IS '공지 상태값';

-- TB_NOTICE_ATTACHMENT 테이블 생성
CREATE TABLE TB_NOTICE_ATTACHMENT (
    NOTICE_ATT_NO NUMBER NOT NULL,
    ORIG_FILE_NAME VARCHAR2(255) NOT NULL,
    SAVE_FILE_NAME VARCHAR2(255) NOT NULL,
    SAVE_PATH VARCHAR2(60) NOT NULL,
    NOTICE_ATT_STATUS CHAR(1) DEFAULT 'Y' NOT NULL,
    NOTICE_NO NUMBER NOT NULL,
    CONSTRAINT PK_NOTICE_ATTACHMENT PRIMARY KEY (NOTICE_ATT_NO),
    CONSTRAINT FK_NOTICE_TO_NOTICE_ATT FOREIGN KEY (NOTICE_NO) REFERENCES TB_NOTICE (NOTICE_NO)
);

COMMENT ON COLUMN TB_NOTICE_ATTACHMENT.NOTICE_ATT_NO IS '첨부 파일 번호';
COMMENT ON COLUMN TB_NOTICE_ATTACHMENT.ORIG_FILE_NAME IS '원본 파일명';
COMMENT ON COLUMN TB_NOTICE_ATTACHMENT.SAVE_FILE_NAME IS '저장 파일명';
COMMENT ON COLUMN TB_NOTICE_ATTACHMENT.SAVE_PATH IS '저장 경로';
COMMENT ON COLUMN TB_NOTICE_ATTACHMENT.NOTICE_ATT_STATUS IS '첨부 파일 상태값';
COMMENT ON COLUMN TB_NOTICE_ATTACHMENT.NOTICE_NO IS '공지 번호';

-- TB_INQUIRY_ATTACHMENT 테이블 생성
CREATE TABLE TB_INQUIRY_ATTACHMENT (
    INQUIRY_ATT_NO NUMBER NOT NULL,
    ORIG_FILE_NAME VARCHAR2(255) NOT NULL,
    SAVE_FILE_NAME VARCHAR2(255) NOT NULL,
    SAVE_PATH VARCHAR2(60) NOT NULL,
    INQUIRY_ATT_STATUS CHAR(1) DEFAULT 'Y' NOT NULL,
    INQUIRY_NO NUMBER NOT NULL,
    CONSTRAINT PK_INQUIRY_ATTACHMENT PRIMARY KEY (INQUIRY_ATT_NO),
    CONSTRAINT FK_INQUIRY_TO_INQUIRY_ATT FOREIGN KEY (INQUIRY_NO) REFERENCES TB_INQUIRY (INQUIRY_NO)
);

COMMENT ON COLUMN TB_INQUIRY_ATTACHMENT.INQUIRY_ATT_NO IS '첨부 파일 번호';
COMMENT ON COLUMN TB_INQUIRY_ATTACHMENT.ORIG_FILE_NAME IS '원본 파일명';
COMMENT ON COLUMN TB_INQUIRY_ATTACHMENT.SAVE_FILE_NAME IS '저장 파일명';
COMMENT ON COLUMN TB_INQUIRY_ATTACHMENT.SAVE_PATH IS '저장 경로';
COMMENT ON COLUMN TB_INQUIRY_ATTACHMENT.INQUIRY_ATT_STATUS IS '첨부 파일 상태값';
COMMENT ON COLUMN TB_INQUIRY_ATTACHMENT.INQUIRY_NO IS '문의글 번호';

-- TB_REVIEW_ATTACHMENT 테이블 생성
CREATE TABLE TB_REVIEW_ATTACHMENT (
    REV_ATT_NO NUMBER NOT NULL,
    ORIG_FILE_NAME VARCHAR2(255) NOT NULL,
    SAVE_FILE_NAME VARCHAR2(255) NOT NULL,
    SAVE_PATH VARCHAR2(60) NOT NULL,
    THUMB_PATH VARCHAR2(60),
    REV_ATT_STATUS CHAR(1) DEFAULT 'Y' NOT NULL,
    REV_NO NUMBER NOT NULL,
    CONSTRAINT PK_REVIEW_ATTACHMENT PRIMARY KEY (REV_ATT_NO),
    CONSTRAINT FK_REVIEW_TO_REVIEW_ATT FOREIGN KEY (REV_NO) REFERENCES TB_REVIEW (REV_NO)
);

COMMENT ON COLUMN TB_REVIEW_ATTACHMENT.REV_ATT_NO IS '첨부 파일 번호';
COMMENT ON COLUMN TB_REVIEW_ATTACHMENT.ORIG_FILE_NAME IS '원본 파일명';
COMMENT ON COLUMN TB_REVIEW_ATTACHMENT.SAVE_FILE_NAME IS '저장 파일명';
COMMENT ON COLUMN TB_REVIEW_ATTACHMENT.SAVE_PATH IS '저장 경로';
COMMENT ON COLUMN TB_REVIEW_ATTACHMENT.THUMB_PATH IS '썸네일 경로';
COMMENT ON COLUMN TB_REVIEW_ATTACHMENT.REV_ATT_STATUS IS '첨부 파일 상태값';
COMMENT ON COLUMN TB_REVIEW_ATTACHMENT.REV_NO IS '리뷰 번호';

-- TB_PRODUCT_BANNER 테이블 생성
CREATE TABLE TB_PRODUCT_BANNER (
    PROD_BANNER_NO NUMBER NOT NULL,
    ORIG_FILE_NAME VARCHAR2(255) NOT NULL,
    SAVE_FILE_NAME VARCHAR2(255) NOT NULL,
    BANNER_PATH VARCHAR2(60),
    MD_PATH VARCHAR2(60),
    BANNER_STATUS CHAR(1) DEFAULT 'Y' NOT NULL,
    PROD_NO NUMBER NOT NULL,
    CONSTRAINT PK_PRODUCT_BANNER PRIMARY KEY (PROD_BANNER_NO),
    CONSTRAINT FK_PRODUCT_TO_PRODUCT_BANNER FOREIGN KEY (PROD_NO) REFERENCES TB_PRODUCT (PROD_NO)
);

COMMENT ON COLUMN TB_PRODUCT_BANNER.PROD_BANNER_NO IS '첨부 파일 번호';
COMMENT ON COLUMN TB_PRODUCT_BANNER.ORIG_FILE_NAME IS '원본 파일명';
COMMENT ON COLUMN TB_PRODUCT_BANNER.SAVE_FILE_NAME IS '저장 파일명';
COMMENT ON COLUMN TB_PRODUCT_BANNER.BANNER_PATH IS '배너 저장 경로';
COMMENT ON COLUMN TB_PRODUCT_BANNER.MD_PATH IS 'MD배너 저장 경로';
COMMENT ON COLUMN TB_PRODUCT_BANNER.BANNER_STATUS IS '배너 상태값';
COMMENT ON COLUMN TB_PRODUCT_BANNER.PROD_NO IS '상품 번호';


COMMIT;