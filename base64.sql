 CREATE FUNCTION  proc1(param varchar(10)) RETURNS varchar(100) DETERMINISTIC
     BEGIN
       DECLARE _SECOND varchar(100);
       DECLARE _FONT_CODE varchar(100);
       DECLARE _RESULT varchar(100);
       DECLARE _RETURN_LIST varchar(100);
       DECLARE _S_POSITION int;
       DECLARE _DIFF_CODE int;
       DECLARE _SPLIT_CHA varchar(30);
       SET _RETURN_LIST = '';
    
       SELECT conv(hex(param),16,2) into _SECOND;
       label1: LOOP
    
         IF CHAR_LENGTH(_SECOND) % 8 = 0 THEN
           LEAVE label1;
         END IF;
    
        SELECT CONCAT(0,_SECOND) into _SECOND;
        ITERATE label1;
       END LOOP label1;
    

       label3: LOOP
    
         IF CHAR_LENGTH(_SECOND) % 6 = 0 THEN
           LEAVE label3;
         END IF;
    
        SELECT CONCAT(_SECOND,0) into _SECOND;
        ITERATE label3;
       END LOOP label3;
       
       SET _S_POSITION = 1;

       label2: LOOP
         SELECT SUBSTRING(_SECOND, _S_POSITION , 6) into _SPLIT_CHA;
         SELECT conv(_SPLIT_CHA,2,10) into _FONT_CODE;
         
         SET _DIFF_CODE =(
         CASE WHEN _FONT_CODE <= 25 THEN  65
	          WHEN _FONT_CODE <= 51 THEN  61
	          WHEN _FONT_CODE <= 61 THEN  -4
	          WHEN _FONT_CODE  = 62 THEN -19
	          WHEN _FONT_CODE  = 63 THEN -16
	          ELSE  null 
	     END);
         
         select unhex(conv(conv(_SPLIT_CHA,2,10)+_DIFF_CODE,10,16)) into _RESULT;
         SELECT CONCAT(_RETURN_LIST,_RESULT) into _RETURN_LIST;
         SET _S_POSITION = _S_POSITION + 6;
    	 IF _S_POSITION >= CHAR_LENGTH(_SECOND) THEN 
    	    LEAVE label2;
         END IF;
         ITERATE label2;
       END LOOP label2;

       label4: LOOP
  
         IF CHAR_LENGTH(_RETURN_LIST) % 4 = 0 THEN
           LEAVE label4;
         END IF;
        SELECT CONCAT(_RETURN_LIST,'=') into _RETURN_LIST;
        ITERATE label4;
       END LOOP label4;
       
       RETURN _RETURN_LIST;
     END;
     //