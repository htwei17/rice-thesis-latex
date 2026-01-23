%%% =========================================================================
%%% File Name: ruthesis.cls
%%% Title: Rice University Thesis Class
%%%
%%% ORIGINAL AUTHOR:
%%%    Jan Erik Odegard <odegard@ece.rice.edu> (Rice ECE, 1995)
%%%
%%% CONTRIBUTORS & MAINTAINERS:
%%%    Nick Vrvilo <nick.vrvilo@alumni.rice.edu> (2017)
%%%    Hao-Tian Wei <htwei@rice.edu> (2026)
%%%
%%% COPYRIGHT:
%%%    (c) 1995-2026 Rice University
%%%    (c) 1995 Jan Erik Odegard (LaTeX)
%%%    (c) 2017 Nick Vrvilo (Significant Refactoring & Port to LaTeX2e)
%%%    (c) 2026 Hao-Tian Wei (Support for XeLaTeX/BibLaTeX & Design Changes)
%%% =========================================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ruthesis}[2026/01/20 Rice Thesis Class, Physics, Hao-Tian Wei]

% -------------------------------------------------------------------------
% 1. OPTION HANDLING
% -------------------------------------------------------------------------
% Toggle for citation compression
\newif\if@compresscitations
\@compresscitationstrue % DEFAULT IS NOW TRUE (Compressed: [1-3])

% Toggle for CJK support
\newif\if@usecjk
\@usecjkfalse % Default is OFF
\DeclareOption{cjk}{\@usecjktrue}

% Option to turn citation compression OFF if explicitly desired
\DeclareOption{nocompress}{\@compresscitationsfalse}

\DeclareOption{draft}{\typeout{DRAFT MODE}}
\DeclareOption{12pt}{\typeout{12pt mode selected implicitly by LoadClass}}

\ProcessOptions

% Load Base Class
\LoadClass[12pt]{report}

% -------------------------------------------------------------------------
% 2. CORE PACKAGES & LAYOUT
% -------------------------------------------------------------------------
\RequirePackage{ifthen}

% Modern Line Spacing
\RequirePackage{setspace}
\doublespacing 
\def\linespacing#1{\setstretch{#1}}

% Modern Margins
\RequirePackage{geometry}
\geometry{
    letterpaper,
    margin=1in,         
    bindingoffset=0.5in,
    headheight=15pt     
}

% -------------------------------------------------------------------------
% 3. SCIENTIFIC & MATH PACKAGES
% -------------------------------------------------------------------------
% Basic Math & Symbols
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{amsthm}
\RequirePackage{latexsym}
\RequirePackage{wasysym}
\RequirePackage{braket}  % Quantum mechanics notation
\RequirePackage{bm}      % Bold Math

% Algorithms
\RequirePackage{algorithm}
\RequirePackage{algpseudocode}
% Rename "Require/Ensure" to "Input/Output" (Standard in CS/ECE)
\algrenewcommand\algorithmicrequire{\textbf{Input:}}
\algrenewcommand\algorithmicensure{\textbf{Output:}}

% Graphics & Colors
\RequirePackage{xcolor}  % Replaces 'color'
\RequirePackage{graphicx}% Replaces 'epsfig', 'epsf', 'graphics'
\RequirePackage{rotating}% For rotated figures/tables
\RequirePackage{textcomp}% Extra symbols

% Subfigures (Modern Replacement)
% 'subfigure' is obsolete. 'subcaption' is the modern standard.
\RequirePackage{subcaption} 

% -------------------------------------------------------------------------
% 4. TYPOGRAPHY & FONTS (XeLaTeX specific)
% -------------------------------------------------------------------------
\RequirePackage{fontspec}        
\RequirePackage{microtype}      

% -- Main English Font --
\setmainfont{TeX Gyre Termes}
% Alternative: \setmainfont{Times New Roman}


% -- Chinese Font Settings --
% Load Chinese font if the [cjk] option is passed
\if@usecjk
  \RequirePackage{xeCJK}
  \setCJKmainfont[
      BoldFont={FandolHei-Regular}, 
      ItalicFont={FandolKai-Regular}
  ]{FandolSong-Regular}
\fi

% -------------------------------------------------------------------------
% 5. BIBLIOGRAPHY (BibLaTeX)
% -------------------------------------------------------------------------
% Logic: Default is Compressed (numeric-comp). 
% If 'nocompress' is passed, use standard numeric.

