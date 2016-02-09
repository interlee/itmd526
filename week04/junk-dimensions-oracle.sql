--
-- DIM_PROD
--
CREATE SEQUENCE seq_dim_prod;

DROP TABLE dim_prod;
CREATE TABLE dim_prod 
(   
  prod_key INTEGER, 
  prod_code VARCHAR(8 BYTE), 
  prod_desc VARCHAR2(126 BYTE),
  constraint pk_dim_prod primary key (prod_key)
  USING INDEX  ENABLE
) ;

INSERT INTO dim_prod(prod_key, prod_code, prod_desc)
  WITH prod_source AS
       ( 
         SELECT 'prd_a' AS prod_code, 'prod desc a' AS prod_desc FROM DUAL UNION ALL
         SELECT 'prd_b' AS prod_code, 'prod desc b' AS prod_desc FROM DUAL UNION ALL
         SELECT 'prd_c' AS prod_code, 'prod desc c' AS prod_desc FROM DUAL UNION ALL
         SELECT 'prd_d' AS prod_code, 'prod desc d' AS prod_desc FROM DUAL UNION ALL
         SELECT 'prd_e' AS prod_code, 'prod desc e' AS prod_desc FROM DUAL
       )
SELECT seq_dim_prod.NEXTVAL prod_key, p.prod_code, p.prod_desc
  FROM prod_source p;
/*
   DIM_PROD
   
    PROD_KEY PROD_CODE PROD_DESC 
  ---------- --------- -----------
           1 prd_a     prod desc a 
           2 prd_b     prod desc b 
           3 prd_c     prod desc c 
           4 prd_d     prod desc d 
           5 prd_e     prod desc e 
 */
 
--
-- SALES SOURCE into FACT_SALES
--
  WITH dim_weather_type AS
       (
          SELECT 1 AS weather_type_key, 'clr' AS weather_type_code, 'Clear'  AS weather_type_desc FROM DUAL UNION ALL
          SELECT 2 AS weather_type_key, 'cld' AS weather_type_code, 'Cloudy' AS weather_type_desc FROM DUAL UNION ALL
          SELECT 3 AS weather_type_key, 'rny' AS weather_type_code, 'Rainy'  AS weather_type_desc FROM DUAL UNION ALL
          SELECT 4 AS weather_type_key, 'snw' AS weather_type_code, 'Snow'   AS weather_type_desc FROM DUAL
          /* 
              DIM_WEATHER_TYPE
          
              weather_TYPE_KEY weather_TYPE_CODE WEATHER_TYPE_DESC
              ---------------- ----------------- -----------------
                             1 clr               Clear             
                             2 cld               Cloudy            
                             3 rny               Rainy             
                             4 snw               Snow                 
          */      
       ),
       dim_payment_option AS
       (
          SELECT 1 AS payment_option_key, 'crd' AS payment_option_code, 'Credit'  AS payment_option_desc FROM DUAL UNION ALL
          SELECT 2 AS payment_option_key, 'chk' AS payment_option_code, 'Check'   AS payment_option_desc FROM DUAL UNION ALL
          SELECT 3 AS payment_option_key, 'csh' AS payment_option_code, 'Cash'    AS payment_option_desc FROM DUAL UNION ALL
          SELECT 4 AS payment_option_key, 'mbl' AS payment_option_code, 'Mobile'  AS payment_option_desc FROM DUAL     
    
          /* 
              DIM_PAYMENT_OPTION
              
              PAYMENT_OPTION_KEY PAYMENT_OPTION_CODE PAYMENT_OPTION_DESC
              ------------------ ------------------- -------------------
                               1 crd                 Credit              
                               2 chk                 Check               
                               3 csh                 Cash                
                               4 mbl                 Mobile                   
           */
       ),   
       pos_sales_source AS
       (
         SELECT 'prd_a' AS prod_code, 'prod desc a' AS prod_desc, 'clr' AS weather_type_code, 'mbl' AS payment_option_code, 10 AS amt, 1 AS qty  FROM DUAL UNION ALL
         SELECT 'prd_b' AS prod_code, 'prod desc b' AS prod_desc, 'rny' AS weather_type_code, 'crd' AS payment_option_code, 20 AS amt, 3 AS qty  FROM DUAL UNION ALL
         SELECT 'prd_c' AS prod_code, 'prod desc c' AS prod_desc, 'clr' AS weather_type_code, 'chk' AS payment_option_code, 50 AS amt, 5 AS qty  FROM DUAL UNION ALL
         SELECT 'prd_d' AS prod_code, 'prod desc d' AS prod_desc, 'cld' AS weather_type_code, 'csh' AS payment_option_code, 30 AS amt, 1 AS qty  FROM DUAL UNION ALL
         SELECT 'prd_e' AS prod_code, 'prod desc e' AS prod_desc, 'snw' AS weather_type_code, 'mbl' AS payment_option_code, 40 AS amt, 1 AS qty  FROM DUAL
        /*
          Sales Data Source:
          
          PROD_CODE PROD_DESC   weather_TYPE_CODE PAYMENT_OPTION_CODE        AMT        QTY
          --------- ----------- ----------------- ------------------- ---------- ----------
          prd_a     prod desc a clr               mbl                         10          1 
          prd_b     prod desc b rny               crd                         20          3 
          prd_c     prod desc c clr               chk                         50          5 
          prd_d     prod desc d cld               csh                         30          1 
          prd_e     prod desc e snw               mbl                         40          1 
         */
       ) 
