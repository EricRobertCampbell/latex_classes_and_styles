%lesson class for outline
%(Mostly this exists to ensure consistent formatting)
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{outline}[2019/01/02 outlines]

%%%%%%%%%%%%%%%%%%%%% REQUIRED PACKAGES
\RequirePackage{filemod} %to indicate the revision date of the tex file
\RequirePackage{fancyhdr}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\LoadClass{article}

%rejecting packages
\newcommand{\unloadpackage}[1]{%
\@namedef{ver@#1.sty}{}
}


%%%%%%%%% Declare \unit and \course as blank - they will be re-written in the target files
\newcommand{\unit}{}
\newcommand{\course}{}

\RequirePackage[margin = 1in, letterpaper]{geometry}

%%%%%%%%%%%%%%%%%%%
%Options
\DeclareOption{format}
{
	\pagestyle{fancy}
	\fancyhf{}
	\lfoot{\course}
	\fancyfoot[C]{\ifnum\thepage=1 Rev. \filemodprint{\jobname} \else \thepage \fi}
	\rfoot{\unit}
}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax


%%%%%%%%%%%%%%%%%%%%% MISCELLANEOUS COMMANDS
\newcommand{\name}{%
	\noindent Name:\rule{4cm}{0.4pt}
}

