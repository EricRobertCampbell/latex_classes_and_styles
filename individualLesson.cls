%lesson class for lessons (not presentations)
%note: idea is individual lessons are their own file here
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{individualLesson}[2019/01/17 Lessons for all courses]

\LoadClass{article}


%%%%%%%%%% Required Packages
\RequirePackage{filemod}

%rejecting packages
\makeatletter
\newcommand{\unloadpackage}[1]{
\@namedef{ver@#1.sty}{}
}
\makeatother

%size of page
\RequirePackage[margin = 1in, letterpaper]{geometry}

%Header and footer
\newcommand{\course}{}
\newcommand{\unit}{}
\RequirePackage{fancyhdr}








%%%%%%%%%%%%%5
%various commands 

\newcommand{\objectivebox}[1]
{
\setlength{\fboxrule}{1pt}
\noindent\fbox{%
	\parbox{\textwidth}{%
		Objectives:
			\setlength{\itemsep}{0pt}
			#1
	}
}
\setlength{\fboxrule}{0.5pt}

}



%Options
\DeclareOption{format}
{
	\pagestyle{fancy}
	\fancyhf{}
	\lfoot{\course}
	\cfoot{\ifnum \thepage=1 Rev. \filemodprint{\jobname} \else \thepage \fi}
	\rfoot{\unit}

	%for chapter titles
	\fancypagestyle{plain}{%
	\fancyhf{}
	\lfoot{\course}
	\cfoot{\ifnum \thepage=1 Rev. \filemodprint{\jobname} \else \thepage \fi}
	\rfoot{\unit}
	}
}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax

