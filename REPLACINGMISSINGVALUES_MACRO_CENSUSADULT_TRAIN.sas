*Creating a macro to Identify 99, 999, 9999, 99999, 999999 values;
 
*Macro name: Find_Value.sas
Purpose: Identifies any specified value for all numeric variables
Calling arguments: dsn= sas data set name
value= numeric value to search for
Example: To find variable values of 999 in data set Test, use
%Find_Value(dsn=Test, Value=999);

%macro Find_Value(Dsn=, /* The data set name */
Value= /* Value to look for */ );
title "Variables with &Value as Missing Values in Data Set &Dsn";
data Tmp;
set &Dsn;
file print;
length Varname $ 32;
array Nums[*] _numeric_;
do iii = 1 to dim(Nums);
if Nums[iii] = &Value then do;
Varname = vname(Nums[iii]);
output;
end;
end;
keep Varname;
run;

proc freq data=Tmp;
tables Varname / out=Summary(keep=Varname Count)
nocum;
run;

proc datasets library=Work nolist;
delete Tmp;
run;
quit;
%mend Find_Value;

*Executing the Macro to find  99, 999, 9999, 99999, 999999 values;

%Find_Value(dsn=banprojs.adulttrain, Value=99);
%Find_Value(dsn=banprojs.adulttrain, Value=999);
%Find_Value(dsn=banprojs.adulttrain, Value=9999);
%Find_Value(dsn=banprojs.adulttrain, Value=99999);
%Find_Value(dsn=banprojs.adulttrain, Value=999999);

*Converting All Values of 99 and 99999 to a SAS Missing Values so we can calculate MEAN values;

Data banprojs.NINES2Missing;
set banprojs.adulttrain (keep=Capital_gain Hours_per_week);
array Nums[*] _numeric_;
do iii = 1 to dim(Nums);
if Nums[iii] = 99 then Nums[iii] = .;
else if Nums[iii] = 99999 then Nums[iii] = .;
end;
drop iii;
run;

Title "Checking Missing Values from the banprojs.NINES2Missing and calculating Mean and Median";
proc means data=banprojs.NINES2Missing n nmiss Mean Stddev Median;
run;

*Replacing SAS Missing Values with MEAN or Median:
Hours_per_Week: from the previous histogram and normal curve obtained when running Proc.
 Univariate, we can confirm this var. has a normal distribution so we will replace missing values
 with the mean (proc means does not include missing values)
Capital_gain: from the previous histogram and normal curve obtained when running Proc.
 Univariate, we cannot confirm this var. has a normal distribution. Thus we will try with both,
 mean and median and evaluate results with Proc Univariate to find out the distribution curve that
 fits better at the latest step in the project.
;

Data banprojs.Hours_nomissing;
set banprojs.NINES2Missing (keep=Hours_per_week);
if Hours_per_week = . then Hours_per_week = 40.2841791;
run;

Title 'Using PROC UNIVARIATE to examine normal distribution in Hours_per_week after replacing missing values with mean';

     proc univariate data=banprojs.Hours_nomissing;
          var Hours_per_week;
          histogram / normal;
run;


Data banprojs.Gain_nomissingM;
set banprojs.NINES2Missing (keep=Capital_gain);
if Capital_gain = . then Capital_gain = 592.2314363;
run;

Title 'Using PROC UNIVARIATE to examine normal distribution in Capital_gain after replacing missing values with mean';

     proc univariate data=banprojs.Gain_nomissingM;
          var Capital_gain;
          histogram / normal;
run;

Data banprojs.Gain_nomissingMDN;
set banprojs.NINES2Missing (keep=Capital_gain);
if Capital_gain = . then Capital_gain = 0;
run;

Title 'Using PROC UNIVARIATE to examine normal distribution in Capital_gain after replacing missing values with median';

     proc univariate data=banprojs.Gain_nomissingMDN;
          var Capital_gain;
          histogram / normal;
run;



