%% dukedissertation -- a document class for dissertations and theses

%% Modified by Huarui Zhou, 2026.
%% This version is based on the Duke University Theses/Dissertations
%% Template maintained by Leon Riesebos, Michael Gao, and earlier contributors.
%%
%% Modifications include updated Duke margin compliance, typography,
%% font configuration, heading design, and title-page formatting.
%%
%% Distributed under the LaTeX Project Public License v1.3c.

%% 2026-09-14  - Huarui Zhou
%% Updated and customized the class for current Duke dissertation formatting and typography:
%%  - Enforced fixed Duke margins on every page: 1.5in left, 1in top/right/bottom,
%%    with the bottom margin measured below the page number
%%  - Increased the main body text to 14pt and adjusted line spacing
%%  - Set Libertinus Serif and Libertinus Math as the document fonts
%%  - Reduced excessive hyphenation using microtype and revised hyphenation penalties
%%  - Redesigned chapter and front-matter headings with centered, bold typography
%%  - Increased spacing between major headings and the following text
%%  - Updated title and abstract title pages to support the graduate program field
%%  - Refined title-page typography and vertical spacing

%% conforming to the 2026 Duke University guidelines.  This class is by
%% Michael Gao. It is based on classes previously developed by:
%% Mitchell Abrams, Leon Riesebos, Michael Gratton,  Mark Holliday, Charlie Martin, Russ Tuck,
%% Sean O'Connell, Michael Todd, Syam Gadde, Rajiv Wickremesinghe, and Hugh Crumley
%% It is based on a long lineage of trying to maintain compliance of this .cls file with
%% ETD guidelines released by the University.

%% I've tried to reproduce the history as far as I can find it

%% If you need a reference to an older version of the classfile, Leon Riesebos has a great
%% starter point -
%% https://gitlab.com/lriesebos/duke-theses-dissertations-template

%% Changelog (may not be complete based on information found on the internet)
%% 2025-08-13  - Michael Gao
%% Added:
%%  - Spacing fixes for pages so that the page numbers end up in the right space
%%  - Table of contents indentation stuff
%%  - Title spacing adjustments based on feedback from Duke Graduate School

%% Nov 5, 2023  - Leon Riesebos
%%    Title and abstract page fixes based on a new 2023 template guidelines
%%    from the Duke Graduate School.
%%
%% Version 1.1
%% July 17, 2023  - Leon Riesebos
%%    Table of content fixes and minor other tweaks and improvements based on
%%    feedback from the Duke Gratuate School.
%%
%% Version 1.0
%% July 15, 2023  - Leon Riesebos
%%    Various fixes and improvements were made to modernize the template and
%%    make it compilable again with recent LaTeX versions.
%%    Additional formatting changes were made on request of the Duke Graduate
%%    School to conform with the formatting guidelines.
%%    All sources are available in a git repository:
%%    https://gitlab.com/lriesebos/duke-theses-dissertations-template
%%
%% Version 0.41
%% August 8, 2014  - Peter Hollender (peterhollender@gmail.com)
%% 		Just one tiny change: made title single-spaced on both the title
%%		and abstract title pages.
%%
%% Version 0.40
%% October 27, 2008  - Michael Gratton (mgratton@math.duke.edu)
%%
%% This class conforms to the 2007 style guidelines for dissertations,
%% including:
%% 1) Page numbers centered in the footer of each page
%% 2) Margins: 1in top, 1in right, 1.5in left, 1in below footer
%% 3) Title signature page, UMI abstract title signature page, and copyright
%%    page automatically generated at \maketitle
%% 4) 'Double' spacing throughout body text (really about 10pt extra instead
%%    of 12pt extra, but it passes)
%% 5) Single spacing in the Table of Contents, List of Tables, List of
%%    Figures, Bibliography, and in chapter, section titles, and figure/table
%%    captions.
%% 6) Footnotes are numbered consecutively within a chapter and placed at the
%%    bottom of the page on which the reference number appears.
%% 7) Page ordering and numbering: roman numeral page numbers appear
%%    in the frontmatter (prior to the introduction or Chapter 1).  The first
%%    numbered page is the Abstract (usuall iv).  Arabic numbering from '1'
%%    starts in the Introduction or Chapter 1 if there's no Introduction.
%% 8) Optional material supported:
%%    *Dedication
%%    *Acknowledgements
%%    *Introduction (different from 'Chapter 1: Introduction')
%%    *Appendices




