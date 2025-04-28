% based on isuthesis style file
% Revision 2.0 2024 - Tagged thesis 
% -- Sarah McCarty
% Revision 1.03 11/02/14 13:51:00  jastruss
% -- Joe Struss (2011/2/14)
% Revision 1.02 11/01/08 13:12:00  jastruss
% -- Joe Struss (2011/1/8)
%%
%% LaTeX document package `isuthesistagged', for use with LaTeX2e.
%% This is a package that is used with the report class to
%%   create a thesis at Iowa State University.
%%
%% Copyright from original isuthesis file:
%% COPYRIGHT 2011, by Joe Struss (jastruss@iastate.edu)
%%
%% Copying of part or all of any file in the iastatethesis class
%% is allowed under the following conditions only:
%% (1) You may freely distribute unchanged copies of the files. Please
%%     include the any or all documentation when you do so.
%% (2) You may modify a renamed copy of any file, but only for personal
%%     use or use within an organization.
%% (3) You may copy fragments from the files, for personal use or for use
%%     in a macro package for distribution, as long as credit is given
%%     where credit is due.
%%
%% You are NOT ALLOWED to take money for the distribution or use of
%% these files or modified versions or fragments thereof, except for
%% a nominal charge for copying etc.
%%

\def\fileversion{2.0}
\def\filedate{2024/02/14}
\typeout{%
    Document Class: isuthesistagged \filedate \space v\fileversion \space (v1 by Joe Struss)}

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{isuthesistagged}[2011/02/14]
%  Requires the Geometry Package

%\usepackage{etoolbox}
\usepackage{xpatch}
%  Thesis looks much like report

\newtoggle{math-tagthesis}
\togglefalse{math-tagthesis}

\newtoggle{algorithms-tagthesis}
\togglefalse{algorithms-tagthesis}

\DeclareOption{math-packages}{%
    \toggletrue{math-tagthesis}
}

\DeclareOption{algorithms-packages}{%
    \toggletrue{algorithms-tagthesis}
}

\DeclareOption{no-mathml}{
    \tagpdfsetup{
        math/mathml/sources=,
        math/mathml/luamml/load=false,
        math/tex/AF=false
    }
}

\DeclareOption{no-tag-tree}{
    \AddToHook{enddocument/end}{\tagpdfsetup{activate/tree=false}}
}

\DeclareOption{bib-no-break}{
    \AtEndPreamble{
        \renewcommand*{\bibsetup}{%
            \interlinepenalty=10000\relax %up from 5000 by default
            \widowpenalty=10000\relax
            \clubpenalty=10000\relax
            \raggedbottom
            \frenchspacing
            \biburlsetup
        }
    }
}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}

\ProcessOptions\relax
\LoadClass[notitlepage]{report}
% notitlepage is used because \begin{abstract} uses titlepage by default, which resets the page numbers

%%%%
% 2024 Additions for new requirements and modern conveniences
%%%%
%%%%
% Patching needed to get TOC and Part pages to look as desired.
% Must be patched before hyperref is loaded.
%%%%

%adds a Period to the numberline
\newcommand{\numberlineP}[1]{\numberline{#1.}}
\xpatchcmd{\@chapter}% <cmd>
{\numberline}% <search>
{\numberlineP}% <replace>
{}{}% <success><failure>
\xpatchcmd{\@part}% <cmd>
{\thepart}% <search>
{PART \thepart}% <replace>
{}{}% <success><failure>\makeatother
\xpatchcmd{\@part}% <cmd>
{\huge}% <search>
{\Large}% <replace>
{}{}% <success><failure>\makeatother
\xpatchcmd{\@part}% <cmd>
{\Huge}% <search>
{\Large}% <replace>
{}{}% <success><failure>\makeatother
\xpatchcmd{\@spart}% <cmd>
{\Huge}% <search>
{\Large}% <replace>
{}{}% <success><failure>\makeatother
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%footnote without a number
\newcommand\blfootnote[1]{%
    \begingroup
    \renewcommand\thefootnote{}\footnote{#1}%
    \addtocounter{footnote}{-1}%
    \endgroup
}
\newcommand{\twoLineTitle}[2]{
    \newcommand{\titleWithLineBreak}{#1\\#2}
    \newcommand{\titleWithoutBreak}{#1 #2}
}

%Add the page number in a modern way - works nicer with other modern things
\usepackage{fancyhdr}
\renewcommand{\headrulewidth}{0pt}
%plain style is used on the first page of chapters
\fancypagestyle{plain}{
    \fancyhead[L,R]{}
    \fancyhead[C]{\thepage}
    \fancyfoot[L,C,R]{}
}
\fancyhead[L,R]{}
\fancyhead[C]{\thepage}
\fancyfoot[L,C,R]{}

%Following command adds numberless chapters
%to the TOC correctly while being compatible with tagging
\let\@tempchapapp=\@chapapp
\newcommand{\addToTOCWithoutChapter}[1]{%
    \addtocontents{toc}{\def\protect\@chapapp{}}%
    \MakeLinkTarget[specialchapt]{}%
    \addcontentsline{toc}{chapter}{#1}%
    \addtocontents{toc}{\def\protect\@chapapp{\@tempchapapp}}
}

\usepackage{titlesec}
%% Patches needed for titlesec to work with tagging in 2024
% Will likely be natively supported by the package/Latex
% See this issue: https://github.com/latex3/tagging-project/issues/24

\patchcmd\ttl@straight@ii
{\@svsechd\unskip}
{\@svsechd\unskip\tagtool {sec-split-para}}
{}{\fail}

\patchcmd\ttl@straight@ii
{\@afterheading}
{\tagtool{restore-para}\@afterheading}
{}{\fail}

\patchcmd\ttl@straight@i
{\par}
{\par\tagtool{sec-start=#1}\tagtool{para}}
{}{\fail}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Format the section title appropriately (while being compatible with tagging)
\newcommand{\chapterTitle}{CHAPTER}
%this command is used so it can be redefined to be appendix when needed

\newtoggle{singleappendix-tagthesis}
\togglefalse{singleappendix-tagthesis}

\titleformat{\chapter}[block]{\large\centering\bfseries}{%
    \chapterTitle%
    \nottoggle{singleappendix-tagthesis}{\ \thechapter}{}%
    .%
}{12pt}{}
\titlespacing{\chapter}{0pt}{0in}{0.6in}
\titleformat{\section}[block]{\large\centering\bfseries}{\thesection}{.5em}{}
\titlespacing{\section}{0pt}{*3}{2.3ex \@plus.2ex}
\titleformat{\subsection}[block]{\normalsize\bfseries\filright}{\thesubsection}{.5em}{}
\titlespacing{\subsection}{0pt}{*3}{1.5ex \@plus .2ex}
\titleformat{\subsubsection}[block]{\bfseries\filright}{\thesubsubsection}{.5em}{}
\titlespacing{\subsubsection}{0.25in}{*3}{1.5ex \@plus .2ex}
\titleformat{\paragraph}[block]{\normalsize\bfseries\filright}{\thesubsection}{.5em}{}
\titlespacing{\paragraph}{0pt}{*3}{1.5ex \@plus .2ex}
\titleformat{\subparagraph}[block]{\bfseries\filright}{\thesubsubsection}{.5em}{}
\titlespacing{\subparagraph}{0.25in}{*3}{1.5ex \@plus .2ex}
%Formatting Part breaks the TOC implementation as of 2024, hence why it is patched instead
%%%%%%%%%%%%%%%
%%%%%%%%%%

\usepackage{setspace}

%%%%
%% Subpackage: isumacros.sty for use with the isuthesis package.
%%
%% LaTeX document package `isuthesis', for use with LaTeX2e.
%% This is a package that is used with the report class to
%%   create a thesis at Iowa State University.
%%
%% COPYRIGHT 1997, by Joe Struss (jastruss@iastate.edu)
%%
%% Copying of part or all of any file in the isuthesis.sty package
%% including isumacros.sty, thesisreport.sty and isuthesis.sty
%% is allowed under the following conditions only:
%% (1) You may freely distribute unchanged copies of the files. Please
%%     include the any or all documentation when you do so.
%% (2) You may modify a renamed copy of any file, but only for personal
%%     use or use within an organization.
%% (3) You may copy fragments from the files, for personal use or for use
%%     in a macro package for distribution, as long as credit is given
%%     where credit is due.
%%
%% You are NOT ALLOWED to take money for the distribution or use of
%% these files or modified versions or fragments thereof, except for
%% a nominal charge for copying etc.
%%
%    ****************************************
%    *           INITIALIZATION             *
%    ****************************************
%
% Default initializations

%\ps@plain                          % 'plain' page style.
\pagenumbering{arabic}             % Arabic page numbers.
\onecolumn                         % Single column.
\if@twoside\else\raggedbottom\fi   % Ragged bottom unless twoside option.

%   ***********************************************
%   *    Local (Iowa State University) macros     *
%   ***********************************************

% 2024 - Does anyone actually use these? They are so buried in this file.
% My guess is that bibliography commands do not even work with biblatex.

% SUPERSCRIPTS AND SUBSCRIPTS
% Declaration which causes superscripts and subscripts to be output at normal
% text size
\def\bigscript{
    \scriptfont0=\textfont0
    \scriptscriptfont0=\textfont0
    \scriptfont1=\textfont1
    \scriptscriptfont1=\textfont1
    \scriptfont2=\textfont2
    \scriptscriptfont2=\textfont2
    \scriptfont3=\textfont3
    \scriptscriptfont3=\textfont3
    \def\xiipt{\textfont\z@\twlrm
        \scriptfont\z@\twlrm \scriptscriptfont\z@\twlrm
        \textfont\@ne\twlmi \scriptfont\@ne\twlmi \scriptscriptfont\@ne\twlmi
        \textfont\tw@\twlsy \scriptfont\tw@\twlsy \scriptscriptfont\tw@\twlsy
        \textfont\thr@@\tenex \scriptfont\thr@@\tenex \scriptscriptfont\thr@@\tenex
        \def\unboldmath{\everymath{}\everydisplay{}\@nomath\unboldmath
            \textfont\@ne\twlmi
            \textfont\tw@\twlsy \textfont\lyfam\twlly
            \@boldfalse}\@boldfalse
        \def\boldmath{\@ifundefined{twlmib}{\global\font\twlmib\@mbi\@magscale1\global
                \font\twlsyb\@mbsy \@magscale1\global\font
                \twllyb\@lasyb\@magscale1\relax\@addfontinfo\@xiipt
                {\def\boldmath{\everymath
                        {\mit}\everydisplay{\mit}\@prtct\@nomathbold
                        \textfont\@ne\twlmib \textfont\tw@\twlsyb
                        \textfont\lyfam\twllyb\@prtct\@boldtrue}}}{}\@xiipt\boldmath}%
        \def\prm{\fam\z@\twlrm}%
        \def\pit{\fam\itfam\twlit}\textfont\itfam\twlit \scriptfont\itfam\egtit
        \scriptscriptfont\itfam\sevit
        \def\psl{\fam\slfam\twlsl}\textfont\slfam\twlsl
        \scriptfont\slfam\tensl \scriptscriptfont\slfam\tensl
        \def\pbf{\fam\bffam\twlbf}\textfont\bffam\twlbf
        \scriptfont\bffam\ninbf \scriptscriptfont\bffam\ninbf
        \def\ptt{\fam\ttfam\twltt}\textfont\ttfam\twltt
        \scriptfont\ttfam\nintt \scriptscriptfont\ttfam\nintt
        \def\psf{\fam\sffam\twlsf}\textfont\sffam\twlsf
        \scriptfont\sffam\tensf \scriptscriptfont\sffam\tensf
        \def\psc{\@getfont\psc\scfam\@xiipt{\@mcsc\@magscale1}}%
        \def\ly{\fam\lyfam\twlly}\textfont\lyfam\twlly
        \scriptfont\lyfam\egtly \scriptscriptfont\lyfam\sixly
        \@setstrut \rm}
} %end bigscript

% Singlespaced hanging paragraph environment for uncited bibliographies.
\def\hangpar{\par \def\baselinestretch{1}\@normalsize
    \raggedright \parindent=0pt \parskip=12pt
    \everypar{\hangindent=24pt \hangafter=1}}
\def\endhangpar{\par}

% Singlespaced hanging paragraph environment suitable for uncited
% bibliographies in sociology and anthropology.
\newif\if@firstdate \@firstdatetrue
\def\socbib{\par \def\baselinestretch{1}\@normalsize
    \raggedright \parindent=0pt \parskip=0pt
    \newskip\socparskip \socparskip = 12pt
    \newdimen\@datewidth \@datewidth = 60 pt
    \newdimen\@stextwidth \@stextwidth=\textwidth
    \advance \@stextwidth by -\@datewidth
    \newskip\@socskip \@socskip=5pt plus 1pt minus 1pt
    \newbox\@sdatebox
    \def\@twodates##1[##2]{\global\setbox\@sdatebox=\vtop{%
            \hbox to \@datewidth{\kern 20 pt ##1\hfil}%
            \hbox to \@datewidth{\kern 20 pt ##2\hfil}%
        }\@socdate}
    \def\@onedate##1{\global\setbox\@sdatebox=%
        \vtop{\hbox to \@datewidth{\kern 20pt ##1\hfil}}\@socdate}
    \def\par{\egroup \egroup \endgraf \vskip\socparskip \@firstdatetrue}
    \def\@socdate{\if@firstdate \endgraf \nopagebreak \@firstdatefalse \else %
            \egroup \egroup \endgraf \vskip\@socskip \fi%
        \hbox to \textwidth\bgroup%
        \box\@sdatebox\vtop\bgroup\hsize\@stextwidth\ignorespaces}
    \def\socdate##1{\@ifnextchar[{\@twodates{##1}}{\@onedate{##1}}}
}
\def\endsocbib{\egroup\egroup\endgraf\vskip\baselineskip}

%%%Title Page
\def\titlepage
{\thispagestyle{empty}
    \pagenumbering{roman}}
\def\endtitlepage{\newpage}

\def\title#1{\gdef\@title{#1}}              \title{Unknown}
\def\author#1{\gdef\@author{#1}}            \author{Unknown}
\def\format#1{\gdef\@format{#1}}            \format{thesis}
\def\degree#1{\gdef\@degree{#1}}            \degree{MASTER OF ARTS}
%\def\mprof#1{\gdef\@mprof{#1, Major Professor}} \def\@mprof{}
\def\submit#1{\gdef\@submit{#1}}            \submit{the graduate faculty}

\newcount\@deptnum  \@deptnum=1
\newcount\@majornum \@majornum=1
\def\@depart{}
\def\@deptone{}
\def\@depttwo{}
\def\@depttitle{}

% Relic of needing a signature page
% \newcount\@numcomm
% \def\committee#1{\@numcomm=#1}
% \committee{0}

\newdimen\@signwidth \@signwidth=6cm

\def\@depmajmac#1#2#3#4{% department and major macro
    \ifcase\@deptnum \def\@depart{}
    \or \def\@depart{\@depttitle #1 \\}
    \else \def\@depart{\@depttitle #1\\ #2\\}\fi
    \ifcase\@majornum \def\@major{}
    \or \def\@major{\@majortitle #3}
    \else \def\@major{\@majortitle #3 \\  #4}\fi}

\newif\if@interdept \@interdeptfalse
\newif\if@interdeptm \@interdeptmfalse
\newcount\signdeptnum  \signdeptnum=1
\newcount\signmajornum \signmajornum=1

\def\interdept{\@interdepttrue}
\def\interdeptm{\@interdeptmtrue}

\def\dept#1{\gdef\@deptone{#1} \gdef\@depttwo{} \@deptnum=1
    \if@interdept\def\@depttitle{Interdepartmental Program: } \else
        \def\@depttitle{Department: }\fi}
\def\codepts#1#2{\gdef\@deptone{#1} \gdef\@depttwo{#2} \@deptnum=2
    \def\@depttitle{Departments: }\signdeptnum=2}
\def\major#1{\@majornum=1 \@depmajmac{\@deptone}{\@depttwo}{#1}{}
    \if@interdeptm\def\@majortitle{Interdepartmental Major: } \else
        \def\@majortitle{Major: }\fi}
\def\comajors#1#2{\@majornum=2 \signmajornum=2
    \@depmajmac{\@deptone}{\@depttwo}{#1}{#2}
    \def\@majortitle{Co-majors: }}

\def\signmajor#1{\def\@signmajor{#1}}
\signmajor{\ifnum\signmajornum=2 Co-major Professor \else
        Major Professor\fi}
\def\signdept#1{\def\@signdept{#1}}
\signdept{\if@interdept For the Major Program \else
        \ifnum\@deptnum=2 For the Co-major Program \else
            For the Major Program\fi\fi}

\def\@depart{}
\def\@major{}

\def\minor#1{\def\@minor{\\Minor: #1}}
\def\@minor{}

\def\mprof#1{\def\@mprof{#1, Major Professor}\signmajornum=2} \def\@mprof{}

% original changed july 2017
%\def\mprofs#1#2{\def\@mprofs{#1, Co-major Professor\\#2, Co-major Professor} 
%\signmajornum=2} 
%\def\@mprofs{}

\def\mprofs#1{\def\@mprofs{#1, Co-major Professor}}
\def\@mprofs{}

\def\cmprofs#1{\def\@cmprofs{\\#1, Co-major Professor}}
\def\@cmprofs{}

\def\members#1{\def\@members{\\#1}}
\def\@members{}

\def\disclaimertitlepage{\def\@disclaimertitlepage{The student author, whose presentation of the scholarship herein was approved by the program of study committee, is solely responsible for the content of this \@format{}. The Graduate College will ensure this \@format{} is globally accessible and will not permit alterations after a degree is conferred.}}
\def\@disclaimertitlepage{}

\def\copyyear#1{\gdef\@copyyear{\number#1}}
\copyyear{\year}
\def\notice{\gdef\@notice{Copyright
        \copyright\/ \@author,\ \@copyyear. All rights reserved.}}
\def\@notice{}

\def\supervisor#1{\gdef\@supervisor{#1}}
\def\@supervisor{}

\def\@titlefoot{\begin{center}Iowa State University\\
        Ames, Iowa\\ \@copyyear\  \\
        \@notice \end{center}}%Added \  after \@copyyear to avoid having \\ problem

\long\def\maketitle{\begin{titlepage}

        % \vbox ensures whole title page stays on one page even if it becomes overfull
        \vbox to \textheight{
            \begin{center}
                \vskip 45pt                   % Added to more evenly space page (JAS11)
                    {\bfseries \@title}
                \vskip 12pt                    % Changed from 11pt to more evenly space page (JAS11)
                by \\
                \vskip 12pt                   % Changed from 11pt to more evenly space page (JAS11)
                    {\bfseries \@author}      % Changed to bold at thesis office request (JAS16)
                \vskip 40pt                  % Changed from 30pt to more evenly space page (JAS11)
                A \@format\ submitted to \@submit\ \\
                in partial fulfillment of the requirements for the degree of\\
                \@degree \\[2.5pt]

                \vskip 40pt                   % Changed from 30pt to cover dept loss
                %   \@depart
                \@major
                %   \@minor                     % No longer listed - Sept. 2001
                \vskip 55pt                    % Changed from 14pt to more evenly space page (JAS11)
                \begin{singlespace}  % Elminated to more evenly space page (JAS11)
                    Program of Study Committee: \\
                    \@mprof
                    \@mprofs
                    \@cmprofs
                    \@members
                    %\end{singlespace}   % Eliminated to more evenly space page (JAS11)
                    \vfill
                    \vspace{12pt} %default was 4 pts
                    %   %\vfill
                    \@disclaimertitlepage
                \end{singlespace}   % Eliminated to more evenly space page (JAS11)
            \end{center}
            \vfill
            \vspace{12pt}%{14pt}
            \vfill
            \@titlefoot } % end of \vbox
    \end{titlepage}
}% end maketitle

\def\alternatepartnum{%  command to number only parts
    \setcounter{secnumdepth}{0}
    \renewcommand{\thechapter}{}
    \makeatletter
    \renewcommand{\thefigure}{\@arabic\c@figure}
    \renewcommand{\theequation}{\arabic{equation}}
    \renewcommand{\thetable}{\@arabic\c@table}
    \makeatother
}

\def\alternatechapnum{%  command to number only parts and chapters
    \setcounter{secnumdepth}{0}
    \makeatletter
    \renewcommand{\thefigure}{\@arabic\c@figure}
    \renewcommand{\theequation}{\arabic{equation}}
    \renewcommand{\thetable}{\@arabic\c@table}
    \makeatother
}

\def\reset{% resets many chapter level counters
    \setcounter{chapter}{0}
    \setcounter{section}{0}
    \setcounter{subsection}{0}
    \setcounter{subsubsection}{0}
    \setcounter{paragraph}{0}
    \setcounter{subparagraph}{0}
    \setcounter{equation}{0}
    \setcounter{figure}{0}
    \setcounter{table}{0}
    \setcounter{footnote}{0}
    \setcounter{mpfootnote}{0}
}

\def\nochap{% bizarre hack to not use a chapter number
    \makeatletter
    \renewcommand{\thefigure}{\@arabic\c@figure}
    \renewcommand{\theequation}{\arabic{equation}}
    \renewcommand{\thetable}{\@arabic\c@table}
    \makeatother
    \renewcommand{\thechapter}      {}
    \renewcommand{\thesection}      {\arabic{section}}
    \renewcommand{\thesubsection}   {\thesection.\arabic{subsection}}
    \renewcommand{\thesubsubsection}{\thesubsection .\arabic{subsubsection}}
    \renewcommand{\theparagraph}    {\thesubsubsection.\arabic{paragraph}}
    \renewcommand{\thesubparagraph} {\theparagraph.\arabic{subparagraph}}
}%end nochap

\def\partnochap{% bizarre hack to not use a chapter number but use parts
    \makeatletter
    \renewcommand{\thefigure}{\@arabic\c@figure}
    \renewcommand{\theequation}{\arabic{equation}}
    \renewcommand{\thetable}{\@arabic\c@table}
    \makeatother
    %   \renewcommand{\thepart}         {\roman{part}}
    \renewcommand{\thechapter}      {}
    \renewcommand{\thesection}      {\thepart.\arabic{section}}
    \renewcommand{\thesubsection}   {\thesection.\arabic{subsection}}
    \renewcommand{\thesubsubsection}{\thesubsection .\arabic{subsubsection}}
    \renewcommand{\theparagraph}    {\thesubsubsection.\arabic{paragraph}}
    \renewcommand{\thesubparagraph} {\theparagraph.\arabic{subparagraph}}
}%end partnochap

% The thesis office wants Chapters with a dotted leader
% (This redefinition borrowed from isuthes may not be a very
%  good idea but it seems to work.) - JAS, April 1996

\renewcommand{\l@chapter}[2]{\addpenalty{-\@highpenalty}
    \setlength{\baselineskip}{13.2pt} %this resets the size of a line from the (much wider) default to 1.2x11pt = 13.2pt font, which matches the single spacing required by the grad college for the TOC. Because it is only this function, it is local to the TOC and won't effect spacing in the rest of the dissertation. 
    \vskip 13.2pt plus 0pt %adds a blank line after a chapter item 
        %\vskip 4pt plus 2pt
        %{\bf \@dottedtocline{0}{0em}{1.5em}{\@chapapp#1}{#2}}}
        {\@dottedtocline{0}{0em}{1.5em}{\@chapapp#1}{#2}}}

% 2024 - I don't get how these commands ever added the word Table or Figure
% but I think they add the dotted leader, so here they stay 

% The following lines and a slight redefinition in isucaption allow
% the word Table and Figure to be placed before Table and Figure entries
% in the List of Tables and List of Figures
% Set the space in the List of Tables and List of Figures (lot) (lof)

%\renewcommand{\l@figure}{\@dottedtocline{1}{1.5em}{6em}}
%\renewcommand{\l@table}{\@dottedtocline{1}{1.5em}{6em}}

%\renewcommand{\l@figure}{\@dottedtocline{1}{1.5em}{6em}} % Use this in List of Figures instead of the renewcommand section below for original latex spacing
%\renewcommand{\l@figure}{\addpenalty{-\@highpenalty}\setlength{\baselineskip}{13.2pt}\vskip 4pt\@dottedtocline{1}{1.5em}{6em}}
\renewcommand{\l@figure}{\addpenalty{-\@highpenalty}\setlength{\baselineskip}{13.2pt}\vskip 13.2pt plus 0pt\@dottedtocline{1}{1.5em}{6em}}

%\renewcommand{\l@table}{\@dottedtocline{1}{1.5em}{6em}}  % Use this in List of Tables instead of the renewcommand and newcommand section below for original latex spacing
%\renewcommand{\l@table}{\addpenalty{-\@highpenalty}\setlength{\baselineskip}{13.2pt}\vskip 4pt\@dottedtocline{1}{1.5em}{6em}}
\renewcommand{\l@table}{\addpenalty{-\@highpenalty}\setlength{\baselineskip}{13.2pt}\vskip 13.2pt plus 0pt\@dottedtocline{1}{1.5em}{6em}}
\newcommand*{\noaddvspace}{\renewcommand*{\addvspace}[1]{}}
\addtocontents{lof}{\protect\noaddvspace}
\addtocontents{lot}{\protect\noaddvspace}

% Resets part name so PART appears
% 2024 - I think this is unused b/c the @part is patched instead

\renewcommand{\partname}{PART\ }

% Resets appendix command so the word APPENDIX appears
% after unsetting chaptername

\def\appendixtitle{% resets appendixname
    \def\@chapapp{APPENDIX}
    \def\thechapter{}
    \addtocontents{toc}{\def\protect\@chapapp{APPENDIX\ }}
    %\renewcommand{\appendixname}{APPENDIX\ }
    \renewcommand{\chapterTitle}{APPENDIX}
}

% USE THE following instead of \appendixtitle for singleappendix
% first \unappendixtitle
% second \singleappendixtitle
\def\singleappendixtitle{% resets appendixname
    \toggletrue{singleappendix-tagthesis}
    \def\@chapapp{APPENDIX}
    \def\thechapter{}
    \addtocontents{toc}{\def\protect\@chapapp{APPENDIX}}
    %\renewcommand{\appendixname}{APPENDIX\ }
    \renewcommand{\chapterTitle}{APPENDIX}
    %Single appendix has no number, hence no space
    \setcounter{chapter}{0}
    \setcounter{section}{0}
    \bookmarksetup{numbered=false}
}

\def\finishAppendixSetup{%
    \iftoggle{singleappendix-tagthesis}{
        \renewcommand{\thechapter}{A}
    }
}

% Resets appendix command so the word APPENDIX appears
% after unsetting chaptername

\def\unappendixtitle{% resets appendixname
    \def\@chapapp{}
    \def\thechapter{}
    \addtocontents{toc}{\def\protect\@chapapp{}}
    \togglefalse{singleappendix-tagthesis}
}
%%%%%%%%%%%%%%%%%%%%

% % Protects added (JAS05 / JAS09)
\renewcommand{\contentsname}
{\protect \centering \large TABLE OF CONTENTS } %JAS
\renewcommand{\listfigurename}
{\protect \centering \large LIST OF FIGURES}  %JAS
\renewcommand{\listtablename}
{\protect \centering \large LIST OF TABLES}    %JAS

%%%%
%% Subpackage: thesisreport.sty for use with the isuthesis package.
%%
%% LaTeX document package `isuthesis', for use with LaTeX2e.
%% This is a package that is used with the report class to
%%   create a thesis at Iowa State University.
%%
%% COPYRIGHT 1997, by Joe Struss (jastruss@iastate.edu)
%%
%% Copying of part or all of any file in the isuthesis.sty package
%% including isumacros.sty, thesisreport.sty and isuthesis.sty
%% is allowed under the following conditions only:
%% (1) You may freely distribute unchanged copies of the files. Please
%%     include the any or all documentation when you do so.
%% (2) You may modify a renamed copy of any file, but only for personal
%%     use or use within an organization.
%% (3) You may copy fragments from the files, for personal use or for use
%%     in a macro package for distribution, as long as credit is given
%%     where credit is due.
%%
%% You are NOT ALLOWED to take money for the distribution or use of
%% these files or modified versions or fragments thereof, except for
%% a nominal charge for copying etc.
%%
%Standard Report class changes;  JAS 10/95-3/96
%  Part -standard (change Huge and huge to Large
%%%%  both afterindentfalse and afterindenttrue should mean the same thing after below

% \let\@afterindentfalse\@afterindenttrue
% \@afterindenttrue
%%%%
%\usepackage[all]{nowidow}
%

%%%%%%%%%%%%%%%%%%2025 fixes and new packages
\newlength{\normalparindent}
\newlength{\normalparskip}

\newcommand{\frontmattersetup}{
    \pagestyle{fancy}
    \raggedright
    \parindent 0.25 in % set all paragraphs in the document to have indent

    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % %% The line below adds the word "Page" over the page numbers in TOC, LOT, LOF
    \addtocontents{toc}{~\hfill\tagstructbegin{tag=Lbl,stash,label=pageOfTOC}\tagmcbegin{tag=Lbl}\textbf{Page}\par\tagmcend\tagstructend}
    \addtocontents{lot}{~\hfill\tagstructbegin{tag=Lbl,stash,label=pageOfLOT}\tagmcbegin{tag=Lbl}\textbf{Page}\par\tagmcend\tagstructend}
    \addtocontents{lof}{~\hfill\tagstructbegin{tag=Lbl,stash,label=pageOfLOF}\tagmcbegin{tag=Lbl}\textbf{Page}\par\tagmcend\tagstructend}
    % %%
    \setlength{\normalparindent}{\parindent}%
    \setlength{\normalparskip}{\parskip}%
}

\newcommand{\tableofcontentsTagged}{
    {
            \pdfbookmark[0]{TABLE OF CONTENTS}{table}
            \tableofcontents
            \tagstructuse{pageOfTOC} %gets tagging of "Page" done
        }
    \addtocontents{toc}{\def\protect\@chapapp{}}
}
\newcommand{\listoftablesTagged}{
    \MakeLinkTarget[specialchapter]{}%necessary for tagging (as of 2024)
    \addcontentsline{toc}{chapter}{LIST OF TABLES}
    \listoftables
    \tagstructuse{pageOfLOT}%gets tagging of "Page" done
}
\newcommand{\listoffiguresTagged}{
    \MakeLinkTarget[specialchapter]{} %necessary for tagging (as of 2024)
    \addcontentsline{toc}{chapter}{LIST OF FIGURES}
    \listoffigures
    \tagstructuse{pageOfLOF}%gets tagging of "Page" done
}

\newcommand{\nomenclatureTagged}{

    \MakeLinkTarget[specialchapter]{}
    \include{Preface/nomenclature}
}

%In the tagging structure, this collects the floats in each
%section. Without it, all the floats for the entire document
%are collected.
\AddToHook{cmd/section/before}{\tagtool{flush-floats=subsection}}
\AddToHook{cmd/chapter/before}{\tagtool{flush-floats=subsection}}

%Caption package & tagging fixes
\usepackage{caption}
\usepackage{subcaption}
%This work-around comes from: https://github.com/latex3/tagging-project/issues/720
\RemoveFromHook{begindocument}[latex-lab-testphase-float]
\ExplSyntaxOn

\socket_new_plug:nnn{tagsupport/parbox/before}{caption}
{
    \tagpdfparaOn %restart para tagging
    \tl_if_empty:NTF\@current@float@struct
    {
        \tag_struct_begin:n{tag=Caption,firstkid}
    }
    {
        \tag_struct_begin:n{tag=Caption,parent=\@current@float@struct,firstkid}
    }
}
\socket_new_plug:nnn{tagsupport/parbox/after}{caption}
{
    \tag_struct_end:
}
\l@addto@macro\caption@beginex@hook{%
    \tagpdfparaOff %leavevmode in parbox should not start paragraph structure
    \AssignSocketPlug{tagsupport/parbox/before}{caption}
    \AssignSocketPlug{tagsupport/parbox/after}{caption}}
\ExplSyntaxOff
\AtBeginDocument{
    \renewcommand*\caption@anchor[1]{%
        \ifmeasuring@ \else
            \caption@raisedlink{\MakeLinkTarget*{#1}}%
        \fi}%  
    \renewcommand{\chapterautorefname}{Chapter}
    \renewcommand{\sectionautorefname}{Section}
    \renewcommand{\subsectionautorefname}{Subsection}
    \renewcommand{\subsubsectionautorefname}{Subsubsection}
}
%This part is my own invention - to get subfigures
%to have captions be where they are supposed to be
%by appending some extras to the subfigure environment
%As with everything else, it probably won't be necessary
%in the long term
%
%Further, no warranties on the robustness
%If complicated subfigures are causing problems,
%you are probably are better commenting this out
%and dealing with the subpar tagging.
\ExplSyntaxOn
\cs_new_eq:NN \origsubfigure \subfigure
\cs_new_eq:NN \origsubfigureend \endsubfigure
\RenewDocumentCommand{\subfigure}{O{b} O{} O{s} m}{
    \origsubfigure[#1][#2][#3]{#4}
    \tagstructbegin{tag=Part}
    \tl_set:Ne\@current@float@struct{\tag_get:n{struct_num}}
}
\ExplSyntaxOff
\def\endsubfigure{
    \tagstructend
    \origsubfigureend
}

%%%Default setup I doubt much of anyone changes
\renewcommand{\chaptername}{CHAPTER\ }
% Old-style, thesis numbering down to subsubsection
\setcounter{secnumdepth}{3}

\setlength{\@fptop}{0pt} %command added to ensure images always float on top of the page

\usepackage{geometry}
\geometry{letterpaper, left=1in, top=1in, right=1in, bottom=1in, includehead=true,headheight=15pt}

\usepackage{graphicx}

\doublespacing
\AtBeginEnvironment{table}{\singlespacing}% 
\AtBeginEnvironment{figure}{\singlespacing}% 

\overfullrule=0pt

%%%Captioning Format
\DeclareCaptionListFormat{figureList}{Figure #1#2}
\DeclareCaptionListFormat{tableList}{Table #1#2}
\captionsetup[figure]{listformat=figureList}
\captionsetup[table]{listformat=tableList}
\captionsetup[ContinuedFloat]{list=no}

%%Optional packages
%math option
\ExplSyntaxOn
\iftoggle{math-tagthesis}{
    \usepackage{amsmath}
    \usepackage{amsthm}
    \usepackage{mathtools}
    \usepackage[thmtools-compat]{keytheorems}
    %\usepackage{thmtools}
    \cs_new_eq:NN \origproof \proof
    \RenewDocumentCommand{\proof}{O{\proofname}}{
        \origproof[#1]%
        \setlength{\parskip}{\normalparskip}%
        \setlength{\parindent}{\normalparindent}%
        \noindent%
        \ignorespaces
    }

}{}
\ExplSyntaxOff

%algorithms
\iftoggle{algorithms-tagthesis}{
    \usepackage[chapter]{algorithm}
    \usepackage{algpseudocode}
    \newcommand{\algmargin}{\the\ALG@thistlm}
    \renewcommand{\thealgorithm}{\thechapter.\arabic{algorithm}}
    \algnewcommand{\parstate}[1]{\State%
        \parbox[t]{\dimexpr\linewidth-\algmargin}{\strut #1\strut}}

}{}