\if@compresscitations
  % IEEE style uses 'numeric-comp' internally. 
  % We explicitly force citestyle to numeric-comp to guarantee [1-3].
  \RequirePackage[
      backend=biber,
      style=ieee,         
      citestyle=numeric-comp, % FORCE COMPRESSION
      natbib=true,       
      sorting=none       
  ]{biblatex}
\else
  % Verbose style [1], [2], [3]
  \RequirePackage[
      backend=biber,
      style=numeric,     
      natbib=true,       
      sorting=none       
  ]{biblatex}
\fi

% Fix line spacing for the bibliography (Single spaced)
\AtBeginBibliography{\linespacing{1}}

% -------------------------------------------------------------------------
% 6. HYPERLINKS & COLORS
% -------------------------------------------------------------------------
\RequirePackage[
    pdfusetitle,       
    bookmarksnumbered, 
    hidelinks          
]{hyperref}

\definecolor{DeepTeal}{rgb}{0.0, 0.52, 0.43}   % Deep Teal
% Official Rice University Colors
\definecolor{RiceBlue}{HTML}{00205B}
\definecolor{RiceGray}{HTML}{7C7E7F}

\hypersetup{
    colorlinks=true,
    linkcolor=RiceBlue,
    citecolor=DeepTeal,
    urlcolor=magenta,
    filecolor=cyan
}

% -------------------------------------------------------------------------
% 7. RICE UNIVERSITY FRONTMATTER MACROS
% -------------------------------------------------------------------------
\newif\if@ruthesis
\@ruthesistrue

% Variables
\def\school#1{\gdef\@school{#1}}
\def\ctitle#1{\gdef\@ctitle{#1}}
\def\department#1{\gdef\@department{#1}}
\def\coverart#1{\gdef\@coverart{#1}}
\def\degree#1{\gdef\@degree{#1}}
\def\committee#1{\gdef\@committee{#1}}
\def\address#1{\gdef\@address{#1}}
\def\donemonth#1{\gdef\@month{#1}}
\def\doneyear#1{\gdef\@year{#1}}

% Defaults
\def\@school{Rice University}
\def\@ctitle{\@title}
\def\@department{Department Name}
\def\@coverart{\includegraphics[width=4.5cm, keepaspectratio]{logos/RiceUStackedVertical_BLUE.pdf}}
\def\@degree{Doctor of Philosophy} % or Master of Science
\def\@committee{
    Committee Chair Name, Chair \\ Chair Title \and
    Committee Member 1 \\ Title \and
    Committee Member 2 \\ Title
}
\def\@address{Houston, Texas}
\def\@month{\ifcase\month ?\or January\or February\or March\or April\or
 May\or June\or July\or August\or September\or October\or
 November\or December\fi}
\def\@year{\number\year}

% Logos and Graphics
\newcommand{\ricelogo}{\includegraphics[height=1.8cm, keepaspectratio]{logos/RiceStackedHoriz_Blue.pdf}}
\newcommand{\art}{\@coverart}

% Cover Page
\def\makecover{%
  \begin{titlepage}
    \thispagestyle{empty}
    \linespacing{1}
    \null
    \vfill % --- Top Vertical Flex ---
    \begin{center}
      % 1. THE TITLE
      {\fontsize{24}{30}\selectfont \bfseries \scshape \color{RiceBlue} \@ctitle \par}
      \vspace{1.5em}
      % 2. THE HORIZON LINE
      {\color{RiceGray}\rule{0.5\textwidth}{0.5pt}}
      \vspace{2em}
      % 3. THE AUTHOR
      \\{\Large \bfseries \@author \par}
      \vspace{4em}
      % 4. THE SHIELD
      \art
    \end{center}
    \vfill % --- Bottom Vertical Flex ---
    % 5. THE FOOTER METADATA
    \begin{center}
      {\color{RiceGray}\large \textsc{\@school}} \par
      \vspace{0.8em}
      {\small Thesis Submitted for the Degree of} \par
      \vspace{0.4em}
      {\large \bfseries \@degree} \par
      \vspace{0.2em}
      {\small Department of \@department} \par
      \vspace{2em}
      % Location and Date separated by a dot
      {\small \@address \ \ $\cdot$ \ \ \@month \ \@year}
    \end{center}
    \cleardoublepage
  \end{titlepage}
}