\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{dukedissertation2025}[Duke Dissertation Style, updated for 2025 guidelines]
\RequirePackage{graphicx}
\RequirePackage{ifthen}
\RequirePackage{tocloft}

% Internal logic (replicates some book.cls features)
\newif\if@frontmatter
\@frontmattertrue
\newif\if@inappendix
\@inappendixfalse

% Option switches and their default values
\newif\if@Gradschool  % Produce extra frontmatter for grad school
\newif\if@MS  % Masters thesis format
\newlength\@SimSpace  % double-space
\newlength\@OpenupSpace
\newboolean{centerpage}


\DeclareOption{economy}{%  Set a bunch of options at once
  \ExecuteOptions{singlespace,nogradschool,nobind}
}
\DeclareOption{gradschool}{\@Gradschooltrue}
\DeclareOption{nogradschool}{\@Gradschoolfalse}
\DeclareOption{MS}{\@MStrue}
\DeclareOption{PhD}{\@MSfalse}
\DeclareOption{nobind}{\setboolean{centerpage}{true}}
\DeclareOption{bind}{\setboolean{centerpage}{false}}
\DeclareOption{doublespace}{%
	\setlength\@SimSpace{10pt} % Simulated double-space skip
	\setlength\@OpenupSpace{3\jot}
}
\DeclareOption{singlespace}{%
	\setlength\@SimSpace{\z@}  % Zero simulated double-space
	\setlength\@OpenupSpace{\z@}
}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ExecuteOptions{gradschool,PhD,doublespace,bind}
\ProcessOptions\relax
\LoadClass[12pt,letterpaper]{book}
% 14pt body text
\renewcommand\normalsize{%
    \@setfontsize\normalsize{14pt}{19pt}%
}
\normalsize


%Reduce the hyphenation
\RequirePackage{microtype}
\hyphenpenalty=800
\exhyphenpenalty=800
\emergencystretch=1em

% Set body/math font to Libertinus Serif
\RequirePackage{fontspec}
\RequirePackage{unicode-math}
\setmainfont{Libertinus Serif}
\setmathfont{Libertinus Math}

% Chapter/front-matter headings are formatted explicitly below.
% Keep the standard names free of font commands so they inherit that style.
\renewcommand{\contentsname}{Table of Contents}
\renewcommand{\listfigurename}{List of Figures}
\renewcommand{\listtablename}{List of Tables}

% Float parameters.  Allow more float per page, open up spacing
\renewcommand{\topfraction}{.75}
\renewcommand{\bottomfraction}{.75}
\renewcommand{\textfraction}{.15}  % About 3 lines of double-spaced text
\renewcommand{\floatpagefraction}{.8}
\renewcommand{\dbltopfraction}{.97}
\renewcommand{\dblfloatpagefraction}{.9}
\setlength{\floatsep}{12pt plus 6pt minus 4pt}
\setlength{\textfloatsep}{15pt plus 8pt minus 5pt}
\setlength{\intextsep}{12pt plus 6pt minus 4pt}
\setlength{\dblfloatsep}{12pt plus 6pt minus 4pt}
\setlength{\dbltextfloatsep}{15pt plus 8pt minus 5pt}
% Float pages have floats near the top of the page
\setlength{\@fptop}{12pt minus 6pt}% removed ``plus 1fil''
\setlength{\@fpsep}{24pt plus 12pt minus 12pt}% removed ``plus 2fil''
\setlength{\@fpbot}{0pt plus 1fil}
\setlength{\@dblfptop}{0pt}% removed ``plus 1fil''
\setlength{\@dblfpsep}{24pt plus 12pt minus 12pt}% removed ``plus 2fil''
\setlength{\@dblfpbot}{0pt plus 1fil}



