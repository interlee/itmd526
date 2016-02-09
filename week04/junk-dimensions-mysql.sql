DROP TABLE IF EXISTS dim_prod;
CREATE TABLE dim_prod 
(   
  prod_key INT PRIMARY KEY AUTO_INCREMENT, 
  prod_code VARCHAR(8), 
  prod_desc VARCHAR(126)
) ;

DROP TABLE IF EXISTS dim_weather_type;
CREATE TABLE dim_weather_type 
(   
  weather_type_key INT PRIMARY KEY AUTO_INCREMENT, 
  weather_type_code VARCHAR(8), 
  weather_type_desc VARCHAR(126)
) ;

DROP TABLE IF EXISTS dim_payment_option;
CREATE TABLE dim_payment_option 
(   
  payment_option_key INT PRIMARY KEY AUTO_INCREMENT, 
  payment_option_code VARCHAR(8), 
  payment_option_desc VARCHAR(126)
) ;

DROP TABLE IF EXISTS dim_junk;
CREATE TABLE dim_junk 
(   
  junk_type_key INT PRIMARY KEY AUTO_INCREMENT,
  weather_type_code VARCHAR(8), 
  weather_type_desc VARCHAR(126), 
  payment_option_code VARCHAR(8), 
  payment_option_desc VARCHAR(126)
) ;

INSERT INTO dim_prod(prod_code, prod_desc)
SELECT a.prod_code, a.prod_desc
  FROM ( 
         SELECT 'prd_a' AS prod_code, 'prod desc a' AS prod_desc FROM DUAL UNION ALL
         SELECT 'prd_b' AS prod_code, 'prod desc b' AS prod_desc FROM DUAL UNION ALL
         SELECT 'prd_c' AS prod_code, 'prod desc c' AS prod_desc FROM DUAL UNION ALL
         SELECT 'prd_d' AS prod_code, 'prod desc d' AS prod_desc FROM DUAL UNION ALL
         SELECT 'prd_e' AS prod_code, 'prod desc e' AS prod_desc FROM DUAL
       ) a
;

INSERT INTO dim_weather_type (weather_type_code, weather_type_desc)
SELECT a.*
  FROM (
          SELECT 'clr' AS weather_type_code, 'Clear'  AS weather_type_desc FROM DUAL UNION ALL
          SELECT 'cld' AS weather_type_code, 'Cloudy' AS weather_type_desc FROM DUAL UNION ALL
          SELECT 'rny' AS weather_type_code, 'Rainy'  AS weather_type_desc FROM DUAL UNION ALL
          SELECT 'snw' AS weather_type_code, 'Snow'   AS weather_type_desc FROM DUAL  
       ) a
          /* 
              DIM_WEATHER_TYPE
          
              weather_TYPE_KEY weather_TYPE_CODE WEATHER_TYPE_DESC
              ---------------- ----------------- -----------------
                             1 clr               Clear             
                             2 cld               Cloudy            
                             3 rny               Rainy             
                             4 snw               Snow                 
          */    
;

INSERT INTO dim_payment_option (payment_option_code, payment_option_desc)
SELECT a.*
  FROM (
          SELECT 'crd' AS payment_option_code, 'Credit'  AS payment_option_desc FROM DUAL UNION ALL
          SELECT 'chk' AS payment_option_code, 'Check'   AS payment_option_desc FROM DUAL UNION ALL
          SELECT 'csh' AS payment_option_code, 'Cash'    AS payment_option_desc FROM DUAL UNION ALL
          SELECT 'mbl' AS payment_option_code, 'Mobile'  AS payment_option_desc FROM DUAL     
    
          /* 
              DIM_PAYMENT_OPTION
              
              PAYMENT_OPTION_KEY PAYMENT_OPTION_CODE PAYMENT_OPTION_DESC
              ------------------ ------------------- -------------------
                               1 crd                 Credit              
                               2 chk                 Check               
                               3 csh                 Cash                
                               4 mbl                 Mobile                   
           */
       ) a 
;

INSERT INTO dim_junk(weather_type_code, weather_type_desc, payment_option_code, payment_option_desc)
SELECT w.weather_type_code, w.weather_type_desc, po.payment_option_code, po.payment_option_desc
  FROM dim_weather_type w, dim_payment_option po
;

--
-- Populating Fact
--

-- Option 1: without the DIM_JUNK
SELECT p.prod_key, w.weather_type_key, po.payment_option_key, s.amt, s.qty
  FROM 
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
       ) s
  LEFT OUTER JOIN dim_prod p
    ON s.prod_code = p.prod_code
  LEFT OUTER JOIN dim_weather_type w
    ON s.weather_type_code = w.weather_type_code
  LEFT OUTER JOIN dim_payment_option po
    ON s.payment_option_code = po.payment_option_code

/*
prod_key  weather_type_key  payment_option_key     amt     qty  
--------  ----------------  ------------------  ------  --------
       2                 3                   1      20         3
       3                 1                   2      50         5
       4                 2                   3      30         1
       1                 1                   4      10         1
       5                 4                   4      40         1
 */
;    

-- Option 2: with the DIM_JUNK
SELECT p.prod_key, j.junk_type_key, s.amt, s.qty
  FROM 
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
       ) s
  LEFT OUTER JOIN dim_prod p
    ON s.prod_code = p.prod_code
  LEFT OUTER JOIN dim_junk j
    ON s.weather_type_code = j.weather_type_code
   AND s.payment_option_code = j.payment_option_code

/*
prod_key  junk_type_key     amt     qty  
--------  -------------  ------  --------
       2              3      20         3
       3              5      50         5
       4             10      30         1
       1             13      10         1
       5             16      40         1 
 */
;  