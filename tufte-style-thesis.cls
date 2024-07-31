\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tufte-style-thesis}[]

%	O P T I O N S
%
\newif\if@justified\@justifiedfalse
\DeclareOption{raggedright}{	% makes all paragraphs left-aligned
	\AtBeginDocument{
		\setlength{\RaggedRightParindent}{1em}
		\RaggedRight
	}
}
\DeclareOption{boxey}{
    \@justifiedtrue
}
\DeclareOption{parskip}{		% changes paragraph indents vor vertical skips
	\AtBeginDocument{\usepackage{parskip}}
	\setlength{\parskip}{\baselineskip}
}
\DeclareOption{casual}{		% removes header numbering --still puts them in toc
	\AtBeginDocument{\setcounter{secnumdepth}{0}}
}
\newif\if@sans\@sansfalse
\DeclareOption{sans}{
	\@sanstrue
	\renewcommand{\familydefault}{\sfdefault}
}
\newif\if@black\@blackfalse
\DeclareOption{black}{
	\@blacktrue
}
\newif\if@colorful\@colorfulfalse
\newif\if@black\@blackfalse
\DeclareOption{colorful}{
	\@colorfultrue
	\@blackfalse
}
\DeclareOption{black}{
	\@blacktrue
	\@colorfulfalse
}

\ExecuteOptions{}
\ProcessOptions\relax
\LoadClassWithOptions{book}

\if@justified
    \AtBeginDocument{
        \justifying
    }
\else
    \AtBeginDocument{
        \setlength{\RaggedRightParindent}{1em}
        \RaggedRight
    }
\fi

%	P A C K A G E   D E F I N I T I O N
%
\RequirePackage{emptypage}		% if a page is empty, it is really empty
\RequirePackage{fullwidth}		% for wide environments
\RequirePackage{sidenotes}	% for margin stuff
\RequirePackage[
	hypcap=false				% hypcap=true spits an error
]{caption}						% for caption formatting
\RequirePackage[T1]{fontenc}	% font encoding
\RequirePackage[osf]{libertinus}% main font
\RequirePackage{libertinust1math}
\RequirePackage{gillius}		% sans font
\RequirePackage[
	defaultmono,
	scale=.82
]{droidsansmono}				% mono font
\RequirePackage{ragged2e}		% for better raggedright
\RequirePackage{titlesec}		% header customization
\RequirePackage{titletoc}		% toc customization
\RequirePackage[titles]{tocloft}% lof lot lol customizatios
\RequirePackage{fancyhdr}		% page header customization
\RequirePackage{graphicx}		% for images
\RequirePackage[%				% listings
	% numberbychapter=true,
]{listings}
\RequirePackage[
	protrusion=true,
	expansion=true,
	final,
	tracking,
]{microtype}					% microtypography: fine-tuning in text
\RequirePackage{amsfonts}		% math fonts
\RequirePackage{amsmath}		% math stuff
\RequirePackage{mathtools}		% amsmath extension
%\RequirePackage{physics}		% handy shortcuts for physics
\RequirePackage{xcolor}			% colorz
\RequirePackage[framemethod=TikZ]{mdframed} % for custom code boxes
\RequirePackage{tabularx}		% adaptive columns on tables
\RequirePackage{booktabs}		% better looking tables
\RequirePackage{enumitem}		% better looking lists
\RequirePackage{setspace}
\RequirePackage[
    hidelinks,
    final,
    breaklinks,
    bookmarks,
    pdfusetitle,
    colorlinks,
    linkcolor=burgundy,
    citecolor=black  % This is for margin notes
]{hyperref}	% automatic references in pdf				% automatic references in pdf
\setitemize{parsep=3mm, topsep=3mm}

%\usepackage[colorlinks,citecolor=red,urlcolor=blue,bookmarks=false,hypertexnames=true]{hyperref} 