SELECT p.prod_key, w.weather_type_key, po.payment_option_key, s.amt, s.qty
  FROM pos_sales_source s
  LEFT OUTER JOIN dim_prod p
    ON s.prod_code = p.prod_code
  LEFT OUTER JOIN dim_weather_type w
    ON s.weather_type_code = w.weather_type_code
  LEFT OUTER JOIN dim_payment_option po
    ON s.payment_option_code = po.payment_option_code
/*
    PROD_KEY WEATHER_TYPE_KEY PAYMENT_OPTION_KEY        AMT        QTY
  ---------- ---------------- ------------------ ---------- ----------
           1                1                  4         10          1 
           2                3                  1         20          3 
           3                1                  2         50          5 
           4                2                  3         30          1 
           5                4                  4         40          1 
 */         
;  


--
-- DIM_JUNK
--
CREATE SEQUENCE seq_dim_junk_types;

DROP TABLE dim_junk;
CREATE TABLE dim_junk 
(   
  junk_type_key INTEGER, 
  weather_type_code CHAR(3 BYTE), 
  weather_type_desc VARCHAR2(6 BYTE), 
  payment_option_code CHAR(3 BYTE), 
  payment_option_desc varchar2(6 BYTE), 
  constraint pk_dim_junk primary key (junk_type_key)
  USING INDEX  ENABLE
) ;

INSERT INTO dim_junk(junk_type_key, weather_type_code, weather_type_desc, payment_option_code, payment_option_desc)
  WITH dim_weather_type AS
       (
          SELECT 1 AS weather_type_key, 'clr' AS weather_type_code, 'Clear'  AS weather_type_desc FROM DUAL UNION ALL
          SELECT 2 AS weather_type_key, 'cld' AS weather_type_code, 'Cloudy' AS weather_type_desc FROM DUAL UNION ALL
          SELECT 3 AS weather_type_key, 'rny' AS weather_type_code, 'Rainy'  AS weather_type_desc FROM DUAL UNION ALL
          SELECT 4 AS weather_type_key, 'snw' AS weather_type_code, 'Snow'   AS weather_type_desc FROM DUAL
          /* 
              DIM_WEATHER_TYPE
          
              weather_TYPE_KEY weather_TYPE_CODE WEATHER_TYPE_DESC
              ---------------- ----------------- -----------------
                             1 clr               Clear             
                             2 cld               Cloudy            
                             3 rny               Rainy             
                             4 snw               Snow                 
          */      
       ),
       dim_payment_option AS
       (
          SELECT 1 AS payment_option_key, 'crd' AS payment_option_code, 'Credit'  AS payment_option_desc FROM DUAL UNION ALL
          SELECT 2 AS payment_option_key, 'chk' AS payment_option_code, 'Check'   AS payment_option_desc FROM DUAL UNION ALL
          SELECT 3 AS payment_option_key, 'csh' AS payment_option_code, 'Cash'    AS payment_option_desc FROM DUAL UNION ALL
          SELECT 4 AS payment_option_key, 'mbl' AS payment_option_code, 'Mobile'  AS payment_option_desc FROM DUAL     
    
          /* 
              DIM_PAYMENT_OPTION
              
              PAYMENT_OPTION_KEY PAYMENT_OPTION_CODE PAYMENT_OPTION_DESC
              ------------------ ------------------- -------------------
                               1 crd                 Credit              
                               2 chk                 Check               
                               3 csh                 Cash                
                               4 mbl                 Mobile                   
           */
       )   