% Title Page
\def\maketitle{%
\begin{titlepage}
  \null\linespacing{1}\setcounter{page}{1}\vfill
  \vbox to 0pt{\vss\vbox to 8.75in{\parskip 0pt \parindent 0pt\centering
      {\large \uppercase\expandafter{\@school} \par} \vskip 0pt plus 3fil
      {\Large \bf \@title \par} \vskip 0pt plus 1.3fil
      {\large by \par} \vskip 0pt plus 1fil
      {\large \bf \@author \par} \vskip 0pt plus 3fil
      {\large \sc A Thesis Submitted \\
        in Partial Fulfillment of the \\
        Requirements for the Degree \par} \vskip 0pt plus 1.1fil
      {\large \bf \@degree \par} \vskip 0pt plus 4.5fil
      \begingroup
      \leftskip .5\textwidth \rightskip 0pt plus 1fil
      {\sc Approved, Thesis Committee: \par} \vskip 2.5em
      \moveright\leftskip\vbox{\hrule width \leftskip}
      \def\and{\par \vskip 2.25em minus 1em\moveright\leftskip%
        \vbox{\hrule width \leftskip}}
      \@committee \par
      \endgroup \vskip 0pt plus 2fil
      {\large \@address \par} \vskip 0pt plus .8fil
      {\large \@month, \@year \par}}}\cleardoublepage
\end{titlepage}}

% Abstract
\def\abstract{\cleardoublepage \pagestyle{empty} \global\@topnum\z@
 \@afterindentfalse \begingroup
 \def \baselinestretch{1.7} \parskip \z@ \parindent \z@ \par
 \null \centering {{\center{ABSTRACT}}} \vskip .4in
\@title \vskip .4in  by \vskip .4in \@author \vskip .4in \par
\endgroup \setcounter
 {footnote}{0}\def\thefootnote{\fnsymbol{footnote}}\addcontentsline
 {toc}{frontmatter}{\protect\numberline {\hfil}Abstract}}

\def\endabstract{\setcounter{footnote}{0}
  \pagestyle{plain}\thispagestyle{empty}}

% Acknowledgments
\def\acknowledge{\chapter*{Acknowledgments}\thispagestyle{empty}
 \setcounter{footnote}{0}
 \addcontentsline{toc}{frontmatter}{\protect\numberline
 {\hfil}Acknowledgments}}
\def\endacknowledge{\setcounter{footnote}{0}}

% Dedications
\def\dedication{
  \cleardoublepage
  \thispagestyle{empty}
  \vspace*{\fill}
  \begin{center}
  \itshape
}
\def\enddedication{
  \end{center}
  \vspace*{\fill}
  \cleardoublepage
}

% Publications
\def\publications{
  \cleardoublepage             
  \chapter*{List of Publications} 
  \thispagestyle{plain}        
  \addcontentsline{toc}{frontmatter}{\protect\numberline{\hfil}List of Publications}
}
\def\endpublications{\par\vfil\newpage}

% Preface
\def\preface{\chapter*{Preface} \thispagestyle{empty}
 \setcounter{footnote}{0}
 \addcontentsline{toc}{frontmatter}{\protect\numberline
 {\hfil}Preface}}
\def\endpreface{\setcounter{footnote}{0}}

% General Frontmatter Utilities
\def\frontmatter{\relax}
\def\endfrontmatter{\cleardoublepage
  \pagenumbering{arabic}\def\thefootnote{\arabic{footnote}}}

% -------------------------------------------------------------------------
% 8. TABLE OF CONTENTS & LISTS FORMATTING
% -------------------------------------------------------------------------
\def\@pnumwidth{1.55em}
\def\@tocrmarg {2.55em plus 1fil}
\def\@dotsep{4.5}
\setcounter{tocdepth}{2}

\def\tableofcontents{\@restonecolfalse\if@twocolumn\@restonecoltrue\onecolumn
 \fi\chapter*{Contents\@mkboth{CONTENTS}{CONTENTS}} \thispagestyle{empty}
 \@starttoc{toc}\if@restonecol\twocolumn\fi}