\RequirePackage{etoolbox}		% really idk what this does
\RequirePackage[strict]{changepage}	% needed by sidenotes
\RequirePackage{placeins}		% for floatbarrier
\RequirePackage{xparse}
\RequirePackage{xpatch}
\RequirePackage[
	% doi=false,
	% isbn=false,
	% url=false,
	autocite 	= superscript,
	backend 	= biber,
	citestyle 	= numeric-comp,
        %style       = authoryear,
	style 		= nature,
	% citecolor   = niceBlue,
	sorting		= none,
	bibencoding = utf8,
]{biblatex}
\RequirePackage{csquotes}
%%% TEST footmisc
\RequirePackage[
    perpage,
    symbol*,
    flushmargin,
    side,
    ragged,
]{footmisc}
% \RequirePackage{marginfix}
\makeatletter
  \renewcommand\@makefnmark{%
    \hbox{%
      \ifx\@fnsymbol\FN@fnsymbol@sym
        \expandafter\@firstofone
      \else
        \expandafter\@textsuperscript
      \fi
      {\normalfont\@thefnmark}%
    }%
  }
\makeatother
\RequirePackage{xifthen}
\RequirePackage{ifoddpage}
\RequirePackage[object=vectorian]{pgfornament} %%  http://altermundus.com/pages/tkz/ornament/index.html



