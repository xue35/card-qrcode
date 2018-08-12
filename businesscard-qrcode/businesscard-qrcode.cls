\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{businesscard-qrcode}[2018/08/12 documented and finished in a first version]

\RequirePackage{kvoptions}
\SetupKeyvalOptions{
	family=BCQ,
	prefix=BCQ@
}
\DeclareStringOption[89mm]{paperwidth}
\DeclareStringOption[59mm]{paperheight}
\DeclareStringOption[85mm]{contentwidth}
\DeclareStringOption[55mm]{contentheight}
\DeclareStringOption[8pt]{fontsize}
\DeclareStringOption[2mm]{padding}
\DeclareStringOption[2]{cutdist}
\DeclareStringOption[1]{cutlen}
\DeclareStringOption[0.50]{textwidth}
\DeclareStringOption[0.40]{qrwidth}
\DeclareStringOption[de]{lang}
\DeclareBoolOption[true]{address}
\DeclareComplementaryOption{noaddress}{address}
\DeclareBoolOption[true]{hint}
\DeclareComplementaryOption{nohint}{hint}
\DeclareBoolOption[true]{icon}
\DeclareComplementaryOption{noicon}{icon}
\DeclareBoolOption[true]{rightalign}
\DeclareComplementaryOption{leftalign}{rightalign}
\DeclareBoolOption[true]{iconleft}
\DeclareComplementaryOption{iconright}{iconleft}
\DeclareBoolOption[true]{fill}
\DeclareComplementaryOption{nofill}{fill}
\DeclareBoolOption[true]{qrfirst}
\DeclareComplementaryOption{textfirst}{qrfirst}
\DeclareBoolOption[true]{https}
\DeclareComplementaryOption{www}{https}

\DeclareDefaultOption{\@unknownoptionerror}

\ProcessKeyvalOptions*
%\ProcessOptions\relax

\LoadClass[\BCQ@fontsize]{extarticle}