%-----------------------------------------------------------
%       DOUBLE    S P A C I N G:
% Most of the bother in the thesis format is in the disgusting double
% spacing requirements.  We handle it by a bit of plain TeX.  The
% \openup command increases the space between baselines unscaled by font
% size.  Double-spacing is
% turned off by the macro \normalbaselines in figure captions, the toc,
% lof, lot, and bibliography.  In the later four, we FAKE double-spacing,
% typically with a \@SimSpace vertical space between entries.
% -----------------------------------------------------------
\newcommand{\@textspace}{\openup \@OpenupSpace\relax}


%-----------------------------------------------------------------------
% Names of environments
%-----------------------------------------------------------------------
\newcommand\biographyname{Biography}
\newcommand\ackname{Acknowledgements}
\newcommand\loaname{List of Abbreviations and Symbols}

%-----------------------------------------------------------------------
%% Page size specifications -- Duke margin requirements
%-----------------------------------------------------------------------
%% Letter paper: 8.5in x 11in
%% Required margins on EVERY page:
%%   left   = 1.5in
%%   right  = 1.0in
%%   top    = 1.0in
%%   bottom = 1.0in measured from BELOW the page number
%%
%% LaTeX places the text block 1in from the physical page origin before
%% applying \oddsidemargin/\evensidemargin and \topmargin. Therefore:
%%   1in + 0.5in = 1.5in physical left margin
%%   text width = 8.5in - 1.5in - 1.0in = 6.0in
%%
%% Use the same left margin on odd and even pages. Duke requires a
%% 1.5in LEFT margin on all pages, not mirrored binding margins.
\setlength{\hoffset}{0pt}
\setlength{\oddsidemargin}{0.5in}
\setlength{\evensidemargin}{0.5in}
\setlength{\textwidth}{6in}

%% No running header is used. Setting headsep to zero makes the top of
%% the text block exactly 1in from the physical top edge:
%%   1in + topmargin + headheight + headsep = 1in.
\setlength{\voffset}{0pt}
\setlength{\topmargin}{0pt}
\setlength{\headheight}{0pt}
\setlength{\headsep}{0pt}

%% Footer/page-number placement.
%% The footer baseline is 0.35in below the text block. A text height of
%% 8.60in puts that baseline 1.05in above the physical bottom edge:
%%   11in - (1in + 8.60in + 0.35in) = 1.05in.
%% The extra 0.05in accommodates the depth of the page-number glyphs, so
%% the BOTTOM of the printed page number remains at least 1in above the
%% page edge, as required by Duke.
\setlength{\footskip}{0.35in}
\setlength{\textheight}{8.60in}

