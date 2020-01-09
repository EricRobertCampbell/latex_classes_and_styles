%lesson class for assessments of all kinds
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{assessment}[2019/10/31 all kinds of assessments - quizzes, assignments, and unit tests]




%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\LoadClass[twoside, addpoints, 12pt]{exam}
\bracketedpoints
\pointname{}
\bonuspointpoints{(bonus)}{(bonus)}
\RequirePackage{color}
\CorrectChoiceEmphasis{\color{red}\bfseries}
\SolutionEmphasis{\color{red}\bfseries}

%%%%%%%%%%%%%%%%%%%%% REQUIRED PACKAGES
\RequirePackage{tikz}
\usetikzlibrary{positioning}
\RequirePackage{filemod} %to indicate the revision date of the tex file
%\RequirePackage{datetime2}
\RequirePackage{url}
\RequirePackage{endnotes} %to make it possible to collect all the answers at the back
\RequirePackage{etoolbox} %hopefully - fix the answers command!
\RequirePackage{xparse} %Used to help deal with getting answers at the end
%\RequirePackage{answersatend} % Attempt to get answers at the end!
\RequirePackage{ifthen}
\RequirePackage{totcount} %to keep track of the total number of different kinds of questions
\RequirePackage[utf8]{inputenc}
\RequirePackage{booktabs}
\RequirePackage{pdfpages}



