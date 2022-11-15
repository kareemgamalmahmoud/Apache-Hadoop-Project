--we need to load the data at first then we will use FILTER and matches commands to return all the lines that contains ('WH...' and '?')
--then we will remove question mark and by using TOKENIZE command to split the chararray lines to words by using space 
--and by using FLATTEN command to vectorize the result make all the words in one column
--Note: We will only return words that start with (Wh)
--Then we will group the similar words together such as (What,{(What),(What),(What)})
--Then we will count the result of grouping statement by using COUNT() command
--Finally Running the script
whquestions = LOAD '/user/osboxes/Lab3_21kgmm/whquestion.txt' as (whWords:chararray);
F = FILTER whquestions BY  (whWords  matches 'Wh.*' and whWords  matches '.*?.*');
remove_qmark = FOREACH F GENERATE REPLACE(whWords,'([^a-zA-Z\\s]+)','') as X;
tokens = FOREACH remove_qmark GENERATE FLATTEN(TOKENIZE(X)) AS whWord;
WH = FILTER tokens BY (whWord  matches 'Wh.*');
word_Grouping = GROUP WH BY whWord ;
word_count = FOREACH word_Grouping GENERATE group, COUNT(WH);
Dump word_count ;
