 CREATE FUNCTION proc26($PARAM varchar(100)) RETURNS varchar(100) DETERMINISTIC
     BEGIN
       DECLARE $EQUAl_TRIM varchar(100);
       DECLARE $FONT_CODE varchar(100);
       DECLARE $RESULT varchar(100);
       DECLARE $RETURN_LIST varchar(100);
       DECLARE $S_POSITION int;
       DECLARE $DIFF_CODE int;
       DECLARE $SPLIT_CHA varchar(30);
       SET $RETURN_LIST = '';
       SET $EQUAl_TRIM = TRIM( '=' FROM $PARAM );
       SET $FONT_CODE = conv(hex($EQUAL_TRIM),16,10);

                   -- 変換表により変換
       SET $S_POSITION = 1;
     --  loop_conversion: LOOP
         SELECT substring($EQUAl_TRIM, $S_POSITION , $S_POSITION) into $SPLIT_CHA;
         
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
         SELECT concat($RETURN_LIST,$RESULT) into $RETURN_LIST;
      --   SET $S_POSITION  = $S_POSITION + 1;
    --	 IF  $S_POSITION >= char_length($EQUAl_TRIM) THEN 
    --	   LEAVE loop_conversion;
     --    END IF;
     --    ITERATE loop_conversion;
     --  END LOOP  loop_conversion;
       
     RETURN $RESULT;
     END;
     //
     
     
     
     
     
     
     作成中