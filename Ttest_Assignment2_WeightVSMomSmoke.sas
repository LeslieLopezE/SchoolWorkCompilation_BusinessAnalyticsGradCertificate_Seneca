*Relationship between variables weight and MomSmoke. 
Assumption: If mother smokes, smoke=1 and if mother does NOT smoke, MomSmoke=0.
I'll run an unpaired t-test to find out if the weight mean is the same for babies that are born
 from smoker mothers and the ones born from non-smoker mothers.
 H0:u1=u2
 H1:u1<u2;
 
 ODS graphics on;
  *Title 'Conducting a two-sample t-test and demonstrating Weight is normally distributed';
 Proc ttest data=webwork.birth;
   class MomSmoke;
   Var Weight;
 Run;
 ODS graphics off;
 
 