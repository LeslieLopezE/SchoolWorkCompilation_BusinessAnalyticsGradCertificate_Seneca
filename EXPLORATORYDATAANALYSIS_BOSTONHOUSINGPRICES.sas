Data BANPROJS.BostonHousePx;
 Set BANPROJS.BostonHousePx;
 
Title 'Testing the normality of all variables';
 Proc univariate data=BANPROJS.BostonHousePx noprint;
 probplot / normal (mu=est sigma=est);
 Run;
 
 
 Title 'Exploratory Data Analysis - Scatter Plot Matrix';
 Proc SGSCATTER data=BANPROJS.BostonHousePx;
  matrix age B Chas Indus PTRatio MedV/diagonal=(histogram);
 Run;
 
 Title 'Exploratory Data Analysis - Scatter Plot Matrix';
 Proc SGSCATTER data=BANPROJS.BostonHousePx;
  matrix  crim LStat nox rad MedV/diagonal=(histogram);
 Run;
 
 Title 'Exploratory Data Analysis - Scatter Plot Matrix';
 Proc SGSCATTER data=BANPROJS.BostonHousePx;
  matrix rm tax dis ZN MedV/diagonal=(histogram);
 Run;

 Title 'Calculating the probability for categorical variables';
 Proc Freq data=BANPROJS.BostonHousePx;
 Tables chas rad;
 Run;