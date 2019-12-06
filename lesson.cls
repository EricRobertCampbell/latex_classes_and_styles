%lesson class for lessons (not presentations)
%note: idea is that this is for the entire unit - individual topics are their own tex files
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{lesson}[2019/10/31 Lessons for all courses]

\LoadClass{book}

%rejecting packages
\makeatletter
\newcommand{\unloadpackage}[1]{
\@namedef{ver@#1.sty}{}
}
\makeatother

%size of page
\RequirePackage[margin = 1in, letterpaper]{geometry}

%for playing with the chapter/topic headings
%\RequirePackage{titlesec}
%\titleformat{\chapter}[hang]{\bfseries\huge}{Topic \thechapter~ - ~}{0pt}{}{}
%\titlespacing{\chapter}{0pt}{*0}{0pt}
%\renewcommand{\chaptername}{Topic}

\RequirePackage[utf8]{inputenc}

\RequirePackage{tikz}
\tikzset{
	NRBox/.pic = 
	{
		\foreach \x in {0, 0.5, 1, 1.5}
		{
			\draw (\x,0) rectangle (\x+0.5,1);
		}
	},
}


%Header and footer
\newcommand{\course}{}
\newcommand{\unit}{}
\RequirePackage{fancyhdr}








%%%%%%%%%%%%%5
%various commands 

\newcommand{\NRBox}{\tikz \pic{NRBox};} 

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
	\cfoot{\thepage}
	\rfoot{\unit}

	%for chapter titles
	\fancypagestyle{plain}{%
	\fancyhf{}
	\lfoot{\course}
	\cfoot{\thepage}
	\rfoot{\unit}
	}
}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax

