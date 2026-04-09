\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{chula-memoir}[2017/08/22]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Initial Code %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newif\if@doctor
\newif\if@master
\newif\if@ugrad
\newif\if@coadvisor
\newif\if@thaithesis
\@coadvisorfalse

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Option Declaration %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\@ugradtrue
\DeclareOption{doctor} {
    \@doctortrue
    \@masterfalse
    \@ugradfalse
} \DeclareOption{master} {
    \@doctorfalse
    \@mastertrue
    \@ugradfalse
} \DeclareOption{ugrad} {
    \@doctorfalse
    \@masterfalse
} \DeclareOption{coadvisor} {
    \@coadvisortrue
} \DeclareOption{thaithesis} {
    \@thaithesistrue
} \DeclareOption{engthesis} {
    \@thaithesisfalse
}
%
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{memoir}
    \PassOptionsToPackage{\CurrentOption}{hyperref}}  % pass any unknown option to the memoir class

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Option Execution %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ExecuteOptions{ugrad,thaithesis}
\ProcessOptions

%%%%%%%%%%%%%%%%%%%%%%%%%%%% Class & Package Loading %%%%%%%%%%%%%%%%%%%%%%%%%%
\LoadClass[a4paper,12pt,oneside]{memoir}           % this class is based on the report class

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Main Code %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Language settings %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\XeTeXlinebreaklocale "th"
\XeTeXlinebreakskip = 0pt plus 0pt

\RequirePackage{hyperref}
\hypersetup{
    hidelinks,
    linkcolor={red!50!black},
    citecolor={blue!50!black},
    urlcolor={blue!80!black}
}

\RequirePackage{fontspec}
%% English fonts are Times, Helvetica, Courier, according to IEEEtran template
\defaultfontfeatures{Mapping=tex-text} 
\setmainfont[Scale=1.15]{TeX Gyre Termes}   % Free Times
\setsansfont{TeX Gyre Heros}                % Free Helvetica
\setmonofont{TeX Gyre Cursor}               % Free Courier

% Use TH Sarabun New for Thai as it is standard font for Thai formal documents
\newfontfamily\thaifont
[Scale=MatchUppercase,
Path = ./Fonts/,
Extension = .ttf,
UprightFont = *,
BoldFont = *_Bold,
ItalicFont = *_Italic,
BoldItalicFont = *_BoldItalic
]{THSarabunNew}
% Set environment for Thai fonts
\newenvironment{thailang}
{\thaifont}
{}

\RequirePackage[Latin,Thai]{ucharclasses}
% Moved here to avoid problems when using MikTeX in Windows
% When using Thai characters use thailang environment
\setTransitionTo{Thai}{\begin{thailang}}
% For other characters, switch back to the original environment
\setTransitionFrom{Thai}{\end{thailang}}

\RequirePackage{polyglossia}
% Set the normal language to English
% i.e. numbering, latin characters will use English font
\setdefaultlanguage{english}
% When using Thai characters, the font will be automatically changed to Thai font
\setotherlanguage{thai}

%% End language settings %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Page layout settings %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{ragged2e}

% set paper size and page margin
\RequirePackage[a4paper]{geometry}
\setlength{\hoffset}{.5in}
\setlength{\voffset}{0pt}
\setlength{\oddsidemargin}{0pt}
\setlength{\topmargin}{0pt}
\setlength{\headheight}{0pt}           %
\setlength{\headsep}{.5in}             %
\setlength{\textheight}{9.19in}        %  text-area height
\setlength{\textwidth}{5.77in}
\setlength{\marginparsep}{0.00cm}      %
\setlength{\marginparwidth}{0.00cm}    %
\setlength{\footskip}{0.00cm}          %
\setlength{\parindent}{1.00cm}         %  paragraph indent
\setlength{\parskip}{0.50cm}           %  distance between paragraphs

%\RequirePackage{afterpage}
%\RequirePackage{array}
\RequirePackage{calc}

