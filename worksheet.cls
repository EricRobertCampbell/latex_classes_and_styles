%lesson class for assessments of all kinds
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{worksheet}[2019/03/16 Worksheets - questions and answers]




%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\LoadClass[twoside, addpoints, answersatend]{assessment}

%%%%%%%%%%%%%%%%%%%
%Options

\DeclareOption{format} %setting page margins, &c.
{
	\pagestyle{headandfoot}
	\chead{\@title}
	\lfoot{\course}
	\cfoot{\thepage}
	\rfoot{\unit}
	\firstpagefooter{}{Rev. \filemodprint{\jobname}}{}
}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{assessment}}
\ProcessOptions\relax

%%%%%%%%%%%%%%%%%%%%% MISCELLANEOUS COMMANDS
\newcommand{\questsoln}[2]{
	\question #1
	\answer{#2}
}

\newcommand\secline{%
\par %make sure we end the paragraph
\vskip5pt %space above the rule
\leaders\vrule width \textwidth\vskip0.4pt %rule thickness is 0.4pt
\nointerlineskip %disable interline glue here
\vskip5pt %space below
}