%----------------------------------------------------------------------
% Variables for titlepages
%----------------------------------------------------------------------
\newcommand{\department}[1]{\gdef\@department{#1}}
\newcommand{\program}[1]{\gdef\@program{#1}}
%\newcommand{\subject}[1]{\gdef\@subject{#1}}
\newcommand{\supervisor}[1]{\gdef\@supervisor{#1}}
\newcommand{\copyrighttext}[1]{\gdef\@copyrighttext{#1}}
% Set default values
\department{??DEPARTMENT??}
\program{??PROGRAM??}
%\subject{\@department}
\supervisor{??ADVISOR??}
\date{\number\year}
\newcommand{\defensedate}[1]{\gdef\@defensedate{#1}}
\defensedate{[Month Day, Year]}
\copyrighttext{All rights reserved}
% Count the number of members, include supervisor
\newcounter{@members}           % Number of member macros defined so far.
\newcommand{\@membera}{\@member{\@supervisor, Advisor}}
\setcounter{@members}{1}        % Supervisor is always 1st member
% Members must be counted . . . up to seven non-supervisor members
\newcommand{\member}[1]{
	\addtocounter{@members}{1}    % Inc. num of members to include this new one.
	\ifcase\value{@members}
	\or \or
	\newcommand{\@memberb}{\@member{#1}} \or
	\newcommand{\@memberc}{\@member{#1}} \or
	\newcommand{\@memberd}{\@member{#1}} \or
	\newcommand{\@membere}{\@member{#1}} \or
	\newcommand{\@memberf}{\@member{#1}} \or
	\newcommand{\@memberg}{\@member{#1}}
	\else
	\ClassError{dukedisseratation.cls}
	{Thesis format error.  Too many committee members.}
	\fi
}
% Print a committee member's name with a signature line
\newcommand{\@member}[1]{
	\parbox{3in}{%
		\vskip 4ex  % Leave some room for signature
		\raisebox{-24pt}[0pt][17pt]{\rule{3in}{.5pt}}\par    % Print line.
		\hfil \raisebox{0pt}[0pt][0pt]{#1} \hfil     % Print member name above.
	}
}

\newcommand{\wideunderline}[2][2em]{%
	\underline{\makebox[\ifdim\width>#1\width\else#1\fi]{#2}}%
}


% -----------------------------------------------------------------------
% TITLE PAGES:
% a) make title page and copyright page
% b) if we're making g-school approved vers, make UMI abs page
% -----------------------------------------------------------------------
\renewcommand\maketitle{\par
	\begingroup
	\renewcommand\thefootnote{\@fnsymbol\c@footnote}%
	\def\@makefnmark{\rlap{\@textsuperscript{\@thefnmark}}}%
	\long\def\@makefntext##1{\parindent 1em\noindent
		\hb@xt@1.8em{%
			\hss\@textsuperscript{\cmr\@thefnmark}}##1}%
	\newpage
	\global\@topnum\z@   % Prevents figures from going at top of page.
	\@maketitle
	\endgroup
	\setcounter{footnote}{0}%
	\global\let\maketitle\relax
	\global\let\@maketitle\relax
	\global\let\@author\@empty
	\global\let\@date\@empty
	\global\let\@title\@empty
	\global\let\title\relax
	\global\let\author\relax
	\global\let\date\relax
	\global\let\and\relax
}
\def\@maketitle{%
	\newpage
	\thispagestyle{empty}
	\null
	\normalbaselines
	\begin{center}%
		{\normalsize\bfseries \@title \par}%
		\vskip 1em%
		\normalsize by \par%
		\vskip 1em%
		{\normalsize \@author \par }%
		\vskip 1em%
		\normalsize Department of \@department \par
        \normalsize Program of \@program \par
		Duke University \par
		\if@Gradschool
		\vskip 4ex%
		Defense Date: \raisebox{1pt}{\wideunderline[2in]{\@defensedate}}
		\par\noindent
		%\vfill
		\vskip 1em%
		{\normalsize Approved:\par}%
		\@printsiglines
		\fi
		\vfill
		\par
		\vspace{1em plus 2em minus 1em}
		\par \normalbaselines \noindent
		\if@Gradschool
		\if@MS
		{\normalsize
			Thesis submitted in partial fulfillment of the requirements for the
			degree of
			\par Master~of~Science in the Department~of~\@department
			\par in the Graduate~School of Duke~University\par}
		\else
		{\fontsize{13pt}{17pt}\selectfont
			Dissertation submitted in partial fulfillment of the requirements for the
			degree of
			\par Doctor~of~Philosophy in the %Department~of~\@department
            Program~of~\@program
			\par in the Graduate~School of Duke~University\par}
		\fi
		\else
		\if@MS
		{\normalsize M.S. Thesis } \par
		\else
		{\normalsize Ph.D. Dissertation } \par
		\fi
		\fi
		\number\year
        \vspace{-0.5in}
	\end{center}%

	% UMI Abstract page too?
        \if@Gradschool
        \@UMIabstract
        \fi
	% \if@Gradschool \if@MS \else
	% \@UMIabstract
	% \fi \fi

	% Everyone gets a copyright! Yay!
	\@copyrightpage
}

\newcommand\@UMIabstract{%
	\newpage
	\thispagestyle{empty}
	\null
	\normalbaselines
	\begin{center}
		{\normalsize\bfseries \underline{ABSTRACT} \par}
		%{\normalsize (\@subject) \par }
		\vskip 1em%
		{\normalsize\bfseries \@title \par}
		\vskip 1em%
		{\normalsize by \par }
		\vskip 1em%
		{\normalsize \@author \par }
		\vskip 1em%
		{\normalsize Department of \@department  \par \normalsize Program of \@program \par Duke University }
        % In \@UMIabstract (replace relevant block):

		\vskip 4ex%
		Defense Date: \raisebox{1pt}{\wideunderline[2in]{\@defensedate}}\par\noindent
		\vskip 1em%
		%\vfill
		{\normalsize Approved:\par}%
		\@printsiglines
		\vfill
		\par \normalbaselines \noindent
        {\fontsize{13pt}{17pt}\selectfont
            \if@MS
            An abstract of a thesis submitted in partial fulfillment of the requirements for
            \par the degree of Master~of~Science in the Department~of~\@department
            \par in the Graduate~School of Duke~University
            \else
            An abstract of a dissertation submitted in partial fulfillment of the requirements for
            \par the degree of Doctor~of~Philosophy in the %Department~of~\@department
            Program~of~\@program
            \par in the Graduate~School of Duke~University
            \fi
            } \par
		% {\normalsize%
		% 	An abstract of a dissertation submitted in partial fulfillment of the
		% 	requirements for
		% 	\par the degree of Doctor~of~Philosophy in the Department~of~\@department
		% 	\par in the Graduate~School of Duke~University } \par
		{\normalsize \number\year}
                \vspace{-0.5in}
	\end{center}%
	\newpage
}

% Member signature lines function
% Print the committee members defined by the user.
% 0.4 -- removed 2-up layout, so page is ugly again.
\newcounter{@membersprinted}

\newcommand\@printsiglines{%
	\vskip -2ex
	\setcounter{@membersprinted}{0}
	\loop
	\ifnum \value{@membersprinted} < \value{@members}
	\addtocounter{@membersprinted}{1}
	\ifcase\value{@membersprinted}
	\or
	\@membera \par \or
	\@memberb \par \or
	\@memberc \par \or
	\@memberd \par \or
	\@membere \par \or
	\@memberf \par \or
	\else \typeout{Too many committee members defined!}
	\fi
	\repeat
}%

% Copyright page
\newcommand\@copyrightpage{%
	\newpage
	\thispagestyle{empty}
	\normalbaselines
	\null
	\vfill
	\begin{center}
		Copyright \copyright\enspace \number\year\enspace by \par \@author \par
		\@copyrighttext
	\end{center}
        \vspace{-0.5in}
	\newpage
}%

% G-school does not allow parts!
\renewcommand\part{%
	\ClassWarning{Grad School guidelines forbid the use of parts!}
}

%-------------------------------------------------------------------------
% Chapter format:
%-------------------------------------------------------------------------

\def\@chapter[#1]#2{%
	\clearpage
	\ifnum \c@secnumdepth >\m@ne
	\refstepcounter{chapter}%
	% Done with frontmatter?
	\if@frontmatter
	\@frontmatterfalse
	\pagenumbering{arabic}
	\setcounter{page}{1}
	\fi
	\typeout{\@chapapp\space\thechapter.}%
	\addcontentsline{toc}{chapter}%
	{\protect\numberline{\thechapter}#1}%
	\else
	\addcontentsline{toc}{chapter}{#1}%
	\fi
	\chaptermark{#1}%
	\addtocontents{lof}{\protect\addvspace{10\p@}}%
	\addtocontents{lot}{\protect\addvspace{10\p@}}%
	\@makechapterhead{\normalbaselines#2}
	\@afterheading
	\normalbaselines
	\@textspace  % double-spaced chapter text
}



% Unified centered chapter headings.
% Numbered chapters use two centered lines with no punctuation between label and title:
%     Chapter 1
%     Chapter Title
% Unnumbered chapters use the same centered title style.
\newcommand{\@chaptertitleblock}[1]{%
    \normalbaselines
    {\centering
        {\normalfont\rmfamily\bfseries\fontsize{20pt}{24pt}\selectfont #1\par}%
    }%
    \vspace*{6em}%
}

% Numbered chapters, including appendices.
\def\@makechapterhead#1{%
    {\parindent 0pt
     \interlinepenalty\@M
     \normalbaselines
     \centering
     {\normalfont\rmfamily\bfseries\fontsize{14pt}{17pt}\selectfont
      \@chapapp\space\thechapter\par}%
     \vspace{0.55em}%
     {\normalfont\rmfamily\bfseries\fontsize{20pt}{24pt}\selectfont
      #1\par}%
     \vspace*{6em}%
    }%
}

% Unnumbered chapters: Abstract, Acknowledgements, TOC, Lists, Biography, etc.
\def\@makeschapterhead#1{%
    {\parindent 0pt
     \interlinepenalty\@M
     \@chaptertitleblock{#1}%
    }%
}

% A non-mainmatter chapter that appears in the ToC
\def\nmchapter#1{
	\chapter*{#1}
	\addcontentsline{toc}{chapter}{#1}%
	\thispagestyle{plain}
	\normalbaselines
	\@textspace
}

\def\nmchapterNOTOC#1{
	\chapter*{#1}
	\thispagestyle{plain}
	\normalbaselines
	\@textspace
}



%-------------------------------------------------------------------------
% Section format:
% \@startsection {NAME}{LEVEL}{INDENT}{BEFORESKIP}{AFTERSKIP}{STYLE}
%            optional * [ALTHEADING]{HEADING}
%-------------------------------------------------------------------------
%\ifthenelse{\boolean{oldstyle}}{%
	%\renewcommand\section{\@startsection {section}{1}{\z@}%
		%                                   {-3.5ex \@plus -1ex \@minus -.2ex}%
		%                                   {2.3ex \@plus.2ex}%
		%                              {\normalbaselines\normalfont\Large\bfseries}}
	%\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
		%                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
		%                                     {1.5ex \@plus .2ex}%
		%                              {\normalbaselines\normalfont\large\bfseries}}
	%\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
		%                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
		%                                     {1.5ex \@plus .2ex}%
		%                              {\normalbaselines\normalfont\normalsize\bfseries}}
	%\renewcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
		%                                    {3.25ex \@plus1ex \@minus.2ex}%
		%                                    {-1em}%
		%                              {\normalbaselines\normalfont\normalsize\bfseries}}
	%\renewcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
		%                                       {3.25ex \@plus1ex \@minus .2ex}%
		%                                       {-1em}%
		%                              {\normalbaselines\normalfont\normalsize\bfseries}}
	%}
%{%
	%\renewcommand\section{\@startsection {section}{1}{\z@}%
		%                                   {-3.5ex \@plus -1ex \@minus -.2ex}%
		%                                   {2.3ex \@plus.2ex}%
		%					{\normalbaselines \usefont{T1}{phv}{b}{i}\fontsize{14pt}{\baselineskip}}}
	%\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
		%                                     {6pt}%
		%                                     {\baselineskip}%
		%				  {\normalbaselines  \usefont{T1}{phv}{b}{n}\fontsize{13pt}{\baselineskip}}}
	%\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
		%                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
		%                                     {1.5ex \@plus .2ex}%
		%				  {\normalbaselines \normalfont\normalsize\it}}
	%\renewcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
		%                                    {3.25ex \@plus 1ex \@minus.2ex}%
		%                                    {-1em}%
		%				 {\normalbaselines\fontsize{11pt}{\baselineskip}}}
	%\renewcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
		%                                       {3.25ex \@plus 1ex \@minus .2ex}%
		%                                       {-1em}%
		%				 {\normalbaselines \normalfont\small\it}}
	%}

\newenvironment{symbollist}
{%
	\normalbaselines
	\begin{list}{ }{%
			\addtolength{\topsep}{0.5\@SimSpace}
			\addtolength{\itemsep}{0.5\@SimSpace}
			\setlength{\labelwidth}{0.24\textwidth}
			\setlength{\labelsep}{2em}
			\setlength{\parsep}{0pt}
			\setlength{\leftmargin}{\labelwidth}
			\setlength{\rightmargin}{0pt}
		}
	}
	{ \end{list} }


%----------------------------------------------------------------
% Figure format
%----------------------------------------------------------------
% Note smallcaps 'Figure' instead of bold
%
\def\fnum@figure{{\sc \figurename\nobreakspace\thefigure}}

\setlength\abovecaptionskip{\z@} % reduced from 10pt
\setlength\belowcaptionskip{12pt plus 12 pt minus 12pt} % increased from 0\p@
% Single space captions
\long\def\@makecaption#1#2{%
	\vskip\abovecaptionskip
	\sbox\@tempboxa{\normalbaselines #1: #2}%
	%\ifdim \wd\@tempboxa >\hsize
	\normalbaselines #1: #2\par
%	\else
%	\global \@minipagefalse%
%	\hb@xt@\hsize{\box\@tempboxa}%
%	\fi
	\vskip\belowcaptionskip
}



%---------------------------------------------------------------------
% Table of contents, list of figures, list of tables
%---------------------------------------------------------------------

%%%% NEW IMPROVED DUKE APPROVED TOC STUFF HERE
% Single space entries
% Table of contents entries remain left-aligned; heading uses unified chapter style
\renewcommand\tableofcontents{%
  \chapter*{\contentsname}% Remove \@mkboth to prevent centering in headers
  \normalbaselines
  \leftskip=0pt % Ensures left alignment
  \@starttoc{toc}%
}
% Simulate double-spacing for chapter entries, no indentation
\renewcommand*\l@chapter{\protect\addvspace{\@SimSpace}\@dottedtocline{0}{0pt}{1em}}
% Indent second-level and higher entries
\renewcommand*\l@section{\protect\addvspace{\@SimSpace}\@dottedtocline{1}{1.5em}{2.3em}}
\renewcommand*\l@subsection{\protect\addvspace{\@SimSpace}\@dottedtocline{2}{2.3em}{3.2em}}
\renewcommand*\l@subsubsection{\protect\addvspace{\@SimSpace}\@dottedtocline{3}{3.2em}{4.1em}}
\renewcommand*\l@paragraph{\protect\addvspace{\@SimSpace}\@dottedtocline{4}{4.1em}{5em}}
\renewcommand*\l@subparagraph{\protect\addvspace{\@SimSpace}\@dottedtocline{5}{5.1em}{6em}}
% Defining list of figures with left-aligned entries
\renewcommand\listoffigures{%
  \chapter*{\listfigurename}%
  \addcontentsline{toc}{chapter}{\listfigurename}%
  \normalbaselines
  \leftskip=0pt % Ensures left alignment
  \@starttoc{lof}%
}
% Simulate double-spacing for figure entries, no indentation
\renewcommand*\l@figure{\protect\addvspace{\@SimSpace}\@dottedtocline{1}{0pt}{2.3em}}
% Defining list of tables with left-aligned entries
\renewcommand\listoftables{%
  \chapter*{\listtablename}%
  \addcontentsline{toc}{chapter}{\listtablename}%
  \normalbaselines
  \leftskip=0pt % Ensures left alignment
  \@starttoc{lot}%
}
% Simulate double-spacing for table entries, no indentation
\renewcommand*\l@table{\protect\addvspace{\@SimSpace}\@dottedtocline{1}{0pt}{2.3em}}
%---------------------------------------------------------------------
%---------------------------------------------------------------------
%------------------------------------------------------------------------
% Bibliography
%------------------------------------------------------------------------
% You guessed it, single spacing

\let\oldbibliography\thebibliography
\renewcommand{\thebibliography}[1]{\oldbibliography{#1}
	\setlength{\itemsep}{10pt}}
%
%\renewenvironment{thebibliography}[1]{%
%	\phantomsection
%	\addcontentsline{toc}{chapter}{\bibname}
%	\setlength{\parskip}{\bibitemsep}%
%	%\normalbaselines % hello!
%	\chapter*{\bibname}%
%	\@mkboth{\MakeUppercase\bibname}{\MakeUppercase\bibname}%
%	\list{\@biblabel{\@arabic\c@enumiv}}%
%	\setlength{\itemsep}{0pt}
%	{\settowidth\labelwidth{\@biblabel{#1}}%
%		\addtolength{\itemsep}{0.5\@SimSpace} % 'double-spacing'
%		\leftmargin\labelwidth
%		\advance\leftmargin\labelsep
%		\@openbib@code
%		\usecounter{enumiv}%
%		\let\p@enumiv\@empty
%		\renewcommand\theenumiv{\@arabic\c@enumiv}}%
%	\sloppy
%	\clubpenalty4000
%	\@clubpenalty \clubpenalty
%	\widowpenalty4000%
%	\sfcode`\.\@m
%}


%-----------------------------------------------------------------------
% Footnote formatting
%-----------------------------------------------------------------------
\renewcommand\@makefntext[1]{%
	\parindent 1em%
	\noindent
	\hb@xt@1em{\hss\@makefnmark} \normalbaselines #1}
% Footnote spacing -- looser spacing looks better with double-spaced text
\setlength{\footnotesep}{ 14pt}
\skip\footins 8pt plus 2pt minus 4pt  % Space between last line of body text
% and first line of footnote


%-----------------------------------------------------------------------
% Biography
%-----------------------------------------------------------------------
\newcommand\biography{%
	\if@MS
	\ClassWarning{dukedissertation}{No biography for MS thesis.}
	\fi
	\nmchapter{\biographyname}


}

%-----------------------------------------------------------------------
% Introduction
%-----------------------------------------------------------------------
\newcommand\introduction{%
	\if@MS
	\ClassWarning{dukedissertation}{No introduction for MS thesis.}
	\fi
	\@frontmatterfalse
	\pagenumbering{arabic}
	\nmchapter{Introduction}
}

%-----------------------------------------------------------------------
% Dedication
%-----------------------------------------------------------------------
\newcommand\dedication[1]{%
	\if@MS
	\ClassWarning{dukedissertation}{No allowed dedication for MS thesis.}
	\fi
	\nmchapterNOTOC{Dedication}
	\thispagestyle{plain}
	#1
	\newpage
}


%-----------------------------------------------------------------------
% List of Abbr.
%-----------------------------------------------------------------------
\newcommand\abbreviations{%
	\nmchapter{\loaname}
}


%-----------------------------------------------------------------------
% Acknowledgements
%-----------------------------------------------------------------------
\newcommand\acknowledgements{%
	\nmchapter{\ackname}
}


%-----------------------------------------------------------------------
% Abstract -- just another non-mainmatter chapter
%-----------------------------------------------------------------------
\providecommand{\abstractname}{Abstract}
\newcommand\abstract{%
	\nmchapter{\abstractname}%
}

%-----------------------------------------------------------------------
% Body text format
%-----------------------------------------------------------------------
\pagestyle{plain}
\@textspace
\raggedbottom % Allow flexibility in text height per page

%----------------------------
% Frontmatter proccessing hack --
% Set page numbering to roman.  @frontmatter
% trips to false when the first numbered (non-starred) chapter is included.
%----------------------------
\@frontmattertrue
\pagenumbering{roman}

\endinput
