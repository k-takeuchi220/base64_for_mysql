# base64_encode_for_mysql
TO_BASE64がMYSQL5.6から出ないと使用できなかったため、自作しました。
5.5の環境で動作しています。
Google translation >
I made it myself because TO_BASE64 can not be used without MYSQL 5.6.
Works in a 5.5 environment.


・base64encode

select to_base64('test'); 
>> dGVzdA==

・base64decod

select from_base64('dGVzdA==');
>> test