\def\l@part#1#2{\addpenalty{-\@highpenalty}
 \addvspace{2.25em plus 1pt}
 \begingroup
 \@tempdima 3em
 \parindent \z@ \rightskip \@pnumwidth
 \parfillskip -\@pnumwidth    
 {\large \bf
 \leavevmode
 #1\hfil \hbox to\@pnumwidth{\hss #2}}\par
 \nobreak
 \endgroup}

\def\l@chapter#1#2{\pagebreak[3] 
 \vskip 1.0em plus 1pt
 \@tempdima 1.5em
 \begingroup
 \parindent \z@ \rightskip \@pnumwidth 
 \parfillskip -\@pnumwidth 
 \parskip \z@
 \large \bf
 \leavevmode
 \advance\leftskip\@tempdima
 \hskip -\leftskip
 #1\nobreak\hfil \nobreak\hbox to\@pnumwidth{\hss #2}\par
 \endgroup}
 
\def\l@section{\@dottedtocline{1}{1.5em}{2.3em}}
\def\l@subsection{\@dottedtocline{2}{3.8em}{3.2em}}
\def\l@subsubsection{\@dottedtocline{3}{7.0em}{4.1em}}
\def\l@paragraph{\@dottedtocline{4}{10em}{5em}}
\def\l@subparagraph{\@dottedtocline{5}{12em}{6em}}

\def\listoffigures{\@restonecolfalse\if@twocolumn\@restonecoltrue\onecolumn
 \fi\chapter*{Illustrations\@mkboth
 {ILLUSTRATIONS}{ILLUSTRATIONS}} \thispagestyle{empty}
 \addcontentsline{toc}{frontmatter}{\protect\numberline
 {\hfil}List of Illustrations}\@starttoc{lof}\if@restonecol
 \twocolumn\fi}

\def\l@figure{\@dottedtocline{1}{1.5em}{2.3em}}

\def\listoftables{\@restonecolfalse\if@twocolumn\@restonecoltrue\onecolumn
 \fi\chapter*{Tables\@mkboth
 {TABLES}{TABLES}} \thispagestyle{empty}
 \addcontentsline{toc}{frontmatter}{\protect\numberline
 {\hfil}List of Tables}\@starttoc{lot}\if@restonecol
 \twocolumn\fi}

\let\l@table\l@figure

\def\l@frontmatter#1#2{\pagebreak[3]
 \@tempdima 1.5em \begingroup
 \parindent \z@ \rightskip \@pnumwidth 
 \parfillskip -\@pnumwidth 
 \leavevmode #1\hfil \hbox to\@pnumwidth{\hss #2}\par
 \endgroup}

% Captions spacing fix
\renewcommand{\fnum@figure}{Figure \thefigure \linespacing{1}}
\renewcommand{\fnum@table}{Table \thetable \linespacing{1}}

% -------------------------------------------------------------------------
% 9. SECTIONING HEADERS & PAGE STYLES
% -------------------------------------------------------------------------

% -- Chapter Heading Formatting --
\def\@makechapterhead#1{\begingroup
 \def \baselinestretch{1} \parskip \z@ \parindent \z@ \par
 \Large\bf \null \vskip 1.5ex \centering
 \ifnum \c@secnumdepth >\m@ne \@chapapp~\thechapter \vskip 3.5ex \fi
 #1 \vskip 3ex plus .2ex\endgroup}

\def\@makeschapterhead#1{\begingroup
 \def \baselinestretch{1} \parskip \z@ \parindent \z@ \par
 \null \vskip .3in \centering
 \Large \bf #1\par \endgroup \nobreak \vskip .6in\relax}

\def\chapter{\cleardoublepage
 \thispagestyle{plain} % Uses the redefined plain style below
 \global\@topnum\z@
 \@afterindentfalse
 \secdef\@chapter\@schapter}