\RequirePackage{url}            % for breaking urls
                                % (use \url{http://www.example.com})
\RequirePackage{breakcites}     % for breaking long citations
\RequirePackage[normalem]{ulem} % for underlineing Journal name in references

\DoubleSpacing                  % for double spacing in memoir
\sloppy                         % for justified text

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% define Thai alphabet and numbering sequence
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\thalph#1{\expandafter\@thalph\csname c@#1\endcsname}
\def\@thalph#1{%
    \ifcase#1\or ก\or ข\or ค\or ง\or จ\or ฉ\or ช\or ซ\or
    ฌ\or ญ\or ฎ\or ฏ\or ฐ\or ฑ\or ฒ\or ณ\or ด\or ต\or ถ\or ท\or ธ\or น\or
    บ\or ป\or ผ\or ฝ\or พ\or ฟ\or ภ\or ม\or ย\or ร\or ฤ\or ล\or ฦ\or ว\or
    ศ\or ษ\or ส\or ห\or ฬ\or อ\or ฮ\else\xpg@ill@value{#1}{@thaialph}\fi}


\def\thainum#1{\expandafter\thainumber\csname c@#1\endcsname}
\def\thainumber#1{%
    \thaidigits{\number#1}%
}
\def\thaidigits#1{\expandafter\thdigits #1@ }
\def\thdigits#1{%
    \ifx @#1% then terminate
    \else
    \ifx0#1๐\else\ifx1#1๑\else\ifx2#1๒\else\ifx3#1๓\else\ifx4#1๔\else\ifx5#1๕\else\ifx6#1๖\else\ifx7#1๗\else\ifx8#1๘\else\ifx9#1๙\else#1\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi
    \expandafter\thdigits
    \fi
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% define some constant string for formatting
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% string setting
\if@doctor
    \newcommand\@ThaiDegreeType{ปริญญาดุษฎีบัณฑิต}
    \newcommand\@EnglishDegreeType{Doctoral Degree}
    \newcommand\@ThaiBookTitle{วิทยานิพนธ์}
    \newcommand\@EnglishBookTitle{Dissertation}
\else
    \if@master
        \newcommand\@ThaiDegreeType{ปริญญามหาบัณฑิต}
        \newcommand\@EnglishDegreeType{Master's Degree}
        \newcommand\@ThaiBookTitle{วิทยานิพนธ์}
        \newcommand\@EnglishBookTitle{Thesis}
    \else
        \newcommand\@ThaiDegreeType{ปริญญาบัณฑิต}
        \newcommand\@EnglishDegreeType{Bachelor's Degree}
        \newcommand\@ThaiBookTitle{โครงงาน}
        \newcommand\@EnglishBookTitle{Project}
    \fi
\fi

%% additional command for setting the first few pages of the thesis
%% please refer to the accompanying bare_thesis.tex for the example
%% usage of these command.
\newcommand{\authortitle}[2]{                               % define Title of Author
    \newcommand{\@ThaiAuthorTitle}{#1}
    \newcommand{\@EnglishAuthorTitle}{#2}
}
\newcommand{\thesisauthor}[2]{                              % define author
    \newcommand{\@ThaiAuthor}{#1}
    \newcommand{\@EnglishAuthor}{#2}
    \newcommand{\@EnglishAuthorUP}{\uppercase{#2}}
}
\newcommand{\thesistitle}[2]{                               % define Thesis' title
    \newcommand{\@ThaiTitle}{#1}
    \newcommand{\@EnglishTitle}{\uppercase{#2}}
}
\newcommand{\advisor}[4]{                                   % define Advisor
    \newcommand{\@ThaiAdvisor}{#1}
    \newcommand{\@ThaiAdvisorShort}{#2}
    \newcommand{\@EnglishAdvisor}{#3}
    \newcommand{\@EnglishAdvisorUP}{\uppercase{#3}}
    \newcommand{\@EnglishAdvisorShort}{#4}
    \newcommand{\@EnglishAdvisorShortUP}{\uppercase{#4}}
}
\newcommand{\coadvisor}[4]{                                 % define co-author (auto include coadvision option)
    \newcommand{\@ThaiCoAdvisor}{#1}                         
    \newcommand{\@ThaiCoAdvisorShort}{#2}
    \newcommand{\@EnglishCoAdvisor}{#3}
    \newcommand{\@EnglishCoAdvisorUP}{\uppercase{#3}}
    \newcommand{\@EnglishCoAdvisorShort}{#4}
    \newcommand{\@EnglishCoAdvisorShortUP}{\uppercase{#4}}
    \@coadvisortrue
}
\newcommand{\faculty}[2]{                                   % define faculty
    \newcommand{\@ThaiFaculty}{#1}
    \newcommand{\@EnglishFaculty}{#2}
}
\newcommand{\department}[2]{                                % define department
    \newcommand{\@ThaiDept}{#1}
    \newcommand{\@EnglishDept}{#2}
}
\newcommand{\fieldofstudy}[2]{                              % define field of study
    \newcommand{\@ThaiFieldOfStudy}{#1}
    \newcommand{\@EnglishFieldOfStudy}{#2}
    \newcommand{\@EnglishFieldOfStudyUP}{\uppercase{#2}}
}
\newcommand{\degree}[2]{                                    % define degree name
    \newcommand{\@ThaiDegree}{#1}
    \newcommand{\@EnglishDegree}{#2}
}
\newcommand{\academicyear}[1]{                              % define academic year
    \newcounter{AcadYear}
    \setcounter{AcadYear}{#1}
    \newcommand{\@ThaiAcademicYear}{\theAcadYear}
    \newcounter{EngAcadYear}
    \setcounter{EngAcadYear}{\value{AcadYear}-543}
    \newcommand{\@EnglishAcademicYear}{\theEngAcadYear}
}
\newcommand{\deanname}[2]{                                  % define name of the dean
    \newcommand{\@ThaiDeanName}{#1}
    \newcommand{\@EnglishDeanName}{#2}
}
\newcommand{\subjID}[1]{
    \newcommand{\@subjID}{#1}
}
\newcommand{\subjName}[2]{
    \newcommand{\@ThaiSubjName}{#1}
    \newcommand{\@EnglishSubjName}{#2}
}
\newcommand{\keywords}[1]{                                  % define keywords
    \newcommand{\@Keywords}{\uppercase{#1}}
}
\newcommand{\authorid}[1]{                                  % define student ID of the author
    \newcommand{\@AuthorID}{#1}
}
\newcommand{\committee}[1]{                                 % define commitee
    \newcommand{\@Committee}{
        \if@thaithesis \fi
        #1
    }
}

%% Some caption constants
\addto\captionsthai{
    \renewcommand{\listfigurename}{สารบัญภาพ}
    \renewcommand{\bibname}{รายการอ้างอิง}
    \renewcommand{\appendixname}{ภาคผนวก}
    \renewcommand{\appendixpagename}{ภาคผนวก}
    \renewcommand{\appendixtocname}{ภาคผนวก}
    \def\@AbstractThaiString{บทคัดย่อภาษาไทย}
    \def\@AbstractEnglishString{บทคัดย่อภาษาอังกฤษ}
    \def\@AcknowledgementsString{กิตติกรรมประกาศ}
    \if@ugrad
        \def\@BiographyString{ประวัติผู้เขียน}
    \else
        \def\@BiographyString{ประวัติผู้เขียนวิทยานิพนธ์}
    \fi
}

\addto\captionsenglish{
    \renewcommand{\bibname}{References}
    \def\@AbstractThaiString{Abstract (Thai)}
    \def\@AbstractEnglishString{Abstract (English)}
    \def\@AcknowledgementsString{Acknowledgements}
    \def\@BiographyString{Biography}
}

%% END OF CLASS

\AtEndOfClass{
    %Add natbib after set all other parameters
    \RequirePackage[round,semicolon]{natbib}    % for bibliography sylte
    
    \renewenvironment{thebibliography}[1]{%
    	\clearpage
        \ULforem
        \setlength{\bibhang}{1.5cm}

        \bibsection\parindent \z@\bibpreamble\bibfont\list
        {\@biblabel{\arabic{NAT@ctr}}}{\@bibsetup{#1}%
            \setcounter{NAT@ctr}{0}}%
        
        \ifNAT@openbib
            \renewcommand\newblock{\par}
        \else
            \renewcommand\newblock{\hskip .11em \@plus.33em \@minus.07em}%
        \fi
        \sloppy\clubpenalty4000\widowpenalty4000
        \sfcode`\.=1000\relax
        \let\citeN\cite \let\shortcite\cite
        \let\citeasnoun\cite
    }{
        \def\@noitemerr{%
            \PackageWarning{natbib}
            {Empty `thebibliography' environment}}%
        \endlist\vskip-\lastskip
        \normalem
    }

}

\AtBeginDocument{
    \if@thaithesis
        \captionsthai
    \else
        \captionsenglish
    \fi
}

%%%%%%%%%%%%
% equation %
%%%%%%%%%%%%
\@addtoreset{equation}{chapter}
\renewcommand{\theequation}{\ifnum\c@chapter>\z@\thechapter.\fi\@arabic\c@equation}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% define styles
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Frontmatter numbering
\addtodef*{\frontmatter}{}{%
    \if@thaithesis
        \pagenumbering{thaialph}
    \else
        \pagenumbering{roman}
    \fi
}
\addtodef*{\mainmatter}{}{%
    \pagenumbering{arabic}
}

%% Cover and sign pages
\newcommand{\makethaicover}{
    \fontsize{11}{15}\selectfont
    \thispagestyle{empty}
    \centerline{ \begin{tabular}{p{14cm}}\centering\@ThaiTitle\end{tabular} }
    \vfill
    \centerline{\@ThaiAuthorTitle\@ThaiAuthor}
    \vspace{1cm}
    \vfill
    \begin{center}
        {\@ThaiBookTitle}นี้เป็นส่วนหนึ่งของการศึกษาตามหลักสูตรปริญญา{\@ThaiDegree}\\
        สาขาวิชา{\@ThaiFieldOfStudy} ภาควิชา{\@ThaiDept} \\
        คณะ{\@ThaiFaculty} จุฬาลงกรณ์มหาวิทยาลัย \\
        ปีการศึกษา {\@ThaiAcademicYear}\\
        ลิขสิทธิ์ของจุฬาลงกรณ์มหาวิทยาลัย
    \end{center}
    \clearpage
}

\newcommand{\makeenglishcover}{
    \fontsize{11}{15}\selectfont
    \thispagestyle{empty}
    \centerline{\begin{tabular}{p{14cm}}\centering\@EnglishTitle\end{tabular}}
    \vfill
    \centerline{\@EnglishAuthorTitle~\@EnglishAuthor}
    \vfill
    \begin{center}
        A {\@EnglishBookTitle} Submitted in Partial Fulfillment of the Requirements \\
        for the Degree of {\@EnglishDegree} Program in {\@EnglishFieldOfStudy} \\
        Department of {\@EnglishDept} \\
        Faculty of {\@EnglishFaculty} \\
        Chulalongkorn University \\
        Academic Year {\@EnglishAcademicYear} \\
        Copyright of Chulalongkorn University
    \end{center}
    \clearpage
}


\newcommand{\ThaiCommittee}[1]{
    \fontsize{11}{13.2}\selectfont
    \thispagestyle{empty}
    \noindent    
    \begin{tabular}{@{}p{5.5cm}p{8.3cm}}
        {หัวข้อ{\@ThaiBookTitle}}   & \@ThaiTitle \\
        {โดย}                                & \@ThaiAuthorTitle\@ThaiAuthor \\
        {สาขาวิชา}                      & \@ThaiFieldOfStudy \\
        {อาจารย์ที่ปรึกษา{\@ThaiBookTitle}หลัก}                   & \@ThaiAdvisor \\
        \if@coadvisor
        {อาจารย์ที่ปรึกษา{\@ThaiBookTitle}ร่วม}               & \@ThaiCoAdvisor \\
        \fi
    \end{tabular}
    
    \vspace*{0.4cm}
    \hrule width 15 cm height 0.0 cm depth 0.025 cm
    
    \if@ugrad {ภาควิชา\@ThaiDept} \fi {คณะ\@ThaiFaculty} {จุฬาลงกรณ์มหาวิทยาลัย} {อนุมัติให้นับ{\@ThaiBookTitle}ฉบับนี้เป็นส่วนหนี่งของการศึกษาตามหลักสูตร{\@ThaiDegreeType}} \if@ugrad ในรายวิชา {\@subjID} {\@ThaiSubjName} \fi
    
    \noindent
    \begin{tabular}{p{2.5cm}p{6cm}>{\raggedright\arraybackslash}p{5cm}}
        \hspace*{0.5cm} & \hspace*{8.0cm} & \\
        & \vfill\dotfill & {\if@ugrad{หัวหน้าภาควิชา{\@ThaiDept}}\else{คณบดีคณะ{\@ThaiFaculty}}\fi} \\
        & \multicolumn{2}{l}{(\@ThaiDeanName)}
    \end{tabular}
    %    \vspace*{0.3cm}
    
    \noindent
    {คณะกรรมการสอบ\@ThaiBookTitle}
    
    \noindent
    \begin{tabular}{p{2.5cm}>{\centering\arraybackslash}p{6cm}l}
        \@Committee
    \end{tabular}     
    
}

\newcommand{\EnglishCommittee}{
    \fontsize{11}{13.2}\selectfont
    \setlength{\textwidth}{16.50cm}
    \thispagestyle{empty}
    \noindent
    \begin{tabular}{p{3cm}p{11cm}}
        \@EnglishBookTitle~Title            & \@EnglishTitle \\
        By                      & \@EnglishAuthorTitle~\@EnglishAuthor \\
        Field of Study          & \@EnglishFieldOfStudy \\
        \@EnglishBookTitle~Advisor          & \@EnglishAdvisor \\
        \if@coadvisor
        \@EnglishBookTitle~Co-advisor       & \@EnglishCoAdvisor \\
        \fi
    \end{tabular}
    
    \vspace*{0.4cm}
    \hrule width 15 cm height 0.0 cm depth 0.025 cm
    
    Accepted by the \if@ugrad Department of \@EnglishDept\fi Faculty of \@EnglishFaculty, Chulalongkorn University in Partial Fulfillment of the Requirements for the \@EnglishDegreeType \if@ugrad in {\@subjID} {\@EnglishSubjName}\fi
    
    \noindent
    \begin{tabular}{p{2.5cm}p{5cm}>{\raggedright\arraybackslash}p{6cm}}
        \hspace*{0.5cm} & \hspace*{8.0cm} & \\
        & \vfill\dotfill & Dean of the {\if@ugrad{Department of \@EnglishDept}\else{Faculty of \@EnglishFaculty}\fi} \\
        & \multicolumn{2}{l}{(\@EnglishDeanName)}
    \end{tabular}
    
    \vspace*{0.4cm}
    
    \noindent
    \if@ugrad{PROJECT}\else{THESIS}\fi~COMMITTEE
    
    \noindent
    \begin{tabular}{p{2.5cm}>{\centering\arraybackslash}p{6cm}l}
        \@Committee
    \end{tabular}
    \setlength{\textwidth}{15.00cm}
}

\newcommand{\makecommittee} {
    \protect\if@thaithesis
        \ThaiCommittee
    \protect\else
        \EnglishCommittee
    \protect\fi
    \clearpage
}

\newcommand{\CommitteeBlock}[2] {
    
    \hspace*{0.5cm} & \hspace*{8.0cm} & \\
    & \dotfill & {#1} \\
    & \multicolumn{2}{l}{(#2)} \\
}
\newcommand{\CommitteeBlockAdvisor} {
    \hspace*{0.5cm} & \hspace*{8.0cm} & \\
    & \dotfill & {\if@thaithesis {อาจารย์ที่ปรึกษา{\@ThaiBookTitle}หลัก} \else \@EnglishBookTitle~Advisor \fi} \\
    & \multicolumn{2}{l}{(\if@thaithesis \@ThaiAdvisor \else \@EnglishAdvisor \fi)} \\
}

\newcommand{\CommitteeBlockCoAdvisor} {
    \if@coadvisor
    \hspace*{0.5cm} & \hspace*{8.0cm} & \\
    & \dotfill & {\if@thaithesis {อาจารย์ที่ปรึกษา{\@ThaiBookTitle}ร่วม} \else {\@EnglishBookTitle}~Co-advisor \fi} \\
    & \multicolumn{2}{l}{(\if@thaithesis \@ThaiCoAdvisor \else \@EnglishCoAdvisor~ \fi)} \\
    \fi
}

%% Abstract
\newenvironment{thaiabstract}{
	\clearpage
	\fontsize{11}{15}\selectfont
	\thispagestyle{headings}
	%    \addtocontents{toc}{\protect\vspace*{-0.5cm}}
	\addtocontents{toc}{\protect\contentsline{chapter}{\bfseries\@AbstractThaiString}{\protect\relax\thepage}{}}
	\noindent
	\hangindent = 1.0 cm \hangafter = -10
	\@ThaiAuthor  : \@ThaiTitle.  (\@EnglishTitle) {อ.ที่ปรึกษา{\@ThaiBookTitle}หลัก : \@ThaiAdvisorShort},
	{\if@coadvisor {อ.ที่ปรึกษา{\@ThaiBookTitle}ร่วม : \@ThaiCoAdvisorShort} \fi}
	{\thelastsheet~หน้า}.
	
} {
	\vfill
	
	\noindent
	\begin{tabular}{lp{4cm}p{4.5cm}p{3cm}}
		& \\
        {ภาควิชา} & {\space \@ThaiDept\hfill}
		& {ลายมือชื่อนิสิต} & \dotuline{\hfill} \\
		{สาขาวิชา} & {\space \@ThaiFieldOfStudy\hfill}
		& {ลายมือชื่อ อ.ที่ปรึกษาหลัก} & \dotuline{\hfill} \\
		{ปีการศึกษา}& {\@ThaiAcademicYear \hfill}
		& \if@coadvisor {ลายมือชื่อ.ที่ปรึกษาร่วม} \fi
		& \if@coadvisor\dotuline{\hfill}\fi
	\end{tabular}
	\clearpage
}

\newenvironment{englishabstract}
{
	\clearpage
	\fontsize{11}{15}\selectfont
	\thispagestyle{headings}
	\addtocontents{toc}{\protect\contentsline{chapter}{\bfseries \@AbstractEnglishString}{\protect\relax\thepage}{}}
	\noindent
	\#\# \@AuthorID : MAJOR \uppercase{\@EnglishFieldOfStudyUP} \\
	KEYWORDS: \@Keywords
	
	\vspace{-\parskip}
	\hangindent = 1.0 cm \hangafter = 1
	\uppercase{\@EnglishAuthorUP} : \@EnglishTitle. ADVISOR : \uppercase{\@EnglishAdvisorShort},
	{\if@coadvisor \MakeUppercase{\@EnglishBookTitle} COADVISOR : \uppercase{\@EnglishCoAdvisorShort},\fi } \thelastsheet~pp.
	
}
{
	\vfill
	
	\noindent
	\begin{tabular}{lp{4.2cm}p{7cm}@{}}
	\hyphenation{engineering}
		& \\
		Department: & {\space \@EnglishDept\hfill} & Student's Signature \dotuline{\hfill} \\
		Field of Study: & {\space \@EnglishFieldOfStudy\hfill} & Advisor's Signature \dotuline{\hfill} \\
		Academic Year: & {\space \@EnglishAcademicYear\hfill} & \if@coadvisor Co-advisor's signature \dotfill \fi \\
	\end{tabular}
	\clearpage
}

%% Acknowledgement
\newenvironment{acknowledgements}
{
	\fontsize{11}{15}
	\addtocontents{toc}{\protect\contentsline{chapter}{\bfseries \@AcknowledgementsString}{\protect\relax\thepage}{}}
	\centerline{\bfseries\Large \@AcknowledgementsString}
	
	\noindent
	\hfill
	\hspace*{1.0cm}
}
{
	\clearpage
}

%% Appendix
\let\oldappendix\appendix
\renewcommand{\appendix}{%
	\clearpage
	%    \fontsize{11}{15}
	\addtocontents{toc}{\protect\contentsline{chapter}{\bfseries \appendixname}{\protect\relax\thepage}{}}
	
	\oldappendix%
	\if@thaithesis
	\renewcommand{\thechapter}{\@thaialph\c@chapter}
	\else
	\renewcommand{\thechapter}{\@Alph\c@chapter}
	\fi
	\setlength{\cftbeforechapterskip}{0pt plus 0pt}
}%
\renewcommand*{\cftappendixname}{\hspace{\cftsectionindent}\if@thaithesis{ภาคผนวก}\else{Apppendix}\fi \space}

\renewcommand{\appendixpage}{%
	\clearpage
	\addtocontents{toc}{\protect\contentsline{chapter}{\bfseries \appendixpagename}{\protect\relax\thepage}{}}
	\thispagestyle{empty}
	\centerline{~}
	\vfill
	\centerline{\bfseries\Large \appendixpagename}
	\vfill
	\centerline{~}
	\clearpage
}

%% Biography
\newenvironment{biography}{
	\clearpage
	%    \toccont
	\addtocontents{toc}{\protect\contentsline{chapter}{\bfseries \@BiographyString}{\protect\relax\thepage}{}}
	\centerline{\bfseries\Large \@BiographyString}
} {
	\clearpage
}

%% Chapter style %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\makechapterstyle{chula}{
	\clearforchapter
	%\insertchapterspace
	
	\renewcommand*{\chapterheadstart}{}
	
	\ifx\@chapapp\appendixname      % test if this chapter is an appendix
	\if@thaithesis
	\newcommand{\thechapternumber}{\thalph{chapter}}
	\else
	\newcommand{\thechapternumber}{\Alph{chapter}}
	\fi
	\else
	% normal chapter
	\if@thaithesis
	\newcommand{\thechapternumber}{\thechapter}
	\else
	\newcommand{\thechapternumber}{\Roman{chapter}}
	\fi
	\fi
	
	\renewcommand*{\chapnumfont}{\bfseries\Large}
	\renewcommand*{\printchaptername}{%%
		\centerline{\chapnumfont 
			{
				\@chapapp
				\space
				\thechapternumber
			}%
		}%
	}%
	
	\renewcommand*{\chapternamenum}{}%
	\renewcommand*{\printchapternum}{}%
	\renewcommand*{\printchapternonum}{}%
	
	\renewcommand*{\chaptitlefont}{\bfseries\Large}%
	\renewcommand*{\printchaptertitle}[1]{%%
		\centering %
		\chaptitlefont \MakeTextUppercase{##1}%
	}%
	\renewcommand*{\afterchaptertitle}{\par\nobreak}
	\indentafterchapter
}
\chapterstyle{chula}
\renewcommand{\beforechapskip}{0pt}

\copypagestyle{chapter}{plain}
\makeoddfoot{chapter}{}{}{}
\makeevenfoot{chapter}{}{}{}

%% End of Chapter style %%%%%%%%%%%%%%%%%%%%%%%%%%

%% Section style %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\setsecheadstyle{\Large\bfseries}
\setsubsecheadstyle{\large\bfseries}
\setsubsubsecheadstyle{\bfseries}
\RequirePackage{indentfirst}

%% Page numbering
\makeoddhead{headings}{}{}{\thepage}
\makeevenhead{headings}{\thepage}{}{}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% define styles
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Table of Contents
\renewcommand{\cftchapterdotsep}{\cftdotsep}
\renewcommand*{\aftertoctitle}{%
	\par\nobreak \mbox{}\hfill{\normalsize \pagename}\par\nobreak}
\renewcommand*{\afterlottitle}{%
	\par\nobreak {\normalsize \tablename}\mbox{}\hfill{\normalsize \pagename}\par\nobreak}
\renewcommand*{\afterloftitle}{%
	\par\nobreak {\normalsize \figurename}\mbox{}\hfill{\normalsize \pagename}\par\nobreak}
\renewcommand*{\insertchapterspace}{}

\newlength{\pageleft}       % for the remaining space of the page

\makepagestyle{runt}
\makeevenfoot{runt}{}{}{}
\makeoddfoot{runt}{}{}{}
\makeoddhead{runt}{}{}{\thepage\\\pagename}
\makeevenhead{runt}{\thepage}{}{\\\pagename}

\let\oldtableofcontents\tableofcontents
\renewcommand{\tableofcontents}{
	\clearpage\pagestyle{runt}
	\oldtableofcontents
	\clearpage\pagestyle{headings}
}

\let\oldlistoftables\listoftables
\renewcommand{\listoftables}{
	\clearpage\pagestyle{runt}
	\oldlistoftables
	\clearpage\pagestyle{headings}
}

\let\oldlistoffigures\listoffigures
\renewcommand{\listoffigures}{
	\clearpage\pagestyle{runt}
	\oldlistoffigures
	\clearpage\pagestyle{headings}
}

