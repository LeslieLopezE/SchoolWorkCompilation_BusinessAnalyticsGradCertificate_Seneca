*Relationship between variables weight and Married. 
Assumption: If mother is married, married=1 and if mother is NOT married, married=0.
I'll run an unpaired t-test to find out if the weight mean is the same for babies that are born
 from married mothers and the ones born from non-married mothers.
 H0:u1=u2
 H1:u1<u2;
 
 ODS graphics on;
  *Title 'Conducting a two-sample t-test and demonstrating Weight is normally distributed';
 Proc ttest data=webwork.birth;
   class Married;
   Var Weight;
 Run;
 ODS graphics off;
 
 