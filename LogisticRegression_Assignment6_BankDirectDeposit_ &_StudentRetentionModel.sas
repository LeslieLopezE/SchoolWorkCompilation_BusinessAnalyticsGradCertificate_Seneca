*Problem 1;

Title 'Figure 1: Logistic Regression - Direct Deposit Sign up';
Proc logistic data=BANK;
 model Direct (event='1') = balance ;
run;
Quit;

*Problem 2;

Title 'Figure 2: Logistic Regression - Lakeland Retention Model';
Proc logistic data=LAKELAND;
 class Program (ref='1');
 model Return (event='1') = Program GPA;
run;
Quit;

title "Using a Combination of Categorical and Continuous Variables"; proc logistic data=risk;
class Age_Group (ref='1:< 60')
Gender (ref='F') / param=ref;
model Heart_Attack (event='Yes') = Gender Age_Group Chol ;
units Chol=10; run;