SELECT seq_dim_junk_types.NEXTVAL AS junk_type_key, w.weather_type_code, w.weather_type_desc, po.payment_option_code, po.payment_option_desc
  FROM dim_weather_type w, dim_payment_option po

/*
    DIM_JUNK
    
    JUNK_TYPE_KEY weather_TYPE_CODE WEATHER_TYPE_DESC PAYMENT_OPTION_CODE PAYMENT_OPTION_DESC
    ------------- ----------------- ----------------- ------------------- -------------------
                1 clr               Clear             crd                 Credit              
                2 clr               Clear             chk                 Check               
                3 clr               Clear             csh                 Cash                
                4 clr               Clear             mbl                 Mobile              
                5 cld               Cloudy            crd                 Credit              
                6 cld               Cloudy            chk                 Check               
                7 cld               Cloudy            csh                 Cash                
                8 cld               Cloudy            mbl                 Mobile              
                9 rny               Rainy             crd                 Credit              
               10 rny               Rainy             chk                 Check               
               11 rny               Rainy             csh                 Cash                
               12 rny               Rainy             mbl                 Mobile              
               13 snw               Snow              crd                 Credit              
               14 snw               Snow              chk                 Check               
               15 snw               Snow              csh                 Cash                
               16 snw               Snow              mbl                 Mobile              
 */
;

-- Clean up
 DROP SEQUENCE seq_dim_prod;  
 DROP sequence seq_dim_junk_types;
 
--
-- SALES SOURCE into FACT_SALES with the DIM_JUNK (replacing the DIM_WEATHER_TYPE and the DIM_PAYMENT_OPTION)
--
  WITH pos_sales_source AS
       (
         SELECT 'prd_a' AS prod_code, 'prod desc a' AS prod_desc, 'clr' AS weather_type_code, 'mbl' AS payment_option_code, 10 AS amt, 1 AS qty  FROM DUAL UNION ALL
         SELECT 'prd_b' AS prod_code, 'prod desc b' AS prod_desc, 'rny' AS weather_type_code, 'crd' AS payment_option_code, 20 AS amt, 3 AS qty  FROM DUAL UNION ALL
         SELECT 'prd_c' AS prod_code, 'prod desc c' AS prod_desc, 'clr' AS weather_type_code, 'chk' AS payment_option_code, 50 AS amt, 5 AS qty  FROM DUAL UNION ALL
         SELECT 'prd_d' AS prod_code, 'prod desc d' AS prod_desc, 'cld' AS weather_type_code, 'csh' AS payment_option_code, 30 AS amt, 1 AS qty  FROM DUAL UNION ALL
         SELECT 'prd_e' AS prod_code, 'prod desc e' AS prod_desc, 'snw' AS weather_type_code, 'mbl' AS payment_option_code, 40 AS amt, 1 AS qty  FROM DUAL
        /*
          Sales Data Source:
          
          PROD_CODE PROD_DESC   weather_TYPE_CODE PAYMENT_OPTION_CODE        AMT        QTY
          --------- ----------- ----------------- ------------------- ---------- ----------
          prd_a     prod desc a clr               mbl                         10          1 
          prd_b     prod desc b rny               crd                         20          3 
          prd_c     prod desc c clr               chk                         50          5 
          prd_d     prod desc d cld               csh                         30          1 
          prd_e     prod desc e snw               mbl                         40          1 
         */
       ) 
SELECT p.prod_key, j.junk_type_key, s.amt, s.qty
  FROM pos_sales_source s
  LEFT OUTER JOIN dim_prod p
    ON s.prod_code = p.prod_code
  LEFT OUTER JOIN dim_junk j
    ON s.weather_type_code = j.weather_type_code
   AND s.payment_option_code = j.payment_option_code
;   

/*
  PROD_KEY JUNK_TYPE_KEY        AMT        QTY
---------- ------------- ---------- ----------
         3             2         50          5 
         1             4         10          1 
         4             7         30          1 
         2             9         20          3 
         5            16         40          1 
 */         