\def\@chapter[#1]#2{\ifnum \c@secnumdepth >\m@ne
 \refstepcounter{chapter}
 \typeout{\@chapapp\space\thechapter.}
 \addcontentsline{toc}{chapter}{\protect
 \numberline{\thechapter}#1}\else
 \addcontentsline{toc}{chapter}{#1}\fi
 \chaptermark{#1}
 \addtocontents{lof}{\protect\addvspace{\baselineskip}}
 \addtocontents{lot}{\protect\addvspace{\baselineskip}}
 \if@twocolumn
 \@topnewpage[\@makechapterhead{#2}]  
 \else \@makechapterhead{#2}
 \@afterheading
 \fi}

\def\@schapter#1{\if@twocolumn \@topnewpage[\@makeschapterhead{#1}]
 \else \@makeschapterhead{#1} 
 \@afterheading\fi}

% -- Section Heading Fonts --
\def\section{\@startsection{section}{1}{\z@}{-3.25ex plus -1ex minus 
 -.2ex}{1.5ex plus .2ex}{\large\bf}}
\def\subsection{\@startsection{subsection}{2}{\z@}{-3.25ex plus -1ex minus 
 -.2ex}{1.5ex plus .2ex}{\normalsize\bf}}
\def\subsubsection{\@startsection{subsubsection}{3}{\z@}{-3.25ex plus 
 -1ex minus -.2ex}{1.5ex plus .2ex}{\normalsize\bf}}
\def\paragraph{\@startsection
 {paragraph}{4}{\z@}{3.25ex plus 1ex minus .2ex}{-1em}{\normalsize\bf}}
\def\subparagraph{\@startsection
 {subparagraph}{4}{\parindent}{3.25ex plus 1ex minus 
 .2ex}{-1em}{\normalsize\bf}}

\setcounter{secnumdepth}{2}

\def\appendix{\par
 \setcounter{chapter}{0}
 \setcounter{section}{0}
 \def\@chapapp{Appendix}
 \def\thechapter{\Alph{chapter}}}

% -- Page Styles (FancyHDR) --
\RequirePackage{fancyhdr}

% Set the default page style
\pagestyle{fancy}
\fancyhf{} % Clear all headers and footers to start

% Define Header Content
\if@twoside
  % Double-sided: Page # on outer edges, Chapter/Section inner
  \fancyhead[RO,LE]{\thepage}
  \fancyhead[RE]{\slshape\leftmark}
  \fancyhead[LO]{\slshape\rightmark}
\else
  % Single-sided: Page # Right, Chapter/Section Left
  \fancyhead[R]{\thepage}
  \fancyhead[L]{\slshape\rightmark}
\fi

% Remove the horizontal rule (line) from the header
\renewcommand{\headrulewidth}{0pt}

% Redefine 'plain' style (used on Chapter title pages)
% Rice usually requires page numbers to remain top-right even on new chapters
\fancypagestyle{plain}{%
  \fancyhf{} % Clear all
  \if@twoside
    \fancyhead[RO,LE]{\thepage}
  \else
    \fancyhead[R]{\thepage}
  \fi
  \renewcommand{\headrulewidth}{0pt}
}

% Fix for headheight warning in modern LaTeX
\setlength{\headheight}{15pt}

\pagenumbering{roman}
\def\thefootnote{\fnsymbol{footnote}}

% -------------------------------------------------------------------------
% 10. CONTENT EXTENSIONS (Epigraphs, Code, Theorems)
% -------------------------------------------------------------------------

% -- Epigraphs (Quotes) --
\RequirePackage{epigraph}
\setlength{\epigraphwidth}{0.6\textwidth} 
\renewcommand{\epigraphflush}{flushright} 
\renewcommand{\sourceflush}{flushright}   
\renewcommand{\textflush}{flushright}     
\renewcommand{\epigraphsize}{\small\itshape}
\RequirePackage{multicol}

% -- Code Listings --
\RequirePackage{listings}

% -- Theorems (TColorBox) --
\RequirePackage{tcolorbox}
\tcbuselibrary{theorems, skins, breakable}

\tcbset{
    commonstyle/.style={
        colback=white,
        colframe=RiceGray,
        fonttitle=\bfseries,
        breakable
    }
}

\newtcbtheorem[number within=section]{definition}{Definition}{commonstyle}{def}
\newtcbtheorem[number within=section]{theorem}{Theorem}{commonstyle}{thm}
\newtcbtheorem[number within=section]{example}{Example}{commonstyle}{ex}
\newtcbtheorem[number within=section]{lemma}{Lemma}{commonstyle}{lem}
\newtcbtheorem[number within=section]{corollary}{Corollary}{commonstyle}{cor}
\newtcbtheorem[number within=section]{remark}{Remark}{commonstyle}{rmk}
\newtcbtheorem[number within=section]{proposition}{Proposition}{commonstyle}{prop}

\endinput
