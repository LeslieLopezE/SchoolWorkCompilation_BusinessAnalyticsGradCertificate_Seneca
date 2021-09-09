*Relationship between variables weight and black. 
Assumption: If mother is black, black=1 and if mother is NOT Black, black=0.
I'll run an unpaired t-test to find out if the weight mean is the same for babies that are born
 from a black mother and the ones born from non-black mothers.
 H0:u1=u2
 H1:u1<u2;
 

 
 ODS graphics on;
 *Title 'Conducting a two-sample t-test and demonstrating Weight is normally distributed';
 Proc ttest data=webwork.birth;
   class Black;
   Var Weight;
 Run;
 ODS graphics off;
 
 
 
 
 
