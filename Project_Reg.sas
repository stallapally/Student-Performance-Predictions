proc import datafile= "C:\Users\Sai Tallapally\Desktop\BIA_Project\student-mat.csv"
			out=work.Student_Maths
			dbms= csv replace;
			getnames=yes;
		run;
	quit;

proc reg data=Student_Maths;
	model G3= G1 G2 sex age address famsize Pstatus Medu Fedu Mjob Fjob reason guardian traveltime studytime failures 
				schoolsup famsup paid activities nursery higher internet romantic famrel freetime goout Dalc Walc
				health absences/dwprob vif stb ss1 selection =forward SLENTRY= .20;

			run;
		quit;

proc reg data=Student_Maths;
	model G3= G1 G2 sex age address famsize Pstatus Medu Fedu Mjob Fjob reason guardian traveltime studytime failures 
				schoolsup famsup paid activities nursery higher internet romantic famrel freetime goout Dalc Walc
				health absences/dwprob vif stb ss1 selection =backward SLENTRY= .20;

			run;
		quit;

	proc reg data=Student_Maths;
	model G3= G1 G2 sex age address famsize Pstatus Medu Fedu Mjob Fjob reason guardian traveltime studytime failures 
				schoolsup famsup paid activities nursery higher internet romantic famrel freetime goout Dalc Walc
				health absences/dwprob vif stb ss1 selection =stepwise SLENTRY= .20;

			run;
		quit;

proc reg data=Student_Maths;
	model G3= G1 G2 age activities romantic famrel walc absences/dwprob vif stb ss1 selection=stepwise SLENTRY=0.05;
	run;
	quit;

proc corr data=Student_Maths;
	var G1 G2 age famrel absences;
	run;
	quit;

proc reg data=Student_Maths;
 	model G3= G1 G2 age activities romantic famrel walc absences/dwprob vif stb ss1;
	OUTPUT OUT=reg_StuMat PREDICTED=Predict RESIDUAL=Res 
	rstudent=rstudent h=lev cookd=cookd dffits=dffit
	STDP=spredicted STDR=s_residual STUDENT=student;
	run;
quit;