% INDEX
\newcommand{\autoindex}[1]{#1\index{#1}}

%	C O L O R  D E F I N I T I O N
%
\definecolor{niceRed}{HTML}{980326}
\definecolor{niceBlue}{HTML}{025472}
\definecolor{tooRed}{HTML}{cc0000}
\definecolor{gray}{HTML}{5B5B5B}
\definecolor{burgundy}{HTML}{ab002a}
\if@colorful
	\renewcommand\thefootnote{\color{niceBlue}\arabic{footnote}}
	\renewcommand\thesidenote{\color{niceBlue}\arabic{sidenote}}
\else
\fi
\if@black
	\definecolor{niceRed}{HTML}{000000}
	\definecolor{niceBlue}{HTML}{000000}
\else
\fi
\newcommand\red[1]{\textcolor{niceRed}{#1}}

%	M A R G I N S
%
% formatting sidenote text
\makeatletter
\RenewDocumentCommand\sidenotetext{ o o +m }{%
    \IfNoValueOrEmptyTF{#1}{%
        \@sidenotes@placemarginal{#2}{\setstretch{1.0}\noindent\footnotesize\RaggedRight{S\thesidenote{}}~~#3}%
        \refstepcounter{sidenote}%
    }{%
        \@sidenotes@placemarginal{#2}{\noindent\footnotesize\RaggedRight{#1}~~#3}%
    }%
}
\makeatother

\newcommand{\sidetext}[1]
{\marginpar{\setstretch{1.0}\footnotesize\noindent #1 \vskip 3pt}}

\newcommand{\sidedef}[2]
{\index{#1}\sidenote{\textbf{\titlecap{#1.}} #2}}
%{\index{#1}\sidenote{\textbf{Def.} #2}}

\newcommand{\sidecitation}[2]{\sidenote{\textit{``#2''}\\ ---\raggedleft \makebox[0pt][r]{}\citeauthor{#1} (\citeyear{#1}).}}
\newcommand{\sidecitationnonum}[2]{\sidenotetext[~]{\textit{``#2''}\\ ---\raggedleft \makebox[0pt][r]{}\citeauthor{#1} (\citeyear{#1}).}}


%\newcommand\sidecite[2][]{\autocite{#2}\sidetext{\ifthenelse{\equal{#1}{}}{}{\vskip #1}%
%\@for\cle:={#2}\do{\raggedright\makebox[0pt][r]{\autocite{\cle}}\citeauthor{\cle} \citeyear{\cle}.\\\vskip 3pt}%
%}}

\newenvironment{wide}{
\begin{fullwidth}[outermargin=-\marginparwidth-\marginparsep, width=\linewidth+\marginparwidth+\marginparsep]
}%
{
\end{fullwidth}
}
% sidenotes reset on new
\let\oldchap\chapter
\renewcommand{\chapter}{\setcounter{sidenote}{1}\oldchap}

% sidenote at the beginning
\ExplSyntaxOn
\NewDocumentCommand{\sidechaptersummary}{m}
 {
  \marginpar
   {
    \raggedright
    \textcolor{burgundy}{\rule{\marginparwidth}{0.4pt}\vspace{2mm}}~
    \chaptersummary:n { #1 }
   }
 }
\cs_new:Nn \chaptersummary:n
 {
 {\sffamily
 \large{IN~THIS~CHAPTER}
 \vspace{3mm}
  \small{
  \begin{itemize}[label={},leftmargin=0mm,]
  \setlength\itemsep{2.5mm}
    \clist_map_inline:nn { #1 }
    {
      \item \titlecap{##1}
    }
  \end{itemize}
  }
  }
 }
\ExplSyntaxOff

%	F U L L  A R A B I C (titlepage = page1)
%
\makeatletter
\renewcommand{\frontmatter}{\cleardoublepage\@mainmatterfalse}
\renewcommand{\mainmatter}{\cleardoublepage\@mainmattertrue}
\makeatother


%	P A G E  H E A D E R S
%
\renewcommand{\chaptermark}[1]{ \markboth{#1}{} }
\renewcommand{\sectionmark}[1]{ \markright{#1}{} }
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\fancyhead[LO]{
	\footnotesize\textls{\MakeUppercase{\sffamily\rightmark}} \hfill \normalfont\normalsize\thepage
}
\fancyhead[RE]{
	\normalfont\normalsize\thepage \hfill \footnotesize\textls{\MakeUppercase{\sffamily\leftmark}}
}
\fancypagestyle{plain}{
\fancyhf{}
\fancyhead[RO]{\thepage}
\fancyhead[LE]{\hfill}
}
\setlength{\headheight}{13.6pt}

\fancypagestyle{plain}{\fancyhead{}}
\fancyheadoffset[LE,RO]{\dimexpr\marginparsep+\marginparwidth\relax}
\fancyfootoffset[LE,RO]{\dimexpr\marginparsep+\marginparwidth\relax}
\renewcommand{\footrulewidth}{\headrulewidth}% to show the width of footer


%	T I T L E  H E A D E R S
%

%	default numbering depth
\AtBeginDocument{\setcounter{secnumdepth}{1}}

%	header formatting
\titlespacing*{\part}{.2\linewidth}{.3\textheight}{0pt}
\titlespacing*{\chapter}{0pt}{-60pt}{10pt}
\titleformat{\part}%[hang]
	{\thispagestyle{empty}\huge\raggedleft}
	{\Large\lsstyle\MakeUppercase{\partname}~~\thepart\normalfont}
	{0em}
	{\vskip 12pt \setstretch{0.9}\huge\lsstyle\sffamily\uppercase}
% \let\oldpart\part
% \renewcommand{\part}{
% }

\newcommand{\marginsecnumber}[1]{%
  \makebox[0pt][r]{#1\hspace{7pt}}%
}

%\newcommand\chapterNum{\@setfontsize{58.1}}
%\titleformat{\chapter}[block]
%	{\begin{wide}\thispagestyle{empty}\itshape\huge}
%	{\normalfont\bfseries\huge\thechapter}
%	{1em}
%	{\setstretch{0.9}\raggedright\huge\itshape}[\end{wide}]

\newcommand{\formatsectiontitle}[1]{\itshape\titlecap{#1}}

\titleformat{\chapter}%
    [% Layout shape (display puts label in separate paragraph)
        display%
    ]%
    {% Underlying font formats
        \begin{wide}\thispagestyle{empty}
        \huge%
        \itshape%
        \color{gray}
    }%
    {% Formatting for the label (number)
        \raggedleft%
        \fontsize{100}{100}\selectfont%
        \textcolor{burgundy}{\thechapter}
    }%
    {0em}% Vertical spacing
    {% Additional code before title text
    \setstretch{0.9} \titlecap
    }%
    [% Additional code after title text
        %{\titlerule[0.5pt]}%
        \end{wide}
    ]%
    %

\titleformat{\section}
	{\itshape\large}
	{\marginsecnumber\thesection}
	{0em}
	{\setstretch{0.9}\raggedright\formatsectiontitle}
% \titleformat{\subsection}
%	{\itshape\normalfont}
%	{\marginsecnumber\thesubsection}
%	{0em}
%	{\setstretch{0.9}\itshape}
\titleformat{\subsection}
	{\itshape\normalfont}
	{\raggedright\normalfont\thesubsection}
	{0em}
	{\setstretch{0.9}\itshape}
\titleformat{\subsubsection}[runin]
	{}
	{\itshape\thesubsubsection}
	{1ex}
	%{{\makebox[-10pt][r]{\footnotesize\color{lightgray}$\blacktriangleright$}}\hspace{10pt}\itshape}[~~$\cdot$]
        {{\makebox[-10pt][r]{\footnotesize\color{lightgray}$\blacktriangleright$}}\hspace{10pt}\scshape}[~~$\cdot$]



%	M A K E T I T L E
%

% 	custom info commands like @title, @author...
% 	info commands definition
\makeatletter
% 	subtitle --title already exists
\newcommand\subtitle[1]{\renewcommand\@subtitle{#1}}
\newcommand\@subtitle{}
% 	university
\newcommand\university[1]{\renewcommand\@university{#1}}
\newcommand\@university{}
% 	lab
\newcommand\lab[1]{\renewcommand\@lab{#1}}
\newcommand\@lab{}

% 	supervisors, jury members, etc.
\newcommand\people{}
\def\zfoo#1\relax{\long\def\people##1{#1}}
\newcommand\updatepeople[1]{%
   \expandafter\zfoo\people{##1}##1#1\relax
}
\newcommand\person[3]{
    \updatepeople{#1 & #2 & #3 \\}
}

%	logos
\newcommand\logos{}
\def\xfoo#1\relax{\long\def\logos##1{#1}}
\newcommand\updatelogos[1]{%
   \expandafter\xfoo\logos{##1}##1#1\relax
}
\newcommand\logo[1]{
    \updatelogos{
		\hspace{20pt}\includegraphics[height=50pt]{#1}
	}
}

\newcommand{\sectionline}{%
  \noindent
  \begin{center}
  {\color{burgundy}
    \resizebox{0.5\linewidth}{1ex}
    {{%
    {\begin{tikzpicture}
    \node  (C) at (0,0) {};
    \node (D) at (9,0) {};
    \path (C) to [ornament=85] (D);
    \end{tikzpicture}}}}}%
    \end{center}
}

\newcommand{\sectionlinenew}{%
  \noindent
  \begin{center}
  {\color{burgundy}
    {%
    {\begin{tikzpicture}

    \draw[burgundy, thick] (-4,0) -- (-0.25,0);
    \draw[burgundy, thick] (0.25,0) -- (4,0);
    \filldraw[burgundy] (0,0) circle (1pt);
    
    \end{tikzpicture}}}}%
    \end{center}
}

% 	Doctoral thesis (subsubtitle)
\newcommand\type[1]{\renewcommand\@type{#1}}
\newcommand\@type{Doctoral thesis}

% 	shoutouts
\newcommand\shoutouts[1]{\renewcommand\@shoutouts{#1}}
\newcommand\@shoutouts{}

% 	ACTUAL MAKETITLE (titlepage + "copyright" and dedication pages)
\newcommand\@maketitlebis{%
	\makeatletter
	\setstretch{1.0}
	\begin{titlepage}
		% \setcounter{page}{1}
		\hfill
		\begin{minipage}{.8\linewidth}
		\raggedleft

		{\large\scshape
				\MakeLowercase{\@university}%

				\bigskip

				\MakeLowercase{\@lab}%  <- this percent is mandatory -- without it latex places and awkward space
		}

		\vskip 80pt

		{\large\itshape\@author}

		\vskip 40 pt

		{%
			\huge
			\if@colorful
				\color{niceRed}
			\else
			\fi
			\@title\par
			}%

		\vskip 8pt

		{\large\@subtitle\par}%

		\vskip 20pt

		{\Large \@type}%

		\vskip 40pt

		{\itshape\@date}

		\end{minipage}

		\vfill

		\raggedleft

		\begin{tabular}{rll}
			\people{}
		\end{tabular}

		\vskip 40pt

		\logos{}

	\end{titlepage}

	\if@colorful
		\hypersetup{
			colorlinks = true,
			linkcolor = niceBlue,
			anchorcolor = niceBlue,
			citecolor = .,
			urlcolor = niceBlue,
		}
	\fi

	% copyright
	\thispagestyle{empty}
	\hfill
	\vfill
	\makeatletter
	\noindent\begin{flushleft}\@author,\quad \textit{\@title,} \@subtitle, \@date.
    \end{flushleft}
	\makeatother


	% dedication
	\cleardoublepage
	\thispagestyle{empty}
	~\vskip .3\textheight
	\begin{flushright}
	\large\itshape\@shoutouts
	\end{flushright}

	\setstretch{1.12}
	\makeatother
}
\renewcommand\maketitle{
	\@maketitlebis
	\thispagestyle{empty}
}
\makeatother

%	COLOPHON
%\AtEndDocument{
%	\cleardoublepage
%	\pagestyle{empty}
%	\footnotesize\raggedleft
%	\hfill
%	\vfill
%	\noindent This document was typeset using \LaTeX{} and the \texttt{tufte-style-thesis} class.
%
%	The style is heavily inspired by the works of Edward R. Tufte and Robert Bringhurst.
%
%	This is available on here:
%
%	\vskip 8pt
%
%	\centering \url{https://github.com/sylvain-kern/tufte-style-thesis/}.\\
%	\raggedleft\noindent Feel free to contribute!
%}

%	F I G U R E S  A N D  S T U F F
%
% 	caption formatting
\DeclareCaptionLabelFormat{lc}{\MakeLowercase{#1}~#2}
\DeclareCaptionLabelSeparator{mysep}{.\quad}
\DeclareCaptionLabelSeparator{mysepside}{.\\}
\captionsetup{
	labelfont = {bf},
	%labelformat = lc,
	labelsep = mysep,
	justification=RaggedRight,
	font={footnotesize, stretch=1},
	singlelinecheck=on,
}
\DeclareCaptionStyle{sidecaption}{
    labelfont = {bf},
	%labelformat = lc,
	labelsep = mysepside,
	justification=RaggedRight,
	font={footnotesize, stretch=1},
	singlelinecheck=off,
}
\DeclareCaptionStyle{marginfigure}{
    labelfont = {bf},
	%labelformat = lc,
	labelsep = mysepside,
	justification=RaggedRight,
	font={footnotesize, stretch=1},
	singlelinecheck=off,
}
\DeclareCaptionStyle{widefigure}{
    labelfont = {bf},
	%labelformat = lc,
	labelsep = mysep,
	justification=RaggedRight,
	font={footnotesize, stretch=1},
	singlelinecheck=off,
}
\DeclareCaptionStyle{margintable}{
    labelfont = {bf},
	%labelformat = lc,
	labelsep = mysep,
	justification=RaggedRight,
	font={footnotesize, stretch=1},
	singlelinecheck=off,
}
\DeclareCaptionStyle{widetable}{
    labelfont = {bf},
	%labelformat = lc,
	labelsep = mysep,
	justification=RaggedRight,
	font={footnotesize, stretch=1},
	singlelinecheck=off,
}
%	figure macros
\AtBeginDocument{\usepackage[export]{adjustbox}} % for 'outer' mode
\newcommand{\textfig}[5][!htb]{%
	\FloatBarrier
	\begin{figure}[#1]%
		\sidecaption{#4\label{#5}}%
		\includegraphics[width = #2\linewidth, outer]{#3}%
	\end{figure}%
}
\newcommand{\marginfig}[3]{%
	\FloatBarrier%
	\begin{marginfigure}%
		\includegraphics[width = \linewidth]{#1}%
		\caption{#2\label{#3}}%
	\end{marginfigure}%
}
\newcommand{\widefig}[5][!htb]{%
	\FloatBarrier%
	\begin{figure*}[#1]%
		\includegraphics[width=#2\linewidth, outer]{#3}%
		\sidecaption{#4\label{#5}}%
	\end{figure*}%
}
\newcommand{\plainfig}[5][!htb]{%
	\FloatBarrier%
	\begin{figure}[#1]%
		\includegraphics[width=#2\linewidth, left]{#3}%
		\caption{#4\label{#5}}%
	\end{figure}%
}
\newcommand{\plainwidefig}[5][!htb]{%
    \FloatBarrier%
    \begin{figure*}[#1]%
        {\includegraphics[width=#2\linewidth, left]{#3}}%
        \caption{#4\label{#5}}%
    \end{figure*}%
}

%	table macros
\newcolumntype{Y}{>{\centering\arraybackslash}X} % tabularx column type
\newenvironment{texttable}[2]{%
	\begingroup%
	\small%
	\marginpar{%
		\vskip 8pt%
		\captionof{table}{#1}%
		\label{#2}%
	}

	\noindent%
}
{
	\endgroup%
}


%	T O C  C U S T O M I Z A T I O N
%
\contentsmargin[1cm]{0cm}
\titlecontents{part}[0em]
	{\hypersetup{linkcolor=niceBlue}\large\scshape}
	{\hypersetup{linkcolor=black}\scshape\thecontentslabel}
	{\vskip 4pt\normalsize\scshape\lowercase}
	{\hfill\textcolor{niceBlue}{\small\contentspage[\hfill\thecontentspage]}}
        [\vskip 0pt]
 
\titlecontents{chapter}[0em]
	{\normalsize\vspace{12pt}}
	{\hypersetup{linkcolor=black}\makebox[-1em][r]{\thecontentslabel}\normalsize\hspace{1em}}
	{\small}
	{\hfill\textcolor{niceBlue}{\contentspage[\hfill\thecontentspage]}}
        [\vskip 2pt]
        
\titlecontents{section}[0em]
	{\small}
	{\hypersetup{linkcolor=black}\thecontentslabel~~}
	{\small}
        {\dotfill\makebox[1.5em][r]{\contentspage[\hfill\textcolor{niceBlue}\thecontentspage]}}
	[\vskip 2pt]
 
\titlecontents{subsection}[1.5em]
	{\small}
	{\hypersetup{linkcolor=black}\thecontentslabel~~}
	{\small\hypersetup{linkcolor=black}}
	{\dotfill\makebox[1.5em][r]{\contentspage[\hfill\textcolor{niceBlue}\thecontentspage]}}
	[\vskip 2pt]

% \titlecontents{subsection}[0em]
% 	{\vspace{4pt}}
% 	{\normalfont\thecontentslabel\enspace\itshape}
% 	{\itshape}
% 	{\qquad\contentspage}[\vskip 0pt]

% \titlecontents{subsubsection}[1em]
% 	{\vspace{0pt}}
% 	{\normalfont\thecontentslabel\enspace\itshape}
% 	{\itshape}
% 	{\quad\quad\contentspage}[\vskip 0pt]

% TOCLOFT (stolen from classicthesis)
\renewcommand{\cftfigpresnum}{\scshape\MakeTextLowercase}%
\renewcommand{\cftfigfont}{\small\hypersetup{linkcolor=black}}%
\renewcommand{\cftfigleader}{\dotfill}%\hspace{1em}}%
\renewcommand{\cftfigafterpnum}{\cftparfillskip}%
\renewcommand{\cftfigpresnum}{\figurename~}%Fig.~}
\renewcommand{\cftfigpagefont}{\color{niceBlue}}
\newlength{\figurelabelwidth}
\settowidth{\figurelabelwidth}{\cftfigpresnum~999}
\addtolength{\figurelabelwidth}{1em}
\cftsetindents{figure}{0em}{\figurelabelwidth}
\cftsetpnumwidth{3ex}%width for  single page numbers, added <<<<<<<<<<<<<<<<<<<<<<

% tables
\renewcommand{\cfttabfont}{\small\hypersetup{linkcolor=black}}%
\renewcommand{\cfttableader}{\dotfill}%\hspace{1em}}%
\renewcommand{\cfttabafterpnum}{\cftparfillskip}%
\renewcommand{\cfttabpresnum}{\tablename~}%Tab.~}
\newlength{\tablelabelwidth}
\settowidth{\tablelabelwidth}{\cfttabpresnum~999}
\addtolength{\tablelabelwidth}{1em}
%\cftsetindents{table}{0em}{\tablelabelwidth}
\cftsetindents{table}{0em}{\figurelabelwidth}
% listings
\newcommand\listingsname{Listing}
\renewcommand\lstlistingname{Listing}
\renewcommand\lstlistlistingname{List of Listings}
\newlistof{listings}{lol}{\lstlistlistingname}%
\renewcommand{\cftlistingspresnum}{\scshape\MakeTextLowercase}%
\renewcommand{\cftlistingsfont}{\normalfont}%
\renewcommand{\cftlistingspresnum}{\lstlistingname~}%
\renewcommand{\cftlistingspagefont}{\normalfont}%
\renewcommand{\cftlistingsleader}{\hspace{1.5em}}%
\renewcommand{\cftlistingsafterpnum}{\cftparfillskip}%
\newlength{\listingslabelwidth}%
\settowidth{\listingslabelwidth}{\cftlistingspresnum~999}%
\addtolength{\listingslabelwidth}{2.5em}%
\cftsetindents{listings}{0em}{\figurelabelwidth}%
% \let\l@lstlisting\l@listings%
\let\lstlistoflistings\listoflistings%
% blue page numbers
\renewcommand{\cftfigpagefont}{\color{niceBlue}}
\renewcommand{\cfttabpagefont}{\color{niceBlue}}
\renewcommand{\cftlistingspagefont}{\color{niceBlue}}
% TOCLOFT over
%	toc offset
\let\oldtoc\tableofcontents
\renewcommand{\tableofcontents}{%
	\begin{quote}\setstretch{1.0}
	\oldtoc
	\end{quote}
}
%	toc depth
\AtBeginDocument{\setcounter{tocdepth}{2}}

%	B I B L I O G R A P H I C
%	      R E F E R E N C E S  %this is black magic to me but it seems 2b working
\makeatletter

% So that years have a link
\DeclareCiteCommand{\citeyear}
    {\usebibmacro{prenote}}
    {\hypersetup{citecolor=burgundy}\bibhyperref{\printfield{year}}\bibhyperref{\printfield{extrayear}}}
    {\multicitedelim}
    {}

%\newcommand\sidecite[2][]{\autocite{#2}\sidetext{\ifthenelse{\equal{#1}{}}{}{\vskip #1}%
%\@for\cle:={#2}\do{\makebox[0pt][r]{\autocite{\cle}}\fullcite{\cle}.\\\vskip 4pt}%
%}}

%% With title
\newcommand\sideauthorcite[2][]{\autocite{#2}\sidetext{\ifthenelse{\equal{#1}{}}{}{\vskip #1}%
\@for\cle:={#2}\do{\raggedright\makebox[0pt][r]{\autocite{\cle}}\citeauthor{\cle} (\citeyear{\cle}), \citetitle{\cle}.\\\vskip 4pt}%
}}

%% Without the title:    
\newcommand\sidecite[2][]{\autocite{#2}\sidetext{\ifthenelse{\equal{#1}{}}{}{\vskip #1}%
\@for\cle:={#2}\do{\raggedright\makebox[0pt][r]{\autocite{\cle}}\citeauthor{\cle} \citeyear{\cle}.\\\vskip 3pt}%
}}

\newcommand\yeartextcite[2][]{\@for\cle:={#2}\do{\citeauthor{\cle} (\citeyear{\cle})}}

\newcommand\sidetextcite[2][]{\sidetext{\ifthenelse{\equal{#1}{}}{}{\vskip #1}%
\@for\cle:={#2}\do{\makebox[0pt][r]{\autocite{\cle}}\fullcite{\cle}.\\\vskip 4pt}%
}}
\makeatother

\DeclareCiteCommand{\fullcite}
  {\usebibmacro{prenote}}
  {\clearfield{url}%
   \clearfield{pagetotal}%
   \clearfield{edition}%
   \usedriver
     {\DeclareNameAlias{sortname}{default}}
     {\thefield{entrytype}}}
  {\multicitedelim}
  {\usebibmacro{postnote}}


%	flush T I G H T  L I S T S
%
\AtBeginDocument{
	\setlist{topsep=0pt, itemsep=0pt, noitemsep}
}
% 	diamond bullets
\renewcommand{\labelitemi}{$\vcenter{\hbox{\small$\diamond$}}$}

%	C O D E
%
%   colors
\definecolor{bg}{rgb}{.95,.95,.95}
\definecolor{key}{HTML}{333399}
\definecolor{comment}{HTML}{6b6b99}
\definecolor{codegray}{rgb}{0.4,0.4,0.4}
\definecolor{string}{HTML}{2b4f2b}
%   boxes
\mdfdefinestyle{code_box}{%
    roundcorner= 2pt,
	backgroundcolor=white,
    linecolor = lightgray,
    linewidth = .5pt,
    topline = true,
    bottomline = true,
    leftline = true,
    rightline = true,
	innertopmargin=.2em,
	innerbottommargin=.2em,
}
%   listing styles
\lstdefinestyle{unnumbered}{
    commentstyle=\color{comment},
    keywordstyle=\color{key},
    stringstyle=\color{string},
    basicstyle=\ttfamily\normalsize\lst@ifdisplaystyle\small\fi,
    breakatwhitespace=false,
    breaklines=true,
    keepspaces=true,
    showspaces=false,
    showstringspaces=false,
    showtabs=false,
    tabsize=4,
    framexleftmargin=30pt,
}
\lstdefinestyle{numbered}{
    commentstyle=\color{comment},
    keywordstyle=\color{key},
    stringstyle=\color{string},
    basicstyle=\ttfamily\normalsize\lst@ifdisplaystyle\small\fi,
    breakatwhitespace=false,
    breaklines=true,
    keepspaces=true,
    numbers=left,
    numberstyle = \color{codegray}\footnotesize\ttfamily,
    numbersep=10pt,
    showspaces=false,
    showstringspaces=false,
    showtabs=false,
    tabsize=4,
    framexleftmargin=30pt,
    framextopmargin=100pt,
    framexbottommargin=30pt,
}
%   code macros
\lstnewenvironment{codebox}[1]{%
	\FloatBarrier
	\mdframed[style = code_box, innerleftmargin=10pt]%
	\lstset{style=unnumbered, language=#1}
}
{
    \endmdframed
}
\lstnewenvironment{altcodebox}[1]{%
	\FloatBarrier
	\mdframed[style = code_box, innerleftmargin=10pt]%
	\lstset{style=unnumbered, language=#1}
}
{
    \endmdframed
}
\lstnewenvironment{codeboxnum}[1]{%
	\FloatBarrier
	\mdframed[style = code_box, innerleftmargin=25pt]%
	\lstset{style=numbered, language=#1}
}
{
    \endmdframed
}
\newcommand{\inlinecode}[1]{\lstinline[style=unnumbered, language=#1]}
%	snippet environments
\lstnewenvironment{snippet}[3]{%
	\marginpar{~\vskip 10pt\captionof{listings}{#2\label{#3}}}
	\mdframed[style = code_box, innerleftmargin=10pt]%
	\lstset{style=unnumbered, language=#1}
}
{
    \endmdframed
}
\lstnewenvironment{snippetnum}[3]{%
	\marginpar{~\vskip 10pt\captionof{listings}{#2\label{#3}}}
	\mdframed[style = code_box, innerleftmargin=25pt]%
	\lstset{style=numbered, language=#1}
}
{
    \endmdframed
}


%	I N - T E X T  F I N E T U N I N G
%
% widows and orphans
\clubpenalty = 10000
\widowpenalty = 10000
\displaywidowpenalty = 10000


%	M I S C E L L A N E O U S
%
\providecommand{\toight}{%
	\tightlist%
}
%	minipages with margin notes
\usepackage{minipage-marginpar}
%	no page break environment
\newenvironment{absolutelynopagebreak}
  {\par\nobreak\vfil\penalty0\vfilneg
   \vtop\bgroup}
  {\par\xdef\tpd{\the\prevdepth}\egroup
   \prevdepth=\tpd}

%	M A T H  &  P H Y S I C S
%	S H O R T C U T S
%\iffalse
% uncomment this \iffalse
%and the \fi at the end to disable (or delete)

% i find it more pleasing
\renewcommand{\phi}{\varphi}
\renewcommand{\epsilon}{\varepsilon}
\newcommand{\N}{\mathbb{N}}     % shortcuts for usual number sets
\newcommand{\Q}{\mathbb{Q}}
\newcommand{\R}{\mathbb{R}}
\newcommand{\C}{\mathbb{C}}
% powers of 10
\newcommand{\ee}[1]{\cdot 10^{#1}}
% new vect with overrightarrow style
%\newcommand{\vect}[1]{\:\overrightarrow{#1}}
%fi

% TODO
\newlistof{todos}{tod}{\bfseries \textls{TO DO} list}
\let\oldlistoftodos\listoftodos
\renewcommand{\listoftodos}{\bgroup\color{tooRed}{\oldlistoftodos}\egroup}
\newcommand{\todolist}{\listoftodos}

\newcounter{todo}
\setcounter{todo}{1}
\newcommand{\todo}[1]{
    \addcontentsline{tod}{todos}{\protect\numberline{\bfseries\#\thetodo}#1}
    \bgroup\color{tooRed}
    \noindent\large\textsc{todo \#\arabic{todo}}~~\hrulefill%
    \refstepcounter{todo}%
    \smallskip

    \normalsize\noindent #1

    \noindent\hrulefill
    \egroup
}

%		S  T   R   E   T     C      H
%
\AtBeginDocument{%
	\setstretch{1.12}
}