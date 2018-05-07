************Importing Maths data to work**************;
proc import datafile= "C:\Users\Sai Tallapally\Desktop\BIA_Project\student-mat_Classified.csv"
			out=work.Student_Maths_Class
			dbms= csv replace;
			getnames=yes;
		run;
	quit;
********Applying Regression stepwise****************;
proc reg data=Student_Maths_Class;
	model G3 = school_MS -- G2/dwprob vif stb ss1 selection =stepwise SLENTRY= .05;
	run;
quit;


***********Applying regression on significant variables**************;
proc reg data= Student_Maths_Class outest=est;
	model G3= age famrel absences G1 G2/dwprob;
	run;
	quit;


****************Importing Classified dataset into work library with data name- Student_Maths_Class_PF*************;
 proc import datafile= "C:\Users\Sai Tallapally\Desktop\BIA_Project\student-mat_Classified_PF.csv"
			out=work.Student_Maths_Class_PF
			dbms= csv replace;
			getnames=yes;
		run;
	quit;

***************Applying Logisitc Model and Selection******************;
proc logistic data=Student_Maths_Class_PF descending;
	model G3_PF(event='1')= school_MS -- G2/selection=stepwise slentry=0.05 ;
	run;
quit;


********Applying logistic model using only the significant variables************;
proc logistic data=Student_Maths_Class_PF plots(only)=(roc(id=prob) effect);
	class school_MS(ref='0') Mjob_athome(ref='0') Mjob_services(ref='0') Fjob_other(ref='0')/param= ref;
    model G3_PF(event='1')=school_MS age Mjob_athome Mjob_services  Fjob_other studytime famrel G1 G2/ scale=none
                            clodds=pl
							CLODDS=BOTH
							ctable
					 		rsquare; 
   run;

************Applying PCA*****************;
proc princomp data=Student_Maths_Class out=PCA_Maths_All;
var school_MS -- G2;
run;
quit;

***********Applyiing Regression on Principal Components***************; 
proc reg data=PCA_Maths_All;
 model G3= Prin1 -- Prin40/dwprob vif stb ss1 selection =stepwise SLENTRY= .05;
 run;
 quit;
