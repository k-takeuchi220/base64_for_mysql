 --CREATE FUNCTION proc59($PARAM varchar(100)) RETURNS varchar(100) DETERMINISTIC
 
  CREATE PROCEDURE proc83(IN param varchar(100))
     BEGIN
       DECLARE $EQUAl_TRIM varchar(100);
       DECLARE $FONT_CODE varchar(100);
       DECLARE $RESULT varchar(100);
       DECLARE $RETURN_LIST varchar(100);
       DECLARE $TMP_LIST varchar(100);
       DECLARE $CUR int;
       DECLARE $CUR_SPL int;
       DECLARE $DIFF_CODE int;
       DECLARE $SPLIT_CHA varchar(30);
       SET $RETURN_LIST = '';
       SET $TMP_LIST = '';
       SET $EQUAl_TRIM = TRIM( '=' FROM param );
       SET $FONT_CODE = conv(hex($EQUAL_TRIM),16,10);

                   -- 変換表により変換
       SET $CUR = 1;
       SET $CUR_SPL = 1;
       loop_conversion: LOOP
         SELECT substring($EQUAl_TRIM, $CUR , 1) into $SPLIT_CHA;
         
         -- elect conv(conv(hex($SPLIT_CHA),16,10)-65,10,2);
         SELECT conv(hex($SPLIT_CHA),16,10) into $FONT_CODE;
         
         SET $DIFF_CODE =(
         CASE WHEN $FONT_CODE <=  57 THEN   4
         	  WHEN $FONT_CODE <=  90 THEN -65
         	  WHEN $FONT_CODE <= 122 THEN -71
              WHEN $FONT_CODE =   47 THEN  16
	          WHEN $FONT_CODE =   43 THEN  19
	     END);
	     
         SELECT conv($FONT_CODE + $DIFF_CODE,10,2) into $RESULT;
         
       loop_add6: LOOP
         IF CHAR_LENGTH($RESULT) % 6 = 0 THEN
           LEAVE loop_add6;
         END IF;
         SELECT CONCAT(0,$RESULT) into $RESULT;
         ITERATE loop_add6;
       END LOOP loop_add6;
       
         SELECT concat($TMP_LIST,$RESULT) into $TMP_LIST;

         SET $CUR  = $CUR + 1;
    	 IF  $CUR > char_length($EQUAl_TRIM) THEN 
    	   LEAVE loop_conversion;
         END IF;
         
         ITERATE loop_conversion;
       END LOOP  loop_conversion;
       
       -- -------------

       loop_split8: LOOP
         SELECT substring($TMP_LIST, $CUR_SPL , 8) into $SPLIT_CHA;
         
         SELECT concat($RETURN_LIST,unhex(conv($SPLIT_CHA,2,16))) into $RETURN_LIST;
         select $RETURN_LIST;
         
         SET $CUR_SPL  = $CUR_SPL + 8;
         
         select $CUR_SPL;
         select char_length($TMP_LIST);
    	 IF  $CUR_SPL >= char_length($TMP_LIST) THEN 
    	   LEAVE loop_split8;
         END IF;
                
         ITERATE loop_split8;
       END LOOP  loop_split8;
		 
       select $RETURN_LIST;
    -- RETURN $TMP_LIST;
     END;
     //
     
     
            SELECT conv(hex(param),16,2) into $SECOND;
       loop_add8: LOOP
         IF CHAR_LENGTH($SECOND) % 8 = 0 THEN
           LEAVE loop_add8;
         END IF;
         SELECT CONCAT(0,$SECOND) into $SECOND;
         ITERATE loop_add8;
       END LOOP loop_add8;
     
     
     
     作成中