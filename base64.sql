 CREATE PROCEDURE proc57(IN param varchar(10))
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
         IF _FONT_CODE <= 25 THEN
           SET _DIFF_CODE = 65;
         ELSEIF _FONT_CODE <= 51 THEN
           SET _DIFF_CODE = 71;
         ELSEIF _FONT_CODE <= 61 THEN
           SET _DIFF_CODE = -4;
         ELSEIF _FONT_CODE = 62 THEN
           SET _DIFF_CODE = -19;
         ELSEIF _FONT_CODE = 63 THEN
           SET _DIFF_CODE = -16;
         END IF;
         
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
          select _RETURN_LIST;
           LEAVE label4;
         END IF;
        SELECT CONCAT(_RETURN_LIST,'=') into _RETURN_LIST;
        ITERATE label4;
       END LOOP label4;
     END;
     //