% To deal with the different versions (A, B, C, D)
% If there is no version, then load the exam-randomizechoices package with the norandomize option (basically just pretend that it doesn't exist)
% Otherwise, parse \jobname to find the specific version and set that as a macro
% Use the value of that macro to set the random seed
\RequirePackage{xstring}

\newcommand{\assessmentVersion}{template}

\IfSubStr*{\jobname}{versionA}
{\def \assessmentVersion{A}}{}
\IfSubStr*{\jobname}{versionB}
{\def \assessmentVersion{B}}{}
\IfSubStr*{\jobname}{versionC}
{\def \assessmentVersion{C}}{}
\IfSubStr*{\jobname}{versionD}
{\def \assessmentVersion{D}}{}

%If it's the template then load without randomization; otherwise, randomize!
\ifthenelse{\equal{\assessmentVersion}{template}}
{
	\PassOptionsToPackage{norandomize}{exam-randomizechoices}
}
{} %don't do anything special
\RequirePackage{exam-randomizechoices}

%Set the random seed as per the assessment version A -> 100, B -> 200, &c.
\ifthenelse{\equal{\assessmentVersion}{template}}
{\setrandomizerseed{0}}{}
\ifthenelse{\equal{\assessmentVersion}{A}}
{\setrandomizerseed{100}}{}
\ifthenelse{\equal{\assessmentVersion}{B}}
{\setrandomizerseed{200}}{}
\ifthenelse{\equal{\assessmentVersion}{C}}
{\setrandomizerseed{300}}{}
\ifthenelse{\equal{\assessmentVersion}{D}}
{\setrandomizerseed{400}}{}


%for checking the value of the random seed
\def \pgfcurrentseed{\pgfmathparse{\pgfmath@rnd@z}\pgfmathresult}





%%%%% Determining the base job name
% So far the only what that this gets modified is by adding -version? or -solutions to the end
% SO: use xstring to strip that part out and we should get the real job name (for passing into the filemod nonsense)

\IfSubStr*{\jobname}{-version}
{% if true
	\StrBefore*{\jobname}{-version}[\realjobname]
}
{% if false, then check for -solutions
	\IfSubStr*{\jobname}{-solutions}
	{% if true
		\StrBefore*{\jobname}{-solutions}[\realjobname]
	}
	{% if false, then no modifications!
		\newcommand{\realjobname}{\jobname}
	}
}




% For answers at end
\newboolean{aae} %answers at end?



%rejecting packages
\newcommand{\unloadpackage}[1]{%
\@namedef{ver@#1.sty}{}
}


\newcommand{\answer}[1]
{
	\begin{solution} #1 \end{solution}
}

%%%%%%%%% Declare \unit and \course as blank - they will be re-written in the target files
\newcommand{\unit}{}
\newcommand{\course}{}

\unloadpackage{framed}

\RequirePackage[margin = 1in, letterpaper]{geometry}



%%%%%%%%%%%%%%%%%%%% COUNTERS
\newtotcounter{mccount}\setcounter{mccount}{1} %how many multiple choice questions?
\newcounter{nrcount} % how many numerical response questions?
\newcounter{wrcount} % how many written response questions?


%%%%%%%%%%%%%%%%%%%% TIKZ PICS
\tikzset{
	mcBubbles/.pic = 
	{
		\foreach \letter/\position in {A/1, B/2, C/3, D/4}
		{
			\node[draw, circle, inner sep = 1pt] at (\position, 0) {\letter};
		}
	},
	NRBox/.pic = 
	{
		\foreach \x in {0, 0.5, 1, 1.5}
		{
			\draw (\x,0) rectangle (\x+0.5,1);
		}
	},
}



%%%%%%%%%%%%%%%%%%%%%%% ENVIRONMENTS
\newenvironment{colchoices}[1]
{
	\begin{multicols}{#1}
		\begin{choices}
}
{
		\end{choices}
	\end{multicols}
}

%CURRENTLY DOESN'T WORK
\newenvironment{colrchoices}[1]
{
	\begin{multicols}{#1}
		\begin{randomizechoices}
}
{
		\end{randomizechoices}
	\end{multicols}
}

\newenvironment{mcquestions}
{
	\begin{questions}
}
{
	\setcounter{mccount}{\thequestion}
	\end{questions}
}

\newenvironment{nrquestion}
{
	\nrformat
}
{
	\noqformat
}



%%%%%%%%%%%%%%%%%%%%% MISCELLANEOUS COMMANDS
\newcommand{\name}{%
	\noindent Name:\rule{4cm}{0.4pt}
}

\newcommand{\namepoints}{%
	\ifprintanswers
		\noindent Name: {\Large \textbf{\textcolor{red}{KEY}}}\null\hfill/\numpoints\\
	\else
		\name\null\hfill/\numpoints\\
	\fi
}

\newcommand{\generateMCAnswers}[1]
{
		%\ifprintanswers
		%	\begin{enumerate}
		%		\foreach \x in {1,...,#1}
		%		{
		%			\item~\ref{question@\x@correctchoice}
		%		}
		%	\end{enumerate}
		%\else
			\begin{enumerate}
				\foreach \x in {1,...,#1}
				{
					\item \resizebox{!}{\baselineskip}{ \tikz \pic{mcBubbles}; }
			}
			\end{enumerate}
		%\fi
}


%%%%%%%%%%%
% Currently doesn't work
\newcommand{\mcanswers}
{
	\ifnum\totvalue{mccount}<1
		FIRST RUN
	\else
		\foreach \x in {1,...,\totvalue{mccount}}
		{
			\x:~\ref{question@\x@correctchoice}
		}
	\fi
}

\newcommand{\NRBox}{\tikz \pic{NRBox};} 

\newcommand{\NRBoxLong}[1]{%
	\resizebox{#1}{!}{
		\begin{tikzpicture}[
				circled/.style = {
					draw,
					circle,
					inner sep = 1pt,
					minimum width=25pt,
				},
				nrb/.style = {
					thick,
				}
				]
			\pgfmathsetmacro{\x}{0.7pt}
			\pgfmathsetmacro{\y}{1pt}
			\pgfmathsetmacro{\lh}{0.5pt}
			\pgfmathsetmacro{\h}{2*\lh}

			%Middle of each entry box
			\coordinate (1) at (0,0);	
			\coordinate[right = 2*\x of 1] (2);	
			\coordinate[right = 2*\x of 2] (3);	
			\coordinate[right = 2*\x of 3] (4);	
			%\tkzDrawPoints(1,2,3,4)
			%\tkzLabelPoints(1,2,3,4)

			%Corners of the entry box
			\coordinate[above left = \y and \x of 1] (A);
			\coordinate[below left = \y and \x of 1] (C);
			\coordinate[below right = \y and \x of 4] (D);
			\coordinate[above right = \y and \x of 4] (B);
			%\tkzLabelPoints(A,B,C,D);

			%places where the vertical lines intersect the box
			\coordinate[above left = \y and \x of 2] (c1);
			\coordinate[above left = \y and \x of 3] (c2);
			\coordinate[above left = \y and \x of 4] (c3);
			%\tkzLabelPoints(c1,c2,c3)

			\draw[nrb] (A) -- (B) -- (D) -- (C) -- cycle;
			\draw[nrb] (c1) |- (C);
			\draw[nrb] (c2) |- (C);
			\draw[nrb] (c3) |- (C);

			\node[below = \y + \lh of 1] (c00) {};
			\node[circled, below = \y+\lh of 2, anchor = center] (c01) {\textbullet};
			\node[circled, below = \y+\lh of 3, anchor = center] (c02) {\textbullet};
			\node[below = \y + \lh of 4] (c03) {};

			\foreach \level in {0,...,9}
			{
				\node[circled, below = \y+\lh+ \h + \level*\h of 1, anchor = center] (c0\level) {\level};
				\node[circled, below = \y+\lh+\h+\level*\h of 2, anchor = center] (c1\level) {\level};
				\node[circled, below = \y+\lh+\h+\level*\h of 3, anchor = center] (c2\level) {\level};
				\node[circled, below = \y+\lh+\h+\level*\h of 4, anchor = center] (c3\level) {\level};
			}
			\coordinate[below = 13cm of A] (X);

			\draw[nrb] (A) |- (X);
			\draw[nrb] (B) |- (X);
			\draw[nrb] (c1) |- (X);
			\draw[nrb] (c2) |- (X);
			\draw[nrb] (c3) |- (X);

		\end{tikzpicture}
	}%resizebox
}


\newcommand{\generateNRAnswers}[1]
{
	\begin{enumerate}
		\foreach \x in {1,...,#1}
		{
			\noindent\begin{minipage}{\columnwidth} \item \hspace{0pt} \\ \tikz \pic{NRBox}; \end{minipage} 

			\vspace{\baselineskip}
		}
	\end{enumerate}
}

\newcommand{\generateNRAnswersLong}[1]
{
	\begin{enumerate}
		\foreach \x in {1,...,#1}
		{
			\noindent\begin{minipage}{\columnwidth} \item \hspace{0pt} \\ \NRBoxLong{2.5cm} \end{minipage} 

			\vspace{\baselineskip}
		}
	\end{enumerate}
}

%Sets a format for NR questions
% (For when there are mixed multiple choice and numerical response questions)
\newcommand{\nrformat}{%
	\qformat{[\thepoints]\ \textbf{Numerical Response Question \thenrcount}  \hfill}
	\stepcounter{nrcount}
	\addtocounter{question}{-1} %so that it doesn't mess up the counting for MC questions
}

\newcommand{\workpage}{% Command to give a work page at the end
	\cleardoublepage

	This page left (mostly) blank for additional work. No work done on this page will be marked.
}

\newcommand{\makeUnitTestTitlePage}
{
	\namepoints
	\vspace{1in}
	\begin{center}
		{\Large \course \par Unit Test \par \unit \par Version: \assessmentVersion \par {}}
	\end{center}
	\vspace{1in}

	\newpage
}

\newcommand{\instructionText}[1]{% Instruction Text!
	\begin{center}
		{\footnotesize \textit{#1}}
	\end{center}
}




%%%%%%%%%%%%%%%%%%%
%Options
\DeclareOption{format} %setting page margins, &c.
{
	\pagestyle{headandfoot}
	\lfoot{\course}
	\cfoot{\thepage}
	\rfoot{\unit}
	\firstpagefooter{}{Rev. \filemodprint{\realjobname}}{}

	\chead{\@title}
}

\DeclareOption{answersatend}
{
	%%%%%%% Printing the answers at the end
	%\AtEndDocument{
	%\ifprintanswers
	%	\newpage
	%	%%%%%%%%%%%%

	%	%\PrintAllAnswers
	%\fi
	%}
	\setboolean{aae}{true} %Check after options for the actual effect
}

\DeclareOption{confidence} %add a litttle thing to each question for the students to monitor their confidence
{
	\qformat{\thequestion. [\thepoints]\dotfill C [0-10]\rule{2cm}{0.4pt}}
	
	\newcommand{\calculatetotalpoints}{\@ifundefined{exam@numpoints}{0}{\exam@numpoints}}

	\renewcommand{\namepoints}{%
		\ifprintanswers
			%\noindent Name: {\Large \textbf{\textcolor{red}{KEY}}}\hfill/\numpoints{} * 10 \relax\\
			\noindent Name: {\Large \textbf{\textcolor{red}{KEY}}}\hfill/\theconfidencepoints\\
		\else
			%\name\null\hfill/\numpoints{} * 10 \\
			\noindent\name\hfill/\theconfidencepoints\\
		\fi
	}

	\newcounter{confidencepoints}
	\AtBeginDocument{%
		\setcounter{confidencepoints}{\the\numexpr\calculatetotalpoints * 10\relax}
	}
} %confidence option


\DeclareOption*{\PassOptionsToClass{\CurrentOption}{exam}}
%\ExecuteOptions{answersatend}
\ProcessOptions\relax

% Additional processing for answers at the end
\ifthenelse{\boolean{aae}}
{
	\RequirePackage{answersatend}
	\AtEndDocument{
		\ifprintanswers
			\newpage

			\section*{Answers}
			\PrintAllAnswers
		\fi
	}
}{}


