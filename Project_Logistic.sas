proc import datafile= "C:\Users\Sai Tallapally\Desktop\BIA_Project\student-mat_class.csv"
			out=work.Student_Maths_Class
			dbms= csv replace;
			getnames=yes;
		run;
	quit;

proc logistic data=Student_Maths;
	class sex(ref='1') address(ref='1') famsize(ref='1') Pstatus(ref='1') Mjob(ref='1') Fjob(ref='1') reason(ref='1') 
				guardian(ref='1') schoolsup(ref='1') famsup(ref='1') paid(ref='1') activities(ref='1') nursery(ref='1')
				higher(ref='1') internet(ref='1') romantic(ref='1');
	model G3_01= G1 G2 sex age address famsize Pstatus Medu Fedu Mjob Fjob reason guardian traveltime studytime failures 
				schoolsup famsup paid activities nursery higher internet romantic famrel freetime goout Dalc Walc
				health absences/ selection =forward SLENTRY= .05;
			run;
		quit;


proc logistic data=Student_Maths_Class;
 class G3_01(ref='0')/param=ref;
 model G3_01= G1 G2 age famrel absences;
 output out=log_StuMat_Class Predicted=Predict h=lev;
 run;
 quit;

