*Relationship between variables weight and Boy. 
Assumption: If baby is a Boy, Boy=1 and if baby is NOT baby, baby=0.
I'll run an unpaired t-test to find out if the weight mean is the same for babies that are born
 boy and the ones born girls.
 H0:u1=u2
 H1:u1<u2;
 
 *Title 'Conducting a two-sample t-test and demonstrating Weight is normally distributed';
 ODS graphics on;
 Proc ttest data=webwork.birth;
   class Boy;
   Var Weight;
 Run;
 ODS graphics off;