%presentation class for all classes
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{presentation}[2019/04/24 Presentations for various courses - different options for each]

\LoadClass[t, 
mathserif,
hyperref = {hidelinks},
]{beamer}

%rejecting packages
\newcommand{\unloadpackage}[1]{
\@namedef{ver@#1.sty}{}
}

%rejecting packages
\unloadpackage{enumitem}

%command to put a nice(~) ending page
\newcommand{\EndFrame}{%
	\frame{
		\begin{centering}
			\begin{beamercolorbox}[sep=12pt, center]{part title}
				\usebeamerfont{section title}END\par
			\end{beamercolorbox}
		\end{centering}
	}
}

%style
%\usetheme{PaloAlto}
%\setbeamertemplate{footline}[frame number]
%\setbeamertemplate{navigation symbols}{}
%\AtBeginSection{\frame{\sectionpage}}
%
%% Dealing with Lectures appropriately
%\AtBeginLecture{\frame{
%		\vspace{\stretch{1}}
%		\begin{centering}
%			\begin{beamercolorbox}[sep=12pt, center]{title}
%				\usebeamerfont{section title}\Large Topic \thelecture: \insertlecture\par
%			\end{beamercolorbox}
%		\end{centering}
%		\vspace{\stretch{1}} %to vertically centre it
%	}
%}
%
%%Dealing with parts appropriately (here a part is a lecture, and I want it to display the lecture number and name
%%Also: include an entry in the TOC
%\providecommand\beamer@partintoc[3]{%
%	\ifnum\c@tocdepth=-1\relax
%		%requesting onlyparts
%		%\hyperref[part-\thepart]{\makebox[6em]{TOPIC #1:} #2}
%		\makebox[6em]{TOPIC #1:} #2
%		\par
%	\fi
%}
%\define@key{beamertoc}{onlyparts}[]{%
%	\c@tocdepth=-1\relax
%}
%
%\AtBeginPart{
%	%add ref to link in the TOC
%	%\label{part-\thepart}
%	%enty to toc
%	\addtocontents{toc}{\protect\beamer@partintoc{\the\c@part}{\beamer@partnameshort}{\the\c@page}}%
%
%	\frame{
%		\vspace{\stretch{1}}
%		\begin{centering}
%			\begin{beamercolorbox}[sep=12pt, center]{title}
%				\usebeamerfont{section title}\Large Topic \thepart: \insertpart\par
%			\end{beamercolorbox}
%		\end{centering}
%		\vspace{\stretch{1}} %to vertically centre it
%	}
%}


%%%%%%%%%%%%%%%%%
%Deal with options
%Pass the class as options - load specific presentation style for each one
%Anything else: pass it to the base beamer class
\DeclareOption{mathClub}{%
	\AtBeginDocument{
		\usetheme{metropolis}
		\setbeamertemplate{navigation symbols}{}
	}
}

\DeclareOption{math31}{%
	\AtBeginDocument{
		\usetheme{Singapore}
		\renewcommand{\insertnavigation}[1]{} %to remove the sections
		\setbeamertemplate{navigation symbols}{}
		}
		
	\AtBeginSection{
		\frame{
			\begin{centering}
				\begin{beamercolorbox}[sep=12pt, center]{part title}
					\usebeamerfont{section title}\insertsection\par
				\end{beamercolorbox}
			\end{centering}
		}
	}
}

\DeclareOption{programming15-I}{%
	\AtBeginDocument{%This is here to avoid a problem with loading beamer themes regularly
		\usetheme{Warsaw}
		\usecolortheme{spruce}
		\setbeamertemplate{navigation symbols}{}
	}
	\AtBeginSection{
		\frame{
			\begin{centering}
				\begin{beamercolorbox}[sep=12pt, center]{part title}
					\usebeamerfont{section title}\insertsection\par
				\end{beamercolorbox}
			\end{centering}
			}
		}
}

\DeclareOption{programming15-II}{%
%	\AtBeginDocument{
%		\usetheme{Singapore}
%		\renewcommand{\insertnavigation}[1]{} %to remove the sections
%		\setbeamertemplate{navigation symbols}{}
%		}
%		
%	\AtBeginSection{
%		\frame{
%			\begin{centering}
%				\begin{beamercolorbox}[sep=12pt, center]{part title}
%					\usebeamerfont{section title}\insertsection\par
%				\end{beamercolorbox}
%			\end{centering}
%		}
%	}
	\AtBeginDocument{
		\usetheme{metropolis}
	}
}

\DeclareOption{programmingClub}{%
	\AtBeginDocument{%This is here to avoid a problem with loading beamer themes regularly
		\usetheme{Warsaw}
		\setbeamertemplate{navigation symbols}{}
	}
	\AtBeginSection{
		\frame{
			\begin{centering}
				\begin{beamercolorbox}[sep=12pt, center]{part title}
					\usebeamerfont{section title}\insertsection\par
				\end{beamercolorbox}
			\end{centering}
			}
		}
}

\DeclareOption{math8}{%
	\AtBeginDocument{
		\usetheme{Singapore}
		\renewcommand{\insertnavigation}[1]{} %to remove the sections
		\setbeamertemplate{navigation symbols}{}
		}
		
	\AtBeginSection{
		\frame{
			\begin{centering}
				\begin{beamercolorbox}[sep=12pt, center]{part title}
					\usebeamerfont{section title}\insertsection\par
				\end{beamercolorbox}
			\end{centering}
		}
	}
}




\DeclareOption*{\PassOptionsToClass{\CurrentOption}{beamer}} %pass to base class

\ProcessOptions\relax
