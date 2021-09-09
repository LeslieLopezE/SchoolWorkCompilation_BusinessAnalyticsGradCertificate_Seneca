
DATA BANPROJS.AdultData;
Set banprojs.adultdata;
   RENAME
     VAR1=Age 
     VAR2=Workclass
     VAR3=Fnlwgt
     VAR4=Education
     VAR5=Education_num
     VAR6=Marital_status
     VAR7=Occupation
     VAR8=Relationship
     VAR9=Race
     VAR10=Sex
     VAR11=Capital_gain
     VAR12=Capital_loss
     VAR13=Hours_per_week
     VAR14=Native_country
     VAR15=Annual_Income
     ;
RUN;

PROC CONTENTS DATA=BANPROJS.AdultData varnum;
RUN;

Title 'Listing the first 10 Observations or Adult Training Data Set';
Proc Print data=banprojs.adultdata (obs=10);
Run;

* Variable Description: 
age: the age of an individual
INTERVAL VARIABLE (NO TRUE ZERO, starts at 16. Source?
● fnlwgt: final weight. In other words, this is the number of people the census believes
the entry represents..
● education: the highest level of education achieved by an individual.
● education­num: the highest level of education achieved in numerical form.
● marital­status: marital status of an individual. Married­civ­spouse corresponds to a
civilian spouse while Married­AF­spouse is a spouse in the Armed Forces.
●occupation: the general type of occupation of an individual
Prof­specialty, Handlers­cleaners, Machine­op­inspct, Adm­clerical,
Farming­fishing, Transport­moving, Priv­house­serv, Protective­serv,
Armed­Forces.
● relationship: represents what this individual is relative to others. For example an
individual could be a Husband. Each entry only has one relationship attribute and is
somewhat redundant with marital status. We might not make use of this attribute at all

● race: Descriptions of an individual’s race

● sex: the biological sex of the individual

● capital­gain: capital gains for an individual

● capital­loss: capital loss for an individual

● hours­per­week: the hours an individual has reported to work per week

● native­country: country of origin for an individual

● the label: whether or not an individual makes more than $50,000 annually.;



Title "Checking Missing Values for Target Variable Income_Group (Categorical)";
Proc format;
  value $Count_Missing ' '   = 'Missing'
  					   other = 'Nonmissing';
run;

proc freq data=banprojs.adultdata;
tables Annual_Income / missing; 
format Annual_Income $Count_Missing.;
run;


* For the target variable Income_Group, we also need to look at the frequency table to examine
 if the dataset is balanced among the different values or not:;

Title 'Checking if values are balanced for Income_Group';
Proc Freq data=banprojs.adultdata;
Tables Annual_Income;
Run;
*75.9% of subjects earn less or equal than $50k per year


*Using PROC MEANS and PROC FREQ to Count NUMERIC Missing Values;


Title "Checking Numeric Missing Values from the banprojs.adultdata data set";
   proc means data=banprojs.adultdata n nmiss;
   run;
   
*FINDINGS: No missing NUMERIC values recorded as "." in the banprojs.adultdata set!;


Title 'Using PROC UNIVARIATE to Examine Numeric Variables Age, fnlwgt, Education_num, Capital_gain, Capital_loss, Hours_per_week  ';

       proc univariate data=banprojs.adultdata;
          var age fnlwgt Education_num Capital_gain Capital_loss Hours_per_week;
          histogram / normal;
run;

/*FINDINGS:
age: This variable does not seem to have errors or values out of range because this data set considers ages startting at 16 y-o. 
fnlwgt: This variable does not has missing values registered with "99999". However it seems to have presence of outliers. We will analyze closely later
education_num: This variable does not has missing values registered with "99". However it seems to have presence of outliers. We will analyze closely later
capital_num: the highest obs with values of 99999 are actually missing values. We will proceed to replace them with the mean of the actual values.
hours_per_week: the highest obs with values of 99 are actually missing values. We will proceed to replace them with the mean of the actual values.*/


Title 'Creating Variable ID';
DATA banprojs.adulttrain;
   SET banprojs.adultdata;
   adult_id = put(_N_,8.);
RUN;

PROC PRINT DATA=banprojs.adulttrain(FIRSTOBS=1561 OBS=1570) NOOBS;
RUN;


Title 'Checking for Invalid Values in Numerical Variables age, fnlwgt, education_num, capital_gain, capital_loss, hours_per_week';

data _null_;
file print;
Set banprojs.adulttrain (Keep=age fnlwgt education_num capital_gain capital_loss hours_per_week);

If notdigit(compress(age, ,"a")) and not missing(age) then
         put "Invalid value " age "for age in adult_id " adult_id;
If notdigit(compress(fnlwgt, ,"a")) and not missing(fnlwgt) then
         put "Invalid value " fnlwgt "for fnlwgt in adult_id " adult_id;
If notdigit(compress(education_num, ,"a")) and not missing(education_num) then
         put "Invalid value " education_num "for education_num in adult_id " adult_id;
If notdigit(compress(capital_gain, ,"a")) and not missing(capital_gain) then
         put "Invalid value " capital_gain "for capital_gain in adult_id " adult_id;
If notdigit(compress(capital_loss, ,"a")) and not missing(capital_loss) then
         put "Invalid value " capital_loss "for capital_loss in adult_id " adult_id;
If notdigit(compress(hours_per_week, ,"a")) and not missing(hours_per_week) then
         put "Invalid value " hours_per_week "for hours_per_week in adult_id " adult_id;
Run;


