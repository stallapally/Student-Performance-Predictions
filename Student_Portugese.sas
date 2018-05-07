*******Importing Data**********;
proc import datafile= "C:\Users\Sai Tallapally\Desktop\BIA_Project\student-por_Classified.csv"
			out=work.Student_Portugese_Class
			dbms= csv replace;
			getnames=yes;
		run;
	quit;

*********Applying Regression and stepwise selection****************;
proc reg data=Student_Portugese_Class;
	model G3 = school_MS -- G2/dwprob vif stb ss1 selection =stepwise SLENTRY= .05;
	run;
quit;

**************Building Model and looking for outliers**************;
proc reg data= Student_Portugese_Class outest=est;
	model G3= reason_other failures G1 G2/dwprob;
	OUTPUT OUT=reg_Portugese PREDICTED= RESIDUAL=Res 
	rstudent=rstudent h=lev cookd=cookd dffits=dffit
	STDP=spredicted STDR=s_residual STUDENT=student;
	run;
	quit;



*********Importing Classification DataSet***************;

 proc import datafile= "C:\Users\Sai Tallapally\Desktop\BIA_Project\student-por_Classified.csv"
			out=work.Student_Portugese_Class_PF
			dbms= csv replace;
			getnames=yes;
		run;
	quit;

*****************Applied logistic and selection=stepwise*************;
proc logistic data=Student_Portugese_Class_PF descending;
	model G3_PF(event='1')= school_MS -- G2/ stb selection=stepwise slentry=0.05;
	run;
quit;

*************Build logistic model, ROC and Cross Validation Matrix**************;

proc logistic data=Student_Portugese_Class_PF plots(only)=(roc(id=prob) effect);
	class 	reason_reputation(ref='0')/param= ref;
    model G3_PF(event='1')=G1 G2 reason_reputation/ scale=none clodds=pl CLODDS=BOTH ctable	rsquare;
run;
quit;


************Applying PCA*******************;

proc princomp data=Student_Portugese_Class out=PCA_Portugese_All;
var school_MS -- G2;
run;
quit;
**********Applying Regression on Significant variables*************;

proc reg data=PCA_Portugese_All;
 model G3= Prin1 -- Prin40/dwprob vif stb ss1 selection =stepwise SLENTRY= .05;
 run;
 quit;
