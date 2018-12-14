% nuscegthesis.cls
% LaTeX class for typesetting a thesis for Computer Engineering undergraduates
% at the National University of Singapore (NUS)
% Author: Kabir Khandpur
%
% The most recent version can be found here:
% https://github.com/kabir-plod/nuscegthesis/blob/master/nuscegthesis.cls

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{nuscegthesis}[2018/12/14 v0.1 National University of Singapore Computer Engineering Undergraduate Thesis Class]

%    ****************************************
%    *               OPTIONS                *
%    ****************************************
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax
\LoadClass{report}


%    ****************************************
%    *               PACKAGES               *
%    ****************************************
% To change margins temporarily, use the \changemargin macro defined below
\RequirePackage[a4paper,left=4cm,right=3cm,top=3cm,bottom=3cm]{geometry}
\RequirePackage{setspace}  % easy switching between single/double spacing
\RequirePackage{titlesec}  % format titles
\RequirePackage{parskip}  % remove indentation at start of paragraphs
\RequirePackage[sorting=none]{biblatex}  % number citations in order of appearance
\addbibresource{references.bib}
\RequirePackage{tocbibind}  % automatically include list of figures/tables in toc
\RequirePackage{hyperref}  % import hyperref last


%    ****************************************
%    *                CONFIG                *
%    ****************************************
\doublespacing  % double spacing
\pagestyle{plain}  % page number at bottom centre
\setlength{\parskip}{2ex}  % blank line between paragraphs

% Centered bold uppercase chapter titles
\titleformat{\chapter}[display]
  {\normalfont\Large\bfseries\centering}
  {\thechapter}
  {0em}
  {\MakeUppercase}

% Chapter number and name on separate lines
\titlespacing*{\chapter}
  {0em}
  {-50pt}
  {2.5ex}


%    ****************************************
%    *             USER MACROS              *
%    ****************************************
\newcommand{\code}[1]{\texttt{#1}}  % print text as code


%    ****************************************
%    *             FRONT MATTER             *
%    ****************************************

% DECLARATIONS
%
% These macros are used to declare arguments needed for the
% construction of the front matter.

% The full (unabbreviated) name of the degree
\def\degree#1{\gdef\@degree{#1}}

% The name of your thesis department (eg. Electrical and Computer Engineering)
\def\department#1{\gdef\@department{#1}}

% The academic year in which the project was undertaken (eg. 2018/2019)
\def\academicyear#1{\gdef\@academicyear{#1}}

% The ID of your project
\def\projectid#1{\gdef\@projectid{#1}}

% The name of your supervisor
\def\supervisor#1{\gdef\@supervisor{#1}}

% The deliverables of your project
\def\deliverables#1{\gdef\@deliverables{#1}}
\def\deliverablestwo#1{\gdef\@deliverablestwo{#1}}
\def\deliverablesthree#1{\gdef\@deliverablesthree{#1}}


% \maketitle outputs the complete title page.  It requires all the
% above macros.

% Temporarily change margins to centre text
\def\changemargin#1#2{\list{}{\rightmargin#2\leftmargin#1}\item[]}
\let\endchangemargin=\endlist

% Set the block letters that will be used in the cover and title pages
\def\blocklt#1{\textbf{\MakeUppercase{#1}}}
\def\blockltit#1{\textit{\textbf{\MakeUppercase{#1}}}}

% TITLE (COVER) PAGE
\def\maketitle{
    \thispagestyle{empty}
    \begin{changemargin}{-1cm}{0cm}
    \begin{singlespace}
    \begin{center}
        \blockltit{\@title}\par
        \vfill
        Submitted by\\
        \@author\\~\\
        Department of \@department\par
        \vfill
        In partial fulfillment of the\\
        requirements for the Degree of\\
        \@degree\\
        National University of Singapore\par
    \end{center}
    \end{singlespace}
    \end{changemargin}
    \pagebreak
}


% (SECONDARY) TITLE PAGE
\newcommand\secondarytitlepage{
    \thispagestyle{empty}
    \begin{changemargin}{-1cm}{0cm}
    \begin{center}
        B.Eng Dissertation\par
        \vspace{8em}
        \blocklt{\@title}\par
        \vspace{8em}
        By\\\
        \@author\\\
        National University of Singapore\\
        \@academicyear\par
        \vfill
    \end{center}
    \begin{flushleft}
    \begin{singlespace}
        Project ID: \@projectid\\
        Project Supervisor: \@supervisor\\~\\
        Deliverables:\\
        \hspace{4em}{\@deliverables}\\
        \ifdefined \deliverablestwo
            \\ \hspace{4em}{\@deliverablestwo}
            \ifdefined \deliverablesthree
                \\ \hspace{4em}{\@deliverablesthree}
            \fi
        \fi
    \par
    \end{singlespace}
    \end{flushleft}
    \end{changemargin}
    \pagebreak
}

%    ************  ENVIRONMENTS ************
% ABSTRACT
\def\abstract{
  \phantomsection\addcontentsline{toc}{chapter}{\abstractname}
  \begin{center}{
    {\blocklt{\large \bfseries \abstractname}}\par
  }
  \end{center}
}

\def\endabstract{\par\vfil\newpage}


% ACKNOWLEDGMENTS
\newcommand\acknowledgename{Acknowledgments}

\def\acknowledgments{
  \phantomsection\addcontentsline{toc}{chapter}{\acknowledgename}
  \begin{center}{
    {\blocklt{\large \bfseries \acknowledgename}}\par
  }
  \end{center}
}

\def\endacknowledgments{\par\vfil\newpage}


% FRONTMATTER
% The FRONTMATTER environment makes sure that page numbering is set
% correctly (roman, lower-case, starting at 1) for the front matter
% starting from the abstract.  It also resets page-numbering for
% the remainder of the thesis (arabic, starting at 1).

\newenvironment{frontmatter}
    {\setcounter{page}{1}\renewcommand{\thepage}{\roman{page}}}
    {\newpage\renewcommand{\thepage}{\arabic{page}}\setcounter{page}{1}}


% Redefinition of ToC command to get single spacing
\makeatletter
\renewcommand\tableofcontents{%
    \begin{spacing}{1.5}
    \null\hfill\textbf{\Large\MakeUppercase\contentsname}\hfill\null\par
    \@mkboth{\MakeUppercase\contentsname}{\MakeUppercase\contentsname}%
    \@starttoc{toc}%
    \end{spacing}
}
\makeatother