\def\content{paperwidth=\BCQ@contentwidth,paperheight=\BCQ@contentheight}
\def\papersize{width=\BCQ@paperwidth,height=\BCQ@paperheight}
\def\padding{\BCQ@padding} % padding around the content
\def\border{\BCQ@cutdist} % distance between start of cutmark and content in mm
\def\cutlen{\BCQ@cutlen} % length of ct marks in mm
\def\textpercents{\BCQ@textwidth} % size of text part 0..1
\def\imagepercents{\BCQ@qrwidth} % size of qrcode image part 0..1
\def\lang{\BCQ@lang}
\def\protdisplay{\ifBCQ@https https://\else www.\fi}
\def\protprefix{\ifBCQ@https https://\fi}
\ifBCQ@address\def\printaddress{}\fi

\newcommand\exec[1]{\csname #1\endcsname}
\newcommand\insa[3][]{\ifcsdef{#2}{

	\ifBCQ@iconleft
		\ifBCQ@icon\parbox{1em}{\centering\exec{#3}}\ \fi\ifBCQ@hint{\tiny#1}\fi\ifBCQ@fill\hfill\fi\exec{#2}
	\else
		\ifBCQ@hint{\tiny#1\ }\fi\exec{#2}\ifBCQ@fill\hfill\fi\ifBCQ@icon\ \parbox{1em}{\centering\exec{#3}}\fi
	\fi
}{}}
\newcommand\ifexists[2]{\ifcsdef{#1}{#2}{}}
\newcommand\ifboth[3]{\ifcsdef{#1}{\ifcsdef{#2}{#3}{}}{}}
\newcommand\ifany[3]{\ifcsdef{#1}{#3}{\ifcsdef{#2}{#3}{}}}
\newcommand\cond[1]{\ifcsdef{#1}{\exec{#1}}{}}

\newcommand\name{\ifexists{honoricprefix}{\honoricprefix\ }\ifexists{givennames}{\givennames\ }\ifexists{familynames}{\familynames}\ifexists{honoricsuffix}{\ \honoricsuffix}}

\newcommand\vcard{BEGIN:VCARD^^J
VERSION:4.0^^J
N:\cond{familynames};\cond{givennames};\cond{additionalnames};\cond{honoricprefix};\cond{honoricsuffix}^^J
FN:\name\ifexists{additionalnames}{\ifcsempty{name}{}{\ }\additionalnames}^^J
\ifexists{printaddress}{ADR\ifexists{type}{;TYPE=\type}:\cond{pobox};\cond{extaddr};\cond{street};\cond{city};\cond{region};\cond{zip};\cond{country}^^J}
\ifexists{phone}{TEL;VALUE=uri;TYPE=\ifexists{type}{\type,}voice,text:tel:\phone^^J}
\ifexists{email}{EMAIL\ifexists{type}{;TYPE=\type}:\email^^J}
\ifexists{jabber}{IMPP;TYPE=XMPP:\jabber^^J}
\ifexists{matrixorg}{IMPP;TYPE=MATRIX:\matrixorg^^J}
\ifexists{cloud}{URL:https://nextcloud.com/federation/\#\cloud^^J}
\ifexists{homepage}{URL:https://\homepage^^J}
\ifexists{wordpress}{URL:https://\wordpress^^J}
\ifexists{drupal}{URL:https://\drupal^^J}
\ifexists{joomla}{URL:https://\joomla^^J}
\ifexists{wikipedia}{URL:https://\lang.wikipedia.org/wiki/\wikipedia^^J}
\ifexists{link}{URL:https://\link^^J}
\ifexists{world}{URL:https://\world^^J}
\ifexists{git}{URL:https://\git^^J}
\ifexists{gitea}{URL:https://\gitea^^J}
\ifexists{github}{URL:https://github.com/\github^^J}
\ifexists{facebook}{URL:https://facebook.com/\facebook^^J}
\ifexists{twitter}{URL:https://twitter.com/\twitter^^J}
\ifexists{youtube}{URL:https://youtube.com/user/\youtube^^J}
\ifexists{google}{URL:https://plus.google.com/+\google^^J}
\ifexists{pgpurl}{KEY;MEDIATYPE=application/pgp-keys:\pgpurl^^J}
\ifexists{pgpfingerprint}{KEY:data:application/x-pgp-fingerprint,\pgpfingerprint^^J}
END:VCARD^^J}

\RequirePackage{marvosym}
\RequirePackage{fontawesome}

\newcommand\address{
	
	\cond{pobox}

	\cond{extaddr}
	
	\cond{street}
	
	\cond{zip} \cond{city}
	
	\cond{region} \cond{country}
	
}

\RequirePackage{pbox}
\RequirePackage{calc}
\newcommand\enforceright{\leftskip0pt plus 1fill\rightskip0pt}

\newcommand\data{
	\ifexists{printaddress}{
		\ifBCQ@iconleft
			\ifBCQ@icon\parbox[c]{1em}{\faMapMarker}\ \ifBCQ@fill\hfill\fi\fi
			\pbox[t]{\dimexpr\textwidth-2em\relax}{\ifBCQ@rightalign\enforceright\fi\address}
		\else
			\pbox[t]{\dimexpr\textwidth-2em\relax}{\ifBCQ@rightalign\enforceright\fi\address}
			\ifBCQ@icon\ifBCQ@fill\hfill\fi\ \parbox[c]{1em}{\faMapMarker}\fi
		\fi
		\vspace{1em}
	}
	
	\insa[tel:]{phone}{faMobile}\insa[mailto:]{email}{Email}\insa[xmpp]{jabber}{faCommentsO}\insa[matrix.org]{matrixorg}{faCommentsO}\insa[nextcloud-id]{cloud}{faCloud}\insa[\protdisplay]{homepage}{faHome}\insa[\protdisplay]{wordpress}{faWordpress}\insa[\protdisplay]{drupal}{faDrupal}\insa[\protdisplay]{joomla}{faJoomla}\insa[{\protprefix}\lang.wikipedia.org/wiki/]{wikipedia}{faWikipediaW}\insa[\protdisplay]{link}{faLink}\insa[\protdisplay]{world}{faGlobe}\insa[\protdisplay]{git}{faGit}\insa[\protdisplay]{gitea}{faGithubAlt}\insa[{\protprefix}github.com/]{github}{faGithub}\insa[{\protprefix}facebook.com/]{facebook}{faFacebook}\insa[{\protprefix}twitter.com/]{twitter}{faTwitter}\insa[{\protprefix}youtube.com/user/]{youtube}{faYoutube}\insa[{\protprefix}plus.google.com/+]{google}{faGooglePlus}
}

\pagestyle{empty}
\setlength{\parindent}{0pt}

\RequirePackage[final]{qrcode}
\RequirePackage{etoolbox}

\RequirePackage{DejaVuSans}
\renewcommand*\familydefault{\sfdefault}
\RequirePackage[T1]{fontenc}

\RequirePackage{wrapfig}

\RequirePackage[\content,top=\padding,left=\padding,right=\padding,bottom=\padding]{geometry}

\newcommand\insertqrcode{
	\qrcode[level=Q,version=0,height=\textwidth]{\vcard}
}

\newcommand\inserttext{
	\data
}

\newcommand\drawcard{
	\ifBCQ@rightalign\raggedleft\fi
	\newcommand\heightscale{\dimexpr\textheight-\ifcsempty{name}{0em}{2em}-\ifcsdef{pgpfingerprint}{2em}{0em}-\ifcsdef{additionalnames}{2em}{0em}\relax}
	{\bfseries
		
		\cond{name}
		
		\cond{additionalnames}
		
	}
	\noindent\makebox[\linewidth]{\rule{\paperwidth}{0.4pt}}
	\vfill
	\ifBCQ@qrfirst
		\begin{minipage}[c][\heightscale][c]{\imagepercents\textwidth}
			\insertqrcode
		\end{minipage}
		\hfill
		\begin{minipage}[c][\heightscale][c]{\textpercents\textwidth}
			\inserttext
		\end{minipage}
	\else
		\begin{minipage}[c][\heightscale][c]{\textpercents\textwidth}
			\inserttext
		\end{minipage}
		\hfill
		\begin{minipage}[c][\heightscale][c]{\imagepercents\textwidth}
			\insertqrcode
		\end{minipage}
	\fi
	\ifexists{pgpfingerprint}{
		\vfill
		\ifBCQ@iconleft
			\faLock\ifBCQ@hint{\tiny\ pgp}\fi\hfill{\small\pgpfingerprint}
		\else
			{\small\pgpfingerprint}\hfill\ifBCQ@hint{\tiny{pgp\ }}\fi\faLock
		\fi
	}
}

% crop marks
\RequirePackage[\papersize,noinfo,center,pdftex]{crop}
\newcommand\tl{
	\begin{picture}(0,0)
	\thinlines\unitlength1mm
	\put(-\border,0){\line(1,0){\cutlen}}
	\put(0,\border){\line(0,-1){\cutlen}}
	\end{picture}
}
\newcommand\tr{
	\begin{picture}(0,0)
	\thinlines\unitlength1mm
	\put(\border,0){\line(-1,0){\cutlen}}
	\put(0,\border){\line(0,-1){\cutlen}}
	\end{picture}
}
\newcommand\bl{
	\begin{picture}(0,0)
	\thinlines\unitlength1mm
	\put(-\border,0){\line(1,0){\cutlen}}
	\put(0,-\border){\line(0,1){\cutlen}}
	\end{picture}
}
\newcommand\br{
	\begin{picture}(0,0)
	\thinlines\unitlength1mm
	\put(\border,0){\line(-1,0){\cutlen}}
	\put(0,-\border){\line(0,1){\cutlen}}
	\end{picture}
}
\cropdef[]\tl\tr\bl\br{cut}
\crop[cut]
