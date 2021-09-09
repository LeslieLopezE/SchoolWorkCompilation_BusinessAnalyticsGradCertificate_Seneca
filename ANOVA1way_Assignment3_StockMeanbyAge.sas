*Problem 1 [10 marks] Use 5% as a significance level
In the last decade stockbrokers have drastically changed the way they do business. 
Internet trading has become quite common and online trades can cost as little as $7. 
It is now easier and cheaper to invest in the stock market than ever before. 
What are the effects of these changes? To help answer this question, 
a financial analyst randomly sampled 366 American households and asked each to report 
the age of the head of the household and the proportion of their financial assets that 
are invested in the stock market. The age categories are:
             Young (under 35)
             Early middle age (35 to 40)
             Late middle age (50 to 65)
             Senior (over 65)
The analyst was particularly interested in determining whether the ownership of stocks
varied by age. Do these data allow the analyst to determine that there are differences 
in stock ownership between the four age groups? Check the required conditions.;


*I'm working with the following hypothesis:

Null hypothesis: There is no difference in the mean of Stock Investments by Age Group:
H0 : 𝜇1= 𝜇2= 𝜇3= 𝜇4

Alternative hypothesis: At least one of the age groups differs in their mean of Stock Investments:
H1: Not all the means are equal;


ods graphics on;
Title "One-way Anova Analysis to determine whether ownership of stocks varied by Age";
Proc glm data=work.stocks_age_a2 plots= diagnostics;
 Class Age;
 Model Stock_Inv = Age /ss3;
 Means Age / hovtest;
Run;
Quit;
Ods graphics off;

